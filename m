Return-Path: <netdev+bounces-121092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D69D95BAB7
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19429B244DB
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AA91CCEE0;
	Thu, 22 Aug 2024 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wpbdy4IR"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25491CCB23
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341288; cv=none; b=dGIJqGSNmk+EXEs4Cr9EcM4c5kjBQTVJbhlxzrmIab8sgkkfXCk6i5/dLTyf4Wwbfor0whTKmfsiY0bKFESZ6Ou0bDlHYybNIWn5kzSWM0O0KCeygi97c/84VkM5BQit7kXdRWunGGNoyEgfcPZwEiAJMapKgUawXzfAQC6fQk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341288; c=relaxed/simple;
	bh=ohfgIxeTRkOynqIzCgEfaM2k2evnvYdBi/1XB5KwvYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pymaIduo0s1du4A8IS7TmaJjIgfrbR+KLwbR5plpMscoubFfWCt/x8CcAFDC/ZNGLyveGp1u3dyWWAT4WXPI91JZEK9hw+OSBGuabVpoDH4vlkDMaIdohLG0UBCWeb6eWSumXPCgVPg/raFcqZ44l1zICHejwyhAQmgtQTl4KzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wpbdy4IR; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724341284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3Ul9dr4s0FV4zx4bC150nxiBfsOJmq4YQc7DzBJrag=;
	b=wpbdy4IRMQLwHZGkL61ND+PvbrxOcqyS662/tmiXVD+QeQB39rXooWX7QebrpvPnFoWHi/
	yiw1SofstlxTF0MYmi6eS+LZDdZfu3AxARN6rLTAUcUUNrqaUsRzSV20vEGLd9KWiSNrQB
	g7xWp8fFeZUZHXs9WL+9HqCYzLHJOcw=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Eric Dumazet <edumazet@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v3 2/5] net: xilinx: axienet: Fix dangling multicast addresses
Date: Thu, 22 Aug 2024 11:40:56 -0400
Message-Id: <20240822154059.1066595-3-sean.anderson@linux.dev>
In-Reply-To: <20240822154059.1066595-1-sean.anderson@linux.dev>
References: <20240822154059.1066595-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If a multicast address is removed but there are still some multicast
addresses, that address would remain programmed into the frame filter.
Fix this by explicitly setting the enable bit for each filter.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
---

(no changes since v1)

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  1 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 21 ++++++++-----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 8165f5f271ff..5a7d6b872f5d 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -172,6 +172,7 @@
 #define XAE_UAW0_OFFSET		0x00000700 /* Unicast address word 0 */
 #define XAE_UAW1_OFFSET		0x00000704 /* Unicast address word 1 */
 #define XAE_FMI_OFFSET		0x00000708 /* Frame Filter Control */
+#define XAE_FFE_OFFSET		0x0000070C /* Frame Filter Enable */
 #define XAE_AF0_OFFSET		0x00000710 /* Address Filter 0 */
 #define XAE_AF1_OFFSET		0x00000714 /* Address Filter 1 */
 
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 6fad473a937b..88ff82c52d0c 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -433,7 +433,7 @@ static int netdev_set_mac_address(struct net_device *ndev, void *p)
  */
 static void axienet_set_multicast_list(struct net_device *ndev)
 {
-	int i;
+	int i = 0;
 	u32 reg, af0reg, af1reg;
 	struct axienet_local *lp = netdev_priv(ndev);
 
@@ -455,7 +455,6 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 		reg &= ~XAE_FMI_PM_MASK;
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
 
-		i = 0;
 		netdev_for_each_mc_addr(ha, ndev) {
 			if (i >= XAE_MULTICAST_CAM_TABLE_NUM)
 				break;
@@ -474,6 +473,7 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 			axienet_iow(lp, XAE_FMI_OFFSET, reg);
 			axienet_iow(lp, XAE_AF0_OFFSET, af0reg);
 			axienet_iow(lp, XAE_AF1_OFFSET, af1reg);
+			axienet_iow(lp, XAE_FFE_OFFSET, 1);
 			i++;
 		}
 	} else {
@@ -481,18 +481,15 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 		reg &= ~XAE_FMI_PM_MASK;
 
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
-
-		for (i = 0; i < XAE_MULTICAST_CAM_TABLE_NUM; i++) {
-			reg = axienet_ior(lp, XAE_FMI_OFFSET) & 0xFFFFFF00;
-			reg |= i;
-
-			axienet_iow(lp, XAE_FMI_OFFSET, reg);
-			axienet_iow(lp, XAE_AF0_OFFSET, 0);
-			axienet_iow(lp, XAE_AF1_OFFSET, 0);
-		}
-
 		dev_info(&ndev->dev, "Promiscuous mode disabled.\n");
 	}
+
+	for (; i < XAE_MULTICAST_CAM_TABLE_NUM; i++) {
+		reg = axienet_ior(lp, XAE_FMI_OFFSET) & 0xFFFFFF00;
+		reg |= i;
+		axienet_iow(lp, XAE_FMI_OFFSET, reg);
+		axienet_iow(lp, XAE_FFE_OFFSET, 0);
+	}
 }
 
 /**
-- 
2.35.1.1320.gc452695387.dirty


