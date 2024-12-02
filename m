Return-Path: <netdev+bounces-148197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8B09E0D42
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C29B253C5
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 19:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AA21DE4E7;
	Mon,  2 Dec 2024 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoKHV+nH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B221632FE;
	Mon,  2 Dec 2024 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169037; cv=none; b=h07TkRSs8mI2ZZGxzpJrZRHH+RstfJOoVCFSPDPTkJx0SuDXhBDBtj9E1n6PMVgRzc6tZpLmBfu1gOXnw68jDzEWvd+JcDJkyfaUo+SK6YGXw6SOcT5gdPge7o+ulRVildU+qIOIRat8i8sSnWklqjWtAy4SN94jw5AB0h/iiaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169037; c=relaxed/simple;
	bh=qWmrRSITex0bqNvb4G3jK4p92XZMgKN8OEGETSvrCxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yqeu0M1XGOF6jxVl8MoKYJ6X0zeQXd4mJjhyyrQHTRQSHLgwR11wMCsaIhx+3I9Urp5znZjTJVQXGTOFskTsr4yx1TroXRWyxMFmQ2FzTsB5BiQ1aOYIf7bkiwrdc7Ml3DvtFTEMNhe6qdCYqJxL/EgyscR4mlZJgPmkHa78wVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoKHV+nH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-215564e34acso4542565ad.3;
        Mon, 02 Dec 2024 11:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733169035; x=1733773835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j6KU1XTLeOsYpmnp4/FCdzEmkfYdYIrUYSYnSf6Dp50=;
        b=LoKHV+nHusYzocKaU+W4oKmaYPN0HrulUQsABgxBojS/U993g+WK7qQMlauTvUHQpG
         5lwdWUKrCQW240kSkcC++efFWKeGROk4HO9c7M3ty7tnJN3V5udP29FgKt99ABi1/C62
         nQk9ENe3VIXfKPnMwXZsB/tV1VM/Z4yjnXHJ0F3mflMe/+c1WBPniYtg3TRIiXhHq+1F
         E29EodbBZk8R3/PFn+V9/qTkIX0Pq9YtGBMTcfM7eXmyJQ++w5aKv6fIU9ImcPWs7LAP
         ImO4IAlfc1JauxQC9iQxBLxnkMZWNryUbzxdlay/2m/ZWn1LgIpoxQ+cgozgbKAxpFcK
         Wr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733169035; x=1733773835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6KU1XTLeOsYpmnp4/FCdzEmkfYdYIrUYSYnSf6Dp50=;
        b=d+gCGg0DTnGzl3tY8Z+GeXTE5yjmpPkfcM5EUCSD6FYMWjUcF1DbxRfAWPOqmK+f8l
         yE9Z5Dkt50t86r8Ge1C5VbMqu2I6cQW3xgATzs9ybzcv1t8FuUpp2lhxQzA1JWD2zs5/
         N7+fAxI3NQnsMLMzwIuCOxwO9M7VGA5uobsWT/5vpMZEMzg0cbwYMRYlQ0F+82aw0vPJ
         b29P371V5eICoPPV5dcK9GT2c0evppKun2n0SeitxE9eeWhGzDoAN6YduyOFuQfO33+1
         QsjE5/t6YS7DEc9QZ6YwogU8U4nFTbrMdprKFc5+zV2U0Cuax2g5h8rhRZtzcoUxuc3T
         9Eww==
X-Forwarded-Encrypted: i=1; AJvYcCU6rqL+//mljpwhr+Xa6g24IqCtEEyJx8GHy3OjamqX5fQs4sIk8+nklpr/8CfC6MhWpS7o95lrBwKvArI=@vger.kernel.org, AJvYcCVVJRuXNDeLCDKkjQs9JWb9Y+FpIq2c7U1OEuw2h+nocS28QbYGB0gHuei19ZIO9ykcTHvS6ETZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzQc54qnDka5/xc6G1ODjh3n5uORgCXujgfCGeP+rR2pWZwr3tx
	Q+9TmE3Hmim2LM0J5QKrFyx8ywhfp39lGIWDwRpsBSrm8cPa/4OL
X-Gm-Gg: ASbGncv6yoIb9EK5+tIks0oVSKmkohmIjXbTSThJ2ce5x1cC34bcxqlgdgOYXQj9a6h
	ftR/oKper+WQ0tCxSiinXlfUQQ6CaGjhITlq4KIB2Ct+W8XVlSVQZc3p1nvfXmXYRBIZgJ2eS8L
	Q0OJxb8ECVIRUrjGQG2ugnRbhlg0dXMCqWoTY0i+25preIjoflxFUfdol/G9DT+xumwaKln+Bfs
	X0NZxMJniwMItbNRAM1hLb5liRhuMjUJLvoqwx/rd4xA0JMOGhdi8pXhUgS
X-Google-Smtp-Source: AGHT+IGI0a0Oq3sOwa8XvTaGf7K2n6fayWnEXM23qQC2B0iYCFKkpAICa7oc7yYzF/YGOCIiZ7IPxg==
X-Received: by 2002:a17:903:2301:b0:20c:f648:e388 with SMTP id d9443c01a7336-21501384201mr124247075ad.7.1733169035402;
        Mon, 02 Dec 2024 11:50:35 -0800 (PST)
Received: from nas-server.i.2e4.me ([156.251.176.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f553fsm81232515ad.6.2024.12.02.11.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 11:50:35 -0800 (PST)
From: Zhiyuan Wan <kmlinuxm@gmail.com>
To: andrew@lunn.ch
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy.liu@realtek.com,
	Zhiyuan Wan <kmlinuxm@gmail.com>,
	Yuki Lee <febrieac@outlook.com>
Subject: [PATCH 1/2] net: phy: realtek: add combo mode support for RTL8211FS
Date: Tue,  3 Dec 2024 03:50:28 +0800
Message-Id: <20241202195029.2045633-1-kmlinuxm@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RTL8211FS chip is an ethernet transceiver with both copper MDIX and
optical (SGMII) port, and it has ability to switch between copper and
optical mode (combo mode).

On Linux kernel v6.12.1, the driver doesn't support negotiation port mode,
which causes optical mode unusable, and copper mode works fine.

This patch solved the issue above by add negotiation phase for this
transceiver chip, allows this transceiver works in combo mode.

Signed-off-by: Yuki Lee <febrieac@outlook.com>
Signed-off-by: Zhiyuan Wan <kmlinuxm@gmail.com>
---
 drivers/net/phy/realtek.c | 67 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index f65d7f1f3..10a87d58c 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -32,6 +32,11 @@
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_INSR				0x1d
 
+#define RTL8211FS_FIBER_ESR			0x0F
+#define RTL8211FS_MODE_MASK			0xC000
+#define RTL8211FS_MODE_COPPER			0
+#define RTL8211FS_MODE_FIBER			1
+
 #define RTL8211F_LEDCR				0x10
 #define RTL8211F_LEDCR_MODE			BIT(15)
 #define RTL8211F_LEDCR_ACT_TXRX			BIT(4)
@@ -110,6 +115,7 @@ struct rtl821x_priv {
 	u16 phycr1;
 	u16 phycr2;
 	bool has_phycr2;
+	int lastmode;
 	struct clk *clk;
 };
 
@@ -163,6 +169,44 @@ static int rtl821x_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl8211f_mode(struct phy_device *phydev)
+{
+	u16 val;
+
+	val = __phy_read(phydev, RTL8211FS_FIBER_ESR);
+	val &= RTL8211FS_MODE_MASK;
+
+	if (val)
+		return RTL8211FS_MODE_FIBER;
+	else
+		return RTL8211FS_MODE_COPPER;
+}
+
+static int rtl8211f_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+
+	struct rtl821x_priv *priv = phydev->priv;
+
+	ret = genphy_read_abilities(phydev);
+	if (ret < 0)
+		return ret;
+
+	linkmode_copy(phydev->advertising, phydev->supported);
+
+	if (rtl8211f_mode(phydev) == RTL8211FS_MODE_FIBER) {
+		dev_dbg(&phydev->mdio.dev, "fiber link up");
+		priv->lastmode = RTL8211FS_MODE_FIBER;
+		return genphy_c37_config_aneg(phydev);
+	}
+
+	dev_dbg(&phydev->mdio.dev, "copper link up");
+
+	priv->lastmode = RTL8211FS_MODE_COPPER;
+
+	return genphy_config_aneg(phydev);
+}
+
 static int rtl8201_ack_interrupt(struct phy_device *phydev)
 {
 	int err;
@@ -732,6 +776,26 @@ static int rtlgen_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl8211f_read_status(struct phy_device *phydev)
+{
+	int ret;
+	struct rtl821x_priv *priv = phydev->priv;
+	bool changed = false;
+
+	if (rtl8211f_mode(phydev) != priv->lastmode) {
+		changed = true;
+		ret = rtl8211f_config_aneg(phydev);
+		if (ret < 0)
+			return ret;
+
+		ret = genphy_restart_aneg(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
+	return genphy_c37_read_status(phydev, &changed);
+}
+
 static int rtlgen_read_mmd(struct phy_device *phydev, int devnum, u16 regnum)
 {
 	int ret;
@@ -1375,7 +1439,8 @@ static struct phy_driver realtek_drvs[] = {
 		.name		= "RTL8211F Gigabit Ethernet",
 		.probe		= rtl821x_probe,
 		.config_init	= &rtl8211f_config_init,
-		.read_status	= rtlgen_read_status,
+		.config_aneg	= rtl8211f_config_aneg,
+		.read_status	= rtl8211f_read_status,
 		.config_intr	= &rtl8211f_config_intr,
 		.handle_interrupt = rtl8211f_handle_interrupt,
 		.suspend	= rtl821x_suspend,
-- 
2.30.2


