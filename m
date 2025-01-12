Return-Path: <netdev+bounces-157530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDAAA0A989
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCD01886B4C
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DFA1B4254;
	Sun, 12 Jan 2025 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjDVcuFu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCA1B4245
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688452; cv=none; b=LE/PU78vii8SN3PMchkdP2RwDyeQSiE1EytyqokjzG4mPntE7nf7VY3STrINivj6m1YBkRdeIlAM7HMLFXXDmfvAh/TYHwC7I/VBkCKqa4/jjOkcruF3bWyKnpjZu54TXFKN1Qt5B8mZ+Z4sDDosqY94K/Be8OnNBkD567iO+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688452; c=relaxed/simple;
	bh=EWAYERHtUNysaHjwIGobdCdTOhWtkr0aHok8S4aBOnM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PYGmcKFlsrGULJuAaLEHzQ+sWQAtU2ja+eoP/UYA8VfptU+Lq96adqMbz5rSWjnx/KUDqMMIlbSE5H4p93pdS1yxvlEJgsTGWG7IEAted5jCNkPJWwNl9C3r8v//9ChMlOrlJ7rA3JgaWGUOfgsuNXsskX+lIg2fxBuMxamTwVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjDVcuFu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e06af753so1805372f8f.2
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736688449; x=1737293249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1vMWGZGJB0wSpyvnBU07N6sSx7cJJIas5pZC5dMSmqM=;
        b=EjDVcuFuFw+2uCrt1GuATMn7FotJ4q1GdZq08Zt9hVg04WCpAc5tTUTBsU9KKmAaw3
         ++c1wwg9A9VNtYAxW+xRR1N0qHbELJBZvz4FtazHKC8IMAwQygs+GxBGNGI6sXvphRPm
         HEEWajma5lJIeyMiARhuz1/f+/PctiZKi4CzAq2QuX2RrUppSyER2x7EqW/xdBvYnpzp
         zS8kVyCa1cDQFsJWiMefM4Au9VPX9dDsEk7Dhbc3AX3oW5z6g2yMFnfDshZmiT+8f2kW
         0xoe56mDropVoEJt6kGMbkKMfW+aeyQpAcGt70zemqd41wXpudaoH2NPlCKXYqiLzQzh
         nHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736688449; x=1737293249;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vMWGZGJB0wSpyvnBU07N6sSx7cJJIas5pZC5dMSmqM=;
        b=Sbh7roj2gagENYdIjej6vWNf33Oql0gpxg79y+LTIvmDpiSmUNl81WGKCP+++jsxQc
         66uZ0KOaad4mj4l6ZHTkpWx4xKegW3SaSpSDavfUS1+J6Qm8RSRWb3Nb5VDKs6XodX0a
         /5xd7UVBL+QijLSgrGd2p32gv6GH3yq0tPX3w0auRaHd3qa8t+nhk4t8uGN6DctEhHxw
         ciPlGl566Lyvmc/DFe0jKdZ65BIAqVhcA4phS0dYhvY0lmUnXAWTh4wxhA/yu5qsigFc
         MSUr1P6V8+/zFchskM/J+xCH+1B9jFh/roFryWwBHZ7M4XFlwWtfuRu5+ORN+DRagpWi
         oWDA==
X-Gm-Message-State: AOJu0YwFQNYhA8Nm+XThp7C6oaesisW+LaizzrJuNL4H/6znId/9WT5q
	9ZZxmy3LRo9Wc2q8wHTkdFTjY0p31BsfNIiOxy0yWGRMWeg2cfFi
X-Gm-Gg: ASbGnctbFEPfoHxxDkNeldcjlobFk4bfaUR+t/RocQU8mKZa7Fo+nIK8329bPcl+CI1
	qhWi/4Jt3qFBVd47f+l3RDtjgFeFgttgf9EZGaBBQFgFokYEPKsSale5Qu+A3+8oCV6GslfCHYB
	UBCx9fXocAacVhCPqO1KB84+pUPSTXt2bsY6kKUwGoIbTdUJNSorrnsgaut9dPJBkFWDD5FXf0c
	IXWx7XYNFFW9E/wT6gLlWIwt+89z8OkmGqfTUd38V+VJnWTEb5PAogILjd/v2XCcXlgrISlIWI3
	8mP6+8Hns/fWUoRw3CBCqZuosLL7uRE/eDus0fhaRNcSagw/o3beuN4GSEVT4Cd2O9yU/UalJMN
	aLnZMDr1/efKPCjRWExdiGBkKpo5T6PfpzOP7+A5L/PcQ7E6G
X-Google-Smtp-Source: AGHT+IFRjCywQUlh+gniNfaDDfFFshtq2YtQ2b6/h+k9nExpicjcbnfOLOtSA32H1C2uQJ8wXwOuCw==
X-Received: by 2002:a5d:648b:0:b0:386:3e3c:ef1 with SMTP id ffacd0b85a97d-38a87312f36mr17399474f8f.35.1736688449018;
        Sun, 12 Jan 2025 05:27:29 -0800 (PST)
Received: from ?IPV6:2a02:3100:b0d5:ab00:44ab:526d:76d3:604a? (dynamic-2a02-3100-b0d5-ab00-44ab-526d-76d3-604a.310.pool.telefonica.de. [2a02:3100:b0d5:ab00:44ab:526d:76d3:604a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436e2e89dfesm146376255e9.32.2025.01.12.05.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 05:27:27 -0800 (PST)
Message-ID: <95ceba4a-4316-44de-a36d-fdffb8dd8626@gmail.com>
Date: Sun, 12 Jan 2025 14:27:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 02/10] net: phy: rename phy_set_eee_broken to
 phy_disable_eee_mode
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Consider that an EEE mode may not be broken but simply not supported
by the MAC, and rename function phy_set_eee_broken().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 6 +++---
 include/linux/phy.h                       | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5724f650f..bf368b32c 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5222,9 +5222,9 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 
 	/* mimic behavior of r8125/r8126 vendor drivers */
 	if (tp->mac_version == RTL_GIGA_MAC_VER_61)
-		phy_set_eee_broken(tp->phydev,
-				   ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
-	phy_set_eee_broken(tp->phydev, ETHTOOL_LINK_MODE_5000baseT_Full_BIT);
+		phy_disable_eee_mode(tp->phydev,
+				     ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
+	phy_disable_eee_mode(tp->phydev, ETHTOOL_LINK_MODE_5000baseT_Full_BIT);
 
 	/* PHY will be woken up in rtl_open() */
 	phy_suspend(tp->phydev);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index c5dc2dbf0..7138bb074 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1318,11 +1318,11 @@ void of_set_phy_timing_role(struct phy_device *phydev);
 int phy_speed_down_core(struct phy_device *phydev);
 
 /**
- * phy_set_eee_broken - Mark an EEE mode as broken so that it isn't advertised.
+ * phy_disable_eee_mode - Don't advertise an EEE mode.
  * @phydev: The phy_device struct
- * @link_mode: The broken EEE mode
+ * @link_mode: The EEE mode to be disabled
  */
-static inline void phy_set_eee_broken(struct phy_device *phydev, u32 link_mode)
+static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode)
 {
 	linkmode_set_bit(link_mode, phydev->eee_disabled_modes);
 }
-- 
2.47.1



