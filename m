Return-Path: <netdev+bounces-237362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCAFC49A07
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 23:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7068D4F74A6
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 22:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2768B337BAE;
	Mon, 10 Nov 2025 22:34:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783F2EC09E;
	Mon, 10 Nov 2025 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814060; cv=none; b=mpAFJxcz6CV8ELijjd/gWULxIp01LAhjwr1QtxyzcFQKHLCOAGN4SH+s1BsWKa2tuZMO5KIdyu7WrGSgKnaESi2GoaKvdW/BpcMWN5hNoPkV2UvEIqhUQdPelq4+eWkwaNoSE55aLt/NH75Or6aAELQz2tSSrJECGokN5DXysgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814060; c=relaxed/simple;
	bh=I1oNJRz9FYOsxzMiD7ANfztym4nWPczNMuvfhZbE6jo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OFx2m9Hs70JCo3Rm+nMotPGchBzzPg8zUKdjwLMU7bUKlfkRIEjrx42tPEJ7u9T4Iy1JF5EpJ8lxeukR1rc4AmFb8IFx2r3C1wdi7DU2Z80VMTFu7Fi1+ra5sqXmYwr+mJaZJj39QfmETtPgOq5cAxoQYItN/nBj7glhJ6TJov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vIaSX-000000003xH-1Kee;
	Mon, 10 Nov 2025 22:34:01 +0000
Date: Mon, 10 Nov 2025 22:33:56 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: phy: mxl-gpy: add support for MXL86211C
Message-ID: <92e7bdac9a581276219b5c985ab3814d65e0a7b5.1762813829.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Chad Monroe <chad@monroe.io>

MXL86211C is a smaller and more efficient version of the GPY211C.
Add the PHY ID and phy_driver instance to the mxl-gpy driver.

Signed-off-by: Chad Monroe <chad@monroe.io>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/mxl-gpy.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 0c8dc16ee7bde..3320a42ef43cf 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -30,6 +30,7 @@
 #define PHY_ID_GPY241B		0x67C9DE40
 #define PHY_ID_GPY241BM		0x67C9DE80
 #define PHY_ID_GPY245B		0x67C9DEC0
+#define PHY_ID_MXL86211C		0xC1335400
 
 #define PHY_CTL1		0x13
 #define PHY_CTL1_MDICD		BIT(3)
@@ -1268,6 +1269,29 @@ static struct phy_driver gpy_drivers[] = {
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
 	},
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_MXL86211C),
+		.name		= "Maxlinear Ethernet MXL86211C",
+		.get_features	= genphy_c45_pma_read_abilities,
+		.config_init	= gpy_config_init,
+		.probe		= gpy_probe,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.config_aneg	= gpy_config_aneg,
+		.aneg_done	= genphy_c45_aneg_done,
+		.read_status	= gpy_read_status,
+		.config_intr	= gpy_config_intr,
+		.handle_interrupt = gpy_handle_interrupt,
+		.set_wol	= gpy_set_wol,
+		.get_wol	= gpy_get_wol,
+		.set_loopback	= gpy_loopback,
+		.led_brightness_set = gpy_led_brightness_set,
+		.led_hw_is_supported = gpy_led_hw_is_supported,
+		.led_hw_control_get = gpy_led_hw_control_get,
+		.led_hw_control_set = gpy_led_hw_control_set,
+		.led_polarity_set = gpy_led_polarity_set,
+		.link_change_notify = gpy_link_change_notify,
+	},
 };
 module_phy_driver(gpy_drivers);
 
-- 
2.51.2

