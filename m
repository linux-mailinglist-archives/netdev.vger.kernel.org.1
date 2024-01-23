Return-Path: <netdev+bounces-65235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D652D839B58
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36584B25804
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300D64E1CB;
	Tue, 23 Jan 2024 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSvR9HsF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E893D3A7
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046314; cv=none; b=rx9raqHOt7ilJE1OkkJUpkpF/W8mITPjeoYOzlSruWiS/wL79o03gZp+53tDT3/UD7tPGOtF3VFZrkToKutHZN0WDnmtDYrO1bgVTHCf8qI1YFKAvMoigR0ZFxKU/r08XwjIlq56dXwSExarspwjaTU7ia93DhpN4l4manPwdd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046314; c=relaxed/simple;
	bh=MqEmtnzVL6rRdFNLH4nFRtPUxGWmQx4poxAzzED5uyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAdk5jdBGNjbYrH23IqPLEZLNgRQ/CILfhUxMDyQ+ZH4iMe+NmtDV2ZLe7HM9vBKCvpc1aQMUvViNgdR1MDVSR0FboVVx0h9FKRPC64nKU7KcJb19LWCfqVTxTVlUHn16fgZZKY+BrIe7FtrNZoMskTACHG5SYQRq+/bQON6HIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSvR9HsF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d7232dcb3eso21854025ad.2
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046311; x=1706651111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPKwFAPd5SH+8GvsG8BVZVczl3fT+affPAFyaag5CQ0=;
        b=VSvR9HsFPkm0UwqJbVvsbAbSDcLCfmb2uKXQe1EJesN7UYQmdNcQfJaXXOc4NfgzEF
         r9w4UAuh6ewv9Dz5Eu0NnHU38xMYM8LBXk606zHOTzDeQNaMmw0ALzaj/k3M4lQTWsC5
         fisyR41S2QmLwWjhiXYA928tk1rxYhhqCVl+wZgiMQmakshctjtI4it+xxXdTJK1q1ku
         93wp+HdHs/SW8FGRccOI5SnIxY6bsgEVTWL+/XPOBOz0LCXQ0WPY6DhtXBwyfcdoMou9
         7nP+uqpzKqAcCebvE6S5tNNt704xCIly9vnS45beX9W+DFo9stVhbKtnRGj0CuP5Q4rC
         99pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046311; x=1706651111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPKwFAPd5SH+8GvsG8BVZVczl3fT+affPAFyaag5CQ0=;
        b=reQmZa40m8CONDwE46HND7yxzmsOzGSbz5zu1xzIEcvVyWWRTx/YelrZp3Ep/4SJ8f
         38z3KxY8VJECmL1gG1g4n8UWPH5HPmwHsrx8oWHSeNc5Ng7fQnmBXXRwIUEeUIZ0mHJQ
         AIjLfYwG5aJj50s76QLAmEO1RPD+yoL8ZGjJZvTQgFZypeVrVV7XW07Jt4pfVYbUXA5V
         ZguyZoJfnuh68vJOw88BEk9S98eNfYRNK1Wipb86Z1BEAO8Sduf93GMELAnHL2zAAuV1
         jDiRGq2jV615xgM2pByWTTVBT8vKXS51PN8HH23UAWKD+Z/NGQ+FX44SxpJrvDOzKcuZ
         bFPQ==
X-Gm-Message-State: AOJu0YxH8a44O46yaF+Fyq6zuyRTP3fs+pTGeUCQaCu141gihBRNtuMo
	YvazSnn9/RDoG1lZPHk2s6nvuV2LAUBGcoLpoYXHoNcxbMG9fFcGmj+uzhUfrq8=
X-Google-Smtp-Source: AGHT+IF4n0x5tXyB6PnAT0yRUoT91mHtaME6v7tTlMpk4Nit9rqmyHhRuNMpRWlRbGfiOU31SOkuZQ==
X-Received: by 2002:a17:902:e5cd:b0:1d4:a179:e68b with SMTP id u13-20020a170902e5cd00b001d4a179e68bmr4940133plf.19.1706046310924;
        Tue, 23 Jan 2024 13:45:10 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001d714a1530bsm8108858plz.176.2024.01.23.13.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:45:10 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com,
	ansuelsmth@gmail.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH 10/11] net: dsa: realtek: use the same mii bus driver for both interfaces
Date: Tue, 23 Jan 2024 18:44:18 -0300
Message-ID: <20240123214420.25716-11-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123214420.25716-1-luizluca@gmail.com>
References: <20240123214420.25716-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The realtek-mdio will now use this driver instead of the generic DSA
driver ("dsa user smi"), which should not be used with OF[1].

With a single ds_ops for both interfaces, the ds_ops in realtek_priv is
no longer necessary. Now, the realtek_variant.ds_ops can be used
directly.

The realtek_priv.setup_interface() has been removed as we can directly
call the new common function.

[1] https://lkml.kernel.org/netdev/20220630200423.tieprdu5fpabflj7@bang-olufsen.dk/T/

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-mdio.c |  1 -
 drivers/net/dsa/realtek/realtek-smi.c  |  2 -
 drivers/net/dsa/realtek/realtek.h      |  5 +--
 drivers/net/dsa/realtek/rtl8365mb.c    | 49 +++---------------------
 drivers/net/dsa/realtek/rtl8366rb.c    | 52 +++-----------------------
 drivers/net/dsa/realtek/rtl83xx.c      |  2 +-
 6 files changed, 14 insertions(+), 97 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index c75b4550802c..6415408c337d 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -132,7 +132,6 @@ int realtek_mdio_probe(struct mdio_device *mdiodev)
 	priv->bus = mdiodev->bus;
 	priv->mdio_addr = mdiodev->addr;
 	priv->write_reg_noack = realtek_mdio_write;
-	priv->ds_ops = priv->variant->ds_ops_mdio;
 
 	ret = rtl83xx_register_switch(priv);
 	if (ret)
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 70f3967e56e8..b9523ebc7413 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -349,8 +349,6 @@ int realtek_smi_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->mdio);
 
 	priv->write_reg_noack = realtek_smi_write_reg_noack;
-	priv->setup_interface = rtl83xx_setup_user_mdio;
-	priv->ds_ops = priv->variant->ds_ops_smi;
 
 	ret = rtl83xx_register_switch(priv);
 	if (ret)
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index fbd0616c1df3..7af6dcc1bb24 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -60,7 +60,6 @@ struct realtek_priv {
 
 	spinlock_t		lock; /* Locks around command writes */
 	struct dsa_switch	*ds;
-	const struct dsa_switch_ops *ds_ops;
 	struct irq_domain	*irqdomain;
 	bool			leds_disabled;
 
@@ -71,7 +70,6 @@ struct realtek_priv {
 	struct rtl8366_mib_counter *mib_counters;
 
 	const struct realtek_ops *ops;
-	int			(*setup_interface)(struct dsa_switch *ds);
 	int			(*write_reg_noack)(void *ctx, u32 addr, u32 data);
 
 	int			vlan_enabled;
@@ -115,8 +113,7 @@ struct realtek_ops {
 };
 
 struct realtek_variant {
-	const struct dsa_switch_ops *ds_ops_smi;
-	const struct dsa_switch_ops *ds_ops_mdio;
+	const struct dsa_switch_ops *ds_ops;
 	const struct realtek_ops *ops;
 	unsigned int clk_delay;
 	u8 cmd_read;
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 97a41ba73718..d7d3ae4746f6 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -828,17 +828,6 @@ static int rtl8365mb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	return 0;
 }
 
-static int rtl8365mb_dsa_phy_read(struct dsa_switch *ds, int phy, int regnum)
-{
-	return rtl8365mb_phy_read(ds->priv, phy, regnum);
-}
-
-static int rtl8365mb_dsa_phy_write(struct dsa_switch *ds, int phy, int regnum,
-				   u16 val)
-{
-	return rtl8365mb_phy_write(ds->priv, phy, regnum, val);
-}
-
 static const struct rtl8365mb_extint *
 rtl8365mb_get_port_extint(struct realtek_priv *priv, int port)
 {
@@ -2017,12 +2006,10 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	if (ret)
 		goto out_teardown_irq;
 
-	if (priv->setup_interface) {
-		ret = priv->setup_interface(ds);
-		if (ret) {
-			dev_err(priv->dev, "could not set up MDIO bus\n");
-			goto out_teardown_irq;
-		}
+	ret = rtl83xx_setup_user_mdio(ds);
+	if (ret) {
+		dev_err(priv->dev, "could not set up MDIO bus\n");
+		goto out_teardown_irq;
 	}
 
 	/* Start statistics counter polling */
@@ -2116,28 +2103,7 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 	return 0;
 }
 
-static const struct dsa_switch_ops rtl8365mb_switch_ops_smi = {
-	.get_tag_protocol = rtl8365mb_get_tag_protocol,
-	.change_tag_protocol = rtl8365mb_change_tag_protocol,
-	.setup = rtl8365mb_setup,
-	.teardown = rtl8365mb_teardown,
-	.phylink_get_caps = rtl8365mb_phylink_get_caps,
-	.phylink_mac_config = rtl8365mb_phylink_mac_config,
-	.phylink_mac_link_down = rtl8365mb_phylink_mac_link_down,
-	.phylink_mac_link_up = rtl8365mb_phylink_mac_link_up,
-	.port_stp_state_set = rtl8365mb_port_stp_state_set,
-	.get_strings = rtl8365mb_get_strings,
-	.get_ethtool_stats = rtl8365mb_get_ethtool_stats,
-	.get_sset_count = rtl8365mb_get_sset_count,
-	.get_eth_phy_stats = rtl8365mb_get_phy_stats,
-	.get_eth_mac_stats = rtl8365mb_get_mac_stats,
-	.get_eth_ctrl_stats = rtl8365mb_get_ctrl_stats,
-	.get_stats64 = rtl8365mb_get_stats64,
-	.port_change_mtu = rtl8365mb_port_change_mtu,
-	.port_max_mtu = rtl8365mb_port_max_mtu,
-};
-
-static const struct dsa_switch_ops rtl8365mb_switch_ops_mdio = {
+static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.get_tag_protocol = rtl8365mb_get_tag_protocol,
 	.change_tag_protocol = rtl8365mb_change_tag_protocol,
 	.setup = rtl8365mb_setup,
@@ -2146,8 +2112,6 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops_mdio = {
 	.phylink_mac_config = rtl8365mb_phylink_mac_config,
 	.phylink_mac_link_down = rtl8365mb_phylink_mac_link_down,
 	.phylink_mac_link_up = rtl8365mb_phylink_mac_link_up,
-	.phy_read = rtl8365mb_dsa_phy_read,
-	.phy_write = rtl8365mb_dsa_phy_write,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.get_strings = rtl8365mb_get_strings,
 	.get_ethtool_stats = rtl8365mb_get_ethtool_stats,
@@ -2167,8 +2131,7 @@ static const struct realtek_ops rtl8365mb_ops = {
 };
 
 const struct realtek_variant rtl8365mb_variant = {
-	.ds_ops_smi = &rtl8365mb_switch_ops_smi,
-	.ds_ops_mdio = &rtl8365mb_switch_ops_mdio,
+	.ds_ops = &rtl8365mb_switch_ops,
 	.ops = &rtl8365mb_ops,
 	.clk_delay = 10,
 	.cmd_read = 0xb9,
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index ec7a55d70bad..5084ad151f0f 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1033,12 +1033,10 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 	if (ret)
 		dev_info(priv->dev, "no interrupt support\n");
 
-	if (priv->setup_interface) {
-		ret = priv->setup_interface(ds);
-		if (ret) {
-			dev_err(priv->dev, "could not set up MDIO bus\n");
-			return -ENODEV;
-		}
+	ret = rtl83xx_setup_user_mdio(ds);
+	if (ret) {
+		dev_err(priv->dev, "could not set up MDIO bus\n");
+		return -ENODEV;
 	}
 
 	return 0;
@@ -1785,17 +1783,6 @@ static int rtl8366rb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	return ret;
 }
 
-static int rtl8366rb_dsa_phy_read(struct dsa_switch *ds, int phy, int regnum)
-{
-	return rtl8366rb_phy_read(ds->priv, phy, regnum);
-}
-
-static int rtl8366rb_dsa_phy_write(struct dsa_switch *ds, int phy, int regnum,
-				   u16 val)
-{
-	return rtl8366rb_phy_write(ds->priv, phy, regnum, val);
-}
-
 static int rtl8366rb_reset_chip(struct realtek_priv *priv)
 {
 	int timeout = 10;
@@ -1861,35 +1848,9 @@ static int rtl8366rb_detect(struct realtek_priv *priv)
 	return 0;
 }
 
-static const struct dsa_switch_ops rtl8366rb_switch_ops_smi = {
-	.get_tag_protocol = rtl8366_get_tag_protocol,
-	.setup = rtl8366rb_setup,
-	.phylink_get_caps = rtl8366rb_phylink_get_caps,
-	.phylink_mac_link_up = rtl8366rb_mac_link_up,
-	.phylink_mac_link_down = rtl8366rb_mac_link_down,
-	.get_strings = rtl8366_get_strings,
-	.get_ethtool_stats = rtl8366_get_ethtool_stats,
-	.get_sset_count = rtl8366_get_sset_count,
-	.port_bridge_join = rtl8366rb_port_bridge_join,
-	.port_bridge_leave = rtl8366rb_port_bridge_leave,
-	.port_vlan_filtering = rtl8366rb_vlan_filtering,
-	.port_vlan_add = rtl8366_vlan_add,
-	.port_vlan_del = rtl8366_vlan_del,
-	.port_enable = rtl8366rb_port_enable,
-	.port_disable = rtl8366rb_port_disable,
-	.port_pre_bridge_flags = rtl8366rb_port_pre_bridge_flags,
-	.port_bridge_flags = rtl8366rb_port_bridge_flags,
-	.port_stp_state_set = rtl8366rb_port_stp_state_set,
-	.port_fast_age = rtl8366rb_port_fast_age,
-	.port_change_mtu = rtl8366rb_change_mtu,
-	.port_max_mtu = rtl8366rb_max_mtu,
-};
-
-static const struct dsa_switch_ops rtl8366rb_switch_ops_mdio = {
+static const struct dsa_switch_ops rtl8366rb_switch_ops = {
 	.get_tag_protocol = rtl8366_get_tag_protocol,
 	.setup = rtl8366rb_setup,
-	.phy_read = rtl8366rb_dsa_phy_read,
-	.phy_write = rtl8366rb_dsa_phy_write,
 	.phylink_get_caps = rtl8366rb_phylink_get_caps,
 	.phylink_mac_link_up = rtl8366rb_mac_link_up,
 	.phylink_mac_link_down = rtl8366rb_mac_link_down,
@@ -1928,8 +1889,7 @@ static const struct realtek_ops rtl8366rb_ops = {
 };
 
 const struct realtek_variant rtl8366rb_variant = {
-	.ds_ops_smi = &rtl8366rb_switch_ops_smi,
-	.ds_ops_mdio = &rtl8366rb_switch_ops_mdio,
+	.ds_ops = &rtl8366rb_switch_ops,
 	.ops = &rtl8366rb_ops,
 	.clk_delay = 10,
 	.cmd_read = 0xa9,
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 525d8c014136..2f39472a44d2 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -229,7 +229,7 @@ int rtl83xx_register_switch(struct realtek_priv *priv)
 
 	priv->ds->priv = priv;
 	priv->ds->dev = priv->dev;
-	priv->ds->ops = priv->ds_ops;
+	priv->ds->ops = priv->variant->ds_ops;
 	priv->ds->num_ports = priv->num_ports;
 
 	ret = dsa_register_switch(priv->ds);
-- 
2.43.0


