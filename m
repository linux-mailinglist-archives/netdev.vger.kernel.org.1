Return-Path: <netdev+bounces-113813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868CB940014
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC4A1C225C6
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F41518F2FE;
	Mon, 29 Jul 2024 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSYICCLN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C3618EFF8;
	Mon, 29 Jul 2024 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287196; cv=none; b=TdXYG3aT5NYMJ2h9hIP9z9Ta5FkOCubPyglB7RhZE1mdS1Djf47sevpkS/3mVX2F+kcUI9eFnYNKZtZnfTrYm8/PgC87gxBmmnlthoRIluOqdVCHlF/UWTrUVgBayIv1s2+dyDMkH7ZTH3KiuTaiPuM1o8eW1VpEO4aHm0VoeHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287196; c=relaxed/simple;
	bh=/b79+/IeDvmGyVD/Eu5lMPxMc2ZBmJKzqqLfEYGs3n8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O3eZE2tc5Cc8GeYJ1ABro3SAtnWpG2SDLEHjeM2ScM5NpW3yLafNcyfF4Wzp6XPg1tlJuDvy/KsfsLFxHl2Kkxb6ZjUPGprIml7gwyYMRmp3LBj7Lho7S1vwSLV64AGR12RntQ+JzRNbJz/ntSffPr2te4YuwpsmqqITjtn/Pyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSYICCLN; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f025bc147so5436843e87.3;
        Mon, 29 Jul 2024 14:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722287192; x=1722891992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfeYb+c57hePDoJHLEF1WjGP9PE9dnpqAqcmHGNY66E=;
        b=DSYICCLNWorbbA0M2fWUdrQ5/sZ0dCTpq57NmR0beTFFTM36mUyXO3mZ7Gal2oBzDz
         kH3dMdB4Ps3AuqCsbgIJXdX9bfXNnZOcCpDbmXh+goTSy7rZetMg8mvkIlWP5zqNS4HN
         Fh3/+yk1BAQDfFJWpROvZK9yE2tb+WkXWk6CoHs3c2JGsv5/O0kCm7wT8MwcRBlx60Cf
         JSSoj5Ou6IyWz2cP1J4j+xCzPNsPlJ68HfwccKFwPQhsWeRFuVgTPj0B8OH0nEYs+Yj+
         q6CX7NBWsmpyHTk7Yfi8H5e3vkBfbo4SgKIxYrnNkP+S1gnR8Z4WsfFUo4iMHwbSmP/s
         1ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287192; x=1722891992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfeYb+c57hePDoJHLEF1WjGP9PE9dnpqAqcmHGNY66E=;
        b=kFts15JPxeEbkxF9iqubNFBWatZ+lUS3kovYqdL1xuPzLrYaz6TGLQMCDJu/vq0Rop
         H++PUYE8OKmUW6iIUKUoppXAwyZ6jVmxtYHPGcTL+gRMM90yJMSAZG3x/ncf8bJX6n7/
         fXKyGykSudirIYKYLF3nbKDTabUbyDyo1Vzga9eBZftI1Med9/UXqDwXlKbS7eySXxiq
         qNOOd3YTfjFGqeWUdbhDk58XKra+SZSJ/VgLxt4Mh4XSADsiWO1GF34KW87rdAdBqjZk
         wYb0jALXEoDt2bk/xpWMdnmnzeSRXclG1yXVE3Hp2VhOJr1DYO23QfH66fm6icCBpDq5
         ZzsA==
X-Forwarded-Encrypted: i=1; AJvYcCUclebOFND0zEUARJ0JGeUa9kXB+gbbBQTX3gOjrpR8zSNGz+n1P8LiF6cM2n9oDDRjHyXIa+fZ0lPP+HddhdxSbRqckQKpV4/KM1sB
X-Gm-Message-State: AOJu0YyqpwR/XTLuTSuqglut041XJnNp473+6EY8TEuXlDY5sYIdJhgg
	Vlxd0uRP7bk6RCvqZTPPhrzAWrTB3P18EHyhVIcr+M7s4y/jTgKQzhmoyljo
X-Google-Smtp-Source: AGHT+IGognejzZA+fBxLCN8BXFoAgffW6c/BZ/oWmj05WoyxcZVvM5T0iuqvUEN1Yfgve1PGSVBDUg==
X-Received: by 2002:ac2:5f8b:0:b0:52c:def4:386b with SMTP id 2adb3069b0e04-5309b280a5dmr5546328e87.35.1722287191945;
        Mon, 29 Jul 2024 14:06:31 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2becesm1624210e87.258.2024.07.29.14.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:06:31 -0700 (PDT)
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
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/9] net: dsa: vsc73xx: use mutex to mdio operations
Date: Mon, 29 Jul 2024 23:06:11 +0200
Message-Id: <20240729210615.279952-6-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729210615.279952-1-paweldembicki@gmail.com>
References: <20240729210615.279952-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vsc73xx needs mutex during mdio bus access to avoid races. Without it,
phys are misconfigured and bus operations aren't work as expected.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 59 ++++++++++++++++++++------
 drivers/net/dsa/vitesse-vsc73xx.h      |  2 +
 2 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 5eb37dee2261..40c64ef7e729 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -545,6 +545,18 @@ static int vsc73xx_detect(struct vsc73xx *vsc)
 	return 0;
 }
 
+static int vsc73xx_mdio_busy_check(struct vsc73xx *vsc)
+{
+	int val, ret;
+
+	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
+			   VSC73XX_MII_STAT, &val);
+	if (ret)
+		return ret;
+
+	return (val & VSC73XX_MII_STAT_BUSY) ? -EBUSY : 0;
+}
+
 static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
 {
 	struct vsc73xx *vsc = ds->priv;
@@ -552,6 +564,12 @@ static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
 	u32 val;
 	int ret;
 
+	mutex_lock(&vsc->mdio_lock);
+
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		goto err;
+
 	/* Setting bit 26 means "read" */
 	cmd = VSC73XX_MII_CMD_OPERATION |
 	      FIELD_PREP(VSC73XX_MII_CMD_PHY_ADDR, phy) |
@@ -559,23 +577,27 @@ static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
 	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
 			    VSC73XX_MII_CMD, cmd);
 	if (ret)
-		return ret;
-	msleep(2);
+		goto err;
+	usleep_range(100, 200);
 	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
 			   VSC73XX_MII_DATA, &val);
 	if (ret)
-		return ret;
+		goto err;
+
 	if (val & VSC73XX_MII_DATA_FAILURE) {
 		dev_err(vsc->dev, "reading reg %02x from phy%d failed\n",
 			regnum, phy);
-		return -EIO;
+		ret = -EIO;
+		goto err;
 	}
-	val &= VSC73XX_MII_DATA_READ_DATA;
+	ret = val & VSC73XX_MII_DATA_READ_DATA;
 
 	dev_dbg(vsc->dev, "read reg %02x from phy%d = %04x\n",
-		regnum, phy, val);
+		regnum, phy, ret);
 
-	return val;
+err:
+	mutex_unlock(&vsc->mdio_lock);
+	return ret;
 }
 
 static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
@@ -583,7 +605,13 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 {
 	struct vsc73xx *vsc = ds->priv;
 	u32 cmd;
-	int ret;
+	int ret = 0;
+
+	mutex_lock(&vsc->mdio_lock);
+
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		goto err;
 
 	/* It was found through tedious experiments that this router
 	 * chip really hates to have it's PHYs reset. They
@@ -601,12 +629,13 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 	      FIELD_PREP(VSC73XX_MII_CMD_WRITE_DATA, val);
 	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
 			    VSC73XX_MII_CMD, cmd);
-	if (ret)
-		return ret;
-
-	dev_dbg(vsc->dev, "write %04x to reg %02x in phy%d\n",
-		val, regnum, phy);
-	return 0;
+	if (!ret)
+		dev_dbg(vsc->dev, "write %04x to reg %02x in phy%d\n",
+			val, regnum, phy);
+	usleep_range(100, 200);
+err:
+	mutex_unlock(&vsc->mdio_lock);
+	return ret;
 }
 
 static enum dsa_tag_protocol vsc73xx_get_tag_protocol(struct dsa_switch *ds,
@@ -1973,6 +2002,8 @@ int vsc73xx_probe(struct vsc73xx *vsc)
 		return -ENODEV;
 	}
 
+	mutex_init(&vsc->mdio_lock);
+
 	eth_random_addr(vsc->addr);
 	dev_info(vsc->dev,
 		 "MAC for control frames: %02X:%02X:%02X:%02X:%02X:%02X\n",
diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index 3ca579acc798..fc0fa8f5f57c 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -45,6 +45,7 @@ struct vsc73xx_portinfo {
  * @vlans: List of configured vlans. Contains port mask and untagged status of
  *	every vlan configured in port vlan operation. It doesn't cover tag_8021q
  *	vlans.
+ * @mdio_lock: Mutex used in mdio operations
  */
 struct vsc73xx {
 	struct device			*dev;
@@ -57,6 +58,7 @@ struct vsc73xx {
 	void				*priv;
 	struct vsc73xx_portinfo		portinfo[VSC73XX_MAX_NUM_PORTS];
 	struct list_head		vlans;
+	struct mutex			mdio_lock;
 };
 
 /**
-- 
2.34.1


