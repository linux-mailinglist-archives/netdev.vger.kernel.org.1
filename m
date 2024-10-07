Return-Path: <netdev+bounces-132634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665E0992933
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3DB4B22252
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B24A1B85F5;
	Mon,  7 Oct 2024 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbO610c8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B8D18B498
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296821; cv=none; b=KjPO6WQ7bJCpIg9D12K3b9euXYRHR8Upl3INZVY/K8PIrOBPf8lgoEgmszI+HfJ8UGm1BT/55TjkpEBPtqeWXKThqHgJmdZMg2mw0G5OBlwjmcpJSNhL/9NgEB6ZvgCzbsNLcRbOKzYkp3OJCXZH0GNv/7cQnodbuudJkoKcun0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296821; c=relaxed/simple;
	bh=wN8S6ijfY2spVa6QValDQlP4UW/7L8R+hNJUKXDScgM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sden6Lcxh+4MigiMajPo0c5leEt9FaVYaQXiDucVsRFDVvZFZ5DUOW4Hx+vVerySKDza65e+rqdKyAyoVZYJ0lH0nn0PYX4lkQDptCHNLVyE7bx2CH4lf9i9S20Nw/4b1/5C7taJH0QB6skKcI/tqwHk8PdKOOmdQ/PCD9uX+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbO610c8; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fad5024b8dso46728331fa.1
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 03:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728296818; x=1728901618; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvA8yfSJ7ncyhz84idsRPBQyUhn+iHOkbePjk03/S00=;
        b=HbO610c8qv+AgeJW88Sicz1epSG0UntcxVc6PZoOjCclRRukr+v1Q66B1e1q5Ut4Df
         Np7VyRlj1tCu4V/GPXIhaWyq10aqWuye8M3WR89aWeJSUW772E3Emqy61uCyoPZuAet/
         /UPJdtmlm6IQr5dxtce+c1heib1s9WPUwFKiPbh6/QGiXkEdpQunTaGojfRioinDgYXj
         +Ox139Qe/w3X2eM+n8t+94dHXptMl2+MrAuLjJvlH3+EK+H8ZgcP57/9qt/q5pkQ97qN
         lc4kUQFoGe0xtXPVXP8EI6oMyN+T3PLfe5pIaRm6ZtVxUPuWfJ1ULQW7/WrvvvL3wXWO
         MS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728296818; x=1728901618;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvA8yfSJ7ncyhz84idsRPBQyUhn+iHOkbePjk03/S00=;
        b=fThDEIBtrgqOzZC4mEHRmmF8lUxZV8ONc2/3y8+KHqxuMBlDFzjhSIuvpixojSL4pK
         KuMFbym1kAg22GJPnDGeUNByEuU0JszJEXnyzE0nF+dCBZmA4kCjCidk9tooIw/0LpL5
         nPyLZC3UgYWMGXE9mn8sqzICw3iXO2q3vBxAVsIV6QY7QSoHFGCxzaJ4EwyCkop3qZCw
         WMa9ViONU2YHeJ5znVoodgNS7ge7Js8JS2N3qk0XaHCw0iId0xrbJyYZ96vgYvgmQ+9+
         A8boPT7VLPWvo9C7kMboVeLWvXo2nTwMmelT/YzDqpKInQkHP4Pg8p9dFSRUBLOoMQgc
         ELUA==
X-Gm-Message-State: AOJu0YxPlTLBNadnwwOnjkFDetL2WwDjFEwtPrB81RK0SLVxGC67xj89
	R4WePOfQXmhB04DIBVnT5FTIRAhsRjBQy+a+aalAY8Uxra74FFyauhuhvA==
X-Google-Smtp-Source: AGHT+IEtP8r04U+5s5jWukOJEcTD5Sik4aeX4WV4y5l0+wOF+jX/BcECFbZPva9h7NSB748YwHi9Iw==
X-Received: by 2002:a05:651c:1502:b0:2fa:e03a:bee7 with SMTP id 38308e7fff4ca-2faf3c64dffmr53355271fa.28.1728296817378;
        Mon, 07 Oct 2024 03:26:57 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a12d:4f00:8871:a49a:3cb3:6563? (dynamic-2a02-3100-a12d-4f00-8871-a49a-3cb3-6563.310.pool.telefonica.de. [2a02:3100:a12d:4f00:8871:a49a:3cb3:6563])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05a7ed3sm3018896a12.22.2024.10.07.03.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 03:26:57 -0700 (PDT)
Message-ID: <a55498c6-cf88-4af9-823f-5c231d5d994e@gmail.com>
Date: Mon, 7 Oct 2024 12:27:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: add support for the temperature sensor being
 available from RTL8125B
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This adds support for the temperature sensor being available from
RTL8125B. Register information was taken from r8125 vendor driver.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 43 +++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 305ec19cc..0a68b9caa 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/ethtool.h>
+#include <linux/hwmon.h>
 #include <linux/phy.h>
 #include <linux/if_vlan.h>
 #include <linux/in.h>
@@ -5363,6 +5364,42 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	return false;
 }
 
+static umode_t r8169_hwmon_is_visible(const void *, enum hwmon_sensor_types,
+				      u32, int)
+{
+	return 0444;
+}
+
+static int r8169_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			    u32 attr, int channel, long *val)
+{
+	struct rtl8169_private *tp = dev_get_drvdata(dev);
+	int val_raw;
+
+	val_raw = phy_read_paged(tp->phydev, 0xbd8, 0x12) & 0x3ff;
+	if (val_raw >= 512)
+		val_raw -= 1024;
+
+	*val = 1000 * val_raw / 2;
+
+	return 0;
+}
+
+static const struct hwmon_ops r8169_hwmon_ops = {
+	.is_visible =  r8169_hwmon_is_visible,
+	.read = r8169_hwmon_read,
+};
+
+static const struct hwmon_channel_info * const r8169_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_chip_info r8169_hwmon_chip_info = {
+	.ops = &r8169_hwmon_ops,
+	.info = r8169_hwmon_info,
+};
+
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct rtl8169_private *tp;
@@ -5537,6 +5574,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
+	/* The temperature sensor is available from RTl8125B */
+	if (IS_REACHABLE(CONFIG_HWMON) && tp->mac_version >= RTL_GIGA_MAC_VER_63)
+		/* ignore errors */
+		devm_hwmon_device_register_with_info(&pdev->dev, "nic_temp", tp,
+						     &r8169_hwmon_chip_info,
+						     NULL);
 	rc = register_netdev(dev);
 	if (rc)
 		return rc;
-- 
2.46.2


