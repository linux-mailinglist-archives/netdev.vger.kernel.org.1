Return-Path: <netdev+bounces-131930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0173498FF6C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA741F21033
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A8F145341;
	Fri,  4 Oct 2024 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="bmQRlAR7"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF41448DF
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033238; cv=none; b=BMx6nJ+9AHD4y9OfvIuhn1qzpBdEq72P4IEFr4GY4YTEuAY6PPO7NZfhcscGvj4BbEa1lPsnTLdeD1GGU4qHujuj5fGji/EVRbQNDucOws7WJvjftfGrj+tAFSuX+6gN4qxinLQlMQanhQ4jKZ3OKPf3xX7yBPR7VyN20QOxGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033238; c=relaxed/simple;
	bh=tn1I7wpm3/zKEWSwdx9qyVtuRYk4ylXroVRIoFeua0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WSt9gEL+W9nf6Ig6K0yxS/MKVwQz/u1TDrHAJ3b8/glP8MyQQCKmrAsivTBM7mZyyXh+Kykf4w2iUpooaYyYIxtKflZhI9I6ZGFOxuBhk5s04C1BLC/rzZPlhZ15GktY/gLeWKbvH8d4P35EAkCe6FmZHz+p+mUETIfegFpr1jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=bmQRlAR7; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20241004090345753918047a3ff72a09
        for <netdev@vger.kernel.org>;
        Fri, 04 Oct 2024 11:03:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Erops0btVT3gcx2HZJeVGVUnqbkpqjwPDWGeaOYbKQI=;
 b=bmQRlAR78QfZ/QPCQfC9Vv7XHTW16Twjk3ZQKr/aHWo/KtbwengUDSZpc0zTVuAj2laU9n
 /daKkapNeS8eEW5nWyKEreX7xz0+EwcADKujzD6PnQohq5toLyLkpgW9/mQY8AsIMmmhFLWk
 RueaMfhlouR/o1UeEoVTrKSuF+GFvfkGmZ/lDkGUcA5AQrnoqqKAxdU7M1L4DcqZ33QUVVsM
 bX17VVa0w9jcIMWt4iSZMyHnP6wWQJDO/iSOPciBQjTmp2BP5bxJ8+FzIF22ipv0XkXXeTkl
 j2te1Izv9kbtSb8rlxo9yGcdNAY3GoB9lMq376oCr7Ym+R9B/z/4G2fA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Anatolij Gustschin <agust@denx.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH net v3] net: dsa: lan9303: ensure chip reset and wait for READY status
Date: Fri,  4 Oct 2024 11:03:31 +0200
Message-ID: <20241004090332.3252564-1-alexander.sverdlin@siemens.com>
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
v3: comment style, use "!ret" in stop condition, user-readable error code
v2: use read_poll_timeout()

 drivers/net/dsa/lan9303-core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index 268949939636a..f478b55d4d297 100644
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
 
@@ -866,6 +869,30 @@ static int lan9303_check_device(struct lan9303 *chip)
 	int ret;
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
+	if (read_poll_timeout(lan9303_read, ret,
+			      !ret && reg & LAN9303_HW_CFG_READY,
+			      20000, 6000000, false,
+			      chip->regmap, LAN9303_HW_CFG, &reg)) {
+		dev_err(chip->dev, "HW_CFG not ready: 0x%08x\n", reg);
+		return -ETIMEDOUT;
+	}
+	if (ret) {
+		dev_err(chip->dev, "failed to read HW_CFG reg: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
 	ret = lan9303_read(chip->regmap, LAN9303_CHIP_REV, &reg);
 	if (ret) {
 		dev_err(chip->dev, "failed to read chip revision register: %d\n",
-- 
2.46.2


