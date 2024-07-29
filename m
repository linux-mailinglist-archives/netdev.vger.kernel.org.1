Return-Path: <netdev+bounces-113814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C5D940016
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE4E2831B0
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E381B18FC83;
	Mon, 29 Jul 2024 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqF2mMIV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6C18F2F0;
	Mon, 29 Jul 2024 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287197; cv=none; b=WkMr6o10122G6e25y+bzM7dZwuL+DZz4bo4LByOiyKLa1rxuq1rDq1iEAqryFTdT9KYdAfEbqahr03+5uN++cF0FLFI+DcDUDcg8mPpCCkbzwvKQqBNh/OLVYDOuUZR0U06MmARTFMA0cY7fkOZaoCVp+163Wy3fJEo3olHnAUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287197; c=relaxed/simple;
	bh=kD5S6LiCcTTGq4F4VT9DVxlZ8kQ+DCninIHU//YP9LU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kAk7ycko37wxizbbi0o81Wjcylp7OoXTu1zuSIg7Fe6+Zk51afP/ud2tSXsRU03gv7ER2QjcJ3nD3EXehGZvBo8xPsbfRRUIdN4Xj1Ln7HzJl6B417EOgiBI7AlwcjptckG0xrL6DfZkCIWtj3O6fUF0PVMa97dkFONN4EI6hk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqF2mMIV; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efabf5d7bso4596154e87.1;
        Mon, 29 Jul 2024 14:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722287194; x=1722891994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmesrltev2WsoY00lWaXAlkGtiK5mvpuNF3kNqMCxx4=;
        b=FqF2mMIV0+FwY9o3fP2ZLPd31zzroIOTADay1xpYOupv0I+Hwk+oQjRd/hZHfvsgc/
         PCQ+wNL85kZPStVWMVXXJf56QB0SV4fjw6LUEmOV5Uz8JfnVzBqvWw0HBeexdkVQvj0o
         kva1SdcmQQH28tR/rctoezDs3mZsFf8SfUMioiaD7CfjR04hUpg54NeB22OeR6Ka8Uu8
         BtvGajhswXQEvIczACpZLsCAt5kDbnyNCwrQ1S+P8bNsVoCzFuBbYOXREaCWJ2iRwLh8
         kAiWFAv1S2wTjU+gtIuzejL2J4f8wCAmGM7bEGhozR159pcnj+9yf38Fe06IAKV4ko62
         iWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287194; x=1722891994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmesrltev2WsoY00lWaXAlkGtiK5mvpuNF3kNqMCxx4=;
        b=Vmcw/tLqxp0kxS2okIWxuOslFcMz4EIaCVurhjdkdD/1AvdNNzQTVWunUunE9+0lEs
         zttHiuxPhjrrd8dWWphBSttAdJOgvTknvG7+erDgxH0FygXkV7FrjicZNl6J4hboK5kZ
         dSng2RCZn45fmofpBoXvHsAt0G2mFFsKZkHKGsrrVHdIg82dO5fES6FhNTRHBCj1H+SX
         5F20N25FvNDxFp73a3a50Xc8AQ2zW3IT8STKYO2zhT1pCMSCRrwttKKBHn9orAehlwVG
         tb0uYe8sRCHOs20moEKknnEeMnrWf9to1Iut77bHKgcs6WzF8hHav6QJgDAmrMgaopkz
         6XQg==
X-Forwarded-Encrypted: i=1; AJvYcCVEH6ONRIHVXFF1eE3WykcB4MXiz5Z9ND/m5Ok17R8J4zjjH88u4uOHm0pU+3hCOaOOXamDAsJMXO+Xi/MHcFbgja4i5TuagDcqNKQp
X-Gm-Message-State: AOJu0YzQ2oPu37wh94MILMjdJkK/cXiLaVU1F3WFYev0FMHrS2a0cfdn
	epf+dNDaEeYg4QuQfIb6e2KAq4l2v8Tky/j3+5q94+gQ12uzFZmgqsGr/jsO
X-Google-Smtp-Source: AGHT+IGxa6YkKA4a4LQpnLOy906gdPbzxWSPbVRHKCdxP/eZy4Y/a/zmcs26+zvZi67kH4GPYfUBXQ==
X-Received: by 2002:ac2:4bca:0:b0:52e:9fe0:bee4 with SMTP id 2adb3069b0e04-5309b25a273mr5980306e87.9.1722287193607;
        Mon, 29 Jul 2024 14:06:33 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2becesm1624210e87.258.2024.07.29.14.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:06:33 -0700 (PDT)
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
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/9] net: dsa: vsc73xx: speed up mdio bus to max allowed value
Date: Mon, 29 Jul 2024 23:06:12 +0200
Message-Id: <20240729210615.279952-7-paweldembicki@gmail.com>
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

According the datasheet, vsc73xx family max internal mdio bus speed is
20MHz. It also allow to disable preamble.

This commit sets mdio clock prescaler to minimal value and crop preamble
to speed up mdio operations.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 40c64ef7e729..9e88eda6f4dd 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -229,6 +229,7 @@
 #define VSC73XX_MII_STAT		0x0
 #define VSC73XX_MII_CMD			0x1
 #define VSC73XX_MII_DATA		0x2
+#define VSC73XX_MII_MPRES		0x3
 
 #define VSC73XX_MII_STAT_BUSY		BIT(3)
 #define VSC73XX_MII_STAT_READ		BIT(2)
@@ -243,6 +244,10 @@
 #define VSC73XX_MII_DATA_FAILURE	BIT(16)
 #define VSC73XX_MII_DATA_READ_DATA	GENMASK(15, 0)
 
+#define VSC73XX_MII_MPRES_NOPREAMBLE	BIT(6)
+#define VSC73XX_MII_MPRES_PRESCALEVAL	GENMASK(5, 0)
+#define VSC73XX_MII_PRESCALEVAL_MIN	3 /* min allowed mdio clock prescaler */
+
 /* Arbiter block 5 registers */
 #define VSC73XX_ARBEMPTY		0x0c
 #define VSC73XX_ARBDISC			0x0e
@@ -578,7 +583,7 @@ static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
 			    VSC73XX_MII_CMD, cmd);
 	if (ret)
 		goto err;
-	usleep_range(100, 200);
+	usleep_range(4, 100);
 	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
 			   VSC73XX_MII_DATA, &val);
 	if (ret)
@@ -632,7 +637,7 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 	if (!ret)
 		dev_dbg(vsc->dev, "write %04x to reg %02x in phy%d\n",
 			val, regnum, phy);
-	usleep_range(100, 200);
+	usleep_range(4, 100);
 err:
 	mutex_unlock(&vsc->mdio_lock);
 	return ret;
@@ -802,7 +807,7 @@ static int vsc73xx_configure_rgmii_port_delay(struct dsa_switch *ds)
 static int vsc73xx_setup(struct dsa_switch *ds)
 {
 	struct vsc73xx *vsc = ds->priv;
-	int i, ret;
+	int i, ret, val;
 
 	dev_info(vsc->dev, "set up the switch\n");
 
@@ -875,6 +880,15 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	mdelay(50);
 
+	/* Disable preamble and use maximum allowed clock for the internal
+	 * mdio bus, used for communication with internal PHYs only.
+	 */
+	val = VSC73XX_MII_MPRES_NOPREAMBLE |
+	      FIELD_PREP(VSC73XX_MII_MPRES_PRESCALEVAL,
+			 VSC73XX_MII_PRESCALEVAL_MIN);
+	vsc73xx_write(vsc, VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
+		      VSC73XX_MII_MPRES, val);
+
 	/* Release reset from the internal PHYs */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
 		      VSC73XX_GLORESET_PHY_RESET);
-- 
2.34.1


