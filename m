Return-Path: <netdev+bounces-148198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A699E0C8E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 20:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F0516544E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 19:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D891DE8A0;
	Mon,  2 Dec 2024 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfvV1Qa1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5621DE3C1;
	Mon,  2 Dec 2024 19:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169044; cv=none; b=L77dixzx0CkzdB4+M7TH6zWCgkegm9BlNpPuV3ito+GRQW5BTFQPb/Jmv0xcsnck2chkhSb2S+nHnAmRNYPZKT8jlJQ2H0jg3eZ+WA9sarih+3fnASN2kUM0zhUIUAIrfjwVON8HPIkmVw7VtXOOtJBPEFLQWpmJx5A1s1Dx8Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169044; c=relaxed/simple;
	bh=InhWf2Mvc3p9xuTrYBcwg2Km48DtBd5eBlfiJ9K+wJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eT28UkdOnIXNhN4MbPeKfpM18IOlYkDZJh/VWn7YGQz75DuqJEjOz5D2xPsMSdBxmd3r4KGiajCn4hzqh8ApLuBzaJjxJqxIeqluuodVRKkftRYlfxv9OrpIzn2eg4FH+bAscpIqvOoXHRmn3lulqozcYeGdLQTEt8odaEt/bxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfvV1Qa1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2155db1c9bdso2360505ad.2;
        Mon, 02 Dec 2024 11:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733169043; x=1733773843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzJtZqYA3L83LZnNmBrcuQuakkPZwZ5W+9qyZIqzWOk=;
        b=FfvV1Qa1YBHAbw79dr6D7VLChccOZXcX7ioh6CppLU4xp164e2XnPBgtIEHiuabprh
         GunI1e4Zdw/HnvRKcGh6XLG7bEHVTkg9Zx4aWDtF0wLRQiGAj9ul3yO4cjR5h9kYWev8
         zg976LeTJVF3j5huCn7UhE45YB3jbpZxTkYnD1SlRfSVd3SmD+jpVdXjA5PyQlINRI+u
         kY9c9ttCy3M+cX9L8rBlHyeEx8nwa9UijGisg/ancgiSnP7hKP/CFIChfOHkmpktco2g
         gPPypNKqljQkCqfcs/v0vvCGUS50jj1fO04GXSg4jMvHcXNZSnWQlX+fOce/MQkKfP/H
         N6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733169043; x=1733773843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzJtZqYA3L83LZnNmBrcuQuakkPZwZ5W+9qyZIqzWOk=;
        b=DYBWYtTl3sem05MpKdQcuE7N9GoeUU2Zbsenmxmclxt6MKPP+LzetgEMH4YgNF0cGZ
         nQwSyxit7ioaSFWQKtjJuN+vbUuIbtX+xbPXxWQnHPdAC7ZVNCDOD9sCgmRlQ++aVqTU
         uux/Vno8uPx/ueNos+22CuDHtsfT83V3DHkAsv9CdkXH5nqOOsebPdcRBBE38HhHCp49
         beT/gzgJY5XRUIXZKm/0uk29YYoHPI5Xffg/oQ1JngAmuk8kFvzMM8SY9uA+iiEz64jz
         b4L2oQ9dHOebck18tAXAWsTyDXo4QdHF39cue6JVI16pRb7r9wQ1qbzlmCqB5aWBnHAy
         wrEg==
X-Forwarded-Encrypted: i=1; AJvYcCVGLz3bS2RshPHgmzuB/DQSHgAWJisn1zZvo7IDek750S7bQQVEYRhVgVoRxz/8hEqNske35gemCVC3Odw=@vger.kernel.org, AJvYcCWtFvgYaDY76HT1M5kJ0nSYwafRNxYJCSRldUjlXYFoYDkNmozLMOjFDrUtQ4RVXErh6ZLIqu6E@vger.kernel.org
X-Gm-Message-State: AOJu0YzqqkElorh4UvLSZJdGOT8U+8t5N2hythS+LZ/J+SKDKHK0BciU
	irDDoMmJuA9moumuGp1M+09STWKES0VsjgNa9Bl6E2oa+QJMm4Ke
X-Gm-Gg: ASbGncsleggMwDV4ofjMIHFRQGvn4PxAXSLVbS/WUF9/bC3ro5mqzBxKcAZbK132wHX
	+KsU1FfPa8fh4oEhwOh3uHairLSZ4FWcM7cdRGPJkA7eICwa7kFXKHpCpdcbfDNtT/oU0U36ppD
	bQBQb298nO130bDh43c6UXwJNbWmIC2B8G+FzgNAc55qKNC4lW1lM9+O1lJR3Bq5TLEiDUTyvGK
	qjKU/K6ZZW08ShIQSmgTJQKLsYcGjONrmr5XPUtCq5H2nBdsXzGg7qwkRkx
X-Google-Smtp-Source: AGHT+IGGxKhdzMiXncx1CtrIIMJJNAfm+HLlBcWZq9fZ88p6OSgS2i+0jhA7hIqZms3nIwfU1Mx5Vw==
X-Received: by 2002:a17:902:e547:b0:215:7a16:8389 with SMTP id d9443c01a7336-2157a168657mr42453095ad.3.1733169042553;
        Mon, 02 Dec 2024 11:50:42 -0800 (PST)
Received: from nas-server.i.2e4.me ([156.251.176.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f553fsm81232515ad.6.2024.12.02.11.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 11:50:42 -0800 (PST)
From: Zhiyuan Wan <kmlinuxm@gmail.com>
To: andrew@lunn.ch
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy.liu@realtek.com,
	Zhiyuan Wan <kmlinuxm@gmail.com>,
	Yuki Lee <febrieac@outlook.com>
Subject: [PATCH 2/2] net: phy: realtek: add dt property to disable broadcast PHY address
Date: Tue,  3 Dec 2024 03:50:29 +0800
Message-Id: <20241202195029.2045633-2-kmlinuxm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241202195029.2045633-1-kmlinuxm@gmail.com>
References: <20241202195029.2045633-1-kmlinuxm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch add support to disable 'broadcast PHY address' feature of
RTL8211F.

This feature is enabled defaultly after a reset of this transceiver.
When this feature is enabled, the phy not only responds to the
configuration PHY address by pin states on board, but also responds
to address 0, the optional broadcast address of the MDIO bus.

But not every transceiver supports this feature, when RTL8211
shares one MDIO bus with other transceivers which doesn't support
this feature, like mt7530 switch chip (integrated in mt7621 SoC),
it usually causes address conflict, leads to the
port of RTL8211FS stops working.

This patch adds dt property `realtek,phyad0-disable` to disable
broadcast PHY address feature of this transceiver.

This patch did not change the default behavior of this driver.

Signed-off-by: Yuki Lee <febrieac@outlook.com>
Signed-off-by: Zhiyuan Wan <kmlinuxm@gmail.com>
---
 drivers/net/phy/realtek.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 10a87d58c..014dd2da1 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -31,6 +31,7 @@
 #define RTL8211F_PHYCR1				0x18
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_INSR				0x1d
+#define RTL8211F_PHYAD0_EN			BIT(13)
 
 #define RTL8211FS_FIBER_ESR			0x0F
 #define RTL8211FS_MODE_MASK			0xC000
@@ -421,12 +422,18 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	struct device *dev = &phydev->mdio.dev;
 	u16 val_txdly, val_rxdly;
 	int ret;
+	u16 phyad0_disable = 0;
 
+	if (of_property_read_bool(dev->of_node, "realtek,phyad0-disable")) {
+		phyad0_disable = RTL8211F_PHYAD0_EN;
+		dev_dbg(dev, "disabling MDIO address 0 for this phy");
+	}
 	ret = phy_modify_paged_changed(phydev, 0xa43, RTL8211F_PHYCR1,
-				       RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF,
+				       RTL8211F_ALDPS_PLL_OFF  | RTL8211F_ALDPS_ENABLE |
+				       RTL8211F_ALDPS_XTAL_OFF | phyad0_disable,
 				       priv->phycr1);
 	if (ret < 0) {
-		dev_err(dev, "aldps mode  configuration failed: %pe\n",
+		dev_err(dev, "mode configuration failed: %pe\n",
 			ERR_PTR(ret));
 		return ret;
 	}
-- 
2.30.2


