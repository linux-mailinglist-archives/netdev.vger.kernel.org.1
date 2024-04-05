Return-Path: <netdev+bounces-85344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E675989A541
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 21:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D183283F21
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 19:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FC5174ED6;
	Fri,  5 Apr 2024 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IL/XQVBp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FAA171E77
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346709; cv=none; b=mR9Wjp59IItgZjrThblqbYk1AZ+jgB+/hgNcK4XKFry6JQxUkqPWkCaKEhurHwE8aq1YmU4r8TbVz35SnPWOPacwo6se/Olav5G9uBNdpDYV50J/qaf9C8j8Bw/rT/lSxLsUs5o/+fcJpdI7gLRLMgmbdc2AHqE8birlBicDHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346709; c=relaxed/simple;
	bh=4uTH3OX3nmKPbZXtcSGIjLpdVnGTqIbYtW93fgvQvAk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gu7xdIVr80y50mqIFEiwStwxRkvETeABTSJKZlURZCk2iK79P+GvuPefQOq+Vwb5kDK9rIgIeLKmk403F7wXijOgpBn0ngr5GrYtQm4A0AfP01t6mVHOQZAitgRFV+JeyuPiYeFSdzC+usFHCiFIJSJwL/r+VVRoMU2i6PkMUZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IL/XQVBp; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712346708; x=1743882708;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4uTH3OX3nmKPbZXtcSGIjLpdVnGTqIbYtW93fgvQvAk=;
  b=IL/XQVBp3iu6kQvGXNqB99bOd/lDxrpErhDafvCfnV0n1GAIfeq/xrTc
   MnP0bzpP4zaMRcU5VQ9TRmm+6Uy/f6ed4xTdgEsKW8X8hBt9DIDtZGNSJ
   UwFF9rBBdvxCw8dazZKCqyCnSxejIFgj2iQOFMRa5v21sAJZuCvOjOCGR
   fwjw/9PZpDn/YA8EYOky7ske6LAxxFUUkVIe1EEY3iZJ6FiOCfugw/vRD
   A3CtOVT+w9Ba3T6RYwGFdFZG24nXgiEHzEA3MKNz4hB8s2Rx5fol4E/9p
   A/v4L/QlSTqJL7dL0zE12U+m2MwjrjPOzUlRbisdCxvyKvhlIdR2x8O+7
   g==;
X-CSE-ConnectionGUID: 2Znmq3J8QZO9GQa3XV6ixQ==
X-CSE-MsgGUID: ZEdjnQ10TCu8DjTZjfGW9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7785935"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7785935"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 12:51:47 -0700
X-CSE-ConnectionGUID: Q3PQPBLiTOKx/7OoHr2pEw==
X-CSE-MsgGUID: cxbd7Xg/QMmOgq2qggwOaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="23989929"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orviesa004.jf.intel.com with ESMTP; 05 Apr 2024 12:51:47 -0700
Subject: [net-next,
 RFC PATCH 5/5] ice: Add driver support for ndo_queue_set_napi
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: edumazet@google.com, pabeni@redhat.com, ast@kernel.org, sdf@google.com,
 lorenzo@kernel.org, tariqt@nvidia.com, daniel@iogearbox.net,
 anthony.l.nguyen@intel.com, lucien.xin@gmail.com, hawk@kernel.org,
 sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 05 Apr 2024 13:09:54 -0700
Message-ID: <171234779427.5075.586255342877398659.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
References: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add support in the ice driver to change the NAPI instance
associated with the queue. This is achieved by updating the
interrupt vector association for the queue.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  |  311 +++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h  |    2 
 drivers/net/ethernet/intel/ice/ice_main.c |    1 
 3 files changed, 310 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 419d9561bc2a..3a93b53a0da0 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -4186,7 +4186,7 @@ static void ice_qvec_configure(struct ice_vsi *vsi, struct ice_q_vector *q_vecto
  * @vsi: the VSI that contains queue vector
  * @q_vector: queue vector
  */
-static int __maybe_unused
+static int
 ice_q_vector_dis(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
 {
 	struct ice_hw *hw = &vsi->back->hw;
@@ -4221,7 +4221,7 @@ ice_q_vector_dis(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
  * @vsi: the VSI that contains queue vector
  * @q_vector: queue vector
  */
-static int __maybe_unused
+static int
 ice_q_vector_ena(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
 {
 	struct ice_rx_ring *rx_ring;
@@ -4278,7 +4278,7 @@ ice_qvec_release_msix(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
  * @vsi: the VSI that contains queue vector
  * @q_vector: queue vector
  */
-static void __maybe_unused
+static void
 ice_qvec_free(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
 {
 	int irq_num = q_vector->irq.virq;
@@ -4309,7 +4309,7 @@ ice_qvec_free(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
  * @vsi: the VSI that contains queue vector
  * @q_vector: queue vector
  */
-static int __maybe_unused
+static int
 ice_qvec_prep(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
 {
 	struct ice_pf *pf = vsi->back;
@@ -4365,3 +4365,306 @@ ice_qvec_prep(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
 
 	return err;
 }
+
+/**
+ * ice_vsi_rename_irq_msix
+ * @vsi: VSI being configured
+ * @basename: name for the vector
+ *
+ * Rename the vector. The default vector names assumed a 1:1 mapping between
+ * queues and vectors in a serial fashion. When the NAPI association for the
+ * queue is changed, it is possible to have multiple queues sharing a vector
+ * in a non-serial way.
+ */
+static void ice_vsi_rename_irq_msix(struct ice_vsi *vsi, char *basename)
+{
+	int q_vectors = vsi->num_q_vectors;
+	int vector, err;
+
+	for (vector = 0; vector < q_vectors; vector++) {
+		struct ice_q_vector *q_vector = vsi->q_vectors[vector];
+
+		if (q_vector->tx.tx_ring && q_vector->rx.rx_ring) {
+			err = snprintf(q_vector->name, sizeof(q_vector->name) - 1,
+				       "%s-%s", basename, "TxRx");
+		} else if (q_vector->rx.rx_ring) {
+			err = snprintf(q_vector->name, sizeof(q_vector->name) - 1,
+				       "%s-%s", basename, "rx");
+		} else if (q_vector->tx.tx_ring) {
+			err = snprintf(q_vector->name, sizeof(q_vector->name) - 1,
+				       "%s-%s", basename, "tx");
+		} else {
+			err = snprintf(q_vector->name, sizeof(q_vector->name) - 1,
+				       "%s", basename);
+		}
+		/* Catching the return quiets a Wformat-truncation complaint */
+		if (err > sizeof(q_vector->name) - 1)
+			netdev_dbg(vsi->netdev, "vector name truncated, ignore\n");
+	}
+}
+
+/**
+ * ice_tx_ring_unmap_qvec - Unmap tx ring from its current q_vector
+ * @tx_ring: rx ring to be removed
+ *
+ * Unmap tx ring from its current vector association in SW
+ */
+static void
+ice_tx_ring_unmap_qvec(struct ice_tx_ring *tx_ring)
+{
+	struct ice_q_vector *q_vector = tx_ring->q_vector;
+	struct ice_tx_ring *prev, *ring;
+
+	/* Remove a tx ring from its corresponding vector's ring container */
+	ring = q_vector->tx.tx_ring;
+	if (!ring)
+		return;
+
+	if (tx_ring == ring) {
+		q_vector->tx.tx_ring = tx_ring->next;
+		q_vector->num_ring_tx--;
+		return;
+	}
+
+	while (ring && ring != tx_ring) {
+		prev = ring;
+		ring = ring->next;
+	}
+	if (!ring)
+		return;
+	prev->next = ring->next;
+	q_vector->num_ring_tx--;
+}
+
+/**
+ * ice_rx_ring_unmap_qvec - Unmap rx ring from its current q_vector
+ * @rx_ring: rx ring to be removed
+ *
+ * Unmap rx ring from its current vector association in SW
+ */
+static void
+ice_rx_ring_unmap_qvec(struct ice_rx_ring *rx_ring)
+{
+	struct ice_q_vector *q_vector = rx_ring->q_vector;
+	struct ice_rx_ring *prev, *ring;
+
+	/* Remove a rx ring from its corresponding vector's ring container */
+	ring = q_vector->rx.rx_ring;
+	if (!ring)
+		return;
+
+	if (rx_ring == ring) {
+		q_vector->rx.rx_ring = rx_ring->next;
+		q_vector->num_ring_rx--;
+		return;
+	}
+
+	while (ring && ring != rx_ring) {
+		prev = ring;
+		ring = ring->next;
+	}
+	if (!ring)
+		return;
+	prev->next = ring->next;
+	q_vector->num_ring_rx--;
+}
+
+static int
+ice_tx_queue_update_q_vector(struct ice_vsi *vsi, u32 q_idx,
+			     struct ice_q_vector *new_qvec)
+{
+	struct ice_q_vector *old_qvec;
+	struct ice_tx_ring *tx_ring;
+	int timeout = 50;
+	int err;
+
+	if (q_idx >= vsi->num_txq)
+		return -EINVAL;
+	tx_ring = vsi->tx_rings[q_idx];
+	if (!tx_ring)
+		return -EINVAL;
+	old_qvec = tx_ring->q_vector;
+
+	if (old_qvec->irq.virq == new_qvec->irq.virq)
+		return 0;
+
+	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state)) {
+		timeout--;
+		if (!timeout)
+			return -EBUSY;
+		usleep_range(1000, 2000);
+	}
+
+	err = ice_q_vector_dis(vsi, old_qvec);
+	if (err)
+		return err;
+
+	ice_tx_ring_unmap_qvec(tx_ring);
+
+	/* free vector if it has no queues as all of its queues are now moved */
+	if (ice_is_q_vector_unused(old_qvec))
+		ice_qvec_free(vsi, old_qvec);
+
+	/* Prepare new q_vector if it was previously unused */
+	if (ice_is_q_vector_unused(new_qvec)) {
+		err = ice_qvec_prep(vsi, new_qvec);
+		if (err)
+			return err;
+	} else {
+		err = ice_q_vector_dis(vsi, new_qvec);
+		if (err)
+			return err;
+	}
+
+	tx_ring->q_vector = new_qvec;
+	tx_ring->next = new_qvec->tx.tx_ring;
+	new_qvec->tx.tx_ring = tx_ring;
+	new_qvec->num_ring_tx++;
+
+	err = ice_q_vector_ena(vsi, new_qvec);
+	if (err)
+		return err;
+
+	if (!ice_is_q_vector_unused(old_qvec)) {
+		err = ice_q_vector_ena(vsi, old_qvec);
+		if (err)
+			return err;
+	}
+
+	clear_bit(ICE_CFG_BUSY, vsi->state);
+
+	return 0;
+}
+
+static int
+ice_rx_queue_update_q_vector(struct ice_vsi *vsi, u32 q_idx,
+			     struct ice_q_vector *new_qvec)
+{
+	struct ice_q_vector *old_qvec;
+	struct ice_rx_ring *rx_ring;
+	int timeout = 50;
+	int err;
+
+	if (q_idx >= vsi->num_rxq)
+		return -EINVAL;
+	rx_ring = vsi->rx_rings[q_idx];
+	if (!rx_ring)
+		return -EINVAL;
+
+	old_qvec = rx_ring->q_vector;
+
+	if (old_qvec->irq.virq == new_qvec->irq.virq)
+		return 0;
+
+	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state)) {
+		timeout--;
+		if (!timeout)
+			return -EBUSY;
+		usleep_range(1000, 2000);
+	}
+
+	err = ice_q_vector_dis(vsi, old_qvec);
+	if (err)
+		return err;
+
+	ice_rx_ring_unmap_qvec(rx_ring);
+
+	/* free vector if it has no queues as all of its queues are now moved */
+	if (ice_is_q_vector_unused(old_qvec))
+		ice_qvec_free(vsi, old_qvec);
+
+	/* Prepare new q_vector if it was previously unused */
+	if (ice_is_q_vector_unused(new_qvec)) {
+		err = ice_qvec_prep(vsi, new_qvec);
+		if (err)
+			return err;
+	} else {
+		err = ice_q_vector_dis(vsi, new_qvec);
+		if (err)
+			return err;
+	}
+
+	rx_ring->q_vector = new_qvec;
+	rx_ring->next = new_qvec->rx.rx_ring;
+	new_qvec->rx.rx_ring = rx_ring;
+	new_qvec->num_ring_rx++;
+
+	err = ice_q_vector_ena(vsi, new_qvec);
+	if (err)
+		return err;
+
+	if (!ice_is_q_vector_unused(old_qvec)) {
+		err = ice_q_vector_ena(vsi, old_qvec);
+		if (err)
+			return err;
+	}
+
+	clear_bit(ICE_CFG_BUSY, vsi->state);
+
+	return 0;
+}
+
+/**
+ * ice_vsi_get_vector_from_irq
+ * @vsi: the VSI being configured
+ * @irq_num: Interrupt vector number
+ *
+ * Get the q_vector from the Linux interrupt vector number
+ */
+static struct ice_q_vector *
+ice_vsi_get_vector_from_irq(struct ice_vsi *vsi, int irq_num)
+{
+	int i;
+
+	ice_for_each_q_vector(vsi, i) {
+		if (vsi->q_vectors[i]->irq.virq == irq_num)
+			return vsi->q_vectors[i];
+	}
+	return NULL;
+}
+
+/**
+ * ice_queue_change_napi - Change the NAPI instance for the queue
+ * @dev: device to which NAPI and queue belong
+ * @q_idx: Index of queue
+ * @q_type: queue type as RX or TX
+ * @napi: NAPI context for the queue
+ */
+int ice_queue_change_napi(struct net_device *dev, u32 q_idx, u32 q_type,
+			  struct napi_struct *napi)
+{
+	struct ice_netdev_priv *np = netdev_priv(dev);
+	char int_name[ICE_INT_NAME_STR_LEN];
+	struct ice_q_vector *q_vector;
+	struct ice_vsi *vsi = np->vsi;
+	struct ice_pf *pf = vsi->back;
+	int err;
+
+	q_vector = ice_vsi_get_vector_from_irq(vsi, napi->irq);
+	if (!q_vector)
+		return -EINVAL;
+
+	switch (q_type) {
+	case NETDEV_QUEUE_TYPE_RX:
+		err = ice_rx_queue_update_q_vector(vsi, q_idx, q_vector);
+		if (err)
+			return err;
+		break;
+	case NETDEV_QUEUE_TYPE_TX:
+		err = ice_tx_queue_update_q_vector(vsi, q_idx, q_vector);
+		if (err)
+			return err;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snprintf(int_name, sizeof(int_name) - 1, "%s-%s",
+		 dev_driver_string(ice_pf_to_dev(pf)), vsi->netdev->name);
+	ice_vsi_rename_irq_msix(vsi, int_name);
+
+	/* Now report to the stack */
+	netif_queue_set_napi(dev, q_idx, q_type, napi);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 66a9709ff612..d53f399487bf 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -170,4 +170,6 @@ ice_is_q_vector_unused(struct ice_q_vector *q_vector)
 	return (!q_vector->num_ring_tx && !q_vector->num_ring_rx);
 }
 
+int ice_queue_change_napi(struct net_device *dev, u32 q_idx, u32 q_type,
+			  struct napi_struct *napi);
 #endif /* !_ICE_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0884b53a0b01..08c20f8b17e2 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9494,4 +9494,5 @@ static const struct net_device_ops ice_netdev_ops = {
 	.ndo_bpf = ice_xdp,
 	.ndo_xdp_xmit = ice_xdp_xmit,
 	.ndo_xsk_wakeup = ice_xsk_wakeup,
+	.ndo_queue_set_napi = ice_queue_change_napi,
 };


