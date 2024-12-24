Return-Path: <netdev+bounces-154157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87099FBB65
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 10:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92D81885C92
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 09:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424A71B4123;
	Tue, 24 Dec 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="keaZ/7pO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m1973196.qiye.163.com (mail-m1973196.qiye.163.com [220.197.31.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214D1B0F1E;
	Tue, 24 Dec 2024 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033302; cv=none; b=DtKYsdfMP9uh4tgcAtCJwUmFlMs+H9o/+lNCaouTKgNI9oCBT/k1owO3D278/YF4CGRU90/oL3TkW7uWCxP7SE4TKXA/EJ20f0M6HANFwd9IM1bE7rnwO9XjeW16qByf02sZPjrDSnWxcr/2VKI//eJ7INZHeYZemDHVCQzzQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033302; c=relaxed/simple;
	bh=jCfcWPXp1ES7rGtk3Xj1haInOpKdDARGk201JY8Nv9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q2COFzddqhHkW8lYZhHN0yggIlI3ycmwQOLLCovwuKW6tmzNexoX1edfkW6NQXiT+CUpvJyjjfP3XmoFdrxQFVSps4F2c2U2wO7iuqTO1jBHz0HEpMryMAZC5tJvV81GapTTSa/dIWOX18YPX4FHivQ/9VYY9RWfjQKU6t8ArX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=keaZ/7pO; arc=none smtp.client-ip=220.197.31.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 6aaa2b9d;
	Tue, 24 Dec 2024 17:41:30 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	David Wu <david.wu@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Jose Abreu <joabreu@synopsys.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] ethernet: stmmac: dwmac-rk: Make the phy clock could be used for external phy
Date: Tue, 24 Dec 2024 17:41:24 +0800
Message-Id: <20241224094124.3816698-3-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241224094124.3816698-1-kever.yang@rock-chips.com>
References: <20241224094124.3816698-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRlIQ1ZITU8YTRhCS0lCQxhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93f80afe1f03afkunm6aaa2b9d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NE06DAw*TjIXTUopLDAzNyEt
	CBIKCxhVSlVKTEhOS0hISUJKQk5OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSUlDNwY+
DKIM-Signature:a=rsa-sha256;
	b=keaZ/7pOSGwKLmGDnHnM7/DGM2W5JdYsOoHegm9IGwDgiKS372WQ+8A6KGjXBxnLiTshkEojX6CbhlzJvuLYR7QtHQRxesCyf70+WZLWLKZQHHiwBtq8YDqsYxB3314f+wmw/5FvPnxpEEMIaUssQs8l7H/tEEgBjnlwj67sUBo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Pg5dVbwxypJNMGI16c4GjNAYB+dPf/j5RN5duzxkZX8=;
	h=date:mime-version:subject:message-id:from;

From: David Wu <david.wu@rock-chips.com>

Use the phy_clk to prepare_enable and unprepare_disable related phy clock.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 2ce38bf205d4..506c7daefa63 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1885,12 +1885,14 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
 		clk_set_rate(bsp_priv->clk_mac, 50000000);
 	}
 
-	if (plat->phy_node && bsp_priv->integrated_phy) {
+	if (plat->phy_node) {
 		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
 		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
 		if (ret)
 			return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
-		clk_set_rate(bsp_priv->clk_phy, 50000000);
+		/* If it is not integrated_phy, clk_phy is optional */
+		if (bsp_priv->integrated_phy)
+			clk_set_rate(bsp_priv->clk_phy, 50000000);
 	}
 
 	return 0;
-- 
2.25.1


