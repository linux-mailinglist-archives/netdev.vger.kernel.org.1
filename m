Return-Path: <netdev+bounces-171809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE92A4EC47
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F0C7AF965
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B386726388D;
	Tue,  4 Mar 2025 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcVQphO3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B90025FA14;
	Tue,  4 Mar 2025 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113450; cv=none; b=SaesmcG+Q07S8ybZlqIQbC20maLvlKwZSI6CtkDuHkikVVmBlTAsE0k2vDX7y5oVp5nitXmIeqLo8YoFmbf32+rvx3GzU4Vm/9QB4msUtB5jjwk5ni7RPSi4x/9RRGxiNlnsUT8c24pqHCNaBY7IQFH6+TIqvm+n6J34Kb9F29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113450; c=relaxed/simple;
	bh=vJ7q3UiEIm0cEXoZ+oIW1aIvNSJiLjWq2Fl9mkg2krA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c8ZikqwB7RGY3uMVpKBWJt2T05hkfkOT0a7v4mQho/rNZQ0eG/UPBJavnVcv8OeXJwoq/KeurwRhkw7Xr1+gsydXXS9kNcqS8YED1HsGaqWe4R8mXvHA0hwKDVt4ugcGjiE8UypdFFAunrubXM/QsP//j0cTA3hMXzEbn/xbkVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcVQphO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1123BC4CEEB;
	Tue,  4 Mar 2025 18:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741113450;
	bh=vJ7q3UiEIm0cEXoZ+oIW1aIvNSJiLjWq2Fl9mkg2krA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EcVQphO3OOyuJET2B138Q3e6IQonTRk3y6q/FOQmZFn1i1jhYh+ndj8ViXNjCgEl7
	 qv7GOI4buZu2rRW9Ru8j1M8/ec4GtPqtOEbIXZT6+FjyGZoTFbM24psf842Ve3j8HA
	 VuB8QnshDMV6sDKZHChevs5Hhbu0doxPar5D8RPn074CdYuGcvm4ZGagkjY14HyC68
	 qNI1H2lT2tnScBN7e3Vbu4Y2syB7ZTJ93TNx+Ls/WlwPrMfbAXAZDEfObJv49Njzao
	 vQEMNSMqeoucNVCRlI7Y9ikhlipDR0UtYbPahQIuV3aiPJpeCx5WgJnaLUSmMRHvp5
	 L0w5MmlIOxllw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0654DC282D9;
	Tue,  4 Mar 2025 18:37:30 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Tue, 04 Mar 2025 19:37:27 +0100
Subject: [PATCH net-next v2 2/2] net: phy: tja11xx: enable PHY in sleep
 mode for TJA1102S
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-tja1102s-support-v2-2-cd3e61ab920f@liebherr.com>
References: <20250304-tja1102s-support-v2-0-cd3e61ab920f@liebherr.com>
In-Reply-To: <20250304-tja1102s-support-v2-0-cd3e61ab920f@liebherr.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, Marek Vasut <marex@denx.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741113448; l=1700;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=DWnLX8up0ewgoQK/chnywysY6pNuZir0wY9kYTPFSC8=;
 b=Pe8Mg7UQFFHMEDej+r44aZcmqA5f+skjcS/S5M6mcZnkLLmh1yvcNMQd66xMM9h+9lMwZ8B4i
 aJ7cBieHtiMDdKw9SYpsrW+6oxvhxJhXJnzKhwhYuD0GKZucyKs9eXU
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/net/phy/nxp-tja11xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index 9cf5e6d32fab88cae5cd556623a9ffa285227ab6..601094fe24ca8273a845512b111ccdd9d2785758 100644
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



