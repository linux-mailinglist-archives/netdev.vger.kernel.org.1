Return-Path: <netdev+bounces-264512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM2jAJfJqWkAFAEAu9opvQ
	(envelope-from <netdev+bounces-264512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:21:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ADA216EFB
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E97BA3045AA2
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870EE3E7165;
	Thu,  5 Mar 2026 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0kn33If"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F1D366078
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772734864; cv=none; b=lg+RtXojoWkls576gxf+Gf/D0BZZl4cuwf43oc29ZDCUo9Qezog8R4+nFjMv16dkcg7O4rtIPYobGXIXx1t1+Zk/KajoTLGa+dhJF2Zo6zNumwZJuh7JPx3J/hDkpjW1jMXxkoZOCIcYN43TYxz1oGE8QfjnzwfnL55whAS9HhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772734864; c=relaxed/simple;
	bh=vR2v3O/pArH8VqPTkQ3RZ+AThT/QAPULI15DrY4Xfxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ufOWlUyCYtLT4XPgRWMgHYTd401a+iEqgub2RaL24cboTjF2+67KzVkHCss7PjWR/9KYMxsHMysg4PZ1XhrUAHerG8WrLYBNYQnI+8xKPhI5+6UkIeSGXlH/WO3m8M2xFQC5yUC3PjoeezFpIXlOujqZG5hyYLXNR8ish4uPz5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0kn33If; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-829759ca646so1166785b3a.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 10:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772734861; x=1773339661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=shETpuP41yo70lUfj5XvzMyYs5NmOFLY8IlGlWXYctU=;
        b=b0kn33If89HqEVTQ52SHpgf+PIf1XZ98my4Gojv/8Vc7/Fv0jBBp2sWoa2kmRmdC0l
         uf0ae6cOEMjWJ1DiX75UE9dbPpQxWbA4wSCAdluOrnsCT2XjlquIzv7kG8z8D2wsft1d
         vZfoCxAO+vWm2waB+rSbIxx2noKt9vnK9XCYpLWqWSZ8ItH6EUKh125JSOEkHLpJ2jH7
         c9wfR9myo2iSpfQlrsP7rwTdtpr0jiOmqWC7481zFrNesgOpeUaOasWSs1aC09pYUVmh
         BFdbX0S/XjpAZdEVWHf8i+VnYfGoPSxWtn1aVf3nDp+dFJszMQ/pbrDt90MzWaJm0auA
         pH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772734861; x=1773339661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shETpuP41yo70lUfj5XvzMyYs5NmOFLY8IlGlWXYctU=;
        b=KjjE1B/lk8m+vifoPslHQN0ZhifKe9hBNe8f6/I+le3WCiC5JYpgS1WSH61n+/mHaN
         Wj7Z5inYdn21W7R0q0N+yZMCuTKA280FCZ1gIPDzgshNU2q/dBz29MIxHGLM6rMh2kfP
         dEbp/au4SOBlAwyPaxbPdWsfBNLaTQlHJ3FQ7Hbmu1EN7gZ1vj/LJu5xSIrWrDaxnHTJ
         RxO8bRl3hHX0pGVFt2Dr3DOzE5GfVdGsARgOXEhBZt/vYON3dc9ful3awUFXmCf8a/tz
         kudqhbxW5P38h7h2YgnHLlFDRM3TidzsmEg9+WsX6CJquTsmVGEqpeLw4sgPbXz/+Kwe
         c8fA==
X-Forwarded-Encrypted: i=1; AJvYcCWoHL+2q+cfH7nTZ/XbW1Z+nPdRFzQbyqL9IYbyPsP22993uMjOfHCwoDcxvHd6OyU4bqkcKh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx46FykkC4VzVTEur/wqTQucAaD505y5FSzcCd3cGXAU3JyvGPf
	8TxP4S5Vh4cvvqI5ntXRm9dHQgy4YfAzVzmJBtePk7ULVM0S0+krlFw2W2zEH5LIyuU=
X-Gm-Gg: ATEYQzxK/C3pSHcFe/5CFeiI56hcJq2gqicGLVtEsvYY56L55mVMKWyTZNZRGkiu/6j
	aAbm8SSMW69wWiuXfJtVxNW4o6rJcq6ZvN7KiIhqpc5ryUKZ0MSn8MYVumsJMlOPwougNwaMNDH
	SJmSiLJwt55Q8jS795rZCGL/MyfpJwm/9y461iZdHRo5rjNs2tZygfyjBe7TH7wE+kT0vuoBZQk
	5ffB18+Er2u9np0N49YEi3IlPOk384/OYVdqTAHfdVvL9858Anhbwfp4zdsENEftgRAYQCI9cQP
	PKXr7M0Fb5vcfLw+Py12+BQgYXVUKlAfwM/qfyBUn4u95ec6q+JsLeqCbQ998wSUuLcqqEcef4H
	RJPvtunChPBIv2YklNyiTM77JX+BbSM4kwdsy2r0lqBhf0U+xBZhJmD2kGzzpSAD6QZ4QySsJRn
	sZOv+tTu1jvoXCb58LZjBEfG3tMEagPE9M9N3GsgoH+S6fsBKo+/mqrZnqQQfSzYsT5LPc756xB
	NQ0l1Y2ZrhaFjP22nBXUw==
X-Received: by 2002:a05:6a00:22c5:b0:829:8942:2c9c with SMTP id d2e1a72fcca58-829894231e7mr3145654b3a.57.1772734861215;
        Thu, 05 Mar 2026 10:21:01 -0800 (PST)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8297faf677bsm3340983b3a.60.2026.03.05.10.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:21:00 -0800 (PST)
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
Subject: [PATCH v3] net: add xmit recursion limit to tunnel xmit functions
Date: Fri,  6 Mar 2026 02:18:49 +0800
Message-ID: <20260305181847.3970452-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 99ADA216EFB
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-264512-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org]
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


