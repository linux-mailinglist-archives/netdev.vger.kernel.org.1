Return-Path: <netdev+bounces-166829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDF8A377BF
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 22:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B507A362B
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 21:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E26F19E7F7;
	Sun, 16 Feb 2025 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnJkfCIW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B136A33C5
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739740688; cv=none; b=OWp3R4g/MBFsADFAc7UjCYSCneqDemQOutL/TAgM4EIYYK2NE2w/7+5079OBa+pImf20bT2hWi3IGx2/Tkro/kVFvE787R760hx/bUjHgF/9VxC3OjfXuzZGCP9226HOX4LRXrFKymNS0sWF1fXDGbqxvpg5G7SflBVFNRu8lwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739740688; c=relaxed/simple;
	bh=k4Jc5K6YbDVb7IoDwbghplVnkduaxK8WfPlwrhbv/cE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bPgy49+LgXyTA4d73WsCjqTGFFwTBdBxKL5YihGltjZm0HJfmzlxWOXXaIw5boWsJ0lkOSik9sN99GzIShOBjsN+mXYqVCnJpMd9GHpEBsx8Pey1zvAU7lhMDatKB5j3lLxiLYLBaQLxW23CbNV8BCRV3JAXkA6A2lp/GXjm7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnJkfCIW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4398738217aso685195e9.3
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 13:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739740685; x=1740345485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yhoUPCLiY1qh5FXsY34Sd3WQZveC57swlGT7d3QX6KU=;
        b=GnJkfCIWbIUTRBkTW+xVfFm+TfBtssVsc8tVRklIl14Ga5Pkmw8YojBcHK2ARBDZjd
         QEnJYZTF1Pnh3wLPfNZu3cecZukuVoEkXDE/LRhQ4+kZKT9CJnKPCbj28hO+z9ewTYkj
         MwqVFXqTkGt6MmsZzzE36ZWhv/nSNhs6arOQEpRlT55sEXYW37uWQiMbkVNBETZ3KNls
         WKk7ehPB8SwfD5et5kapelGEv6MjmLLBTr542/VXrIyCgXIt5ScznzMTeAelDW0fQHmV
         N/2G1QPoiX7XZosCf8yzdjq+LmqiKqke2r59sAoz60U8RxZCPizzptaXpGXd9f7ZUm7c
         H/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739740685; x=1740345485;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhoUPCLiY1qh5FXsY34Sd3WQZveC57swlGT7d3QX6KU=;
        b=ooyyiymvzC+ltP0zGO6nzzLwbdvuLiOW/C/WtJ4CKmB9cCTrcziSRr2IjQlenKh26J
         WG9+a1VGBoIpJZDYvrlHXkfOUw2Y24b9IB577O8d+W71prXUM7e6aDq4vvv1DFt9LAtr
         hONXkcPguOmLa8rvgQr/FTVx9JwnHrOksrXgPbc8NT3rDyJpk6gXLiIZbQTD9ttVgttW
         pc1qObCzTIBIjWDCKuFWngqwa866pB4Y/cVvTRjQlSuvjsp9fAn55h8J1nlcHNHgvyuu
         dZKzus76OvZgyYFSajbtHW30li+sIam4Ot65CemTcBaqsN5n5ogHfhGzNNIROy6wNrxg
         KziQ==
X-Gm-Message-State: AOJu0YygIyVazeAMywPatNQvwH4/Y9ubA/PQqHwyej1ZzXdEWFj6Xbhu
	fROdx9zgBRvrMYWe5IC0hz7la9CU45qU7hwVWezinNr32fbLWAZ+DGQcSscC
X-Gm-Gg: ASbGncvl0gjs5c/Fqt+Ipq+YdJ7OClU/ArvTFXusUsgqEMSGT4/aPfkukNZvcVwnKyx
	CU5E/4c4DrnW3pro54YuD97eu5AajNm73vATX9hfvQOY1l4aiLZU81FDddwXZV7Xi+KhSW41OCd
	zhMOlUYUnem9sRrrJL2Bu5pUGgwDym4nubgANVDfL5O4BwGM2uIKbWELA7YPoQ8Lb0iHDb0r1jR
	p4239CW2R2bSQr7SYVuILNyLaWNTqiG0WqK3ODrdtHBsSFP/TTkpbBFuPa82AG5NFxhwSYcFcBg
	cb6vzmc7TF0tx7JXkHvSEl/vcg1TE7HfG7qpL+BwXjSYxvBTeXGUZgqqVbI/FFG108BX/8Fe/cm
	F/HqnF0Cir2mkQdVnMODpqYhaRFv2Qk05JeuVMVGcmfv3q9hBofOHakAX55WcwxLYFp1QZ+seT9
	PmMmnfd8k=
X-Google-Smtp-Source: AGHT+IF+NvhDQ2ITV8ASlNNs1ZQKEyM/L8mjFPjpSWdnMqbhTtvsBzMTieKQRJCiCq+wVbkk8gFH2A==
X-Received: by 2002:a05:600c:46d1:b0:439:6712:643d with SMTP id 5b1f17b1804b1-4396e6a74f2mr60933265e9.9.1739740684747;
        Sun, 16 Feb 2025 13:18:04 -0800 (PST)
Received: from ?IPV6:2a02:3100:a14d:c000:1d06:77f1:27f3:ba49? (dynamic-2a02-3100-a14d-c000-1d06-77f1-27f3-ba49.310.pool.telefonica.de. [2a02:3100:a14d:c000:1d06:77f1:27f3:ba49])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-439858741e9sm6106095e9.1.2025.02.16.13.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 13:18:03 -0800 (PST)
Message-ID: <e95b9dad-24a7-4e3e-9af9-6f0770cf1520@gmail.com>
Date: Sun, 16 Feb 2025 22:18:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 4/6] net: phy: c45: Don't silently remove disabled
 EEE modes any longer when writing advertisement register
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

advertising_eee is adjusted now whenever an EEE mode gets disabled.
Therefore we can remove the silent removal of disabled EEE modes here.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index dedbdcab8..b19055cfc 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -683,13 +683,10 @@ EXPORT_SYMBOL_GPL(genphy_c45_read_mdix);
 static int genphy_c45_write_eee_adv(struct phy_device *phydev,
 				    unsigned long *adv)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp);
 	int val, changed = 0;
 
-	linkmode_andnot(tmp, adv, phydev->eee_disabled_modes);
-
 	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP1_FEATURES)) {
-		val = linkmode_to_mii_eee_cap1_t(tmp);
+		val = linkmode_to_mii_eee_cap1_t(adv);
 
 		/* IEEE 802.3-2018 45.2.7.13 EEE advertisement 1
 		 * (Register 7.60)
@@ -707,7 +704,7 @@ static int genphy_c45_write_eee_adv(struct phy_device *phydev,
 	}
 
 	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP2_FEATURES)) {
-		val = linkmode_to_mii_eee_cap2_t(tmp);
+		val = linkmode_to_mii_eee_cap2_t(adv);
 
 		/* IEEE 802.3-2022 45.2.7.16 EEE advertisement 2
 		 * (Register 7.62)
-- 
2.48.1



