Return-Path: <netdev+bounces-248807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8255D0EE6D
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 13:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B85B03007292
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 12:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02B233C19E;
	Sun, 11 Jan 2026 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irqv1iYh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070D14F70
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768135407; cv=none; b=Ld9dz+20BYRjG3x0B/VSWJtO8SkZZ8i1sVexzRDK5QdOIdnFXMUTkeGrIQOHqNdLkwINHtzsZ/PcSPr6AZiQoomYpu1CMSMwZN1qikaamH1PnFglz+6ZjAOzyVzCFT3lZZPHfoLA4r1hOlrntJPnNmkzoRi3/OgKlaRRUXqDdY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768135407; c=relaxed/simple;
	bh=64j5Olm86lV96Y7gxVwqnbVRE2FvmaOZy7fmXNZGxlY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QbgRaansw9lUpkiofmfIln41X1Sv42oNXLTMVpMje1ggtOJeEZ8S4QiQLq9x9tuw1HOQu0WIY85p7MialitzBmvjnNsMptGviCSpyZRAHggC013EwsBFdYQ65k7NgfDPE3PtNXKFj/KwLa06dh61BheA/9YnKwKKVvPSM+DJoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irqv1iYh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47796a837c7so38939475e9.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 04:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768135404; x=1768740204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BnELWpid4bhMNse/rPG4Hd0x2+fk0Z04tyfcZf33H10=;
        b=irqv1iYh41VCSWO38zc5quZY/LYYerCVkXjMSmbL228GT3tgHmJlZbkZ7JwWFHBGYX
         F6W1BI/WBemZZ+hlPD8lpxjQ2g6p9YCqLD3bta+ejaHrmudYWo1N3SDCq8NGW4DHFQSv
         /dchqdB7FCiv9KdFq1cqFF/jQ6bDgCkGeuGtjOEQsUSOYyPOhPTNLJCkaeey/70+5PBl
         pnn0s9Ve9g0M13Vfw6fnpvxJREfwG5gFOksQT3QpGPLZ4w/HsJcauPWrg70WA7TTxliS
         2T/nRDlgyJbZc5WObYn5dlbxnlzGdAVU/DY9X2WF+crBi1LJ/VlbbwpP4m0Z0EW0X5Ze
         n2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768135404; x=1768740204;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BnELWpid4bhMNse/rPG4Hd0x2+fk0Z04tyfcZf33H10=;
        b=Q8pwAORRE7I5ch0tLqFh+pJY047Z+Pg9g9FK9wAezj+k5prsRwWP3Lw4A0hvNck5er
         +6XqxGp9Q3lGd4dHAlwzAeCHmtlO0MAGpNU0pUe+CSVWpzHEVjQa6a6onenxwBcZ9NWM
         EKVT9oQAf6E0UsYc+tR2JGW+a9OwIEOJ7hNVT391sRyQmn/z5M2ltWlYXkBj0SOs5T5h
         xKYIjDjrxMTbGVhZ/E+GuWL2Ulv+ZlbApKGdWkwr+2jh6mKM9c+vpX5FCqzwCjTMbRgP
         uFs7a1G7lPsiUhacKtZEFsTtTgTosuOyzdNIP2pKqqYaaPQ76+nbBsxdnG1EZc9H93Hk
         pXlw==
X-Gm-Message-State: AOJu0YxycZrAkCxNpYw+HmZjlZ/EyDymKuHuEoOlcS4Cym6oxctrvdFQ
	Ak8d85jHakbMHDhswAO98y05scVi/yjJj+07dlEiX3i545Vli49xK5UD
X-Gm-Gg: AY/fxX4o2L79ZSGG1KRC6rc2mhl9vdlomoXudocAhM38qhV821JbHd8Sw8aksh1uCqF
	vw0r5nGxKa9M9Ht8aC04ejCkQDuX/GRA9WqatFkhcEczm7eqnGPx21vwafpG9Hu2QVpKLzsoDVz
	Nw/bLNz93Frm9lg23QBDBqDYUNFHzsf+yR7hZpupR0RjnqAQwDUq/4iRsEmKzxVI2qz8buBjBpV
	V7xD4Xuu+7vJi6hZ26c+GllQRjOWMdM7YpiaK9IubaPF/JfJuS6lDxOjPQZSI69kci0vT0uiQA+
	X5rnJyi9njGhDVwtzLsttrST77X8sNKvqOx6iAWSBvNlUUDasQPNk2up74yWqEAfcTEzq2V12Ml
	vD5qjtwnyDtDn7Bsls1lcPvPTyvfP9WmFqHRVGQzIVej5F4J8uljlAwSZDeGbiMz4yY9K8qqHlO
	Oc1aaoCXYQvghDrLJqt/+sNQr4qH2H48UrU/COlnwuR/VH673kqzzyUD1+UqYkEq/utI6HgN37j
	KnB9L70LsvD8+bxvV4aMj+hoWwOh1AEPD/jermZHyIrpZ8mMbrYLQ==
X-Google-Smtp-Source: AGHT+IEAi2oJbnwY96D8SZhZKSAAJuYsFbeMrlMhQPeDY7sUMGEmaFU8UQZOFTUi8cB4neD86HJIow==
X-Received: by 2002:a05:600c:a015:b0:479:1348:c61e with SMTP id 5b1f17b1804b1-47d84b54c82mr129491775e9.20.1768135404271;
        Sun, 11 Jan 2026 04:43:24 -0800 (PST)
Received: from ?IPV6:2003:ea:8f47:8300:6996:b28c:496c:1292? (p200300ea8f4783006996b28c496c1292.dip0.t-ipconnect.de. [2003:ea:8f47:8300:6996:b28c:496c:1292])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f7053f5sm297995795e9.14.2026.01.11.04.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 04:43:23 -0800 (PST)
Message-ID: <d4614463-d532-41fc-92e9-ef97107aceb5@gmail.com>
Date: Sun, 11 Jan 2026 13:43:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 2/2] net: phy: fixed_phy: replace IDA with a
 bitmap
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <110f676d-727c-4575-abe4-e383f98fc38f@gmail.com>
Content-Language: en-US
In-Reply-To: <110f676d-727c-4575-abe4-e383f98fc38f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Size of array fmb_fixed_phys is small, so we can use a simple bitmap
instead of an IDA to manage dynamic allocation of fixed PHY's.
find_first_zero_bit() isn't atomic, so we need the loop to rule out
double allocation of a PHY address.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- patch added
---
 drivers/net/phy/fixed_phy.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 7d6078d1570..0b83fb30a54 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -16,7 +16,6 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/idr.h>
 #include <linux/netdevice.h>
 
 #include "swphy.h"
@@ -32,13 +31,13 @@ struct fixed_phy {
 	int (*link_update)(struct net_device *, struct fixed_phy_status *);
 };
 
+static DECLARE_BITMAP(fixed_phy_ids, NUM_FP);
 static struct fixed_phy fmb_fixed_phys[NUM_FP];
 static struct mii_bus *fmb_mii_bus;
-static DEFINE_IDA(phy_fixed_ida);
 
 static struct fixed_phy *fixed_phy_find(int addr)
 {
-	return ida_exists(&phy_fixed_ida, addr) ? fmb_fixed_phys + addr : NULL;
+	return test_bit(addr, fixed_phy_ids) ? fmb_fixed_phys + addr : NULL;
 }
 
 int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier)
@@ -113,7 +112,20 @@ static void fixed_phy_del(int phy_addr)
 		return;
 
 	memset(fp, 0, sizeof(*fp));
-	ida_free(&phy_fixed_ida, phy_addr);
+	clear_bit(phy_addr, fixed_phy_ids);
+}
+
+static int fixed_phy_get_free_addr(void)
+{
+	int addr;
+
+	do {
+		addr = find_first_zero_bit(fixed_phy_ids, NUM_FP);
+		if (addr == NUM_FP)
+			return -ENOSPC;
+	} while (test_and_set_bit(addr, fixed_phy_ids));
+
+	return addr;
 }
 
 struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
@@ -131,7 +143,7 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 		return ERR_PTR(-EPROBE_DEFER);
 
 	/* Get the next available PHY address, up to NUM_FP */
-	phy_addr = ida_alloc_max(&phy_fixed_ida, NUM_FP - 1, GFP_KERNEL);
+	phy_addr = fixed_phy_get_free_addr();
 	if (phy_addr < 0)
 		return ERR_PTR(phy_addr);
 
@@ -210,8 +222,6 @@ static void __exit fixed_mdio_bus_exit(void)
 {
 	mdiobus_unregister(fmb_mii_bus);
 	mdiobus_free(fmb_mii_bus);
-
-	ida_destroy(&phy_fixed_ida);
 }
 module_exit(fixed_mdio_bus_exit);
 
-- 
2.52.0



