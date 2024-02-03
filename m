Return-Path: <netdev+bounces-68804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B3784854E
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 12:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B32E286570
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 11:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95C71CAA3;
	Sat,  3 Feb 2024 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6qxssv3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A9A12E51
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706959215; cv=none; b=apzv/Zq/fQgGPbeVBNhBfMYqpLYLNiGhFsov2dcGfl/KcrGB59XFXhgEF0JRC4mEZNd3daNOpQkT5GltND7GpRe8LiNk6Zj6fp+avPk2G90zrN3exNmGbuf8hokzanki+YcekUvyjUNyMk0kPtzEEOFG6ezC0biz6vH2A7NGJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706959215; c=relaxed/simple;
	bh=xRzoyDno+ZjhJtNRPdjfzGzqvvgir7MAOXzY7NEvQC0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=frKLVQbQ56WTnWKN122zzwxJVx9dUpEJUd1jmN6vDVaqwlsMEoHQ5IVaF3kfm2/jKR5WvC0EX2h4Ze8Brireg9wmdYFB3le814MkqUteJ6cbQYyBOabNZVUeNwyMRNam7rE90pSSZhbsxy6WVwZ5FJopNtslXxPZ2ov563NMU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6qxssv3; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56002e7118dso1348835a12.0
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 03:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706959212; x=1707564012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=75voncJtV82jxd12/hVvR0/uejYNFEPsMm6iucNJdQ0=;
        b=d6qxssv3Tua5CmWlgKkNg1MnIF6AwiVneC9p3iXSpG1BiorG1UUc00veXtV0X8xp1R
         q303Mlh9n8MSJCjwzdkPa0hcTaGqPzCyDmRiwnyrGRcTP9j+5wleMM2RSNyMNNy+1X90
         5n5g8QXOJ4+iP1SyvMTG1nSGkCBeC5ltcwezw7vptinSn6JRU8bR7RIIhlKZd4MhDZmx
         4HDnSVT9RHpq1gpJBDHUBBnd8GJm0ldLeFZq7QmWTyQJ9FQ5XWt625Y03j4eRerx7ez9
         NCNJwgMUPAswnF5h7ByHhmDfnu9C2iOdlhLjXTUr3B9xuFREffpSMvTuqtuIo7lwU3J1
         mZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706959212; x=1707564012;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75voncJtV82jxd12/hVvR0/uejYNFEPsMm6iucNJdQ0=;
        b=SFrLypJFfGRSR++mLpszik3VzxlWn5SjrrHaG+BL0HHTV+/3UFWCJ1cmTntQDakg7U
         yFiwSAV1jP9W2kNp2X1GLKz0sfQvLryxzA33KlpQF3vKj4yGTBIXTfmLEkiQMzjmw19H
         HsDNwsJt+nYzebYvC7lL37cMgoshZdoXhsqNWX0LqUAHqx3QwjYj/CnL2c2RTLwm/ooN
         vMJ7zPLwWBSVvQHiJuWnDwTUVxGUauG95JOl1uOe5kKaiof8YJSBtv+fXy4d0qR9KZwO
         TM7LAQBb4UoPn+1DM63Af4jRAobwQqTJa76AB9tUo0qAdxtY+47p1z/YfEfHFvyf7a6r
         x0hw==
X-Gm-Message-State: AOJu0Ywjm/AG3Zrk9+QORfhc/rlgzsp9Ed/JmDlJs1M//lW92GEARcIR
	XhbiEjx+pv02ZEX2dDESGSteKAw4EicYEdiDFVkd/Wh3svgtY07GNsU/+HZf
X-Google-Smtp-Source: AGHT+IHEJus0Pfa0o4QGWGNwn2C/YQ4dW3kWkZzugkOFfMYr4oZ+c7s65EvcNzCeM7ygt1Dgyv9zrw==
X-Received: by 2002:aa7:df14:0:b0:55c:7b3b:5990 with SMTP id c20-20020aa7df14000000b0055c7b3b5990mr1631813edy.7.1706959212011;
        Sat, 03 Feb 2024 03:20:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX+mQSKvnJjlVei4ZZqC1sMSZaheRC79pGVPM+5UCjlVSY7yDENBPzd9oWnV6+9YWF3PZCcsg74hvGwAEoCLC8D5NVJIRO2T9EEzxdy9Q+m3V9I6OfdCe1A8nKa4eg5VIvj9/l7kRLj4nck4Oxup8bnSFqsAUCGIaX5ok/LcDZfPxCXTWfa5tJB19b25di7XALjZ6CDcbDHLj3WuA+PeR6T8QrZLQaV
Received: from ?IPV6:2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac? (dynamic-2a01-0c23-bde4-a000-48dd-a4bf-88d3-e6ac.c23.pool.telefonica.de. [2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac])
        by smtp.googlemail.com with ESMTPSA id g18-20020a056402091200b0055ff4a88936sm1380915edz.41.2024.02.03.03.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 03:20:11 -0800 (PST)
Message-ID: <45b0be04-2886-4eaa-a5a4-9e3a2e29b667@gmail.com>
Date: Sat, 3 Feb 2024 12:20:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/2] net: phy: add helper phy_advertise_eee_all
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <14ee6c37-3b4f-454e-9760-ca41848fffc2@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <14ee6c37-3b4f-454e-9760-ca41848fffc2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Per default phylib preserves the EEE advertising at the time of
phy probing. The EEE advertising can be changed from user space,
in addition this helper allows to set the EEE advertising to all
supported modes from drivers in kernel space.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 12 ++++++++++++
 include/linux/phy.h          |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index dd778c7fd..df56c3ebf 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2769,6 +2769,18 @@ void phy_advertise_supported(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_advertise_supported);
 
+/**
+ * phy_advertise_eee_all - Advertise all supported EEE modes
+ * @phydev: target phy_device struct
+ *
+ * Description: Called to advertise all supported EEE modes
+ */
+void phy_advertise_eee_all(struct phy_device *phydev)
+{
+	linkmode_copy(phydev->advertising_eee, phydev->supported_eee);
+}
+EXPORT_SYMBOL_GPL(phy_advertise_eee_all);
+
 /**
  * phy_support_sym_pause - Enable support of symmetrical pause
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a66f07d3f..1343a4081 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1960,6 +1960,7 @@ int phy_get_rate_matching(struct phy_device *phydev,
 void phy_set_max_speed(struct phy_device *phydev, u32 max_speed);
 void phy_remove_link_mode(struct phy_device *phydev, u32 link_mode);
 void phy_advertise_supported(struct phy_device *phydev);
+void phy_advertise_eee_all(struct phy_device *phydev);
 void phy_support_sym_pause(struct phy_device *phydev);
 void phy_support_asym_pause(struct phy_device *phydev);
 void phy_set_sym_pause(struct phy_device *phydev, bool rx, bool tx,
-- 
2.43.0



