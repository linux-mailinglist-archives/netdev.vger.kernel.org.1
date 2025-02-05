Return-Path: <netdev+bounces-163281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBA7A29CB5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17734168030
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 22:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A604214A90;
	Wed,  5 Feb 2025 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KfKZWdSF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F51192D83
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794753; cv=none; b=hnWkZolef4RU/5uvuaqhSIFdk28wm4V/MdSag9BFwhp6xOx29rTYDcADR1kvFsQINGbrRl+KH0AbYWLapqSFILC5zo4zdRPogCEdfJROpXc7FmK1vHPClUxD4BL2Wh1uLcr45/ThctXX6Xkm63mG42syGDhaQTf78USmjfW08YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794753; c=relaxed/simple;
	bh=rbtMWEoMMwxGw5KknDbNrT0/x7uWZL7UO8f3pMBT8Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9LEyuOkxWAKR8uoMrS3fWFmXoWBmW+wLhPx+SdObzkW5XXwK+jSlztcwPtMkzyvvGfrSYBo5NwjOGmV0nSO1KwIP2D++wCd7CmFn9Y+DfG0YuL9yTlVm+tulM3qp0REbLGNcYlRi/quAEUVQZnWy56d4lFPx+0AGX4NL3I2/r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KfKZWdSF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f1d4111d4so4945245ad.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 14:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738794751; x=1739399551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pswc9S70dFQyhH7NgxiZZFTh6vio2P5SVb8GGRDtltc=;
        b=KfKZWdSF+hLZn4KZsQOwEQMKZO6/w1Kc2vwRTJ8Uma+fAla99ArkK6pbVvYcd5xGf1
         wyPxx1R+jslD5QqY4ssDNEpGhPp61F/kDggc624T53G0xZ4VE1QvZxWRA/hKoz/vzecK
         YsGCczLt8oPDh8rjTxUKTaPJbQzTUfvyXu6Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738794751; x=1739399551;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pswc9S70dFQyhH7NgxiZZFTh6vio2P5SVb8GGRDtltc=;
        b=fdxcXVfN7g1WxaKpwsvK1UVpEt6nnfMkV6C1XUFp5a+f1TJO2bMw76vwUvJicp7HWJ
         1Glkt5kOQPG6IReb8/1JWgNTKZJFDcqFAyYFlzhqlNQ7ezx971Osd/FoNCtLAorzd/K/
         bnhBp7/pm6beIVfwNJXRzxmJwPyrviq7RQ4a57/UqMP5sKbD5dzpMWSjnNM9taq2K1XO
         gyKIyZAGjQzsL+HfCbQNGsgMI9zxFfX+/zt2eN1n7K9uemdZ9PZB+JtXYntK/zj6VTQd
         7qip1XArnea25gncqfEDctsy2Hftvbh6/5RUz2uINYbCRXcybqzvXjNH7btszcpJSJnO
         a3ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsmlhGTYL84Z0yVEl9QWMVxor2dQ63ZQeegJqfjDPnD/9R7KuTnh84Op9xYfx2J9lgC5IK0e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPWf6e+y4kUpclQH4/bGLZGEDkpp0OZ7WGULuR/5R9DMMSGSI7
	cReCpBY68VM61SInmzvGS5ytr3e3Uft/mAVG5ONIudHgvrDT5CcnaYvcnrVwtAI=
X-Gm-Gg: ASbGncvpbNTxCcG3hRY4shhahV0sUWzslc0O/NV/5H+kRtquAa84DHkZAlmH9BszVoL
	LkfWkOxUg9qYERutwSkcy8dY4NJrisWynA/Tr0Z2IKsyTSsscVKnvV4AgYcnTwFISjgSj3a71xX
	qxrba5ZNku16xHhUfhkrEdJCjzKSNIEOuM62W6t0aSa97vaspCIlD+vaDjzaOpDWZqbvANWD2/f
	0RlTXY2hTBVZkJrxDHSxi5L86Xvw/8/h5gCbE1cG0QECeRLd8DoGUgWVqmfqHN9WLtiQ0g53w91
	tCbdYmcf6U6NYW1zZMcNIAVfQVQhVtSrXASlA5/JEB/sfUNSVP2UmwR3qA==
X-Google-Smtp-Source: AGHT+IG68U/Jf2uyCGOpSi/tnO/+6CQBIeEe5BbeOi6exCet3cF9p89ekuIWyFRAaQi6Fb2o8o5LeQ==
X-Received: by 2002:a05:6a00:e13:b0:725:e37d:cd36 with SMTP id d2e1a72fcca58-730350e4f2amr7229142b3a.2.1738794750889;
        Wed, 05 Feb 2025 14:32:30 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631bebdsm13081005b3a.29.2025.02.05.14.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 14:32:30 -0800 (PST)
Date: Wed, 5 Feb 2025 14:32:28 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [RFC net-next 1/4] net: Hold netdev instance lock during
 ndo_open/ndo_stop
Message-ID: <Z6Pm_AaXEwVFzHyI@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
References: <20250204230057.1270362-1-sdf@fomichev.me>
 <20250204230057.1270362-2-sdf@fomichev.me>
 <Z6O8ujq-gYVG4sjw@LQ3V64L9R2>
 <Z6PYvNeBE2_dpRDG@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6PYvNeBE2_dpRDG@mini-arch>

On Wed, Feb 05, 2025 at 01:31:40PM -0800, Stanislav Fomichev wrote:
> On 02/05, Joe Damato wrote:
> > On Tue, Feb 04, 2025 at 03:00:54PM -0800, Stanislav Fomichev wrote:
> > > For the drivers that use shaper API, switch to the mode where
> > > core stack holds the netdev lock. This affects two drivers:
> > > 
> > > * iavf - already grabs netdev lock in ndo_open/ndo_stop, so mostly
> > >          remove these
> > > * netdevsim - switch to _locked APIs to avoid deadlock
> > > 
> > > Cc: Saeed Mahameed <saeed@kernel.org>
> > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > > ---
> > >  Documentation/networking/netdevices.rst     |  6 ++++--
> > >  drivers/net/ethernet/intel/iavf/iavf_main.c | 14 ++++++-------
> > >  drivers/net/netdevsim/netdev.c              | 14 ++++++++-----
> > >  include/linux/netdevice.h                   | 23 +++++++++++++++++++++
> > >  net/core/dev.c                              | 12 +++++++++++
> > >  net/core/dev.h                              |  6 ++++--
> > >  6 files changed, 58 insertions(+), 17 deletions(-)
> > 
> > [...]
> > 
> > > @@ -4474,12 +4471,12 @@ static int iavf_close(struct net_device *netdev)
> > >  	u64 aq_to_restore;
> > >  	int status;
> > >  
> > > -	netdev_lock(netdev);
> > > +	netdev_assert_locked(netdev);
> > > +
> > >  	mutex_lock(&adapter->crit_lock);
> > >  
> > >  	if (adapter->state <= __IAVF_DOWN_PENDING) {
> > >  		mutex_unlock(&adapter->crit_lock);
> > > -		netdev_unlock(netdev);
> > >  		return 0;
> > >  	}
> > >  
> > > @@ -4532,6 +4529,7 @@ static int iavf_close(struct net_device *netdev)
> > >  	if (!status)
> > >  		netdev_warn(netdev, "Device resources not yet released\n");
> > >  
> > > +	netdev_lock(netdev);
> > 
> > I'm probably just misreading the rest of the patch, but I was just
> > wondering: is this netdev_lock call here intentional? I am asking
> > because I thought the lock was taken in ndo_stop before this is
> > called?
> 
> Yes, this part is a bit confusing. Existing iavf_close looks like
> this:
> 
> iavf_close() {
>   netdev_lock()
>   .. 
>   netdev_unlock()
>   wait_event_timeout(down_waitqueue)
> }
> 
> I change it to the following:
> 
> netdev_lock()
> iavf_close() {
>   .. 
>   netdev_unlock()
>   wait_event_timeout(down_waitqueue)
>   netdev_lock()
> }
> netdev_unlock()
> 
> And the diff is confusing because I reuse existing netdev_lock call,
> so it looks like I only add netdev_unlock...

Ah, I see. Thanks for explaining that; I looked at it a second time
more closely and I see that you are correct and I did miss the
existing netdev_lock call.

> I don't think I can hold instance lock during wait_event_timeout because
> the wake_up(down_waitqueue) callers grab netdev instance lock as well.

Agreed.

