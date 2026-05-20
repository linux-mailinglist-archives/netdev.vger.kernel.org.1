Return-Path: <netdev+bounces-289921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEOgILShDWou0gUAu9opvQ
	(envelope-from <netdev+bounces-289921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:57:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C257D58D198
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 957EF30585CF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC803DC4CF;
	Wed, 20 May 2026 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="muyxCGjR"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483CC3DB326
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278091; cv=none; b=ny4JmN1Wc1Hj1ureyQB2xmDvqdTz87nAwrsQkMoxEgTw9qfq4iH1SPMeCLs9u1fQkZfcRspEkouPUPYhYSR43cikTmTKkXbQnvJXJch+5lpA5+exTjbEktsXr+SkfrN7S2d+wjcIoGqfL0Ctt3ocRnZX6kCHgSgGE5mhVUINTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278091; c=relaxed/simple;
	bh=gDQRJE8ivErAhSRR5cj/JApdk8fiDCAue+Jq4UK88hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOuFVlzWT/OKi6Hsz6QfOPeujMX1LO3Trdp3WSzQvmm8YSCHkWkOIOxKvUQ1WWT8nb23r78JrckQqHqSNYUF5/ChFt6rGnXsjw4QB9+IYjjc8xGhtInUGrsZG3HIoyBzhiErDYUC+2zrf6CjU8RdP+X1CY0vUcTvZ0oo6OS193c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=muyxCGjR; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779278085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYtewblOdVwpfCD0XV03JBhlqS1ubGmMoyNowXCEcvI=;
	b=muyxCGjRiT0vqpE1t7hatGx5VGZQy4wVZLXn4SRZpVCXwKclu+P7kEkzCPh2Px4DloVUJu
	KUkl4B3OI2JrQK0IRPVzM2uTMOl4MrQ6HV4+BjwjwIVknRscTXv4ijHCmS69Tq+iP9BLG+
	J2BZCnfDQ2MMSNSSImhEWexPd8fRAMggDDD08LVCj7r3qn+U/X8Pdd5UEAWSagpkHruH8G
	zbTEBXbmfbOXLH5LAXFHqidCxyHAr+k/ReiDCSZy5tFzsnvpRUKHpehPR1t6r1yGNQtzNa
	Cd2CoTTuInqgnTaZ2//MfPtX1uHWfROF0wJeAKN/Qc4yohd16yoFTExxzzRfgA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 10/11] batman-adv: bla: avoid double decrement of bla.num_requests
Date: Wed, 20 May 2026 13:54:21 +0200
Message-ID: <20260520115422.53552-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520115422.53552-1-sw@simonwunderlich.de>
References: <20260520115422.53552-1-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289921-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,narfation.org:email]
X-Rspamd-Queue-Id: C257D58D198
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sven Eckelmann <sven@narfation.org>

The bla.num_requests is increased when no request_sent was in progress. And
it is decremented in various places (announcement was received, backbone is
purged, periodic work). But the check if the request_sent is actually set
to a specific state and the atomic_dec/_inc are not safe because they are
not atomic (TOCTOU) and multiple such code portions can run concurrently.

At the same time, it is necessary to modify request_sent (state) and
bla.num_requests atomically. Otherwise batadv_bla_send_request() might set
request_sent to 1 and is interrupted.  batadv_handle_announce() can then
set request_sent back to 0 and decrement num_requests before
batadv_bla_send_request() incremented it.

The two operations must therefore be locked. And since state (request_sent)
and wait_periods are only accessed inside this lock, they can be converted
to simpler datatypes. And to avoid that the bla.num_requests is touched by
a parallel running context with a valid backbone_gw reference after
batadv_bla_purge_backbone_gw() ran, a third state "stopped" is required to
correctly signal that a backbone_gw is in the state of being cleaned up.

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 51 ++++++++++++++++++--------
 net/batman-adv/mesh-interface.c        |  1 +
 net/batman-adv/types.h                 | 39 ++++++++++++++++----
 3 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index df1dfdf4a1a12..1bef12e659cb2 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -514,8 +514,8 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 	entry->crc = BATADV_BLA_CRC_INIT;
 	entry->bat_priv = bat_priv;
 	spin_lock_init(&entry->crc_lock);
-	atomic_set(&entry->request_sent, 0);
-	atomic_set(&entry->wait_periods, 0);
+	entry->state = BATADV_BLA_BACKBONE_GW_SYNCED;
+	entry->wait_periods = 0;
 	ether_addr_copy(entry->orig, orig);
 	INIT_WORK(&entry->report_work, batadv_bla_loopdetect_report);
 	kref_init(&entry->refcount);
@@ -544,9 +544,13 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 		batadv_bla_send_announce(bat_priv, entry);
 
 		/* this will be decreased in the worker thread */
-		atomic_inc(&entry->request_sent);
-		atomic_set(&entry->wait_periods, BATADV_BLA_WAIT_PERIODS);
-		atomic_inc(&bat_priv->bla.num_requests);
+		spin_lock_bh(&bat_priv->bla.num_requests_lock);
+		if (entry->state == BATADV_BLA_BACKBONE_GW_SYNCED) {
+			entry->state = BATADV_BLA_BACKBONE_GW_UNSYNCED;
+			entry->wait_periods = BATADV_BLA_WAIT_PERIODS;
+			atomic_inc(&bat_priv->bla.num_requests);
+		}
+		spin_unlock_bh(&bat_priv->bla.num_requests_lock);
 	}
 
 	return entry;
@@ -649,10 +653,12 @@ static void batadv_bla_send_request(struct batadv_bla_backbone_gw *backbone_gw)
 			      backbone_gw->vid, BATADV_CLAIM_TYPE_REQUEST);
 
 	/* no local broadcasts should be sent or received, for now. */
-	if (!atomic_read(&backbone_gw->request_sent)) {
+	spin_lock_bh(&backbone_gw->bat_priv->bla.num_requests_lock);
+	if (backbone_gw->state == BATADV_BLA_BACKBONE_GW_SYNCED) {
+		backbone_gw->state = BATADV_BLA_BACKBONE_GW_UNSYNCED;
 		atomic_inc(&backbone_gw->bat_priv->bla.num_requests);
-		atomic_set(&backbone_gw->request_sent, 1);
 	}
+	spin_unlock_bh(&backbone_gw->bat_priv->bla.num_requests_lock);
 }
 
 /**
@@ -873,10 +879,12 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 		/* if we have sent a request and the crc was OK,
 		 * we can allow traffic again.
 		 */
-		if (atomic_read(&backbone_gw->request_sent)) {
+		spin_lock_bh(&bat_priv->bla.num_requests_lock);
+		if (backbone_gw->state == BATADV_BLA_BACKBONE_GW_UNSYNCED) {
+			backbone_gw->state = BATADV_BLA_BACKBONE_GW_SYNCED;
 			atomic_dec(&backbone_gw->bat_priv->bla.num_requests);
-			atomic_set(&backbone_gw->request_sent, 0);
 		}
+		spin_unlock_bh(&bat_priv->bla.num_requests_lock);
 	}
 
 	batadv_backbone_gw_put(backbone_gw);
@@ -1255,9 +1263,13 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 				purged = true;
 
 				/* don't wait for the pending request anymore */
-				if (atomic_read(&backbone_gw->request_sent))
+				spin_lock_bh(&bat_priv->bla.num_requests_lock);
+				if (backbone_gw->state == BATADV_BLA_BACKBONE_GW_UNSYNCED)
 					atomic_dec(&bat_priv->bla.num_requests);
 
+				backbone_gw->state = BATADV_BLA_BACKBONE_GW_STOPPED;
+				spin_unlock_bh(&bat_priv->bla.num_requests_lock);
+
 				batadv_bla_del_backbone_claims(backbone_gw);
 
 				hlist_del_rcu(&backbone_gw->hash_entry);
@@ -1508,7 +1520,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 				batadv_bla_send_loopdetect(bat_priv,
 							   backbone_gw);
 
-			/* request_sent is only set after creation to avoid
+			/* state is only set to unsynced after creation to avoid
 			 * problems when we are not yet known as backbone gw
 			 * in the backbone.
 			 *
@@ -1517,14 +1529,21 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 			 * some grace time.
 			 */
 
-			if (atomic_read(&backbone_gw->request_sent) == 0)
-				continue;
+			spin_lock_bh(&bat_priv->bla.num_requests_lock);
+			if (backbone_gw->state != BATADV_BLA_BACKBONE_GW_UNSYNCED)
+				goto unlock_next;
 
-			if (!atomic_dec_and_test(&backbone_gw->wait_periods))
-				continue;
+			if (backbone_gw->wait_periods > 0)
+				backbone_gw->wait_periods--;
+
+			if (backbone_gw->wait_periods > 0)
+				goto unlock_next;
 
+			backbone_gw->state = BATADV_BLA_BACKBONE_GW_SYNCED;
 			atomic_dec(&backbone_gw->bat_priv->bla.num_requests);
-			atomic_set(&backbone_gw->request_sent, 0);
+
+unlock_next:
+			spin_unlock_bh(&bat_priv->bla.num_requests_lock);
 		}
 		rcu_read_unlock();
 	}
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 56ca1c1b83f27..e7aa45bc6b7ad 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -787,6 +787,7 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->tt.ogm_append_cnt, 0);
 #ifdef CONFIG_BATMAN_ADV_BLA
 	atomic_set(&bat_priv->bla.num_requests, 0);
+	spin_lock_init(&bat_priv->bla.num_requests_lock);
 #endif
 	atomic_set(&bat_priv->tp_num, 0);
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 821ada05d86a7..a01ee46d97f34 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1026,6 +1026,12 @@ struct batadv_priv_bla {
 	/** @num_requests: number of bla requests in flight */
 	atomic_t num_requests;
 
+	/**
+	 * @num_requests_lock: locks update num_requests +
+	 * batadv_backbone_gw::state + batadv_backbone_gw::wait_periods update
+	 */
+	spinlock_t num_requests_lock;
+
 	/**
 	 * @claim_hash: hash table containing mesh nodes this host has claimed
 	 */
@@ -1672,6 +1678,27 @@ struct batadv_priv {
 
 #ifdef CONFIG_BATMAN_ADV_BLA
 
+enum batadv_bla_backbone_gw_state {
+	/**
+	 * @BATADV_BLA_BACKBONE_GW_STOPPED: backbone gw is being removed
+	 * and it must not longer work on requests
+	 */
+	BATADV_BLA_BACKBONE_GW_STOPPED,
+
+	/**
+	 * @BATADV_BLA_BACKBONE_GW_UNSYNCED: backbone was detected out
+	 * of sync and a request was send. No traffic is forwarded until the
+	 * situation is resolved
+	 */
+	BATADV_BLA_BACKBONE_GW_UNSYNCED,
+
+	/**
+	 * @BATADV_BLA_BACKBONE_GW_SYNCED: backbone is consider to be in
+	 * sync. traffic can be forwarded
+	 */
+	BATADV_BLA_BACKBONE_GW_SYNCED,
+};
+
 /**
  * struct batadv_bla_backbone_gw - batman-adv gateway bridged into the LAN
  */
@@ -1697,16 +1724,12 @@ struct batadv_bla_backbone_gw {
 	/**
 	 * @wait_periods: grace time for bridge forward delays and bla group
 	 *  forming at bootup phase - no bcast traffic is formwared until it has
-	 *  elapsed
+	 *  elapsed. Must only be access with num_requests_lock.
 	 */
-	atomic_t wait_periods;
+	u8 wait_periods;
 
-	/**
-	 * @request_sent: if this bool is set to true we are out of sync with
-	 *  this backbone gateway - no bcast traffic is formwared until the
-	 *  situation was resolved
-	 */
-	atomic_t request_sent;
+	/** @state: sync state. Must only be access with num_requests_lock. */
+	enum batadv_bla_backbone_gw_state state;
 
 	/** @crc: crc16 checksum over all claims */
 	u16 crc;
-- 
2.47.3


