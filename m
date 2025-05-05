Return-Path: <netdev+bounces-187834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E25AA9D0B
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 22:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99EC317AF0B
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 20:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1C326FDB4;
	Mon,  5 May 2025 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJVBry6l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3135A266577
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746476084; cv=none; b=tslyeL4WvGJL0q3c/s9KrnMcEeMe2AAaDja2PsTWgM7B5Zc5d8gP8OmOXwCEEzdN2UL9KxlKKX2p5uTrKPWniPSGMgfOdMtwayczgvDQUYQWz7RpyDM+D/eW33pHafZPXNQgvwD6DFbtQzBz8GbUDf4E6fWdCbrnbXuBTdlWhX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746476084; c=relaxed/simple;
	bh=35U0jnYMXpEtI4C/gbBRDo9IKVVJFEZ3lPZv9xq87AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nk7JaKb9DSiOl1U4qNtvoQtQSsDEkj03ajKDW1KtKlosQhW7ikBbjTo+LQAf2TpojxKoj1jC08eQ699pB7Yjxj3+pjWxKLjg91kfT1/C6qSrF6LABWG1BchBNVpLpu+WNyreIm9bJ3g0Fd50RwI6xbaVb00DaYMVJXRpkX6s2RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJVBry6l; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746476082; x=1778012082;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=35U0jnYMXpEtI4C/gbBRDo9IKVVJFEZ3lPZv9xq87AY=;
  b=VJVBry6lFAjvoICJNTdST+lg0nmrCUg0QJ2Fad4+P3yrCPwtbDhvZJuw
   QrX+wEhiFHtYJd0lt0p+3JI/qnwvxRaoPiPbYOmmPx0+EPjOjA0wkY0gP
   2HezpQbFdV5ab2+jGmS9YW/uxUifDxeObmnB9ab8v/fZ7soA54mbmAPM1
   JAparcQApUwAo/v2XXWVHSPuXaxFEd+q2iE4NE6XClPS5ekM/ogYRjniI
   30OTHzjtXoxmSgeFG/crAENHCdF+jJ5+KZIyqCHegIsuzxChLqWCy0Yfl
   L7CG00hVJSkASX/uOH5fKCdbdRTJaTmcq+4N6BXApyFPbe2RVZor2ts+k
   g==;
X-CSE-ConnectionGUID: c7Kyh5hXSYiZJ8dnUh+xSg==
X-CSE-MsgGUID: 8QDh7KiTQhOHFzEsAb0ITg==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="65635327"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="65635327"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 13:14:39 -0700
X-CSE-ConnectionGUID: d1MH01leTkKw+CqZ5yvdbg==
X-CSE-MsgGUID: QYExkGeTQaK3Zfe0bSiJ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="158593555"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 13:14:39 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 05 May 2025 13:14:22 -0700
Subject: [PATCH iwl-next v2 1/2] net: intel: rename 'hena' to 'hashcfg' for
 clarity
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-jk-hash-ena-refactor-v2-1-c1f62aee1ffe@intel.com>
References: <20250505-jk-hash-ena-refactor-v2-0-c1f62aee1ffe@intel.com>
In-Reply-To: <20250505-jk-hash-ena-refactor-v2-0-c1f62aee1ffe@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2

i40e, ice, and iAVF all use 'hena' as a shorthand for the "hash enable"
configuration. This comes originally from the X710 datasheet 'xxQF_HENA'
registers. In the context of the registers the meaning is fairly clear.

However, on its own, hena is a weird name that can be more difficult to
understand. This is especially true in ice. The E810 hardware doesn't even
have registers with HENA in the name.

Replace the shorthand 'hena' with 'hashcfg'. This makes it clear the
variables deal with the Hash configuration, not just a single boolean
on/off for all hashing.

Do not update the register names. These come directly from the datasheet
for X710 and X722, and it is more important that the names can be searched.

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  8 ++--
 drivers/net/ethernet/intel/iavf/iavf.h             | 10 ++---
 drivers/net/ethernet/intel/iavf/iavf_txrx.h        |  4 +-
 drivers/net/ethernet/intel/ice/ice_flow.h          |  4 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h      |  4 +-
 include/linux/avf/virtchnl.h                       | 22 +++++------
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 46 +++++++++++-----------
 drivers/net/ethernet/intel/iavf/iavf_main.c        | 17 ++++----
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    | 33 ++++++++--------
 drivers/net/ethernet/intel/ice/ice_lib.c           |  2 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      | 44 ++++++++++-----------
 .../ethernet/intel/ice/ice_virtchnl_allowlist.c    |  2 +-
 13 files changed, 101 insertions(+), 97 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 7c26c9a2bf65d03285516da1e9ae8ec6e4de51a2..b007a84268a7ba0378bb6a99012be2cb2beb7e1e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -71,7 +71,7 @@ enum i40e_dyn_idx {
 #define I40E_SW_ITR    I40E_IDX_ITR2
 
 /* Supported RSS offloads */
-#define I40E_DEFAULT_RSS_HENA ( \
+#define I40E_DEFAULT_RSS_HASHCFG ( \
 	BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_UDP) | \
 	BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_SCTP) | \
 	BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_TCP) | \
@@ -84,7 +84,7 @@ enum i40e_dyn_idx {
 	BIT_ULL(I40E_FILTER_PCTYPE_FRAG_IPV6) | \
 	BIT_ULL(I40E_FILTER_PCTYPE_L2_PAYLOAD))
 
-#define I40E_DEFAULT_RSS_HENA_EXPANDED (I40E_DEFAULT_RSS_HENA | \
+#define I40E_DEFAULT_RSS_HASHCFG_EXPANDED (I40E_DEFAULT_RSS_HASHCFG | \
 	BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_TCP_SYN_NO_ACK) | \
 	BIT_ULL(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV4_UDP) | \
 	BIT_ULL(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV4_UDP) | \
@@ -92,9 +92,9 @@ enum i40e_dyn_idx {
 	BIT_ULL(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP) | \
 	BIT_ULL(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP))
 
-#define i40e_pf_get_default_rss_hena(pf) \
+#define i40e_pf_get_default_rss_hashcfg(pf) \
 	(test_bit(I40E_HW_CAP_MULTI_TCP_UDP_RSS_PCTYPE, (pf)->hw.caps) ? \
-	 I40E_DEFAULT_RSS_HENA_EXPANDED : I40E_DEFAULT_RSS_HENA)
+	 I40E_DEFAULT_RSS_HASHCFG_EXPANDED : I40E_DEFAULT_RSS_HASHCFG)
 
 /* Supported Rx Buffer Sizes (a multiple of 128) */
 #define I40E_RXBUFFER_256   256
diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 9de3e0ba37316c801bc8300e9eaf1a81502abcbd..ae07344cd1b8de17ec9a20899cde757ffa5f8674 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -316,8 +316,8 @@ struct iavf_adapter {
 #define IAVF_FLAG_AQ_CONFIGURE_RSS		BIT_ULL(9) /* direct AQ config */
 #define IAVF_FLAG_AQ_GET_CONFIG			BIT_ULL(10)
 /* Newer style, RSS done by the PF so we can ignore hardware vagaries. */
-#define IAVF_FLAG_AQ_GET_HENA			BIT_ULL(11)
-#define IAVF_FLAG_AQ_SET_HENA			BIT_ULL(12)
+#define IAVF_FLAG_AQ_GET_RSS_HASHCFG		BIT_ULL(11)
+#define IAVF_FLAG_AQ_SET_RSS_HASHCFG		BIT_ULL(12)
 #define IAVF_FLAG_AQ_SET_RSS_KEY		BIT_ULL(13)
 #define IAVF_FLAG_AQ_SET_RSS_LUT		BIT_ULL(14)
 #define IAVF_FLAG_AQ_SET_RSS_HFUNC		BIT_ULL(15)
@@ -457,7 +457,7 @@ struct iavf_adapter {
 	u32 aq_wait_count;
 	/* RSS stuff */
 	enum virtchnl_rss_algorithm hfunc;
-	u64 hena;
+	u64 rss_hashcfg;
 	u16 rss_key_size;
 	u16 rss_lut_size;
 	u8 *rss_key;
@@ -601,8 +601,8 @@ void iavf_set_promiscuous(struct iavf_adapter *adapter);
 bool iavf_promiscuous_mode_changed(struct iavf_adapter *adapter);
 void iavf_request_stats(struct iavf_adapter *adapter);
 int iavf_request_reset(struct iavf_adapter *adapter);
-void iavf_get_hena(struct iavf_adapter *adapter);
-void iavf_set_hena(struct iavf_adapter *adapter);
+void iavf_get_rss_hashcfg(struct iavf_adapter *adapter);
+void iavf_set_rss_hashcfg(struct iavf_adapter *adapter);
 void iavf_set_rss_key(struct iavf_adapter *adapter);
 void iavf_set_rss_lut(struct iavf_adapter *adapter);
 void iavf_set_rss_hfunc(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index 79ad554f2d53b35bf91a91bb9ab0cb2b8f52e7df..94b324f212bd9c909e3bc1c9d9f68c6e8f0ee994 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -59,7 +59,7 @@ enum iavf_dyn_idx_t {
 #define IAVF_PE_ITR    IAVF_IDX_ITR2
 
 /* Supported RSS offloads */
-#define IAVF_DEFAULT_RSS_HENA ( \
+#define IAVF_DEFAULT_RSS_HASHCFG ( \
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_IPV4_UDP) | \
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_IPV4_SCTP) | \
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_IPV4_TCP) | \
@@ -72,7 +72,7 @@ enum iavf_dyn_idx_t {
 	BIT_ULL(IAVF_FILTER_PCTYPE_FRAG_IPV6) | \
 	BIT_ULL(IAVF_FILTER_PCTYPE_L2_PAYLOAD))
 
-#define IAVF_DEFAULT_RSS_HENA_EXPANDED (IAVF_DEFAULT_RSS_HENA | \
+#define IAVF_DEFAULT_RSS_HASHCFG_EXPANDED (IAVF_DEFAULT_RSS_HASHCFG | \
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_IPV4_TCP_SYN_NO_ACK) | \
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_UNICAST_IPV4_UDP) | \
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_MULTICAST_IPV4_UDP) | \
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/ethernet/intel/ice/ice_flow.h
index 6cb7bb879c98ead000fb30e8223beb698d60a2c4..b1313fb61677f0bbfedfb937a5ce3f87d4adc9e1 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.h
+++ b/drivers/net/ethernet/intel/ice/ice_flow.h
@@ -295,10 +295,10 @@ enum ice_flow_avf_hdr_field {
 };
 
 /* Supported RSS offloads  This macro is defined to support
- * VIRTCHNL_OP_GET_RSS_HENA_CAPS ops. PF driver sends the RSS hardware
+ * VIRTCHNL_OP_GET_RSS_HASHCFG_CAPS ops. PF driver sends the RSS hardware
  * capabilities to the caller of this ops.
  */
-#define ICE_DEFAULT_RSS_HENA ( \
+#define ICE_DEFAULT_RSS_HASHCFG ( \
 	BIT_ULL(ICE_AVF_FLOW_FIELD_IPV4_UDP) | \
 	BIT_ULL(ICE_AVF_FLOW_FIELD_IPV4_SCTP) | \
 	BIT_ULL(ICE_AVF_FLOW_FIELD_IPV4_TCP) | \
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.h b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
index 222990f229d5ed0810da5dda3ec5990895ff6f4a..b3eece8c67804a808e51875a975be2176b1cab37 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
@@ -57,8 +57,8 @@ struct ice_virtchnl_ops {
 	int (*add_vlan_msg)(struct ice_vf *vf, u8 *msg);
 	int (*remove_vlan_msg)(struct ice_vf *vf, u8 *msg);
 	int (*query_rxdid)(struct ice_vf *vf);
-	int (*get_rss_hena)(struct ice_vf *vf);
-	int (*set_rss_hena_msg)(struct ice_vf *vf, u8 *msg);
+	int (*get_rss_hashcfg)(struct ice_vf *vf);
+	int (*set_rss_hashcfg)(struct ice_vf *vf, u8 *msg);
 	int (*ena_vlan_stripping)(struct ice_vf *vf);
 	int (*dis_vlan_stripping)(struct ice_vf *vf);
 	int (*handle_rss_cfg_msg)(struct ice_vf *vf, u8 *msg, bool add);
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index cf0afa60e4a7b25476504138bba96f3c51b87177..362d1cdc8cd8adc99467ebb1f7e6e28b1817f7cb 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -132,8 +132,8 @@ enum virtchnl_ops {
 	VIRTCHNL_OP_RELEASE_RDMA_IRQ_MAP = VIRTCHNL_OP_RELEASE_IWARP_IRQ_MAP,
 	VIRTCHNL_OP_CONFIG_RSS_KEY = 23,
 	VIRTCHNL_OP_CONFIG_RSS_LUT = 24,
-	VIRTCHNL_OP_GET_RSS_HENA_CAPS = 25,
-	VIRTCHNL_OP_SET_RSS_HENA = 26,
+	VIRTCHNL_OP_GET_RSS_HASHCFG_CAPS = 25,
+	VIRTCHNL_OP_SET_RSS_HASHCFG = 26,
 	VIRTCHNL_OP_ENABLE_VLAN_STRIPPING = 27,
 	VIRTCHNL_OP_DISABLE_VLAN_STRIPPING = 28,
 	VIRTCHNL_OP_REQUEST_QUEUES = 29,
@@ -974,18 +974,18 @@ struct virtchnl_rss_lut {
 VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_rss_lut);
 #define virtchnl_rss_lut_LEGACY_SIZEOF	6
 
-/* VIRTCHNL_OP_GET_RSS_HENA_CAPS
- * VIRTCHNL_OP_SET_RSS_HENA
- * VF sends these messages to get and set the hash filter enable bits for RSS.
+/* VIRTCHNL_OP_GET_RSS_HASHCFG_CAPS
+ * VIRTCHNL_OP_SET_RSS_HASHCFG
+ * VF sends these messages to get and set the hash filter configuration for RSS.
  * By default, the PF sets these to all possible traffic types that the
  * hardware supports. The VF can query this value if it wants to change the
  * traffic types that are hashed by the hardware.
  */
-struct virtchnl_rss_hena {
-	u64 hena;
+struct virtchnl_rss_hashcfg {
+	u64 hashcfg;
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_rss_hena);
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_rss_hashcfg);
 
 /* Type of RSS algorithm */
 enum virtchnl_rss_algorithm {
@@ -1779,10 +1779,10 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 	case VIRTCHNL_OP_CONFIG_RSS_HFUNC:
 		valid_len = sizeof(struct virtchnl_rss_hfunc);
 		break;
-	case VIRTCHNL_OP_GET_RSS_HENA_CAPS:
+	case VIRTCHNL_OP_GET_RSS_HASHCFG_CAPS:
 		break;
-	case VIRTCHNL_OP_SET_RSS_HENA:
-		valid_len = sizeof(struct virtchnl_rss_hena);
+	case VIRTCHNL_OP_SET_RSS_HASHCFG:
+		valid_len = sizeof(struct virtchnl_rss_hashcfg);
 		break;
 	case VIRTCHNL_OP_ENABLE_VLAN_STRIPPING:
 	case VIRTCHNL_OP_DISABLE_VLAN_STRIPPING:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 120d68654e3f74cef833a355ebbbd54c20142ee7..516e07b58161de8acf4c742c246fcf94d1e22c02 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12507,7 +12507,7 @@ static int i40e_pf_config_rss(struct i40e_pf *pf)
 	/* By default we enable TCP/UDP with IPv4/IPv6 ptypes */
 	hena = (u64)i40e_read_rx_ctl(hw, I40E_PFQF_HENA(0)) |
 		((u64)i40e_read_rx_ctl(hw, I40E_PFQF_HENA(1)) << 32);
-	hena |= i40e_pf_get_default_rss_hena(pf);
+	hena |= i40e_pf_get_default_rss_hashcfg(pf);
 
 	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(0), (u32)hena);
 	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(1), (u32)(hena >> 32));
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 1120f8e4bb6703d55b50afda4eec29355125e6aa..2d9b7e51bbe1f497a3eca9dc10e818ac591b9c5b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -812,7 +812,7 @@ static int i40e_alloc_vsi_res(struct i40e_vf *vf, u8 idx)
 	}
 
 	if (!idx) {
-		u64 hena = i40e_pf_get_default_rss_hena(pf);
+		u64 hashcfg = i40e_pf_get_default_rss_hashcfg(pf);
 		u8 broadcast[ETH_ALEN];
 
 		vf->lan_vsi_idx = vsi->idx;
@@ -841,8 +841,9 @@ static int i40e_alloc_vsi_res(struct i40e_vf *vf, u8 idx)
 			dev_info(&pf->pdev->dev,
 				 "Could not allocate VF broadcast filter\n");
 		spin_unlock_bh(&vsi->mac_filter_hash_lock);
-		wr32(&pf->hw, I40E_VFQF_HENA1(0, vf->vf_id), (u32)hena);
-		wr32(&pf->hw, I40E_VFQF_HENA1(1, vf->vf_id), (u32)(hena >> 32));
+		wr32(&pf->hw, I40E_VFQF_HENA1(0, vf->vf_id), (u32)hashcfg);
+		wr32(&pf->hw, I40E_VFQF_HENA1(1, vf->vf_id),
+		     (u32)(hashcfg >> 32));
 		/* program mac filter only for VF VSI */
 		ret = i40e_sync_vsi_filters(vsi);
 		if (ret)
@@ -3447,15 +3448,15 @@ static int i40e_vc_config_rss_lut(struct i40e_vf *vf, u8 *msg)
 }
 
 /**
- * i40e_vc_get_rss_hena
+ * i40e_vc_get_rss_hashcfg
  * @vf: pointer to the VF info
  * @msg: pointer to the msg buffer
  *
- * Return the RSS HENA bits allowed by the hardware
+ * Return the RSS Hash configuration bits allowed by the hardware
  **/
-static int i40e_vc_get_rss_hena(struct i40e_vf *vf, u8 *msg)
+static int i40e_vc_get_rss_hashcfg(struct i40e_vf *vf, u8 *msg)
 {
-	struct virtchnl_rss_hena *vrh = NULL;
+	struct virtchnl_rss_hashcfg *vrh = NULL;
 	struct i40e_pf *pf = vf->pf;
 	int aq_ret = 0;
 	int len = 0;
@@ -3464,7 +3465,7 @@ static int i40e_vc_get_rss_hena(struct i40e_vf *vf, u8 *msg)
 		aq_ret = -EINVAL;
 		goto err;
 	}
-	len = sizeof(struct virtchnl_rss_hena);
+	len = sizeof(struct virtchnl_rss_hashcfg);
 
 	vrh = kzalloc(len, GFP_KERNEL);
 	if (!vrh) {
@@ -3472,26 +3473,26 @@ static int i40e_vc_get_rss_hena(struct i40e_vf *vf, u8 *msg)
 		len = 0;
 		goto err;
 	}
-	vrh->hena = i40e_pf_get_default_rss_hena(pf);
+	vrh->hashcfg = i40e_pf_get_default_rss_hashcfg(pf);
 err:
 	/* send the response back to the VF */
-	aq_ret = i40e_vc_send_msg_to_vf(vf, VIRTCHNL_OP_GET_RSS_HENA_CAPS,
+	aq_ret = i40e_vc_send_msg_to_vf(vf, VIRTCHNL_OP_GET_RSS_HASHCFG_CAPS,
 					aq_ret, (u8 *)vrh, len);
 	kfree(vrh);
 	return aq_ret;
 }
 
 /**
- * i40e_vc_set_rss_hena
+ * i40e_vc_set_rss_hashcfg
  * @vf: pointer to the VF info
  * @msg: pointer to the msg buffer
  *
- * Set the RSS HENA bits for the VF
+ * Set the RSS Hash configuration bits for the VF
  **/
-static int i40e_vc_set_rss_hena(struct i40e_vf *vf, u8 *msg)
+static int i40e_vc_set_rss_hashcfg(struct i40e_vf *vf, u8 *msg)
 {
-	struct virtchnl_rss_hena *vrh =
-		(struct virtchnl_rss_hena *)msg;
+	struct virtchnl_rss_hashcfg *vrh =
+		(struct virtchnl_rss_hashcfg *)msg;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_hw *hw = &pf->hw;
 	int aq_ret = 0;
@@ -3500,13 +3501,14 @@ static int i40e_vc_set_rss_hena(struct i40e_vf *vf, u8 *msg)
 		aq_ret = -EINVAL;
 		goto err;
 	}
-	i40e_write_rx_ctl(hw, I40E_VFQF_HENA1(0, vf->vf_id), (u32)vrh->hena);
+	i40e_write_rx_ctl(hw, I40E_VFQF_HENA1(0, vf->vf_id),
+			  (u32)vrh->hashcfg);
 	i40e_write_rx_ctl(hw, I40E_VFQF_HENA1(1, vf->vf_id),
-			  (u32)(vrh->hena >> 32));
+			  (u32)(vrh->hashcfg >> 32));
 
 	/* send the response to the VF */
 err:
-	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_SET_RSS_HENA, aq_ret);
+	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_SET_RSS_HASHCFG, aq_ret);
 }
 
 /**
@@ -4253,11 +4255,11 @@ int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
 	case VIRTCHNL_OP_CONFIG_RSS_LUT:
 		ret = i40e_vc_config_rss_lut(vf, msg);
 		break;
-	case VIRTCHNL_OP_GET_RSS_HENA_CAPS:
-		ret = i40e_vc_get_rss_hena(vf, msg);
+	case VIRTCHNL_OP_GET_RSS_HASHCFG_CAPS:
+		ret = i40e_vc_get_rss_hashcfg(vf, msg);
 		break;
-	case VIRTCHNL_OP_SET_RSS_HENA:
-		ret = i40e_vc_set_rss_hena(vf, msg);
+	case VIRTCHNL_OP_SET_RSS_HASHCFG:
+		ret = i40e_vc_set_rss_hashcfg(vf, msg);
 		break;
 	case VIRTCHNL_OP_ENABLE_VLAN_STRIPPING:
 		ret = i40e_vc_enable_vlan_stripping(vf, msg);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 6d7ba4d67a193346c50907558f3d83e2b130b251..39a18048cc4ae1d21a718b36396eed68c667d18d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1823,12 +1823,13 @@ static int iavf_init_rss(struct iavf_adapter *adapter)
 		/* Enable PCTYPES for RSS, TCP/UDP with IPv4/IPv6 */
 		if (adapter->vf_res->vf_cap_flags &
 		    VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2)
-			adapter->hena = IAVF_DEFAULT_RSS_HENA_EXPANDED;
+			adapter->rss_hashcfg =
+				IAVF_DEFAULT_RSS_HASHCFG_EXPANDED;
 		else
-			adapter->hena = IAVF_DEFAULT_RSS_HENA;
+			adapter->rss_hashcfg = IAVF_DEFAULT_RSS_HASHCFG;
 
-		wr32(hw, IAVF_VFQF_HENA(0), (u32)adapter->hena);
-		wr32(hw, IAVF_VFQF_HENA(1), (u32)(adapter->hena >> 32));
+		wr32(hw, IAVF_VFQF_HENA(0), (u32)adapter->rss_hashcfg);
+		wr32(hw, IAVF_VFQF_HENA(1), (u32)(adapter->rss_hashcfg >> 32));
 	}
 
 	iavf_fill_rss_lut(adapter);
@@ -2199,12 +2200,12 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
 		adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_RSS;
 		return 0;
 	}
-	if (adapter->aq_required & IAVF_FLAG_AQ_GET_HENA) {
-		iavf_get_hena(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_GET_RSS_HASHCFG) {
+		iavf_get_rss_hashcfg(adapter);
 		return 0;
 	}
-	if (adapter->aq_required & IAVF_FLAG_AQ_SET_HENA) {
-		iavf_set_hena(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_SET_RSS_HASHCFG) {
+		iavf_set_rss_hashcfg(adapter);
 		return 0;
 	}
 	if (adapter->aq_required & IAVF_FLAG_AQ_SET_RSS_KEY) {
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index a6f0e5990be25050549770de4152b9251f886e68..1815cf3e28f48b1227cb795efbf905f61b6e57b5 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1128,12 +1128,12 @@ void iavf_request_stats(struct iavf_adapter *adapter)
 }
 
 /**
- * iavf_get_hena
+ * iavf_get_rss_hashcfg
  * @adapter: adapter structure
  *
- * Request hash enable capabilities from PF
+ * Request RSS Hash enable bits from PF
  **/
-void iavf_get_hena(struct iavf_adapter *adapter)
+void iavf_get_rss_hashcfg(struct iavf_adapter *adapter)
 {
 	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
@@ -1141,20 +1141,20 @@ void iavf_get_hena(struct iavf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
-	adapter->current_op = VIRTCHNL_OP_GET_RSS_HENA_CAPS;
-	adapter->aq_required &= ~IAVF_FLAG_AQ_GET_HENA;
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_GET_RSS_HENA_CAPS, NULL, 0);
+	adapter->current_op = VIRTCHNL_OP_GET_RSS_HASHCFG_CAPS;
+	adapter->aq_required &= ~IAVF_FLAG_AQ_GET_RSS_HASHCFG;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_GET_RSS_HASHCFG_CAPS, NULL, 0);
 }
 
 /**
- * iavf_set_hena
+ * iavf_set_rss_hashcfg
  * @adapter: adapter structure
  *
  * Request the PF to set our RSS hash capabilities
  **/
-void iavf_set_hena(struct iavf_adapter *adapter)
+void iavf_set_rss_hashcfg(struct iavf_adapter *adapter)
 {
-	struct virtchnl_rss_hena vrh;
+	struct virtchnl_rss_hashcfg vrh;
 
 	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
@@ -1162,10 +1162,10 @@ void iavf_set_hena(struct iavf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
-	vrh.hena = adapter->hena;
-	adapter->current_op = VIRTCHNL_OP_SET_RSS_HENA;
-	adapter->aq_required &= ~IAVF_FLAG_AQ_SET_HENA;
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_SET_RSS_HENA, (u8 *)&vrh,
+	vrh.hashcfg = adapter->rss_hashcfg;
+	adapter->current_op = VIRTCHNL_OP_SET_RSS_HASHCFG;
+	adapter->aq_required &= ~IAVF_FLAG_AQ_SET_RSS_HASHCFG;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_SET_RSS_HASHCFG, (u8 *)&vrh,
 			 sizeof(vrh));
 }
 
@@ -2735,11 +2735,12 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		if (v_opcode != adapter->current_op)
 			return;
 		break;
-	case VIRTCHNL_OP_GET_RSS_HENA_CAPS: {
-		struct virtchnl_rss_hena *vrh = (struct virtchnl_rss_hena *)msg;
+	case VIRTCHNL_OP_GET_RSS_HASHCFG_CAPS: {
+		struct virtchnl_rss_hashcfg *vrh =
+			(struct virtchnl_rss_hashcfg *)msg;
 
 		if (msglen == sizeof(*vrh))
-			adapter->hena = vrh->hena;
+			adapter->rss_hashcfg = vrh->hashcfg;
 		else
 			dev_warn(&adapter->pdev->dev,
 				 "Invalid message %d from PF\n", v_opcode);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 03bb16191237e85e492855593695e963f3231558..2cc050db509f17e4c65dea8a3080119d803fcca9 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1579,7 +1579,7 @@ static void ice_vsi_set_vf_rss_flow_fld(struct ice_vsi *vsi)
 		return;
 	}
 
-	status = ice_add_avf_rss_cfg(&pf->hw, vsi, ICE_DEFAULT_RSS_HENA);
+	status = ice_add_avf_rss_cfg(&pf->hw, vsi, ICE_DEFAULT_RSS_HASHCFG);
 	if (status)
 		dev_dbg(dev, "ice_add_avf_rss_cfg failed for vsi = %d, error = %d\n",
 			vsi->vsi_num, status);
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index b147f6cf26151ec6e56eaf391ae85804e86d7725..97f094e2fb1e7cd8cad0018446ffa7d0c77e8c0f 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -2999,13 +2999,13 @@ static int ice_vc_dis_vlan_stripping(struct ice_vf *vf)
 }
 
 /**
- * ice_vc_get_rss_hena - return the RSS HENA bits allowed by the hardware
+ * ice_vc_get_rss_hashcfg - return the RSS Hash configuration
  * @vf: pointer to the VF info
  */
-static int ice_vc_get_rss_hena(struct ice_vf *vf)
+static int ice_vc_get_rss_hashcfg(struct ice_vf *vf)
 {
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	struct virtchnl_rss_hena *vrh = NULL;
+	struct virtchnl_rss_hashcfg *vrh = NULL;
 	int len = 0, ret;
 
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
@@ -3019,7 +3019,7 @@ static int ice_vc_get_rss_hena(struct ice_vf *vf)
 		goto err;
 	}
 
-	len = sizeof(struct virtchnl_rss_hena);
+	len = sizeof(struct virtchnl_rss_hashcfg);
 	vrh = kzalloc(len, GFP_KERNEL);
 	if (!vrh) {
 		v_ret = VIRTCHNL_STATUS_ERR_NO_MEMORY;
@@ -3027,23 +3027,23 @@ static int ice_vc_get_rss_hena(struct ice_vf *vf)
 		goto err;
 	}
 
-	vrh->hena = ICE_DEFAULT_RSS_HENA;
+	vrh->hashcfg = ICE_DEFAULT_RSS_HASHCFG;
 err:
 	/* send the response back to the VF */
-	ret = ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_GET_RSS_HENA_CAPS, v_ret,
+	ret = ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_GET_RSS_HASHCFG_CAPS, v_ret,
 				    (u8 *)vrh, len);
 	kfree(vrh);
 	return ret;
 }
 
 /**
- * ice_vc_set_rss_hena - set RSS HENA bits for the VF
+ * ice_vc_set_rss_hashcfg - set RSS Hash configuration bits for the VF
  * @vf: pointer to the VF info
  * @msg: pointer to the msg buffer
  */
-static int ice_vc_set_rss_hena(struct ice_vf *vf, u8 *msg)
+static int ice_vc_set_rss_hashcfg(struct ice_vf *vf, u8 *msg)
 {
-	struct virtchnl_rss_hena *vrh = (struct virtchnl_rss_hena *)msg;
+	struct virtchnl_rss_hashcfg *vrh = (struct virtchnl_rss_hashcfg *)msg;
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
 	struct ice_pf *pf = vf->pf;
 	struct ice_vsi *vsi;
@@ -3074,9 +3074,9 @@ static int ice_vc_set_rss_hena(struct ice_vf *vf, u8 *msg)
 	 * disable RSS
 	 */
 	status = ice_rem_vsi_rss_cfg(&pf->hw, vsi->idx);
-	if (status && !vrh->hena) {
+	if (status && !vrh->hashcfg) {
 		/* only report failure to clear the current RSS configuration if
-		 * that was clearly the VF's intention (i.e. vrh->hena = 0)
+		 * that was clearly the VF's intention (i.e. vrh->hashcfg = 0)
 		 */
 		v_ret = ice_err_to_virt_err(status);
 		goto err;
@@ -3089,14 +3089,14 @@ static int ice_vc_set_rss_hena(struct ice_vf *vf, u8 *msg)
 			 vf->vf_id);
 	}
 
-	if (vrh->hena) {
-		status = ice_add_avf_rss_cfg(&pf->hw, vsi, vrh->hena);
+	if (vrh->hashcfg) {
+		status = ice_add_avf_rss_cfg(&pf->hw, vsi, vrh->hashcfg);
 		v_ret = ice_err_to_virt_err(status);
 	}
 
 	/* send the response to the VF */
 err:
-	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_SET_RSS_HENA, v_ret,
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_SET_RSS_HASHCFG, v_ret,
 				     NULL, 0);
 }
 
@@ -4243,8 +4243,8 @@ static const struct ice_virtchnl_ops ice_virtchnl_dflt_ops = {
 	.add_vlan_msg = ice_vc_add_vlan_msg,
 	.remove_vlan_msg = ice_vc_remove_vlan_msg,
 	.query_rxdid = ice_vc_query_rxdid,
-	.get_rss_hena = ice_vc_get_rss_hena,
-	.set_rss_hena_msg = ice_vc_set_rss_hena,
+	.get_rss_hashcfg = ice_vc_get_rss_hashcfg,
+	.set_rss_hashcfg = ice_vc_set_rss_hashcfg,
 	.ena_vlan_stripping = ice_vc_ena_vlan_stripping,
 	.dis_vlan_stripping = ice_vc_dis_vlan_stripping,
 	.handle_rss_cfg_msg = ice_vc_handle_rss_cfg,
@@ -4381,8 +4381,8 @@ static const struct ice_virtchnl_ops ice_virtchnl_repr_ops = {
 	.add_vlan_msg = ice_vc_add_vlan_msg,
 	.remove_vlan_msg = ice_vc_remove_vlan_msg,
 	.query_rxdid = ice_vc_query_rxdid,
-	.get_rss_hena = ice_vc_get_rss_hena,
-	.set_rss_hena_msg = ice_vc_set_rss_hena,
+	.get_rss_hashcfg = ice_vc_get_rss_hashcfg,
+	.set_rss_hashcfg = ice_vc_set_rss_hashcfg,
 	.ena_vlan_stripping = ice_vc_ena_vlan_stripping,
 	.dis_vlan_stripping = ice_vc_dis_vlan_stripping,
 	.handle_rss_cfg_msg = ice_vc_handle_rss_cfg,
@@ -4583,11 +4583,11 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event,
 	case VIRTCHNL_OP_GET_SUPPORTED_RXDIDS:
 		err = ops->query_rxdid(vf);
 		break;
-	case VIRTCHNL_OP_GET_RSS_HENA_CAPS:
-		err = ops->get_rss_hena(vf);
+	case VIRTCHNL_OP_GET_RSS_HASHCFG_CAPS:
+		err = ops->get_rss_hashcfg(vf);
 		break;
-	case VIRTCHNL_OP_SET_RSS_HENA:
-		err = ops->set_rss_hena_msg(vf, msg);
+	case VIRTCHNL_OP_SET_RSS_HASHCFG:
+		err = ops->set_rss_hashcfg(vf, msg);
 		break;
 	case VIRTCHNL_OP_ENABLE_VLAN_STRIPPING:
 		err = ops->ena_vlan_stripping(vf);
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
index a3d1579a619a55428690a5d224f27569ae2003d4..4c2ec2337b38381a95a0c61537d8509080b76453 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
@@ -65,7 +65,7 @@ static const u32 vlan_v2_allowlist_opcodes[] = {
 /* VIRTCHNL_VF_OFFLOAD_RSS_PF */
 static const u32 rss_pf_allowlist_opcodes[] = {
 	VIRTCHNL_OP_CONFIG_RSS_KEY, VIRTCHNL_OP_CONFIG_RSS_LUT,
-	VIRTCHNL_OP_GET_RSS_HENA_CAPS, VIRTCHNL_OP_SET_RSS_HENA,
+	VIRTCHNL_OP_GET_RSS_HASHCFG_CAPS, VIRTCHNL_OP_SET_RSS_HASHCFG,
 	VIRTCHNL_OP_CONFIG_RSS_HFUNC,
 };
 

-- 
2.48.1.397.gec9d649cc640


