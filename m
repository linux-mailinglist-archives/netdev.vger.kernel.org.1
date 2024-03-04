Return-Path: <netdev+bounces-77249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7724870CEF
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AFC1C2404A
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163457BB0C;
	Mon,  4 Mar 2024 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jp/q4koY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B3482DA
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587784; cv=none; b=uuMCbVom6FdTAEffcnLHZn5CKYuGXDQK3SK2okf5n0IafJCfsMKdJ8Q8NWjuG/P2GS/EK6rmwRiZrIKq3itvHn0BNJfSUK1a7vjiObZHg6LGRsqRix9DNeapZaxf69ATaOz1FCixk+ynSYJVKoPI8eEdlADy5Xjf4aH9JlngApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587784; c=relaxed/simple;
	bh=rpmLH4pEdfWvfr+kNPw2xpsJHV25d/ERV0Bvi6LjmWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lerbKsnRSyvPkWPk16htmZiymOoHvvkKegYt9rptRWqaQY5AtEf3XdL28xa2Js9lrZeFxLKottEtpSgYIV8fxpS4nUHKaZI9zJL4Ym5B5NAASdmEjLjeygu46JIy4maz2NJZekG9fLx91W++jL0taDLliCzxO/PYAy52o/MMb+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jp/q4koY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709587781; x=1741123781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rpmLH4pEdfWvfr+kNPw2xpsJHV25d/ERV0Bvi6LjmWY=;
  b=jp/q4koYSnE5/Ney6IoDz+jAYPLjeHMH4VB55VL3RJLQsMn8ZS4V0OpM
   3I19zkmRccPr8eVzSpWQKkexDriS2K2NxnNvZnBKDxcYla6fMEbgma/He
   /xi+ice/RRaXIXeUmF2V3EC2OMREOyVtf/OhGeGsLyBVHAM4s0cCcanXC
   KQPNr+pYXUpBXsHvhzPi2xFCHqmmRp9e3N38x7jpQ4hUEw/ish+GPrdpr
   21NPOj5duj/FBnTQOTdOwJDgufge8D6oIoYjgWE8jM2rgo8KisVhu/v4U
   Cl3t530PShJljzUPBEOwLFIoNAMozTBe+8742yOCeGytiHtiDnleifp4a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3968061"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="3968061"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="46647869"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 04 Mar 2024 13:29:40 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 1/9] ice: pass VSI pointer into ice_vc_isvalid_q_id
Date: Mon,  4 Mar 2024 13:29:22 -0800
Message-ID: <20240304212932.3412641-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240304212932.3412641-1-anthony.l.nguyen@intel.com>
References: <20240304212932.3412641-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_vc_isvalid_q_id() function takes a VSI index and a queue ID. It
looks up the VSI from its index, and then validates that the queue number
is valid for that VSI.

The VSI ID passed is typically a VSI index from the VF. This VSI number is
validated by the PF to ensure that it matches the VSI associated with the
VF already.

In every flow where ice_vc_isvalid_q_id() is called, the PF driver already
has a pointer to the VSI associated with the VF. This pointer is obtained
using ice_get_vf_vsi(), rather than looking up the VSI using the index sent
by the VF.

Since we already know which VSI to operate on, we can modify
ice_vc_isvalid_q_id() to take a VSI pointer instead of a VSI index. Pass
the VSI we found from ice_get_vf_vsi() instead of re-doing the lookup. This
removes some unnecessary computation and scanning of the VSI list.

It also removes the last place where the driver directly used the VSI
number from the VF. This will pave the way for refactoring to communicate
relative VSI numbers to the VF instead of absolute numbers from the PF
space.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index c925813ec9ca..3dd4e5af0b6a 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -562,17 +562,15 @@ bool ice_vc_isvalid_vsi_id(struct ice_vf *vf, u16 vsi_id)
 
 /**
  * ice_vc_isvalid_q_id
- * @vf: pointer to the VF info
- * @vsi_id: VSI ID
+ * @vsi: VSI to check queue ID against
  * @qid: VSI relative queue ID
  *
  * check for the valid queue ID
  */
-static bool ice_vc_isvalid_q_id(struct ice_vf *vf, u16 vsi_id, u8 qid)
+static bool ice_vc_isvalid_q_id(struct ice_vsi *vsi, u8 qid)
 {
-	struct ice_vsi *vsi = ice_find_vsi(vf->pf, vsi_id);
 	/* allocated Tx and Rx queues should be always equal for VF VSI */
-	return (vsi && (qid < vsi->alloc_txq));
+	return qid < vsi->alloc_txq;
 }
 
 /**
@@ -1330,7 +1328,7 @@ static int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 	 */
 	q_map = vqs->rx_queues;
 	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
-		if (!ice_vc_isvalid_q_id(vf, vqs->vsi_id, vf_q_id)) {
+		if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
 		}
@@ -1352,7 +1350,7 @@ static int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 
 	q_map = vqs->tx_queues;
 	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
-		if (!ice_vc_isvalid_q_id(vf, vqs->vsi_id, vf_q_id)) {
+		if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
 		}
@@ -1457,7 +1455,7 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 		q_map = vqs->tx_queues;
 
 		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
-			if (!ice_vc_isvalid_q_id(vf, vqs->vsi_id, vf_q_id)) {
+			if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 				goto error_param;
 			}
@@ -1483,7 +1481,7 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 		bitmap_zero(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF);
 	} else if (q_map) {
 		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
-			if (!ice_vc_isvalid_q_id(vf, vqs->vsi_id, vf_q_id)) {
+			if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 				goto error_param;
 			}
@@ -1539,7 +1537,7 @@ ice_cfg_interrupt(struct ice_vf *vf, struct ice_vsi *vsi, u16 vector_id,
 	for_each_set_bit(vsi_q_id_idx, &qmap, ICE_MAX_RSS_QS_PER_VF) {
 		vsi_q_id = vsi_q_id_idx;
 
-		if (!ice_vc_isvalid_q_id(vf, vsi->vsi_num, vsi_q_id))
+		if (!ice_vc_isvalid_q_id(vsi, vsi_q_id))
 			return VIRTCHNL_STATUS_ERR_PARAM;
 
 		q_vector->num_ring_rx++;
@@ -1553,7 +1551,7 @@ ice_cfg_interrupt(struct ice_vf *vf, struct ice_vsi *vsi, u16 vector_id,
 	for_each_set_bit(vsi_q_id_idx, &qmap, ICE_MAX_RSS_QS_PER_VF) {
 		vsi_q_id = vsi_q_id_idx;
 
-		if (!ice_vc_isvalid_q_id(vf, vsi->vsi_num, vsi_q_id))
+		if (!ice_vc_isvalid_q_id(vsi, vsi_q_id))
 			return VIRTCHNL_STATUS_ERR_PARAM;
 
 		q_vector->num_ring_tx++;
@@ -1710,7 +1708,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 		    qpi->txq.headwb_enabled ||
 		    !ice_vc_isvalid_ring_len(qpi->txq.ring_len) ||
 		    !ice_vc_isvalid_ring_len(qpi->rxq.ring_len) ||
-		    !ice_vc_isvalid_q_id(vf, qci->vsi_id, qpi->txq.queue_id)) {
+		    !ice_vc_isvalid_q_id(vsi, qpi->txq.queue_id)) {
 			goto error_param;
 		}
 
-- 
2.41.0


