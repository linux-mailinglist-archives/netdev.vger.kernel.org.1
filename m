Return-Path: <netdev+bounces-241989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A18C8B680
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CA2D35681B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EA727F4CE;
	Wed, 26 Nov 2025 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ut7db16c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdM05r3y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEB921CC51
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764180977; cv=none; b=PMhfn90sZeHtKd91Sqk3Yjkrjvmpgzip3UBwOjYbbGOv/YCb/kE8W6miOz4OjoCvdbyDvy6a0alO469jGg1ypBD0jFWdMcEw45OkIY0+8YAG3XxKeaX2q4ehOulyeYab6Cs3zK7NACXHRC+mh/AXy3p+oxb4LnnFILfpFS06ux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764180977; c=relaxed/simple;
	bh=kyULVipYGXF8pQ4S/uAyjcoQp2UuofAj8by9h0Na7sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ii8egU7PxjQNG0rSBFxVv+m/PMjevZ8doWqj+3Xn86G1hEimYxCEMvZbbXtCSFuVI75Fjr6m14oN770gXux7RdFuYVztofQMgBP+V57qZoqtE9EkwhzXJTm+LXhH81/bXYNR/aI5UYRQi0F2NHoq0Bocsqi+B+BMqSyxabDzUnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ut7db16c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IdM05r3y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764180974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qZzdcbGa6XCDNLwt3NmSWbQLiICgwvwTMHTS5/gnpeU=;
	b=Ut7db16cA7rloEIP5c/6eFeTRVaEjy4hS0C7ke4K8lF7pPqPkefHrR0oyAo0ir9GMu55OS
	2TMfRd2jcCVNm8Kwha0jmaU1SDXJqI2GaJxGb5t1+XHgARvB6RdhG9iH4KO7b8hJvqe0SV
	2GJwGMD2JVB9w675GTFCR/YhNKhiBMY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-74p38tVJPVOVJyWZ4MFIrw-1; Wed, 26 Nov 2025 13:16:12 -0500
X-MC-Unique: 74p38tVJPVOVJyWZ4MFIrw-1
X-Mimecast-MFC-AGG-ID: 74p38tVJPVOVJyWZ4MFIrw_1764180971
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477939321e6so49315e9.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 10:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764180970; x=1764785770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZzdcbGa6XCDNLwt3NmSWbQLiICgwvwTMHTS5/gnpeU=;
        b=IdM05r3yRfxBby5yj1dFGE8cUsBUC8iPzGR3l1pAMd5j/bDTGwNbyz6QXA9ujIzQl4
         KkcVIyJAVliscfVuaj6fzfskwkBr0SzIrjpY872N3jjPLMQjko5VaBYCtRPf51lmtmVz
         e37kZpzPHMwanXxYbTgQvbLr+qVManvnDgmtRkIG50rCouxH+EUv/RiGjF/X8AA7eYpG
         XYtMf6un7KrRZeFYQv7h5nzPDsF1q/IOXVY6mWLYrcGtP4Njyw3/fxHNZJ8DnnjSb7os
         3/C9qsVRPjm8SbBF1jDSfwKVY6h53RQ+YokmPJL/GIVdoSgFlue2ta4hQQjNXQDhb+WH
         JMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764180971; x=1764785771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZzdcbGa6XCDNLwt3NmSWbQLiICgwvwTMHTS5/gnpeU=;
        b=BhesgICzDGrEfD3bOiZcDy4b5mcLf3wk+PwA4PUbcaHfCP+BZ12g94t4goLKM3I8Qs
         C2ivBJhi6hp/h9F9NVPCVeZksDug1pVDMxMqqVy8jKXKADbq9HpT3AOOPOhxDr8tOctQ
         X2i9CafouptfRqpOxpAARfsNq0U5pTxmlFNnK9zdHqI+QhjVn3fzlSKKXl6lzUwWiYf0
         U2Q7+PLKmKcJKBd8MWvAuuzCpfhDSpkZb8jUmVt/t3FVyyJnMD87TFF8L6FTgStBqGdM
         z3V8hlONp3JoFLMIsr2/bdb3c5NR00h+HECkRHfd/1ox0I1J1DOaqAWyaVLo3TPIK4ZU
         7a3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgFCxbdX8r4rSRoV5pwkomGT6RqRH4Qb+1i0sCiEZH/NqmvGVE8+yDfsp6uQzgn31UJaERsxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyGau6Pp6dghX/9NKuRp5A0a8WP4WrzPsMRZyuLxaxhJdd0Ww
	LJZXGFo0o8yt30gEseEdCfVOubawpiXpgWDHLNRSEYIvGSzT9dBIJUSKQURK13MFr1vMxJYIjbM
	shuTaP5X0T3FG/ds/V9TV/tu/EaE76Vhf9jkYNyfkc9T203aUGERbm6w3Jg==
X-Gm-Gg: ASbGnctQEY2/IzfcUgm2k08yobvTLQ7+t4LDhv1nDp0yCZJfXySmex3DUxQVI3S527N
	8/PEjK2WrSwVd8VrNGt9s8IGv42BzUZslRhtYKUcqfqksBSOrJcAiD1v8ksM18A7KjfSZ4O8AoR
	VCSl6b83EDVV9b4x966aRoj+FbaXbkhqfyIk3nx7WTMWNfRGiKf5r5AZQXy3N77HFFO8bzUy7mj
	7E6HE7b93r6lJfVkgO7UnpueHGRui5Dcl/3ILnKTuOeB9Udb0C3zKdLRoFyfPUW8pZ56i7d85vu
	HQ5OMYrSRnDETiZKF8LI3OHe1VLlQkodJXacaE5BlHBiGiBAYCSB2ME3Q6QAPBqITOEM6VoWTnv
	TWBKBaVE9XnnJxto1hUzOKyBNGQG0jQ==
X-Received: by 2002:a05:600c:5252:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-47904b248demr87345775e9.31.1764180970580;
        Wed, 26 Nov 2025 10:16:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgRL93Ppj04AXVDEje5Q42qgkdWU1MdkDElxcXzRopk1GruOFcZ+Ewr6pGrw/CAbF8TMGXHA==
X-Received: by 2002:a05:600c:5252:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-47904b248demr87345385e9.31.1764180970053;
        Wed, 26 Nov 2025 10:16:10 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e598sm41453547f8f.4.2025.11.26.10.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 10:16:09 -0800 (PST)
Date: Wed, 26 Nov 2025 13:16:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	jon@nutanix.com, tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v6 3/8] tun/tap: add synchronized ring
 produce/consume with queue management
Message-ID: <20251126130226-mutt-send-email-mst@kernel.org>
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <20251120152914.1127975-4-simon.schippers@tu-dortmund.de>
 <20251125100655-mutt-send-email-mst@kernel.org>
 <4db234bd-ebd7-4325-9157-e74eccb58616@tu-dortmund.de>
 <20251126100007-mutt-send-email-mst@kernel.org>
 <c0fc512a-5bee-48da-9dfb-2b8101f3dec6@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0fc512a-5bee-48da-9dfb-2b8101f3dec6@tu-dortmund.de>

On Wed, Nov 26, 2025 at 05:04:25PM +0100, Simon Schippers wrote:
> On 11/26/25 16:25, Michael S. Tsirkin wrote:
> > On Wed, Nov 26, 2025 at 10:23:50AM +0100, Simon Schippers wrote:
> >> On 11/25/25 17:54, Michael S. Tsirkin wrote:
> >>> On Thu, Nov 20, 2025 at 04:29:08PM +0100, Simon Schippers wrote:
> >>>> Implement new ring buffer produce and consume functions for tun and tap
> >>>> drivers that provide lockless producer-consumer synchronization and
> >>>> netdev queue management to prevent ptr_ring tail drop and permanent
> >>>> starvation.
> >>>>
> >>>> - tun_ring_produce(): Produces packets to the ptr_ring with proper memory
> >>>>   barriers and proactively stops the netdev queue when the ring is about
> >>>>   to become full.
> >>>>
> >>>> - __tun_ring_consume() / __tap_ring_consume(): Internal consume functions
> >>>>   that check if the netdev queue was stopped due to a full ring, and wake
> >>>>   it when space becomes available. Uses memory barriers to ensure proper
> >>>>   ordering between producer and consumer.
> >>>>
> >>>> - tun_ring_consume() / tap_ring_consume(): Wrapper functions that acquire
> >>>>   the consumer lock before calling the internal consume functions.
> >>>>
> >>>> Key features:
> >>>> - Proactive queue stopping using __ptr_ring_full_next() to stop the queue
> >>>>   before it becomes completely full.
> >>>> - Not stopping the queue when the ptr_ring is full already, because if
> >>>>   the consumer empties all entries in the meantime, stopping the queue
> >>>>   would cause permanent starvation.
> >>>
> >>> what is permanent starvation? this comment seems to answer this
> >>> question:
> >>>
> >>>
> >>> 	/* Do not stop the netdev queue if the ptr_ring is full already.
> >>> 	 * The consumer could empty out the ptr_ring in the meantime
> >>> 	 * without noticing the stopped netdev queue, resulting in a
> >>> 	 * stopped netdev queue and an empty ptr_ring. In this case the
> >>> 	 * netdev queue would stay stopped forever.
> >>> 	 */
> >>>
> >>>
> >>> why having a single entry in
> >>> the ring we never use helpful to address this?
> >>>
> >>>
> >>>
> >>>
> >>> In fact, all your patch does to solve it, is check
> >>> netif_tx_queue_stopped on every consumed packet.
> >>>
> >>>
> >>> I already proposed:
> >>>
> >>> static inline int __ptr_ring_peek_producer(struct ptr_ring *r)
> >>> {
> >>>         if (unlikely(!r->size) || r->queue[r->producer])
> >>>                 return -ENOSPC;
> >>>         return 0;
> >>> }
> >>>
> >>> And with that, why isn't avoiding the race as simple as
> >>> just rechecking after stopping the queue?
> >>  
> >> I think you are right and that is quite similar to what veth [1] does.
> >> However, there are two differences:
> >>
> >> - Your approach avoids returning NETDEV_TX_BUSY by already stopping
> >>   when the ring becomes full (and not when the ring is full already)
> >> - ...and the recheck of the producer wakes on !full instead of empty.
> >>
> >> I like both aspects better than the veth implementation.
> > 
> > Right.
> > 
> > Though frankly, someone should just fix NETDEV_TX_BUSY already
> > at least with the most popular qdiscs.
> > 
> > It is a common situation and it is just annoying that every driver has
> > to come up with its own scheme.
> 
> I can not judge it, but yes, it would have made this patchset way
> simpler.
> 
> > 
> > 
> > 
> > 
> > 
> >> Just one thing: like the veth implementation, we probably need a
> >> smp_mb__after_atomic() after netif_tx_stop_queue() as they also discussed
> >> in their v6 [2].
> > 
> > yea makes sense.
> > 
> >>
> >> On the consumer side, I would then just do:
> >>
> >> __ptr_ring_consume();
> >> if (unlikely(__ptr_ring_consume_created_space()))
> >>     netif_tx_wake_queue(txq);
> >>
> >> Right?
> >>
> >> And for the batched consume method, I would just call this in a loop.
> > 
> > Well tun does not use batched consume does it?
> 
> tun does not but vhost-net does.
> 
> Since vhost-net also uses tun_net_xmit() as its ndo_start_xmit in a
> tap+vhost-net setup, its consumer must also be changed. Else
> tun_net_xmit() would stop the queue, but it would never be woken again.


Ah, ok.



> > 
> > 
> >> Thank you!
> >>
> >> [1] Link: https://lore.kernel.org/netdev/174559288731.827981.8748257839971869213.stgit@firesoul/T/#m2582fcc48901e2e845b20b89e0e7196951484e5f
> >> [2] Link: https://lore.kernel.org/all/174549933665.608169.392044991754158047.stgit@firesoul/T/#m63f2deb86ffbd9ff3a27e1232077a3775606c14d
> >>
> >>>
> >>> __ptr_ring_produce();
> >>> if (__ptr_ring_peek_producer())
> >>> 	netif_tx_stop_queue
> >>
> >> smp_mb__after_atomic(); // Right here
> >>
> >>> 	if (!__ptr_ring_peek_producer())
> >>> 		netif_tx_wake_queue(txq);
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> > 


