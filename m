Return-Path: <netdev+bounces-303220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id prkwMEvPQ2qgiwoAu9opvQ
	(envelope-from <netdev+bounces-303220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:14:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FD46E54A8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:14:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=SKTFjl3M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303220-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303220-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AE643198F9F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47963423149;
	Tue, 30 Jun 2026 14:06:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B93A4F26
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:06:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828394; cv=none; b=Nvzc2ZJEhkGKrq5/Lcx/hIBCwJAvl842YXSAmNldil71/MLr8mQOEw0A+pfBaV1qTDU9fwbpqSvDH3dsiZUbhqGYyiIUCZr47ffXrWEj3rUg1Ch2xg/eP65I9oitytgNrMIN21JHYvMupQfTQXi7siMEQvaQZnxwATfI29opGyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828394; c=relaxed/simple;
	bh=jNJzsrcuS0HonsQF7PWkD67VLe9kDn/3q2WEgYfd4c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzZHvtaLZwj29xQoG1qRzGXVMl7LK7VfYt0Q8sl9TXJAJ5ki4je2xxZ7Dk0oyCnrBM9LFCt4+VKAfEoTofrAn0b2h2VA+Wk33Hu9tOxG5mbozZR0vVct5UnlR02LiiBkf2meIT2kC85RMurBWpb7Quse/fzC+vlm+xWZgpFNj6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=SKTFjl3M; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnvUe6Opebjp4crldOSLq+segpIbxB7KcINVcKbi988=;
	b=SKTFjl3Ms0ChEgAsHn86Nb4VmGcqFWSfGsZpfpZLpAJ/a/nYvVLsVXE6t23xaWtIkEwAtY
	RhaVAtHJi1fGAaFxcTROeddqeTe9mUZFxEEkteKtBlDNhcqcDtMG5L9Z8+jBqKhgvMKczL
	OkGuSwC4IM69z9xYNzQ4qNdwdHQTz49LsZITaFKBL+aUlOfD74aNY/p6jURZ+CIBgnE1V8
	0arhCbEtpFenn/9i+uw3c5q3mIlP+jFm4ro/nzp9BLor0PIlxUBlasOWE2rOtS+neMWH6H
	usEx6/uhB1GvT1lPXmdSYlPpa09YaZKkSm5dqZ38KHR85N6Gn2WxkHbJmv/Oig==
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
Subject: [PATCH net-next 08/15] Revert "batman-adv: v: stop OGMv2 on disabled interface"
Date: Tue, 30 Jun 2026 16:06:16 +0200
Message-ID: <20260630140623.88431-9-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303220-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,narfation.org:email,simonwunderlich.de:dkim,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,aggr_wq.work:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19FD46E54A8

From: Sven Eckelmann <sven@narfation.org>

With the immutability guarantee of batadv_hard_iface->mesh_iface, the check
for "changed" (or NULL) mesh_iface doesn't work anymore and is also no
longer necessary. The extra (complicated) code for the sending of OGMv2s
can therefore be removed and the original code can be used again.

This reverts commit f8ce8b8331a1bc44ad4905886a482214d428b253.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_ogm.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 037921aad35d5..e921d49f7eced 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -115,14 +115,14 @@ static void batadv_v_ogm_start_timer(struct batadv_priv *bat_priv)
 
 /**
  * batadv_v_ogm_send_to_if() - send a batman ogm using a given interface
- * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the OGM to send
  * @hard_iface: the interface to use to send the OGM
  */
-static void batadv_v_ogm_send_to_if(struct batadv_priv *bat_priv,
-				    struct sk_buff *skb,
+static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
 				    struct batadv_hard_iface *hard_iface)
 {
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
+
 	if (hard_iface->if_status != BATADV_IF_ACTIVE) {
 		kfree_skb(skb);
 		return;
@@ -189,7 +189,6 @@ static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_iface)
 
 /**
  * batadv_v_ogm_aggr_send() - flush & send aggregation queue
- * @bat_priv: the bat priv with all the mesh interface information
  * @hard_iface: the interface with the aggregation queue to flush
  *
  * Aggregates all OGMv2 packets currently in the aggregation queue into a
@@ -199,8 +198,7 @@ static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_iface)
  *
  * Caller needs to hold the hard_iface->bat_v.aggr_list.lock.
  */
-static void batadv_v_ogm_aggr_send(struct batadv_priv *bat_priv,
-				   struct batadv_hard_iface *hard_iface)
+static void batadv_v_ogm_aggr_send(struct batadv_hard_iface *hard_iface)
 {
 	unsigned int aggr_len = hard_iface->bat_v.aggr_len;
 	struct sk_buff *skb_aggr;
@@ -230,26 +228,21 @@ static void batadv_v_ogm_aggr_send(struct batadv_priv *bat_priv,
 		consume_skb(skb);
 	}
 
-	batadv_v_ogm_send_to_if(bat_priv, skb_aggr, hard_iface);
+	batadv_v_ogm_send_to_if(skb_aggr, hard_iface);
 }
 
 /**
  * batadv_v_ogm_queue_on_if() - queue a batman ogm on a given interface
- * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the OGM to queue
  * @hard_iface: the interface to queue the OGM on
  */
-static void batadv_v_ogm_queue_on_if(struct batadv_priv *bat_priv,
-				     struct sk_buff *skb,
+static void batadv_v_ogm_queue_on_if(struct sk_buff *skb,
 				     struct batadv_hard_iface *hard_iface)
 {
-	if (hard_iface->mesh_iface != bat_priv->mesh_iface) {
-		kfree_skb(skb);
-		return;
-	}
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 
 	if (!READ_ONCE(bat_priv->aggregated_ogms)) {
-		batadv_v_ogm_send_to_if(bat_priv, skb, hard_iface);
+		batadv_v_ogm_send_to_if(skb, hard_iface);
 		return;
 	}
 
@@ -260,7 +253,7 @@ static void batadv_v_ogm_queue_on_if(struct batadv_priv *bat_priv,
 	}
 
 	if (!batadv_v_ogm_queue_left(skb, hard_iface))
-		batadv_v_ogm_aggr_send(bat_priv, hard_iface);
+		batadv_v_ogm_aggr_send(hard_iface);
 
 	hard_iface->bat_v.aggr_len += batadv_v_ogm_len(skb);
 	__skb_queue_tail(&hard_iface->bat_v.aggr_list, skb);
@@ -357,7 +350,7 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 			break;
 		}
 
-		batadv_v_ogm_queue_on_if(bat_priv, skb_tmp, hard_iface);
+		batadv_v_ogm_queue_on_if(skb_tmp, hard_iface);
 		batadv_hardif_put(hard_iface);
 	}
 	rcu_read_unlock();
@@ -397,14 +390,12 @@ void batadv_v_ogm_aggr_work(struct work_struct *work)
 {
 	struct batadv_hard_iface_bat_v *batv;
 	struct batadv_hard_iface *hard_iface;
-	struct batadv_priv *bat_priv;
 
 	batv = container_of(work, struct batadv_hard_iface_bat_v, aggr_wq.work);
 	hard_iface = container_of(batv, struct batadv_hard_iface, bat_v);
-	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
-	batadv_v_ogm_aggr_send(bat_priv, hard_iface);
+	batadv_v_ogm_aggr_send(hard_iface);
 	spin_unlock_bh(&hard_iface->bat_v.aggr_list.lock);
 
 	batadv_v_ogm_start_queue_timer(hard_iface);
@@ -601,7 +592,7 @@ static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
 		   if_outgoing->net_dev->name, ntohl(ogm_forward->throughput),
 		   ogm_forward->ttl, if_incoming->net_dev->name);
 
-	batadv_v_ogm_queue_on_if(bat_priv, skb, if_outgoing);
+	batadv_v_ogm_queue_on_if(skb, if_outgoing);
 
 out:
 	batadv_orig_ifinfo_put(orig_ifinfo);
-- 
2.47.3


