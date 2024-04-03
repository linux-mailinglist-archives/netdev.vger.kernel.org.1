Return-Path: <netdev+bounces-84451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D9B896F53
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52911F287A5
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322D61487D7;
	Wed,  3 Apr 2024 12:50:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D019146D57
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148654; cv=none; b=OLu9qsNinMdcjM3UEfJWQKiZ7+6mHOmZe7s/q1l78BnBiECqCB+Db6OoBV02fLRJkvcqa3JvfjFalLirNAUyp8rkna/AKQUMBMAj38mmeke1ng5ix+0GapWhgpDSsGNknBZM9awxAgoplZ8OowP56kcBjEkR8gU1sCCVwXfZBBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148654; c=relaxed/simple;
	bh=Bcc7wC539i7cfCgpBSkB4ImTrUNgqBAy5MoTxbGa6hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VKw6teImx0oKT9tP1WoZrIuVKZY1VP5TvfS/nf3bFVdNvi0axhEX+mnDG3CgLt4n3G0ZXZZmTIssdb7xxU1fhjYrm63Gng63OUISw9h3XL355+KqtC3dDTQ3Ed9ryrpEEJOshNoq6MBceuLuYw7uDUv9qwRVtDZd74+cy+fB8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04h-0005yV-0Z; Wed, 03 Apr 2024 14:50:43 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04f-00ABEm-Fz; Wed, 03 Apr 2024 14:50:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04f-00EKbB-1F;
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
Subject: [PATCH net-next v2 8/8] net: dsa: microchip: ksz8_r_dyn_mac_table(): use entries variable to signal 0 entries
Date: Wed,  3 Apr 2024 14:50:39 +0200
Message-Id: <20240403125039.3414824-9-o.rempel@pengutronix.de>
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

We already have a variable to provide number of entries. So use it,
instead of using error number.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index de3d8357da855..ecef6f6f830b3 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -399,19 +399,11 @@ static int ksz8_valid_dyn_entry(struct ksz_device *dev, u8 *data)
 	} while ((*data & masks[DYNAMIC_MAC_TABLE_NOT_READY]) && timeout);
 
 	/* Entry is not ready for accessing. */
-	if (*data & masks[DYNAMIC_MAC_TABLE_NOT_READY]) {
+	if (*data & masks[DYNAMIC_MAC_TABLE_NOT_READY])
 		return -ETIMEDOUT;
-	/* Entry is ready for accessing. */
-	} else {
-		ret = ksz_read8(dev, regs[REG_IND_DATA_8], data);
-		if (ret)
-			return ret;
 
-		/* There is no valid entry in the table. */
-		if (*data & masks[DYNAMIC_MAC_TABLE_MAC_EMPTY])
-			return -ENXIO;
-	}
-	return 0;
+	/* Entry is ready for accessing. */
+	return ksz_read8(dev, regs[REG_IND_DATA_8], data);
 }
 
 static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
@@ -439,13 +431,13 @@ static int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 		goto unlock_alu;
 
 	ret = ksz8_valid_dyn_entry(dev, &data);
-	if (ret == -ENXIO) {
-		*entries = 0;
+	if (ret)
 		goto unlock_alu;
-	}
 
-	if (ret)
+	if (data & masks[DYNAMIC_MAC_TABLE_MAC_EMPTY]) {
+		*entries = 0;
 		goto unlock_alu;
+	}
 
 	ret = ksz_read64(dev, regs[REG_IND_DATA_HI], &buf);
 	if (ret)
@@ -1210,8 +1202,6 @@ int ksz8_fdb_dump(struct ksz_device *dev, int port,
 	for (i = 0; i < KSZ8_DYN_MAC_ENTRIES; i++) {
 		ret = ksz8_r_dyn_mac_table(dev, i, mac, &fid, &src_port,
 					   &entries);
-		if (ret == -ENXIO)
-			return 0;
 		if (ret)
 			return ret;
 
-- 
2.39.2


