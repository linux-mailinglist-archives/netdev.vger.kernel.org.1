Return-Path: <netdev+bounces-85885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF289CBF0
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 20:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3DA1F28930
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 18:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60DC145326;
	Mon,  8 Apr 2024 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SM54dAdQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A931D144D1A
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602063; cv=none; b=gi2neALzO5Xoam55bSwQS5xcyJcd8C+8+L0oFO30YwXMHchwsdl5TZwQt3uJazTEuiWfjczbc9zLclkBe7d7tx95soPvvlCC7T/wLckbYLDSDwG4exWydOZc+v9H1Rqlvi+JAiULJeR/CPDm6IEBZOIFgEMyBEFZAMNwG3wg/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602063; c=relaxed/simple;
	bh=kl1Wd41mtNKmv/m9ugGl3ikLThZ5KPtqnY0vhvfD0rc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MzqzCqrvUc6Y7Y/oCUbFvLkaqLKDzR70gqyPUmNccp7ezCPkbfm7uLICTpN9ePX5iHbXwNOv7vOhT9l5DE4+PIZjSNYCk7kPbjcYPq+omWgXmlS4WjqY8NEC//ZRuei3MrWWtZ/KXHGtLP1xfZkXmjiy6bN/+bMw28hoWkeg9l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SM54dAdQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a51a7d4466bso377616466b.2
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 11:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712602060; x=1713206860; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTSbfFyNm8pYH99fEKpgyCQOlDZhpnhJX0UQHA+1dXo=;
        b=SM54dAdQYZmE/gJc8YBdOELdhu0WyWugJQCiWMtrCvvA0XZS04yaCvZNOH+UjtoQP4
         cwMinGRu+Dzbcq/Ze8gwYTiV4l+pJp5bAF4o7uklgcuaD0TrLQQGhe8DDT6E9HqKQFZ8
         VJRkoHYbuKuEfebTWDdByY2oP/HzbA4mfWpg1T6rP9RS/S4BDX+TesP4LozuJtFXiqwF
         grkXJ1qhlTliT+hChGCUC77V8QVM4D5l9aVz14HwySFv4md01E1YlVKw61m0uf4iLrFw
         g3v7fFONbv5IrCGdJQdPBGvN11uD46l3DcQov8DLjIt0RJcPh0+h9e1GP6fphnOOv5L0
         i6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712602060; x=1713206860;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTSbfFyNm8pYH99fEKpgyCQOlDZhpnhJX0UQHA+1dXo=;
        b=tIs6utlKbxHU8576zkhDBaDXLjZZFZA8tSH5SBoE6esT1zvkTSpo7DLwyK6W6zsrHC
         PNBlvaQEatweZlUJH6L9aQ2iM8TWlC0SOStGXWsdv+Z+s6Auv8EQfSKNn5CmHbvRt++D
         sp7wg2NcMslNd+dHDY9hlsQRCguko7zQFQSoIZA2CIGXycMOl0yrQ91I4pUelJeJIU+f
         QIT4f2uXC7MvCboojh3z+ypGxGfYaV0aySAEkrwLAe4NRys+kjRiyKjB6dVxc9BLPjS7
         skxwY46/VqklTYm0uxMg/BrsqW+EnfNjxLnOU59sXQ6hT3dEiqR/dJlR/kMUi4omBtSh
         Yjdg==
X-Forwarded-Encrypted: i=1; AJvYcCWwHl8Gpozj0kFe0saQFKgT3hED+c8thDdH5iRpdJ4t9PUV2Q/2bhuVGN+mib/SgBr3j/uqKzlFvADmiArqQ60U2NncqS+q
X-Gm-Message-State: AOJu0YyM6rR/WYPiZC7frhrBr2EUDXj7dUu3SHk4kKQEZZ5ygc+EwVbM
	xuKbtZ7W3Z/ReGnLudh0CbbgIPZ6JrMSG3JdUAfthyPHmaAkEzSiLYllcDWj
X-Google-Smtp-Source: AGHT+IG602HCKQ+IESFJHpfCcd0CCb6mW40imGVnsciYdTNKVFwDUSOd0wZiTSuZA4gejKAQuU+ekQ==
X-Received: by 2002:a17:907:1b03:b0:a51:db9e:4cce with SMTP id mp3-20020a1709071b0300b00a51db9e4ccemr2229746ejc.3.1712602059633;
        Mon, 08 Apr 2024 11:47:39 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c089:d500:a874:5bd3:c0b7:2ae1? (dynamic-2a01-0c23-c089-d500-a874-5bd3-c0b7-2ae1.c23.pool.telefonica.de. [2a01:c23:c089:d500:a874:5bd3:c0b7:2ae1])
        by smtp.googlemail.com with ESMTPSA id cw23-20020a170906c79700b00a51bf5932aesm3209836ejb.28.2024.04.08.11.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 11:47:39 -0700 (PDT)
Message-ID: <2695e9db-a5a0-4564-9812-a50b91fb1b46@gmail.com>
Date: Mon, 8 Apr 2024 20:47:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: Lukas Wunner <lukas@wunner.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net] r8169: fix LED-related deadlock on module removal
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Binding devm_led_classdev_register() to the netdev is problematic
because on module removal we get a RTNL-related deadlock. Fix this
by avoiding the device-managed LED functions.

Note: We can safely call led_classdev_unregister() for a LED even
if registering it failed, because led_classdev_unregister() detects
this and is a no-op in this case.

Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/RTL8101")
Cc: stable@vger.kernel.org
Reported-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- avoid using device-managed functions
---
 drivers/net/ethernet/realtek/r8169.h      |  6 ++--
 drivers/net/ethernet/realtek/r8169_leds.c | 35 +++++++++++++++--------
 drivers/net/ethernet/realtek/r8169_main.c |  8 ++++--
 3 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 4c0430521..00882ffc7 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -73,6 +73,7 @@ enum mac_version {
 };
 
 struct rtl8169_private;
+struct r8169_led_classdev;
 
 void r8169_apply_firmware(struct rtl8169_private *tp);
 u16 rtl8168h_2_get_adc_bias_ioffset(struct rtl8169_private *tp);
@@ -84,7 +85,8 @@ void r8169_get_led_name(struct rtl8169_private *tp, int idx,
 			char *buf, int buf_len);
 int rtl8168_get_led_mode(struct rtl8169_private *tp);
 int rtl8168_led_mod_ctrl(struct rtl8169_private *tp, u16 mask, u16 val);
-void rtl8168_init_leds(struct net_device *ndev);
+struct r8169_led_classdev *rtl8168_init_leds(struct net_device *ndev);
 int rtl8125_get_led_mode(struct rtl8169_private *tp, int index);
 int rtl8125_set_led_mode(struct rtl8169_private *tp, int index, u16 mode);
-void rtl8125_init_leds(struct net_device *ndev);
+struct r8169_led_classdev *rtl8125_init_leds(struct net_device *ndev);
+void r8169_remove_leds(struct r8169_led_classdev *leds);
diff --git a/drivers/net/ethernet/realtek/r8169_leds.c b/drivers/net/ethernet/realtek/r8169_leds.c
index 7c5dc9d0d..e10bee706 100644
--- a/drivers/net/ethernet/realtek/r8169_leds.c
+++ b/drivers/net/ethernet/realtek/r8169_leds.c
@@ -146,22 +146,22 @@ static void rtl8168_setup_ldev(struct r8169_led_classdev *ldev,
 	led_cdev->hw_control_get_device = r8169_led_hw_control_get_device;
 
 	/* ignore errors */
-	devm_led_classdev_register(&ndev->dev, led_cdev);
+	led_classdev_register(&ndev->dev, led_cdev);
 }
 
-void rtl8168_init_leds(struct net_device *ndev)
+struct r8169_led_classdev *rtl8168_init_leds(struct net_device *ndev)
 {
-	/* bind resource mgmt to netdev */
-	struct device *dev = &ndev->dev;
 	struct r8169_led_classdev *leds;
 	int i;
 
-	leds = devm_kcalloc(dev, RTL8168_NUM_LEDS, sizeof(*leds), GFP_KERNEL);
+	leds = kcalloc(RTL8168_NUM_LEDS + 1, sizeof(*leds), GFP_KERNEL);
 	if (!leds)
-		return;
+		return NULL;
 
 	for (i = 0; i < RTL8168_NUM_LEDS; i++)
 		rtl8168_setup_ldev(leds + i, ndev, i);
+
+	return leds;
 }
 
 static int rtl8125_led_hw_control_is_supported(struct led_classdev *led_cdev,
@@ -245,20 +245,31 @@ static void rtl8125_setup_led_ldev(struct r8169_led_classdev *ldev,
 	led_cdev->hw_control_get_device = r8169_led_hw_control_get_device;
 
 	/* ignore errors */
-	devm_led_classdev_register(&ndev->dev, led_cdev);
+	led_classdev_register(&ndev->dev, led_cdev);
 }
 
-void rtl8125_init_leds(struct net_device *ndev)
+struct r8169_led_classdev *rtl8125_init_leds(struct net_device *ndev)
 {
-	/* bind resource mgmt to netdev */
-	struct device *dev = &ndev->dev;
 	struct r8169_led_classdev *leds;
 	int i;
 
-	leds = devm_kcalloc(dev, RTL8125_NUM_LEDS, sizeof(*leds), GFP_KERNEL);
+	leds = kcalloc(RTL8125_NUM_LEDS + 1, sizeof(*leds), GFP_KERNEL);
 	if (!leds)
-		return;
+		return NULL;
 
 	for (i = 0; i < RTL8125_NUM_LEDS; i++)
 		rtl8125_setup_led_ldev(leds + i, ndev, i);
+
+	return leds;
+}
+
+void r8169_remove_leds(struct r8169_led_classdev *leds)
+{
+	if (!leds)
+		return;
+
+	for (struct r8169_led_classdev *l = leds; l->ndev; l++)
+		led_classdev_unregister(&l->led);
+
+	kfree(leds);
 }
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index fc8e6771e..06631a0d6 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -647,6 +647,8 @@ struct rtl8169_private {
 	const char *fw_name;
 	struct rtl_fw *rtl_fw;
 
+	struct r8169_led_classdev *leds;
+
 	u32 ocp_base;
 };
 
@@ -5044,6 +5046,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
 
 	cancel_work_sync(&tp->wk.work);
 
+	r8169_remove_leds(tp->leds);
+
 	unregister_netdev(tp->dev);
 
 	if (tp->dash_type != RTL_DASH_NONE)
@@ -5501,9 +5505,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (IS_ENABLED(CONFIG_R8169_LEDS)) {
 		if (rtl_is_8125(tp))
-			rtl8125_init_leds(dev);
+			tp->leds = rtl8125_init_leds(dev);
 		else if (tp->mac_version > RTL_GIGA_MAC_VER_06)
-			rtl8168_init_leds(dev);
+			tp->leds = rtl8168_init_leds(dev);
 	}
 
 	netdev_info(dev, "%s, %pM, XID %03x, IRQ %d\n",
-- 
2.44.0


