Return-Path: <netdev+bounces-112101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A67934F7E
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 16:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE58C1F219AF
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642D4143757;
	Thu, 18 Jul 2024 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JLO2FJqh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF343142E9F
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314682; cv=none; b=kPyb1gozvH6yretCkxAEy6IV1+4GttMDX2OLPlhS/Uc8uBSbVcthMVVUzxnchW/ly9PxiQBND4oRbvnvEmlVHylsBapnLPsr7NhsI5L4wIvDgR+Bt3/lHguW/AJPMi8xv2pj62lyh/ktWzCAPaqSJib+aTIedCBcL+6OG5zPybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314682; c=relaxed/simple;
	bh=7I9tJroh8I1AkLj9d0MbU1dtLMjMfbxN6dEchC2ugeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OiILCZH0Rbjq+Kq/OJjsH2wVppTgQ6y/ji2CVWBfWCZFygoSUIvlUSZBSH833IUozm2Z/doBAvAR7aDAHy25QtxT05BUZm/xeE74r3mNcvgp8GqIhfOFKxFNCLE8eOIN2K6Fbnd6c6nRzh4m2pN0zXmrsfEOq95uTkagL/G9RvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JLO2FJqh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42793fc0a6dso3596165e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721314678; x=1721919478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xao5cSIMl4nUJRUMK33h1hsF1hwBAVfY7Y5/Z14dkdY=;
        b=JLO2FJqh8pAvk5N1F/TDUyQtkLPNkr3eif6kDuVZnq0pyixFdceonKu6Zn/HPxWo00
         kzw3xW9yB6qeS4fqrqkREVNmIgGadM/JmXLhTCoxzX9ODc+EHG/kNItweeKKbNItLsQr
         DcOSvKnU37sAoEskAEzJIMQ1UdYbT9OWt6fFArdRYS7kw4fd1IZi2bWuGYUGKtjOxWm5
         E3cGDug1nPMv+ppYZx4FjXJyGQMwJlT3timx6HHI9Q5Vm95Kg/ZTZR0hrHbcXH1akC5O
         63gI4V57K3Am3FhDN1TUFv+wv7ZdNRrAqpIhtTU2vbw7OTFcq3FBECt+/NpBL1tICl/+
         TOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721314678; x=1721919478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xao5cSIMl4nUJRUMK33h1hsF1hwBAVfY7Y5/Z14dkdY=;
        b=uUy07Ik6CxJfgySKzWNGCGM8HBTazdUL6G/Kpz6+v06jA/C/Z+3wiqmI1wc8LFL9Nf
         9D1bunTGD1KarZyzwqijeCvMPoE1zhb1OziBppd7wgoxwLS5TP839/db2p3RKUAdyJ67
         SRjGv+V4NJYN6k9UI0AcgorheGM+WzFEy7gzS9VqWYD4I58fxCqkZCuyNp1JrNvq8NB+
         wiu8A8k9F8ud2nCtMzqzcxg6pKtwG8N5RPCAzFLIJwDig/n2gQ5sJEcu+CobD3q36Yn+
         aAUhUULXkvOqx6wGsdpRo3gIbN74AZXXRuCwxmMtJdS0+l2xx8CL8xMDgmcxqV2HVdPp
         pSKw==
X-Gm-Message-State: AOJu0Ywm5V0eDuHqGoDuS3h+/c3+xU3VDfTNv4oLYLX2/CNQ3+4NNBfF
	zAe1D0PqMvpUdyuTmqjnAu57gcxqYsHOrzrYdVj5Xe+HWGdYSLd006Yf/TFSZ9E=
X-Google-Smtp-Source: AGHT+IHSigq7kQ41NwUPTLCmMIcoPfUWubsX81+aoWc8hHI/gd3MGv8dVx16s+DFg/48Nm68yhbeUA==
X-Received: by 2002:a05:600c:1ca8:b0:426:54c9:dfed with SMTP id 5b1f17b1804b1-427c371a871mr35992455e9.28.1721314678062;
        Thu, 18 Jul 2024 07:57:58 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:58d4:2f84:5fcd:8259])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2b294fbsm17148855e9.34.2024.07.18.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 07:57:57 -0700 (PDT)
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [RFT PATCH net] net: phy: aquantia: only poll GLOBAL_CFG registers on aqr113c and aqr115c
Date: Thu, 18 Jul 2024 16:57:47 +0200
Message-ID: <20240718145747.131318-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Commit 708405f3e56e ("net: phy: aquantia: wait for the GLOBAL_CFG to
start returning real values") introduced a workaround for an issue
observed on aqr115c. However there were never any reports of it
happening on other models and the workaround has been reported to cause
and issue on aqr113c (and it may cause the same on any other model not
supporting 10M mode).

Let's limit the impact of the workaround to aqr113c and aqr115c and poll
the 100M GLOBAL_CFG register instead as both models are known to support
it correctly.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/lkml/7c0140be-4325-4005-9068-7e0fc5ff344d@nvidia.com/
Fixes: 708405f3e56e ("net: phy: aquantia: wait for the GLOBAL_CFG to start returning real values")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/aquantia/aquantia_main.c | 29 +++++++++++++++++-------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index d12e35374231..6e3e0fc6ea27 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -653,13 +653,7 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
 	unsigned long *possible = phydev->possible_interfaces;
 	unsigned int serdes_mode, rate_adapt;
 	phy_interface_t interface;
-	int i, val, ret;
-
-	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
-					VEND1_GLOBAL_CFG_10M, val, val != 0,
-					1000, 100000, false);
-	if (ret)
-		return ret;
+	int i, val;
 
 	/* Walk the media-speed configuration registers to determine which
 	 * host-side serdes modes may be used by the PHY depending on the
@@ -708,6 +702,25 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
 	return 0;
 }
 
+static int aqr113c_fill_interface_modes(struct phy_device *phydev)
+{
+	int val, ret;
+
+	/* It's been observed on some models that - when coming out of suspend
+	 * - the FW signals that the PHY is ready but the GLOBAL_CFG registers
+	 * continue on returning zeroes for some time. Let's poll the 10M
+	 * register until it returns a real value as both 113c and 115c support
+	 * this mode.
+	 */
+	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
+					VEND1_GLOBAL_CFG_100M, val, val != 0,
+					1000, 100000, false);
+	if (ret)
+		return ret;
+
+	return aqr107_fill_interface_modes(phydev);
+}
+
 static int aqr113c_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -725,7 +738,7 @@ static int aqr113c_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	return aqr107_fill_interface_modes(phydev);
+	return aqr113c_fill_interface_modes(phydev);
 }
 
 static int aqr107_probe(struct phy_device *phydev)
-- 
2.43.0


