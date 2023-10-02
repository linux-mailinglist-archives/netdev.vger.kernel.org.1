Return-Path: <netdev+bounces-37500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390F57B5B09
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 21:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D8D7A2822DB
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 19:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F71D1F924;
	Mon,  2 Oct 2023 19:16:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334191F5FB
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 19:15:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF03CDC
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 12:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696274156; x=1727810156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eoKwJ0AVZ9QB2FX9Q3f2dYmdEd6Q5nqBpKF2NydLpE4=;
  b=hjbmcYDO3o7qUxWkQRSasfe0/ENPlA3Zvv6UroEPGdRGOIK6NLGGC3Ir
   GSFXjziqFhg/LeSZpM8W9ND17rtdodKcrN75b5wg+pz6FDsRYph/2yZw2
   A/Rb6Qn0yza6N8gEJMEgpaRAYCRzDK4YG4btOgnlfROiJfwIl7Gou6f2p
   XWe2/rWJqir1H8SopPTxo8x/oZtODjcnJPZfnk78RjwQnCKfIqJ/dGOv5
   17ZYHtrqgROO4gdNtX7Vue/5DFgSLcCXlKBBw9aSRKyXZY5lSHRIFlrhX
   TSuUbamPMwQavYvBuXvjhuzSHTn0VBsqb9lmMfQZrDjP0kAuC1VWRhqKG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="373055025"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="373055025"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 11:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="780011936"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="780011936"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 02 Oct 2023 11:51:29 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Yajun Deng <yajun.deng@linux.dev>,
	anthony.l.nguyen@intel.com,
	Arpana Arland <arpanax.arland@intel.com>
Subject: [PATCH net-next 1/3] i40e: Add rx_missed_errors for buffer exhaustion
Date: Mon,  2 Oct 2023 11:50:32 -0700
Message-Id: <20231002185034.1575127-2-anthony.l.nguyen@intel.com>
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

From: Yajun Deng <yajun.deng@linux.dev>

As the comment in struct rtnl_link_stats64, rx_dropped should not
include packets dropped by the device due to buffer exhaustion.
They are counted in rx_missed_errors, procfs folds those two counters
together.

Add rx_missed_errors for buffer exhaustion, rx_missed_errors corresponds
to rx_discards, rx_dropped corresponds to rx_discards_other.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  3 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 18 +++++++-----------
 .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  2 +-
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index bd1321bf7e26..77e4ac103866 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -245,6 +245,7 @@ static const struct i40e_stats i40e_gstrings_net_stats[] = {
 	I40E_NETDEV_STAT(rx_errors),
 	I40E_NETDEV_STAT(tx_errors),
 	I40E_NETDEV_STAT(rx_dropped),
+	I40E_NETDEV_STAT(rx_missed_errors),
 	I40E_NETDEV_STAT(tx_dropped),
 	I40E_NETDEV_STAT(collisions),
 	I40E_NETDEV_STAT(rx_length_errors),
@@ -321,7 +322,7 @@ static const struct i40e_stats i40e_gstrings_stats[] = {
 	I40E_PF_STAT("port.rx_broadcast", stats.eth.rx_broadcast),
 	I40E_PF_STAT("port.tx_broadcast", stats.eth.tx_broadcast),
 	I40E_PF_STAT("port.tx_errors", stats.eth.tx_errors),
-	I40E_PF_STAT("port.rx_dropped", stats.eth.rx_discards),
+	I40E_PF_STAT("port.rx_discards", stats.eth.rx_discards),
 	I40E_PF_STAT("port.tx_dropped_link_down", stats.tx_dropped_link_down),
 	I40E_PF_STAT("port.rx_crc_errors", stats.crc_errors),
 	I40E_PF_STAT("port.illegal_bytes", stats.illegal_bytes),
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 00ca2b88165c..4b9788d2ded7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -489,6 +489,7 @@ static void i40e_get_netdev_stats_struct(struct net_device *netdev,
 	stats->tx_dropped	= vsi_stats->tx_dropped;
 	stats->rx_errors	= vsi_stats->rx_errors;
 	stats->rx_dropped	= vsi_stats->rx_dropped;
+	stats->rx_missed_errors	= vsi_stats->rx_missed_errors;
 	stats->rx_crc_errors	= vsi_stats->rx_crc_errors;
 	stats->rx_length_errors	= vsi_stats->rx_length_errors;
 }
@@ -680,17 +681,13 @@ i40e_stats_update_rx_discards(struct i40e_vsi *vsi, struct i40e_hw *hw,
 			      struct i40e_eth_stats *stat_offset,
 			      struct i40e_eth_stats *stat)
 {
-	u64 rx_rdpc, rx_rxerr;
-
 	i40e_stat_update32(hw, I40E_GLV_RDPC(stat_idx), offset_loaded,
-			   &stat_offset->rx_discards, &rx_rdpc);
+			   &stat_offset->rx_discards, &stat->rx_discards);
 	i40e_stat_update64(hw,
 			   I40E_GL_RXERR1H(i40e_compute_pci_to_hw_id(vsi, hw)),
 			   I40E_GL_RXERR1L(i40e_compute_pci_to_hw_id(vsi, hw)),
 			   offset_loaded, &stat_offset->rx_discards_other,
-			   &rx_rxerr);
-
-	stat->rx_discards = rx_rdpc + rx_rxerr;
+			   &stat->rx_discards_other);
 }
 
 /**
@@ -712,9 +709,6 @@ void i40e_update_eth_stats(struct i40e_vsi *vsi)
 	i40e_stat_update32(hw, I40E_GLV_TEPC(stat_idx),
 			   vsi->stat_offsets_loaded,
 			   &oes->tx_errors, &es->tx_errors);
-	i40e_stat_update32(hw, I40E_GLV_RDPC(stat_idx),
-			   vsi->stat_offsets_loaded,
-			   &oes->rx_discards, &es->rx_discards);
 	i40e_stat_update32(hw, I40E_GLV_RUPP(stat_idx),
 			   vsi->stat_offsets_loaded,
 			   &oes->rx_unknown_protocol, &es->rx_unknown_protocol);
@@ -971,8 +965,10 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	ns->tx_errors = es->tx_errors;
 	ons->multicast = oes->rx_multicast;
 	ns->multicast = es->rx_multicast;
-	ons->rx_dropped = oes->rx_discards;
-	ns->rx_dropped = es->rx_discards;
+	ons->rx_dropped = oes->rx_discards_other;
+	ns->rx_dropped = es->rx_discards_other;
+	ons->rx_missed_errors = oes->rx_discards;
+	ns->rx_missed_errors = es->rx_discards;
 	ons->tx_dropped = oes->tx_discards;
 	ns->tx_dropped = es->tx_discards;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index d3d6415553ed..186b1130dbaf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4916,7 +4916,7 @@ int i40e_get_vf_stats(struct net_device *netdev, int vf_id,
 	vf_stats->tx_bytes   = stats->tx_bytes;
 	vf_stats->broadcast  = stats->rx_broadcast;
 	vf_stats->multicast  = stats->rx_multicast;
-	vf_stats->rx_dropped = stats->rx_discards;
+	vf_stats->rx_dropped = stats->rx_discards + stats->rx_discards_other;
 	vf_stats->tx_dropped = stats->tx_discards;
 
 	return 0;
-- 
2.38.1


