Return-Path: <netdev+bounces-178614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E3EA77CF9
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2DE188B913
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264752046A8;
	Tue,  1 Apr 2025 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="khWvoUj1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAC6204692
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515835; cv=none; b=GKtS+Kq7cY2CbzGDE0ZSyXyBXCq6pr8/KsTTUZSi36ClB447ua1lWzV2R/oS+RL0wqRydWUf+MOip9DN0dc2z7D7VJEHO+TfukGJjeTmqQOX6bU2U2dmCJerumt7n0W0YLBv0arghRTAHLpGfFoK54ZV2PxxbamvMQVJnx/jfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515835; c=relaxed/simple;
	bh=NWXXVvjt39xU+rA7+NnTR8sUGDWv6O8iuPCim6wufCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e8BymVGXo3LvzwEOifz4MX+d6e3eQOF9BK35wAI2NA1KZyXDnn+d3u7oi9/e1bw+KpU5wWKKqUUQXXQfW87/+ycU+fXOt9femJVHTOTDUFlCyJhglDACdn9t8HKKNqSwPfkbs44SFvPtMMmtuNoT5TVum7I/sRWVGPR9OwxmXi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=khWvoUj1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39ac9aea656so4599003f8f.3
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1743515828; x=1744120628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uwYV6EoXAucL5Dj4d79APrOokX4rUIbo+yxZ5Oz9Kew=;
        b=khWvoUj1FQ5wPqYpMh3IWstvhOhhNAoHJ8X/kS/Tlw1XOWzp11ZTOLrbqWS8cBujbf
         an6M46xGdsP3+VJZ/Lwzm7x5t06rfi5fuz2dghVnoFTnxhBW8weS32/ZZwVebWWA9p27
         sSueg11U6Y9Lyp8fa8TJRc005VAhLl1RihBnO57YfnIelYH+XwuM1nCi7F0+pq6lkKWB
         jwBLuU2SWESlRWlSXmLlvU9z+9c4XEDx6PEJ1uFXbs+zMgjvSEX1/apRBEFDpCfipUde
         hXwwkQPluhKC1OaMoSn/hgUvXK/nnGyt1pf38/9XdpfAhmAHsVDN9GMMl41oskWsZqkF
         E9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515828; x=1744120628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwYV6EoXAucL5Dj4d79APrOokX4rUIbo+yxZ5Oz9Kew=;
        b=Ulkj7ReCBAQGpRoxBBHLi6OFfhTTTAljnNAyUdvijZv+eAIkF08yv1R9sOgO+blxfL
         vzYHa1Unxq6KZkS9usroGofT0xw1fYowBC+N+WtygPNVGOqSl9ApIaVz+PCDQuEw/Kl4
         2VzPNcgSs3N2NE6OSxXN56V1kjRgCMYiRnAUnavXtF4bhuZQksd0uO+aXRpQnZAZ/YRy
         WAqgZjHpOzCwBV4AIOs9ZydtRwrOHXoBTVl7o0XJa94PT4wk7sUHvQHr2acKh1lAvXka
         RfRbISlbMQqrM4b6QtEPzm2dstgNeeNPb0hkf7y+8mDPx7htGbMaKyG1JAYEGaWOlNVb
         APmQ==
X-Gm-Message-State: AOJu0Yx0lfY3xxu8gzSnhSWR8cUzSaqx21FYc4fW4Fh2Pm06wVqZr7VV
	6RpPcefbe82/Y8hiZLW5FxPW++HFgLRZEg0Q2JLWPhBdpnMxmLCucELnU9WE/tZvT+8edAXu5OA
	fbWw=
X-Gm-Gg: ASbGnctY8ZIxNZRp3GjruZJQ3N5ge1+UClcE4hwLdoNDlHMKRgdcPp7BoHJBF7lIor4
	NvJtlqzwcjgOuOSf0Q4IlFMa93pjDEf0fR16f9jrVY6O+Q82cQolSCkkbb8PDtqSdpk6q4SMba7
	MIAmyiSGiBbhlhckow8wKLNatX8flCuw8RSnO08HxWqmMG89/VLHNfDlfllIdtf8wxV536lZ8i2
	hd2JpcoW3HC3UG9oUKfYlgWeYP8byd9vQ6+Tx52LouOrRSRakaF2qCm8uGCv8Sfi1qPvf8Cb0jW
	0MoZVmhig8bLGGrqUk7xFsDC15oXSfLj4s3F2Xcy3s/RNwLBA0bNSt1/rSIJltDrpHOgLiU2IQt
	Gbj20xCEz
X-Google-Smtp-Source: AGHT+IHTPWai+jBGLAnveIJs6fn4EvvDuSSqT2nask6GBM2fV4+C1CEIjhI6NE2QLkoCxTJzkbEvmA==
X-Received: by 2002:a05:6000:381:b0:39c:1ef5:ff8b with SMTP id ffacd0b85a97d-39c1ef5ffa2mr4867175f8f.48.1743515828334;
        Tue, 01 Apr 2025 06:57:08 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82dedd03sm200475155e9.3.2025.04.01.06.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:57:08 -0700 (PDT)
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
Subject: [PATCH v4] net: dsa: mv88e6xxx: propperly shutdown PPU re-enable timer on destroy
Date: Tue,  1 Apr 2025 15:56:37 +0200
Message-ID: <20250401135705.92760-1-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mv88e6xxx has an internal PPU that polls PHY state. If we want to
access the internal PHYs, we need to disable the PPU first. Because
that is a slow operation, a 10ms timer is used to re-enable it,
canceled with every access, so bulk operations effectively only
disable it once and re-enable it some 10ms after the last access.

If a PHY is accessed and then the mv88e6xxx module is removed before
the 10ms are up, the PPU re-enable ends up accessing a dangling pointer.

This especially affects probing during bootup. The MDIO bus and PHY
registration may succeed, but registration with the DSA framework
may fail later on (e.g. because the CPU port depends on another,
very slow device that isn't done probing yet, returning -EPROBE_DEFER).
In this case, probe() fails, but the MDIO subsystem may already have
accessed the MIDO bus or PHYs, arming the timer.

This is fixed as follows:
 - If probe fails after mv88e6xxx_phy_init(), make sure we also call
   mv88e6xxx_phy_destroy() before returning
 - In mv88e6xxx_remove(), make sure we do the teardown in the correct
   order, calling mv88e6xxx_phy_destroy() after unregistering the
   switch device.
 - In mv88e6xxx_phy_destroy(), destroy both the timer and the work item
   that the timer might schedule, synchronously waiting in case one of
   the callbacks already fired and destroying the timer first, before
   waiting for the work item.
 - Access to the PPU is guarded by a mutex, the worker acquires it
   with a mutex_trylock(), not proceeding with the expensive shutdown
   if that fails. We grab the mutex in mv88e6xxx_phy_destroy() to make
   sure the slow PPU shutdown is already done or won't even enter, when
   we wait for the work item.

Fixes: 2e5f032095ff ("dsa: add support for the Marvell 88E6131 switch chip")
Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
FWIW, this is a forward port of a patch I'm using on v6.6.

Thanks,

David
---
 drivers/net/dsa/mv88e6xxx/chip.c | 11 +++++++----
 drivers/net/dsa/mv88e6xxx/phy.c  |  3 +++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 901929f96b38..29a89ab4b789 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7350,13 +7350,13 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
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
 
@@ -7375,7 +7375,7 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	mv88e6xxx_reg_unlock(chip);
 
 	if (err)
-		goto out;
+		goto out_phy;
 
 	if (chip->info->g2_irqs > 0) {
 		err = mv88e6xxx_g2_irq_setup(chip);
@@ -7409,6 +7409,8 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 		mv88e6xxx_g1_irq_free(chip);
 	else
 		mv88e6xxx_irq_poll_free(chip);
+out_phy:
+	mv88e6xxx_phy_destroy(chip);
 out:
 	if (pdata)
 		dev_put(pdata->netdev);
@@ -7431,7 +7433,6 @@ static void mv88e6xxx_remove(struct mdio_device *mdiodev)
 		mv88e6xxx_ptp_free(chip);
 	}
 
-	mv88e6xxx_phy_destroy(chip);
 	mv88e6xxx_unregister_switch(chip);
 
 	mv88e6xxx_g1_vtu_prob_irq_free(chip);
@@ -7444,6 +7445,8 @@ static void mv88e6xxx_remove(struct mdio_device *mdiodev)
 		mv88e6xxx_g1_irq_free(chip);
 	else
 		mv88e6xxx_irq_poll_free(chip);
+
+	mv88e6xxx_phy_destroy(chip);
 }
 
 static void mv88e6xxx_shutdown(struct mdio_device *mdiodev)
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
2.48.1


