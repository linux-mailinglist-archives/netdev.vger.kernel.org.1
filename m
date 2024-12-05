Return-Path: <netdev+bounces-149461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C64E9E5B8C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3243628A64C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C65E21D589;
	Thu,  5 Dec 2024 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGPSLhtl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2B4192B63
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416567; cv=none; b=g3jOEPGk6WiN80LgzE6iThW4T6/nnMqKgljH3iYAXD1G/WEMFzlZneifmc/aA05K1he6ayPCQKQrk0kQZrXQo4v5LuXrWrdb3wf8IMGq6gj1eaWUdrlKzpMmQnbpAvVgHGTlLznqqr+IjdksQT2WD1eRqGhDBTKKpkWCpCfYxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416567; c=relaxed/simple;
	bh=nDMenWyhMBbhCiWSPmoRRBvSQM290uTWwfWO2pMdEs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUB74LeTLklQgLFBlJECNs6tJsZbloFoIHCqKOftCURonwLfUzEO8ARoKTwOv653C6WIe+TCO1ziG+wGJkuw1Ij8p7Y8u7fOUtUB+SDZ5/ifVgU/4CsNib0JrpeJYV+FhwSCDDMy6C17d3HCGYsAlTIGplFZhxnM5G1S7j2VUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGPSLhtl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so154135866b.3
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 08:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733416564; x=1734021364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzwAFCeMz7adF7peCKjJfhPicAWNbBcmbD9/5ww0TQM=;
        b=jGPSLhtlRs+/yTnPtIE9Q5jF9zk+19B9ggTe6NXdAclDah4ZdPhq/n739ox+65ECCQ
         VfIOSL9ZvKgWa9QKDoRxjomgdmfUbWdsMrAQi4Z7mdIVu4Dv4Fu4OXXU2hG8B6HUCT0I
         OwDGOeuoKlE6fC/kV3GJ/+yUaoqNGogyYck51Zvoeo+fBaYVnSb98NRF74I9AG8e9LgY
         pYRdRdERcYKDM5ftG6Debng+Dh4CF3AeR4RoyvMk7HKzFM8RqaL/mrbJPcqCF3PM/DPu
         xRyX4KlBUVLOnyI4GWk7q6ELdiSS1ZUWH+Dh1V7FQQVHPyBhoJg4ARaLk5YVxI0hRS9+
         Kl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733416564; x=1734021364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzwAFCeMz7adF7peCKjJfhPicAWNbBcmbD9/5ww0TQM=;
        b=HEuvKTstTnJ3S4GDnMTsGARzOSm5tAKTTkdZi9vtFMSToT9gWqj5i/4GGeNJWyDz6+
         1WpDwe/O6ZVej8BYaktkhO9OOM10Dsl04BVSn/XmJF37WeET9jkDSTnEKb0CieCaDMJl
         NBy1o75IHJJvD/T6ej2ZP+Vib1O+wxQ+8TQM21RwIEVVGHmdp6QDx1g9xqJZvVVo3Wao
         V+Z9h7GseOdbZOnKae9BeNTgaxowU3WD2kkdGcE3vpktXQgsPNCSkRBwngTGlLEos50F
         EuD0o5Yk5vS8Ob7tSL7WLOihr7cBA8yaxwulWpyNg0rs71r/TjFYTkWi5ww381eTdzpq
         TWZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzi5O4a4ELO9mzeqaXJl3OblgHLMgmkMHV25sM+0rN+pjHCTdjVMKMONKE/Mx+6n7yS9RGXvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM4OlKk0zLmtStYTJpIJulWg++3PXzGP6iSXVXKRFyByv8PgxS
	z2wUuxbww3Dgg0laX7eX2yNfMUWCcAWYaCbnQdFcG1XIfYN+L4banBFAdJgKUHGbhVi5IKdbRsj
	MC92g/7kdiayJT8/l60tMGTHVNvixJr9bkyfD
X-Gm-Gg: ASbGncvvYOatN9z5dzt74ro4xmUd3puHWjBL9K6iIEVBMDzAMlsim4XYQFxyPAgT++3
	pedB0iK4twpYjgLmDIRWmhNCCjaamIg==
X-Google-Smtp-Source: AGHT+IHu5T4y6VN6Mmfm5r71B73dqH6JzaQ0IXKFWgYEs6fEFrcsZGjwhQgQ3+6fBweUm2Jpxdf0UubrS2Sb5A9uK0s=
X-Received: by 2002:a05:6402:2553:b0:5cf:dfaf:d5f2 with SMTP id
 4fb4d7f45d1cf-5d10cb5644dmr15967046a12.9.1733416563870; Thu, 05 Dec 2024
 08:36:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221254.3537932-1-sbrivio@redhat.com> <20241204221254.3537932-3-sbrivio@redhat.com>
In-Reply-To: <20241204221254.3537932-3-sbrivio@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Dec 2024 17:35:52 +0100
Message-ID: <CANn89i+iULeqTO2GrTCDZEOKPmU_18zwRxG6-P1XoqhP_j1p3A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] datagram, udp: Set local address and rehash
 socket atomically against lookup
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Mike Manning <mvrmanning@gmail.com>, 
	David Gibson <david@gibson.dropbear.id.au>, Paul Holzinger <pholzing@redhat.com>, 
	Philo Lu <lulie@linux.alibaba.com>, Cambda Zhu <cambda@linux.alibaba.com>, 
	Fred Chen <fred.cc@alibaba-inc.com>, Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:12=E2=80=AFPM Stefano Brivio <sbrivio@redhat.com>=
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
> To fix this, replace the rehash operation by a set_rcv_saddr()
> callback holding the spinlock on the primary hash chain, just like
> the rehash operation used to do, but also setting the address (via
> inet_update_saddr(), moved to headers) while holding the spinlock.
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
>  include/net/inet_hashtables.h | 13 ++++++
>  include/net/sock.h            |  2 +-
>  include/net/udp.h             |  3 +-
>  net/core/sock.c               | 12 ++++-
>  net/ipv4/datagram.c           |  7 +--
>  net/ipv4/inet_hashtables.c    | 13 ------
>  net/ipv4/udp.c                | 84 +++++++++++++++++++++++------------
>  net/ipv4/udp_impl.h           |  2 +-
>  net/ipv4/udplite.c            |  2 +-
>  net/ipv6/datagram.c           | 30 +++++++++----
>  net/ipv6/udp.c                | 31 +++++++------
>  net/ipv6/udp_impl.h           |  2 +-
>  net/ipv6/udplite.c            |  2 +-
>  13 files changed, 130 insertions(+), 73 deletions(-)
>
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.=
h
> index 5eea47f135a4..7f05e7ebc2e4 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -525,6 +525,19 @@ static inline void sk_rcv_saddr_set(struct sock *sk,=
 __be32 addr)
>  #endif
>  }
>
> +static inline void inet_update_saddr(struct sock *sk, void *saddr, int f=
amily)
> +{
> +       if (family =3D=3D AF_INET) {
> +               inet_sk(sk)->inet_saddr =3D *(__be32 *)saddr;
> +               sk_rcv_saddr_set(sk, inet_sk(sk)->inet_saddr);
> +       }
> +#if IS_ENABLED(CONFIG_IPV6)
> +       else {
> +               sk->sk_v6_rcv_saddr =3D *(struct in6_addr *)saddr;
> +       }
> +#endif
> +}
> +
>  int __inet_hash_connect(struct inet_timewait_death_row *death_row,
>                         struct sock *sk, u64 port_offset,
>                         int (*check_established)(struct inet_timewait_dea=
th_row *,
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 7464e9f9f47c..1410036e4f5a 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1228,6 +1228,7 @@ struct proto {
>         int                     (*connect)(struct sock *sk,
>                                         struct sockaddr *uaddr,
>                                         int addr_len);
> +       void                    (*set_rcv_saddr)(struct sock *sk, void *a=
ddr);
>         int                     (*disconnect)(struct sock *sk, int flags)=
;
>
>         struct sock *           (*accept)(struct sock *sk,
> @@ -1269,7 +1270,6 @@ struct proto {
>         /* Keeping track of sk's, looking them up, and port selection met=
hods. */
>         int                     (*hash)(struct sock *sk);
>         void                    (*unhash)(struct sock *sk);
> -       void                    (*rehash)(struct sock *sk);
>         int                     (*get_port)(struct sock *sk, unsigned sho=
rt snum);
>         void                    (*put_port)(struct sock *sk);
>  #ifdef CONFIG_BPF_SYSCALL
> diff --git a/include/net/udp.h b/include/net/udp.h
> index 6e89520e100d..8283ea5768de 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -302,7 +302,6 @@ static inline int udp_lib_hash(struct sock *sk)
>  }
>
>  void udp_lib_unhash(struct sock *sk);
> -void udp_lib_rehash(struct sock *sk, u16 new_hash, u16 new_hash4);
>  u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 l=
port,
>                 const __be32 faddr, const __be16 fport);
>
> @@ -411,6 +410,8 @@ int udp_rcv(struct sk_buff *skb);
>  int udp_ioctl(struct sock *sk, int cmd, int *karg);
>  int udp_init_sock(struct sock *sk);
>  int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_le=
n);
> +void udp_lib_set_rcv_saddr(struct sock *sk, void *addr, u16 hash, u16 ha=
sh4);
> +int udp_set_rcv_saddr(struct sock *sk, void *addr);
>  int __udp_disconnect(struct sock *sk, int flags);
>  int udp_disconnect(struct sock *sk, int flags);
>  __poll_t udp_poll(struct file *file, struct socket *sock, poll_table *wa=
it);
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 74729d20cd00..221c904d870d 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -641,8 +641,16 @@ static int sock_bindtoindex_locked(struct sock *sk, =
int ifindex)
>         /* Paired with all READ_ONCE() done locklessly. */
>         WRITE_ONCE(sk->sk_bound_dev_if, ifindex);
>
> -       if (sk->sk_prot->rehash)
> -               sk->sk_prot->rehash(sk);
> +       /* Force rehash if protocol needs it */
> +       if (sk->sk_prot->set_rcv_saddr) {
> +               if (sk->sk_family =3D=3D AF_INET)
> +                       sk->sk_prot->set_rcv_saddr(sk, &sk->sk_rcv_saddr)=
;
> +#if IS_ENABLED(CONFIG_IPV6)
> +               else if (sk->sk_family =3D=3D AF_INET6)
> +                       sk->sk_prot->set_rcv_saddr(sk, &sk->sk_v6_rcv_sad=
dr);
> +#endif
> +       }
> +
>         sk_dst_reset(sk);
>
>         ret =3D 0;
> diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
> index d52333e921f3..3ea3fa94c127 100644
> --- a/net/ipv4/datagram.c
> +++ b/net/ipv4/datagram.c
> @@ -64,9 +64,10 @@ int __ip4_datagram_connect(struct sock *sk, struct soc=
kaddr *uaddr, int addr_len
>         if (!inet->inet_saddr)
>                 inet->inet_saddr =3D fl4->saddr;  /* Update source addres=
s */
>         if (!inet->inet_rcv_saddr) {
> -               inet->inet_rcv_saddr =3D fl4->saddr;
> -               if (sk->sk_prot->rehash && sk->sk_family =3D=3D AF_INET)
> -                       sk->sk_prot->rehash(sk);
> +               if (sk->sk_prot->set_rcv_saddr && sk->sk_family =3D=3D AF=
_INET)
> +                       sk->sk_prot->set_rcv_saddr(sk, &fl4->saddr);
> +               else
> +                       inet->inet_rcv_saddr =3D fl4->saddr;
>         }
>         inet->inet_daddr =3D fl4->daddr;
>         inet->inet_dport =3D usin->sin_port;
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 9bfcfd016e18..74e6a3604bcf 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -874,19 +874,6 @@ inet_bhash2_addr_any_hashbucket(const struct sock *s=
k, const struct net *net, in
>         return &hinfo->bhash2[hash & (hinfo->bhash_size - 1)];
>  }
>
> -static void inet_update_saddr(struct sock *sk, void *saddr, int family)
> -{
> -       if (family =3D=3D AF_INET) {
> -               inet_sk(sk)->inet_saddr =3D *(__be32 *)saddr;
> -               sk_rcv_saddr_set(sk, inet_sk(sk)->inet_saddr);
> -       }
> -#if IS_ENABLED(CONFIG_IPV6)
> -       else {
> -               sk->sk_v6_rcv_saddr =3D *(struct in6_addr *)saddr;
> -       }
> -#endif
> -}
> -
>  static int __inet_bhash2_update_saddr(struct sock *sk, void *saddr, int =
family, bool reset)
>  {
>         struct inet_hashinfo *hinfo =3D tcp_or_dccp_get_hashinfo(sk);
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 6a01905d379f..8490408f6009 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -639,18 +639,21 @@ struct sock *__udp4_lib_lookup(const struct net *ne=
t, __be32 saddr,
>                 int sdif, struct udp_table *udptable, struct sk_buff *skb=
)
>  {
>         unsigned short hnum =3D ntohs(dport);
> -       struct udp_hslot *hslot2;
> +       struct udp_hslot *hslot, *hslot2;
>         struct sock *result, *sk;
>         unsigned int hash2;
>
> +       hslot =3D udp_hashslot(udptable, net, hnum);
> +       spin_lock_bh(&hslot->lock);

This is not acceptable.
UDP is best effort, packets can be dropped.
Please fix user application expectations.

