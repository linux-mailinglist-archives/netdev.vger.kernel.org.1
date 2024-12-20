Return-Path: <netdev+bounces-153716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B89D9F950D
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 16:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7841C18935D4
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376C218AAA;
	Fri, 20 Dec 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U93YP4PC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC2215F44
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707162; cv=none; b=tHBYbfWuXF5N2o1YiITp70OBakyZjTYj5n2xN0MjdN0Av7kmpkoiDsRaBVylyY7fT4WKA2bbTFljWL0YHW6jDDC3fG8dRR9zg/qFbxVXfPFOELut3avwlyyKZszW+rX1a6Nv70eqdHmRwR9/pHWujJNAZa2J2quyld+uXJV9o2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707162; c=relaxed/simple;
	bh=9bNyNXq8ZBuWAZCiQAfoZ2QkiXOuKEzS0VgzfBiIIvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POZRozcQQug2VI2lad9vdVo1lj7QzkZfgWziCsJDg7Mc32HE260rJ2DWsOfJdj5a6d9dWHuYwL/MmVGVz67ZFPOTL4HWaxcx6zMOhnqw4PZ4tnD6Zotyq1ed0AUw4rt6yW4py/GuWRyciJZ+tP6YlA/9n2pPIxG0DzzRoYEN7n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U93YP4PC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734707159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R31kY5tJXOAoXoGKKqD3SFFNHIschOeD3SfPaGvQVeo=;
	b=U93YP4PCfsDGksKLNULQaHTzcru7a3HCnx6CSeCi5KNj0Q1kIAx4ZhFybPjJ9YiUl0NJdD
	hs7s8CKrP/T6+6jlryppn54AaYn54a19DdlV2jQdqI9M4Mrldo3OHoHf6wfKCixi4aRlKv
	oZPhLirlYhp52oAV5400I6KxOuFGuKA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-eZAzDOq8Ogi9__ePm9n4jg-1; Fri, 20 Dec 2024 10:05:58 -0500
X-MC-Unique: eZAzDOq8Ogi9__ePm9n4jg-1
X-Mimecast-MFC-AGG-ID: eZAzDOq8Ogi9__ePm9n4jg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43635895374so15635095e9.0
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 07:05:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707157; x=1735311957;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R31kY5tJXOAoXoGKKqD3SFFNHIschOeD3SfPaGvQVeo=;
        b=LcunwKZaCBfYBSB2OTZ3eeOBW62AKYe7gR/rlvzXvvczr1j9h0Zxpv4IJetixeYZFD
         B0i1/wL2Gd9FO3EML/p3PMhc5K5EO3G0hQ8ekrHP05a0o1ZQscVFvJsoIVRfUnbkrbZH
         aeG1BRIGB9R6Q7CNcnyL8jR2rf9OFiaUs/8k6mzqqYO/3bcQR1FuczM1xihnuovWjT7o
         lcnTZoZEeiCB6Y5gRQy9nhM8IAk9zSyjuuiEOp+jb/VlG4acc8S7YagprOcESxpqFdwD
         b+g73K2C2K+xd8oegCW4yCD0x6mQQfLqOg8yQCC+RQvibmssUubS+bANb2omxFv89XSk
         JYtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6x1EOkUTudA5WNs5g/2KJXvp+EwmWGFHVntGc9B2h8AT2NNAsT+7JOFgDFLavYsiHDf33NIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSchG6EnCuQr032QlnRLlhvUK6AaZm6CFAPHdXtrYJ/pgVdC5/
	Mjsa9E8japGMwjtp0CmFfMJS+kZJ8l+aBqCuWXzrcXNqZTnOpRTNIkscRp/w3LMHv3cdogAGeCU
	PrDD/XZi3UtRuP0NeHu1srRMT3nbicCr9HvO8weL3pJ0Zd4G+4Cly3Q==
X-Gm-Gg: ASbGncuTl58fEskaVvQRyzCcAeDtsCIgyvR6Y0jPhhMFPRwB4He3jPB7uRVtIaOWb+s
	2YZ5zdYtX75+27t2VyZpb/dF7gPhBQn4WR/QCXtxacxMpOobqoh8uEu0/fkLqVe4OsbgA+zsQZ5
	1UVnUNTpZPprf1fS05foCc0IYIJb69Z7d+VuWkZMF67kFnIuXtJieAEEUeOnvEsF/mQk+H+2gUA
	p6dsIzMOOaVL3PyU2afevVXHMl7qGVsXIMA4tmCRCgIJxx8h9D086CBDgfo4LCJ0GnN
X-Received: by 2002:a05:600c:4ed2:b0:42c:b8c9:16c8 with SMTP id 5b1f17b1804b1-43669a22d92mr28015155e9.10.1734707155418;
        Fri, 20 Dec 2024 07:05:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEA3RoTKqANOqPh3kdl3/DmZtiwQwHvoKzwxmqEXJa0WzZ8DD4iV3i7Tp25oxjuIwT5rynaqw==
X-Received: by 2002:a05:600c:4ed2:b0:42c:b8c9:16c8 with SMTP id 5b1f17b1804b1-43669a22d92mr28012625e9.10.1734707152926;
        Fri, 20 Dec 2024 07:05:52 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364b1516bbsm75716325e9.1.2024.12.20.07.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:05:52 -0800 (PST)
Date: Fri, 20 Dec 2024 16:05:50 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Mike Manning <mvrmanning@gmail.com>, David Gibson
 <david@gibson.dropbear.id.au>, Paul Holzinger <pholzing@redhat.com>, Philo
 Lu <lulie@linux.alibaba.com>, Cambda Zhu <cambda@linux.alibaba.com>, Fred
 Chen <fred.cc@alibaba-inc.com>, Yubing Qiu
 <yubing.qiuyubing@alibaba-inc.com>, Peter Oskolkov <posk@google.com>
Subject: Re: [PATCH net-next v2] udp: Deal with race between UDP socket
 address change and rehash
Message-ID: <20241220160550.74c1c7e0@elisabeth>
In-Reply-To: <CANn89iL4hJptSzM7KUjjUbDOHS_fwvha_569G7tX=c_GS=AT2A@mail.gmail.com>
References: <20241218162116.681734-1-sbrivio@redhat.com>
	<CANn89iL4hJptSzM7KUjjUbDOHS_fwvha_569G7tX=c_GS=AT2A@mail.gmail.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Dec 2024 15:16:42 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Wed, Dec 18, 2024 at 5:21=E2=80=AFPM Stefano Brivio <sbrivio@redhat.co=
m> wrote:
> >
> > If a UDP socket changes its local address while it's receiving
> > datagrams, as a result of connect(), there is a period during which
> > a lookup operation might fail to find it, after the address is changed
> > but before the secondary hash (port and address) and the four-tuple
> > hash (local and remote ports and addresses) are updated.
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
> >   LEN=3D$(($(cat /proc/sys/net/core/wmem_default) / 4))
> >   dd if=3D/dev/urandom bs=3D1 count=3D${LEN} of=3Dtmp.in
> >
> >   while :; do
> >         taskset -c 1 socat UDP4-LISTEN:1337,null-eof OPEN:tmp.out,creat=
e,trunc &
> >         sleep 0.1 || sleep 1
> >         taskset -c 2 socat OPEN:tmp.in UDP4:localhost:1337,shut-null
> >         wait
> >   done
> >
> > where the client will eventually get ECONNREFUSED on a write()
> > (typically the second or third one of a given iteration):
> >
> >   2024/11/13 21:28:23 socat[46901] E write(6, 0x556db2e3c000, 8192): Co=
nnection refused
> >
> > This issue was first observed as a seldom failure in Podman's tests
> > checking UDP functionality while using pasta(1) to connect the
> > container's network namespace, which leads us to a reproducer with
> > the lookup error resulting in an ICMP packet on a tap device:
> >
> >   LOCAL_ADDR=3D"$(ip -j -4 addr show|jq -rM '.[] | .addr_info[0] | sele=
ct(.scope =3D=3D "global").local')"
> >
> >   while :; do
> >         ./pasta --config-net -p pasta.pcap -u 1337 socat UDP4-LISTEN:13=
37,null-eof OPEN:tmp.out,create,trunc &
> >         sleep 0.2 || sleep 1
> >         socat OPEN:tmp.in UDP4:${LOCAL_ADDR}:1337,shut-null
> >         wait
> >         cmp tmp.in tmp.out
> >   done
> >
> > Once this fails:
> >
> >   tmp.in tmp.out differ: char 8193, line 29
> >
> > we can finally have a look at what's going on:
> >
> >   $ tshark -r pasta.pcap
> >       1   0.000000           :: ? ff02::16     ICMPv6 110 Multicast Lis=
tener Report Message v2
> >       2   0.168690 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Le=
n=3D8192
> >       3   0.168767 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Le=
n=3D8192
> >       4   0.168806 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Le=
n=3D8192
> >       5   0.168827 c6:47:05:8d:dc:04 ? Broadcast    ARP 42 Who has 88.1=
98.0.161? Tell 88.198.0.164
> >       6   0.168851 9a:55:9a:55:9a:55 ? c6:47:05:8d:dc:04 ARP 42 88.198.=
0.161 is at 9a:55:9a:55:9a:55
> >       7   0.168875 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Le=
n=3D8192
> >       8   0.168896 88.198.0.164 ? 88.198.0.161 ICMP 590 Destination unr=
eachable (Port unreachable)
> >       9   0.168926 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Le=
n=3D8192
> >      10   0.168959 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Le=
n=3D8192
> >      11   0.168989 88.198.0.161 ? 88.198.0.164 UDP 4138 60260 ? 1337 Le=
n=3D4096
> >      12   0.169010 88.198.0.161 ? 88.198.0.164 UDP 42 60260 ? 1337 Len=
=3D0
> >
> > On the third datagram received, the network namespace of the container
> > initiates an ARP lookup to deliver the ICMP message.
> >
> > In another variant of this reproducer, starting the client with:
> >
> >   strace -f pasta --config-net -u 1337 socat UDP4-LISTEN:1337,null-eof =
OPEN:tmp.out,create,trunc 2>strace.log &
> >
> > and connecting to the socat server using a loopback address:
> >
> >   socat OPEN:tmp.in UDP4:localhost:1337,shut-null
> >
> > we can more clearly observe a sendmmsg() call failing after the
> > first datagram is delivered:
> >
> >   [pid 278012] connect(173, 0x7fff96c95fc0, 16) =3D 0
> >   [...]
> >   [pid 278012] recvmmsg(173, 0x7fff96c96020, 1024, MSG_DONTWAIT, NULL) =
=3D -1 EAGAIN (Resource temporarily unavailable)
> >   [pid 278012] sendmmsg(173, 0x561c5ad0a720, 1, MSG_NOSIGNAL) =3D 1
> >   [...]
> >   [pid 278012] sendmmsg(173, 0x561c5ad0a720, 1, MSG_NOSIGNAL) =3D -1 EC=
ONNREFUSED (Connection refused)
> >
> > and, somewhat confusingly, after a connect() on the same socket
> > succeeded.
> >
> > Until commit 4cdeeee9252a ("net: udp: prefer listeners bound to an
> > address"), the race between receive address change and lookup didn't
> > actually cause visible issues, because, once the lookup based on the
> > secondary hash chain failed, we would still attempt a lookup based on
> > the primary hash (destination port only), and find the socket with the
> > outdated secondary hash.
> >
> > That change, however, dropped port-only lookups altogether, as side
> > effect, making the race visible.
> >
> > To fix this, while avoiding the need to make address changes and
> > rehash atomic against lookups, reintroduce primary hash lookups as
> > fallback, if lookups based on four-tuple and secondary hashes fail.
> >
> > To this end, introduce a simplified lookup implementation, which
> > doesn't take care of SO_REUSEPORT groups: if we have one, there are
> > multiple sockets that would match the four-tuple or secondary hash,
> > meaning that we can't run into this race at all.
> >
> > v2:
> >   - instead of synchronising lookup operations against address change
> >     plus rehash, reintroduce a simplified version of the original
> >     primary hash lookup as fallback
> >
> > v1:
> >   - fix build with CONFIG_IPV6=3Dn: add ifdef around sk_v6_rcv_saddr
> >     usage (Kuniyuki Iwashima)
> >   - directly use sk_rcv_saddr for IPv4 receive addresses instead of
> >     fetching inet_rcv_saddr (Kuniyuki Iwashima)
> >   - move inet_update_saddr() to inet_hashtables.h and use that
> >     to set IPv4/IPv6 addresses as suitable (Kuniyuki Iwashima)
> >   - rebase onto net-next, update commit message accordingly
> >
> > Reported-by: Ed Santiago <santiago@redhat.com>
> > Link: https://github.com/containers/podman/issues/24147
> > Analysed-by: David Gibson <david@gibson.dropbear.id.au>
> > Fixes: 30fff9231fad ("udp: bind() optimisation")
> > Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> > --- =20
>=20
> I think this should work. Another solution would have been to add a
> sequence to each UDP socket.
>=20
> Fixes: tag probably could refer to 4cdeeee9252a ("net: udp: prefer
> listeners bound to an address"), because your patch
> is partially kind-of reverting it.

I was actually a bit undecided because, conceptually, the race condition
itself was added by 30fff9231fad. On the other hand, it can't really be
called a race without 4cdeeee9252a, because by itself it was a mere
optimisation not affecting the result of the lookup.

And on a second thought, perhaps more relevant for backports, there's
no issue without 4cdeeee9252a. So yeah, I guess you're right, the tag
should be amended to:

Fixes: 4cdeeee9252a ("net: udp: prefer listeners bound to an address")

> Reviewed-by: Eric Dumazet <edumazet@google.com>
>=20
> I will post additional patches for net-next to better take care of
> data-races in compute_score()

Ah, right, thanks, those are potentially nasty as well.

--=20
Stefano


