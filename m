Return-Path: <netdev+bounces-153698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DC59F93D3
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B5018943E1
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F4B217F42;
	Fri, 20 Dec 2024 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5rHx9xF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C7A1C5F19
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702697; cv=none; b=sS8LBqvOhPnoRxu5GYbO3inuDoEob6iKQAOdzwqPIG6PjdMU+PIx0+cc4zUzOXH0RF90E+QULA8cbxFwZa4BBp0JARkvnHWpfnAWV+OJBbWYuZWRS3VB0KSZWvzBXbBDQGOjAveOtZl71/afxdE5ON2Fh7C/ndyYdsI6CYz8M7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702697; c=relaxed/simple;
	bh=nplSBzwl31z+Mt/fY4US1/Fw5U8kBllV+HgOgwWKcus=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gYlqh6DSHFqdmJ8u2g8778PgM9JYrWM1Ck1nVQWyBULHu5mZpW6aQb1LaM/YZUlhnO9CbDuLLhmRdsEAMBA5KAyqysc23zOLKMKAkudwSF2hXflsSFrSKKZt1x0dcd2e92v0dngEj9QgapSLwu1xbYLYFzPXd+W7uhf2+oef4rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5rHx9xF; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso2725729a12.3
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 05:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734702694; x=1735307494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ncBWufviQi5N362JzS8y2BzdkDuzo+WeoGCs1fgi/vc=;
        b=E5rHx9xFP36H+FsfZjJJ/746UqnVCm+vsrn5dQkQm5Jqnw+WCgW3I8IBX903J0iGIJ
         TDZQ1Vg3hfMwvseABK6ulwbhlAAgt+M6i9HnMNqVdF5DY+sM1qFjizWDd/G3SAauGiBx
         E9PZjvsY4jpECIe2RHW0klRCI2vGvt0LVqcJ33aeV8m3glxHrUVlrlHhJAucD0KQSLDH
         KPO47+Zw8zTvXkrEj/q7lRZCNRRdr21uRlW8XTWNFyRwPUtHHkKq8PH7dQ6G78VMtfXz
         34A96CaJmd7OAARcCWqr6wumuKfLDen5exUVpLU4Rr5GaAGv5Ax38uiBF4mKtNSiyNny
         cSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734702694; x=1735307494;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncBWufviQi5N362JzS8y2BzdkDuzo+WeoGCs1fgi/vc=;
        b=h2D5syWW/rf4hUC/B1nMGXyL8dMM21Kmup2eFl/oipSg+hPgyniaKXRloCMt3nz5i6
         ICqtOrZRaa6eHc8ZGbYP7ygC1re1fYv82/o4vv35K37QuFmz8dRAcQ4+AEUpD6udeoup
         4zp59bl5XhmOLJ32AUoa1RNOdA2bZSXq2dua1sQZSwMEBmTCdm3yXBctQznyPhW41UCi
         DqKhB51hbWsLqTsQP+xUNDyzeqxIu0Xm8CKazWdF/U1ym27bkxp7SIXreLnVQtdAgpw7
         P/9hIaqLUjBv0O5QGtfG5AnQaVEZAkBwqS1CbjmVZRkerAIRO0NfGrTBOR/358tMiV4h
         PVKg==
X-Gm-Message-State: AOJu0YzUrRxaHo2nnA70+m0RFmAI0EgU/hDuTa7gytJgja3R3XmLOZNW
	FLnbbg69vpgIFuAdzlK0Se0Ryf5+g0E2L9U/WzZ92Rxv0VtDtgMs
X-Gm-Gg: ASbGncvF9H4mVEIoNhY6ekW7YTKeQqXQ9EQ1JoSMwh/LVFQVREIGKMgFNrn7TlAF/IZ
	Iue9+hjIIsR1mR0qSPpCY7hiyuNT5aMF8/YfdHjfe6s/sY3mHWsrzrwwPEbDFxJsf05VrnmfAs9
	FUV8N3M7MKFIIXzm1Qe3m1KU7N818yxbLRl040WQ4ETXlOmHgn9OzN5tkIcJak5jufYm1syUaaV
	MVpV2sXSHzwzMhf++b1jAhalPkcJlAwagCVte9totp36twY0gwB4jbEBgHb7GcH8QQJeLm93qWj
	0hkCOnUo+VcyyUs9IUEnOU4FhsC12Hj/D6nGpUyFlTA5mQeZ//VAU24QdiYtyuilN4Ywlxe1BWp
	JevV6d4Bg2UqybMgyFA/SUU1xVbpyW+kPxBLNpRXu1g/ctMIW
X-Google-Smtp-Source: AGHT+IGQFEZ9WpIURsTixlCe6uEso/9/2XWRwdVQX/j45RkPtO6SAusWtl55RTyiAcIn+dAWa49TNw==
X-Received: by 2002:a05:6402:3217:b0:5d4:4143:c06c with SMTP id 4fb4d7f45d1cf-5d81ddffa67mr2667667a12.23.1734702694413;
        Fri, 20 Dec 2024 05:51:34 -0800 (PST)
Received: from ?IPV6:2a02:3100:a560:5100:8565:bec9:a1c7:2d82? (dynamic-2a02-3100-a560-5100-8565-bec9-a1c7-2d82.310.pool.telefonica.de. [2a02:3100:a560:5100:8565:bec9:a1c7:2d82])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d806feddfasm1841255a12.58.2024.12.20.05.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 05:51:33 -0800 (PST)
Message-ID: <77df52d5-a7b9-4a5c-b004-a785750a1291@gmail.com>
Date: Fri, 20 Dec 2024 14:51:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/2] net: phy: micrel: disable EEE on KSZ9477-type
 PHY
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Woojung Huh <woojung.huh@microchip.com>,
 Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
 Tim Harvey <tharvey@gateworks.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <942da603-ec84-4cb8-b452-22b5d8651ec1@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <942da603-ec84-4cb8-b452-22b5d8651ec1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On several supported switches the integrated PHY's have buggy EEE.
On the GBit-capable ones it's always the same type of PHY with PHY ID
0x00221631. So we can simplify the erratum handling by simply clearing
phydev->supported_eee for this PHY type.

Note: The KSZ9477 PHY driver also covers e.g. the internal PHY of
      KSZ9563 (ID: 0x00221637), which is unaffected by the EEE issue.
      Therefore check for the exact PHY ID.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/micrel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 3ef508840..ece6d026e 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1522,6 +1522,12 @@ static int ksz9477_get_features(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	/* See KSZ9477 Errata DS80000754C Module 4 */
+	if (phydev->phy_id == PHY_ID_KSZ9477) {
+		linkmode_zero(phydev->supported_eee);
+		return 0;
+	}
+
 	/* The "EEE control and capability 1" (Register 3.20) seems to be
 	 * influenced by the "EEE advertisement 1" (Register 7.60). Changes
 	 * on the 7.60 will affect 3.20. So, we need to construct our own list
@@ -2000,12 +2006,6 @@ static int ksz9477_config_init(struct phy_device *phydev)
 			return err;
 	}
 
-	/* According to KSZ9477 Errata DS80000754C (Module 4) all EEE modes
-	 * in this switch shall be regarded as broken.
-	 */
-	if (phydev->dev_flags & MICREL_NO_EEE)
-		linkmode_fill(phydev->eee_broken_modes);
-
 	return kszphy_config_init(phydev);
 }
 
-- 
2.47.1



