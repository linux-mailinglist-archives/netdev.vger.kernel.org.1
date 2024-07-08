Return-Path: <netdev+bounces-109752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36B1929DB5
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE57280E7F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 07:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4A93A1B0;
	Mon,  8 Jul 2024 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1CHMVnRp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E223759
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425033; cv=none; b=scJE9yUImHppZ0lLZHTCSDRHFTuVxulBQq1G8UQxSL01pckKPBEfasqz1INpBHrcIvjEbSRjp2RoG2qf7c8SgS/TGkm4785dj1XXE6N+jau1bjt+baIFIYOfZgWS0R3m/HbJdjF11hWgY8wI9g1M6pIq+WSWvluxpMTXE5WgRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425033; c=relaxed/simple;
	bh=9yi1anNucjAJ8p+xi+AkakLSWlU6/VCwEhS0HwZzO54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4NFCprvowwQ736vFzKD/DD4Z70hfx5oPESkjhHr7JWWsw5k+OQPkC/rerHW/Fs6E/bUT273/+obyb8RoUGId5DsK2c8rCPgQpqQuHWv0cc2VHAWCqySKJDF4Le9DEHDeMcy4y8GJ4fueFo6j0/EJzfV+ejj4K8DPs0JfY8ALgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1CHMVnRp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-367a081d1cdso2041422f8f.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720425029; x=1721029829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvg9NGlB7Q3nnPA4DGlVOBNb6F5m/xXWm+pljGd+Dec=;
        b=1CHMVnRpprAnpqZEBhSRDNgQ8hVvKKnHTiDzqzSja591RtzItEyZiwh1HsLjR4LGAP
         fK2obxynuMxL3cTy0ikdxkMLvmXSJ3hY4q1YeZyszhDNuvQuxc5ndAD6rjvFvfmNXzUz
         RJFypAlTvgnlDJK7f35wBzjC5mBaTZMdNmtSUwarnvOaz+q9oBD+YedawdUFslnRhyhA
         zpI+Am3Qdl+qZjv3zt/8EMeGyhv2r9UjrZdd70synlpUiuoaQJO9fIaWFeAEBLnh8Qd8
         6YfbspgqmFcIavkTVq2x9AMDchWjqRGUcDQMtbbEb1TvzTtgh+DB4gTHYhs2wghM7QSw
         DhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425029; x=1721029829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvg9NGlB7Q3nnPA4DGlVOBNb6F5m/xXWm+pljGd+Dec=;
        b=WCrIsOJ17gD7EIhFXO39gtQJBvgyweI8QRFvjH69mJTCtF2TWT/8rVv99XR85JmE5o
         6rJTLDef6kyibmtnCKGMStNiXPwt2OS3UvSi1n37mfE7nisI/JvLJ67NOMeT+ceFPVbJ
         QpbQemuKVdGwcdiakVkuSXMa5ar83IDZ6uszMdnE+CnkOTMwU9Z3bOgoiSVJw/Sx4LfE
         DQmc6hlZEVO+AoOW+AvHuusDY6flBCefVZHU5ASCOW4lwFeUxnomS9ubCrEaLWBMEhZL
         S9/woT8aAe//9C97ctnGhSIbYCBLj243xZFYVIC3szN039CtjLDNfVPDxknhqngOMvoj
         9gkA==
X-Gm-Message-State: AOJu0YzT7rQXzZ9p6zl+dNdVNnwjedX0JOpDx2gi7P/XdXyxtiwAG6Ed
	t08m6W2cYqf9IBdh4oUm1i5C/wSX9qvtG9DcA49NQZ3GngLHi2FOCAjaqrOHVlH/gg6gaJgr0qd
	l
X-Google-Smtp-Source: AGHT+IGEsMan5VERG5Ruuq/k28lPTx8wwmEfk9bARBnsnlCFiqZl6+JtfHYuFcpgTGHfbHSorC7eJA==
X-Received: by 2002:a5d:408c:0:b0:360:7c13:761e with SMTP id ffacd0b85a97d-3679dd71a3dmr8078039f8f.65.1720425029279;
        Mon, 08 Jul 2024 00:50:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b5f9:a318:2e8a:9e50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679d827789sm10160055f8f.76.2024.07.08.00.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:50:29 -0700 (PDT)
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
Subject: [RESEND PATCH net-next v3 1/4] net: phy: aquantia: rename and export aqr107_wait_reset_complete()
Date: Mon,  8 Jul 2024 09:50:20 +0200
Message-ID: <20240708075023.14893-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708075023.14893-1-brgl@bgdev.pl>
References: <20240708075023.14893-1-brgl@bgdev.pl>
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
 drivers/net/phy/aquantia/aquantia.h      | 2 ++
 drivers/net/phy/aquantia/aquantia_main.c | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index 0bca28ec3332..2465345081f8 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -201,4 +201,6 @@ int aqr_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
 int aqr_phy_led_active_low_set(struct phy_device *phydev, int index, bool enable);
 int aqr_phy_led_polarity_set(struct phy_device *phydev, int index,
 			     unsigned long modes);
+int aqr_wait_reset_complete(struct phy_device *phydev);
+
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


