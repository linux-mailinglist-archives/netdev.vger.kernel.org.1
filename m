Return-Path: <netdev+bounces-264873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDZyLpD8qmmcZAEAu9opvQ
	(envelope-from <netdev+bounces-264873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 17:10:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B4381224974
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 17:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CC293002931
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FF43B3C12;
	Fri,  6 Mar 2026 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8mplGUA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2363ECBC6
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812945; cv=none; b=EClUwd2y9SfoqQuE/u5uwF8dbmIjv8t9NEHhL2ZjiecuMkjh61rX6ggG3BiZBbV5xWzkn8ZGFBPNnAm2TZhpMz0QSrn1IaWZeio99r8yJPxd4BsPJV4jGmk/IkOgTlcLCull2IzLippMkL3He+Aa8Plq5HD7OSLqseeYUlroddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812945; c=relaxed/simple;
	bh=CsTVC0EV2R91NRGTHbtcx2MmRIHGeZkjkIv9VmrvC7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iFNxnlqafwNntJkkmumKeUY1MAYHkhdFuJ23eNu9zTDBIrWR12FmUD+sEseSzPdM3HBmPclsRzeivbZov2WsMJgEzec8vS3EcBc0Dq7+rz5UqZuRsfyuZoYRRo96roaJkucilUtB2TtUcXN5g9cz2ByIKc1vOQzy4p943bk4aVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8mplGUA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aae4816912so62898435ad.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 08:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772812943; x=1773417743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HNOl9DmH03CuJeZ7EdtVsWa2rfmxXwYbpbUYzp8nbvs=;
        b=D8mplGUA/JsYhlbmFEgmuTjt1StYMkGVyafDMwTx9kUn9cBnSwFUrEi0sjHy/4smVo
         n7Fgzwks9ea8HzV9UylSFadi/r7Mx7+mHxkNZTYHayDVGKz9LfyLCWJAljb48iYPcClP
         wejIkC/Wp53lYP43qcpb9rvt7v/YDd2oowCkVFXSMszhiaItWFg5FMkBIaE3YB9KHOHO
         yiu+kuJX3hGjl2698c5g+hQME+Z5d4rKWtQC+2sbaoYrpnwQpKBN1t/Zu2sY9BXxOkVj
         zxTmhMWs7+f+f12KYQTidPH75GwHw17UWYWbvT3TVu47pF9ep0yJCFrQNAtHjQjUsQRH
         36rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812943; x=1773417743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNOl9DmH03CuJeZ7EdtVsWa2rfmxXwYbpbUYzp8nbvs=;
        b=IqILTM0/VIBTCRaEGzER5No57nz/YSRNbzcel5cRZetbIW2yIcw0G2CsbI0/8474Zr
         XdIHgpo8XGkkpDO/RCzdcSBVedDog2RD5pHxlaNYUCOHHo0dop0gU3/lfu+AG2MdH6aI
         MRJLjHnodfzZ/kYeydLiED325RpXAv+E0WVFNygFYhCPBtTjkgXijvuEIp0ie0Flej2I
         EExOavQMNLI16++dhNbBkM+kNqxpiqFdE6VDH4aLybSlZUY0EeaJTLPLWdHPfdWF+Ma5
         Me+joNqYYKZIuPyUMQP6eKYuK/VoLV1v0is0VRfNVsyRf9Euvgf/ry6CWObd1mgcDPfF
         jArw==
X-Forwarded-Encrypted: i=1; AJvYcCUF5Ds0wTcMEGGXFdppjFGZ2XL44ZzSUOY4vxx4HhAPifMIbbZlHH0qsFqhnqiSFSs6/Pm8Lp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTOmbT///cfPuMwDj8Dd3VIg5bJJB8I7XmWAo2+QbLoHbdvTx+
	cMg3B2i5JN+xqtycx2LYVvFuZQqn8z8TOnHA2bHBwRs0O+nFEnbmQg31
X-Gm-Gg: ATEYQzwVteFWVanx7zmOXyvtjZzzsa9SHyBy/cgQr5rwLLtObG35iftWMwFqH61MALn
	SWP/RXNzreOOxpa4wRM2wcittQTOzu+D8GTYEdFR2mQ+0/KiqApjXtHFYvrMM2a7vkf/gKHvK1K
	0aqRZmgAXzMP323bp7yEyTo5VYxG95wccoFWovb0AKb3DqwZDAjTkuYNrN+VHpnzVhDhQkpkJkh
	38L7KMXxtjiyMd5zo9I8Ly2Y4CsJ1BN/XUiIo0qILnpoUybFJ74suVEbVAdFHqwY78cyyyvWB2k
	OsHtLoMWTathDsJZkOAuLIvPnFOdHpC62mwWBsS5e4NyszPh4DKTp1hVYDsFUKGEw/iwWHU/S8d
	USpC7slu/HO9u5bsg/M6ZP0mf8EvUJyVV+lcaJ3XIptLDx8jHH7rtjfWGwdFnTdepyOoeVSqg+Y
	V0TXnhkFbypmPP3XcxahsfpGG79bQiXBrIvXEj/GK1WbvXTk7fy8+ZX6Zp+n/DuKWr79C5Rk3U4
	qKof/2GfJg=
X-Received: by 2002:a17:903:37c6:b0:2ae:8272:deb0 with SMTP id d9443c01a7336-2ae8272df36mr28165795ad.15.1772812942540;
        Fri, 06 Mar 2026 08:02:22 -0800 (PST)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e97924sm24614515ad.27.2026.03.06.08.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 08:02:21 -0800 (PST)
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
Subject: [PATCH net v4] net: add xmit recursion limit to tunnel xmit functions
Date: Sat,  7 Mar 2026 00:01:34 +0800
Message-ID: <20260306160133.3852900-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4381224974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,asu.edu,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264873-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Weiming Shi <bestswngs@gmail.com>

Tunnel xmit functions (iptunnel_xmit, ip6tunnel_xmit) lack their own
recursion limit. When a bond device in broadcast mode has GRE tap
interfaces as slaves, and those GRE tunnels route back through the
bond, multicast/broadcast traffic triggers infinite recursion between
bond_xmit_broadcast() and ip_tunnel_xmit()/ip6_tnl_xmit(), causing
kernel stack overflow.

The existing XMIT_RECURSION_LIMIT (8) in the no-qdisc path is not
sufficient because tunnel recursion involves route lookups and full IP
output, consuming much more stack per level. Use a lower limit of 4
(IP_TUNNEL_RECURSION_LIMIT) to prevent overflow.

Add recursion detection using dev_xmit_recursion helpers directly in
iptunnel_xmit() and ip6tunnel_xmit() to cover all IPv4/IPv6 tunnel
paths including UDP encapsulated tunnels (VXLAN, Geneve, etc.).

Move dev_xmit_recursion helpers from net/core/dev.h to public header
include/linux/netdevice.h so they can be used by tunnel code.

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

Fixes: 745e20f1b626 ("net: add a recursion limit in xmit path")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v4:
 - Fix subject prefix to use [PATCH net] per netdev convention
v3:
 - Move recursion check from ip_tunnel_xmit()/ip6_tnl_xmit() to
   iptunnel_xmit()/ip6tunnel_xmit() to also cover UDP encapsulated
   tunnels (VXLAN, Geneve, etc.) (Paolo Abeni)
v2:
 - Use IP_TUNNEL_RECURSION_LIMIT (4) instead of MAX_NEST_DEV (8)
   because tunnel recursion consumes more stack per level (Eric Dumazet)
 - Add recursion detection with dev_xmit_recursion helpers
---
 include/linux/netdevice.h | 32 ++++++++++++++++++++++++++++++++
 include/net/ip6_tunnel.h  | 12 ++++++++++++
 include/net/ip_tunnels.h  |  7 +++++++
 net/core/dev.h            | 35 -----------------------------------
 net/ipv4/ip_tunnel_core.c | 13 +++++++++++++
 5 files changed, 64 insertions(+), 35 deletions(-)

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
diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index 120db2865811..1253cbb4b0a4 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -156,6 +156,16 @@ static inline void ip6tunnel_xmit(struct sock *sk, struct sk_buff *skb,
 {
 	int pkt_len, err;
 
+	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
+		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
+				     dev->name);
+		DEV_STATS_INC(dev, tx_errors);
+		kfree_skb(skb);
+		return;
+	}
+
+	dev_xmit_recursion_inc();
+
 	memset(skb->cb, 0, sizeof(struct inet6_skb_parm));
 	IP6CB(skb)->flags = ip6cb_flags;
 	pkt_len = skb->len - skb_inner_network_offset(skb);
@@ -166,6 +176,8 @@ static inline void ip6tunnel_xmit(struct sock *sk, struct sk_buff *skb,
 			pkt_len = -1;
 		iptunnel_xmit_stats(dev, pkt_len);
 	}
+
+	dev_xmit_recursion_dec();
 }
 #endif
 #endif
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
index 98793a738f43..781619e76b3e 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -366,41 +366,6 @@ static inline void napi_assert_will_not_race(const struct napi_struct *napi)
 
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
-
 int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg,
 			    struct netlink_ext_ack *extack);
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 2e61ac137128..b1b6bf949f65 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -58,6 +58,17 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 	struct iphdr *iph;
 	int err;
 
+	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
+		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
+				     dev->name);
+		DEV_STATS_INC(dev, tx_errors);
+		ip_rt_put(rt);
+		kfree_skb(skb);
+		return;
+	}
+
+	dev_xmit_recursion_inc();
+
 	skb_scrub_packet(skb, xnet);
 
 	skb_clear_hash_if_not_l4(skb);
@@ -88,6 +99,8 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 			pkt_len = 0;
 		iptunnel_xmit_stats(dev, pkt_len);
 	}
+
+	dev_xmit_recursion_dec();
 }
 EXPORT_SYMBOL_GPL(iptunnel_xmit);
 
-- 
2.43.0


