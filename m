Return-Path: <netdev+bounces-51175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A337F96A2
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 00:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87CB280D2E
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 23:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DBB168CD;
	Sun, 26 Nov 2023 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uz5+1sSV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D28ED;
	Sun, 26 Nov 2023 15:51:57 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4079ed65582so24907595e9.1;
        Sun, 26 Nov 2023 15:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701042715; x=1701647515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Afqq+Hb2PFb58HdScLJ0dW+5Ky8jYx/Z5oemC8zCj40=;
        b=Uz5+1sSVEUO/fu6npO79SuXh5Bzgh0DGCBfRWxpiRfXuZLnyoKcaXYre0W1ebYS9KM
         DqgvvQccfNrbByL9OXZssuP28SAaTnODP4kg2AOPdydjB0lv82W4TkoZtkWWH28KL352
         +GeI8YqDrex/+mblw84NvFqSxG+gRmfi0Bs20du2whO6x3CzEeplF8gojCCGzvOFoppn
         Z52//5dmqzl7VRpTf9FvctcoW9J+4RYVyw2yHQnAvUjRUxkzRJLy0f9JApRpbZuhQb0O
         4J3HSLtrDdEkNciYw7Vlk7TAnWoc+UBv0XK+CWCBQx2icDbLxQTfHcHPX9scSkih/+xZ
         fepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701042715; x=1701647515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Afqq+Hb2PFb58HdScLJ0dW+5Ky8jYx/Z5oemC8zCj40=;
        b=Pdmp18heg4LV6nfSK6wfwfBv3taTGZ42YhyHADdwlfWRkEmNlvbrDYfmuKsJGB22h3
         Yz1wURt3ZcSQoRZ/HrkKX96grv/C6LVC/Q6nmRj1x8amtmD1ordQvPUq4KUpJzrvuTP9
         GWFL4dVGJVxMwcOLb+KuOzRU46NWnpCEt045sOKM0pzK9blpP7efshOInApsGUyvQnwE
         +s2sHW5zON3Fl9KmYzTMT67+90tyaOZxVdAisUclTzSSW29MI9sIu2E3sgpvxDos7L2D
         +TWduZLB1Yw2ywPU8sPPObcCp74VqWCNgRXeDvjeeIQfHdsY7yGEUH2fN+WolMJWr5zM
         9u4w==
X-Gm-Message-State: AOJu0Yz7kweiFtbQ+Jkfnb7n1Xv9zV2wGg/G/3Cn1jiCmYQulwuJg7lb
	arF93pzYojvdSTvEKK5VLBA=
X-Google-Smtp-Source: AGHT+IEwRV0W3djiHwQK9Trs5S8HNyruJEnsR+oP2hEE1bFWHYJf4qPcQulSGlaFXrKgeIkLHSrtbg==
X-Received: by 2002:a05:600c:78f:b0:40b:3725:4228 with SMTP id z15-20020a05600c078f00b0040b37254228mr7265523wmo.18.1701042715461;
        Sun, 26 Nov 2023 15:51:55 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m4-20020a05600c4f4400b0040b3dbb5c93sm1202151wmq.1.2023.11.26.15.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 15:51:54 -0800 (PST)
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
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Harini Katakam <harini.katakam@amd.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v2 2/4] net: phy: move mmd_phy_indirect to generic header
Date: Mon, 27 Nov 2023 00:51:39 +0100
Message-Id: <20231126235141.17996-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126235141.17996-1-ansuelsmth@gmail.com>
References: <20231126235141.17996-1-ansuelsmth@gmail.com>
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
index 51702e349d83..a63d45880b1a 100644
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


