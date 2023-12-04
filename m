Return-Path: <netdev+bounces-53437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D732802F9D
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 11:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB7DB20A9F
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B60200B2;
	Mon,  4 Dec 2023 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="L6fId/4L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFD099
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 02:08:28 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bce78f145so5000332e87.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 02:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701684506; x=1702289306; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NupAADUjLojjcNqZenMNhCx0/lE8c7FM0G/tbESSkUc=;
        b=L6fId/4LDvqXBNRgzxvCxkLWTn/CFLZb3XHEio+K6iTmuDK3RiYjH6J9G8dKy7Zdl2
         rRv8hn3X2KggHWVV3V9TczqvYi3BzGg9qxGsLtm5WSlwl2gH52xFkuab8be6TkUJru48
         vDrQVxOSVoaAQ2SAlF2t0C+qfVkxn9/lYC7c06rXA0ND9i8j1NeumsvFSaw5VFnXcb+j
         9SiVYJXkL4Pnh1t/4qQkId4DHYCeZU2v+5C/cr1orEulJ7EDBt4RiVnHMhuebOtI1dNk
         23KoQ0ICMK0lsPHa1W4C0OO0T7XFGJhA24SIflhhQ7VeHiQdO4Q2BjAqg9MlPLqGReA+
         g/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684506; x=1702289306;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NupAADUjLojjcNqZenMNhCx0/lE8c7FM0G/tbESSkUc=;
        b=rkwEoYF7b6l9j0Tf4BS88aWhYK+7WWHvwQUsosbEwJtQllVqIjKzNneINJZ705h3qy
         WunGWsamS1Jx6vkikMbHSVM/bbOOjnn8PXYsPUsTJprSS97CYwa8B3/z+thfX5ITrZzV
         jRfTLBnaWPt4Zf1qekWqGVdIxBK2g7MN9aAaYb5+ZbXZuhEqgWX9aF7qryqE+ZrEuu46
         V0g50YXVjm0HSrx89mBqZcy86/w/g/6gJRe1rYX1sAWRbtU+oMD+SU+7ZxnSIcNA+4rx
         H20lcDz/jbC7uhzLRGMH8Ne89xT/ph184x0NrAb7nCSZuUoB8ueEY3cwYwdZCn4IP4E2
         rruw==
X-Gm-Message-State: AOJu0YwC9GVc1OrCqKtE5FV82fh+PGGMyGrJY0sKZZqr/YUS5UucuVDV
	rHmsTP8VHK/TI8pK2N5nZMWrBw==
X-Google-Smtp-Source: AGHT+IFnKHddgyeXxCxSsPyAvJkBdc+uBF4j3NvlvRO9tK7ilBqh7o/xm9UEOxQdtfjYVRvqCCdX2A==
X-Received: by 2002:ac2:4d07:0:b0:50b:f822:eac7 with SMTP id r7-20020ac24d07000000b0050bf822eac7mr262516lfi.171.1701684506188;
        Mon, 04 Dec 2023 02:08:26 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id u29-20020a19791d000000b0050beead375bsm553643lfc.57.2023.12.04.02.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 02:08:25 -0800 (PST)
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
Subject: [PATCH v2 net-next 3/3] net: mvmdio: Support setting the MDC frequency on XSMI controllers
Date: Mon,  4 Dec 2023 11:08:11 +0100
Message-Id: <20231204100811.2708884-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204100811.2708884-1-tobias@waldekranz.com>
References: <20231204100811.2708884-1-tobias@waldekranz.com>
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
index 5f66f779e56f..9190eff6c0bb 100644
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
@@ -225,6 +232,40 @@ static int orion_mdio_xsmi_write_c45(struct mii_bus *bus, int mii_id,
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
@@ -303,6 +344,9 @@ static int orion_mdio_probe(struct platform_device *pdev)
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


