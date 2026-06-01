Return-Path: <netdev+bounces-293749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eILVAlx9HWrEbAkAu9opvQ
	(envelope-from <netdev+bounces-293749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:38:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE19F61F629
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E53CC301E557
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D393A3E78;
	Mon,  1 Jun 2026 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="sS2NOZJK"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD9337F731
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317418; cv=none; b=irXo5AlufuULZgs+BW528ZEt5C6TfH4/C8LQbvIJYyRLM+Mv7xn2qWMWNoHJ6jv2uYIyZ3rcdVH14RtCv+qAUsErhrDlrYbNAkCfdtIdIIXF5cWX9ZMBLOLtiMHmXAu+LOnasyXyIs2HngbgpflKjQZ+PSQFosVbiMl1+y2tepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317418; c=relaxed/simple;
	bh=W3rwvBbFodYZhJd6tvubvoqZ19EFRz8W9B+ZH5+24k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWNGJkp3Bvuy9Op8Eg78Bh6GU1gRPPbSNXuUyGFky4i8thh0uOPN7r29wWdOZfN3NBaSXLFCoboRTuP5dnuqayIQCrxqK6EL50Sa4hXqB5VyDcMf/AH+QZ5PGIsLbb3lCsTbC2Q7VGky7woiHIR47oywPimFii8UNpxuwnYPNLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=sS2NOZJK; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gG3Q4GWiuel3jX+pRu2M4I/xsuWgwKoGKy32bhznjmA=;
	b=sS2NOZJK4rORUEsjJlKTc1F/krtDf8zawSiUL36KYaNECCXQ63W7DboqDDbeFuXKttm9VW
	1cSrWwVyUtsZrEMJaGQ1WjEdJwxf7LC4H4fbGJaWx0Sbb66FGmggg4eAeGIS68k/MbNSw2
	/UlhGltHXHmDsf0ZMLf4eqKM/bPdo44R2Ql7K8CNAPb4RuYhEmEGK3wWlewWL5MfED1BwQ
	J8uUswknpl0vbxK0p/74xXvXoXrPR206GrxJjExk9UA6a5StFySOEFVkomxMvhcb/ueie0
	IYKyWr4in+uSzOybuDRe1kpT/36bo+bt2sRhcU2IFzhIkH/APS8/jI/QoxqT1A==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 07/15] batman-adv: replace non-atomic meshif config fields with (READ|WRITE)_ONCE
Date: Mon,  1 Jun 2026 14:36:21 +0200
Message-ID: <20260601123629.707089-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601123629.707089-1-sw@simonwunderlich.de>
References: <20260601123629.707089-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293749-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,narfation.org:email]
X-Rspamd-Queue-Id: AE19F61F629
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sven Eckelmann <sven@narfation.org>

The meshif configuration values are only accessed as plain loads/stores and
do not require full atomic_t semantics. Convert these fields to native
integer types and replace their users with READ_ONCE()/WRITE_ONCE() to
avoid load/store tearing.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c            | 26 +++++++-----
 net/batman-adv/bat_v.c                 |  5 ++-
 net/batman-adv/bat_v_ogm.c             |  7 ++--
 net/batman-adv/bridge_loop_avoidance.c | 14 +++----
 net/batman-adv/distributed-arp-table.c | 16 ++++----
 net/batman-adv/gateway_client.c        |  6 +--
 net/batman-adv/gateway_common.c        | 14 +++----
 net/batman-adv/hard-interface.c        | 10 ++---
 net/batman-adv/log.h                   |  2 +-
 net/batman-adv/mesh-interface.c        | 28 ++++++-------
 net/batman-adv/multicast.c             |  4 +-
 net/batman-adv/netlink.c               | 57 +++++++++++++-------------
 net/batman-adv/originator.c            |  1 -
 net/batman-adv/routing.c               |  2 +-
 net/batman-adv/send.c                  |  2 +-
 net/batman-adv/types.h                 | 54 ++++++++++++------------
 16 files changed, 127 insertions(+), 121 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index b8b1b997960a9..5628017bee511 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -13,6 +13,7 @@
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
+#include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -274,7 +275,7 @@ batadv_iv_ogm_emit_send_time(const struct batadv_priv *bat_priv)
 {
 	unsigned int msecs;
 
-	msecs = atomic_read(&bat_priv->orig_interval) - BATADV_JITTER;
+	msecs = READ_ONCE(bat_priv->orig_interval) - BATADV_JITTER;
 	msecs += get_random_u32_below(2 * BATADV_JITTER);
 
 	return jiffies + msecs_to_jiffies(msecs);
@@ -289,7 +290,7 @@ static unsigned long batadv_iv_ogm_fwd_send_time(void)
 /* apply hop penalty for a normal link */
 static u8 batadv_hop_penalty(u8 tq, const struct batadv_priv *bat_priv)
 {
-	int hop_penalty = atomic_read(&bat_priv->hop_penalty);
+	int hop_penalty = READ_ONCE(bat_priv->hop_penalty);
 	int new_tq;
 
 	new_tq = tq * (BATADV_TQ_MAX_VALUE - hop_penalty);
@@ -555,7 +556,7 @@ static bool batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	unsigned int skb_size;
 	atomic_t *queue_left = own_packet ? NULL : &bat_priv->batman_queue_left;
 
-	if (atomic_read(&bat_priv->aggregated_ogms))
+	if (READ_ONCE(bat_priv->aggregated_ogms))
 		skb_size = max_t(unsigned int, BATADV_MAX_AGGREGATION_BYTES,
 				 packet_len);
 	else
@@ -641,6 +642,7 @@ static bool batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	bool direct_link;
 	unsigned long max_aggregation_jiffies;
+	bool aggregated_ogms;
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)packet_buff;
 	direct_link = !!(batadv_ogm_packet->flags & BATADV_DIRECTLINK);
@@ -648,8 +650,10 @@ static bool batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 
 	/* find position for the packet in the forward queue */
 	spin_lock_bh(&bat_priv->forw_bat_list_lock);
+	aggregated_ogms = READ_ONCE(bat_priv->aggregated_ogms);
+
 	/* own packets are not to be aggregated */
-	if (atomic_read(&bat_priv->aggregated_ogms) && !own_packet) {
+	if (aggregated_ogms && !own_packet) {
 		hlist_for_each_entry(forw_packet_pos,
 				     &bat_priv->forw_bat_list, list) {
 			if (batadv_iv_ogm_can_aggregate(batadv_ogm_packet,
@@ -675,7 +679,7 @@ static bool batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 		 * we hold it back for a while, so that it might be aggregated
 		 * later on
 		 */
-		if (!own_packet && atomic_read(&bat_priv->aggregated_ogms))
+		if (!own_packet && aggregated_ogms)
 			send_time += max_aggregation_jiffies;
 
 		return batadv_iv_ogm_aggregate_new(packet_buff, packet_len,
@@ -888,7 +892,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		 */
 		queue_delayed_work(batadv_event_workqueue,
 				   &hard_iface->bat_iv.reschedule_work,
-				   msecs_to_jiffies(atomic_read(&bat_priv->orig_interval)));
+				   msecs_to_jiffies(READ_ONCE(bat_priv->orig_interval)));
 	}
 
 	batadv_hardif_put(primary_if);
@@ -2321,7 +2325,7 @@ static void batadv_iv_iface_enabled(struct batadv_hard_iface *hard_iface)
 static void batadv_iv_init_sel_class(struct batadv_priv *bat_priv)
 {
 	/* set default TQ difference threshold to 20 */
-	atomic_set(&bat_priv->gw.sel_class, 20);
+	WRITE_ONCE(bat_priv->gw.sel_class, 20);
 }
 
 static struct batadv_gw_node *
@@ -2353,7 +2357,7 @@ batadv_iv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 
 		tq_avg = router_ifinfo->bat_iv.tq_avg;
 
-		switch (atomic_read(&bat_priv->gw.sel_class)) {
+		switch (READ_ONCE(bat_priv->gw.sel_class)) {
 		case 1: /* fast connection */
 			tmp_gw_factor = tq_avg * tq_avg;
 			tmp_gw_factor *= gw_node->bandwidth_down;
@@ -2407,13 +2411,14 @@ static bool batadv_iv_gw_is_eligible(struct batadv_priv *bat_priv,
 {
 	struct batadv_neigh_ifinfo *router_orig_ifinfo = NULL;
 	struct batadv_neigh_ifinfo *router_gw_ifinfo = NULL;
+	u32 sel_class = READ_ONCE(bat_priv->gw.sel_class);
 	struct batadv_neigh_node *router_gw = NULL;
 	struct batadv_neigh_node *router_orig = NULL;
 	u8 gw_tq_avg, orig_tq_avg;
 	bool ret = false;
 
 	/* dynamic re-election is performed only on fast or late switch */
-	if (atomic_read(&bat_priv->gw.sel_class) <= 2)
+	if (sel_class <= 2)
 		return false;
 
 	router_gw = batadv_orig_router_get(curr_gw_orig, BATADV_IF_DEFAULT);
@@ -2448,8 +2453,7 @@ static bool batadv_iv_gw_is_eligible(struct batadv_priv *bat_priv,
 	/* if the routing class is greater than 3 the value tells us how much
 	 * greater the TQ value of the new gateway must be
 	 */
-	if ((atomic_read(&bat_priv->gw.sel_class) > 3) &&
-	    (orig_tq_avg - gw_tq_avg < atomic_read(&bat_priv->gw.sel_class)))
+	if (sel_class > 3 && orig_tq_avg - gw_tq_avg < sel_class)
 		goto out;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index de94447142642..492058a87682b 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -9,6 +9,7 @@
 
 #include <linux/atomic.h>
 #include <linux/cache.h>
+#include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/if_ether.h>
 #include <linux/init.h>
@@ -505,7 +506,7 @@ static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 static void batadv_v_init_sel_class(struct batadv_priv *bat_priv)
 {
 	/* set default throughput difference threshold to 5Mbps */
-	atomic_set(&bat_priv->gw.sel_class, 50);
+	WRITE_ONCE(bat_priv->gw.sel_class, 50);
 }
 
 /**
@@ -602,7 +603,7 @@ static bool batadv_v_gw_is_eligible(struct batadv_priv *bat_priv,
 	u32 gw_throughput, orig_throughput, threshold;
 	bool ret = false;
 
-	threshold = atomic_read(&bat_priv->gw.sel_class);
+	threshold = READ_ONCE(bat_priv->gw.sel_class);
 
 	curr_gw = batadv_gw_node_get(bat_priv, curr_gw_orig);
 	if (!curr_gw) {
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 6436e9bc079b6..28f28b61ad6bc 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -10,6 +10,7 @@
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
+#include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -106,7 +107,7 @@ static void batadv_v_ogm_start_timer(struct batadv_priv *bat_priv)
 	if (delayed_work_pending(&bat_priv->bat_v.ogm_wq))
 		return;
 
-	msecs = atomic_read(&bat_priv->orig_interval) - BATADV_JITTER;
+	msecs = READ_ONCE(bat_priv->orig_interval) - BATADV_JITTER;
 	msecs += get_random_u32_below(2 * BATADV_JITTER);
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->bat_v.ogm_wq,
 			   msecs_to_jiffies(msecs));
@@ -247,7 +248,7 @@ static void batadv_v_ogm_queue_on_if(struct batadv_priv *bat_priv,
 		return;
 	}
 
-	if (!atomic_read(&bat_priv->aggregated_ogms)) {
+	if (!READ_ONCE(bat_priv->aggregated_ogms)) {
 		batadv_v_ogm_send_to_if(bat_priv, skb, hard_iface);
 		return;
 	}
@@ -486,7 +487,7 @@ static u32 batadv_v_forward_penalty(struct batadv_priv *bat_priv,
 				    u32 throughput)
 {
 	int if_hop_penalty = atomic_read(&if_incoming->hop_penalty);
-	int hop_penalty = atomic_read(&bat_priv->hop_penalty);
+	int hop_penalty = READ_ONCE(bat_priv->hop_penalty);
 	int hop_penalty_max = BATADV_TQ_MAX_VALUE;
 
 	/* Apply per hardif hop penalty */
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index f6ca69252ff7c..87d6b11161e4a 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1380,7 +1380,7 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 	bat_priv->bla.claim_dest.group = group;
 
 	/* purge everything when bridge loop avoidance is turned off */
-	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
+	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
 		oldif = NULL;
 
 	if (!oldif) {
@@ -1484,7 +1484,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 	batadv_bla_purge_claims(bat_priv, primary_if, 0);
 	batadv_bla_purge_backbone_gw(bat_priv, 0);
 
-	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
+	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
 		goto out;
 
 	if (atomic_dec_and_test(&bat_priv->bla.loopdetect_next)) {
@@ -1783,7 +1783,7 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
 	struct batadv_bla_backbone_gw *backbone_gw;
 	int i;
 
-	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
+	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
 		return false;
 
 	if (!hash)
@@ -1821,7 +1821,7 @@ bool batadv_bla_is_backbone_gw(struct sk_buff *skb,
 	struct batadv_bla_backbone_gw *backbone_gw;
 	unsigned short vid;
 
-	if (!atomic_read(&orig_node->bat_priv->bridge_loop_avoidance))
+	if (!READ_ONCE(orig_node->bat_priv->bridge_loop_avoidance))
 		return false;
 
 	/* first, find out the vid. */
@@ -1953,7 +1953,7 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	if (!primary_if)
 		goto handled;
 
-	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
+	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
 		goto allow;
 
 	if (batadv_bla_loopdetect_check(bat_priv, skb, primary_if, vid))
@@ -2085,7 +2085,7 @@ bool batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	if (!primary_if)
 		goto out;
 
-	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
+	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
 		goto allow;
 
 	if (batadv_bla_process_claim(bat_priv, primary_if, skb))
@@ -2505,7 +2505,7 @@ bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
 	struct batadv_hard_iface *primary_if = NULL;
 	bool ret = true;
 
-	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
+	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
 		return ret;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index c6084ae6760c5..0b02018c5b850 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -743,7 +743,7 @@ static void batadv_dat_tvlv_container_update(struct batadv_priv *bat_priv)
 {
 	char dat_mode;
 
-	dat_mode = atomic_read(&bat_priv->distributed_arp_table);
+	dat_mode = READ_ONCE(bat_priv->distributed_arp_table);
 
 	switch (dat_mode) {
 	case 0:
@@ -1139,7 +1139,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	int hdr_size = 0;
 	unsigned short vid;
 
-	if (!atomic_read(&bat_priv->distributed_arp_table))
+	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
 
 	vid = batadv_dat_get_vid(skb, &hdr_size);
@@ -1234,7 +1234,7 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	unsigned short vid;
 	int err;
 
-	if (!atomic_read(&bat_priv->distributed_arp_table))
+	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
 
 	vid = batadv_dat_get_vid(skb, &hdr_size);
@@ -1296,7 +1296,7 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	int hdr_size = 0;
 	unsigned short vid;
 
-	if (!atomic_read(&bat_priv->distributed_arp_table))
+	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		return;
 
 	vid = batadv_dat_get_vid(skb, &hdr_size);
@@ -1344,7 +1344,7 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	bool dropped = false;
 	unsigned short vid;
 
-	if (!atomic_read(&bat_priv->distributed_arp_table))
+	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
 
 	vid = batadv_dat_get_vid(skb, &hdr_size);
@@ -1714,7 +1714,7 @@ void batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
 	u8 chaddr[BATADV_DHCP_CHADDR_LEN];
 	__be32 ip_src, yiaddr;
 
-	if (!atomic_read(&bat_priv->distributed_arp_table))
+	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		return;
 
 	if (!batadv_dat_check_dhcp_ack(skb, proto, &ip_src, chaddr, &yiaddr))
@@ -1744,7 +1744,7 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 	__be16 proto;
 	u8 *hw_src;
 
-	if (!atomic_read(&bat_priv->distributed_arp_table))
+	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		return;
 
 	if (unlikely(!pskb_may_pull(skb, hdr_size + ETH_HLEN)))
@@ -1789,7 +1789,7 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 	int hdr_size = sizeof(struct batadv_bcast_packet);
 	unsigned short vid;
 
-	if (!atomic_read(&bat_priv->distributed_arp_table))
+	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
 
 	/* If this packet is an ARP_REQUEST and the node already has the
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 026627c8ba45b..305488a74a256 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -171,7 +171,7 @@ void batadv_gw_check_client_stop(struct batadv_priv *bat_priv)
 {
 	struct batadv_gw_node *curr_gw;
 
-	if (atomic_read(&bat_priv->gw.mode) != BATADV_GW_MODE_CLIENT)
+	if (READ_ONCE(bat_priv->gw.mode) != BATADV_GW_MODE_CLIENT)
 		return;
 
 	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
@@ -203,7 +203,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
 	char gw_addr[18] = { '\0' };
 
-	if (atomic_read(&bat_priv->gw.mode) != BATADV_GW_MODE_CLIENT)
+	if (READ_ONCE(bat_priv->gw.mode) != BATADV_GW_MODE_CLIENT)
 		goto out;
 
 	if (!bat_priv->algo_ops->gw.get_best_gw_node)
@@ -703,7 +703,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 	if (!gw_node)
 		goto out;
 
-	switch (atomic_read(&bat_priv->gw.mode)) {
+	switch (READ_ONCE(bat_priv->gw.mode)) {
 	case BATADV_GW_MODE_SERVER:
 		/* If we are a GW then we are our best GW. We can artificially
 		 * set the tq towards ourself as the maximum value
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 315fa90f0c947..675ebf098d4ec 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -7,8 +7,8 @@
 #include "gateway_common.h"
 #include "main.h"
 
-#include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
+#include <linux/compiler.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <uapi/linux/batadv_packet.h>
@@ -25,10 +25,10 @@
 void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv)
 {
 	struct batadv_tvlv_gateway_data gw;
+	enum batadv_gw_modes gw_mode;
 	u32 down, up;
-	char gw_mode;
 
-	gw_mode = atomic_read(&bat_priv->gw.mode);
+	gw_mode = READ_ONCE(bat_priv->gw.mode);
 
 	switch (gw_mode) {
 	case BATADV_GW_MODE_OFF:
@@ -36,8 +36,8 @@ void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv)
 		batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_GW, 1);
 		break;
 	case BATADV_GW_MODE_SERVER:
-		down = atomic_read(&bat_priv->gw.bandwidth_down);
-		up = atomic_read(&bat_priv->gw.bandwidth_up);
+		down = READ_ONCE(bat_priv->gw.bandwidth_down);
+		up = READ_ONCE(bat_priv->gw.bandwidth_up);
 		gw.bandwidth_down = htonl(down);
 		gw.bandwidth_up = htonl(up);
 		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_GW, 1,
@@ -83,7 +83,7 @@ static void batadv_gw_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 
 	/* restart gateway selection */
 	if (gateway.bandwidth_down != 0 &&
-	    atomic_read(&bat_priv->gw.mode) == BATADV_GW_MODE_CLIENT)
+	    READ_ONCE(bat_priv->gw.mode) == BATADV_GW_MODE_CLIENT)
 		batadv_gw_check_election(bat_priv, orig);
 }
 
@@ -96,7 +96,7 @@ void batadv_gw_init(struct batadv_priv *bat_priv)
 	if (bat_priv->algo_ops->gw.init_sel_class)
 		bat_priv->algo_ops->gw.init_sel_class(bat_priv);
 	else
-		atomic_set(&bat_priv->gw.sel_class, 1);
+		WRITE_ONCE(bat_priv->gw.sel_class, 1);
 
 	batadv_tvlv_handler_register(bat_priv, batadv_gw_tvlv_ogm_handler_v1,
 				     NULL, NULL, BATADV_TVLV_GW, 1,
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 647fda1898e55..e89aa4b61a7cd 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -612,7 +612,7 @@ int batadv_hardif_min_mtu(struct net_device *mesh_iface)
 	}
 	rcu_read_unlock();
 
-	if (atomic_read(&bat_priv->fragmentation) == 0)
+	if (READ_ONCE(bat_priv->fragmentation) == 0)
 		goto out;
 
 	/* with fragmentation enabled the maximum size of internally generated
@@ -727,6 +727,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	int max_header_len = batadv_max_header_len();
 	unsigned int required_mtu;
 	unsigned int hardif_mtu;
+	bool fragmentation;
 	int ret;
 
 	hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
@@ -764,15 +765,14 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	batadv_info(hard_iface->mesh_iface, "Adding interface: %s\n",
 		    hard_iface->net_dev->name);
 
-	if (atomic_read(&bat_priv->fragmentation) &&
-	    hardif_mtu < required_mtu)
+	fragmentation = READ_ONCE(bat_priv->fragmentation);
+	if (fragmentation && hardif_mtu < required_mtu)
 		batadv_info(hard_iface->mesh_iface,
 			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to %i would solve the problem.\n",
 			    hard_iface->net_dev->name, hardif_mtu,
 			    required_mtu);
 
-	if (!atomic_read(&bat_priv->fragmentation) &&
-	    hardif_mtu < required_mtu)
+	if (!fragmentation && hardif_mtu < required_mtu)
 		batadv_info(hard_iface->mesh_iface,
 			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. If you experience problems getting traffic through try increasing the MTU to %i.\n",
 			    hard_iface->net_dev->name, hardif_mtu,
diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 225b747a2048e..a0d2b0d64b2b0 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -76,7 +76,7 @@ __printf(2, 3);
 #define _batadv_dbg(type, bat_priv, ratelimited, fmt, arg...)		\
 	do {								\
 		struct batadv_priv *__batpriv = (bat_priv);		\
-		if (atomic_read(&__batpriv->log_level) & (type) &&	\
+		if (READ_ONCE(__batpriv->log_level) & (type) &&	\
 		    (!(ratelimited) || net_ratelimit()))		\
 			batadv_debug_log(__batpriv, fmt, ## arg);	\
 	}								\
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index d6f40ae3c815a..071cbf1c1d317 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -257,7 +257,7 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (batadv_compare_eth(ethhdr->h_dest, ectp_addr))
 		goto dropped;
 
-	gw_mode = atomic_read(&bat_priv->gw.mode);
+	gw_mode = READ_ONCE(bat_priv->gw.mode);
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		/* if gw mode is off, broadcast every packet */
 		if (gw_mode == BATADV_GW_MODE_OFF) {
@@ -754,31 +754,31 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	if (!bat_priv->bat_counters)
 		return -ENOMEM;
 
-	atomic_set(&bat_priv->aggregated_ogms, 1);
-	atomic_set(&bat_priv->bonding, 0);
+	WRITE_ONCE(bat_priv->aggregated_ogms, 1);
+	WRITE_ONCE(bat_priv->bonding, 0);
 #ifdef CONFIG_BATMAN_ADV_BLA
-	atomic_set(&bat_priv->bridge_loop_avoidance, 1);
+	WRITE_ONCE(bat_priv->bridge_loop_avoidance, 1);
 #endif
 #ifdef CONFIG_BATMAN_ADV_DAT
-	atomic_set(&bat_priv->distributed_arp_table, 1);
+	WRITE_ONCE(bat_priv->distributed_arp_table, 1);
 #endif
 #ifdef CONFIG_BATMAN_ADV_MCAST
-	atomic_set(&bat_priv->multicast_mode, 1);
-	atomic_set(&bat_priv->multicast_fanout, 16);
+	WRITE_ONCE(bat_priv->multicast_mode, 1);
+	WRITE_ONCE(bat_priv->multicast_fanout, 16);
 	atomic_set(&bat_priv->mcast.num_want_all_unsnoopables, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv4, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv6, 0);
 	atomic_set(&bat_priv->mcast.num_no_mc_ptype_capa, 0);
 #endif
-	atomic_set(&bat_priv->gw.mode, BATADV_GW_MODE_OFF);
-	atomic_set(&bat_priv->gw.bandwidth_down, 100);
-	atomic_set(&bat_priv->gw.bandwidth_up, 20);
-	atomic_set(&bat_priv->orig_interval, 1000);
-	atomic_set(&bat_priv->hop_penalty, 30);
+	WRITE_ONCE(bat_priv->gw.mode, BATADV_GW_MODE_OFF);
+	WRITE_ONCE(bat_priv->gw.bandwidth_down, 100);
+	WRITE_ONCE(bat_priv->gw.bandwidth_up, 20);
+	WRITE_ONCE(bat_priv->orig_interval, 1000);
+	WRITE_ONCE(bat_priv->hop_penalty, 30);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-	atomic_set(&bat_priv->log_level, 0);
+	WRITE_ONCE(bat_priv->log_level, 0);
 #endif
-	atomic_set(&bat_priv->fragmentation, 1);
+	WRITE_ONCE(bat_priv->fragmentation, 1);
 	atomic_set(&bat_priv->packet_size_max, BATADV_MAX_MTU);
 	atomic_set(&bat_priv->bcast_queue_left, BATADV_BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATADV_BATMAN_QUEUE_LEN);
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index a3d3efe22d301..3274e2ac4f4a7 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1099,7 +1099,7 @@ static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 {
 	struct ethhdr *ethhdr = eth_hdr(skb);
 
-	if (!atomic_read(&bat_priv->multicast_mode))
+	if (!READ_ONCE(bat_priv->multicast_mode))
 		return -EINVAL;
 
 	switch (ntohs(ethhdr->h_proto)) {
@@ -1204,7 +1204,7 @@ batadv_mcast_forw_mode_by_count(struct batadv_priv *bat_priv,
 	    batadv_mcast_forw_push(bat_priv, skb, vid, is_routable, count))
 		return BATADV_FORW_MCAST;
 
-	if (count <= atomic_read(&bat_priv->multicast_fanout))
+	if (count <= READ_ONCE(bat_priv->multicast_fanout))
 		return BATADV_FORW_UCASTS;
 
 	return BATADV_FORW_BCAST;
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index b30f018740fcc..027e9fe1042a2 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -13,6 +13,7 @@
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
+#include <linux/compiler.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
@@ -268,7 +269,7 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 	}
 
 	if (nla_put_u8(msg, BATADV_ATTR_AGGREGATED_OGMS_ENABLED,
-		       !!atomic_read(&bat_priv->aggregated_ogms)))
+		       !!READ_ONCE(bat_priv->aggregated_ogms)))
 		goto nla_put_failure;
 
 	if (batadv_netlink_mesh_fill_ap_isolation(msg, bat_priv))
@@ -283,35 +284,35 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 		goto nla_put_failure;
 
 	if (nla_put_u8(msg, BATADV_ATTR_BONDING_ENABLED,
-		       !!atomic_read(&bat_priv->bonding)))
+		       !!READ_ONCE(bat_priv->bonding)))
 		goto nla_put_failure;
 
 #ifdef CONFIG_BATMAN_ADV_BLA
 	if (nla_put_u8(msg, BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED,
-		       !!atomic_read(&bat_priv->bridge_loop_avoidance)))
+		       !!READ_ONCE(bat_priv->bridge_loop_avoidance)))
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_BLA */
 
 #ifdef CONFIG_BATMAN_ADV_DAT
 	if (nla_put_u8(msg, BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED,
-		       !!atomic_read(&bat_priv->distributed_arp_table)))
+		       !!READ_ONCE(bat_priv->distributed_arp_table)))
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_DAT */
 
 	if (nla_put_u8(msg, BATADV_ATTR_FRAGMENTATION_ENABLED,
-		       !!atomic_read(&bat_priv->fragmentation)))
+		       !!READ_ONCE(bat_priv->fragmentation)))
 		goto nla_put_failure;
 
 	if (nla_put_u32(msg, BATADV_ATTR_GW_BANDWIDTH_DOWN,
-			atomic_read(&bat_priv->gw.bandwidth_down)))
+			READ_ONCE(bat_priv->gw.bandwidth_down)))
 		goto nla_put_failure;
 
 	if (nla_put_u32(msg, BATADV_ATTR_GW_BANDWIDTH_UP,
-			atomic_read(&bat_priv->gw.bandwidth_up)))
+			READ_ONCE(bat_priv->gw.bandwidth_up)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(msg, BATADV_ATTR_GW_MODE,
-		       atomic_read(&bat_priv->gw.mode)))
+		       READ_ONCE(bat_priv->gw.mode)))
 		goto nla_put_failure;
 
 	if (bat_priv->algo_ops->gw.get_best_gw_node &&
@@ -320,32 +321,32 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 		 * in use does not implement the GW API
 		 */
 		if (nla_put_u32(msg, BATADV_ATTR_GW_SEL_CLASS,
-				atomic_read(&bat_priv->gw.sel_class)))
+				READ_ONCE(bat_priv->gw.sel_class)))
 			goto nla_put_failure;
 	}
 
 	if (nla_put_u8(msg, BATADV_ATTR_HOP_PENALTY,
-		       atomic_read(&bat_priv->hop_penalty)))
+		       READ_ONCE(bat_priv->hop_penalty)))
 		goto nla_put_failure;
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	if (nla_put_u32(msg, BATADV_ATTR_LOG_LEVEL,
-			atomic_read(&bat_priv->log_level)))
+			READ_ONCE(bat_priv->log_level)))
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_DEBUG */
 
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	if (nla_put_u8(msg, BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED,
-		       !atomic_read(&bat_priv->multicast_mode)))
+		       !READ_ONCE(bat_priv->multicast_mode)))
 		goto nla_put_failure;
 
 	if (nla_put_u32(msg, BATADV_ATTR_MULTICAST_FANOUT,
-			atomic_read(&bat_priv->multicast_fanout)))
+			READ_ONCE(bat_priv->multicast_fanout)))
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_MCAST */
 
 	if (nla_put_u32(msg, BATADV_ATTR_ORIG_INTERVAL,
-			atomic_read(&bat_priv->orig_interval)))
+			READ_ONCE(bat_priv->orig_interval)))
 		goto nla_put_failure;
 
 	batadv_hardif_put(primary_if);
@@ -433,7 +434,7 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_AGGREGATED_OGMS_ENABLED]) {
 		attr = info->attrs[BATADV_ATTR_AGGREGATED_OGMS_ENABLED];
 
-		atomic_set(&bat_priv->aggregated_ogms, !!nla_get_u8(attr));
+		WRITE_ONCE(bat_priv->aggregated_ogms, !!nla_get_u8(attr));
 	}
 
 	if (info->attrs[BATADV_ATTR_AP_ISOLATION_ENABLED]) {
@@ -457,14 +458,14 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_BONDING_ENABLED]) {
 		attr = info->attrs[BATADV_ATTR_BONDING_ENABLED];
 
-		atomic_set(&bat_priv->bonding, !!nla_get_u8(attr));
+		WRITE_ONCE(bat_priv->bonding, !!nla_get_u8(attr));
 	}
 
 #ifdef CONFIG_BATMAN_ADV_BLA
 	if (info->attrs[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED]) {
 		attr = info->attrs[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED];
 
-		atomic_set(&bat_priv->bridge_loop_avoidance,
+		WRITE_ONCE(bat_priv->bridge_loop_avoidance,
 			   !!nla_get_u8(attr));
 		batadv_bla_status_update(bat_priv->mesh_iface);
 	}
@@ -474,7 +475,7 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED]) {
 		attr = info->attrs[BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED];
 
-		atomic_set(&bat_priv->distributed_arp_table,
+		WRITE_ONCE(bat_priv->distributed_arp_table,
 			   !!nla_get_u8(attr));
 		batadv_dat_status_update(bat_priv->mesh_iface);
 	}
@@ -483,7 +484,7 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_FRAGMENTATION_ENABLED]) {
 		attr = info->attrs[BATADV_ATTR_FRAGMENTATION_ENABLED];
 
-		atomic_set(&bat_priv->fragmentation, !!nla_get_u8(attr));
+		WRITE_ONCE(bat_priv->fragmentation, !!nla_get_u8(attr));
 
 		rtnl_lock();
 		batadv_update_min_mtu(bat_priv->mesh_iface);
@@ -493,14 +494,14 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_GW_BANDWIDTH_DOWN]) {
 		attr = info->attrs[BATADV_ATTR_GW_BANDWIDTH_DOWN];
 
-		atomic_set(&bat_priv->gw.bandwidth_down, nla_get_u32(attr));
+		WRITE_ONCE(bat_priv->gw.bandwidth_down, nla_get_u32(attr));
 		batadv_gw_tvlv_container_update(bat_priv);
 	}
 
 	if (info->attrs[BATADV_ATTR_GW_BANDWIDTH_UP]) {
 		attr = info->attrs[BATADV_ATTR_GW_BANDWIDTH_UP];
 
-		atomic_set(&bat_priv->gw.bandwidth_up, nla_get_u32(attr));
+		WRITE_ONCE(bat_priv->gw.bandwidth_up, nla_get_u32(attr));
 		batadv_gw_tvlv_container_update(bat_priv);
 	}
 
@@ -528,7 +529,7 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 			 * changing the gateway state
 			 */
 			batadv_gw_check_client_stop(bat_priv);
-			atomic_set(&bat_priv->gw.mode, gw_mode);
+			WRITE_ONCE(bat_priv->gw.mode, gw_mode);
 			batadv_gw_tvlv_container_update(bat_priv);
 		}
 	}
@@ -547,7 +548,7 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		sel_class = nla_get_u32(attr);
 
 		if (sel_class >= 1 && sel_class <= sel_class_max) {
-			atomic_set(&bat_priv->gw.sel_class, sel_class);
+			WRITE_ONCE(bat_priv->gw.sel_class, sel_class);
 			batadv_gw_reselect(bat_priv);
 		}
 	}
@@ -555,14 +556,14 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_HOP_PENALTY]) {
 		attr = info->attrs[BATADV_ATTR_HOP_PENALTY];
 
-		atomic_set(&bat_priv->hop_penalty, nla_get_u8(attr));
+		WRITE_ONCE(bat_priv->hop_penalty, nla_get_u8(attr));
 	}
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	if (info->attrs[BATADV_ATTR_LOG_LEVEL]) {
 		attr = info->attrs[BATADV_ATTR_LOG_LEVEL];
 
-		atomic_set(&bat_priv->log_level,
+		WRITE_ONCE(bat_priv->log_level,
 			   nla_get_u32(attr) & BATADV_DBG_ALL);
 	}
 #endif /* CONFIG_BATMAN_ADV_DEBUG */
@@ -571,13 +572,13 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED]) {
 		attr = info->attrs[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED];
 
-		atomic_set(&bat_priv->multicast_mode, !nla_get_u8(attr));
+		WRITE_ONCE(bat_priv->multicast_mode, !nla_get_u8(attr));
 	}
 
 	if (info->attrs[BATADV_ATTR_MULTICAST_FANOUT]) {
 		attr = info->attrs[BATADV_ATTR_MULTICAST_FANOUT];
 
-		atomic_set(&bat_priv->multicast_fanout, nla_get_u32(attr));
+		WRITE_ONCE(bat_priv->multicast_fanout, nla_get_u32(attr));
 	}
 #endif /* CONFIG_BATMAN_ADV_MCAST */
 
@@ -590,7 +591,7 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		orig_interval = min_t(u32, orig_interval, INT_MAX);
 		orig_interval = max_t(u32, orig_interval, 2 * BATADV_JITTER);
 
-		atomic_set(&bat_priv->orig_interval, orig_interval);
+		WRITE_ONCE(bat_priv->orig_interval, orig_interval);
 	}
 
 	batadv_netlink_notify_mesh(bat_priv);
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index ad4921b659d9d..0ce07bfdade59 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -7,7 +7,6 @@
 #include "originator.h"
 #include "main.h"
 
-#include <linux/atomic.h>
 #include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/errno.h>
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 12c16f81cc51d..1dd295d934f49 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -543,7 +543,7 @@ batadv_find_router(struct batadv_priv *bat_priv,
 	/* only consider bonding for recv_if == BATADV_IF_DEFAULT (first hop)
 	 * and if activated.
 	 */
-	if (!(recv_if == BATADV_IF_DEFAULT && atomic_read(&bat_priv->bonding)))
+	if (!(recv_if == BATADV_IF_DEFAULT && READ_ONCE(bat_priv->bonding)))
 		return router;
 
 	/* bonding: loop through the list of possible routers found
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 60cd67ec9cea1..62ae98eef81e2 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -185,7 +185,7 @@ int batadv_send_skb_to_orig(struct sk_buff *skb,
 	/* Check if the skb is too large to send in one piece and fragment
 	 * it if needed.
 	 */
-	if (atomic_read(&bat_priv->fragmentation) &&
+	if (READ_ONCE(bat_priv->fragmentation) &&
 	    skb->len > neigh_node->if_incoming->net_dev->mtu) {
 		/* Fragment and send packet. */
 		ret = batadv_frag_send_packet(skb, orig_node, neigh_node);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 16fe843577421..c4845b5e43be0 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1119,21 +1119,21 @@ struct batadv_priv_gw {
 	/**
 	 * @mode: gateway operation: off, client or server (see batadv_gw_modes)
 	 */
-	atomic_t mode;
+	enum batadv_gw_modes mode;
 
 	/** @sel_class: gateway selection class (applies if gw_mode client) */
-	atomic_t sel_class;
+	u32 sel_class;
 
 	/**
 	 * @bandwidth_down: advertised uplink download bandwidth (if gw_mode
 	 *  server)
 	 */
-	atomic_t bandwidth_down;
+	u32 bandwidth_down;
 
 	/**
 	 * @bandwidth_up: advertised uplink upload bandwidth (if gw_mode server)
 	 */
-	atomic_t bandwidth_up;
+	u32 bandwidth_up;
 
 	/** @reselect: bool indicating a gateway re-selection is in progress */
 	atomic_t reselect;
@@ -1524,36 +1524,23 @@ struct batadv_priv {
 	/**
 	 * @aggregated_ogms: bool indicating whether OGM aggregation is enabled
 	 */
-	atomic_t aggregated_ogms;
+	u8 aggregated_ogms;
 
 	/** @bonding: bool indicating whether traffic bonding is enabled */
-	atomic_t bonding;
+	u8 bonding;
 
 	/**
 	 * @fragmentation: bool indicating whether traffic fragmentation is
 	 *  enabled
 	 */
-	atomic_t fragmentation;
-
-	/**
-	 * @packet_size_max: max packet size that can be transmitted via
-	 *  multiple fragmented skbs or a single frame if fragmentation is
-	 *  disabled
-	 */
-	atomic_t packet_size_max;
-
-	/**
-	 * @frag_seqno: incremental counter to identify chains of egress
-	 *  fragments
-	 */
-	atomic_t frag_seqno;
+	u8 fragmentation;
 
 #ifdef CONFIG_BATMAN_ADV_BLA
 	/**
 	 * @bridge_loop_avoidance: bool indicating whether bridge loop
 	 *  avoidance is enabled
 	 */
-	atomic_t bridge_loop_avoidance;
+	u8 bridge_loop_avoidance;
 #endif
 
 #ifdef CONFIG_BATMAN_ADV_DAT
@@ -1561,7 +1548,7 @@ struct batadv_priv {
 	 * @distributed_arp_table: bool indicating whether distributed ARP table
 	 *  is enabled
 	 */
-	atomic_t distributed_arp_table;
+	u8 distributed_arp_table;
 #endif
 
 #ifdef CONFIG_BATMAN_ADV_MCAST
@@ -1569,27 +1556,40 @@ struct batadv_priv {
 	 * @multicast_mode: Enable or disable multicast optimizations on this
 	 *  node's sender/originating side
 	 */
-	atomic_t multicast_mode;
+	u8 multicast_mode;
 
 	/**
 	 * @multicast_fanout: Maximum number of packet copies to generate for a
 	 *  multicast-to-unicast conversion
 	 */
-	atomic_t multicast_fanout;
+	u32 multicast_fanout;
 #endif
 
+	/**
+	 * @packet_size_max: max packet size that can be transmitted via
+	 *  multiple fragmented skbs or a single frame if fragmentation is
+	 *  disabled
+	 */
+	atomic_t packet_size_max;
+
+	/**
+	 * @frag_seqno: incremental counter to identify chains of egress
+	 *  fragments
+	 */
+	atomic_t frag_seqno;
+
 	/** @orig_interval: OGM broadcast interval in milliseconds */
-	atomic_t orig_interval;
+	u32 orig_interval;
 
 	/**
 	 * @hop_penalty: penalty which will be applied to an OGM's tq-field on
 	 *  every hop
 	 */
-	atomic_t hop_penalty;
+	u8 hop_penalty;
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	/** @log_level: configured log level (see batadv_dbg_level) */
-	atomic_t log_level;
+	u32 log_level;
 #endif
 
 	/**
-- 
2.47.3


