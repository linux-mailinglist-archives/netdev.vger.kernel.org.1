Return-Path: <netdev+bounces-281252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAF2MIgV72kv6AAAu9opvQ
	(envelope-from <netdev+bounces-281252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:51:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F32F46E9D7
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AE30300D15F
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 07:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B423976A4;
	Mon, 27 Apr 2026 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="RutnrPlt"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB083806C6
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777276285; cv=none; b=TQXRa/a3wD7EeTx802sOINswHOuML3WkYe5LSYoXWJKSTI6yRjihDJUw3yMRwfF3jQzeCqWk1nRQRBX9ijiYBpYX77psXuPQTaz5YSgk2Ssi3NmDS6F9+BiR6Is3tQSeSCI6BvayxjjF3HbBnbZWFn+MeTQ6jgFocvjCSbH0yCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777276285; c=relaxed/simple;
	bh=VJe+JM/vmZ9Lf58BMZw6brbrv4i+6wpyG497EeDw5fg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EW1IU3Lp2zQo2dmwv++aaVExUskrHSlltWQJz9tHXi3Yj79heuRcrA0Bi2R9+Z2vtIycrKPLf495NGe5saK6ZLjDa9k1C4LPgrvqdzKP0SMUMjnEA7E4TIAD9hGT7C2jx6OcNESsrikRbnYMl6BDpgqexUBQ1l4IHOgC6S0TuXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zlingsmart.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=RutnrPlt; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zlingsmart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yR
	wSuP4H6/rNf2Y7Zogne8blMqYzxIrZdEtZuYq47NY=; b=RutnrPltEv8c6VxVSp
	3vok3+bgkq232x2eI6NwTO9h2lolzW3oW/Vgn4VFk3GfFeOPpgb1td8B2yA8v5qz
	aShaJzIqe3VC6KS6XpQ2ie3A7nQc2PH0xYYESQIIjHfJFr8HavZjcJbqeG0tG4f+
	vR+dFN2kUnS4nxal/3QD4TFfs=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3H7dLFe9p1oR9AQ--.45306S2;
	Mon, 27 Apr 2026 15:50:35 +0800 (CST)
From: Liu Xiang <liu.xiang@zlingsmart.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Liu Xiang <liu.xiang@zlingsmart.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v3] net: stmmac: avoid repeated devm_gpiod_get_optional in mdio
Date: Mon, 27 Apr 2026 15:50:32 +0800
Message-Id: <20260427075032.10442-1-liu.xiang@zlingsmart.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H7dLFe9p1oR9AQ--.45306S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFWfWry5Wr15Ww48tFWkZwb_yoW5Cryxp3
	y5Aas0qr9rJr1Utw4kXw48ZF95Ka43tr48W3WfW3ySgayUtFZ0qr1aqry3Zr15KrZ5WFya
	9r1UCF1Uua1qkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USzutUUUUU=
Sender: liuxiang_1999@126.com
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/xtbBrwutXmnvFUu0BAAA3-
X-Rspamd-Queue-Id: 5F32F46E9D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[zlingsmart.com];
	TAGGED_FROM(0.00)[bounces-281252-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liu.xiang@zlingsmart.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[126.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zlingsmart.com:mid,zlingsmart.com:email]

During system resume, stmmac_resume() calls stmmac_mdio_reset().
This results in repeated calls to devm_gpiod_get_optional() for the same
GPIO. The second invocation returns an error since the GPIO descriptor has
already been obtained.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 43 +++++++++++--------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 33667a267..34ebc6f3a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -372,6 +372,8 @@ struct stmmac_priv {
 	struct bpf_prog *xdp_prog;
 
 	struct devlink *devlink;
+
+	struct gpio_desc *reset_gpio;
 };
 
 enum stmmac_state {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index a7c2496b3..c0b35b8e2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -386,29 +386,26 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 
 #ifdef CONFIG_OF
 	if (priv->device->of_node) {
-		struct gpio_desc *reset_gpio;
-		u32 delays[3] = { 0, 0, 0 };
+		if (priv->reset_gpio) {
+			u32 delays[3] = { 0, 0, 0 };
 
-		reset_gpio = devm_gpiod_get_optional(priv->device,
-						     "snps,reset",
-						     GPIOD_OUT_LOW);
-		if (IS_ERR(reset_gpio))
-			return PTR_ERR(reset_gpio);
+			device_property_read_u32_array(priv->device,
+						       "snps,reset-delays-us",
+						       delays,
+						       ARRAY_SIZE(delays));
 
-		device_property_read_u32_array(priv->device,
-					       "snps,reset-delays-us",
-					       delays, ARRAY_SIZE(delays));
+			gpiod_set_value_cansleep(priv->reset_gpio, 0);
+			if (delays[0])
+				msleep(DIV_ROUND_UP(delays[0], 1000));
 
-		if (delays[0])
-			msleep(DIV_ROUND_UP(delays[0], 1000));
+			gpiod_set_value_cansleep(priv->reset_gpio, 1);
+			if (delays[1])
+				msleep(DIV_ROUND_UP(delays[1], 1000));
 
-		gpiod_set_value_cansleep(reset_gpio, 1);
-		if (delays[1])
-			msleep(DIV_ROUND_UP(delays[1], 1000));
-
-		gpiod_set_value_cansleep(reset_gpio, 0);
-		if (delays[2])
-			msleep(DIV_ROUND_UP(delays[2], 1000));
+			gpiod_set_value_cansleep(priv->reset_gpio, 0);
+			if (delays[2])
+				msleep(DIV_ROUND_UP(delays[2], 1000));
+		}
 	}
 #endif
 
@@ -648,6 +645,14 @@ int stmmac_mdio_register(struct net_device *ndev)
 	if (priv->plat->core_type == DWMAC_CORE_XGMAC)
 		stmmac_xgmac2_mdio_read_c45(new_bus, 0, 0, 0);
 
+	priv->reset_gpio = devm_gpiod_get_optional(priv->device,
+						   "snps,reset",
+						    GPIOD_ASIS);
+	if (IS_ERR(priv->reset_gpio)) {
+		priv->reset_gpio = NULL;
+		dev_warn(dev, "No reset GPIO found\n");
+	}
+
 	/* If fixed-link is set, skip PHY scanning */
 	fwnode = priv->plat->port_node;
 	if (!fwnode)
-- 
2.34.1


