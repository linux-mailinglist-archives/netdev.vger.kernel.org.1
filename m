Return-Path: <netdev+bounces-130810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3239998B9DE
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB7E0B20B9E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEB51A0AF2;
	Tue,  1 Oct 2024 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="BVSja4HC"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE219F429
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779353; cv=none; b=QXcODjPHSSTjhgP2F6ov7TfBzgsig4ZUTByF1S2PirkCTiJbA4pdHdFtXCnQhGE+GmJkbLhphZtYJhm6PnYsxyoqwfKE3K+iY8jMrWEBbbzaFpRb4LFcMpDuLRAjHAGZjgSajD2S04/IGlPiESoBtRR7bZLzBSY15Y8/KafDOmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779353; c=relaxed/simple;
	bh=A2m2JG1sKFFuxphy2R4x6wwGG/2QgU5om1WkPl7XIy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t+lx+Wy9GRbs+rSutIgU5+MBY1kLT1zpEVN9wlDO0eAnYgo5iwWp2K4UvWlxdmFh7mvVfHHhpZsFBi4BRnw4uN7cmzKDL7foLXrq/aZrGCs77UHfZK/CW6DL5r++FVajrQtb5mhGpSX43p2ururFqafGMm6IOZgO9iADqvDmjPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=BVSja4HC; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20241001090156363a97986af55192c0
        for <netdev@vger.kernel.org>;
        Tue, 01 Oct 2024 11:01:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Afbt1rU/D3LzPIoUlrD57EFq1hd6k2lJnZju7E4xE1Q=;
 b=BVSja4HC9/QBLdBfJ7ObT6e+MtW9e25LcZIpaO94E8gbBKDDwuZX8bviisBI7hz2athAT0
 bpfDEE2ZUBfhysUlQH/mCoOVkxk9IxTpja3f0dQZYCvuRK5io0osE6KbdQeqjTX8z6CGNmxz
 KHB73o8m9yOlO1VvixMgBaUuBgjYTFjkz4RKeQyH5MLs9GAD/ym8rOCNNSN/KOCaZxL8jZ7j
 UapQnUoUaomelHfeAdK5niPGTKWIqBdqEgrFub8bd228DxBNzRaFrz1AdpYtGn2m+OH0poo/
 AaO4EHkqkbrv3PVa/HEO4OHsn2inHJArQPq6cOUy0eBd8QWA3wo4e7+Q==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Anatolij Gustschin <agust@denx.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH net-next] net: dsa: lan9303: ensure chip reset and wait for READY status
Date: Tue,  1 Oct 2024 11:01:48 +0200
Message-ID: <20241001090151.876200-1-alexander.sverdlin@siemens.com>
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
[alex: added msleep() + justification for tout]
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/dsa/lan9303-core.c | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index 268949939636a..5744e7ac436fb 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -839,6 +839,8 @@ static void lan9303_handle_reset(struct lan9303 *chip)
 	if (!chip->reset_gpio)
 		return;
 
+	gpiod_set_value_cansleep(chip->reset_gpio, 1);
+
 	if (chip->reset_duration != 0)
 		msleep(chip->reset_duration);
 
@@ -863,9 +865,45 @@ static int lan9303_disable_processing(struct lan9303 *chip)
 
 static int lan9303_check_device(struct lan9303 *chip)
 {
+	/*
+	 * Loading of the largest supported EEPROM is expected to take at least
+	 * 5.9s
+	 */
+	int tout = 6000 / 30;
 	int ret;
 	u32 reg;
 
+	do {
+		ret = lan9303_read(chip->regmap, LAN9303_HW_CFG, &reg);
+		if (ret) {
+			dev_err(chip->dev, "failed to read HW_CFG reg: %d\n",
+				ret);
+		}
+		tout--;
+
+		dev_dbg(chip->dev, "%s: HW_CFG: 0x%08x\n", __func__, reg);
+		if ((reg & LAN9303_HW_CFG_READY) || !tout)
+			break;
+
+		/*
+		 * In I2C-managed configurations this polling loop will clash
+		 * with switch's reading of EEPROM right after reset and this
+		 * behaviour is not configurable. While lan9303_read() already
+		 * has quite long retry timeout, seems not all cases are being
+		 * detected as arbitration error.
+		 *
+		 * According to datasheet, EEPROM loader has 30ms timeout
+		 * (in case of missing EEPROM).
+		 */
+		msleep(30);
+	} while (true);
+
+	if (!tout) {
+		dev_err(chip->dev, "%s: HW_CFG not ready: 0x%08x\n",
+			__func__, reg);
+		return -ENODEV;
+	}
+
 	ret = lan9303_read(chip->regmap, LAN9303_CHIP_REV, &reg);
 	if (ret) {
 		dev_err(chip->dev, "failed to read chip revision register: %d\n",
-- 
2.46.0


