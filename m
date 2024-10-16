Return-Path: <netdev+bounces-136029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1331599FFDD
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 06:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DD11C23BB2
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 04:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8E41537C8;
	Wed, 16 Oct 2024 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMXt/G2T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64679487A5;
	Wed, 16 Oct 2024 04:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729051374; cv=none; b=VpYNRYMwAHmNnfcqsVX4vv5KbefUT0ihKLdOARSU3i1GDztURNRhcyb9nHKaCPeImY+nOV1oDOc1lW3qjbCu0OcXE8AESCboaWeNlr1rDl40InLAUWkc1asNPhRcE9PvwoYJPIqQvWEjEOxUQj/A/3PoYtHWZyIWioFfl0ap0nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729051374; c=relaxed/simple;
	bh=DCfW+aMLbxAPA6ifhf1ThCxeG6r04GjhljO/+nKPQ5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlLPN/eqF4A3JZOaEY+jrM5fksHXKhkLpN0YzMOGVKkvJlGIK518V4O7CDfIB6VWTszJSemhPYl6FoxmSZtdNSOzV+3sWlTKyXhrDzUWSyIYJbTawz6HtS8+0CLZY+Vkr7RnnvFkJhQr/zRsKrfFtEzAYh/H+ekEmfKUydo+maA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMXt/G2T; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cdda5cfb6so30067745ad.3;
        Tue, 15 Oct 2024 21:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729051373; x=1729656173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntsHHgsKKirQ6ZAZrxHrp2nW0QPmelrzaOWFkgE7yAU=;
        b=LMXt/G2TEfs3zEM47/xTGFWpdKCZha1YuddMSGZflDY/EI1AYuZGqFocUQrtQJzcyM
         0riXWFjkaOVI4uvmdyb/AazeslRw5KbPHbng4b9taYzbFo4It+kOX7fhxyZGgBwQ/8gz
         sFS7UzAoFhI8vUG3yztS4yQAhySO0NkhEcB+b8L5eqd0q9Tv4a0FcPIXHdd/kym7GOwi
         UwtzaxvUlWt6YbzPxuvekxZfFI/qro/DXtFoiqMn16qRIVAcgg0aPr99t++Mp48gFIsp
         /Vb7445zTViQt0Mz1gEkl6Z09yh7jh0NHV9/6zx16A7GmF5ryc6jAEs/AirznaXFwvHa
         rXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729051373; x=1729656173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntsHHgsKKirQ6ZAZrxHrp2nW0QPmelrzaOWFkgE7yAU=;
        b=K/wGyxaSk6h2QqlqTcTBen7M6A+sqJlykAGVAzIeLNZTOTFudB5+N+M26cfhV//U4P
         wnCUafyXz3cRVtEDPrfB5nbEwRP6cxnkj5L4FSTOm07EkK2aR5zSazhU0JsEwqqyTHbv
         +vzLYnKHL2x/ZX81W+EcyjHH6WLH7p0mspDo3Z91TybUnKvVOsphGdnVN119bioAP5xP
         g3h3MRw0ewKeChzQLy88ndUi6XuHxUTCtwoAwtbXw9hLiZJ4RpTLc+rjO5wACygGeLyJ
         miRyiF0t+SRkYE7qrixoJmZeD+KJZnPnZc1zmzRyXA/3B2lOmsHjTJ9Cys4CRvW2dbG6
         yeVg==
X-Forwarded-Encrypted: i=1; AJvYcCVaEBBv29XUeLdrDS22J9B2QotaCoBnT3MQJIc/XbVeY8Z8Lbe/mJy+ImUetRhwD1oqyDq+e4I2e1NLeAs=@vger.kernel.org, AJvYcCVdNZlAkVrQkn8LDZbVg+Gg3/Al+yRG7UXHjyhpVS2ply6fAQkbiiklzzu/lGXKZReXVQavmA2t@vger.kernel.org
X-Gm-Message-State: AOJu0YzGuIiTBSOQLpUAykIkoM0Mu/ULAcjXLtvznzB381JSkEpnmS6m
	CLh/XC62yz1O6u3eKfH4io7vDYKiyQtzIClZUlzeEsjVAm9ZkJdi
X-Google-Smtp-Source: AGHT+IEE+gmw+5w0f4YcSUcAKGq5Xdyra0HmV91k0/Fsm+itmUFGK2zWKtURAkx6foMhV4Jj3f87uA==
X-Received: by 2002:a17:902:fc8f:b0:20b:5231:cd61 with SMTP id d9443c01a7336-20ca14732d9mr227299045ad.24.1729051372491;
        Tue, 15 Oct 2024 21:02:52 -0700 (PDT)
Received: from Fantasy-Ubuntu ([2001:56a:7eb6:f700:d7a1:e36a:e9c7:6c4b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f82c7csm20226785ad.16.2024.10.15.21.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 21:02:51 -0700 (PDT)
Date: Tue, 15 Oct 2024 22:02:49 -0600
From: Johnny Park <pjohnny0508@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] igb: Fix styling in enable/disable SR-IOV
Message-ID: <Zw866aMO9sfBXRsm@Fantasy-Ubuntu>
References: <Zw2mTeDYEkWnh36A@Fantasy-Ubuntu>
 <20241015174607.6c29bb8d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015174607.6c29bb8d@kernel.org>

On Tue, Oct 15, 2024 at 05:46:07PM -0700, Jakub Kicinski wrote:
> On Mon, 14 Oct 2024 17:16:29 -0600 Johnny Park wrote:
> > This patch fixes the checks and warnings for igb_enable_sriov and
> > igb_disable_sriov function reported by checkpatch.pl
> 
> Quoting documentation:
> 
>   Clean-up patches
>   ~~~~~~~~~~~~~~~~
>   
>   Netdev discourages patches which perform simple clean-ups, which are not in
>   the context of other work. For example:
>   
>   * Addressing ``checkpatch.pl`` warnings
>   * Addressing :ref:`Local variable ordering<rcs>` issues
>   * Conversions to device-managed APIs (``devm_`` helpers)
>   
>   This is because it is felt that the churn that such changes produce comes
>   at a greater cost than the value of such clean-ups.
>   
>   Conversely, spelling and grammar fixes are not discouraged.
>   
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
I see. Apologies for the inconvenience, I'm new to this area so I must have missed that portion of documentation.

