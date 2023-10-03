Return-Path: <netdev+bounces-37811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECED7B742A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 00:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 5CC5EB209C0
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 22:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622573E48E;
	Tue,  3 Oct 2023 22:37:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B45379
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 22:37:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29716B0
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696372635; x=1727908635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DTakvPF5tMhEivvUnEgZ9Fh23wZJj2dk6QWO26hDh+Q=;
  b=DmyTsz6A1ad60wPPempIpBn5ehYBJ0G+ZY0qIfPU+o3PZKFVx5kOMQk/
   bDR5FtkRZnt7hffzAamoVzaojyea2HzzfwcNtOksfRgsBy55WtqzpFac5
   78epxunMkZ34UampVYLtPsFrGWEcu62d54sSIbqL7B9bHTirF6z0CQ+e4
   mQm2HiSNdHlNgP5YIR0MzHcEtJPOJ5f1i2ENzPi/PXeJoLxp3z0g3bYKi
   cnc5XMfsq9EUOXo/R25qQD6NZBkTAr5q7WOe8BcpWwxOhykLekjtbtQ/o
   B/z6+VSPtCqNpY7X7qzHlvtOh3CjETLczQGFCwueIPX3EIPAdsvJyA//M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="386865673"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="386865673"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 15:37:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="751057800"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="751057800"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 03 Oct 2023 15:37:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v2 2/2] iavf: remove "inline" functions from iavf_txrx.c
Date: Tue,  3 Oct 2023 15:36:10 -0700
Message-Id: <20231003223610.2004976-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231003223610.2004976-1-anthony.l.nguyen@intel.com>
References: <20231003223610.2004976-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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


