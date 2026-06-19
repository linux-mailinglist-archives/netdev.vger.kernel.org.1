Return-Path: <netdev+bounces-300634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bgEkBmzrNGpxkAYAu9opvQ
	(envelope-from <netdev+bounces-300634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:10:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 653936A43F8
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:10:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=Gyx8VoFS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300634-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300634-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72F1F301FF20
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57A3352C2C;
	Fri, 19 Jun 2026 07:10:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965B33ADA8
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 07:10:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853032; cv=none; b=H8zD/5CVXFmN50+0/J1I+6alwYf+U3MneLwIS+M6GPAsnz/pnIMcuBsFt/B5/H6M1FfiWG7po5vGN/xV3X0gSjlVtuf/RYMNQhvfPpsSE5LY/VotSQZzP1LvsYuzxj+qp4iYsF+WQE2LzpQpoOnqZIf1q8A58vkY/FczrsAihwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853032; c=relaxed/simple;
	bh=oNM7e/exOP51kma8X00b1dG2eRJClOHuDA9nTaA8nmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUScaolpOh/JX5rxyxCT2bjmffgx1jHx01ouNsWLmoWJD/hPVjIBQHVbcDnQuRHmi/AQfj+KkSFjsFqKMAGd+mMe/PNP0WWwFsKoBcCC7ee/77hCCLCS4QKfgQSdaTQpXYbhfYTmeSO/PNK2Ukq68P/p9m2AF3v2Lcy2IoC8uuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=Gyx8VoFS; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=df0sc9RvZxEMHTxHbnI9oNmIsDOa2OH9rHZyYmPP0HE=;
	b=Gyx8VoFSJgR/rJAu3SHlSg43O/brt5+15CKcdS6vmgbPzcULKmnMC0IwPNScH7tOLSzUxh
	He6s+ovORHfMWoWBwKgoD+kOtR3EZzSQIbc7bl3bBMtDa8S8TX/BY0mvQEFeYxz3T2p7VE
	5TcGjPATjiKNyR6sMpB1Db97MWnEBsiFb1IRJ44g+lbzqmPnazSU1a3zFYeMiiUwZjcbmY
	bqaMJGhJmcXIQ7XsgP9uy0vf55gAZFl1D4PkJtIHckzl+9Gekm6GoA5Xgo+tmwPTOgWbPS
	MIkW8HhalYaI6F1BkplLBErp9EFxBYLgpgOAcjbz617vYW3TgkXEA+9BxQWxkQ==
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
Subject: [PATCH net 04/15] batman-adv: frag: ensure fragment is writable before modifying TTL
Date: Fri, 19 Jun 2026 09:00:34 +0200
Message-ID: <20260619070045.438101-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619070045.438101-1-sw@simonwunderlich.de>
References: <20260619070045.438101-1-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300634-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:stable@kernel.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,simonwunderlich.de:dkim,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,narfation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 653936A43F8

From: Sven Eckelmann <sven@narfation.org>

Before batman-adv is allowed to write to an skb, it either has to have its
own copy of the skb or use skb_cow() to ensure that the data part is not
shared. But batadv_frag_skb_fwd() modifies the TTL even when it is shared.

Adding a skb_cow() right before this operation avoids this and can at the
same time prepare it for the modifications required to forward the
fragment.

Cc: stable@kernel.org
Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/fragmentation.c | 15 ++++++++++++++-
 net/batman-adv/fragmentation.h |  3 ++-
 net/batman-adv/routing.c       |  3 +--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 1e42cf99f8b33..f311a42203d2e 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -386,6 +386,8 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
  * @skb: skb to forward
  * @recv_if: interface that the skb is received on
  * @orig_node_src: originator that the skb is received from
+ * @rx_result: set to NET_RX_SUCCESS when the fragment was forwarded and
+ *  NET_RX_DROP when it was dropped; only valid when true is returned
  *
  * Look up the next-hop of the fragments payload and check if the merged packet
  * will exceed the MTU towards the next-hop. If so, the fragment is forwarded
@@ -395,7 +397,8 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
  */
 bool batadv_frag_skb_fwd(struct sk_buff *skb,
 			 struct batadv_hard_iface *recv_if,
-			 struct batadv_orig_node *orig_node_src)
+			 struct batadv_orig_node *orig_node_src,
+			 int *rx_result)
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_neigh_node *neigh_node = NULL;
@@ -414,12 +417,22 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 	 */
 	total_size = ntohs(packet->total_size);
 	if (total_size > neigh_node->if_incoming->net_dev->mtu) {
+		if (skb_cow(skb, ETH_HLEN) < 0) {
+			kfree_skb(skb);
+			*rx_result = NET_RX_DROP;
+			ret = true;
+			goto out;
+		}
+
+		packet = (struct batadv_frag_packet *)skb->data;
+
 		batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_FWD);
 		batadv_add_counter(bat_priv, BATADV_CNT_FRAG_FWD_BYTES,
 				   skb->len + ETH_HLEN);
 
 		packet->ttl--;
 		batadv_send_unicast_skb(skb, neigh_node);
+		*rx_result = NET_RX_SUCCESS;
 		ret = true;
 	}
 
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index dbf0871f87030..51e281027ab63 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -19,7 +19,8 @@ void batadv_frag_purge_orig(struct batadv_orig_node *orig,
 			    bool (*check_cb)(struct batadv_frag_table_entry *));
 bool batadv_frag_skb_fwd(struct sk_buff *skb,
 			 struct batadv_hard_iface *recv_if,
-			 struct batadv_orig_node *orig_node_src);
+			 struct batadv_orig_node *orig_node_src,
+			 int *rx_result);
 bool batadv_frag_skb_buffer(struct sk_buff **skb,
 			    struct batadv_orig_node *orig_node);
 int batadv_frag_send_packet(struct sk_buff *skb,
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 8786b66c8a924..9db57fd36e7d4 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1168,10 +1168,9 @@ int batadv_recv_frag_packet(struct sk_buff *skb,
 
 	/* Route the fragment if it is not for us and too big to be merged. */
 	if (!batadv_is_my_mac(bat_priv, frag_packet->dest) &&
-	    batadv_frag_skb_fwd(skb, recv_if, orig_node_src)) {
+	    batadv_frag_skb_fwd(skb, recv_if, orig_node_src, &ret)) {
 		/* skb was consumed */
 		skb = NULL;
-		ret = NET_RX_SUCCESS;
 		goto put_orig_node;
 	}
 
-- 
2.47.3


