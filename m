Return-Path: <netdev+bounces-24524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EE1770764
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 19:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05612827C4
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38F11BEE5;
	Fri,  4 Aug 2023 17:59:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860AC2CA
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 17:59:04 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1366F122
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 10:59:02 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id CF53A86660;
	Fri,  4 Aug 2023 19:58:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1691171939;
	bh=MOr9Qlya1CnuxR4ka35e0UNVov/FCjAij7AB7i19F7k=;
	h=From:To:Cc:Subject:Date:From;
	b=nLjrMirenK+KBdYoOuP0DQWRM+dfDnkNGOMO/KwK6zke8fIeSBwICjPrlJFPbrPrx
	 cPYuloHCYrynf82lFsQ0Ou/cQcP2tUT7kgJxu3M+b55rJVR3VKdeLKVvUpZY4AAnyC
	 +Xsv46WgJ8NC56BSfzq7ei4vRoj290BDwtLCHd0WCqoeV+wywD96RqE9BRc+yapFT+
	 K5woxd9xHZElBzjgcc0WBaixfPtmYyhB064m7v68FaDLcS9nFMMZTDY6HjKHLe5uCN
	 z926A6be8UQojcrswOwdbKDycyLDdt8TE/qPA0DmQy0NpUhQPU0CgMUcIDo5AlEK8l
	 POtiP0PvL246g==
From: Marek Vasut <marex@denx.de>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Wei Fang <wei.fang@nxp.com>
Subject: [PATCH] net: phy: at803x: Improve hibernation support on start up
Date: Fri,  4 Aug 2023 19:58:42 +0200
Message-Id: <20230804175842.209537-1-marex@denx.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Toggle hibernation mode OFF and ON to wake the PHY up and
make it generate clock on RX_CLK pin for about 10 seconds.
These clock are needed during start up by MACs like DWMAC
in NXP i.MX8M Plus to release their DMA from reset. After
the MAC has started up, the PHY can enter hibernation and
disable the RX_CLK clock, this poses no problem for the MAC.

Originally, this issue has been described by NXP in commit
9ecf04016c87 ("net: phy: at803x: add disable hibernation mode support")
but this approach fully disables the hibernation support and
takes away any power saving benefit. This patch instead makes
the PHY generate the clock on start up for 10 seconds, which
should be long enough for the EQoS MAC to release DMA from
reset.

Before this patch on i.MX8M Plus board with AR8031 PHY:
"
$ ifconfig eth1 up
[   25.576734] imx-dwmac 30bf0000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-0
[   25.658916] imx-dwmac 30bf0000.ethernet eth1: PHY [stmmac-1:00] driver [Qualcomm Atheros AR8031/AR8033] (irq=38)
[   26.670276] imx-dwmac 30bf0000.ethernet: Failed to reset the dma
[   26.676322] imx-dwmac 30bf0000.ethernet eth1: stmmac_hw_setup: DMA engine initialization failed
[   26.685103] imx-dwmac 30bf0000.ethernet eth1: __stmmac_open: Hw setup failed
ifconfig: SIOCSIFFLAGS: Connection timed out
"

After this patch on i.MX8M Plus board with AR8031 PHY:
"
$ ifconfig eth1 up
[   19.419085] imx-dwmac 30bf0000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-0
[   19.507380] imx-dwmac 30bf0000.ethernet eth1: PHY [stmmac-1:00] driver [Qualcomm Atheros AR8031/AR8033] (irq=38)
[   19.528464] imx-dwmac 30bf0000.ethernet eth1: No Safety Features support found
[   19.535769] imx-dwmac 30bf0000.ethernet eth1: IEEE 1588-2008 Advanced Timestamp supported
[   19.544302] imx-dwmac 30bf0000.ethernet eth1: registered PTP clock
[   19.552008] imx-dwmac 30bf0000.ethernet eth1: FPE workqueue start
[   19.558152] imx-dwmac 30bf0000.ethernet eth1: configuring for phy/rgmii-id link mode
"

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <linux@rempel-privat.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Wei Fang <wei.fang@nxp.com>
Cc: netdev@vger.kernel.org
---
 drivers/net/phy/at803x.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 13c4121fa3092..8cb7b39c6cddc 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -986,6 +986,25 @@ static int at8031_pll_config(struct phy_device *phydev)
 static int at803x_hibernation_mode_config(struct phy_device *phydev)
 {
 	struct at803x_priv *priv = phydev->priv;
+	int ret;
+
+	/* Toggle hibernation mode OFF and ON to wake the PHY up and
+	 * make it generate clock on RX_CLK pin for about 10 seconds.
+	 * These clock are needed during start up by MACs like DWMAC
+	 * in NXP i.MX8M Plus to release their DMA from reset. After
+	 * the MAC has started up, the PHY can enter hibernation and
+	 * disable the RX_CLK clock, this poses no problem for the MAC.
+	 */
+	ret = at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_HIB_CTRL,
+				    AT803X_DEBUG_HIB_CTRL_PS_HIB_EN, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_HIB_CTRL,
+				    AT803X_DEBUG_HIB_CTRL_PS_HIB_EN,
+				    AT803X_DEBUG_HIB_CTRL_PS_HIB_EN);
+	if (ret < 0)
+		return ret;
 
 	/* The default after hardware reset is hibernation mode enabled. After
 	 * software reset, the value is retained.
-- 
2.40.1


