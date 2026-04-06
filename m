Return-Path: <netdev+bounces-275578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEj/FtGd02nGjgcAu9opvQ
	(envelope-from <netdev+bounces-275578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 13:49:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0AD3A324D
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 13:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 620F4300F188
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 11:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E59332EDE;
	Mon,  6 Apr 2026 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="r1D49UlB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BxwvLeEe"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F801332ED0;
	Mon,  6 Apr 2026 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775476172; cv=none; b=d6aDvW8zY7rdXKh6H4Jkmi/W0U3ppIQ003RwdOJEtif4UoKr2gh0y5KeQIybWbRD4d5FLjZbMf5a3ES4QvdKpBUfBoRLG0dpWEQUw1OYlRyh7766WwPJ++LjBjTrG32DePM35B6T6F2jUtYnXIZNopSm93amFAY4fWS0iZAA2DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775476172; c=relaxed/simple;
	bh=ElTI4ch/q1PK6KaWKqQdkphlnnXPnWeo5BIRo5tQ/z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrFsDyAhgpAfdctDTGjoR5R2HXKzSTfcNi7z3g5oNv2e6Qm46IAcKmVtQrn6+lXHSlI48LjvNJp1bqhGgZL5hx3Rqi/+WEXkb4By+Dayy+Ijm9y4zFQwLxklw9RAFEfFDQtG7Upj/aTJp4IZ4bIuOnKFvh38yX1CsLgJm2Pg8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=r1D49UlB; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BxwvLeEe; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4fq70L5GxFzB1J0;
	Mon,  6 Apr 2026 13:49:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775476162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lviZr5OB/1BdIsAZAshFDCsCNodIEVkbyY4ofYDvk3o=;
	b=r1D49UlBIEciX23eXKofB5bDknk2ewFx354ZgKZUN+zVHx80Ub6BH9VYG53Vif9JsftWKQ
	nWLFZB/QYUrc5uOVPnV3wXCW+zuaR/hjXlTWODEicGpHHgbzGQYdIh2bBN0gycHUVs6hbc
	Cn6ErOKdUUj3OiyydasXBmVL6w0ZAmyMsSMoJCDNlcdXhlcbLgrx5lUjvnSAmskt1esMZW
	aGesd34LFJ/YLL7ypIYfg8D1hIza5sLNPBqJMjZ6TzhNjc7LFtKvEMShPg5AgAukGNWULJ
	MgGkT7h4oExdN0sEbN6f55uT/gqmiv7mJGa/YQRCIz8xo/jO0QO0IxOMjLqAtg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=BxwvLeEe;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775476161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lviZr5OB/1BdIsAZAshFDCsCNodIEVkbyY4ofYDvk3o=;
	b=BxwvLeEe7uGCEmPqca+EYa6Qg890jmTQ4BMs93pMguhwRT8UbWbjFg1nodHE8fcVuUV+OI
	cEXKJfYdrG5jXNtT3GEcywY1usTFA+mPERDOBVOkVgjZAnoysQHZ4i4SCxr7K1IykxALXc
	kxzXqrekSsV6oQPqNwyqkUxs3k0I20zWCZIKalkFqSj2xjUq1Aw53vPlHpZBoIR2bA2y1c
	MLHxxEXqOHsrFFmaK+UVisdHDKU2uFkZYu4XEHFMVTiWinAGM1wXvB7BnKtjZSEnQjDuPx
	6qJ5AeebFafo3T+IIxvp+4nac3uW5nZW8JZWqkj5Dp5WDcrEgH+1Afha70/ZDQ==
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+6eb7834837cf6a8db75b@syzkaller.appspotmail.com,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH net v2] net: netrom: fix lock order inversion in nr_add_node, nr_del_node and nr_dec_obs
Date: Mon,  6 Apr 2026 19:49:04 +0800
Message-ID: <20260406114904.89088-1-mashiro.chen@mailbox.org>
In-Reply-To: <20260406110643.82577-1-mashiro.chen@mailbox.org>
References: <20260406110643.82577-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3i94t3xm3f8pj6gst8r1ke5dzqqc3rkm
X-MBO-RS-ID: 8d1fc563d922d8c983b
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275578-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,6eb7834837cf6a8db75b];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: CC0AD3A324D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nr_del_node() and nr_dec_obs() acquire nr_node_list_lock first, then
call nr_remove_neigh() which internally acquires nr_neigh_list_lock.
nr_add_node() acquires node_lock first, then calls nr_remove_neigh()
which acquires nr_neigh_list_lock.

Both are the reverse of the lock order used in nr_rt_device_down() and
nr_rt_free(), which acquire nr_neigh_list_lock before nr_node_list_lock
and node_lock.

The resulting lock order inversions can cause an ABBA deadlock when
concurrently executing:
  - SIOCDELRT or SIOCNRDECOBS ioctl (requires CAP_NET_ADMIN)
  - bringing down a NET/ROM-attached network device

Fix by acquiring nr_neigh_list_lock before nr_node_list_lock and
node_lock in all three functions, following the canonical lock order,
and replacing the internal-locking nr_remove_neigh() with
nr_remove_neigh_locked() which assumes the caller already holds
nr_neigh_list_lock.

Fixes: e03e7f20ebf7 ("netrom: fix possible dead-lock in nr_rt_ioctl()")
Reported-by: syzbot+6eb7834837cf6a8db75b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6eb7834837cf6a8db75b
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
Changes in v2:
  - Move __nr_remove_neigh() and nr_remove_neigh_locked() macro definition
    before nr_add_node() to fix implicit function declaration build error

 net/netrom/nr_route.c | 45 ++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 9cc29ae85b06f..c3cceee5a2284 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -75,7 +75,21 @@ static struct nr_neigh *nr_neigh_get_dev(ax25_address *callsign,
 	return found;
 }
 
-static void nr_remove_neigh(struct nr_neigh *);
+static inline void __nr_remove_neigh(struct nr_neigh *nr_neigh)
+{
+	hlist_del_init(&nr_neigh->neigh_node);
+	nr_neigh_put(nr_neigh);
+}
+
+#define nr_remove_neigh_locked(__neigh) \
+	__nr_remove_neigh(__neigh)
+
+static void nr_remove_neigh(struct nr_neigh *nr_neigh)
+{
+	spin_lock_bh(&nr_neigh_list_lock);
+	__nr_remove_neigh(nr_neigh);
+	spin_unlock_bh(&nr_neigh_list_lock);
+}
 
 /*      re-sort the routes in quality order.    */
 static void re_sort_routes(struct nr_node *nr_node, int x, int y)
@@ -211,6 +225,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		nr_neigh_put(nr_neigh);
 		return 0;
 	}
+	spin_lock_bh(&nr_neigh_list_lock);
 	nr_node_lock(nr_node);
 
 	if (quality != 0)
@@ -246,7 +261,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 				nr_neigh_put(nr_node->routes[2].neighbour);
 
 				if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)
-					nr_remove_neigh(nr_node->routes[2].neighbour);
+					nr_remove_neigh_locked(nr_node->routes[2].neighbour);
 
 				nr_node->routes[2].quality   = quality;
 				nr_node->routes[2].obs_count = obs_count;
@@ -281,6 +296,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 
 	nr_neigh_put(nr_neigh);
 	nr_node_unlock(nr_node);
+	spin_unlock_bh(&nr_neigh_list_lock);
 	nr_node_put(nr_node);
 	return 0;
 }
@@ -293,22 +309,6 @@ static void nr_remove_node_locked(struct nr_node *nr_node)
 	nr_node_put(nr_node);
 }
 
-static inline void __nr_remove_neigh(struct nr_neigh *nr_neigh)
-{
-	hlist_del_init(&nr_neigh->neigh_node);
-	nr_neigh_put(nr_neigh);
-}
-
-#define nr_remove_neigh_locked(__neigh) \
-	__nr_remove_neigh(__neigh)
-
-static void nr_remove_neigh(struct nr_neigh *nr_neigh)
-{
-	spin_lock_bh(&nr_neigh_list_lock);
-	__nr_remove_neigh(nr_neigh);
-	spin_unlock_bh(&nr_neigh_list_lock);
-}
-
 /*
  *	"Delete" a node. Strictly speaking remove a route to a node. The node
  *	is only deleted if no routes are left to it.
@@ -331,6 +331,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 		return -EINVAL;
 	}
 
+	spin_lock_bh(&nr_neigh_list_lock);
 	spin_lock_bh(&nr_node_list_lock);
 	nr_node_lock(nr_node);
 	for (i = 0; i < nr_node->count; i++) {
@@ -339,7 +340,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 			nr_neigh_put(nr_neigh);
 
 			if (nr_neigh->count == 0 && !nr_neigh->locked)
-				nr_remove_neigh(nr_neigh);
+				nr_remove_neigh_locked(nr_neigh);
 			nr_neigh_put(nr_neigh);
 
 			nr_node->count--;
@@ -361,6 +362,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 			}
 			nr_node_unlock(nr_node);
 			spin_unlock_bh(&nr_node_list_lock);
+			spin_unlock_bh(&nr_neigh_list_lock);
 
 			return 0;
 		}
@@ -368,6 +370,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 	nr_neigh_put(nr_neigh);
 	nr_node_unlock(nr_node);
 	spin_unlock_bh(&nr_node_list_lock);
+	spin_unlock_bh(&nr_neigh_list_lock);
 	nr_node_put(nr_node);
 
 	return -EINVAL;
@@ -454,6 +457,7 @@ static int nr_dec_obs(void)
 	struct hlist_node *nodet;
 	int i;
 
+	spin_lock_bh(&nr_neigh_list_lock);
 	spin_lock_bh(&nr_node_list_lock);
 	nr_node_for_each_safe(s, nodet, &nr_node_list) {
 		nr_node_lock(s);
@@ -469,7 +473,7 @@ static int nr_dec_obs(void)
 				nr_neigh_put(nr_neigh);
 
 				if (nr_neigh->count == 0 && !nr_neigh->locked)
-					nr_remove_neigh(nr_neigh);
+					nr_remove_neigh_locked(nr_neigh);
 
 				s->count--;
 
@@ -497,6 +501,7 @@ static int nr_dec_obs(void)
 		nr_node_unlock(s);
 	}
 	spin_unlock_bh(&nr_node_list_lock);
+	spin_unlock_bh(&nr_neigh_list_lock);
 
 	return 0;
 }
-- 
2.53.0


