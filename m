Return-Path: <netdev+bounces-221486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8D1B509F1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 02:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614353B778B
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 00:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A2D19F11E;
	Wed, 10 Sep 2025 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="PAZaoO8F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BD319D8AC
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757464812; cv=none; b=mK7QhrriH2CPHShe/Nf1ZE8+IpAd5nAQVQzBmbz3eGll1Joi6k6LFE0qCmf7/Kve/SscKdX5at9HKWb+pX6JXvWfP3/563DZRUW+sArM7tgDMLO9vr5gOg7GEK3lFotywKAjZaqJ5muuq9f7CMZGC1jJ5o4szSmqUsUyrYno4/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757464812; c=relaxed/simple;
	bh=7Cb5u7jncLcFhLiVnCTY8Y1qEYzK9rvuSJcpTxKvSS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfwtSUBcHay3LXbEAcflwyCKQVa9nWzbBf/pusDNbeq1i16OJd3DlrGUAO73PYVMdDft/+OgHmmBw/hzSPgpiWaDI8Gav3sz9m+fYXLufaeW/oumGv5n/1R4k0nKArRvC9kmzkCeRwyYF5m6GrETYMfcV+neeVPJ/2NKpIageeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=PAZaoO8F; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77246079bc9so7350326b3a.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 17:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1757464810; x=1758069610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mss6uQGd55J5igKePLGZ8MRE87EtXTRkrLicTbCnVC4=;
        b=PAZaoO8FupiaKyCAO3ep6QLCS18VoZoPvPU4IDivyLi5JRj9EpIuCMS5oqA5+eonqm
         KziMxJHUdNK/1HWzcnC/I9pEnijpkOa1iYPhfZdTjppte+BYNeN3n5i3xLOwNcPCXGJ4
         FBJyeeKZzblSHiMZSjbZzn8nHVwFFVRE0O/93d0jOhCPD/UsnaEP8Wekyg8EfDPIBzht
         JzLifi2EVWvm228Dnp0A57Ad08oFm6/q76Y5ALef+VhqVRz7SFt1CrCMR6bu7RWfiTzz
         xc7jeEgV/DcffCX36LbTfd7HiPBpPcBWHlmauFZj0dLky9LUEnaYC3OFWBrX6+bbx7nS
         G8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757464810; x=1758069610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mss6uQGd55J5igKePLGZ8MRE87EtXTRkrLicTbCnVC4=;
        b=GKgayTvmd7rc3zs8oLk9ZHxSBZrUAowkir2cskHF/QAaCPXZMTRyMYNvrKkTol8HB2
         sq9HRq2xdomKZOgR579tKvCMPwu6xSwypIQtWnJyqanfnqHS3nRljjYj1iSWPLQdOwaU
         BFb5iyokqmqYoLCaiEfLBSQ6LcGILmr/jM1L/GffywVrfD03etR2gyB1EJpvMYtSB2Ot
         sCjVi8Rljn82za0QLjBHM/OY7GbFPjBMnzXIz9QZl4GCHtSCFdIgZc45OuGUfGegCckY
         l0Fv3r+pd+9jLgetDOIsbwyowryeZQ54flfaY4dwsAF+hZoh7+1pX5Fdg53PKPbBiJjP
         TT5g==
X-Forwarded-Encrypted: i=1; AJvYcCXoxqRrBeQi516OgTCcU5SEaUUOwBx1p28Xbnhn6AnfPnnAFPiAvP+bXGkZd6IaIeYOrL4MHGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLKg5kcM1/0qXyLo/ljmQX5kE5Kr+EYblHWh9eth3+YgiiTN6l
	Ka15YdkgNNjVkRy0UxMz9LvfuNkzt53ctODJQy0Fd6H4yppYTRSbXzOG7X/wGmJtels=
X-Gm-Gg: ASbGncunwvZqKgP0KEdYd2QtAUPyWjmpQa6CknVgJSEyGqpV+6sq4ObW0L/nQmC35kH
	ZpPk3kvtmpgM0Sse56AwJtL8P/haPGj98lP2lIVr3kJMZup8Dh/guKMKaqgTUeFvzZWKpRao41G
	iKjt0/ZxoVom1Q03wbpZSagMbmIWk3yx8jnOop4h5EssbR6qECp+WpsvWl4p+Olf3bhTRSDnkoI
	eFxztVO989SahKLVNFpXJeA1P5ye6tjeK2Pyk+TXvQu3Cp71wT4rQrxAmTA2/gNG+oT8zlv07sj
	ZbEQVKANGyr0HmhxEnezU4dZEd47mh6tSPf8frLcKfLNGWfDwszUnjzkeKY0xLvJMhrnK1jB44V
	irU20sa8jmKpu2WUm2IqRjHl9
X-Google-Smtp-Source: AGHT+IHSK5EEmR6TBrosEOEhDl6rDkA2E4ZqWIoCbjjkEo/IjzID4OBobJs2anobHQNRGAw2j2+pcA==
X-Received: by 2002:a05:6a00:928c:b0:772:337e:3090 with SMTP id d2e1a72fcca58-7742ddaddf2mr18533500b3a.4.1757464810474;
        Tue, 09 Sep 2025 17:40:10 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774660e67cbsm3247520b3a.6.2025.09.09.17.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:40:09 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:40:06 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	asantostc@gmail.com, efault@gmx.de, kernel-team@meta.com,
	stable@vger.kernel.org, jv@jvosburgh.net
Subject: Re: [PATCH net v3 1/3] netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Message-ID: <aMDI5hY0BH2iSkdt@mozart.vkv.me>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
 <20250905-netconsole_torture-v3-1-875c7febd316@debian.org>
 <aL9A3JDyx3TxAzLf@mozart.vkv.me>
 <frxhoevr2fd4rdkhiix4z2agnqaglf4ho2rj6p6ncjwmseplg7@gknjhh23px4o>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <frxhoevr2fd4rdkhiix4z2agnqaglf4ho2rj6p6ncjwmseplg7@gknjhh23px4o>

On Tuesday 09/09 at 07:05 -0700, Breno Leitao wrote:
> On Mon, Sep 08, 2025 at 01:47:24PM -0700, Calvin Owens wrote:
> > On Friday 09/05 at 10:25 -0700, Breno Leitao wrote:
> > > commit efa95b01da18 ("netpoll: fix use after free") incorrectly
> > > ignored the refcount and prematurely set dev->npinfo to NULL during
> > > netpoll cleanup, leading to improper behavior and memory leaks.
> > > 
> > > Scenario causing lack of proper cleanup:
> > > 
> > > 1) A netpoll is associated with a NIC (e.g., eth0) and netdev->npinfo is
> > >    allocated, and refcnt = 1
> > >    - Keep in mind that npinfo is shared among all netpoll instances. In
> > >      this case, there is just one.
> > > 
> > > 2) Another netpoll is also associated with the same NIC and
> > >    npinfo->refcnt += 1.
> > >    - Now dev->npinfo->refcnt = 2;
> > >    - There is just one npinfo associated to the netdev.
> > > 
> > > 3) When the first netpolls goes to clean up:
> > >    - The first cleanup succeeds and clears np->dev->npinfo, ignoring
> > >      refcnt.
> > >      - It basically calls `RCU_INIT_POINTER(np->dev->npinfo, NULL);`
> > >    - Set dev->npinfo = NULL, without proper cleanup
> > >    - No ->ndo_netpoll_cleanup() is either called
> > > 
> > > 4) Now the second target tries to clean up
> > >    - The second cleanup fails because np->dev->npinfo is already NULL.
> > >      * In this case, ops->ndo_netpoll_cleanup() was never called, and
> > >        the skb pool is not cleaned as well (for the second netpoll
> > >        instance)
> > >   - This leaks npinfo and skbpool skbs, which is clearly reported by
> > >     kmemleak.
> > > 
> > > Revert commit efa95b01da18 ("netpoll: fix use after free") and adds
> > > clarifying comments emphasizing that npinfo cleanup should only happen
> > > once the refcount reaches zero, ensuring stable and correct netpoll
> > > behavior.
> > 
> > This makes sense to me.
> > 
> > Just curious, did you try the original OOPS reproducer?
> > https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/
> 
> Yes, but I have not been able to reproduce the problem at all.
> I've have tested it using netdevsim, and here is a quick log of what I
> run:

Nice, thanks for clarifying.

I also tried reverting a few commits like [1] around the time that smell
vaguely related, on top of your fix, but the repro still never triggers
anything for me either. I was using virtio interfaces in KVM.

The world may never know :)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=69b0216ac255

> 	+ modprobe netconsole
> 	+ modprobe bonding mode=4
> 	[   86.540950] Warning: miimon must be specified, otherwise bonding will not detect link failure, speed and duplex which are essential for 802.3ad operation
> 	[   86.541617] Forcing miimon to 100msec
> 	[   86.541893] MII link monitoring set to 100 ms
> 	+ echo +bond0
> 	[   86.547802] bonding: bond0 is being created...
> 	+ ifconfig bond0 192.168.56.3 up
> 	+ mkdir /sys/kernel/config/netconsole/blah
> 	+ echo 0
> 	[   86.614772] netconsole: network logging has already stopped
> 	./run.sh: line 19: echo: write error: Invalid argument
> 	+ echo bond0
> 	+ echo 192.168.56.42
> 	+ echo 1
> 	[   86.622318] netconsole: netconsole: local port 6665
> 	[   86.622550] netconsole: netconsole: local IPv4 address 0.0.0.0
> 	[   86.622819] netconsole: netconsole: interface name 'bond0'
> 	[   86.623038] netconsole: netconsole: local ethernet address '00:00:00:00:00:00'
> 	[   86.623466] netconsole: netconsole: remote port 6666
> 	[   86.623675] netconsole: netconsole: remote IPv4 address 192.168.56.42
> 	[   86.623924] netconsole: netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
> 	[   86.624264] netpoll: netconsole: local IP 192.168.56.3
> 	[   86.643174] netconsole: network logging started
> 	+ ifenslave bond0 eth1
> 	[   86.659899] bond0: (slave eth1): Enslaving as a backup interface with a down link
> 	+ ifenslave bond0 eth2
> 	[   86.687630] bond0: (slave eth2): Enslaving as a backup interface with a down link
> 	+ sleep 3
> 	+ ifenslave -d bond0 eth1
> 	[   89.735701] bond0: (slave eth1): Releasing backup interface
> 	[   89.737239] bond0: (slave eth1): the permanent HWaddr of slave - 06:44:84:94:87:c7 - is still in use by bond - set the HWaddr of slave to a different address to avoid conflicts
> 	+ sleep 1
> 	+ echo -bond0
> 	[   90.798676] bonding: bond0 is being deleted...
> 	[   90.815595] netconsole: network logging stopped on interface bond0 as it unregistered
> 	[   90.816416] bond0 (unregistering): (slave eth2): Releasing backup interface
> 	[   90.863054] bond0 (unregistering): Released all slaves
> 	+ ls -lR /
> 	+ tail -30
> 	<snip>
> 
> 	+ echo +bond0
> 	./run.sh: line 39: /sys/class/net/bonding_masters: Permission denied

I don't get -EACCES here like you seem to, but nothing interesting
happens either.

> 	+ ifconfig bond0 192.168.56.3 up
> 	SIOCSIFADDR: No such device
> 	bond0: ERROR while getting interface flags: No such device
> 	bond0: ERROR while

