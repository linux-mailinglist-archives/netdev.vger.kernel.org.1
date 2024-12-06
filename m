Return-Path: <netdev+bounces-149675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCEF9E6C8B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 11:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E432165805
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA411BA86C;
	Fri,  6 Dec 2024 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE5N16KK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A71B641
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 10:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733482261; cv=none; b=IUJzSOP3bh2vsHYVWsKu91TPE9w6J0zDcjy44JbJx+Teo6IU7YdKTjZ0/tQtavFFRIk1EjajZC9mGi71BbVSWJEWmLHVfSe7e7SWJQLMxmsgXWunydDt98nnTXWgWOVy03C9MAuJgC7vTd8aDMEgz9KQAZHEG4jjIcT7WCXE/uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733482261; c=relaxed/simple;
	bh=IecnkFIvJs9WmsxFxoGBAC8CF5+sNI+jrntaO4BXK94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwhcgGkaVtOr7LkOYD6dr6tMTg/WBoZgebP4/cQUFaeokoAcuyuuCZreaUTIVot9JCvLK0bSeDfoUCDVaLCOrV47pRON7OovTdUkKu0HouVqLKVwuI+oaaNgathdAj4oDzBSdx+DS3WVs6WE8NVQy3MtYsiC4tD6+9sQ3aEpIqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XE5N16KK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733482258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCjICA2B+lkSDjf5LXEsHGqI2UEB+WFSm1+bIkOSHB0=;
	b=XE5N16KKM1Ck61h4+t22MKS3U7mOz3+g33ACpstxcVcmyDTY2GPStTnZtDKQQjI8sW2B/t
	hID/0VgeUQ2iEF/ycJMpTi+qyMA6bEv/dYkadfUPttt8IMpDBbxhmmWumd9rSSxj/856Rr
	5XJU5jGggtq13AEHmfRcV1RltsBBi1s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-6R1WW8I7PTS-lrW86az1Pg-1; Fri, 06 Dec 2024 05:50:57 -0500
X-MC-Unique: 6R1WW8I7PTS-lrW86az1Pg-1
X-Mimecast-MFC-AGG-ID: 6R1WW8I7PTS-lrW86az1Pg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434a4ad4798so12366475e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 02:50:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733482256; x=1734087056;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCjICA2B+lkSDjf5LXEsHGqI2UEB+WFSm1+bIkOSHB0=;
        b=NQfTLrnyWUi+XKqy+FZfCb0Nwof8uecE8Kb+1oTiQB2gnhprZe9RlsYRdrUKjY69bZ
         vssH3ti4qI5NWePRqZu/fvEMMhd1NskSTMKP/XFo4CfwnS+/eDRcPZl/Bn5t1xoKuiRX
         2x05jEp8aIX8awuYPotXWVAkX8g5d/S2zA71hxira9mqDIFCChz2a3pkA2L5h8kNj0Xp
         QEHzXZV70ScJ7jw2FfmXU6L0RnoWR4xq5T0cj7P1PVww6Jtw9ws0/bes+4iSrrUxhwui
         P6ge4TAdywOpfE46qXyjLCsq/gmPmfyUSas4/KwNek6sJf1bKzMOdp7AD4l/DZsrISxV
         1wng==
X-Forwarded-Encrypted: i=1; AJvYcCVr/dULvrOzWSCyjgvuE/2Ig2wdR1NB9dUwFQlQmuEEVUoRU3HmdTPRpBRvSV5ZJyCNx4mxwEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRgFZfCe4frr2yxA2VGckcdBa3jUCYA+AFnC7rK9EwInRzyu6P
	NjY3S0fHb/P9LBjCdXvzT2bT6h+/lKj8BXQC0ziIlg1SLK5zk78/YPgTlnszijO0s8SbqSaWKaQ
	k1EgQi3l4v2nGIROGRdvGCZg+4uSEwg9gMAN+3QXinpSyxXSXGYuqjA==
X-Gm-Gg: ASbGncvG6QVH7rDd+uEHqfEVqz1JEPrNOD+qA9nTym9+hbfv3dqYY6pk8kGxE/I2LU4
	xn+joza+iQ8ju/2VbrDa/2SSt3qaVQ1Dbe8zmTPgmTyG0ompYKZc91W5PT5sNmp6jLJUt6nJv1F
	e5+/QmmKektN0+JjJaXNFxezQ5DYcZDVI2UfagPKBBcYDIsfVTtFw3GElYKsrTE/4gUK451mBXI
	yf6q8pj5jmrR8GnLMBFFgKR6wYVsr6CI/q6GAlvREuK8t7CNCxOSQz6xrhgqJV5FFNCvm7kkRxZ
	IBw=
X-Received: by 2002:a05:600c:510b:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-434ddeaba49mr20279195e9.8.1733482255719;
        Fri, 06 Dec 2024 02:50:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyEoBHyx3Je+x7whj46EgxR6wd5QuCxHpGslNiKDSQNG2pA26dN3uLGq74F5ywa5MdNcFgVw==
X-Received: by 2002:a05:600c:510b:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-434ddeaba49mr20279025e9.8.1733482255335;
        Fri, 06 Dec 2024 02:50:55 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5272f99sm89044355e9.11.2024.12.06.02.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 02:50:54 -0800 (PST)
Date: Fri, 6 Dec 2024 11:50:42 +0100
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
Message-ID: <20241206115042.4e98ff8b@elisabeth>
In-Reply-To: <c1601a03-0643-41ec-a91c-4eac5d26e693@redhat.com>
References: <20241204221254.3537932-1-sbrivio@redhat.com>
	<20241204221254.3537932-3-sbrivio@redhat.com>
	<fa941e0d-2359-4d06-8e61-de40b3d570cb@redhat.com>
	<20241205165830.64da6fd7@elisabeth>
	<c1601a03-0643-41ec-a91c-4eac5d26e693@redhat.com>
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

On Thu, 5 Dec 2024 17:53:33 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> On 12/5/24 16:58, Stefano Brivio wrote:
> > On Thu, 5 Dec 2024 10:30:14 +0100
> > Paolo Abeni <pabeni@redhat.com> wrote:
> >   
> >> On 12/4/24 23:12, Stefano Brivio wrote:
> >>  
> >>> [...]
> >>>
> >>> To fix this, replace the rehash operation by a set_rcv_saddr()
> >>> callback holding the spinlock on the primary hash chain, just like
> >>> the rehash operation used to do, but also setting the address (via
> >>> inet_update_saddr(), moved to headers) while holding the spinlock.
> >>>
> >>> To make this atomic against the lookup operation, also acquire the
> >>> spinlock on the primary chain there.    
> >>
> >> I'm sorry for the late feedback.
> >>
> >> I'm concerned by the unconditional spinlock in __udp4_lib_lookup(). I
> >> fear it could cause performance regressions in different workloads:
> >> heavy UDP unicast flow, or even TCP over UDP tunnel when the NIC
> >> supports RX offload for the relevant UDP tunnel protocol.
> >>
> >> In the first case there will be an additional atomic operation per packet.  
> > 
> > So, I've been looking into this a bit, and request-response rates with
> > neper's udp_rr (https://github.com/google/neper/blob/master/udp_rr.c)
> > for a client/server pair via loopback interface are the same before and
> > after this patch.
> > 
> > The reason is, I suppose, that the only contention on that spinlock is
> > the "intended" one, that is, between connect() and lookup.
> > 
> > Then I moved on to bulk flows, with socat or iperf3. But there (and
> > that's the whole point of this fix) we have connected sockets, and once
> > they are connected, we switch to early demux, which is not affected by
> > this patch.
> > 
> > In the end, I don't think this will affect "regular", bulk unicast
> > flows, because applications using them will typically connect sockets,
> > and we'll switch to early demux right away.
> > 
> > This lookup is not exactly "slow path", but it's not fast path either.  
> 
> Some (most ?) quick server implementations don't use connect.

Assuming you mean QUIC, fair enough, I see your point.

> DNS servers will be affected, and will see contention on the hash lock

At the same time, clients (not just DNS) are surely affected by bogus
ICMP Port Unreachable messages, if remote, or ECONNREFUSED on send()
(!), if local.

If (presumed) contention is so relevant, I would have expected that
somebody could indicate a benchmark for it. As I mentioned, udp_rr from
'neper' didn't really show any difference for me. Anyway, fine, let's
assume that it's an issue.

> Even deployment using SO_REUSEPORT with a per-cpu UDP socket will see
> contention. This latter case would be pretty bad, as it's supposed to
> scale linearly.

Okay, I guess we could observe a bigger impact in this case (this is
something I didn't try).

> I really think the hash lock during lookup is a no go.
> 
> >> In the latter the spin_lock will be contended with multiple concurrent
> >> TCP over UDP tunnel flows: the NIC with UDP tunnel offload can use the
> >> inner header to compute the RX hash, and use different rx queues for
> >> such flows.
> >>
> >> The GRO stage will perform UDP tunnel socket lookup and will contend the
> >> bucket lock.  
> > 
> > In this case (I couldn't find out yet), aren't sockets connected? I
> > would expect that we switch to the early demux path relatively soon for
> > anything that needs to have somehow high throughput.  
> 
> The UDP socket backing tunnels is unconnected and can receive data from
> multiple other tunnel endpoints.
> 
> > And if we don't, probably the more reasonable alternative would be to
> > "fix" that, rather than keeping this relatively common case broken.
> > 
> > Do you have a benchmark or something I can run?  
> 
> I'm sorry, but I don't have anything handy. If you have a NIC
> implementing i.e. vxlan H/W offload you should be able to observe
> contention with multiple simultaneus TCP over vxlan flows targeting an
> endpoint on top of it.

Thanks for the idea, but no, I don't have one right now.

> >>> This results in some awkwardness at a caller site, specifically
> >>> sock_bindtoindex_locked(), where we really just need to rehash the
> >>> socket without changing its address. With the new operation, we now
> >>> need to forcibly set the current address again.
> >>>
> >>> On the other hand, this appears more elegant than alternatives such
> >>> as fetching the spinlock reference in ip4_datagram_connect() and
> >>> ip6_datagram_conect(), and keeping the rehash operation around for
> >>> a single user also seems a tad overkill.    
> >>
> >> Would such option require the same additional lock at lookup time?  
> > 
> > Yes, it's conceptually the same, we would pretty much just move code
> > around.
> > 
> > I've been thinking about possible alternatives but they all involve a
> > much bigger rework. One idea could be that we RCU-connect() sockets,
> > instead of just having the hash table insertion under RCU. That is, as
> > long as we're in the grace period, the lookup would still see the old
> > receive address.  
> 
> I'm wondering if the issue could be solved (almost) entirely in the
> rehash callback?!? if the rehash happens on connect and the the socket
> does not have hash4 yet (it's not a reconnect) do the l4 hashing before
> everything else.

So, yes, that's actually the first thing I tried: do the hashing (any
hash) before setting the address (I guess that's what you mean by
"everything else").

If you take this series, and drop the changes in __udp4_lib_lookup(), I
guess that would match what you suggest.

With udp_lib_set_rcv_saddr() instead of a "rehash" callback you can see
pretty easily that hashes are updated first, and then we set the
receiving address.

It doesn't work because the socket does have a receiving address (and
hashes) already: it's 0.0.0.0. So we're just moving the race condition.
I don't think we can really change that part.

Note that this issue occurs with and without four-tuple hashes (I
actually posted the original fix before they were introduced).

> Incoming packets should match the l4 hash and reach the socket even
> while later updating the other hash(es).

...to obtain this kind of outcome, I'm trying to keep the old hash
around until the new hash is there *and* we changed the address.

For simplicity, I cut out four-tuple hashes, and, in the new
udp_lib_set_rcv_saddr(), I changed RCU calls so that it should always
be the case... but that doesn't help either for some reason.

I wonder if you have some idea as to whether that's a viable approach
at all, and if there's something particular I should observe while
implementing it.

-- 
Stefano


