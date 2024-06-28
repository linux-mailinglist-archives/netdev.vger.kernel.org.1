Return-Path: <netdev+bounces-107527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E1E91B51F
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 04:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF791F22916
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 02:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA7F17BDC;
	Fri, 28 Jun 2024 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="uOubbM6g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48D20DE8
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719542198; cv=none; b=L9dPyHjaEoyM2JBJf7EKOeiz4/vLt1NsEXV2VkuW/o1q7i5mQfYIviPKBQrw8wemwaLXV70zfQtYOn7c0qT73LVpYJhMTZuI/28skeZQ9wRBYLBeT9pK+sw1sZ4RWspBbWg02INundMamQxiUok00ed0tvvfvlrKZASihmXKO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719542198; c=relaxed/simple;
	bh=58LpqfTaSwJ+sjn5jWzll+3BWIc7gGuPI8kw+6IUkKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0j+tITaEGGiiNQCThdYsQOFAhWdIf1PeyVvqLSzNDd4uEjF/rKFNpSXEa0yS6FU+qxrvPv22vR/t0xAU3CgtAB8cJje2MprIyHA0tY+Jd6oCOiZzwdwxRm3SEzMMh0WOU35JnuBGhaUvgbVe8T9WR3OxqK0+FnkGT/45QvFzts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=uOubbM6g; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-706738c209bso104591b3a.3
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 19:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1719542195; x=1720146995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVHT3z6620PlYWUwD85yO22cfHovi4vQP2i8lkzAtk4=;
        b=uOubbM6gXdRcPFRZOs0mHDFg652QVrjgz+2qoQlA8fVcaE6mr50mzTA8ucdV2s/9El
         r6ApY9rEH8QVVpgc0x1pmo1mW1nONKwc5Z2LDnQbU6yiC4f79dz4oryseoVp7BHvInRa
         MidnnjH317qtEchEa8KbOoWcwWTEGIP1KHN4yMxMTTv8fdBtriBwzTo+vWP33cgyistz
         q8EVXKzng9FdKqLZGSCB02rlXPeG4mtWV4NEgzUbVDnDPx77CEyIWBGvGhN2JcWJAi7b
         toD2IXW78YT1jMMa5I4K5M55eQBTqUukw7pEAPeo5VjB7T6pccguofZ4PcuzXUdqxThV
         uW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719542195; x=1720146995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVHT3z6620PlYWUwD85yO22cfHovi4vQP2i8lkzAtk4=;
        b=PW0BzBhMAYP5KSX0rUcnsQbS31m+7hsCRjL9LK5NYIL4v4jaUmHS14NVuu+Mvb0NHJ
         qNok24MGPPByvVc1SnHt7c4o7eK5Pgb6HoIqrVc0+5w1b/BDOtwpcoa6EGhXkIBRlkt+
         VcOr8MgowVqgDUBUWbp1dxEPfHS4Ji19pNBQPB8GDXaUYNH86PwBi8yMLO13HNj2Sd4w
         ILlbB9mG59LB00u/jRVKwwHoJFxss6ZMqTtNXNCp0EwQF3OqLCy4G40LrsVpiYEPVoKX
         y7EHPaOJ8g/M87RFyL+M/MdbP76m8/7L11U2GhSjGUt5fnq3Nu0U4yO5u3sRADPkOsl7
         DQsw==
X-Gm-Message-State: AOJu0Yy2jLJeH+R2etfLBmAcOjrj/n6l9/4n93vS6kx2DIygsIeu9LQR
	OPJRv04B9O30ajIhZsW+RjPgyg7RBTecj7s9asA65tqtFMdRe1Pd4oHCt38thI0=
X-Google-Smtp-Source: AGHT+IEcfx/ST+GeuTeYBfN2ERcalZsvRzJ1sGIjKdGcDtSetsB5p9q8jJyC4aa7BZV/5OeaaL4NoQ==
X-Received: by 2002:a05:6a00:138b:b0:706:747c:76b6 with SMTP id d2e1a72fcca58-706747c7759mr20549648b3a.22.1719542195315;
        Thu, 27 Jun 2024 19:36:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a31b463sm370416a12.21.2024.06.27.19.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 19:36:35 -0700 (PDT)
Date: Thu, 27 Jun 2024 19:36:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: "ip route show dev enp0s9" does not show all routes for enp0s9
Message-ID: <20240627193632.5ea88216@hermes.local>
In-Reply-To: <SJ0PR84MB2088DCBDCCCD49FFB9DFFBAAD8D02@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
References: <SJ0PR84MB2088DCBDCCCD49FFB9DFFBAAD8D02@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 00:01:47 +0000
"Muggeridge, Matt" <matt.muggeridge2@hpe.com> wrote:

> Hi,
> 
> This looks like a problem in "iproute2".  This was observed on a fresh install of Ubuntu 24.04, with Linux 6.8.0-36-generic.
> 
> NOTE: I first raised this in https://bugs.launchpad.net/ubuntu/+source/iproute2/+bug/2070412, then later found https://github.com/iproute2/iproute2/blob/main/README.devel.
> 
> * PROBLEM
> Compare the outputs:
> 
> $ ip -6 route show dev enp0s9
> 2001:2:0:1000::/64 proto ra metric 1024 expires 65518sec pref medium
> fe80::/64 proto kernel metric 256 pref medium
> 
> $ ip -6 route
> 2001:2:0:1000::/64 dev enp0s9 proto ra metric 1024 expires 65525sec pref medium
> fe80::/64 dev enp0s3 proto kernel metric 256 pref medium
> fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
> default proto ra metric 1024 expires 589sec pref medium
>  nexthop via fe80::200:10ff:fe10:1060 dev enp0s9 weight 1
>  nexthop via fe80::200:10ff:fe10:1061 dev enp0s9 weight 1
> 
> The default route is associated with enp0s9, yet the first command above does not show it.
> 
> FWIW, the two default route entries were created by two separate routers on the network, each sending their RA.
> 
> * REPRODUCER
> Statically Configure systemd-networkd with two route entries, similar to the following:
> 
> $ networkctl cat 10-enp0s9.network
> # /etc/systemd/network/10-enp0s9.network
> [Match]
> Name=enp0s9
> 
> [Link]
> RequiredForOnline=no
> 
> [Network]
> Description="Internal Network: Private VM-to-VM IPv6 interface"
> DHCP=no
> LLDP=no
> EmitLLDP=no
> 
> 
> # /etc/systemd/network/10-enp0s9.network.d/address.conf
> [Network]
> Address=2001:2:0:1000:a00:27ff:fe5f:f72d/64
> 
> 
> # /etc/systemd/network/10-enp0s9.network.d/route-1060.conf
> [Route]
> Gateway=fe80::200:10ff:fe10:1060
> GatewayOnLink=true
> 
> 
> # /etc/systemd/network/10-enp0s9.network.d/route-1061.conf
> [Route]
> Gateway=fe80::200:10ff:fe10:1061
> GatewayOnLink=true
> 
> 
> 
> Now reload and reconfigure the interface and you will see two routes.
> 
> $ networkctl reload
> $ networkctl reconfigure enp0s9
> $ ip -6 r
> $ ip -6 r show dev enp0s9 # the routes are not shown
> 

"Don't blame the messenger", the ip command only reports what the kernel
sends. So it is likely a route semantics issue in the kernel.


