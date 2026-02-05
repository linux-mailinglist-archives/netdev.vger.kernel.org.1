Return-Path: <netdev+bounces-256927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP+jD+cDhGmHwwMAu9opvQ
	(envelope-from <netdev+bounces-256927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:43:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A952AEE12F
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CAC730117BC
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5812C15AA;
	Thu,  5 Feb 2026 02:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3F8MkVH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6411FF1B5
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 02:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259427; cv=none; b=TFH+0KXj5EiqIYjMZ94zNJCVZ5wCrUtWBTnMx3nqM1li8ehkEv8EWep8o4hwdgYWc/JidtwEFwbX9sC8XnJeG2D9220NIxMY5oyNN23k0jHSq5izRDaeDgCwoJhjQJIxiNkLdyqD/MuYSHmGfqE/8+DAx/+4NdS9lP5Fji5KpNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259427; c=relaxed/simple;
	bh=FOCU7ky6atLZJIqo4lqdbHNvOqA+ZkuKyKkbuO881Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YnP/jLfytZb+8PxIHIfKio/bT5xHP8YCq+1yOD2vDamVpub9HDa/J64niS4e8rOlcw73rMRoumbxDDleyUkFQm5ICN7QzSWpKjRTZUtquiMW60dX5EVSpyBtesNMrlnS04Cz6gX27sTT2YW30PRGPFJzdT8FaFuZ9sQqyQbpcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3F8MkVH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a12ed4d205so2913905ad.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 18:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770259426; x=1770864226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uq//eKnU0VIy+iDlWT3coRvXqAavfDjJ0UDudhoedEQ=;
        b=T3F8MkVHgHWiv+LABR1Ilst4Pjyi7gs6ZmUwxaTdun3xwLh4XB4Avt9BnZKx/MRDZb
         kYZcHzNY6h8VnN+KP7Ep1nJssBqdHFaHrxRfzqRjT0xEQ4IQJmCboh3CMjoZrtYXRZd8
         83QMQRG8RRl2ock0GMm26hy/ltJGLnucJH/So5dic/mHwJa0Bp9Yh8+nwhUScF1NGaAD
         QG9M6Q7l9Q9JbAcv338LEvuDFqEyEwfDLuvCs6idmca2FM7hP5ezkUXq/LqLoRtDMrug
         XHpWrT9JbKJcVnPhioPlDBnrGs8aIj6zRMZ6420ZyksRYP3FG3ZYDSdmtjTT4EqkFt1G
         J7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770259426; x=1770864226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uq//eKnU0VIy+iDlWT3coRvXqAavfDjJ0UDudhoedEQ=;
        b=XQZqBeo1UU5WQpyNG92bE7mkogHngr/6K/Yyx26VY3+sGtG6k1dASCw5R/70WNObZ6
         ztdHL8GLR+89n5bc+o5CBUfZtM439OfBdGu3jcLeHxGiAKgWiO234Ev+t0I7iAgCd7Gs
         jvLvT3la31gFoLpU1+g0YDZx3QGV+caeBk3QKCkteVjyVVhSUJEjqqxUYH8ilCLQc0A+
         8aOo8V/ESHOIfZOJ0mKpsQPJbi+2z7gL94Pz/Y2gD7MRltHBK45tYIwFzN+B1MhhcTC1
         /vhZbTaac16YeKvUjzG+4nE49sv4BbZWsiPnzT+7N45hMY3BYxs2KI5wCBRZwp6Ou4mf
         GFWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7MtumwM0jEWC4Udo6fPDgBWNTXXLSwje+G3Avh39a+hsyKiI359x8roG7kWhKC9Ad7gRLiBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoes5vDtf9VYIWvZSzKc6EyoTGex+6iIIbZiUe76ATWEk/zVRz
	4AdJO/fejBETdfp1WFnSOxGjt5lfQhPdAKQjwyJYfeL9hOFUIbHX2Qym
X-Gm-Gg: AZuq6aKa3GozsZhizTSO4isusC69E9y+P7LBZV/JKw0I4PnGpdiUm/S6UEhiiScwiX7
	l2WWqQNgh2MvVqNuYU86sLHTEJTmdSz13YQMsknHb3rEeTxej0HIAKxpTooa3ThacB2CRnuWIzC
	45RYOOt+mKYxkKIzz+D9Gaqvlaz+t0WUMATy+bO9VCxEJV4NOnKWRPCP/g55WJXjnFn/0oRfzqB
	kc05zrjr1CWM3yX8tlBuhNZJQJQPsQvgsiNIDvClLUUmUUsDQojAG4wQkNTBV6jbzqrCu+3DSgm
	uGN8guXUdyP7IUwkHqhTQNAsjZNaKSL/IcyscQ+uPLEYMhzf8PobH6+dgQ2JxE1P3QXxnRiqsP+
	xY4hM/TQLYS9xAveMu1QCdDEY7taDQOU66ML+fA2vvP8cJ5ngAIAA+ID3AuTI3jZk3BEn2kkee5
	Nh7ojVSgof/IkvfXIk690GHbd5NvWTLKIzWmsWxuKKND1Rg4UziDdgQ/9u7AN74e4/ZhTV5zY/f
	oKfH25lCbE=
X-Received: by 2002:a17:903:4b0d:b0:2a7:f369:4de8 with SMTP id d9443c01a7336-2a933fddab3mr51965225ad.42.1770259426114;
        Wed, 04 Feb 2026 18:43:46 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9338acfe8sm36559315ad.42.2026.02.04.18.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 18:43:45 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: tony.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	paul.greenwalt@intel.com,
	maciej.fijalkowski@intel.com,
	aleksandr.loktionov@intel.com,
	alice.michael@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Keita Morisaki <kmta1236@gmail.com>
Subject: [PATCH v2] ice: fix race condition in TX timestamp ring cleanup
Date: Thu,  5 Feb 2026 11:43:27 +0900
Message-Id: <20260205024327.233346-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,lists.osuosl.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-256927-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmta1236@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A952AEE12F
X-Rspamd-Action: no action

Fix a race condition between ice_free_tx_tstamp_ring() and ice_tx_map()
that can cause a NULL pointer dereference.

ice_free_tx_tstamp_ring currently clears the ICE_TX_FLAGS_TXTIME flag
after NULLing the tstamp_ring. This could allow a concurrent ice_tx_map
call on another CPU to dereference the tstamp_ring, which could lead to
a NULL pointer dereference.

  CPU A:ice_free_tx_tstamp_ring() | CPU B:ice_tx_map()
  --------------------------------|---------------------------------
  tx_ring->tstamp_ring = NULL     |
                                  | ice_is_txtime_cfg() -> true
                                  | tstamp_ring = tx_ring->tstamp_ring
                                  | tstamp_ring->count  // NULL deref!
  flags &= ~ICE_TX_FLAGS_TXTIME   |

Fix by:
1. Reordering ice_free_tx_tstamp_ring() to clear the flag before
   NULLing the pointer, with smp_wmb() to ensure proper ordering.
2. Adding smp_rmb() in ice_tx_map() after the flag check to order the
   flag read before the pointer read, using READ_ONCE() for the
   pointer, and adding a NULL check as a safety net.
3. Converting tx_ring->flags from u8 to DECLARE_BITMAP() and using
   atomic bitops (set_bit(), clear_bit(), test_bit()) for all flag
   operations throughout the driver:
   - ICE_TX_RING_FLAGS_XDP
   - ICE_TX_RING_FLAGS_VLAN_L2TAG1
   - ICE_TX_RING_FLAGS_VLAN_L2TAG2
   - ICE_TX_RING_FLAGS_TXTIME

Fixes: ccde82e909467 ("ice: add E830 Earliest TxTime First Offload support")
Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
Changes in v2:
- Convert tx_ring->flags from u8 to DECLARE_BITMAP() and use atomic
  bitops (set_bit(), clear_bit(), test_bit()) for all flag operations
  instead of WRITE_ONCE() for flag updates
- Rename flags from ICE_TX_FLAGS_RING_* to ICE_TX_RING_FLAGS_* to
  distinguish from per-packet flags (ICE_TX_FLAGS_*)

 drivers/net/ethernet/intel/ice/ice.h         |  4 ++--
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c     |  4 ++--
 drivers/net/ethernet/intel/ice/ice_txrx.c    | 23 ++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_txrx.h    | 16 +++++++++-----
 5 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 00f75d87c73f9..5baeca824cd99 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -753,7 +753,7 @@ static inline bool ice_is_xdp_ena_vsi(struct ice_vsi *vsi)
 
 static inline void ice_set_ring_xdp(struct ice_tx_ring *ring)
 {
-	ring->flags |= ICE_TX_FLAGS_RING_XDP;
+	set_bit(ICE_TX_RING_FLAGS_XDP, ring->flags);
 }
 
 /**
@@ -778,7 +778,7 @@ static inline bool ice_is_txtime_ena(const struct ice_tx_ring *ring)
  */
 static inline bool ice_is_txtime_cfg(const struct ice_tx_ring *ring)
 {
-	return !!(ring->flags & ICE_TX_FLAGS_TXTIME);
+	return test_bit(ICE_TX_RING_FLAGS_TXTIME, ring->flags);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 9fc8681cc58ea..bd74344271f3f 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -943,7 +943,7 @@ ice_tx_prepare_vlan_flags_dcb(struct ice_tx_ring *tx_ring,
 		/* if this is not already set it means a VLAN 0 + priority needs
 		 * to be offloaded
 		 */
-		if (tx_ring->flags & ICE_TX_FLAGS_RING_VLAN_L2TAG2)
+		if (test_bit(ICE_TX_RING_FLAGS_VLAN_L2TAG2, tx_ring->flags))
 			first->tx_flags |= ICE_TX_FLAGS_HW_OUTER_SINGLE_VLAN;
 		else
 			first->tx_flags |= ICE_TX_FLAGS_HW_VLAN;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d47af94f31a99..55ff0708d136e 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1412,9 +1412,9 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 		ring->count = vsi->num_tx_desc;
 		ring->txq_teid = ICE_INVAL_TEID;
 		if (dvm_ena)
-			ring->flags |= ICE_TX_FLAGS_RING_VLAN_L2TAG2;
+			set_bit(ICE_TX_RING_FLAGS_VLAN_L2TAG2, ring->flags);
 		else
-			ring->flags |= ICE_TX_FLAGS_RING_VLAN_L2TAG1;
+			set_bit(ICE_TX_RING_FLAGS_VLAN_L2TAG1, ring->flags);
 		WRITE_ONCE(vsi->tx_rings[i], ring);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index ad76768a42323..564e4e33ecbc3 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -190,9 +190,10 @@ void ice_free_tstamp_ring(struct ice_tx_ring *tx_ring)
 void ice_free_tx_tstamp_ring(struct ice_tx_ring *tx_ring)
 {
 	ice_free_tstamp_ring(tx_ring);
+	clear_bit(ICE_TX_RING_FLAGS_TXTIME, tx_ring->flags);
+	smp_wmb();	/* order flag clear before pointer NULL */
 	kfree_rcu(tx_ring->tstamp_ring, rcu);
-	tx_ring->tstamp_ring = NULL;
-	tx_ring->flags &= ~ICE_TX_FLAGS_TXTIME;
+	WRITE_ONCE(tx_ring->tstamp_ring, NULL);
 }
 
 /**
@@ -405,7 +406,7 @@ static int ice_alloc_tstamp_ring(struct ice_tx_ring *tx_ring)
 	tx_ring->tstamp_ring = tstamp_ring;
 	tstamp_ring->desc = NULL;
 	tstamp_ring->count = ice_calc_ts_ring_count(tx_ring);
-	tx_ring->flags |= ICE_TX_FLAGS_TXTIME;
+	set_bit(ICE_TX_RING_FLAGS_TXTIME, tx_ring->flags);
 	return 0;
 }
 
@@ -1519,13 +1520,20 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 		return;
 
 	if (ice_is_txtime_cfg(tx_ring)) {
-		struct ice_tstamp_ring *tstamp_ring = tx_ring->tstamp_ring;
-		u32 tstamp_count = tstamp_ring->count;
-		u32 j = tstamp_ring->next_to_use;
+		struct ice_tstamp_ring *tstamp_ring;
+		u32 tstamp_count, j;
 		struct ice_ts_desc *ts_desc;
 		struct timespec64 ts;
 		u32 tstamp;
 
+		smp_rmb();	/* order flag read before pointer read */
+		tstamp_ring = READ_ONCE(tx_ring->tstamp_ring);
+		if (unlikely(!tstamp_ring))
+			goto ring_kick;
+
+		tstamp_count = tstamp_ring->count;
+		j = tstamp_ring->next_to_use;
+
 		ts = ktime_to_timespec64(first->skb->tstamp);
 		tstamp = ts.tv_nsec >> ICE_TXTIME_CTX_RESOLUTION_128NS;
 
@@ -1553,6 +1561,7 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 		tstamp_ring->next_to_use = j;
 		writel_relaxed(j, tstamp_ring->tail);
 	} else {
+ring_kick:
 		writel_relaxed(i, tx_ring->tail);
 	}
 	return;
@@ -1812,7 +1821,7 @@ ice_tx_prepare_vlan_flags(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first)
 	 */
 	if (skb_vlan_tag_present(skb)) {
 		first->vid = skb_vlan_tag_get(skb);
-		if (tx_ring->flags & ICE_TX_FLAGS_RING_VLAN_L2TAG2)
+		if (test_bit(ICE_TX_RING_FLAGS_VLAN_L2TAG2, tx_ring->flags))
 			first->tx_flags |= ICE_TX_FLAGS_HW_OUTER_SINGLE_VLAN;
 		else
 			first->tx_flags |= ICE_TX_FLAGS_HW_VLAN;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index e440c55d9e9f0..d35ffdc3dc84d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -181,6 +181,14 @@ enum ice_rx_dtype {
 	ICE_RX_DTYPE_SPLIT_ALWAYS	= 2,
 };
 
+enum ice_tx_ring_flags {
+	ICE_TX_RING_FLAGS_XDP,
+	ICE_TX_RING_FLAGS_VLAN_L2TAG1,
+	ICE_TX_RING_FLAGS_VLAN_L2TAG2,
+	ICE_TX_RING_FLAGS_TXTIME,
+	ICE_TX_RING_FLAGS_NBITS,
+};
+
 struct ice_pkt_ctx {
 	u64 cached_phctime;
 	__be16 vlan_proto;
@@ -333,11 +341,7 @@ struct ice_tx_ring {
 	u32 txq_teid;			/* Added Tx queue TEID */
 	/* CL4 - 4th cacheline starts here */
 	struct ice_tstamp_ring *tstamp_ring;
-#define ICE_TX_FLAGS_RING_XDP		BIT(0)
-#define ICE_TX_FLAGS_RING_VLAN_L2TAG1	BIT(1)
-#define ICE_TX_FLAGS_RING_VLAN_L2TAG2	BIT(2)
-#define ICE_TX_FLAGS_TXTIME		BIT(3)
-	u8 flags;
+	DECLARE_BITMAP(flags, ICE_TX_RING_FLAGS_NBITS);
 	u8 dcb_tc;			/* Traffic class of ring */
 	u16 quanta_prof_id;
 } ____cacheline_internodealigned_in_smp;
@@ -349,7 +353,7 @@ static inline bool ice_ring_ch_enabled(struct ice_tx_ring *ring)
 
 static inline bool ice_ring_is_xdp(struct ice_tx_ring *ring)
 {
-	return !!(ring->flags & ICE_TX_FLAGS_RING_XDP);
+	return test_bit(ICE_TX_RING_FLAGS_XDP, ring->flags);
 }
 
 enum ice_container_type {

base-commit: 18f7fcd5e69a04df57b563360b88be72471d6b62
-- 
2.34.1


