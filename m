Return-Path: <netdev+bounces-197638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B34AD96B1
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 22:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B783B618D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EBB24BD03;
	Fri, 13 Jun 2025 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkKpxNJL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6087F2397A4
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 20:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749848149; cv=none; b=rgwrm4sjlZOdSxse4fD3wzXzapaYZUYlb7/S8COrv+LBe/feft7XdfBhLr/VHNjRjoVD7xY3B4M/l6XHCSU89LQL3R0uuloZy7Co9JngqKH7pdIqvl8rDMfVYyR8rzEqCDQKiyAe+MpGTKwSlHkR6CSTMnav63Wfh5JJ8pKWjUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749848149; c=relaxed/simple;
	bh=3Cd6E+x48vTJ/Di806kw8GWF0zFvVlSVPhElv2kiwG0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mIhgDQVAzBk/z7CyrFBfPphdTBljhW4KECwuXEFZoRaa0YbzMbCkm4k6srFRneH5s1fiY5NGY79GngDo78xrZauecKVq8e5TFpY47j/v7wYYPzpc5+fwMc7J6Ff9mG6KS9KdoOhIcQo8AH7DXIkb2qBKxiZ06iYxog/TfyKajO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkKpxNJL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4530921461aso22603185e9.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749848146; x=1750452946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TMWtQZst4tyrdwntHwwl/96FUI4XNLUxqIS3adhLrlI=;
        b=CkKpxNJLk4+91kV5OPlaz7a467pO/Io1Aj94r+pGOwmvTh4celt524wfJdocQ3R4h9
         RBLbehfykC5Eqq04ArvinjaNim4316bSZjSEga3bbCPiyuBewMFbCCtIfzIcrcV067T/
         erZdvUy7SJXwgCNfGeKeP+x2bk8oq3Rf4TUsiM+B1BVLtkj5V7MAAdo/6A77yvN80CxJ
         3+CywXFdJn1di91ARcMOXKWjbhAkhsLboTncLCJJaE0xve6doX/tRSA+UlQVuo3NvMjT
         CXgn/Ftv0U4gicRIcvhAyJjuC5mPxt66otDfED41yzE83kGlzsa3c9y8GHyhNOUQUFgq
         t00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749848146; x=1750452946;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMWtQZst4tyrdwntHwwl/96FUI4XNLUxqIS3adhLrlI=;
        b=ZAFhuWcQ2D5CsgB/o0VUndoXSaoDywJJ9TsPY5xfDBZnprLag2bn1ABgmyqYKsLJtn
         JAuTQ7SwJjT5SCVa7qwmDPwqGkjCdNPkw5KIXLw7a1FK4xMWk2gIDhR/vDnsKLdqsQG/
         eobgA8A79M9RXLhSNasfRIfv48NVJbGS3pwfW3c6g8FXPS46qJFMB7zbdWCq9BPxhnOI
         ou3s4x35H8Vqa/02/3+JzkKARuwgWSy1GlzxiY7+yoOpARBylO9uLj6FS2iCA5SGZBDM
         n0lKzPbIAJhByITIHpnbNAmMi3mnoXo5QVHEjZDgmWMxN8jVz8H6NVdH/ZerHyRKq+fJ
         MHLQ==
X-Gm-Message-State: AOJu0YyL+a5UcatXpLYEl7hJG3ouzpr2cHSqlIJDJpo+5QBLQefTRKPi
	zVNipmVfGPZrRX1oLdGPmP1ds2Xnl9nMtKH2qBwwEwts6ACS/1RONS2x
X-Gm-Gg: ASbGnct8LXOSZdWpouHbiTVYNjd6t9+1ENt4o8XkGYigxYxwuR5DmIIs2ZC9eputEEd
	7w4A/XGw0gryqCP07PCLqINB3FpTJ9ozrnZqVOyC+J9Z2Zb9i53pj7GRNvnuupDykS280lMC+KF
	WqYoijjPL+uOddN8Lup91DfhjanGFTswkKMhaJm8xUER8NGYsImcLTCb6oOR29oqlem7v8zynYB
	wJ5iRQv6Z4KjFVFU6P/vQBhFU6OE4w+aiyrJ1eOzV26kvcGGwxaCJqMJNgxkfJMSdPg28QtSeVQ
	LvwDkBeP7IT4mo9uNHTY64gJ7pdy2wd1D9U24KatqrzxIO/P7o7h9x1rc7mtgy5Bk/kd9n00SXd
	n0QkqXVWw57VcmVKsGlcig6+VNTWw+hX6B+SOvVL+9Eg1PzlGkArn2hYSsHwRk7wUuW+tO85Bl7
	sGaToy2UxvnnGHsppzqtBzdXOtGvZSWB0dHI1H
X-Google-Smtp-Source: AGHT+IHqPCSzvCYrHIVkXckeuqhZ3SEcMYdhBO7TNrIViM1vsp3412R8WSoJMydVuaIlmWphIHoEBw==
X-Received: by 2002:a05:600c:c16b:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-4533ca4f7a8mr13833875e9.10.1749848145629;
        Fri, 13 Jun 2025 13:55:45 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1c:2700:11ba:d147:51f7:99fa? (p200300ea8f1c270011bad14751f799fa.dip0.t-ipconnect.de. [2003:ea:8f1c:2700:11ba:d147:51f7:99fa])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4532e224617sm63577175e9.2.2025.06.13.13.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 13:55:45 -0700 (PDT)
Message-ID: <95375cb2-e887-458b-b87e-3f6603ca9a36@gmail.com>
Date: Fri, 13 Jun 2025 22:55:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/3] net: phy: improve phy_driver_is_genphy
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <8bcd626f-a219-43e8-a0c2-aa04148d046d@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <8bcd626f-a219-43e8-a0c2-aa04148d046d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use new flag phydev->is_genphy_driven to simplify this function.
Note that this includes a minor functional change:
Now this function returns true if ANY of the genphy drivers
is bound to the PHY device.

We have only one user in DSA driver mt7530, and there the
functional change doesn't matter.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c |  7 -------
 include/linux/phy.h          | 11 ++++++++++-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index bbd8e3710..c132ae977 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1722,13 +1722,6 @@ static bool phy_driver_is_genphy_kind(struct phy_device *phydev,
 	return ret;
 }
 
-bool phy_driver_is_genphy(struct phy_device *phydev)
-{
-	return phy_driver_is_genphy_kind(phydev,
-					 &genphy_driver.mdiodrv.driver);
-}
-EXPORT_SYMBOL_GPL(phy_driver_is_genphy);
-
 bool phy_driver_is_genphy_10g(struct phy_device *phydev)
 {
 	return phy_driver_is_genphy_kind(phydev,
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5b02b4319..4daf6d69f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1293,6 +1293,16 @@ static inline bool phy_is_started(struct phy_device *phydev)
 	return phydev->state >= PHY_UP;
 }
 
+/**
+ * phy_driver_is_genphy - Convenience function to check whether PHY is driven
+ *                        by one of the generic PHY drivers
+ * @phydev: The phy_device struct
+ */
+static inline bool phy_driver_is_genphy(struct phy_device *phydev)
+{
+	return phydev->is_genphy_driven;
+}
+
 /**
  * phy_disable_eee_mode - Don't advertise an EEE mode.
  * @phydev: The phy_device struct
@@ -2098,7 +2108,6 @@ module_exit(phy_module_exit)
 #define module_phy_driver(__phy_drivers)				\
 	phy_module_driver(__phy_drivers, ARRAY_SIZE(__phy_drivers))
 
-bool phy_driver_is_genphy(struct phy_device *phydev);
 bool phy_driver_is_genphy_10g(struct phy_device *phydev);
 
 #endif /* __PHY_H */
-- 
2.49.0



