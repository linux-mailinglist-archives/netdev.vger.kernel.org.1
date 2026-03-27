Return-Path: <netdev+bounces-272412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAEuJXgzxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:36:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAE1340818
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6BBE3039F9D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808E53CD8A3;
	Fri, 27 Mar 2026 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tb5RusUq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB63CCFA6
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596663; cv=none; b=Ieq8/V5NnBY1fbdVZ5h1tIpwxjkUet8t8DGfb1CdhecSj4h5GPnXsH2CtQao0zu28T/SNSgXJlAB9gGo98MNLG+A3ozdx9LoWd99LcE5GwInNHcnQ2TqKFH+yLDfbWiHI9TgvLaoj3VDxcv18W0oRSi0NrNTC8J79xBZjZ0L27M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596663; c=relaxed/simple;
	bh=y2yKKNgr3vmACHaIi7uKjgzkogFj3MgrCQ7Vm/PMxX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9BJuMZz54aiJOaEWwEWNg/Ze+N+kcLOpB0Ap1tcsR2HAAWtbqiqW3AiU0z7LPlmBB1XKOec5zJHnehkLo5NC+Bm2QgBU+GhA3mTlhvq1eWUqybU+F9ps6Rgzli47tyKf7NHQtujVuzEpvy0Rml46IytuXZ2F13hmlkF+cxtsnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tb5RusUq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596653; x=1806132653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y2yKKNgr3vmACHaIi7uKjgzkogFj3MgrCQ7Vm/PMxX8=;
  b=Tb5RusUqZuVYeahBayQwUTxoFyhB1R5tx4mqsou3dsIwXtFFjoq7k7DG
   Ohh2lJzjseIRaNIEmkKebkm/9QbCWzySQx3xtL2Ds8CtBTklUrK+f9jI4
   Ij8zZOCA7R+ARB9df/qjyrUtw/YeqGEN0lVU4vFsAEQKoI5FWdUJtmyw+
   747ApwgAD6eJXFCUkH2i4qjr84qGJ7+AcQ3a0XMJiArn77LYtIhhBq2Kg
   SS2o1qsIHFHkZXPwrsSJFUhm1Gx+5XvTlnqH5zLaEKv+3YvA8Kko0Arjo
   watqC0ROIjRRP1bRhmCbbWaj8CM5Uee32w9eagC45WfBcXJKYQoqjxSIb
   g==;
X-CSE-ConnectionGUID: tk7gC/zBQPK5HF28AnyXdQ==
X-CSE-MsgGUID: oYJDUZABTKuNkj4uku0xuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75734298"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75734298"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:30:51 -0700
X-CSE-ConnectionGUID: bndeIcSqRZGZKqeQpCwCeQ==
X-CSE-MsgGUID: m9daod8WQWmVxWnEbEgJ2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255740366"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:30:50 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next] ixgbe: clean up adaptive interrupt moderation algorithm
Date: Fri, 27 Mar 2026 08:30:37 +0100
Message-ID: <20260327073046.134085-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272412-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BAE1340818
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alexander Duyck <alexander.h.duyck@intel.com>

Improve the adaptive interrupt throttle (ITR) algorithm in several ways:

 - Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 us (12K interrupts/s
   minimum in bulk mode) to prevent RX starvation in full-blown bulk
   scenarios.

 - Add ixgbe_container_is_rx() helper to split the Rx vs Tx logic in
   ixgbe_update_itr(); Rx uses a latency-favouring path for small bursts
   (< 24 packets and < 12112 bytes), targeting 8x throughput growth per
   step.

 - Limit the ITR decrease in latency mode to at most 2 us per update so
   ACK workloads do not overdrive the moderation and starve TCP senders.

 - Add IXGBE_ITR_ADAPTIVE_MASK_USECS (= IXGBE_ITR_ADAPTIVE_LATENCY - 1
   = 0x7F) to mask out the mode flag bit 7 in ixgbe_set_itr(), replacing
   the open-coded ~IXGBE_ITR_ADAPTIVE_LATENCY.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 78 +++++++++++--------
 2 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 59a1cee4..c704cc6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -475,9 +475,10 @@ static inline unsigned int ixgbe_rx_pg_order(struct ixgbe_ring *ring)
 
 #define IXGBE_ITR_ADAPTIVE_MIN_INC	2
 #define IXGBE_ITR_ADAPTIVE_MIN_USECS	10
-#define IXGBE_ITR_ADAPTIVE_MAX_USECS	126
+#define IXGBE_ITR_ADAPTIVE_MAX_USECS	84
 #define IXGBE_ITR_ADAPTIVE_LATENCY	0x80
 #define IXGBE_ITR_ADAPTIVE_BULK		0x00
+#define IXGBE_ITR_ADAPTIVE_MASK_USECS	(IXGBE_ITR_ADAPTIVE_LATENCY - 1)
 
 struct ixgbe_ring_container {
 	struct ixgbe_ring *ring;	/* pointer to linked list of rings */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 0bc806a..1885fe8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2711,6 +2711,12 @@ static void ixgbe_configure_msix(struct ixgbe_adapter *adapter)
 	IXGBE_WRITE_REG(&adapter->hw, IXGBE_EIAC, mask);
 }
 
+static inline bool ixgbe_container_is_rx(struct ixgbe_q_vector *q_vector,
+					 struct ixgbe_ring_container *rc)
+{
+	return &q_vector->rx == rc;
+}
+
 /**
  * ixgbe_update_itr - update the dynamic ITR value based on statistics
  * @q_vector: structure containing interrupt and ring information
@@ -2747,35 +2753,24 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 		goto clear_counts;
 
 	packets = ring_container->total_packets;
-
-	/* We have no packets to actually measure against. This means
-	 * either one of the other queues on this vector is active or
-	 * we are a Tx queue doing TSO with too high of an interrupt rate.
-	 *
-	 * When this occurs just tick up our delay by the minimum value
-	 * and hope that this extra delay will prevent us from being called
-	 * without any work on our queue.
-	 */
-	if (!packets) {
-		itr = (q_vector->itr >> 2) + IXGBE_ITR_ADAPTIVE_MIN_INC;
-		if (itr > IXGBE_ITR_ADAPTIVE_MAX_USECS)
-			itr = IXGBE_ITR_ADAPTIVE_MAX_USECS;
-		itr += ring_container->itr & IXGBE_ITR_ADAPTIVE_LATENCY;
-		goto clear_counts;
-	}
-
 	bytes = ring_container->total_bytes;
 
-	/* If packets are less than 4 or bytes are less than 9000 assume
-	 * insufficient data to use bulk rate limiting approach. We are
-	 * likely latency driven.
-	 */
-	if (packets < 4 && bytes < 9000) {
-		itr = IXGBE_ITR_ADAPTIVE_LATENCY;
-		goto adjust_by_size;
+	if (ixgbe_container_is_rx(q_vector, ring_container)) {
+		/* If Rx and there are 1 to 23 packets and bytes are less than
+		 * 12112 assume insufficient data to use bulk rate limiting
+		 * approach. Instead we will focus on simply trying to target
+		 * receiving 8 times as much data in the next interrupt.
+		 */
+		if (packets && packets < 24 && bytes < 12112) {
+			itr = IXGBE_ITR_ADAPTIVE_LATENCY;
+			avg_wire_size = (bytes + packets * 24) * 2;
+			avg_wire_size = clamp_t(unsigned int,
+						avg_wire_size, 2560, 12800);
+			goto adjust_for_speed;
+		}
 	}
 
-	/* Between 4 and 48 we can assume that our current interrupt delay
+	/* Less than 48 packets we can assume that our current interrupt delay
 	 * is only slightly too low. As such we should increase it by a small
 	 * fixed amount.
 	 */
@@ -2783,6 +2778,20 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 		itr = (q_vector->itr >> 2) + IXGBE_ITR_ADAPTIVE_MIN_INC;
 		if (itr > IXGBE_ITR_ADAPTIVE_MAX_USECS)
 			itr = IXGBE_ITR_ADAPTIVE_MAX_USECS;
+
+		/* If sample size is 0 - 7 we should probably switch
+		 * to latency mode instead of trying to control
+		 * things as though we are in bulk.
+		 *
+		 * Otherwise if the number of packets is less than 48
+		 * we should maintain whatever mode we are currently
+		 * in. The range between 8 and 48 is the cross-over
+		 * point between latency and bulk traffic.
+		 */
+		if (packets < 8)
+			itr += IXGBE_ITR_ADAPTIVE_LATENCY;
+		else
+			itr += ring_container->itr & IXGBE_ITR_ADAPTIVE_LATENCY;
 		goto clear_counts;
 	}
 
@@ -2813,7 +2822,6 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 	 */
 	itr = IXGBE_ITR_ADAPTIVE_BULK;
 
-adjust_by_size:
 	/* If packet counts are 256 or greater we can assume we have a gross
 	 * overestimation of what the rate should be. Instead of trying to fine
 	 * tune it just use the formula below to try and dial in an exact value
@@ -2856,12 +2864,7 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 		avg_wire_size = 32256;
 	}
 
-	/* If we are in low latency mode half our delay which doubles the rate
-	 * to somewhere between 100K to 16K ints/sec
-	 */
-	if (itr & IXGBE_ITR_ADAPTIVE_LATENCY)
-		avg_wire_size >>= 1;
-
+adjust_for_speed:
 	/* Resultant value is 256 times larger than it needs to be. This
 	 * gives us room to adjust the value as needed to either increase
 	 * or decrease the value based on link speeds of 10G, 2.5G, 1G, etc.
@@ -2888,6 +2891,15 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 		break;
 	}
 
+	/* In the case of a latency specific workload only allow us to
+	 * reduce the ITR by at most 2us. By doing this we should dial
+	 * in so that our number of interrupts is no more than 2x the number
+	 * of packets for the least busy workload. So for example in the case
+	 * of a TCP workload the ACK packets being received would set the
+	 * interrupt rate as they are a latency specific workload.
+	 */
+	if ((itr & IXGBE_ITR_ADAPTIVE_LATENCY) && itr < ring_container->itr)
+		itr = ring_container->itr - IXGBE_ITR_ADAPTIVE_MIN_INC;
 clear_counts:
 	/* write back value */
 	ring_container->itr = itr;
@@ -2948,7 +2960,7 @@ static void ixgbe_set_itr(struct ixgbe_q_vector *q_vector)
 	new_itr = min(q_vector->rx.itr, q_vector->tx.itr);
 
 	/* Clear latency flag if set, shift into correct position */
-	new_itr &= ~IXGBE_ITR_ADAPTIVE_LATENCY;
+	new_itr &= IXGBE_ITR_ADAPTIVE_MASK_USECS;
 	new_itr <<= 2;
 
 	if (new_itr != q_vector->itr) {
-- 
2.52.0


