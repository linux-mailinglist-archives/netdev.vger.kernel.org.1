Return-Path: <netdev+bounces-150830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6E79EBAD9
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CC51888999
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA482228C9A;
	Tue, 10 Dec 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bc7dUHnf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24702228384
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862455; cv=none; b=aqTRgddMe/e0mSGwV+3kiqd3i3ITpndPXZATIhCd1iiA/FmR2F5ttZthTYhKji1JOXJoKZytEN/U6GbHF4m42nGwiw2a3LIYTdJEjk6q4NrjWsSkDd1Z96tmSByaKcv5LqnjP355nXV1oRxjbaXtoXz6ojfRu7Cfa3B9IeA5Mw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862455; c=relaxed/simple;
	bh=IkXx8ftQSJ88xgscRSgBQC1zidnBLzSaz832fqO38xU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQEqw2zJbX6A0bGot5UXhyWpJfUXhfa1arcHDMnJBYU9xB6gItY5MMuJhJNxQ5kfROu/dbFXpjTV8QAee7ymUIjSD/x/j2XG9o7xp0mC0Dv1Fpg+lrYgUmyFmuxTBAryEeongncdrof4dOjkbfMnaVxWt1NMRl6+Cx5kXdp5iic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bc7dUHnf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733862454; x=1765398454;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=IkXx8ftQSJ88xgscRSgBQC1zidnBLzSaz832fqO38xU=;
  b=Bc7dUHnfAb6kdEKH4tiD9JMaTcIGOJ0mOr7/OQN4YcN3kDIgjc0b6pvk
   D+EoMvPcGplYKSStXLXQEOU8JyA2B9UJ8bTGh7PEdBXctkR96OMzvoqZa
   ufRKzTPorRfrt0ibEP5eqMRMeh6FdJro7NdYub/lpCK8vhz7jCiqbeiRb
   iETCx/pl7DjoujMGIe/26T7lhQkmJJGNvbOItn8sUMR5uYHaSEg/jk1DX
   mT5MYB3IFPWZKme3qh/lv+FxpfsXtWnTLs8wdiupq8w/vO8KlJOlZAhRG
   UJQyZW9snc3bwiFankyPi5MoaiNJiJH91w8nfZb/wSVFhCCTMq1WfBvEu
   w==;
X-CSE-ConnectionGUID: jueRJmqUS0+y/aXTjNTaNg==
X-CSE-MsgGUID: RPgJKVQmSL6Zwiu2eWOnlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34147320"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="34147320"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:27:29 -0800
X-CSE-ConnectionGUID: pO8EkNsTSlOul9WnGQWaAw==
X-CSE-MsgGUID: KwXzKjDJRlyZGaXGQ5xPGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="126424101"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:27:28 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 10 Dec 2024 12:27:17 -0800
Subject: [PATCH net-next v10 08/10] ice: reduce size of queue context
 fields
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-packing-pack-fields-and-ice-implementation-v10-8-ee56a47479ac@intel.com>
References: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
In-Reply-To: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

The ice_rlan_ctx and ice_tlan_ctx structures have some fields which are
intentionally sized larger than necessary relative to the packed sizes the
data must fit into. This was done because the original ice_set_ctx()
function and its helpers did not correctly handle packing when the packed
bits straddled a byte. This is no longer the case with the use of the
<linux/packing.h> implementation.

Save some bytes in these structures by sizing the variables to the number
of bytes the actual bitpacked fields fit into.

There are a couple of gaps left in the structure, which is a result of the
fields being in the order they appear in the packed bit layout, but where
alignment forces some extra gaps. We could fix this, saving ~8 bytes from
each structure. However, these structures are not used heavily, and the
resulting savings is minimal:

$ bloat-o-meter ice-before-reorder.ko ice-after-reorder.ko
add/remove: 0/0 grow/shrink: 1/1 up/down: 26/-70 (-44)
Function                                     old     new   delta
ice_vsi_cfg_txq                             1873    1899     +26
ice_setup_rx_ctx.constprop                  1529    1459     -70
Total: Before=1459555, After=1459511, chg -0.00%

Thus, the fields are left in the same order as the packed bit layout,
despite the gaps this causes.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 32 ++++++++------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index 31d4a445d640df21c2aa007ffbd4f2310da264ad..1479b45738af15bf6e00aed24b2c6a3f91675f4d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -375,23 +375,17 @@ enum ice_rx_flex_desc_status_error_1_bits {
 #define ICE_TX_DRBELL_Q_CTX_SIZE_DWORDS	5
 #define GLTCLAN_CQ_CNTX(i, CQ)		(GLTCLAN_CQ_CNTX0(CQ) + ((i) * 0x0800))
 
-/* RLAN Rx queue context data
- *
- * The sizes of the variables may be larger than needed due to crossing byte
- * boundaries. If we do not have the width of the variable set to the correct
- * size then we could end up shifting bits off the top of the variable when the
- * variable is at the top of a byte and crosses over into the next byte.
- */
+/* RLAN Rx queue context data */
 struct ice_rlan_ctx {
 	u16 head;
-	u16 cpuid; /* bigger than needed, see above for reason */
+	u8 cpuid;
 #define ICE_RLAN_BASE_S 7
 	u64 base;
 	u16 qlen;
 #define ICE_RLAN_CTX_DBUF_S 7
-	u16 dbuf; /* bigger than needed, see above for reason */
+	u8 dbuf;
 #define ICE_RLAN_CTX_HBUF_S 6
-	u16 hbuf; /* bigger than needed, see above for reason */
+	u8 hbuf;
 	u8 dtype;
 	u8 dsize;
 	u8 crcstrip;
@@ -399,12 +393,12 @@ struct ice_rlan_ctx {
 	u8 hsplit_0;
 	u8 hsplit_1;
 	u8 showiv;
-	u32 rxmax; /* bigger than needed, see above for reason */
+	u16 rxmax;
 	u8 tphrdesc_ena;
 	u8 tphwdesc_ena;
 	u8 tphdata_ena;
 	u8 tphhead_ena;
-	u16 lrxqthresh; /* bigger than needed, see above for reason */
+	u8 lrxqthresh;
 	u8 prefena;	/* NOTE: normally must be set to 1 at init */
 };
 
@@ -535,18 +529,12 @@ enum ice_tx_ctx_desc_eipt_offload {
 #define ICE_LAN_TXQ_MAX_QGRPS	127
 #define ICE_LAN_TXQ_MAX_QDIS	1023
 
-/* Tx queue context data
- *
- * The sizes of the variables may be larger than needed due to crossing byte
- * boundaries. If we do not have the width of the variable set to the correct
- * size then we could end up shifting bits off the top of the variable when the
- * variable is at the top of a byte and crosses over into the next byte.
- */
+/* Tx queue context data */
 struct ice_tlan_ctx {
 #define ICE_TLAN_CTX_BASE_S	7
 	u64 base;		/* base is defined in 128-byte units */
 	u8 port_num;
-	u16 cgd_num;		/* bigger than needed, see above for reason */
+	u8 cgd_num;
 	u8 pf_num;
 	u16 vmvf_num;
 	u8 vmvf_type;
@@ -557,7 +545,7 @@ struct ice_tlan_ctx {
 	u8 tsyn_ena;
 	u8 internal_usage_flag;
 	u8 alt_vlan;
-	u16 cpuid;		/* bigger than needed, see above for reason */
+	u8 cpuid;
 	u8 wb_mode;
 	u8 tphrd_desc;
 	u8 tphrd;
@@ -566,7 +554,7 @@ struct ice_tlan_ctx {
 	u16 qnum_in_func;
 	u8 itr_notification_mode;
 	u8 adjust_prof_id;
-	u32 qlen;		/* bigger than needed, see above for reason */
+	u16 qlen;
 	u8 quanta_prof_idx;
 	u8 tso_ena;
 	u16 tso_qnum;

-- 
2.47.0.265.g4ca455297942


