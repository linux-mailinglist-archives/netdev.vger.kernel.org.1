Return-Path: <netdev+bounces-125649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507EC96E0C8
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DE51C23E71
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C95E1A0AF3;
	Thu,  5 Sep 2024 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ns4JRVdx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA841A0737
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555908; cv=none; b=ui1+9QJUT55TF789C9Xdt7Ugfr2FGtSeuTKtHSZXYzWGYIHvDFlWsTXyP6KpF8/s0cC/evUa1qijZ/EYxqpp7/hzA2Uxm7emi7Qf2VQ7zOZHwi2sWZC42UTpkv9RvXoAlmT5E5V/++fSo3KhQCuzTwZrraf7yhmi7pEz7Mzq4aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555908; c=relaxed/simple;
	bh=jHDgMHr03VVzHhUG+OiLt/Kh1d1XiMSt/x5DRTggc1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FH8uqxhBlFceVE43GaJx0qudGjLpNrHvqLh/73lxlDdlIYL4ebjvcmVJqJfAPF7ws6gxw1Rb7bIrrCA9m32sBJCR6KqA90xNc/kRluVtf2RDWewZy4LZt90RZVAI4pFVergoq446HJtT/1zwb2Y5kuCVhnVoHngXwjr0KKj/8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ns4JRVdx; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374ba74e9b6so785410f8f.0
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725555904; x=1726160704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIKUfIudnC68dpnre//nTRJxjNKVnEXJEwPgKoRrffU=;
        b=ns4JRVdxwXTLmq7pqL4FxHU+FIKQ//R+NAq/X1N29HOPqqdYDQ518GkTdyXM8yCYDA
         DMip4xr7oDFl5vYlXdqmznS2rT9Qd8tQmxNncXtS7ygF0igVGy/mY3oaHCxIV5+FiATq
         /OWUpO8oRvD2ngfBPKhsfABWoXo3INPX/2td8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725555904; x=1726160704;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIKUfIudnC68dpnre//nTRJxjNKVnEXJEwPgKoRrffU=;
        b=Nf1sPQ4P92wPUMQtubnUI1RmKROyZassmoRd+QqnoFQTRqTA7wIb6hG5/xvCLUyE4A
         chdvgl81TYSYufR97/jS5SKQQMjdTmtACrR6oK+w3ks7u61shegDFTvhiqWDORmsUy8d
         s1jQ9+VxlJqCb/FdWkpNbd1QeFn/QhqmUph8hVVm1lymExlc976RAXz1aR32mnxmzRAK
         F2PJTcq3516+UyzgB6PKWMv3y7fLBossOzzZK+JhH2/Fy4VoXGrUytt5bpO5XU/a/l9p
         zHSuoR+v5J0JLB6iOZ7LGDc5HxMliDh9YFLP088CfxmyNg67kQqhCNeIQln+l1kGUHAW
         5CGw==
X-Forwarded-Encrypted: i=1; AJvYcCVulIwdpJvix/bM1A0UULIdyFsYKJPK6iJ8Hc3jWmjP6XRQchIgTlKYXaJkeUdbfe0WY5X0thU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnJ6ncZVf0BK9hCVEv1iADeE7N9gqPTP/FK9EeL79FjhsV7kir
	iifuHdk6BvXTGOlapoOefsQFq2tZtI1rTfqOQr+AQ6aF6cr1ppuiibo49lmhlqs=
X-Google-Smtp-Source: AGHT+IHYidanxyBEjM0ZNE63RtTsWntOoSNW5LAz9Suq28Jzmb1y3o8MA/42TcvXxX0SR1jd6CU6gg==
X-Received: by 2002:adf:f1c8:0:b0:374:c948:f4db with SMTP id ffacd0b85a97d-374c948f50amr12319780f8f.26.1725555903829;
        Thu, 05 Sep 2024 10:05:03 -0700 (PDT)
Received: from LQ3V64L9R2 (net-2-42-195-208.cust.vodafonedsl.it. [2.42.195.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c11eeea6sm14421116f8f.52.2024.09.05.10.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 10:05:03 -0700 (PDT)
Date: Thu, 5 Sep 2024 19:05:01 +0200
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <ZtnkvTA2_eE0po9N@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>,
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
 <ZtXuJ3TMp9cN5e9h@LQ3V64L9R2.station>
 <Ztjv-dgNFwFBnXwd@mini-arch>
 <Ztl6HvkMzu9-7CQJ@LQ3V64L9R2>
 <Ztniy_Yo_u_nXMLT@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztniy_Yo_u_nXMLT@mini-arch>

On Thu, Sep 05, 2024 at 09:56:43AM -0700, Stanislav Fomichev wrote:
> On 09/05, Joe Damato wrote:
> > On Wed, Sep 04, 2024 at 04:40:41PM -0700, Stanislav Fomichev wrote:
> > > On 09/02, Joe Damato wrote:
> > > > On Fri, Aug 30, 2024 at 02:22:35PM -0700, Jakub Kicinski wrote:
> > > > > On Fri, 30 Aug 2024 11:43:00 +0100 Joe Damato wrote:
> > > > > > On Thu, Aug 29, 2024 at 03:31:05PM -0700, Jakub Kicinski wrote:
> > > > > > > On Thu, 29 Aug 2024 13:12:01 +0000 Joe Damato wrote:  
> > > > > > > > +      doc: Set configurable NAPI instance settings.  
> > > > > > > 
> > > > > > > We should pause and think here how configuring NAPI params should
> > > > > > > behave. NAPI instances are ephemeral, if you close and open the
> > > > > > > device (or for some drivers change any BPF or ethtool setting)
> > > > > > > the NAPIs may get wiped and recreated, discarding all configuration.
> > > > > > > 
> > > > > > > This is not how the sysfs API behaves, the sysfs settings on the device
> > > > > > > survive close. It's (weirdly?) also not how queues behave, because we
> > > > > > > have struct netdev{_rx,}_queue to store stuff persistently. Even tho
> > > > > > > you'd think queues are as ephemeral as NAPIs if not more.
> > > > > > > 
> > > > > > > I guess we can either document this, and move on (which may be fine,
> > > > > > > you have more practical experience than me). Or we can add an internal
> > > > > > > concept of a "channel" (which perhaps maybe if you squint is what
> > > > > > > ethtool -l calls NAPIs?) or just "napi_storage" as an array inside
> > > > > > > net_device and store such config there. For simplicity of matching
> > > > > > > config to NAPIs we can assume drivers add NAPI instances in order. 
> > > > > > > If driver wants to do something more fancy we can add a variant of
> > > > > > > netif_napi_add() which specifies the channel/storage to use.
> > > > > > > 
> > > > > > > Thoughts? I may be overly sensitive to the ephemeral thing, maybe
> > > > > > > I work with unfortunate drivers...  
> > > > > > 
> > > > > > Thanks for pointing this out. I think this is an important case to
> > > > > > consider. Here's how I'm thinking about it.
> > > > > > 
> > > > > > There are two cases:
> > > > > > 
> > > > > > 1) sysfs setting is used by existing/legacy apps: If the NAPIs are
> > > > > > discarded and recreated, the code I added to netif_napi_add_weight
> > > > > > in patch 1 and 3 should take care of that case preserving how sysfs
> > > > > > works today, I believe. I think we are good on this case ?
> > > > > 
> > > > > Agreed.
> > > > > 
> > > > > > 2) apps using netlink to set various custom settings. This seems
> > > > > > like a case where a future extension can be made to add a notifier
> > > > > > for NAPI changes (like the netdevice notifier?).
> > > > > 
> > > > > Yes, the notifier may help, but it's a bit of a stop gap / fallback.
> > > > > 
> > > > > > If you think this is a good idea, then we'd do something like:
> > > > > >   1. Document that the NAPI settings are wiped when NAPIs are wiped
> > > > > >   2. In the future (not part of this series) a NAPI notifier is
> > > > > >      added
> > > > > >   3. User apps can then listen for NAPI create/delete events
> > > > > >      and update settings when a NAPI is created. It would be
> > > > > >      helpful, I think, for user apps to know about NAPI
> > > > > >      create/delete events in general because it means NAPI IDs are
> > > > > >      changing.
> > > > > > 
> > > > > > One could argue:
> > > > > > 
> > > > > >   When wiping/recreating a NAPI for an existing HW queue, that HW
> > > > > >   queue gets a new NAPI ID associated with it. User apps operating
> > > > > >   at this level probably care about NAPI IDs changing (as it affects
> > > > > >   epoll busy poll). Since the settings in this series are per-NAPI
> > > > > >   (and not per HW queue), the argument could be that user apps need
> > > > > >   to setup NAPIs when they are created and settings do not persist
> > > > > >   between NAPIs with different IDs even if associated with the same
> > > > > >   HW queue.
> > > > > 
> > > > > IDK if the fact that NAPI ID gets replaced was intentional in the first
> > > > > place. I would venture a guess that the person who added the IDs was
> > > > > working with NICs which have stable NAPI instances once the device is
> > > > > opened. This is, unfortunately, not universally the case.
> > > > > 
> > > > > I just poked at bnxt, mlx5 and fbnic and all of them reallocate NAPIs
> > > > > on an open device. Closer we get to queue API the more dynamic the whole
> > > > > setup will become (read: the more often reconfigurations will happen).
> > > > >
> > > > 
> > > > [...]
> > > > 
> > > > > > I think you have much more practical experience when it comes to
> > > > > > dealing with drivers, so I am happy to follow your lead on this one,
> > > > > > but assuming drivers will "do a thing" seems mildly scary to me with
> > > > > > limited driver experience.
> > > > > > 
> > > > > > My two goals with this series are:
> > > > > >   1. Make it possible to set these values per NAPI
> > > > > >   2. Unblock the IRQ suspension series by threading the suspend
> > > > > >      parameter through the code path carved in this series
> > > > > > 
> > > > > > So, I'm happy to proceed with this series as you prefer whether
> > > > > > that's documentation or "napi_storage"; I think you are probably the
> > > > > > best person to answer this question :)
> > > > > 
> > > > > How do you feel about making this configuration opt-in / require driver
> > > > > changes? What I'm thinking is that having the new "netif_napi_add()"
> > > > > variant (or perhaps extending netif_napi_set_irq()) to take an extra
> > > > > "index" parameter would make the whole thing much simpler.
> > > > 
> > > > What about extending netif_queue_set_napi instead? That function
> > > > takes a napi and a queue index.
> > > > 
> > > > Locally I kinda of hacked up something simple that:
> > > >   - Allocates napi_storage in net_device in alloc_netdev_mqs
> > > >   - Modifies netif_queue_set_napi to:
> > > >      if (napi)
> > > >        napi->storage = dev->napi_storage[queue_index];
> > > > 
> > > > I think I'm still missing the bit about the
> > > > max(rx_queues,tx_queues), though :(
> > > > 
> > > > > Index would basically be an integer 0..n, where n is the number of
> > > > > IRQs configured for the driver. The index of a NAPI instance would
> > > > > likely match the queue ID of the queue the NAPI serves.
> > > > 
> > > > Hmmm. I'm hesitant about the "number of IRQs" part. What if there
> > > > are NAPIs for which no IRQ is allocated ~someday~ ?
> > > > 
> > > > It seems like (I could totally be wrong) that netif_queue_set_napi
> > > > can be called and work and create the association even without an
> > > > IRQ allocated.
> > > > 
> > > > I guess the issue is mostly the queue index question above: combined
> > > > rx/tx vs drivers having different numbers of rx and tx queues.
> > > > 
> > > > > We can then allocate an array of "napi_configs" in net_device -
> > > > > like we allocate queues, the array size would be max(num_rx_queue,
> > > > > num_tx_queues). We just need to store a couple of ints so it will
> > > > > be tiny compared to queue structs, anyway.
> > > > > 
> > > > > The NAPI_SET netlink op can then work based on NAPI index rather 
> > > > > than the ephemeral NAPI ID. It can apply the config to all live
> > > > > NAPI instances with that index (of which there really should only 
> > > > > be one, unless driver is mid-reconfiguration somehow but even that
> > > > > won't cause issues, we can give multiple instances the same settings)
> > > > > and also store the user config in the array in net_device.
> > > > > 
> > > > > When new NAPI instance is associate with a NAPI index it should get
> > > > > all the config associated with that index applied.
> > > > > 
> > > > > Thoughts? Does that makes sense, and if so do you think it's an
> > > > > over-complication?
> > > > 
> > > > I think what you are proposing seems fine; I'm just working out the
> > > > implementation details and making sure I understand before sending
> > > > another revision.
> > > 
> > > What if instead of an extra storage index in UAPI, we make napi_id persistent?
> > > Then we can keep using napi_id as a user-facing number for the configuration.
> > > 
> > > Having a stable napi_id would also be super useful for the epoll setup so you
> > > don't have to match old/invalid ids to the new ones on device reset.
> > 
> > Up to now for prototyping purposes: the way I've been dealing with this is
> > using a SO_ATTACH_REUSEPORT_CBPF program like this:
> > 
> > struct sock_filter code[] = {
> >     /* A = skb->queue_mapping */
> >     { BPF_LD | BPF_W | BPF_ABS, 0, 0, SKF_AD_OFF + SKF_AD_QUEUE },
> >     /* A = A % n */
> >     { BPF_ALU | BPF_MOD, 0, 0, n },
> >     /* return A */
> >     { BPF_RET | BPF_A, 0, 0, 0 },
> > };
> > 
> > with SO_BINDTODEVICE. Note that the above uses queue_mapping (not NAPI ID) so
> > even if the NAPI IDs change the filter still distributes connections from the
> > same "queue_mapping" to the same thread.
> > 
> > Since epoll busy poll is based on NAPI ID (and not queue_mapping), this will
> > probably cause some issue if the NAPI ID changes because the NAPI ID associated
> > with the epoll context will suddenly change meaning the "old" NAPI won't be
> > busy polled. This might be fine because if that happens the old NAPI is being
> > disabled anyway?
> > 
> > At any rate the user program doesn't "need" to do anything when the NAPI ID
> > changes... unless it has a more complicated ebpf program that relies on NAPI ID
> > ;)
> 
> Ah, you went a more creative route. We were doing SO_INCOMING_NAPI_ID on
> a single listener and manually adding fds to the appropriate epoll.
> But regardless of the method, having a stable napi_id is still good
> to have and hopefully it's not a lot of work compared to exposing
> extra napi storage id to the userspace.

Yes, your approach makes sense, as well. With a single acceptor
thread I'd also do what you are doing.

I was essentially modifying an existing REUSEPORT user app that one
app listens on all interfaces, so BINDTODEVICE + queue_mapping bpf
filter was the only way (that I could find) to make the NAPI ID
based polling work.

