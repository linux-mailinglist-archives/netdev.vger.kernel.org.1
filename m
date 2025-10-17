Return-Path: <netdev+bounces-230266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5F3BE6070
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 03:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04BF34E1294
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 01:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0A721767A;
	Fri, 17 Oct 2025 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjJuMRmF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D72334691
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 01:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760663934; cv=none; b=VINBDvRrg4RaOxtUnHZClhf9WnBqLrl3fNmv4P5eHHon4mk5zyFwv7yTfIrJYgoLO7FBySNFBUWk6WQsatBVl+mZ4KpThmm+z6Smt9MTPoPJ8H+AkS6BZLEk/umYfFNKXCB8neSA0T2Nb2zCgJUiDvOreNhkyOYJJTEWud+F7HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760663934; c=relaxed/simple;
	bh=MItE3VZ9nrWY6YAL83Q4LvoAoVU5qLe8wux5tVVpriA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kV1Mjxib3zZnQqT3QvIVdJcu5NeZwrFxZZTKJxxu95z5HX1PXOZ5VqYgLOmTqTjP3Ge3JgzOfeh7ChXrqzmnogifg6ERP2+H9kL+ccd3EQG5wQBe0y+rwjy0H/PIGZTfZHS9a3dkR/IBMSiqjwKHd/StvdOnl0r1yUELz+/6RMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjJuMRmF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290dc630a07so825325ad.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 18:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760663932; x=1761268732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2WufNMZZ/3kF+kxCtpxLWUmoQMaWHtLSOKhsUHckblc=;
        b=kjJuMRmF0Ygv2+s4C90BIJg/yNnQi2Z/5O30gbiYVjTAfiGVOqUfYsJRhec5CtAm7p
         GwDIH723kCtcQ0si/UC7e384wSu/mNf3O/fgSzvI3XjfhYe1hmQeScFblx86zLVC412K
         7hC2tFcmQ+sa7yYMqBE4/tRua9AQ9B58S54Ux2sTv4wm71yiuY8/Kl/ZVqObAyBslEam
         PZpAV+7c6RQlID4yTSTdzjRLX/jGnDUEb027e4S5M0ouGNuU/F1P6mnFqdTkG21aqO7W
         GAQ6RA8I9EUEAbA1BSL60pzs/GoYCuRCbkGNyYB0pEsdinu0VwrMG7XeT12xuZCkYdZA
         KvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760663932; x=1761268732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WufNMZZ/3kF+kxCtpxLWUmoQMaWHtLSOKhsUHckblc=;
        b=P2IYO+ghEVHi7pvb/oJzEUHsOzFqB3SU1jdxAw4+9llG4yy00giW7rceJEhjmdD5sk
         E9DmySp5yL52+GXntWq78AW2WbuB1jSR6LDDtQkTFrxpuS8KlDGfViTdQbQukVE6LqCr
         Qc1lFG/t8/c4/GCujH7YLtpT/o2x46sBDK0QFlXUaM7CJ1s5RRAcYEys1V1IaN1NIAcd
         eKp3E/gg0nCYFSuKjOX5U/OnV8f4hT7ewl38qi7JxYqIhXZxWjt21Dxz+WQrx8yBy+3j
         /LbRdSl2Iv9bpBcJsuYyN1vlTVgh8hnvhiyubbSZ7OClcIrBejyVC92OYMo0GgR3Nnsh
         VxRw==
X-Gm-Message-State: AOJu0Yy1/MagF47Yw+g3AiiFOn+JN9lNfL0vPfR9IxuJYr14+BuR9x03
	P69iY/2IFe+qvkxb1fCi9Gki4k78h6RefmpwJ8LJuJVD8MymxbQzXK1s
X-Gm-Gg: ASbGncsw5muMh+994UoW2uRK6/A+J19/DpaZB6lS1xLNecuSKRbKAZujMuTkrle+UYG
	2BrlKDUHCbTU8GbzetkzIjmDVHpOYs+1SqTxHswq3FcZ3YwpU/kVcJKpQcm4L0kf+ywzYkxH63H
	28NgmsTYJHkHQaoB55qRRYXMIrhrkonaqus8O82zDM76iXG7RBVjr6V3tz31r3LeDdp/fEFRONH
	xsUVSGzMzltn96xL3yFIzBle+VeQsn9wpPDTBfm3v4EFdw5pTfiwoK1h57eKI7X71NuQaupyIgA
	EvIfPD/30fgQsjAWyZYu7TYtu3fLKtUCAWy84DuZOnX75v7OwnQ9tzJAqNwrb0kHgIzyKatCQFQ
	iiZ+hVSOiooygS7GKHCu+5ePYjKOrkCAbNvmXsuIZi6/UIcxGH/JTnz6Gs54UAGlDL/REU3bJhT
	E=
X-Google-Smtp-Source: AGHT+IGCscuN23O1/GUCRY7mt5g8A0uy7Km3DMtv6zREsA54udw0SWdK9cRyXK5d1lQXl3K9mp81rA==
X-Received: by 2002:a17:902:ce0f:b0:269:8d1b:40c3 with SMTP id d9443c01a7336-290c9cf344bmr22801155ad.12.1760663931864;
        Thu, 16 Oct 2025 18:18:51 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7b032sm44355765ad.63.2025.10.16.18.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 18:18:51 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>
Cc: netdev@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Fri, 17 Oct 2025 09:18:01 +0800
Message-ID: <20251017011802.523140-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the SG2042 has an internal rx delay, the delay should be remove
when init the mac, otherwise the phy will be misconfigurated.

Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <rabenda.cn@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
index 3b7947a7a7ba..b2dee1399eb0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
@@ -7,6 +7,7 @@

 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>

@@ -29,8 +30,23 @@ static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
 	return 0;
 }

+static int sophgo_sg2042_set_mode(struct plat_stmmacenet_data *plat_dat)
+{
+	switch (plat_dat->phy_interface) {
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII_TXID;
+		return 0;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int sophgo_dwmac_probe(struct platform_device *pdev)
 {
+	int (*plat_set_mode)(struct plat_stmmacenet_data *plat_dat);
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
 	struct device *dev = &pdev->dev;
@@ -50,11 +66,18 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;

+	plat_set_mode = device_get_match_data(&pdev->dev);
+	if (plat_set_mode) {
+		ret = plat_set_mode(plat_dat);
+		if (ret)
+			return ret;
+	}
+
 	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
 }

 static const struct of_device_id sophgo_dwmac_match[] = {
-	{ .compatible = "sophgo,sg2042-dwmac" },
+	{ .compatible = "sophgo,sg2042-dwmac", .data = sophgo_sg2042_set_mode },
 	{ .compatible = "sophgo,sg2044-dwmac" },
 	{ /* sentinel */ }
 };
--
2.51.0


