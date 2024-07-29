Return-Path: <netdev+bounces-113685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B76093F8FB
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0798C281E5D
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AC9155CBA;
	Mon, 29 Jul 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MQ1hsHbo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B114830F
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265415; cv=none; b=IBLQa+uWt1YZTSPirS3SFLNbS4VGm+3CxmRHyvLq50ZnMvk6UT0yr+a36+Bv5gldw4HSwpVZq88FYjJensy33EWvTVDesRjzLuWBX5gxzdYV/07oEqpkssLq/o2rh9gSli5+VKt1Wplav4FIlN2eOn0NPRCSY1XYM8B21iiYXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265415; c=relaxed/simple;
	bh=LixSEKAWirX0NOPhznGfzZIIzCKChSYlVSRBuDE3gCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZINsu8GZjsA+nnYV8HFG+Ng/0sFVlJGFjIVy9n2SqvSfQOch5M7/0q9j8AZhBsVarj2S7A9eX/41WVYw4jgIBBiRWXFvG5k6tkbNN3cMOq7Pi82dbFxm3Bp82o76rz1KGvePCP6rM9WPLFTjfgu5hfOrDg/ucTDbliMsp7FGNKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MQ1hsHbo; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef2cce8c08so41146351fa.0
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722265411; x=1722870211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lGkbzrAqMpJOKzg1gN9QMr+Bs2M7SGlMJ9VaOqKnPoI=;
        b=MQ1hsHboyYlBqO+vsbhDBktxTL/xJ0rl1qSap20TbmZegi+g4xh3qNhFPYWLz3Z7bD
         8hXbpAEPdOMqDHSotIbLC4i4ZSVYx/F77saP7kccsOu5hyvt1a94cAovpce/IrmdA+Ul
         5Lqj8swFJNCHnVzgPmUwQvR9wxZlbdej6xv6p3zaNAbqyvKx9UHy0QZDYH0gDXQz3vid
         eJVSedrtXyhuvM4ov7ZP0D0FcNG+rhSOm0Vk7duNWy1KE/rTNuGI2uc+Tk4SA+Dhfk7j
         IkKJLARfvDlEi9arYERHW5B6DGtS//oxoIUjNeaslvYnrHf4eDGvD1jVNuSv9wRgc4I6
         tDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722265411; x=1722870211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGkbzrAqMpJOKzg1gN9QMr+Bs2M7SGlMJ9VaOqKnPoI=;
        b=JO57bQ1l7or25x1x9L54+F1jUjgM9sL0oB7oRsjZboWGax4+KLGMSE2eYFOWcZU30i
         i2s9XLyL93C6tUtl2HR0D4pRBy4fx4L8La8u2KqrlU8dkwq+WPgNRvBeyiYuFhTippUc
         +Rr1wMlD6tghW/EYO6RUkRLB4zQ4lYOOcnW7IY+S80JhbQm+6pr8jgWuriEMt2YUkDmv
         C4u/KzOC7eDT4u4/Y0KFggVjVQonQBfqpYAfEfUk7lKGYxBd6xCl0x/dsVuBDRgJoE9a
         99dLoqXrqwQTf6yjLHboTlXf84LEUX13AyFPXGIqe9P3k3bRc2BZtA4h1WrWaPcS5fKc
         vL0g==
X-Gm-Message-State: AOJu0YzNceGnpzBK0aZWAZPcyf8MUaSfqDcQYMtkg6w4pWb6tc9pIfWO
	6i36KeWPWn4TCnwCGhGHkt0jjoW118dh2vtrvaE2BO+cn8/KEzGjupBBLMtYvfE=
X-Google-Smtp-Source: AGHT+IGk/iWA5wi1P/B8XTv9G4vLUSNAph/qAsd9e1PTA/AJ+yhzpqUakiDFr/71iqFzUruHa/NSXw==
X-Received: by 2002:a2e:7307:0:b0:2ef:26f2:d3e6 with SMTP id 38308e7fff4ca-2f12ee5bd37mr52432071fa.34.1722265410471;
        Mon, 29 Jul 2024 08:03:30 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a777:82b0:b20f:20e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42802e2f525sm111899025e9.0.2024.07.29.08.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:03:30 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH net v2] net: phy: aquantia: only poll GLOBAL_CFG regs on aqr113, aqr113c and aqr115c
Date: Mon, 29 Jul 2024 17:03:14 +0200
Message-ID: <20240729150315.65798-1-brgl@bgdev.pl>
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

Let's limit the impact of the workaround to aqr113, aqr113c and aqr115c
and poll the 100M GLOBAL_CFG register instead as both models are known
to support it correctly.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/lkml/7c0140be-4325-4005-9068-7e0fc5ff344d@nvidia.com/
Fixes: 708405f3e56e ("net: phy: aquantia: wait for the GLOBAL_CFG to start returning real values")
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- update the commit message to mention aqr113 too
- fix the comment in the source file: 10M -> 100M

 drivers/net/phy/aquantia/aquantia_main.c | 29 +++++++++++++++++-------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index d12e35374231..e982e9ce44a5 100644
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
+	 * continue on returning zeroes for some time. Let's poll the 100M
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


