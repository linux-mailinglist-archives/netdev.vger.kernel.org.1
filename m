Return-Path: <netdev+bounces-132836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE1993647
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF0D1C2352D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9401DB522;
	Mon,  7 Oct 2024 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTw4RXAV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3106A1D5CD1;
	Mon,  7 Oct 2024 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326057; cv=none; b=rdu2TtIcIt/JWVg5WOe1P39WwNh3HjiM0l0EcGzuH62sBrSSnCOI2GyiuHI01RDjWdWFMxLBGlvz6EmNf/ZdJazVucqhwZNVrpo6rDc/brXu1vytJguUrkx75t71LBloTux1om8aCWBYtz/RLynD9GER87xqK7w0u2r3+eXQqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326057; c=relaxed/simple;
	bh=jNI+TidUFDtFhNS0b2eJLio8CkweC70YVTphaQfuJEU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Vpr3ZUUl0/TniQan8cJqPD6x3Oz8ybxybNG8fNsR3YC5ZrOrce1ctbzRcxQMLRSKZbWEU1/98H27sEO6E5ZaG00CfJCfEWdnbUJ1oDwlYcL6TrDtxZO1FfCfzRNHTRkd7JfYGm4mPOobBtVKyg3nOsKOuUwvLIJ07aG/IfUylk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTw4RXAV; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5389e24a4d1so5798820e87.3;
        Mon, 07 Oct 2024 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728326054; x=1728930854; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dO8DmCF1ZmLSeDrY9cPbpgugcDiKxCdJ592xu9WHdcI=;
        b=UTw4RXAVsF8zYgUsor0aEQ32FFXenYoecAPtVoKNLt7AVswZlFR6GEY/WQ3W29VuOh
         WbBoSkDM2WVatWkOu7wRay3LLOZ1ENuiDXDcuKLddX04wek5DwlGCnSGwbmM/ugE4cdD
         xl60aTJUq2MCnpS1mPgnvkiaWyAhHjASNJywAyfcbe7VY9HU4/q0dI19FzJl3JU4w/JL
         pDq8QhxiZlpF3AZJIB8Ow5btbqEY7BrbM0GtPPgszFYDBXmpJKDRf9I2H35fXDxemQKM
         3NBj0h9DrHNdZndaRHqHLTJvdWH6sh3k1fjO9JZVBucxOL+wJlnSRUAVuLNi3NLAfyKX
         AjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728326054; x=1728930854;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dO8DmCF1ZmLSeDrY9cPbpgugcDiKxCdJ592xu9WHdcI=;
        b=iI1NyRFvwCc0SQhaxCsNeS6szzCEP/w7JIW7D5QZgm2c1Bu0CNXx5YiKwX26uT0NUc
         59SrAtVl5xghkfviepyepYGIydbFzLstHqhScqTPw+7RyUFXBExQuJQegeh30IpdY9x2
         frqGQT056OzSJpDR6AFoGpaKJinO/QV1KVwkNrypZgoCniobkG9E+HdcVeNgfyDn1kBq
         CCttkItztHCF61AXXlIyznHjNXev3qKx3zYy9ruRCMu9bmDbrkWMELJBi6QSebpRWQ3v
         iquqJa7gYSJhMrDEWz5wBjHuebkNMblLZs5PWGWUn8n/4q+1bhctQahHpc1Jotl3hSQF
         DBNw==
X-Forwarded-Encrypted: i=1; AJvYcCUB+N4rALD689R75zIqYm3tTHXBqfbFxcysnbmmonySmdOtkQoeybXDudd01CuYqXPE/kKnB3/V1wwGHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkjfGXaLQfSmjvXCU8+TRuTaADaVAtUXcYuuFSoP/Z1vwKObL
	2Xgr3GY3D9SkXo8Ox4lTaWQFgwJQ8nAcaGR2IHEvGUuaBcMokN5vH49iLg==
X-Google-Smtp-Source: AGHT+IHVnqlhUAvuG4dqmwDdBCX80tBEfkMiJ9w0UoxTBmUTR9IB7lYywyCBOrJ5q3nSrsrNjyesuA==
X-Received: by 2002:a05:6512:3b21:b0:535:45d2:abf0 with SMTP id 2adb3069b0e04-539ab8adcb6mr6017463e87.39.1728326054077;
        Mon, 07 Oct 2024 11:34:14 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a12d:4f00:a884:c611:9e1:3345? (dynamic-2a02-3100-a12d-4f00-a884-c611-09e1-3345.310.pool.telefonica.de. [2a02:3100:a12d:4f00:a884:c611:9e1:3345])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99309aa6afsm400953766b.112.2024.10.07.11.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 11:34:13 -0700 (PDT)
Message-ID: <f1658894-4c46-447a-80e6-153c8b788d71@gmail.com>
Date: Mon, 7 Oct 2024 20:34:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v2] r8169: add support for the temperature sensor
 being available from RTL8125B
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This adds support for the temperature sensor being available from
RTL8125B. Register information was taken from r8125 vendor driver.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- don't omit identifiers in definition of r8169_hwmon_is_visible()
---
 drivers/net/ethernet/realtek/r8169_main.c | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 305ec19cc..6a9259d85 100644
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
@@ -5363,6 +5364,43 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	return false;
 }
 
+static umode_t r8169_hwmon_is_visible(const void *drvdata,
+				      enum hwmon_sensor_types type,
+				      u32 attr, int channel)
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
@@ -5537,6 +5575,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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



