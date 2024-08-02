Return-Path: <netdev+bounces-115244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2895194597A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1F21C2262E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652951C379F;
	Fri,  2 Aug 2024 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efgOlOEs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854421C232A;
	Fri,  2 Aug 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585871; cv=none; b=ug60vg3O7vbJ+oAWP7E/t4kjJGY8UFFPYodYh6vH+DRWzwTtv8udAHIuT7PFLm9NhwVGrwDLb5zh7NTRzErBOjutdrHJDSZcYRYEjak0KE/NzfrTJQEaFyKWuKgCVoa1DFKb0/WrhlLZzjx6p2UaqBcAbbEmFhFsXpATuQiy54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585871; c=relaxed/simple;
	bh=Gsn709wr5opjbZ8Ntr8HC7WPpT6a1GpYdFpfoRMZdw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MnK6rLKypdCbayGdQWMd5pjLmr5eVuQnDtYPgNLXMEFL1/+zRPJiVlQv9ErtW1drLpouo2FNHGJ6cv/xe6oNLbdneVEh/nQqICwwAyD2rTU8n1VFSA1GCEnvVC4d8HRRkAQeBNzGnP5GqAEgHoqgUKggjv4UwpjcMPlkHaOniWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efgOlOEs; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efa16aad9so11216578e87.0;
        Fri, 02 Aug 2024 01:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722585867; x=1723190667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7VmA3/E7I7462QYgrQuUGgZ8QDhIU3xN9IszoRtcCM=;
        b=efgOlOEsnom+kXuJVvFVfHlMrtXwPRfZNlAiDw/uN9/WKvij3YaIbevWS4MiIjTkAS
         visYXYZO4ofMAaeIkkDirvc4GQseFstua/VOyt/BPWDPRVyc5TiBcWp7PMvOJrk7oGUu
         TWgoeb4p5KrfejTWoJIxJIKj/0957ryYKwr6+roLI+C0rUnWxWopLjsoP34GV02Qdar+
         bBMuG05/bBRStF4+ApW5jhhp4JjEOBznVOhinWCMQkgaqU55fs06ZplVeT85AC3NR1Xs
         gfQXY7VMZrDSrEfwvPzFmbg74ehMWeZHEYKr1G+Qray+n0LnvU2rOvP4J5145LdeSTN6
         ormA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585867; x=1723190667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7VmA3/E7I7462QYgrQuUGgZ8QDhIU3xN9IszoRtcCM=;
        b=vncPSmp/wsYfkpgyuVqth94XdqdxLraBg/GlvzYmdJ74atY0ADqn5LfiJvc4Wg/ZZd
         RLVZjJ9gEiaa2Rr+hdvr86OFiktONgoKaxxd1fL4jKH6ZJhFDUyz2+D8tiuThxN84YJ4
         r5Q3CcZJKmFjcnjhpBEbxTLhLXQaHvrk3NInsaXWHWK3vQf615YuUfSe2X0aLKxMmAi/
         M0YB4UImt1ktyOnfLvuMwGA/kdF24UCNvsSfjKZ8FagnCfYf9M2LVt1ZbyTKxkgH8ZPM
         H5cOMBsWsVWGTVzE2oWEivltMksSTcyI2nnxNPQnPRFnE+B9M+7Dx+RUql0K09nKNQSz
         PjCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2QDeeORia0ADBv4fmKGx0CIMOLVH7y+UumjOFmomavSX9LXcVP4ALV0P95wLBAzx3Qc2UPMZjWNkaI4VDTYt4VIMulG1Sz1FLsBKl
X-Gm-Message-State: AOJu0YzhLydtiaOAPkTa6qlQPiGKrGICYZzEU0p5gFMC0qCi6Rt+Y5BC
	nCxGlIHAWSjxLjCyqeY/qveV2f+K5TGWWQuXyA2SqXEhSBXyJaQggDhPxwB7
X-Google-Smtp-Source: AGHT+IE1MH/X+gx660BxbBcm1KaFTmpiBxVNitGIKZI6pM+5fG7rVb40MpxxHzWt3gEoWX6/cebHLA==
X-Received: by 2002:a05:6512:31c1:b0:516:d219:3779 with SMTP id 2adb3069b0e04-530bb39ba4emr1489973e87.58.1722585867062;
        Fri, 02 Aug 2024 01:04:27 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba07e46sm163281e87.32.2024.08.02.01.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 01:04:26 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/6] net: dsa: vsc73xx: use defined values in phy operations
Date: Fri,  2 Aug 2024 10:04:00 +0200
Message-Id: <20240802080403.739509-4-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802080403.739509-1-paweldembicki@gmail.com>
References: <20240802080403.739509-1-paweldembicki@gmail.com>
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

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
This patch came from net-next series[0].
Changes since net-next:
  - rebased to netdev/main only

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-6-paweldembicki@gmail.com/
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 45 ++++++++++++++++++++------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 4b300c293dec..b6c46a3da9a5 100644
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
@@ -40,6 +41,10 @@
 #define VSC73XX_BLOCK_ARBITER	0x5 /* Only subblock 0 */
 #define VSC73XX_BLOCK_SYSTEM	0x7 /* Only subblock 0 */
 
+/* MII Block subblock */
+#define VSC73XX_BLOCK_MII_INTERNAL	0x0 /* Internal MDIO subblock */
+#define VSC73XX_BLOCK_MII_EXTERNAL	0x1 /* External MDIO subblock */
+
 #define CPU_PORT	6 /* CPU port */
 
 /* MAC Block registers */
@@ -221,9 +226,22 @@
 #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_CLEAR_TABLE	3
 
 /* MII block 3 registers */
-#define VSC73XX_MII_STAT	0x0
-#define VSC73XX_MII_CMD		0x1
-#define VSC73XX_MII_DATA	0x2
+#define VSC73XX_MII_STAT		0x0
+#define VSC73XX_MII_CMD			0x1
+#define VSC73XX_MII_DATA		0x2
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
 
 /* Arbiter block 5 registers */
 #define VSC73XX_ARBEMPTY		0x0c
@@ -535,20 +553,24 @@ static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
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
@@ -574,8 +596,11 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 		return 0;
 	}
 
-	cmd = (phy << 21) | (regnum << 16) | val;
-	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, 0, 1, cmd);
+	cmd = FIELD_PREP(VSC73XX_MII_CMD_PHY_ADDR, phy) |
+	      FIELD_PREP(VSC73XX_MII_CMD_PHY_REG, regnum) |
+	      FIELD_PREP(VSC73XX_MII_CMD_WRITE_DATA, val);
+	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
+			    VSC73XX_MII_CMD, cmd);
 	if (ret)
 		return ret;
 
-- 
2.34.1


