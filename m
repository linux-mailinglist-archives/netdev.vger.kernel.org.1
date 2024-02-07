Return-Path: <netdev+bounces-69726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823B984C584
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 08:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE861F23C2E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 07:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9481CFBC;
	Wed,  7 Feb 2024 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1ybhTEk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7BB200A8
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290203; cv=none; b=ZrQCpwb9S915X2axTbaq8bRSkLTWwM9PULQbgpp0NhnXfGJ8NOW0P0A+2PMZglreujguRtHZpiiKP83eEQ2wLUJTYExCJFSNYwWNixi55bfzw5FnMioJKwWqlGOPk2RjZTJw7iFC5Vj4mq2t+lt/aPfp1YODyUaBzUIqKh+jIks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290203; c=relaxed/simple;
	bh=26xeSa7sP4t/TtyAW6VrLQob5iC1bN+qVFhJuCnBOmg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=r/HI6yVNVeCVxFVcDnEHZ2JoFcueh69kyfGyJfBQ/ze8/wJqiOeoKQfFwnsJFf4rutl5Ry69iG82cJSBQyUT4LGLMj11AjEOR2Pw5dt8kWsu4IJt/IOfRVMvNTnO9Ul7JIwfpVR1JtE331LkNgEuPZQhPxLErYNJytUoW57efew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1ybhTEk; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3884b1a441so13614066b.2
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 23:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707290200; x=1707895000; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdkiH/WZUSE1m65pkhmqy7y5DpThlA2r/cwVsig9LNE=;
        b=H1ybhTEkK2sFfG+3C3rf2An5c8YrDNsnZdzAq3IZKAeD13xY6WsZRCT7F2l7Vz/bjW
         lq0b4STLcbLrdk2xCo6IYFdFMPH1nuyF9SCqWScHL2rSGJat4Elsgqz1+mKJ7EAntrk3
         UzZkioNPcZ21SEvR9ibBKcqCX+QB3jdDpF86KrBDd+7Hi0jzbxMJSQgK+R4D3ac2xW+L
         a8XxDCEYYFyHbEetdB5a6KAPHNEPq0Gf/iRB5f5MBVedaNj8OBilO92NbGwuYmzR6/H/
         CjqGMxPAGlJaxnyZPgZRhO5CMnIS+ny9/4veRaPOh2/gzL/gsx/rE6DE5jjPsSy8XPhH
         e0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707290200; x=1707895000;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdkiH/WZUSE1m65pkhmqy7y5DpThlA2r/cwVsig9LNE=;
        b=axDEd6Za9XCWuSX4jG2j/c0C/iL8fGbTuATV+QiCua1ahAT1bRZgzfZyg8VPQWTbSt
         HLl/zeRqCSSClUy5odgBRvNgiCMU0LRqyNqTRIFD8RKNSWjMqTHWpJJ0eBQ9VODgW/hu
         y0X6BrUrbByAKlkz/FxHMnmUxCrfEFyrob3ftNsMN/U7W/w6yotX1btXpUnA2GbrOpd+
         8AycrhywkzqX60rpsSlyD2scyMRTTm7S9Tx7tlWZNR/UDGRNT8/s5yBwdhk+sbzhJJHw
         igLzBYfWowvZbuEfaNI/YqAqQb0u0/DORKihO3CWau56UI4stEXQ9BWMSMr6QM/yEvlr
         RRbA==
X-Gm-Message-State: AOJu0Yw7wqp7fai5ruy9fy4igSe+NIxP53uo/y/7lw7IqY+Em/6THo/s
	l8QqYDBXETnoS6K5NUeVlVou+YuJ0rdek8IHUW7EjkCiKRgb8NaC
X-Google-Smtp-Source: AGHT+IGd0rkZNDWTP8Fg26H+75EckUvsxwLeBgCSX88bFD+tiRwzSXJ7552NMkVokvIWAmte1HBttg==
X-Received: by 2002:a17:907:508e:b0:a38:3f63:1ae4 with SMTP id fv14-20020a170907508e00b00a383f631ae4mr1800601ejc.27.1707290200308;
        Tue, 06 Feb 2024 23:16:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvhYzN7i8L6x6mbOZp+l1TrdiWmU0oTj7ypCj2jAWGhTN53pNODFf8MoQ4grWZK/jxp4WnIDVu9v6Oaeld+uDGHKiBgheigcSX6OwHV1UXSDPfMVJ8gk/2rhJc9toEwNJ8ExGhoApEIvGGae4+PcqHLvn/VR+48SFjBTze
Received: from ?IPV6:2a01:c22:76b1:9500:754d:f584:769d:10e? (dynamic-2a01-0c22-76b1-9500-754d-f584-769d-010e.c22.pool.telefonica.de. [2a01:c22:76b1:9500:754d:f584:769d:10e])
        by smtp.googlemail.com with ESMTPSA id st7-20020a170907c08700b00a35cd148c7esm413070ejc.212.2024.02.06.23.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 23:16:39 -0800 (PST)
Message-ID: <8876a9f4-7a2d-48c3-8eae-0d834f5c27c5@gmail.com>
Date: Wed, 7 Feb 2024 08:16:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: improve checking for valid LED modes
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After 3a2746320403 ("leds: trigger: netdev: Display only supported link
speed attribute") the check for valid link modes can be simplified.
In addition factor it out, so that it can be re-used by the upcoming
LED support for RTL8125.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_leds.c | 38 ++++++++++++-----------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_leds.c b/drivers/net/ethernet/realtek/r8169_leds.c
index f082bd7d6..78078eca3 100644
--- a/drivers/net/ethernet/realtek/r8169_leds.c
+++ b/drivers/net/ethernet/realtek/r8169_leds.c
@@ -20,11 +20,6 @@
 
 #define RTL8168_NUM_LEDS		3
 
-#define RTL8168_SUPPORTED_MODES \
-	(BIT(TRIGGER_NETDEV_LINK_1000) | BIT(TRIGGER_NETDEV_LINK_100) | \
-	 BIT(TRIGGER_NETDEV_LINK_10) | BIT(TRIGGER_NETDEV_RX) | \
-	 BIT(TRIGGER_NETDEV_TX))
-
 struct r8169_led_classdev {
 	struct led_classdev led;
 	struct net_device *ndev;
@@ -33,28 +28,35 @@ struct r8169_led_classdev {
 
 #define lcdev_to_r8169_ldev(lcdev) container_of(lcdev, struct r8169_led_classdev, led)
 
+static bool r8169_trigger_mode_is_valid(unsigned long flags)
+{
+	bool rx, tx;
+
+	if (flags & BIT(TRIGGER_NETDEV_HALF_DUPLEX))
+		return false;
+	if (flags & BIT(TRIGGER_NETDEV_FULL_DUPLEX))
+		return false;
+
+	rx = flags & BIT(TRIGGER_NETDEV_RX);
+	tx = flags & BIT(TRIGGER_NETDEV_TX);
+
+	return rx == tx;
+}
+
 static int rtl8168_led_hw_control_is_supported(struct led_classdev *led_cdev,
 					       unsigned long flags)
 {
 	struct r8169_led_classdev *ldev = lcdev_to_r8169_ldev(led_cdev);
 	struct rtl8169_private *tp = netdev_priv(ldev->ndev);
 	int shift = ldev->index * 4;
-	bool rx, tx;
-
-	if (flags & ~RTL8168_SUPPORTED_MODES)
-		goto nosupp;
 
-	rx = flags & BIT(TRIGGER_NETDEV_RX);
-	tx = flags & BIT(TRIGGER_NETDEV_TX);
-	if (rx != tx)
-		goto nosupp;
+	if (!r8169_trigger_mode_is_valid(flags)) {
+		/* Switch LED off to indicate that mode isn't supported */
+		rtl8168_led_mod_ctrl(tp, 0x000f << shift, 0);
+		return -EOPNOTSUPP;
+	}
 
 	return 0;
-
-nosupp:
-	/* Switch LED off to indicate that mode isn't supported */
-	rtl8168_led_mod_ctrl(tp, 0x000f << shift, 0);
-	return -EOPNOTSUPP;
 }
 
 static int rtl8168_led_hw_control_set(struct led_classdev *led_cdev,
-- 
2.43.0


