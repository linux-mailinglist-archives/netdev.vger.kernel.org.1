Return-Path: <netdev+bounces-293744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNc1NTR9HWrEbAkAu9opvQ
	(envelope-from <netdev+bounces-293744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:38:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ECC61F5F6
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9051C3014245
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FE437BE63;
	Mon,  1 Jun 2026 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="0oLQ6s6g"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101AD37F75B
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317417; cv=none; b=hDz/Stpperj0LECfZJgJF2UPsTbgtxfmsjeDpC/I22QNAss+WyS9zVVW0CGZ2PqaoAW+O+/uauFH/dLPxR2u2XHt0hQ6vBLpq3s2c6E6/Dmh73ro7iHwKFerfTmfFOl9bp06y61OH22dCStGirVHd+t+c5q85GkLJMjKA89EEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317417; c=relaxed/simple;
	bh=IgsMsLTH+aIx0XEhbU/IX5FKem8ycAkilq9ImUfppS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAW32gq0uemD2mIqJHro37pii4nJj3RiehDotb3KDGlckNFvqNw9yEdI/HMBLp2gc2UusWAFGLCMC7Vxs75MqFX72yRFLmeHhTEADCfMDbGSWCJgfUp+zaog3Z9NIAuFPTlNlnRJovR+wmcmbhBwL+fkIL19PGwZuu7qnPlwcn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=0oLQ6s6g; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9+WB8YF39qEgw1TjmumqQ3RHGa+ipeDa6dcaa8I518=;
	b=0oLQ6s6gcvYuNLOS6kNbLQ92IjGStv/WkmvVbn9BvYNa0a5FCUGpaesmHqWs1hPgTniylj
	65CSPWEcNAqayAVpZ4Kzs4DoATultyGqWKF1oZR5+58dxEAUcaUm1vstKGW6wcVYLtVNh4
	Odw7ER2Fm5bIhHPaKbM27j9MX5wQnyLIYqbw1xsCOyApsSjIbYyA1nzDR/m8tcWnkNrMom
	fIaB6p2nImwla+K4w3Q2QZVS+sl/ry3lYgIXitYKVDgrh+t4mkaqfMQB4khLWEVIrm3uTq
	xGea/Vg+0x4HNMaF0QLNW2TSXAwSGGJ4Lr0zOR8eFE81HNzDMpeaToGB/8Syog==
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
Date: Mon,  1 Jun 2026 14:36:24 +0200
Message-ID: <20260601123629.707089-11-sw@simonwunderlich.de>
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
	TAGGED_FROM(0.00)[bounces-293744-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 79ECC61F5F6
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
index a5398c5df2632..60d4f60066c80 100644
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
index 58cbb4f8a5abd..7497f307c10db 100644
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


