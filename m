Return-Path: <netdev+bounces-239061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2327C63442
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23F7A4F31CA
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36D032ABCF;
	Mon, 17 Nov 2025 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="EmeIpeLX"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCB432A3F1;
	Mon, 17 Nov 2025 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372060; cv=none; b=EstEpaEN0p4u5cXQKK2HR8SuSw9RITbo92Jkf7K8LqnbdjxeS5LeGYEq6Hy2DeLtJbX0q9mVc5y8Mh6mFLN87OIhJo2dudQ1u3SFnczx9Ax74YToUvaKw/jhUrYm7binDp+NLfv1ivReY7o/X6Npmsvqzvd2qDmv+Xx7SKFyfYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372060; c=relaxed/simple;
	bh=s56XGaJkEN6aYqwdee6IgNuvZiOEyF0ICKNQgbbjFuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOH+gEu76gJnNBelTTOLcs6WT9PxTAN9/kS+VPOVSHmiKRjuMveYNhyN9G7/vc8ccO5HLcSjo7lAwrQesmCNqyVuJ4HHc0mRi3i/FdsvEs/yd83pzCFJYK0r4uRNQMiHCqfg/RUGoWICaYc9mXwGfHNwMiiOcElqhS64FwC6c0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=EmeIpeLX; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 819BAA0FB1;
	Mon, 17 Nov 2025 10:29:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=6q9m0lW01giS8sV0rG9U
	LGw/tzHsYEwdUQviw0bTeiA=; b=EmeIpeLXj9+2EXSfauvg0ditos/+CDPbxn+4
	lCG8X/CTZahVfDPFZrU+g+ki+akYqJ9yEMg1uDahdC7y7V+FR4qBpNQcxflXaQGm
	Wphvc9pqzIprOPZjfe3U3/P9Tmbsa64t453koXfIO1/m9rf8ty7IHMqXj9lY7IX9
	8J3w0yFGxVet8k2GyL1+UbNOISD+KaII/nVpkHhG0w+zyNxlyvOBZLPeIbiCYg0S
	FpL3PpBzyAEil4rb/ewJ19YBF9JjlGBRQr5/8nI7TxGhQZ8+VMLue2GRdzueAjN2
	Wrc0GV+53twTJUEzJbYrq6Yx4yRtQ/uxAR/25Ue7+N3Su0hQ03DW+euy5NsG1nhd
	UCsMS2K8NuJceiu/HKNVAnye27MH0Gk8/3HwZPdh/NZnADZz/q1RSXlx0jP63LCx
	gJgjn2f/4dO+vjQAcuSmCJO8+Cii0Cjl6DKFZLTowT4frQJp5dUG3kjH+59Br0No
	wDcHWP4gCHx8bYPgJh/doN3G1eScEuhYuBkNitqPMayBBRP+GuckLyG9LKUq08v9
	tMlz5P5I72OiT19ySn9OjRwM1HfzsH6ZHqGR2sesYwlPzofX9QFPjA3nDO6kMPVc
	Dp2NRCiGljO98xwPaB1f/OzXxhhryI0VRQfAy71EPXZY2rOaH04DiK1YT/mKA1+z
	xOqTosI=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v2 3/3] net: mdio: improve reset handling in mdio_device.c
Date: Mon, 17 Nov 2025 10:28:53 +0100
Message-ID: <8d7e7a52925d2a87c4642c236524324680ab36e2.1763371003.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1763371003.git.buday.csaba@prolan.hu>
References: <cover.1763371003.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1763371741;VERSION=8002;MC=4061085841;ID=73153;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F617362

Change fwnode_property_read_u32() in mdio_device_register_reset()
to device_property_read_u32(), which is more appropriate here.

Make mdio_device_unregister_reset() truly reverse
mdio_device_register_reset() by setting the internal fields to
their default values.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V1 -> V2: rebase, leak fix removed, since it is already in base
---
 drivers/net/phy/mdio_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 749cf8cdb..2de401961 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -148,9 +148,9 @@ int mdio_device_register_reset(struct mdio_device *mdiodev)
 	mdiodev->reset_ctrl = reset;
 
 	/* Read optional firmware properties */
-	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-assert-us",
+	device_property_read_u32(&mdiodev->dev, "reset-assert-us",
 				 &mdiodev->reset_assert_delay);
-	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-deassert-us",
+	device_property_read_u32(&mdiodev->dev, "reset-deassert-us",
 				 &mdiodev->reset_deassert_delay);
 
 	return 0;
@@ -164,7 +164,11 @@ int mdio_device_register_reset(struct mdio_device *mdiodev)
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



