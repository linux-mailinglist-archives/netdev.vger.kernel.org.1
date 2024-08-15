Return-Path: <netdev+bounces-118962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74925953AF4
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2986F1F256BD
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0981509B4;
	Thu, 15 Aug 2024 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="icv7P/YP"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134C14EC51
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750598; cv=none; b=jb8ZRp7mWRwKtZdJr8+PM3BaCpnprtJ8MsZWmbLps8K36Dww7/6Eaml9MmfzIIIIfzQhKUdORhzxjaV46oczHHxTeiQY1+6tFC7sQ92fYQyzf5X2ThLr1Xlq/EDaVMcL3Aqsq0+TIgRCmlEnEXMxyoWc9ARNukvS7VV7hkBSFFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750598; c=relaxed/simple;
	bh=xyG4ID1L/kWmN1CjIqb7sv+QYxyA4Ge8/8dWxThTCYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=So6jFoHQwpIiExhS636RDjV9lgPFq8R8Kya+ArMRSGu9iX2EKpeTah6Ctz2+5cnPHYSz/9nQRaeaI+FmDqZ4iNdvIPeevNKj1AH1Ah+G2/JZpflzBmUqNdkhNDEpr9kTA8ofMDYfw/uYRlRJVpX6XT43MC8JoGeU96+i7tZqaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=icv7P/YP; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723750595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4kvv6JhT/h3sb0rBqC1P9JMctOhljJhc6Mf41GF+Lc=;
	b=icv7P/YPIT+rlH5++UI71iq3hQEfP0CMLN1Zs7L4Vb8Zbmvw5imy26tgwHPGds7gl4MKbP
	Ze+gOuTyc8mO4UUOjFrUXXcDyd4iVpzcVpV/eaNkz01tQTGTU3CA2Px0b1dz8MPILWs1AD
	bSx676YfzcRN8LiwplcNv5lpyWjDFJE=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 5/5] net: xilinx: axienet: Support IFF_ALLMULTI
Date: Thu, 15 Aug 2024 15:36:14 -0400
Message-Id: <20240815193614.4120810-6-sean.anderson@linux.dev>
In-Reply-To: <20240815193614.4120810-1-sean.anderson@linux.dev>
References: <20240815193614.4120810-1-sean.anderson@linux.dev>
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
index 03fef656478e..d1b68a040f5a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -173,6 +173,8 @@
 #define XAE_FFE_OFFSET		0x0000070C /* Frame Filter Enable */
 #define XAE_AF0_OFFSET		0x00000710 /* Address Filter 0 */
 #define XAE_AF1_OFFSET		0x00000714 /* Address Filter 1 */
+#define XAE_AM0_OFFSET		0x00000750 /* Frame Filter Mask Value Bytes 3-0 */
+#define XAE_AM1_OFFSET		0x00000754 /* Frame Filter Mask Value Bytes 7-4 */
 
 #define XAE_TX_VLAN_DATA_OFFSET 0x00004000 /* TX VLAN data table address */
 #define XAE_RX_VLAN_DATA_OFFSET 0x00008000 /* RX VLAN data table address */
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 9bcad515f156..c420bc753750 100644
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


