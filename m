Return-Path: <netdev+bounces-108999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0199267DB
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144C11F262E3
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784FA18734B;
	Wed,  3 Jul 2024 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ik5ysb32"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F31862BA
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030310; cv=none; b=InqnAoeD09xr3IyaB1CAzjMHige4VfLtYEr/10/Fb9otA6cT0DguzimVwpWMQhpCx9hbU4AzDxuR7Aw3Bp7Q5H4eDOKstkPVkdHzWhuiizeiR03SRQ1wehpe0A3g3t+d0umsR+O79Hw5KMyUlDcW0QoeNeB8jsk0Qfsol087aBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030310; c=relaxed/simple;
	bh=Ya7JRuOpvI1mc23hT3kq5HyKGwwymGLsHGeOErmvRQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxaeql/QQksuTuT4Khr/FZJYSTWQyXXCcX8dGOAVJdnqGAJxN4uNq5JVya4OMb6UQkR66y0wgZ/cOqhhjpELFKuh64PZwM13738ymmu13Ay/ZDCg71rsyK2jcpOmtm44tdEQyntIWKRYeg/8MzdbhOg7/vL+JrknIYqShUZ4JIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ik5ysb32; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42562a984d3so40140645e9.3
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720030307; x=1720635107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0QRgM6fvt7mWflQHel1qsIOJCVNJNaGUQC7xIWGyMo=;
        b=Ik5ysb32mOl0oXNfXsMaGpmiIGVI98ZJQ+6ckvjkrwcJ8lrvUW03ee8CH+BR4k+ICh
         l1P+5GSbDpcgt6Wku1PP5cH9MjWJcw1MH/G2rygUbXwyec4rdP55fD7z32Iybl5HKGMn
         Z/0hlgLW8jFr5cWmrlo6Qii+I/ASP8l8V0Y9istyTl+MdDdxp26+Lm3umWi4QPrGozXS
         v0a4hOKeE3z6EOC7w+OAUvKLeWX4nVOfPEWPJpO7+FitiVu7A0HAsIKvNwIRXEjT286A
         QoQzFbyDlxziZX0SfcKYRoIcVpMTK2aIRF7y4gd8CV5n0BWMlGoo6ahvZJ1bsbTC8kNT
         +7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030307; x=1720635107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0QRgM6fvt7mWflQHel1qsIOJCVNJNaGUQC7xIWGyMo=;
        b=F70AbqhumQD4znkNlWWYhmQdND8cpSNBEQFJV3q6lBTEVIA4rSaCnuF6sJhZEqBvPf
         Gx58UPoKfjpPGgUf7q7SDM367O5jp98B8r0CRy4hZJrTLWpclkRkmiBULlq7MxR0k+5v
         SmqcY7ukVurjfVc7EOskXOmjnxNN2+cNhP5yDvQriPtB7rrvQ4CLwgAyPWsbQok5loen
         IVsMDxQitDBcVZF9r6X2c7B4Vel94w8wM7guA9C4tFEkF3hF8Hv8bayhMojDUndPckUK
         xBJWs2m6xft+yY3zAezwOYCFJlB2jOD5oyk2MbGXMtPbXmqg/dfX4fvmydhS3GCvFwLe
         xgRw==
X-Gm-Message-State: AOJu0YxvBK5+pxTP/WUGUagngh6MFMwMaIjeDdc2yok1GtO0pcZD/OP7
	VxlHUspshVv63CrSXL+bUFUF86fmJatO5D2p6SbSpl8eUmb/6gcJtK5hH5gmKbg=
X-Google-Smtp-Source: AGHT+IE9ecYh0TynIiGek+n1mnz5lEz375vFlXm+NaSRncFsOuV60WslfeQFIDqe0ZUtBf/d5YRwVA==
X-Received: by 2002:a05:600c:54cc:b0:425:849c:86fd with SMTP id 5b1f17b1804b1-425849c8732mr60047875e9.14.1720030306764;
        Wed, 03 Jul 2024 11:11:46 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af37828sm255295965e9.9.2024.07.03.11.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:11:45 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/4] net: phy: aquantia: rename and export aqr107_wait_reset_complete()
Date: Wed,  3 Jul 2024 20:11:28 +0200
Message-ID: <20240703181132.28374-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703181132.28374-1-brgl@bgdev.pl>
References: <20240703181132.28374-1-brgl@bgdev.pl>
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


