Return-Path: <netdev+bounces-135450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFD799DF88
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05201F23D66
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 07:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1225C1B85CC;
	Tue, 15 Oct 2024 07:45:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470E1AB508
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978344; cv=none; b=HGNIwOtXa8BPFVjSEYJzfYuYHBWM08ZIQeDsgmvRgQVGBXhBqro1tq7NkMOXg6rVAvSjbnIqv8D9Ru9Zr/e03Ky7tZu/0r09KdwAE8y+avrCrVCuc14OL4KULwLQ7fUuL5Ih97mnnrgwAV091M4gfsUA7amDAy8969d8fDHVjUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978344; c=relaxed/simple;
	bh=BiZPoHyXE3wK0PqOLoV1/coRhSpTMWVKREQHwYo7L9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DqCxFIAWzPfkUw6+rPWXFRxk204OiOWQ5RFEklWWKFQXyXvJ7mJWUVm6EJRWe2YnTxN5v/t9099rH5cW8XpkjW0zpJyjRN60LQtaD+TBhUuaJrYNfRkjDndci+umKDTGO9Hjr+p4V148+GLdOcr8jppv2tt9zf5CQJKdQdiDPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p5480b09e.dip0.t-ipconnect.de [84.128.176.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 1223CFAA31;
	Tue, 15 Oct 2024 09:39:50 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 3/4] batman-adv: Use string choice helper to print booleans
Date: Tue, 15 Oct 2024 09:39:45 +0200
Message-Id: <20241015073946.46613-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015073946.46613-1-sw@simonwunderlich.de>
References: <20241015073946.46613-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The commit ea4692c75e1c ("lib/string_helpers: Consolidate string helpers
implementation") introduced common helpers to print string representations
of boolean helpers. These are supposed to be used instead of open coded
versions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c            | 4 ++--
 net/batman-adv/bridge_loop_avoidance.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 74b49c35ddc1..07ae5dd1f150 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -36,6 +36,7 @@
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <net/genetlink.h>
@@ -371,8 +372,7 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 			   batadv_ogm_packet->orig,
 			   ntohl(batadv_ogm_packet->seqno),
 			   batadv_ogm_packet->tq, batadv_ogm_packet->ttl,
-			   ((batadv_ogm_packet->flags & BATADV_DIRECTLINK) ?
-			    "on" : "off"),
+			   str_on_off(batadv_ogm_packet->flags & BATADV_DIRECTLINK),
 			   hard_iface->net_dev->name,
 			   hard_iface->net_dev->dev_addr);
 
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 5f46ca3d4bb8..449faf5a5487 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -33,6 +33,7 @@
 #include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/workqueue.h>
 #include <net/arp.h>
 #include <net/genetlink.h>
@@ -1946,16 +1947,15 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	claim = batadv_claim_hash_find(bat_priv, &search_claim);
 
 	if (!claim) {
+		bool local = batadv_is_my_client(bat_priv, ethhdr->h_source, vid);
+
 		/* possible optimization: race for a claim */
 		/* No claim exists yet, claim it for us!
 		 */
 
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "%s(): Unclaimed MAC %pM found. Claim it. Local: %s\n",
-			   __func__, ethhdr->h_source,
-			   batadv_is_my_client(bat_priv,
-					       ethhdr->h_source, vid) ?
-			   "yes" : "no");
+			   __func__, ethhdr->h_source, str_yes_no(local));
 		batadv_handle_claim(bat_priv, primary_if,
 				    primary_if->net_dev->dev_addr,
 				    ethhdr->h_source, vid);
-- 
2.39.5


