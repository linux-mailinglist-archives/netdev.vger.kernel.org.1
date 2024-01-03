Return-Path: <netdev+bounces-61232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD90B822F2C
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1AE280C97
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B4319BD8;
	Wed,  3 Jan 2024 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTOyCSVE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA58E1A282
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704290828; x=1735826828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gXW7NtRV3PRG3hVtfxiiINB9hIR80aIG4hAgr+HvWqE=;
  b=FTOyCSVEqSz7edoE09W5ZP0cXNAMSivNQT3WVp0BQ3n4fpbjWWlqQ1ww
   TUTlyYrG+iqyVXSDWeoQNXVQmcnuhgXpDLpH2sDqFdq2FFwrVImWp9en+
   R1a1q1g0wm0XCdDjeDsgXAJCcdlxTl0q+IQiZrE0hspKDSSfyNCFyfeO7
   Z/o17yMGH51XlpkCec+SfWEhQFbXLVicDorXgc9fJj3xvhoZg03X7MDvK
   tcKZVhtBIVUUjbqCmpZmNvpcIsCDAbeWEK7FALcmUbhPsq1abb/wWJG57
   YqGfVOChR7bATiCfkIWW9s83/IOlezyjGeZP1tonbUaHXNZnYdsoAcvb2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="3813542"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="3813542"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 06:07:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="779998486"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="779998486"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga002.jf.intel.com with ESMTP; 03 Jan 2024 06:07:04 -0800
Received: from DevelopmentVM.nql.local (s240.igk.intel.com [10.102.18.202])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 699C2373E2;
	Wed,  3 Jan 2024 14:06:58 +0000 (GMT)
From: Jan Sokolowski <jan.sokolowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aniruddha Paul <aniruddha.paul@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jan Glaza <jan.glaza@intel.com>,
	Jan Sokolowski <jan.sokolowski@intel.com>
Subject: [PATCH iwl-next v1] ice: Add a new counter for Rx EIPE errors
Date: Wed,  3 Jan 2024 15:11:15 +0100
Message-Id: <20240103141115.9509-1-jan.sokolowski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aniruddha Paul <aniruddha.paul@intel.com>

HW incorrectly reports EIPE errors on encapsulated packets
with L2 padding inside inner packet. HW shows outer UDP/IPV4
packet checksum errors as part of the EIPE flags of the
Rx descriptor. These are reported only if checksum offload
is enabled and L3/L4 parsed flag is valid in Rx descriptor.

When that error is reported by HW, we don't act on it
instead of incrementing main Rx errors statistic as it
would normally happen.

Add a new statistic to count these errors since we still want
to print them.

Signed-off-by: Aniruddha Paul <aniruddha.paul@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          | 1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 8 ++++++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 367b613d92c0..e841f6c4f1c4 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -606,6 +606,7 @@ struct ice_pf {
 	wait_queue_head_t reset_wait_queue;
 
 	u32 hw_csum_rx_error;
+	u32 hw_rx_eipe_error;
 	u32 oicr_err_reg;
 	struct msi_map oicr_irq;	/* Other interrupt cause MSIX vector */
 	struct msi_map ll_ts_irq;	/* LL_TS interrupt MSIX vector */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a19b06f18e40..f25e43881df2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -129,6 +129,7 @@ static const struct ice_stats ice_gstrings_pf_stats[] = {
 	ICE_PF_STAT("rx_oversize.nic", stats.rx_oversize),
 	ICE_PF_STAT("rx_jabber.nic", stats.rx_jabber),
 	ICE_PF_STAT("rx_csum_bad.nic", hw_csum_rx_error),
+	ICE_PF_STAT("rx_eipe_error.nic", hw_rx_eipe_error),
 	ICE_PF_STAT("rx_dropped.nic", stats.eth.rx_discards),
 	ICE_PF_STAT("rx_crc_errors.nic", stats.crc_errors),
 	ICE_PF_STAT("illegal_bytes.nic", stats.illegal_bytes),
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 839e5da24ad5..f8f1d2bdc1be 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -143,8 +143,12 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
 	ipv6 = (decoded.outer_ip == ICE_RX_PTYPE_OUTER_IP) &&
 	       (decoded.outer_ip_ver == ICE_RX_PTYPE_OUTER_IPV6);
 
-	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_IPE_S) |
-				   BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EIPE_S))))
+	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EIPE_S)))) {
+		ring->vsi->back->hw_rx_eipe_error++;
+		return;
+	}
+
+	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_IPE_S))))
 		goto checksum_fail;
 
 	if (ipv6 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_IPV6EXADD_S))))
-- 
2.31.1


