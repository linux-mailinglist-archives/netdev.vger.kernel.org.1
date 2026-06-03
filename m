Return-Path: <netdev+bounces-294628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2D9BHWHfH2o6rgAAu9opvQ
	(envelope-from <netdev+bounces-294628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:01:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 798BB635765
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:01:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=a9j9pyXT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294628-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294628-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CF7E312D336
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F20402453;
	Wed,  3 Jun 2026 07:25:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBA6400DF2
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:25:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471546; cv=none; b=cw78DnJUrRYt8lYF+S662JoCJUkqvc+04FNOhw5kKIIlqhJfH67/FOAUXYEArJc2gk/YZQOrms+FvOGZ154Tp7ZrmFM5hhSrUKXrNJt89klJaNsJYOMfvxCioPkNhA288lgY/E5PrWqrkH411XQvhrznuVN30g5fTBpiygx3/+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471546; c=relaxed/simple;
	bh=8K2iP9LSXQp27nsPUhKWxYl0Bitnf3LmxGh9VjbxmV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKeAt74HBtMpInKP1dYf/tU/RdDQmcC9zzrUgxCi0056VEql3r8NsFDePPALDzerJQSfy0+CyqvR55StN3PpfZ07isYzDyelhjjW7Xif8ibNl19TYEOH2GhVOoAbi2gKQ/vfuuvTiftM7NrPg/0Mx8qQg78jKDgI7nfYLN6r6/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=a9j9pyXT; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=he0/n/acgmP1vB/t/w0LP0oXotNGkr4FL/Cuc2RofVQ=;
	b=a9j9pyXTUKQkbPU7aduarieiA3jnA9aDiRznBp9lT+pmmLPr5t2jc2FCsJyUIupP4aJUqr
	9kz8k8pPfdKUQCh5hN4AUwTkuDF7ipsk8/P8AajBUgTCsVvERTxKXIsapkcQMm3jYgYUic
	xl2n/LwOo4u3Yd81eU1TgZRW6YtHBWY+fsNg6VpAlTRziDHmqpSGaO/Sfr4E07CMwPBtS9
	R//G1kL69lUArE11LSpK7mLuCTpFAV6r3jDTsque/Yv6+HO4P4GLppsWfyzOBuRFG2Ynep
	HBRApSK7agZK8It4OIGhlP0YTP6r0qtZYd5G73jWTj1el6KBmHj/z/ue/dlIQg==
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
Subject: [PATCH net-next 15/15] batman-adv: tt: directly retrieve wifi flags of net_device
Date: Wed,  3 Jun 2026 09:25:26 +0200
Message-ID: <20260603072527.174487-16-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603072527.174487-1-sw@simonwunderlich.de>
References: <20260603072527.174487-1-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294628-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,simonwunderlich.de:mid,simonwunderlich.de:dkim,simonwunderlich.de:from_mime,simonwunderlich.de:email,narfation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 798BB635765

From: Sven Eckelmann <sven@narfation.org>

batadv_tt_local_add() tries to retrieve the wifi flags of an interface to
mark the TT entry as wifi client for the AP isolation feature. In the past,
it was necessary to look up the batadv_hard_iface because the wifi_flags
were stored inside this struct. But with the batadv_wifi_net_devices
rhashtable, it is preferred to directly retrieve the wifi_flags instead of
the indirect route via batadv_hard_iface - which at the end only provides
the net_device (which we used to find the batadv_hard_iface).

This will also be essential when the global batadv_hardif_list is removed
and each lookup via batadv_hardif_get_by_netdev() will require the RTNL
lock.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c    | 25 ++++++++++++++++++-------
 net/batman-adv/hard-interface.h    |  1 +
 net/batman-adv/translation-table.c | 14 ++++++++------
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index bb3c31b5f259d..43ebf86e7b368 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -366,22 +366,19 @@ static u32 batadv_wifi_flags_evaluate(struct net_device *net_device)
 }
 
 /**
- * batadv_hardif_get_wifi_flags() - retrieve wifi flags for hard_iface
- * @hard_iface: the device to check
+ * batadv_netdev_get_wifi_flags() - retrieve wifi flags for net_device
+ * @net_dev: the device to check
  *
  * Return: batadv_hard_iface_wifi_flags flags of the device
  */
-u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface)
+u32 batadv_netdev_get_wifi_flags(struct net_device *net_dev)
 {
 	struct batadv_wifi_net_device_state *device_state;
 	u32 wifi_flags = 0;
 
-	if (!hard_iface)
-		return 0;
-
 	rcu_read_lock();
 	device_state = rhashtable_lookup_fast(&batadv_wifi_net_devices,
-					      &hard_iface->net_dev,
+					      &net_dev,
 					      batadv_wifi_net_devices_params);
 	if (device_state)
 		wifi_flags = READ_ONCE(device_state->wifi_flags);
@@ -390,6 +387,20 @@ u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface)
 	return wifi_flags;
 }
 
+/**
+ * batadv_hardif_get_wifi_flags() - retrieve wifi flags for hard_iface
+ * @hard_iface: the device to check
+ *
+ * Return: batadv_hard_iface_wifi_flags flags of the device
+ */
+u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface)
+{
+	if (!hard_iface)
+		return 0;
+
+	return batadv_netdev_get_wifi_flags(hard_iface->net_dev);
+}
+
 /**
  * batadv_is_wifi_hardif() - check if the given hardif is a wifi interface
  * @hard_iface: the device to check
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 089e65c8a4817..822e7e378c4d1 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -70,6 +70,7 @@ extern struct notifier_block batadv_hard_if_notifier;
 
 struct net_device *__batadv_get_real_netdev(struct net_device *net_device);
 struct net_device *batadv_get_real_netdev(struct net_device *net_device);
+u32 batadv_netdev_get_wifi_flags(struct net_device *net_dev);
 u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface);
 bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface);
 struct batadv_hard_iface*
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 44bbaa3bb37d1..c346e43d47b9b 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -596,20 +596,23 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	struct net *net = dev_net(mesh_iface);
 	struct batadv_meshif_vlan *vlan;
 	struct net_device *in_dev = NULL;
-	struct batadv_hard_iface *in_hardif = NULL;
 	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry;
 	int hash_added, table_size, packet_size_max;
 	bool ret = false;
 	bool roamed_back = false;
+	bool iif_is_wifi = false;
 	u8 remote_flags;
 	u32 match_mark;
 
 	if (ifindex != BATADV_NULL_IFINDEX)
 		in_dev = dev_get_by_index(net, ifindex);
 
-	if (in_dev)
-		in_hardif = batadv_hardif_get_by_netdev(in_dev);
+	if (in_dev) {
+		u32 wifi_flags = batadv_netdev_get_wifi_flags(in_dev);
+
+		iif_is_wifi = batadv_is_wifi(wifi_flags);
+	}
 
 	tt_local = batadv_tt_local_hash_find(bat_priv, addr, vid);
 
@@ -684,7 +687,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	 */
 	tt_local->common.flags = BATADV_TT_CLIENT_NEW;
 	tt_local->common.vid = vid;
-	if (batadv_is_wifi_hardif(in_hardif))
+	if (iif_is_wifi)
 		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
 	kref_init(&tt_local->common.refcount);
 	tt_local->last_seen = jiffies;
@@ -743,7 +746,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	 */
 	remote_flags = tt_local->common.flags & BATADV_TT_REMOTE_MASK;
 
-	if (batadv_is_wifi_hardif(in_hardif))
+	if (iif_is_wifi)
 		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
 	else
 		tt_local->common.flags &= ~BATADV_TT_CLIENT_WIFI;
@@ -767,7 +770,6 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
 	ret = true;
 out:
-	batadv_hardif_put(in_hardif);
 	dev_put(in_dev);
 	batadv_tt_local_entry_put(tt_local);
 	batadv_tt_global_entry_put(tt_global);
-- 
2.47.3


