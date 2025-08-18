Return-Path: <netdev+bounces-214736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC90B2B1FC
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 21:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECD9526004
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 19:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB2274FF5;
	Mon, 18 Aug 2025 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBvM7LIb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE66274B59
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755547179; cv=none; b=RjFrUem5TgUQWD6ywJMoBKlzXt1xw4EAuVYdxg/RgVzWBmHKdHa85SoFWIEz/aFoIYwgc+Ms5vYD+rtCaW3fL5slNyOjeYP/R6T2dmXOTbyLTDVUmj/YViyaW6R8iHcsSOw3LQzvk09+jV2fK/iHflKzttPkI+uZWy81j3c9zIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755547179; c=relaxed/simple;
	bh=t2sJaIWS/MNGvjBE/e4gtlvZz/mz/HS3d9TTkZ4uj1A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r7wsNWdrEa3/6RJDwVqE7/bZ5wnEwRXPf8W9Ae5brAZeh3iKy7EQunHEwlkQ5r+AUlL3B7K45lBWbQWknSj1k1dPFfN9UE8tUVggRgZ1dAUky7b09e9oL+R3vFcDT12fv7PCbgGdEmW3RDCh4j8SeEksiA7cZyikawoXggdFvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iBvM7LIb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-71e6dd71698so45027617b3.2
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755547176; x=1756151976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O5dlT7rxNwsu1t8gPXC6lzblDyyazDMxVm0LmENvSLM=;
        b=iBvM7LIbHWPtpvHJ1y39yg0e7s8lwfc6KotNJohw7PbDru9c/014OxgRWDx9II5faO
         CK6l8aJffTw9y4gMOWTw5BVLe+1PhXLr9f01wPhXmh9MGZkvg/bQMbIy4TmD3HroJfjd
         ZxckLrllbeKoqFhzso1Ack5syb/4q00fbmQQwftOLhDfFJsuG28lLHnjzyBA+k02vioK
         VjfnRJysWxeMe8qQADxC0gVVdDT3t8ziyxeDFhDVpEJaYcYVnMnzTs0DRm3m/ehbAYAk
         zpZ0plclSrIeEFWP+dRfqr7fFJHNzVgjniEpkrI9X1BueKzkmp5kODA1GCtTltzLDHax
         v2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755547176; x=1756151976;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5dlT7rxNwsu1t8gPXC6lzblDyyazDMxVm0LmENvSLM=;
        b=s24b4hJt0jd7MQ1kudOBJZoPW2HCbtc0w4IaDx2TxNTjntn37ret6sGcv2i8RURaHG
         gkb2RY0PewaUYyt+b8sE4K8NHGv5T0SuqE060gPOhnYRjn8WfEQGIRW+YdlzjQA+IntV
         zcTEvVk9oZLz7kPa2eMToazI9UO18F2dHq2WcB3ddxA1XOYxca4WafxZ0DNFlK7d2kwl
         jT5qQ4HRsycbpYteI7Wg3bf8vWTLn6OvLPVvVnDJsU70FPqagwtj5TceZxeSQKTuMEkz
         bXlue1Tu+fNoqWUU8VUF7OdE0eLR3CpKheEaTtJ+JE76BzIZgdFbsmtaLoPd4LbJwbRl
         z5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz0JEUe1ukIVqr76IE4mb7woic9LILDz5WpklMvOxTkw++KZ+JQbfyyc92O4/Rlx3pCeQPXBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAr0f81ec/4p76lDrDV16DVqKn/+XOvcetBlRSfTliEF3N5nB2
	76ltWsrgtKqPKDhRDep2ikNeeakBOC4erZzUOyoovRYHxraRzz8MHMYv6tN8mLIq516isgK39hJ
	zIK881NemK3el3g==
X-Google-Smtp-Source: AGHT+IH7bpaLpFufwXvN2n6J59bY3RJtyK3rG4TBWQqgXaon9kTdv5n7i+tkCjB8EWDKic6Jv0y6vU+LaqFu3g==
X-Received: from ywbjg17.prod.google.com ([2002:a05:690c:7091:b0:71c:120f:90f4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6911:b0:719:f77b:9395 with SMTP id 00721157ae682-71f9d4cfac6mr549067b3.1.1755547176423;
 Mon, 18 Aug 2025 12:59:36 -0700 (PDT)
Date: Mon, 18 Aug 2025 19:59:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818195934.757936-1-edumazet@google.com>
Subject: [PATCH net-next] idpf: do not linearize big TSO packets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Madhu Chittim <madhu.chittim@intel.com>, Pavan Kumar Linga <pavan.kumar.linga@intel.com>, 
	Joshua Hay <joshua.a.hay@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Willem de Bruijn <willemb@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"

idpf has a limit on number of scatter-gather frags
that can be used per segment.

Currently, idpf_tx_start() checks if the limit is hit
and forces a linearization of the whole packet.

This requires high order allocations that can fail
under memory pressure. A full size BIG-TCP packet
would require order-7 alocation on x86_64 :/

We can move the check earlier from idpf_features_check()
for TSO packets, to force GSO in this case, removing the
cost of a big copy.

This means that a linearization will eventually happen
with sizes smaller than one MSS.

__idpf_chk_linearize() is renamed to idpf_chk_tso_segment()
and moved to idpf_lib.c

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Cc: Madhu Chittim <madhu.chittim@intel.com>
Cc: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Cc: Joshua Hay <joshua.a.hay@intel.com>
Cc: Brian Vazquez <brianvv@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/ethernet/intel/idpf/idpf.h      |   2 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c  | 102 +++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 129 ++++----------------
 3 files changed, 120 insertions(+), 113 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index f4c0eaf9bde336ec77c9d61b5480f20fe7929e02..aafbb280c2e7387745bef10bd1fbfead07a3666b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -148,6 +148,7 @@ enum idpf_vport_state {
  * @link_speed_mbps: Link speed in mbps
  * @vport_idx: Relative vport index
  * @max_tx_hdr_size: Max header length hardware can support
+ * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
  * @state: See enum idpf_vport_state
  * @netstats: Packet and byte stats
  * @stats_lock: Lock to protect stats update
@@ -159,6 +160,7 @@ struct idpf_netdev_priv {
 	u32 link_speed_mbps;
 	u16 vport_idx;
 	u16 max_tx_hdr_size;
+	u16 tx_max_bufs;
 	enum idpf_vport_state state;
 	struct rtnl_link_stats64 netstats;
 	spinlock_t stats_lock;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 2c2a3e85d693013be95b71d2032817fb1e0a63d7..565c521c88cfb39cec31edbc0dc2ca9418fc3f09 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -776,6 +776,7 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	np->vport_idx = vport->idx;
 	np->vport_id = vport->vport_id;
 	np->max_tx_hdr_size = idpf_get_max_tx_hdr_size(adapter);
+	np->tx_max_bufs = idpf_get_max_tx_bufs(adapter);
 
 	spin_lock_init(&np->stats_lock);
 
@@ -2271,6 +2272,92 @@ static int idpf_change_mtu(struct net_device *netdev, int new_mtu)
 	return err;
 }
 
+/**
+ * idpf_chk_tso_segment - Check skb is not using too many buffers
+ * @skb: send buffer
+ * @max_bufs: maximum number of buffers
+ *
+ * For TSO we need to count the TSO header and segment payload separately.  As
+ * such we need to check cases where we have max_bufs-1 fragments or more as we
+ * can potentially require max_bufs+1 DMA transactions, 1 for the TSO header, 1
+ * for the segment payload in the first descriptor, and another max_buf-1 for
+ * the fragments.
+ *
+ * Returns true if the packet needs to be software segmented by core stack.
+ */
+static bool idpf_chk_tso_segment(const struct sk_buff *skb,
+				 unsigned int max_bufs)
+{
+	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+	const skb_frag_t *frag, *stale;
+	int nr_frags, sum;
+
+	/* no need to check if number of frags is less than max_bufs - 1 */
+	nr_frags = shinfo->nr_frags;
+	if (nr_frags < (max_bufs - 1))
+		return false;
+
+	/* We need to walk through the list and validate that each group
+	 * of max_bufs-2 fragments totals at least gso_size.
+	 */
+	nr_frags -= max_bufs - 2;
+	frag = &shinfo->frags[0];
+
+	/* Initialize size to the negative value of gso_size minus 1.  We use
+	 * this as the worst case scenario in which the frag ahead of us only
+	 * provides one byte which is why we are limited to max_bufs-2
+	 * descriptors for a single transmit as the header and previous
+	 * fragment are already consuming 2 descriptors.
+	 */
+	sum = 1 - shinfo->gso_size;
+
+	/* Add size of frags 0 through 4 to create our initial sum */
+	sum += skb_frag_size(frag++);
+	sum += skb_frag_size(frag++);
+	sum += skb_frag_size(frag++);
+	sum += skb_frag_size(frag++);
+	sum += skb_frag_size(frag++);
+
+	/* Walk through fragments adding latest fragment, testing it, and
+	 * then removing stale fragments from the sum.
+	 */
+	for (stale = &shinfo->frags[0];; stale++) {
+		int stale_size = skb_frag_size(stale);
+
+		sum += skb_frag_size(frag++);
+
+		/* The stale fragment may present us with a smaller
+		 * descriptor than the actual fragment size. To account
+		 * for that we need to remove all the data on the front and
+		 * figure out what the remainder would be in the last
+		 * descriptor associated with the fragment.
+		 */
+		if (stale_size > IDPF_TX_MAX_DESC_DATA) {
+			int align_pad = -(skb_frag_off(stale)) &
+					(IDPF_TX_MAX_READ_REQ_SIZE - 1);
+
+			sum -= align_pad;
+			stale_size -= align_pad;
+
+			do {
+				sum -= IDPF_TX_MAX_DESC_DATA_ALIGNED;
+				stale_size -= IDPF_TX_MAX_DESC_DATA_ALIGNED;
+			} while (stale_size > IDPF_TX_MAX_DESC_DATA);
+		}
+
+		/* if sum is negative we failed to make sufficient progress */
+		if (sum < 0)
+			return true;
+
+		if (!nr_frags--)
+			break;
+
+		sum -= stale_size;
+	}
+
+	return false;
+}
+
 /**
  * idpf_features_check - Validate packet conforms to limits
  * @skb: skb buffer
@@ -2292,12 +2379,15 @@ static netdev_features_t idpf_features_check(struct sk_buff *skb,
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
 		return features;
 
-	/* We cannot support GSO if the MSS is going to be less than
-	 * 88 bytes. If it is then we need to drop support for GSO.
-	 */
-	if (skb_is_gso(skb) &&
-	    (skb_shinfo(skb)->gso_size < IDPF_TX_TSO_MIN_MSS))
-		features &= ~NETIF_F_GSO_MASK;
+	if (skb_is_gso(skb)) {
+		/* We cannot support GSO if the MSS is going to be less than
+		 * 88 bytes. If it is then we need to drop support for GSO.
+		 */
+		if (skb_shinfo(skb)->gso_size < IDPF_TX_TSO_MIN_MSS)
+			features &= ~NETIF_F_GSO_MASK;
+		else if (idpf_chk_tso_segment(skb, np->tx_max_bufs))
+			features &= ~NETIF_F_GSO_MASK;
+	}
 
 	/* Ensure MACLEN is <= 126 bytes (63 words) and not an odd size */
 	len = skb_network_offset(skb);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 66a1b040639d1110519ca8fd57c2bdf0fdb2d822..b868761fad4d7ec8be414a35dc21640425abf09b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -16,8 +16,28 @@ struct idpf_tx_stash {
 #define idpf_tx_buf_compl_tag(buf)	(*(u32 *)&(buf)->priv)
 LIBETH_SQE_CHECK_PRIV(u32);
 
-static bool idpf_chk_linearize(struct sk_buff *skb, unsigned int max_bufs,
-			       unsigned int count);
+/**
+ * idpf_chk_linearize - Check if skb exceeds max descriptors per packet
+ * @skb: send buffer
+ * @max_bufs: maximum scatter gather buffers for single packet
+ * @count: number of buffers this packet needs
+ *
+ * Make sure we don't exceed maximum scatter gather buffers for a single
+ * packet.
+ * TSO case has been handled earlier from idpf_features_check().
+ */
+static bool idpf_chk_linearize(const struct sk_buff *skb,
+			       unsigned int max_bufs,
+			       unsigned int count)
+{
+	if (likely(count <= max_bufs))
+		return false;
+
+	if (skb_is_gso(skb))
+		return false;
+
+	return true;
+}
 
 /**
  * idpf_buf_lifo_push - push a buffer pointer onto stack
@@ -2627,111 +2647,6 @@ int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off)
 	return 1;
 }
 
-/**
- * __idpf_chk_linearize - Check skb is not using too many buffers
- * @skb: send buffer
- * @max_bufs: maximum number of buffers
- *
- * For TSO we need to count the TSO header and segment payload separately.  As
- * such we need to check cases where we have max_bufs-1 fragments or more as we
- * can potentially require max_bufs+1 DMA transactions, 1 for the TSO header, 1
- * for the segment payload in the first descriptor, and another max_buf-1 for
- * the fragments.
- */
-static bool __idpf_chk_linearize(struct sk_buff *skb, unsigned int max_bufs)
-{
-	const struct skb_shared_info *shinfo = skb_shinfo(skb);
-	const skb_frag_t *frag, *stale;
-	int nr_frags, sum;
-
-	/* no need to check if number of frags is less than max_bufs - 1 */
-	nr_frags = shinfo->nr_frags;
-	if (nr_frags < (max_bufs - 1))
-		return false;
-
-	/* We need to walk through the list and validate that each group
-	 * of max_bufs-2 fragments totals at least gso_size.
-	 */
-	nr_frags -= max_bufs - 2;
-	frag = &shinfo->frags[0];
-
-	/* Initialize size to the negative value of gso_size minus 1.  We use
-	 * this as the worst case scenario in which the frag ahead of us only
-	 * provides one byte which is why we are limited to max_bufs-2
-	 * descriptors for a single transmit as the header and previous
-	 * fragment are already consuming 2 descriptors.
-	 */
-	sum = 1 - shinfo->gso_size;
-
-	/* Add size of frags 0 through 4 to create our initial sum */
-	sum += skb_frag_size(frag++);
-	sum += skb_frag_size(frag++);
-	sum += skb_frag_size(frag++);
-	sum += skb_frag_size(frag++);
-	sum += skb_frag_size(frag++);
-
-	/* Walk through fragments adding latest fragment, testing it, and
-	 * then removing stale fragments from the sum.
-	 */
-	for (stale = &shinfo->frags[0];; stale++) {
-		int stale_size = skb_frag_size(stale);
-
-		sum += skb_frag_size(frag++);
-
-		/* The stale fragment may present us with a smaller
-		 * descriptor than the actual fragment size. To account
-		 * for that we need to remove all the data on the front and
-		 * figure out what the remainder would be in the last
-		 * descriptor associated with the fragment.
-		 */
-		if (stale_size > IDPF_TX_MAX_DESC_DATA) {
-			int align_pad = -(skb_frag_off(stale)) &
-					(IDPF_TX_MAX_READ_REQ_SIZE - 1);
-
-			sum -= align_pad;
-			stale_size -= align_pad;
-
-			do {
-				sum -= IDPF_TX_MAX_DESC_DATA_ALIGNED;
-				stale_size -= IDPF_TX_MAX_DESC_DATA_ALIGNED;
-			} while (stale_size > IDPF_TX_MAX_DESC_DATA);
-		}
-
-		/* if sum is negative we failed to make sufficient progress */
-		if (sum < 0)
-			return true;
-
-		if (!nr_frags--)
-			break;
-
-		sum -= stale_size;
-	}
-
-	return false;
-}
-
-/**
- * idpf_chk_linearize - Check if skb exceeds max descriptors per packet
- * @skb: send buffer
- * @max_bufs: maximum scatter gather buffers for single packet
- * @count: number of buffers this packet needs
- *
- * Make sure we don't exceed maximum scatter gather buffers for a single
- * packet. We have to do some special checking around the boundary (max_bufs-1)
- * if TSO is on since we need count the TSO header and payload separately.
- * E.g.: a packet with 7 fragments can require 9 DMA transactions; 1 for TSO
- * header, 1 for segment payload, and then 7 for the fragments.
- */
-static bool idpf_chk_linearize(struct sk_buff *skb, unsigned int max_bufs,
-			       unsigned int count)
-{
-	if (likely(count < max_bufs))
-		return false;
-	if (skb_is_gso(skb))
-		return __idpf_chk_linearize(skb, max_bufs);
-
-	return count > max_bufs;
-}
 
 /**
  * idpf_tx_splitq_get_ctx_desc - grab next desc and update buffer ring
-- 
2.51.0.rc1.167.g924127e9c0-goog


