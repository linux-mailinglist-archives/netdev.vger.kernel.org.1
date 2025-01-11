Return-Path: <netdev+bounces-157467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED1DA0A601
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0FB3A87DA
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 20:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591A11B87D3;
	Sat, 11 Jan 2025 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8rcngK3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1FE1B6CEF
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736628690; cv=none; b=i5TfLdiWb4Tgu+EFnKyuH3eEN3ibB/lKXppWJaQmqIETP2PhOpDjMqiq0j4UNHaFs5HfJ3TwgTWFc/SSc2ZnndGlTzdkXk72MYJ6b0S2ZNI8MGu7lky08YLRaujCvCzGEs3agSVz5zv9osIzok2gGaPWG0LaHWYpdaJfHHH2S9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736628690; c=relaxed/simple;
	bh=NCsP2RlbUoZmKV5ozE8zkSx4DWVppH1hPsQB5VLqlls=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tLkqHwA05Y8svd4EtjlO8eFtUzH/TNOdxSmeomTsA/j28XzUwGijAB3aNsxsNkVwOEq3LrkNFHYfsxxm4Ae6BlBMDAQo95UXSGZ7j7txFDIEKU/fYuend90FxidZk0e57c/wSTBzSVHTLrUw1E4GuGkT+c20GULqUCjs1VdBw+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8rcngK3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4368a293339so35803295e9.3
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 12:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736628686; x=1737233486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A+NPa9UsOrWnDqnzu9b+a9ltXqFDmICrd+f0MG1TMaQ=;
        b=d8rcngK3CvLVVwuD9gkSg/nsBeiq88jKAb45/I3gdrKs0TdNKs7OKC2ELfFcI1OcfL
         TwNt8504k+oVgqCxT4nbZP0M1z5agnqabwfqbKBeIQK2Zm29RVJrCDg8hFsb6QCdkh+Z
         Z3N0jtXO076y+8flK+iNMUOsk3b+nekOYqjj8R8601X1FMYpBgAIEcpkiPh+i3mMacDv
         d+HLcz/Yook3KBbknN1hvgWXFjCCkF235tbn9F9cp+IR9EQWPJoBUjlbkqThagq55piL
         FKBWzi+eZhQtmmIIV1LXFlj3hEHRo4rNtyMr/bd5Ajk6jmp6mYNTPwZ5hmckwvPI30AF
         T0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736628686; x=1737233486;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+NPa9UsOrWnDqnzu9b+a9ltXqFDmICrd+f0MG1TMaQ=;
        b=i7/1CfYhcTUTaHJ3sJVOAwcy5E8PY+MXvV09fV96rJB6emSHTWWW7388657nccxAPi
         W49FyXvdxOhcRxXc9so5cU2agBmPLJ3mnq/t+btyPfRSF8OjoQ9JGQ07/JGL0QIFjsYZ
         L/LvwJm2bp6vtOzrTYjiH89VnFAMBNvJHWHsY9yZwcy4PSjBYqjKllHPhQUmfwHv9LvP
         TokKECIjcUMLFCYR1OEYpNWhj7o9yB+H0QR0w5T3a8h1arQfZFjxxnr4J6M/dJS/4GZb
         sFeUoFzQToZuIVDA8n8cSNhIqdDzFrTSH8HTQWJsFJpZ2nhyAHB7TEkPoyS5tnNJPV7t
         N4bA==
X-Gm-Message-State: AOJu0YxClBh7mIo+JUwGpmhtwqZuCy7TP6Vtl6OsYb25Wie6+opLUF2v
	lV5Le7Fw1Js40SnFMXsAgakah0x17T9jZ6IZFnOSDR96BahBZZ0N
X-Gm-Gg: ASbGncvWOcE9Am/baAlonQ18X2hIXiDEnbR7obFn9q9gvxxvVxw3XjWMa4H/tE5it6k
	DrD1ZDopMJ1XY9nPprTjsxXa3OVF/CreOmp9NvkpA9DsbS5T0oyCnfWbzz+WmxFRRxnxJiht+7u
	O5odheyg0Ln48PlEpMgnPOX4vVqGVSG8SKPTbxXPHDesAfLRD8IjIsPl0+A15zxi+6tPF1Uhz6/
	AK1yJtAPyuyZsVQtLGqF6a3qjbCWur3yF9jxbFRzmpzrSoddAmrEUn+sY4yIfj684z3TEexCres
	3+R0I5/Ctc2k4H/hpZei4ZdDqVeWoRJiHw7j4WfCLSeXCu5TJbyqOuDikC+FP+9HQ1NLdC/iuCq
	D65FL3kHwAf01jlJaN7uWgpm+8kQqXEB4S4I9j6/zxvY/AYF7
X-Google-Smtp-Source: AGHT+IHE57Uz363aXgmMUnRO6OX+2St5W+7mIIdVJB2suBEgGBRPR4tuw/qoISTQbn6kjYLm2em0/Q==
X-Received: by 2002:a05:600c:3ba0:b0:434:a802:43d with SMTP id 5b1f17b1804b1-436e27170c7mr128293675e9.27.1736628685345;
        Sat, 11 Jan 2025 12:51:25 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436e2e89dfesm127323755e9.32.2025.01.11.12.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 12:51:25 -0800 (PST)
Message-ID: <ad6bfe9f-6375-4a00-84b4-bfb38a21bd71@gmail.com>
Date: Sat, 11 Jan 2025 21:51:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 3/3] net: phy: realtek: add hwmon support for temp
 sensor on RTL822x
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <7319d8f9-2d6f-4522-92e8-a8a4990042fb@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <7319d8f9-2d6f-4522-92e8-a8a4990042fb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This adds hwmon support for the temperature sensor on RTL822x.
It's available on the standalone versions of the PHY's, and on
the integrated PHY's in RTL8125B/RTL8125D/RTL8126.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/realtek/Kconfig         |  6 ++
 drivers/net/phy/realtek/Makefile        |  1 +
 drivers/net/phy/realtek/realtek.h       | 10 ++++
 drivers/net/phy/realtek/realtek_hwmon.c | 79 +++++++++++++++++++++++++
 drivers/net/phy/realtek/realtek_main.c  | 12 ++++
 5 files changed, 108 insertions(+)
 create mode 100644 drivers/net/phy/realtek/realtek.h
 create mode 100644 drivers/net/phy/realtek/realtek_hwmon.c

diff --git a/drivers/net/phy/realtek/Kconfig b/drivers/net/phy/realtek/Kconfig
index 5b9e6e6db..31935f147 100644
--- a/drivers/net/phy/realtek/Kconfig
+++ b/drivers/net/phy/realtek/Kconfig
@@ -3,3 +3,9 @@ config REALTEK_PHY
 	tristate "Realtek PHYs"
 	help
 	  Currently supports RTL821x/RTL822x and fast ethernet PHYs
+
+config REALTEK_PHY_HWMON
+	def_bool REALTEK_PHY && HWMON
+	depends on !(REALTEK_PHY=y && HWMON=m)
+	help
+	  Optional hwmon support for the temperature sensor
diff --git a/drivers/net/phy/realtek/Makefile b/drivers/net/phy/realtek/Makefile
index 996a80642..dd21cf87f 100644
--- a/drivers/net/phy/realtek/Makefile
+++ b/drivers/net/phy/realtek/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 realtek-y			+= realtek_main.o
+realtek-$(CONFIG_REALTEK_PHY_HWMON) += realtek_hwmon.o
 obj-$(CONFIG_REALTEK_PHY)	+= realtek.o
diff --git a/drivers/net/phy/realtek/realtek.h b/drivers/net/phy/realtek/realtek.h
new file mode 100644
index 000000000..a39b44fa1
--- /dev/null
+++ b/drivers/net/phy/realtek/realtek.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef REALTEK_H
+#define REALTEK_H
+
+#include <linux/phy.h>
+
+int rtl822x_hwmon_init(struct phy_device *phydev);
+
+#endif /* REALTEK_H */
diff --git a/drivers/net/phy/realtek/realtek_hwmon.c b/drivers/net/phy/realtek/realtek_hwmon.c
new file mode 100644
index 000000000..1ecb410bb
--- /dev/null
+++ b/drivers/net/phy/realtek/realtek_hwmon.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * HWMON support for Realtek PHY's
+ *
+ * Author: Heiner Kallweit <hkallweit1@gmail.com>
+ */
+
+#include <linux/hwmon.h>
+#include <linux/phy.h>
+
+#include "realtek.h"
+
+#define RTL822X_VND2_TSALRM				0xa662
+#define RTL822X_VND2_TSRR				0xbd84
+#define RTL822X_VND2_TSSR				0xb54c
+
+static int rtl822x_hwmon_get_temp(int raw)
+{
+	if (raw >= 512)
+		raw -= 1024;
+
+	return 1000 * raw / 2;
+}
+
+static int rtl822x_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+	struct phy_device *phydev = dev_get_drvdata(dev);
+	int raw;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		raw = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSRR) & 0x3ff;
+		*val = rtl822x_hwmon_get_temp(raw);
+		break;
+	case hwmon_temp_max:
+		/* Chip reduces speed to 1G if threshold is exceeded */
+		raw = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSSR) >> 6;
+		*val = rtl822x_hwmon_get_temp(raw);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct hwmon_ops rtl822x_hwmon_ops = {
+	.visible = 0444,
+	.read = rtl822x_hwmon_read,
+};
+
+static const struct hwmon_channel_info * const rtl822x_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX),
+	NULL
+};
+
+static const struct hwmon_chip_info rtl822x_hwmon_chip_info = {
+	.ops = &rtl822x_hwmon_ops,
+	.info = rtl822x_hwmon_info,
+};
+
+int rtl822x_hwmon_init(struct phy_device *phydev)
+{
+	struct device *hwdev, *dev = &phydev->mdio.dev;
+	const char *name;
+
+	/* Ensure over-temp alarm is reset. */
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSALRM, 3);
+
+	name = devm_hwmon_sanitize_name(dev, dev_name(dev));
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+
+	hwdev = devm_hwmon_device_register_with_info(dev, name, phydev,
+						     &rtl822x_hwmon_chip_info,
+						     NULL);
+	return PTR_ERR_OR_ZERO(hwdev);
+}
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index af9874143..38149958d 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -14,6 +14,8 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 
+#include "realtek.h"
+
 #define RTL821x_PHYSR				0x11
 #define RTL821x_PHYSR_DUPLEX			BIT(13)
 #define RTL821x_PHYSR_SPEED			GENMASK(15, 14)
@@ -820,6 +822,15 @@ static int rtl822x_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 	return ret;
 }
 
+static int rtl822x_probe(struct phy_device *phydev)
+{
+	if (IS_ENABLED(CONFIG_REALTEK_PHY_HWMON) &&
+	    phydev->phy_id != RTL_GENERIC_PHYID)
+		return rtl822x_hwmon_init(phydev);
+
+	return 0;
+}
+
 static int rtl822xb_config_init(struct phy_device *phydev)
 {
 	bool has_2500, has_sgmii;
@@ -1519,6 +1530,7 @@ static struct phy_driver realtek_drvs[] = {
 		.match_phy_device = rtl_internal_nbaset_match_phy_device,
 		.name           = "Realtek Internal NBASE-T PHY",
 		.flags		= PHY_IS_INTERNAL,
+		.probe		= rtl822x_probe,
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
-- 
2.47.1



