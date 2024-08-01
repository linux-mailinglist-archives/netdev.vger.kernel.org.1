Return-Path: <netdev+bounces-114800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E445B94428E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 07:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5CCB213DB
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 05:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6572113D897;
	Thu,  1 Aug 2024 05:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKGF0fwD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B28713D896;
	Thu,  1 Aug 2024 05:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488990; cv=none; b=qKgtWjyppGRHIzPJ9EKVMQx26gWhqMFfPVHRRH6UT6PD/tm4mUjO7cZsrQw/uWJGx3vi2aCjYgBfR24y205lyL+XtklPNm/8Fz6eeylPLlbuY5+vvyxgppJVOivGWp3B51g1EM/kyNdIUQgttbnldmjvUFL/rhF4qQ5PZFtmD5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488990; c=relaxed/simple;
	bh=nHb6lEUHZi1toKpMAARAgRxA9UYHiKEtz7z3MClrIEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dMmu3vYhViRcdQ+AXqnRNQAWEFRFUvFE+myKlsA2ZZt2EqHjXPD6tnU+kvaUqnU28RZTZtmdiufccD6iUiBU1dwyeOdN0JVFA+Ljs737UBWHS9LiIGqwuNkagzW7NTdFiyZM7952IVr55WdqjxtGVjLzfWLaqWJ/H/hrXLhVIW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKGF0fwD; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f035ae0fd1so76005061fa.2;
        Wed, 31 Jul 2024 22:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722488986; x=1723093786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xRwhtgkVbim64kFSvCu5VgEKFVZ26jSmTV4RIeV4eNA=;
        b=TKGF0fwDCwEtz2zNCXRW3UR/klDWcIB6mWuDvTbgTDM4OaTBCpfvWjOQD7v3kQNiY0
         J2WwcfEaXKfL23pEnKK1ZU1d8L28NuImOgIQ78dVe4qXIyj7H9OZEHJto85BLEQdSWv8
         oFW5JgV6t08iRZhUdbk/3C8Nc9Q1lmATn8MGZBz47hoX2QNmwz91LkRPD9LNV0pA6eoS
         gfW2Nmxkh1vteky5S33Vj17FFjtIXKZ9XCg8ChWHBtkx3KmHFX0BNoVXXkLHhitvk8I6
         Sa2C9Wypwan6ZCRbPSp53neTdl/pULeopUExBUNL5tXj7lu4/V8a1IRrmQu9tlpu/jRv
         iPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488986; x=1723093786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRwhtgkVbim64kFSvCu5VgEKFVZ26jSmTV4RIeV4eNA=;
        b=DgD9jbLzLBgxrtUoUx1VDZR6tZIz6ZIW1oumWGnO5sKHqJPyxUOpKwKbaqZgbXljFf
         5ZQvjYQdH3K+Pt8t4cBOaV9+gLakyq+Ew4Pvm4lUHcTrzmyCDrHnBMbIztQNRXDTv39x
         4puJTKy5X34YtMeqjQsQCSf6/I+0z9sDkDIaeW4UWPvjn7KfTWK8lfpauNpgnJ6xf/2W
         K3NV/dMJ4m4RHf8bVH64N5Q6ftuzPfvoLJAK06SW1TjO/oeeGGLces5+fcyN0FgUR4hv
         hy2Ny9wFPOW2LuRO2VfBO6MiAkZbhg1qulfx0AGtZ6LKVtI1NXyHgxIjUKKb9eWXDnW3
         sJRw==
X-Forwarded-Encrypted: i=1; AJvYcCWsz9XPcQFTvTTH+hOwfoT2V5xLOnUmSwe4LjsGXTvLou9eKfp2B7wvLqhJ676ZWMun1v4p9EUV1/PtlC59UybyDphkLa6Wo9s/Yg2f
X-Gm-Message-State: AOJu0YyYP5A1aGYvChd6UYQfBtk/BMMChsTlkh8suCU7fKp7n2uJfGIB
	s1EWT/MXnotGF0DIanvsugPkjPbUA1vpveiHQUF8Is6frJr9DxRFC7/Hlj67
X-Google-Smtp-Source: AGHT+IH2DWuwqyTBdjpC/crMoWKi77ApW/pbtMgFZpqpe9j7sMXAPoHOoLBs3n9Xci7eELI9nFUiHA==
X-Received: by 2002:a05:651c:c8:b0:2ef:290e:4a2b with SMTP id 38308e7fff4ca-2f1532daefemr9215241fa.38.1722488985843;
        Wed, 31 Jul 2024 22:09:45 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03d075447sm21664971fa.121.2024.07.31.22.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 22:09:45 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: vitesse: implement downshift in vsc73xx phys
Date: Thu,  1 Aug 2024 07:09:10 +0200
Message-Id: <20240801050909.584460-1-paweldembicki@gmail.com>
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

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

---
This patch came from net-next patch series[0] which was splitted.
It's simplified as Russell King requested.

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-10-paweldembicki@gmail.com/
---
 drivers/net/phy/vitesse.c | 90 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index 19b7bf189be5..82b1fc1a3276 100644
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
 /* VSC73XX PHY_BYPASS_CTRL register*/
 #define MII_VSC73XX_PHY_BYPASS_CTRL		MII_DCOUNTER
 #define MII_PBC_FORCED_SPEED_AUTO_MDIX_DIS	BIT(7)
@@ -133,6 +144,74 @@ static int vsc73xx_write_page(struct phy_device *phydev, int page)
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
@@ -142,6 +221,9 @@ static void vsc73xx_config_init(struct phy_device *phydev)
 
 	/* Config LEDs 0x61 */
 	phy_modify(phydev, MII_TPISTATUS, 0xff00, 0x0061);
+
+	/* Enable downshift by default */
+	vsc73xx_set_downshift(phydev, MII_VSC73XX_DOWNSHIFT_MAX);
 }
 
 static int vsc738x_config_init(struct phy_device *phydev)
@@ -460,6 +542,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
+	.get_tunable    = vsc73xx_get_tunable,
+	.set_tunable    = vsc73xx_set_tunable,
 }, {
 	.phy_id         = PHY_ID_VSC7388,
 	.name           = "Vitesse VSC7388",
@@ -469,6 +553,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
+	.get_tunable    = vsc73xx_get_tunable,
+	.set_tunable    = vsc73xx_set_tunable,
 }, {
 	.phy_id         = PHY_ID_VSC7395,
 	.name           = "Vitesse VSC7395",
@@ -478,6 +564,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
+	.get_tunable    = vsc73xx_get_tunable,
+	.set_tunable    = vsc73xx_set_tunable,
 }, {
 	.phy_id         = PHY_ID_VSC7398,
 	.name           = "Vitesse VSC7398",
@@ -487,6 +575,8 @@ static struct phy_driver vsc82xx_driver[] = {
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


