Return-Path: <netdev+bounces-157136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D32FA08FB6
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F55F1883713
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A7A20A5D0;
	Fri, 10 Jan 2025 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARDWTmAv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C0205AC2;
	Fri, 10 Jan 2025 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509744; cv=none; b=okKAkmNOK+qT2x3ssl/hHOaV28AchsMBcvFcT54/RmKX5vXC7XUZ5S565f+cCq4jmYbgQQ0TMvp7D7VDV0kvPG8PIdJPpUk9LyjOuVkFJ2QuTumDr0e9XXysNoBntzCFY47KWZC/sBkpavuBZs4cdyrVZceXzSi3yta3xPt7jeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509744; c=relaxed/simple;
	bh=IG28JPRy8rC3DA1u9NkcapKewG+lHiHS1ho+Pj1X94w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iwL1vM2PZwVOVWBI3J/kF/UOW2PfXZrqdpww8SGckhU+ZNbH9uAC+wVfiqV1Osh5U/3c4hruYC2W2IROZEF1w3BcHESdUd2DCMDdYsEk/eUjChp+NzrutZH9KTHmnwb29uTXKzTzQmGsYA3tLMarqbdkY9QgZa5mn6kImJd6Zns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARDWTmAv; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa69107179cso391434966b.0;
        Fri, 10 Jan 2025 03:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736509740; x=1737114540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nDhfwmVUMDkg4WzAT/EvKEcVBKs5+02lfd4/lB3Zw8I=;
        b=ARDWTmAvDJn0mWcY0wphuxOdZWviPz+mMYXKVFWgICxVaHowhteL7hsQz2SzHNZgCX
         4oFNNMFKFDah2OXZApHeldwRckKkU7FGTKkk+4wbD2IXclhnGivXbQrDxKAicXVQBLnY
         cbXYHUmpXa43jwinYsx1pvUcY8f4FtSSCDWUvRCAPbvQGyXdS45wTQUgh1AXEK9NvCdd
         ScyWYEZn2hGubvY3G7kvcPqJ5toMF5kjKwExhq8PQSmZHdPmHqZVpu5wgJuEW1F6YR6a
         cdTuhE28OI0qZcnS1OiJu3IjuQoPOYnQKG20Gp4FdpsUA7txik1mawwquPVwvOOq91vk
         NsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736509740; x=1737114540;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nDhfwmVUMDkg4WzAT/EvKEcVBKs5+02lfd4/lB3Zw8I=;
        b=QFteFf3EDdXVYFiVuX3IBfR6FNKUUldoI04ZTew3jGpsWUBqUKRVZySG5EqEtZ4Rjl
         7wQmNeR40vFuK9mpOv5ukjRnhY6NTQYs6qaayZ6E5LKTLov9OOL0nG9qYUNPSmdoHR9K
         MKL2WGur4UqTiIhMJ++42NWCsnAdB2uLYBntaqkE/e7IMxFWpDLFHADZ5FZgnkHR4aEO
         j7QZRF8NqZHTWVfVXEjV177CCqwbRJJjWUAFmS2Ah3ccDpurXqBQC2GnNl3yhD1xdB3C
         Q+jvHkJJlk9rr8df/8LvNkkx2pTUeHSeObHwNgs2RLetTrAjAmduCHZmjNODDxAZ24j5
         7yww==
X-Forwarded-Encrypted: i=1; AJvYcCX1yIEPRnhnjSYQionjYMer5FSFmoJ6v6HpbMy8uM2gOt3gjCzEsdbe+cFBDPcien5TGmBV5QYvcvN5dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBoawP1KFNZXUfq4H8lvVKC6Gm5TobbRegc07nX36AJDS85Cul
	raMfa2Wl9f3Jo2j3jw+ApY9MEzGKpzvVPmjVB5an7+/JvgJ4Oljm
X-Gm-Gg: ASbGncvAixjapeFGGCRwQDi6C9Sv1SErHVnJBukxZ4YPUI/IwWvZrS97xmuJGTW2Tl5
	MrTKOZG2YqC9hsY6aYEpvm4k1l8pp/DHE2nFKYwfJWzB0rD83CgjueNy6FXMx9s51+GVPMzTRRE
	0Nx3yCYbIw5evfw9Ry1JxkfugbVS34oJ2AQfidovoKm1tzzuBMc27nRaZ2BP2Sp5lPMZXcAb03A
	Z/BS2BiVjMtlb42BiaqQlSfscdJz9vXNKLAI2kZol5uhYmaXEDQ+lZ1VMBj+OkoI8mwDkjtVf6H
	YAVm5kqLL/5GSRuC74SO8IeiC6fjLK4YUwrIl2rMbsM+eMnUWoQG5MDuoGpWSM/4t+Yp9gu824Z
	jjvik57ojWKxPWzxfBnZiqOs1paPlYlNf1x0slcLhGByRdQEJ
X-Google-Smtp-Source: AGHT+IG2ZHs3cWa69zXXfnYBgzXk9PW888p0qMewa2Oo7vPDUqHA24Ti5mlcXEwsNEynoFzmh8oIiA==
X-Received: by 2002:a17:907:c0c:b0:aae:8490:9429 with SMTP id a640c23a62f3a-ab2ab6fd4c3mr704660966b.34.1736509740228;
        Fri, 10 Jan 2025 03:49:00 -0800 (PST)
Received: from ?IPV6:2a02:3100:a08a:a100:c4f5:b048:2468:70d1? (dynamic-2a02-3100-a08a-a100-c4f5-b048-2468-70d1.310.pool.telefonica.de. [2a02:3100:a08a:a100:c4f5:b048:2468:70d1])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c95af24bsm159814166b.134.2025.01.10.03.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 03:48:59 -0800 (PST)
Message-ID: <dbfeb139-808f-4345-afe8-830b7f4da26a@gmail.com>
Date: Fri, 10 Jan 2025 12:48:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/3] net: phy: realtek: add hwmon support for temp
 sensor on RTL822x
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
References: <3e2784e3-4670-4d54-932f-b25440747b65@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <3e2784e3-4670-4d54-932f-b25440747b65@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This adds hwmon support for the temperature sensor on RTL822x. It's
available on the standalone versions of the PHY's, and on the integrated
PHY's in RTL8125B/RTL8125D/RTL8126.

Notes:
- over-temp threshold is set by PHY power-on default or BIOS / boot loader
  and it's read-only
- over-temp alarm remains set, even if temperature drops below threshold

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/Kconfig         |  6 +++
 drivers/net/phy/Makefile        |  1 +
 drivers/net/phy/realtek.h       | 10 ++++
 drivers/net/phy/realtek_hwmon.c | 83 +++++++++++++++++++++++++++++++++
 drivers/net/phy/realtek_main.c  | 12 +++++
 5 files changed, 112 insertions(+)
 create mode 100644 drivers/net/phy/realtek.h
 create mode 100644 drivers/net/phy/realtek_hwmon.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index dc625f2b3..eae53ef88 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -355,6 +355,12 @@ config REALTEK_PHY
 	help
 	  Supports the Realtek 821x PHY.
 
+config REALTEK_PHY_HWMON
+	def_bool REALTEK_PHY && HWMON
+	depends on !(REALTEK_PHY=y && HWMON=m)
+	help
+	  Optional hwmon support for the temperature sensor
+
 config RENESAS_PHY
 	tristate "Renesas PHYs"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index ec480e733..ca369a5c9 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_NXP_TJA11XX_PHY)	+= nxp-tja11xx.o
 obj-y				+= qcom/
 obj-$(CONFIG_QSEMI_PHY)		+= qsemi.o
 realtek-y += realtek_main.o
+realtek-$(CONFIG_REALTEK_PHY_HWMON) += realtek_hwmon.o
 obj-$(CONFIG_REALTEK_PHY)	+= realtek.o
 obj-$(CONFIG_RENESAS_PHY)	+= uPD60620.o
 obj-$(CONFIG_ROCKCHIP_PHY)	+= rockchip.o
diff --git a/drivers/net/phy/realtek.h b/drivers/net/phy/realtek.h
new file mode 100644
index 000000000..a39b44fa1
--- /dev/null
+++ b/drivers/net/phy/realtek.h
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
diff --git a/drivers/net/phy/realtek_hwmon.c b/drivers/net/phy/realtek_hwmon.c
new file mode 100644
index 000000000..d3284c83f
--- /dev/null
+++ b/drivers/net/phy/realtek_hwmon.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0+
+ *
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
+	case hwmon_temp_alarm:
+		raw = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSALRM);
+		*val = !!(raw & 3);
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
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_ALARM),
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
diff --git a/drivers/net/phy/realtek_main.c b/drivers/net/phy/realtek_main.c
index af9874143..38149958d 100644
--- a/drivers/net/phy/realtek_main.c
+++ b/drivers/net/phy/realtek_main.c
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



