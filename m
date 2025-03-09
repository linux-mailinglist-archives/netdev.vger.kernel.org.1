Return-Path: <netdev+bounces-173368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929B0A58806
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 21:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DA016A506
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 20:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84CB1DF279;
	Sun,  9 Mar 2025 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtN2py/A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AD81DE4F8
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741550657; cv=none; b=AiRdrav52M2Gj1efdyabQA2Yre9C6z1AvgYdMN+L+XRIaagd9Nj6M8TunsZMKQD4O6gE+VK6FuvjfK4/OWWMtlHAmd/qAcqbQqmW2JuILIZ9mVRhfORc7X+GREDOAkPNcNiGHgTG22A95/TsL3LUErjuaX+Q5RI0Wu2YtdLYi/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741550657; c=relaxed/simple;
	bh=wbr4MY31EKpQ2TX7Ee3BSdhjlYHyQiBSHL/fS5nd5sE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CYRcJIPL/6CoITG1VBNSr4tO1P3RUGDGQrzZsKeSTpWQAO1xb6DwNiW5W1mWjVrpM32T4yZiphcTkDUpP1whEa9d9by8RV5CJNGtiGXeBd06DnhyWT6WTiYqB1yW8o684I6BLrtLl7Tv2JHC8Mdwtss7Ebqq+dMLCLKMaHDsYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtN2py/A; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso830887a12.3
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741550654; x=1742155454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0byt4gDK/kgG9gsQAfI2cA8bWzPc+LU1fgloMyPs1pk=;
        b=YtN2py/AM977+vi0bGZ2deJOQeNuX7k07jNXWQhKycDtuFHktLieZ1Bdn4WoPDVPtH
         jxMbYRq9nGaABHWvL3I01lM+Q5zJeSAEjFGs5i8JSDHjPjGW9YuwWj/spMfVyVneuVok
         8p/5tr4KOT6OYO5ohyXWKeMO2H5a6dRJF9qYUumYBiMJHncSe1AcfvVBNP62vIV+8JQn
         ScHaRGALJf5+oPMMs9b/K8YY/1wofHyZ6VnWmvr5dCS0fgikopRRFpdqcdAmNSAare9n
         o6jrzKTflTkVAwXh0Gh9c9D9jnTQQyKNZLpxkzbtFq8kzY8ZmQqFMJAY+bYaZuSNe59u
         eY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741550654; x=1742155454;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0byt4gDK/kgG9gsQAfI2cA8bWzPc+LU1fgloMyPs1pk=;
        b=YNgz71kBSxPmJBXJcs3ScuZyqBhc3zQNBq3SK+M4r2d9R1I0Nhj9/fzOIDlvf0NYpb
         jTagUKd8rUjH+CBHYQjSL1oDCn7mJHDVXHhgr415dwJQ51jLsZTQKtFum8m4wjvGErWF
         oRCzv60hV4TUdN/PhQtKMuC/EB4bvKSCWJFdaSg4a1HLY8VZdmbpW1vFer80gj9d61SO
         /LFMW2GMbSwlL4e7AZGof3fm5yy/bs7kSpJbI1zAWadVdnsMn0IYl6shnXPKNhez1kYG
         NfeI+S1qmIG8OuUWH8dUtvcZ4dx0htY8We5PYrfh/xEM6mGG/xcEpmISR60nF2o6Fr0f
         4Qwg==
X-Gm-Message-State: AOJu0YwB4wDkF59cp6FZIlfuyFe+geLeMvm1u+4gHr8Zhw08qTK4EBUQ
	/WfcRy5cXtm1HKYbSwAkfg37BzopENNLaVo6fMpSgnOROPw+3Gpx
X-Gm-Gg: ASbGnctlIKH3mi3+FtLAoEJt8m064vWk8lhOE+B4rWa9f7nqFL6FAuMYcvXu4gGHOyg
	h8VoBAw1vkyf791TmzG0EqwIzw1cHJL33btzYx6jQDMzmkV15pF1OCTEbgnOKiv0oINeHpOESfG
	7RtvjNT7FB4W07jE+EnbvJZiF52Ejsvf/C5IC8ApG52cAisIEEMUPFErCY9V+zGGeNne/2Dr25a
	ik6/hw5h/r/7dah3MCnjuABEczaWIw5UtPREtjKdc46ucQg9+2EFMYTTF0aP2umMIZauvGMPync
	eZ0/Dt6Zl85Uu7RWQqOrwuyi7eYYorkIV4rcG05i0kqRWozdWGXExmiq1mUWWX2pb0rgFkIzF6/
	gY/WJYUVbhpVC+o7Dv+PByfG/QjUjmeVbKo8vL9y/symbuYrEs0JfkYj8yf91lL/grVqkJFUZDj
	pyHGPpc4Bwa83+oPR/oqhQsOMR1yWuETfrZ1fH
X-Google-Smtp-Source: AGHT+IEHewNJn/areRDcx+XY/KvVjsZic58iykixCUtfNPaM/feZI7SLRUnRULwc+kop893PoFNtZA==
X-Received: by 2002:a17:907:720d:b0:ac1:db49:99b7 with SMTP id a640c23a62f3a-ac252ff84c2mr1398267166b.51.1741550653995;
        Sun, 09 Mar 2025 13:04:13 -0700 (PDT)
Received: from ?IPV6:2a02:3100:acdd:4200:b9d3:2874:813c:4af4? (dynamic-2a02-3100-acdd-4200-b9d3-2874-813c-4af4.310.pool.telefonica.de. [2a02:3100:acdd:4200:b9d3:2874:813c:4af4])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac29d5f1895sm81096366b.16.2025.03.09.13.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 13:04:13 -0700 (PDT)
Message-ID: <406c8a20-b62e-4ee3-b174-b566724a0876@gmail.com>
Date: Sun, 9 Mar 2025 21:04:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/2] net: phy: move PHY package MMD access function
 declarations from phy.h to phylib.h
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b624fcb7-b493-461a-a0b5-9ca7e9d767bc@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <b624fcb7-b493-461a-a0b5-9ca7e9d767bc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These functions are used by PHY drivers only, therefore move their
declaration to phylib.h.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phylib.h | 6 ++++++
 include/linux/phy.h      | 8 --------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phylib.h b/drivers/net/phy/phylib.h
index f0e499fed..c15484a80 100644
--- a/drivers/net/phy/phylib.h
+++ b/drivers/net/phy/phylib.h
@@ -15,6 +15,12 @@ int __phy_package_read(struct phy_device *phydev, unsigned int addr_offset,
 		       u32 regnum);
 int __phy_package_write(struct phy_device *phydev, unsigned int addr_offset,
 			u32 regnum, u16 val);
+int __phy_package_read_mmd(struct phy_device *phydev,
+			   unsigned int addr_offset, int devad,
+			   u32 regnum);
+int __phy_package_write_mmd(struct phy_device *phydev,
+			    unsigned int addr_offset, int devad,
+			    u32 regnum, u16 val);
 bool phy_package_init_once(struct phy_device *phydev);
 bool phy_package_probe_once(struct phy_device *phydev);
 int phy_package_join(struct phy_device *phydev, int base_addr, size_t priv_size);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index c4a6385fa..fc028bab1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2107,18 +2107,10 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
 		       struct kernel_hwtstamp_config *config,
 		       struct netlink_ext_ack *extack);
 
-int __phy_package_read_mmd(struct phy_device *phydev,
-			   unsigned int addr_offset, int devad,
-			   u32 regnum);
-
 int phy_package_read_mmd(struct phy_device *phydev,
 			 unsigned int addr_offset, int devad,
 			 u32 regnum);
 
-int __phy_package_write_mmd(struct phy_device *phydev,
-			    unsigned int addr_offset, int devad,
-			    u32 regnum, u16 val);
-
 int phy_package_write_mmd(struct phy_device *phydev,
 			  unsigned int addr_offset, int devad,
 			  u32 regnum, u16 val);
-- 
2.48.1



