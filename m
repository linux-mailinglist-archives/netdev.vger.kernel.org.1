Return-Path: <netdev+bounces-292715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCslF31UGGoQjQgAu9opvQ
	(envelope-from <netdev+bounces-292715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:43:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 542BF5F3DD5
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50A9B30B6188
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E253F1ABF;
	Thu, 28 May 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="AAYVy4nY"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F39D3E5575
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978580; cv=none; b=nWw2kEOvzxyklfGkM+8+6nMd9Nf9RCANT2O6UhyWWh4As/akSUq+5z55KxeAgpJwobgVEHCkPdG1wRudrOlBFDBQIdhZT0oE7USrBdoo2F0+/HbI+oW77XY3l81KJ4hioHTPtOdqZKsTG+CWhagVPOaIRKLLFCzHPyTrd3T/27M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978580; c=relaxed/simple;
	bh=u7eC3uIUpk9nT6RZF89SkQ3/l3GhF6+N+MEym5p5s/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJ8skSKHRUXWooRVMoT2bgLjqrMnLq64SfNx6I5yb6q1QqCfw1lpHd4awL9IOjrHxNLMJXvwGWTIQDMd9y9PdEbuS03smMAV1DC2ZIeIoMd7AMG6YfByle9GII8omuyySFdiKkpN/8ee5XkAgoJDN1ovkiqVff3dnGqbkt/NxlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=AAYVy4nY; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779978573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5ffcxgrdqHeq7yXI5Zp0GIbn0qD/GZHIUCc4K907Yk=;
	b=AAYVy4nYfwe8oXT27M1B8hn7k7Nx3MTVhJ/x50EAMWMuzAiEMXx27b2kFht9TrbkBDb+MV
	SRSdia5QswLv+p/zlooGw9dpEzVaBuyp3ToU9WesUB/3bgdpxGqkzw2glOXaLx93R4wSwR
	tiWt9ILvxMlwHoc0uf9FBk0AMtzUAnY3R3B3N6jmuqiKzp3Vhp/PRmHFXoJAuelbeSxKUP
	TkENbQOCwfvr0c7BZY29G+YrAvOWeObM9urfYR3Q6gLeEUrZ1wakCbOX0xbKYaJfMxw83W
	X474tEqcwR23bTe66I4wYB/BRJaEhBDIFC+mFVaneFPMijUpyHA5UbTZ8WbwPA==
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
Subject: [PATCH net-next 10/15] batman-adv: replace non-atomic mesh state with (READ|WRITE)_ONCE
Date: Thu, 28 May 2026 16:29:19 +0200
Message-ID: <20260528142924.329658-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528142924.329658-1-sw@simonwunderlich.de>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292715-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 542BF5F3DD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sven Eckelmann <sven@narfation.org>

The mesh state is only accessed as plain loads/stores and does not require
full atomic_t semantics. Convert to an enum and replace its users with
READ_ONCE()/WRITE_ONCE() to avoid load/store tearing.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c     |  2 +-
 net/batman-adv/bat_v_elp.c      |  2 +-
 net/batman-adv/bat_v_ogm.c      |  2 +-
 net/batman-adv/main.c           | 20 ++++++++++----------
 net/batman-adv/mesh-interface.c |  6 +++---
 net/batman-adv/send.c           |  2 +-
 net/batman-adv/tp_meter.c       |  6 +++---
 net/batman-adv/types.h          |  2 +-
 8 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index df8e64588e1e7..c436b77674a56 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1777,7 +1777,7 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 				   delayed_work);
 	bat_priv = netdev_priv(forw_packet->if_incoming->mesh_iface);
 
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
+	if (READ_ONCE(bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
 		dropped = true;
 		goto out;
 	}
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 0190fafcbed2d..d53485d17220e 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -307,7 +307,7 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 	hard_iface = container_of(bat_v, struct batadv_hard_iface, bat_v);
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
+	if (READ_ONCE(bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
 		goto out;
 
 	/* we are in the process of shutting this interface down */
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index f4cd8cad97e0c..b337bd8e58e7d 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -279,7 +279,7 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 
 	lockdep_assert_held(&bat_priv->bat_v.ogm_buff_mutex);
 
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
+	if (READ_ONCE(bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
 		goto out;
 
 	ogm_buff = &bat_priv->bat_v.ogm_buff;
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 786b80a18b5d9..4aabbf2c3a5db 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -200,31 +200,31 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 
 	ret = batadv_originator_init(bat_priv);
 	if (ret < 0) {
-		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+		WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 		goto err_orig;
 	}
 
 	ret = batadv_tt_init(bat_priv);
 	if (ret < 0) {
-		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+		WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 		goto err_tt;
 	}
 
 	ret = batadv_v_mesh_init(bat_priv);
 	if (ret < 0) {
-		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+		WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 		goto err_v;
 	}
 
 	ret = batadv_bla_init(bat_priv);
 	if (ret < 0) {
-		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+		WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 		goto err_bla;
 	}
 
 	ret = batadv_dat_init(bat_priv);
 	if (ret < 0) {
-		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+		WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 		goto err_dat;
 	}
 
@@ -232,7 +232,7 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 	batadv_mcast_init(bat_priv);
 
 	atomic_set(&bat_priv->gw.reselect, 0);
-	atomic_set(&bat_priv->mesh_state, BATADV_MESH_ACTIVE);
+	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_ACTIVE);
 
 	return 0;
 
@@ -246,7 +246,7 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 	batadv_originator_free(bat_priv);
 err_orig:
 	batadv_purge_outstanding_packets(bat_priv, NULL);
-	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
+	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 
 	return ret;
 }
@@ -259,7 +259,7 @@ void batadv_mesh_free(struct net_device *mesh_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 
-	atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
 	batadv_purge_outstanding_packets(bat_priv, NULL);
 	batadv_tp_stop_all(bat_priv);
@@ -290,7 +290,7 @@ void batadv_mesh_free(struct net_device *mesh_iface)
 	free_percpu(bat_priv->bat_counters);
 	bat_priv->bat_counters = NULL;
 
-	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
+	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 }
 
 /**
@@ -454,7 +454,7 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto err_free;
 
 	/* discard frames on not active interfaces */
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 6d7f2dc326fe9..72a0ec823e3ca 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -125,7 +125,7 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 	eth_hw_addr_set(dev, addr->sa_data);
 
 	/* only modify transtable if it has been initialized before */
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		return 0;
 
 	rcu_read_lock();
@@ -192,7 +192,7 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	int network_offset = ETH_HLEN;
 	__be16 proto;
 
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
 
 	/* reset control block to avoid left overs from previous users */
@@ -783,7 +783,7 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->bcast_queue_left, BATADV_BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATADV_BATMAN_QUEUE_LEN);
 
-	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
+	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 	atomic_set(&bat_priv->bcast_seqno, 1);
 	atomic_set(&bat_priv->tt.vn, 0);
 	atomic_set(&bat_priv->tt.ogm_append_cnt, 0);
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 62ae98eef81e2..c7e86c83242a2 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -1047,7 +1047,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 				   delayed_work);
 	bat_priv = netdev_priv(forw_packet->if_incoming->mesh_iface);
 
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
+	if (READ_ONCE(bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
 		dropped = true;
 		goto out;
 	}
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 0fc4ca78e84eb..aefe757277b20 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -999,7 +999,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	/* look for an already existing test towards this node */
 	spin_lock_bh(&bat_priv->tp_list_lock);
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE) {
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE) {
 		spin_unlock_bh(&bat_priv->tp_list_lock);
 		batadv_tp_batctl_error_notify(BATADV_TP_REASON_DST_UNREACHABLE,
 					      dst, bat_priv, session_cookie);
@@ -1387,7 +1387,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	struct batadv_tp_vars *tp_vars = NULL;
 
 	spin_lock_bh(&bat_priv->tp_list_lock);
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto out_unlock;
 
 	tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
@@ -1518,7 +1518,7 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
 {
 	struct batadv_icmp_tp_packet *icmp;
 
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto out;
 
 	icmp = (struct batadv_icmp_tp_packet *)skb->data;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index cf01a670d8250..58375c0a643b8 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1504,7 +1504,7 @@ struct batadv_priv {
 	 * @mesh_state: current status of the mesh
 	 *  (inactive/active/deactivating)
 	 */
-	atomic_t mesh_state;
+	enum batadv_mesh_state mesh_state;
 
 	/** @mesh_iface: net device which holds this struct as private data */
 	struct net_device *mesh_iface;
-- 
2.47.3


