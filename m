Return-Path: <netdev+bounces-68641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9678476D1
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A228D1C2621E
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036C8151460;
	Fri,  2 Feb 2024 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q30E9HkS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E70151451
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896585; cv=none; b=NFrOIcIKyh92eVC3bRg2Y4fFD4zlxkUpP+fLBSviF9Q+Q3Fj1SDXcqT85y8ofl60CV5ixVC9KlGAu9Ywk0DP5qI7XSorsDu1oo9DBngjthM5qJxm4gl8OQOEX5AN/SMvu0z7ONl7CzIZBh6DzGBslPhXKjyceY25VJG8NIbSm8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896585; c=relaxed/simple;
	bh=ed1pa01NpylKbuGOAgxUxNyRjyMaR0ZklViikUWd0sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idFFYsmXC/ENbe0bC6fsgeRZDImH89amEKw7MftPXGaSkbkfDLywQB0RN4fSoXnA2XofQ6+C3x3+W2pO8b8jAjSiqtOaWWRna52vikJlz0+8n1U2iEtzEu+BTSyJqn+LDR8WV/BIDM5TpwWrHejrOb8+hyp1TQXSLRaRerxFJdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q30E9HkS; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706896584; x=1738432584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ed1pa01NpylKbuGOAgxUxNyRjyMaR0ZklViikUWd0sw=;
  b=Q30E9HkS6wxY2tCkRp7H3EM784PWtIzGG1ihyijHAphxstrcwBpctRt9
   iH5+NQppR0aUncvb8SlcvxMqlRy6HX1XPgAa+JZbYNLZbe9PM3g1SgitA
   e+wbDxy0BMiIeOI/TT28N91yG+lkzO4VMkc9Gao1asG5wsk4CyeOdVOn+
   igEmMOGZJdxnR2FBuUTieAhPyX0EEL2wpfQ+9DJe7i+BPIrJPqUl1VJ6o
   8Lyh21AO3E98vZCaZiIbpdpdDhHe20Uhm4d8WQoPfOF8wOg4LwqKXH26q
   Ctsy3DUA0bOPyio7PnLSA8Rb1TeQSZdAi18svU9Sq/OdYXkzWwEmYEZ5u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="435347627"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="435347627"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 09:56:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="137839"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 02 Feb 2024 09:56:18 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Aniruddha Paul <aniruddha.paul@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jan Glaza <jan.glaza@intel.com>,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 3/4] ice: Add a new counter for Rx EIPE errors
Date: Fri,  2 Feb 2024 09:56:11 -0800
Message-ID: <20240202175613.3470818-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240202175613.3470818-1-anthony.l.nguyen@intel.com>
References: <20240202175613.3470818-1-anthony.l.nguyen@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          | 1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 8 ++++++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 97c2a5fb5dbf..a4ba60e17d0b 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -605,6 +605,7 @@ struct ice_pf {
 	wait_queue_head_t reset_wait_queue;
 
 	u32 hw_csum_rx_error;
+	u32 hw_rx_eipe_error;
 	u32 oicr_err_reg;
 	struct msi_map oicr_irq;	/* Other interrupt cause MSIX vector */
 	struct msi_map ll_ts_irq;	/* LL_TS interrupt MSIX vector */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 55fcf17d503e..3cc364a4d682 100644
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
2.41.0


