Return-Path: <netdev+bounces-250928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE5D39A6E
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 23:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B5273007EF9
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 22:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAE71A9FA0;
	Sun, 18 Jan 2026 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gqi4/Ke0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6CC1B808
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768774592; cv=none; b=drwiCqKUVxOrcKuBWCUDz6cCyn+xcUsxvG7TN8KoHQAQG1NkrqdtwN0ZkO7Bxge/Up52CSOOc8qD+UMrXzYSU1bd2HCsnGVIjLbZsHm4KLUaWuBiGMB2cvhD4bUtV8+ZveXN79YFADfkjZvecfbpz++GbfYwG5OyAmpHqX2ujhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768774592; c=relaxed/simple;
	bh=EpnA9WVO5MdDVMFPPiX+kntd3eRkzPPhbdHn0BFKT1s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=e5Hmxr/UmL+um+lsaIPK/znzCA4oB5MpGNJUsmlqQKzZzftrcT7Fc6bwje2Oe+LkBvwJPrTdqatWdOm8uNAQ2aUQCfKMIxkirp+xnQIVbPoJ0qnYGA0s+ck1fMY94iwiqfiRQDs5L0HTtlRWXgofpi78zBTquSd9mVhLdFS9VTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gqi4/Ke0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc305882so2001698f8f.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 14:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768774590; x=1769379390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvYQeSoBR6Tc6MsCfEkmIpOz0ALjsgIYQ7JTk1K/TAw=;
        b=Gqi4/Ke0PV+NzG2/YwmfgC67hSh1W58+DpJBO+BF77hjtCtuwLDuqIbf1tTAd3xJaG
         SPhgJKry367YqrU9BT/gqtwvHd/4iHBHwOzpTZ/T+IxjWeJUJtoQzbKezkm8++d2aTVK
         nGwRzX5cEydjNQEaEHFA0yVTYR02cPG8VLSU4u/Zo/BrbqW85WBStzyBfSFjtb14FIW3
         GKlB8Q9CBuBEWnBI0K+srtUxN1yP3bya2xHyzlOa20A63bUeHpzusSqyYbxj3sNv+WGR
         dDGbH210YdNzW//JvJHNy9I4/v+OZmPXMoLh+BcTBNIrj9+luNI2BXnQW8VoDuqzigHH
         r+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768774590; x=1769379390;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BvYQeSoBR6Tc6MsCfEkmIpOz0ALjsgIYQ7JTk1K/TAw=;
        b=v39+ypccNMZK+eNjPlM5MVFumO0EV2+tdCN6fPiQk+2MSstNXTnk8GG997Uo5fgNgR
         mM5u97V/qs5iiyGkDFY9vuFTqBQLesP2UOgvICZgxO1Y2dnYIbGhlcGxWeeBIevbpcW4
         vyDbmnXqwOh1BBbdHb7D9WOEA19mXap3pssnsq1ZNHiLEY5kqieY9BDYaotYdSgvwVyU
         ILLjIlLeTMbNsgl1cIYqRG6uO1PxIOIYqwlcXGy3PCoH/wnVtaYV0AaMTxiXNl/1+dXK
         ynuExkmQpxsDJS1oqcWrlP+slLjNPbqwKZDg7aPp47gXzGiiXcplFsYmChejBN/eXtZN
         G+ow==
X-Gm-Message-State: AOJu0Yy9er1Kt+7eQfRcCuqC7VZHpdIwarbgKu2yKWgKokBeb7qhB3Jb
	9qLV1HiTd9PEZTWVtTcf/h74olHRhkPn99KmlkSawK+tS9t8G+63LSNjRKvjRg==
X-Gm-Gg: AY/fxX6sK85oZKxqt5DNSHFxIu+teELADk3nhTaQuuIGSb0WQJzHXbkvbHbqv8Y2MGF
	zkgP9YC679qbDkWHx7nTN22Tp+N8/Pm+eN1wpJ2Qgy6bUS9m6oteMuJP3Zk03wF6NFYB4589tBW
	qISvWO6zBGIJt/Lzok8AXCGC8gTavOP0omALPOk44YIqeiISQBoN9vpUg4YEunAFHTFTWC2RBSV
	Y+iNMeX1ztU3rvyn9zUZCTnoKxmsrz32GC72MXvwGVgIO1PnaeUNbJRmCRLDZV4ZxRU1ijjmf1X
	AttJTOoY5BBo/6h6ejjm/OSc3DKnEyUpJ6iTWSgUUvxNpqmb6d/pB9i+OOvWSzwPvtwtU9iR8AU
	1MoyBvSCPA7PbagrpIxNfpqSBHHPJQWSdcEHsuUQNU4Nv3B2V/035lnLUdLiHJ8ltpDXEzxpaiF
	ZxA2ZcpDvxM4LV6O89yZGZzmcYRoBz/Rhdo/OQw5NcflVSplBOMU+WeFwmWE9hAot9ksJg+teke
	yNoYaPtSBfLgdRBCakSL/Fcl/Y/+r8jR14Utia5skZz9WLUd8MxVZefpCQ=
X-Received: by 2002:a5d:64c5:0:b0:431:752:671e with SMTP id ffacd0b85a97d-4356998a993mr11735921f8f.15.1768774589437;
        Sun, 18 Jan 2026 14:16:29 -0800 (PST)
Received: from ?IPV6:2003:ea:8f02:4600:9d:c619:49ef:793c? (p200300ea8f024600009dc61949ef793c.dip0.t-ipconnect.de. [2003:ea:8f02:4600:9d:c619:49ef:793c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e79asm19261946f8f.33.2026.01.18.14.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 14:16:28 -0800 (PST)
Message-ID: <e7394cc8-5895-4d02-a8fe-802345c7c547@gmail.com>
Date: Sun, 18 Jan 2026 23:16:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: simplify PHY fixup registration
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Based on the fact that either bus_id-based matching or phy_uid-based
matching is used, the code can be simplified. PHY_ANY_ID and
PHY_ANY_UID are not needed. Ensure that phy_id_compare() is called
only if phy_uid_mask isn't zero, because a zero value would always
result in a match.
In addition change the return value type of phy_needs_fixup() to bool.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0e19482455d..f624218bf36 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -49,9 +49,6 @@ MODULE_DESCRIPTION("PHY library");
 MODULE_AUTHOR("Andy Fleming");
 MODULE_LICENSE("GPL");
 
-#define	PHY_ANY_ID	"MATCH ANY PHY"
-#define	PHY_ANY_UID	0xffffffff
-
 struct phy_fixup {
 	struct list_head list;
 	char bus_id[MII_BUS_ID_SIZE + 3];
@@ -432,11 +429,10 @@ static SIMPLE_DEV_PM_OPS(mdio_bus_phy_pm_ops, mdio_bus_phy_suspend,
 
 /**
  * phy_register_fixup - creates a new phy_fixup and adds it to the list
- * @bus_id: A string which matches phydev->mdio.dev.bus_id (or PHY_ANY_ID)
+ * @bus_id: A string which matches phydev->mdio.dev.bus_id (or NULL)
  * @phy_uid: Used to match against phydev->phy_id (the UID of the PHY)
- *	It can also be PHY_ANY_UID
  * @phy_uid_mask: Applied to phydev->phy_id and fixup->phy_uid before
- *	comparison
+ *	comparison (or 0 to disable id-based matching)
  * @run: The actual code to be run when a matching PHY is found
  */
 static int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
@@ -447,7 +443,8 @@ static int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
 	if (!fixup)
 		return -ENOMEM;
 
-	strscpy(fixup->bus_id, bus_id, sizeof(fixup->bus_id));
+	if (bus_id)
+		strscpy(fixup->bus_id, bus_id, sizeof(fixup->bus_id));
 	fixup->phy_uid = phy_uid;
 	fixup->phy_uid_mask = phy_uid_mask;
 	fixup->run = run;
@@ -463,7 +460,7 @@ static int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
 int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
 			       int (*run)(struct phy_device *))
 {
-	return phy_register_fixup(PHY_ANY_ID, phy_uid, phy_uid_mask, run);
+	return phy_register_fixup(NULL, phy_uid, phy_uid_mask, run);
 }
 EXPORT_SYMBOL(phy_register_fixup_for_uid);
 
@@ -471,25 +468,20 @@ EXPORT_SYMBOL(phy_register_fixup_for_uid);
 int phy_register_fixup_for_id(const char *bus_id,
 			      int (*run)(struct phy_device *))
 {
-	return phy_register_fixup(bus_id, PHY_ANY_UID, 0xffffffff, run);
+	return phy_register_fixup(bus_id, 0, 0, run);
 }
 EXPORT_SYMBOL(phy_register_fixup_for_id);
 
-/* Returns 1 if fixup matches phydev in bus_id and phy_uid.
- * Fixups can be set to match any in one or more fields.
- */
-static int phy_needs_fixup(struct phy_device *phydev, struct phy_fixup *fixup)
+static bool phy_needs_fixup(struct phy_device *phydev, struct phy_fixup *fixup)
 {
-	if (strcmp(fixup->bus_id, phydev_name(phydev)) != 0)
-		if (strcmp(fixup->bus_id, PHY_ANY_ID) != 0)
-			return 0;
+	if (!strcmp(fixup->bus_id, phydev_name(phydev)))
+		return true;
 
-	if (!phy_id_compare(phydev->phy_id, fixup->phy_uid,
-			    fixup->phy_uid_mask))
-		if (fixup->phy_uid != PHY_ANY_UID)
-			return 0;
+	if (fixup->phy_uid_mask &&
+	    phy_id_compare(phydev->phy_id, fixup->phy_uid, fixup->phy_uid_mask))
+		return true;
 
-	return 1;
+	return false;
 }
 
 /* Runs any matching fixups for this phydev */
-- 
2.52.0


