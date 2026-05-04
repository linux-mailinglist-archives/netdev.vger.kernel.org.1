Return-Path: <netdev+bounces-284029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PPbCnn0+Gk73gIAu9opvQ
	(envelope-from <netdev+bounces-284029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:33:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 839CD4C347B
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 238CF3018407
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 19:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89743FAE07;
	Mon,  4 May 2026 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="wHqgAZ1p"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162FB22A4EE;
	Mon,  4 May 2026 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777923188; cv=none; b=naOE/xvE9OmbnTC9bJ2cimks/5mu3VO/3nLrKSRDxmk+LdN9KrLmDMmt8TbGpshNG7satxuptRHFkJHvyvo0eCmuMV8KR7dzZSmShzZxophBH5qtxFVBC0pulb27iwXXXA4SkO3si8PTN+c25S+VLXfa5+m+I2BFEzSwVRwgBaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777923188; c=relaxed/simple;
	bh=3baNab/PKWRzQWqmzSt6NT567cjaLxcNDE+ohCHOPMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qcaauW6kO0ULmNlxM6QveaFrnB2KK0g/FTV4PuH6MsKdlshWbeCYdrGfJFrtK6lgW8Nd9y0UQKUdwWu5XiJayxftSJosrC8v1QCoRJBjM6U6TfFcH03KyJPl+HCrfiW4MSMjIYdyp5eXLemmnWqU4QsyRWHo0z2c1u+BrkUnn3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=wHqgAZ1p; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id B17971FE4D;
	Mon, 04 May 2026 19:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777923178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c5QmEhIbBZmnycI5gzgl1LqeD/FhzzBLVAW4WdCqXeE=;
	b=wHqgAZ1pp0uwdszir0bXXVP8O+nKBAjCv86HFto8gKXl54yZWOnWE4ZDajD3dqTllorp+p
	xZqY7AIJG5NwxHKnYU8J08ef6vUPhj2WR8ScKSlLSK3C5EhYcmgL+XdUHrNWZCdtjbjYue
	XvbeQY4YfJyZAgyxKN93G3yUgF2qYZY=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 04 May 2026 21:32:24 +0200
Subject: [PATCH batadv-next] batman-adv: use neigh_node's orig_node only as
 id
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-neigh_node-no-orig_node-v1-1-33b282272711@narfation.org>
X-B4-Tracking: v=1; b=H4sIAEf0+GkC/z2O3WoDIRCFX2XxuoK6/uZVSiijjrsWoq2aEAh59
 5ik9GrmMPOdc26kY8vYyWG5kYaX3HMtU/CPhYQdyoY0x6mJYEIzxSQtmLf9q9SItFRaW97eAq0
 PBo2LzgOZ9E/DlK8v50/iYUC8TPY6yPF97Gf/jWE8vf/eG/6eZ/74ZzrSUE+nPGafpFIK2giu5
 2IVZ3oFlSKT0hthwAvFDeD6soIR9ln7sNjIuFMsIhfBJmm4QjeHWIF5nXhYpUMNVpLj/f4AdTx
 ruAoBAAA=
X-Change-ID: 20260504-neigh_node-no-orig_node-e8bc7e79d9ba
To: Marek Lindner <marek.lindner@mailbox.org>, 
 Simon Wunderlich <sw@simonwunderlich.de>, 
 Antonio Quartulli <antonio@mandelbit.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Yuan Tan <yuantan098@gmail.com>, Yifan Wu <yifanwucs@gmail.com>, 
 Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>, 
 Jiexun Wang <wangjiexun2025@gmail.com>, Ren Wei <n05ec@lzu.edu.cn>, 
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3264; i=sven@narfation.org;
 h=from:subject:message-id; bh=3baNab/PKWRzQWqmzSt6NT567cjaLxcNDE+ohCHOPMI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJk/vqQKdW2pLtYXVvDazcLzg2ei0Z4Xtv3zDXds/bPon
 wHjRoHQjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEjsxn+Ke6br9B2w8NmR+l
 5XHRf3YEfjwd8q04X6fJbdWjVWbXdyky/GYTDth5+Nfim0JBMgySbEneOzY/nsGXNfGDSE986rw
 Wa14A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-Rspamd-Queue-Id: 839CD4C347B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284029-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lzu.edu.cn,lists.open-mesh.org,vger.kernel.org,narfation.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[narfation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
---
 net/batman-adv/bat_v_ogm.c  |  2 +-
 net/batman-adv/originator.c |  5 ++++-
 net/batman-adv/types.h      | 11 +++++++++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index e3870492dab7..10614d7c1053 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -710,7 +710,7 @@ static bool batadv_v_ogm_route_update(struct batadv_priv *bat_priv,
 	 * don't route towards it
 	 */
 	router = batadv_orig_router_get(orig_node, if_outgoing);
-	if (router && router->orig_node != orig_node && !orig_neigh_router) {
+	if (router && ACCESS_PRIVATE(router, orig_node_id) != orig_node && !orig_neigh_router) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: OGM via unknown neighbor!\n");
 		goto out;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index b3468ccab535..97375eb4cd96 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -694,9 +694,12 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
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
index daa06f421154..ba46e414fe05 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -628,8 +628,15 @@ struct batadv_neigh_node {
 	/** @list: list node for &batadv_orig_node.neigh_list */
 	struct hlist_node list;
 
-	/** @orig_node: pointer to corresponding orig_node */
-	struct batadv_orig_node *orig_node;
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	/**
+	 * @orig_node_id: pointer to corresponding orig_node. It must only be used
+	 * to identify the node but must NEVER be dereferenced. The reference counter
+	 * was not increased when this was assigned because it would otherwise create
+	 * an reference cycle.
+	 */
+	struct batadv_orig_node *__private orig_node_id;
+#endif
 
 	/** @addr: the MAC address of the neighboring interface */
 	u8 addr[ETH_ALEN];

---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260504-neigh_node-no-orig_node-e8bc7e79d9ba
prerequisite-patch-id: 8d01950de12c8f4715e9f4723a0b6f1c349e6a84

Best regards,
--  
Sven Eckelmann <sven@narfation.org>


