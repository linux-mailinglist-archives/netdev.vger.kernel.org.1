Return-Path: <netdev+bounces-149451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AF19E5A8E
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0C6283161
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65321D5AB;
	Thu,  5 Dec 2024 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQNIWdN2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B0E21D5A8
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733414319; cv=none; b=qj+qMp1WT21wYa9jCNGgqX85URL/7J7gBWtQ4KzcCLnemqhqJcI8F3WhKtXsCIBZMWJqZGz20kSECJB9hvYS3O0dTWmUVGhW6xVkAO/t+RBw3UeDFFmvoXyWPccXCWyZd0KBgG5b+n6LoVhYxTw3hPjbFwEXD7jUUCXDDNC8KAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733414319; c=relaxed/simple;
	bh=hZYVEYP/BkreZ/P2VpTab4f6A/R1qCOEF31RSyMKUks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBJAWy9FvW9Gbw6eYXWYvmJgBfjkh0bZejjP+5BC3sspqKZQIs/BoF9hCp8v/VWp6SMagypty853bEoKPioBT4RrUe7K8bnJxd+Ey0+rO/9IleVsoB1YEAAQPCX7aflVnEeIAojuIetE/hxk4PJQZ5EJbosoN+JK7VbED+pGzsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQNIWdN2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733414316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=79e12/Inlm+a+XDX2QLOcdPh5UyEkIkLfWKw6eoX3KI=;
	b=JQNIWdN2COxCEiEsPjqjbv1ct/mTY62K5gi2VPvCnc2vi6ix/ByavqpBXkZqJjSa//u/BR
	+yMZnUlQPYyyUJUM2xtHEVKwpxTUgSIFTWRw4uGffXjGr76SJOxPlOTZiVQt1zJb8xCYos
	aYul5zj5kmrN6DfoaBbu6i9pAyZbVp0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-WoZcTAXUMd-WSjS3t688oQ-1; Thu, 05 Dec 2024 10:58:34 -0500
X-MC-Unique: WoZcTAXUMd-WSjS3t688oQ-1
X-Mimecast-MFC-AGG-ID: WoZcTAXUMd-WSjS3t688oQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e1339790so752688f8f.2
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 07:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733414313; x=1734019113;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=79e12/Inlm+a+XDX2QLOcdPh5UyEkIkLfWKw6eoX3KI=;
        b=XZiSPyhLrqP/DSF/ZYFE5sach8zzu3MKy8yyQ6mo4N4rv86VOSDCMSDjw0EF4WMJGc
         WTaohodzX/V1EXMXBk/3mGwhEh8EN0KY5nv+apYjF/nPqbmbILWZvQuNTJgm+t0/BAbN
         5C9wDvdUzzJSjQ7SjosdPkXM2aurkJOVL7MdRw5ftvT10dY+hxfEnXI5RZ7IZ5Kj9Ny6
         YLQjifm+BhpKlFmCcbu7m2K1VrwpdyOnjVSBFia/uzWAqAfYLmo1Ej6fSLE0KOAAXdw/
         Dl4TqFYsLCjpe2olJA/kwuiLVOHZUJ3AWMujKKX0C/3SfZFkCCju2hu9BktvwCiqgEdq
         KKVA==
X-Forwarded-Encrypted: i=1; AJvYcCU5qUVzO6RTx9eW7IrFDxBff0JQvwtqsAqkMl0H4J3BKsGpmCfhQM8NYtZ4iwyJO326XG/2aUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgd0TuYnVEOn3wPHwuHuzx/6vXfG4o73Seau9DW82SChLREn7o
	SZLlXx0Z79ztPf2vozID1cYpKcTmqpjEhHARafZqMgvkJ2vSIbFfyKLFPYhBiFC6qKgAQl9dbn0
	hdGpuUAYn6cxsIVHHIp4/k1EI9yiR+x1nfmoYNgQ62IXAZsm5uSSWOg==
X-Gm-Gg: ASbGncsueM4Ts7JwyDD+kLLpLeThC1MIlfIzxxt3SZ70EsbetaI/2VO7c3jI7o9OZWH
	qd+j360s8BJ6pBgH5jHBcA89FatA7vMj60Q6cKc7RD02N5pZrIIma//Gd1QWbC5TqYRUniR2FfU
	GeOhLM5pDyU2Lj/953wl4AsOWe0yMgkX/LxFNewHjA1cVADSS2vqcAfvqku/X6rToHdgFRRFnJa
	/KDqdyzVJlSHVVnvZwWFRe6g+E//sHUN9HrYUsW4puWkUxDHwW4+LoNnD3KzQ==
X-Received: by 2002:a5d:6d03:0:b0:37d:4833:38f5 with SMTP id ffacd0b85a97d-385fd3f2c0emr10956904f8f.30.1733414313472;
        Thu, 05 Dec 2024 07:58:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlKSJhtirBkNqZFNH9RqG+hjCxLZfB8doDmHDMIv25P19/ObmWE5UmlSGAjv5zo/6+iS5Gyg==
X-Received: by 2002:a5d:6d03:0:b0:37d:4833:38f5 with SMTP id ffacd0b85a97d-385fd3f2c0emr10956880f8f.30.1733414313112;
        Thu, 05 Dec 2024 07:58:33 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d691csm27754605e9.11.2024.12.05.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:58:32 -0800 (PST)
Date: Thu, 5 Dec 2024 16:58:30 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Mike Manning <mvrmanning@gmail.com>, David Gibson
 <david@gibson.dropbear.id.au>, Paul Holzinger <pholzing@redhat.com>, Philo
 Lu <lulie@linux.alibaba.com>, Cambda Zhu <cambda@linux.alibaba.com>, Fred
 Chen <fred.cc@alibaba-inc.com>, Yubing Qiu
 <yubing.qiuyubing@alibaba-inc.com>
Subject: Re: [PATCH net-next 2/2] datagram, udp: Set local address and
 rehash socket atomically against lookup
Message-ID: <20241205165830.64da6fd7@elisabeth>
In-Reply-To: <fa941e0d-2359-4d06-8e61-de40b3d570cb@redhat.com>
References: <20241204221254.3537932-1-sbrivio@redhat.com>
	<20241204221254.3537932-3-sbrivio@redhat.com>
	<fa941e0d-2359-4d06-8e61-de40b3d570cb@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Dec 2024 10:30:14 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> On 12/4/24 23:12, Stefano Brivio wrote:
>
> > [...]
> > 
> > To fix this, replace the rehash operation by a set_rcv_saddr()
> > callback holding the spinlock on the primary hash chain, just like
> > the rehash operation used to do, but also setting the address (via
> > inet_update_saddr(), moved to headers) while holding the spinlock.
> > 
> > To make this atomic against the lookup operation, also acquire the
> > spinlock on the primary chain there.  
> 
> I'm sorry for the late feedback.
> 
> I'm concerned by the unconditional spinlock in __udp4_lib_lookup(). I
> fear it could cause performance regressions in different workloads:
> heavy UDP unicast flow, or even TCP over UDP tunnel when the NIC
> supports RX offload for the relevant UDP tunnel protocol.
> 
> In the first case there will be an additional atomic operation per packet.

So, I've been looking into this a bit, and request-response rates with
neper's udp_rr (https://github.com/google/neper/blob/master/udp_rr.c)
for a client/server pair via loopback interface are the same before and
after this patch.

The reason is, I suppose, that the only contention on that spinlock is
the "intended" one, that is, between connect() and lookup.

Then I moved on to bulk flows, with socat or iperf3. But there (and
that's the whole point of this fix) we have connected sockets, and once
they are connected, we switch to early demux, which is not affected by
this patch.

In the end, I don't think this will affect "regular", bulk unicast
flows, because applications using them will typically connect sockets,
and we'll switch to early demux right away.

This lookup is not exactly "slow path", but it's not fast path either.

> In the latter the spin_lock will be contended with multiple concurrent
> TCP over UDP tunnel flows: the NIC with UDP tunnel offload can use the
> inner header to compute the RX hash, and use different rx queues for
> such flows.
> 
> The GRO stage will perform UDP tunnel socket lookup and will contend the
> bucket lock.

In this case (I couldn't find out yet), aren't sockets connected? I
would expect that we switch to the early demux path relatively soon for
anything that needs to have somehow high throughput.

And if we don't, probably the more reasonable alternative would be to
"fix" that, rather than keeping this relatively common case broken.

Do you have a benchmark or something I can run?

> > This results in some awkwardness at a caller site, specifically
> > sock_bindtoindex_locked(), where we really just need to rehash the
> > socket without changing its address. With the new operation, we now
> > need to forcibly set the current address again.
> > 
> > On the other hand, this appears more elegant than alternatives such
> > as fetching the spinlock reference in ip4_datagram_connect() and
> > ip6_datagram_conect(), and keeping the rehash operation around for
> > a single user also seems a tad overkill.  
> 
> Would such option require the same additional lock at lookup time?

Yes, it's conceptually the same, we would pretty much just move code
around.

I've been thinking about possible alternatives but they all involve a
much bigger rework. One idea could be that we RCU-connect() sockets,
instead of just having the hash table insertion under RCU. That is, as
long as we're in the grace period, the lookup would still see the old
receive address.

But, especially now that we have *three* hash tables, this is extremely
involved, and perhaps would warrant a rewrite of the whole thing. Given
that we're currently breaking users, I'd rather fix this first.

Sure, things have been broken for 19 years so I guess it's okay to defer
this fix to net-next (see discussion around the RFC), but I'd still
suggest that we fix this as a first step, because the breakage is
embarrassingly obvious (see reproducers).

-- 
Stefano


