Return-Path: <netdev+bounces-241928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A6AC8AA08
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6125D3B078E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 15:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186433321C4;
	Wed, 26 Nov 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlPbdJim";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrFKSehg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186F331A51
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170755; cv=none; b=IaQM0TNmB/Z9Iq3es/v3By60Co85XimhTzNd7TXhPctFf0BfdeCE/02idIUosJAyq9jIFBtCBJX6CliynXf3DCArpONIFsRcpXHwLf6gLC8iS3YhwPYXjb6OlSScaGDIqT5PLLOA7S/VV34x7zCxBSDRORX8qF0ziFiy22IIgag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170755; c=relaxed/simple;
	bh=MlNy/atfOJbZCeA0q/MGoSHM0JWfj9pD6YlEmXsdmCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNsmLqX9L8KlzO3KxR+ydGgYuB3NEeF9QcZz7iCFMyBJz2J13ki64L8xD7XU8y02rKogcXH8wvCl/veWF51OSLp9LElLA1PUAseFUNn7jxsFx2AXHWTCYXuKrfCUmLvmOdjNAqzz5QhiRnSJ4IWrfL3IjUNeQvLVVvHzp8eD82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlPbdJim; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CrFKSehg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764170752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdOd/whsaB5ha6Xltts70lCb5PGc5f2tglKc7q062f4=;
	b=QlPbdJimjippuKa4JyrQxKtfkC5TlOoI+8bLgGwb6AryKJFBApO2SMcd5B4VPhb4lQmBU5
	EFX29A9bmG3B6qjURlHRcBxc42igiBoCASGO+mLOBtt3Ac0XY8lJxDadrb9hJDbULaOo8r
	TLjLIRJt7AlBYN/D3OQEtUjcoOEVH6I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-mNdyx8WKO_q5EJIIHYcSKQ-1; Wed, 26 Nov 2025 10:25:50 -0500
X-MC-Unique: mNdyx8WKO_q5EJIIHYcSKQ-1
X-Mimecast-MFC-AGG-ID: mNdyx8WKO_q5EJIIHYcSKQ_1764170750
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b3c965ce5so6246765f8f.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 07:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764170749; x=1764775549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IdOd/whsaB5ha6Xltts70lCb5PGc5f2tglKc7q062f4=;
        b=CrFKSehgTVATz5ItZ3SW5aIMvHYoe8RmV8ykOb+wphhtyd6jYk3JwjvcVP5LpU/vBV
         6vf6/+SmcGGExXk67kp1vuUIyCPFL3MR7wNn3jvH2x17yiML7NFG5VmZzq0AHG7BN3TL
         /+3zXLS2qaOFDMsqaqBzFLAhPBlTYz/EM99xszc598B/fuZzM9ea9qj79L+xjNISad5r
         eUxB8HtW4ZxYHccmBzymAOywYtFcurY6gOaBaFcRyAkdsI4Ly8UBzFVgKO/zJT6Ulyy2
         IYstD/lFXO3B5HowxI3AlwJq/DA3kbNY3ay8z7xxU+rYmg1PD8UPLUGvdnh/ylL8xY2d
         8ypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764170749; x=1764775549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdOd/whsaB5ha6Xltts70lCb5PGc5f2tglKc7q062f4=;
        b=lVSApjynjCusp0ug5EVmolgCIXoKtlF5GW0RKScYpi/etJ/NFDmatVjn1TQOpWdYwD
         zoMMpBYatM5MGPQQE5pnvBuKcxj0CsYDQ15aFLH4g0sqRy+oFj9tqTY0xMxV2otkVzLp
         R+lW2ZD3tzaaYA3+OSj1ldcIH22zn5hClB0RqRKxi3v5fPRbQeprrozvrCajxszJqRLh
         EY/tl/07TTojoZBFpzAEgVaUWr26yFdv3MecFstjh/NotbYR/lkucNQSGlhhsjGh8BmF
         r17iAtG9H8kbDYtyVnAv2DMho8oNRds6FkSzzFpOPIAdXeYH7vxgzx6wuQmRA2vu80ea
         e7vg==
X-Forwarded-Encrypted: i=1; AJvYcCVr0Vy3vSQotJUbQ9ZRiAGwQHgpnQe0zYP8cIFqKQglRW5v1FPLFam4FxhUXsbA2AKYL/bYE5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRqddsHgIAQvr2wDpBtZrV2K1UznSYsr4bM2VRVfZHnf0CXKEv
	H2i87b6Z4X00VJH6CVv4ItS3b4Yb/8b/BENWkwG33z2Z40ceSFL1DJpoKrccGMpaqhxXyrKqHW8
	aQzRRiIk94/scB9kznS7IG8JsvLU8LUby0h0ChZa+YjHYCf4IIuCv8EWXHw==
X-Gm-Gg: ASbGncsVHhk13/j6N1GAv86oSfSnhX56IOWrFNqxFP8wAy2sJJ4oLmeO7Kfs67zwcqC
	1EagnGNpQoXbez+fYveXbVK3A3OjZRB5ou+ygYTY81QCeU1buRaS8+Mp935Cnj9dMlsCbFAMxi6
	nO4k4HJR/qkRVAsDW2E563r2fkIfdEXtc/N7ARczX/bFIJw76LRVyUC0DMXK9eL0WVy9GyuIURl
	sRN3mQGNNnef47ztXLutLbG5COX1sXhlT2BjCZ85XvfukfZQ217IwEZAASx3t7IW+ylQD9Mg2WT
	lztJ+JGihfy8LJAdLT+eopkvVed//aBxnrfo4g8GlKwG5vTlWCcXWvTRLFSPS+lmB4joQsYwORQ
	54OXz3TsevAYiFH6W3vA1vRZKbAH5ug==
X-Received: by 2002:a05:6000:2489:b0:42b:3a84:1ee6 with SMTP id ffacd0b85a97d-42e0f22a2c8mr8023541f8f.24.1764170748937;
        Wed, 26 Nov 2025 07:25:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+KQvLghlDUQh9afZD+PVNCo1iNTuBYw29hyUe/fgigkK4QndBh9YrGoJcdMGDn9uA+ZGhNA==
X-Received: by 2002:a05:6000:2489:b0:42b:3a84:1ee6 with SMTP id ffacd0b85a97d-42e0f22a2c8mr8023493f8f.24.1764170748385;
        Wed, 26 Nov 2025 07:25:48 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e581sm38903906f8f.8.2025.11.26.07.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 07:25:47 -0800 (PST)
Date: Wed, 26 Nov 2025 10:25:44 -0500
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
Message-ID: <20251126100007-mutt-send-email-mst@kernel.org>
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <20251120152914.1127975-4-simon.schippers@tu-dortmund.de>
 <20251125100655-mutt-send-email-mst@kernel.org>
 <4db234bd-ebd7-4325-9157-e74eccb58616@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4db234bd-ebd7-4325-9157-e74eccb58616@tu-dortmund.de>

On Wed, Nov 26, 2025 at 10:23:50AM +0100, Simon Schippers wrote:
> On 11/25/25 17:54, Michael S. Tsirkin wrote:
> > On Thu, Nov 20, 2025 at 04:29:08PM +0100, Simon Schippers wrote:
> >> Implement new ring buffer produce and consume functions for tun and tap
> >> drivers that provide lockless producer-consumer synchronization and
> >> netdev queue management to prevent ptr_ring tail drop and permanent
> >> starvation.
> >>
> >> - tun_ring_produce(): Produces packets to the ptr_ring with proper memory
> >>   barriers and proactively stops the netdev queue when the ring is about
> >>   to become full.
> >>
> >> - __tun_ring_consume() / __tap_ring_consume(): Internal consume functions
> >>   that check if the netdev queue was stopped due to a full ring, and wake
> >>   it when space becomes available. Uses memory barriers to ensure proper
> >>   ordering between producer and consumer.
> >>
> >> - tun_ring_consume() / tap_ring_consume(): Wrapper functions that acquire
> >>   the consumer lock before calling the internal consume functions.
> >>
> >> Key features:
> >> - Proactive queue stopping using __ptr_ring_full_next() to stop the queue
> >>   before it becomes completely full.
> >> - Not stopping the queue when the ptr_ring is full already, because if
> >>   the consumer empties all entries in the meantime, stopping the queue
> >>   would cause permanent starvation.
> > 
> > what is permanent starvation? this comment seems to answer this
> > question:
> > 
> > 
> > 	/* Do not stop the netdev queue if the ptr_ring is full already.
> > 	 * The consumer could empty out the ptr_ring in the meantime
> > 	 * without noticing the stopped netdev queue, resulting in a
> > 	 * stopped netdev queue and an empty ptr_ring. In this case the
> > 	 * netdev queue would stay stopped forever.
> > 	 */
> > 
> > 
> > why having a single entry in
> > the ring we never use helpful to address this?
> > 
> > 
> > 
> > 
> > In fact, all your patch does to solve it, is check
> > netif_tx_queue_stopped on every consumed packet.
> > 
> > 
> > I already proposed:
> > 
> > static inline int __ptr_ring_peek_producer(struct ptr_ring *r)
> > {
> >         if (unlikely(!r->size) || r->queue[r->producer])
> >                 return -ENOSPC;
> >         return 0;
> > }
> > 
> > And with that, why isn't avoiding the race as simple as
> > just rechecking after stopping the queue?
>  
> I think you are right and that is quite similar to what veth [1] does.
> However, there are two differences:
> 
> - Your approach avoids returning NETDEV_TX_BUSY by already stopping
>   when the ring becomes full (and not when the ring is full already)
> - ...and the recheck of the producer wakes on !full instead of empty.
> 
> I like both aspects better than the veth implementation.

Right.

Though frankly, someone should just fix NETDEV_TX_BUSY already
at least with the most popular qdiscs.

It is a common situation and it is just annoying that every driver has
to come up with its own scheme.





> Just one thing: like the veth implementation, we probably need a
> smp_mb__after_atomic() after netif_tx_stop_queue() as they also discussed
> in their v6 [2].

yea makes sense.

> 
> On the consumer side, I would then just do:
> 
> __ptr_ring_consume();
> if (unlikely(__ptr_ring_consume_created_space()))
>     netif_tx_wake_queue(txq);
> 
> Right?
> 
> And for the batched consume method, I would just call this in a loop.

Well tun does not use batched consume does it?


> Thank you!
> 
> [1] Link: https://lore.kernel.org/netdev/174559288731.827981.8748257839971869213.stgit@firesoul/T/#m2582fcc48901e2e845b20b89e0e7196951484e5f
> [2] Link: https://lore.kernel.org/all/174549933665.608169.392044991754158047.stgit@firesoul/T/#m63f2deb86ffbd9ff3a27e1232077a3775606c14d
> 
> > 
> > __ptr_ring_produce();
> > if (__ptr_ring_peek_producer())
> > 	netif_tx_stop_queue
> 
> smp_mb__after_atomic(); // Right here
> 
> > 	if (!__ptr_ring_peek_producer())
> > 		netif_tx_wake_queue(txq);
> > 
> > 
> > 
> > 
> > 
> > 
> > 


