Return-Path: <netdev+bounces-130531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE90E98ABAB
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5BF283930
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F38199234;
	Mon, 30 Sep 2024 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AnosJ7u4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PxAZARrR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AnosJ7u4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PxAZARrR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613EE1990D1
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719763; cv=none; b=HtEHZntx8I649lbY7reIeQjhPZx1i411uWP0BANcnE1rZFW1eln7FYLJjZUjG1hZfOjFHyR9Xlt5Sw5aLbQeek37+j6bPM/JqUlBURuIBdtYaEXgnutXmXm7HYQTj7R6AbF/nDyuzJHo+K+KZqb/4ZzHaMRKFmwbGEkldGXPKDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719763; c=relaxed/simple;
	bh=oy+uSwx4XxhLUIdVHhHRuqQqQRExaoTw9lJviTtJcNY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OceQaCKeEb6JDklw5SlAwp5bnDFalSkmoYicY4gYRVNwZHMYluHLVQyDQ38lyhRMdMttmeUXMR/IyniYc3+VExfUG9+bchifvUIcIKseuL+Y6ag6JmHTph75MVpp+Z7jgAw8LkSjsSESCIDU1BskDtZh/eKCs34qpZdRIaiNj/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AnosJ7u4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PxAZARrR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AnosJ7u4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PxAZARrR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA0191F814;
	Mon, 30 Sep 2024 18:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727719757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=KECiQiOiWGgm1BaGr/GBzJZYiMR4R1jdJFmzdkHUNHw=;
	b=AnosJ7u4Lrpeaau38Z2dfTX2vbhiJhFkLlgEjaPMT+URMcjp5fo5yA7ZxDhu++8i10a2KX
	UiNeYzEUwhIpGqX58g9pgNNVIHoLMzeTCS8Fyk3QyLLbrOpgYnXj5v8uq3LuFbGG+Y8Vcp
	YOSlRKMnBBX6vW4aQVEH2+Y2cVRXpYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727719757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=KECiQiOiWGgm1BaGr/GBzJZYiMR4R1jdJFmzdkHUNHw=;
	b=PxAZARrRBGEBo917BFbAhZZ0QYDLn4nPu0ewZS3KjeyrJLTrHgVayv/W4kiKMqiyC0LO1g
	w3jJgbE0cUuaKyCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727719757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=KECiQiOiWGgm1BaGr/GBzJZYiMR4R1jdJFmzdkHUNHw=;
	b=AnosJ7u4Lrpeaau38Z2dfTX2vbhiJhFkLlgEjaPMT+URMcjp5fo5yA7ZxDhu++8i10a2KX
	UiNeYzEUwhIpGqX58g9pgNNVIHoLMzeTCS8Fyk3QyLLbrOpgYnXj5v8uq3LuFbGG+Y8Vcp
	YOSlRKMnBBX6vW4aQVEH2+Y2cVRXpYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727719757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=KECiQiOiWGgm1BaGr/GBzJZYiMR4R1jdJFmzdkHUNHw=;
	b=PxAZARrRBGEBo917BFbAhZZ0QYDLn4nPu0ewZS3KjeyrJLTrHgVayv/W4kiKMqiyC0LO1g
	w3jJgbE0cUuaKyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9209113A8B;
	Mon, 30 Sep 2024 18:09:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QdKbI03p+mZ1UwAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Mon, 30 Sep 2024 18:09:17 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id ABE6AB102B; Mon, 30 Sep 2024 20:09:16 +0200 (CEST)
Date: Mon, 30 Sep 2024 20:09:16 +0200
From: Jiri Wiesner <jwiesner@suse.de>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH] ipv6: route: release reference of dsts cached in sockets
Message-ID: <20240930180916.GA24637@incl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

An unbalanced refcount was reported for the loopback device of a net
namespace being destroyed:
unregister_netdevice: waiting for lo to become free. Usage count = 2

Analysis revealed that the IPv6 net device corresponding to the loopback
device did not get destroyed (in6_dev_finish_destroy() was not called).
The IPv6 loopback device had an unbalaced refcount:
net dev 73da100 lo refcount 1
Operation                     Count Balancing Operation     Count
hold  __ipv6_dev_mc_inc           2 ma_put                      2
      addrconf_ifdown             1                             0 unbalanced
hold  fib6_nh_init                2 fib6_nh_init                2
put   inet6_ifa_finish_destroy    1 ipv6_add_addr               1
      ip6_dst_destroy            90                             0 unbalanced
      ip6_dst_ifdown             90                             0 unbalanced
hold  ip6_route_dev_notify        6 ip6_route_dev_notify        6
hold  ipv6_add_addr               1 inet6_ifa_finish_destroy    1
put   ma_put                      2 __ipv6_dev_mc_inc           2
hold  ndisc_netdev_event          2 ndisc_netdev_event          2
      rt6_disable_ip              1                             0 unbalanced

The refcount of addrconf_ifdown() balances the refcount increment in
ipv6_add_dev(), which had no corresponding trace entry. The
rt6_disable_ip() and ip6_dst_ifdown() entries were hold operations on the
looback device, and the ip6_dst_destroy() entries were put operations. One
refcount decrement in ip6_dst_destroy() was not executed. At this point, a
hash was implemented in the debug kernel to hold the changes of the
refcount of dst objects per namespace. The trace for the dst object that
did not decrement the IPv6 refcount of loopback follows:

Function        Parent       Op  Net            Device Dst              Refcount Diff
ip6_dst_ifdown: dst_dev_put: dst ff404b2f073da100 eth0 ff404af71ffc9c00 1
ip6_negative_advice: tcp_retransmit_timer: dst_hold ff404b2f073da100 eth0 ff404af71ffc9c00 1
dst_alloc: ip6_dst_alloc: dst_hold ff404b2f073da100 eth0 ff404af71ffc9c00 1
ip6_route_output_flags: ip6_dst_lookup_tail: dst_hold ff404b2f073da100 eth0 ff404af71ffc9c00 84
dst_release: ip6_negative_advice: dst_put ff404b2f073da100 eth0 ff404af71ffc9c00 1
dst_release: tcp_retransmit_timer: dst_put ff404b2f073da100 eth0 ff404af71ffc9c00 20
dst_release: inet_sock_destruct: dst_put ff404b2f073da100 eth0 ff404af71ffc9c00 29
dst_release: __dev_queue_xmit: dst_put ff404b2f073da100 eth0 ff404af71ffc9c00 34
dst_release: rt6_remove_exception: dst_put ffffffff9c8e2a80 blackhole_dev ff404af71ffc9c00 1

The ip6_dst_ifdown() trace entry was neither a hold nor a put - it merely
indicates that the net device of the dst object was changed to
blackhole_dev and the IPv6 refcount was transferred onto the loopback
device. There was no ip6_dst_destroy() trace entry, which means the dst
object was not destroyed. There were 86 hold operations but only 85 put
operations so the dst object was not destroyed because the refcount of the
dst object was unbalanced.

The problem is that the refcount sums are ambiguous. The most probable
explanation is this: The dst object was a route for an IPv6 TCP connection
that kept timing out. Sometimes, the process closed the socket, which
corresponds to the refcount decrements of the
dst_release()/inet_sock_destruct() entries. Sometimes, the TCP retransmit
timer reset the dst of the sockets, which corresponds to the
dst_release()/tcp_retransmit_timer() entries. I am unsure about the
dst_release()/__dev_queue_xmit() entries because inet6_csk_xmit() sets
skb->_skb_refdst with SKB_DST_NOREF.

The feature that sets the above trace apart from all the other dst traces
is the execution of ip6_negative_advice() for a cached and also expired
dst object in the exception table. The cached and expired dst object has
its refcount set to at least 2 before executing rt6_remove_exception_rt()
found in ip6_negative_advice(). One decrement happens in
rt6_remove_exception() after the dst object has been removed from the
exception table. The other decrement happens in sk_dst_reset() but that
one is counteracted by a dst_hold() intentionally placed just before the
sk_dst_reset() in ip6_negative_advice(). The probem is that a socket that
keeps a reference to a dst in its sk_dst_cache member increments the
refcount of the dst by 1. This is apparent in the following code paths:
* When ip6_route_output_flags() finds a dst that is then stored in
  sk->sk_dst_cache by ip6_dst_store() called from inet6_csk_route_socket().
* When inet_sock_destruct() calls dst_release() for sk->sk_dst_cache
Provided the dst is not kept in the sk_dst_cache member of another socket,
there is no other object tied to the dst (the socket lost its reference
and the dst is no longer in the exception table) and the dst becomes a
leaked object after ip6_negative_advice() finishes. This leak then
precludes the net namespace from being destroyed.

The patch that introduced the dst_hold() in ip6_negative_advice() was
92f1655aa2b22 ("net: fix __dst_negative_advice() race"). But 92f1655aa2b22
only refactored the code with regards to the dst refcount so the issue was
present even before 92f1655aa2b22.

Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
---
At the moment, I am sending this as an RFC because I am not able to 
reproduce the issue in-house. The customer that encountered the issue is 
currently running tests. For the customer's testing, I fixed the issue 
with a kprobe module that calls dst_release() right after 
rt6_remove_exception_rt() returns in ip6_negative_advice(), which is not 
quite the same as the change proposed below.

 net/ipv6/route.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b4251915585f..b70267c8d251 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2780,10 +2780,7 @@ static void ip6_negative_advice(struct sock *sk,
 	if (rt->rt6i_flags & RTF_CACHE) {
 		rcu_read_lock();
 		if (rt6_check_expired(rt)) {
-			/* counteract the dst_release() in sk_dst_reset() */
-			dst_hold(dst);
 			sk_dst_reset(sk);
-
 			rt6_remove_exception_rt(rt);
 		}
 		rcu_read_unlock();
-- 
2.35.3


-- 
Jiri Wiesner
SUSE Labs

