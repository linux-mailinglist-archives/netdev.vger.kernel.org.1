Return-Path: <netdev+bounces-226920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D68BA62F8
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9344A1A94
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 19:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF681DE3DC;
	Sat, 27 Sep 2025 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmRanA4d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329A728371
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759002740; cv=none; b=XBhZwcZqX273fVt6c20+ZRcSB9j/CxUg5hGhN9QneMtg+iLd0j3wmNRLYhraKcuHRF24Wes6tzb5uu7iOU6mmkXdYK9no1KkzDoTvK/ub3YJ2wQwk3uSTt4ktFLhNCdArBYOlMG1LYwn+B4n1LS9GVs3SNZPJFIfdk4iyHWfBdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759002740; c=relaxed/simple;
	bh=bB/zoiRlwlFyjrjOQHABSHexFjbg5UfCgTzGIchnvxY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BSIe8W0NBKrenETWIiPIMf886KRlNmokp/WhPXW7At6NvO9x0FfZGo3KqVOLMGRtgpO1zS6fFK6J2BcKnbURtlcubNEZWYvGGh85yoL7Au3WJudX3N+jA0G1baB6K3S3QRszEa8aq7P2OKBvir0YgBhQVASh/cQ3B0VxA9jUMaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmRanA4d; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso15123785e9.2
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759002737; x=1759607537; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLsVwj7c8issKKuAuKgbiRTqbzoD7m7Ti8iXj7U+moE=;
        b=kmRanA4dnNG1zrx+codzGuV6ybYTCWeFK2MKdnt+xUKoaSiBkP8w3FCrizjnybTZvd
         AaVO2fj005kLcEixvsW9eR3KzizLXLr3apkC2UEeMuKbRZqn6X51Pw9evKeJDuwm+v6P
         Qe6uMEEdz3VaYb8vA7d5iu5nIkcdfH+3HjA+ryEDRXt36kmN7bQgxmjmyxOZGc/gPbj8
         tp9NLIEC+i2yhNzYzQVk6RVzCOVBedzUOFc8nkk4ICrsFn5pkcNECX7y7a1Ksga2SF6n
         dnsRFoPuKev8oAPFUxJui5k4wJCAevw59w/k97NrBvZ2F1bIfjb+qHJjeTheI5WP358/
         4EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759002737; x=1759607537;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLsVwj7c8issKKuAuKgbiRTqbzoD7m7Ti8iXj7U+moE=;
        b=ZQXdItJdSKnNt3PkrSLCKwQ7r3F5QcM8Z8S4mhpFwWzx1lwLS1DUEY9XO/tj+3Wqxc
         mGD7BtqsOPaKSvb6wEV4MasNOq6sVbnjp3UnewX3y9uHbhlFNlGE18PxV/NfE41oRBj/
         plnwRTEpjMJSYg4qF15f/xFHY1i2RFlcvzedzL8R+I5XMTJ6OUO2hzSuWlaNEab0B1Lx
         OGJyvFmwEcOKh4rhzM2BYih0yrrSu0WlSKItdYb3hSJq20GZtnlNAM3vmlz/JGxWbQNp
         SoLc3VjghPl+UByHlSzG1EY6pCfoKE3hBKc9zaxJo9ZFQrxdnHdvvdxMwe5utYldduYi
         Akrg==
X-Gm-Message-State: AOJu0YxTroNvrUiUBnVt2yRLQOT5dN7Et2vOIbT1Vn6ooUxIvB1dOScm
	RLmr77+2bIe1pKjxxww5IQb9Tev5f7/2mfN5bHuNUo0uwnI32kD0Eif8
X-Gm-Gg: ASbGnct+C3JKyzuKHHZrKKFtjV1qbsneRTQnVsXH9/MIhoCe5JeigA0m4nOuRPfATYx
	WVE4UeKJRCfB01MLs4MvNV+DUPLrwxVw5483k9rReRc1d344KI5v0JQoHmiIH4oZeYQnNqI3Ce1
	mi+C/LJA1ulgxpENS4qXULcvgIcQ96dJ2JSYVM7D7kQUDXVl+t+vmbq1STEwLlAipcWiba2i9ld
	lmVlUS8hKRneCv+saHSAO1fVmxVfxNAACqH0GShhkqK5oZjjfPh1YVlDoJE3nW/+ex2kTTE+ne4
	qM8z8mX0g4cf+bXMWJX1j3tHWJU6WCgBUjedy/UtSqY8ENOdOggfXuaRBWCYwkAuKzcLkmn0FzE
	pmSGS/odDGg840T4x38RjArAxllkoskoa4y443JtkUn7fjj93sD+bozlXIUIq/T6n8nQ2wx0fx8
	Ja1J2FRKHO3nT6a7R12MdH7hf/Kl+OsV0KY4mFiMSzuMwzfbQvZCG+hbSzUqdwG+iSiqYEW7Z8
X-Google-Smtp-Source: AGHT+IG/TVqOCm3NNshVIWKAKcsBpaATn5HauN0gCbzFDP2NtcmLAnoICHyUdjHFU0HAlE3nNQDkAQ==
X-Received: by 2002:a5d:64e6:0:b0:3ec:e0d0:60e5 with SMTP id ffacd0b85a97d-40e45a927c1mr10495284f8f.15.1759002737152;
        Sat, 27 Sep 2025 12:52:17 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f38:7d00:d0c6:28bf:dc2c:1c4f? (p200300ea8f387d00d0c628bfdc2c1c4f.dip0.t-ipconnect.de. [2003:ea:8f38:7d00:d0c6:28bf:dc2c:1c4f])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fb72fb6b7sm12717673f8f.2.2025.09.27.12.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 12:52:16 -0700 (PDT)
Message-ID: <2bab950e-4b70-4030-b997-03f48379586f@gmail.com>
Date: Sat, 27 Sep 2025 21:52:30 +0200
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
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: stop exporting phy_driver_unregister
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver
removal handling") we can stop exporting also phy_driver_unregister().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 11 +++++------
 include/linux/phy.h          |  1 -
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 01269b865..1c0264041 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3589,6 +3589,11 @@ static int phy_driver_register(struct phy_driver *new_driver,
 	return 0;
 }
 
+static void phy_driver_unregister(struct phy_driver *drv)
+{
+	driver_unregister(&drv->mdiodrv.driver);
+}
+
 int phy_drivers_register(struct phy_driver *new_driver, int n,
 			 struct module *owner)
 {
@@ -3606,12 +3611,6 @@ int phy_drivers_register(struct phy_driver *new_driver, int n,
 }
 EXPORT_SYMBOL(phy_drivers_register);
 
-void phy_driver_unregister(struct phy_driver *drv)
-{
-	driver_unregister(&drv->mdiodrv.driver);
-}
-EXPORT_SYMBOL(phy_driver_unregister);
-
 void phy_drivers_unregister(struct phy_driver *drv, int n)
 {
 	int i;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index b377dfaa6..7a54a8b4d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2030,7 +2030,6 @@ static inline int phy_read_status(struct phy_device *phydev)
 		return genphy_read_status(phydev);
 }
 
-void phy_driver_unregister(struct phy_driver *drv);
 void phy_drivers_unregister(struct phy_driver *drv, int n);
 int phy_drivers_register(struct phy_driver *new_driver, int n,
 			 struct module *owner);
-- 
2.51.0


