Return-Path: <netdev+bounces-37499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ED37B5B08
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 21:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B07A11C20970
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 19:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0FD1F5E5;
	Mon,  2 Oct 2023 19:16:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1405F1A719
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 19:15:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362C4DD
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696274156; x=1727810156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DTakvPF5tMhEivvUnEgZ9Fh23wZJj2dk6QWO26hDh+Q=;
  b=Oof4hx36IRgwF6z+YqSlsNCQ0o8Gy5xMFEvHjK4Z9incX+U2sfrq/XfZ
   uGlosPUHMHASkS/+UnI69WQKuxVE5hDLEBNh5yL5x1qdBLy2ogAqrfPkA
   yZKBKKjv7cG8bF6cX2AQWXORStI5t9ToTu+klP1SOM7cFNDPeQFTKWmbC
   Oh0BJ9Sk7UsVqmdX/uIhhl8fvgTglO0XznPszLbRY1dxuvISaQ5svkbWA
   9MI6WL6Gxjev/c871BpNfhQBYzsRs+UjIGUHVnszKanaTfV0YaQ1CfREf
   7j1AYRBOrlXCHEbm+qKf95ivxS9Q4KyYAiGmG78OMKoNCU4dFf9P5Pr7+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="373055034"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="373055034"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 11:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="780011939"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="780011939"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 02 Oct 2023 11:51:29 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next 2/3] iavf: remove "inline" functions from iavf_txrx.c
Date: Mon,  2 Oct 2023 11:50:33 -0700
Message-Id: <20231002185034.1575127-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231002185034.1575127-1-anthony.l.nguyen@intel.com>
References: <20231002185034.1575127-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jacob Keller <jacob.e.keller@intel.com>

The iAVF txrx hotpath code has several functions that are marked as
"static inline" in the iavf_txrx.c file. This use of inline is frowned
upon in the netdev community and explicitly marked as something to avoid
in the Linux coding-style document (section 15).

Even though these functions are only used once, it is expected that GCC
is smart enough to decide when to perform function inlining where
appropriate without the "hint".

./scripts/bloat-o-meter is showing zero difference with this changes.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 46 ++++++++++-----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 8c5f6096b002..d64c4997136b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -7,8 +7,8 @@
 #include "iavf_trace.h"
 #include "iavf_prototype.h"
 
-static inline __le64 build_ctob(u32 td_cmd, u32 td_offset, unsigned int size,
-				u32 td_tag)
+static __le64 build_ctob(u32 td_cmd, u32 td_offset, unsigned int size,
+			 u32 td_tag)
 {
 	return cpu_to_le64(IAVF_TX_DESC_DTYPE_DATA |
 			   ((u64)td_cmd  << IAVF_TXD_QW1_CMD_SHIFT) |
@@ -370,8 +370,8 @@ static void iavf_enable_wb_on_itr(struct iavf_vsi *vsi,
 	q_vector->arm_wb_state = true;
 }
 
-static inline bool iavf_container_is_rx(struct iavf_q_vector *q_vector,
-					struct iavf_ring_container *rc)
+static bool iavf_container_is_rx(struct iavf_q_vector *q_vector,
+				 struct iavf_ring_container *rc)
 {
 	return &q_vector->rx == rc;
 }
@@ -806,7 +806,7 @@ int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
  * @rx_ring: ring to bump
  * @val: new head index
  **/
-static inline void iavf_release_rx_desc(struct iavf_ring *rx_ring, u32 val)
+static void iavf_release_rx_desc(struct iavf_ring *rx_ring, u32 val)
 {
 	rx_ring->next_to_use = val;
 
@@ -828,7 +828,7 @@ static inline void iavf_release_rx_desc(struct iavf_ring *rx_ring, u32 val)
  *
  * Returns the offset value for ring into the data buffer.
  */
-static inline unsigned int iavf_rx_offset(struct iavf_ring *rx_ring)
+static unsigned int iavf_rx_offset(struct iavf_ring *rx_ring)
 {
 	return ring_uses_build_skb(rx_ring) ? IAVF_SKB_PAD : 0;
 }
@@ -977,9 +977,9 @@ bool iavf_alloc_rx_buffers(struct iavf_ring *rx_ring, u16 cleaned_count)
  * @skb: skb currently being received and modified
  * @rx_desc: the receive descriptor
  **/
-static inline void iavf_rx_checksum(struct iavf_vsi *vsi,
-				    struct sk_buff *skb,
-				    union iavf_rx_desc *rx_desc)
+static void iavf_rx_checksum(struct iavf_vsi *vsi,
+			     struct sk_buff *skb,
+			     union iavf_rx_desc *rx_desc)
 {
 	struct iavf_rx_ptype_decoded decoded;
 	u32 rx_error, rx_status;
@@ -1061,7 +1061,7 @@ static inline void iavf_rx_checksum(struct iavf_vsi *vsi,
  *
  * Returns a hash type to be used by skb_set_hash
  **/
-static inline int iavf_ptype_to_htype(u8 ptype)
+static int iavf_ptype_to_htype(u8 ptype)
 {
 	struct iavf_rx_ptype_decoded decoded = decode_rx_desc_ptype(ptype);
 
@@ -1085,10 +1085,10 @@ static inline int iavf_ptype_to_htype(u8 ptype)
  * @skb: skb currently being received and modified
  * @rx_ptype: Rx packet type
  **/
-static inline void iavf_rx_hash(struct iavf_ring *ring,
-				union iavf_rx_desc *rx_desc,
-				struct sk_buff *skb,
-				u8 rx_ptype)
+static void iavf_rx_hash(struct iavf_ring *ring,
+			 union iavf_rx_desc *rx_desc,
+			 struct sk_buff *skb,
+			 u8 rx_ptype)
 {
 	u32 hash;
 	const __le64 rss_mask =
@@ -1115,10 +1115,10 @@ static inline void iavf_rx_hash(struct iavf_ring *ring,
  * order to populate the hash, checksum, VLAN, protocol, and
  * other fields within the skb.
  **/
-static inline
-void iavf_process_skb_fields(struct iavf_ring *rx_ring,
-			     union iavf_rx_desc *rx_desc, struct sk_buff *skb,
-			     u8 rx_ptype)
+static void
+iavf_process_skb_fields(struct iavf_ring *rx_ring,
+			union iavf_rx_desc *rx_desc, struct sk_buff *skb,
+			u8 rx_ptype)
 {
 	iavf_rx_hash(rx_ring, rx_desc, skb, rx_ptype);
 
@@ -1662,8 +1662,8 @@ static inline u32 iavf_buildreg_itr(const int type, u16 itr)
  * @q_vector: q_vector for which itr is being updated and interrupt enabled
  *
  **/
-static inline void iavf_update_enable_itr(struct iavf_vsi *vsi,
-					  struct iavf_q_vector *q_vector)
+static void iavf_update_enable_itr(struct iavf_vsi *vsi,
+				   struct iavf_q_vector *q_vector)
 {
 	struct iavf_hw *hw = &vsi->back->hw;
 	u32 intval;
@@ -2275,9 +2275,9 @@ int __iavf_maybe_stop_tx(struct iavf_ring *tx_ring, int size)
  * @td_cmd:   the command field in the descriptor
  * @td_offset: offset for checksum or crc
  **/
-static inline void iavf_tx_map(struct iavf_ring *tx_ring, struct sk_buff *skb,
-			       struct iavf_tx_buffer *first, u32 tx_flags,
-			       const u8 hdr_len, u32 td_cmd, u32 td_offset)
+static void iavf_tx_map(struct iavf_ring *tx_ring, struct sk_buff *skb,
+			struct iavf_tx_buffer *first, u32 tx_flags,
+			const u8 hdr_len, u32 td_cmd, u32 td_offset)
 {
 	unsigned int data_len = skb->data_len;
 	unsigned int size = skb_headlen(skb);
-- 
2.38.1


