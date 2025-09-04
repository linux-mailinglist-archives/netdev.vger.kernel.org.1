Return-Path: <netdev+bounces-219795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207E8B4304D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 05:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DEB207999
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 03:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38CA27FB06;
	Thu,  4 Sep 2025 03:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="IAZv1PYE"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED391C8CE;
	Thu,  4 Sep 2025 03:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756955637; cv=none; b=kQLMoGmN9mbMFtWV/kkdIZLAUFei8eGZr3yyMnXp2F770ZdAVIwGHB7fdJsAtdR/qPGI/RpYMqLDvSeHz1H8j6iT6UPG/qSYYgRz0f3E2yv30NPO9Rpi4P9tBz+Pg0FaugNH19a/yfG0dtqb4IzkycSRlUD+uJcAE/jXGobYqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756955637; c=relaxed/simple;
	bh=/9+CJqX1fS+UiFee8YHounmOVjuOHZemA2Z3M9XlkQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NwIGSuSJYyhO6feLNqDLbrpsVaR6OY6O8zCi16ku7VgK2EhRKBlwgqHXjzTAD22CJwYkbpXldoIxIt/FC52cG/8VfMgeY5PHNLCNoBK2z4m1EFUTP0YP8sSQ66VPg+S4Y2EB3anunZjQGySNEE48GyU7dPG6VO8MLw65ISB4fao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=IAZv1PYE; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 32F9D25C7A;
	Thu,  4 Sep 2025 05:13:53 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AFJ3nJp-J8Y8; Thu,  4 Sep 2025 05:13:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1756955632; bh=/9+CJqX1fS+UiFee8YHounmOVjuOHZemA2Z3M9XlkQs=;
	h=From:To:Cc:Subject:Date;
	b=IAZv1PYEoOH/IBuhDPdjQ4Yr/XQmioZXmZxqmEvX5yuLh2NdlEYpFZjl3mxfeoNS4
	 6rFOh2EKybtfqR4bpdUwloekmlRk11lxNpgIAW3yppbGdZ7X++wXuXgTo3dNcKbfDq
	 8u/7F3suLrnFoAj7aidkPIkUqvuBFecg0Dqj14398qr5kFjx+0sUCwmxHZkEQV3ePn
	 LE1ogfDoNip3D8BDIdxLxB0ynM+3e0TEupGIBcMFXOsM2WNaaJPFg5EQy6H7AibfQZ
	 BYBWv95rX6375Uk3k4FY38MNvulpBHDtm3uwu6650sI3ZDjZbZeYwxm1dtp1fzAu1S
	 hwUSTZpKZJVvQ==
From: Yao Zi <ziyao@disroot.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jonas Karlman <jonas@kwiboo.se>,
	David Wu <david.wu@rock-chips.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH net] net: stmmac: dwmac-rk: Ensure clk_phy doesn't contain invalid address
Date: Thu,  4 Sep 2025 03:12:24 +0000
Message-ID: <20250904031222.40953-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We must set the clk_phy pointer to NULL to indicating it isn't available
if the optional phy clock couldn't be obtained. Otherwise the error code
returned by of_clk_get() could be wrongly taken as an address, causing
invalid pointer dereference when later clk_phy is passed to
clk_prepare_enable().

Fixes: da114122b831 ("net: ethernet: stmmac: dwmac-rk: Make the clk_phy could be used for external phy")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

On next-20250903, the fixed commit causes NULL pointer dereference on
Radxa E20C during probe of dwmac-rk, a typical dmesg looks like

[    0.273324] rk_gmac-dwmac ffbe0000.ethernet: IRQ eth_lpi not found
[    0.273888] rk_gmac-dwmac ffbe0000.ethernet: IRQ sfty not found
[    0.274520] rk_gmac-dwmac ffbe0000.ethernet: PTP uses main clock
[    0.275226] rk_gmac-dwmac ffbe0000.ethernet: clock input or output? (output).
[    0.275867] rk_gmac-dwmac ffbe0000.ethernet: Can not read property: tx_delay.
[    0.276491] rk_gmac-dwmac ffbe0000.ethernet: set tx_delay to 0x30
[    0.277026] rk_gmac-dwmac ffbe0000.ethernet: Can not read property: rx_delay.
[    0.278086] rk_gmac-dwmac ffbe0000.ethernet: set rx_delay to 0x10
[    0.278658] rk_gmac-dwmac ffbe0000.ethernet: integrated PHY? (no).
[    0.279249] Unable to handle kernel paging request at virtual address fffffffffffffffe
[    0.279948] Mem abort info:
[    0.280195]   ESR = 0x000000096000006
[    0.280523]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.280989]   SET = 0, FnV = 0
[    0.281287]   EA = 0, S1PTW = 0
[    0.281574]   FSC = 0x06: level 2 translation fault

where the invalid address is just -ENOENT (-2).

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index cf619a428664..26ec8ae662a6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1414,11 +1414,17 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
 	if (plat->phy_node) {
 		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
 		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
-		/* If it is not integrated_phy, clk_phy is optional */
+		/*
+		 * If it is not integrated_phy, clk_phy is optional. But we must
+		 * set bsp_priv->clk_phy to NULL if clk_phy isn't proivded, or
+		 * the error code could be wrongly taken as an invalid pointer.
+		 */
 		if (bsp_priv->integrated_phy) {
 			if (ret)
 				return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
 			clk_set_rate(bsp_priv->clk_phy, 50000000);
+		} else if (ret) {
+			bsp_priv->clk_phy = NULL;
 		}
 	}
 
-- 
2.50.1


