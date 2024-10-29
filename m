Return-Path: <netdev+bounces-139922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA279B49F1
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FAD7B22D14
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6191EB9E6;
	Tue, 29 Oct 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="uUUinjxN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A5B632
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205836; cv=none; b=g0AaKcIElZ9BhpTs76mrLLXFhp/7KC6deV9KisYA7e70ZlObITYPRkUH0s6CvXrHTIvk68gjpzgsCJKAE8V9yTRj9IXere1k9YXG3r84ZvkroIr/6lJUcHbkcswcRaiSkowu2YBQ5VDpcfSQxGjUOBZdhzOyzSJ6s0YBmlvMtJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205836; c=relaxed/simple;
	bh=VAIjTC/o5nk8wiDyartM0yrRUBbC8NpqYhxF/SYj1uM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ryk84wrkblWNKb34V1tL/THp26PKw7Z6yM2DO0siOiIzrQoCQK3ItQz7QpVQPOnCH90z7FPauHbWCXjK9OacxkPtSQd4hIwoi58u6Cdmeiqqg6iFrcHw8cOMmiFaAQ9lYyZIlyFqK2lZLkvXj3gmCdzihwmhjCVIZIsbl81bBFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=uUUinjxN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4314c452180so44102985e9.0
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1730205831; x=1730810631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ct56u9lAIlyQ0UHnyppJVp13Bh0/HOpwZWVs1n20D0=;
        b=uUUinjxNiRjqN6eLL755VeQ+bfk6QKwkPMdR2FRtmxy9rcOQKm0KDLixaFSSD+82FS
         tGsPY0js9owoQQz1pPTmCcwr2LYOXPytttdkzVq33HF6Diy70AiNS0pM9uAj5mzHb0Nv
         qNNML6nrL/W37rh8HaOHFeqnOSz+nCDbmzXxPBnXANOlMe5ACIPR+lB6Efe/N6rFHNJ6
         qotU8tdJZY+KfZA/9T96JF0fHxyXAQ+/Npw5KVKOhhPmQWgBpYcDVRJHyDGdiwnwXWWt
         MgB0EukzRIjWucNHVTuSrWqwF9SL7Mc/ehQUw23K/O64Gvca/oyFCayfiyLAPuhjyZKV
         9ZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730205831; x=1730810631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ct56u9lAIlyQ0UHnyppJVp13Bh0/HOpwZWVs1n20D0=;
        b=Ng4u4loe/pwXWD1L6ClQWxBiZme0nbyfUBW/I++4NTpAZhsdA2MoJ8T4uP8eEqTSZx
         yjyZL0mQOeFoFhX9HtBfWydhsoKfZa6V6vrbx26OBTFVRhbtPU9aPlF8daiFcesyQkSv
         lW6dPqqgPaRRBbxHzqkJEKflzIg1MDNJ9qFB4+uhvaN9JScTPsCbqaBCpHr/JwuuLOLz
         Laq2h2VRy6UqJkGfpnXoAqVPPTymdjmA5RN9QDI2IKKTPiwgaSyOKCGpin2VYJDCT46z
         tMP+6YqdJnyTUk/xaBhA1kY2pajz+uqdU0HYQJCCdF/ReLNmtdIe9/hsbzxyGSDHAVPP
         vrVg==
X-Gm-Message-State: AOJu0Yxlqf6niVM/VSlaUDws8w+qhm9VTbvcEO/KKeNF1iPoQB/vkmyR
	21qwu5n4F9Bt5doCcFtdwj3M9Oex/iWOlnDbuLt5jOlF3Ts6al90XTqQYHrnyhiOjbnXGjGlHj4
	0/gY=
X-Google-Smtp-Source: AGHT+IE9yfBCXXTlTJlwoojMc92ENtlt5lsQZG5GZ12S5D6IFW7eXJRgWuNHq1GKc7zlzhNBL9bCLw==
X-Received: by 2002:a05:600c:3555:b0:42c:b166:913 with SMTP id 5b1f17b1804b1-431b5727f7fmr15525125e9.11.1730205830697;
        Tue, 29 Oct 2024 05:43:50 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1c645sm12433940f8f.17.2024.10.29.05.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 05:43:50 -0700 (PDT)
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
Subject: [PATCH] net: dsa: mv88e6xxx: properly shutdown PPU re-enable timer on destroy
Date: Tue, 29 Oct 2024 13:42:45 +0100
Message-ID: <20241029124332.51008-1-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.46.2
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

This is easily triggered by deferred probing during boot-up. MDIO bus
and PHY registration may succeed, but switch registration fails later
on, because the CPU port depends on a very slow device. In this case,
probe() fails, but the MDIO subsystem may already have accessed bus
or the PHYs, arming timer.

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
2.46.2


