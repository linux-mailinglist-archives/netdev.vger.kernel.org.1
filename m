Return-Path: <netdev+bounces-292713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NOYBkpTGGoQjQgAu9opvQ
	(envelope-from <netdev+bounces-292713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:38:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0105F3CEC
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81581315DE49
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BDF3EFFAF;
	Thu, 28 May 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="zOi1U/YQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC133D3CF9
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978579; cv=none; b=lAwiSwXeGF0DulcKy/zuv64eu51REKuw4yumEwB/f2iqNuncl2OWzL14d9Im4awoR12jD6SxM6mXDHVx9X+KTjD0HZgLf2NHra4es/7RBvyWDy9j9BvhKzLeHS4LN+eQzD3L28TWEaIBFxjbk1m4wylh9uRyS5ipp/0sP4BtTPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978579; c=relaxed/simple;
	bh=ziombrDOAVC/KFNIwmLH1SI93FKnRd0WIiSgRadSNgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeM+E12WLEBUMYPUq/PJAwddjwk55JCsibKZSuVE3rtEl+Pf9TvUoWryRyISyvpru01Jdgdcsj6QYy+DSdE1DtWvQ/GQ8784ixjO0YvLtvCvblBF1x1ykLNu1FrQ/qYeBK3xTcXWDSwjp1Y0PsqnjcxiprbOnspjNHza3qx04po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=zOi1U/YQ; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779978574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlRW/1o5c5Pn9BcJXzRZfsihaCkWvKRTb1wXQ9KjKv8=;
	b=zOi1U/YQxRf3sp1ZGgtCjuiwONVc4+wXHvcj6fO/zyzuC0WzgjafdCGZ5P5yrtNJT0rNqX
	tyy7OgVvULtcJzrnN/IgUAYY8EujTwzF/Ro+R6QLp45nZP9clJJgqBjij7K8a1w+FpMtUp
	mnJQEuqh8ZyAWX08Jtvs6UNp6vJPZLn0d2wL190XLkto5UR6ANhucnQWHvPRNNtgR7/bWv
	Os4pdYlQ9t+XzukSJCFXOu5lUReAq3blMyA2L5wLm8aPmhgkqUSPjLVFLtOn9DH1kQy3Su
	amNzVbg2edcL4m8RSCNb2QJHkFSFk9QVR6Cz8Qo7HvgGt/xC0ZxiR4Eqr8uzRw==
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
Subject: [PATCH net-next 12/15] batman-adv: replace non-atomic last_ttvn with (READ|WRITE)_ONCE
Date: Thu, 28 May 2026 16:29:21 +0200
Message-ID: <20260528142924.329658-13-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292713-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AA0105F3CEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sven Eckelmann <sven@narfation.org>

The last TT version number of an meshif is only accessed as plain
loads/stores and does not require full atomic_t semantics. Convert to an
native integer and replace its users with READ_ONCE()/WRITE_ONCE() to avoid
load/store tearing.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/originator.c        |  2 +-
 net/batman-adv/routing.c           |  4 ++--
 net/batman-adv/send.c              |  2 +-
 net/batman-adv/translation-table.c | 16 ++++++++--------
 net/batman-adv/types.h             |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 0ce07bfdade59..d05c8240426bd 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -965,7 +965,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	orig_node->bat_priv = bat_priv;
 	ether_addr_copy(orig_node->orig, addr);
 	batadv_dat_init_orig_node_addr(orig_node);
-	atomic_set(&orig_node->last_ttvn, 0);
+	WRITE_ONCE(orig_node->last_ttvn, 0);
 	orig_node->tt_buff = NULL;
 	orig_node->tt_buff_len = 0;
 	orig_node->last_seen = jiffies;
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 1dd295d934f49..cd4368b846add 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -765,7 +765,7 @@ batadv_reroute_unicast_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			goto out;
 
 		orig_addr = orig_node->orig;
-		orig_ttvn = (u8)atomic_read(&orig_node->last_ttvn);
+		orig_ttvn = READ_ONCE(orig_node->last_ttvn);
 	}
 
 	/* update the packet header */
@@ -845,7 +845,7 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 		if (!orig_node)
 			return false;
 
-		curr_ttvn = (u8)atomic_read(&orig_node->last_ttvn);
+		curr_ttvn = READ_ONCE(orig_node->last_ttvn);
 		batadv_orig_node_put(orig_node);
 	}
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index c7e86c83242a2..5f9da3606a8f5 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -222,7 +222,7 @@ batadv_send_skb_push_fill_unicast(struct sk_buff *skb, int hdr_size,
 				  struct batadv_orig_node *orig_node)
 {
 	struct batadv_unicast_packet *unicast_packet;
-	u8 ttvn = (u8)atomic_read(&orig_node->last_ttvn);
+	u8 ttvn = READ_ONCE(orig_node->last_ttvn);
 
 	if (batadv_skb_head_push(skb, hdr_size) < 0)
 		return false;
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e319b0796f7c8..8903b2f84f512 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -841,7 +841,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	}
 
 	(*tt_data)->flags = BATADV_NO_FLAGS;
-	(*tt_data)->ttvn = atomic_read(&orig_node->last_ttvn);
+	(*tt_data)->ttvn = READ_ONCE(orig_node->last_ttvn);
 	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (*tt_data)->vlan_data;
@@ -1822,7 +1822,7 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 	if (!hdr)
 		return -ENOBUFS;
 
-	last_ttvn = atomic_read(&orig->orig_node->last_ttvn);
+	last_ttvn = READ_ONCE(orig->orig_node->last_ttvn);
 
 	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->addr) ||
 	    nla_put(msg, BATADV_ATTR_ORIG_ADDRESS, ETH_ALEN,
@@ -3013,7 +3013,7 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	if (!res_dst_orig_node)
 		goto out;
 
-	orig_ttvn = (u8)atomic_read(&req_dst_orig_node->last_ttvn);
+	orig_ttvn = READ_ONCE(req_dst_orig_node->last_ttvn);
 	req_ttvn = tt_data->ttvn;
 
 	/* this node doesn't have the requested data */
@@ -3300,7 +3300,7 @@ static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
 	orig_node->tt_buff = NULL;
 	spin_unlock_bh(&orig_node->tt_buff_lock);
 
-	atomic_set(&orig_node->last_ttvn, ttvn);
+	WRITE_ONCE(orig_node->last_ttvn, ttvn);
 
 out:
 	batadv_orig_node_put(orig_node);
@@ -3316,7 +3316,7 @@ static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
 
 	batadv_tt_save_orig_buffer(bat_priv, orig_node, tt_change,
 				   batadv_tt_len(tt_num_changes));
-	atomic_set(&orig_node->last_ttvn, ttvn);
+	WRITE_ONCE(orig_node->last_ttvn, ttvn);
 }
 
 /**
@@ -3769,7 +3769,7 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 				  struct batadv_tvlv_tt_change *tt_change,
 				  u16 tt_num_changes, u8 ttvn)
 {
-	u8 orig_ttvn = (u8)atomic_read(&orig_node->last_ttvn);
+	u8 orig_ttvn = READ_ONCE(orig_node->last_ttvn);
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	bool full_table = true;
 	bool has_tt_init;
@@ -3911,7 +3911,7 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 
 	if (!batadv_tt_global_add(bat_priv, orig_node, addr, vid,
 				  BATADV_TT_CLIENT_TEMP,
-				  atomic_read(&orig_node->last_ttvn)))
+				  READ_ONCE(orig_node->last_ttvn)))
 		return false;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -4125,7 +4125,7 @@ static int batadv_roam_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 
 	batadv_tt_global_add(bat_priv, orig_node, roaming_adv->client,
 			     ntohs(roaming_adv->vid), BATADV_TT_CLIENT_ROAM,
-			     atomic_read(&orig_node->last_ttvn) + 1);
+			     READ_ONCE(orig_node->last_ttvn) + 1);
 
 out:
 	batadv_orig_node_put(orig_node);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 51880748bc2f5..5d4ad35c19636 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -464,7 +464,7 @@ struct batadv_orig_node {
 	unsigned long capa_initialized;
 
 	/** @last_ttvn: last seen translation table version number */
-	atomic_t last_ttvn;
+	u8 last_ttvn;
 
 	/** @tt_buff: last tt changeset this node received from the orig node */
 	unsigned char *tt_buff;
-- 
2.47.3


