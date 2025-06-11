Return-Path: <netdev+bounces-196699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E447AD5FE8
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD35E1796E6
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC222BD01E;
	Wed, 11 Jun 2025 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeOSckus"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439B2222CA
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672680; cv=none; b=SPISJ8eZlUj7AOUfAOHijoRx02kx54bVe2Rkr100s3UHFnyQE0wBGy77uO4/rRN52Fbs6R7G0nZK+W+uXj1vvfHEcsxdYKB8JJsV55f2EC0YQS+krGcYlKDRTeEQHkLppThcjEHPHnu+QmDK6iScXZK+GWxINrCdUzsaZX8ACXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672680; c=relaxed/simple;
	bh=Amjk5kIE1xMiBDJvW719tIQr9JPNuya+sXUUd5aAZKY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OaRLM0RWKlhuB6wjPwKKzJ8JShA9xKpD7n5BUJP3356pYncfkMy2I0XSBz6VHxhmzM7qox1A3CD+QXc8OWkdadJNUnkDk0afxLEbk/wdjwmSgi1neS3HfTmhwYwBdl2ppSSLJ85vWoiL1xfI2FB8+oQYdd1ndoSbfN077Tdt27M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeOSckus; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so153276f8f.3
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 13:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672677; x=1750277477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/Loo4DGKi2IZxX2RI+LHypN4Yrlt44s2v+c+f+gSRYk=;
        b=XeOSckus6aV2oRQ1lqkasGdvdn5LVSQ7/QPzdUdNAcY6np6Ume3E32Ij/+HMcLtv/B
         YEwIAbYAGVcrODX2zkwR0uLVKp0zSsHbYeazGZlzSA2qyK05NuvlzrqXpYup6zpnppuz
         EdfKlCkMpDwWsHEy1ZSMvFW3SHjOv5Bs86XkpwEzzzgjLQ/92ogIPRVi7ABTORKClRAM
         tg1f2F3CFci26LvFf9j7A8kfbA0ErOgJulZX4D6SePKdCN4loQ5cLicwmmUE7TccHoUf
         Grm1i2uUdVfXmKSkrG0QMLjP7dy8sZr8Bo9nR23blm19pVomVQ/6SrhOtfXjIiqC7zsn
         o/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672677; x=1750277477;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Loo4DGKi2IZxX2RI+LHypN4Yrlt44s2v+c+f+gSRYk=;
        b=fWx8ZDzlCbFoIsIAO51KEyN04eQashV90e5HQODyZb7SR0Zm4R1OEsLcVh8iwb+YX3
         x3Yk0nyuTlULb7owWVnB74jEizAQ7Eq+c64bW9QUcYHaXuuoOOASq08Q6FOc081SrdQp
         /h8Uy900+pD5o24vYnTsN3P3S1vzJEOvGcf+D+eZqygEagR86Pg5IlOogRZDxOEKxHNs
         bcmdSQD/JHpVi3le43vVRGZW0UvpmSDtouwW7f8Ycr5gdcdlIQ1DSxdd7D2Td6mn48nU
         Q5wGz2YdkBkMmKneOLQ+Ys4YYDNQtHAh+GrYz6/UmzuBF2mQbJ4kNfTHZtW/EsU8wYlg
         Ef1Q==
X-Gm-Message-State: AOJu0YwpdYUCd8EJfJR45JFpciMux0gQDmKHkQJvYKhpWAlg9uoBM07h
	k1o96Y7tzW+ujEdaWUBNDxIkko/UY6iHyKBQMT6RapSNwmlP+cKvX2iy
X-Gm-Gg: ASbGncsOjyCdFZ7DkWeyYuo66QBBmwhSnPKHDl/WYBR3PNMimK35dKWckQyKskRz2pM
	iSvCF6uGDwF0dHNlsBvS0V4bLoyVZBhejvBIW0NimDEG4c/6eYbLEFD0mCvNYJTqoJqeNXpj3Ms
	1QgqUrzVs+LmNnfTG90BI17dQGgv47E85Ghk5E8TNpcek89jyMiXAKy2QNZXWJbfa3U3lbbA6HK
	/fUNsNQ+1uZ+1R8oelWz2QxyyxrwmAEjF0bHhg7gz93epO/IgbnOTdMpU8zzoORIwRB8O0S8Wbp
	JUfbj9uzJxeFiGlenmrQln7fmry25WJojA1dkf26vkaUAGHu3FJc9qQbo4J7TSCmplcUWcgOEjY
	UXAzQFLjGOw3SpNsYc7AcCcDOsbdfPwi2qXBS1NI8QVMKfCqu2Cok8e5vUhdKNFZU21OIYIsG4o
	7tqWyfUUEAKrF36hBfKgsZS81hHQ==
X-Google-Smtp-Source: AGHT+IEU7bJtA3FcHUoqQPdWTR8uzQA5OkYZ/yKQjMk1AT6xBdeFsYDlkwYe6e7LxpC42lux0q2FzQ==
X-Received: by 2002:a5d:588d:0:b0:3a4:f6b7:8b07 with SMTP id ffacd0b85a97d-3a56075c5aamr598675f8f.48.1749672677213;
        Wed, 11 Jun 2025 13:11:17 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1d:5400:69f2:2062:82e9:fc02? (p200300ea8f1d540069f2206282e9fc02.dip0.t-ipconnect.de. [2003:ea:8f1d:5400:69f2:2062:82e9:fc02])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a53244e0e3sm16553433f8f.68.2025.06.11.13.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 13:11:16 -0700 (PDT)
Message-ID: <86b7a1d6-9f9c-4d22-b3d8-5abdef0bb39a@gmail.com>
Date: Wed, 11 Jun 2025 22:11:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/4] net: phy: improve mdio-boardinfo.h
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <6ae7bda0-c093-468a-8ac0-50a2afa73c45@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <6ae7bda0-c093-468a-8ac0-50a2afa73c45@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There's no need to include phy.h and mutex.h in mdio-boardinfo.h.
However mdio-boardinfo.c included phy.h indirectly this way so far,
include it explicitly instead. Whilst at it, sort the included
headers properly.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio-boardinfo.c | 7 ++++---
 drivers/net/phy/mdio-boardinfo.h | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio-boardinfo.c b/drivers/net/phy/mdio-boardinfo.c
index 2b2728b68..b1e7a5920 100644
--- a/drivers/net/phy/mdio-boardinfo.c
+++ b/drivers/net/phy/mdio-boardinfo.c
@@ -3,11 +3,12 @@
  * mdio-boardinfo - Collect pre-declarations for MDIO devices
  */
 
-#include <linux/kernel.h>
-#include <linux/slab.h>
 #include <linux/export.h>
-#include <linux/mutex.h>
+#include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/phy.h>
+#include <linux/slab.h>
 
 #include "mdio-boardinfo.h"
 
diff --git a/drivers/net/phy/mdio-boardinfo.h b/drivers/net/phy/mdio-boardinfo.h
index 765c64713..0878b7787 100644
--- a/drivers/net/phy/mdio-boardinfo.h
+++ b/drivers/net/phy/mdio-boardinfo.h
@@ -7,8 +7,8 @@
 #ifndef __MDIO_BOARD_INFO_H
 #define __MDIO_BOARD_INFO_H
 
-#include <linux/phy.h>
-#include <linux/mutex.h>
+struct mii_bus;
+struct mdio_board_info;
 
 void mdiobus_setup_mdiodev_from_board_info(struct mii_bus *bus,
 					   int (*cb)
-- 
2.49.0



