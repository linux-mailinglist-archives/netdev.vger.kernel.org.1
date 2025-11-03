Return-Path: <netdev+bounces-235245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49250C2E437
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 23:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B65C34B43C
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 22:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E153002D4;
	Mon,  3 Nov 2025 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h944nJYQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD362EDD7E
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762208814; cv=none; b=tawDsRy24zAh6bkQVmx3BSxo2M2Xq9QdYptZXwPRuTe4zJKfxkYFtcP3gtFLMgCbW/xJp3BDypj4/GKkU4naND83nigfNqU/2zokhQBQ6VTEZbtbg8BghV5vE3pvB6Xny9Gu+dAQWFOiUuqSGOeaTXJhmkHjoR0AOQJyBrgttA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762208814; c=relaxed/simple;
	bh=H/QzqrM3ItlU2GfNxK+Ruqi3TMlQInlVGBJGd75jW/A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=GEezkHID2Sgz6CJdMlMTdwIxxNio2yMEbqnrzV+Ysi+ac0HuP0jmICIIIzSamfPrkPY2G7luwCljTfHApwLbim+jZJsPwWMf+T5nn1gt8BbcnAWKL0kBAC3azyQRj3mZklmcZTtS4hFd+5Nlv3eS9k3pojM1NEuGSfmjYIgSTWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h944nJYQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso65955305e9.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 14:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762208811; x=1762813611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1see8z0xW04+R2wfkzDBGJrYxct8PSz9BhwZu6yj6Y=;
        b=h944nJYQl8gioNLV9+XP5BCLhK05lLpLEhefRuh5BCimRGZnEcwCVhW0W6rFbE45n5
         2kwt9NHzHzdv+HDa9kjRaLCBEnu0PKX08ll0vPKZpMcIMnfVJq60FhwfwFAfnP6lsMhV
         YZaV52div4mao9OIKQuHESu4wnx0+K+B8erOlKR/WKyhqAwwCSmXD+tHwKLPreAVs+W7
         JH2BmTpyj2yttn0wHiTIQ/rI/fkEG7DFE2KVBM72bt3b7cLKWSh/IzHrWiH/l5W0uYQR
         xzUfkVMPgABfXnyuKi7MURSK/po+hNouft2b58BqMhSY9h2oExDweTSeqj+XHuFHJ2yu
         lsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762208811; x=1762813611;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z1see8z0xW04+R2wfkzDBGJrYxct8PSz9BhwZu6yj6Y=;
        b=NFj4oVBiZOt01ehdjEddTRZplUyy62KV6WMaAvTsB8SVcAj3dh/YlxsEvoEhA6C4ib
         XeuQQaoPwDUvk8EZnbom5vOmAosaIQuphiCZDMgYKkCM5Fym/fmWcTzw5r/PUOTKsJUy
         cAdT1nHczuJwIvzBPuRLoCiTWCJo0dPx7h9CfuwCMWMQ9MQe+Vv26cGf8dNSNb2ts85y
         XDBvEgxnpolUZuoJFGin2BOyAbRFHmQDI3gJ2YpfO2Eh/IacOmWbqdzwuMl4CiZruA3m
         a4wo3zVaAaTDLFbiHLvKwG9Pu8rPHnLx+zooj0ZZOLfJhE7xIBCXiw52GH5mefbXa6Fa
         U5hQ==
X-Gm-Message-State: AOJu0Yww0/wuhSwYG8tA5RxENvwYzOq8uXSGfzRmB5AO84TBWqQOXCWh
	Ubr7yjT5tHeYziiyBJyarTwM94YFZ8IIpeEV6RQmT7ZWxa2czZufPYUj
X-Gm-Gg: ASbGncsxniALstAR+8N7U7pQ/WSuP2ukietZEZPirzZT3ZyQaYvnyef0kjUAfVrbcgR
	D0AAKNDhLH/06hfkg6rGT+nLuRiwnzEj2NiX4YPbCIF5tZRJ5IAeunqR63mN3xbZ11rYRavzxSJ
	P1Uv9BGypqGNitlymXKqrFL3IIfNRNSmnHnohyQ9MQ4PB33ALmTMfRigsaWBIFV0Fzpw0gMUVNx
	JbOq9xfw+wAezHppRqMM6xeSwoa/BLhGLpQ+BJnyQENaSnxQgewXpcqWNqX3RD1/iFhcx6GFTSK
	fwgbY8dOsOG+vC2+D+yjlNK7YVeh8x/bZYTEWi/MiLUVwC7aoLmbhTKgybAUXY/JZf245BjLNbK
	3Oa9CGX+AGxSGnCLaDWfeC7hs+FldyONxi7D9ZYddeQXGNeOY5f+m92ph81+C5QwY+r4CtaDKfN
	xfJmZUWL9p4RB0dCz9hkoDvkLSV8oK6GCyidFIarz7xYLcQ+KAcW0qKC/jRKSqnc1++zNsnXyks
	Vr7D0P/9BD7GcSFi6bRD6SlKcwXYP3vn4yqOle49oY=
X-Google-Smtp-Source: AGHT+IFAbUlNQCCjgnThMlnJU+gLuPqGXmM7LzbJcGzUxIufl8LCG8dnWSXLZ78rpLVP+g4p0VbT+w==
X-Received: by 2002:a05:600c:6986:b0:46e:7247:cbc0 with SMTP id 5b1f17b1804b1-47730859cefmr115531385e9.18.1762208810500;
        Mon, 03 Nov 2025 14:26:50 -0800 (PST)
Received: from ?IPV6:2003:ea:8f0d:b700:d5d1:9ab3:c77e:dec7? (p200300ea8f0db700d5d19ab3c77edec7.dip0.t-ipconnect.de. [2003:ea:8f0d:b700:d5d1:9ab3:c77e:dec7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53ec2csm178124555e9.11.2025.11.03.14.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 14:26:48 -0800 (PST)
Message-ID: <764e9a31-b40b-4dc9-b808-118192a16d87@gmail.com>
Date: Mon, 3 Nov 2025 23:26:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: make phy_device members pause and
 asym_pause bitfield bits
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

We can reduce the size of struct phy_device a little by switching
the type of members pause and asym_pause from int to a single bit.
As C99 is supported now, we can use type bool for the bitfield members,
what provides us with the benefit of the usual implicit bool conversions.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c    | 20 ++++++++++----------
 drivers/net/phy/phy_device.c | 16 ++++++++--------
 include/linux/phy.h          |  4 ++--
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 61670be0f..1a7b32be4 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -485,8 +485,8 @@ static int genphy_c45_baset1_read_lpa(struct phy_device *phydev)
 		mii_t1_adv_l_mod_linkmode_t(phydev->lp_advertising, 0);
 		mii_t1_adv_m_mod_linkmode_t(phydev->lp_advertising, 0);
 
-		phydev->pause = 0;
-		phydev->asym_pause = 0;
+		phydev->pause = false;
+		phydev->asym_pause = false;
 
 		return 0;
 	}
@@ -498,8 +498,8 @@ static int genphy_c45_baset1_read_lpa(struct phy_device *phydev)
 		return val;
 
 	mii_t1_adv_l_mod_linkmode_t(phydev->lp_advertising, val);
-	phydev->pause = val & MDIO_AN_T1_ADV_L_PAUSE_CAP ? 1 : 0;
-	phydev->asym_pause = val & MDIO_AN_T1_ADV_L_PAUSE_ASYM ? 1 : 0;
+	phydev->pause = val & MDIO_AN_T1_ADV_L_PAUSE_CAP;
+	phydev->asym_pause = val & MDIO_AN_T1_ADV_L_PAUSE_ASYM;
 
 	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_LP_M);
 	if (val < 0)
@@ -536,8 +536,8 @@ int genphy_c45_read_lpa(struct phy_device *phydev)
 				   phydev->lp_advertising);
 		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
 		mii_adv_mod_linkmode_adv_t(phydev->lp_advertising, 0);
-		phydev->pause = 0;
-		phydev->asym_pause = 0;
+		phydev->pause = false;
+		phydev->asym_pause = false;
 
 		return 0;
 	}
@@ -551,8 +551,8 @@ int genphy_c45_read_lpa(struct phy_device *phydev)
 		return val;
 
 	mii_adv_mod_linkmode_adv_t(phydev->lp_advertising, val);
-	phydev->pause = val & LPA_PAUSE_CAP ? 1 : 0;
-	phydev->asym_pause = val & LPA_PAUSE_ASYM ? 1 : 0;
+	phydev->pause = val & LPA_PAUSE_CAP;
+	phydev->asym_pause = val & LPA_PAUSE_ASYM;
 
 	/* Read the link partner's 10G advertisement */
 	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
@@ -1171,8 +1171,8 @@ int genphy_c45_read_status(struct phy_device *phydev)
 
 	phydev->speed = SPEED_UNKNOWN;
 	phydev->duplex = DUPLEX_UNKNOWN;
-	phydev->pause = 0;
-	phydev->asym_pause = 0;
+	phydev->pause = false;
+	phydev->asym_pause = false;
 
 	if (phydev->autoneg == AUTONEG_ENABLE) {
 		ret = genphy_c45_read_lpa(phydev);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index c4fbacbc3..9d2931f95 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -815,8 +815,8 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 
 	dev->speed = SPEED_UNKNOWN;
 	dev->duplex = DUPLEX_UNKNOWN;
-	dev->pause = 0;
-	dev->asym_pause = 0;
+	dev->pause = false;
+	dev->asym_pause = false;
 	dev->link = 0;
 	dev->port = PORT_TP;
 	dev->interface = PHY_INTERFACE_MODE_GMII;
@@ -2082,8 +2082,8 @@ int genphy_setup_forced(struct phy_device *phydev)
 {
 	u16 ctl;
 
-	phydev->pause = 0;
-	phydev->asym_pause = 0;
+	phydev->pause = false;
+	phydev->asym_pause = false;
 
 	ctl = mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
 
@@ -2490,8 +2490,8 @@ int genphy_read_status(struct phy_device *phydev)
 	phydev->master_slave_state = MASTER_SLAVE_STATE_UNSUPPORTED;
 	phydev->speed = SPEED_UNKNOWN;
 	phydev->duplex = DUPLEX_UNKNOWN;
-	phydev->pause = 0;
-	phydev->asym_pause = 0;
+	phydev->pause = false;
+	phydev->asym_pause = false;
 
 	if (phydev->is_gigabit_capable) {
 		err = genphy_read_master_slave(phydev);
@@ -2544,8 +2544,8 @@ int genphy_c37_read_status(struct phy_device *phydev, bool *changed)
 	/* Signal link has changed */
 	*changed = true;
 	phydev->duplex = DUPLEX_UNKNOWN;
-	phydev->pause = 0;
-	phydev->asym_pause = 0;
+	phydev->pause = false;
+	phydev->asym_pause = false;
 
 	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
 		lpa = phy_read(phydev, MII_LPA);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3809ca705..df7d52b27 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -666,6 +666,8 @@ struct phy_device {
 	/* The most recently read link state */
 	unsigned link:1;
 	unsigned autoneg_complete:1;
+	bool pause:1;
+	bool asym_pause:1;
 
 	/* Interrupts are enabled */
 	unsigned interrupts:1;
@@ -690,8 +692,6 @@ struct phy_device {
 	int speed;
 	int duplex;
 	int port;
-	int pause;
-	int asym_pause;
 	u8 master_slave_get;
 	u8 master_slave_set;
 	u8 master_slave_state;
-- 
2.51.2


