Return-Path: <netdev+bounces-39051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0447BD8DE
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 12:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9962816CE
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 10:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725EF6FB9;
	Mon,  9 Oct 2023 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Wl+hBSrU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663C4156C3
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 10:39:55 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1BC99
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 03:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KqgME9D+HxzTp5py4nD+JswQeI2Q380RyHMOj6OCc3U=; b=Wl+hBSrU9StlCKyYQJ0Bsz8fUJ
	EUQiaqLk9FeSuupp2eTMl+lFJdfFFKDIKZy5JH8AjesEwWJXw2dlyZdYRFH3Yow2xxDefZItsOjmT
	2BECZw/2CaM87jRvuJOYA4VOp+6slH1x4I9zzAluGG9WkGXlQTeshNAqNRqzRYAcvFzeoe9wv62yi
	NxuqQGlSEpXJdVqrSNrBpmdWzRU1txhnRdHNr62CO8l3k8YYwimBohbdd5nIGNXbluakzWp39AWDX
	+av5rhNmLj/XBEi/JKbLpM7XRYXRvi3KmftyBrgtKL/fIfG15o/142/g2hf+94vgvX9P+T3LAFjgC
	CS0XBJ3g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54120 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qpnfx-0008MF-0H;
	Mon, 09 Oct 2023 11:39:49 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qpnfy-009Ncm-9D; Mon, 09 Oct 2023 11:39:50 +0100
In-Reply-To: <ZSPOV+GhEQkwhoz9@shell.armlinux.org.uk>
References: <ZSPOV+GhEQkwhoz9@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next 2/3] net: dsa: dsa_loop: add phylink capabilities
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qpnfy-009Ncm-9D@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 09 Oct 2023 11:39:50 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add phylink capabilities for dsa_loop, which I believe being a software
construct means that it supports essentially all interface types and
all speeds.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/dsa_loop.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
index 5b139f2206b6..c70ed67cc188 100644
--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -277,6 +277,14 @@ static int dsa_loop_port_max_mtu(struct dsa_switch *ds, int port)
 	return ETH_MAX_MTU;
 }
 
+static void dsa_loop_phylink_get_caps(struct dsa_switch *dsa, int port,
+				      struct phylink_config *config)
+{
+	bitmap_fill(config->supported_interfaces, PHY_INTERFACE_MODE_MAX);
+	__clear_bit(PHY_INTERFACE_MODE_NA, config->supported_interfaces);
+	config->mac_capabilities = ~0;
+}
+
 static const struct dsa_switch_ops dsa_loop_driver = {
 	.get_tag_protocol	= dsa_loop_get_protocol,
 	.setup			= dsa_loop_setup,
@@ -295,6 +303,7 @@ static const struct dsa_switch_ops dsa_loop_driver = {
 	.port_vlan_del		= dsa_loop_port_vlan_del,
 	.port_change_mtu	= dsa_loop_port_change_mtu,
 	.port_max_mtu		= dsa_loop_port_max_mtu,
+	.phylink_get_caps	= dsa_loop_phylink_get_caps,
 };
 
 static int dsa_loop_drv_probe(struct mdio_device *mdiodev)
-- 
2.30.2


