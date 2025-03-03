Return-Path: <netdev+bounces-171268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88D9A4C477
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C8C18872E7
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA162144A4;
	Mon,  3 Mar 2025 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM8Dn0PI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE7213E66;
	Mon,  3 Mar 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014887; cv=none; b=dJ3vfaqmL/EL8bXB7TCykYM+bPdELKXYTmjOZsm73bk/l44yVnxlXVboQt+xR8DIT1Vdz6Syk0/zUv6ALkoVqtxSS9NC6l4XciTgH+XMbid34zURQpSj0yVG7GQMbLCdQ66MWgirtB6qKQbkrW6O/MA3vkIKKmoqH6GnRhcNBL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014887; c=relaxed/simple;
	bh=fCmSeaLsHOGgZCOe1ZjtdfESaoOaO/P39GiorM9u4bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oc5OmE+TUegM3BT94Iu/7pHwQ4vTmbOPFHzKXD5bRWlB8C01yNwDiP5K8wWb3GB4sZbLRexD2ZSBoUsvaaRfYOQvahpIOHsYwlOqSQ8AXXaHXg9rXKmmN92FgT4j/QfBZ92iGby8La77Vn1W+5gaCSnymiRh+GF5Rhzu9V9KQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lM8Dn0PI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82649C4CEE9;
	Mon,  3 Mar 2025 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741014886;
	bh=fCmSeaLsHOGgZCOe1ZjtdfESaoOaO/P39GiorM9u4bw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lM8Dn0PIV/Hd+HRlhme1MmK6Qs/yxnMHZtQGS4sJDXF2jg/ab1llKxZjBdEZGmV/n
	 M+7I8cLWLemEbmdYmctpGUeqjxDft9Guhsn5iEwAYcOIGEkDZinKG/57VxYbnD4T/Q
	 JVZsTV6LqrAIKq1FZ/Ouhq3v3XyY88bbokotdjgriaM4YR+Zm2eVg+cWNkwQVB+rN4
	 8IMDi4O4O/zk+5xZ6sC3la6a2x0TOg47hBewmIr4PysOdyx+tEiWKmIxVp1yLk1JvE
	 VcpYdPYI6tjsF1TxDa2lhsSgmkOgyaYZpjPoLtQZNPDiGvJHcnqlugB1OFKCxmsJ73
	 wLEL894ozF13g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7657CC282CD;
	Mon,  3 Mar 2025 15:14:46 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 03 Mar 2025 16:14:37 +0100
Subject: [PATCH 2/2] net: phy: tja11xx: enable PHY in sleep mode for
 TJA1102S
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-tja1102s-support-v1-2-180e945396e0@liebherr.com>
References: <20250303-tja1102s-support-v1-0-180e945396e0@liebherr.com>
In-Reply-To: <20250303-tja1102s-support-v1-0-180e945396e0@liebherr.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, Marek Vasut <marex@denx.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741014885; l=1657;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=fBVwJfKA7vzb3FvQIQ+c8V1qrobOuDv18BhKafbdQZE=;
 b=FdXcsDo2MrmnegrJeWJl01AAbNIN2MwO2dE2AqikztnZHnXJ1ZWgENF8egIt/ke00SojEpV3+
 TUBuD61aB5eBIkkczmouE+W/Fmvq7sQ/VtWqMlkvRyA+i6vbVqYln+H
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Due to pin strapping the PHY maybe disabled per default. TJA1102 devices
can be enabled by setting the PHY_EN bit. Support is provided for TJA1102S
devices but can be easily added for TJA1102 too.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/net/phy/nxp-tja11xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index 8f3bd27b023b5755c223b6769980aad0b76aad89..42a21371c7502a2bd08ae1a9385bf90dfab9105c 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -28,6 +28,7 @@
 #define MII_ECTRL_POWER_MODE_MASK	GENMASK(14, 11)
 #define MII_ECTRL_POWER_MODE_NO_CHANGE	(0x0 << 11)
 #define MII_ECTRL_POWER_MODE_NORMAL	(0x3 << 11)
+#define MII_ECTRL_POWER_MODE_SLEEP	(0xa << 11)
 #define MII_ECTRL_POWER_MODE_STANDBY	(0xc << 11)
 #define MII_ECTRL_CABLE_TEST		BIT(5)
 #define MII_ECTRL_CONFIG_EN		BIT(2)
@@ -79,6 +80,9 @@
 #define MII_COMMCFG			27
 #define MII_COMMCFG_AUTO_OP		BIT(15)
 
+#define MII_CFG3			28
+#define MII_CFG3_PHY_EN			BIT(0)
+
 /* Configure REF_CLK as input in RMII mode */
 #define TJA110X_RMII_MODE_REFCLK_IN       BIT(0)
 
@@ -180,6 +184,14 @@ static int tja11xx_wakeup(struct phy_device *phydev)
 			return ret;
 
 		return tja11xx_enable_link_control(phydev);
+	case MII_ECTRL_POWER_MODE_SLEEP:
+		switch (phydev->phy_id & PHY_ID_MASK) {
+		case PHY_ID_TJA1102S:
+			/* Enable PHY, maybe it is disabled due to pin strapping */
+			return phy_set_bits(phydev, MII_CFG3, MII_CFG3_PHY_EN);
+		default:
+			return 0;
+		}
 	default:
 		break;
 	}

-- 
2.39.5



