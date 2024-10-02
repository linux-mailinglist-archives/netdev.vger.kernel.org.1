Return-Path: <netdev+bounces-131328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DC198E17E
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 19:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B1A284DA4
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3B01D0DC3;
	Wed,  2 Oct 2024 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="eJeMYKm7"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944E16419
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727889170; cv=none; b=L6shfYuvwHXUff1SFJ1zUKmG2ovevBYZmFZzEC91uaYcBPkbk2eW4kXhXGlXFk+iz+87OQZvQV71dqc4HvdXaKDZFyy7+R3jB2s3KLhNH11vpF2tdHEAy/goKT/POjExEkKcz24vefx7wh6QILEUUrqVTcAeEhov0cXTiB8Buv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727889170; c=relaxed/simple;
	bh=ErONom/Ai9zIX5PSONp+QFKxytgOpuX04ZrmD+dkgEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAK0HJrRziE3uA+iqsE5uSokzrmpelvHVWI28LaBJgNo964DrJD4woIpk64jcI8Exd0eZSFSA14+B1i41Nh2tAW8/Tbve4oyli/MigK0/feOmku0nfWstC5aQITKtHmGyhkyBP5Wxjbwk++9qdT16nuUKEEVt+gw5/QDV0QHM/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=eJeMYKm7; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20241002171233a27a727a77d5ddee8e
        for <netdev@vger.kernel.org>;
        Wed, 02 Oct 2024 19:12:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=e7QmFZwkSyc492JijwjT4JHyXfg7s0uXN5hCiPvx5Ts=;
 b=eJeMYKm7GDjPLn0AaVrIguWEM1f6uIG1Y6ionHMk9Ig/PH4zrm2+o6RJ/kiCVA3p4FHoLy
 bgMhZQEt3m/cqgVVV69xGv5h2iNUQ+J7AWqU3AZQFmLKHpAg1zwpqPuT0Ru77JMU21zzf6EL
 NQOHmVuh/wOkzMuB4Wm3Jc/AkYuLOBBrUwQknisNtqdrJi2sRIsgH8/BubIdw2DCUUUIuKZ3
 UZfSoQxVygBdgrcn9nUN2ix0VhHX10UTLERq1fnDrpqapHIoq8LLhJ+YoqszTnlG/21pufBE
 cG2AhWm5BMUAYxjeefS8dSqDPxbQUK94Zg51Jwg/qHIcxxV+b7RYjoWw==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Anatolij Gustschin <agust@denx.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH net v2] net: dsa: lan9303: ensure chip reset and wait for READY status
Date: Wed,  2 Oct 2024 19:12:28 +0200
Message-ID: <20241002171230.1502325-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Anatolij Gustschin <agust@denx.de>

Accessing device registers seems to be not reliable, the chip
revision is sometimes detected wrongly (0 instead of expected 1).

Ensure that the chip reset is performed via reset GPIO and then
wait for 'Device Ready' status in HW_CFG register before doing
any register initializations.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
[alex: reworked using read_poll_timeout()]
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v2: use read_poll_timeout()

 drivers/net/dsa/lan9303-core.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index 268949939636a..3155ec1ab2517 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
+#include <linux/iopoll.h>
 #include <linux/mutex.h>
 #include <linux/mii.h>
 #include <linux/of.h>
@@ -839,6 +840,8 @@ static void lan9303_handle_reset(struct lan9303 *chip)
 	if (!chip->reset_gpio)
 		return;
 
+	gpiod_set_value_cansleep(chip->reset_gpio, 1);
+
 	if (chip->reset_duration != 0)
 		msleep(chip->reset_duration);
 
@@ -866,6 +869,29 @@ static int lan9303_check_device(struct lan9303 *chip)
 	int ret;
 	u32 reg;
 
+	/*
+	 * In I2C-managed configurations this polling loop will clash with
+	 * switch's reading of EEPROM right after reset and this behaviour is
+	 * not configurable. While lan9303_read() already has quite long retry
+	 * timeout, seems not all cases are being detected as arbitration error.
+	 *
+	 * According to datasheet, EEPROM loader has 30ms timeout (in case of
+	 * missing EEPROM).
+	 *
+	 * Loading of the largest supported EEPROM is expected to take at least
+	 * 5.9s.
+	 */
+	if (read_poll_timeout(lan9303_read, ret, reg & LAN9303_HW_CFG_READY,
+			      20000, 6000000, false,
+			      chip->regmap, LAN9303_HW_CFG, &reg)) {
+		dev_err(chip->dev, "HW_CFG not ready: 0x%08x\n", reg);
+		return -ENODEV;
+	}
+	if (ret) {
+		dev_err(chip->dev, "failed to read HW_CFG reg: %d\n", ret);
+		return ret;
+	}
+
 	ret = lan9303_read(chip->regmap, LAN9303_CHIP_REV, &reg);
 	if (ret) {
 		dev_err(chip->dev, "failed to read chip revision register: %d\n",
-- 
2.46.2


