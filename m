Return-Path: <netdev+bounces-190545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0941AB7771
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 22:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8697A11AC
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 20:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D770028FA89;
	Wed, 14 May 2025 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="K1/UoWGM"
X-Original-To: netdev@vger.kernel.org
Received: from mx04lb.world4you.com (mx04lb.world4you.com [81.19.149.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43218170A0B
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747256281; cv=none; b=j6Q7S6uI+ZnBwXCFm9PAy7CxDvla1ydysbYb3xXX/1jkLISD0KjPcfDfGpniUV6J8ykaciMDbRVIcKnq2IjOWpTFcCIZdgj2SvtJaUWMolQJE9o+PqVPXWQolSkIPaqZp6w9zdNvmrFP3RoHNhLska3FJZ01Os4DjhVUq7/2no4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747256281; c=relaxed/simple;
	bh=qLijJVgUZ/xYBQI+/bbJFwBfI82PebA03n7PfKODcRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V68dLp94SvlI8eTknOPnTou21/0p3D4S7E3+v3z/lHSaDS0p540fH9xWH/HAamOqvEOb+WH+yAt0u/zzFSqFGkK8cDwPRSSLsqP/E6LqbqQ0+h9skAKVmxa5FHmcmIwXPHc6RLlZ8BkOpnYmnWGIGxWq73kfH8LzRuYbd7bc+xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=K1/UoWGM; arc=none smtp.client-ip=81.19.149.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bEI4T8ulLS9F7I+rTx5RO94AV42+GmGJFlL1uhv6f64=; b=K1/UoWGMY9JAe9j3cm2P311XZR
	DrtIB3Jr1J06ZaC1va9RDzHunRTf2ixDlWfW/y5EPf/kTmGzuf4zkzwLwAjuJyBHVTb5I1Rltg1Du
	orAIdpmdQZp3viOy40qA3YtW+pL38VtTG2iKL5VI3mbBj+2X2jt11zOKZckRcAZvdiwc=;
Received: from [188.22.4.212] (helo=hornet.engleder.at)
	by mx04lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1uFIDz-0000000062N-496w;
	Wed, 14 May 2025 21:57:08 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH net v2] tsnep: fix timestamping with a stacked DSA driver
Date: Wed, 14 May 2025 21:56:57 +0200
Message-Id: <20250514195657.25874-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

This driver is susceptible to a form of the bug explained in commit
c26a2c2ddc01 ("gianfar: Fix TX timestamping with a stacked DSA driver")
and in Documentation/networking/timestamping.rst section "Other caveats
for MAC drivers", specifically it timestamps any skb which has
SKBTX_HW_TSTAMP, and does not consider if timestamping has been enabled
in adapter->hwtstamp_config.tx_type.

Evaluate the proper TX timestamping condition only once on the TX
path (in tsnep_xmit_frame_ring()) and store the result in an additional
TX entry flag. Evaluate the new TX entry flag in the TX confirmation path
(in tsnep_tx_poll()).

This way SKBTX_IN_PROGRESS is set by the driver as required, but never
evaluated. SKBTX_IN_PROGRESS shall not be evaluated as it can be set
by a stacked DSA driver and evaluating it would lead to unwanted
timestamps.

Fixes: 403f69bbdbad ("tsnep: Add TSN endpoint Ethernet MAC driver")
Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
v2:
- took over patch from Vladimir Oltean (thank you for your work, I hope
  the Suggested-by is ok for you, I was not sure about Co-developed-by)
- do TX timestamp check only in tsnep_xmit_frame_ring() and store result
  in TX entry flag
---
 drivers/net/ethernet/engleder/tsnep_main.c | 30 ++++++++++++++--------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 61a23413b577..48e08e550c57 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -74,6 +74,8 @@
 #define TSNEP_TX_TYPE_XDP_NDO_MAP_PAGE	(TSNEP_TX_TYPE_XDP_NDO | TSNEP_TX_TYPE_MAP_PAGE)
 #define TSNEP_TX_TYPE_XDP		(TSNEP_TX_TYPE_XDP_TX | TSNEP_TX_TYPE_XDP_NDO)
 #define TSNEP_TX_TYPE_XSK		BIT(12)
+#define TSNEP_TX_TYPE_TSTAMP		BIT(13)
+#define TSNEP_TX_TYPE_SKB_TSTAMP	(TSNEP_TX_TYPE_SKB | TSNEP_TX_TYPE_TSTAMP)
 
 #define TSNEP_XDP_TX		BIT(0)
 #define TSNEP_XDP_REDIRECT	BIT(1)
@@ -393,8 +395,7 @@ static void tsnep_tx_activate(struct tsnep_tx *tx, int index, int length,
 	if (entry->skb) {
 		entry->properties = length & TSNEP_DESC_LENGTH_MASK;
 		entry->properties |= TSNEP_DESC_INTERRUPT_FLAG;
-		if ((entry->type & TSNEP_TX_TYPE_SKB) &&
-		    (skb_shinfo(entry->skb)->tx_flags & SKBTX_IN_PROGRESS))
+		if ((entry->type & TSNEP_TX_TYPE_SKB_TSTAMP) == TSNEP_TX_TYPE_SKB_TSTAMP)
 			entry->properties |= TSNEP_DESC_EXTENDED_WRITEBACK_FLAG;
 
 		/* toggle user flag to prevent false acknowledge
@@ -486,7 +487,8 @@ static int tsnep_tx_map_frag(skb_frag_t *frag, struct tsnep_tx_entry *entry,
 	return mapped;
 }
 
-static int tsnep_tx_map(struct sk_buff *skb, struct tsnep_tx *tx, int count)
+static int tsnep_tx_map(struct sk_buff *skb, struct tsnep_tx *tx, int count,
+			bool do_tstamp)
 {
 	struct device *dmadev = tx->adapter->dmadev;
 	struct tsnep_tx_entry *entry;
@@ -512,6 +514,9 @@ static int tsnep_tx_map(struct sk_buff *skb, struct tsnep_tx *tx, int count)
 				entry->type = TSNEP_TX_TYPE_SKB_INLINE;
 				mapped = 0;
 			}
+
+			if (do_tstamp)
+				entry->type |= TSNEP_TX_TYPE_TSTAMP;
 		} else {
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i - 1];
 
@@ -565,11 +570,12 @@ static int tsnep_tx_unmap(struct tsnep_tx *tx, int index, int count)
 static netdev_tx_t tsnep_xmit_frame_ring(struct sk_buff *skb,
 					 struct tsnep_tx *tx)
 {
-	int count = 1;
 	struct tsnep_tx_entry *entry;
+	bool do_tstamp = false;
+	int count = 1;
 	int length;
-	int i;
 	int retval;
+	int i;
 
 	if (skb_shinfo(skb)->nr_frags > 0)
 		count += skb_shinfo(skb)->nr_frags;
@@ -586,7 +592,13 @@ static netdev_tx_t tsnep_xmit_frame_ring(struct sk_buff *skb,
 	entry = &tx->entry[tx->write];
 	entry->skb = skb;
 
-	retval = tsnep_tx_map(skb, tx, count);
+	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
+	    tx->adapter->hwtstamp_config.tx_type == HWTSTAMP_TX_ON) {
+		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+		do_tstamp = true;
+	}
+
+	retval = tsnep_tx_map(skb, tx, count, do_tstamp);
 	if (retval < 0) {
 		tsnep_tx_unmap(tx, tx->write, count);
 		dev_kfree_skb_any(entry->skb);
@@ -598,9 +610,6 @@ static netdev_tx_t tsnep_xmit_frame_ring(struct sk_buff *skb,
 	}
 	length = retval;
 
-	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
-		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-
 	for (i = 0; i < count; i++)
 		tsnep_tx_activate(tx, (tx->write + i) & TSNEP_RING_MASK, length,
 				  i == count - 1);
@@ -851,8 +860,7 @@ static bool tsnep_tx_poll(struct tsnep_tx *tx, int napi_budget)
 
 		length = tsnep_tx_unmap(tx, tx->read, count);
 
-		if ((entry->type & TSNEP_TX_TYPE_SKB) &&
-		    (skb_shinfo(entry->skb)->tx_flags & SKBTX_IN_PROGRESS) &&
+		if (((entry->type & TSNEP_TX_TYPE_SKB_TSTAMP) == TSNEP_TX_TYPE_SKB_TSTAMP) &&
 		    (__le32_to_cpu(entry->desc_wb->properties) &
 		     TSNEP_DESC_EXTENDED_WRITEBACK_FLAG)) {
 			struct skb_shared_hwtstamps hwtstamps;
-- 
2.39.5


