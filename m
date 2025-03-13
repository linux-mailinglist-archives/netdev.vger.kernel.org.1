Return-Path: <netdev+bounces-174670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83225A5FC6F
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD13A310A
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C135268FED;
	Thu, 13 Mar 2025 16:45:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6180226A098
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884329; cv=none; b=XOjon91cA0sRbhL4lSONgEPkWneCIhLWxda9mhc8MPqUX532R8lF4dcgsqPgnzR1jKr5CI0NQ8kxz+fGFkK4oT31Y3JAfQ1CroudQhCXNXCJ0zQCy5TvGtHhSqtdusO4EbYTbrhlWq3EQC0uNutUYVvGE9FzwtBd4YiXwk92+Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884329; c=relaxed/simple;
	bh=70zk0jhiSITTpBl0Ej450hjLej6xhL5eiocELW3R5cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aOdCS4Lu7IuaP/vsmjZZxkTvybXXlkFPkKM2zfUYyeq3O8e/yHLziOfFgnIU665yvGsrmMel0uHu7ldkVrJhHkcRJcmGyDxT3Zb/zSIlMNtONoNm2Vhw2QtVm/Vocxrxz86RqVD4swxMirCPvdB9vuEe/rulXCvdVR/S+7ZxO0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300fA272413901A38A4BC9c0De305.dip0.t-ipconnect.de [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 475B7FA1ED;
	Thu, 13 Mar 2025 17:45:25 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Eric Dumazet <edumazet@google.com>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 03/10] batman-adv: adopt netdev_hold() / netdev_put()
Date: Thu, 13 Mar 2025 17:45:12 +0100
Message-Id: <20250313164519.72808-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313164519.72808-1-sw@simonwunderlich.de>
References: <20250313164519.72808-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

Add a device tracker to struct batadv_hard_iface to help
debugging of network device refcount imbalances.

Signed-off-by: Eric Dumazet <edumazet@google.com>
[sven@narfation.org: fix kernel-doc, adopt for softif reference]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 20 ++++++++------------
 net/batman-adv/types.h          |  6 ++++++
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 96a412beab2d..71b2236c0058 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -51,7 +51,7 @@ void batadv_hardif_release(struct kref *ref)
 	struct batadv_hard_iface *hard_iface;
 
 	hard_iface = container_of(ref, struct batadv_hard_iface, refcount);
-	dev_put(hard_iface->net_dev);
+	netdev_put(hard_iface->net_dev, &hard_iface->dev_tracker);
 
 	kfree_rcu(hard_iface, rcu);
 }
@@ -728,6 +728,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	kref_get(&hard_iface->refcount);
 
 	dev_hold(soft_iface);
+	netdev_hold(soft_iface, &hard_iface->softif_dev_tracker, GFP_ATOMIC);
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
@@ -784,7 +785,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	netdev_upper_dev_unlink(hard_iface->net_dev, soft_iface);
 err_dev:
 	hard_iface->soft_iface = NULL;
-	dev_put(soft_iface);
+	netdev_put(soft_iface, &hard_iface->softif_dev_tracker);
 	batadv_hardif_put(hard_iface);
 	return ret;
 }
@@ -851,7 +852,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	/* delete all references to this hard_iface */
 	batadv_purge_orig_ref(bat_priv);
 	batadv_purge_outstanding_packets(bat_priv, hard_iface);
-	dev_put(hard_iface->soft_iface);
+	netdev_put(hard_iface->soft_iface, &hard_iface->softif_dev_tracker);
 
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->soft_iface);
 	batadv_hardif_recalc_extra_skbroom(hard_iface->soft_iface);
@@ -875,15 +876,15 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	ASSERT_RTNL();
 
 	if (!batadv_is_valid_iface(net_dev))
-		goto out;
-
-	dev_hold(net_dev);
+		return NULL;
 
 	hard_iface = kzalloc(sizeof(*hard_iface), GFP_ATOMIC);
 	if (!hard_iface)
-		goto release_dev;
+		return NULL;
 
+	netdev_hold(net_dev, &hard_iface->dev_tracker, GFP_ATOMIC);
 	hard_iface->net_dev = net_dev;
+
 	hard_iface->soft_iface = NULL;
 	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
 
@@ -909,11 +910,6 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	batadv_hardif_generation++;
 
 	return hard_iface;
-
-release_dev:
-	dev_put(net_dev);
-out:
-	return NULL;
 }
 
 static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 64a0cf4257ed..b3b4f71f6dec 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -186,6 +186,9 @@ struct batadv_hard_iface {
 	/** @net_dev: pointer to the net_device */
 	struct net_device *net_dev;
 
+	/** @dev_tracker: device tracker for @net_dev */
+	netdevice_tracker dev_tracker;
+
 	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
 
@@ -201,6 +204,9 @@ struct batadv_hard_iface {
 	 */
 	struct net_device *soft_iface;
 
+	/** @softif_dev_tracker: device tracker for @soft_iface */
+	netdevice_tracker softif_dev_tracker;
+
 	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
 
-- 
2.39.5


