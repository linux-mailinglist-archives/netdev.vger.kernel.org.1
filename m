Return-Path: <netdev+bounces-239568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EED09C69D23
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E31E04F6C84
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4CB35F8C6;
	Tue, 18 Nov 2025 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="KLGlu8be"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE43570C9;
	Tue, 18 Nov 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474353; cv=none; b=Lg0V5/b6wDKG1NELieDeUyq+ZN6+yr+gddjK4e1+MBhP8YbwWU2XTPOQVjDA91gXkr0KTIDiHG9eLjr7iSS6lXbpcqW6/YOB4wBbTvKz+TFw6iBquOnD11j6lyB99jjhB+Ty9WuvpoZFUYFXgWjX0ezLTc5DufmJhiTx/vlw7wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474353; c=relaxed/simple;
	bh=vuCMu8Zyr0++D4LokQ/BIJwvJfctwQ7pVDmzVTNH3mk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGuOZCJFqog7UtnEpCNFb2+PuXbm9ujFo5aJ/53aH0mB6uRRCkmW0D7T0Znz9jYxLYKBqklj7QcpzpISj0jOjEic6zWlpLQ0o+i3mrKKJiCqabMTxi7KMMr8IaD/IbCSh/gQL+TMG45B0l27H7Dp1+WvHMJm9NG/ZxsIaUMsCXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=KLGlu8be; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 47A74A0A9C;
	Tue, 18 Nov 2025 14:58:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=BH8nS9fyL+TA/Jht3rNm
	U3h3KU5XVc/dfK0gPokSnho=; b=KLGlu8bePrDaDoExgYUMfAq2aoCoIidrPId3
	mye2DjTnnpzgTMzaBLizI3rZIh5ZbmanB3Ojco+A+iJ4ngHaZtyTCHgwmI2BeQJp
	+ki8n0/TMZJdBm16C9EshdZXRC/i3+EeXwIpNw06WGNoYZEal3gaDorxrmYoLAsd
	3elzcyJx1e5Y1zi25drGSHdlsRe/ClOoH1U3vXy0WzeWZP0dk5kVjN314Rnx/8ZT
	eGU64LHidNz5RX225uu/+Ba08621qr43FkFihx9RcRgvi+s90y/hGaEvk4ZDt9ur
	AfQ7AHMAnAvpfJbgX4T3MbDvi1ntusZw6jczyGSa/vUJq3GjhLCS8oPqE3K1EikO
	8vEUgf9GGKiWggjEBm4dQrHN8ngAPZatVsZxO78WSBgKsXwoUp4dSprjmPvdkFOH
	lXvOLEvXIfAUlseB3zNm1oZFsX12aGvNIjqLbgWzcMyV/sb+GZhvEpAgpGwrWQTI
	nKPfz6JmbmP6MOEXIjpRgsfxr/JKOzpYfWmc8i/CffE/aCBIf9Z8ckBQIT1HrQtP
	2HEhYWZFC7ww8jeJga0JWqQuytHOeBFRgYlMLQqtEA7Vp49SwUqcAMSq9BJE7hvW
	I2vgu2sIZ33i5i37GhA9m21VrMcda1Ph3lhMMiq+vI3c2vf9rIMGmKLYlz8JPdiB
	kJF2Gx4=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v3 3/3] net: mdio: improve reset handling in mdio_device.c
Date: Tue, 18 Nov 2025 14:58:54 +0100
Message-ID: <641df1488517ae71ba10158ec1e38424211d8651.1763473655.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1763473655.git.buday.csaba@prolan.hu>
References: <cover.1763473655.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1763474337;VERSION=8002;MC=3304440463;ID=69551;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F617266

Change fwnode_property_read_u32() in mdio_device_register_reset()
to device_property_read_u32(), which is more appropriate here.

Make mdio_device_unregister_reset() truly reverse
mdio_device_register_reset() by setting the internal fields to
their default values.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V2 -> V3: no changes
V1 -> V2: rebase, leak fix removed, since it is already in base
---
 drivers/net/phy/mdio_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index a4d9c6ccf..fd0e16dbc 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -149,9 +149,9 @@ int mdio_device_register_reset(struct mdio_device *mdiodev)
 	mdiodev->reset_ctrl = reset;
 
 	/* Read optional firmware properties */
-	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-assert-us",
+	device_property_read_u32(&mdiodev->dev, "reset-assert-us",
 				 &mdiodev->reset_assert_delay);
-	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-deassert-us",
+	device_property_read_u32(&mdiodev->dev, "reset-deassert-us",
 				 &mdiodev->reset_deassert_delay);
 
 	return 0;
@@ -165,7 +165,11 @@ int mdio_device_register_reset(struct mdio_device *mdiodev)
 void mdio_device_unregister_reset(struct mdio_device *mdiodev)
 {
 	gpiod_put(mdiodev->reset_gpio);
+	mdiodev->reset_gpio = NULL;
 	reset_control_put(mdiodev->reset_ctrl);
+	mdiodev->reset_ctrl = NULL;
+	mdiodev->reset_assert_delay = 0;
+	mdiodev->reset_deassert_delay = 0;
 }
 
 void mdio_device_reset(struct mdio_device *mdiodev, int value)
-- 
2.39.5



