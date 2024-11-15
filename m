Return-Path: <netdev+bounces-145360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FDB9CF3E0
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A0EB3F1AC
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 18:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6291CF2B7;
	Fri, 15 Nov 2024 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzG2DLEP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDA31D63D7
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731694238; cv=none; b=TkqAKfJZltsl916A0bvNxzUvv6cDnLFH8FDsUTw+mWr93WCml1poGwFE8TJPLZ3wR67lR4XrXBoziIr45wuMtEus74M557YPz74ZjyPYrUTD7AQsb8PzCSPuMKLKDr8ng6zqmEsdgqhYQY+2Jrc4WwlgdjkrTWknDyWEhevkVq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731694238; c=relaxed/simple;
	bh=v9H5Bu2Xi5mYd20j8Cn+lvhRUHreXbysBE91l4c8NPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1DVllY21ffmlCOUj0W11wDfz6KILajHJZ96O3GlAbgVv0Szhws1GDDt5e1PPBXev5y3eANH3IpkcHcMTINy2SfF221hM4yobknVZDbiE5D32unJIoCzSP/ojDjjsaiaNYDt1GuvyKAhe1toGyWt8hSYmGizc6NqrLIZBPYRSe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzG2DLEP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731694235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JpbZCS9HzBxlafR92HJOx12JsfbvPkYH+fhtqcJrSAU=;
	b=OzG2DLEPqMgQBUBgfijbBC0Y/9FjIh8EubBDD5fQ243JjGZzOEcv+QtL5Q3F7aoPVIBYbV
	hXeXyRCJFFw1gi3EmHj7KEChOAYKlqMgSm0dICsq52TpP3GIP4q0o1GzX5CNpfcjYr09a+
	MbFH8tFKwF/jLSsH8m4OO4hjILC7mmo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-XrN7BrkuNWyH8RCe2yxcRw-1; Fri, 15 Nov 2024 13:10:34 -0500
X-MC-Unique: XrN7BrkuNWyH8RCe2yxcRw-1
X-Mimecast-MFC-AGG-ID: XrN7BrkuNWyH8RCe2yxcRw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d52ccc50eso1124287f8f.3
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 10:10:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731694232; x=1732299032;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JpbZCS9HzBxlafR92HJOx12JsfbvPkYH+fhtqcJrSAU=;
        b=Dy3Vci6weNvd2uvAC5VDNuIm0W2qEJLJETwPNhIptXyMhZMpLowmLKngNGmmMNRKwj
         nXa0Oe4tPjAkXLHqROavk88jySQgOuCqfEfAdowiZyvDyzgg9Lrjp1jZODfYJlVnu8F3
         cUUto0n/7q5rwD3EUA1JUiPmnCigxOHx1uKpzZJrzQk+LJxNq0+8BuPNU8WHR2/hHesm
         pDh7Ultm5dfj6uEzcz1IOab3cU1ewvmmbhEBIW9oliAQCC8swPtxae6/JMGwu+y9kC8o
         6NdmAw2kLRHL694f0fDrHStKfNxY/yqCaruIpO+EN/e5JDNV88ar5/Kp77lCPZlTRJXS
         xUoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6VpgsIFVBQ5Omw1dk+ctIj78h9Rc1zSUz0wpeZGBF+ATXZxPp2Um0NlUGqLodncr4YVdoGPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQZ+8fXZHesCq4e3Ig6PAAfoCZIeCRoVG6Cc8ypOEgzy1xVMwZ
	e6JW5makSsu1MIJM6Tz8w+DzhXC9rnZ6eNyKLJX3JU6tIUWzl3LiCiD323HCb43qeA7yZYGeU5+
	DpyfXmC+bYdaXS9bwhAQEEQJyiROMuSkr1Q6y4w9XiuAjIZyqArwFDiRHlc/s/Q==
X-Received: by 2002:a05:6000:2709:b0:382:27ab:7b5 with SMTP id ffacd0b85a97d-38227ab07famr1960898f8f.53.1731694232319;
        Fri, 15 Nov 2024 10:10:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFA3l2FEFluPO+qYmYw1nmc5aJQEhHvoMXNxRY3ImajF7bfLuZu/htYYs731LN+OXm7nkdB2A==
X-Received: by 2002:a05:6000:2709:b0:382:27ab:7b5 with SMTP id ffacd0b85a97d-38227ab07famr1960879f8f.53.1731694231836;
        Fri, 15 Nov 2024 10:10:31 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae3101fsm4939143f8f.92.2024.11.15.10.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 10:10:31 -0800 (PST)
Date: Fri, 15 Nov 2024 19:10:29 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Mike Manning
 <mvrmanning@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Ed
 Santiago <santiago@redhat.com>, Paul Holzinger <pholzing@redhat.com>
Subject: Re: [PATCH RFC net 2/2] datagram, udp: Set local address and rehash
 socket atomically against lookup
Message-ID: <20241115191029.37456575@elisabeth>
In-Reply-To: <673789deb6649_3d5f2c294ec@willemb.c.googlers.com.notmuch>
References: <20241114215414.3357873-1-sbrivio@redhat.com>
	<20241114215414.3357873-3-sbrivio@redhat.com>
	<673789deb6649_3d5f2c294ec@willemb.c.googlers.com.notmuch>
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

On Fri, 15 Nov 2024 12:50:22 -0500
Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> Stefano Brivio wrote:
> > If a UDP socket changes its local address while it's receiving
> > datagrams, as a result of connect(), there is a period during which
> > a lookup operation might fail to find it, after the address is changed
> > but before the secondary hash (port and address) is updated.
> > 
> > Secondary hash chains were introduced by commit 30fff9231fad ("udp:
> > bind() optimisation") and, as a result, a rehash operation became
> > needed to make a bound socket reachable again after a connect().
> > 
> > This operation was introduced by commit 719f835853a9 ("udp: add
> > rehash on connect()") which isn't however a complete fix: the
> > socket will be found once the rehashing completes, but not while
> > it's pending.
> > 
> > This is noticeable with a socat(1) server in UDP4-LISTEN mode, and a
> > client sending datagrams to it. After the server receives the first
> > datagram (cf. _xioopen_ipdgram_listen()), it issues a connect() to
> > the address of the sender, in order to set up a directed flow.
> > 
> > Now, if the client, running on a different CPU thread, happens to
> > send a (subsequent) datagram while the server's socket changes its
> > address, but is not rehashed yet, this will result in a failed
> > lookup and a port unreachable error delivered to the client, as
> > apparent from the following reproducer:
> > 
> >   LEN=$(($(cat /proc/sys/net/core/wmem_default) / 4))
> >   dd if=/dev/urandom bs=1 count=${LEN} of=tmp.in
> > 
> >   while :; do
> >   	taskset -c 1 socat UDP4-LISTEN:1337,null-eof OPEN:tmp.out,create,trunc &
> >   	sleep 0.1 || sleep 1
> >   	taskset -c 2 socat OPEN:tmp.in UDP4:localhost:1337,shut-null
> >   	wait
> >   done
> > 
> > where the client will eventually get ECONNREFUSED on a write()
> > (typically the second or third one of a given iteration):
> > 
> >   2024/11/13 21:28:23 socat[46901] E write(6, 0x556db2e3c000, 8192): Connection refused
> > 
> > This issue was first observed as a seldom failure in Podman's tests
> > checking UDP functionality while using pasta(1) to connect the
> > container's network namespace, which leads us to a reproducer with
> > the lookup error resulting in an ICMP packet on a tap device:
> > 
> >   LOCAL_ADDR="$(ip -j -4 addr show|jq -rM '.[] | .addr_info[0] | select(.scope == "global").local')"
> > 
> >   while :; do
> >   	./pasta --config-net -p pasta.pcap -u 1337 socat UDP4-LISTEN:1337,null-eof OPEN:tmp.out,create,trunc &
> >   	sleep 0.2 || sleep 1
> >   	socat OPEN:tmp.in UDP4:${LOCAL_ADDR}:1337,shut-null
> >   	wait
> >   	cmp tmp.in tmp.out
> >   done
> > 
> > Once this fails:
> > 
> >   tmp.in tmp.out differ: char 8193, line 29
> > 
> > we can finally have a look at what's going on:
> > 
> >   $ tshark -r pasta.pcap
> >       1   0.000000           :: ? ff02::16     ICMPv6 110 Multicast Listener Report Message v2
> >       2   0.168690 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
> >       3   0.168767 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
> >       4   0.168806 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
> >       5   0.168827 c6:47:05:8d:dc:04 ? Broadcast    ARP 42 Who has 88.198.0.161? Tell 88.198.0.164
> >       6   0.168851 9a:55:9a:55:9a:55 ? c6:47:05:8d:dc:04 ARP 42 88.198.0.161 is at 9a:55:9a:55:9a:55
> >       7   0.168875 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
> >       8   0.168896 88.198.0.164 ? 88.198.0.161 ICMP 590 Destination unreachable (Port unreachable)
> >       9   0.168926 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
> >      10   0.168959 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
> >      11   0.168989 88.198.0.161 ? 88.198.0.164 UDP 4138 60260 ? 1337 Len=4096
> >      12   0.169010 88.198.0.161 ? 88.198.0.164 UDP 42 60260 ? 1337 Len=0
> > 
> > On the third datagram received, the network namespace of the container
> > initiates an ARP lookup to deliver the ICMP message.
> > 
> > In another variant of this reproducer, starting the client with:
> > 
> >   strace -f pasta --config-net -u 1337 socat UDP4-LISTEN:1337,null-eof OPEN:tmp.out,create,trunc 2>strace.log &
> > 
> > and connecting to the socat server using a loopback address:
> > 
> >   socat OPEN:tmp.in UDP4:localhost:1337,shut-null
> > 
> > we can more clearly observe a sendmmsg() call failing after the
> > first datagram is delivered:
> > 
> >   [pid 278012] connect(173, 0x7fff96c95fc0, 16) = 0
> >   [...]
> >   [pid 278012] recvmmsg(173, 0x7fff96c96020, 1024, MSG_DONTWAIT, NULL) = -1 EAGAIN (Resource temporarily unavailable)
> >   [pid 278012] sendmmsg(173, 0x561c5ad0a720, 1, MSG_NOSIGNAL) = 1
> >   [...]
> >   [pid 278012] sendmmsg(173, 0x561c5ad0a720, 1, MSG_NOSIGNAL) = -1 ECONNREFUSED (Connection refused)
> > 
> > and, somewhat confusingly, after a connect() on the same socket
> > succeeded.
> > 
> > To fix this, replace the rehash operation by a set_rcv_saddr()
> > callback holding the spinlock on the primary hash chain, just like
> > the rehash operation used to do, but also setting the address while
> > holding the spinlock.
> > 
> > To make this atomic against the lookup operation, also acquire the
> > spinlock on the primary chain there.
> > 
> > This results in some awkwardness at a caller site, specifically
> > sock_bindtoindex_locked(), where we really just need to rehash the
> > socket without changing its address. With the new operation, we now
> > need to forcibly set the current address again.
> > 
> > On the other hand, this appears more elegant than alternatives such
> > as fetching the spinlock reference in ip4_datagram_connect() and
> > ip6_datagram_conect(), and keeping the rehash operation around for
> > a single user also seems a tad overkill.
> > 
> > Reported-by: Ed Santiago <santiago@redhat.com>
> > Link: https://github.com/containers/podman/issues/24147
> > Analysed-by: David Gibson <david@gibson.dropbear.id.au>
> > Fixes: 30fff9231fad ("udp: bind() optimisation")
> > Signed-off-by: Stefano Brivio <sbrivio@redhat.com>  
> 
> Thanks for the detailed well written explanation of the
> condition, and the repro.
> 
> The current patch is quite complex, making it very hard to backport to
> stable kernels.

It shouldn't be backported to stable, the issue has been there since
2009, so I don't think anybody will be offended if we don't.

> Let's investigate if this issue can be mitigated with a much smaller
> patch.

One thing I tried was to open-code the current rehash operation in the
datagram connect stuff. It works and I can submit that version, but if
you have one copy for IPv4 and one for IPv6 the change gets actually
bigger.

I would rather submit the whole thing for net-next instead. Does that
make sense?

-- 
Stefano


