Return-Path: <netdev+bounces-123986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA2A9672CE
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 19:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1628B21849
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 17:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE0E55E48;
	Sat, 31 Aug 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="rDGKrm7K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F60282FC
	for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725125271; cv=none; b=nY3YoOYdbCH4mFE77U3jRvLqb8gF2QEpDt/yjgJMa9i4yz4l5yMa5G2eZtpwHSfhnYvl3jLPJkYa6hXXcCMXxY4VYhmQE6Q88EoItptbNBNT8po71ZbADapH9x726mOLTC0mY5oUhGVr9qMWcD517EFkeFHCtlaqwp4s+iv6Tbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725125271; c=relaxed/simple;
	bh=tgBgHElHU/JQNeOUlFyZ8i9x9/58/6NrE7QX8ETtCms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYYp+RS0TxLuCzKGjF+IJ6pdJG/Y0wYQJzu1uOxqISQVLPhUpY2cQ76HEzpOkJOmyEZGZumbvtTRiaVMkGm40d635hogDO+ZdtyRUQAEyEBxYbQBWW2tpcfg7CGba2Ny+p8O7WIOkcR91ZoQtd0fbUN5OhDRTrBqS86rZcBNLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=rDGKrm7K; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367990aaef3so1729238f8f.0
        for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 10:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725125267; x=1725730067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZ0YVbwHufs3vIExxpLzmbWF9hyInLnZlv53BHalC/g=;
        b=rDGKrm7KhBbLfdriH0gzL8j+iMqI66dfb0G0dgqcPvkLOPJsHoSsBz+p+yq/r6Z6n/
         CD6tWeOvafxR4OTEcfesGUp3T6g3mTgevPB6oI0/xGGtor5JCCRbq5q0VfXN+Up7/VIz
         GA6Xe6bdfvJTfZbtNh7y3FAHwj+1ycHVTQh4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725125267; x=1725730067;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ0YVbwHufs3vIExxpLzmbWF9hyInLnZlv53BHalC/g=;
        b=RLm06jOM3/jYT8SkmY1slaK/2JUajPiIrMX3vjAIyvdZHusYf6EV8DVpZFi0JKSKnp
         rCcdE0/NjOPzWRU1B/03ie3uAjHSnS+BdQA7+R8e+mz+GMyspJwmlFXUc7iJEt2Xkv/A
         jPzVf6U4HgmHwoRL6YhrXpnB3GtIUGVcd5YgbUHHscIf9+hHvxbV+2gVqqoybgz6XSbk
         Mc+2Tww8Dw9r2kWovjmoOzQNJzJbcJ/utIH9l60fAYnezIaVIqFVdBn2VmsDvTH0ZNt4
         c6kWiTzJE0AS7jT35K+9QBdM/xtGQ7mUQDsPFEw6VOo4rVOxQGhpba4GSKyp4D4YApuK
         DEIQ==
X-Gm-Message-State: AOJu0YxZ8nWZMbvl6/q1fiTLGWIDIeSjSISS9rw+zO6UV7wGwj20/+hn
	wdHvlxlp5kS57bexSPG35hNeNBqMvriHWnfEEbAb/Y0tlGWQJ3HFURsdOBKh4QE=
X-Google-Smtp-Source: AGHT+IEu6xJYOajULga49j5jdi/y1J2EqWMsOEaH4T9o806yQC51Dg/gOzbzxy7fItKCeBwhDtYchQ==
X-Received: by 2002:a5d:6188:0:b0:367:bb20:b3e1 with SMTP id ffacd0b85a97d-3749b585e8cmr6450024f8f.51.1725125266848;
        Sat, 31 Aug 2024 10:27:46 -0700 (PDT)
Received: from LQ3V64L9R2 ([185.226.39.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b6f7ef8esm3891341f8f.8.2024.08.31.10.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 10:27:46 -0700 (PDT)
Date: Sat, 31 Aug 2024 18:27:45 +0100
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
Message-ID: <ZtNSkWa1G40jRX5N@LQ3V64L9R2>
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
> > > > +	napi = napi_by_id(napi_id);
> > > > +	if (napi)
> > > > +		err = netdev_nl_napi_set_config(napi, info);
> > > > +	else
> > > > +		err = -EINVAL;  
> > > 
> > > if (napi) {
> > > ...
> > > } else {
> > > 	NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID])
> > > 	err = -ENOENT;
> > > }  
> > 
> > Thanks, I'll make that change in the v2.
> > 
> > Should I send a Fixes for the same pattern in
> > netdev_nl_napi_get_doit ?
> 
> SG, standalone patch is good, FWIW, no need to add to the series.

Done. TBH: couldn't tell if it was a fixes for net or a net-next
thing.
 
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
> > Admittedly, from the perspective of a user it would be nice if a new
> > NAPI created for an existing HW queue retained the previous
> > settings so that I, as the user, can do less work.
> > 
> > But, what happens if a HW queue is destroyed and recreated? Will any
> > HW settings be retained? And does that have any influence on what we
> > do in software? See below.
> 
> Up to the driver, today. But settings we store in queue structs in 
> the core are not wiped.
> 
> > This part of your message:
> > 
> > > we can assume drivers add NAPI instances in order. If driver wants
> > > to do something more fancy we can add a variant of
> > > netif_napi_add() which specifies the channel/storage to use.  
> > 
> > assuming drivers will "do a thing", so to speak, makes me uneasy.
> 
> Yeah.. :(
> 
> > I started to wonder: how do drivers handle per-queue HW IRQ coalesce
> > settings when queue counts increase? It's a different, but adjacent
> > problem, I think.
> > 
> > I tried a couple experiments on mlx5 and got very strange results
> > suitable for their own thread and I didn't want to get this thread
> > too far off track.
> 
> Yes, but ethtool is an old shallow API from the times when semantics
> were simpler. It's precisely this mess which we try to avoid by storing
> more of the config in the core, in a consistent fashion.
> 
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

I think if we are going to go this way, then opt-in is probably the
way to go. This series would include the necessary changes for mlx5,
in that case (because that's what I have access to) so that the new
variant has a user?

> Index would basically be an integer 0..n, where n is the number of
> IRQs configured for the driver. The index of a NAPI instance would
> likely match the queue ID of the queue the NAPI serves.
> 
> We can then allocate an array of "napi_configs" in net_device -
> like we allocate queues, the array size would be max(num_rx_queue,
> num_tx_queues). We just need to store a couple of ints so it will
> be tiny compared to queue structs, anyway.

I assume napi_storage exists for both combined RX/TX NAPIs (i.e.
drivers that multiplex RX/TX on a single NAPI like mlx5) as well
as drivers which create NAPIs that are RX or TX-only, right?

If so, it seems like we'd either need to:
  - Do something more complicated when computing how much NAPI
    storage to make, or
  - Provide a different path for drivers which don't multiplex and
    create some number of (for example) TX-only NAPIs ?

I guess I'm just imagining a weird case where a driver has 8 RX
queues but 64 TX queues. max of that is 64, so we'd be missing 8
napi_storage ?

Sorry, I'm probably just missing something about the implementation
details you summarized above.

> The NAPI_SET netlink op can then work based on NAPI index rather 
> than the ephemeral NAPI ID. It can apply the config to all live
> NAPI instances with that index (of which there really should only 
> be one, unless driver is mid-reconfiguration somehow but even that
> won't cause issues, we can give multiple instances the same settings)
> and also store the user config in the array in net_device.

I understand what you are proposing. I suppose napi-get could be
extended to include the NAPI index, too?

Then users could map queues to NAPI indexes to queues (via NAPI ID)?

> When new NAPI instance is associate with a NAPI index it should get
> all the config associated with that index applied.
> 
> Thoughts? Does that makes sense, and if so do you think it's an
> over-complication?

It feels a bit tricky, to me, as it seems there are some edge cases
to be careful with (queue count change). I could probably give the
implementation a try and see where I end up.

Having these settings per-NAPI would be really useful and being able
to support IRQ suspension would be useful, too.

I think being thoughtful about how we get there is important; I'm a
little wary of getting side tracked, but I trust your judgement and
if you think this is worth exploring I'll think on it some more.

- Joe

