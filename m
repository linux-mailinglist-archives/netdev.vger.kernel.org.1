Return-Path: <netdev+bounces-288199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBYKEpbFBmpdngIAu9opvQ
	(envelope-from <netdev+bounces-288199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:04:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0105654A4AF
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22567308FDF1
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 06:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5232D37DACE;
	Fri, 15 May 2026 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="GRUO0vie"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083CB3CC306
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 06:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778828284; cv=none; b=Q79pcQbYM/v/PItmDOV1xnub3Zz33V1JYyb7+71JnTY6a+Kh69dsWDEkusQusdBU3hclywxVbSSQTyXuW5paUaisFMVVDafe0C4MPUTI5DWEHujLFOtSLy+VpLWaCq3Vj4GPyJqNl+vOzPnop0bv7Yi14HQd3MMAynYQ9xlMgrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778828284; c=relaxed/simple;
	bh=zCfWK9Cwj1/E24bkqFQR4g8IPeZwSaE3lwNY9FRc6Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r7GWZAPS53321uvpJLMoh/WrrTdxKe9bKaAJKqWl23Dpb5gtXVgUZRAIhNNExBD7GQi469GYEuGN+S1QNF65N+VEQkrLfFuPiMj1o6WqG8J5GSBY6FYdFHON00Ae3j83FXxXQqd/t7/ZOedDwAgzlAiIbXvEAnRR+fkZTbqRLC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zlingsmart.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=GRUO0vie; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zlingsmart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Cb
	BkPSrSNzq233BEc2bgakAVeCLNB5w/irLagmtLHfI=; b=GRUO0vie3ZYRQShAlN
	upz4NSX+3pcsTyH9NHR8U2JG7jNw4pxDWo6ZIZ8rMTe0RojjKKyM5ctnKcbT84qM
	LKWMIubBt0D3FdAyN3BKV+MrtAZW3AfkdbpNI/KiJdij0u2zbwi6F4UlCpWgTibN
	24yquq1UT1YPNfB2Nuz4tqW70=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXj_y2wwZquh4GBg--.25471S2;
	Fri, 15 May 2026 14:56:55 +0800 (CST)
From: Liu Xiang <liu.xiang@zlingsmart.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Liu Xiang <liu.xiang@zlingsmart.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v4] net: stmmac: avoid repeated devm_gpiod_get_optional in mdio reset on resume
Date: Fri, 15 May 2026 14:56:52 +0800
Message-Id: <20260515065652.46998-1-liu.xiang@zlingsmart.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXj_y2wwZquh4GBg--.25471S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFW3ZFykXFWDZr4kGF48WFg_yoW5WFWxp3
	y5Za45Xr1kAr18tw4kXw48ZF95Kay3tr48W3WfG3ySga1UtrWYqryaqry3Zr17KrWDWFya
	gr1UCF1Uua1qkw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U2oGdUUUUU=
Sender: liuxiang_1999@126.com
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/xtbBoBc66moGw7cxvgAA3w
X-Rspamd-Queue-Id: 0105654A4AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[zlingsmart.com];
	TAGGED_FROM(0.00)[bounces-288199-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

During system resume, stmmac_resume() calls stmmac_mdio_reset().
This results in repeated calls to devm_gpiod_get_optional() for the same
GPIO. The second invocation returns an error since the GPIO descriptor has
already been obtained.

Fixes: 7c86f20d15b7c113 ("net: stmmac: use GPIO descriptors in stmmac_mdio_reset")
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 22 ++++++++++---------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 8ba8f03e1..afec9c3a2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -383,6 +383,8 @@ struct stmmac_priv {
 	struct bpf_prog *xdp_prog;
 
 	struct devlink *devlink;
+
+	struct gpio_desc *reset_gpio;
 };
 
 enum stmmac_state {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index afe98ff5b..26f7d0611 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -385,28 +385,22 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 	unsigned int mii_address = priv->hw->mii.addr;
 
 #ifdef CONFIG_OF
-	if (priv->device->of_node) {
-		struct gpio_desc *reset_gpio;
+	if (priv->device->of_node && priv->reset_gpio) {
 		u32 delays[3] = { 0, 0, 0 };
 
-		reset_gpio = devm_gpiod_get_optional(priv->device,
-						     "snps,reset",
-						     GPIOD_OUT_LOW);
-		if (IS_ERR(reset_gpio))
-			return PTR_ERR(reset_gpio);
-
 		device_property_read_u32_array(priv->device,
 					       "snps,reset-delays-us",
 					       delays, ARRAY_SIZE(delays));
 
+		gpiod_set_value_cansleep(priv->reset_gpio, 0);
 		if (delays[0])
 			msleep(DIV_ROUND_UP(delays[0], 1000));
 
-		gpiod_set_value_cansleep(reset_gpio, 1);
+		gpiod_set_value_cansleep(priv->reset_gpio, 1);
 		if (delays[1])
 			msleep(DIV_ROUND_UP(delays[1], 1000));
 
-		gpiod_set_value_cansleep(reset_gpio, 0);
+		gpiod_set_value_cansleep(priv->reset_gpio, 0);
 		if (delays[2])
 			msleep(DIV_ROUND_UP(delays[2], 1000));
 	}
@@ -666,6 +660,14 @@ int stmmac_mdio_register(struct net_device *ndev)
 	if (priv->plat->core_type == DWMAC_CORE_XGMAC)
 		stmmac_xgmac2_mdio_read_c45(new_bus, 0, 0, 0);
 
+	priv->reset_gpio = devm_gpiod_get_optional(priv->device,
+						   "snps,reset",
+						   GPIOD_ASIS);
+	if (IS_ERR(priv->reset_gpio)) {
+		priv->reset_gpio = NULL;
+		dev_warn(dev, "No reset GPIO found\n");
+	}
+
 	/* If fixed-link is set, skip PHY scanning */
 	fwnode = dev_fwnode(priv->device);
 	if (fwnode) {
-- 
2.34.1


