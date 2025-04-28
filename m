Return-Path: <netdev+bounces-186500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25649A9F772
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 19:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516223B4874
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139D02951B4;
	Mon, 28 Apr 2025 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3NvCLZj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC8294A17
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745861778; cv=none; b=OZo8PxgSI/hVD6StZMZyiqDoqxSvPA7whbl+R3Mm4AsrAlLUiUb9Ry9H3QZogG7anKtq8r7OFhvIZJ76bqJ92wUIA7GoqyIMcphFZpbiFPc4Xv8ItM0NGcgMmok4GnIdEs2y9hysHx4CqK6VCLcawm94Tn+NCwNaW8nSlb9plPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745861778; c=relaxed/simple;
	bh=6A5I6ee9+wW9VXv222+jYTtgcusG76CERZnv59A8kD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCw559DpXP9bh6euSFFTfPSJuVI5FWiQ9v4vB7h28Oc1zqoDqBW/stmaUQT24Jkv8m567ufnMicPJRQu3t+BXSxTusMNCYjzB80f6oKUFbET5mGpVu36jtKNY7uZyw3VXJpVNVokzTz9tcp7+LgtCfUEM/9dPwzCY0HebazATr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3NvCLZj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745861776; x=1777397776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6A5I6ee9+wW9VXv222+jYTtgcusG76CERZnv59A8kD0=;
  b=n3NvCLZj3+g5OUCyS+IzIc2z6GwiZKJWKYSaunc/MqVAETNUa6SddN2e
   bvlFIlWpGDJF0Qnip1v6SxJPIkXmLx9xlKkSCLjPa90UY3pZKq+gjxrEv
   BwMBzIuI87/dAVv1VrtZJrtVEjSC+eQ3Z9KZ2kbOoEE0Z+URWQnIG3Zw3
   1vfw4TG2vNic3LWZcC7zcMRVDKcC5sE0WflRs+T43l113gKjS7t+fiQol
   z/YUn94qf8hOwEulEm0y1tdWTOnVYy1PoEUa120G2hQWqI5pX46r1Immp
   jEOH+R0zvKKXOxaYsTjVBWFy797Ch9jKK+vtqyGnG8HW6zUNZ/pYHkHrT
   g==;
X-CSE-ConnectionGUID: cj/jsIo5SBWhnvK4+DYwjg==
X-CSE-MsgGUID: 0siVMtoWSR6XC17M9SOwIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58452163"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; 
   d="scan'208";a="58452163"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 10:36:13 -0700
X-CSE-ConnectionGUID: L+u2TA+oST2wkGv4ap1pyA==
X-CSE-MsgGUID: s/m5OxtrQ3esPsDIrWB8Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; 
   d="scan'208";a="138679033"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.55])
  by fmviesa004.fm.intel.com with ESMTP; 28 Apr 2025 10:36:13 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	milena.olech@intel.com,
	anton.nadezhdin@intel.com,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: [PATCH iwl-next v3 5/9] idpf: reshuffle idpf_vport struct members to avoid holes
Date: Mon, 28 Apr 2025 10:35:48 -0700
Message-ID: <20250428173552.2884-6-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428173552.2884-1-pavan.kumar.linga@intel.com>
References: <20250428173552.2884-1-pavan.kumar.linga@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous refactor of moving queue and vector resources
out of the idpf_vport structure, created few holes. Reshuffle
the existing members to avoid holes as much as possible.

Reviewed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h | 27 +++++++++++++-------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index c81aba7d5256..e9f531c3b5ca 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -325,24 +325,24 @@ struct idpf_q_vec_rsrc {
 /**
  * struct idpf_vport - Handle for netdevices and queue resources
  * @dflt_qv_rsrc: contains default queue and vector resources
- * @num_txq: Number of allocated TX queues
- * @compln_clean_budget: Work budget for completion clean
  * @txqs: Used only in hotpath to get to the right queue very fast
- * @crc_enable: Enable CRC insertion offload
- * @rx_ptype_lkup: Lookup table for ptypes on RX
  * @adapter: back pointer to associated adapter
  * @netdev: Associated net_device. Each vport should have one and only one
  *	    associated netdev.
  * @flags: See enum idpf_vport_flags
- * @vport_type: Default SRIOV, SIOV, etc.
+ * @compln_clean_budget: Work budget for completion clean
  * @vport_id: Device given vport identifier
+ * @vport_type: Default SRIOV, SIOV, etc.
  * @idx: Software index in adapter vports struct
- * @default_vport: Use this vport if one isn't specified
+ * @num_txq: Number of allocated TX queues
  * @max_mtu: device given max possible MTU
  * @default_mac_addr: device will give a default MAC to use
  * @rx_itr_profile: RX profiles for Dynamic Interrupt Moderation
  * @tx_itr_profile: TX profiles for Dynamic Interrupt Moderation
+ * @rx_ptype_lkup: Lookup table for ptypes on RX
  * @port_stats: per port csum, header split, and other offload stats
+ * @default_vport: Use this vport if one isn't specified
+ * @crc_enable: Enable CRC insertion offload
  * @link_up: True if link is up
  * @sw_marker_wq: workqueue for marker packets
  * @tx_tstamp_caps: Capabilities negotiated for Tx timestamping
@@ -352,27 +352,26 @@ struct idpf_q_vec_rsrc {
  */
 struct idpf_vport {
 	struct idpf_q_vec_rsrc dflt_qv_rsrc;
-	u16 num_txq;
-	u32 compln_clean_budget;
 	struct idpf_tx_queue **txqs;
-	bool crc_enable;
-
-	struct libeth_rx_pt *rx_ptype_lkup;
 
 	struct idpf_adapter *adapter;
 	struct net_device *netdev;
 	DECLARE_BITMAP(flags, IDPF_VPORT_FLAGS_NBITS);
-	u16 vport_type;
+	u32 compln_clean_budget;
 	u32 vport_id;
+	u16 vport_type;
 	u16 idx;
-	bool default_vport;
 
+	u16 num_txq;
 	u16 max_mtu;
 	u8 default_mac_addr[ETH_ALEN];
 	u16 rx_itr_profile[IDPF_DIM_PROFILE_SLOTS];
 	u16 tx_itr_profile[IDPF_DIM_PROFILE_SLOTS];
-	struct idpf_port_stats port_stats;
 
+	struct libeth_rx_pt *rx_ptype_lkup;
+	struct idpf_port_stats port_stats;
+	bool default_vport;
+	bool crc_enable;
 	bool link_up;
 
 	wait_queue_head_t sw_marker_wq;
-- 
2.43.0


