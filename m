Return-Path: <netdev+bounces-147447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBE49D9922
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 15:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C04283DE7
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9621D54E9;
	Tue, 26 Nov 2024 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yzFGhiId"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D83D528
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732630080; cv=none; b=NtlEf/dldP9w4nn80/mgKoJjgNLtauC+CtyNyBHGLQIbnnlE/2PG6X+xMDbofXV0mb+GLCgsOv84gHkMjDxtQ0Vxfny+pjuzWyXNS/QrGV9CjYEOU43iLKJn3+k+UgN/Rr1WiPrzj/4gAmekni4MWVjwOMhbYQanJvG08cbIelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732630080; c=relaxed/simple;
	bh=gFQ5yHEYHvIKUkrrm/GSqctCFGCa8JrNsvEB3xV7HsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/TvvLeYHqY/QA/S9QkPILSMKLU4pjE2n0t/JyYgAXdzGdYztq73+oqWGmaJc47gT7m6O16CsejZXj3blmzj0gzB3g0DfMzBqbIIayRlqSbXr+YkjqJCoVJcOF7wnp+N3kYL2VTLKg8Nav3CBFyrsuk43qEYuSTQFLgBaCU2Mt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yzFGhiId; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cfcb7183deso11241970a12.0
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 06:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732630076; x=1733234876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZCsr06D9wZEIDINxYTNXC9eksP+P64uSOKwHbPdoRM=;
        b=yzFGhiIdtX/XwwiRo6REJ7pkf+ONvEfdu1zzJYRYC+AZBftcp2o6BzsOtKjVSO0MEb
         3uc3yx8KzVF2QSGulTtz4LI+PsO6YKWe1qFmsZV0yOunhcVE3quF/nEl50MiLI2BrLR9
         EugyoxAlioXeW+0CBnLckUzZ+c3N/CXqDkVRs9HQD30mJUwxhMQGTbd5PWJrswVAOvMI
         DNnlT9jobRLtBN3izMV5ge50X85nkIRwvsNpSgpPE6WXaUIe0kX387zbZwkY/bS6nnxf
         C+0x1Oc9deaDiyhPriGebynD7NKRbBMvCRmQ6whZdSZUgLaX8xClj7/7zcwY6mD6oLw9
         YASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732630076; x=1733234876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZCsr06D9wZEIDINxYTNXC9eksP+P64uSOKwHbPdoRM=;
        b=mkyLbSiy9Xgq6VjdGB8HSPG86ucZaUbdTBZNFfLGlnJtGXM+JwjDhxNKIXckNj3+ml
         mGU6zA9LhHsQIPkCz/xFmLtDA+vvUXxDObXeIhKgo7Pd1sTwJCy1iY5N6Q+BiqfP4+ht
         WNk6n4CyG2YhHyU59k+8GiNiI4JNzry1TCNzY+QdyikYxGrXLUgVU5+kjIR2g0nvUcOu
         X/59wM+aXd0qYiaPK71LGL1ynNoCoNU6rbfSF+WA2I3+TtXhzLBBPVpz6TQjmWgCHs9w
         C0wueOh4LK0un1XCcGKlWgYawqa5pfFODwl4Fsf0AGaznMMQ5qk/O0YZ2yw/SVE2ZRfR
         D8lg==
X-Gm-Message-State: AOJu0Yz1V7Lc7JKw5XyyMKFfnT7ccLdOPGbScpnXNLc3q7Y0688/M5Ka
	8TOR/DD8V0dVP0uVnrhfcFZivyutjP+D0StnT6Jak1zZwWQspHvCrtj53Z1o0DuYpr4wbM1pgTh
	1ZAWyt6NTj3ujXC21owrMglYUFEpJlMr4PviU
X-Gm-Gg: ASbGncuab4A4Ei8VeQrswAn1MtqaUv04qLNIIOCF1ww0hlxqgYVWOgyuxTBB20Cb7vN
	Yhumnv7HR61YTo24O0kS4v+afz62PzjnM
X-Google-Smtp-Source: AGHT+IGW3DUBSyC7gnWkBjFG2ZRFoXIc3uCG3PVEWJq2FHMZYNz29AvFBrqbcYF9Q+RnehfT1f88bNG2nNWLv8t2tGQ=
X-Received: by 2002:a17:907:3da3:b0:aa5:4acb:b06c with SMTP id
 a640c23a62f3a-aa56497082bmr308473466b.24.1732630075988; Tue, 26 Nov 2024
 06:07:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113105611.GA6723@incl>
In-Reply-To: <20241113105611.GA6723@incl>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Nov 2024 15:07:44 +0100
Message-ID: <CANn89iJXAFzgm27m=Df+AsmEPCoLpkXTgCf896FpjQkrz_f_Nw@mail.gmail.com>
Subject: Re: [PATCH net] net/ipv6: release expired exception dst cached in socket
To: Jiri Wiesner <jwiesner@suse.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xin Long <lucien.xin@gmail.com>, yousaf.kaukab@suse.com, andreas.taschner@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 11:56=E2=80=AFAM Jiri Wiesner <jwiesner@suse.de> wr=
ote:
>
> Dst objects get leaked in ip6_negative_advice() when this function is
> executed for an expired IPv6 route located in the exception table. There
> are several conditions that must be fulfilled for the leak to occur:
> * an ICMPv6 packet indicating a change of the MTU for the path is receive=
d
> * a TCP connection that uses the exception dst for routing packets must
>   start timing out so that TCP begins retransmissions
> * after the exception dst expires, the FIB6 garbage collector must not ru=
n
>   before TCP executes ip6_negative_advice() for the expired exception dst
>
> The following steps reproduce the issue:
>
> ip link add veth1 mtu 65535 type veth peer veth0 mtu 65535
> ip netns add ns0
> ip link set veth1 netns ns0
> ip addr add fd00::1/24 dev veth0
> ip -n ns0 addr add fd00::2/24 dev veth1
> ip link set up dev veth0
> ip -n ns0 link set up dev lo
> ip -n ns0 link set up dev veth1
> ip -n ns0 route add default via fd00::1 dev veth1
>
> ip link add veth3 mtu 65535 type veth peer veth2 mtu 65535
> ip netns add ns2
> ip link set veth3 netns ns2
> ip addr add fd02::1/24 dev veth2
> ip -n ns2 addr add fd02::2/24 dev veth3
> ip link set up dev veth2
> ip -n ns2 link set up dev lo
> ip -n ns2 link set up dev veth3
> ip -n ns2 route add default via fd02::1 dev veth3
>
> ip netns exec ns0 bash -c "echo 6 > /proc/sys/net/ipv6/route/mtu_expires"
> ip netns exec ns0 bash -c "echo 900 > /proc/sys/net/ipv6/route/gc_interva=
l"
> sleep 30
>
> ip6tables -A FORWARD -i veth0 -d fd02::/24 -j ACCEPT
> ip6tables -A FORWARD -i veth2 -d fd00::/24 -j ACCEPT
> echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
>
> (ip netns exec ns2 netcat -6 -l -s fd02::2 -p 1234 &> /dev/null) & serv=
=3D$!
> sleep 1
> dd if=3D/dev/zero bs=3D1M | ip netns exec ns0 netcat -6 fd02::2 1234 & cl=
nt=3D$!
> sleep 1
> ip link set veth2 mtu 2000
> sleep 1
> ip6tables -D FORWARD -i veth2 -d fd00::/24 -j ACCEPT
> ip6tables -A FORWARD -i veth2 -d fd00::/24 -j DROP
>
> sleep 10
> kill $clnt $serv
> wait $serv
>
> ip6tables -D FORWARD -i veth0 -d fd02::/24 -j ACCEPT
> ip6tables -D FORWARD -i veth2 -d fd00::/24 -j DROP
>
> ip -n ns0 link set down dev lo
> ip -n ns0 link set down dev veth1
> ip -n ns0 link delete dev veth1
> ip netns delete ns0
>
> ip -n ns2 link set down dev lo
> ip -n ns2 link set down dev veth3
> ip -n ns2 link delete dev veth3
> ip netns delete ns2
>
> This trace has been created with kprobes under kernel 6.12-rc7. Upon
> receiving an ICMPv6 packet indicating an MTU change, exception dst
> 0xff3027eec766c100 is created and inserted into the IPv6 exception table:
> 3651.126884: rt6_insert_exception: (rt6_insert_exception+0x0/0x2b0) dst=
=3D0xff3027eec766c100 rcuref=3D0
> 3651.126889: <stack trace>
>  =3D> rt6_insert_exception+0x5/0x2b0
>  =3D> __ip6_rt_update_pmtu+0x1ef/0x380
>  =3D> inet6_csk_update_pmtu+0x4b/0x90
>  =3D> tcp_v6_mtu_reduced.part.22+0x34/0xc0
> The exception dst is used to route packets:
> 3651.126902: inet6_csk_route_socket: (inet6_csk_update_pmtu+0x58/0x90 <- =
inet6_csk_route_socket) dst=3D0xff3027eec766c100
> At this point, the connection has been severed and TCP starts retransmiss=
ions:
> 3652.349466: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=
=3D0xff3027ef4a0f3780 sk=3D0xff3027eeeb1f3d80
> 3652.349497: inet6_csk_route_socket: (inet6_csk_xmit+0x56/0x130 <- inet6_=
csk_route_socket) dst=3D0xff3027eec766c100
> 3652.769469: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=
=3D0xff3027ef4a0f3780 sk=3D0xff3027eeeb1f3d80
> 3652.769495: inet6_csk_route_socket: (inet6_csk_xmit+0x56/0x130 <- inet6_=
csk_route_socket) dst=3D0xff3027eec766c100
> 3653.596135: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=
=3D0xff3027ef4a0f3780 sk=3D0xff3027eeeb1f3d80
> 3653.596156: inet6_csk_route_socket: (inet6_csk_xmit+0x56/0x130 <- inet6_=
csk_route_socket) dst=3D0xff3027eec766c100
> 3655.249465: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=
=3D0xff3027ef4a0f3780 sk=3D0xff3027eeeb1f3d80
> 3655.249490: inet6_csk_route_socket: (inet6_csk_xmit+0x56/0x130 <- inet6_=
csk_route_socket) dst=3D0xff3027eec766c100
> 3658.689463: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=
=3D0xff3027ef4a0f3780 sk=3D0xff3027eeeb1f3d80
> When ip6_negative_advice() is executed the refcount is 2 - the increment
> made by dst_init() and the increment made by the socket:
> 3658.689475: ip6_negative_advice: (ip6_negative_advice+0x0/0xa0) net=3D0x=
ff3027ef4a0f3780 sk=3D0xff3027eeeb1f3d80 dst=3D0xff3027eec766c100 rcuref=3D=
1
> This is the result of dst_hold() and sk_dst_reset() in ip6_negative_advic=
e():
> 3658.689477: dst_release: (dst_release+0x0/0x80) dst=3D0xff3027eec766c100=
 rcuref=3D2
> 3658.689498: rt6_remove_exception_rt: (rt6_remove_exception_rt+0x0/0xa0) =
dst=3D0xff3027eec766c100 rcuref=3D1
> 3658.689501: rt6_remove_exception: (rt6_remove_exception.part.58+0x0/0xe0=
) dst=3D0xff3027eec766c100 rcuref=3D1
> The refcount of dst 0xff3027eec766c100 is decremented by 1 as a result of
> removing the exception from the exception table with
> rt6_remove_exception_rt():
> 3658.689505: dst_release: (dst_release+0x0/0x80) dst=3D0xff3027eec766c100=
 rcuref=3D1
> The retransmissions continue without the exception dst being used for
> routing packets:
> 3662.352796: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=
=3D0xff3027ef00cab780 sk=3D0xff3027eeeb1f0000
> 3662.769470: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=
=3D0xff3027ef00cab780 sk=3D0xff3027eeeb1f0000
> 3663.596132: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=
=3D0xff3027ef00cab780 sk=3D0xff3027eeeb1f0000
>
> The ip6_dst_destroy() function was instrumented but there was no entry fo=
r
> dst 0xff3027eec766c100 in the trace even long after the ns0 and ns2 net
> namespaces had been destroyed. The refcount made by the socket was never
> released. The refcount of the dst is decremented in sk_dst_reset() but
> that decrement is counteracted by a dst_hold() intentionally placed just
> before the sk_dst_reset() in ip6_negative_advice(). The probem is that
> sockets that keep a reference to a dst in the sk_dst_cache member
> increment the refcount of the dst by 1. This is apparent in the following
> code paths:
> * When ip6_route_output_flags() finds a dst that is then stored in
>   sk->sk_dst_cache by ip6_dst_store() called from inet6_csk_route_socket(=
)
> * When inet_sock_destruct() calls dst_release() for sk->sk_dst_cache
> Provided the dst is not kept in the sk_dst_cache member of another socket=
,
> there is no other object tied to the dst (the socket lost its reference
> and the dst is no longer in the exception table) and the dst becomes a
> leaked object after ip6_negative_advice() has finished.
>
> As a result of this dst leak, an unbalanced refcount is reported for the
> loopback device of a net namespace being destroyed under kernels that do
> not contain e5f80fcf869a ("ipv6: give an IPv6 dev to blackhole_netdev"):
> unregister_netdevice: waiting for lo to become free. Usage count =3D 2
>
> Fix the dst leak by removing the dst_hold() in ip6_negative_advice(). The
> patch that introduced the dst_hold() in ip6_negative_advice() was
> 92f1655aa2b22 ("net: fix __dst_negative_advice() race"). But 92f1655aa2b2=
2
> merely refactored the code with regards to the dst refcount so the issue
> was present even before 92f1655aa2b22. The bug was introduced in
> 54c1a859efd9f ("ipv6: Don't drop cache route entry unless timer actually
> expired.") where the expired cached route is deleted, the sk_dst_cache
> member of the socket is set to NULL by calling dst_negative_advice() but
> the refcount belonging to the socket is left unbalanced.
>
> The IPv4 version - ipv4_negative_advice() - is not affected by this bug. =
A
> nexthop exception is created and the dst associated with the socket fails
> a check after the ICMPv6 packet indicating an MTU change has been
> received. When the TCP connection times out ipv4_negative_advice() merely
> resets the sk_dst_cache of the socket while decrementing the refcount of
> the exception dst. Then, the expired nexthop exception is deleted along
> with its routes in find_exception() while TCP tries to retransmit the sam=
e
> packet again.
>
> Fixes: 92f1655aa2b22 ("net: fix __dst_negative_advice() race")
> Fixes: 54c1a859efd9f ("ipv6: Don't drop cache route entry unless timer ac=
tually expired.")
>
> Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
> ---
>  net/ipv6/route.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index b4251915585f..b70267c8d251 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -2780,10 +2780,7 @@ static void ip6_negative_advice(struct sock *sk,
>         if (rt->rt6i_flags & RTF_CACHE) {
>                 rcu_read_lock();
>                 if (rt6_check_expired(rt)) {
> -                       /* counteract the dst_release() in sk_dst_reset()=
 */

I think I wanted to make sure the dst would not be destroyed too soon.

The rcu_read_lock() was already protecting us.

Perhaps replace the comment with
/* rt/dst can not be destroyed yet, because of rcu_read_lock() */

> -                       dst_hold(dst);
>                         sk_dst_reset(sk);
> -
>                         rt6_remove_exception_rt(rt);
>                 }
>                 rcu_read_unlock();
> --
> 2.35.3

Thanks for working on this issue.

You perhaps could make the changelog much shorter. and include a Link:
to this changelog,
if anyone in the future really wants the fine details.

