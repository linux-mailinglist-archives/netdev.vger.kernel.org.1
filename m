Return-Path: <netdev+bounces-121095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB0A95BABE
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A991C23600
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB61CC8BB;
	Thu, 22 Aug 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xrOW7BOI"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB101CDFD6
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341294; cv=none; b=T5iFWHm3C7cUQq1vkRuDD0020DEcRlOVJOvYO6v5zuqAQ+t51horaQrOIl8gkHSmyrU4IAipfAQ+I1O8u6dyibeVZSGEOuvEUY6pdlFG/4C2daUBSKDVA7s1BKuMeYrtpClsxMTBIWLQpzoVUCiAIxaMUqtRDNzJ7PfDMVCJjYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341294; c=relaxed/simple;
	bh=8/XFPh25xGSUZ1P8YK1SABWsinsK0clgjIwNTRAEvUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SwnAixh5F/u7rHpeLk5wZWIhPTE2WJC5gObKNMVe7C+h0wj1kQf2WVAjUzQBg2Fj43fJMMaInXrv/YKrPNfBrmGShTSpZ1OgAE3ExVewj/rdiACX9nffZE3bxtC4sL4y/CmQm15CcTw6kG0MyZ6tST3rXZ+6ipfl1oW7wIQOr5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xrOW7BOI; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724341290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XRAKJklo9vBktdRNWOH6AnRZImaO00oA0lmHQ28GKY=;
	b=xrOW7BOICT3ZrLBwTKvk8/GDpheqAjKRKpfd4DQuOyY/9hRd4HODr+fhUFtTcfofIiPOBe
	6HRXugEyX/D8XI3SC0FjP4pPcGOS3/hNyA5GKzGKaKomNbOVHQCVJCmGK3Bb5HoTFWg54e
	IRFuzu8h4XY7bmXzoVyxqoxFqbakPM8=
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
Subject: [PATCH net-next v3 5/5] net: xilinx: axienet: Support IFF_ALLMULTI
Date: Thu, 22 Aug 2024 11:40:59 -0400
Message-Id: <20240822154059.1066595-6-sean.anderson@linux.dev>
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

Add support for IFF_ALLMULTI by configuring a single filter to match the
multicast address bit. This allows us to keep promiscuous mode disabled,
even when we have more than four multicast addresses. An even better
solution would be to "pack" addresses into the available CAM registers,
but that can wait for a future series.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
---

(no changes since v1)

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  2 ++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 34 +++++++++++--------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 5a7d6b872f5d..c301dd2ee083 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -175,6 +175,8 @@
 #define XAE_FFE_OFFSET		0x0000070C /* Frame Filter Enable */
 #define XAE_AF0_OFFSET		0x00000710 /* Address Filter 0 */
 #define XAE_AF1_OFFSET		0x00000714 /* Address Filter 1 */
+#define XAE_AM0_OFFSET		0x00000750 /* Frame Filter Mask Value Bytes 3-0 */
+#define XAE_AM1_OFFSET		0x00000754 /* Frame Filter Mask Value Bytes 7-4 */
 
 #define XAE_TX_VLAN_DATA_OFFSET 0x00004000 /* TX VLAN data table address */
 #define XAE_RX_VLAN_DATA_OFFSET 0x00008000 /* RX VLAN data table address */
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 5c4a5949a021..fe6a0e2e463f 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -437,18 +437,27 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 	u32 reg, af0reg, af1reg;
 	struct axienet_local *lp = netdev_priv(ndev);
 
-	if (ndev->flags & (IFF_ALLMULTI | IFF_PROMISC) ||
-	    netdev_mc_count(ndev) > XAE_MULTICAST_CAM_TABLE_NUM) {
-		reg = axienet_ior(lp, XAE_FMI_OFFSET);
+	reg = axienet_ior(lp, XAE_FMI_OFFSET);
+	reg &= ~XAE_FMI_PM_MASK;
+	if (ndev->flags & IFF_PROMISC)
 		reg |= XAE_FMI_PM_MASK;
+	else
+		reg &= ~XAE_FMI_PM_MASK;
+	axienet_iow(lp, XAE_FMI_OFFSET, reg);
+
+	if (ndev->flags & IFF_ALLMULTI ||
+	    netdev_mc_count(ndev) > XAE_MULTICAST_CAM_TABLE_NUM) {
+		reg &= 0xFFFFFF00;
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
+		axienet_iow(lp, XAE_AF0_OFFSET, 1); /* Multicast bit */
+		axienet_iow(lp, XAE_AF1_OFFSET, 0);
+		axienet_iow(lp, XAE_AM0_OFFSET, 1); /* ditto */
+		axienet_iow(lp, XAE_AM1_OFFSET, 0);
+		axienet_iow(lp, XAE_FFE_OFFSET, 1);
+		i = 1;
 	} else if (!netdev_mc_empty(ndev)) {
 		struct netdev_hw_addr *ha;
 
-		reg = axienet_ior(lp, XAE_FMI_OFFSET);
-		reg &= ~XAE_FMI_PM_MASK;
-		axienet_iow(lp, XAE_FMI_OFFSET, reg);
-
 		netdev_for_each_mc_addr(ha, ndev) {
 			if (i >= XAE_MULTICAST_CAM_TABLE_NUM)
 				break;
@@ -461,24 +470,21 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 			af1reg = (ha->addr[4]);
 			af1reg |= (ha->addr[5] << 8);
 
-			reg = axienet_ior(lp, XAE_FMI_OFFSET) & 0xFFFFFF00;
+			reg &= 0xFFFFFF00;
 			reg |= i;
 
 			axienet_iow(lp, XAE_FMI_OFFSET, reg);
 			axienet_iow(lp, XAE_AF0_OFFSET, af0reg);
 			axienet_iow(lp, XAE_AF1_OFFSET, af1reg);
+			axienet_iow(lp, XAE_AM0_OFFSET, 0xffffffff);
+			axienet_iow(lp, XAE_AM1_OFFSET, 0x0000ffff);
 			axienet_iow(lp, XAE_FFE_OFFSET, 1);
 			i++;
 		}
-	} else {
-		reg = axienet_ior(lp, XAE_FMI_OFFSET);
-		reg &= ~XAE_FMI_PM_MASK;
-
-		axienet_iow(lp, XAE_FMI_OFFSET, reg);
 	}
 
 	for (; i < XAE_MULTICAST_CAM_TABLE_NUM; i++) {
-		reg = axienet_ior(lp, XAE_FMI_OFFSET) & 0xFFFFFF00;
+		reg &= 0xFFFFFF00;
 		reg |= i;
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
 		axienet_iow(lp, XAE_FFE_OFFSET, 0);
-- 
2.35.1.1320.gc452695387.dirty


