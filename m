Return-Path: <netdev+bounces-173369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234A3A58807
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 21:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DDA16A656
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 20:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1372D202999;
	Sun,  9 Mar 2025 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPWuKxOj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4461DE4F8
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741550714; cv=none; b=CNdaWeygnE9/xNi+rtBac+EZwrDIbzQjWiOs1ZWUE2POan9G5EBnSQdADTIjgeW0QMdo5fl7QVDhInkT44K9Shjiu1Y1JstAo+RBIDwARIqPikEOCeoDj0CnRjTkdy2Qdl/RugPVBliCFu+HMhg4jmo8NOZpDdvBtA1aMsOyCbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741550714; c=relaxed/simple;
	bh=nHrC+HeXpAzhQOFH0Xf7hg/nmnJel2G+TxnhR4Pego4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=N9Cy518UnAcr3TpQQx1M8GGoiyTfm78QnSJ5s9CVub1mR+3qSLp8LOydsDsZYiAsFE+DUcNtlmBPriLAV+vz9DZwhKyUA5oWjyFy4XTuEwOMlxn2B7NAsXpbsSVXvCAToVamO8kZkCUvTZa/vzBD+hSD94NG1jQD6c3ez6DfNWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPWuKxOj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso5871506a12.3
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 13:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741550709; x=1742155509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PUnsBjKaLN2LaCwdQEJkCaCqE6e+H1E9B5AHeSYkxe8=;
        b=FPWuKxOjuem+sXMOOVLFBwYD4nciIvkqOOAaK2J1o/2stJg1N9MkJpFHAiJVr5I6yD
         f3mXLDd3sw9lt/9ejFS8I4OC/2yV33aOioPPR1bxklyPUfod1HoNmJniYB11DMLFPX14
         B9XHifKy0hpTyePPCZhQvirqA/OR0lOmngiNKlryxWGeXVZy0olbJgd7lzlYM1bj8U5+
         lixsa/sUqEYckhqUgUPc6sRarr8hBz/HB7H0WdVEQX3PWFGfdOcsr2LJ8AJjvjtVXvUu
         nPuSB1x6p0VSCFQO5GYmOl+QbBwT5fHC3whghWBlUmHOwwuuSbLIHgzGcLVYiDoZ5RuW
         OTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741550709; x=1742155509;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUnsBjKaLN2LaCwdQEJkCaCqE6e+H1E9B5AHeSYkxe8=;
        b=QqsYKGYk3agtiy1QI/vDVX1u87oDlPXocWeALoqTf7pok0NgIln7OiMjm51VLcBA23
         i8olY5i5PAsmVz2svCtEwjFk5AJvwH/KREXArZqOVPUXXIWNbb9fHvHXKcmemYFELqZn
         17dK7C5jmsiydpMh9vQwc7Eaa8W43ZYuwWPMG9ragSuAZC4YQ2jim+PXiRMTHFlhUNKj
         Cv5N7YxtxDYE97cfG7E1pQcOBtxau+GDgXHusF6zCzW/kOWsFwPvCC6c2xEmjUILYbak
         OGZ5bOM7U11uXIBy02lEeNeswMTS10JlOZ4yvo/YcSX1Ixsol0Ar8xWeYXz1mO7Xgy2T
         VELg==
X-Gm-Message-State: AOJu0Yzti8FhfBy0atblnMU1r+ChJSIwIzBQi+ie2HiODw59GamtCS5Y
	qM1JYVWpV5+DGa603lp28gez3NO3qwyz6vH9ZX0X3blVj+UQ61Y8
X-Gm-Gg: ASbGnctgCWKSxX4AfoVa28T11xYaRfEcKauBBg9CmCL4CvVRMG+83UBAwu55KQClCiC
	kcPDqs3+gPVzT7hVCZNO5OwaGCAa53j3glldaEu9eeYE4gMxAyeaNdtKLsoOmi3qjtL+JyY2rqV
	YN4a4Mo0r5dkIf9WWMCejQniGj3NxXLs+jLlUNoMQe3Iv1XCKUq0MKcGJHx8h83mIbkDkwSEonm
	qwFu5KpdkVLgcupXwImWWkOgMvzzYN+H3G6FM4412kcNF9G5kobhjm7FJ5pnww8doDAt86eI+4/
	csshr6fs5nBMB8v2/4TyRowc1JsOABoqNQVh0MvbD+WhdFTDzUgeU0fogMpVXZBRlDLWh3vs20y
	YOw1v1eRE2a7jQ5fZTgGH3lERFwjsuCZB/Irx4AjX0RWHx4ctV5k0txx082qbimcVemHwvjc3gU
	6HztOHX2R5FGnUupjD3v1CkxJxy16GJ8vv8OR6Hpm9rCspmwc=
X-Google-Smtp-Source: AGHT+IFUjkhuVOjIYIBtoOdoBeK1+Ymkp79O6sSJ1toqSbDz3y7MmHY3NHVZhSr2UC5eYcG90T0gAg==
X-Received: by 2002:a17:907:3e09:b0:abf:5266:6542 with SMTP id a640c23a62f3a-ac252ef911bmr1280722966b.55.1741550709183;
        Sun, 09 Mar 2025 13:05:09 -0700 (PDT)
Received: from ?IPV6:2a02:3100:acdd:4200:b9d3:2874:813c:4af4? (dynamic-2a02-3100-acdd-4200-b9d3-2874-813c-4af4.310.pool.telefonica.de. [2a02:3100:acdd:4200:b9d3:2874:813c:4af4])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac2394fd5b8sm638675166b.79.2025.03.09.13.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 13:05:07 -0700 (PDT)
Message-ID: <5792e2cd-6f0a-4f7d-a5ef-b932f94d82f3@gmail.com>
Date: Sun, 9 Mar 2025 21:05:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/2] net: phy: remove unused functions
 phy_package_[read|write]_mmd
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

These functions have never had a user, so remove them.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-core.c | 75 --------------------------------------
 include/linux/phy.h        |  8 ----
 2 files changed, 83 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 154d29be6..31ed1ce3b 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -734,43 +734,6 @@ int __phy_package_read_mmd(struct phy_device *phydev,
 }
 EXPORT_SYMBOL(__phy_package_read_mmd);
 
-/**
- * phy_package_read_mmd - read MMD reg relative to PHY package base addr
- * @phydev: The phy_device struct
- * @addr_offset: The offset to be added to PHY package base_addr
- * @devad: The MMD to read from
- * @regnum: The register on the MMD to read
- *
- * Convenience helper for reading a register of an MMD on a given PHY
- * using the PHY package base address. The base address is added to
- * the addr_offset value.
- *
- * Same calling rules as for phy_read();
- *
- * NOTE: It's assumed that the entire PHY package is either C22 or C45.
- */
-int phy_package_read_mmd(struct phy_device *phydev,
-			 unsigned int addr_offset, int devad,
-			 u32 regnum)
-{
-	int addr = phy_package_address(phydev, addr_offset);
-	int val;
-
-	if (addr < 0)
-		return addr;
-
-	if (regnum > (u16)~0 || devad > 32)
-		return -EINVAL;
-
-	phy_lock_mdio_bus(phydev);
-	val = mmd_phy_read(phydev->mdio.bus, addr, phydev->is_c45, devad,
-			   regnum);
-	phy_unlock_mdio_bus(phydev);
-
-	return val;
-}
-EXPORT_SYMBOL(phy_package_read_mmd);
-
 /**
  * __phy_package_write_mmd - write MMD reg relative to PHY package base addr
  * @phydev: The phy_device struct
@@ -804,44 +767,6 @@ int __phy_package_write_mmd(struct phy_device *phydev,
 }
 EXPORT_SYMBOL(__phy_package_write_mmd);
 
-/**
- * phy_package_write_mmd - write MMD reg relative to PHY package base addr
- * @phydev: The phy_device struct
- * @addr_offset: The offset to be added to PHY package base_addr
- * @devad: The MMD to write to
- * @regnum: The register on the MMD to write
- * @val: value to write to @regnum
- *
- * Convenience helper for writing a register of an MMD on a given PHY
- * using the PHY package base address. The base address is added to
- * the addr_offset value.
- *
- * Same calling rules as for phy_write();
- *
- * NOTE: It's assumed that the entire PHY package is either C22 or C45.
- */
-int phy_package_write_mmd(struct phy_device *phydev,
-			  unsigned int addr_offset, int devad,
-			  u32 regnum, u16 val)
-{
-	int addr = phy_package_address(phydev, addr_offset);
-	int ret;
-
-	if (addr < 0)
-		return addr;
-
-	if (regnum > (u16)~0 || devad > 32)
-		return -EINVAL;
-
-	phy_lock_mdio_bus(phydev);
-	ret = mmd_phy_write(phydev->mdio.bus, addr, phydev->is_c45, devad,
-			    regnum, val);
-	phy_unlock_mdio_bus(phydev);
-
-	return ret;
-}
-EXPORT_SYMBOL(phy_package_write_mmd);
-
 /**
  * phy_modify_changed - Function for modifying a PHY register
  * @phydev: the phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fc028bab1..61a8cb9d1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2107,14 +2107,6 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
 		       struct kernel_hwtstamp_config *config,
 		       struct netlink_ext_ack *extack);
 
-int phy_package_read_mmd(struct phy_device *phydev,
-			 unsigned int addr_offset, int devad,
-			 u32 regnum);
-
-int phy_package_write_mmd(struct phy_device *phydev,
-			  unsigned int addr_offset, int devad,
-			  u32 regnum, u16 val);
-
 extern const struct bus_type mdio_bus_type;
 
 struct mdio_board_info {
-- 
2.48.1



