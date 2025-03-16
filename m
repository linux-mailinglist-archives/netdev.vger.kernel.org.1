Return-Path: <netdev+bounces-175089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8C1A63348
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 03:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26379171298
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 02:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB6A8BE5;
	Sun, 16 Mar 2025 02:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc/O5Gd2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571E7DA66;
	Sun, 16 Mar 2025 02:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742090675; cv=none; b=i04AYkIhVNKPPjxm4Xy1NxnyxORKLr0dJNdhTHIguo1YrHN6bmXY611sKq+WjI36Bs+mFO/ktsCxmQze8o9eY1E0BJJ4JCtt/Mmfe2zEQKHquk2QPHJxNYSCNIr6cqgJYFYrlnzK4k/UFLO4mTOwUUJfJw1Knb070hLH+CDq/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742090675; c=relaxed/simple;
	bh=PI5MGq6SJfuPQw6nz7ZzA/PhOIfj6m9e6nts8d5VFaw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AnDnt73dEbF+yU2Y4FxEfIQV6lQ2IWLuHRZiIQyKgRhqAmEqyJzGe7gc5S3E0CX+14RRUrYu/qX9dguuVSYaiIS1tcZactCLPqLj3uZ5u4VdK9xoMobQeg1p2ZMww47xi9xU4TCmhzxTg5F/4PVuYX84XfwZNnBSVzuQWJNTk0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pc/O5Gd2; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c089b2e239so331181285a.0;
        Sat, 15 Mar 2025 19:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742090673; x=1742695473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrwGLm7Mg0OFOfTovVm2b8/IP0PcSqPyBDGUkHn/ZpA=;
        b=Pc/O5Gd2bpBvUxKJhVPUWqAdMZdCf5Jp8Wh3nU1usNvAGpOgo9mRX3F5Xc4F6XtjEd
         VPX2+yGxk6dB/F1sWhSiKmIhfVstfLw+Hu1b+dtWTq25ZmPZyimS+Kb6JL8rv+PUDJ4l
         7/6KpDR/99Z1cVkgVdVRImbephGcrquKTd4+5vKzZD9lVyVZO61SZc0v4Ko6vK/uSBAD
         AokVsIHnANA3FS/K9vaJ00YNxg2btpTYMO3v117NAahQPuqhPdsi/9u0ve2U+I/2rxaU
         Bh2sWxm4KfKFHOocjESw0ViIMi9z+5G3AcgClSGjkigjRHU8JJ2Pu7UI0XBEG5Tcq1AR
         hBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742090673; x=1742695473;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JrwGLm7Mg0OFOfTovVm2b8/IP0PcSqPyBDGUkHn/ZpA=;
        b=Yc7RWUIM2oufnbY2QMsDm+mPhgRBrccALo4Dv3HHYpzBzGasemG9pODXO29xkbaqRV
         wwQAzzMcNSOplm4oCbjSScOW/x9jtD55V5B6mGLAdXEzW376uAPSUbifdJLrSXqk1R8j
         Jkhi+EI+vMSQer0xZvwqQjuLsFV1b6g1np4JD7wv0c3rwqaBw/3FY4XCpeIniIQ6h/he
         UdiMB0qXQsO1AxPzdpzFY59LjihcEBFe9QyNVvIPH+ZCYJQAX6zNEM3+GfaJ6OYHwYX7
         fl8Fpm+ofoC0fUV8sHxuSVdhcWGk+HDK3y1MfbRRcZPcBLNQmlpYFdethSB3AQEzHe+3
         N/FA==
X-Forwarded-Encrypted: i=1; AJvYcCVZOOCtQT+q5+7aAfDGKve+3mtPBJsyOlOugj0mSFmXvYAnDnvt9PjDx2Yq1pu/4HH/6i6RVkmJlVQkM1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLP+KonA9S7ZB19x9pT4jENi5wr2tvASSdUcpKGui2CG7pPHI
	ZvEgQl+qOwWLec2iyIYx3mNO3v6KaA+sRMNYDp3aKFWemrE84UXz
X-Gm-Gg: ASbGnctaidapCC20r+gHfKwbJOC6aj/yPf3mpD6ZdnmqklOuK96mFaeGljexkmPRr/N
	3A2xlWx13l4uxf+9hDgAh/+2JXq8qD7RUNhFfB8s72vixgHh/Rmp6zs0di/o2QOaNvGtqxetdWh
	MrJbAds7y5qNDqx3Rns8GgXcutXG8JPmhG2fPuxtFgmcVjUp6/9EtMfSyts79K+Qo8klp6m3Yza
	p1cBNchgWG78Kf+7Sl9byv2wm/CMwOiDPyFOktWMW5ukjYJdzYQjAA0e8U2wxuEKlVUxP88/GIF
	kQMyB8X6Yi9Ltjo3u7dpvsyiH8MIj1u7YQwaZ/A1171Ddzbw1VLTsRHg45PF0kRY2hxnq5FanFB
	ekvMeSz+JtKnKRzaaHoOxCg==
X-Google-Smtp-Source: AGHT+IFmVWQVAfKF7sRwSqd+5gZarDw8P/Q8Kgb28nolpwjHtiDgwUpM9On2UZjCdM+jIH/N5IMN7A==
X-Received: by 2002:a05:620a:248a:b0:7c3:ca29:c87e with SMTP id af79cd13be357-7c57386f5f9mr1750980185a.21.1742090672675;
        Sat, 15 Mar 2025 19:04:32 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c545c5sm434273285a.21.2025.03.15.19.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 19:04:31 -0700 (PDT)
Date: Sat, 15 Mar 2025 22:04:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Radharapu, Rakesh" <Rakesh.Radharapu@amd.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "git (AMD-Xilinx)" <git@amd.com>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "horms@kernel.org" <horms@kernel.org>, 
 "kuniyu@amazon.com" <kuniyu@amazon.com>, 
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "Katakam, Harini" <harini.katakam@amd.com>, 
 "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, 
 "Simek, Michal" <michal.simek@amd.com>
Message-ID: <67d631ae62f7e_2489c92941f@willemb.c.googlers.com.notmuch>
In-Reply-To: <SA1PR12MB81631C34BCAAA27CB25E271E9DD02@SA1PR12MB8163.namprd12.prod.outlook.com>
References: <20250312115400.773516-1-rakesh.radharapu@amd.com>
 <0b1cdac7-662a-4e27-b8b0-836cdba1d460@redhat.com>
 <SA1PR12MB81631C34BCAAA27CB25E271E9DD02@SA1PR12MB8163.namprd12.prod.outlook.com>
Subject: RE: [RFC PATCH net-next] net: Modify CSUM capability check for USO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Radharapu, Rakesh wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> > -----Original Message-----
> > From: Paolo Abeni <pabeni@redhat.com>
> > Sent: Wednesday, March 12, 2025 9:44 PM
> > To: Radharapu, Rakesh <Rakesh.Radharapu@amd.com>; git (AMD-Xilinx)
> > <git@amd.com>; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; horms@kernel.org; kuniyu@amazon.com;
> > bigeasy@linutronix.de
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Katakam, Harini
> > <harini.katakam@amd.com>; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; Simek, Michal
> > <michal.simek@amd.com>
> > Subject: Re: [RFC PATCH net-next] net: Modify CSUM capability check for USO
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On 3/12/25 12:54 PM, Radharapu Rakesh wrote:
> > >  net/core/dev.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/net/core/dev.c b/net/core/dev.c index
> > > 1cb134ff7327..a22f8f6e2ed1 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -10465,11 +10465,13 @@ static void
> > > netdev_sync_lower_features(struct net_device *upper,
> > >
> > >  static bool netdev_has_ip_or_hw_csum(netdev_features_t features)  {
> > > -     netdev_features_t ip_csum_mask = NETIF_F_IP_CSUM |
> > NETIF_F_IPV6_CSUM;
> > > -     bool ip_csum = (features & ip_csum_mask) == ip_csum_mask;
> > > +     netdev_features_t ipv4_csum_mask = NETIF_F_IP_CSUM;
> > > +     netdev_features_t ipv6_csum_mask = NETIF_F_IPV6_CSUM;
> > > +     bool ipv4_csum = (features & ipv4_csum_mask) == ipv4_csum_mask;
> > > +     bool ipv6_csum = (features & ipv6_csum_mask) == ipv6_csum_mask;
> > >       bool hw_csum = features & NETIF_F_HW_CSUM;
> > >
> > > -     return ip_csum || hw_csum;
> > > +     return ipv4_csum || ipv6_csum || hw_csum;
> > >  }
> >
> > The above will additionally affect TLS offload, and will likely break i.e. USO
> > over IPv6 traffic landing on devices supporting only USO over IPv4, unless
> > such devices additionally implement a suitable ndo_features_check().
> >
> > Such situation will be quite bug prone, I'm unsure we want this kind of change
> > - even without looking at the TLS side of it.
> >
> > /P
> Thanks for your review. I understand that this will lead to an issue.
> We have a device that supports only IPv4 CSUM and are unable to enable the
> USO feature because of this check. Can you please let me know if splitting
> GSO feature for IPv4 and IPv6 would be helpful? That way corresponding
> CSUM offloads can be checked. But this would be a major change.
> Will appreciate any other suggestions.

Splitting NETIF_F_GSO_UDP_L4 would incur significant churn.

Since this is a limitation of a specific device, can you instead
advertise the feature, but for IPv6 packets drop the flag in
ndo_features_check?


