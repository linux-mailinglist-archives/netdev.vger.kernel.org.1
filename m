Return-Path: <netdev+bounces-210432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 678DFB13516
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 08:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C974A3B884A
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 06:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D8421FF50;
	Mon, 28 Jul 2025 06:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cswc0eCx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF642E36E6;
	Mon, 28 Jul 2025 06:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753685394; cv=none; b=GYZpwvHZ1po0+7SQk/ElxWXbRTBvzaG2dExKN1QCANxUCPg7NV2fW41EbGFLEto0x4Csi6PeZV7LR2hZE9UiTmBO6Pd7D4EAX1B3+cv9AwyIN8t2WclKC4VVBtCVnyeDmGM3FeKXzH1V0RGq+ARFKOpozx6t1DaE/UyKYb/zuhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753685394; c=relaxed/simple;
	bh=uAX8Lw55ZwWtTrr9I5WDi7Xk2+x+7/0Pib/WIeArjGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F4AnZXATVRevHRL4vIFIHa8tbVpXjy7tgMW+RcvAWxYwvZvY2CRduEJBJ0o6OkZTiDv4P3MHqLv78BWBC/eXn9eepJrsB5Fz5/BYsVJXm+1evdRCO1fJmmZLEbaag6MYGNByAkNudtFAfjXgfmakPDSiOusQNb6RIIR3HhzhQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cswc0eCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D7CC4CEF4;
	Mon, 28 Jul 2025 06:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753685394;
	bh=uAX8Lw55ZwWtTrr9I5WDi7Xk2+x+7/0Pib/WIeArjGo=;
	h=From:To:Cc:Subject:Date:From;
	b=Cswc0eCxHw1vURagW9/hdGAAnuyRjWdY3lhAkgmuux42zuC/AS17NnWWm8/CHofHo
	 ctK8sb7isfaklNC3QIHUbEr+A1jEpdD8fc8uowMEtyE9Wr+bQnxuyOvLpiO+h5z6eh
	 LzANJ4JpEXLRbZB6CLhyO9J2j3uAybugxRTDbjmX5IWc/7DUTygKpEQ7wDSA1hbMA+
	 dbrGdhf3R7N+TKc2Xtfw6I0g/ZowQoZ+VcMyoeS76KP34r1zIWk/6KD1M+JEuB/5dD
	 V4BRyB09mdWRgSeiie9Kt1jiLxW+2IS9AV9MTdAFyMjldP0meSwTHIFLzvKBVCRKTu
	 nEMCwRXkULOew==
From: Michael Walle <mwalle@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Roger Quadros <rogerq@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH net-next] Revert "net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed RGMII TX delay"
Date: Mon, 28 Jul 2025 08:49:38 +0200
Message-Id: <20250728064938.275304-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit ca13b249f291f4920466638d1adbfb3f9c8db6e9.

This patch breaks the transmit path on an AM67A/J722S. This SoC has an
(undocumented) configurable delay (CTRL_MMR0_CFG0_ENET1_CTRL, bit 4).

The u-boot driver (net/ti/am65-cpsw-nuss.c) will configure the delay in
am65_cpsw_gmii_sel_k3(). If the u-boot device tree uses rgmii-id this
patch will break the transmit path because it will disable the PHY delay
on the transmit path, but the bootloader has already disabled the MAC
delay, hence there will be no delay at all.

Although the datasheet reads the delay is fixed, that is at least
wrong for the J722S/AM67A and apparently for at least the AM65x
(which was the original target of the u-boot driver).

Fixes: ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed RGMII TX delay")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
This is targeted as net-next although the merge window is open, because
the original patch is just in net-next.
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 27 ++----------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index ecd6ecac87bb..231ca141331f 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2600,7 +2600,6 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 		return -ENOENT;
 
 	for_each_child_of_node(node, port_np) {
-		phy_interface_t phy_if;
 		struct am65_cpsw_port *port;
 		u32 port_id;
 
@@ -2666,36 +2665,14 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 
 		/* get phy/link info */
 		port->slave.port_np = of_node_get(port_np);
-		ret = of_get_phy_mode(port_np, &phy_if);
+		ret = of_get_phy_mode(port_np, &port->slave.phy_if);
 		if (ret) {
 			dev_err(dev, "%pOF read phy-mode err %d\n",
 				port_np, ret);
 			goto of_node_put;
 		}
 
-		/* CPSW controllers supported by this driver have a fixed
-		 * internal TX delay in RGMII mode. Fix up PHY mode to account
-		 * for this and warn about Device Trees that claim to have a TX
-		 * delay on the PCB.
-		 */
-		switch (phy_if) {
-		case PHY_INTERFACE_MODE_RGMII_ID:
-			phy_if = PHY_INTERFACE_MODE_RGMII_RXID;
-			break;
-		case PHY_INTERFACE_MODE_RGMII_TXID:
-			phy_if = PHY_INTERFACE_MODE_RGMII;
-			break;
-		case PHY_INTERFACE_MODE_RGMII:
-		case PHY_INTERFACE_MODE_RGMII_RXID:
-			dev_warn(dev,
-				 "RGMII mode without internal TX delay unsupported; please fix your Device Tree\n");
-			break;
-		default:
-			break;
-		}
-
-		port->slave.phy_if = phy_if;
-		ret = phy_set_mode_ext(port->slave.ifphy, PHY_MODE_ETHERNET, phy_if);
+		ret = phy_set_mode_ext(port->slave.ifphy, PHY_MODE_ETHERNET, port->slave.phy_if);
 		if (ret)
 			goto of_node_put;
 
-- 
2.39.5


