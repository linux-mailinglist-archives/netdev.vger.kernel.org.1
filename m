Return-Path: <netdev+bounces-61032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B4E822483
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F3B1F23726
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CE0171BF;
	Tue,  2 Jan 2024 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dxXeKNAD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E00171A7
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 22:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704233081; x=1735769081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2okGMPnlWsjRz2l5q6+aQGt+NjTcjSoczrJpuoTLI5o=;
  b=dxXeKNADy1XXYaEF9osH1B8jD2DAZnSjfQx5PW1ceCzPDaqrkHzfir89
   fCMusnNiVHK6mCxF9BbDOALLvfdUaqhD8yssn78ozHdmOJdJFIJB96GaS
   oJ/zSGsjpc1V/nFnV/xxlr6fScIWsrpo52O4BeBZ4RVeEGQpVAExuiLhF
   ndL6w9U+iIQoy0Qxv+LZDaPyYEaASkFgupTKYqKtVQSkMy8eNBx2WB3mq
   HLROUZuvXJlGyxdxCQQ2a7V81BMi93ibZ1esZ9fiBJYTcWWWT0LarA1ua
   X7tUGSw6XXQRJb0wR3yjknYaaDKFAAcp02hCRDveqj+1KNo1nAj+EDiCV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="15567898"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="15567898"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 14:04:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="808621413"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="808621413"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 02 Jan 2024 14:04:36 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jan Sokolowski <jan.sokolowski@intel.com>,
	anthony.l.nguyen@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 5/7] ice: remove rx_len_errors statistic
Date: Tue,  2 Jan 2024 14:04:21 -0800
Message-ID: <20240102220428.698969-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240102220428.698969-1-anthony.l.nguyen@intel.com>
References: <20240102220428.698969-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Sokolowski <jan.sokolowski@intel.com>

It was found that this statistic is incorrectly
reported by HW and thus, useless.

As RX length error statistics are shown to the
end user when requested, the values reported
are misleading.

Thus, that value is no longer reported and
doesn't count anymore when adding all rx errors.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 -
 drivers/net/ethernet/intel/ice/ice_main.c    | 5 -----
 drivers/net/ethernet/intel/ice/ice_type.h    | 1 -
 3 files changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 2244d41fd933..a19b06f18e40 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -129,7 +129,6 @@ static const struct ice_stats ice_gstrings_pf_stats[] = {
 	ICE_PF_STAT("rx_oversize.nic", stats.rx_oversize),
 	ICE_PF_STAT("rx_jabber.nic", stats.rx_jabber),
 	ICE_PF_STAT("rx_csum_bad.nic", hw_csum_rx_error),
-	ICE_PF_STAT("rx_length_errors.nic", stats.rx_len_errors),
 	ICE_PF_STAT("rx_dropped.nic", stats.eth.rx_discards),
 	ICE_PF_STAT("rx_crc_errors.nic", stats.crc_errors),
 	ICE_PF_STAT("illegal_bytes.nic", stats.illegal_bytes),
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2fa46bacf5ba..63a5fb701ada 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6834,13 +6834,11 @@ void ice_update_vsi_stats(struct ice_vsi *vsi)
 		cur_ns->rx_crc_errors = pf->stats.crc_errors;
 		cur_ns->rx_errors = pf->stats.crc_errors +
 				    pf->stats.illegal_bytes +
-				    pf->stats.rx_len_errors +
 				    pf->stats.rx_undersize +
 				    pf->hw_csum_rx_error +
 				    pf->stats.rx_jabber +
 				    pf->stats.rx_fragments +
 				    pf->stats.rx_oversize;
-		cur_ns->rx_length_errors = pf->stats.rx_len_errors;
 		/* record drops from the port level */
 		cur_ns->rx_missed_errors = pf->stats.eth.rx_discards;
 	}
@@ -6980,9 +6978,6 @@ void ice_update_pf_stats(struct ice_pf *pf)
 			  &prev_ps->mac_remote_faults,
 			  &cur_ps->mac_remote_faults);
 
-	ice_stat_update32(hw, GLPRT_RLEC(port), pf->stat_prev_loaded,
-			  &prev_ps->rx_len_errors, &cur_ps->rx_len_errors);
-
 	ice_stat_update32(hw, GLPRT_RUC(port), pf->stat_prev_loaded,
 			  &prev_ps->rx_undersize, &cur_ps->rx_undersize);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 5f04b1318c9e..41ab6d7bbd9e 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -1003,7 +1003,6 @@ struct ice_hw_port_stats {
 	u64 error_bytes;		/* errbc */
 	u64 mac_local_faults;		/* mlfc */
 	u64 mac_remote_faults;		/* mrfc */
-	u64 rx_len_errors;		/* rlec */
 	u64 link_xon_rx;		/* lxonrxc */
 	u64 link_xoff_rx;		/* lxoffrxc */
 	u64 link_xon_tx;		/* lxontxc */
-- 
2.41.0


