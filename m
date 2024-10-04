Return-Path: <netdev+bounces-132011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6E499022C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D794A1F23519
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47911155733;
	Fri,  4 Oct 2024 11:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="WHKsleH9"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687B91EB2E
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728041909; cv=none; b=GuPvYdGb4mOdPy/aEfNgVvLzYfvYNgw86YIArZ+uJQ+RWloIdE9HePaHYbxc/hN67BuiZ44ckomBWfn6l30s72m4cR7+IaBDqqPwlaVfeIYVIRQJQjlyc91wgql7xqljT+xg7rENLUtC5cwUl+F95+Ep9pG4rfQ75qKtFD5YWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728041909; c=relaxed/simple;
	bh=XYK+rw8xKpvXeMHQF1dKZ4ZWLocOBTDTEhfFjxONxGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6R/e+8A0e6bq+o4HHZaeyGXcKY5qRL6H9ujGq663K+3EwT/gnPAwzIyB9myB7nOiOEsS+D3JictKUZbF6/no/H3PJ6lIq5VUKyNsjhM9k/ByiT5AgF/Sbtjw7otlEcLKv0LOhfZhaOp6qlEXgIZU6PuSYOib9dqtBUl2kaINAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=WHKsleH9; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20241004113811d45e5f832dd3692756
        for <netdev@vger.kernel.org>;
        Fri, 04 Oct 2024 13:38:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=p+hfBwLXx/KXLHLVUc0TTdbArPb9R37LaZPFd1Db5Bw=;
 b=WHKsleH9xhLG3EFBw3hLLc7r5EM6tLFqMEp/EyuFuBgPIhM2+Zgbe4K5IB7JcULsBZJ8jg
 m1uWXySfXUWvP3qxiIdfMzc80H/iKIcV5y1wf0ZxSddRsDB0uvS7SwSX8fbUpG/th+l+KK3c
 AEBZO76REwZDbTTNpcgcpSrZrrEhETtTRwAigAWMOgxsuS/tMpUyd1JchSjngCmpSZPpPwz+
 luClHvrRNyZtHThQc5QmAK/6qYG91YkFw+kIrZuAZvJkeZDU/QoHO9HjMUsgF4y47mzNG0cT
 PLLUeNih9TqxjZEqL3wKPiIOTh26xt4Q5u4ZPPp71McAxkumQ7WkT5nA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Anatolij Gustschin <agust@denx.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH net v4] net: dsa: lan9303: ensure chip reset and wait for READY status
Date: Fri,  4 Oct 2024 13:36:54 +0200
Message-ID: <20241004113655.3436296-1-alexander.sverdlin@siemens.com>
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
v4: return read_poll_timeout() error unmodified
v3: comment style, use "!ret" in stop condition, user-readable error code
v2: use read_poll_timeout()

 drivers/net/dsa/lan9303-core.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index 268949939636a..d246f95d57ecf 100644
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
 
@@ -864,8 +867,34 @@ static int lan9303_disable_processing(struct lan9303 *chip)
 static int lan9303_check_device(struct lan9303 *chip)
 {
 	int ret;
+	int err;
 	u32 reg;
 
+	/* In I2C-managed configurations this polling loop will clash with
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
+	err = read_poll_timeout(lan9303_read, ret,
+				!ret && reg & LAN9303_HW_CFG_READY,
+				20000, 6000000, false,
+				chip->regmap, LAN9303_HW_CFG, &reg);
+	if (ret) {
+		dev_err(chip->dev, "failed to read HW_CFG reg: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+	if (err) {
+		dev_err(chip->dev, "HW_CFG not ready: 0x%08x\n", reg);
+		return err;
+	}
+
 	ret = lan9303_read(chip->regmap, LAN9303_CHIP_REV, &reg);
 	if (ret) {
 		dev_err(chip->dev, "failed to read chip revision register: %d\n",
-- 
2.46.2


