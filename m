Return-Path: <netdev+bounces-226924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0282BA6327
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 22:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E9C179FA7
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 20:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B040A1925BC;
	Sat, 27 Sep 2025 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmQT1ms4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9F17C91
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759004591; cv=none; b=jvuzRGt4Lf4OHrOkO0PzbWpQhUpRBQg8ZX4LujiPwdGY72krUXQsUP6StG0BxbOyOY3iQ0bqh5LELuq5zrJqQIfR1rkn/54GHBncTvf7raAA6mrFTnvvvXq8Qa4qaC+Y3es+AQsVUxWmu9i+xXp3W3MDbZOKXTlaZsfqNbBjy1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759004591; c=relaxed/simple;
	bh=ytcwei99temNieJcZDHjblIQuEEEw1T0Z9l9x2ir3rY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=d83liV6/+k4UItodU/oLW4ogMUz9mlsY3KrIwMXxgUZaD23TQIvdWgREXjv7OuI+YyGDRHFh1iygCcWemcjzAn3ftzgsxJ89TUSEiF/gIlPyVQvdjmdgssfeuLSgfnLy8nuagDS9YVRL5omnu+d3w8jhvmhZQK3d9ZkiQ7SRLRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmQT1ms4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so31342315e9.2
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 13:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759004588; x=1759609388; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDudiZbr/4Qj5kMAYyafyLiDyT3HqFCkHPD2XqnSoTM=;
        b=LmQT1ms4SodW5/NXfDm8uhiADsCjCImcSacG/YV4nwXrfJj8ZqykPxSZzNOLNDog2w
         X9hbpk5M4W7+X69899TKqj1b9jExy0G3Lqpf8VIbugjUj8wJoPisc/1ayWGTR+sUC87K
         hippEh1Pge9+kg5ZXTh3kba87mfDDpqlpLfkUiGKLVs1v7VHSXydfCcMKfEx2Z9JEzJx
         R9wcxaNHftI8pNBc21sO98zXxzpv8sjz128MYU37My1wRuiFeEqjCValVhmBQDsj43Qu
         sVBy31rqJRgovPRp5sbqKy8csKP+1KKENwVjDREs6Xz8WAmZbUc73Sqwe0zlkzqh7QaM
         xzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759004588; x=1759609388;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDudiZbr/4Qj5kMAYyafyLiDyT3HqFCkHPD2XqnSoTM=;
        b=Ynuzw7m4mejUNu0rnjTz0s3u84Is3k/pKgXzIT34Om17rUr3D8mUWbgLKfP81cDkDh
         1S5p2etLIAgW7jYrPatxULnhLQbZUcI8xzKSAEbMk/4uA331buo9lr1gEPzamWItD9xW
         fJId5G9h0cHBo+NhH+cJQwjzGl5mDstZfVhRDFM0z6InlLvhqaPGfcj696crblhuToG7
         2T0OkQwUz/XtWcYAD6lVHpAz7EErH1/zkoKnbBKkRgtQQgY5qbOlN8Rpn3KjsfoQNdJX
         ouG1i+VPu2brtUnt91j2+nbivnzOEZPEiiCQCcyZ2h7rB1gGefWdS29oPsjuJdiKX+Iu
         AnXw==
X-Gm-Message-State: AOJu0YwaaHeaIFa2MWmtEJLnDVzPyARxH5JwlRv9iffoIViGRvjJVtDi
	Qklnd5aLiXFgWQA9YQR0Xnzn31ymhqjz3o62K9siUboz6flLbs6FlD7f
X-Gm-Gg: ASbGnctDdws3G94k4d9Y3bOXxjEehZaiii7QIOxfQ0KDXQ1FwDwS8S8CgwhZc9UA8pT
	vFf43iVOeOjZPE8S7/3lKnh2eduEgDqXTnc37tT7/Qfbj6cEG3DNJ981+BF7DihfOGGshJN0wBa
	UtY3qwQ5JKDsy31ByXeaD3d59Du94DnPdo2+e/w9nR1BpugKtXmYnKE+CMoyn6zEUSvsIqwEy+R
	D5RZ0PUOhUokdjZus2dqSC+Uv184M3YbVRNV2hHLnpNmchSR+IRe4jsbAFCg9k3rxIMl5eWkJpM
	RhXOpcEQqqhYJ9FhNEXiVp0XXyYnavjSlHF+CJbW/uAzOl3fkQPM8VbJDeiEcEfJotdviDxfy7R
	Sene2p/2O5GNxHG1nm2BgtWPfnNHfafvU7Yaws11jicP6O3mKkVUO/Szt7nrw5p7NoBvyvTHZ6r
	HYz/bOdj+a3CFy0c655u15j68epEwb1ewcbzQ8NJR2Tx1tr+Woo6xQPfsZ5yPF5A==
X-Google-Smtp-Source: AGHT+IEUK3SMiS1UhyJpzTBW3UNujoCpXTvuT/TTVQ6gQ+2UbXOGW44X49EKMxqdS2YTTgIlN6NTtQ==
X-Received: by 2002:a05:600c:1e87:b0:46e:27f7:80ce with SMTP id 5b1f17b1804b1-46e329e51c2mr110368645e9.23.1759004587893;
        Sat, 27 Sep 2025 13:23:07 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f38:7d00:d0c6:28bf:dc2c:1c4f? (p200300ea8f387d00d0c628bfdc2c1c4f.dip0.t-ipconnect.de. [2003:ea:8f38:7d00:d0c6:28bf:dc2c:1c4f])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fc6921f4esm11907172f8f.44.2025.09.27.13.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 13:23:07 -0700 (PDT)
Message-ID: <b8079f96-6865-431c-a908-a0b9e9bd5379@gmail.com>
Date: Sat, 27 Sep 2025 22:23:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: sfp: improve poll interval handling
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The poll interval is a fixed value, so we don't need a static variable
for it. The change also allows to use standard macro
module_platform_driver, avoiding some boilerplate code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/sfp.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 92b906bb6..0401fa6b2 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -220,6 +220,8 @@ static const enum gpiod_flags gpio_flags[] = {
  */
 #define SFP_EEPROM_BLOCK_SIZE	16
 
+#define SFP_POLL_INTERVAL	msecs_to_jiffies(100)
+
 struct sff_data {
 	unsigned int gpios;
 	bool (*module_supported)(const struct sfp_eeprom_id *id);
@@ -298,6 +300,11 @@ struct sfp {
 #endif
 };
 
+static void sfp_schedule_poll(struct sfp *sfp)
+{
+	mod_delayed_work(system_percpu_wq, &sfp->poll, SFP_POLL_INTERVAL);
+}
+
 static bool sff_module_supported(const struct sfp_eeprom_id *id)
 {
 	return id->base.phys_id == SFF8024_ID_SFF_8472 &&
@@ -586,8 +593,6 @@ static const struct sfp_quirk *sfp_lookup_quirk(const struct sfp_eeprom_id *id)
 	return NULL;
 }
 
-static unsigned long poll_jiffies;
-
 static unsigned int sfp_gpio_get_state(struct sfp *sfp)
 {
 	unsigned int i, state, v;
@@ -910,7 +915,7 @@ static void sfp_soft_start_poll(struct sfp *sfp)
 
 	if (sfp->state_soft_mask & (SFP_F_LOS | SFP_F_TX_FAULT) &&
 	    !sfp->need_poll)
-		mod_delayed_work(system_percpu_wq, &sfp->poll, poll_jiffies);
+		sfp_schedule_poll(sfp);
 	mutex_unlock(&sfp->st_mutex);
 }
 
@@ -3007,7 +3012,7 @@ static void sfp_poll(struct work_struct *work)
 	// it's unimportant if we race while reading this.
 	if (sfp->state_soft_mask & (SFP_F_LOS | SFP_F_TX_FAULT) ||
 	    sfp->need_poll)
-		mod_delayed_work(system_percpu_wq, &sfp->poll, poll_jiffies);
+		sfp_schedule_poll(sfp);
 }
 
 static struct sfp *sfp_alloc(struct device *dev)
@@ -3177,7 +3182,7 @@ static int sfp_probe(struct platform_device *pdev)
 	}
 
 	if (sfp->need_poll)
-		mod_delayed_work(system_percpu_wq, &sfp->poll, poll_jiffies);
+		sfp_schedule_poll(sfp);
 
 	/* We could have an issue in cases no Tx disable pin is available or
 	 * wired as modules using a laser as their light source will continue to
@@ -3244,19 +3249,7 @@ static struct platform_driver sfp_driver = {
 	},
 };
 
-static int sfp_init(void)
-{
-	poll_jiffies = msecs_to_jiffies(100);
-
-	return platform_driver_register(&sfp_driver);
-}
-module_init(sfp_init);
-
-static void sfp_exit(void)
-{
-	platform_driver_unregister(&sfp_driver);
-}
-module_exit(sfp_exit);
+module_platform_driver(sfp_driver);
 
 MODULE_ALIAS("platform:sfp");
 MODULE_AUTHOR("Russell King");
-- 
2.51.0


