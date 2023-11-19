Return-Path: <netdev+bounces-49028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9997F0716
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 16:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22518B208B3
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 15:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99E3134C7;
	Sun, 19 Nov 2023 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9uUDLMD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205ECB3;
	Sun, 19 Nov 2023 07:13:10 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32deb2809daso2345978f8f.3;
        Sun, 19 Nov 2023 07:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700406788; x=1701011588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EDtSNkcu3n6VEBL6cX5/6KUOPyj6eJV5oYhNMI3f5+A=;
        b=O9uUDLMDJhtz2sX/JQZW1VmB/mLps+faHLhVsh2xBMCpH9AusoOsJgf8ZZKG8XfsEz
         cdv+SiQBFPUA5Tl7dj0hhtzRA+v3XitkcymeMH+dyqYvhPgQpAbUKGM9dOVmwCtuUnrq
         sT8OZswoQeOh4DoXXh3VOSXdABdJilvXBkgll4vEfsE2gMosmf/6yMp0NY5FJG9q7EZf
         GpZttwjc6SViC/oJ2kt7tIWhEt12ySmHoWwQMi1nEuGnSdAa8TY6ymXrp4+RJQErNStN
         X7Ij9i4UvNzihQ4gdrCDaS/TaIqpfoz0/0Ti2ffDizRXR1+QFFUABxoh7Pq8yX7eShxR
         3+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700406788; x=1701011588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDtSNkcu3n6VEBL6cX5/6KUOPyj6eJV5oYhNMI3f5+A=;
        b=V81Hehkaa4+f4dI6JxhGXs7WKIapPZd1bzC0dywWmHpTL2jjvRG8PaTw6LbggMaG+H
         fyUC6Kg/wHzEMLQY0wNfhvTKtfMt1y5f8v59zWlvAC20cqbjpa2O3iwtlq1iO3zfkkq9
         QFVUeh0tKxP7I/KQp56FanasNNz6kXaOAsho0ohZvMRxMOsPR7Tu4rrkjLjQOFAK8ZnB
         QNAKXVkOTOIKBqeQRpmhWyi4bH+e03+oXoqfTQodUn9+Bf0k00HsUXeIBaXTHwl1+SQ2
         0+Oxs+4qwXjXEnw1ppsG7nKL/SLBLPuCDZ1oCqK0YCgAXq2xBV8kw/096vUP1JGkvXAh
         bghA==
X-Gm-Message-State: AOJu0YzDHlcp1xgaGknPDJg7laM3Vt6DGgMY20MB5MVf4GvLKYYIsSlu
	1oJHMkNLBtN+ASEgEwxHsg4e03Unk6Q=
X-Google-Smtp-Source: AGHT+IEVZDPP0CD+D6MdB9oueW18RKXcsXrHKRVyv3oaAVMl1DsvLnOQ59+Ypy1csSNjpl22zR/MDA==
X-Received: by 2002:a5d:64ab:0:b0:31a:d9bc:47a2 with SMTP id m11-20020a5d64ab000000b0031ad9bc47a2mr3160376wrp.53.1700406788088;
        Sun, 19 Nov 2023 07:13:08 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m3-20020adffa03000000b00323293bd023sm8321441wrr.6.2023.11.19.07.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 07:13:07 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [net PATCH] net: phy: correctly check soft_reset ret ONLY if defined for PHY
Date: Sun, 19 Nov 2023 16:12:58 +0100
Message-Id: <20231119151258.20201-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

soft_reset call for phy_init_hw had multiple revision across the years
and the implementation goes back to 2014. Originally was a simple call
to write the generic PHY reset BIT, it was then moved to a dedicated
function. It was then added the option for PHY driver to define their
own special way to reset the PHY. Till this change, checking for ret was
correct as it was always filled by either the generic reset or the
custom implementation. This changed tho with commit 6e2d85ec0559 ("net:
phy: Stop with excessive soft reset"), as the generic reset call to PHY
was dropped but the ret check was never made entirely optional and
dependent whether soft_reset was defined for the PHY driver or not.

Luckly nothing was ever added before the soft_reset call so the ret
check (in the case where a PHY didn't had soft_reset defined) although
wrong, never caused problems as ret was init 0 at the start of
phy_init_hw.

To prevent any kind of problem and to make the function cleaner and more
robust, correctly move the ret check if the soft_reset section making it
optional and needed only with the function defined.

Cc: stable@vger.kernel.org # v5.8+
Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2ce74593d6e4..478126f6b5bc 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1235,14 +1235,13 @@ int phy_init_hw(struct phy_device *phydev)
 
 	if (phydev->drv->soft_reset) {
 		ret = phydev->drv->soft_reset(phydev);
+		if (ret < 0)
+			return ret;
+
 		/* see comment in genphy_soft_reset for an explanation */
-		if (!ret)
-			phydev->suspended = 0;
+		phydev->suspended = 0;
 	}
 
-	if (ret < 0)
-		return ret;
-
 	ret = phy_scan_fixups(phydev);
 	if (ret < 0)
 		return ret;
-- 
2.40.1


