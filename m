Return-Path: <netdev+bounces-145354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BADA9CF345
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 18:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2294E1F21687
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2671D5ADB;
	Fri, 15 Nov 2024 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mELoXePB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B222F1D460E
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731693026; cv=none; b=VTnMNWtmaHfpRlCoTDdyjiVdY5+7cwLqJA9U/mFpambA+nHk/YwPx5F2ZcElPDIjXTJE4bn1++D92BKx4AVY48m7VdvAL8+nnoQNkEsl5wzEib+MAUxH52/DLrwgfdldB21HitJhmG/4o9JTHLuGAQkpFM871fkZraNJqrt9JIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731693026; c=relaxed/simple;
	bh=jF+cXVBz6EnLQszISNMZOcZCPNhnouqxbCQrvDWQcaM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VI4XQjAAnhOJtDv+4cfM+erRSYqkW8YI/J0rqN6Jpau60dKPkhhSWL3VpjA2bB2Csje8spAK0sCBKWG5xFRUSbbwxmUvIci5IzzhJJ/j9CRU7cBMY6rSiqOegelMA16px4KVjopMv6EgkJ8vv7bZ0/HKnjwagDPmYQMVudP+dRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mELoXePB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d403b1d050so2892886d6.1
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 09:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731693023; x=1732297823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnXaHctzYpNpCefB/P+ft32kfn87hPOWnNuxFcwieKQ=;
        b=mELoXePBtxxH4vu81+fiC3Jk6lVYrzzzpsLPt4dBg/TismBJr/D0YFL+t2+PjEqWHL
         2jk4gED5Dlg08FLn0oQYW7A79tBJhwXhwfl2PzV5Q5MzRW92riLnIoThvGt9KSXJnaiX
         aA8Etnl67mMzP+S2U06gheS9GrfYxJTW9nOgq/1pUxUFVUMqKsp2Fl/Obhy8ya/gFElK
         VpgWhIOBcfVcTYeifRjxkRo5kTKF7xQPPiIwXBoGTnpoXzburpvunrCkc9xsz0O/kxiy
         VQVKmM9dJLSoZPc+RafJm6GDqlqf5/WcK6zW+vGWfQiK1RckSg7/L5SwCjStObGRupV9
         e4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731693023; x=1732297823;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vnXaHctzYpNpCefB/P+ft32kfn87hPOWnNuxFcwieKQ=;
        b=TuYFOADtN1c8V3qN8mplgV9YtMMVnhIHN/QYKp2tq+fGuz370r66qRCXqL7fMXIeqh
         FXTCffxyBPHBBEstkePyevC/dZtTGYfm6KlXEklHzgEMVf3OuJCTz6S+QciqcxeceKlN
         sSfM5CeagaO+HWTcSE97ioeeyG5es09Sa2m+4TvMFk/bfE55HnUTCDqkO7gpKXuNw1Ws
         ui3LBE2+y8C29syihEZF0stjudbtxvqhp3Tln5fnWS1NXE7GuPk9BXNVQLbx7YGJXklM
         btWtHeSVLJBNHVxm+umK+pLRoFRW3WUaFX5Sejp5Sc6DXRoV6piFqlK7VoFHNADekNm9
         Yo/A==
X-Gm-Message-State: AOJu0YwSHbpTFxnKWdSiXV6Ts1SDQnJpYyAvBkIBR9j8Hg4USO5BTJ34
	B4cHbK+YNZO679y7s1Cw43ADq/w72yqFFWDbCqz5Zz1PR18J7MTP
X-Google-Smtp-Source: AGHT+IFnzHbzeTI4fTmAUsK41CIQf8rbM0xGsBvDFx6uNi4dZGECs+EZEycdBuDMKOCgfoNsD1S5LQ==
X-Received: by 2002:a05:6214:5888:b0:6cb:600f:568b with SMTP id 6a1803df08f44-6d3fb7ae0c0mr36737916d6.8.1731693023497;
        Fri, 15 Nov 2024 09:50:23 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee972c01sm19539826d6.131.2024.11.15.09.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 09:50:23 -0800 (PST)
Date: Fri, 15 Nov 2024 12:50:22 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stefano Brivio <sbrivio@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, 
 Mike Manning <mmanning@vyatta.att-mail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Ed Santiago <santiago@redhat.com>, 
 Paul Holzinger <pholzing@redhat.com>
Message-ID: <673789deb6649_3d5f2c294ec@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241114215414.3357873-3-sbrivio@redhat.com>
References: <20241114215414.3357873-1-sbrivio@redhat.com>
 <20241114215414.3357873-3-sbrivio@redhat.com>
Subject: Re: [PATCH RFC net 2/2] datagram, udp: Set local address and rehash
 socket atomically against lookup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stefano Brivio wrote:
> If a UDP socket changes its local address while it's receiving
> datagrams, as a result of connect(), there is a period during which
> a lookup operation might fail to find it, after the address is changed
> but before the secondary hash (port and address) is updated.
> 
> Secondary hash chains were introduced by commit 30fff9231fad ("udp:
> bind() optimisation") and, as a result, a rehash operation became
> needed to make a bound socket reachable again after a connect().
> 
> This operation was introduced by commit 719f835853a9 ("udp: add
> rehash on connect()") which isn't however a complete fix: the
> socket will be found once the rehashing completes, but not while
> it's pending.
> 
> This is noticeable with a socat(1) server in UDP4-LISTEN mode, and a
> client sending datagrams to it. After the server receives the first
> datagram (cf. _xioopen_ipdgram_listen()), it issues a connect() to
> the address of the sender, in order to set up a directed flow.
> 
> Now, if the client, running on a different CPU thread, happens to
> send a (subsequent) datagram while the server's socket changes its
> address, but is not rehashed yet, this will result in a failed
> lookup and a port unreachable error delivered to the client, as
> apparent from the following reproducer:
> 
>   LEN=$(($(cat /proc/sys/net/core/wmem_default) / 4))
>   dd if=/dev/urandom bs=1 count=${LEN} of=tmp.in
> 
>   while :; do
>   	taskset -c 1 socat UDP4-LISTEN:1337,null-eof OPEN:tmp.out,create,trunc &
>   	sleep 0.1 || sleep 1
>   	taskset -c 2 socat OPEN:tmp.in UDP4:localhost:1337,shut-null
>   	wait
>   done
> 
> where the client will eventually get ECONNREFUSED on a write()
> (typically the second or third one of a given iteration):
> 
>   2024/11/13 21:28:23 socat[46901] E write(6, 0x556db2e3c000, 8192): Connection refused
> 
> This issue was first observed as a seldom failure in Podman's tests
> checking UDP functionality while using pasta(1) to connect the
> container's network namespace, which leads us to a reproducer with
> the lookup error resulting in an ICMP packet on a tap device:
> 
>   LOCAL_ADDR="$(ip -j -4 addr show|jq -rM '.[] | .addr_info[0] | select(.scope == "global").local')"
> 
>   while :; do
>   	./pasta --config-net -p pasta.pcap -u 1337 socat UDP4-LISTEN:1337,null-eof OPEN:tmp.out,create,trunc &
>   	sleep 0.2 || sleep 1
>   	socat OPEN:tmp.in UDP4:${LOCAL_ADDR}:1337,shut-null
>   	wait
>   	cmp tmp.in tmp.out
>   done
> 
> Once this fails:
> 
>   tmp.in tmp.out differ: char 8193, line 29
> 
> we can finally have a look at what's going on:
> 
>   $ tshark -r pasta.pcap
>       1   0.000000           :: ? ff02::16     ICMPv6 110 Multicast Listener Report Message v2
>       2   0.168690 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
>       3   0.168767 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
>       4   0.168806 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
>       5   0.168827 c6:47:05:8d:dc:04 ? Broadcast    ARP 42 Who has 88.198.0.161? Tell 88.198.0.164
>       6   0.168851 9a:55:9a:55:9a:55 ? c6:47:05:8d:dc:04 ARP 42 88.198.0.161 is at 9a:55:9a:55:9a:55
>       7   0.168875 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
>       8   0.168896 88.198.0.164 ? 88.198.0.161 ICMP 590 Destination unreachable (Port unreachable)
>       9   0.168926 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
>      10   0.168959 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
>      11   0.168989 88.198.0.161 ? 88.198.0.164 UDP 4138 60260 ? 1337 Len=4096
>      12   0.169010 88.198.0.161 ? 88.198.0.164 UDP 42 60260 ? 1337 Len=0
> 
> On the third datagram received, the network namespace of the container
> initiates an ARP lookup to deliver the ICMP message.
> 
> In another variant of this reproducer, starting the client with:
> 
>   strace -f pasta --config-net -u 1337 socat UDP4-LISTEN:1337,null-eof OPEN:tmp.out,create,trunc 2>strace.log &
> 
> and connecting to the socat server using a loopback address:
> 
>   socat OPEN:tmp.in UDP4:localhost:1337,shut-null
> 
> we can more clearly observe a sendmmsg() call failing after the
> first datagram is delivered:
> 
>   [pid 278012] connect(173, 0x7fff96c95fc0, 16) = 0
>   [...]
>   [pid 278012] recvmmsg(173, 0x7fff96c96020, 1024, MSG_DONTWAIT, NULL) = -1 EAGAIN (Resource temporarily unavailable)
>   [pid 278012] sendmmsg(173, 0x561c5ad0a720, 1, MSG_NOSIGNAL) = 1
>   [...]
>   [pid 278012] sendmmsg(173, 0x561c5ad0a720, 1, MSG_NOSIGNAL) = -1 ECONNREFUSED (Connection refused)
> 
> and, somewhat confusingly, after a connect() on the same socket
> succeeded.
> 
> To fix this, replace the rehash operation by a set_rcv_saddr()
> callback holding the spinlock on the primary hash chain, just like
> the rehash operation used to do, but also setting the address while
> holding the spinlock.
> 
> To make this atomic against the lookup operation, also acquire the
> spinlock on the primary chain there.
> 
> This results in some awkwardness at a caller site, specifically
> sock_bindtoindex_locked(), where we really just need to rehash the
> socket without changing its address. With the new operation, we now
> need to forcibly set the current address again.
> 
> On the other hand, this appears more elegant than alternatives such
> as fetching the spinlock reference in ip4_datagram_connect() and
> ip6_datagram_conect(), and keeping the rehash operation around for
> a single user also seems a tad overkill.
> 
> Reported-by: Ed Santiago <santiago@redhat.com>
> Link: https://github.com/containers/podman/issues/24147
> Analysed-by: David Gibson <david@gibson.dropbear.id.au>
> Fixes: 30fff9231fad ("udp: bind() optimisation")
> Signed-off-by: Stefano Brivio <sbrivio@redhat.com>

Thanks for the detailed well written explanation of the
condition, and the repro.

The current patch is quite complex, making it very hard to backport to
stable kernels.

Let's investigate if this issue can be mitigated with a much smaller
patch.

