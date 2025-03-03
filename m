Return-Path: <netdev+bounces-171266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A2BA4C47A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F243A3006
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B561214232;
	Mon,  3 Mar 2025 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAvY0Y4j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F0016FF37;
	Mon,  3 Mar 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014887; cv=none; b=pa2RCSX2LfMdU3gDqQLIdhjoc4KW+TB8VDNAd+NTv56lTGxOlnURCT36kXpSo44qDWkCbtdVFWiYV0YTwGiiC/JMtagbchHrxqXuH2e4DbfYrtArHmjLBwp2cAvUIYLZ3Gx6qRfwyGsE2NxygfEBO6GoIU65W0a4EnoofqsOlsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014887; c=relaxed/simple;
	bh=IMGuFX+/Gm06Z3V2LJ3RlUU7YI6Ncb0TWv2rE27t5v4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=If+UziPA5UdwERKhu5lZREnpmkQFYTyVXJ2ATGEl2D7JMUIR2gJ8TNV8AW9erDBb4eJ0+Ymtc2IvIhhXgNFc6NbodqWYD/mjAi1W9lbdrI1b8qSh6jgKQWxCdcIzlXcO/bGp70NEQcSDmPGkTAMIMtwj+qDuYsvOCtEafdnGjRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAvY0Y4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76735C4CEE6;
	Mon,  3 Mar 2025 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741014886;
	bh=IMGuFX+/Gm06Z3V2LJ3RlUU7YI6Ncb0TWv2rE27t5v4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rAvY0Y4jB+RnSl1yjyFs5pv+EQJ7F518rs25JNDfyrzUetr3RVXcjt1nfcMxvJV6c
	 N+EjL95ScP21BaQ/Wh2bb6X1gFx0/JLa6lkHhGdN+XeXF/H/6EKfbGifVDRinGsg6v
	 lg2+TNTwSiY91kC7Oq+1PbDbCyCQW1di4EhdIM5K3OxmkWYJXhjO0xrQ/GhOghD2XO
	 ShGT0TmZm6W7HY4NMmyeaWPb97US0KCJ4SRKfxuxlXkFEMHTr1Y7FQY3lTgnxP0lpj
	 iKqkGAeE26fA0W+YJlLVYBqi+bQbulr9U5mPSRAsKE4FurMuE2/v0Zk+hL3JV14hnE
	 sv3GfI940EzLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DA6C282D2;
	Mon,  3 Mar 2025 15:14:46 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 03 Mar 2025 16:14:36 +0100
Subject: [PATCH 1/2] net: phy: tja11xx: add support for TJA1102S
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-tja1102s-support-v1-1-180e945396e0@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741014885; l=2430;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=pGyYFfOoYoiauhJeFVwnNTNUveufWHkJw8YhBUwCGk8=;
 b=VgoY170UQhKPb1II/2dLLKRd/V0MzHhPYytNrEwa9lSgmnSYwqF9AwrMg25zNkNApqTs0jlVh
 6zyRjRu1k3oBumFcfZzw8VPg6EFEZcO7YqKtiXma6ImRE0BPy/7XIwY
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

NXPs TJA1102S is a single PHY version of the TJA1102 in which one of the
PHYs is disabled.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/net/phy/nxp-tja11xx.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index ed7fa26bac8e83f43d6d656e2e2812e501111eb0..8f3bd27b023b5755c223b6769980aad0b76aad89 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -21,6 +21,7 @@
 #define PHY_ID_TJA1100			0x0180dc40
 #define PHY_ID_TJA1101			0x0180dd00
 #define PHY_ID_TJA1102			0x0180dc80
+#define PHY_ID_TJA1102S			0x0180dc90
 
 #define MII_ECTRL			17
 #define MII_ECTRL_LINK_CONTROL		BIT(15)
@@ -316,6 +317,8 @@ static int tja11xx_config_init(struct phy_device *phydev)
 		if (ret)
 			return ret;
 		break;
+	case PHY_ID_TJA1102S:
+		fallthrough;
 	case PHY_ID_TJA1101:
 		reg_mask = MII_CFG1_INTERFACE_MODE_MASK;
 		ret = tja11xx_get_interface_mode(phydev);
@@ -883,6 +886,29 @@ static struct phy_driver tja11xx_driver[] = {
 		.handle_interrupt = tja11xx_handle_interrupt,
 		.cable_test_start = tja11xx_cable_test_start,
 		.cable_test_get_status = tja11xx_cable_test_get_status,
+	}, {
+		PHY_ID_MATCH_MODEL(PHY_ID_TJA1102S),
+		.name		= "NXP TJA1102S",
+		.features       = PHY_BASIC_T1_FEATURES,
+		.flags          = PHY_POLL_CABLE_TEST,
+		.probe		= tja11xx_probe,
+		.soft_reset	= tja11xx_soft_reset,
+		.config_aneg	= tja11xx_config_aneg,
+		.config_init	= tja11xx_config_init,
+		.read_status	= tja11xx_read_status,
+		.get_sqi	= tja11xx_get_sqi,
+		.get_sqi_max	= tja11xx_get_sqi_max,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.set_loopback   = genphy_loopback,
+		/* Statistics */
+		.get_sset_count = tja11xx_get_sset_count,
+		.get_strings	= tja11xx_get_strings,
+		.get_stats	= tja11xx_get_stats,
+		.config_intr	= tja11xx_config_intr,
+		.handle_interrupt = tja11xx_handle_interrupt,
+		.cable_test_start = tja11xx_cable_test_start,
+		.cable_test_get_status = tja11xx_cable_test_get_status,
 	}
 };
 
@@ -892,6 +918,7 @@ static const struct mdio_device_id __maybe_unused tja11xx_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA1100) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA1101) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA1102) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA1102S) },
 	{ }
 };
 

-- 
2.39.5



