Return-Path: <netdev+bounces-218893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21071B3EF82
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3021A87989
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BB427E1C6;
	Mon,  1 Sep 2025 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/FFlf5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A98A26E70E;
	Mon,  1 Sep 2025 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758016; cv=none; b=DoXz2in9CHof5IY99nZF5dFhVX3TH8qdBUw9BZY5utBepY8j84ZrGSKna8avZU3988vkQSfVnUxIuIa646ucwS9eMELQ69wMDgAjiNvfs4F5bS1iSFREuyyiHbwX/7Zb0yAcA+ZpFBhgq1gWZWUvtn3UCAef9Wp1FFjM6NnaklA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758016; c=relaxed/simple;
	bh=uEg15OibvvWYTNHSOey/Ib5tVfECjgYt6Y6y/EwMQPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCo04qX7QWM4rp1t9z7MFbMeGs29twf3HnH4QQ8zpR910fsd6l1tH7wL75B5ErH1D823jUYXIBkcRunbyiFghJtkAFgh2l8/kCLTCjty+/YXnEC4QLMYCb5BF1Qkoxu7kdMM7mvoT6z5pLjOjeu5a6kce2SeCI1QNyES5VAfidw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/FFlf5Z; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77250e45d36so1182031b3a.0;
        Mon, 01 Sep 2025 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756758013; x=1757362813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFXwRwPxCKeJGOhkMF7DyDw5Gt2GrTpsqldARicJoTk=;
        b=Y/FFlf5Z+wb4p3C74MxjyBXJwDYWHnM0Gpj+qEqVZrTZ/ixX4e86V7uYYn91o/xu5g
         khlttoEO2+pGZFv0L+Ckf88g1RCTPJNktirzfMzOHM/2S/4jNMpBWhCg23SMCCyFMqFo
         LuihTV984t3PO477cU06ATD3o6N3GlJCnaYrd372ALth4++hpH05CrTsjnfY/JUBxuG5
         6fMDtzWeOtWH9wdHQrxnxndWV7/LfMjUzPbRMnYT6DCZHi5SsV6V9MxENKcF65j6rysE
         OTlckaYmZCai5mgQc80WtAvHrjSrIkslCXur9T3JUGrN2y2435Jtw1zdaob3zCOqBLnM
         On5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756758013; x=1757362813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFXwRwPxCKeJGOhkMF7DyDw5Gt2GrTpsqldARicJoTk=;
        b=JNZ7/2S85pSUTQR4vAxxcgG5fRSHZLtulG1k/G+W+kQ1y1jHRby9lpvhOkeyvKTh3z
         soOkRM5KjdA4Skhl5VOZo5q2ixEuTyDiMoo4pHgB/HigY0rkXxp/DzLPgeZLUBt4xaAo
         M8LQ2c9LxI6On9+rz8rbHmoOWnCzln0+T87/5kPpMoEAQfAQXOTZkd0phb5VEdicKNkc
         l+O0athVJKSuuREBWXTIREakibXwS8bfVhVnihcdSoIPYpVtjf6/VOTbAJIvBxNKoe0U
         rxaEgth52TZ6+T4ZwMEyChPIavpUsnRIsQJWqTRMV+C5TvSa2KY3R+LbTU5qaU2Rhscj
         JMzw==
X-Forwarded-Encrypted: i=1; AJvYcCWL2eOCaYtaPXSqxf3Z0NwZNfb8RUF4JfbZ9c73sYhD5szUQkMT+iW1mrSip3RdJdd4/4dzE6vw3JM7gpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8kW6aH3HrT1zAWP3ixV+tRvOOBn5G1ZSKFjtvKdsRcZRjxPUl
	OeLkLPxxQBrrFFIyxmdrWWBbPM6ETQukzC8P4Mrj8xYm9KDLvlxcbK9f5r2tig==
X-Gm-Gg: ASbGnctaJ6c4qNikWUCZmU1a+xAjWMHT1cXe9p4Ds2dBgDspjvOGHpQteT0+9rwHlRv
	uuPlHTwUMYCdfivnQ7fHo8ksQRDxmAE+e/G/IMPOl9HhsjtbpJyQU7/Avna4pbhp4bjr4jq9rjO
	CEYUCA0NB+EPrmrxSkCOrCggWFGXYsaX4/keuefZvSNUC//ABsadbe22YCuxD0z/GJbLGX6F1LU
	uYVGE02/7TIDGSg+AKGYveFFPi8gSpt8jmAhOMMYQfbu+ngvCnUPVjSfXpTz59kRv8M9xTQby68
	VbPb6ZI3ayM+5Dd8P4iaCRl+WTSX5sUCklkLUWBIzA+TWzp+R4DV7Gq3OIbTEwxqtczeeFxloyg
	mF2llo5xoCreDrKH2USZSt21HAbjnxCRp1KQxe2BBqAVpsDdO79dqmWi0Dpho
X-Google-Smtp-Source: AGHT+IEs66TrW9+nVCTr2EnWHb+auIr/jJFi81Q/FnfoXfN9IbkWLLcEQy8N3XeeZA0Ddp2w4LDACg==
X-Received: by 2002:a05:6a20:7349:b0:243:c36f:6a71 with SMTP id adf61e73a8af0-243d6e07ac3mr12170485637.21.1756758013344;
        Mon, 01 Sep 2025 13:20:13 -0700 (PDT)
Received: from archlinux ([2601:644:8200:acc7::9ec])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd007026esm10118256a12.9.2025.09.01.13.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:20:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com (maintainer:MICROCHIP LAN966X ETHERNET DRIVER),
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk> (maintainer:SFF/SFP/SFP+ MODULE SUPPORT:Keyword:phylink\.h|struct\s+phylink|\.phylink|>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next 2/2] net: lan966x: convert fwnode to of
Date: Mon,  1 Sep 2025 13:20:01 -0700
Message-ID: <20250901202001.27024-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901202001.27024-1-rosenp@gmail.com>
References: <20250901202001.27024-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a purely OF driver. There's no need for fwnode to handle any of
this, with the exception being phylik_create. Use of_fwnode_handle for
that.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../ethernet/microchip/lan966x/lan966x_main.c | 34 ++++++++++---------
 .../ethernet/microchip/lan966x/lan966x_main.h |  2 +-
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 8bf28915c030..98937830e74b 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -183,7 +183,7 @@ static int lan966x_port_open(struct net_device *dev)
 		ANA_PORT_CFG_PORTID_VAL,
 		lan966x, ANA_PORT_CFG(port->chip_port));
 
-	err = phylink_fwnode_phy_connect(port->phylink, port->fwnode, 0);
+	err = phylink_of_phy_connect(port->phylink, port->dnode, 0);
 	if (err) {
 		netdev_err(dev, "Could not attach to PHY\n");
 		return err;
@@ -767,8 +767,8 @@ static void lan966x_cleanup_ports(struct lan966x *lan966x)
 			port->phylink = NULL;
 		}
 
-		if (port->fwnode)
-			fwnode_handle_put(port->fwnode);
+		if (port->dnode)
+			of_node_put(port->dnode);
 	}
 
 	disable_irq(lan966x->xtr_irq);
@@ -791,7 +791,7 @@ static void lan966x_cleanup_ports(struct lan966x *lan966x)
 
 static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
 			      phy_interface_t phy_mode,
-			      struct fwnode_handle *portnp)
+			      struct device_node *portnp)
 {
 	struct lan966x_port *port;
 	struct phylink *phylink;
@@ -855,7 +855,7 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
 		  port->phylink_config.supported_interfaces);
 
 	phylink = phylink_create(&port->phylink_config,
-				 portnp,
+				 of_fwnode_handle(portnp),
 				 phy_mode,
 				 &lan966x_phylink_mac_ops);
 	if (IS_ERR(phylink)) {
@@ -1081,7 +1081,7 @@ static int lan966x_reset_switch(struct lan966x *lan966x)
 
 static int lan966x_probe(struct platform_device *pdev)
 {
-	struct fwnode_handle *ports, *portnp;
+	struct device_node *ports, *portnp;
 	struct lan966x *lan966x;
 	int err;
 
@@ -1179,7 +1179,7 @@ static int lan966x_probe(struct platform_device *pdev)
 		}
 	}
 
-	ports = device_get_named_child_node(&pdev->dev, "ethernet-ports");
+	ports = of_get_child_by_name(pdev->dev.of_node, "ethernet-ports");
 	if (!ports)
 		return dev_err_probe(&pdev->dev, -ENODEV,
 				     "no ethernet-ports child found\n");
@@ -1191,25 +1191,27 @@ static int lan966x_probe(struct platform_device *pdev)
 	lan966x_stats_init(lan966x);
 
 	/* go over the child nodes */
-	fwnode_for_each_available_child_node(ports, portnp) {
+	for_each_available_child_of_node(ports, portnp) {
 		phy_interface_t phy_mode;
 		struct phy *serdes;
 		u32 p;
 
-		if (fwnode_property_read_u32(portnp, "reg", &p))
+		if (of_property_read_u32(portnp, "reg", &p))
 			continue;
 
-		phy_mode = fwnode_get_phy_mode(portnp);
+		err = of_get_phy_mode(portnp, &phy_mode);
+		if (err)
+			goto cleanup_ports;
+
 		err = lan966x_probe_port(lan966x, p, phy_mode, portnp);
 		if (err)
 			goto cleanup_ports;
 
 		/* Read needed configuration */
 		lan966x->ports[p]->config.portmode = phy_mode;
-		lan966x->ports[p]->fwnode = fwnode_handle_get(portnp);
+		lan966x->ports[p]->dnode = of_node_get(portnp);
 
-		serdes = devm_of_phy_optional_get(lan966x->dev,
-						  to_of_node(portnp), NULL);
+		serdes = devm_of_phy_optional_get(lan966x->dev, portnp, NULL);
 		if (IS_ERR(serdes)) {
 			err = PTR_ERR(serdes);
 			goto cleanup_ports;
@@ -1222,7 +1224,7 @@ static int lan966x_probe(struct platform_device *pdev)
 			goto cleanup_ports;
 	}
 
-	fwnode_handle_put(ports);
+	of_node_put(ports);
 
 	lan966x_mdb_init(lan966x);
 	err = lan966x_fdb_init(lan966x);
@@ -1255,8 +1257,8 @@ static int lan966x_probe(struct platform_device *pdev)
 	lan966x_fdb_deinit(lan966x);
 
 cleanup_ports:
-	fwnode_handle_put(ports);
-	fwnode_handle_put(portnp);
+	of_node_put(ports);
+	of_node_put(portnp);
 
 	lan966x_cleanup_ports(lan966x);
 
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 4f75f0688369..bafb8f5ee64d 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -407,7 +407,7 @@ struct lan966x_port {
 	struct lan966x_port_config config;
 	struct phylink *phylink;
 	struct phy *serdes;
-	struct fwnode_handle *fwnode;
+	struct device_node *dnode;
 
 	u8 ptp_tx_cmd;
 	bool ptp_rx_cmd;
-- 
2.51.0


