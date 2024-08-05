Return-Path: <netdev+bounces-115885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BFB948418
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9284D1F21DE9
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 21:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EAC16C84B;
	Mon,  5 Aug 2024 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfwL8tnZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C402913C90F;
	Mon,  5 Aug 2024 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893019; cv=none; b=IvGIr0JqR5lMeLCPaS3BzODi7JHNyvBkC7weCP8a2kaJJ75KVbrI5bI75XLBCOBS18UElOoMkktC9F6gJ2cvPuokmT4BIdH9rZZk4iTWggquJBejTRGWIfxiD4K18p3qrNytWau4Dpr5yuylohWsxOeCgY8car3kJbo5f7JLGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893019; c=relaxed/simple;
	bh=6T9Zzq2l0xHxUBu3W7B/XPT/1DyqdGz1WIfaqGCewTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F1tlEBf5gwuKwDazTpifaFepIeU+3zw1tXzd6VWI9Q5ftmtXajcr0zNuyUGiupINGiExSqBIzW+cKBsu7zwCGRhnYf+OT//YnzYWARBxF7j7IH/4QxV+Nsp2Z/kyyIrjYQVojf4N5N3maD1a7CoR6sQ1BW6T1peMApx29T5d+GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfwL8tnZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so211226e87.0;
        Mon, 05 Aug 2024 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722893016; x=1723497816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WF2fMDB+n/mFpBaadsV9S0GjInGv5Q7jWfUz4BjQAaI=;
        b=JfwL8tnZ52OAE0V+mUEMaZ5QDY4ml1znzCmsHG35vhEwCgBBPNTAQgF4VG+Tsy/5St
         eJYomRZhjGZ3pV5Pfghba4fQ5kDRjJk6DpsLSaBK7wFyzliVqldOCRbf2GDiB9wRNVlp
         XngshRHPbMjuJWEiKh65Qse9hK3xTcWzYn8YWAhb5AXorxAbgdKTaKrR1KLohcWnWr0l
         rstpNUAqDEHM5PdHLw1dENutKPFDrxkTRgZHZNfLIO17uhU8/eZYmZRTleYMuxvSwq8Y
         s2Y4IRgrFEcKw6jlNPakeClEDx1J+9L2pmBSGxEcZcOxw7qvrcNoYeaLjld1n/PakUgp
         CT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722893016; x=1723497816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WF2fMDB+n/mFpBaadsV9S0GjInGv5Q7jWfUz4BjQAaI=;
        b=oCbsn/JPBtHGYpnLgRDVAKlP6gwI4uHwXHLK8H6s0oyiPPrZSY0c4gn7Uth9ghr++A
         X2T5SI/a7jajGBWY4f+CjuTuMeaU4uvVSpYqYC5C90YXamSg+BKpuaxnaRvMaEHh5TCR
         0tVZxFt/7WyaBzc6ckzmZHJXk+T54T6Oo0e3UrEp1IqLakjFgV0pSE1A/aYc4r54LWv2
         uWlCffWnFrDHJy+xJ6Zu4f2IlaSVIZOWHdjKwiiiqo9KS4pxw1wzF+78enyPM8rqvoXs
         PQfea03Wq+eU/E7XqPO0tOzTRYPnt2g+eRitKgcUCy3aPldwaJjynXtStgn6eA/syD5Y
         EgEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpRVVL9AvF5EBUCQesJB3a25NMJWbDLxSkeD4E34a4bdBjYzmEfzH4WCQmWz4eum4K2AwcD1KNhDW+Fk9GtpXB1Rt3bKflhl3MadLM
X-Gm-Message-State: AOJu0YwkF+5gkGOf6soR80FL3T1W5Vv65G9/XGc5RJDtSx1qvrs9QeFT
	RGcWMkuNbulk1JzDPLGcyhGsXwvBI2AviDAC9zxTI2Y7smmYPnjuSN5F9y2Y
X-Google-Smtp-Source: AGHT+IFxl2KtrIOBqIhl4pSfCKwP3Hh1VwOF6F9pEZVolJaxj7Cn7EdtyKAZ1elh2fEDaUyC8aiF8A==
X-Received: by 2002:a05:6512:3ba5:b0:52e:fefe:49c9 with SMTP id 2adb3069b0e04-530bb39ddf8mr9764672e87.36.1722893015164;
        Mon, 05 Aug 2024 14:23:35 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:1688:6c25:c8e4:9968])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba07360sm1262665e87.58.2024.08.05.14.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 14:23:34 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: vsc73xx: use defined values in phy operations
Date: Mon,  5 Aug 2024 23:23:22 +0200
Message-Id: <20240805212322.1696789-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit changes magic numbers in phy operations.
Some shifted registers was replaced with bitfield macros.

No functional changes done.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
This patch came from net series[0].
Changes since net:
  - rebased to net-next/main only

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240802080403.739509-4-paweldembicki@gmail.com/
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 45 +++++++++++++++++++-------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 1711e780e65b..a82b550a9e40 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
 #include <linux/etherdevice.h>
@@ -41,7 +42,8 @@
 #define VSC73XX_BLOCK_SYSTEM	0x7 /* Only subblock 0 */
 
 /* MII Block subblock */
-#define VSC73XX_BLOCK_MII_INTERNAL     0x0 /* Internal MDIO subblock */
+#define VSC73XX_BLOCK_MII_INTERNAL	0x0 /* Internal MDIO subblock */
+#define VSC73XX_BLOCK_MII_EXTERNAL	0x1 /* External MDIO subblock */
 
 #define CPU_PORT	6 /* CPU port */
 
@@ -224,10 +226,23 @@
 #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_CLEAR_TABLE	3
 
 /* MII block 3 registers */
-#define VSC73XX_MII_STAT	0x0
-#define VSC73XX_MII_CMD		0x1
-#define VSC73XX_MII_DATA	0x2
-#define VSC73XX_MII_MPRES	0x3
+#define VSC73XX_MII_STAT		0x0
+#define VSC73XX_MII_CMD			0x1
+#define VSC73XX_MII_DATA		0x2
+#define VSC73XX_MII_MPRES		0x3
+
+#define VSC73XX_MII_STAT_BUSY		BIT(3)
+#define VSC73XX_MII_STAT_READ		BIT(2)
+#define VSC73XX_MII_STAT_WRITE		BIT(1)
+
+#define VSC73XX_MII_CMD_SCAN		BIT(27)
+#define VSC73XX_MII_CMD_OPERATION	BIT(26)
+#define VSC73XX_MII_CMD_PHY_ADDR	GENMASK(25, 21)
+#define VSC73XX_MII_CMD_PHY_REG		GENMASK(20, 16)
+#define VSC73XX_MII_CMD_WRITE_DATA	GENMASK(15, 0)
+
+#define VSC73XX_MII_DATA_FAILURE	BIT(16)
+#define VSC73XX_MII_DATA_READ_DATA	GENMASK(15, 0)
 
 #define VSC73XX_MII_MPRES_NOPREAMBLE	BIT(6)
 #define VSC73XX_MII_MPRES_PRESCALEVAL	GENMASK(5, 0)
@@ -543,20 +558,24 @@ static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
 	int ret;
 
 	/* Setting bit 26 means "read" */
-	cmd = BIT(26) | (phy << 21) | (regnum << 16);
-	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, 0, 1, cmd);
+	cmd = VSC73XX_MII_CMD_OPERATION |
+	      FIELD_PREP(VSC73XX_MII_CMD_PHY_ADDR, phy) |
+	      FIELD_PREP(VSC73XX_MII_CMD_PHY_REG, regnum);
+	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
+			    VSC73XX_MII_CMD, cmd);
 	if (ret)
 		return ret;
 	msleep(2);
-	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_MII, 0, 2, &val);
+	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
+			   VSC73XX_MII_DATA, &val);
 	if (ret)
 		return ret;
-	if (val & BIT(16)) {
+	if (val & VSC73XX_MII_DATA_FAILURE) {
 		dev_err(vsc->dev, "reading reg %02x from phy%d failed\n",
 			regnum, phy);
 		return -EIO;
 	}
-	val &= 0xFFFFU;
+	val &= VSC73XX_MII_DATA_READ_DATA;
 
 	dev_dbg(vsc->dev, "read reg %02x from phy%d = %04x\n",
 		regnum, phy, val);
@@ -582,8 +601,10 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 		return 0;
 	}
 
-	cmd = (phy << 21) | (regnum << 16);
-	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, 0, 1, cmd);
+	cmd = FIELD_PREP(VSC73XX_MII_CMD_PHY_ADDR, phy) |
+	      FIELD_PREP(VSC73XX_MII_CMD_PHY_REG, regnum);
+	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
+			    VSC73XX_MII_CMD, cmd);
 	if (ret)
 		return ret;
 
-- 
2.34.1


