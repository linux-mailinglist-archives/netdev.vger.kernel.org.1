Return-Path: <netdev+bounces-303453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xZLYF2yHRGppwQoAu9opvQ
	(envelope-from <netdev+bounces-303453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 05:20:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 781806E96B6
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 05:20:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=JnkcQ8r8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303453-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303453-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1EE13014234
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 03:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA6625EF9C;
	Wed,  1 Jul 2026 03:19:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F31155A5D
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 03:19:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875996; cv=none; b=WMBUWXsaK3qjQ/pZNfsv0Z4+tHx7LowRUfBsyWqgYzbSBsbGUxjiD4tkWewDGEb11PxtaXmwrAzhjhU8GPAeNJq+LMBc2Js+HZQ6DhxCdYS6T8JLAfCiiHfFVqxW+LpJ/xLsE0ssboZZr6fKwAdxi+3ZKCRkRLkbgFzZkh2S4Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875996; c=relaxed/simple;
	bh=v/+DavR8tRBmPogGEbRLyoYwByy7clgvstIgjdG2E7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/vmLP3RbXSoID634yR04r5AmRudyYSVmy1wGEb2kYWFswpCLGiyDfk4s4Wiq/G//higlyMSVLDP6g2fylzB47XQ1fzrICU6sMm7f0Q584eHMmALa9pFl2+0JxQe2PToiElWGyhZmzj6kNiJrRbbcDMgpBj7AwpStoErR1bMsy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JnkcQ8r8; arc=none smtp.client-ip=91.218.175.189
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782875983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5NAHIWlyEWl1hlg6uEH0Z3tmc81TasF279IcSkQr1qc=;
	b=JnkcQ8r8KQkKLQLA7Nc8NwCMNKvTm/zc9B+LmCB8eyEZR3lT9mEDcvnLOdlxxfr7/a7uDa
	dKPl9l52n8dSJeUuO07aQcv3kvDSdipvItyyAm919srQdhzuREIq82Ne1F7G3UTZhvmwmA
	zfghlXPa9lY82UCfqzg75b8s19M0auM=
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
Subject: [PATCH net-next v2] ipv4: hold a consistent view of rt->dst.dev under RCU
Date: Wed,  1 Jul 2026 11:16:21 +0800
Message-ID: <20260701031621.17322-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260630094250.29386-1-xuanqiang.luo@linux.dev>
References: <20260630094250.29386-1-xuanqiang.luo@linux.dev>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303453-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luoxuanqiang@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 781806E96B6

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
device.  ip_rt_get_source() has the same problem: it reads
rt->dst.dev four times to obtain the output ifindex, the netns,
and the source address, so a concurrent flush can cause the source
selection to mix state from different devices.

Take a single dst_dev_rcu() snapshot of rt->dst.dev at the start
of each affected RCU reader and use that snapshot throughout, so
concurrent flushes cannot cause mid-function inconsistency.
Publish the in-place write in rt_flush_dev() with rcu_assign_pointer()
to match the readers.

Fixes: caacf05e5ad1a ("ipv4: Properly purge netdev references on uncached routes.")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
v2:
- Use dst_dev_rcu() and dev_net_rcu() for the RCU readers.
- Use rcu_assign_pointer() when publishing the uncached route device
  replacement.
- Slightly adjust the commit message wording because this issue was found
  by inspection, not from an observed user-visible failure.

v1: https://lore.kernel.org/all/20260630094250.29386-1-xuanqiang.luo@linux.dev/

 net/ipv4/route.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3f3de5164d6e5..57f38467e6d0c 100644
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
+	dev = dst_dev_rcu(&rt->dst);
+	in_dev = __in_dev_get_rcu(dev);
 	if (!in_dev || !IN_DEV_TX_REDIRECTS(in_dev)) {
 		rcu_read_unlock();
 		return;
 	}
 	log_martians = IN_DEV_LOG_MARTIANS(in_dev);
-	vif = l3mdev_master_ifindex_rcu(rt->dst.dev);
+	vif = l3mdev_master_ifindex_rcu(dev);
 
-	net = dev_net(rt->dst.dev);
+	net = dev_net_rcu(dev);
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
+		struct net_device *dev = dst_dev_rcu(&rt->dst);
+		struct net *net = dev_net_rcu(dev);
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
+			rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
 			netdev_ref_replace(dev, blackhole_netdev,
 					   &rt->dst.dev_tracker, GFP_ATOMIC);
 			list_del_init(&rt->dst.rt_uncached);
-- 
2.43.0

