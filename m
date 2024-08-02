Return-Path: <netdev+bounces-115221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B080945752
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 07:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894651C22567
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 05:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AF520323;
	Fri,  2 Aug 2024 05:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iF1f4i8R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFAA2C9D;
	Fri,  2 Aug 2024 05:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722575786; cv=none; b=SrdlY+cWMS0+/4fLeCpOMyXfhmrT00tIrYtvSjZTPIBjciWQzTDwj7/nb3D0aFYGlkSHFzk1MduThnzSYt6eWSkU7X5kdtQbiCsSgu2FGvZn5Q0r8Am2cBgnNntDK6xnl3DlhCwn0uN6R7wLDkqgM2Mj0hy+FZRqv/bIn1ZN3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722575786; c=relaxed/simple;
	bh=tPrfhMTNpUynDeUjZdYqskwMEJjTr0aThAoUisWdS+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ck13kVapZ34QNb5twHsb6asPjeqQCmJ90AMTqKRnPW2h4qsJu+BHKKGPcuZPPXCkNJlwn+Vclqt9z8UU+CFLaz/p6ia1ztouJrt9OEwfKa1K6Gl4T0jrrjzhMDTT+c1VRJPP5O63rVNqZWMg8qba2yznjoLMeyH0Y1NFt2I4eEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iF1f4i8R; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso5707071e87.3;
        Thu, 01 Aug 2024 22:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722575782; x=1723180582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WQm7e8C+pnNsg5JZY2JhlWJSLAihgvOivwCZy06g0Vg=;
        b=iF1f4i8RIknkHCucF34tjLvBU5hXVubdUgipU28Ai9VZ5BzwZ1mknPUrjBs+w5kMXS
         yy2sqsNNc+UC10C3sypKBTF34HX16AE2OwXC1enjOAS3NUI8S9fMnhQhNkYZkcLeSQtp
         f6FA7y6mXQ/yPK+7UsrU/woHvGT849bQANFBTWgX8NGvWl9Hm41N7j6CkKEAjPjhDR7m
         IoiDWaFwF07qtMDCrV+eYMRn5+x60xGmzRTTHChZOz0Shq9H19wHESq1uOv7DpAY6KDF
         MFOE03/3eGpryHRtwi0USwHY/kJZr1ybUxnyA3cEuqtXFHTMcDbJBJpL5ShGnAbj3P/G
         jtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722575782; x=1723180582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQm7e8C+pnNsg5JZY2JhlWJSLAihgvOivwCZy06g0Vg=;
        b=PiaYcpUMZteNLbvPC6d5i42/GF0RLb0BfqLkt3Kr2NLa/SMRmDo2hFp/atljBY2bxp
         gL+DjaW2N5oFju1reRmbC/YuRlepL4soI1nEZ0a4L4zdbxLdpsfBoevrFe4YyBtmcKKJ
         Jc+niJkVywEaVGZo32L96qKciaBg5B0Pj7wpnYi0yD6Z59WAD+SXH5I2lpy3FwF6Z2Z5
         x4iuZFzYMgHUL29bMsbh01JXf1n1oJatYtU84lwUa1rdKc8x0ZghX86bvf03a0lIuI3s
         9mO08AmPIWxe0TgyUGU8oll3J3MBcEFkZFftcs4aLnaMwCWePTGzFMXq9DdIVWj3wR/4
         a6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsRqBd7kwLbuug0U30EAyg4fMZdThtgqK5CZJltxlZJP0dq3rMuhyL6wn8dYKujepWx616/3vuAfUTJdMZZxq3IDVsBydhTtZ0Ziy1
X-Gm-Message-State: AOJu0Yz+iwDxSyhrkAcIgIPltrAeNpaaIWe1Q36GwJsgSqbxXj7KvHMX
	DUu7D8P6Opxzu9Ohl/mYVFGEOBTWyQs2mSgs/LIzjqlZuk0D61bH5qvPU7UD
X-Google-Smtp-Source: AGHT+IHshsD+i5leT1VoMBtSKqhGXkdLxehXyPogxHwktYJVZFGqP72HJW+8JTNBNGXvHw2otMhf+Q==
X-Received: by 2002:a05:6512:104b:b0:52e:932d:88ab with SMTP id 2adb3069b0e04-530bb38c968mr1813580e87.23.1722575781463;
        Thu, 01 Aug 2024 22:16:21 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba35230sm125336e87.198.2024.08.01.22.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 22:16:20 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: phy: vitesse: implement downshift in vsc73xx phys
Date: Fri,  2 Aug 2024 07:16:09 +0200
Message-Id: <20240802051609.637406-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit implements downshift feature in vsc73xx family phys.

By default downshift was enabled with maximum tries.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

---
v2:
  - rebased to current net-next/main

This patch came from net-next patch series[0] which was splitted.
It's simplified as Russell King requested.

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-10-paweldembicki@gmail.com/
---
 drivers/net/phy/vitesse.c | 90 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index 897b979ec03c..67ac4a2756ca 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -10,8 +10,10 @@
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
+#include <linux/bitfield.h>
 
 /* Vitesse Extended Page Magic Register(s) */
+#define MII_VSC73XX_EXT_PAGE_1E		0x01
 #define MII_VSC82X4_EXT_PAGE_16E	0x10
 #define MII_VSC82X4_EXT_PAGE_17E	0x11
 #define MII_VSC82X4_EXT_PAGE_18E	0x12
@@ -60,6 +62,15 @@
 /* Vitesse Extended Page Access Register */
 #define MII_VSC82X4_EXT_PAGE_ACCESS	0x1f
 
+/* Vitesse VSC73XX Extended Control Register */
+#define MII_VSC73XX_PHY_CTRL_EXT3		0x14
+
+#define MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_EN	BIT(4)
+#define MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_CNT	GENMASK(3, 2)
+#define MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_STA	BIT(1)
+#define MII_VSC73XX_DOWNSHIFT_MAX		5
+#define MII_VSC73XX_DOWNSHIFT_INVAL		1
+
 /* Vitesse VSC8601 Extended PHY Control Register 1 */
 #define MII_VSC8601_EPHY_CTL		0x17
 #define MII_VSC8601_EPHY_CTL_RGMII_SKEW	(1 << 8)
@@ -128,6 +139,74 @@ static int vsc73xx_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, VSC73XX_EXT_PAGE_ACCESS, page);
 }
 
+static int vsc73xx_get_downshift(struct phy_device *phydev, u8 *data)
+{
+	int val, enable, cnt;
+
+	val = phy_read_paged(phydev, MII_VSC73XX_EXT_PAGE_1E,
+			     MII_VSC73XX_PHY_CTRL_EXT3);
+	if (val < 0)
+		return val;
+
+	enable = FIELD_GET(MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_EN, val);
+	cnt = FIELD_GET(MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_CNT, val) + 2;
+
+	*data = enable ? cnt : DOWNSHIFT_DEV_DISABLE;
+
+	return 0;
+}
+
+static int vsc73xx_set_downshift(struct phy_device *phydev, u8 cnt)
+{
+	u16 mask, val;
+	int ret;
+
+	if (cnt > MII_VSC73XX_DOWNSHIFT_MAX)
+		return -E2BIG;
+	else if (cnt == MII_VSC73XX_DOWNSHIFT_INVAL)
+		return -EINVAL;
+
+	mask = MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_EN;
+
+	if (!cnt) {
+		val = 0;
+	} else {
+		mask |= MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_CNT;
+		val = MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_EN |
+		      FIELD_PREP(MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_CNT,
+				 cnt - 2);
+	}
+
+	ret = phy_modify_paged(phydev, MII_VSC73XX_EXT_PAGE_1E,
+			       MII_VSC73XX_PHY_CTRL_EXT3, mask, val);
+	if (ret < 0)
+		return ret;
+
+	return genphy_soft_reset(phydev);
+}
+
+static int vsc73xx_get_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return vsc73xx_get_downshift(phydev, data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int vsc73xx_set_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, const void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return vsc73xx_set_downshift(phydev, *(const u8 *)data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static void vsc73xx_config_init(struct phy_device *phydev)
 {
 	/* Receiver init */
@@ -137,6 +216,9 @@ static void vsc73xx_config_init(struct phy_device *phydev)
 
 	/* Config LEDs 0x61 */
 	phy_modify(phydev, MII_TPISTATUS, 0xff00, 0x0061);
+
+	/* Enable downshift by default */
+	vsc73xx_set_downshift(phydev, MII_VSC73XX_DOWNSHIFT_MAX);
 }
 
 static int vsc738x_config_init(struct phy_device *phydev)
@@ -447,6 +529,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
+	.get_tunable    = vsc73xx_get_tunable,
+	.set_tunable    = vsc73xx_set_tunable,
 }, {
 	.phy_id         = PHY_ID_VSC7388,
 	.name           = "Vitesse VSC7388",
@@ -456,6 +540,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
+	.get_tunable    = vsc73xx_get_tunable,
+	.set_tunable    = vsc73xx_set_tunable,
 }, {
 	.phy_id         = PHY_ID_VSC7395,
 	.name           = "Vitesse VSC7395",
@@ -465,6 +551,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
+	.get_tunable    = vsc73xx_get_tunable,
+	.set_tunable    = vsc73xx_set_tunable,
 }, {
 	.phy_id         = PHY_ID_VSC7398,
 	.name           = "Vitesse VSC7398",
@@ -474,6 +562,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
+	.get_tunable    = vsc73xx_get_tunable,
+	.set_tunable    = vsc73xx_set_tunable,
 }, {
 	.phy_id         = PHY_ID_VSC8662,
 	.name           = "Vitesse VSC8662",
-- 
2.34.1


