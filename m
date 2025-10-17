Return-Path: <netdev+bounces-230346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0E2BE6DA4
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DEBB5628EB
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B9331283F;
	Fri, 17 Oct 2025 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WgHJsIRl"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95987312808;
	Fri, 17 Oct 2025 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684054; cv=none; b=h00I5H2zE3OdUS+k4r/FyIZHNp47eZf7kp4WYJjP3oFP94/6X9jUkbg7vmYP/TsL5Ja9z56le5nezqtBgntVw9o++cTBF4mNFwatcpYdEVqpNTppWvIbFYt/AcJJRJZddgttCJC6FaDfz2tPQ9D3Gg7CzoDDdgrlWInaISBMmhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684054; c=relaxed/simple;
	bh=eurQv0xeKau5jRgrZWm1V5cTpeVBo/sd9VBHUwcd3rM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t72NM1cBvpTgzTRJCqbAGkMc1Rj/q0o5+ba6nkz47RyQmSu3eht/mEZwv/nNMv+79bJx9ZuiFZ7oi4rPQa4F7y2onNK4lqkrmENfX392zeFsYKSOnPZUVyqRzXO/XPLGyVNiM+fi1K0A3izkEcTK6RFinCgih+WJTPwpvFCyU/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WgHJsIRl; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1760684053; x=1792220053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eurQv0xeKau5jRgrZWm1V5cTpeVBo/sd9VBHUwcd3rM=;
  b=WgHJsIRl9HL57wwZwUM8YCmXsmayjdGEMEy8pkQZCMvCRukAc3QTuFB7
   oW/ulzJGSe+UF/+Ia1+w+2u0u3sniP0ykd7cxaEt1LOtCV+34uXWP7LeV
   kQJ6bQBOo/g9ZkvMlxzoKUftIeVXKFAsPIqJ/2J8D7zKjES4UqGFwOLdR
   R316EarRHz6VmGHz6zymxXOqVJTMAtgSBR8Fu2TqrbqJ4PCrzsA16t21w
   BNiQXhLMnn9gjRhkYGsPdN/7O+zbEOptXpATvissM9zGdCIGwgQaZNsfX
   JYn5GYdnNTipA5WU6s6uqI0Y/zUmfIrCIol6ZnWvq1SxPK232K2LDA9f4
   g==;
X-CSE-ConnectionGUID: PiLoJKnxRMWxzVVyQ7dqGQ==
X-CSE-MsgGUID: zPXdkAquQNSGPBHANTdt9A==
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="279282480"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2025 23:54:06 -0700
Received: from chn-vm-ex2.mchp-main.com (10.10.87.31) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 16 Oct 2025 23:53:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.27; Thu, 16 Oct 2025 23:53:49 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 16 Oct 2025 23:53:46 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<vadim.fedorenko@linux.dev>, <rmk+kernel@armlinux.org.uk>,
	<christophe.jaillet@wanadoo.fr>, <rosenp@gmail.com>,
	<steen.hegelund@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v4 2/2] phy: mscc: Fix PTP for VSC8574 and VSC8572
Date: Fri, 17 Oct 2025 08:48:19 +0200
Message-ID: <20251017064819.3048793-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017064819.3048793-1-horatiu.vultur@microchip.com>
References: <20251017064819.3048793-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The PTP initialization is two-step. First part are the function
vsc8584_ptp_probe_once() and vsc8584_ptp_probe() at probe time which
initialize the locks, queues, creates the PTP device. The second part is
the function vsc8584_ptp_init() at config_init() time which initialize
PTP in the HW.

For VSC8574 and VSC8572, the PTP initialization is incomplete. It is
missing the first part but it makes the second part. Meaning that the
ptp_clock_register() is never called.

There is no crash without the first part when enabling PTP but this is
unexpected because some PHys have PTP functionality exposed by the
driver and some don't even though they share the same PTP clock PTP.

Fixes: 774626fa440e ("net: phy: mscc: Add PTP support for 2 more VSC PHYs")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/mscc/mscc_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index d05f6ed052ad0..90b62b8fd4af6 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2613,7 +2613,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
 	.remove		= &vsc85xx_remove,
-	.probe		= &vsc8574_probe,
+	.probe		= &vsc8584_probe,
 	.set_wol	= &vsc85xx_wol_set,
 	.get_wol	= &vsc85xx_wol_get,
 	.get_tunable	= &vsc85xx_get_tunable,
@@ -2636,12 +2636,12 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_aneg    = &vsc85xx_config_aneg,
 	.aneg_done	= &genphy_aneg_done,
 	.read_status	= &vsc85xx_read_status,
-	.handle_interrupt = vsc85xx_handle_interrupt,
+	.handle_interrupt = vsc8584_handle_interrupt,
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
 	.remove		= &vsc85xx_remove,
-	.probe		= &vsc8574_probe,
+	.probe		= &vsc8584_probe,
 	.set_wol	= &vsc85xx_wol_set,
 	.get_wol	= &vsc85xx_wol_get,
 	.get_tunable	= &vsc85xx_get_tunable,
-- 
2.34.1


