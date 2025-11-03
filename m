Return-Path: <netdev+bounces-235046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92147C2B8C0
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54FB94F3FCF
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D86304969;
	Mon,  3 Nov 2025 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GcRQzZj5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD433043B4
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170640; cv=none; b=InFJB5nXNBBRK/w0VNVE4nuiHrI98BkuM3uEyrQGAegmL5alluSPF0tEj6WQDnHu6/vS7jQo6bYpdZGQx67RDprmn96pad6pmDn7cJw2fL+joUM08igenkOB3wfEGSIaRO9wkVdrzgy5Z2+oWpujZ+9suzZ1KZje48JkFD4zs/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170640; c=relaxed/simple;
	bh=/mFa0Jbxp90SO6iCwqYJtXQgTuJ40SBXJeUHrBspyR0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=f/g3iZ6HN3HRG8XHKF5qlnTbPkPehOBqiESHjHhugeU6tWUNCTsEULsRzugM7evFkNbZgHVEh+v06P2eYuCYpH41nnbUL+mmTSwk1Hz+NUXJObHNLEmCYlKxM2S+jfr9IPx8EAkgCDsWSa3m4XbdWoXiCK0c7OroHAipXPai0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GcRQzZj5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+Dqc1o+TXCFPHgAJeb3WkN4OQLaaOvn2AuUElfR+DHY=; b=GcRQzZj5+EHYWRD6Hu1HFfSpFG
	XbWk655wAKMtM0hondOWIxRoPt6FpX0MnCMRtUO3zC/RIeoM80byWGbGsiCT998S2wIeF8NMSQdTv
	Lj+/uQFvfu2dCyinNiEfG4MJ/Op9HJzpLvA48/3g4ciqoKmAyvBuonI9lniSrIw4rgyr2NC+yNiu5
	Upv4tFKczAYUD8tC7yhyqZlBKuy3aGYebeeBg3D1+qvteBUvzASlviBrt/RUPorxU+GL5U/pXdCXD
	qc9dG8nkk7NzDuFkgAu71u0HfOmTmpPi2Hj4m6ar4eZdDHtB7EjInhfW7gTbOnUe9x+pNNI8y6h4F
	zsP2JVMQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41444 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vFt4o-000000000gn-2KqT;
	Mon, 03 Nov 2025 11:50:22 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vFt4n-0000000Choy-0IeG;
	Mon, 03 Nov 2025 11:50:21 +0000
In-Reply-To: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
References: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	s32@nxp.com,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH net-next 06/11] net: stmmac: imx: convert to PHY_INTF_SEL_xxx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vFt4n-0000000Choy-0IeG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 03 Nov 2025 11:50:21 +0000

Convert dwmac-imx to use the PHY_INTF_SEL_xxx definitions rather than
constants via:
- ensuring that the prefix for the MASK and value definitions is the
  same.
- using FIELD_PREP() to shift the PHY_INTF_SEL_xxx definition to the
  appropriate bitfield.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 147fa08d5b6e..4fbee59e7337 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -23,18 +23,25 @@
 #include "stmmac_platform.h"
 
 #define GPR_ENET_QOS_INTF_MODE_MASK	GENMASK(21, 16)
-#define GPR_ENET_QOS_INTF_SEL_MII	(0x0 << 16)
-#define GPR_ENET_QOS_INTF_SEL_RMII	(0x4 << 16)
-#define GPR_ENET_QOS_INTF_SEL_RGMII	(0x1 << 16)
+#define GPR_ENET_QOS_INTF_SEL_MASK	GENMASK(20, 16)
+#define GPR_ENET_QOS_INTF_SEL_MII	FIELD_PREP(GPR_ENET_QOS_INTF_SEL_MASK, \
+						   PHY_INTF_SEL_GMII_MII)
+#define GPR_ENET_QOS_INTF_SEL_RMII	FIELD_PREP(GPR_ENET_QOS_INTF_SEL_MASK, \
+						   PHY_INTF_SEL_RMII)
+#define GPR_ENET_QOS_INTF_SEL_RGMII	FIELD_PREP(GPR_ENET_QOS_INTF_SEL_MASK, \
+						   PHY_INTF_SEL_RGMII)
 #define GPR_ENET_QOS_CLK_GEN_EN		(0x1 << 19)
 #define GPR_ENET_QOS_CLK_TX_CLK_SEL	(0x1 << 20)
 #define GPR_ENET_QOS_RGMII_EN		(0x1 << 21)
 
 #define MX93_GPR_ENET_QOS_INTF_MODE_MASK	GENMASK(3, 0)
-#define MX93_GPR_ENET_QOS_INTF_MASK		GENMASK(3, 1)
-#define MX93_GPR_ENET_QOS_INTF_SEL_MII		(0x0 << 1)
-#define MX93_GPR_ENET_QOS_INTF_SEL_RMII		(0x4 << 1)
-#define MX93_GPR_ENET_QOS_INTF_SEL_RGMII	(0x1 << 1)
+#define MX93_GPR_ENET_QOS_INTF_SEL_MASK		GENMASK(3, 1)
+#define MX93_GPR_ENET_QOS_INTF_SEL_MII		FIELD_PREP(MX93_GPR_ENET_QOS_INTF_SEL_MASK, \
+							   PHY_INTF_SEL_GMII_MII)
+#define MX93_GPR_ENET_QOS_INTF_SEL_RMII		FIELD_PREP(MX93_GPR_ENET_QOS_INTF_SEL_MASK, \
+							   PHY_INTF_SEL_RMII)
+#define MX93_GPR_ENET_QOS_INTF_SEL_RGMII	FIELD_PREP(MX93_GPR_ENET_QOS_INTF_SEL_MASK, \
+							   PHY_INTF_SEL_RGMII)
 #define MX93_GPR_ENET_QOS_CLK_GEN_EN		(0x1 << 0)
 #define MX93_GPR_ENET_QOS_CLK_SEL_MASK		BIT_MASK(0)
 #define MX93_GPR_CLK_SEL_OFFSET			(4)
@@ -241,7 +248,7 @@ static void imx93_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
 	if (regmap_read(dwmac->intf_regmap, dwmac->intf_reg_off, &iface))
 		return;
 
-	iface &= MX93_GPR_ENET_QOS_INTF_MASK;
+	iface &= MX93_GPR_ENET_QOS_INTF_SEL_MASK;
 	if (iface != MX93_GPR_ENET_QOS_INTF_SEL_RGMII)
 		return;
 
-- 
2.47.3


