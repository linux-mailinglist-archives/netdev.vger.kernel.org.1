Return-Path: <netdev+bounces-148453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645539E1B25
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2427F285485
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85011E3DD8;
	Tue,  3 Dec 2024 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQPfSKWE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE23211
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225971; cv=none; b=U4WIBf89pt+0qQLIRX/r0dbsQfPK2Zj2fqa2gyoB0ikTBJQuYula3eeO/bjvsi3xwkxQKQTV5qqUaNTWDlwiP0y+vrvqtM5rsUtx7u72b7Gyu6ebzw0FqLl+kJn4wbnxHiDgRJebFvgveO5I28/53OqBl1zFIULp/XZxfkqH4kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225971; c=relaxed/simple;
	bh=RnHW5/HAne66yS6fj01PkNJu80hArkQ4YTvqTB4qsXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmE1oKDMxf442/CdIkUs4t2xouU4nUl0wu8XOuJkFMln6xnzGuVPT9O/fTsQinVEtHKKYhVkW615kEpDpcgR+64mY6ysWasrSOLaZIpi1RNmACqbZfbj5Z5gVVAbaf65g7lToNGN/4S2T9hhdiQ96ToLPWNTEed75g7cnd2vDNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQPfSKWE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733225969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w4ZhvVVoHAbxcq/R8MQJ3kCgFGEeIhSsfSq7XUZEgNE=;
	b=gQPfSKWEHvcoDcy88fadhstWxm65ksUKCN2jLjgFNAGQT3BqSJkxS7/btTMzkHD6h6v4xN
	BVEJtPyzhaCmrCTRENxk/NlUfNYjtr+Tq0ZQT4oeoKv1P4nwfY8rFqb7EQje1vkqJ9LLpS
	Bq83Yqo4i9QsxKbmukuE/DjRBn6WJPU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-9-1bQaB-MhOofbL268dU0Q-1; Tue, 03 Dec 2024 06:39:27 -0500
X-MC-Unique: 9-1bQaB-MhOofbL268dU0Q-1
X-Mimecast-MFC-AGG-ID: 9-1bQaB-MhOofbL268dU0Q
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434a27c9044so30819855e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 03:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733225966; x=1733830766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4ZhvVVoHAbxcq/R8MQJ3kCgFGEeIhSsfSq7XUZEgNE=;
        b=CstPmN1g25EIvf8a8R20HQjx8Z0LI3ohrfdiGA3NyQ0mfSz++hZsB/3bAZ5u+F4GRC
         ykYFS1hmnlGK77spBkBQK8vB6/pjbKklYGZrAIiBOFcS1tbe4YubSr6cKEoIB4wRI2En
         Fg6QiHoEB0KaxLSB3sCIVEZaOOLgmlNpy25fdA+jef/x8M5Uxiqbo4zWt8VwNvl40e51
         bl861dSiBh8XbVeXINSYGSh6D3gEPkR+KNSQSknMYgl1ko1aYACcw3MWC9YPMB9EmCa4
         AtaFcxy9rcnBYs8dQvDUPIYi17qGPIhDG88yfBLHBzy09htSRIVSobQnt01RxDTZxDs9
         DVHg==
X-Forwarded-Encrypted: i=1; AJvYcCUj6PCEfBjOmQ6oyZEQhihI4sooB6HydlTHIS1/bhcGdi17E3M3Yz31CXit6+3oY9k3xiFWgYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDiEi1RrA+dQ4/EFdfkAAZgzOhrI5z29butZib6RXJ1aMaclzc
	lszlNw8Opui8xbmLemzz9zxFxSDUdR5OOMI0VK4l/192bxLdwFiYE4R8kcD+oyt/rmvDlRS8Uaw
	axmpDlkPL4lkgf1F954fogVls9KrMmLgtKAIZN0dJbT7wzBpzIzq/Iw==
X-Gm-Gg: ASbGnctb3IAhw3vIPrtyIo1hNzGLAcJBNh8S+DMvUoU68KvdIAC2oFoY2kaDR0wllyl
	aT1ZoIUvjHpWXwnFSpvCDmsyynQATQ3R/qCTHPJysoOCPsQeTqUCZqPrdpScADitkcgMyGtEqic
	J42HAMYosFwgdAF7nwyuAEnGjgQ4rYM3zzKm+Kaj1pyRtldV+aTSoMtoFq/hl5jaQje9Xy/7EEE
	AeQg3oqCXvPYexBpTny5+YVzNHMQ4jyuFY9rLKE2Glu4taMiZXwSwmrUNl2wDiFxI0oPe1kItgo
	fEGUuHvkqzzx09IIh13K8J9SDpv8fw==
X-Received: by 2002:a05:600c:4592:b0:434:a830:936a with SMTP id 5b1f17b1804b1-434d0a05544mr15048435e9.21.1733225965837;
        Tue, 03 Dec 2024 03:39:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnLpTw7Wv8Y0pr83fgy3xaiOkPyF8LFqJjTlws7n/n6/dWE7fqfT9mpnEnCtfKcM6pqQhdbw==
X-Received: by 2002:a05:600c:4592:b0:434:a830:936a with SMTP id 5b1f17b1804b1-434d0a05544mr15048275e9.21.1733225965480;
        Tue, 03 Dec 2024 03:39:25 -0800 (PST)
Received: from debian (2a01cb058d23d600d18d33c42e57fdb0.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:d18d:33c4:2e57:fdb0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa76a981sm215993775e9.16.2024.12.03.03.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:39:24 -0800 (PST)
Date: Tue, 3 Dec 2024 12:39:23 +0100
From: Guillaume Nault <gnault@redhat.com>
To: James Chapman <jchapman@katalix.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next 0/4] net: Convert some UDP tunnel drivers to
 NETDEV_PCPU_STAT_DSTATS.
Message-ID: <Z07t69eseT2+PzDj@debian>
References: <cover.1733175419.git.gnault@redhat.com>
 <bb2cd5e8-39c3-4fc4-e02e-2c2d6bf01f64@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb2cd5e8-39c3-4fc4-e02e-2c2d6bf01f64@katalix.com>

On Tue, Dec 03, 2024 at 08:12:29AM +0000, James Chapman wrote:
> Hi Guillaume,
> 
> I can work on similar changes to l2tp if you haven't already started work on
> it.

I haven't, so yes, please do. You can Cc me when submitting the patch,
so that I can ack it in time.

> James
> 
> On 02/12/2024 21:48, Guillaume Nault wrote:
> > VXLAN, Geneve and Bareudp use various device counters for managing
> > RX and TX statistics:
> > 
> >    * VXLAN uses the device core_stats for RX and TX drops, tstats for
> >      regular RX/TX counters and DEV_STATS_INC() for various types of
> >      RX/TX errors.
> > 
> >    * Geneve uses tstats for regular RX/TX counters and DEV_STATS_INC()
> >      for everything else, include RX/TX drops.
> > 
> >    * Bareudp, was recently converted to follow VXLAN behaviour, that is,
> >      device core_stats for RX and TX drops, tstats for regular RX/TX
> >      counters and DEV_STATS_INC() for other counter types.
> > 
> > Let's consolidate statistics management around the dstats counters
> > instead. This avoids using core_stats in VXLAN and Bareudp, as
> > core_stats is supposed to be used by core networking code only (and not
> > in drivers).  This also allows Geneve to avoid using atomic increments
> > when updating RX and TX drop counters, as dstats is per-cpu. Finally,
> > this also simplifies the code as all three modules now handle stats in
> > the same way and with only two different sets of counters (the per-cpu
> > dstats and the atomic DEV_STATS_INC()).
> > 
> > Patch 1 creates dstats helper functions that can be used outside of VRF
> > (before that, dstats was VRF-specific).
> > Patches 2 to 4 convert VXLAN, Geneve and Bareudp, one by one.
> > 
> > Guillaume Nault (4):
> >    vrf: Make pcpu_dstats update functions available to other modules.
> >    vxlan: Handle stats using NETDEV_PCPU_STAT_DSTATS.
> >    geneve: Handle stats using NETDEV_PCPU_STAT_DSTATS.
> >    bareudp: Handle stats using NETDEV_PCPU_STAT_DSTATS.
> > 
> >   drivers/net/bareudp.c          | 16 ++++++------
> >   drivers/net/geneve.c           | 12 ++++-----
> >   drivers/net/vrf.c              | 46 +++++++++-------------------------
> >   drivers/net/vxlan/vxlan_core.c | 28 ++++++++++-----------
> >   include/linux/netdevice.h      | 40 +++++++++++++++++++++++++++++
> >   5 files changed, 80 insertions(+), 62 deletions(-)
> > 
> 
> -- 
> James Chapman
> Katalix Systems Ltd
> https://katalix.com
> Catalysts for your Embedded Linux software development
> 


