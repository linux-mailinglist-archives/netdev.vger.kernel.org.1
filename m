Return-Path: <netdev+bounces-266272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN38K0dYsGkJiQIAu9opvQ
	(envelope-from <netdev+bounces-266272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:43:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 551B7255CDC
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB45632157F7
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DB43D8101;
	Tue, 10 Mar 2026 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJphveOm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA33D75D2
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164342; cv=none; b=VM/d8rRCqrHzEFjtTdS28xCdhRWIkT2ynD2zTXBOWY3sFsBpTb2NprXwew+3u9SvxnQkA8X8z90wyTG6u42W+9mw+0dC1LC5qzMFma/hVXdbxrg43iLDZRg+LGlaPRn1QHPgxcEh7q49JA9L57MslilCwtD8yKJkgUWZigZJJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164342; c=relaxed/simple;
	bh=6nh8hser+whvA1PfR1iGtoLj1pfTFR51/unCHyuL39U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5fuJpt/ilxXio4pmZxM6VoihawtrgNk6SPeFSZ7H9yQEkOxgSAdK7/kReYLlGm+I2Gqs/CkXfk+bSKvEidRaG285/DhAANvowdgq8kEqaSgzruajQ3QXmJqi/7u5v+8dBMu1/Bs3w7pdLCM88jFHmnaC5Y8MyI6CtEMJrlkBOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJphveOm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48535a0ef86so23852485e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164338; x=1773769138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5kecdfbWVFCpvWANmeDGj+7c6bf15MwYHY69kbw3bw=;
        b=jJphveOmcZXg3YcEj4YNym7kkl38U68mgse3zolN6zCvkmgjDD4elBa2DJqQP2P3uO
         xZ3EKSrHNiYZ7HAAxwwnFLpK7U82WCJ4SEHyzmzeNEJmTKO3Z5O6FPBET8tA7C5AAkp3
         ZZJPcQgjaAL0gHgZoHx94fss9jCzHRFvb7umouqiZje78H1vh5B4qQvfgRXEJ4kkWBOJ
         rlTracDFR+WK5SugtrFUaWuPKUDMf+yGUFeIQ2EFmjD52+JpgxLu5zwa2Fve6T2QPJYM
         zIImulIvla0noQvAWD01mCAKDLu5CVWvkGRcRFvhJfuag2GHP7PmmrTUE6Wuj9yi8aYL
         DnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164338; x=1773769138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K5kecdfbWVFCpvWANmeDGj+7c6bf15MwYHY69kbw3bw=;
        b=o1CUzvt9v3UnLdU2pYHZ8fgo8ZQiJN90o5dS8YuvIVdQR9HWP+U6Ka+zhEUCQoFfSZ
         Cl3m0I+aXCWTTcYoBTVYG8XWwf+pT0WYkOw9Ev8ND8YQX1l2jRFNocRVhhCavy0wDKXw
         MAfAb2lSl/5FfpnbSmPeugZUsZAPZ0B8gcv3STjsOrwNP4TVP3UvVrXZF12SZAwFv2TL
         0tCW6kUF0XNdcFjUxIL1bDVzbz+Ba8zqkskdkgA5LURh2ME8v3wtHa/z3yDht9A6VRWd
         bPMtwVnz6Gx+OEF3R590EEjzGPVqy8yDDLp8RYjLn073pyL4PkQNxJSDpaWAVWD0TEk8
         fDXg==
X-Gm-Message-State: AOJu0YxwSr/wa51MqD5wbi8KVbvJ9KjGJH7SqZK+B/QEFZLOy8Jn5a9O
	L8I68SUU9MsSJP1h/YJQ+KXQUMnYGTNJZBaePjPaQIFQYbaWrPzHeKQd
X-Gm-Gg: ATEYQzz1cPgqAye9XUkmbM9y22oVd63T/YyXHKhHotWiaAQezXxQG63gMNTkRouPdBO
	b9Dyf6mRxAxQpuGPRbF4YA2MfB/FIVPuOGUzYACGwtCCy0mX9tTM3xEK6y+6pqhLMaxHYiO9lJJ
	f3fww0V2kAtai0oYGrZJpYf/Zed1eRDyV0GeT10ZVt33vm3nrSl5DC1zvNFWwrzp1y0t+hGIg27
	ogWxR2mbPxeadJyVCNzNzoaf7NLxPeXT95pidgbCcLk6HU30fCjsBCl4a/ZYhpeolhcWGC3t+Lq
	w3DqycPdjB4ZcjULL9FxPpIUq3T7QGAKHL69JED0OO640KU6Mf4B0KR0XL9iM6RtDxyPjxKVEEV
	AX2zQ1Pew0hvdZkP1hONAlcn/C2TM2N0Hf4JcUUysG7wFLSBGh2mvfTtt1X7U7W8iNHgZwAe72Z
	EXdUKq1pX6oit3E/0S69IumbE=
X-Received: by 2002:a05:600c:1e2a:b0:47e:e57d:404 with SMTP id 5b1f17b1804b1-485269582efmr255465235e9.16.1773164338375;
        Tue, 10 Mar 2026 10:38:58 -0700 (PDT)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a900easm103239295e9.9.2026.03.10.10.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:38:58 -0700 (PDT)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org,
	maxime.chevallier@bootlin.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH net-next v7 4/4] net: phy: realtek: add RTL8224 polarity support
Date: Tue, 10 Mar 2026 18:38:46 +0100
Message-ID: <20260310173846.230923-5-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310173846.230923-1-dam.dejean@gmail.com>
References: <20260310173846.230923-1-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 551B7255CDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266272-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The RTL8224 has a register to configure the polarity of every pair of
each port. It provides device designers more flexbility when wiring the
chip.

Unfortunately, the register is left in an unknown state after a reset.
Thus on devices where the bootloader don't initialize it, the driver has
to do it to detect and use a link.

The MDI polarity swap can be set in the device tree using the property
enet-phy-pair-polarity. The u32 value is a bitfield where bit[0..3]
control the polarity of pairs A..D.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 drivers/net/phy/realtek/realtek_main.c | 77 ++++++++++++++++++++------
 1 file changed, 59 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index ee3f7318e933..a3691f9c19a5 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -172,6 +172,7 @@
 #define RTL8224_SRAM_RTCT_LEN(pair)		(0x8028 + (pair) * 4)
 
 #define RTL8224_VND1_MDI_PAIR_SWAP		0xa90
+#define RTL8224_VND1_MDI_POLARITY_SWAP		0xa94
 
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
@@ -1822,12 +1823,35 @@ static int rtl8224_cable_test_get_status(struct phy_device *phydev, bool *finish
 	return rtl8224_cable_test_report(phydev, finished);
 }
 
+static int rtl8224_package_modify_mmd(struct phy_device *phydev, int devad,
+				      u32 regnum, u16 mask, u16 set)
+{
+	int val, ret;
+
+	phy_lock_mdio_bus(phydev);
+
+	val = __phy_package_read_mmd(phydev, 0, devad, regnum);
+	if (val < 0) {
+		ret = val;
+		goto exit;
+	}
+
+	val &= ~mask;
+	val |= set;
+
+	ret = __phy_package_write_mmd(phydev, 0, devad, regnum, val);
+
+exit:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
 static int rtl8224_mdi_config_order(struct phy_device *phydev)
 {
 	struct device_node *np = phydev->mdio.dev.of_node;
 	u8 port_offset = phydev->mdio.addr & 3;
 	u32 order = 0;
-	int ret, val;
+	int ret;
 
 	ret = of_property_read_u32(np, "enet-phy-pair-order", &order);
 
@@ -1841,29 +1865,46 @@ static int rtl8224_mdi_config_order(struct phy_device *phydev)
 	if (order & ~1)
 		return -EINVAL;
 
-	phy_lock_mdio_bus(phydev);
-	val = __phy_package_read_mmd(phydev, 0, MDIO_MMD_VEND1,
-				     RTL8224_VND1_MDI_PAIR_SWAP);
-	if (val < 0) {
-		ret = val;
-		goto exit;
-	}
+	return rtl8224_package_modify_mmd(phydev, MDIO_MMD_VEND1,
+					  RTL8224_VND1_MDI_PAIR_SWAP,
+					  BIT(port_offset),
+					  order ? BIT(port_offset) : 0);
+}
 
-	if (order)
-		val |= (1 << port_offset);
-	else
-		val &= ~(1 << port_offset);
+static int rtl8224_mdi_config_polarity(struct phy_device *phydev)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	u8 offset = (phydev->mdio.addr & 3) * 4;
+	u32 polarity = 0;
+	int ret;
 
-	ret = __phy_package_write_mmd(phydev, 0, MDIO_MMD_VEND1,
-				      RTL8224_VND1_MDI_PAIR_SWAP, val);
-exit:
-	phy_unlock_mdio_bus(phydev);
-	return ret;
+	ret = of_property_read_u32(np, "enet-phy-pair-polarity", &polarity);
+
+	/* Do nothing if the property is not present */
+	if (ret == -EINVAL)
+		return 0;
+
+	if (ret)
+		return ret;
+
+	if (polarity & ~0xf)
+		return -EINVAL;
+
+	return rtl8224_package_modify_mmd(phydev, MDIO_MMD_VEND1,
+					  RTL8224_VND1_MDI_POLARITY_SWAP,
+					  0xf << offset,
+					  polarity << offset);
 }
 
 static int rtl8224_config_init(struct phy_device *phydev)
 {
-	return rtl8224_mdi_config_order(phydev);
+	int ret;
+
+	ret = rtl8224_mdi_config_order(phydev);
+	if (ret)
+		return ret;
+
+	return rtl8224_mdi_config_polarity(phydev);
 }
 
 static int rtl8224_probe(struct phy_device *phydev)
-- 
2.47.3


