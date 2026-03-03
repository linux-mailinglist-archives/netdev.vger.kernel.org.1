Return-Path: <netdev+bounces-263331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPscH/QRp2k0cwAAu9opvQ
	(envelope-from <netdev+bounces-263331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:53:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C21F71F429F
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88CDF3059FE9
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19AA3CD8C5;
	Tue,  3 Mar 2026 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoltW9n5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932723CA4AF
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556538; cv=none; b=CG+v7gVDk+wcI11ZCwx9UH/xaBHij3665cKcHcjUqeSE9q1RsZmmXlB++l/eBoSorTFBZ+M2v2jOYwqVyvQ7F1z9EAIWDrqL+KC8+ALPHL5JGaC2FqLdlGXpUK/c0TWLBSk6k1bpgg3D1FQehblgfY64izmIjElXMpWWkUnkX9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556538; c=relaxed/simple;
	bh=098nhU7x4lcZXqJyI/AQLle5Tuj6VXVN7bRv1Y6GfqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NVKQBDrWb7yl2v/acsonuOZuezPc+vz8GIan38+lPRuQzqSElXUB3P9afIkgHiSMCxSHW6GH6HpHUn2YVEcgQByPVki4yq0mD80O/hQWlp+YiTdjWkhh7ToRnNa5zSArq6LViiG9MlT46IJof3L1Bs7T0uwQgYpZUe42syDSUa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoltW9n5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-827307b12dfso3170288b3a.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 08:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772556537; x=1773161337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nVGTjSPGwp4w2ILnjIgMur2s24WwV0NXgkchZ/zUpvc=;
        b=VoltW9n5XoE9/34NT7iyiabQoX/WQ/7nv6C0qHTSDJRZA/pWzXH8sAtJP76b/E7RDF
         vZcJd7XcROg3UF+jHUAfRhZKUPcyfKweHBna7TQBSnvq+/7qaiGxwuBULSjTwH2lHoOs
         Dndt1ijD5vdN7aKKGf3JF/huwfeSjssSI5e+7RMyAHcZctU+FpMZx3Jjb1x6+1InZEyB
         tzpyx0sl+9IjUhxL3RIyCHNEyY58zks0VTpIwa9DLo+tC9yO7BjctNAhpbKJwtV87okl
         P+KGI1Jq7Tf2L/Iwts0eR5iB2bMUVjF6W+DMLQtJa1sC1Se9VeDoNKfPwNmRyl8uINrS
         k9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772556537; x=1773161337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVGTjSPGwp4w2ILnjIgMur2s24WwV0NXgkchZ/zUpvc=;
        b=AsOXWKwwxjSihTiAqjZAB1g3W1h61H2UOp5IPCcMP5fzLHDeXXawa0G+K09e98rS61
         FTsGOFuaVYqqoMZqUK3kt5n8DmbVcq8RqL1Pwq0VzyHNFjELgVMIzFZLMg1jvlTA73oV
         v7cCq9Rm5e99hPMir2BMx4Fom5ZMQH6OQVf8fB2zuMyIZI7wrozmXudZbttxCqFvyQA/
         2ByZro0U/m7DbnxvZZqHtuDfA0Ib92vZv9Ux7Ri6oXffU88MKFjZl3PmnJxaILHM2/yX
         oDGhW8UIzFNvAoxO10zHsa2Aa/BnuhfPRSCRGphmQwgbc6LxN772ggp8IT6VMGQb8G/b
         Ipog==
X-Forwarded-Encrypted: i=1; AJvYcCUx24g5VvfiCb9Srv0kX/BlcmPdOCsqlPudfc5iXJt2R67gdCFdrY6OryQNxa3CDZWCDPCCAFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3iL/QTGu6WoTGGO+IohsYMG39iaNABrF63TJ8He/ETNgk1Mq
	PWHaLFDQjij77c7/udyGSYsEbnpxZlz60pL1e3dbdv/09FzxHbIyESLh
X-Gm-Gg: ATEYQzx3Osb/kcZZqLYWoNUQj8lVSjRAmgjXXFU3cJqkxseJDCAQXnQhhj7KQPFzQlU
	GCXtPzQLhbYQ0UPfLbVHV8a5o+J7uakDwr/7aG+LktfLUiy4SB6HmJ050aUGOUdCim3rpbiiR59
	WNleuPPTZXDSv+sig6SrnmFkgX3QtlJUSSL5glM6zWQptFEYv4uPMdqrGLjur5Y7O6jr3+JTCqP
	/GVTaBDkOHVJkH2ImgkhJDIIAQvp0zon1Bzt9uzbe2iUCUfLuc2bSc6a4ZgRsqBF15S9FwW75ST
	AISitixnHYJCaGsnVYdrBd0KAR6UhwJG/Dl1k2L4z5ydFq7zRh051tAmAwdmbQq8pIGvfHqGS5I
	iJl24gUMUJcdMDMFStMdxSYToeWwehYAR3UE0w/XYSyZCUvcjDgPPALBlVeqKx4iqcKauSKnIgW
	0NMDpAgsUBYwxEBWYasnldCeOP4hrt3bx8cu8EgjKh6VSrbZ8nHoW22GY3adiakh/8tnEa4+4xG
	7BMz/KVB7A=
X-Received: by 2002:a05:6a00:2d86:b0:81c:5bca:8104 with SMTP id d2e1a72fcca58-8295d899908mr2406962b3a.24.1772556536647;
        Tue, 03 Mar 2026 08:48:56 -0800 (PST)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1ca9sm15617418b3a.36.2026.03.03.08.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 08:48:55 -0800 (PST)
From: bestswngs@gmail.com
To: security@kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v2] net: add xmit recursion limit to tunnel drivers
Date: Wed,  4 Mar 2026 00:43:26 +0800
Message-ID: <20260303164326.1803916-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C21F71F429F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,asu.edu,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263331-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Weiming Shi <bestswngs@gmail.com>

__dev_queue_xmit() has two transmit code paths depending on whether the
device has a qdisc attached:

 1. Qdisc path (q->enqueue): calls __dev_xmit_skb()
 2. No-qdisc path: calls dev_hard_start_xmit() directly

Commit 745e20f1b626 ("net: add a recursion limit in xmit path") added
recursion protection to the no-qdisc path via dev_xmit_recursion()
check and dev_xmit_recursion_inc()/dec() tracking. However, the qdisc
path performs no recursion depth checking at all.

This allows unbounded recursion through qdisc-attached devices. For
example, a bond interface in broadcast mode with gretap slaves whose
remote endpoints route back through the bond creates an infinite
transmit loop that exhausts the kernel stack:

 BUG: KASAN: stack-out-of-bounds in blake2s.constprop.0+0xe7/0x160
 Write of size 32 at addr ffff88810033fed0 by task kworker/0:1/11
 Workqueue: mld mld_ifc_work
 Call Trace:
  <TASK>
  __build_flow_key.constprop.0 (net/ipv4/route.c:515)
  ip_rt_update_pmtu (net/ipv4/route.c:1073)
  iptunnel_xmit (net/ipv4/ip_tunnel_core.c:84)
  ip_tunnel_xmit (net/ipv4/ip_tunnel.c:847)
  gre_tap_xmit (net/ipv4/ip_gre.c:779)
  dev_hard_start_xmit (net/core/dev.c:3887)
  sch_direct_xmit (net/sched/sch_generic.c:347)
  __dev_queue_xmit (net/core/dev.c:4802)
  bond_dev_queue_xmit (drivers/net/bonding/bond_main.c:312)
  bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5279)
  bond_start_xmit (drivers/net/bonding/bond_main.c:5530)
  dev_hard_start_xmit (net/core/dev.c:3887)
  __dev_queue_xmit (net/core/dev.c:4841)
  ip_finish_output2 (net/ipv4/ip_output.c:237)
  ip_output (net/ipv4/ip_output.c:438)
  iptunnel_xmit (net/ipv4/ip_tunnel_core.c:86)
  gre_tap_xmit (net/ipv4/ip_gre.c:779)
  dev_hard_start_xmit (net/core/dev.c:3887)
  sch_direct_xmit (net/sched/sch_generic.c:347)
  __dev_queue_xmit (net/core/dev.c:4802)
  bond_dev_queue_xmit (drivers/net/bonding/bond_main.c:312)
  bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5279)
  bond_start_xmit (drivers/net/bonding/bond_main.c:5530)
  dev_hard_start_xmit (net/core/dev.c:3887)
  __dev_queue_xmit (net/core/dev.c:4841)
  ip_finish_output2 (net/ipv4/ip_output.c:237)
  ip_output (net/ipv4/ip_output.c:438)
  iptunnel_xmit (net/ipv4/ip_tunnel_core.c:86)
  ip_tunnel_xmit (net/ipv4/ip_tunnel.c:847)
  gre_tap_xmit (net/ipv4/ip_gre.c:779)
  dev_hard_start_xmit (net/core/dev.c:3887)
  sch_direct_xmit (net/sched/sch_generic.c:347)
  __dev_queue_xmit (net/core/dev.c:4802)
  bond_dev_queue_xmit (drivers/net/bonding/bond_main.c:312)
  bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5279)
  bond_start_xmit (drivers/net/bonding/bond_main.c:5530)
  dev_hard_start_xmit (net/core/dev.c:3887)
  __dev_queue_xmit (net/core/dev.c:4841)
  mld_sendpack
  mld_ifc_work
  process_one_work
  worker_thread
  </TASK>

Rather than adding an expensive recursion check to the common qdisc
fast path, add recursion detection directly in tunnel drivers where
route lookups can create these loops, as suggested by Eric Dumazet.

Use a lower limit (IP_TUNNEL_RECURSION_LIMIT=4) than XMIT_RECURSION_LIMIT
(8) because each tunnel recursion level involves route lookups and full
IP output processing, consuming significantly more stack per level.

Move dev_xmit_recursion helpers from the private net/core/dev.h header
to the public include/linux/netdevice.h so tunnel drivers can use them.

Fixes: 745e20f1b626 ("net: add a recursion limit in xmit path")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
  - Move recursion check from qdisc path to tunnel drivers (Eric Dumazet)
  - Add IPv6 tunnel (ip6_tunnel) coverage
  - Use lower recursion limit (4) for tunnel-specific stack consumption

 include/linux/netdevice.h | 32 ++++++++++++++++++++++++++++++++
 include/net/ip_tunnels.h  |  7 +++++++
 net/core/dev.h            | 34 ----------------------------------
 net/ipv4/ip_tunnel.c      | 10 ++++++++++
 net/ipv6/ip6_tunnel.c     | 10 ++++++++++
 5 files changed, 59 insertions(+), 34 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d4e6e00bb90a..1a4d2542dbab 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3576,17 +3576,49 @@ struct page_pool_bh {
 };
 DECLARE_PER_CPU(struct page_pool_bh, system_page_pool);
 
+#define XMIT_RECURSION_LIMIT	8
+
 #ifndef CONFIG_PREEMPT_RT
 static inline int dev_recursion_level(void)
 {
 	return this_cpu_read(softnet_data.xmit.recursion);
 }
+
+static inline bool dev_xmit_recursion(void)
+{
+	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
+			XMIT_RECURSION_LIMIT);
+}
+
+static inline void dev_xmit_recursion_inc(void)
+{
+	__this_cpu_inc(softnet_data.xmit.recursion);
+}
+
+static inline void dev_xmit_recursion_dec(void)
+{
+	__this_cpu_dec(softnet_data.xmit.recursion);
+}
 #else
 static inline int dev_recursion_level(void)
 {
 	return current->net_xmit.recursion;
 }
 
+static inline bool dev_xmit_recursion(void)
+{
+	return unlikely(current->net_xmit.recursion > XMIT_RECURSION_LIMIT);
+}
+
+static inline void dev_xmit_recursion_inc(void)
+{
+	current->net_xmit.recursion++;
+}
+
+static inline void dev_xmit_recursion_dec(void)
+{
+	current->net_xmit.recursion--;
+}
 #endif
 
 void __netif_schedule(struct Qdisc *q);
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 4021e6a73e32..80662f812080 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -27,6 +27,13 @@
 #include <net/ip6_route.h>
 #endif
 
+/* Recursion limit for tunnel xmit to detect routing loops.
+ * Unlike XMIT_RECURSION_LIMIT (8) used in the no-qdisc path, tunnel
+ * recursion involves route lookups and full IP output, consuming much
+ * more stack per level, so a lower limit is needed.
+ */
+#define IP_TUNNEL_RECURSION_LIMIT	4
+
 /* Keep error state on tunnel for 30 sec */
 #define IPTUNNEL_ERR_TIMEO	(30*HZ)
 
diff --git a/net/core/dev.h b/net/core/dev.h
index 98793a738f43..ec974b3c42d9 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -366,40 +366,6 @@ static inline void napi_assert_will_not_race(const struct napi_struct *napi)
 
 void kick_defer_list_purge(unsigned int cpu);
 
-#define XMIT_RECURSION_LIMIT	8
-
-#ifndef CONFIG_PREEMPT_RT
-static inline bool dev_xmit_recursion(void)
-{
-	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
-			XMIT_RECURSION_LIMIT);
-}
-
-static inline void dev_xmit_recursion_inc(void)
-{
-	__this_cpu_inc(softnet_data.xmit.recursion);
-}
-
-static inline void dev_xmit_recursion_dec(void)
-{
-	__this_cpu_dec(softnet_data.xmit.recursion);
-}
-#else
-static inline bool dev_xmit_recursion(void)
-{
-	return unlikely(current->net_xmit.recursion > XMIT_RECURSION_LIMIT);
-}
-
-static inline void dev_xmit_recursion_inc(void)
-{
-	current->net_xmit.recursion++;
-}
-
-static inline void dev_xmit_recursion_dec(void)
-{
-	current->net_xmit.recursion--;
-}
-#endif
 
 int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg,
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 50d0f5fe4e4c..39822e845a06 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -683,6 +683,14 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	__be32 dst;
 	__be16 df;
 
+	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
+		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
+				     dev->name);
+		DEV_STATS_INC(dev, tx_errors);
+		kfree_skb(skb);
+		return;
+	}
+
 	inner_iph = (const struct iphdr *)skb_inner_network_header(skb);
 	connected = (tunnel->parms.iph.daddr != 0);
 	payload_protocol = skb_protocol(skb, true);
@@ -842,8 +850,10 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_adj_headroom(dev, max_headroom);
 
+	dev_xmit_recursion_inc();
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
+	dev_xmit_recursion_dec();
 	return;
 
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 4c29aa94e86e..55bedd5cd656 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1101,6 +1101,14 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	u8 hop_limit;
 	int err = -1;
 
+	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
+		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
+				     dev->name);
+		DEV_STATS_INC(dev, tx_errors);
+		kfree_skb(skb);
+		return -1;
+	}
+
 	payload_protocol = skb_protocol(skb, true);
 
 	if (t->parms.collect_md) {
@@ -1277,7 +1285,9 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	ipv6h->nexthdr = proto;
 	ipv6h->saddr = fl6->saddr;
 	ipv6h->daddr = fl6->daddr;
+	dev_xmit_recursion_inc();
 	ip6tunnel_xmit(NULL, skb, dev, 0);
+	dev_xmit_recursion_dec();
 	return 0;
 tx_err_link_failure:
 	DEV_STATS_INC(dev, tx_carrier_errors);
-- 
2.43.0


