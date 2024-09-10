Return-Path: <netdev+bounces-126800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 861889728EC
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 07:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CED31F24EEB
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 05:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AC116DEAB;
	Tue, 10 Sep 2024 05:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4Uhl7X3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEAB167265
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 05:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725946649; cv=none; b=rc8G1HdpKZmYPpSS25jOStnuCfn9teVYvJDTnYjz+eAufmNWU9c083HCSjw6amblyO/JtQhRBaI6B4k3KG0SnZxb5QHvX2T9IkERqOL3dU6WPzgx7jQ3zQddiFcWbWu8o7Aaa80Sx1/XB/ysVuFNqR39FC6BxSJ6ZCt+k4oSU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725946649; c=relaxed/simple;
	bh=EwUDL3+iHQReQO7jq/ozcs0XJgYNxwnErRCdGouFpWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4R8+CXkbe6y3vlCQjNPEVBYxNpB5pi/jixDriIObheS5wqDYcQ+66lu7Aac3KB54+W7N0nqA6NQqLD7Diu/4sFUvTKPKyiGiE66VmnjQIr7UJdfmgTeT9ufsKFEnS6I+EuJsbS0B5HJuKA89PF89JF1V0yA6nhpQKXAJh5YhaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L4Uhl7X3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb2191107so17212035e9.1
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 22:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725946646; x=1726551446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt7Mj3BWGNLUk60mWJOJFe3CkhoFp+8BmiqAzcG1VNQ=;
        b=L4Uhl7X333OEM+r9rXAcDZuiQDToNIiwt3Ij6m/LU7z4L3g+TQiuoQVE2jlOr6bqp1
         RjD15voGmvpKDD5qNhe0SRjq0i/HMPMmjS77TFiX4zQF3IGprM1klbO4jmS4ZrphggXF
         YwmZyVIPTLXcetHx++ai7dGc7kdkrLAZkr2m27auOnwwHEdP1D5ktL/XECRovW5jai4A
         s7aMR5zGVSN3+1v4fx9x1RFh5E2TKIf3nMgc8OLFSXinnb/B+JrdJbDSzk5AWktVSiYL
         zc0TcC8fN6cnJkJidRqCuZulTeP2AEM5g3cvj+KcvYAroDfNZCLCVYNFudWlzfI3nhXf
         smeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725946646; x=1726551446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tt7Mj3BWGNLUk60mWJOJFe3CkhoFp+8BmiqAzcG1VNQ=;
        b=gdApQTXotSVp5fygAlSTstw/H+aWHITsO1ABkMmk67gGgHuuufnilgnODBmSMkBB7A
         5Kxh23+ZuCU7K7KGEzdewx7ikRDTfJ3D3gJ9LLZ0dsLfo9LV0JBYcIbxyJi/Nva4Yd0H
         Fp81z1Od/c1Ir1xJUPu2rEpZsx4b1oRqzASq330O5eZLa2LCJnmy977oxgZzCfi/Dm8A
         lh1GVIH1IRKGkrBHVlO2kIdEK2+BWTNsmDV/YH09lAupM9xmT1RtesDZxH1gzktAFXQA
         rJtbjmmUHkg4reDKVzhSlAH0YND1FylAzUtYpmMK/X7wjfXXpXaHsZxFpp6iSuSKivib
         3BNw==
X-Forwarded-Encrypted: i=1; AJvYcCVO09Zt1lLeP4vWu0x73G7DGY4evhgfTAlXRJkRS51kI123pkNfQjJN63DJYLTeYexeoZVn2cY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztHv4Jcd6V8WgIqGqDCq3hg6la5RyM93T8pDvsfO678RBCdlyJ
	reLYkM6h3pvbW6vFrlAYS9Yt8CyFSfZofWa4Q2GdBeaQhWSIMSIUavye4hjscLY=
X-Google-Smtp-Source: AGHT+IHjXYlPMT3piNONEka+qQsLN94g/qh6HhRrUNihwyrYbhVZJ1z/lDjlPuuWUanPSJk6AoHIiA==
X-Received: by 2002:adf:a186:0:b0:371:8cc1:2028 with SMTP id ffacd0b85a97d-3789268edeamr5657243f8f.14.1725946645724;
        Mon, 09 Sep 2024 22:37:25 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb2ca95a6sm78765485e9.21.2024.09.09.22.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:37:25 -0700 (PDT)
Date: Tue, 10 Sep 2024 08:37:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5l?= =?utf-8?Q?xt=5D_net?=
 =?utf-8?Q?=3A?= ftgmac100: Fix potential NULL dereference in error handling
Message-ID: <a2dba28a-6ac4-4770-b618-acfdd59cbbf4@stanley.mountain>
References: <3f196da5-2c1a-4f94-9ced-35d302c1a2b9@stanley.mountain>
 <SEYPR06MB51342F3EC5D457CC512937259D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <6c60860b-dd3c-4d1c-945b-edb8ef6a8618@lunn.ch>
 <SEYPR06MB513433B0DBD9E8008F094CE39D992@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <6261c529-0a15-4395-a8e9-3840ae4dddd6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6261c529-0a15-4395-a8e9-3840ae4dddd6@lunn.ch>

On Mon, Sep 09, 2024 at 02:03:32PM +0200, Andrew Lunn wrote:
> > > Are you actually saying:
> > > 
> > >         if (netdev->phydev) {
> > >                 /* If we have a PHY, start polling */
> > >                 phy_start(netdev->phydev);
> > >         }
> > > 
> > > is wrong, it is guaranteed there is always a phydev?
> > > 
> > This patch is focus on error handling when using NC-SI at open stage.
> > 
> >          if (netdev->phydev) {
> >                  /* If we have a PHY, start polling */
> >                  phy_start(netdev->phydev);
> >          }
> > 
> > This code is used to check the other cases.
> > Perhaps, phy-handle or fixed-link property are not added in DTS.
> 
> I'm guessing, but i think the static analysers see this condition, and
> deducing that phydev might be a NULL. Hence when phy_stop() is called,
> it needs the check.
> 
> You say the static analyser is wrong, probably because it cannot check
> the bigger context. It can be NULL for phy_start() but not for
> phy_stop(). Maybe you can give it some more hints?
> 
> Dan, is this Smatch? Is it possible to dump the paths through the code
> where it thinks it might be NULL?

Adding a check here is the correct thing.  The current code works because we
only have the one goto after the call to phy_start(netdev->phydev), but as
soon as we add a second goto then it will crash.

Silencing this warning means tying the information from probe() into it.  It's
a fun problem but not something I'm going to do this year.

regards,
dan carpenter

