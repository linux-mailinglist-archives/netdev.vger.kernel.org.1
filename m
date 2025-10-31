Return-Path: <netdev+bounces-234628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0B0C24CAF
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100A84616D6
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2C7345CD9;
	Fri, 31 Oct 2025 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="FA1oXAU9"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAED33B96F;
	Fri, 31 Oct 2025 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910355; cv=none; b=TdVJjF1bCHUA51K0LLElsnANUxNJry6/XnSKWLykCO9Kl8oQnHVv8EtPDA1OklYinYPTfL4Hw1kjovcIqnMviRPJMCWPbfyyO29kNHMx6VrKJS4ZYMo7cVTu7ruMlZ3qgmQ+X/vaKSXRh8mIIGC0LpU2+xh8Jj6OkV92G1M+Pfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910355; c=relaxed/simple;
	bh=B48clSXiuUvuM3hoU+3tOFN6zI8pHgapG4peXvojYm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O84WBBMGfTxFN+s+G1g2jVOJCVgZOTBDDa8s0Vo6kwtUHdyQ+omUvk3rh8yB4BwpnvYfrjPNBHZuB96q2/Hf9HTeSNSesisXCZH5jzpKz7dpr9ebEsYoFOqwdO7+YeNaeVO7c6SAinAEnyafZfl4UiqSNxE2cd/awviulgYhdpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=FA1oXAU9; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 6F5C5A156A;
	Fri, 31 Oct 2025 12:32:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=iVSjyIKCQTGv8GkSx/6A
	seNBhKr161aQL3VM4f1SFXM=; b=FA1oXAU9eOJsoH9qpftKPiRjp+UsOcdMM5z4
	AY7PtmYzkryZdyY2VnAbLl4zeNTJMCuXfrJUv9pe1HqyRhjiVNOosl1GbSRVcrvK
	nTudcKuKgsBzQTUesSsw1KzTwa7hAhPD82kZXX0OtqswRPiG3EvQExhEhG+4CT4Z
	Yaf533PjjamjvXHEmBlLG34kotZsRmGeCdP9zxqPGue6N4nctf5JJ2RrFOy1iZfA
	XfrrtoilkuEs8K0ViLlzV4TKdhjRdsiR4btqFz8cxJaQX+JSUhQKb6vhtWMGNyNM
	gf9iY9iTOnijJm7GKZahbVV81ZR1xjJ8rS4DfecZNevV5kUTSt8CX1AuRR7Uhq7U
	EU9oQuNCvhHZ86YGqlZKkxbxUWHrx0TQZVe/b29fcrQ9ZG9o7Wl1YRBeukxXnqLM
	tw2wi/Xe3F60SZji7PYPrj0n1o02EamzimZAqWIIADc4G3LgdxFfC3Yih7HGdgZB
	hrcsAHmdvcBJE7WoWdkPSSIedrB+dxADJn3HtUa5f3GcC9J0CQfbim6mLQImx5L+
	WFYrXSdmToKCtUYN8a5CdqIaQEYrEa80sEvAZzwK3byL4lyLdEKhbrAyFtqgF50L
	CAvmK2BczssEX1xpSyKiYhrKSqTscarfL9CYj4Lq4DJtDXxWrJ94fr6/PcxL6Q25
	rJELPkM=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next 3/3] net: mdio: improve reset handling in mdio_device.c
Date: Fri, 31 Oct 2025 12:32:28 +0100
Message-ID: <11b197641e5498cab3e43f8983120fcabe06257e.1761909948.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1761909948.git.buday.csaba@prolan.hu>
References: <cover.1761909948.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761910350;VERSION=8001;MC=1035019571;ID=195344;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F677D60

Change fwnode_property_read_u32() in mdio_device_register_reset()
to device_property_read_u32(), which is more appropriate here.

Fix a potential leak in mdio_device_register_reset() if both
a reset-gpio and a reset-controller are present.

Make mdio_device_unregister_reset() truly reverse
mdio_device_register_reset() by setting the internal fields to
their default values.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
 drivers/net/phy/mdio_device.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index ec0263264..2de401961 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -139,15 +139,18 @@ int mdio_device_register_reset(struct mdio_device *mdiodev)
 		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
 
 	reset = reset_control_get_optional_exclusive(&mdiodev->dev, "phy");
-	if (IS_ERR(reset))
+	if (IS_ERR(reset)) {
+		gpiod_put(mdiodev->reset_gpio);
+		mdiodev->reset_gpio = NULL;
 		return PTR_ERR(reset);
+	}
 
 	mdiodev->reset_ctrl = reset;
 
 	/* Read optional firmware properties */
-	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-assert-us",
+	device_property_read_u32(&mdiodev->dev, "reset-assert-us",
 				 &mdiodev->reset_assert_delay);
-	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-deassert-us",
+	device_property_read_u32(&mdiodev->dev, "reset-deassert-us",
 				 &mdiodev->reset_deassert_delay);
 
 	return 0;
@@ -161,7 +164,11 @@ int mdio_device_register_reset(struct mdio_device *mdiodev)
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



