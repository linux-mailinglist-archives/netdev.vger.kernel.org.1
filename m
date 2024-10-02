Return-Path: <netdev+bounces-131360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F14298E424
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 22:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330141C229BC
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 20:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE096216A34;
	Wed,  2 Oct 2024 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZk8Eoha"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCFD2141B4
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727900889; cv=none; b=peqLkRCauVTC/e+3euxpc/YX6Vdgfx9Eoa4l2q2FKIKFoqy85SJkGM8OePUsWbCr44cxeQf2LUGK5U0/2FDMPPqzAxR71UgVKQ8tA0n3ztgIGvHRI/jP1ws61A1mE4fXsNGV8lrXehxJqAYcYA1q6+QBUcKhe+A8O85NgNCGTEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727900889; c=relaxed/simple;
	bh=g8OiyXnd+KbOAGzZCUk7JKPn96stb0CYvPUVPygyWvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUEdSvfjq3C4gwKBe/TMDNOdTwGtasy3R8ZnyXQ5SDVcrN1tk1cdGneINYky4utB9feldBzSozjkhd+mUVDryCqfIU2ePIkRrxZdAdSjAjLAkhWzFUzLwnj5/nx1sM48PWCtyQpu4i0DbzqdPtUg3PLh0kJe4pF9z3WdwoKGFIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZk8Eoha; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82ceab75c05so12209339f.0
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 13:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727900887; x=1728505687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qB9QRz9Ed519eFjOS/LAybjRwIb455Tx8K2wBEGYqU4=;
        b=OZk8EohaffKFmUcF0fJnUvChyuwO3rMe9Ajzwt2BCce0oqkxq1AGcnup0XWtWRFRWT
         vTZSN9we2s8WOIAyLYF7nmaWO1m1Zl8BeR1xzesKCpg0n/fxJjoP1fhQoeZ/RSLSURrS
         jYPyXN0UhE71O3257X1gP15qiHtwi+1trzwdjzJpsyg8maiXTv7Aeta/ADw8MCD6LkBj
         d0Iu326Rb73U5kMs2AKLTN1iNPp8+BlA4tQrXFQ4v82d6RsxwYMa+TNkGZPKVOejbJ7q
         MEtV53p55mYu5VkCeIiOp+4HMahYi6kdBzEViZB5WWpEl9b4toW9VdI+6PV/rwAqK2aq
         yKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727900887; x=1728505687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qB9QRz9Ed519eFjOS/LAybjRwIb455Tx8K2wBEGYqU4=;
        b=Phmxs3hzmSFGiixcxxx6FcFm7SqhthkUw/4yXOm9pTkZjnyzVsq228AGDyClC5q2f/
         lLFOeDGUuR/EHMzeyDtihopZp5RpcXCVzBRFtAf1+7/Bj+qzO0dR4cYNcKQG33OkIYFU
         RNv7kgjUDY8MvaTow7lmD/ebqFXipjs4XHbhpUk75RBAZaE3lqBw/FL0TojmK78hqCj6
         csosXo8yPzbdDxduW3ZGROxrUdcBqlVP5tft/9Gi5MXBoZIQMV1+T9nFE99Sd1x+Fry4
         LLdbzMNEB8BIqT5IQb4YIcaXvkOlEjRsl+l7L0PBtk552ZBD+3ZQ+JhOYCC5pLvLniLp
         eMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsTOEGpyR942NrszXOugjiYtrEuIhIvAzngKvUMSP+uy45siYsVdAYowq5/7V4EF2aC+ekmuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2YYl5+kSNoCekHYVq8KqzCJTYH6c3QJ+l3ax1YQnAgr4XnT2m
	nNUCwAK3TquzCt4RKagsBgVtSywpg7MdOKT2ze9N8BlbkCvLpAFFPsoW6T3DPtVuhDqxOaTUfPl
	gse+XCibYVBstR3ims6v/IAUc37s=
X-Google-Smtp-Source: AGHT+IFw8KteeJ7AL/Hfiwz107G7AHP1Es2gQiCjlRzY72iUw/7hsy2Bx9Qlf1HkWwTLDFBgaV9Mq4TYiFRW8njWvKU=
X-Received: by 2002:a05:6e02:1543:b0:3a0:9f85:d74f with SMTP id
 e9e14a558f8ab-3a3659445bcmr43552855ab.16.1727900886797; Wed, 02 Oct 2024
 13:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930180916.GA24637@incl> <CANn89iJQDWEyTC5Xc77PEXyxbbvKjm=exb5jKB0-O3ZzZ=W1Hg@mail.gmail.com>
 <20241001152609.GA24007@incl>
In-Reply-To: <20241001152609.GA24007@incl>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 2 Oct 2024 16:27:55 -0400
Message-ID: <CADvbK_cmi_ppJyPwmh77dHgkm=Lh52vtEWddwSAFNhZpmmev6Q@mail.gmail.com>
Subject: Re: [RFC PATCH] ipv6: route: release reference of dsts cached in sockets
To: Jiri Wiesner <jwiesner@suse.de>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 11:26=E2=80=AFAM Jiri Wiesner <jwiesner@suse.de> wro=
te:
>
> On Mon, Sep 30, 2024 at 08:27:50PM +0200, Eric Dumazet wrote:
> > On Mon, Sep 30, 2024 at 8:09=E2=80=AFPM Jiri Wiesner <jwiesner@suse.de>=
 wrote:
> > >
> > > An unbalanced refcount was reported for the loopback device of a net
> > > namespace being destroyed:
> > > unregister_netdevice: waiting for lo to become free. Usage count =3D =
2
> > >
> > > Analysis revealed that the IPv6 net device corresponding to the loopb=
ack
> > > device did not get destroyed (in6_dev_finish_destroy() was not called=
).
> > > The IPv6 loopback device had an unbalaced refcount:
> > > net dev 73da100 lo refcount 1
> > > Operation                     Count Balancing Operation     Count
> > > hold  __ipv6_dev_mc_inc           2 ma_put                      2
> > >       addrconf_ifdown             1                             0 unb=
alanced
> > > hold  fib6_nh_init                2 fib6_nh_init                2
> > > put   inet6_ifa_finish_destroy    1 ipv6_add_addr               1
> > >       ip6_dst_destroy            90                             0 unb=
alanced
> > >       ip6_dst_ifdown             90                             0 unb=
alanced
> > > hold  ip6_route_dev_notify        6 ip6_route_dev_notify        6
> > > hold  ipv6_add_addr               1 inet6_ifa_finish_destroy    1
> > > put   ma_put                      2 __ipv6_dev_mc_inc           2
> > > hold  ndisc_netdev_event          2 ndisc_netdev_event          2
> > >       rt6_disable_ip              1                             0 unb=
alanced
> > >
> > > The refcount of addrconf_ifdown() balances the refcount increment in
> > > ipv6_add_dev(), which had no corresponding trace entry. The
> > > rt6_disable_ip() and ip6_dst_ifdown() entries were hold operations on=
 the
> > > looback device, and the ip6_dst_destroy() entries were put operations=
. One
> > > refcount decrement in ip6_dst_destroy() was not executed. At this poi=
nt, a
> > > hash was implemented in the debug kernel to hold the changes of the
> > > refcount of dst objects per namespace. The trace for the dst object t=
hat
> > > did not decrement the IPv6 refcount of loopback follows:
> > >
> > > Function        Parent       Op  Net            Device Dst           =
   Refcount Diff
> > > ip6_dst_ifdown: dst_dev_put: dst ff404b2f073da100 eth0 ff404af71ffc9c=
00 1
> > > ip6_negative_advice: tcp_retransmit_timer: dst_hold ff404b2f073da100 =
eth0 ff404af71ffc9c00 1
> > > dst_alloc: ip6_dst_alloc: dst_hold ff404b2f073da100 eth0 ff404af71ffc=
9c00 1
> > > ip6_route_output_flags: ip6_dst_lookup_tail: dst_hold ff404b2f073da10=
0 eth0 ff404af71ffc9c00 84
> > > dst_release: ip6_negative_advice: dst_put ff404b2f073da100 eth0 ff404=
af71ffc9c00 1
> > > dst_release: tcp_retransmit_timer: dst_put ff404b2f073da100 eth0 ff40=
4af71ffc9c00 20
> > > dst_release: inet_sock_destruct: dst_put ff404b2f073da100 eth0 ff404a=
f71ffc9c00 29
> > > dst_release: __dev_queue_xmit: dst_put ff404b2f073da100 eth0 ff404af7=
1ffc9c00 34
> > > dst_release: rt6_remove_exception: dst_put ffffffff9c8e2a80 blackhole=
_dev ff404af71ffc9c00 1
> > >
> > > The ip6_dst_ifdown() trace entry was neither a hold nor a put - it me=
rely
> > > indicates that the net device of the dst object was changed to
> > > blackhole_dev and the IPv6 refcount was transferred onto the loopback
> > > device. There was no ip6_dst_destroy() trace entry, which means the d=
st
> > > object was not destroyed. There were 86 hold operations but only 85 p=
ut
> > > operations so the dst object was not destroyed because the refcount o=
f the
> > > dst object was unbalanced.
> > >
> > > The problem is that the refcount sums are ambiguous. The most probabl=
e
> > > explanation is this: The dst object was a route for an IPv6 TCP conne=
ction
> > > that kept timing out. Sometimes, the process closed the socket, which
> > > corresponds to the refcount decrements of the
> > > dst_release()/inet_sock_destruct() entries. Sometimes, the TCP retran=
smit
> > > timer reset the dst of the sockets, which corresponds to the
> > > dst_release()/tcp_retransmit_timer() entries. I am unsure about the
> > > dst_release()/__dev_queue_xmit() entries because inet6_csk_xmit() set=
s
> > > skb->_skb_refdst with SKB_DST_NOREF.
> > >
> > > The feature that sets the above trace apart from all the other dst tr=
aces
> > > is the execution of ip6_negative_advice() for a cached and also expir=
ed
> > > dst object in the exception table. The cached and expired dst object =
has
> > > its refcount set to at least 2 before executing rt6_remove_exception_=
rt()
> > > found in ip6_negative_advice(). One decrement happens in
> > > rt6_remove_exception() after the dst object has been removed from the
> > > exception table. The other decrement happens in sk_dst_reset() but th=
at
> > > one is counteracted by a dst_hold() intentionally placed just before =
the
> > > sk_dst_reset() in ip6_negative_advice(). The probem is that a socket =
that
> > > keeps a reference to a dst in its sk_dst_cache member increments the
> > > refcount of the dst by 1. This is apparent in the following code path=
s:
> > > * When ip6_route_output_flags() finds a dst that is then stored in
> > >   sk->sk_dst_cache by ip6_dst_store() called from inet6_csk_route_soc=
ket().
> > > * When inet_sock_destruct() calls dst_release() for sk->sk_dst_cache
> > > Provided the dst is not kept in the sk_dst_cache member of another so=
cket,
> > > there is no other object tied to the dst (the socket lost its referen=
ce
> > > and the dst is no longer in the exception table) and the dst becomes =
a
> > > leaked object after ip6_negative_advice() finishes. This leak then
> > > precludes the net namespace from being destroyed.
> > >
> > > The patch that introduced the dst_hold() in ip6_negative_advice() was
> > > 92f1655aa2b22 ("net: fix __dst_negative_advice() race"). But 92f1655a=
a2b22
> > > only refactored the code with regards to the dst refcount so the issu=
e was
> > > present even before 92f1655aa2b22.
> > >
> > > Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
> > > ---
> > > At the moment, I am sending this as an RFC because I am not able to
> > > reproduce the issue in-house. The customer that encountered the issue=
 is
> > > currently running tests. For the customer's testing, I fixed the issu=
e
> > > with a kprobe module that calls dst_release() right after
> > > rt6_remove_exception_rt() returns in ip6_negative_advice(), which is =
not
> > > quite the same as the change proposed below.
> > >
> > >  net/ipv6/route.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >
> > > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > > index b4251915585f..b70267c8d251 100644
> > > --- a/net/ipv6/route.c
> > > +++ b/net/ipv6/route.c
> > > @@ -2780,10 +2780,7 @@ static void ip6_negative_advice(struct sock *s=
k,
> > >         if (rt->rt6i_flags & RTF_CACHE) {
> > >                 rcu_read_lock();
> > >                 if (rt6_check_expired(rt)) {
> > > -                       /* counteract the dst_release() in sk_dst_res=
et() */
> > > -                       dst_hold(dst);
> > >                         sk_dst_reset(sk);
> > > -
> > >                         rt6_remove_exception_rt(rt);
> > >                 }
> > >                 rcu_read_unlock();
> > > --
> >
> > Interesting, what kernel version is your customer using ?
>
> It is a distribution kernel (SLES 15 SP5) that is based on 5.14. The newe=
st SLES service pack, SP6, has a 6.4-based kernel. But the customer has yet=
 to move to that one.
>
> > I think that with recent kernels (after 5.18), we do not see issues
> > because of the use of blackhole_netdev
> > instead of loopback.
>
> Thank you very much for mentioning that. I will be backporting these patc=
hes to SUSE's 5.14-based kernels:
> > 9cc341286e99 ("dn_route: set rt neigh to blackhole_netdev instead of lo=
opback_dev in ifdown")
> > 4d33ab08c0af ("xfrm: set dst dev to blackhole_netdev instead of loopbac=
k_dev in ifdown")
> > dd263a8cb194 ("ipv6: blackhole_netdev needs snmp6 counters")
> > e5f80fcf869a ("ipv6: give an IPv6 dev to blackhole_netdev")
> These patches will not resolve the dst leak but being able to destroy net=
 namespaces at the expense of sustaining infrequently occurring dst leaks i=
s a favourable trade.
>
> The testing results (debugging SLES15 SP5 kernel plus the kprobe module c=
alling dst_release() in probe_ip6_negative_advice()) came back and the kern=
el log indicates negative overflow of the dst refcount. The first machine:
> > [ 9366.700330] dst_release underflow
> > [ 9366.700346] WARNING: CPU: 42 PID: 0 at ../net/core/dst.c:176 dst_rel=
ease+0x19f/0x1b0
> > [ 9366.701492] Call Trace:
> > [ 9366.701497]  <IRQ>
> > [ 9366.701506]  probe_ip6_negative_advice+0x12/0x30 [probe 0c57153a505e=
d7cc20e2c5db9522a1a524ec4f56]
> > [ 9366.701514]  opt_pre_handler+0x3d/0x70
> > [ 9366.701528]  optimized_callback+0x64/0x90
> > [ 9366.701538]  0xffffffffc0476032
> > [ 9366.701548]  ? ip6_negative_advice+0xdf/0x180
> > [ 9366.701558]  ? tcp_retransmit_timer+0x658/0x930
> > [ 9366.701595]  ? tcp_write_timer_handler+0xba/0x1f0
> > [ 9366.701601]  ? tcp_write_timer+0x211/0x260
> > [ 9366.701624]  ? call_timer_fn+0x27/0x130
> > [ 9366.701631]  ? run_timer_softirq+0x443/0x480
> > [ 9366.701645]  ? __do_softirq+0xd2/0x2c0
> > [ 9366.701654]  ? irq_exit_rcu+0xa4/0xc0
> > [ 9366.701661]  ? sysvec_apic_timer_interrupt+0x50/0x90
> > [ 9366.701667]  </IRQ>
> > [ 9366.701744] dst_release: dst:00000000ac3b9120 refcnt:-1
> > [ 9366.701757] dst_release: dst:00000000ac3b9120 refcnt:-2
> > [ 9382.832164] dst_release: dst:00000000ac3b9120 refcnt:-3
> > [ 9659.561679] dst_release: dst:00000000494633c6 refcnt:-1
> Obviously, the refcount of the cached and expired dst, dst:00000000ac3b91=
20, was 1 before probe_ip6_negative_advice() was called from tcp_write_time=
out()/tcp_retransmit_timer(). So, my supposition that cached dsts being pas=
sed to probe_ip6_negative_advice() have a refcount of at least 2 was wrong.
>
> The second machine:
> [11479.272704] dst_release underflow
> [11479.272718] WARNING: CPU: 52 PID: 0 at ../net/core/dst.c:176 dst_relea=
se+0x19f/0x1b0
> [11479.272924] Call Trace:
> [11479.272928]  <IRQ>
> [11479.272932]  tcp_retransmit_timer+0x47c/0x930
> [11479.272953]  tcp_write_timer_handler+0xba/0x1f0
> [11479.272956]  tcp_write_timer+0x211/0x260
> [11479.272962]  call_timer_fn+0x27/0x130
> [11479.272966]  run_timer_softirq+0x443/0x480
> [11479.272973]  __do_softirq+0xd2/0x2c0
> [11479.272980]  irq_exit_rcu+0xa4/0xc0
> [11479.272985]  sysvec_apic_timer_interrupt+0x50/0x90
> [11479.272989]  </IRQ>
> [11479.273044] dst_release: dst:00000000ff7e6845 refcnt:-1
> [11681.380331] dst_release: dst:00000000893d8a2d refcnt:-1
> In this case, the refcount of dst:00000000ff7e6845 was have been 2 before=
 probe_ip6_negative_advice() so the dst_release() called from the kprobe ha=
ndler decremented the refcount to 0. No warning was printed. There probably=
 was another socket having the dst stored in sk_dst_cache, to which the ref=
count of 1 belonged. When the second __sk_dst_reset() was called in tcp_ret=
ransmit_timer(), which was the tcp_retransmit_timer+0x47c site, the refcoun=
t dropped below 0.
>
> I am afraid this patch is misguided. I would still like to find the sourc=
e of the dst leak but I am also running out of time which the customer is w=
illing to invest into investigating this issue.
Is your kernel including this commit?

commit 28044fc1d4953b07acec0da4d2fc4784c57ea6fb
Author: Joanne Koong <joannelkoong@gmail.com>
Date:   Mon Aug 22 11:10:21 2022 -0700

    net: Add a bhash2 table hashed by port and address

After this commit, it seems in tcp_v6_connect(), the 'goto failure'
may cause a dst leak.:

        dst =3D ip6_dst_lookup_flow(net, sk, &fl6, final_p);
        ...
        if (!saddr) {
                saddr =3D &fl6.saddr;

                err =3D inet_bhash2_update_saddr(sk, saddr, AF_INET6);
                if (err)
                        goto failure; <---
        }
        ...
        ip6_dst_store(sk, dst, NULL, NULL);

