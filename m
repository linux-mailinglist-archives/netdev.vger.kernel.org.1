Return-Path: <netdev+bounces-124277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D406968C82
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45EC6B21CC6
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F4E20FAB9;
	Mon,  2 Sep 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZPBaJrC7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B521AB6F9
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725296173; cv=none; b=nt3E0kpCIzC/+KXgMJ2BHMERcmEAOHKLTqDHYHNLXGYeBRAPqGItpkn3842Q0C+ypL197vtlLVsusC4/pQA2LMspM7Zfw5UvC/Vwm8mn3XHwLwxRUAkT5u2vIN80zamC/x6TozMF9pSVZIp5Kh0dv2iWKc5NlbzTWWsUqTy0XSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725296173; c=relaxed/simple;
	bh=NlKD6Rywk2o6S7Srgzx1r8fUDtPHl6oDuqm+Szl1lHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5iV1b26OTQOwrA3H2cmqMrrqOoM8pPrWw8iWJAKJsOP7KVf8Xt/zMxvOxU6O4PwNGkRt/E3nUcLa5Emqfwc7CVpfodVAYU6sBCrCzyFCIcIS5VP8mc1SggbH2fOAaiju44Sgk52hZAHaWh7W3sm6/MQGA5RwEobm4NE5G47hws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZPBaJrC7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bef295a45bso1894277a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725296170; x=1725900970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPZZydcS8XzcurpZ/PVZNgRNYtNKwp7mFoxRYZkP320=;
        b=ZPBaJrC7F6iDUA2SJFcItS05EMhCK4OK/qZHcHeRBTyssWyN5/xzr8VfRw4EtBFuxi
         p6K1zbA4H2j5NPp2GRIL2aYEFDxyFFf+vvL28t2Dik+2mN/wjCIpCimEKAm2zDMDf2YO
         uAcXx/iiI7BUT5/EFcem+C25ai+rE1r3Iu0wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725296170; x=1725900970;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPZZydcS8XzcurpZ/PVZNgRNYtNKwp7mFoxRYZkP320=;
        b=cxzAiwETlBCRYu8ceTj7EWVCWioO6m35pdsLWA5ZHOvoRvAg5JNLghIlPCAk/8UMEE
         1/R/P7Fu9TROKxKWAGNqqE6+Zb+v6aj2hNaU1HfPwtRcc1YTOGylYh0I+gdys71+a75u
         t3z+jP3W3TNuLZAfwh56ejX+sTskdcRAMR2znlrfpHnu3eIB0ja0CNK4W/fnMkTlU+VV
         841wLY9nq189ByXx3fd17S5EacoZ8s348mB+/dr3v4GUjz2fO6WvGm6IScZ3RXnTOPwG
         U3Vn0madYdpNOILP31WViHA+EnK4X6vMacvhEE3+JOul6YNQhZ4cTKtbxM71pLE9+nLu
         dbIg==
X-Gm-Message-State: AOJu0YwAlzH+EtDejiQ/b2/uPiVQqOwgFKg3jpK/Y4N5OXtKvDTmbIQL
	0THJN76BY8yyW1OMf2AwDfnz1w5NA0dtoyVOLAXDtnn6cDF7tJyDvFkssDP4mHU=
X-Google-Smtp-Source: AGHT+IHK75a4RqYwQmJU4PYa0YsDaXS5QJG7oU28vPgrDCS0nTi/Fa82tRY6Z9AtBXhRiq29RMTkxw==
X-Received: by 2002:a05:6402:4402:b0:5c2:43b1:fe58 with SMTP id 4fb4d7f45d1cf-5c243b1febcmr7426045a12.20.1725296169696;
        Mon, 02 Sep 2024 09:56:09 -0700 (PDT)
Received: from LQ3V64L9R2.station (net-2-42-195-208.cust.vodafonedsl.it. [2.42.195.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c250edd2e3sm2348706a12.27.2024.09.02.09.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 09:56:09 -0700 (PDT)
Date: Mon, 2 Sep 2024 18:56:07 +0200
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <ZtXuJ3TMp9cN5e9h@LQ3V64L9R2.station>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240829131214.169977-1-jdamato@fastly.com>
 <20240829131214.169977-6-jdamato@fastly.com>
 <20240829153105.6b813c98@kernel.org>
 <ZtGiNF0wsCRhTtOF@LQ3V64L9R2>
 <20240830142235.352dbad5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830142235.352dbad5@kernel.org>

On Fri, Aug 30, 2024 at 02:22:35PM -0700, Jakub Kicinski wrote:
> On Fri, 30 Aug 2024 11:43:00 +0100 Joe Damato wrote:
> > On Thu, Aug 29, 2024 at 03:31:05PM -0700, Jakub Kicinski wrote:
> > > On Thu, 29 Aug 2024 13:12:01 +0000 Joe Damato wrote:  
> > > > +      doc: Set configurable NAPI instance settings.  
> > > 
> > > We should pause and think here how configuring NAPI params should
> > > behave. NAPI instances are ephemeral, if you close and open the
> > > device (or for some drivers change any BPF or ethtool setting)
> > > the NAPIs may get wiped and recreated, discarding all configuration.
> > > 
> > > This is not how the sysfs API behaves, the sysfs settings on the device
> > > survive close. It's (weirdly?) also not how queues behave, because we
> > > have struct netdev{_rx,}_queue to store stuff persistently. Even tho
> > > you'd think queues are as ephemeral as NAPIs if not more.
> > > 
> > > I guess we can either document this, and move on (which may be fine,
> > > you have more practical experience than me). Or we can add an internal
> > > concept of a "channel" (which perhaps maybe if you squint is what
> > > ethtool -l calls NAPIs?) or just "napi_storage" as an array inside
> > > net_device and store such config there. For simplicity of matching
> > > config to NAPIs we can assume drivers add NAPI instances in order. 
> > > If driver wants to do something more fancy we can add a variant of
> > > netif_napi_add() which specifies the channel/storage to use.
> > > 
> > > Thoughts? I may be overly sensitive to the ephemeral thing, maybe
> > > I work with unfortunate drivers...  
> > 
> > Thanks for pointing this out. I think this is an important case to
> > consider. Here's how I'm thinking about it.
> > 
> > There are two cases:
> > 
> > 1) sysfs setting is used by existing/legacy apps: If the NAPIs are
> > discarded and recreated, the code I added to netif_napi_add_weight
> > in patch 1 and 3 should take care of that case preserving how sysfs
> > works today, I believe. I think we are good on this case ?
> 
> Agreed.
> 
> > 2) apps using netlink to set various custom settings. This seems
> > like a case where a future extension can be made to add a notifier
> > for NAPI changes (like the netdevice notifier?).
> 
> Yes, the notifier may help, but it's a bit of a stop gap / fallback.
> 
> > If you think this is a good idea, then we'd do something like:
> >   1. Document that the NAPI settings are wiped when NAPIs are wiped
> >   2. In the future (not part of this series) a NAPI notifier is
> >      added
> >   3. User apps can then listen for NAPI create/delete events
> >      and update settings when a NAPI is created. It would be
> >      helpful, I think, for user apps to know about NAPI
> >      create/delete events in general because it means NAPI IDs are
> >      changing.
> > 
> > One could argue:
> > 
> >   When wiping/recreating a NAPI for an existing HW queue, that HW
> >   queue gets a new NAPI ID associated with it. User apps operating
> >   at this level probably care about NAPI IDs changing (as it affects
> >   epoll busy poll). Since the settings in this series are per-NAPI
> >   (and not per HW queue), the argument could be that user apps need
> >   to setup NAPIs when they are created and settings do not persist
> >   between NAPIs with different IDs even if associated with the same
> >   HW queue.
> 
> IDK if the fact that NAPI ID gets replaced was intentional in the first
> place. I would venture a guess that the person who added the IDs was
> working with NICs which have stable NAPI instances once the device is
> opened. This is, unfortunately, not universally the case.
> 
> I just poked at bnxt, mlx5 and fbnic and all of them reallocate NAPIs
> on an open device. Closer we get to queue API the more dynamic the whole
> setup will become (read: the more often reconfigurations will happen).
>

[...]

> > I think you have much more practical experience when it comes to
> > dealing with drivers, so I am happy to follow your lead on this one,
> > but assuming drivers will "do a thing" seems mildly scary to me with
> > limited driver experience.
> > 
> > My two goals with this series are:
> >   1. Make it possible to set these values per NAPI
> >   2. Unblock the IRQ suspension series by threading the suspend
> >      parameter through the code path carved in this series
> > 
> > So, I'm happy to proceed with this series as you prefer whether
> > that's documentation or "napi_storage"; I think you are probably the
> > best person to answer this question :)
> 
> How do you feel about making this configuration opt-in / require driver
> changes? What I'm thinking is that having the new "netif_napi_add()"
> variant (or perhaps extending netif_napi_set_irq()) to take an extra
> "index" parameter would make the whole thing much simpler.

What about extending netif_queue_set_napi instead? That function
takes a napi and a queue index.

Locally I kinda of hacked up something simple that:
  - Allocates napi_storage in net_device in alloc_netdev_mqs
  - Modifies netif_queue_set_napi to:
     if (napi)
       napi->storage = dev->napi_storage[queue_index];

I think I'm still missing the bit about the
max(rx_queues,tx_queues), though :(

> Index would basically be an integer 0..n, where n is the number of
> IRQs configured for the driver. The index of a NAPI instance would
> likely match the queue ID of the queue the NAPI serves.

Hmmm. I'm hesitant about the "number of IRQs" part. What if there
are NAPIs for which no IRQ is allocated ~someday~ ?

It seems like (I could totally be wrong) that netif_queue_set_napi
can be called and work and create the association even without an
IRQ allocated.

I guess the issue is mostly the queue index question above: combined
rx/tx vs drivers having different numbers of rx and tx queues.

> We can then allocate an array of "napi_configs" in net_device -
> like we allocate queues, the array size would be max(num_rx_queue,
> num_tx_queues). We just need to store a couple of ints so it will
> be tiny compared to queue structs, anyway.
> 
> The NAPI_SET netlink op can then work based on NAPI index rather 
> than the ephemeral NAPI ID. It can apply the config to all live
> NAPI instances with that index (of which there really should only 
> be one, unless driver is mid-reconfiguration somehow but even that
> won't cause issues, we can give multiple instances the same settings)
> and also store the user config in the array in net_device.
> 
> When new NAPI instance is associate with a NAPI index it should get
> all the config associated with that index applied.
> 
> Thoughts? Does that makes sense, and if so do you think it's an
> over-complication?

I think what you are proposing seems fine; I'm just working out the
implementation details and making sure I understand before sending
another revision.

