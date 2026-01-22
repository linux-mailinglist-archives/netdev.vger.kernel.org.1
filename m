Return-Path: <netdev+bounces-252459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIrxNR9gcmnbjAAAu9opvQ
	(envelope-from <netdev+bounces-252459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:36:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 800B66B742
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AE07303C272
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F9B3DBC0A;
	Thu, 22 Jan 2026 16:39:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680627934B;
	Thu, 22 Jan 2026 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099986; cv=none; b=aO1pFQ7Zl2c7pO9u4Jyz283KwUP1Z0KTF1aElhI2mx2W/QEopZN+JHT921Mx4sq067FxyFbKIXQKoeXmGPQmdwA2bF1/gSAdmhJZgJPNi25t95uFxRU0w/J8sIwj9P7eQaEWahJuA3sShwmXf/0hAAfMocS8/8TtdBNneDTBTX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099986; c=relaxed/simple;
	bh=9/wOEAP9Z70YlA94ausVaW4pw/bf8VxiowP0V8TIO9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrD8TFIbgIxOjVTpadf0UYZI6WzuhO8yPpFa0fZh/F2Sp/eawtaIjyeIJuy1IBeceJ4jHorZHS9hSQU553AnkTxHFUIhv8OHTyKX4AMv4HDYkpxnt2z4H0UAm5dmlHo25gWC042CaZJKPBqdJMSXTBZBGD9cHikfyDaPG4+WjVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vixiX-000000001S0-0svo;
	Thu, 22 Jan 2026 16:39:33 +0000
Date: Thu, 22 Jan 2026 16:39:30 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chen Minqiang <ptpt52@gmail.com>, Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: [PATCH net-next v6 6/6] net: dsa: mxl-gsw1xx: add support for Intel
 GSW150
Message-ID: <c84cf94337bf1be30940841b338b6368468c6e17.1769099517.git.daniel@makrotopia.org>
References: <cover.1769099517.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769099517.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-252459-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[hauke-m.de,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,gl-inet.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid,makrotopia.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 800B66B742
X-Rspamd-Action: no action

Add support for the Intel GSW150 (aka. Lantiq PEB7084) switch IC to
the mxl-gsw1xx driver. This switch comes with 5 Gigabit Ethernet
copper ports (Intel XWAY PHY11G (xRX v1.2 integrated) PHYs) as well as
one GMII/RGMII and one RGMII port.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v6:
 * rebase on top of current net-next
 * update Kconfig to mention GSW150
 * allow configuring RGMII slewrate introduced by commit dbf24ab58fec3
   ("net: dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration")

v5: no changes

v4: spell out mii_cfg and mii_pcdu values in struct gswip_hw_info instead
    of using default initializer which requires diag exception

v3: enclose the gswip_hw_info initializers in compiler diag exception
    to prevent triggering -Woverride-init

v2: clean-up phylink_get_caps


 drivers/net/dsa/lantiq/Kconfig      |  4 +-
 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 67 ++++++++++++++++++++++++++---
 drivers/net/dsa/lantiq/mxl-gsw1xx.h |  2 +
 3 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/lantiq/Kconfig b/drivers/net/dsa/lantiq/Kconfig
index 4a9771be5d588..bad13817af257 100644
--- a/drivers/net/dsa/lantiq/Kconfig
+++ b/drivers/net/dsa/lantiq/Kconfig
@@ -16,9 +16,11 @@ config NET_DSA_MXL_GSW1XX
 	select NET_DSA_TAG_MXL_GSW1XX
 	select NET_DSA_LANTIQ_COMMON
 	help
-	  This enables support for the MaxLinear GSW1xx family of 1GE switches
+	  This enables support for the Intel/MaxLinear GSW1xx family of 1GE
+	  switches.
 	    GSW120 4 port, 2 PHYs, RGMII & SGMII/2500Base-X
 	    GSW125 4 port, 2 PHYs, RGMII & SGMII/2500Base-X, industrial temperature
 	    GSW140 6 port, 4 PHYs, RGMII & SGMII/2500Base-X
 	    GSW141 6 port, 4 PHYs, RGMII & SGMII
 	    GSW145 6 port, 4 PHYs, RGMII & SGMII/2500Base-X, industrial temperature
+	    GSW150 7 port, 5 PHYs, 1x GMII/RGMII, 1x RGMII
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index c6fa93229349a..79cf72cc77be9 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -502,6 +502,14 @@ static const struct phylink_pcs_ops gsw1xx_pcs_ops = {
 	.pcs_link_up = gsw1xx_pcs_link_up,
 };
 
+static void gsw1xx_phylink_get_lpi_caps(struct phylink_config *config)
+{
+	config->lpi_capabilities = MAC_100FD | MAC_1000FD;
+	config->lpi_timer_default = 20;
+	memcpy(config->lpi_interfaces, config->supported_interfaces,
+	       sizeof(config->lpi_interfaces));
+}
+
 static void gsw1xx_phylink_get_caps(struct dsa_switch *ds, int port,
 				    struct phylink_config *config)
 {
@@ -535,10 +543,32 @@ static void gsw1xx_phylink_get_caps(struct dsa_switch *ds, int port,
 		break;
 	}
 
-	config->lpi_capabilities = MAC_100FD | MAC_1000FD;
-	config->lpi_timer_default = 20;
-	memcpy(config->lpi_interfaces, config->supported_interfaces,
-	       sizeof(config->lpi_interfaces));
+	gsw1xx_phylink_get_lpi_caps(config);
+}
+
+static void gsw150_phylink_get_caps(struct dsa_switch *ds, int port,
+				    struct phylink_config *config)
+{
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+				   MAC_10 | MAC_100 | MAC_1000;
+
+	switch (port) {
+	case 0 ... 4: /* built-in PHYs */
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+		break;
+
+	case 5: /* GMII or RGMII */
+		__set_bit(PHY_INTERFACE_MODE_GMII,
+			  config->supported_interfaces);
+		fallthrough;
+
+	case 6: /* RGMII */
+		phy_interface_set_rgmii(config->supported_interfaces);
+		break;
+	}
+
+	gsw1xx_phylink_get_lpi_caps(config);
 }
 
 static struct phylink_pcs *gsw1xx_phylink_mac_select_pcs(struct phylink_config *config,
@@ -809,11 +839,38 @@ static const struct gswip_hw_info gsw141_data = {
 	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
 };
 
+static const struct gswip_hw_info gsw150_data = {
+	.max_ports		= GSW150_PORTS,
+	.allowed_cpu_ports	= BIT(5) | BIT(6),
+	.mii_cfg = {
+		[0 ... 4] = -1,
+		[5] = 0,
+		[6] = 10,
+	},
+	.mii_pcdu = {
+		[0 ... 4] = -1,
+		[5] = 1,
+		[6] = 11,
+	},
+	.phylink_get_caps	= gsw150_phylink_get_caps,
+	/* There is only a single RGMII_SLEW_CFG register in GSW150 and it is
+	 * unknown if RGMII slew configuration affects both RGMII ports
+	 * or only port 5. Use .port_setup which assumes it affects port 5
+	 * for now.
+	 */
+	.port_setup		= gsw1xx_port_setup,
+	.pce_microcode		= &gsw1xx_pce_microcode,
+	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
+	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
+};
+
 /*
  * GSW125 is the industrial temperature version of GSW120.
  * GSW145 is the industrial temperature version of GSW140.
  */
 static const struct of_device_id gsw1xx_of_match[] = {
+	{ .compatible = "intel,gsw150", .data = &gsw150_data },
+	{ .compatible = "lantiq,peb7084", .data = &gsw150_data },
 	{ .compatible = "maxlinear,gsw120", .data = &gsw12x_data },
 	{ .compatible = "maxlinear,gsw125", .data = &gsw12x_data },
 	{ .compatible = "maxlinear,gsw140", .data = &gsw140_data },
@@ -837,5 +894,5 @@ static struct mdio_driver gsw1xx_driver = {
 mdio_module_driver(gsw1xx_driver);
 
 MODULE_AUTHOR("Daniel Golle <daniel@makrotopia.org>");
-MODULE_DESCRIPTION("Driver for MaxLinear GSW1xx ethernet switch");
+MODULE_DESCRIPTION("Driver for Intel/MaxLinear GSW1xx Ethernet switch");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.h b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
index 8c0298b2b7663..d1fded56e9678 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.h
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
@@ -10,6 +10,8 @@
 #include <linux/bitfield.h>
 
 #define GSW1XX_PORTS				6
+#define GSW150_PORTS				7
+
 /* Port used for RGMII or optional RMII */
 #define GSW1XX_MII_PORT				5
 /* Port used for SGMII */
-- 
2.52.0

