Return-Path: <netdev+bounces-84015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED143895509
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5D71C22325
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F22113442D;
	Tue,  2 Apr 2024 13:13:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98F131720
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063638; cv=none; b=aP9Fa5Maaj+T5o6JXOSBpj3zcwX+BpfC12dN72GDc822FGa/GwobCStYeAp2B08zEsFg6koFvEJ/PrZ5nnpwT30wS+9Q3Qsv9UVStls5CuVJerv84MQKEdgpx683SdDC/sZz7IhQYB1E8MlEvDveOJTOa0ZK/Uy93xFoO9YGr/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063638; c=relaxed/simple;
	bh=L1PTgioQ9UTXOR1GMlJUXHK63uWuG9gFutlyR0MyD9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p3y6bU78N+m5tXxZ0M9dVoZnZkC34c4LSiLBAk61sEYZyqfscYbAPrOWiIG7r5SGP5uw6tisE8i8xsmC0CDZw+WXAw5b9xEc8Tg9T3JvgnB2mJLFc9VJs5mlTNpWJrf95ImRPyc3gINBzrF4nEB3yBcXsWuPPHJO9FPF2Y+fBIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxN-0007Nl-MW; Tue, 02 Apr 2024 15:13:41 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxM-009zW6-Gp; Tue, 02 Apr 2024 15:13:40 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxM-006OpX-1R;
	Tue, 02 Apr 2024 15:13:40 +0200
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
Subject: [PATCH net-next v1 5/8] net: dsa: microchip: ksz8: Unify variable naming in ksz8_r_dyn_mac_table()
Date: Tue,  2 Apr 2024 15:13:36 +0200
Message-Id: <20240402131339.1525330-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402131339.1525330-1-o.rempel@pengutronix.de>
References: <20240402131339.1525330-1-o.rempel@pengutronix.de>
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

Use 'ret' instead of 'rc' in ksz8_r_dyn_mac_table() to maintain
consistency with the rest of the file.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 1962195e16a6f..d5ec4b9772752 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -419,7 +419,7 @@ static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 	u64 buf = 0;
 	u8 data;
 	int cnt;
-	int rc;
+	int ret;
 
 	shifts = dev->info->shifts;
 	masks = dev->info->masks;
@@ -430,12 +430,12 @@ static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 	mutex_lock(&dev->alu_mutex);
 	ksz_write16(dev, regs[REG_IND_CTRL_0], ctrl_addr);
 
-	rc = ksz8_valid_dyn_entry(dev, &data);
-	if (rc == -EAGAIN) {
+	ret = ksz8_valid_dyn_entry(dev, &data);
+	if (ret == -EAGAIN) {
 		if (addr == 0)
 			*entries = 0;
 		goto unlock_alu;
-	} else if (rc == -ENXIO) {
+	} else if (ret == -ENXIO) {
 		*entries = 0;
 		goto unlock_alu;
 	}
@@ -463,12 +463,12 @@ static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 
 	mac_addr[1] = (u8)data_hi;
 	mac_addr[0] = (u8)(data_hi >> 8);
-	rc = 0;
+	ret = 0;
 
 unlock_alu:
 	mutex_unlock(&dev->alu_mutex);
 
-	return rc;
+	return ret;
 }
 
 static int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
-- 
2.39.2


