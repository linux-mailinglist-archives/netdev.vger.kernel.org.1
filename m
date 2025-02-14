Return-Path: <netdev+bounces-166505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2406FA36326
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 648C87A58B9
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2DE267728;
	Fri, 14 Feb 2025 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZCz+nHc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5853026738E;
	Fri, 14 Feb 2025 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550748; cv=none; b=AnDfj+aU886ntm+zmIAXgQjtpgK0T6xSoVRtpMRXOKzoao60DmcWFMnYYIKbEmCc8/aE9gy5uoOLut0lT2EXppAxQGAhRnZO3xApvk3i8ylguaqp1MOqktYeXc38FlV0w/AaxCGnszA+BD7O/b9/jsZGImuKuzt4sdqv4pv3/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550748; c=relaxed/simple;
	bh=bbN5XPoPJYOE7dUWkYFpKfKibXLVL4Gt//xKGZaY0H0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=csd9yMGD3JldJ0H/70VuYUSBCKN5KIVooEUNM1pdHBqKhRBLiVeBVOsYgBAyVBuJsHkJWYxqWiM7ckdGP7/VyaRHUmQeEY916FIBACYLW561EitdJteGiu8oTHAc2+rF8M05UD1Tp2hvWzsDFJenQqBzq2oW+GgnhsO0YbMBF9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZCz+nHc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so452103166b.3;
        Fri, 14 Feb 2025 08:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739550744; x=1740155544; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLxy05oqMmwvq+/mJkLJb+5gbVQ1NvpKOenAaEc/PzE=;
        b=cZCz+nHcUs9IFTww+Ie2qGacCjv+w30sL89i/cwoLzZV5OkS+zJjYkGsiLhktwCq86
         PpElutf6fcixVsE0BpMqr5hN5Nuy5EXiZW6zMXfIsbrtXgyWGfKQZ/9Ok2SgvtTaZple
         bYdve/u1fZle0oWfMtYAuIopP2/gOg5LuO62x+hjHiXxPZRxkB7DN1ssvZWd49QcmrkI
         J1xHzLBpt+HMDSONz3IQtmjfLl2C657hDjj6RGy6uiCjVBDFkAAangXFeox/uWD3n5/2
         2eLJQAKhSWygpWzhg9b+mlH84VuAaEgm/HOwxmckjRxWzxrlqzHQKFLE0GxrTNyVikut
         PETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739550744; x=1740155544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLxy05oqMmwvq+/mJkLJb+5gbVQ1NvpKOenAaEc/PzE=;
        b=KGdNiA5qiRT2DnULJdCGawFi/+eVPI+euDzlu2Muija1rnTFx1/W1tdB2bR6mIqSVd
         qIil9Bx060F9USWvXftRX4I7NuBBHKFWM8ef2GeMqIHaGhXeYxWuQir2zQYFi/tsydK+
         db4PlB9azAvf3nK6+JgxsdUkMCQlqCxkMKXEieBRmV5ztLtL5dtpY+gbGsBhxMRCAUP8
         bTvpDb9Uexld0MopYmLCNua2YqTtcNMZi0kNNFT2SKdtRbg2smRX7mXoJ9Q4sxc/Tinm
         DBFSc+DrM+GxatABiCADdReNhfbBTfSCB6EFie7Xk0783Uv1uWeaQZOOikQbUMglvdta
         BH3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9IBeFG9uLAj+GSiFPc5uY9XfgunBi7e4vkC0SDyJmZBt6Enk5yyrPvKgKZhVpZDY/SlByTKAVEKbAxEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNnwsdA2g+XrysooUIehjqjAWfbrug/HTgvoSc7mktD2URKvp/
	At5jazaOJrWHSMq32PigQPEi70Tt/nj9GaFhaFD5Wzd6rrrtSddo
X-Gm-Gg: ASbGncua8i2mPGweJrCfA8vRMy0HxuFG1xu2zVxNjlpemVOGV/z16VnJOBEDz7QgMPJ
	yidXTsRqu1fEKqYaZzQdEJUi8LM4I8pQPiLLLINeW0FTH4w44ACgyJ7bc1zmk3S/mEZuF6luyk5
	AvwwOZg6fBHOKVZy/atozSeZKTrWJcUflRX9Ex0MhvkZ5ul4q6Hda0DtuMfghigixunvftly+bQ
	wJAL5+SZjIAjTiIIh9IZRcjVqM0Zw94/9SB8eHfuxpA+LlG+Y7k5/E4dqC807k6LufJ1KFe582i
	YHRkv5o747HNewk1Tqc=
X-Google-Smtp-Source: AGHT+IGXVcix/3pEl7EzZKrYT+OKqNgNeCyrmVjNrOsIfeVM8Zc3SBjYJ6jCN2Go0h/ZeI/Bx0MC+A==
X-Received: by 2002:a17:906:bc90:b0:aba:2464:ce07 with SMTP id a640c23a62f3a-aba2464df59mr704840966b.20.1739550744314;
        Fri, 14 Feb 2025 08:32:24 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:653:f300:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5323202dsm370716266b.6.2025.02.14.08.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:32:23 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Fri, 14 Feb 2025 17:32:03 +0100
Subject: [PATCH net-next 1/3] net: phy: marvell-88q2xxx: align defines
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-marvell-88q2xxx-cleanup-v1-1-71d67c20f308@gmail.com>
References: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
In-Reply-To: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2

Align some defines.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 62 +++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index bad5e7b2357da067bfd1ec6bd1307c42f5dc5c91..6e95de080bc65e8e8543d4effb9846fdd823a9d4 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -12,29 +12,29 @@
 #include <linux/phy.h>
 #include <linux/hwmon.h>
 
-#define PHY_ID_88Q2220_REVB0	(MARVELL_PHY_ID_88Q2220 | 0x1)
-#define PHY_ID_88Q2220_REVB1	(MARVELL_PHY_ID_88Q2220 | 0x2)
-#define PHY_ID_88Q2220_REVB2	(MARVELL_PHY_ID_88Q2220 | 0x3)
-
-#define MDIO_MMD_AN_MV_STAT			32769
-#define MDIO_MMD_AN_MV_STAT_ANEG		0x0100
-#define MDIO_MMD_AN_MV_STAT_LOCAL_RX		0x1000
-#define MDIO_MMD_AN_MV_STAT_REMOTE_RX		0x2000
-#define MDIO_MMD_AN_MV_STAT_LOCAL_MASTER	0x4000
-#define MDIO_MMD_AN_MV_STAT_MS_CONF_FAULT	0x8000
-
-#define MDIO_MMD_AN_MV_STAT2			32794
-#define MDIO_MMD_AN_MV_STAT2_AN_RESOLVED	0x0800
-#define MDIO_MMD_AN_MV_STAT2_100BT1		0x2000
-#define MDIO_MMD_AN_MV_STAT2_1000BT1		0x4000
-
-#define MDIO_MMD_PCS_MV_RESET_CTRL		32768
-#define MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE	0x8
-
-#define MDIO_MMD_PCS_MV_INT_EN			32784
-#define MDIO_MMD_PCS_MV_INT_EN_LINK_UP		0x0040
-#define MDIO_MMD_PCS_MV_INT_EN_LINK_DOWN	0x0080
-#define MDIO_MMD_PCS_MV_INT_EN_100BT1		0x1000
+#define PHY_ID_88Q2220_REVB0				(MARVELL_PHY_ID_88Q2220 | 0x1)
+#define PHY_ID_88Q2220_REVB1				(MARVELL_PHY_ID_88Q2220 | 0x2)
+#define PHY_ID_88Q2220_REVB2				(MARVELL_PHY_ID_88Q2220 | 0x3)
+
+#define MDIO_MMD_AN_MV_STAT				32769
+#define MDIO_MMD_AN_MV_STAT_ANEG			0x0100
+#define MDIO_MMD_AN_MV_STAT_LOCAL_RX			0x1000
+#define MDIO_MMD_AN_MV_STAT_REMOTE_RX			0x2000
+#define MDIO_MMD_AN_MV_STAT_LOCAL_MASTER		0x4000
+#define MDIO_MMD_AN_MV_STAT_MS_CONF_FAULT		0x8000
+
+#define MDIO_MMD_AN_MV_STAT2				32794
+#define MDIO_MMD_AN_MV_STAT2_AN_RESOLVED		0x0800
+#define MDIO_MMD_AN_MV_STAT2_100BT1			0x2000
+#define MDIO_MMD_AN_MV_STAT2_1000BT1			0x4000
+
+#define MDIO_MMD_PCS_MV_RESET_CTRL			32768
+#define MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE		0x8
+
+#define MDIO_MMD_PCS_MV_INT_EN				32784
+#define MDIO_MMD_PCS_MV_INT_EN_LINK_UP			0x0040
+#define MDIO_MMD_PCS_MV_INT_EN_LINK_DOWN		0x0080
+#define MDIO_MMD_PCS_MV_INT_EN_100BT1			0x1000
 
 #define MDIO_MMD_PCS_MV_GPIO_INT_STAT			32785
 #define MDIO_MMD_PCS_MV_GPIO_INT_STAT_LINK_UP		0x0040
@@ -80,11 +80,11 @@
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_REMOTE_RX		0x2000
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_LOCAL_MASTER	0x4000
 
-#define MDIO_MMD_PCS_MV_100BT1_STAT2		33033
-#define MDIO_MMD_PCS_MV_100BT1_STAT2_JABBER	0x0001
-#define MDIO_MMD_PCS_MV_100BT1_STAT2_POL	0x0002
-#define MDIO_MMD_PCS_MV_100BT1_STAT2_LINK	0x0004
-#define MDIO_MMD_PCS_MV_100BT1_STAT2_ANGE	0x0008
+#define MDIO_MMD_PCS_MV_100BT1_STAT2			33033
+#define MDIO_MMD_PCS_MV_100BT1_STAT2_JABBER		0x0001
+#define MDIO_MMD_PCS_MV_100BT1_STAT2_POL		0x0002
+#define MDIO_MMD_PCS_MV_100BT1_STAT2_LINK		0x0004
+#define MDIO_MMD_PCS_MV_100BT1_STAT2_ANGE		0x0008
 
 #define MDIO_MMD_PCS_MV_100BT1_INT_EN			33042
 #define MDIO_MMD_PCS_MV_100BT1_INT_EN_LINKEVENT		0x0400
@@ -92,7 +92,7 @@
 #define MDIO_MMD_PCS_MV_COPPER_INT_STAT			33043
 #define MDIO_MMD_PCS_MV_COPPER_INT_STAT_LINKEVENT	0x0400
 
-#define MDIO_MMD_PCS_MV_RX_STAT			33328
+#define MDIO_MMD_PCS_MV_RX_STAT				33328
 
 #define MDIO_MMD_PCS_MV_TDR_RESET			65226
 #define MDIO_MMD_PCS_MV_TDR_RESET_TDR_RST		0x1000
@@ -115,8 +115,8 @@
 
 #define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
 
-#define MV88Q2XXX_LED_INDEX_TX_ENABLE	0
-#define MV88Q2XXX_LED_INDEX_GPIO	1
+#define MV88Q2XXX_LED_INDEX_TX_ENABLE			0
+#define MV88Q2XXX_LED_INDEX_GPIO			1
 
 struct mv88q2xxx_priv {
 	bool enable_temp;

-- 
2.39.5


