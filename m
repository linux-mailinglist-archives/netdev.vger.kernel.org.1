Return-Path: <netdev+bounces-157902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA07CA0C448
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C72166FE5
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 21:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882731EE021;
	Mon, 13 Jan 2025 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="XUpoBOLA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A523232
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805532; cv=none; b=ujNoV51QHlopvKR+dsfhI9B2L9E/6tW6gh46eGk1RLVI8MRWP8r9s9EfxsUzRyQHKgmhKjF4N7jTopJegYPSlMyLEJnl+VXZvs/C3/yfC4v5bo3nbW6ywqiNAFoj3P8P3kvRYixtf+cwrEQMnfbAr/fwUW88GXrKyZOEZPJMPmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805532; c=relaxed/simple;
	bh=YT7tw+yLpBD8mm51eiJecrgQMxOp6GEumiwHGuJ2WQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crS8Rwc1bYAp23G9SocO22wL3YrVa0Q6C30THR2kaHDxuit2KoHQbtzWkyB/C6UhE6UTXp/a8hizmuqwYwCaLOvgIa+xLJny6uLma7eSv9z3NxZxX50JhnGJ8ts3Vs6jM/WYP7nxtCMHBvBcSeakhv593OUGwMxDJZCyxlTkTnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=XUpoBOLA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166360285dso83870835ad.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 13:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736805530; x=1737410330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1twCwD/6lZcYLaRpkR8mPmSDuI0NT9StKcevPHbSPFc=;
        b=XUpoBOLA6q3sVNocyS1ezcEP4+cYOSFFHLw9oKdPVyWy1/HctPThMR/j7OFVBrWNHR
         ZSFrix29dXq5QpxsYClaGk6ZUdfGrq716hNHXeFay+CSUPFUHgw+vJdg0x4xcifiCgFv
         zKDVZRs8y0YmVo2z+4Q6sT1Dgz/KagOo5qeAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736805530; x=1737410330;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1twCwD/6lZcYLaRpkR8mPmSDuI0NT9StKcevPHbSPFc=;
        b=Qowwj/D96w6eaVo7+Ahjko85cuHCSWUzWZGZnRdzy14jqYHw2GzF7/+TjD+3zRN0YE
         Yf9yyX2fn1J6EIj1/8ovnUelP2ZfkpkkufODEqvDmBt4WsJzGrP5BUfr+15mjcllpxY5
         WCDSaVFPweOCt5+MP5tEOCnSmZski6MJDraqnICKNTgB0KQ4Bpu3tHRjSg6wOHUckqkM
         hyxKPBGNCd/11WvzlUq7X2BuYdWJama36LegzIninyWUMy0spSMOxKyTUfIUGH9laD1C
         +QQ6ITFi1c546zEtPlnWFxn6oYa1R4idAjjcyBCIgZ0cgiaZU4JQ5caamd2h8eRPUu6U
         ra1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZVL/6yVGGScDiokxpLRURL9Kn/MnG2rw0DhyXf0d8GCY/4f4fnmJhWmjcMnPtayX17qepH4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqgAnTSXRsI/rvQ/z7eacJ7lFpoE6274n3byIHK0px+tdsWgt1
	2bwJ3zT5OQKVQtqzlWWi24O+6qD4yaqX5NBjxlJ0rqJJPrd7WyOk+2GEDcqCam8=
X-Gm-Gg: ASbGncuFIGvGo6lwygI7Gg8oNynJY1JtrRVoQVaSLCug/nyrq5PSa9xhpHS1/yhw7+v
	lJ9f94Fsbo2+Qsq2FaTcyMyCsan0WEq1kfnSXs5ozF9qOHyuNv18Evj+b1i3NtAKGXUqdbVAdNv
	930HldeCl5qf9pOYLT/r1qgl9pU2RCIcwPkLrltpjk4WgjXNLo5MIr+Se/WGNvdoPPdhwMYfoJC
	u6u5/llzf6jolFY8cvUNtmunSsW4xksG4LSlhsstYgWE11DwEe5qZuDwI2JDd183Zw7bx/lD2FN
	srh9xOjCC/4eJjg9POQqQKU=
X-Google-Smtp-Source: AGHT+IEy4a+fqtFSueZzVtc2SRzJuoPJNIUP7MY1bj0DO6uOAeEg/SwVA9O4cbddmsDMAe+fWeCj2g==
X-Received: by 2002:a17:903:244a:b0:211:fcad:d6ea with SMTP id d9443c01a7336-21a83fcf7a9mr342201385ad.45.1736805530337;
        Mon, 13 Jan 2025 13:58:50 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22ecf2sm58329325ad.192.2025.01.13.13.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:58:49 -0800 (PST)
Date: Mon, 13 Jan 2025 13:58:47 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v2 1/2] net: remove init_dummy_netdev()
Message-ID: <Z4WMl6PvgRFRQEMm@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, matttbe@kernel.org,
	martineau@kernel.org, geliang@kernel.org,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	mptcp@lists.linux.dev
References: <20250113003456.3904110-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113003456.3904110-1-kuba@kernel.org>

On Sun, Jan 12, 2025 at 04:34:55PM -0800, Jakub Kicinski wrote:
> init_dummy_netdev() can initialize statically declared or embedded
> net_devices. Such netdevs did not come from alloc_netdev_mqs().
> After recent work by Breno, there are the only two cases where
> we have do that.
> 
> Switch those cases to alloc_netdev_mqs() and delete init_dummy_netdev().
> Dealing with static netdevs is not worth the maintenance burden.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2: change of plan, delete init_dummy_netdev() completely
> v1: https://lore.kernel.org/20250111065955.3698801-1-kuba@kernel.org
> ---
> CC: matttbe@kernel.org
> CC: martineau@kernel.org
> CC: geliang@kernel.org
> CC: steffen.klassert@secunet.com
> CC: herbert@gondor.apana.org.au
> CC: mptcp@lists.linux.dev
> ---
>  include/linux/netdevice.h |  1 -
>  net/core/dev.c            | 22 ----------------------
>  net/mptcp/protocol.c      |  8 +++++---
>  net/xfrm/xfrm_input.c     |  9 ++++++---
>  4 files changed, 11 insertions(+), 29 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

