Return-Path: <netdev+bounces-51082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA747F907A
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 01:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282011C20C2A
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 00:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F108B80D;
	Sun, 26 Nov 2023 00:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG99uR1O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAB013E;
	Sat, 25 Nov 2023 16:37:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332c0c32d19so2111564f8f.3;
        Sat, 25 Nov 2023 16:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700959076; x=1701563876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nawp6U3vqPYo/CUc2ds9jui4s+5qr227Har9OTpQpYc=;
        b=lG99uR1O5q5MdIn5x/FUuSNHRbkbT4zuCVS2sNNuM/0u1/59fR8KpjUek+dcEKuFSv
         ahXlv0Yky0myjpzDujCjxbsUzdVAL62IJJYuqt8brYXD7SFikRF2k1v9RalwCGpD/PMf
         kaVoKqppu+mS6aFZ6bWRSCcLjGIu+7Nkb1Jhg7rlv+a+G/+koY1cFlEsB8VQEwYubopM
         6kj3+90sU+ply1oygzMPTQuvGPh3d0Opjaf1lyY3hmKXSte7Yhh4PsK/Aqnd7Zrguwk1
         D9x7WFNWRNlcbqIn9MEKNQyMT9ZwMEW74bKx/dYV/lHZHeeCyjs1MMMsSrct8CE1ozQ8
         du2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700959076; x=1701563876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nawp6U3vqPYo/CUc2ds9jui4s+5qr227Har9OTpQpYc=;
        b=iMQWcZBsfFIPZxp+/PCajrzSOpYlCbBSB2ntq4ZU1y3D4VDP8CE56jcz8utHZCACyr
         QEBNv3zcgJtl4Wh0kA6f7wVgJ34+RfhhSG3tUvC/lq4nGo1KDwbsgcqGl7HKVTuOkgsi
         RQlSNiqhHnRmjhXrhsIgDhZAiQE4ZFMZHPuweQsq5GDv/039kKFid490VFqpQB1HFnbX
         /3rcbxGqoZ+IYbP0FkU1gw8g5i8zaXvOWeo/lxbK9Gsp0IQ3GiBAwLI4ivHKi5FjZnlJ
         BMhxslDtVIC8ZiVe0Y8vLHwU1UJz2htDCJqdy3DoOQASEyxbrEs8q9Bwxd+l4bzZzTPB
         bBBQ==
X-Gm-Message-State: AOJu0Yx/dcCcbPjYennV8fhI8oqYUY/EgFYqU0AGcUhY/JvHP//qsWLF
	tmTVx6CU7IdUKkjR/+W8+QM=
X-Google-Smtp-Source: AGHT+IGTyfDzfPril3A5JZlueNrlqBBg6D+eglrTT/8Gw0O9pB7NEl+qeTDytozz9QqxKQl48lqJ8A==
X-Received: by 2002:a5d:68cc:0:b0:332:ef1e:bb96 with SMTP id p12-20020a5d68cc000000b00332ef1ebb96mr2163557wrw.36.1700959076464;
        Sat, 25 Nov 2023 16:37:56 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id v19-20020adfd053000000b0032f9688ea48sm7735249wrh.10.2023.11.25.16.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 16:37:56 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Harini Katakam <harini.katakam@amd.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH 2/3] net: phy: move mmd_phy_indirect to generic header
Date: Sun, 26 Nov 2023 01:37:47 +0100
Message-Id: <20231126003748.9600-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126003748.9600-1-ansuelsmth@gmail.com>
References: <20231126003748.9600-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move mmd_phy_indirect function from phy-core to generic phy.h to permit
future usage for PHY package read/write_mmd.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy-core.c | 14 --------------
 include/linux/phy.h        | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 966c93cbe616..b4f80847eefd 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -526,20 +526,6 @@ int phy_speed_down_core(struct phy_device *phydev)
 	return 0;
 }
 
-static void mmd_phy_indirect(struct mii_bus *bus, int phy_addr, int devad,
-			     u16 regnum)
-{
-	/* Write the desired MMD Devad */
-	__mdiobus_write(bus, phy_addr, MII_MMD_CTRL, devad);
-
-	/* Write the desired MMD register address */
-	__mdiobus_write(bus, phy_addr, MII_MMD_DATA, regnum);
-
-	/* Select the Function : DATA with no post increment */
-	__mdiobus_write(bus, phy_addr, MII_MMD_CTRL,
-			devad | MII_MMD_CTRL_NOINCR);
-}
-
 /**
  * __phy_read_mmd - Convenience function for reading a register
  * from an MMD on a given PHY.
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 8253c7871d68..984bca9a82f4 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1316,6 +1316,20 @@ static inline int __phy_modify_changed(struct phy_device *phydev, u32 regnum,
 					regnum, mask, set);
 }
 
+static inline void mmd_phy_indirect(struct mii_bus *bus, int phy_addr, int devad,
+				    u16 regnum)
+{
+	/* Write the desired MMD Devad */
+	__mdiobus_write(bus, phy_addr, MII_MMD_CTRL, devad);
+
+	/* Write the desired MMD register address */
+	__mdiobus_write(bus, phy_addr, MII_MMD_DATA, regnum);
+
+	/* Select the Function : DATA with no post increment */
+	__mdiobus_write(bus, phy_addr, MII_MMD_CTRL,
+			devad | MII_MMD_CTRL_NOINCR);
+}
+
 /*
  * phy_read_mmd - Convenience function for reading a register
  * from an MMD on a given PHY.
-- 
2.40.1


