Return-Path: <netdev+bounces-107228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D79AF91A554
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED9B1F2509F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5D0156C61;
	Thu, 27 Jun 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iBePjVnn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A26A14E2F0
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487834; cv=none; b=YtOzI87ODrJwnFKsAGyv95Fc88b8L/pK+H3gbxgBBLMeVz8ZOzROyToWwP8lELIsUPNCU2bhM14MX0OEpfIlVUAINROQXiJs+33XL5aMmkx/MS0ce05gkPG3ewUCAWBx4IGBg2SY1zCCNTHvmhKdQpuXet1B1Sliy2zUZGJKgao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487834; c=relaxed/simple;
	bh=Ya7JRuOpvI1mc23hT3kq5HyKGwwymGLsHGeOErmvRQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dO4hr9G4nEGUPIkcMLQb5eGUsWvWg31OuZfpzGpSgTcO8phCRfZ/Llhv5BFbzCl/mAGTvoIMjogH71KGMSOfuIcbar0Xzy7TKeS1E42EB9JO9Wd4bCwUOHgL8nlqN273u7DMvxvUR3BLPjc860XGplfsmYVf/cputFjyy01F/kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iBePjVnn; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3672aec418cso1083766f8f.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 04:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719487829; x=1720092629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0QRgM6fvt7mWflQHel1qsIOJCVNJNaGUQC7xIWGyMo=;
        b=iBePjVnnTtGtjqA8u4A7A7+Jc6sxhTAmyqlqO79rsZsc4AFO/JI7ocX8j2PFZZxrfU
         PA8s2hGCLvOuJeJVDfd0udlFxvsOLSxSigIq0pL72WHq+4d7PwKK6jnWlmhjEk2o91O9
         jTDwu9q4+SbslYlWdUZktrih8lqEtfozTUN0IxwPM0bHq9wBj/Gcupd7ie38Eoo4/qQp
         4rpZIegUxwDP7uh6p+m5OAReVOb5tRLYESW5ebB1LRgJxCWyiY3xkME+cDXUIfmbrNmW
         OqcxcB9OGokmRJyVrlp+7QZ0d4GmBbFJXQeRoEdrkRhdCqWn+lpFGodrmhUlPVyRwm8+
         qWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719487829; x=1720092629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0QRgM6fvt7mWflQHel1qsIOJCVNJNaGUQC7xIWGyMo=;
        b=DOJoubbxWSXt1yeVW5VabU5I/MRiONOOrF5eb1/VJhWx0rkWMxufS15AolP5eKJONE
         Tvlry8oPfezMvoOpieNkgk5LCYyK86GXfd14Ee3RrWQSWifefcBIWmA6+sgqtr92+j8K
         rW717hM/BR8nDLGqQs7BPGOIDBuUuabGuvOVYDYW2C3WamYxBf0ALiIJGKctJfSZ94Se
         XHHCHHA8zL1UfbVe3+jJa0Y+bFDRac+YWIDtGrsSsHlG4D3hsHd+KYo4JvGkmEoEEGAo
         4lPjL0eTvjhfKQAAha4858s2CLGu2ItHr2sX8UC8r/AFx8fgqw8ew8I6YhLBK0xjsv3a
         xMJA==
X-Gm-Message-State: AOJu0YwQtpkghDcYbG7wR7kifQZE73QLcP7wFF6Sryr7EFszD/au9p0k
	6ENNf+t2lBtVBS7qkFZVnskqMkCXRMisp+bQpnDzsxWMgAH2KPyANriN8jVMq5U=
X-Google-Smtp-Source: AGHT+IHtZalwKUmz03jYf/W8W6QwUXJljrBV5NvK4R0vga/4Bv2QjNASP687/iYIZH4x0UVsSJ4hjw==
X-Received: by 2002:a05:6000:1888:b0:366:e87d:a771 with SMTP id ffacd0b85a97d-366e87da7d9mr12245883f8f.3.1719487828431;
        Thu, 27 Jun 2024 04:30:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7fe5:47e9:28c5:7f25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36743699ae0sm1504111f8f.66.2024.06.27.04.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:30:27 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 net-next 1/3] net: phy: aquantia: rename and export aqr107_wait_reset_complete()
Date: Thu, 27 Jun 2024 13:30:15 +0200
Message-ID: <20240627113018.25083-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627113018.25083-1-brgl@bgdev.pl>
References: <20240627113018.25083-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This function is quite generic in this driver and not limited to aqr107.
We will use it outside its current compilation unit soon so rename it
and declare it in the header.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/aquantia/aquantia.h      | 1 +
 drivers/net/phy/aquantia/aquantia_main.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index b8502793962e..2465345081f8 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -201,5 +201,6 @@ int aqr_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
 int aqr_phy_led_active_low_set(struct phy_device *phydev, int index, bool enable);
 int aqr_phy_led_polarity_set(struct phy_device *phydev, int index,
 			     unsigned long modes);
+int aqr_wait_reset_complete(struct phy_device *phydev);
 
 #endif /* AQUANTIA_H */
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 6c14355744b7..974795bd0860 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -441,7 +441,7 @@ static int aqr107_set_tunable(struct phy_device *phydev,
  * The chip also provides a "reset completed" bit, but it's cleared after
  * read. Therefore function would time out if called again.
  */
-static int aqr107_wait_reset_complete(struct phy_device *phydev)
+int aqr_wait_reset_complete(struct phy_device *phydev)
 {
 	int val;
 
@@ -494,7 +494,7 @@ static int aqr107_config_init(struct phy_device *phydev)
 	WARN(phydev->interface == PHY_INTERFACE_MODE_XGMII,
 	     "Your devicetree is out of date, please update it. The AQR107 family doesn't support XGMII, maybe you mean USXGMII.\n");
 
-	ret = aqr107_wait_reset_complete(phydev);
+	ret = aqr_wait_reset_complete(phydev);
 	if (!ret)
 		aqr107_chip_info(phydev);
 
@@ -522,7 +522,7 @@ static int aqcs109_config_init(struct phy_device *phydev)
 	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX)
 		return -ENODEV;
 
-	ret = aqr107_wait_reset_complete(phydev);
+	ret = aqr_wait_reset_complete(phydev);
 	if (!ret)
 		aqr107_chip_info(phydev);
 
-- 
2.43.0


