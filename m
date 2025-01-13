Return-Path: <netdev+bounces-157649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE72A0B1A2
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3AC618863BF
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696582343AE;
	Mon, 13 Jan 2025 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="LBs4KqeJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCB3233153
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758167; cv=none; b=rUCV4dPLtmSVsOVzaP0TE7XKJl8OIJagVD0vAtEbKcGVkmOfADs0+Yafm/FdXIjfEj6Q+WAH/7UW/JT8UDrxyjOf0ljKBLrkkq+3lQdBAvH3OeFvthZYxCpkQHbETyYfNPjORYHSd7LEn1AbDOvFT0zZySjdFhNItNsXuPDrO+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758167; c=relaxed/simple;
	bh=vCkDacTWZvcuafWH2kjulsf3aX2Vk3dmsFF092eXKBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXBI3X9ZGnFNmP+lucqoZD4qMaPFTSbzZlnPzFVedcVWrWs5w4mUoMxY8m79cj146j9nsmogDmJYa7hJ+gZwzDp//vT84/3cIUBMWYpMeXKw+wWtqGMbGozcdis4dZS+C+bdmDnVVBdAsqgHIKw4tnUsoITTHRIIfgN4rglkpb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=LBs4KqeJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43618283dedso38394005e9.3
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 00:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1736758162; x=1737362962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gnnl0VwLJeV2gkqDwbC1b2CdoHjgb3H7tibMthkFU6U=;
        b=LBs4KqeJ9tbqT2QtgZWhL6WKL0qB0FRtypV1xtIWqkKypw4ZVN1fPR6UiUnC7UJasQ
         TQE9m32Wa+mW1OaO5dq4LmpcTHDm4B88vV74+Nw5vP6dGNFhfteKBXjXlYwsS88ILLTr
         qGxXGoYAcnbYWWpzTqwHIUqypQkz6lB9s5NVGKcCWHvQ0Df60+NKYhkFlwVauo1xo+HY
         IfFYEojY8qk7baKCbUlOb3N2N2xaE9T2TTnpr2mbI4wr3arO3s+c1EPfmHybferDw8E4
         U/MY9z9qpQOZJ9NPgdVYe6hjOh2IJNe20v+AlNTjg6Q7nMp2Yigg/RgH4W6biV1kszbN
         OD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736758162; x=1737362962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gnnl0VwLJeV2gkqDwbC1b2CdoHjgb3H7tibMthkFU6U=;
        b=i+u4D9uqmhfjoJSy3hwC4z4BMDM0W9sr+6+DbKh4tic/I8B0iOETIexQpSMNvGGKGU
         lmocbcsdDHKSDf6+ceCeJtVfVr3fr/ULogtb170MNkCeJswq9Q7SV24gpG1bumajmSBN
         IR+aae+xauSuoIPjW9SCGtvyfMrov1u2dDM05GPihwQLj/YE9PddCSaO5R+PEMKOMxUW
         23cHmqZx0HGWS1h2WHa7I8RBTvswcRS3//i4FqC4pmakGXiw6sqEx/TTBJAPt7cJtb+f
         +c+yQXdIb/L46NQud2FgBXkSlaSia/bEWXMg3XYEyTM3qzOjYE/e89eNBUEI+zD5tNR4
         M3vQ==
X-Gm-Message-State: AOJu0YxfycQJmHOzbCsjP6Q10pA+81w7UERmDgUUyNfrssgpFztRRRvr
	whLtFtfA+W1bZYo6k2DzIAYkuUj26R8t5Zn0q/Hiy5D7kpZii3C7Qk8piObl5YgHcwBuiztTJs7
	Z+PE=
X-Gm-Gg: ASbGnctXeA2Hcrfg9w4YtgqtCAvbIfsTYDx5hxPu61IfXwuGwens9zOtHNJoehAfM0l
	JUqTEtCjM7ldHT4ujXCqOnvMLfP3cZl9FaFPbYrOCGNcu1ghQatHOYYMBb74wyfAxHRLJ+k+75E
	ua9IsCNeqzwN06Mr177VB2aXG7D5Oj1LWqTmbGksM7cEABTWheVZFw+F97XkMSWgm+W9x4p2RMU
	ikyykrvphUCRxyu2O1epuaD63r/Z0yyB6Y5q/pmJy74rkU5Iy3ANEUaw6K721zk3kXoIhVENMSr
	H4egmtIZDx6UF4GsVABs
X-Google-Smtp-Source: AGHT+IFBijnZ0WjmXifiseTgCnAunx2NxiPja28AwiOTHT/QqLpzFwAOQAkeKW+0V1Wumd0RGJ6NuQ==
X-Received: by 2002:a05:600c:b55:b0:435:1b:65ee with SMTP id 5b1f17b1804b1-436e2707f2cmr148478835e9.24.1736758161975;
        Mon, 13 Jan 2025 00:49:21 -0800 (PST)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2df2faesm171830825e9.26.2025.01.13.00.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 00:49:21 -0800 (PST)
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
Subject: [PATCH v3] net: dsa: mv88e6xxx: propperly shutdown PPU re-enable timer on destroy
Date: Mon, 13 Jan 2025 09:49:12 +0100
Message-ID: <20250113084912.16245-1-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.47.1
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
   anything, mutex_trylock() in the worker function fails to grab the
   mutex and returns.
 - In addition to destroying the timer, also destroy the work item, in
   case the timer has already fired.
 - Do all of this synchronously, to make sure timer & work item are
   destroyed and none of the callbacks are running.
 - Because of the nesting of the timer & work item, cancel_work_sync()
   alone is not sufficient and the order of the cancellation steps matters.

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
2.47.1


