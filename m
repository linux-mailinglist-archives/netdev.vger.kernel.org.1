Return-Path: <netdev+bounces-163267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF744A29BE3
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 22:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C079E169137
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACDD14F9FD;
	Wed,  5 Feb 2025 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYo29rfD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25171519AD
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791104; cv=none; b=NciKgmRLm5rrVox2ceHVaZPzWrgf3TTXVN1PLVktBds0/eZwVr9u62ePfR6gLrUAmFhB5GujHkwuXeP/QoavJsrD267gJR5FRNPbkmUNkWTaZaCfLkg0frnVoSMWsgKeBcuR2vjvmHDIYKTwVVQ8mkx0fRxuhYXJom57jZPtZoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791104; c=relaxed/simple;
	bh=BQTJ0tsZJr+UdARG8ZHB44WS1DWpTikhoJL/IkDFU7g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5GGUhbrq+eyCsRyFdy0fsOB8G3/5ERcVs6H5EYgSDLLIe5eYT6cjnMuvA+Xjf06U6ObiIS/BE2PNMvfIZGd9r3+WnRwIB3GMEMYt44zPlBYy2sex7ixMdMLikdTYfWYrJgFeo6drcmhhVmrwN/15OuQpFrsm3lp54HsmGTvt7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYo29rfD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f05693a27so3867015ad.2
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 13:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738791102; x=1739395902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1u+FoVmiH3HlH3e3ZhLv5dqfpqnEYp17kc4FXVCfE0=;
        b=SYo29rfDod0hWeImlh3y0IqgKwuD/lMfcW7Ao/mq/kclnk+Qwy1yrQzw562Q4R4J92
         AhraPRcMxer+8vhFzF+AIxDyhHEi+qSP1AagYI5513FKA0fgScszW8jJRx3vDAQnxGOd
         FGlf8nCbAFmiadgzZZQHQJlruyjgwZBO87Ywwg51cxh7da5yUXRxEC1ysbp/IitQlhBj
         3vjHN75t3zpdKb33tfNxIoHVHmHGNub22PhEipcpuZg8JhCynKs77Ifef/AA8sVMyGKw
         OD+DvqZMdZT+HhMf16UJawQj6IgsyxGOslSbiYZyPWgRNsd07VE21qQ98izG4ocHITIp
         UrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738791102; x=1739395902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1u+FoVmiH3HlH3e3ZhLv5dqfpqnEYp17kc4FXVCfE0=;
        b=XiEYtD21A9Trr8bz9H3eaF9k9ekAKJ7rK8u8vaDl/Yz+gypDJwCbKTT2pM4HuBvjHm
         fahUIk2d4B6tvHWooWGhXfgdBbkXG7Q2ON85EQKmzs1nl5Qmqwk9cFwAYeMckY6uu485
         rpq0VCrsA1X/vLGCFCVelBRdKGt7eSgobrJi3/CmOX7DLOEv/tuhAWJVeOgt1tla0V5f
         TpC7fsiDFcYIfffezcJVDEHOn4hjmGELLiz94bKkeFqE20Wi7eRv1ZxK1Afk2483wEuM
         GDH2zpLEnMGG837HI2YU9qUKxRaFHbzHrTBgyOre833Oj4jeDoiI+aK7pGLbEZvuyBJb
         Mjbg==
X-Forwarded-Encrypted: i=1; AJvYcCXGwh6GT14H8JCTSJPN3/zC2dgc4TTWRIav5k85KwRSZFZ85BxU1j7XIJW8IfI3CCPZJ0K006E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTAGozZJtgb/FTNbbSPrTbaEEFGewGJOyIzsQJOiE7eQYZFJgm
	d5zcW4chY1Z6s9wlGjm/+ggjXhKB1A75yLpBXVQ9WhGQUDpAqOQ=
X-Gm-Gg: ASbGncsxalBUWhCQ9Vrwo8/l7TKNQhG28r+7xnG24XiVJVw0pZR83wy3kUzbAbm0twI
	YVJHnmGdrHipY4YL91kyIlrHYbNBYfLRhKtn16Q1oZmUs/6Al21SC05Zgib+RJLqrFyeZTYgsj/
	fZdHawgdG2jiHzkVU4CQ9w4WphCyrDDM9lJ1t4WdBBPklapl4ZDVLgZPnXbt/N+9duJbXMBWq2+
	M/3ygmJm8dpXv8Vuvl7rsDw8eIxCAzm0m8iGrnEOCmnV9m95wScgvvc3fghjmsD05viLwkNwVIF
	8EK2qCy/XhSwfC8=
X-Google-Smtp-Source: AGHT+IEU/sfluQ5BJMhZh9OWN58YIHtydVJCcwcmHvqaUPCTF0SFm13GOnM8D12CzVbvaRQfJN5y/A==
X-Received: by 2002:aa7:930d:0:b0:725:b347:c3cc with SMTP id d2e1a72fcca58-7303521f9camr7672483b3a.23.1738791101731;
        Wed, 05 Feb 2025 13:31:41 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe69ba4a0sm13444953b3a.102.2025.02.05.13.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:31:41 -0800 (PST)
Date: Wed, 5 Feb 2025 13:31:40 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [RFC net-next 1/4] net: Hold netdev instance lock during
 ndo_open/ndo_stop
Message-ID: <Z6PYvNeBE2_dpRDG@mini-arch>
References: <20250204230057.1270362-1-sdf@fomichev.me>
 <20250204230057.1270362-2-sdf@fomichev.me>
 <Z6O8ujq-gYVG4sjw@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6O8ujq-gYVG4sjw@LQ3V64L9R2>

On 02/05, Joe Damato wrote:
> On Tue, Feb 04, 2025 at 03:00:54PM -0800, Stanislav Fomichev wrote:
> > For the drivers that use shaper API, switch to the mode where
> > core stack holds the netdev lock. This affects two drivers:
> > 
> > * iavf - already grabs netdev lock in ndo_open/ndo_stop, so mostly
> >          remove these
> > * netdevsim - switch to _locked APIs to avoid deadlock
> > 
> > Cc: Saeed Mahameed <saeed@kernel.org>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  Documentation/networking/netdevices.rst     |  6 ++++--
> >  drivers/net/ethernet/intel/iavf/iavf_main.c | 14 ++++++-------
> >  drivers/net/netdevsim/netdev.c              | 14 ++++++++-----
> >  include/linux/netdevice.h                   | 23 +++++++++++++++++++++
> >  net/core/dev.c                              | 12 +++++++++++
> >  net/core/dev.h                              |  6 ++++--
> >  6 files changed, 58 insertions(+), 17 deletions(-)
> 
> [...]
> 
> > @@ -4474,12 +4471,12 @@ static int iavf_close(struct net_device *netdev)
> >  	u64 aq_to_restore;
> >  	int status;
> >  
> > -	netdev_lock(netdev);
> > +	netdev_assert_locked(netdev);
> > +
> >  	mutex_lock(&adapter->crit_lock);
> >  
> >  	if (adapter->state <= __IAVF_DOWN_PENDING) {
> >  		mutex_unlock(&adapter->crit_lock);
> > -		netdev_unlock(netdev);
> >  		return 0;
> >  	}
> >  
> > @@ -4532,6 +4529,7 @@ static int iavf_close(struct net_device *netdev)
> >  	if (!status)
> >  		netdev_warn(netdev, "Device resources not yet released\n");
> >  
> > +	netdev_lock(netdev);
> 
> I'm probably just misreading the rest of the patch, but I was just
> wondering: is this netdev_lock call here intentional? I am asking
> because I thought the lock was taken in ndo_stop before this is
> called?

Yes, this part is a bit confusing. Existing iavf_close looks like
this:

iavf_close() {
  netdev_lock()
  .. 
  netdev_unlock()
  wait_event_timeout(down_waitqueue)
}

I change it to the following:

netdev_lock()
iavf_close() {
  .. 
  netdev_unlock()
  wait_event_timeout(down_waitqueue)
  netdev_lock()
}
netdev_unlock()

And the diff is confusing because I reuse existing netdev_lock call,
so it looks like I only add netdev_unlock...

I don't think I can hold instance lock during wait_event_timeout because
the wake_up(down_waitqueue) callers grab netdev instance lock as well.

