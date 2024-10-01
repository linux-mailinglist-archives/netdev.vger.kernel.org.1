Return-Path: <netdev+bounces-130927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8745598C18F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A11285DB7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36281C7B64;
	Tue,  1 Oct 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LGoFGhUO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a9yzYQN+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LGoFGhUO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a9yzYQN+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C56F1CB318
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796373; cv=none; b=fP3wkRgLizq5aphZ6K3gD3TwkUQdzbeBTt2qQyxctIck3pOUNh3iICzAY1Mw+7iHKnxBg4uTJjDStF8DtGN5fTotrf+Evf/FuXpTIC72aPAT00WHXI78RJqM4rt/m0oal3W8eZtB3iwR6VvKzcwq09VF//cRI58koDdrgAKNBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796373; c=relaxed/simple;
	bh=nju4ki75V2vZZU5qawwxP2MMnOMzTvBF38MN4CsfsZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pylFRtp+jJZ8wsOV6SCNzp7b+RQaCI2TAKVQw4gqSY7cFrrY0aCbC2h5B7npXlluAZAmweEnZadwjbHNLWZreUAlampgMAL7B/u9sf9Q3krrS84r5sSxvZXqMMLzebKVaK8Ugbs88usjCtLKPWseFXd+oqlHEMJO+3qxz2uHPNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LGoFGhUO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a9yzYQN+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LGoFGhUO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a9yzYQN+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B83081F88A;
	Tue,  1 Oct 2024 15:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727796369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eO108cxwqSOZypFAqpYWDgxGb7X54mY6Dwjs0DyerXU=;
	b=LGoFGhUOAXw8GoANHu7WueVzu705gBH9ZQXdjovMqOrI0eK3oKrKCLT0nR5BBp16tn71Zr
	T2TJhYUQogk5F8JpCW9sULZSJpBfQmHl7wWzlNi0BDrfx16LjkidifZBqLD0JDVh+/73JM
	HZqHgvF+x4XOa+M6B7Kos0PEOloLPVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727796369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eO108cxwqSOZypFAqpYWDgxGb7X54mY6Dwjs0DyerXU=;
	b=a9yzYQN+uwoAeA8TvicbrRz5i858DymUd2pNxlJ71Je9AWgUBXK94a7Y/31N014z0TOLda
	nwsE25t8VNuraUCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727796369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eO108cxwqSOZypFAqpYWDgxGb7X54mY6Dwjs0DyerXU=;
	b=LGoFGhUOAXw8GoANHu7WueVzu705gBH9ZQXdjovMqOrI0eK3oKrKCLT0nR5BBp16tn71Zr
	T2TJhYUQogk5F8JpCW9sULZSJpBfQmHl7wWzlNi0BDrfx16LjkidifZBqLD0JDVh+/73JM
	HZqHgvF+x4XOa+M6B7Kos0PEOloLPVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727796369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eO108cxwqSOZypFAqpYWDgxGb7X54mY6Dwjs0DyerXU=;
	b=a9yzYQN+uwoAeA8TvicbrRz5i858DymUd2pNxlJ71Je9AWgUBXK94a7Y/31N014z0TOLda
	nwsE25t8VNuraUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9909E13A73;
	Tue,  1 Oct 2024 15:26:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i3xaJZEU/GbFMwAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Tue, 01 Oct 2024 15:26:09 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id 50C2EB1091; Tue,  1 Oct 2024 17:26:09 +0200 (CEST)
Date: Tue, 1 Oct 2024 17:26:09 +0200
From: Jiri Wiesner <jwiesner@suse.de>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH] ipv6: route: release reference of dsts cached in
 sockets
Message-ID: <20241001152609.GA24007@incl>
References: <20240930180916.GA24637@incl>
 <CANn89iJQDWEyTC5Xc77PEXyxbbvKjm=exb5jKB0-O3ZzZ=W1Hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJQDWEyTC5Xc77PEXyxbbvKjm=exb5jKB0-O3ZzZ=W1Hg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Sep 30, 2024 at 08:27:50PM +0200, Eric Dumazet wrote:
> On Mon, Sep 30, 2024 at 8:09 PM Jiri Wiesner <jwiesner@suse.de> wrote:
> >
> > An unbalanced refcount was reported for the loopback device of a net
> > namespace being destroyed:
> > unregister_netdevice: waiting for lo to become free. Usage count = 2
> >
> > Analysis revealed that the IPv6 net device corresponding to the loopback
> > device did not get destroyed (in6_dev_finish_destroy() was not called).
> > The IPv6 loopback device had an unbalaced refcount:
> > net dev 73da100 lo refcount 1
> > Operation                     Count Balancing Operation     Count
> > hold  __ipv6_dev_mc_inc           2 ma_put                      2
> >       addrconf_ifdown             1                             0 unbalanced
> > hold  fib6_nh_init                2 fib6_nh_init                2
> > put   inet6_ifa_finish_destroy    1 ipv6_add_addr               1
> >       ip6_dst_destroy            90                             0 unbalanced
> >       ip6_dst_ifdown             90                             0 unbalanced
> > hold  ip6_route_dev_notify        6 ip6_route_dev_notify        6
> > hold  ipv6_add_addr               1 inet6_ifa_finish_destroy    1
> > put   ma_put                      2 __ipv6_dev_mc_inc           2
> > hold  ndisc_netdev_event          2 ndisc_netdev_event          2
> >       rt6_disable_ip              1                             0 unbalanced
> >
> > The refcount of addrconf_ifdown() balances the refcount increment in
> > ipv6_add_dev(), which had no corresponding trace entry. The
> > rt6_disable_ip() and ip6_dst_ifdown() entries were hold operations on the
> > looback device, and the ip6_dst_destroy() entries were put operations. One
> > refcount decrement in ip6_dst_destroy() was not executed. At this point, a
> > hash was implemented in the debug kernel to hold the changes of the
> > refcount of dst objects per namespace. The trace for the dst object that
> > did not decrement the IPv6 refcount of loopback follows:
> >
> > Function        Parent       Op  Net            Device Dst              Refcount Diff
> > ip6_dst_ifdown: dst_dev_put: dst ff404b2f073da100 eth0 ff404af71ffc9c00 1
> > ip6_negative_advice: tcp_retransmit_timer: dst_hold ff404b2f073da100 eth0 ff404af71ffc9c00 1
> > dst_alloc: ip6_dst_alloc: dst_hold ff404b2f073da100 eth0 ff404af71ffc9c00 1
> > ip6_route_output_flags: ip6_dst_lookup_tail: dst_hold ff404b2f073da100 eth0 ff404af71ffc9c00 84
> > dst_release: ip6_negative_advice: dst_put ff404b2f073da100 eth0 ff404af71ffc9c00 1
> > dst_release: tcp_retransmit_timer: dst_put ff404b2f073da100 eth0 ff404af71ffc9c00 20
> > dst_release: inet_sock_destruct: dst_put ff404b2f073da100 eth0 ff404af71ffc9c00 29
> > dst_release: __dev_queue_xmit: dst_put ff404b2f073da100 eth0 ff404af71ffc9c00 34
> > dst_release: rt6_remove_exception: dst_put ffffffff9c8e2a80 blackhole_dev ff404af71ffc9c00 1
> >
> > The ip6_dst_ifdown() trace entry was neither a hold nor a put - it merely
> > indicates that the net device of the dst object was changed to
> > blackhole_dev and the IPv6 refcount was transferred onto the loopback
> > device. There was no ip6_dst_destroy() trace entry, which means the dst
> > object was not destroyed. There were 86 hold operations but only 85 put
> > operations so the dst object was not destroyed because the refcount of the
> > dst object was unbalanced.
> >
> > The problem is that the refcount sums are ambiguous. The most probable
> > explanation is this: The dst object was a route for an IPv6 TCP connection
> > that kept timing out. Sometimes, the process closed the socket, which
> > corresponds to the refcount decrements of the
> > dst_release()/inet_sock_destruct() entries. Sometimes, the TCP retransmit
> > timer reset the dst of the sockets, which corresponds to the
> > dst_release()/tcp_retransmit_timer() entries. I am unsure about the
> > dst_release()/__dev_queue_xmit() entries because inet6_csk_xmit() sets
> > skb->_skb_refdst with SKB_DST_NOREF.
> >
> > The feature that sets the above trace apart from all the other dst traces
> > is the execution of ip6_negative_advice() for a cached and also expired
> > dst object in the exception table. The cached and expired dst object has
> > its refcount set to at least 2 before executing rt6_remove_exception_rt()
> > found in ip6_negative_advice(). One decrement happens in
> > rt6_remove_exception() after the dst object has been removed from the
> > exception table. The other decrement happens in sk_dst_reset() but that
> > one is counteracted by a dst_hold() intentionally placed just before the
> > sk_dst_reset() in ip6_negative_advice(). The probem is that a socket that
> > keeps a reference to a dst in its sk_dst_cache member increments the
> > refcount of the dst by 1. This is apparent in the following code paths:
> > * When ip6_route_output_flags() finds a dst that is then stored in
> >   sk->sk_dst_cache by ip6_dst_store() called from inet6_csk_route_socket().
> > * When inet_sock_destruct() calls dst_release() for sk->sk_dst_cache
> > Provided the dst is not kept in the sk_dst_cache member of another socket,
> > there is no other object tied to the dst (the socket lost its reference
> > and the dst is no longer in the exception table) and the dst becomes a
> > leaked object after ip6_negative_advice() finishes. This leak then
> > precludes the net namespace from being destroyed.
> >
> > The patch that introduced the dst_hold() in ip6_negative_advice() was
> > 92f1655aa2b22 ("net: fix __dst_negative_advice() race"). But 92f1655aa2b22
> > only refactored the code with regards to the dst refcount so the issue was
> > present even before 92f1655aa2b22.
> >
> > Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
> > ---
> > At the moment, I am sending this as an RFC because I am not able to
> > reproduce the issue in-house. The customer that encountered the issue is
> > currently running tests. For the customer's testing, I fixed the issue
> > with a kprobe module that calls dst_release() right after
> > rt6_remove_exception_rt() returns in ip6_negative_advice(), which is not
> > quite the same as the change proposed below.
> >
> >  net/ipv6/route.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index b4251915585f..b70267c8d251 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -2780,10 +2780,7 @@ static void ip6_negative_advice(struct sock *sk,
> >         if (rt->rt6i_flags & RTF_CACHE) {
> >                 rcu_read_lock();
> >                 if (rt6_check_expired(rt)) {
> > -                       /* counteract the dst_release() in sk_dst_reset() */
> > -                       dst_hold(dst);
> >                         sk_dst_reset(sk);
> > -
> >                         rt6_remove_exception_rt(rt);
> >                 }
> >                 rcu_read_unlock();
> > --
> 
> Interesting, what kernel version is your customer using ?

It is a distribution kernel (SLES 15 SP5) that is based on 5.14. The newest SLES service pack, SP6, has a 6.4-based kernel. But the customer has yet to move to that one.

> I think that with recent kernels (after 5.18), we do not see issues
> because of the use of blackhole_netdev
> instead of loopback.

Thank you very much for mentioning that. I will be backporting these patches to SUSE's 5.14-based kernels:
> 9cc341286e99 ("dn_route: set rt neigh to blackhole_netdev instead of loopback_dev in ifdown")
> 4d33ab08c0af ("xfrm: set dst dev to blackhole_netdev instead of loopback_dev in ifdown")
> dd263a8cb194 ("ipv6: blackhole_netdev needs snmp6 counters")
> e5f80fcf869a ("ipv6: give an IPv6 dev to blackhole_netdev")
These patches will not resolve the dst leak but being able to destroy net namespaces at the expense of sustaining infrequently occurring dst leaks is a favourable trade.

The testing results (debugging SLES15 SP5 kernel plus the kprobe module calling dst_release() in probe_ip6_negative_advice()) came back and the kernel log indicates negative overflow of the dst refcount. The first machine:
> [ 9366.700330] dst_release underflow
> [ 9366.700346] WARNING: CPU: 42 PID: 0 at ../net/core/dst.c:176 dst_release+0x19f/0x1b0
> [ 9366.701492] Call Trace:
> [ 9366.701497]  <IRQ>
> [ 9366.701506]  probe_ip6_negative_advice+0x12/0x30 [probe 0c57153a505ed7cc20e2c5db9522a1a524ec4f56]
> [ 9366.701514]  opt_pre_handler+0x3d/0x70
> [ 9366.701528]  optimized_callback+0x64/0x90
> [ 9366.701538]  0xffffffffc0476032
> [ 9366.701548]  ? ip6_negative_advice+0xdf/0x180
> [ 9366.701558]  ? tcp_retransmit_timer+0x658/0x930
> [ 9366.701595]  ? tcp_write_timer_handler+0xba/0x1f0
> [ 9366.701601]  ? tcp_write_timer+0x211/0x260
> [ 9366.701624]  ? call_timer_fn+0x27/0x130
> [ 9366.701631]  ? run_timer_softirq+0x443/0x480
> [ 9366.701645]  ? __do_softirq+0xd2/0x2c0
> [ 9366.701654]  ? irq_exit_rcu+0xa4/0xc0
> [ 9366.701661]  ? sysvec_apic_timer_interrupt+0x50/0x90
> [ 9366.701667]  </IRQ>
> [ 9366.701744] dst_release: dst:00000000ac3b9120 refcnt:-1
> [ 9366.701757] dst_release: dst:00000000ac3b9120 refcnt:-2
> [ 9382.832164] dst_release: dst:00000000ac3b9120 refcnt:-3
> [ 9659.561679] dst_release: dst:00000000494633c6 refcnt:-1
Obviously, the refcount of the cached and expired dst, dst:00000000ac3b9120, was 1 before probe_ip6_negative_advice() was called from tcp_write_timeout()/tcp_retransmit_timer(). So, my supposition that cached dsts being passed to probe_ip6_negative_advice() have a refcount of at least 2 was wrong.

The second machine:
[11479.272704] dst_release underflow
[11479.272718] WARNING: CPU: 52 PID: 0 at ../net/core/dst.c:176 dst_release+0x19f/0x1b0
[11479.272924] Call Trace:
[11479.272928]  <IRQ>
[11479.272932]  tcp_retransmit_timer+0x47c/0x930
[11479.272953]  tcp_write_timer_handler+0xba/0x1f0
[11479.272956]  tcp_write_timer+0x211/0x260
[11479.272962]  call_timer_fn+0x27/0x130
[11479.272966]  run_timer_softirq+0x443/0x480
[11479.272973]  __do_softirq+0xd2/0x2c0
[11479.272980]  irq_exit_rcu+0xa4/0xc0
[11479.272985]  sysvec_apic_timer_interrupt+0x50/0x90
[11479.272989]  </IRQ>
[11479.273044] dst_release: dst:00000000ff7e6845 refcnt:-1
[11681.380331] dst_release: dst:00000000893d8a2d refcnt:-1
In this case, the refcount of dst:00000000ff7e6845 was have been 2 before probe_ip6_negative_advice() so the dst_release() called from the kprobe handler decremented the refcount to 0. No warning was printed. There probably was another socket having the dst stored in sk_dst_cache, to which the refcount of 1 belonged. When the second __sk_dst_reset() was called in tcp_retransmit_timer(), which was the tcp_retransmit_timer+0x47c site, the refcount dropped below 0.

I am afraid this patch is misguided. I would still like to find the source of the dst leak but I am also running out of time which the customer is willing to invest into investigating this issue.
-- 
Jiri Wiesner
SUSE Labs

