Return-Path: <netdev+bounces-152716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A73B9F586E
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E7E7A3028
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 21:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F3E1FBC8E;
	Tue, 17 Dec 2024 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQHgsnCt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF581FA8EC
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469659; cv=none; b=cuy9ovqZTrcFqtgjsrQQaabwEjfOaU7NFxy+uHPVRu2wZZoMxsZOYTjw9vSiYnoEmWy0SutldCqIQmeSUmC4RkQ9duSfjo2uD23qSyNBTSdZCvynm6j8pzVkIulFJpYHTyCOt2E9CmyYNLTQbjB9xGmJs9WhlrfKT7p3ghU7i7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469659; c=relaxed/simple;
	bh=ARm3wZdsJFE1EXnn6XMmXs+6j95IcoRF/BPmTCJB7yE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FrWUa3TJVFN0GUraVD1uCeseAbW2lmumMg+FkGhvr5PI58x5GuBzgmVUp/rNkMXF47zEp8GY91EBLGtkOABCG0S9BJNus7nIH/r6X4J4YDVqDhgykiUq9gUNtmIMZztnY0yLPBOLRuMwXgg5x3NiaxnvxgZK56So9+lyi/1AlMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQHgsnCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 304BAC4CEE6;
	Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734469659;
	bh=ARm3wZdsJFE1EXnn6XMmXs+6j95IcoRF/BPmTCJB7yE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tQHgsnCtFytSA/MqL+C4MNL4ICP6j9A9UzaQ3svO7QzxB1KeXb7/ydfK/mo7A109W
	 B4w0GCkeHVkmHx3S9/hrpyEZBUvsxqVtN0UI6UWTn1PxrNODEgOPf3QF4EVHDIUu1C
	 UfjC96zQtsQGtQqkKS5HFuZmCB6pmHjGatkeJ/cdDnM9pbW/5Cx79bqczFPhxYcIwF
	 VcGU/74jmibiNtnxBFnq3ShenlNvoKk/Anz2oIwVoRfHlO6c8mjWxI5TSi2z7FV9Np
	 KKTp2fKjEl9t+Owpgl28a6xQ3vUXjqHMiQ7kc2l+vyccYzn/p8VRJok6A6vG79wyG3
	 Khr7PcumqeHgw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261DCE77184;
	Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Tue, 17 Dec 2024 22:07:37 +0100
Subject: [PATCH net-next v3 6/7] net: tn40xx: prepare tn40xx driver to find
 phy of the TN9510 card
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-tn9510-v3a-v3-6-4d5ef6f686e0@gmx.net>
References: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
In-Reply-To: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734469657; l=1416;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=rESsj+vd7KGKfozt3aHW3N4Wnw4DdcDrscsB4sUdilI=;
 b=xf0hdxtZyuXoEfg78h7+uWKrxqCrXtjcIE1fYmrVWHkjXeNAkCbLsnoun5jW49gku5zbj3SOZ
 zfwcEafc4TrDdBF7T5PN34qqNyG7DfiqjHoV47qzdAQrYELwyLXnZow
X-Developer-Key: i=hfdevel@gmx.net; a=ed25519;
 pk=s3DJ3DFe6BJDRAcnd7VGvvwPXcLgV8mrfbpt8B9coRc=
X-Endpoint-Received: by B4 Relay for hfdevel@gmx.net/20240915 with
 auth_id=209
X-Original-From: Hans-Frieder Vogt <hfdevel@gmx.net>
Reply-To: hfdevel@gmx.net

From: Hans-Frieder Vogt <hfdevel@gmx.net>

Prepare the tn40xx driver to load for Tehuti TN9510 cards, which require
bit 3 in the register TN40_REG_MDIO_CMD_STAT to be set. The function of bit
3 is unclear, but may have something to do with the length of the preamble
in the MDIO communication. If bit 3 is not set, the PHY will not be found
when performing a scan for PHYs. Use the available tn40_mdio_set_speed
function which includes setting bit 3. Just move the function to before the
devm_mdio_register function, which scans the mdio bus for PHYs.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
---
 drivers/net/ethernet/tehuti/tn40_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
index b8ee553f60d1beadeda828584adfea670f0d4ca8..993458cc49322de3466c604385dca64d4c3b949f 100644
--- a/drivers/net/ethernet/tehuti/tn40_mdio.c
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -185,13 +185,13 @@ int tn40_mdiobus_init(struct tn40_priv *priv)
 			ret);
 	}
 
+	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_6MHZ);
 	ret = devm_mdiobus_register(&pdev->dev, bus);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",
 			ret, bus->state, MDIOBUS_UNREGISTERED);
 		goto err_swnodes_unregister;
 	}
-	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_6MHZ);
 	priv->mdio = bus;
 	return 0;
 

-- 
2.45.2



