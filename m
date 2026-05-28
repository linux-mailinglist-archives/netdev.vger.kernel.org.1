Return-Path: <netdev+bounces-292719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPmmL8dUGGoQjQgAu9opvQ
	(envelope-from <netdev+bounces-292719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:44:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0BC5F3E11
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C53230D7F51
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E756F3F6C4B;
	Thu, 28 May 2026 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="PM13G3G+"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9683F0AB2
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978581; cv=none; b=sLF97cyy5OnPsl74R407eQnb/a+2mCqK2EYT0xTYSUgvnh8cZq/4Lu/0Frx2lrtk1aRDFFllDSqkI6UergNj3B2agwERKowzL4B4xj4BFGMCHYcriYe8l+0EkR+d5wWQHfaB7pzrkwdIQFTBBJrkKs9uY9JpkcvDHwZiTXmvWbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978581; c=relaxed/simple;
	bh=ZmalaQCS82x8DIx/xJmtideFEt10o2S2BXubvRxPcN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8W2EluZ2xaxtjMNE0ahdQdkzCrfDgh+9sMs5lZgy2J5IQzj4LcmjxwM2wH9LwPGxkdG2LeALzmVycbl/+7v9UYZ6Wq/eM24pNFm91voyjVQ26kfm22vQC/+Qe2EV6+0cxikosb7lNUJPpHd2ZzdfFYgoSlyQ9+Bs8LsKIo9HI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=PM13G3G+; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779978576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wU8EADN7q21SEHJNlOIBEzAVqEevDfMMQ8wP/p0bpp0=;
	b=PM13G3G+giU1PJJeHHUZW31dWIsEbYdcRNPxuP8X/4ECXreF7QVEz4ZjaPHHx8VPJ/oaqm
	/ie2Sm+EAQuu+nkWaYNKJ/8gLmU5zES4hRS6QUFuMVEXK3nqFhCwl11ZS13SyXc5JmJq8J
	A3iOAJopH9qyPeUlte3uKSeWQRU53VZAlXwE9UqwsyvEoWND7IikXbV0BB6orTTe320kzN
	LctYcfjqKjfwPhUK1zEw8IcBBSwVcJdArDVPVs2FAq9MGDGsAomHNs0Fx8jhILX7OT4bUO
	cYAycRaeVsuQEHTGpkRy7s5xjvc2EI8cn7d07aoQV3J197+oXLu/RntD0N60uw==
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
Subject: [PATCH net-next 15/15] batman-adv: use neigh_node's orig_node only as id
Date: Thu, 28 May 2026 16:29:24 +0200
Message-ID: <20260528142924.329658-16-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292719-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BB0BC5F3E11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sven Eckelmann <sven@narfation.org>

The orig_node member of struct batadv_neigh_node is no longer used in
B.A.T.M.A.N. IV. But batadv_neigh_node_create() is still storing it.
Only batadv_v_ogm_route_update() uses it to check if we route toward
it - not needing the data stored in the batadv_orig_node object itself,
but merely a pointer to identify the originator.

The field cannot hold a proper reference because that would create a
reference cycle, so it must never be dereferenced. Rename it to
orig_node_id and mark it __private to make any future attempt to
dereference it immediately noticeable.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_ogm.c  |  2 +-
 net/batman-adv/originator.c |  5 ++++-
 net/batman-adv/types.h      | 11 +++++++++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 2c4dca639709c..5936d0048be01 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -719,7 +719,7 @@ static bool batadv_v_ogm_route_update(struct batadv_priv *bat_priv,
 	 * don't route towards it
 	 */
 	router = batadv_orig_router_get(orig_node, if_outgoing);
-	if (router && router->orig_node != orig_node && !orig_neigh_router) {
+	if (router && ACCESS_PRIVATE(router, orig_node_id) != orig_node && !orig_neigh_router) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: OGM via unknown neighbor!\n");
 		goto out;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index d05c8240426bd..15d660ca79376 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -693,9 +693,12 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 	kref_get(&hard_iface->refcount);
 	ether_addr_copy(neigh_node->addr, neigh_addr);
 	neigh_node->if_incoming = hard_iface;
-	neigh_node->orig_node = orig_node;
 	neigh_node->last_seen = jiffies;
 
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	ACCESS_PRIVATE(neigh_node, orig_node_id) = orig_node;
+#endif
+
 	/* increment unique neighbor refcount */
 	kref_get(&hardif_neigh->refcount);
 	neigh_node->hardif_neigh = hardif_neigh;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c3b6af399110b..1fbdd58b59bd9 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -663,8 +663,15 @@ struct batadv_neigh_node {
 	/** @list: list node for &batadv_orig_node.neigh_list */
 	struct hlist_node list;
 
-	/** @orig_node: pointer to corresponding orig_node */
-	struct batadv_orig_node *orig_node;
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	/**
+	 * @orig_node_id: pointer to corresponding orig_node. It must only be used
+	 * to identify the node but must NEVER be dereferenced. The reference counter
+	 * was not increased when this was assigned because it would otherwise create
+	 * a reference cycle.
+	 */
+	struct batadv_orig_node *__private orig_node_id;
+#endif
 
 	/** @addr: the MAC address of the neighboring interface */
 	u8 addr[ETH_ALEN];
-- 
2.47.3


