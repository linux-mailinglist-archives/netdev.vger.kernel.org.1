Return-Path: <netdev+bounces-71058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2BB851D30
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 19:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E639E284A1D
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF6D4653C;
	Mon, 12 Feb 2024 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER6pi4DB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B920D45C12
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763453; cv=none; b=kL8pfg+r6AJsZZ+J5SIKQ3271jwRHOSvBL9crOLxjsKRCffSS1vyMPaRWJcY4YhlYiopB0b5zLID3FoxTPgvS8SRj15o08+Q6jE5sEidnehXn6kVfXDAYBFNLygurUDOSfqmsLht2py8/opIRMziGZx/UqZXqi4He+vIwTGFpik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763453; c=relaxed/simple;
	bh=7gy1/MhwfQslp6t9BgtTWqR9LBBJdksqBhpRcUNBrjk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fHBoHArR1VjKfj9m3PSxwqp2GO8anyhF8MYQMyCLKMwefLutZ2zCIA59CpmrGRTVaRj9dpQYJDhGp6HOASnZNw/GjdiHS1QFW5wQ3KHgGRvEfc9DoayrrKCvxPYvGErzqnwCAt/K19XlX/Tdap9t9fyM+pXdsfHclxauJTpR6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER6pi4DB; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0d799b55cso44067451fa.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 10:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707763450; x=1708368250; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMgiCrKmuo3+lVfc6UxIcaBTOwNRJdVSWOt7YipESio=;
        b=ER6pi4DBODQKRUz7O03kBaPwHsBHUSF+KWx4k2haDlVT4p+NOlO1FKfPeMeWGrjHxz
         BylGGdCzMhHawtzYJqxVfHsqr53WM17f97LjWcEGePgW5/NYlM8gLbPlkruXZdc1nHPe
         tt0qsTwwk/TTFLrjcyuebhw4KQvaKypSTYHEkS8/FtIFe2o0WUMVVvF5kjZ3Hm3ExCBs
         ujhiK99en59oA2lMOiY2Hn/S+7cWl3MGXMLdjU6vm4s5IUSgR55yXv4OxaeVfUtI0ge/
         WzB8jkxpx+pdAl8tRjPf2ggONIe1KEBSTYwc93hd6ywLD6N7WG5KUvnYLsQUCQcEHQ6Z
         GEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763450; x=1708368250;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMgiCrKmuo3+lVfc6UxIcaBTOwNRJdVSWOt7YipESio=;
        b=Y7KNCDl7RAlDlbA9+MBsgRjszYyOyBSEjlAYvZLbabe01EUFw2EG1a0okDx4v4t29I
         jLX5f+b/uIBjCDmrmfMouoMvLW0rnt9ywbo9ysSFvYDcvq8J0Vak8Jvx+9YWuANLxH4C
         ka8OU6JNwZEhvy8o6MPV0VdCIwh84FW7PrZY9369/HRZ8n7yEo+V2jHHeUppgE/qWumo
         vv3OIdHZzDcHzYGU813f7CPxbX/x90L3E2S5modKPtVtsOnh2C2rztWqTzmEHnPY2wvn
         lMaqolkdbaJWmfzwI7daEYs8/2WCgXOWdTAnYjPwp95JicpXV9kOqRC0OpBClxtfxJ5u
         bPfw==
X-Gm-Message-State: AOJu0Yy6kAfkIDXm2krzT5MovijnYdy3pRs5ybbzBgDAVjRCcbQKjyeD
	KdAPmXGnh5POehRlnWFdRVEcziu/DdF5vD/PKNxlCLwYR8UynpCi
X-Google-Smtp-Source: AGHT+IHfP9kZXKPH2A96rjKqmH7+5MRrfP+hzJzVZfT5whA5tT2YjJY2n+Tsq+wVPeHPs7z0xEJlUg==
X-Received: by 2002:a05:651c:2006:b0:2d0:69b1:b44b with SMTP id s6-20020a05651c200600b002d069b1b44bmr4483780ljo.19.1707763449472;
        Mon, 12 Feb 2024 10:44:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVD2Ff6yQ+gJrxTqj0500z6pM15kuDhC7/ggaJi6rugC3yj9jZCP7pb5qS83SipGYEMwSYjHDPaGF/XESV+92dZmTsF+wXhY+fMiNT6UZgIT5JhXjM47BYreUTLkBNZmWtL5hbo3qxP3nbSEllsB++gsjlrjY7MtRgneRDl
Received: from ?IPV6:2a01:c22:778f:2300:f4de:66ea:cd50:b2c7? (dynamic-2a01-0c22-778f-2300-f4de-66ea-cd50-b2c7.c22.pool.telefonica.de. [2a01:c22:778f:2300:f4de:66ea:cd50:b2c7])
        by smtp.googlemail.com with ESMTPSA id ec13-20020a0564020d4d00b00561ca6046b3sm761125edb.31.2024.02.12.10.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 10:44:09 -0800 (PST)
Message-ID: <f982602c-9de3-4ca6-85a3-2c1d118dcb15@gmail.com>
Date: Mon, 12 Feb 2024 19:44:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: add LED support for RTL8125/RTL8126
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This adds LED support for RTL8125/RTL8126.

Note: Due to missing datasheets changing the 5Gbps link mode isn't
supported for RTL8126.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.h      |   3 +
 drivers/net/ethernet/realtek/r8169_leds.c | 106 ++++++++++++++++++++++
 drivers/net/ethernet/realtek/r8169_main.c |  61 ++++++++++++-
 3 files changed, 166 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index c921456ed..4c0430521 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -85,3 +85,6 @@ void r8169_get_led_name(struct rtl8169_private *tp, int idx,
 int rtl8168_get_led_mode(struct rtl8169_private *tp);
 int rtl8168_led_mod_ctrl(struct rtl8169_private *tp, u16 mask, u16 val);
 void rtl8168_init_leds(struct net_device *ndev);
+int rtl8125_get_led_mode(struct rtl8169_private *tp, int index);
+int rtl8125_set_led_mode(struct rtl8169_private *tp, int index, u16 mode);
+void rtl8125_init_leds(struct net_device *ndev);
diff --git a/drivers/net/ethernet/realtek/r8169_leds.c b/drivers/net/ethernet/realtek/r8169_leds.c
index 78078eca3..7c5dc9d0d 100644
--- a/drivers/net/ethernet/realtek/r8169_leds.c
+++ b/drivers/net/ethernet/realtek/r8169_leds.c
@@ -18,7 +18,14 @@
 #define RTL8168_LED_CTRL_LINK_100	BIT(1)
 #define RTL8168_LED_CTRL_LINK_10	BIT(0)
 
+#define RTL8125_LED_CTRL_ACT		BIT(9)
+#define RTL8125_LED_CTRL_LINK_2500	BIT(5)
+#define RTL8125_LED_CTRL_LINK_1000	BIT(3)
+#define RTL8125_LED_CTRL_LINK_100	BIT(1)
+#define RTL8125_LED_CTRL_LINK_10	BIT(0)
+
 #define RTL8168_NUM_LEDS		3
+#define RTL8125_NUM_LEDS		4
 
 struct r8169_led_classdev {
 	struct led_classdev led;
@@ -156,3 +163,102 @@ void rtl8168_init_leds(struct net_device *ndev)
 	for (i = 0; i < RTL8168_NUM_LEDS; i++)
 		rtl8168_setup_ldev(leds + i, ndev, i);
 }
+
+static int rtl8125_led_hw_control_is_supported(struct led_classdev *led_cdev,
+					       unsigned long flags)
+{
+	struct r8169_led_classdev *ldev = lcdev_to_r8169_ldev(led_cdev);
+	struct rtl8169_private *tp = netdev_priv(ldev->ndev);
+
+	if (!r8169_trigger_mode_is_valid(flags)) {
+		/* Switch LED off to indicate that mode isn't supported */
+		rtl8125_set_led_mode(tp, ldev->index, 0);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int rtl8125_led_hw_control_set(struct led_classdev *led_cdev,
+				      unsigned long flags)
+{
+	struct r8169_led_classdev *ldev = lcdev_to_r8169_ldev(led_cdev);
+	struct rtl8169_private *tp = netdev_priv(ldev->ndev);
+	u16 mode = 0;
+
+	if (flags & BIT(TRIGGER_NETDEV_LINK_10))
+		mode |= RTL8125_LED_CTRL_LINK_10;
+	if (flags & BIT(TRIGGER_NETDEV_LINK_100))
+		mode |= RTL8125_LED_CTRL_LINK_100;
+	if (flags & BIT(TRIGGER_NETDEV_LINK_1000))
+		mode |= RTL8125_LED_CTRL_LINK_1000;
+	if (flags & BIT(TRIGGER_NETDEV_LINK_2500))
+		mode |= RTL8125_LED_CTRL_LINK_2500;
+	if (flags & (BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX)))
+		mode |= RTL8125_LED_CTRL_ACT;
+
+	return rtl8125_set_led_mode(tp, ldev->index, mode);
+}
+
+static int rtl8125_led_hw_control_get(struct led_classdev *led_cdev,
+				      unsigned long *flags)
+{
+	struct r8169_led_classdev *ldev = lcdev_to_r8169_ldev(led_cdev);
+	struct rtl8169_private *tp = netdev_priv(ldev->ndev);
+	int mode;
+
+	mode = rtl8125_get_led_mode(tp, ldev->index);
+	if (mode < 0)
+		return mode;
+
+	if (mode & RTL8125_LED_CTRL_LINK_10)
+		*flags |= BIT(TRIGGER_NETDEV_LINK_10);
+	if (mode & RTL8125_LED_CTRL_LINK_100)
+		*flags |= BIT(TRIGGER_NETDEV_LINK_100);
+	if (mode & RTL8125_LED_CTRL_LINK_1000)
+		*flags |= BIT(TRIGGER_NETDEV_LINK_1000);
+	if (mode & RTL8125_LED_CTRL_LINK_2500)
+		*flags |= BIT(TRIGGER_NETDEV_LINK_2500);
+	if (mode & RTL8125_LED_CTRL_ACT)
+		*flags |= BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX);
+
+	return 0;
+}
+
+static void rtl8125_setup_led_ldev(struct r8169_led_classdev *ldev,
+				   struct net_device *ndev, int index)
+{
+	struct rtl8169_private *tp = netdev_priv(ndev);
+	struct led_classdev *led_cdev = &ldev->led;
+	char led_name[LED_MAX_NAME_SIZE];
+
+	ldev->ndev = ndev;
+	ldev->index = index;
+
+	r8169_get_led_name(tp, index, led_name, LED_MAX_NAME_SIZE);
+	led_cdev->name = led_name;
+	led_cdev->hw_control_trigger = "netdev";
+	led_cdev->flags |= LED_RETAIN_AT_SHUTDOWN;
+	led_cdev->hw_control_is_supported = rtl8125_led_hw_control_is_supported;
+	led_cdev->hw_control_set = rtl8125_led_hw_control_set;
+	led_cdev->hw_control_get = rtl8125_led_hw_control_get;
+	led_cdev->hw_control_get_device = r8169_led_hw_control_get_device;
+
+	/* ignore errors */
+	devm_led_classdev_register(&ndev->dev, led_cdev);
+}
+
+void rtl8125_init_leds(struct net_device *ndev)
+{
+	/* bind resource mgmt to netdev */
+	struct device *dev = &ndev->dev;
+	struct r8169_led_classdev *leds;
+	int i;
+
+	leds = devm_kcalloc(dev, RTL8125_NUM_LEDS, sizeof(*leds), GFP_KERNEL);
+	if (!leds)
+		return;
+
+	for (i = 0; i < RTL8125_NUM_LEDS; i++)
+		rtl8125_setup_led_ldev(leds + i, ndev, i);
+}
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index b43db3c49..9fdc9b0f3 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -330,17 +330,23 @@ enum rtl8168_registers {
 };
 
 enum rtl8125_registers {
+	LEDSEL0			= 0x18,
 	INT_CFG0_8125		= 0x34,
 #define INT_CFG0_ENABLE_8125		BIT(0)
 #define INT_CFG0_CLKREQEN		BIT(3)
 	IntrMask_8125		= 0x38,
 	IntrStatus_8125		= 0x3c,
 	INT_CFG1_8125		= 0x7a,
+	LEDSEL2			= 0x84,
+	LEDSEL1			= 0x86,
 	TxPoll_8125		= 0x90,
+	LEDSEL3			= 0x96,
 	MAC0_BKP		= 0x19e0,
 	EEE_TXIDLE_TIMER_8125	= 0x6048,
 };
 
+#define LEDSEL_MASK_8125	0x23f
+
 #define RX_VLAN_INNER_8125	BIT(22)
 #define RX_VLAN_OUTER_8125	BIT(23)
 #define RX_VLAN_8125		(RX_VLAN_INNER_8125 | RX_VLAN_OUTER_8125)
@@ -830,6 +836,51 @@ int rtl8168_get_led_mode(struct rtl8169_private *tp)
 	return ret;
 }
 
+static int rtl8125_get_led_reg(int index)
+{
+	static const int led_regs[] = { LEDSEL0, LEDSEL1, LEDSEL2, LEDSEL3 };
+
+	return led_regs[index];
+}
+
+int rtl8125_set_led_mode(struct rtl8169_private *tp, int index, u16 mode)
+{
+	int reg = rtl8125_get_led_reg(index);
+	struct device *dev = tp_to_dev(tp);
+	int ret;
+	u16 val;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&tp->led_lock);
+	val = RTL_R16(tp, reg) & ~LEDSEL_MASK_8125;
+	RTL_W16(tp, reg, val | mode);
+	mutex_unlock(&tp->led_lock);
+
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
+int rtl8125_get_led_mode(struct rtl8169_private *tp, int index)
+{
+	int reg = rtl8125_get_led_reg(index);
+	struct device *dev = tp_to_dev(tp);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = RTL_R16(tp, reg);
+
+	pm_runtime_put_sync(dev);
+
+	return ret;
+}
+
 void r8169_get_led_name(struct rtl8169_private *tp, int idx,
 			char *buf, int buf_len)
 {
@@ -5388,10 +5439,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	if (IS_ENABLED(CONFIG_R8169_LEDS) &&
-	    tp->mac_version > RTL_GIGA_MAC_VER_06 &&
-	    tp->mac_version < RTL_GIGA_MAC_VER_61)
-		rtl8168_init_leds(dev);
+	if (IS_ENABLED(CONFIG_R8169_LEDS)) {
+		if (rtl_is_8125(tp))
+			rtl8125_init_leds(dev);
+		else if (tp->mac_version > RTL_GIGA_MAC_VER_06)
+			rtl8168_init_leds(dev);
+	}
 
 	netdev_info(dev, "%s, %pM, XID %03x, IRQ %d\n",
 		    rtl_chip_infos[chipset].name, dev->dev_addr, xid, tp->irq);
-- 
2.43.0


