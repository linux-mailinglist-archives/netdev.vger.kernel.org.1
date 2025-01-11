Return-Path: <netdev+bounces-157391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356D9A0A222
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 10:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1F7168B0C
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9DE185924;
	Sat, 11 Jan 2025 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLhFZ0BI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B0124B22C
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736586416; cv=none; b=K2fs6yiO2v8S5n1Kf+CUh1rvXQTU9Hu4xTcUZcwc93giCau76wwm3WpmZ2OZNs9GQk50n/caAgYcfRX+nhYmUX9gq+IdO63CPcq3U+ToqnhhUHZIovbWL+YHN69WviewrdgtnIc2Ns4ZD/teUWVHI+fo9zxPXq/omyxeIAecgfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736586416; c=relaxed/simple;
	bh=jPx1NDxNEud4owSbvYgV5w/KsZRT+U7tOEdh19pm1Z4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ec06VHycZ7NHoBTiN8C4Egio8uSOaVXVA16/q78XYBPuaTx4jr/TryT0N2aa1XzlN/+g0f7xox1pCdjxuaNJdHPh/9c/zTMVp+mLIlwqJV/tsEtvR0zI+NS0Tg0+rESM+J19tiyGOkXDOSc1fiSV9aozSuy4fmhMrCeyJrkwEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLhFZ0BI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so505960166b.2
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 01:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736586413; x=1737191213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D1GoVZaTZhrjTjAe0U0XKWytSXKvgBIDeabv1Mucsks=;
        b=nLhFZ0BIXym9yNxKefJ+cPpQNDhrv2Z7b0s5HFVEDjU9UFbnPZfsBDgf9Tucem5YaI
         7Ped3NUvP7XsrIZIuqkf3Ia4mpYGZjF7GtXeJeOS9tHyGuYFyEceQ/iIJEAP+ut4jjF8
         emnH1C3A3hVPOl9RVcPkaceBHz4eYuaM+JZffJLRXvfBV/R8Ojp+3vF9xJjfguK2Rkzz
         BYYyfpeDEXGRg4UYjuf7QSTU7q2siCAmpdscIt8KlyK/YjhN981toho1UaglY2vknHI6
         NQ52pXgNN8Io9utH9VuTzshrEkiVNTf+5Xe+SFEbbFmzLcALou/T/K/PwbtzpceQGZYB
         bKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736586413; x=1737191213;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1GoVZaTZhrjTjAe0U0XKWytSXKvgBIDeabv1Mucsks=;
        b=tOJ804LvjnVXbHHcOVB1gMXK2hC4VkQz070L/w9JRDwQe0lwWYl9w0CGreIP/gX95r
         zDWSngFQM2NTInO0XnKSu/qLN9H1obyIMxvyAJhI/1yapnCaA6Zeqr6Q49sTLPnCtNsI
         QieArrx3PNL+GL18H4HlxqBG5xXC4rco4xm7IoScVcfX1X/ezyDm18fhaWOIDto6/2eD
         IX9vgIzSIhUKixQNPsQR9wC1REul3+SUH/TO85SbTPBb04TqkcBiALT6Ly85M+WZ8QAO
         i2tE1KtL6ppKT5H1Y9eTIORLKHIVE0YEXNYHJyQKv6VAtgTiksWL1XcmKnhDLV6uZQlz
         sYzA==
X-Gm-Message-State: AOJu0YynrnvFMBPAKF7qv9q/OOevdDzbk1HJIPjoB40BYtTrIo0YbWBd
	9Jdj052ZpyA2SDEuW27W/JpI2Y3ZXkTpWPwTb4nWFEt0Mwt1emMo
X-Gm-Gg: ASbGncuI9wJZ7cvZJPq0wpaTvIzS2FyMVEuyXbEtUJ5Bg/KETtZHvJ8IWpjjTPiCoid
	DwvumOcDkXxEVuWy4xbOzakdBcH3PIqIbSo5pSpRUTOmM0mOTg0sTkfI55meWfwXX0SXQ2y3+FT
	EAGqwzvTYUwMgLbyN79myatV1tovJFojx6KPKxBUu6I0GVmzsyWPFDNnproSi4J1tPVGl7lrRCF
	Hy1DKOBPsVRBz9zCoouXvvhHDAlUZFCbe9v5A+6aSG31mj6UmYs0vLNpShhOGMWkUf5f30sV/Zg
	s8jbBW+YFiY+hsvOxh9JmmC2Kr69wehlTGNrQs9NQrVNZ+c14Jyzup6ynbK8nmkkWcNddI7ZQwZ
	0J9mX0QmxIhzDFOoE2U+MilRKED06VOlyU2q3s4kswNJPlC9z
X-Google-Smtp-Source: AGHT+IH6AcWLcjO7Ho1qKu0PdqTcBn6NPCBZewCtQg8eytg26RbaI5qXU3129V+BXCPljAQCND+MoA==
X-Received: by 2002:a17:907:1b03:b0:aa6:86d1:c3fe with SMTP id a640c23a62f3a-ab2ab6705b8mr1356227666b.4.1736586413365;
        Sat, 11 Jan 2025 01:06:53 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c90dacd7sm252525366b.70.2025.01.11.01.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 01:06:52 -0800 (PST)
Message-ID: <1bd0087d-0e10-4f12-b6f4-32ca423cf0e0@gmail.com>
Date: Sat, 11 Jan 2025 10:06:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 4/9] net: phy: move definition of phy_is_started
 before phy_disable_eee_mode
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In preparation of a follow-up patch, move phy_is_started() to before
phy_disable_eee_mode().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/phy.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7138bb074..ad71d3a3b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1318,22 +1318,22 @@ void of_set_phy_timing_role(struct phy_device *phydev);
 int phy_speed_down_core(struct phy_device *phydev);
 
 /**
- * phy_disable_eee_mode - Don't advertise an EEE mode.
+ * phy_is_started - Convenience function to check whether PHY is started
  * @phydev: The phy_device struct
- * @link_mode: The EEE mode to be disabled
  */
-static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode)
+static inline bool phy_is_started(struct phy_device *phydev)
 {
-	linkmode_set_bit(link_mode, phydev->eee_disabled_modes);
+	return phydev->state >= PHY_UP;
 }
 
 /**
- * phy_is_started - Convenience function to check whether PHY is started
+ * phy_disable_eee_mode - Don't advertise an EEE mode.
  * @phydev: The phy_device struct
+ * @link_mode: The EEE mode to be disabled
  */
-static inline bool phy_is_started(struct phy_device *phydev)
+static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode)
 {
-	return phydev->state >= PHY_UP;
+	linkmode_set_bit(link_mode, phydev->eee_disabled_modes);
 }
 
 void phy_resolve_aneg_pause(struct phy_device *phydev);
-- 
2.47.1



