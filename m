Return-Path: <netdev+bounces-166218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ED2A350B1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 22:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603F316204F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 21:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BADD266B6F;
	Thu, 13 Feb 2025 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH+5PQ+T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E35200132
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 21:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483329; cv=none; b=cfoGkfnoy3ANQws64z4OcmVAx+vv/i2BnhIvxoZXZvRNphuw06HIUqBnpZV+I3gVsFD0TnXOeBSsouzgsERzwIAYf9uvPMsIIk863+4mwtzk2BBBrFC+N/cjc3nvP1NWwaXAwbyGOZ5mp12wNhKY7LFsetkQUEGAgfdtpV+5Y50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483329; c=relaxed/simple;
	bh=3ng2k+vsaRTqhuQp+8rlHVCqdtQycv27IfJnSSZDulk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ys5Vf/LdBwsyQbQwgun2KXSKtZI5ICcTWCv9YX04l1uBHs4+kDHFKr5SC3LtEO0SMfPVBmw4+RGHK/hKC1v1W+qOLPpUIq4NI2IrlXazYKxyTb0cm7NhUfkWLXIbpElH3+KA+1dj6DIC0hWj47Ar5v9lD7tFn/unfkMN635DadM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH+5PQ+T; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7cc0c1a37so262645766b.0
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739483325; x=1740088125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WrInHI6x5g7wz8uecKXZn0Eb/BTtMocQUlkdMAo/LSE=;
        b=PH+5PQ+ToCanlwHqdNQEeS/6DyIWdsbCTToFPCxmZnPZS8qC8DVBkhu+vkrN2uhEIN
         5tje5r+vuGmUBbDkryauC73PQQJyj6AMbeNBXheO1jeRpy6XZo83dlFvDVDAsXAUaSBR
         uh9uqhSjTsZev42gcuR+hrwwxI2uqeojScxRZKdJIaKtUJAI2y+5OLeO9Xx25EUtI0mg
         IA+gLsJFV3nqtKsvMRV3lQy7QxPZX0id9vx8dPox6zJnnATOwyKo9JqVSk4VdV+A1ZM3
         W0WjNzgRloTColVEYRn8eAMMGqDiLF8AnKJmlrpAvIfgeOpQp8pv+DjyAfi+53Il6P02
         Q04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739483325; x=1740088125;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrInHI6x5g7wz8uecKXZn0Eb/BTtMocQUlkdMAo/LSE=;
        b=GyTIvFbwZmEAiL83ydYDdYPID4c1CPThogEH0QR22pRUNkK0CMMCZpmwhgGPyMlDGt
         nj6gxP0EBphA5zA44IBDCS9Yo3EetY3Sm7bRyoIqeNKM2+w+4uE4lunex8UXRA+A/4S6
         k4zFbt/VRj0fvnnibY0SYy6oL2hZXLot1hp4jiNGSpN0vMqEPM1W+GgDOXF5/CZg0nMe
         u7GEkT03rMN0/eFMeMTlzHh7xVPz+bcRQ6/3NmcFhkbTn4tKCpMBgoRZ4RqUQvtIxa/8
         HC01fNTrWBJdDL6Tg3PSOrnXxiZBomQcRzfwixjs3JEHsItmLZrGEOceLDRjLBEnKDo7
         s0JQ==
X-Gm-Message-State: AOJu0Yy1Au4BUVRWIei1gD4CLaEkEP/bMP/oOfnSu3FjggaEjPYeO+FG
	wvCCFh0fJa+dv84KPDGBWu3c2/LkaI2Jcs49RnFiZKcoThaPAh9t
X-Gm-Gg: ASbGnct12BWRRBy6i/lqXh9rjd/hBeNxrkNPnZMH4DuVODXx/JeTW/btdZLh3A43YEe
	MAI3UqKfvaDY0N1qdD9ZoFmVdCuEFCTCATltl1bTWLXXnpxSIZ2y1PJFLD1XbG4PiiX+MPdqMTj
	CUjWWj1C0r3L8DRT/Jd86tPmAQiqR974mYgPzhnQBm8XuEOkGdEfUTWhglLgrKtu1Pxj+C8aTLK
	E3G1QT2VR3HVeXJFtlKwox/uD7Ege0Y7jJ3qfrry21mfbY4rxaWCRMHMXcc93rChYNNDTc4zsEK
	WSIUXPyWqN8EF0PlhDfHHrIXBBc48z+ErywSMllkL5dsWHxFOMe2bs+dPK1oDtCBF8q6/87l8ZL
	csKHEj7aqu75SlwbHezMnL04f1OPhgKWobGa4vfgIppU+YSvPEqKL5zJqhWxgDBOdxvXxu9N8ng
	x/XEf/
X-Google-Smtp-Source: AGHT+IHhGL8Ot8KXZBMQlMim51xzcgXrx9A57jkgfyjcJtoHHV/iUD2RiohrjFDKrEqm9kR+dRja3Q==
X-Received: by 2002:a17:906:c110:b0:ab7:cc00:4d4a with SMTP id a640c23a62f3a-ab7f347eademr697276066b.35.1739483325387;
        Thu, 13 Feb 2025 13:48:45 -0800 (PST)
Received: from ?IPV6:2a02:3100:9dea:b00:8140:d035:b1a4:911d? (dynamic-2a02-3100-9dea-0b00-8140-d035-b1a4-911d.310.pool.telefonica.de. [2a02:3100:9dea:b00:8140:d035:b1a4:911d])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aba53258215sm206454066b.53.2025.02.13.13.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 13:48:44 -0800 (PST)
Message-ID: <01886672-4880-4ca8-b7b0-94d40f6e0ec5@gmail.com>
Date: Thu, 13 Feb 2025 22:49:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/4] net: phy: stop exporting feature arrays which
 aren't used outside phylib
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Stop exporting feature arrays which aren't used outside phylib.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 22 ++++++----------------
 include/linux/phy.h          |  5 -----
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 14c312ad2..1c10c774b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -91,37 +91,28 @@ static const int phy_all_ports_features_array[7] = {
 	ETHTOOL_LINK_MODE_Backplane_BIT,
 };
 
-const int phy_10_100_features_array[4] = {
+static const int phy_10_100_features_array[4] = {
 	ETHTOOL_LINK_MODE_10baseT_Half_BIT,
 	ETHTOOL_LINK_MODE_10baseT_Full_BIT,
 	ETHTOOL_LINK_MODE_100baseT_Half_BIT,
 	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
 };
-EXPORT_SYMBOL_GPL(phy_10_100_features_array);
 
-const int phy_basic_t1_features_array[3] = {
+static const int phy_basic_t1_features_array[3] = {
 	ETHTOOL_LINK_MODE_TP_BIT,
 	ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
 	ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
 };
-EXPORT_SYMBOL_GPL(phy_basic_t1_features_array);
 
-const int phy_basic_t1s_p2mp_features_array[2] = {
+static const int phy_basic_t1s_p2mp_features_array[2] = {
 	ETHTOOL_LINK_MODE_TP_BIT,
 	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT,
 };
-EXPORT_SYMBOL_GPL(phy_basic_t1s_p2mp_features_array);
 
-const int phy_gbit_features_array[2] = {
+static const int phy_gbit_features_array[2] = {
 	ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
 	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
 };
-EXPORT_SYMBOL_GPL(phy_gbit_features_array);
-
-const int phy_10gbit_features_array[1] = {
-	ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
-};
-EXPORT_SYMBOL_GPL(phy_10gbit_features_array);
 
 static const int phy_eee_cap1_features_array[] = {
 	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
@@ -196,9 +187,8 @@ static void features_init(void)
 	linkmode_set_bit_array(phy_gbit_features_array,
 			       ARRAY_SIZE(phy_gbit_features_array),
 			       phy_10gbit_features);
-	linkmode_set_bit_array(phy_10gbit_features_array,
-			       ARRAY_SIZE(phy_10gbit_features_array),
-			       phy_10gbit_features);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			 phy_10gbit_features);
 
 	linkmode_set_bit_array(phy_eee_cap1_features_array,
 			       ARRAY_SIZE(phy_eee_cap1_features_array),
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 96e427c2c..33e2c2c93 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -54,11 +54,6 @@ extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap2_features) __ro_after_init;
 #define PHY_EEE_CAP2_FEATURES ((unsigned long *)&phy_eee_cap2_features)
 
 extern const int phy_basic_ports_array[3];
-extern const int phy_10_100_features_array[4];
-extern const int phy_basic_t1_features_array[3];
-extern const int phy_basic_t1s_p2mp_features_array[2];
-extern const int phy_gbit_features_array[2];
-extern const int phy_10gbit_features_array[1];
 
 /*
  * Set phydev->irq to PHY_POLL if interrupts are not supported,
-- 
2.48.1



