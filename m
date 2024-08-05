Return-Path: <netdev+bounces-115880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C64239483EC
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80971283AC0
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 21:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9995616D4C1;
	Mon,  5 Aug 2024 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEpIddrU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EFA14D70B;
	Mon,  5 Aug 2024 21:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722892282; cv=none; b=Sa7HJiQhh/T67XjbWphmVRYVn2O04pTUBNl8XWLVV5XyfdHYUi1e/q7tauWuAiptCniiJ9OYh4QQAYmGQSIrxJZ+WuxjRhIdCwjrc3MBX2+F25OvoEYvF3MQ5Aga2/YG7ZHJSGIgMMbpEdF4IX/blc8YRx0CNCeusAq64kSuRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722892282; c=relaxed/simple;
	bh=mqAtEaCOs4qvF8RYITi+/Ro0cJob8VLThP7fGd1o2g0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bf10PtTvIA5NKtLzVI5KwaYp9+C1AwbjkAyn7BU4xGtg3lBYgk0HYJnTUTNVoag+4qPx7HWqT1UQjTig7FIPf1c8ocTgkrRUoU6/VIkal0FIk1AH2Dg8Sq0NPRP9YA4rcax+HICyfG91Pqsav27t6iH3/wI+CD0CBRzavIyxCmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEpIddrU; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f16767830dso53371fa.0;
        Mon, 05 Aug 2024 14:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722892279; x=1723497079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPORZJh8gGgLPpyf2+SR3CgjHBg2lzp2hf0os76X+ko=;
        b=UEpIddrUw6QHAbFRDjl1C0vwniS3Ikbu7Z8z7eTKOxlN6BxnZwBljytl9x/T1oRbdR
         QbearOJ7joTiKod8lSDoKNR+Njpphf7p92ny76T8XVBJMG6Uuq/8SAxSRc1le8sYBr+q
         naN0b307ssYWyx3UplDfqziobCpTBdvDJDS/Rckj35r9o7aoIeLqDaJiBW40eUO4Lkzb
         ky5sJ62v9P0lxbphx73uhDtN5HJdCTe3G9ZrfekchhDfwxL8C12GGAVVPp9kO55vhdY7
         iQWxJJ7pJyemFYkwBuUPwsKQSdVH1zewBmM7DrKaEBqY5DHGllv0w9Fci8oJCRgRe1qQ
         MQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722892279; x=1723497079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPORZJh8gGgLPpyf2+SR3CgjHBg2lzp2hf0os76X+ko=;
        b=SFakSDwJ3HMvJi3CPVJ2CEX1LeQgZ1T3ZkCvmpnI0GRRwNOO372BDGbb+ipuBql/Li
         7smb/AUHtCFUAOrsdkBxtkcbkGnxxkub04AJWYc9xYCPcE+G+BVYJt+fxty4pZJ+W3ff
         VS7grrIMjSk+jKt/Dhx2ekXwDJrPPdf9eudfymHE4RposbFsEASgLv05wFh6fq/r4vHb
         03Bb8N/JtHBjmnuJadNfO/EOpeac30qKfYsTSYhGspRFZCqeGSiNHvsZL9/2xRh8el3T
         3Ur7o9Fy2OJbTd4intJu6EQGwaPLSSOULOTt2ajYSFEgw6pbdb0LtlVMtxGxUlJV7WW1
         cRIg==
X-Forwarded-Encrypted: i=1; AJvYcCUmDd6bODUy2yfH1t3MPCT3BauX+k0liWOGUu16FGAFc+toTZKk6ztUGC2bx0QaG93tx1rXgV8tQj17/1iAcjdGAEilyC/BsQX6shCG
X-Gm-Message-State: AOJu0YyrNPzfMmjTGyfNknZP1s4Xpii6l891LyC1dV985054Ku5euuTW
	rwtqLqpB1Q5JfJFtkxvIAGWVc1I3Di1EOSJLTFApwSiNYm3eZWa5cs7ZLJcD
X-Google-Smtp-Source: AGHT+IFo4miWdf6u+dlZcOHKBIZHFN1gAeEiGU9yFzQHTIcYkUFVGYN7ELScWXw522BA3eZ6fi/osg==
X-Received: by 2002:a2e:8611:0:b0:2ef:2f60:1950 with SMTP id 38308e7fff4ca-2f15ab06196mr76793121fa.30.1722892278546;
        Mon, 05 Aug 2024 14:11:18 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:1688:6c25:c8e4:9968])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1c623csm11875291fa.63.2024.08.05.14.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 14:11:18 -0700 (PDT)
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
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/5] net: dsa: vsc73xx: check busy flag in MDIO operations
Date: Mon,  5 Aug 2024 23:10:29 +0200
Message-Id: <20240805211031.1689134-4-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805211031.1689134-1-paweldembicki@gmail.com>
References: <20240805211031.1689134-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VSC73xx has a busy flag used during MDIO operations. It is raised
when MDIO read/write operations are in progress. Without it, PHYs are
misconfigured and bus operations do not work as expected.

Fixes: 05bd97fc559d ("net: dsa: Add Vitesse VSC73xx DSA router driver")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

---
v2:
  - used defines from patch moved to net-next

This patch came from net-next series[0].
Changes since net-next:
  - removed mutex
  - used method poll.h to poll busy value in 'vsc73xx_mdio_busy_check'
  - use 'vsc73xx_mdio_busy_check' for control if mdio is ready

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-6-paweldembicki@gmail.com/
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 40 ++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 4b300c293dec..a9378e0512d8 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -40,6 +40,10 @@
 #define VSC73XX_BLOCK_ARBITER	0x5 /* Only subblock 0 */
 #define VSC73XX_BLOCK_SYSTEM	0x7 /* Only subblock 0 */
 
+/* MII Block subblock */
+#define VSC73XX_BLOCK_MII_INTERNAL	0x0 /* Internal MDIO subblock */
+#define VSC73XX_BLOCK_MII_EXTERNAL	0x1 /* External MDIO subblock */
+
 #define CPU_PORT	6 /* CPU port */
 
 /* MAC Block registers */
@@ -225,6 +229,8 @@
 #define VSC73XX_MII_CMD		0x1
 #define VSC73XX_MII_DATA	0x2
 
+#define VSC73XX_MII_STAT_BUSY	BIT(3)
+
 /* Arbiter block 5 registers */
 #define VSC73XX_ARBEMPTY		0x0c
 #define VSC73XX_ARBDISC			0x0e
@@ -299,6 +305,7 @@
 #define IS_739X(a) (IS_7395(a) || IS_7398(a))
 
 #define VSC73XX_POLL_SLEEP_US		1000
+#define VSC73XX_MDIO_POLL_SLEEP_US	5
 #define VSC73XX_POLL_TIMEOUT_US		10000
 
 struct vsc73xx_counter {
@@ -527,6 +534,22 @@ static int vsc73xx_detect(struct vsc73xx *vsc)
 	return 0;
 }
 
+static int vsc73xx_mdio_busy_check(struct vsc73xx *vsc)
+{
+	int ret, err;
+	u32 val;
+
+	ret = read_poll_timeout(vsc73xx_read, err,
+				err < 0 || !(val & VSC73XX_MII_STAT_BUSY),
+				VSC73XX_MDIO_POLL_SLEEP_US,
+				VSC73XX_POLL_TIMEOUT_US, false, vsc,
+				VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
+				VSC73XX_MII_STAT, &val);
+	if (ret)
+		return ret;
+	return err;
+}
+
 static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
 {
 	struct vsc73xx *vsc = ds->priv;
@@ -534,13 +557,22 @@ static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
 	u32 val;
 	int ret;
 
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		return ret;
+
 	/* Setting bit 26 means "read" */
 	cmd = BIT(26) | (phy << 21) | (regnum << 16);
 	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, 0, 1, cmd);
 	if (ret)
 		return ret;
-	msleep(2);
+
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		return ret;
+
 	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_MII, 0, 2, &val);
+
 	if (ret)
 		return ret;
 	if (val & BIT(16)) {
@@ -561,7 +593,11 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 {
 	struct vsc73xx *vsc = ds->priv;
 	u32 cmd;
-	int ret;
+	int ret = 0;
+
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		return ret;
 
 	/* It was found through tedious experiments that this router
 	 * chip really hates to have it's PHYs reset. They
-- 
2.34.1


