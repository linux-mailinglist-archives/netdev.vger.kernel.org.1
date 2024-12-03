Return-Path: <netdev+bounces-148536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC879E2859
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C0BB44F9F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D981F4738;
	Tue,  3 Dec 2024 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="FBw04yPx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BEF1DAC9F
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237142; cv=none; b=Lvr1BrU7qtkHvqoEIvV5qQjFuI9/hYZzxZPOO83PtYM5gVFFbUs102N8ZNxITjn/3Z++MC/cD8od3B8zPuy+X/uwVN9n+6EvHePiZXYfpGS6U8jXpebysPN/GTH69R8qMIpA3pxC9XwF9K47dvsepHP/WCQRClvTtGmaqozZBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237142; c=relaxed/simple;
	bh=8dZAcCybSyyCbITBqYJytc/CotfK54Ox4Lm254vkMfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3L7EfTujsixpTsAwdlCF4jz+ucWQreO1jfDtkHV2dSD+GhWcC4W6/3rRBx8zeQiIMWSVIbh63Py0R/8cOlUQRxujYUxX+u8I9Nftz+qRAdCu5z+w0Pc8LR6ORbfaOZgioreT2JRhsYOChEpMA4q9hw8DK4fcYw3WWBU80+dR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=FBw04yPx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434aa472617so47829675e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 06:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1733237138; x=1733841938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LYUAWSDIdbphZ5G3pOF/T6c6CGV5MMb69iUkbh1uoXk=;
        b=FBw04yPxapayMEI/Hfp92iF64lphRv30tzwssBm46+MOSJCjFa88BvlfYZ5EW8lGPl
         mBxRvYkDgcqIvYHrUqhnD7fuHKO/pCfkSmmAxz+sgszBH1dF5dlSrVX20rF/daYnPWS2
         LtYuR0drXI7HBXwUntbPCKaKSp5ZZrfLJdcFoTm2Q2QhTS5jtz2uhkD6gY5kJkjz2ek0
         JfQckACfFNMzvtOtY+jwZwPjpXIXvFs3slBWDKZ1mz8Nbc69oD1DZZopOpqaplqkHJT1
         VDMvM3nK9CQG8E6Rdz87QLPIEw+6BIKq40zDLgu5goHOk1Cxt+evVhiMYPQWW3jBlsIJ
         vNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237138; x=1733841938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYUAWSDIdbphZ5G3pOF/T6c6CGV5MMb69iUkbh1uoXk=;
        b=VxWnGK82gXdoMEyi/w4tcm2/kUDM2WDReOBunuzjxqAtaPZYuOoVxWgQojpeQi4MHg
         3QEyJHfqNE6hPN5n8W8/uyKrLVDjJqHrOjVcJakj+mfyT3a9Loz8nbCCXoN/weikDNhy
         yHObGe6k/z0zztns2oibrcEig8bnFnb0Oqxw4lGZgoHfn4s4k9aOxiiryph3CNGsELXX
         dDEKBv4eW1zbBMXNKzuZeHg4sqjKR/BMmOgMnNdxCu7zuqhBk04BkeQMnDXo0SetX+mO
         nGbW4//X8Zxyyi6Qp1jH7DxEXwwhc1E/eKTBiW2q8SsV/KIXSGg05v2WXth7h3GPF6l5
         xV9w==
X-Gm-Message-State: AOJu0Ywyj8FeGx2ewynCAn+QrhXQXSo2ZDozNFDCWXG+vBU9rxVHMz6h
	2WWw1aIZN1Yi4onz9NPyezM3YKcqaPr2Wo5NhjOxTv5uxH1E64DinsESrNd+AOCCjpyPdgosFjS
	1UwY=
X-Gm-Gg: ASbGnctLctGOeclLNjvqgWkJyUWO4VS4F7FFQyWyJsxEnKyQSjXYuvn7Z/oFaoRwxzR
	2w3X1NxPWn7DHcEubv8nqUvgeWpej1+qWtHI/6qeLPsfAvzM1ngwBRfVBEYO3dqG1fDhYs8rJc3
	rsj3y51z0QFKCg4nGMhxP3jkxwjmZk6uPrENExRFJDq3QGfl5Eia0SusxExfqCwzTe6ZDLApEWG
	8ah4AamhyAdJjnNB4AbdqqWWsKiB/nmZeEUgXymR8exCt9flkDFQ96ccUcZRHeUZq5vMJWlT0eT
	xvg2wyyUIL1GLA==
X-Google-Smtp-Source: AGHT+IExdHHjexiWRYW0A3yzO/aU99shhOBSmwRHUoZR7Gb39P6gg6MqzgLWtBfZZGTqXTUyZjZmMg==
X-Received: by 2002:a05:6000:4802:b0:385:e961:6589 with SMTP id ffacd0b85a97d-385fd3cd5f2mr2621165f8f.20.1733237138384;
        Tue, 03 Dec 2024 06:45:38 -0800 (PST)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385faec0c9dsm3180818f8f.20.2024.12.03.06.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:45:38 -0800 (PST)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: netdev@vger.kernel.org,
	andrew@lunn.ch
Cc: Julian.FRIEDRICH@frequentis.com,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	upstream+netdev@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v2] net: dsa: mv88e6xxx: propperly shutdown PPU re-enable timer on destroy
Date: Tue,  3 Dec 2024 15:43:40 +0100
Message-ID: <20241203144448.30880-1-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mv88e6xxx has an internal PPU that polls PHY state. If we want to
access the internal PHYs, we need to disable it. Because enable/disable
of the PPU is a slow operation, a 10ms timer is used to re-enable it,
canceled with every access, so bulk operations effectively only disable
it once and re-enable it some 10ms after the last access.

If a PHY is accessed and then the mv88e6xxx module is removed before
the 10ms are up, the PPU re-enable ends up accessing a dangling pointer.

This especially affects probing during bootup. The MDIO bus and PHY
registration may succeed, but registration with the DSA framework
may fail later on (e.g. because the CPU port depends on another,
very slow device that isn't done probing yet, returning -EPROBE_DEFER).
In this case, probe() fails, but the MDIO subsystem may already have
accessed the MIDO bus or PHYs, arming timer.

This is fixed as follows:
 - If probe fails after mv88e6xxx_phy_init(), make sure we also call
   mv88e6xxx_phy_destroy() before returning
 - In mv88e6xxx_phy_destroy(), grab the ppu_mutex to make sure the work
   function either has already exited, or (should it run) cannot do
   anything, fails to grab the mutex and returns.
 - In addition to destroying the timer, also destroy the work item, in
   case the timer has already fired.
 - Do all of this synchronously, to make sure timer & work item are
   destroyed and none of the callbacks are running.

Fixes: 2e5f032095ff ("dsa: add support for the Marvell 88E6131 switch chip")
Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
FWIW, this is a forward port of a patch I'm using on v6.6.

Thanks,

David
---
 drivers/net/dsa/mv88e6xxx/chip.c | 8 +++++---
 drivers/net/dsa/mv88e6xxx/phy.c  | 3 +++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 284270a4ade1..c2af69bed660 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7264,13 +7264,13 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	err = mv88e6xxx_switch_reset(chip);
 	mv88e6xxx_reg_unlock(chip);
 	if (err)
-		goto out;
+		goto out_phy;
 
 	if (np) {
 		chip->irq = of_irq_get(np, 0);
 		if (chip->irq == -EPROBE_DEFER) {
 			err = chip->irq;
-			goto out;
+			goto out_phy;
 		}
 	}
 
@@ -7289,7 +7289,7 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	mv88e6xxx_reg_unlock(chip);
 
 	if (err)
-		goto out;
+		goto out_phy;
 
 	if (chip->info->g2_irqs > 0) {
 		err = mv88e6xxx_g2_irq_setup(chip);
@@ -7323,6 +7323,8 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 		mv88e6xxx_g1_irq_free(chip);
 	else
 		mv88e6xxx_irq_poll_free(chip);
+out_phy:
+	mv88e6xxx_phy_destroy(chip);
 out:
 	if (pdata)
 		dev_put(pdata->netdev);
diff --git a/drivers/net/dsa/mv88e6xxx/phy.c b/drivers/net/dsa/mv88e6xxx/phy.c
index 8bb88b3d900d..ee9e5d7e5277 100644
--- a/drivers/net/dsa/mv88e6xxx/phy.c
+++ b/drivers/net/dsa/mv88e6xxx/phy.c
@@ -229,7 +229,10 @@ static void mv88e6xxx_phy_ppu_state_init(struct mv88e6xxx_chip *chip)
 
 static void mv88e6xxx_phy_ppu_state_destroy(struct mv88e6xxx_chip *chip)
 {
+	mutex_lock(&chip->ppu_mutex);
 	del_timer_sync(&chip->ppu_timer);
+	cancel_work_sync(&chip->ppu_work);
+	mutex_unlock(&chip->ppu_mutex);
 }
 
 int mv88e6185_phy_ppu_read(struct mv88e6xxx_chip *chip, struct mii_bus *bus,
-- 
2.47.0


