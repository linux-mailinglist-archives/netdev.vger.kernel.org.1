Return-Path: <netdev+bounces-32195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBD879365D
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 09:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83515281270
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 07:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F119DEC7;
	Wed,  6 Sep 2023 07:35:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4712A59
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 07:35:33 +0000 (UTC)
X-Greylist: delayed 435 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Sep 2023 00:35:31 PDT
Received: from out-220.mta1.migadu.com (out-220.mta1.migadu.com [95.215.58.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6491CE
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 00:35:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693985294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=938feFunuVXrcQFgTRaCo4N0Cd13MIgXYg/3Qnd6T7g=;
	b=OlHVPoQNIIWLajc/u/NPrn8F8+xDKk2SY0BWtBkfBz3Xn51WktNbj5XpWZ2IR0/aWW+Bdy
	jy/sSX7uz3wVfm18fYS6eGuqhqgA1fboaTlV1sFtW1IjCQBUyLBdLhiRI0OpGpWtWlxn8p
	Jqn11zt98CKVXa7uQBPeG2D5JWZMnSQ=
From: Yajun Deng <yajun.deng@linux.dev>
To: anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] i40e: Add rx_missed_errors for buffer exhaustion
Date: Wed,  6 Sep 2023 15:27:57 +0800
Message-Id: <20230906072757.3929754-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As the comment in struct rtnl_link_stats64, rx_dropped should not
include packets dropped by the device due to buffer exhaustion.
They are counted in rx_missed_errors, procfs folds those two counters
together.

Add rx_missed_errors for buffer exhaustion, rx_missed_errors corresponds
to rx_discards, rx_dropped corresponds to rx_discards_other.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
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
index de7fd43dc11c..290c011168c2 100644
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
index 8ea1a238dcef..3b514abfaa1e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4914,7 +4914,7 @@ int i40e_get_vf_stats(struct net_device *netdev, int vf_id,
 	vf_stats->tx_bytes   = stats->tx_bytes;
 	vf_stats->broadcast  = stats->rx_broadcast;
 	vf_stats->multicast  = stats->rx_multicast;
-	vf_stats->rx_dropped = stats->rx_discards;
+	vf_stats->rx_dropped = stats->rx_discards + stats->rx_discards_other;
 	vf_stats->tx_dropped = stats->tx_discards;
 
 	return 0;
-- 
2.25.1


