Return-Path: <netdev+bounces-170191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B53A47B79
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E6616EBB0
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6622022DF9A;
	Thu, 27 Feb 2025 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SDzKw6O1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m15597.qiye.163.com (mail-m15597.qiye.163.com [101.71.155.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209C822DFA5;
	Thu, 27 Feb 2025 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654430; cv=none; b=s574CetsFBLVrCxsvgs9RihvaEg8oYsOI3fhyTPTC6ZQZYQw7PD20aISamBsQiy+aIHK1qOoLyk7CxgfZy9eB4FXv44CHkR6z17nQidiFDA96AJHOvkzai5uhw3SIMBoVODqWHOSEDj6HfFBGBQ/wmHoml8H3GXWATF8EuEcxNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654430; c=relaxed/simple;
	bh=QcScKeljPaP6q4KsbNlSyNEca/2Bc0ZZ2CPbrSexmoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TahogSnQJQhpXxZ8b+HMFYsr1sr8sHggdNoh2fDsRXzIAoIzS/t80Pr4UQlFvd1EsKS4ruKqLk/nexVz43yQqRTO+ewVt16Ztr4rSKly5JHy+IyG7xY50G/YROT+pS5Q9P3N8yceB/HzgN9DzZM5d4wHRfom81ds6iZDGkZV95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SDzKw6O1; arc=none smtp.client-ip=101.71.155.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65b3758;
	Thu, 27 Feb 2025 19:06:58 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	David Wu <david.wu@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 3/3] ethernet: stmmac: dwmac-rk: Make the phy clock could be used for external phy
Date: Thu, 27 Feb 2025 19:06:52 +0800
Message-Id: <20250227110652.2342729-3-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227110652.2342729-1-kever.yang@rock-chips.com>
References: <20250227110652.2342729-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUwfSFZLQ0sfSUweSUpIHktWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
X-HM-Tid: 0a954716998c03afkunmc65b3758
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCo6TDo*NDIQQg0KEhQ4L05K
	Hi8aChFVSlVKTE9LTU5PT0pCQk9OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSU5KNwY+
DKIM-Signature:a=rsa-sha256;
	b=SDzKw6O1ad1HTN56DBqdOpnbD7IMM+V26Hprp/qQctw4Cq814Ew4vphHWMvo41Uo9IMcW2QvJHtUuP2ioVhdBgeWTgdGcKx0grhhKovB11Ggb6cYv5x0U0Pz235kKKtt8REWDYLndDhLkQduFSLlfMP1UWfQMEOuVzGN9GhTROc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=jrwDkuFUXUDj9MICD8KUchO+3GWZ8SbQ7JyWrq5N/Ck=;
	h=date:mime-version:subject:message-id:from;

From: David Wu <david.wu@rock-chips.com>

Use the phy_clk to prepare_enable and unprepare_disable related phy clock.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2: None

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index ccf4ecdffad3..cc90c74ec70c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1867,12 +1867,14 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
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


