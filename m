Return-Path: <netdev+bounces-303063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s0o1CoiRQ2o8cQoAu9opvQ
	(envelope-from <netdev+bounces-303063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:51:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 737D86E2743
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:51:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=FIr5FheH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303063-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303063-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BC9F3044134
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B76137F01B;
	Tue, 30 Jun 2026 09:44:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF481DE894
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 09:44:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812655; cv=none; b=c2TA4rmx9wdMwqQXmXik2nTAI1vvViW9JoSz6OoX6NS/Ts1TuqWnk5qmuNwirqEJIPctPSq2P4CuYZqBtSDUPHdWOw1cbDuzo+bcWlgq8NfWsYKHLTMxc1ia829V0vjDcLdVEEt1bsd+ywYw59+DW5tu0Nhoqtcxd7kC/8foxjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812655; c=relaxed/simple;
	bh=oupUiEMDcMnAyLGsPxx8QGnBoeuQ2C/o4Nwwq57KXns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MpiJaPnVT7Bw3Fpl4i2Vur82e9ZA5yT0mR2/4tuwRjkFcDKFLFWCdlarOet5uzwDSpPK+KI+xXimLzHws9jNofNLe7e5bPE9puJEVgC4J/8GX3Mj88OxoUE+5RZJydAXj5zz6ndYx0lXqPfkl8YCXwSBCjXd+oIIRfWdkBwHhOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FIr5FheH; arc=none smtp.client-ip=91.218.175.174
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782812651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RlXVy39WxevdJg+dRELNULcdQzpTU2wu1rmjs9ovpQo=;
	b=FIr5FheHeUJwKx+VNDCtNiYxgCUIb5qkpM26Lykc5toqeOlu3RtKiWhQ38UvjwdkDulmzG
	EMAO3S6r9sXcRNNXOOcGkM2kVyK9Xt3OGKRPjN2cOnzX1buoz/1pKvNQVZFfQnRtZ8a8jv
	oVzdB5deyq+qJHzl4XHTWwKflmewVYg=
From: xuanqiang.luo@linux.dev
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v1] ipv4: hold a consistent view of rt->dst.dev under RCU
Date: Tue, 30 Jun 2026 17:42:50 +0800
Message-ID: <20260630094250.29386-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303063-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luoxuanqiang@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 737D86E2743

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

rt_flush_dev() walks the per-CPU uncached route list and rewrites
rt->dst.dev in-place to blackhole_netdev under spin_lock_bh().
This lock does not exclude RCU readers, which may load rt->dst.dev
multiple times within a single rcu_read_lock() region.

ip_rt_send_redirect() is a typical example: it reads rt->dst.dev
three times to obtain in_dev, the L3 master ifindex, and net.
A concurrent device unregistration can repoint rt->dst.dev to
blackhole_netdev between those reads, making the reader combine
state from two different net_devices — for instance, an in_dev
from the real device but a netns and peer lookup from the blackhole
device, causing ICMP redirects to be issued against the wrong
namespace.  ip_rt_get_source() has the same problem: it reads
rt->dst.dev four times to obtain the output ifindex, the netns,
and the source address, so a concurrent flush can cause the source
selection to mix state from different devices.

Take a single READ_ONCE() snapshot of rt->dst.dev at the start of
each affected RCU reader and use that snapshot throughout, so
concurrent flushes cannot cause mid-function inconsistency.
Publish the in-place write in rt_flush_dev() with WRITE_ONCE() to
pair with the readers.

Fixes: caacf05e5ad1a ("ipv4: Properly purge netdev references on uncached routes.")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/ipv4/route.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3f3de5164d6e5..e14325c4929ab 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -873,6 +873,7 @@ static void ipv4_negative_advice(struct sock *sk,
 void ip_rt_send_redirect(struct sk_buff *skb)
 {
 	struct rtable *rt = skb_rtable(skb);
+	struct net_device *dev;
 	struct in_device *in_dev;
 	struct inet_peer *peer;
 	struct net *net;
@@ -880,15 +881,16 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 	int vif;
 
 	rcu_read_lock();
-	in_dev = __in_dev_get_rcu(rt->dst.dev);
+	dev = READ_ONCE(rt->dst.dev);
+	in_dev = __in_dev_get_rcu(dev);
 	if (!in_dev || !IN_DEV_TX_REDIRECTS(in_dev)) {
 		rcu_read_unlock();
 		return;
 	}
 	log_martians = IN_DEV_LOG_MARTIANS(in_dev);
-	vif = l3mdev_master_ifindex_rcu(rt->dst.dev);
+	vif = l3mdev_master_ifindex_rcu(dev);
 
-	net = dev_net(rt->dst.dev);
+	net = dev_net(dev);
 	peer = inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr, vif);
 	if (!peer) {
 		rcu_read_unlock();
@@ -1287,29 +1289,32 @@ void ip_rt_get_source(u8 *addr, struct sk_buff *skb, struct rtable *rt)
 {
 	__be32 src;
 
-	if (rt_is_output_route(rt))
+	rcu_read_lock();
+	if (rt_is_output_route(rt)) {
 		src = ip_hdr(skb)->saddr;
-	else {
+	} else {
 		struct fib_result res;
 		struct iphdr *iph = ip_hdr(skb);
+		struct net_device *dev = READ_ONCE(rt->dst.dev);
+		struct net *net = dev_net(dev);
 		struct flowi4 fl4 = {
 			.daddr = iph->daddr,
 			.saddr = iph->saddr,
 			.flowi4_dscp = ip4h_dscp(iph),
-			.flowi4_oif = rt->dst.dev->ifindex,
+			.flowi4_oif = dev->ifindex,
 			.flowi4_iif = skb->dev->ifindex,
 			.flowi4_mark = skb->mark,
 		};
 
-		rcu_read_lock();
-		if (fib_lookup(dev_net(rt->dst.dev), &fl4, &res, 0) == 0)
-			src = fib_result_prefsrc(dev_net(rt->dst.dev), &res);
+		if (fib_lookup(net, &fl4, &res, 0) == 0)
+			src = fib_result_prefsrc(net, &res);
 		else
-			src = inet_select_addr(rt->dst.dev,
+			src = inet_select_addr(dev,
 					       rt_nexthop(rt, iph->daddr),
 					       RT_SCOPE_UNIVERSE);
-		rcu_read_unlock();
 	}
+	rcu_read_unlock();
+
 	memcpy(addr, &src, 4);
 }
 
@@ -1565,7 +1570,7 @@ void rt_flush_dev(struct net_device *dev)
 		list_for_each_entry_safe(rt, safe, &ul->head, dst.rt_uncached) {
 			if (rt->dst.dev != dev)
 				continue;
-			rt->dst.dev = blackhole_netdev;
+			WRITE_ONCE(rt->dst.dev, blackhole_netdev);
 			netdev_ref_replace(dev, blackhole_netdev,
 					   &rt->dst.dev_tracker, GFP_ATOMIC);
 			list_del_init(&rt->dst.rt_uncached);
-- 
2.43.0


