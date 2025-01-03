Return-Path: <netdev+bounces-154935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AABD2A00674
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F94316254C
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8221CEADF;
	Fri,  3 Jan 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="M9wnYRN6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBFF1CD205;
	Fri,  3 Jan 2025 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735895322; cv=none; b=MqqdnZgtfEaG87uFUV/1iYfCqT+kA3fxKWiD/RubVzOHN8dbs0RPE2kdivXBJ1V7zxaimjquc7t3C6pm+sLYlMyuZpcWN7Gpq9rvajlvwcZN3Ul4tBlXGhVyBK0V8SRyM5DN+RLJY1kxdz/feKeESgIHDXOCD6FJV/Xov+qMOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735895322; c=relaxed/simple;
	bh=HfMmLMEz/Z04AX70J7x98PS1/99QuJwU/vue65a+wr8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hi0TuU4Q2D9pATwjHsW+Efqb3m3DXA/qSDIPXoG4nSFx4tJzyFB+mg9mnF8cmVuk2U6m2aqRhU/eEa4Mxs5u5nx9bSZoqK/buwGGvl6FBpWxi9URtdFu0G/7hZVBAX/FT56wAhq2wcQH1HwuWtkMNp3/di569w35srOiZFeZRdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=M9wnYRN6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1735895321; x=1767431321;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=HfMmLMEz/Z04AX70J7x98PS1/99QuJwU/vue65a+wr8=;
  b=M9wnYRN6FJTWGGRRkO3/AseJk5Qk32gaUZpcVYti6uZkG+xhWXJnHnqW
   YhJ52g23pm2kdRWJ7MkSy1/KevOcubmwmSHji87KhCfJteOQlefTFC+uK
   jbOHtN8hHDWRfKZteNvyqFKVmdQppPMih7w+1pLeG6IIsI4htc0iUUG2G
   8xliT86lmYIerTNb6spTzAOSxq6bMLiaTuv24teIJgjB2qTwK3ul0cXNq
   Ad3Kam00In18n/HRe0r6dcv+Ue1KsZ2Ff3DE//EbeGrav5ui+rsY2qZL9
   zXEZiv+jYjSk5LblugwihzY1h1v35EfRQkSkQoa0qT+44u7K1YOfzUlne
   g==;
X-CSE-ConnectionGUID: EXABeJ56QrCvAsgIXU519A==
X-CSE-MsgGUID: VmmvSA5TQPKJRDCmYiIelQ==
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="36577056"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jan 2025 02:08:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 Jan 2025 02:07:40 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 3 Jan 2025 02:07:36 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next 2/3] net: phy: microchip_t1: Enable GPIO pins specific to lan887x phy for PEROUT signals
Date: Fri, 3 Jan 2025 14:37:30 +0530
Message-ID: <20250103090731.1355-3-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250103090731.1355-1-divya.koppera@microchip.com>
References: <20250103090731.1355-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adds support for enabling GPIO pins that are required
to generate periodic output signals on lan887x phy.

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
 drivers/net/phy/microchip_t1.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 73f28463bc35..b0a34f794f4c 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -273,6 +273,11 @@
 /* End offset of samples */
 #define SQI_INLIERS_END (SQI_INLIERS_START + SQI_INLIERS_NUM)
 
+#define LAN887X_MX_CHIP_TOP_REG_CONTROL1		(0xF002)
+#define LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN		BIT(8)
+#define LAN887X_MX_CHIP_TOP_REG_CONTROL1_REF_CLK	BIT(9)
+#define LAN887X_MX_CHIP_TOP_REG_CONTROL1_GPIO2_EN	BIT(5)
+
 #define DRIVER_AUTHOR	"Nisar Sayed <nisar.sayed@microchip.com>"
 #define DRIVER_DESC	"Microchip LAN87XX/LAN937x/LAN887x T1 PHY driver"
 
@@ -1286,6 +1291,19 @@ static int lan887x_phy_init(struct phy_device *phydev)
 		if (IS_ERR(priv->clock))
 			return PTR_ERR(priv->clock);
 
+		/* Enable pin mux for GPIO 2(EVT B) as ref clk */
+		/* Enable pin mux for EVT A */
+		phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+			       LAN887X_MX_CHIP_TOP_REG_CONTROL1,
+			       LAN887X_MX_CHIP_TOP_REG_CONTROL1_REF_CLK |
+			       LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN,
+			       LAN887X_MX_CHIP_TOP_REG_CONTROL1_REF_CLK |
+			       LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN);
+
+		 /* Initialize pin numbers specific to PEROUT */
+		priv->clock->gpio_event_a = 3;
+		priv->clock->gpio_event_b = 1;
+
 		priv->init_done = true;
 	}
 
-- 
2.17.1


