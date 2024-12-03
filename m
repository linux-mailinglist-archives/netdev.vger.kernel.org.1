Return-Path: <netdev+bounces-148376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1319E1405
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6CF164A44
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BA51E0B78;
	Tue,  3 Dec 2024 07:22:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8CB1DED62
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210533; cv=none; b=quuOD3cNAhoh2VLMbHgYohj+wZNa5nvQUESQ0aSqgr2hEATezA2Cnwxl39yXGrk79v31icy/FyVWw8LSjRw/AFROlFfROssz4EniEFNYtq7Y5RP3/5PiK0Z23eOE1Sb+oHb+bzQFtF0IfgSQTtGu2i5uDEDZ6HS0L9qUErq/ElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210533; c=relaxed/simple;
	bh=HOXLXiMPHRS6IL2NNR8//USrcPilE4QP9QKx0Qv7l74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rul4QqQ9IlwBkNyIAO457R3AFQBb8YThSPl5OZF/zvr/6m66KEVEgERrDtw8Jzzl68J4SwKW/mxB+mru3aWVGPXmJhceD8sMYNMlUmLtQI4qJJsH6+SnWTrQXisyD74a1m/a1CBRVBzbw4+1NHZDyRYL5tjPuewefeznswPPvE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEL-0004s4-6E; Tue, 03 Dec 2024 08:21:57 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-001Qys-0N;
	Tue, 03 Dec 2024 08:21:55 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-00AEnP-2V;
	Tue, 03 Dec 2024 08:21:55 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v1 06/21] net: usb: lan78xx: Improve error handling in EEPROM and OTP operations
Date: Tue,  3 Dec 2024 08:21:39 +0100
Message-Id: <20241203072154.2440034-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241203072154.2440034-1-o.rempel@pengutronix.de>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Refine error handling in EEPROM and OTP read/write functions by:
- Return error values immediately upon detection.
- Avoid overwriting correct error codes with `-EIO`.
- Preserve initial error codes as they were appropriate for specific
  failures.
- Use `-ETIMEDOUT` for timeout conditions instead of `-EIO`.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 240 ++++++++++++++++++++++++--------------
 1 file changed, 152 insertions(+), 88 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index ee308be1e618..29f6e1a36e20 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1000,8 +1000,8 @@ static int lan78xx_wait_eeprom(struct lan78xx_net *dev)
 
 	do {
 		ret = lan78xx_read_reg(dev, E2P_CMD, &val);
-		if (unlikely(ret < 0))
-			return -EIO;
+		if (ret < 0)
+			return ret;
 
 		if (!(val & E2P_CMD_EPC_BUSY_) ||
 		    (val & E2P_CMD_EPC_TIMEOUT_))
@@ -1011,7 +1011,7 @@ static int lan78xx_wait_eeprom(struct lan78xx_net *dev)
 
 	if (val & (E2P_CMD_EPC_TIMEOUT_ | E2P_CMD_EPC_BUSY_)) {
 		netdev_warn(dev->net, "EEPROM read operation timeout");
-		return -EIO;
+		return -ETIMEDOUT;
 	}
 
 	return 0;
@@ -1025,8 +1025,8 @@ static int lan78xx_eeprom_confirm_not_busy(struct lan78xx_net *dev)
 
 	do {
 		ret = lan78xx_read_reg(dev, E2P_CMD, &val);
-		if (unlikely(ret < 0))
-			return -EIO;
+		if (ret < 0)
+			return ret;
 
 		if (!(val & E2P_CMD_EPC_BUSY_))
 			return 0;
@@ -1035,75 +1035,81 @@ static int lan78xx_eeprom_confirm_not_busy(struct lan78xx_net *dev)
 	} while (!time_after(jiffies, start_time + HZ));
 
 	netdev_warn(dev->net, "EEPROM is busy");
-	return -EIO;
+	return -ETIMEDOUT;
 }
 
 static int lan78xx_read_raw_eeprom(struct lan78xx_net *dev, u32 offset,
 				   u32 length, u8 *data)
 {
-	u32 val;
-	u32 saved;
+	u32 val, saved;
 	int i, ret;
-	int retval;
 
 	/* depends on chip, some EEPROM pins are muxed with LED function.
 	 * disable & restore LED function to access EEPROM.
 	 */
 	ret = lan78xx_read_reg(dev, HW_CFG, &val);
+	if (ret < 0)
+		return ret;
+
 	saved = val;
 	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
 		val &= ~(HW_CFG_LED1_EN_ | HW_CFG_LED0_EN_);
 		ret = lan78xx_write_reg(dev, HW_CFG, val);
+		if (ret < 0)
+			return ret;
 	}
 
-	retval = lan78xx_eeprom_confirm_not_busy(dev);
-	if (retval)
-		return retval;
+	ret = lan78xx_eeprom_confirm_not_busy(dev);
+	if (ret == -ETIMEDOUT)
+		goto read_raw_eeprom_done;
+	/* If USB fails, there is nothing to do */
+	if (ret < 0)
+		return ret;
 
 	for (i = 0; i < length; i++) {
 		val = E2P_CMD_EPC_BUSY_ | E2P_CMD_EPC_CMD_READ_;
 		val |= (offset & E2P_CMD_EPC_ADDR_MASK_);
 		ret = lan78xx_write_reg(dev, E2P_CMD, val);
-		if (unlikely(ret < 0)) {
-			retval = -EIO;
-			goto exit;
-		}
+		if (ret < 0)
+			return ret;
 
-		retval = lan78xx_wait_eeprom(dev);
-		if (retval < 0)
-			goto exit;
+		ret = lan78xx_wait_eeprom(dev);
+		/* Looks like not USB specific error, try to recover */
+		if (ret == -ETIMEDOUT)
+			goto read_raw_eeprom_done;
+		/* If USB fails, there is nothing to do */
+		if (ret < 0)
+			return ret;
 
 		ret = lan78xx_read_reg(dev, E2P_DATA, &val);
-		if (unlikely(ret < 0)) {
-			retval = -EIO;
-			goto exit;
-		}
+		if (ret < 0)
+			return ret;
 
 		data[i] = val & 0xFF;
 		offset++;
 	}
 
-	retval = 0;
-exit:
+read_raw_eeprom_done:
 	if (dev->chipid == ID_REV_CHIP_ID_7800_)
-		ret = lan78xx_write_reg(dev, HW_CFG, saved);
+		return lan78xx_write_reg(dev, HW_CFG, saved);
 
-	return retval;
+	return 0;
 }
 
 static int lan78xx_read_eeprom(struct lan78xx_net *dev, u32 offset,
 			       u32 length, u8 *data)
 {
-	u8 sig;
 	int ret;
+	u8 sig;
 
 	ret = lan78xx_read_raw_eeprom(dev, 0, 1, &sig);
-	if ((ret == 0) && (sig == EEPROM_INDICATOR))
-		ret = lan78xx_read_raw_eeprom(dev, offset, length, data);
-	else
-		ret = -EINVAL;
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	if (sig != EEPROM_INDICATOR)
+		return -ENODATA;
+
+	return lan78xx_read_raw_eeprom(dev, offset, length, data);
 }
 
 static int lan78xx_write_raw_eeprom(struct lan78xx_net *dev, u32 offset,
@@ -1112,113 +1118,144 @@ static int lan78xx_write_raw_eeprom(struct lan78xx_net *dev, u32 offset,
 	u32 val;
 	u32 saved;
 	int i, ret;
-	int retval;
 
 	/* depends on chip, some EEPROM pins are muxed with LED function.
 	 * disable & restore LED function to access EEPROM.
 	 */
 	ret = lan78xx_read_reg(dev, HW_CFG, &val);
+	if (ret < 0)
+		return ret;
+
 	saved = val;
 	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
 		val &= ~(HW_CFG_LED1_EN_ | HW_CFG_LED0_EN_);
 		ret = lan78xx_write_reg(dev, HW_CFG, val);
+		if (ret < 0)
+			return ret;
 	}
 
-	retval = lan78xx_eeprom_confirm_not_busy(dev);
-	if (retval)
-		goto exit;
+	ret = lan78xx_eeprom_confirm_not_busy(dev);
+	/* Looks like not USB specific error, try to recover */
+	if (ret == -ETIMEDOUT)
+		goto write_raw_eeprom_done;
+	/* If USB fails, there is nothing to do */
+	if (ret < 0)
+		return ret;
 
 	/* Issue write/erase enable command */
 	val = E2P_CMD_EPC_BUSY_ | E2P_CMD_EPC_CMD_EWEN_;
 	ret = lan78xx_write_reg(dev, E2P_CMD, val);
-	if (unlikely(ret < 0)) {
-		retval = -EIO;
-		goto exit;
-	}
+	if (ret < 0)
+		return ret;
 
-	retval = lan78xx_wait_eeprom(dev);
-	if (retval < 0)
-		goto exit;
+	ret = lan78xx_wait_eeprom(dev);
+	/* Looks like not USB specific error, try to recover */
+	if (ret == -ETIMEDOUT)
+		goto write_raw_eeprom_done;
+	/* If USB fails, there is nothing to do */
+	if (ret < 0)
+		return ret;
 
 	for (i = 0; i < length; i++) {
 		/* Fill data register */
 		val = data[i];
 		ret = lan78xx_write_reg(dev, E2P_DATA, val);
-		if (ret < 0) {
-			retval = -EIO;
-			goto exit;
-		}
+		if (ret < 0)
+			return ret;
 
 		/* Send "write" command */
 		val = E2P_CMD_EPC_BUSY_ | E2P_CMD_EPC_CMD_WRITE_;
 		val |= (offset & E2P_CMD_EPC_ADDR_MASK_);
 		ret = lan78xx_write_reg(dev, E2P_CMD, val);
-		if (ret < 0) {
-			retval = -EIO;
-			goto exit;
-		}
+		if (ret < 0)
+			return ret;
 
-		retval = lan78xx_wait_eeprom(dev);
-		if (retval < 0)
-			goto exit;
+		ret = lan78xx_wait_eeprom(dev);
+		/* Looks like not USB specific error, try to recover */
+		if (ret == -ETIMEDOUT)
+			goto write_raw_eeprom_done;
+		/* If USB fails, there is nothing to do */
+		if (ret < 0)
+			return ret;
 
 		offset++;
 	}
 
-	retval = 0;
-exit:
+write_raw_eeprom_done:
 	if (dev->chipid == ID_REV_CHIP_ID_7800_)
-		ret = lan78xx_write_reg(dev, HW_CFG, saved);
+		return lan78xx_write_reg(dev, HW_CFG, saved);
 
-	return retval;
+	return 0;
 }
 
 static int lan78xx_read_raw_otp(struct lan78xx_net *dev, u32 offset,
 				u32 length, u8 *data)
 {
-	int i;
-	u32 buf;
 	unsigned long timeout;
+	int ret, i;
+	u32 buf;
 
-	lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
+	ret = lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
+	if (ret < 0)
+		return ret;
 
 	if (buf & OTP_PWR_DN_PWRDN_N_) {
 		/* clear it and wait to be cleared */
-		lan78xx_write_reg(dev, OTP_PWR_DN, 0);
+		ret = lan78xx_write_reg(dev, OTP_PWR_DN, 0);
+		if (ret < 0)
+			return ret;
 
 		timeout = jiffies + HZ;
 		do {
 			usleep_range(1, 10);
-			lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
+			ret = lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
+			if (ret < 0)
+				return ret;
+
 			if (time_after(jiffies, timeout)) {
 				netdev_warn(dev->net,
 					    "timeout on OTP_PWR_DN");
-				return -EIO;
+				return -ETIMEDOUT;
 			}
 		} while (buf & OTP_PWR_DN_PWRDN_N_);
 	}
 
 	for (i = 0; i < length; i++) {
-		lan78xx_write_reg(dev, OTP_ADDR1,
-				  ((offset + i) >> 8) & OTP_ADDR1_15_11);
-		lan78xx_write_reg(dev, OTP_ADDR2,
-				  ((offset + i) & OTP_ADDR2_10_3));
+		ret = lan78xx_write_reg(dev, OTP_ADDR1,
+					((offset + i) >> 8) & OTP_ADDR1_15_11);
+		if (ret < 0)
+			return ret;
+
+		ret = lan78xx_write_reg(dev, OTP_ADDR2,
+					((offset + i) & OTP_ADDR2_10_3));
+		if (ret < 0)
+			return ret;
+
+		ret = lan78xx_write_reg(dev, OTP_FUNC_CMD, OTP_FUNC_CMD_READ_);
+		if (ret < 0)
+			return ret;
 
-		lan78xx_write_reg(dev, OTP_FUNC_CMD, OTP_FUNC_CMD_READ_);
-		lan78xx_write_reg(dev, OTP_CMD_GO, OTP_CMD_GO_GO_);
+		ret = lan78xx_write_reg(dev, OTP_CMD_GO, OTP_CMD_GO_GO_);
+		if (ret < 0)
+			return ret;
 
 		timeout = jiffies + HZ;
 		do {
 			udelay(1);
-			lan78xx_read_reg(dev, OTP_STATUS, &buf);
+			ret = lan78xx_read_reg(dev, OTP_STATUS, &buf);
+			if (ret < 0)
+				return ret;
+
 			if (time_after(jiffies, timeout)) {
 				netdev_warn(dev->net,
 					    "timeout on OTP_STATUS");
-				return -EIO;
+				return -ETIMEDOUT;
 			}
 		} while (buf & OTP_STATUS_BUSY_);
 
-		lan78xx_read_reg(dev, OTP_RD_DATA, &buf);
+		ret = lan78xx_read_reg(dev, OTP_RD_DATA, &buf);
+		if (ret < 0)
+			return ret;
 
 		data[i] = (u8)(buf & 0xFF);
 	}
@@ -1232,45 +1269,72 @@ static int lan78xx_write_raw_otp(struct lan78xx_net *dev, u32 offset,
 	int i;
 	u32 buf;
 	unsigned long timeout;
+	int ret;
 
-	lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
+	ret = lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
+	if (ret < 0)
+		return ret;
 
 	if (buf & OTP_PWR_DN_PWRDN_N_) {
 		/* clear it and wait to be cleared */
-		lan78xx_write_reg(dev, OTP_PWR_DN, 0);
+		ret = lan78xx_write_reg(dev, OTP_PWR_DN, 0);
+		if (ret < 0)
+			return ret;
 
 		timeout = jiffies + HZ;
 		do {
 			udelay(1);
-			lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
+			ret = lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
+			if (ret < 0)
+				return ret;
+
 			if (time_after(jiffies, timeout)) {
 				netdev_warn(dev->net,
 					    "timeout on OTP_PWR_DN completion");
-				return -EIO;
+				return -ETIMEDOUT;
 			}
 		} while (buf & OTP_PWR_DN_PWRDN_N_);
 	}
 
 	/* set to BYTE program mode */
-	lan78xx_write_reg(dev, OTP_PRGM_MODE, OTP_PRGM_MODE_BYTE_);
+	ret = lan78xx_write_reg(dev, OTP_PRGM_MODE, OTP_PRGM_MODE_BYTE_);
+	if (ret < 0)
+		return ret;
 
 	for (i = 0; i < length; i++) {
-		lan78xx_write_reg(dev, OTP_ADDR1,
-				  ((offset + i) >> 8) & OTP_ADDR1_15_11);
-		lan78xx_write_reg(dev, OTP_ADDR2,
-				  ((offset + i) & OTP_ADDR2_10_3));
-		lan78xx_write_reg(dev, OTP_PRGM_DATA, data[i]);
-		lan78xx_write_reg(dev, OTP_TST_CMD, OTP_TST_CMD_PRGVRFY_);
-		lan78xx_write_reg(dev, OTP_CMD_GO, OTP_CMD_GO_GO_);
+		ret = lan78xx_write_reg(dev, OTP_ADDR1,
+					((offset + i) >> 8) & OTP_ADDR1_15_11);
+		if (ret < 0)
+			return ret;
+
+		ret = lan78xx_write_reg(dev, OTP_ADDR2,
+					((offset + i) & OTP_ADDR2_10_3));
+		if (ret < 0)
+			return ret;
+
+		ret = lan78xx_write_reg(dev, OTP_PRGM_DATA, data[i]);
+		if (ret < 0)
+			return ret;
+
+		ret = lan78xx_write_reg(dev, OTP_TST_CMD, OTP_TST_CMD_PRGVRFY_);
+		if (ret < 0)
+			return ret;
+
+		ret = lan78xx_write_reg(dev, OTP_CMD_GO, OTP_CMD_GO_GO_);
+		if (ret < 0)
+			return ret;
 
 		timeout = jiffies + HZ;
 		do {
 			udelay(1);
-			lan78xx_read_reg(dev, OTP_STATUS, &buf);
+			ret = lan78xx_read_reg(dev, OTP_STATUS, &buf);
+			if (ret < 0)
+				return ret;
+
 			if (time_after(jiffies, timeout)) {
 				netdev_warn(dev->net,
 					    "Timeout on OTP_STATUS completion");
-				return -EIO;
+				return -ETIMEDOUT;
 			}
 		} while (buf & OTP_STATUS_BUSY_);
 	}
-- 
2.39.5


