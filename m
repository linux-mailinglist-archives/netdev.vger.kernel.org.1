Return-Path: <netdev+bounces-217449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD30B38BAB
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 23:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00CE67B49C7
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8FF30F7E7;
	Wed, 27 Aug 2025 21:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxdfYA/s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4059A30E0FA;
	Wed, 27 Aug 2025 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331448; cv=none; b=TxEx/xSKt1TNE8GrohuwHvUTJuxKhFN7pDUIbiek1jrWLXGlvXH+kME0UdKlBI5VaPiHogc7XbiNiI4MFRZtu+sYhKUHT7px/8mgJk9JWkOH4nTMRAF9QNnWeoAXWytOo5otZXAhgoWTBW0p/IkQeE5lRTNvZgOrTuEi0aE9H/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331448; c=relaxed/simple;
	bh=BuujTLAWedRDy5YEAJ0tpz38DoweFsg1ZztFXHJET6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRMLkDWjCCXvH29JdA7TsmKnGoNcFDHZnzkQhcdti74JG2WqdWnHUlHUGA+0fkqp5DQfi1IZyppfzkm1ua1eN1ew3vSkcWP6qcijmd0EIMolxo0kawvdDVIm2KCXMWmnzr+qwpGo3y4tzuZEsh+6eYLAIlzpGs8neNKxQ7JTj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxdfYA/s; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-246151aefaaso11881515ad.1;
        Wed, 27 Aug 2025 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756331446; x=1756936246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UozAhkcUiSjKYUMUoDcNOQ4O68AAuW0dIDQ3a9gM49k=;
        b=kxdfYA/swpmYaQ/XETjCeuISTPEeor5DbFpzegA0X/QEKJzay4To6tRagh1tEFKd14
         52NsCNG0Qi4IsJEy7jOAm8/FMIHmY8LUULFxeEeNowWq5ddfROeuVQwurUflVdfUUUBC
         7P89IspOGoP/0zyAbL0QgEFh7Z3yPwyWoJQSooOwRcqb/jVWvNZX1MSw1Dss7UJ+QciZ
         3Xiw8OsV4hwp5qHuPvGnA9tq0k2lhaLiw9dJV6V6ES/RNgoj/iawsR8B5Fbj/mo5I++x
         795E2gYmYxDOi2BDxN/TN69FdCYW7pFPr11KQ4duidTbbuw79WIhXTm+RnL5c8kFUjfQ
         YjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756331446; x=1756936246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UozAhkcUiSjKYUMUoDcNOQ4O68AAuW0dIDQ3a9gM49k=;
        b=KfGtSwGi1omuXptliB1KEpuy7diQkZMH+6h+hKTyyu6e8ox29Ki48P6tVIxSOQ2iiS
         vz82rRBb0lQZTY30KBc264AxqG8hD1OzVq0IySfY4iFyeig29lFZU2VvTbSAQ14tUV4Y
         NV+726vdbGamD0H9sXUQdjFTQMGEtQjOJvwK1o3u34t4lTcDCZrLmZ70HppyLOq6mfMz
         6ensAxxP3cIyQqmTjYT8aQaU7J0+mnAxP1EVffFZoEvd2lQdz1l0MZpht5OyCZrTXFKc
         evSbsPRBP7Bk/8p+mKaLnChesdUNNz8eC53wgt+IV5Dl61ajIefhkQSYiNZZ+kC2utXF
         g1DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqbWkWDURSeTb/gnGy2SA4Rcu4qW8rCG6C6f7xhPwQLUch8nDyyfuyyZ9ra6XA1w7w6/cGb9bk0rN+B98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcw6WFwIw+5uCvMWiNmAanhibeBUmyuD6PC05gGPeY+ErTI9U0
	SB8YejLz1xevaA4s0mj3MNAelp9QG1s74amZxYvdW0/j1Q1PsYmhqiopFD4WPNFb
X-Gm-Gg: ASbGncugYluJ2uN3KtVtize5sih7NDUgJmASSjGmzvscMwLle8UCqN2jhPeKy6mAfT1
	Q+hKzE99VqBeIWgjBG4NyLc02uxRpMAxiD0tgVUDVg6oSpmB8MX1tQCyFZwYHDmbnGj3r7mmiSF
	AE5XclHPzlof+N+xwrJ35x6ICz3vQjMOYPTdk0128LZwFe+EL8ajDUE+/s8ffBoisTcSg3V1o13
	cLUNyC3fuW1Y0dk1zd/LppXb8rtLkAqq8lBlB4fpPZoLJxpBfpuOHVHePzBpqA1E2jKc0OHjRNZ
	WxW/hIBd3uQ8Uhe3xdQYTdsRgKZY31XouGdVpNMgpDsiu6dwYzGsD5qCkImpLg5ENIiVDUtmorE
	C2USmdc9VgA57Rb8CgONxYAjhl600N2ef+3gLMdJS+0Pm+Di2Oad5FrP+q3ehrDs7UQ==
X-Google-Smtp-Source: AGHT+IGnTAMKIVfAwB2LXmoA547rKUXRuIiaxwK76d1wWSo2cP6MFhn1mVcVqwUXH36PVIHv0Xp+5A==
X-Received: by 2002:a17:902:e5cc:b0:246:d5b3:6310 with SMTP id d9443c01a7336-2487539f6b8mr76316115ad.23.1756331446269;
        Wed, 27 Aug 2025 14:50:46 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248cd2cd5desm6430765ad.147.2025.08.27.14.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 14:50:45 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] net: lan966x: convert fwnode to of
Date: Wed, 27 Aug 2025 14:50:42 -0700
Message-ID: <20250827215042.79843-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827215042.79843-1-rosenp@gmail.com>
References: <20250827215042.79843-1-rosenp@gmail.com>
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
 .../ethernet/microchip/lan966x/lan966x_main.c | 32 ++++++++++---------
 .../ethernet/microchip/lan966x/lan966x_main.h |  2 +-
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 8bf28915c030..d778806dcfc6 100644
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
-		err = lan966x_probe_port(lan966x, p, phy_mode, portnp);
+		err = of_get_phy_mode(portnp, &phy_mode);
+		if (err)
+			goto cleanup_ports;
+
+		err = lan966x_probe_port(lan966x, p, phy_mode, of_fwnode_handle(portnp));
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


