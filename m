Return-Path: <netdev+bounces-84453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191C1896F58
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA301C261E5
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3EE14882D;
	Wed,  3 Apr 2024 12:50:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5E9146D65
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148654; cv=none; b=TfXJjJ+XrqrAUzQZMllZs2TmQAhrZhOKdUecy5w+CXEaEm43ZIDilwCkqMhcgorB8CFFZX7SXivH9UUKsfz4e1aw5KP2Ybyd9rrdwbRPvgRrh2JFcEBTkE9SQCenpXE7v0RTWuFxW/MJ9N2MBdkxxRHwMPqCnLkIYkP6EGvFWtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148654; c=relaxed/simple;
	bh=NA2fFPMrmmfDyRMamEZkosSkMFaKXIJpa7uMLU7FeMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dTOldQNrhSHfbQ5LzI0I0vrXtZNqMcSlchPFT0cKnHwRxTKHe1QRSXG7yDkev0+0WOfbr+3SCkr6MYJyugJx8Cy4YFsOKyiv2t91iaRq1rLbn6RP//Wk+FgLODzBIvOmLbCTKpTOlNqmWnudn+1BYJ36rIXK+vPXXK6j73w0VMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04h-0005yU-0a; Wed, 03 Apr 2024 14:50:43 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04f-00ABEk-EC; Wed, 03 Apr 2024 14:50:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04f-00EKaP-0r;
	Wed, 03 Apr 2024 14:50:41 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v2 7/8] net: dsa: microchip: ksz8_r_dyn_mac_table(): return read/write error if we got any
Date: Wed,  3 Apr 2024 14:50:38 +0200
Message-Id: <20240403125039.3414824-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403125039.3414824-1-o.rempel@pengutronix.de>
References: <20240403125039.3414824-1-o.rempel@pengutronix.de>
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

The read/write path may fail. So, return error if we got it.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index eeb32df0939d1..de3d8357da855 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -385,12 +385,16 @@ static int ksz8_valid_dyn_entry(struct ksz_device *dev, u8 *data)
 	int timeout = 100;
 	const u32 *masks;
 	const u16 *regs;
+	int ret;
 
 	masks = dev->info->masks;
 	regs = dev->info->regs;
 
 	do {
-		ksz_read8(dev, regs[REG_IND_DATA_CHECK], data);
+		ret = ksz_read8(dev, regs[REG_IND_DATA_CHECK], data);
+		if (ret)
+			return ret;
+
 		timeout--;
 	} while ((*data & masks[DYNAMIC_MAC_TABLE_NOT_READY]) && timeout);
 
@@ -399,7 +403,9 @@ static int ksz8_valid_dyn_entry(struct ksz_device *dev, u8 *data)
 		return -ETIMEDOUT;
 	/* Entry is ready for accessing. */
 	} else {
-		ksz_read8(dev, regs[REG_IND_DATA_8], data);
+		ret = ksz_read8(dev, regs[REG_IND_DATA_8], data);
+		if (ret)
+			return ret;
 
 		/* There is no valid entry in the table. */
 		if (*data & masks[DYNAMIC_MAC_TABLE_MAC_EMPTY])
@@ -428,7 +434,9 @@ static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 	ctrl_addr = IND_ACC_TABLE(TABLE_DYNAMIC_MAC | TABLE_READ) | addr;
 
 	mutex_lock(&dev->alu_mutex);
-	ksz_write16(dev, regs[REG_IND_CTRL_0], ctrl_addr);
+	ret = ksz_write16(dev, regs[REG_IND_CTRL_0], ctrl_addr);
+	if (ret)
+		goto unlock_alu;
 
 	ret = ksz8_valid_dyn_entry(dev, &data);
 	if (ret == -ENXIO) {
@@ -439,7 +447,10 @@ static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 	if (ret)
 		goto unlock_alu;
 
-	ksz_read64(dev, regs[REG_IND_DATA_HI], &buf);
+	ret = ksz_read64(dev, regs[REG_IND_DATA_HI], &buf);
+	if (ret)
+		goto unlock_alu;
+
 	data_hi = (u32)(buf >> 32);
 	data_lo = (u32)buf;
 
@@ -462,7 +473,6 @@ static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 
 	mac_addr[1] = (u8)data_hi;
 	mac_addr[0] = (u8)(data_hi >> 8);
-	ret = 0;
 
 unlock_alu:
 	mutex_unlock(&dev->alu_mutex);
-- 
2.39.2


