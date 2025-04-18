Return-Path: <netdev+bounces-184108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21733A935CB
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 12:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83550466D98
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AB42741B9;
	Fri, 18 Apr 2025 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="aIsvloBf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m3284.qiye.163.com (mail-m3284.qiye.163.com [220.197.32.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC0626FD8C;
	Fri, 18 Apr 2025 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744970809; cv=none; b=esCTLAdxDMHHq5oy2NfQOdwrY9mGmWnGEuNDr4Rphpra7yvuP9xZcfNwp+ojAITqvmn5B2iVvdimzkKfp3vaAzcMCvGvivEIYT72kCO0I1IORCpWMTXfFSg62pdyaA4bsu/piXt76X1enVtOrjy5s9eM0OfVcKIg2pdIZKREgQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744970809; c=relaxed/simple;
	bh=ZCH9iYJ0vfC3zyfr+ro7OeHUb8DRov0Dtb0Nu2wJAs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TpW2iEyr4VhUWY+OXIyeNWFrtYEGF3tGHR3LUcQKrwGWXk0/PF4xGs/uhcGFTBDbpP6bs+ixN/z77OEzQehDfEFYscaygz0ToMP4UOwwJN+e9Zldiyg/eTJjqaTUvhzFdgPVus+LPqjcxrOwOwWpwFojcVVu7myZQYFqLRRjzO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=aIsvloBf; arc=none smtp.client-ip=220.197.32.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 125a97193;
	Fri, 18 Apr 2025 17:51:20 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	David Wu <david.wu@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	netdev@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 3/3] ethernet: stmmac: dwmac-rk: Make the phy clock could be used for external phy
Date: Fri, 18 Apr 2025 17:51:14 +0800
Message-Id: <20250418095114.271562-3-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250418095114.271562-1-kever.yang@rock-chips.com>
References: <20250418095114.271562-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ09JSlZLQ0saH0seSUNPSx9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96484f541803afkunm125a97193
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxg6HSo4OTJRFgorSUhJI1FO
	GBdPChNVSlVKTE9PQk1CQ0NJSU5DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0lDNwY+
DKIM-Signature:a=rsa-sha256;
	b=aIsvloBfoUv0GslYV58lWI7EmDBe+MlX+QXMqQLdeV5Fe9ADD6yiZPce7TAeWNiQE84AIFKe+Jdw4XGERK8MVZewOzXhj6XgO4EF8Dxet17Ll6HogvUCQIz0BHsKh3hB7QtY3a8j5fu33+8kHPYuYTCum2KqybyJcjNGPQSdRP8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=en5gdMxExqw1aD8bG9IqTvDUrdOVPKSMS7wnF9SEYCg=;
	h=date:mime-version:subject:message-id:from;

From: David Wu <david.wu@rock-chips.com>

Use the phy_clk to prepare_enable and unprepare_disable related phy clock.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v3:
- Update the code logic for backwards compatible;

Changes in v2: None

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 82174054644a..b237771f687a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1784,12 +1784,17 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
 		clk_set_rate(bsp_priv->clk_mac, 50000000);
 	}
 
-	if (plat->phy_node && bsp_priv->integrated_phy) {
+	if (plat->phy_node) {
 		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
-		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
-		if (ret)
-			return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
-		clk_set_rate(bsp_priv->clk_phy, 50000000);
+		/* If it is not integrated_phy, clk_phy is optional */
+		if (bsp_priv->integrated_phy) {
+			if (IS_ERR(bsp_priv->clk_phy)) {
+				ret = PTR_ERR(bsp_priv->clk_phy);
+				dev_err(dev, "Cannot get PHY clock: %d\n", ret);
+				return -EINVAL;
+			}
+			clk_set_rate(bsp_priv->clk_phy, 50000000);
+		}
 	}
 
 	return 0;
-- 
2.25.1


