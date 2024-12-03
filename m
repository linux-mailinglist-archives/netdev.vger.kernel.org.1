Return-Path: <netdev+bounces-148392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9BA9E14B8
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE34282F26
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576D81D86C6;
	Tue,  3 Dec 2024 07:56:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40121A01B9
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212603; cv=none; b=K7oWOrYLfuB0M21xCBw0ku7TierIzcPNmjUuBJCNb+opeEsjUo0ftnkPs0LMI+1A51aCL03MRCkTFcTVU1WIcZX7bH9tlfxYIp72s2C6h2pQiqyOlLK+4xekITgZdZDxs8qlnk9i/pKhJQLlIbSc7J2ahE9G0kKNX67gdMkJc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212603; c=relaxed/simple;
	bh=h2wq29K/7BN/z+SVjji4cLJS5r3QL0WZHvFT9zzVm1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vk0ch59SnUmmrCD3aFgGSHj8YyPhStn6CFSxDqDFxw4E3pOAaPloYVsHLcJ5SwlI/EudEFF4ArPyUHSdWFL4G6KjYT7LeG5YsLsgXSnbxYGxM4O/yPrUzIPN/m6sIp3Nxce4/33GkgqTkxqZVMN+X0yEzsCNs7s66FTCVqv9zqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINlj-000395-Kl; Tue, 03 Dec 2024 08:56:27 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINle-001R8x-0h;
	Tue, 03 Dec 2024 08:56:22 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINle-00AHw8-2v;
	Tue, 03 Dec 2024 08:56:22 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v1 3/7] phy: replace bitwise flag definitions with BIT() macro
Date: Tue,  3 Dec 2024 08:56:17 +0100
Message-Id: <20241203075622.2452169-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241203075622.2452169-1-o.rempel@pengutronix.de>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Convert the PHY flag definitions to use the BIT() macro instead of
hexadecimal values. This improves readability and maintainability.

No functional changes are introduced by this modification.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/linux/phy.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 20a0d43ab5d4..a6c47b0675af 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -86,11 +86,11 @@ extern const int phy_10gbit_features_array[1];
 #define PHY_POLL		-1
 #define PHY_MAC_INTERRUPT	-2
 
-#define PHY_IS_INTERNAL		0x00000001
-#define PHY_RST_AFTER_CLK_EN	0x00000002
-#define PHY_POLL_CABLE_TEST	0x00000004
-#define PHY_ALWAYS_CALL_SUSPEND	0x00000008
-#define MDIO_DEVICE_IS_PHY	0x80000000
+#define PHY_IS_INTERNAL		BIT(0)
+#define PHY_RST_AFTER_CLK_EN	BIT(1)
+#define PHY_POLL_CABLE_TEST	BIT(2)
+#define PHY_ALWAYS_CALL_SUSPEND	BIT(3)
+#define MDIO_DEVICE_IS_PHY	BIT(31)
 
 /**
  * enum phy_interface_t - Interface Mode definitions
-- 
2.39.5


