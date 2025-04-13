Return-Path: <netdev+bounces-181971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E98A87232
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 16:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27953B074B
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2814A18B47C;
	Sun, 13 Apr 2025 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxQEPT6I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E992F4A
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744553330; cv=none; b=IFv6HU4PvIT0HArNadE3LtyRzDZ7u/DddKlmMUxYtAD/egLQbusDldFbHFfbIgX9vfUQkHQzEVgKyPYkGy8ybdS9IsXrssU40bxkJP3zxwZa8fie65wC8OswNiXL5RDW1ifiVlA8Y8hMl+RzUPLmzzn5QdFk9sHGf/mWW3JxSl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744553330; c=relaxed/simple;
	bh=R5rl61+IGQ9L8sm8i1k5KgogSGBRisE4kf8Vhlnh6jQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=uMPI7tZOvIUxhbgpBAsux5+g1AcAnIpoRiMUbq14YfuYb1CzQ6Wu+IEF5xRIykKq4OT0rt0m3fNjgkQextDOevj/ilAZqCWXQdRSI9Jk9Bcgm8zAt+NdAjl3BFqYTgqRbhS23KBO0bUjS3WO5Kz+GJeAC4SIEUB7gGREqSN4IbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxQEPT6I; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394a823036so35021675e9.0
        for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 07:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744553326; x=1745158126; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ymjiRwtWbx2EbBlY63Bj/H8padSyy1HWwvIBZV2kNlY=;
        b=TxQEPT6I/ld0DjrlQOcDalBFMaWxN69vSKRuiXUADgMznc7yJVEElv8CAfdMSHN6SP
         ZJCAKrM4VYsNm/HO93sTBsK9EQyya5zcNmU8zOFzR7iNbcE6bSHBET96dsK7Y2sq6Tmm
         kpKYdsTvN8YpZGo72WwTEnQwuoI7P6geCAtAR39cGWMeh4w6VIKKU7q84PB5oXLzc6aD
         OTFKFOP66ay5QGf9fLDGjUfw4J5mBWN5Cu/Xcd08aJegsBgjfFRVxxNb+6WCiMeRNk8a
         sWonFoho61K3Ak9D/upaOUF5kTsrn4vf1ATN515enG4MGWJ9xFWblEhkYarJydGKuKZ3
         voHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744553326; x=1745158126;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymjiRwtWbx2EbBlY63Bj/H8padSyy1HWwvIBZV2kNlY=;
        b=MHkb9dwmKdXVIsvlGXAsrgVdS9lSTKcuLUUDs4fcFMuGLaYqfM85TzTf1WaG7ITqoD
         nM59DCTYLiB6MfRBbDykjB/ue95ZRa2UhD64Agq5HX47VeVpxr5pv7guPgsoY+Lmipxr
         daZMZB4XYUnVKvRjdc1pKnzAQMiGAhhF0zTFjues/tnAN7OBNdz8yd/PbC3xJIdtQ1TC
         K+bgDsLLjmEKHaVDZrQMz2sZHmiDYNKXIVSGCu2qfdQRTgNF633HY1l+aW+HxuBJnBmZ
         Wz6msDU8CQQuz8jZfykz4j6V9FwuQ33W9+OknjCpUkmI6a2QmWTOwW8SO/OVRYojHSHs
         tsWw==
X-Gm-Message-State: AOJu0YwmtlPKdj9SiTYZD8DW2c2SE2Uv94PV6IIEORwup8xmYxBGoMZJ
	jhc2gXpQeeLiKErcHjCHbonq5V1hAF1j5AudlNfm0koZl5GF94qZ0k/4YA==
X-Gm-Gg: ASbGncuDnErSC5S2K4wNTbAzxA0am25Ucse4Xf6VP+cXQ6kC1t8T+ffDUb3UH7+OFLM
	1JNu/Wzjds08KJrptM+tM3sDc1AuUNkJzPf3s/JFAWlw/GgslkutZUWDCpFZN0EwCSP+Eqw96v4
	TMHLlBPXKw3xjUmQ0VWWQPKvUVDZHjw3+xAQrS2j8NSE4E2WxG7vCmEJ6+lr7tv8zPROpBCU+DV
	S/BgXbsXyBn2HFXz9zd1CQ7fytIubnygOaBJBzhPECs6+m2wXqCiPipNax9CEjwXmU695gjyu9U
	nBJF88dIrdn/lVcrK7c98KuJKTUCaWwFTuNJPrEY2xwGmodBmJQqt3iGJN/iuNb3uodnm9VtXOi
	/P3jVl4552XS8XaBMim7fyr+vvC67aD9POMr4H5gBXdEa+9Xd8qpsBsrDIe4m93PPNvibaNSUCV
	s8J5+nJrA8XY93q2ylXt1O5EDHkPr5qA==
X-Google-Smtp-Source: AGHT+IGaYfVgL5fr767ZE2bJQdnnM6+xXXGj75XCi8990cWNjTpDuDJaXjazV8c7F8Skjp8+oIP1Pg==
X-Received: by 2002:a05:600c:674a:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43f4da84f37mr22400995e9.14.1744553326407;
        Sun, 13 Apr 2025 07:08:46 -0700 (PDT)
Received: from ?IPV6:2a02:3100:af2b:bc00:419e:9df:ec7f:c3f4? (dynamic-2a02-3100-af2b-bc00-419e-09df-ec7f-c3f4.310.pool.telefonica.de. [2a02:3100:af2b:bc00:419e:9df:ec7f:c3f4])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39eaf43ccd8sm8123228f8f.72.2025.04.13.07.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 07:08:45 -0700 (PDT)
Message-ID: <ab7b8094-2eea-4e82-a047-fd60117f220b@gmail.com>
Date: Sun, 13 Apr 2025 16:09:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: remove device_phy_find_device
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

AFAICS this function has never had a user.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 12 ------------
 include/linux/phy.h          |  6 ------
 2 files changed, 18 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 675fbd225..d948e4d86 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3208,18 +3208,6 @@ struct phy_device *fwnode_phy_find_device(struct fwnode_handle *phy_fwnode)
 }
 EXPORT_SYMBOL(fwnode_phy_find_device);
 
-/**
- * device_phy_find_device - For the given device, get the phy_device
- * @dev: Pointer to the given device
- *
- * Refer return conditions of fwnode_phy_find_device().
- */
-struct phy_device *device_phy_find_device(struct device *dev)
-{
-	return fwnode_phy_find_device(dev_fwnode(dev));
-}
-EXPORT_SYMBOL_GPL(device_phy_find_device);
-
 /**
  * fwnode_get_phy_node - Get the phy_node using the named reference.
  * @fwnode: Pointer to fwnode from which phy_node has to be obtained.
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a2bfae80c..fb755358d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1757,7 +1757,6 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 int fwnode_get_phy_id(struct fwnode_handle *fwnode, u32 *phy_id);
 struct mdio_device *fwnode_mdio_find_device(struct fwnode_handle *fwnode);
 struct phy_device *fwnode_phy_find_device(struct fwnode_handle *phy_fwnode);
-struct phy_device *device_phy_find_device(struct device *dev);
 struct fwnode_handle *fwnode_get_phy_node(const struct fwnode_handle *fwnode);
 struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45);
 int phy_device_register(struct phy_device *phy);
@@ -1779,11 +1778,6 @@ struct phy_device *fwnode_phy_find_device(struct fwnode_handle *phy_fwnode)
 	return NULL;
 }
 
-static inline struct phy_device *device_phy_find_device(struct device *dev)
-{
-	return NULL;
-}
-
 static inline
 struct fwnode_handle *fwnode_get_phy_node(struct fwnode_handle *fwnode)
 {
-- 
2.49.0




