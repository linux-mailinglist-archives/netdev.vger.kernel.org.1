Return-Path: <netdev+bounces-260617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JxDCS7lnWlDSgQAu9opvQ
	(envelope-from <netdev+bounces-260617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:51:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E4D18AC13
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66A243137791
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D793A63E6;
	Tue, 24 Feb 2026 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCcyHHts"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C264F3A1D14;
	Tue, 24 Feb 2026 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955368; cv=none; b=kRcN1FVtnz6bY/NDOSVy3x9bs4OfciIa9BU4bISFRGwznXHW1KMAemYSruRf9ExVqBKz69CpOsnIJxN80Gy1Zuikk3RXl4d/6XTGvHbD/TMhPTzAWGyUJCX8fFaKIDMb3r1Rr61R57IGuY0SUYp6Cw+92NNxgLiGEE2GFKEPoMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955368; c=relaxed/simple;
	bh=9FXAWJfCf4n5/W/PCCbtw1+D93+IJGoeGv51fbruus8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6FABHAtjwRi4M4+OUlEAbaTV+EuJX2bKutdymw6l1qm6wlETQrItq8Z2JRfnJ5Um1/Aw+O2VttojPiqZBu5vK43eZapsHd9HAUz1LNEr57ZWwksFwTDzekLgGIRdBFrKhiDdlgKfbBARtqS6bA/jORkcm7RgwG5KMk58YWVYKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCcyHHts; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771955366; x=1803491366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9FXAWJfCf4n5/W/PCCbtw1+D93+IJGoeGv51fbruus8=;
  b=kCcyHHtsll0fAqIKe7fylfw5F7tF/xSlvAgcJTECsso8H4R+Lt50JEU+
   6kyZOp0z8OF2DwBIEXeKD3ISaYyS0kjEXWPbZR6ciT6wHxmE1HUMJ61jn
   vNB1NyIGb6cznMdGXhY6fA6VPVUKgKlCUwVHQ772yDie2/vDEf4TUED/c
   H5JLdKqrIxVUDrOUdI7n4Npon4nx0mhE+H97fGrRWNUsRcmDEnidWVQbS
   sGhudH324cZi/rZVL5/tq1T0dYcc4hzz4q6UFPZ79f9w0RtCZOdF69DdE
   s43Xl5GppM/z5lSlXXtIV0rv24WU4u8VDK5ZwrW0IGpD3hC2t/fNLNIFj
   A==;
X-CSE-ConnectionGUID: A630VGDHTnaW6e2C/UJ6Ig==
X-CSE-MsgGUID: FHYDfk54RAGkJboGWU2e0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="98444592"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="98444592"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 09:49:26 -0800
X-CSE-ConnectionGUID: hBAGwyhdQv+aEcMWuD7cSw==
X-CSE-MsgGUID: 6dNYgn+XRPOW7/KGFGav5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="220088556"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 24 Feb 2026 09:49:22 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kohei Enju <kohei@enjuk.jp>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v3 5/5] ice: add support for transmitting unreadable frags
Date: Tue, 24 Feb 2026 18:46:18 +0100
Message-ID: <20260224174618.2780516-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224174618.2780516-1-aleksander.lobakin@intel.com>
References: <20260224174618.2780516-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260617-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: A9E4D18AC13
X-Rspamd-Action: no action

Advertise netmem Tx support in ice. The only change needed is to set
ICE_TX_BUF_FRAG conditionally, only when skb_frag_is_net_iov() is
false. Otherwise, the Tx buffer type will be ICE_TX_BUF_EMPTY and
the driver will skip the DMA unmapping operation.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c   |  1 +
 drivers/net/ethernet/intel/ice/ice_sf_eth.c |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c   | 17 +++++++++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d16a7013470d..3b54f8a819f4 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3525,6 +3525,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
 
 	netdev->netdev_ops = &ice_netdev_ops;
 	netdev->queue_mgmt_ops = &ice_queue_mgmt_ops;
+	netdev->netmem_tx = true;
 	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;
 	netdev->xdp_metadata_ops = &ice_xdp_md_ops;
 	ice_set_ethtool_ops(netdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index b1f3783a8fad..8ec2e4597c47 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -59,6 +59,7 @@ static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port,
 	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
 	netdev->netdev_ops = &ice_sf_netdev_ops;
 	netdev->queue_mgmt_ops = &ice_queue_mgmt_ops;
+	netdev->netmem_tx = true;
 	SET_NETDEV_DEVLINK_PORT(netdev, devlink_port);
 
 	err = register_netdev(netdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 8e2cbddb146d..a7e37a430e61 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -113,11 +113,17 @@ ice_prgm_fdir_fltr(struct ice_vsi *vsi, struct ice_fltr_desc *fdir_desc,
 static void
 ice_unmap_and_free_tx_buf(struct ice_tx_ring *ring, struct ice_tx_buf *tx_buf)
 {
-	if (tx_buf->type != ICE_TX_BUF_XDP_TX && dma_unmap_len(tx_buf, len))
+	switch (tx_buf->type) {
+	case ICE_TX_BUF_DUMMY:
+	case ICE_TX_BUF_FRAG:
+	case ICE_TX_BUF_SKB:
+	case ICE_TX_BUF_XDP_XMIT:
 		dma_unmap_page(ring->dev,
 			       dma_unmap_addr(tx_buf, dma),
 			       dma_unmap_len(tx_buf, len),
 			       DMA_TO_DEVICE);
+		break;
+	}
 
 	switch (tx_buf->type) {
 	case ICE_TX_BUF_DUMMY:
@@ -337,12 +343,14 @@ static bool ice_clean_tx_irq(struct ice_tx_ring *tx_ring, int napi_budget)
 			}
 
 			/* unmap any remaining paged data */
-			if (dma_unmap_len(tx_buf, len)) {
+			if (tx_buf->type != ICE_TX_BUF_EMPTY) {
 				dma_unmap_page(tx_ring->dev,
 					       dma_unmap_addr(tx_buf, dma),
 					       dma_unmap_len(tx_buf, len),
 					       DMA_TO_DEVICE);
+
 				dma_unmap_len_set(tx_buf, len, 0);
+				tx_buf->type = ICE_TX_BUF_EMPTY;
 			}
 		}
 		ice_trace(clean_tx_irq_unmap_eop, tx_ring, tx_desc, tx_buf);
@@ -1492,7 +1500,8 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 				       DMA_TO_DEVICE);
 
 		tx_buf = &tx_ring->tx_buf[i];
-		tx_buf->type = ICE_TX_BUF_FRAG;
+		if (!skb_frag_is_net_iov(frag))
+			tx_buf->type = ICE_TX_BUF_FRAG;
 	}
 
 	/* record SW timestamp if HW timestamp is not available */
@@ -2364,7 +2373,7 @@ void ice_clean_ctrl_tx_irq(struct ice_tx_ring *tx_ring)
 		}
 
 		/* unmap the data header */
-		if (dma_unmap_len(tx_buf, len))
+		if (tx_buf->type != ICE_TX_BUF_EMPTY)
 			dma_unmap_single(tx_ring->dev,
 					 dma_unmap_addr(tx_buf, dma),
 					 dma_unmap_len(tx_buf, len),
-- 
2.53.0


