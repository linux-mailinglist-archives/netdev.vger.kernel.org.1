Return-Path: <netdev+bounces-174291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F79CA5E2C5
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F4319C038E
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2002257426;
	Wed, 12 Mar 2025 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enAwAT42"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9942512EC;
	Wed, 12 Mar 2025 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800214; cv=none; b=mcQAJrC+BrhyPgWJA2jT3WUfkR8XZnjoQaeAjACR8kfZOWh5wxKB6rzVhbKjNcQZItyK/2yiBaBQBLjBtIESI/RenMCHJ1ZTlJvBdJ4xTGOpjYSYS34i1c6lOFjBPdOmdA5Hb6vVTG5XWIJUchIIspiwheMhGAFI0o6BZ3/UXQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800214; c=relaxed/simple;
	bh=HRP31qOf8ZjL4WrltY8eJhifWwmnmgiDUdOBxrGEvD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RBPEdK2Lk6qYQBm4SaW26dG1CR0sU8MCU/ufAldyyrT87AUs9ZfNV4swgB4VosTAX/OF6Y4yUGVwbm4mqH0X2rCG5BgfraY8asW1CPEr//itkrvEdJKPZccQPY4JnSLc4k6IV6iav3El4fk7Vmkdf28d6W1emj7MILppmTPjxNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enAwAT42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3D42C116C6;
	Wed, 12 Mar 2025 17:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741800213;
	bh=HRP31qOf8ZjL4WrltY8eJhifWwmnmgiDUdOBxrGEvD4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=enAwAT42yvxtwbdSEVY3AGIifGdvmaR0YtbkhxAYgzYT/20MNwqiLY6dzrQk97gi1
	 MpM90pxrXg8j3Mj2KksotOtDg6lLJ0RgnbxaRJHl9/rpzU+xGck3BN9FslovMi+C9F
	 gkoBvfKIvq9CqaNm0zSiJwNv/7ekp8y1ep+/4F3SDcPSqcydgWxIGlbjyN+TrErWtq
	 R8JSIyD+/LtqdmFGuLSIWZ4o072cfE9WLWdgYbo79++NwZeBC84awg7EZdhFPfynQb
	 sRx/Fksrr+OYj9PXNgYLFiEVVQvP1GEf59/GUQlr1hLmD+x4HyMxZ9pbYgzb9mN5Ru
	 bSHxk569r5Fkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA752C28B28;
	Wed, 12 Mar 2025 17:23:33 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Wed, 12 Mar 2025 18:23:32 +0100
Subject: [PATCH] net: phy: dp83822: fix transmit amplitude if
 CONFIG_OF_MDIO not defined
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-dp83822-fix-transceiver-mdio-v1-1-7b69103c5ab0@liebherr.com>
X-B4-Tracking: v=1; b=H4sIABPD0WcC/x3MQQqDMBBG4avIrB1IJ6ixV5EugvnVWTTKpEhBv
 HtDlx883kUFpij0bC4ynFp0zxWPtqF5i3kFa6omcdI57wZOR/BBhBf98sdiLjP0hPE76c4RMix
 IwfXjSHVxGGr330+v+/4Bv2o46W4AAAA=
X-Change-ID: 20250307-dp83822-fix-transceiver-mdio-ae27fed80699
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741800212; l=1832;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=mTFreHX34pBc+oU2pNBg+ke78ROdzLxTH0hZJ0yVXyw=;
 b=E2EFw8PtEHMY2cU2EAObFNnLPVJSmYdJUHq4B1GKMusIPHWH28S+jC1WuDKZDUqDG8IEnSYiD
 b5VmYCuMFNbBaB+pnQkyQHGHSVBtAjeCgfanKaHVq5O9lZLUOwCHkG+
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

When CONFIG_OF_MDIO is not defined the index for selecting the transmit
amplitude voltage for 100BASE-TX is set to 0, but it should be -1, if there
is no need to modify the transmit amplitude voltage. Add a flag to make
sure there is a need to modify it.

Fixes: 4f3735e82d8a ("net: phy: dp83822: Add support for changing the transmit amplitude voltage")
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/net/phy/dp83822.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 3662f3905d5ade8ad933608fcaeabb714a588418..d69000cb0ceff28e8288ba24e0af1c960ea9cc97 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -201,6 +201,7 @@ struct dp83822_private {
 	bool set_gpio2_clk_out;
 	u32 gpio2_clk_out;
 	bool led_pin_enable[DP83822_MAX_LED_PINS];
+	bool tx_amplitude_100base_tx_modify;
 	int tx_amplitude_100base_tx_index;
 };
 
@@ -527,7 +528,7 @@ static int dp83822_config_init(struct phy_device *phydev)
 			       FIELD_PREP(DP83822_IOCTRL2_GPIO2_CLK_SRC,
 					  dp83822->gpio2_clk_out));
 
-	if (dp83822->tx_amplitude_100base_tx_index >= 0)
+	if (dp83822->tx_amplitude_100base_tx_modify)
 		phy_modify_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_LDCTRL,
 			       DP83822_100BASE_TX_LINE_DRIVER_SWING,
 			       FIELD_PREP(DP83822_100BASE_TX_LINE_DRIVER_SWING,
@@ -851,6 +852,8 @@ static int dp83822_of_init(struct phy_device *phydev)
 				   val);
 			return -EINVAL;
 		}
+
+		dp83822->tx_amplitude_100base_tx_modify = true;
 	}
 
 	return dp83822_of_init_leds(phydev);

---
base-commit: c62e6f056ea308d6382450c1cb32e41727375885
change-id: 20250307-dp83822-fix-transceiver-mdio-ae27fed80699

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



