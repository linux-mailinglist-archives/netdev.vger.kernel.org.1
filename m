Return-Path: <netdev+bounces-222806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE67B56303
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 23:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43F694E0344
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 21:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6A82701B4;
	Sat, 13 Sep 2025 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn/cTasW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3561DFCB
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757797605; cv=none; b=hXT1ElTwFspuYXSYJRTzQJEPIpfdlYuwTaWNSGf8GFprczOdGvV0mFd4l1Oug8eA0Y2Do40paqZj7Xd9GEH4s1ijhEwo5C2mwzLJpKW1PHXIcMk4z8C95jTMO5RZjHDnQ61gr304oUHWjHxKrYVauNNByIhI8G+kaHQU7TAwV+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757797605; c=relaxed/simple;
	bh=Q0q6Xy7IS8PdbdfF1D1AB14PoYH1adWpSHk/OhbnBR4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WMvFiPScpjTri9ujHhpaWUbp5kBx0Kyy6vzhkernAKVokeiX/k3UwaOTD7lF2Xv1KbMrHnTXIo445tqEMkB/DU0A9EP7oVVK0/u0ZNLHS0R4OMRFhMmoxWdnUUlDoZKv++C5jo+EW3QiIgGMxTYZWPuQe2ceL15ghgZuUtH5/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn/cTasW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dec1ae562so26572095e9.1
        for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 14:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757797602; x=1758402402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KfOdfRh7ghnQBv4AwRVVt11a6hxXjdGEEED2aYR0uVo=;
        b=nn/cTasW83zR6sY+Ud0TBN8weA8dPrVNh6fTXbxpvVyaCbVc4pUp2nydlgiKdtWcX/
         41kEdYsT/pVXJcSPJNi9K2EIN9ZDY8O2iWrd9yiDGQUwzOIaUA2FcqAl2FF+fh/4inoy
         doKC8fL17utbq4qwJ7G+PrQZUraqpznN/PNxZAEI1Y3z61mOHIK+0itku1EKVjZFWASb
         bBLrt5btJCass1vwFD63fNji5rPvOHHENpjjXT0d+7P6BLN2M3Q3VMVpcpYWYk8/Qzh5
         lI4Fdf/X3K5lJkq47zfqTUCtn8u8OF9MfeERuhx/F1eTkVH06ovumxMxsF1XZlK1PkOY
         pAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757797602; x=1758402402;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfOdfRh7ghnQBv4AwRVVt11a6hxXjdGEEED2aYR0uVo=;
        b=L/JK5fY/3H2JN/X+xiH7e85BFGevB0t9laaoTV8dbNLWfdgiYbqyfx8hVsMHtQYhhB
         rp1nTz1k4+5sqcdGOWdK2U03HW1uQ0ABfWpsrUUXlj+HrSvwJnio/2DDQ/QQwHoycJvo
         wzSwMCp1Xz7rXeEw3sHERVwCG7Yltk0ku+i8GjU/9IbpQ09rlCWyC2CFtG6ixcbbr+ft
         ET5yBsPXPlL7I9qadb9eb14/EFF6u6xH4gb6Aq6xa+M9O4FswZrhb0ZrdxjcgHjB/UGw
         aUOoVMGUtnM5AF0WZsPOkTjbxcFO2k+I2prijKoqILakk1Q4uTKNdOs/RG9lwVvAFQRI
         dXaw==
X-Gm-Message-State: AOJu0Yyw+HKXpmvGO67aykbyC3HlnYATSAGvVWC4zif/QjsgqywtfhCq
	LGNMlpyKcfxkWK3nmkSTRll1U9LrJspK1wulVWrlarEP7dupOfAzRB4H
X-Gm-Gg: ASbGncumnkmk21/y1ZtcYpcve/xuxU15yvX2HPe5824WcXkBWYCwNrnhCSqMFBKZfMu
	wUMuyDC6/kJOwBXIBCB14l8Ha4J+POPfoSq3PVDloZ8zlTaqw9j0w5fh8OujKbt+dLMPkIzHHGu
	ipUsSUJRSwMfvhadzUBseNrz0jCyJfceNRZf4PAyWqTLAtHy2Bpau5lcN3Y8+PkmJFbGiIOHVEs
	yX6G+BXAEUhlPwEq3CwlqsmIyc3DSmGs73lPbhjhD7rHZi1ee5qoqYjzHDAwgIVvTZnLlH02zp5
	H01p1v7N7pCf9Vt+pYfLKQZk8K1KAfujXCxLZDZS9GqXlemJ4Jl9HmmnYJc3QyDCI6qOLFTiNep
	PiJ2a+9oy3K/24VgShX6SYfKFwE/j2/RAWCyrVLh5JAQvfyaLwINAoqDONJ1QAQLyQdI3Dw4TtB
	Z702itIObtIZkQq5N/j2feO45JY5rEot/9XtEnAA02uQcUK7IV3hzdSvrVGczv9ix+NnKOa8Rw
X-Google-Smtp-Source: AGHT+IEqG3Ie7QzUurKkwwsTobaTK7cAS44fC6QVo0H0+tnQdoi512AsrT9JXyocC/amDij499/aUQ==
X-Received: by 2002:a05:600c:1384:b0:458:b01c:8f with SMTP id 5b1f17b1804b1-45f211cc941mr78022825e9.8.1757797602040;
        Sat, 13 Sep 2025 14:06:42 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f24:8500:34bf:776f:e57e:cca6? (p200300ea8f24850034bf776fe57ecca6.dip0.t-ipconnect.de. [2003:ea:8f24:8500:34bf:776f:e57e:cca6])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45f24be2aafsm34731395e9.2.2025.09.13.14.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 14:06:41 -0700 (PDT)
Message-ID: <da9563a4-8e14-41cf-bfea-cf5f1b58a4b7@gmail.com>
Date: Sat, 13 Sep 2025 23:07:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/2] net: dsa: dsa_loop: remove usage of
 mdio_board_info
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <4ccf7476-0744-4f6b-aafc-7ba84d15a432@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <4ccf7476-0744-4f6b-aafc-7ba84d15a432@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

dsa_loop is the last remaining user of mdio_board_info. Let's remove
using mdio_board_info, so that support for it can be dropped from
phylib.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/dsa/Makefile          |  3 --
 drivers/net/dsa/dsa_loop.c        | 63 +++++++++++++++++++++++++++++--
 drivers/net/dsa/dsa_loop.h        | 20 ----------
 drivers/net/dsa/dsa_loop_bdinfo.c | 36 ------------------
 4 files changed, 60 insertions(+), 62 deletions(-)
 delete mode 100644 drivers/net/dsa/dsa_loop.h
 delete mode 100644 drivers/net/dsa/dsa_loop_bdinfo.c

diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index c0a534fe6..0f8ff4a1a 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -2,9 +2,6 @@
 obj-$(CONFIG_NET_DSA_BCM_SF2)	+= bcm-sf2.o
 bcm-sf2-objs			:= bcm_sf2.o bcm_sf2_cfp.o
 obj-$(CONFIG_NET_DSA_LOOP)	+= dsa_loop.o
-ifdef CONFIG_NET_DSA_LOOP
-obj-$(CONFIG_FIXED_PHY)		+= dsa_loop_bdinfo.o
-endif
 obj-$(CONFIG_NET_DSA_KS8995) 	+= ks8995.o
 obj-$(CONFIG_NET_DSA_MT7530)	+= mt7530.o
 obj-$(CONFIG_NET_DSA_MT7530_MDIO) += mt7530-mdio.o
diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
index 8112515d5..720738807 100644
--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -17,7 +17,19 @@
 #include <linux/dsa/loop.h>
 #include <net/dsa.h>
 
-#include "dsa_loop.h"
+#define DSA_LOOP_NUM_PORTS	6
+#define DSA_LOOP_CPU_PORT	(DSA_LOOP_NUM_PORTS - 1)
+#define NUM_FIXED_PHYS		(DSA_LOOP_NUM_PORTS - 2)
+
+struct dsa_loop_pdata {
+	/* Must be first, such that dsa_register_switch() can access this
+	 * without gory pointer manipulations
+	 */
+	struct dsa_chip_data cd;
+	const char *name;
+	unsigned int enabled_ports;
+	const char *netdev;
+};
 
 static struct dsa_loop_mib_entry dsa_loop_mibs[] = {
 	[DSA_LOOP_PHY_READ_OK]	= { "phy_read_ok", },
@@ -27,6 +39,7 @@ static struct dsa_loop_mib_entry dsa_loop_mibs[] = {
 };
 
 static struct phy_device *phydevs[PHY_MAX_ADDR];
+static struct mdio_device *switch_mdiodev;
 
 enum dsa_loop_devlink_resource_id {
 	DSA_LOOP_DEVLINK_PARAM_ID_VTU,
@@ -392,6 +405,42 @@ static void dsa_loop_phydevs_unregister(void)
 	}
 }
 
+static int __init dsa_loop_create_switch_mdiodev(void)
+{
+	static struct dsa_loop_pdata dsa_loop_pdata = {
+		.cd = {
+			.port_names[0] = "lan1",
+			.port_names[1] = "lan2",
+			.port_names[2] = "lan3",
+			.port_names[3] = "lan4",
+			.port_names[DSA_LOOP_CPU_PORT] = "cpu",
+		},
+		.name = "DSA mockup driver",
+		.enabled_ports = 0x1f,
+		.netdev = "eth0",
+	};
+	struct mii_bus *bus;
+	int ret = -ENODEV;
+
+	bus = mdio_find_bus("fixed-0");
+	if (WARN_ON(!bus))
+		return ret;
+
+	switch_mdiodev = mdio_device_create(bus, 31);
+	if (IS_ERR(switch_mdiodev))
+		goto out;
+
+	strscpy(switch_mdiodev->modalias, "dsa-loop");
+	switch_mdiodev->dev.platform_data = &dsa_loop_pdata;
+
+	ret = mdio_device_register(switch_mdiodev);
+	if (ret)
+		mdio_device_free(switch_mdiodev);
+out:
+	put_device(&bus->dev);
+	return ret;
+}
+
 static int __init dsa_loop_init(void)
 {
 	struct fixed_phy_status status = {
@@ -402,12 +451,19 @@ static int __init dsa_loop_init(void)
 	unsigned int i;
 	int ret;
 
+	ret = dsa_loop_create_switch_mdiodev();
+	if (ret)
+		return ret;
+
 	for (i = 0; i < NUM_FIXED_PHYS; i++)
 		phydevs[i] = fixed_phy_register(&status, NULL);
 
 	ret = mdio_driver_register(&dsa_loop_drv);
-	if (ret)
+	if (ret) {
 		dsa_loop_phydevs_unregister();
+		mdio_device_remove(switch_mdiodev);
+		mdio_device_free(switch_mdiodev);
+	}
 
 	return ret;
 }
@@ -417,10 +473,11 @@ static void __exit dsa_loop_exit(void)
 {
 	mdio_driver_unregister(&dsa_loop_drv);
 	dsa_loop_phydevs_unregister();
+	mdio_device_remove(switch_mdiodev);
+	mdio_device_free(switch_mdiodev);
 }
 module_exit(dsa_loop_exit);
 
-MODULE_SOFTDEP("pre: dsa_loop_bdinfo");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Florian Fainelli");
 MODULE_DESCRIPTION("DSA loopback driver");
diff --git a/drivers/net/dsa/dsa_loop.h b/drivers/net/dsa/dsa_loop.h
deleted file mode 100644
index 93e5c15d0..000000000
--- a/drivers/net/dsa/dsa_loop.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __DSA_LOOP_H
-#define __DSA_LOOP_H
-
-struct dsa_chip_data;
-
-struct dsa_loop_pdata {
-	/* Must be first, such that dsa_register_switch() can access this
-	 * without gory pointer manipulations
-	 */
-	struct dsa_chip_data cd;
-	const char *name;
-	unsigned int enabled_ports;
-	const char *netdev;
-};
-
-#define DSA_LOOP_NUM_PORTS	6
-#define DSA_LOOP_CPU_PORT	(DSA_LOOP_NUM_PORTS - 1)
-
-#endif /* __DSA_LOOP_H */
diff --git a/drivers/net/dsa/dsa_loop_bdinfo.c b/drivers/net/dsa/dsa_loop_bdinfo.c
deleted file mode 100644
index 14ca42491..000000000
--- a/drivers/net/dsa/dsa_loop_bdinfo.c
+++ /dev/null
@@ -1,36 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/phy.h>
-#include <net/dsa.h>
-
-#include "dsa_loop.h"
-
-static struct dsa_loop_pdata dsa_loop_pdata = {
-	.cd = {
-		.port_names[0] = "lan1",
-		.port_names[1] = "lan2",
-		.port_names[2] = "lan3",
-		.port_names[3] = "lan4",
-		.port_names[DSA_LOOP_CPU_PORT] = "cpu",
-	},
-	.name = "DSA mockup driver",
-	.enabled_ports = 0x1f,
-	.netdev = "eth0",
-};
-
-static const struct mdio_board_info bdinfo = {
-	.bus_id	= "fixed-0",
-	.modalias = "dsa-loop",
-	.mdio_addr = 31,
-	.platform_data = &dsa_loop_pdata,
-};
-
-static int __init dsa_loop_bdinfo_init(void)
-{
-	return mdiobus_register_board_info(&bdinfo, 1);
-}
-arch_initcall(dsa_loop_bdinfo_init)
-
-MODULE_DESCRIPTION("DSA mock-up switch driver");
-MODULE_LICENSE("GPL");
-- 
2.51.0



