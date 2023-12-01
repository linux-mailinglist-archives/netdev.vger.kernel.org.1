Return-Path: <netdev+bounces-53015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084518011CB
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317771C20AED
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CDD4E625;
	Fri,  1 Dec 2023 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="C7BO8hoa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE78F1A8
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:36:12 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9bbb30c34so30285181fa.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 09:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701452171; x=1702056971; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=62Xb/t0WXbU4fDk0OR1toLDrHS6G4bi3D72m+zt9Jb4=;
        b=C7BO8hoaP0Urbr1ItuWkOFPgOejTzYmQwaAItuWK4tTFgZg86O9HO7NdKPZyT0YTNR
         CHrFQbPMpyMJEmujgcTk9qYpqedvCj+rXMWh+/oyc2ILif3reUSATLDAkqrEGB+8P8DI
         1jmGP8Uh3u01od5T/RYCe6oxA0XasSIcL2/wtYFokiEVbls1W89rsdQiGtH6BQygkCgd
         QQL8Vz3qL7ToAxMKSTcdwHFplPaPxSYSQ1W/HZEtrh5SFkbK24BS0r0STnmdiKNubUme
         tSg7x7bybQUiYqCi5ZjAPQA2qrrn6MbB+jwQvX5Q34pGC17oiYCN9aOKCB9xsStRY116
         fCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452171; x=1702056971;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=62Xb/t0WXbU4fDk0OR1toLDrHS6G4bi3D72m+zt9Jb4=;
        b=Qb1oLSTHFUCNfKZhHpMNxd1Hzhs3fp3pBIjEsUdfTUaLVTrVRMGBIdRkzQ4Yn/kC3I
         MOlvBLWchChQ0EapdXn5mr9Iii4pmnSG4ga2alDZN+skeipCMyAR5CL5I8doDg21N7re
         8T56Wbxf5PeRUddyf7tZMLn+spaMT7TRq1NTMBOrK8Hkfgvn3tZOyjwb53XGpqk4dwUT
         91zBihhYprDBwx6g9g2I0AfG7LaXs4yaqNiAFrFzoBwTu+iIPygcjXxzNZUdKjMzkbNL
         x5Mpu001zGfbgtlaWRP5Y+hCkiBbovneBRRIxkYsxm+ECa2uvv0h5eBWPoKbBB2B29Vr
         pCag==
X-Gm-Message-State: AOJu0YyTFf6J/8H56LmtjRmbNbzDaHreNDVrJs9gF6Pje3hvKz+Mq23D
	N5mGAFLuedLpcRX/gO2izHTsCg==
X-Google-Smtp-Source: AGHT+IEplCSmIjKdrlEkQyJ/P3ctkeYH+24Sdg1W1dfa3j+SKWZx5gC8SOeMLv1FOaRq6827ZT09uQ==
X-Received: by 2002:a2e:8796:0:b0:2c9:d874:4b53 with SMTP id n22-20020a2e8796000000b002c9d8744b53mr989880lji.67.1701452171147;
        Fri, 01 Dec 2023 09:36:11 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-176-10-137-178.NA.cust.bahnhof.se. [176.10.137.178])
        by smtp.gmail.com with ESMTPSA id y9-20020a2eb009000000b002c120b99f8csm470327ljk.134.2023.12.01.09.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:36:10 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/3] net: mvmdio: Support setting the MDC frequency on XSMI controllers
Date: Fri,  1 Dec 2023 18:35:45 +0100
Message-Id: <20231201173545.1215940-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201173545.1215940-1-tobias@waldekranz.com>
References: <20231201173545.1215940-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Support the standard "clock-frequency" attribute to set the generated
MDC frequency. If not specified, the driver will leave the divisor
untouched.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/ethernet/marvell/mvmdio.c | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 1de2175269bf..69d5e73be8fe 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -53,6 +53,13 @@
 #define  MVMDIO_XSMI_BUSY		BIT(30)
 #define MVMDIO_XSMI_ADDR_REG		0x8
 
+#define MVMDIO_XSMI_CFG_REG		0xc
+#define  MVMDIO_XSMI_CLKDIV_MASK	0x3
+#define  MVMDIO_XSMI_CLKDIV_256		0x0
+#define  MVMDIO_XSMI_CLKDIV_64		0x1
+#define  MVMDIO_XSMI_CLKDIV_32		0x2
+#define  MVMDIO_XSMI_CLKDIV_8		0x3
+
 /*
  * SMI Timeout measurements:
  * - Kirkwood 88F6281 (Globalscale Dreamplug): 45us to 95us (Interrupt)
@@ -237,6 +244,40 @@ static int orion_mdio_xsmi_write_c45(struct mii_bus *bus, int mii_id,
 	return 0;
 }
 
+static void orion_mdio_xsmi_set_mdc_freq(struct mii_bus *bus)
+{
+	struct orion_mdio_dev *dev = bus->priv;
+	struct clk *mg_core;
+	u32 div, freq, cfg;
+
+	if (device_property_read_u32(bus->parent, "clock-frequency", &freq))
+		return;
+
+	mg_core = of_clk_get_by_name(bus->parent->of_node, "mg_core_clk");
+	if (IS_ERR(mg_core)) {
+		dev_err(bus->parent,
+			"MG core clock unknown, not changing MDC frequency");
+		return;
+	}
+
+	div = clk_get_rate(mg_core) / (freq + 1) + 1;
+	clk_put(mg_core);
+
+	if (div <= 8)
+		div = MVMDIO_XSMI_CLKDIV_8;
+	else if (div <= 32)
+		div = MVMDIO_XSMI_CLKDIV_32;
+	else if (div <= 64)
+		div = MVMDIO_XSMI_CLKDIV_64;
+	else
+		div = MVMDIO_XSMI_CLKDIV_256;
+
+	cfg = readl(dev->regs + MVMDIO_XSMI_CFG_REG);
+	cfg &= ~MVMDIO_XSMI_CLKDIV_MASK;
+	cfg |= div;
+	writel(cfg, dev->regs + MVMDIO_XSMI_CFG_REG);
+}
+
 static irqreturn_t orion_mdio_err_irq(int irq, void *dev_id)
 {
 	struct orion_mdio_dev *dev = dev_id;
@@ -315,6 +356,9 @@ static int orion_mdio_probe(struct platform_device *pdev)
 			dev_warn(&pdev->dev,
 				 "unsupported number of clocks, limiting to the first "
 				 __stringify(ARRAY_SIZE(dev->clk)) "\n");
+
+		if (type == BUS_TYPE_XSMI)
+			orion_mdio_xsmi_set_mdc_freq(bus);
 	} else {
 		dev->clk[0] = clk_get(&pdev->dev, NULL);
 		if (PTR_ERR(dev->clk[0]) == -EPROBE_DEFER) {
-- 
2.34.1


