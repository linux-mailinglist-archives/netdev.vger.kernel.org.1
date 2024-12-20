Return-Path: <netdev+bounces-153702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D90D9F941A
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8D17A367B
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5652215764;
	Fri, 20 Dec 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCiuAdLD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC983186607
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704217; cv=none; b=A96CAowGE79Enx0t2GxCektm5sEg57Wj93BkuOOaLNld18uWQd84HVakTE6rITumKgVezDPfv1Nnrd6/ROqPVE+g3JvTzF/OBs9caSD4fkzqxhPHMDdluicl53NuDoD46OIyIkj2jILv8FQ1LytBm3YhWeow2/mzAo8/AwjLv/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704217; c=relaxed/simple;
	bh=ZNixlel1Wgl89ImeCjmGign5P1vgWG7xsf6dd3jFclE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTEZY/SnH5eBEQuSNyNDGgolNEEG1RU7UhvrjPchze1gBQzggbR2DNqoLvpNwks9RCm/rcoh7/aY6PIRH0BBkaPpaWmFntfCOL5d0pffXVb0b1i3nErchC/BtxjO8OBkF71J1hy8qiRbkQqOtPE1o2uaAn75UTHbjz+zvHW2U8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oCiuAdLD; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so2654099a12.0
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 06:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734704214; x=1735309014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd+p6RlLVZyzuGKTLNFNczVgzdaevQwx74B9+dMUIcA=;
        b=oCiuAdLDdgPKxC/2p7Saow9Ti+YfhdAd5mpiolRR9h+8qkaCGP95BZ0AKNuYZUAoiQ
         hUrkclexQ2BTGbeTwidmKkqTxYeyMXaBz6wHFMSwXpjP66gMVPpSivO37iwg3wHhmxwU
         o5WUaTQHHkwNG08KKgtRIdD0IoD46WYyWk5NzlVajmWIJeacAIFSj+IJ7KizuUHHAtlr
         uT+D06ahxcqHupSxBpLnbZoXkSvHrwJoVN5Z5um2tWI2H6WNXUx/t0aiOxMrnWE2Ao0t
         eFbDaFLIb06xoiXbzAoL/ZnrlnEhy0Kl4js+zqiBjLepuIZbKbJYaPf8xRzChw95yJxU
         n6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734704214; x=1735309014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd+p6RlLVZyzuGKTLNFNczVgzdaevQwx74B9+dMUIcA=;
        b=oyIWsk3oQve+N2TbaMvlXBjo61KX6FH22UP3hnAL2CjXhs+S7f6MsLfW/dgz43ThXm
         HzKbcCZSWtFGp9i4M8AA4Hym/p0qMlfi/wlv7hImzIw7YBezgmIUY1ZahlYDT/wG8UTr
         aXgRu4ah0Vd8S9N6mY1uXwqMo85ykQcjuIbNO8vcg72gp8Xptu8ap5RUF8o5hlOeznad
         3nEHtgfArwTqRvjdxUv87Te6vTTmEwVoGQgiXNlKhgCNP+bf/+9R72jqEOuZhJuVZzTT
         ZF67Ht6jXNWZBRVb9iA2ALKfOAbdP47vvHX1I1RDj+Vc++2qOgHqekyqVsJGSMKqZow2
         iWqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYS0SUigueheqC+kZJxHccTR2+anj1t0MGsQfiO2zDwdAlPGXFzvqxx9g+sjq8L9zizlU139A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwomLU45x3+OkIAA5DE75JJcS2MF+8CRxbQZm6ze8jjpwLR7hxK
	B9s+qr7hyLAy3twUr281hBJ1sWYlvUer5pneSetmdM5eiFy94FY4uR3KECvNqqlS46CqzrCLONz
	bYumEdY6Tr6ac3d9JI40vEh72qbbKdMYC3V9g
X-Gm-Gg: ASbGncsnQ2Qk7MZdi0rSi/BbKvcfMx3UdlmucVNKe7SwzDnVsk2fKm6dsW9q9V9xPVH
	R93DZ7VeotlYnfa4ZEEuxxDK8535XLKr5eU5bFw==
X-Google-Smtp-Source: AGHT+IE5gqk3P2/Ih3zI9VWeCMpC1df2p4hcSDcpHGmWaU4BMZzINp1ECSdryBjQHq2hF4UmBisUt2Cs9G/4lFr62Ns=
X-Received: by 2002:a05:6402:3549:b0:5d3:ce7f:abee with SMTP id
 4fb4d7f45d1cf-5d81ddffac3mr2329514a12.25.1734704213839; Fri, 20 Dec 2024
 06:16:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218162116.681734-1-sbrivio@redhat.com>
In-Reply-To: <20241218162116.681734-1-sbrivio@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 20 Dec 2024 15:16:42 +0100
Message-ID: <CANn89iL4hJptSzM7KUjjUbDOHS_fwvha_569G7tX=c_GS=AT2A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] udp: Deal with race between UDP socket
 address change and rehash
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Mike Manning <mvrmanning@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, 
	Paul Holzinger <pholzing@redhat.com>, Philo Lu <lulie@linux.alibaba.com>, 
	Cambda Zhu <cambda@linux.alibaba.com>, Fred Chen <fred.cc@alibaba-inc.com>, 
	Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>, Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 5:21=E2=80=AFPM Stefano Brivio <sbrivio@redhat.com>=
 wrote:
>
> If a UDP socket changes its local address while it's receiving
> datagrams, as a result of connect(), there is a period during which
> a lookup operation might fail to find it, after the address is changed
> but before the secondary hash (port and address) and the four-tuple
> hash (local and remote ports and addresses) are updated.
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
>   LEN=3D$(($(cat /proc/sys/net/core/wmem_default) / 4))
>   dd if=3D/dev/urandom bs=3D1 count=3D${LEN} of=3Dtmp.in
>
>   while :; do
>         taskset -c 1 socat UDP4-LISTEN:1337,null-eof OPEN:tmp.out,create,=
trunc &
>         sleep 0.1 || sleep 1
>         taskset -c 2 socat OPEN:tmp.in UDP4:localhost:1337,shut-null
>         wait
>   done
>
> where the client will eventually get ECONNREFUSED on a write()
> (typically the second or third one of a given iteration):
>
>   2024/11/13 21:28:23 socat[46901] E write(6, 0x556db2e3c000, 8192): Conn=
ection refused
>
> This issue was first observed as a seldom failure in Podman's tests
> checking UDP functionality while using pasta(1) to connect the
> container's network namespace, which leads us to a reproducer with
> the lookup error resulting in an ICMP packet on a tap device:
>
>   LOCAL_ADDR=3D"$(ip -j -4 addr show|jq -rM '.[] | .addr_info[0] | select=
(.scope =3D=3D "global").local')"
>
>   while :; do
>         ./pasta --config-net -p pasta.pcap -u 1337 socat UDP4-LISTEN:1337=
,null-eof OPEN:tmp.out,create,trunc &
>         sleep 0.2 || sleep 1
>         socat OPEN:tmp.in UDP4:${LOCAL_ADDR}:1337,shut-null
>         wait
>         cmp tmp.in tmp.out
>   done
>
> Once this fails:
>
>   tmp.in tmp.out differ: char 8193, line 29
>
> we can finally have a look at what's going on:
>
>   $ tshark -r pasta.pcap
>       1   0.000000           :: ? ff02::16     ICMPv6 110 Multicast Liste=
ner Report Message v2
>       2   0.168690 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=
=3D8192
>       3   0.168767 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=
=3D8192
>       4   0.168806 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=
=3D8192
>       5   0.168827 c6:47:05:8d:dc:04 ? Broadcast    ARP 42 Who has 88.198=
.0.161? Tell 88.198.0.164
>       6   0.168851 9a:55:9a:55:9a:55 ? c6:47:05:8d:dc:04 ARP 42 88.198.0.=
161 is at 9a:55:9a:55:9a:55
>       7   0.168875 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=
=3D8192
>       8   0.168896 88.198.0.164 ? 88.198.0.161 ICMP 590 Destination unrea=
chable (Port unreachable)
>       9   0.168926 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=
=3D8192
>      10   0.168959 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=
=3D8192
>      11   0.168989 88.198.0.161 ? 88.198.0.164 UDP 4138 60260 ? 1337 Len=
=3D4096
>      12   0.169010 88.198.0.161 ? 88.198.0.164 UDP 42 60260 ? 1337 Len=3D=
0
>
> On the third datagram received, the network namespace of the container
> initiates an ARP lookup to deliver the ICMP message.
>
> In another variant of this reproducer, starting the client with:
>
>   strace -f pasta --config-net -u 1337 socat UDP4-LISTEN:1337,null-eof OP=
EN:tmp.out,create,trunc 2>strace.log &
>
> and connecting to the socat server using a loopback address:
>
>   socat OPEN:tmp.in UDP4:localhost:1337,shut-null
>
> we can more clearly observe a sendmmsg() call failing after the
> first datagram is delivered:
>
>   [pid 278012] connect(173, 0x7fff96c95fc0, 16) =3D 0
>   [...]
>   [pid 278012] recvmmsg(173, 0x7fff96c96020, 1024, MSG_DONTWAIT, NULL) =
=3D -1 EAGAIN (Resource temporarily unavailable)
>   [pid 278012] sendmmsg(173, 0x561c5ad0a720, 1, MSG_NOSIGNAL) =3D 1
>   [...]
>   [pid 278012] sendmmsg(173, 0x561c5ad0a720, 1, MSG_NOSIGNAL) =3D -1 ECON=
NREFUSED (Connection refused)
>
> and, somewhat confusingly, after a connect() on the same socket
> succeeded.
>
> Until commit 4cdeeee9252a ("net: udp: prefer listeners bound to an
> address"), the race between receive address change and lookup didn't
> actually cause visible issues, because, once the lookup based on the
> secondary hash chain failed, we would still attempt a lookup based on
> the primary hash (destination port only), and find the socket with the
> outdated secondary hash.
>
> That change, however, dropped port-only lookups altogether, as side
> effect, making the race visible.
>
> To fix this, while avoiding the need to make address changes and
> rehash atomic against lookups, reintroduce primary hash lookups as
> fallback, if lookups based on four-tuple and secondary hashes fail.
>
> To this end, introduce a simplified lookup implementation, which
> doesn't take care of SO_REUSEPORT groups: if we have one, there are
> multiple sockets that would match the four-tuple or secondary hash,
> meaning that we can't run into this race at all.
>
> v2:
>   - instead of synchronising lookup operations against address change
>     plus rehash, reintroduce a simplified version of the original
>     primary hash lookup as fallback
>
> v1:
>   - fix build with CONFIG_IPV6=3Dn: add ifdef around sk_v6_rcv_saddr
>     usage (Kuniyuki Iwashima)
>   - directly use sk_rcv_saddr for IPv4 receive addresses instead of
>     fetching inet_rcv_saddr (Kuniyuki Iwashima)
>   - move inet_update_saddr() to inet_hashtables.h and use that
>     to set IPv4/IPv6 addresses as suitable (Kuniyuki Iwashima)
>   - rebase onto net-next, update commit message accordingly
>
> Reported-by: Ed Santiago <santiago@redhat.com>
> Link: https://github.com/containers/podman/issues/24147
> Analysed-by: David Gibson <david@gibson.dropbear.id.au>
> Fixes: 30fff9231fad ("udp: bind() optimisation")
> Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> ---

I think this should work. Another solution would have been to add a
sequence to each UDP socket.

Fixes: tag probably could refer to 4cdeeee9252a ("net: udp: prefer
listeners bound to an address"), because your patch
is partially kind-of reverting it.

Reviewed-by: Eric Dumazet <edumazet@google.com>

I will post additional patches for net-next to better take care of
data-races in compute_score()

