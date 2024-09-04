Return-Path: <netdev+bounces-125298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E5596CAE8
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D88B24D01
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 23:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B79183CD6;
	Wed,  4 Sep 2024 23:40:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D3C17ADFF;
	Wed,  4 Sep 2024 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493245; cv=none; b=ex/IftAaZScBxoICQbsf5KFhCiRduhbMSrdNMCp72Q0HDsIzBx9pScjPaBaKYYQXysOdcaKyyKqb5fbR5UhxrG9MW5EK6OD4uzvf0tvn8UBIzkBMjRWB1ha+p81zKkBRw9r5HWNjfUOm9mKWSRvkEr2z/2ojcsazDALS90i6Oog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493245; c=relaxed/simple;
	bh=wRmcDh7W+oWS28+XAhHv0g3d6RIaFwjNqMRSOlMlWAY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHeY8KXXmEmu+hb4IgQamJQQOtwFW55QogtLJT9d60o+wpRTYH4XOoPbN891zlBqJD/Nl5ioZ6Eb2FHzb7cBGZ6LGaBkR4sF1tb+xs9p/x07RE2+nC6smFDVQuGOnREcP+AdfKuxS+uYNxZoGxufyHNThCq9qRC5X4VnjaNMKdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5dfaccba946so125940eaf.1;
        Wed, 04 Sep 2024 16:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725493242; x=1726098042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPNdBdUCQDHHgHj5AgSA28hftNXG157gckEYtkAH7hY=;
        b=pYfD+jbv//qBA7asSCQCBGvca+09DdTZDXOA1m46U+MUQ0OlNL2SaOjeQO/4Oo23bI
         dT+zPa+8mk9uVSrG7bOCQmq6Uisg0OH8HKWI5urFusZ+5mrklFh5+2FYpGXRXxs3lnbz
         4/HcE+cSuR9vUmk4sGTTeGEcjIi6pO2c5jNaRlxzVo6ZCY+QWjYgo+9RASeg5XcAGU4t
         QfgYhbUKA9J0LHO7JoLBNZ+DSz8fopxESfd3szmNq5vQjDLH3cs773rUMRY3GTD8tEHW
         QPRoqqY3+JtKu+LsUEGkK58EYEprPU/y3bxrKTJIAlEj7SB6UugfKqTH5YfCwTQVoo+1
         bdBw==
X-Forwarded-Encrypted: i=1; AJvYcCU+Bw9OmoE4OjF6DHhtZsZBBDJDUL60HLHh9ja8WQLot6mrDVouFbpfkC2egvTSdasJ+dJr74hU@vger.kernel.org, AJvYcCWrAicsb2IUewGG/QGpvvM7SAazLzNxuSqyVd70Yh5mzRBxPhiEd/gT94jfsi/tx9bU7HzYx/y/KUcxMSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvpYxRtr1vTCDRwiV5Ewsdp02eYm7ujv3rYchAWlAf75tMzLDW
	qoCbOdMLMjMbqar1t0CgJz2gcWTEFFyDgSbxtApgYz8ql65lMoo=
X-Google-Smtp-Source: AGHT+IEEF2xs3FDoxz65k0aj+tNQ9BM5KVKyGYBQkHVxbeuJro7EX8k6xTHxPuGt6BgQgB8SCKpf3Q==
X-Received: by 2002:a05:6358:63a8:b0:1aa:d6fe:f3fc with SMTP id e5c5f4694b2df-1b7f1b1b24fmr1962003355d.19.1725493242335;
        Wed, 04 Sep 2024 16:40:42 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd92aaasm2206176a12.50.2024.09.04.16.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 16:40:41 -0700 (PDT)
Date: Wed, 4 Sep 2024 16:40:41 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
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
Message-ID: <Ztjv-dgNFwFBnXwd@mini-arch>
References: <20240829131214.169977-1-jdamato@fastly.com>
 <20240829131214.169977-6-jdamato@fastly.com>
 <20240829153105.6b813c98@kernel.org>
 <ZtGiNF0wsCRhTtOF@LQ3V64L9R2>
 <20240830142235.352dbad5@kernel.org>
 <ZtXuJ3TMp9cN5e9h@LQ3V64L9R2.station>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtXuJ3TMp9cN5e9h@LQ3V64L9R2.station>

On 09/02, Joe Damato wrote:
> On Fri, Aug 30, 2024 at 02:22:35PM -0700, Jakub Kicinski wrote:
> > On Fri, 30 Aug 2024 11:43:00 +0100 Joe Damato wrote:
> > > On Thu, Aug 29, 2024 at 03:31:05PM -0700, Jakub Kicinski wrote:
> > > > On Thu, 29 Aug 2024 13:12:01 +0000 Joe Damato wrote:  
> > > > > +      doc: Set configurable NAPI instance settings.  
> > > > 
> > > > We should pause and think here how configuring NAPI params should
> > > > behave. NAPI instances are ephemeral, if you close and open the
> > > > device (or for some drivers change any BPF or ethtool setting)
> > > > the NAPIs may get wiped and recreated, discarding all configuration.
> > > > 
> > > > This is not how the sysfs API behaves, the sysfs settings on the device
> > > > survive close. It's (weirdly?) also not how queues behave, because we
> > > > have struct netdev{_rx,}_queue to store stuff persistently. Even tho
> > > > you'd think queues are as ephemeral as NAPIs if not more.
> > > > 
> > > > I guess we can either document this, and move on (which may be fine,
> > > > you have more practical experience than me). Or we can add an internal
> > > > concept of a "channel" (which perhaps maybe if you squint is what
> > > > ethtool -l calls NAPIs?) or just "napi_storage" as an array inside
> > > > net_device and store such config there. For simplicity of matching
> > > > config to NAPIs we can assume drivers add NAPI instances in order. 
> > > > If driver wants to do something more fancy we can add a variant of
> > > > netif_napi_add() which specifies the channel/storage to use.
> > > > 
> > > > Thoughts? I may be overly sensitive to the ephemeral thing, maybe
> > > > I work with unfortunate drivers...  
> > > 
> > > Thanks for pointing this out. I think this is an important case to
> > > consider. Here's how I'm thinking about it.
> > > 
> > > There are two cases:
> > > 
> > > 1) sysfs setting is used by existing/legacy apps: If the NAPIs are
> > > discarded and recreated, the code I added to netif_napi_add_weight
> > > in patch 1 and 3 should take care of that case preserving how sysfs
> > > works today, I believe. I think we are good on this case ?
> > 
> > Agreed.
> > 
> > > 2) apps using netlink to set various custom settings. This seems
> > > like a case where a future extension can be made to add a notifier
> > > for NAPI changes (like the netdevice notifier?).
> > 
> > Yes, the notifier may help, but it's a bit of a stop gap / fallback.
> > 
> > > If you think this is a good idea, then we'd do something like:
> > >   1. Document that the NAPI settings are wiped when NAPIs are wiped
> > >   2. In the future (not part of this series) a NAPI notifier is
> > >      added
> > >   3. User apps can then listen for NAPI create/delete events
> > >      and update settings when a NAPI is created. It would be
> > >      helpful, I think, for user apps to know about NAPI
> > >      create/delete events in general because it means NAPI IDs are
> > >      changing.
> > > 
> > > One could argue:
> > > 
> > >   When wiping/recreating a NAPI for an existing HW queue, that HW
> > >   queue gets a new NAPI ID associated with it. User apps operating
> > >   at this level probably care about NAPI IDs changing (as it affects
> > >   epoll busy poll). Since the settings in this series are per-NAPI
> > >   (and not per HW queue), the argument could be that user apps need
> > >   to setup NAPIs when they are created and settings do not persist
> > >   between NAPIs with different IDs even if associated with the same
> > >   HW queue.
> > 
> > IDK if the fact that NAPI ID gets replaced was intentional in the first
> > place. I would venture a guess that the person who added the IDs was
> > working with NICs which have stable NAPI instances once the device is
> > opened. This is, unfortunately, not universally the case.
> > 
> > I just poked at bnxt, mlx5 and fbnic and all of them reallocate NAPIs
> > on an open device. Closer we get to queue API the more dynamic the whole
> > setup will become (read: the more often reconfigurations will happen).
> >
> 
> [...]
> 
> > > I think you have much more practical experience when it comes to
> > > dealing with drivers, so I am happy to follow your lead on this one,
> > > but assuming drivers will "do a thing" seems mildly scary to me with
> > > limited driver experience.
> > > 
> > > My two goals with this series are:
> > >   1. Make it possible to set these values per NAPI
> > >   2. Unblock the IRQ suspension series by threading the suspend
> > >      parameter through the code path carved in this series
> > > 
> > > So, I'm happy to proceed with this series as you prefer whether
> > > that's documentation or "napi_storage"; I think you are probably the
> > > best person to answer this question :)
> > 
> > How do you feel about making this configuration opt-in / require driver
> > changes? What I'm thinking is that having the new "netif_napi_add()"
> > variant (or perhaps extending netif_napi_set_irq()) to take an extra
> > "index" parameter would make the whole thing much simpler.
> 
> What about extending netif_queue_set_napi instead? That function
> takes a napi and a queue index.
> 
> Locally I kinda of hacked up something simple that:
>   - Allocates napi_storage in net_device in alloc_netdev_mqs
>   - Modifies netif_queue_set_napi to:
>      if (napi)
>        napi->storage = dev->napi_storage[queue_index];
> 
> I think I'm still missing the bit about the
> max(rx_queues,tx_queues), though :(
> 
> > Index would basically be an integer 0..n, where n is the number of
> > IRQs configured for the driver. The index of a NAPI instance would
> > likely match the queue ID of the queue the NAPI serves.
> 
> Hmmm. I'm hesitant about the "number of IRQs" part. What if there
> are NAPIs for which no IRQ is allocated ~someday~ ?
> 
> It seems like (I could totally be wrong) that netif_queue_set_napi
> can be called and work and create the association even without an
> IRQ allocated.
> 
> I guess the issue is mostly the queue index question above: combined
> rx/tx vs drivers having different numbers of rx and tx queues.
> 
> > We can then allocate an array of "napi_configs" in net_device -
> > like we allocate queues, the array size would be max(num_rx_queue,
> > num_tx_queues). We just need to store a couple of ints so it will
> > be tiny compared to queue structs, anyway.
> > 
> > The NAPI_SET netlink op can then work based on NAPI index rather 
> > than the ephemeral NAPI ID. It can apply the config to all live
> > NAPI instances with that index (of which there really should only 
> > be one, unless driver is mid-reconfiguration somehow but even that
> > won't cause issues, we can give multiple instances the same settings)
> > and also store the user config in the array in net_device.
> > 
> > When new NAPI instance is associate with a NAPI index it should get
> > all the config associated with that index applied.
> > 
> > Thoughts? Does that makes sense, and if so do you think it's an
> > over-complication?
> 
> I think what you are proposing seems fine; I'm just working out the
> implementation details and making sure I understand before sending
> another revision.

What if instead of an extra storage index in UAPI, we make napi_id persistent?
Then we can keep using napi_id as a user-facing number for the configuration.

Having a stable napi_id would also be super useful for the epoll setup so you
don't have to match old/invalid ids to the new ones on device reset.

In the code, we can keep the same idea with napi_storage in netdev and
ask drivers to provide storage id, but keep that id internal.

The only complication with that is napi_hash_add/napi_hash_del that
happen in netif_napi_add_weight. So for the devices that allocate
new napi before removing the old ones (most devices?), we'd have to add
some new netif_napi_takeover(old_napi, new_napi) to remove the
old napi_id from the hash and reuse it in the new one.

So for mlx5, the flow would look like the following:

- mlx5e_safe_switch_params
  - mlx5e_open_channels
    - netif_napi_add(new_napi)
      - adds napi with 'ephemeral' napi id
  - mlx5e_switch_priv_channels
    - mlx5e_deactivate_priv_channels
      - napi_disable(old_napi)
      - netif_napi_del(old_napi) - this frees the old napi_id
  - mlx5e_activate_priv_channels
    - mlx5e_activate_channels
      - mlx5e_activate_channel
        - netif_napi_takeover(old_napi is gone, so probably take id from napi_storage?)
	  - if napi is not hashed - safe to reuse?
	- napi_enable

This is a bit ugly because we still have random napi ids during reset, but
is not super complicated implementation-wise. We can eventually improve
the above by splitting netif_napi_add_weight into two steps: allocate and
activate (to do the napi_id allocation & hashing). Thoughts?

