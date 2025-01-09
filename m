Return-Path: <netdev+bounces-156530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AD9A06D0E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 05:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BA31889BBE
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 04:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A520C023;
	Thu,  9 Jan 2025 04:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhOuVK28"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C5920C006
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 04:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736397060; cv=none; b=gRe14sON8hj4LkaZx0ABVFJqBo4pa85UsS44+7EKoJKmC+aHH4bAAMDEpWiIU2zBap4k63iryX4u+1PvJB06OOEjnPaEiuMRrf6TP2h8kFapC+/negde2gcaSYTjgS2vPkSD7VMeOH8Z1LmqF46IV/CWFt/VzOf5wyxoODJynEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736397060; c=relaxed/simple;
	bh=u52Td5MsJMyfQGpO8yojmWul1RcM7DlXfDOr8NhTcUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LlUK+R7+RwDSYbHMfqmTyK2sCDZK4WIE0fzKU4rfTwcsBadNJwinURihVODAavAwYFY79JmL9zbblbJH4OQYQZ8gMmI3Cyi/EgZacXAzaOhoTqHGXUJIXx6pL7RkblcLlK1PqPD9UWYDvaA+u2oDDQSv2oE1b0RyGRBncEq1IG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhOuVK28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47C4C4CED2;
	Thu,  9 Jan 2025 04:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736397060;
	bh=u52Td5MsJMyfQGpO8yojmWul1RcM7DlXfDOr8NhTcUM=;
	h=From:To:Cc:Subject:Date:From;
	b=LhOuVK28yitH7z+KSjd7H6ubCIuq10v/mgPFh8I74BPBL8+JP2jrFfR2XoC9yNbyM
	 BX4coNaOVj2LRiSwn4ZxvYb+ujDUL05yPxsS66yHcH7e8SWMmgShflMX2MV2TvauZl
	 D4gvRTH7QQ2040J101Wjitre4LFgTGmVLPHkDL8dDPBtkqHX/rIi4Xw06TtAZW1kFB
	 EhYAOiCFpAsSlHGV2pe4bcB0HYh1xW4JIqxVc3E0XOOU/4ICDXlTcuw6a9tcQJ3V5i
	 Zv+VYSAvJANxL4folf1UEqfGFXOWeS6FsIMLScByU1Ey+vq6m0+/6r+uuhQiL0qtLJ
	 J7sJ0R+h6itlQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	michael.chan@broadcom.com,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net] eth: bnxt: always recalculate features after XDP clearing, fix null-deref
Date: Wed,  8 Jan 2025 20:30:57 -0800
Message-ID: <20250109043057.2888953-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recalculate features when XDP is detached.

Before:
  # ip li set dev eth0 xdp obj xdp_dummy.bpf.o sec xdp
  # ip li set dev eth0 xdp off
  # ethtool -k eth0 | grep gro
  rx-gro-hw: off [requested on]

After:
  # ip li set dev eth0 xdp obj xdp_dummy.bpf.o sec xdp
  # ip li set dev eth0 xdp off
  # ethtool -k eth0 | grep gro
  rx-gro-hw: on

The fact that HW-GRO doesn't get re-enabled automatically is just
a minor annoyance. The real issue is that the features will randomly
come back during another reconfiguration which just happens to invoke
netdev_update_features(). The driver doesn't handle reconfiguring
two things at a time very robustly.

Starting with commit 98ba1d931f61 ("bnxt_en: Fix RSS logic in
__bnxt_reserve_rings()") we only reconfigure the RSS hash table
if the "effective" number of Rx rings has changed. If HW-GRO is
enabled "effective" number of rings is 2x what user sees.
So if we are in the bad state, with HW-GRO re-enablement "pending"
after XDP off, and we lower the rings by / 2 - the HW-GRO rings
doing 2x and the ethtool -L doing / 2 may cancel each other out,
and the:

  if (old_rx_rings != bp->hw_resc.resv_rx_rings &&

condition in __bnxt_reserve_rings() will be false.
The RSS map won't get updated, and we'll crash with:

  BUG: kernel NULL pointer dereference, address: 0000000000000168
  RIP: 0010:__bnxt_hwrm_vnic_set_rss+0x13a/0x1a0
    bnxt_hwrm_vnic_rss_cfg_p5+0x47/0x180
    __bnxt_setup_vnic_p5+0x58/0x110
    bnxt_init_nic+0xb72/0xf50
    __bnxt_open_nic+0x40d/0xab0
    bnxt_open_nic+0x2b/0x60
    ethtool_set_channels+0x18c/0x1d0

As we try to access a freed ring.

The issue is present since XDP support was added, really, but
prior to commit 98ba1d931f61 ("bnxt_en: Fix RSS logic in
__bnxt_reserve_rings()") it wasn't causing major issues.

Fixes: 1054aee82321 ("bnxt_en: Use NETIF_F_GRO_HW.")
Fixes: 98ba1d931f61 ("bnxt_en: Fix RSS logic in __bnxt_reserve_rings()")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com
CC: daniel@iogearbox.net
CC: hawk@kernel.org
CC: john.fastabend@gmail.com
CC: andrew.gospodarek@broadcom.com
CC: pavan.chebbi@broadcom.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 +++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  7 ------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index aeaa74f03046..b6f844cac80e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4708,7 +4708,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
 /* Changing allocation mode of RX rings.
  * TODO: Update when extending xdp_rxq_info to support allocation modes.
  */
-int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
+static void __bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
 {
 	struct net_device *dev = bp->dev;
 
@@ -4729,15 +4729,30 @@ int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
 			bp->rx_skb_func = bnxt_rx_page_skb;
 		}
 		bp->rx_dir = DMA_BIDIRECTIONAL;
-		/* Disable LRO or GRO_HW */
-		netdev_update_features(dev);
 	} else {
 		dev->max_mtu = bp->max_mtu;
 		bp->flags &= ~BNXT_FLAG_RX_PAGE_MODE;
 		bp->rx_dir = DMA_FROM_DEVICE;
 		bp->rx_skb_func = bnxt_rx_skb;
 	}
-	return 0;
+}
+
+void bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
+{
+	__bnxt_set_rx_skb_mode(bp, page_mode);
+
+	if (!page_mode) {
+		int rx, tx;
+
+		bnxt_get_max_rings(bp, &rx, &tx, true);
+		if (rx > 1) {
+			bp->flags &= ~BNXT_FLAG_NO_AGG_RINGS;
+			bp->dev->hw_features |= NETIF_F_LRO;
+		}
+	}
+
+	/* Update LRO and GRO_HW availability */
+	netdev_update_features(bp->dev);
 }
 
 static void bnxt_free_vnic_attributes(struct bnxt *bp)
@@ -16214,7 +16229,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (bp->max_fltr < BNXT_MAX_FLTR)
 		bp->max_fltr = BNXT_MAX_FLTR;
 	bnxt_init_l2_fltr_tbl(bp);
-	bnxt_set_rx_skb_mode(bp, false);
+	__bnxt_set_rx_skb_mode(bp, false);
 	bnxt_set_tpa_flags(bp);
 	bnxt_set_ring_params(bp);
 	bnxt_rdma_aux_device_init(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 7df7a2233307..f11ed59203d9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2846,7 +2846,7 @@ u32 bnxt_fw_health_readl(struct bnxt *bp, int reg_idx);
 bool bnxt_bs_trace_avail(struct bnxt *bp, u16 type);
 void bnxt_set_tpa_flags(struct bnxt *bp);
 void bnxt_set_ring_params(struct bnxt *);
-int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode);
+void bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode);
 void bnxt_insert_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr);
 void bnxt_del_one_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr);
 int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index f88b641533fc..dc51dce209d5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -422,15 +422,8 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 		bnxt_set_rx_skb_mode(bp, true);
 		xdp_features_set_redirect_target(dev, true);
 	} else {
-		int rx, tx;
-
 		xdp_features_clear_redirect_target(dev);
 		bnxt_set_rx_skb_mode(bp, false);
-		bnxt_get_max_rings(bp, &rx, &tx, true);
-		if (rx > 1) {
-			bp->flags &= ~BNXT_FLAG_NO_AGG_RINGS;
-			bp->dev->hw_features |= NETIF_F_LRO;
-		}
 	}
 	bp->tx_nr_rings_xdp = tx_xdp;
 	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tc + tx_xdp;
-- 
2.47.1


