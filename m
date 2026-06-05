Return-Path: <netdev+bounces-295679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OCZ/Fit7ImrJYAEAu9opvQ
	(envelope-from <netdev+bounces-295679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:30:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AB9645FDF
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:30:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=F6OsP8ML;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295679-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295679-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3AD8308DF05
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA84B47AF6D;
	Fri,  5 Jun 2026 07:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12347884E
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:20:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644021; cv=none; b=N5xwCvwgwQ5HJrNhqEJfpEdNOrX1HjOmHUM3Ktt/E4WPiK7z/C4TnGUroqeL+01exS9/SRJV0MBe5TWp1uNTA3k3UTX41pE2/FMtllU2XACyn5Df2jm/wLNXFb5UWfAwLCq+RV6Um6gvpXSQQqsLOslJEDFzAF+Ww/Oxq+wbLnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644021; c=relaxed/simple;
	bh=wCGkQ3HJaNK2wyQwmBpQ5PtCSKF8F54dU7bAw6oz8qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C68vR7vYuySw1gaJLJJXtfDQaFsPMgG0ri44EK/ZTsj2riEj2jJeqhYrDmh/Qy3O6rz5WfgO4tMkJN1/enLuXm5TqhB1XGHS37aJBv+jzOS20dQ+UVkRbRG9celqliOcod0CUustsl6e2KVPurNV7HMlwZBz4GslFr9e3lSHpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=F6OsP8ML; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XayUOr0ee7YPv+5l8yPXIocEHJrmBbPJHkDKJCahM0w=;
	b=F6OsP8ML4T0t0AuyENeYKkY0QWxRdUEm6tshcPh/drduvkPek/+JyGlWxz5P9wot2zobei
	8xLnfMcj3SLLckicq4d70F0x1xuV6I13hVg5crTmf3IPxpKw/sFfW3kGKZZw5EkJ8aOxv0
	FbLANQPUa8MKxxedwyiuVlYcnB/FvGCbwnYit6FHk6oBiQvgN7/+CXu7bb3OVfD8S65L1O
	TG9XwDpqyPjpVXjnZ7hAtpAqOPs4XWMf2dC85M5bhU6KJ9JUAvR1wwZDxEsZAvia8t4EVx
	HsN7IqbAbR9DDoCRn7L8YY2GTCCqoPpmWQD4V0oB4S2S/h5d56cZ8dAL/yKDvA==
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
Subject: [PATCH net-next 02/11] batman-adv: convert cancellation of work items to disable helper
Date: Fri,  5 Jun 2026 09:19:56 +0200
Message-ID: <20260605072005.490368-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295679-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,narfation.org:email,simonwunderlich.de:mid,simonwunderlich.de:dkim,simonwunderlich.de:from_mime,simonwunderlich.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3AB9645FDF

From: Sven Eckelmann <sven@narfation.org>

With commit 86898fa6b8cd ("workqueue: Implement disable/enable for
(delayed) work items"), work queues gained the ability to permanently
disallow re-queuing of work items. This is particularly important during
object teardown, where a work item must not be re-armed after shutdown
begins.

Convert all cancel_work_sync() and cancel_delayed_work_sync() call sites to
their disable_* equivalents to clarify the intent to prevent re-arming
after teardown.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c            | 2 +-
 net/batman-adv/bat_v.c                 | 2 ++
 net/batman-adv/bat_v_elp.c             | 6 +++---
 net/batman-adv/bat_v_ogm.c             | 6 ++++--
 net/batman-adv/bridge_loop_avoidance.c | 4 ++--
 net/batman-adv/distributed-arp-table.c | 2 +-
 net/batman-adv/multicast.c             | 2 +-
 net/batman-adv/originator.c            | 2 +-
 net/batman-adv/send.c                  | 2 +-
 net/batman-adv/tp_meter.c              | 2 +-
 net/batman-adv/translation-table.c     | 2 +-
 11 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 6f5a468c4084c..7588e64e7ba6f 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -230,7 +230,7 @@ static void batadv_iv_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 
 	mutex_unlock(&hard_iface->bat_iv.ogm_buff_mutex);
 
-	cancel_delayed_work_sync(&hard_iface->bat_iv.reschedule_work);
+	disable_delayed_work_sync(&hard_iface->bat_iv.reschedule_work);
 }
 
 static void batadv_iv_ogm_iface_update_mac(struct batadv_hard_iface *hard_iface)
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index ac2932da5472d..cb081038d14f5 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -819,6 +819,8 @@ void batadv_v_hardif_init(struct batadv_hard_iface *hard_iface)
 	skb_queue_head_init(&hard_iface->bat_v.aggr_list);
 	INIT_DELAYED_WORK(&hard_iface->bat_v.aggr_wq,
 			  batadv_v_ogm_aggr_work);
+	/* make sure it doesn't run until interface gets enabled */
+	disable_delayed_work(&hard_iface->bat_v.aggr_wq);
 }
 
 /**
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index d53485d17220e..4841f0f1a9b13 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -115,7 +115,7 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 			goto default_throughput;
 
 		/* only use rtnl_trylock because the elp worker will be cancelled while
-		 * the rntl_lock is held. the cancel_delayed_work_sync() would otherwise
+		 * the rntl_lock is held. the disable_delayed_work_sync() would otherwise
 		 * wait forever when the elp work_item was started and it is then also
 		 * trying to rtnl_lock
 		 */
@@ -162,7 +162,7 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 	}
 
 	/* only use rtnl_trylock because the elp worker will be cancelled while
-	 * the rntl_lock is held. the cancel_delayed_work_sync() would otherwise
+	 * the rntl_lock is held. the disable_delayed_work_sync() would otherwise
 	 * wait forever when the elp work_item was started and it is then also
 	 * trying to rtnl_lock
 	 */
@@ -447,7 +447,7 @@ int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
  */
 void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface)
 {
-	cancel_delayed_work_sync(&hard_iface->bat_v.elp_wq);
+	disable_delayed_work_sync(&hard_iface->bat_v.elp_wq);
 
 	dev_kfree_skb(hard_iface->bat_v.elp_skb);
 	hard_iface->bat_v.elp_skb = NULL;
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 5936d0048be01..72ae8ffc9db65 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -415,6 +415,8 @@ int batadv_v_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 
+	enable_delayed_work(&hard_iface->bat_v.aggr_wq);
+
 	batadv_v_ogm_start_queue_timer(hard_iface);
 	batadv_v_ogm_start_timer(bat_priv);
 
@@ -427,7 +429,7 @@ int batadv_v_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
  */
 void batadv_v_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 {
-	cancel_delayed_work_sync(&hard_iface->bat_v.aggr_wq);
+	disable_delayed_work_sync(&hard_iface->bat_v.aggr_wq);
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
 	batadv_v_ogm_aggr_list_free(hard_iface);
@@ -1080,7 +1082,7 @@ int batadv_v_ogm_init(struct batadv_priv *bat_priv)
  */
 void batadv_v_ogm_free(struct batadv_priv *bat_priv)
 {
-	cancel_delayed_work_sync(&bat_priv->bat_v.ogm_wq);
+	disable_delayed_work_sync(&bat_priv->bat_v.ogm_wq);
 
 	mutex_lock(&bat_priv->bat_v.ogm_buff_mutex);
 
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 0461f11227d06..0bd24a19ff202 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1282,7 +1282,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 
 			if (purged) {
 				/* reference for pending report_work */
-				if (cancel_work_sync(&backbone_gw->report_work))
+				if (disable_work_sync(&backbone_gw->report_work))
 					batadv_backbone_gw_put(backbone_gw);
 
 				/* reference for hash_entry */
@@ -1850,7 +1850,7 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_hard_iface *primary_if;
 
-	cancel_delayed_work_sync(&bat_priv->bla.work);
+	disable_delayed_work_sync(&bat_priv->bla.work);
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 
 	if (bat_priv->bla.claim_hash) {
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 0b02018c5b850..aaea155b94038 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -838,7 +838,7 @@ void batadv_dat_free(struct batadv_priv *bat_priv)
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_DAT, 1);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_DAT, 1);
 
-	cancel_delayed_work_sync(&bat_priv->dat.work);
+	disable_delayed_work_sync(&bat_priv->dat.work);
 
 	batadv_dat_hash_free(bat_priv);
 }
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 3274e2ac4f4a7..1c5315e55c046 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -2161,7 +2161,7 @@ int batadv_mcast_flags_dump(struct sk_buff *msg, struct netlink_callback *cb)
  */
 void batadv_mcast_free(struct batadv_priv *bat_priv)
 {
-	cancel_delayed_work_sync(&bat_priv->mcast.work);
+	disable_delayed_work_sync(&bat_priv->mcast.work);
 
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST_TRACKER, 1);
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 15d660ca79376..b161232c10885 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -908,7 +908,7 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 	if (!hash)
 		return;
 
-	cancel_delayed_work_sync(&bat_priv->orig_work);
+	disable_delayed_work_sync(&bat_priv->orig_work);
 
 	bat_priv->orig_hash = NULL;
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 5f9da3606a8f5..7f449338a4909 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -629,7 +629,7 @@ static void batadv_forw_packet_list_free(struct hlist_head *head)
 
 	hlist_for_each_entry_safe(forw_packet, safe_tmp_node, head,
 				  cleanup_list) {
-		cancel_delayed_work_sync(&forw_packet->delayed_work);
+		disable_delayed_work_sync(&forw_packet->delayed_work);
 
 		hlist_del(&forw_packet->cleanup_list);
 		batadv_forw_packet_free(forw_packet, true);
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index cc72468ca2abe..a404d70e053e2 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -421,7 +421,7 @@ static bool batadv_tp_list_detach(struct batadv_tp_vars_common *tp_vars)
  */
 static void batadv_tp_sender_cleanup(struct batadv_tp_sender *tp_vars)
 {
-	cancel_delayed_work_sync(&tp_vars->finish_work);
+	disable_delayed_work_sync(&tp_vars->finish_work);
 
 	if (batadv_tp_list_detach(&tp_vars->common))
 		batadv_tp_sender_put(tp_vars);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index c346e43d47b9b..8b6c49c32c892 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3574,7 +3574,7 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_TT, 1);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_TT, 1);
 
-	cancel_delayed_work_sync(&bat_priv->tt.work);
+	disable_delayed_work_sync(&bat_priv->tt.work);
 
 	batadv_tt_local_table_free(bat_priv);
 	batadv_tt_global_table_free(bat_priv);
-- 
2.47.3


