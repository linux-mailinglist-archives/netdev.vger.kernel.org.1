Return-Path: <netdev+bounces-144240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B07E9C63C9
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 22:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856DF1F242C1
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 21:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C532185AD;
	Tue, 12 Nov 2024 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAwogQ0j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7441FEFD9
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 21:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731448301; cv=none; b=oQ+nER8A6dz2T/iER/nMJXlz75w+9CJO5lEVhhw+MV9G980KDc2L8pjwE4rrq10rUVmQ7BR7uZJwtXsJI30CFD88K0OjernrHwdVSRlxX/1hFYdebr7QxSSlyuADX9Rw1xRVGHBuL3u4KqlocYdhf9CWKsF4YevCaTvmMsO3Kuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731448301; c=relaxed/simple;
	bh=8TFKR9SVqlMiKmlmPrXlQfo2oKDqbpFel26hExPda70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekmQ2IR1Nkk3INQQ6RHxeLz/Ga1nLaGH1Zb4Ym3qO6PTnDFimNtTdwFcW7jOQ6thGxvGkB44U9/8/UYtM27NoEK5E4gWrzqMHPIkPgXxE+9IO7pvY3fRepZ2mhGQgAArJbkvYWUZdXtMiMW/JfGEdRbBhzdvtKFjaAqOIGXmb8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAwogQ0j; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a4e5401636so23973345ab.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 13:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731448299; x=1732053099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQwIfadcpAWn3Mtey4ukCQSRs90/Zh2U5Jq7zt9BXw4=;
        b=CAwogQ0jdpbFirdzX29ep+EeSCsal9KwKtAOVrTjjLwdkr5a6Q0UeVq/cftBmwB+0C
         SlcHWeHZno5iqAnpk5Oxy2lRYqqrKDmfcflCxzPFf7wzHmXYL6m/D1pn2f4Ql+j/kZMO
         fuV/efJIU5cVphsImRwGy1xAhREFoZwhhWd4xDqRDkdFYvkfqA3fwIUVpO1OJ7tlH87P
         6ErgF4YHqpQ0qGb2SumIGFX0u2kvKC8KCavn2THLg+JA7wfjk05Hfx9EQOeCWdX8JAZn
         CKdvqalNEH1gHCh+wmk2wUnlIsOlZinMVOyIi//grqW+UvQJc41Top2ZuQDoBXGxMmJf
         0+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731448299; x=1732053099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQwIfadcpAWn3Mtey4ukCQSRs90/Zh2U5Jq7zt9BXw4=;
        b=TBq7bvO/yOtK1dD6Lx0yoLjguzQMuApQDfmgv7Ngp2x+0yxlVpw91aXnB0SZVuRPKp
         W+dH4eafqcMr0kJ3MaxnydnvjkilvC9ghm+shrllvpAy8FxYvtE4rQoYjRC9KANEg9LU
         0eHOzfsOyeX7QBfS4bLxRVz4ueXEYFGXXCLQQa6eceXQWUROrgtK43yUJQq3bbmlpRQl
         zXfQWviakpisO/UI67NHwMaTavrv5PiUOLwOYvNdjLyh16uY7QeNoLevUETVIM+186AG
         6a+sAJ+cGQeqRxtCVfndNqA6H8fNEPXoptLwmz/uVeSL+gx5RR1XRHCOFGR3Di9tZeSv
         V1hg==
X-Forwarded-Encrypted: i=1; AJvYcCVnyqH0ddznY0iwgw+XO0vWZuek9F90d2ck4yh5D0VD71QgNRhSR3dLfHgSz8va3ZO8ZSoSZOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQPPU49gM8fiRkpgAIFdVasCjIsEbVBbQVdj0lg5qIPIpiR5dg
	dIy22WFrjH+g39NndujglrzRlhdjQ/A3YxwE7xHAXNSMwP/xm+BmHWVxtBDs0NIfnS4TKTVJjH4
	/hXfg4euKHSTAxVFdCRMrKCAydUE=
X-Google-Smtp-Source: AGHT+IFldardOs4F2OzLqGulMd0+ASsQ/+dVYQRplk2YCXSK68AlWYTOIqTruI4LADdmzXFlpAHHExsMvC9QWZ19UP8=
X-Received: by 2002:a05:6e02:1fed:b0:3a4:eca2:95f1 with SMTP id
 e9e14a558f8ab-3a6f19ebf12mr178192175ab.6.1731448298611; Tue, 12 Nov 2024
 13:51:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930180916.GA24637@incl> <CANn89iJQDWEyTC5Xc77PEXyxbbvKjm=exb5jKB0-O3ZzZ=W1Hg@mail.gmail.com>
 <20241001152609.GA24007@incl> <CADvbK_cmi_ppJyPwmh77dHgkm=Lh52vtEWddwSAFNhZpmmev6Q@mail.gmail.com>
 <20241003170126.GA20362@incl> <CADvbK_e_Etot3nzMC=FEt-cqoWfnER4SVOC5dOm6aH43iME1iA@mail.gmail.com>
 <20241112085655.GA19776@incl>
In-Reply-To: <20241112085655.GA19776@incl>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 12 Nov 2024 16:51:27 -0500
Message-ID: <CADvbK_dz9ewsEmGa63DgMOwRwFyE-evALq61CUYi54-K_WTvog@mail.gmail.com>
Subject: Re: [RFC PATCH] ipv6: route: release reference of dsts cached in sockets
To: Jiri Wiesner <jwiesner@suse.de>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 3:57=E2=80=AFAM Jiri Wiesner <jwiesner@suse.de> wro=
te:
>
> On Sun, Oct 06, 2024 at 02:25:25PM -0400, Xin Long wrote:
> > We recently also encountered this
> >
> >   'unregister_netdevice: waiting for lo to become free. Usage count =3D=
 X'
> >
> > problem on our customer env after backporting
> >
> >   Commit 92f1655aa2b22 ("net: fix __dst_negative_advice() race"). [1]
> >
> > The commit looks correct to me, so I guess it may uncover some existing
> > issues.
> >
> > As it took a very long time to get reproduced on our customer env, whic=
h
> > made it impossible to debug. Also the issue existed even after
> > disabling IPv6.
> >
> > It seems much easier to reproduce it on your customer env. So I'm wonde=
ring
> >
> > - Was the testing on your customer env related to IPv6 ?
> > - Does the issue still exist after reverting the commit [1] ?
>
> The customer tried reproducing the issue with 92f1655aa2b22 ("net: fix __=
dst_negative_advice() race") reverted and the issue appeared again. My next=
 step was capturing more points within the stacktraces when dst refcounts a=
re changed (I do not have full stack traces - the trace entries I store in =
the hash contain only the instruction pointer and the parent function). Thi=
s is the trace for the leaked dst object:
> > dst ff1c4157413bf900
> > alloc: 1 destroy:  obj diff: 1
> > hold ops: 5 put ops: 4 refcnt diff: 1
> > Function                            Parent                           Op=
  Net            Device Dst              Number of Calls
> > inet6_csk_route_socket+0x1c2/0x2d0: inet6_csk_update_pmtu+0x58/0x90: ds=
t ff1c4151bcac1080 eth0 ff1c4157413bf900 1
> > __ip6_rt_update_pmtu+0x183/0x3c0: inet6_csk_update_pmtu+0x4b/0x90: dst =
ff1c4151bcac1080 eth0 ff1c4157413bf900 1
> > ip6_dst_lookup_flow+0x4f/0x1d0: inet6_csk_route_socket+0x198/0x2d0: dst=
 ff1c4151bcac1080 eth0 ff1c4157413bf900 1
> > ip6_dst_ifdown+0x5/0x250: dst_dev_put+0x2d/0xd0: dst ff1c4151bcac1080 e=
th0 ff1c4157413bf900 1
> > tcp_v6_connect+0x37e/0x790: __inet_stream_connect+0x2c8/0x3a0: dst ff1c=
4151bcac1080 eth0 ff1c4157413bf900 2
> > ip6_dst_lookup_flow+0x4f/0x1d0: tcp_v6_connect+0x320/0x790: dst ff1c415=
1bcac1080 eth0 ff1c4157413bf900 2
> > __dev_queue_xmit+0x1af/0xd20: ip6_finish_output2+0x1f1/0x6e0: dst ff1c4=
151bcac1080 eth0 ff1c4157413bf900 675
> > inet6_csk_xmit+0xa1/0x150: __tcp_transmit_skb+0x5f8/0xd40: dst ff1c4151=
bcac1080 eth0 ff1c4157413bf900 675
> > Function                            Parent                           Op=
      Net            Device Dst              Refcount Diff
> > ip6_route_output_flags+0x76/0x230: ip6_dst_lookup_tail+0x215/0x250: dst=
_hold ff1c4151bcac1080 eth0 ff1c4157413bf900 1
> > ip6_negative_advice+0x66/0x2d0: tcp_retransmit_timer+0x5ed/0xac0: dst_h=
old ff1c4151bcac1080 eth0 ff1c4157413bf900 1
> > dst_alloc+0x5e/0x180: ip6_dst_alloc+0x27/0x60: dst_hold ff1c4151bcac108=
0 eth0 ff1c4157413bf900 1
> > ip6_route_output_flags+0x76/0x230: ip6_dst_lookup_tail+0x10f/0x250: dst=
_hold ff1c4151bcac1080 eth0 ff1c4157413bf900 2
> > dst_release+0x32/0x140: ip6_negative_advice+0x137/0x2d0: dst_put ff1c41=
51bcac1080 eth0 ff1c4157413bf900 1
> > dst_release+0x32/0x140: inet_sock_destruct+0x146/0x1c0: dst_put ff1c415=
1bcac1080 eth0 ff1c4157413bf900 2
> > dst_release+0x32/0x140: rt6_remove_exception.part.53+0x7f/0xe0: dst_put=
 ffffffff90ee2a80 blackhole_dev ff1c4157413bf900 1
> > Function                 Parent                      Op     Net        =
      Dst              Socket           Number of Calls
> > sk_setup_caps+0x5/0x200: tcp_v6_connect+0x428/0x790: sk_dst ff1c4151bca=
c1080 ff1c4157413bf900 ff1c4158c07aaf80 1
> > sk_setup_caps+0x5/0x200: tcp_v6_connect+0x428/0x790: sk_dst ff1c4151bca=
c1080 ff1c4157413bf900 ff1c418e49bac280 1
> > sk_setup_caps+0x5/0x200: inet6_csk_route_socket+0x23c/0x2d0: sk_dst ff1=
c4151bcac1080 ff1c4157413bf900 ff1c418ea04f7200 1
>
> The refcount of the dst was changed only when a dst_hold or dst_put opera=
tion was logged. The hold in dst_alloc() is balanced by the dst_release() i=
n rt6_remove_exception(). The three holds in ip6_route_output_flags() belon=
ged to the references held by sockets which were balanced by the dst_releas=
e() in inet_sock_destruct(). But that leaves one hold operation outstanding=
 and unbalanced. There is a put operation for expired cached dst objects in=
 ip6_negative_advice() but that one is intentionally balanced by a hold in =
the same function.
>
This makes sense to me.

The code prior to 92f1655aa2b22 ("net: fix __dst_negative_advice()
race") had no longer been able to release the cached dst for the
reference held by socket in ip6_negative_advice() since
rt6_remove_exception_rt() is called there.

Hi, David Ahern,

Can you confirm this?

Thanks.

> Accoding to the sk_dst trace entries, three sockets held a reference to t=
he leaked dst. All of these sockets were eventually distroyed so there was =
no socket leak causing the dst leak, which rules out one of the possbile hy=
potheses. The dst was stored in the socket object while a connect() sycall =
was being executed for two of the sockets. An IMCPv6 packet carrying a Pack=
et Too Big message was received by the third socket, which lead to the exec=
ution of routines changing the MTU for the dst and storing a reference to t=
he dst in the socket object. As for races, sockets are locked in inet_strea=
m_connect, tcp_write_timer() and tcp_v6_err(), and the mutual exclusion pre=
vents races when reference to dst objects are set and reset for sockets. Th=
e put operation executed from dst_release() in inet_sock_destruct() is not =
part of a critical section protected by mutual exclusion but it is guarante=
ed to run only after the refcount of the socket has reached zero. All the o=
ther code paths in the trace increment the refcount of the socket while the=
y manipulate dsts (the connect() syscall uses the refcount incremented by t=
he socket() syscall).
>
> This is a trace for the socket for which ip6_negative_advice() was execut=
ed for an expired cached dst:
> > socket ff1c4158c07aaf80
> > alloc: 1 destroy: 1 obj diff: 0
> > hold ops: 9 put ops: 9 refcnt diff: 0
> > ip6_negative_advice+0xcd/0x2d0: tcp_retransmit_timer+0x5ed/0xac0: sk_ds=
t ff1c4151bcac1080 0 ff1c4158c07aaf80 1
> > tcp_retransmit_timer+0x50d/0xac0: tcp_write_timer_handler+0xba/0x1f0: s=
k_dst ff1c4151bcac1080 0 ff1c4158c07aaf80 2
> > ip6_negative_advice+0x169/0x2d0: tcp_retransmit_timer+0x5ed/0xac0: sk_d=
st ff1c4151bcac1080 0 ff1c4158c07aaf80 3
> > sk_setup_caps+0x5/0x200: inet6_sk_rebuild_header+0x1f9/0x2a0: sk_dst ff=
1c4151bcac1080 ff1c4153a762d500 ff1c4158c07aaf80 5
> > sk_setup_caps+0x5/0x200: tcp_v6_connect+0x428/0x790: sk_dst ff1c4151bca=
c1080 ff1c4157413bf900 ff1c4158c07aaf80 1
> > sk_free+0x5/0x100: tcp_close+0x100/0x120: sk ff1c4151bcac1080 0 ff1c415=
8c07aaf80 1
> > __sk_free+0x5/0x190: sk_free+0xe3/0x100: sk ff1c4151bcac1080 0 ff1c4158=
c07aaf80 1
> > sk_destruct+0x5/0x150: __sk_free+0x83/0x190: sk ff1c4151bcac1080 0 ff1c=
4158c07aaf80 1
> > sk_alloc+0x195/0x2a0: inet6_create+0xd5/0x450: sk ff1c4151bcac1080 0 ff=
1c4158c07aaf80 1
> > sk_free+0x5/0x100: ip6_rcv_core.isra.25+0x27c/0x440: sk ff1c4151bcac108=
0 0 ff1c4158c07aaf80 7
> > sk_reset_timer+0x7b/0x130: tcp_connect+0x83f/0xe00: sk_hold ff1c4151bca=
c1080 0 ff1c4158c07aaf80 1
> > __tcp_close+0x15d/0x4c0: tcp_close+0x35/0x120: sk_hold ff1c4151bcac1080=
 0 ff1c4158c07aaf80 1
> > sock_init_data_uid+0x107/0x2d0: inet6_create+0xec/0x450: sk_hold ff1c41=
51bcac1080 0 ff1c4158c07aaf80 1
> > sk_reset_timer+0x7b/0x130: tcp_retransmit_timer+0x4e3/0xac0: sk_hold ff=
1c4151bcac1080 0 ff1c4158c07aaf80 6
> > tcp_close+0x5/0x120: inet_release+0x3c/0x80: sk_put ff1c4151bcac1080 0 =
ff1c4158c07aaf80 1
> > inet_csk_destroy_sock+0x90/0x1e0: __tcp_close+0x2ca/0x4c0: sk_put ff1c4=
151bcac1080 0 ff1c4158c07aaf80 1
> > tcp_write_timer+0x61/0x260: call_timer_fn+0x27/0x130: sk_put ff1c4151bc=
ac1080 0 ff1c4158c07aaf80 7
>
> Besides dst ff1c4157413bf900, this sockets held a reference to another ds=
t - ff1c4153a762d500. Regardless of the order in which the dst references w=
ere held, the extra dst_hold() in ip6_negative_advice() would preserve the =
refcount increment owned by the socket while also resetting the sk_dst_cach=
e member of the socket to NULL, rendering it impossible for the socket to d=
ecrement the refcount in the future. We see that the socket was destroyed b=
ut the sk_dst_cache member was most probably NULL at the time because all t=
he dst references were reset in tcp_retransmit_timer() and ip6_negative_adv=
ice().
>
> Based on this data, I went back to recheck the kprobe module that was mea=
nt to implement a dst_release() in ip6_negative_advice(). I found a mistake=
 in the module that resulted in executing:
> > static void ip6_negative_advice(struct sock *sk, struct dst_entry *dst)
> > {
> >         struct rt6_info *rt =3D (struct rt6_info *) dst;
> >         if (rt->rt6i_flags & RTF_CACHE) {
> >                 rcu_read_lock();
> >                 if (rt6_check_expired(rt)) {
> >                         /* counteract the dst_release() in sk_dst_reset=
() */
> >                         dst_hold(dst);
> >                         sk_dst_reset(sk);
> >                         rt6_remove_exception_rt(rt);
> >                 }
> > --->            kprobe_calls_dst_release;
> >                 rcu_read_unlock();
> >                 return;
> >         }
> >         sk_dst_reset(sk);
> > }
> instead of this:
> > static void ip6_negative_advice(struct sock *sk, struct dst_entry *dst)
> > {
> >         struct rt6_info *rt =3D (struct rt6_info *) dst;
> >         if (rt->rt6i_flags & RTF_CACHE) {
> >                 rcu_read_lock();
> >                 if (rt6_check_expired(rt)) {
> >                         /* counteract the dst_release() in sk_dst_reset=
() */
> >                         dst_hold(dst);
> > --->                    kprobe_calls_dst_release;
> >                         sk_dst_reset(sk);
> >                         rt6_remove_exception_rt(rt);
> >                 }
> >                 rcu_read_unlock();
> >                 return;
> >         }
> >         sk_dst_reset(sk);
> > }
> which clearly shows why the test with the module resulted in negative ove=
rflow of dst refcounts. I fixed the module and further testing showed the i=
ssue is no longer reproducible.
>
> I have managed to put together a minimal set of steps needed to reproduce=
 the issue:
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
> #ip netns exec ns2 bash -c "echo 6 > /proc/sys/net/ipv6/route/mtu_expires=
"
> ip netns exec ns0 bash -c "echo 900 > /proc/sys/net/ipv6/route/gc_interva=
l"
> #ip netns exec ns2 bash -c "echo 900 > /proc/sys/net/ipv6/route/gc_interv=
al"
> sleep 30
>
> ip6tables -F
> ip6tables -A FORWARD -i veth0 -d fd02::/24 -j ACCEPT
> ip6tables -A FORWARD -i veth2 -d fd00::/24 -j ACCEPT
> echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
> ip6tables -L -v
>
> (ip netns exec ns2 netcat -6 -l -s fd02::2 -p 1234 &> /dev/null) & serv=
=3D$!
> sleep 1
> dd if=3D/dev/zero bs=3D1M count=3D100 | ip netns exec ns0 netcat -6 fd02:=
:2 1234 & clnt=3D$!
> sleep 1
> kill $clnt $serv
> wait $serv
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
> I was able to reproduce the dst leak under 6.12-rc7. I will submit a fix =
shortly.
> --
> Jiri Wiesner
> SUSE Labs

