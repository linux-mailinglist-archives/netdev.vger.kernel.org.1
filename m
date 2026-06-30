Return-Path: <netdev+bounces-303219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x1ciMP/NQ2rGigoAu9opvQ
	(envelope-from <netdev+bounces-303219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:09:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3FE6E53D4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:09:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=LjsgBsea;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303219-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303219-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DE3F301E479
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B4E4192FF;
	Tue, 30 Jun 2026 14:06:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B233769E5
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:06:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828393; cv=none; b=DrhZITpwn2PG7OpjNuKqH4kWfxeRoSoZ+3gMbTZlLvZywff2EYz3B4LWfbTWrHIltN3rOeG3W/m3we89wz2iL5S0X8mJbCUCQHPqYrLEKCg6bc9lEOjRxt8j9buDGcFLGO2b5LIYwumel96xQzQwxXTX8tccxrIcS/uswUawupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828393; c=relaxed/simple;
	bh=OmZX6yx8NPd26VlowHHyej8ZGh/0fqhk3PpD7eYlpoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKMJK/8L5fQSgJwGbAT5eU6R/KeY6WA5fUyne8XiLl2mbfGaUctmFKFbZ+vGyp373U2DIroEisDTl7gUzaCLAgGQLDzcpnqeIqQU1rMf8ZRO54SMD1wLoK62jpuPEkisKxUhSifS3HtHEoUKgpm6osEdCLEoHDv2Yu/OSvqj1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=LjsgBsea; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ompe1pyONMmJSv377DN++kdxEJ80NzbZMnVOLnyDunI=;
	b=LjsgBseaJa0lSHWvrZ7+xqdpznFIbHtNUZqml6xXuSZzqb5YMrhFeDBIGCx1kvwtGViGAd
	o1mmXgIxvocczUsHJI/oIgIaTcMxRilT8ZV18EF0Fp8EJ65OpEOkeqMQRNmC2fa02xTZAD
	6xFAIJZ3GLTu7vSUBr3qvIB5X2xHU4VUBb4Z0sGPnSlMRETkI+8kPBfh2p+DbibEHd5Wnh
	1IPbW1GzAfCdHoVWMLqwIgXkTZSnAH7pyAFESdwdjB2egh41BSB9uY0onjo7HamnkbIP0L
	54yHuaGCWqP/0r2wqfO1IY3H3K6Y4BIfIQdxc8qp/hvIVqhrqDubusp4h0vUWw==
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
Subject: [PATCH net-next 07/15] batman-adv: drop NULL check for immutable hardif->mesh_iface
Date: Tue, 30 Jun 2026 16:06:15 +0200
Message-ID: <20260630140623.88431-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630140623.88431-1-sw@simonwunderlich.de>
References: <20260630140623.88431-1-sw@simonwunderlich.de>
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
	TAGGED_FROM(0.00)[bounces-303219-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,simonwunderlich.de:dkim,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA3FE6E53D4

From: Sven Eckelmann <sven@narfation.org>

The batadv_hard_iface->mesh_iface became immutable after the global
batadv_hardif_list was removed and batadv_hard_iface only exists when it is
assigned to an mesh_iface. This member can never become NULL and thus a
check is now unnecessary.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_elp.c             | 6 ------
 net/batman-adv/bridge_loop_avoidance.c | 9 ++-------
 net/batman-adv/hard-interface.c        | 8 ++------
 net/batman-adv/main.c                  | 3 ---
 4 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index bc3e4f264afa1..262e40040007c 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -90,12 +90,6 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 	u32 throughput;
 	int ret;
 
-	/* don't query throughput when no longer associated with any
-	 * batman-adv interface
-	 */
-	if (!mesh_iface)
-		return false;
-
 	/* if the user specified a customised value for this interface, then
 	 * return it directly
 	 */
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 5c73f6ba16cff..f9a1fadf8de9e 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -344,7 +344,6 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, const u8 *mac,
 	struct sk_buff *skb;
 	struct ethhdr *ethhdr;
 	struct batadv_hard_iface *primary_if;
-	struct net_device *mesh_iface;
 	u8 *hw_src;
 	struct batadv_bla_claim_dst local_claim_dest;
 	__be32 zeroip = 0;
@@ -357,14 +356,10 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, const u8 *mac,
 	       sizeof(local_claim_dest));
 	local_claim_dest.type = claimtype;
 
-	mesh_iface = READ_ONCE(primary_if->mesh_iface);
-	if (!mesh_iface)
-		goto out;
-
 	skb = arp_create(ARPOP_REPLY, ETH_P_ARP,
 			 /* IP DST: 0.0.0.0 */
 			 zeroip,
-			 mesh_iface,
+			 primary_if->mesh_iface,
 			 /* IP SRC: 0.0.0.0 */
 			 zeroip,
 			 /* Ethernet DST: Broadcast */
@@ -442,7 +437,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, const u8 *mac,
 	}
 
 	skb_reset_mac_header(skb);
-	skb->protocol = eth_type_trans(skb, mesh_iface);
+	skb->protocol = eth_type_trans(skb, primary_if->mesh_iface);
 	batadv_inc_counter(bat_priv, BATADV_CNT_RX);
 	batadv_add_counter(bat_priv, BATADV_CNT_RX_BYTES,
 			   skb->len + ETH_HLEN);
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 6fc49ad47fd87..b6867576bbafa 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -246,7 +246,7 @@ struct net_device *__batadv_get_real_netdev(struct net_device *netdev)
 	}
 
 	hard_iface = batadv_hardif_get_by_netdev(netdev);
-	if (!hard_iface || !hard_iface->mesh_iface)
+	if (!hard_iface)
 		goto out;
 
 	net = dev_net(hard_iface->mesh_iface);
@@ -540,9 +540,6 @@ static void batadv_check_known_mac_addr(const struct batadv_hard_iface *hard_ifa
 	const struct batadv_hard_iface *tmp_hard_iface;
 	struct list_head *iter;
 
-	if (!mesh_iface)
-		return;
-
 	netdev_for_each_lower_private(mesh_iface, tmp_hard_iface, iter) {
 		if (tmp_hard_iface == hard_iface)
 			continue;
@@ -1053,8 +1050,7 @@ static int batadv_hard_if_event(struct notifier_block *this,
 		batadv_hardif_disable_interface(hard_iface);
 		break;
 	case NETDEV_CHANGEMTU:
-		if (hard_iface->mesh_iface)
-			batadv_update_min_mtu(hard_iface->mesh_iface);
+		batadv_update_min_mtu(hard_iface->mesh_iface);
 		break;
 	case NETDEV_CHANGEADDR:
 		batadv_check_known_mac_addr(hard_iface);
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index badc1df0af1d5..04bb030ef299a 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -444,9 +444,6 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (unlikely(skb->mac_len != ETH_HLEN || !skb_mac_header(skb)))
 		goto err_free;
 
-	if (!hard_iface->mesh_iface)
-		goto err_free;
-
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
 	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
-- 
2.47.3


