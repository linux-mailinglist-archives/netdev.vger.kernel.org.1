Return-Path: <netdev+bounces-220632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF12B477E5
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 00:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BA7168689
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 22:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D8C2D238A;
	Sat,  6 Sep 2025 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CksmXieU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4844620C038
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757196105; cv=none; b=n/OKPBkwb6RWIhHMq6+9T+eU2J/f5fm4QpWH5umTQdz3Rx8W4BiC7S9UmUPesqxaMYpsFs/9tpio0LGYFwccwFuLWEflhIBrqt9DXLOS7yH+9EopXZG5JzizQxK2bHyYOxTy0uGy3c3MaxmvHK2zjuThN/0rUm1fdzXDcAQ0xO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757196105; c=relaxed/simple;
	bh=mxtOK+i6jjmZaMpMe2m1qAf/biCEIcP9PLvayH0oJn0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nwh0B9IS6E9uT0k7q8eUQp4y0QrTU9suBSo7yqzcBRwfNGsIeQSSffWDVptw/+Q+WpPsVbT/NOku8z2XSf0jWJz1DYiPV7xblwuQXHtSlAfxwZNLv6v0YsPpIonL7tX2NYfH3ryUIQ7HPEC+Pm7YmjcszKbFiKcjtKXZUaj4iqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CksmXieU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e014bf8ec1so2281864f8f.1
        for <netdev@vger.kernel.org>; Sat, 06 Sep 2025 15:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757196101; x=1757800901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g2SQWlNvsiaX0k61jmdTkPFs72qDWZnNh6qnY5mnElA=;
        b=CksmXieUugXguTiV075EohrXfUGTQ9bFyMKo3E8rjtk0ULB9vq3jP3fRd6Gx3ir1a9
         XpCcJ+aRO7uatGmf7PSpK+luMmh6D4Bs0rm2OyfkJAy52vp1EF/uSh1xAxFGke9OIZoU
         Arcy+PnVLDEG4gLzz14kTplregfPZ7zVuPBlUjR8WqHfxKXAtzHWn+K4qTMBbI5vcTWo
         whWbeoyL3Z2Ua6qJgtEtTVXEFfYSeGL7SdLxO7XNosNnMTeQbnCKJBUpQ+eHbQcMY0xq
         HQEzlMSfvcBdVyRq38IhP+VNq7zuMq3Yjtso3CtevhAPhlmrixEuwDMjZrEOKCHnzz23
         pmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757196101; x=1757800901;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2SQWlNvsiaX0k61jmdTkPFs72qDWZnNh6qnY5mnElA=;
        b=hs8bb3uGddOov9kf2s6c2WFL1x/X/2XPuXVZ3xGh8pso96lC40CxXqaPYdpCvoNPTw
         6DBtb4CjZ+Zh0I57Jx9vY1/tTy3UNnjwZRKJ57czx7oa8QpPvMASTt/+IScWgcHZgkt8
         kCtrk+fZ8EIVBWHqKOp4V/cVow1QMzPplubyVej8vDea9MLU7WxKYhksvL6wfUgjNaa1
         VHF9RALHU7S7GBE9FT9rB+CXjbvsA/PdWVxkpjambeX1ZyPkoHSvHsIBCILkqO3D+Kyr
         5288r8IVLpqM5xXlLVySO7RKmWiOa0yeorrIAYycJ4IlUKgvLpmQDdIoTJSPX4hvQt7Q
         eTCg==
X-Gm-Message-State: AOJu0Yz/KEZ8PdG67z5xEhtE6c9WnwBIyflHqoRQ2bKnIgb/0x08MgBn
	Md4gFk2WZQRKuH1tF6G/QNxI+VfOg3teLtb5FhqYZ/E/3Tb4HatIVNzR
X-Gm-Gg: ASbGncvSRecMQC4ShbS8Qyj4pt95rTACqBgAlEQMpDazOT3uTcX4pS/Nz5sBumxI4QX
	WEOMPZjdG9cGg088N/XB9LiT3nI5gF+VyiARrZ1oPunvXKjGZ9mX/2PFk8aY2iwRh1fW5HyLvKG
	8aAG0TRIhI4JB6JofW7ZsYa7tkJMntrHflFAOO5wtnpwDxpYHFlBVMhqGQx61VTj98uQIiMwFUG
	fZ/sYYbCuVkYySrnV3U2N13Kb7s427HnacMpw0uzyXqKEY/vN5l5Oyo6xSmSC6F8zYGxXhqxuIT
	WbM5Bs/fBSX8RznytU+bAs5zWyZOfpGXUyerEpBAjqR+4SNK7TKFY7htAQtXiF1yGC73ccb7GPO
	XcUYO4OdBNhA8idfhoEA43gYthM/2PDOAN8hkXu7Am52oR3UbWGfr0dWRKRj4tNum+dX5EWm5gg
	st7ZrLKgCeKlP3xnCQ3RiG2N60AZQW5+1bpuOq96NBBk0dTmV6blwI9o19WNA=
X-Google-Smtp-Source: AGHT+IGms9lptp967kEFZEus9UbMXmMqXVJjvVyg3OYhf+Y7IUaxJmqydz+A68lEILhedJkYOZRDKQ==
X-Received: by 2002:adf:b1d6:0:b0:3e7:451f:3a6b with SMTP id ffacd0b85a97d-3e7451f3e56mr109338f8f.42.1757196101448;
        Sat, 06 Sep 2025 15:01:41 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2b:f400:f9ef:5bb:5d77:26c7? (p200300ea8f2bf400f9ef05bb5d7726c7.dip0.t-ipconnect.de. [2003:ea:8f2b:f400:f9ef:5bb:5d77:26c7])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e411219ddfsm6781508f8f.57.2025.09.06.15.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 15:01:40 -0700 (PDT)
Message-ID: <34434ab0-69ba-4a93-bc7a-944e2cf49852@gmail.com>
Date: Sun, 7 Sep 2025 00:01:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/4] net: phy: fixed_phy: add helper fixed_phy_find
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <e81be066-cc23-4055-aed7-2fbc86da1ff7@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <e81be066-cc23-4055-aed7-2fbc86da1ff7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Factor out the functionality to search for a fixed_phy matching an
address. This improves readability of the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 81 +++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 35ac29c3e..eae513b70 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -40,42 +40,49 @@ static struct fixed_mdio_bus platform_fmb = {
 	.phys = LIST_HEAD_INIT(platform_fmb.phys),
 };
 
-int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier)
+static struct fixed_phy *fixed_phy_find(int addr)
 {
 	struct fixed_mdio_bus *fmb = &platform_fmb;
+	struct fixed_phy *fp;
+
+	list_for_each_entry(fp, &fmb->phys, node) {
+		if (fp->addr == addr)
+			return fp;
+	}
+
+	return NULL;
+}
+
+int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier)
+{
 	struct phy_device *phydev = dev->phydev;
 	struct fixed_phy *fp;
 
 	if (!phydev || !phydev->mdio.bus)
 		return -EINVAL;
 
-	list_for_each_entry(fp, &fmb->phys, node) {
-		if (fp->addr == phydev->mdio.addr) {
-			fp->status.link = new_carrier;
-			return 0;
-		}
-	}
-	return -EINVAL;
+	fp = fixed_phy_find(phydev->mdio.addr);
+	if (!fp)
+		return -EINVAL;
+
+	fp->status.link = new_carrier;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(fixed_phy_change_carrier);
 
 static int fixed_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
 {
-	struct fixed_mdio_bus *fmb = bus->priv;
 	struct fixed_phy *fp;
 
-	list_for_each_entry(fp, &fmb->phys, node) {
-		if (fp->addr == phy_addr) {
-			/* Issue callback if user registered it. */
-			if (fp->link_update)
-				fp->link_update(fp->phydev->attached_dev,
-						&fp->status);
-
-			return swphy_read_reg(reg_num, &fp->status);
-		}
-	}
+	fp = fixed_phy_find(phy_addr);
+	if (!fp)
+		return 0xffff;
 
-	return 0xFFFF;
+	if (fp->link_update)
+		fp->link_update(fp->phydev->attached_dev, &fp->status);
+
+	return swphy_read_reg(reg_num, &fp->status);
 }
 
 static int fixed_mdio_write(struct mii_bus *bus, int phy_addr, int reg_num,
@@ -93,21 +100,19 @@ int fixed_phy_set_link_update(struct phy_device *phydev,
 			      int (*link_update)(struct net_device *,
 						 struct fixed_phy_status *))
 {
-	struct fixed_mdio_bus *fmb = &platform_fmb;
 	struct fixed_phy *fp;
 
 	if (!phydev || !phydev->mdio.bus)
 		return -EINVAL;
 
-	list_for_each_entry(fp, &fmb->phys, node) {
-		if (fp->addr == phydev->mdio.addr) {
-			fp->link_update = link_update;
-			fp->phydev = phydev;
-			return 0;
-		}
-	}
+	fp = fixed_phy_find(phydev->mdio.addr);
+	if (!fp)
+		return -ENOENT;
+
+	fp->link_update = link_update;
+	fp->phydev = phydev;
 
-	return -ENOENT;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(fixed_phy_set_link_update);
 
@@ -144,17 +149,15 @@ static DEFINE_IDA(phy_fixed_ida);
 
 static void fixed_phy_del(int phy_addr)
 {
-	struct fixed_mdio_bus *fmb = &platform_fmb;
-	struct fixed_phy *fp, *tmp;
+	struct fixed_phy *fp;
 
-	list_for_each_entry_safe(fp, tmp, &fmb->phys, node) {
-		if (fp->addr == phy_addr) {
-			list_del(&fp->node);
-			kfree(fp);
-			ida_free(&phy_fixed_ida, phy_addr);
-			return;
-		}
-	}
+	fp = fixed_phy_find(phy_addr);
+	if (!fp)
+		return;
+
+	list_del(&fp->node);
+	kfree(fp);
+	ida_free(&phy_fixed_ida, phy_addr);
 }
 
 struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
-- 
2.51.0



