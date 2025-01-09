Return-Path: <netdev+bounces-156878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AEEA082C2
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 23:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8290D3A7F8B
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 22:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F306205AD7;
	Thu,  9 Jan 2025 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnRyKWQC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E391205E10
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736461757; cv=none; b=icbu4E3xDSw4EJWaEyOGtQSZJy74Xtu1f/qGZeUuDeDVLkRochhPxQCL/9+HZir18zXMCRdxVa/TDE9O0wcJHoP6y+7YGORIe67stRC2pkRatMQEuU8lokLESOwCUK/FGI2P6t5AGIught3aW1l3ik0hk3YbaTDl6cwGI+/szmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736461757; c=relaxed/simple;
	bh=mpQjfd9pPF7b9388bvXKIjwok27jOmoOLEeYBTaBl+4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=C0TYIllncrnOWZJ0Nv9F/GC+x+2qET9cCu2J2nXkSjaob9x55qNEK4Yl8g1phGUKmjprpqP8rdhjfV1ifB7K6uaxG1EOLwd+oXAvaDhOauNC4+WTUKB/W1Ho0KF99cuFywzrqOa4G3qJIIOQ/0rjxI/x/OfLyki9YXroIPH4WL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnRyKWQC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aae81f4fdc4so301494366b.0
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 14:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736461752; x=1737066552; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FatX4CPnxNFSVZ+zDZENcJO7T5TZonGlKafDbem7Zzs=;
        b=SnRyKWQCjoIMUeb6+nvUOzvnhcjfGLASHj2bAFfkF+IeNwFNlMj+IA06evgxjJ/r8H
         6toYJcMyLrqL9E1JuDKgDPt9yffX6++nphjBNtw6HPNPitANhYsXLsGQV9P76LcOJm2w
         WYK4kq+Z0wNrkeXXqwH4ACphMHr77pRKp4lQyDwvPhkE34c5b+k2NWxiv1Z37sw8nL6V
         pwbJEMc4okZBTb1Xp4Yk9OW+gKGFPnA8B3jNAL9GoZwM5uZB2O7Mhtz8bOHcbsywPHgc
         ldO8WnIRRSztxFeMGr9LfieZgkLT67RD6Uz4JhK/jRvCWSfDqfWlHkAs2kqqQuNWR5aS
         HgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736461752; x=1737066552;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FatX4CPnxNFSVZ+zDZENcJO7T5TZonGlKafDbem7Zzs=;
        b=fFAtCf+U7cz4s0JFHXj2fVnha4jHREjLiY6USZlcnEL75iip8F38VK1QDS/kydDXv2
         mA+9QbHm50RfZBk+n0Y/RRrP+32oykPZDK9MBI5G3a9m59A3FD8i9mXyycVPT9jIUQkt
         KvUSi8LUPZKZ5AlbMwmrSx+th/OJNd6phChuBr2QcgMJ1/wGAR76qtaRfgVhsfCF0Mwx
         PlctlTZcSzVfUO05QpfSErOx1aWNNn4Al7+EMHv2c0ZzYkL4yGL0oz2kP+KK7o7pg7Qv
         zcZOh+I33d01TWsmRTIm8PjwyKepxj1s9dBpOxlcZgnfRH8BUbPAP+XxMhIbMaWN6JF0
         durQ==
X-Gm-Message-State: AOJu0YxLrqYpSNCwJlpai4ClqUI5+IkfJvdSiJqSf2UTzIQQpj6K5pMy
	pLpsGAcdtz2j7DEiSO0FsSOrdXtVfHP0Lj6Z3DB5COXzdQ9Y7qH8
X-Gm-Gg: ASbGnctI7BU9oG7xQSrK8w3vF24Gk4COswmXZiykMJ/AA9PvvIMWyUSdmmFvaqAGEmB
	YK/S3tiS8xAE7AIyaGJqLO4hg3FC/i5WeAabo+R0ln2f/jXUNjvYMbvrZCv5bQnXeRvWree+ByF
	shs6/AiX4X7B8yauWnRZD3x7JeEmwRMo2yzT8ANKAuXVFd1JYk8lNM1LvaJx3AvtUJQhggC9OIJ
	M3iRD7yl2nGsmI5vJAO8qXK1RNLn5Xkg7omXeQDZoRnLjSiOD0GMxLoJ+Rm+zkql6aHH+SmFHZ5
	rBpO1gJV/xOAimyipJcZl0xNwc/+uTfTIMjDltUnseZiWEjjZ+giE/tfgkbDotKBa0U11rw3dL1
	UtkjxlJFksVCZlPIs5mAmNEKc6Boj/NkzmMdkJMrrjdf2RMGm
X-Google-Smtp-Source: AGHT+IH+v3kiMvqbNg1o35xdYTcKk4Z1sDWGjp8bPWMTguinHqT679jzOXOayStL0RuOjaGg96wr/A==
X-Received: by 2002:a17:907:988:b0:aa6:715a:75b5 with SMTP id a640c23a62f3a-ab2abcababdmr814822566b.46.1736461751657;
        Thu, 09 Jan 2025 14:29:11 -0800 (PST)
Received: from ?IPV6:2a02:3100:ac5c:5700:44f4:3326:ed45:6e1e? (dynamic-2a02-3100-ac5c-5700-44f4-3326-ed45-6e1e.310.pool.telefonica.de. [2a02:3100:ac5c:5700:44f4:3326:ed45:6e1e])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c95aedf6sm111101366b.138.2025.01.09.14.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 14:29:10 -0800 (PST)
Message-ID: <357e6526-ee3e-4e66-b556-7364fdcb2bfc@gmail.com>
Date: Thu, 9 Jan 2025 23:29:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net] r8169: remove redundant hwmon support
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The temperature sensor is actually part of the integrated PHY and available
also on the standalone versions of the PHY. Therefore hwmon support will
be added to the Realtek PHY driver and can be removed here.

Fixes: 1ffcc8d41306 ("r8169: add support for the temperature sensor being available from RTL8125B")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 37 -----------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5724f650f..7b9ba91c3 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -16,7 +16,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/ethtool.h>
-#include <linux/hwmon.h>
 #include <linux/phy.h>
 #include <linux/if_vlan.h>
 #include <linux/in.h>
@@ -5338,36 +5337,6 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	return false;
 }
 
-static int r8169_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
-			    u32 attr, int channel, long *val)
-{
-	struct rtl8169_private *tp = dev_get_drvdata(dev);
-	int val_raw;
-
-	val_raw = phy_read_paged(tp->phydev, 0xbd8, 0x12) & 0x3ff;
-	if (val_raw >= 512)
-		val_raw -= 1024;
-
-	*val = 1000 * val_raw / 2;
-
-	return 0;
-}
-
-static const struct hwmon_ops r8169_hwmon_ops = {
-	.visible = 0444,
-	.read = r8169_hwmon_read,
-};
-
-static const struct hwmon_channel_info * const r8169_hwmon_info[] = {
-	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
-	NULL
-};
-
-static const struct hwmon_chip_info r8169_hwmon_chip_info = {
-	.ops = &r8169_hwmon_ops,
-	.info = r8169_hwmon_info,
-};
-
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct rtl8169_private *tp;
@@ -5547,12 +5516,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	/* The temperature sensor is available from RTl8125B */
-	if (IS_REACHABLE(CONFIG_HWMON) && tp->mac_version >= RTL_GIGA_MAC_VER_63)
-		/* ignore errors */
-		devm_hwmon_device_register_with_info(&pdev->dev, "nic_temp", tp,
-						     &r8169_hwmon_chip_info,
-						     NULL);
 	rc = register_netdev(dev);
 	if (rc)
 		return rc;
-- 
2.47.1


