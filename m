Return-Path: <netdev+bounces-142512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2FB9BF62C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 20:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05771C21BC8
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A2220BB52;
	Wed,  6 Nov 2024 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z6iRigtx"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70553207A12;
	Wed,  6 Nov 2024 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730920679; cv=none; b=hxNf3NwRKY4rx6DoY+ZN69m6NEDKUJtLMzOWefhqCmGGy9tXTwNb41ZAh+0usupXMHJLEbdlS3WBBQdHq6BpTMsDpxBg/C0Qoy2ZAqglQziCSFRTk9fm5n0s4Jaq9IGxsjdol1bLTRER6gyFmZcsg1rswt1gPDfdCwgeqDI5Kg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730920679; c=relaxed/simple;
	bh=oUwJ+FCZePBc7/upX3mDxs2QlaWyc4n9jjTguyvbq64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ugu2W0xCvpFhzkvkkgEhZ/nJP9E8+WieEQhsM66pG4e+rYgMCYJc0NQgAMc1kftxCqG/uK/LIymNPzE5rdm8md64oh2SvSwT1QXTdAM+mKHs4jJEEcYTmNIJYgoZJA47vLJxOXSkrjB8O7d/dPzJEZEr3KSyzGUDu0RGGiCghCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z6iRigtx; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730920676; x=1762456676;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=oUwJ+FCZePBc7/upX3mDxs2QlaWyc4n9jjTguyvbq64=;
  b=Z6iRigtxzG5ZH5RENnUUB8On81bGjGe60VehX5ayJNQny2AoUvs3/yVm
   B9QyLYZ7EL7ZdgH3y1PyQJYoyInBnAWIL2fb+S+zZ5yLSQkvJE5LLsKF/
   Vhd8b1yV3p9pXxv+AsBCfHrG1GZHW1b1NYKwJmZ/WtRXXL+CmlIkU5FhE
   wYnOq57/S5XRnLVWWQNzOUKSK9OIPkfmFjMcqmzw0V+jtsk9K9bPQfnp3
   y5yQE9/ixfCwRSCOY1jZ5kdkqvL41SwyRwaKhdXbNOb+7xJWIP04PoxUo
   2IqMvPkJkpW+CVCh3Ga1cVPde5EkyPMm4WulCa85WCJ1l6DQPNyNXDhh6
   Q==;
X-CSE-ConnectionGUID: R5B6jnU1TTWc0t0C0FxLpw==
X-CSE-MsgGUID: PpcyY+1cRIa5I2fT9W4UDQ==
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="37447987"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2024 12:17:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Nov 2024 12:17:23 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 6 Nov 2024 12:17:19 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 6 Nov 2024 20:16:45 +0100
Subject: [PATCH net-next 7/7] net: lan969x: add function for configuring
 RGMII port devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241106-sparx5-lan969x-switch-driver-4-v1-7-f7f7316436bd@microchip.com>
References: <20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com>
In-Reply-To: <20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

The lan969x switch device includes two RGMII interfaces (port 28 and 29)
supporting data speeds of 1 Gbps, 100 Mbps and 10 Mbps.

Add new function: rgmii_config() to the match data ops, and use it to
configure RGMII port devices when doing a port config.  On Sparx5, the
RGMII configuration will always be skipped, as the is_port_rgmii() will
return false.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan969x/lan969x.c   | 105 +++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   2 +
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |   3 +
 3 files changed, 110 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.c b/drivers/net/ethernet/microchip/lan969x/lan969x.c
index cfd57eb42c04..0681913a05d4 100644
--- a/drivers/net/ethernet/microchip/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x.c
@@ -9,6 +9,17 @@
 #define LAN969X_SDLB_GRP_CNT 5
 #define LAN969X_HSCH_LEAK_GRP_CNT 4
 
+#define LAN969X_RGMII_TX_CLK_DISABLE 0  /* Disable TX clock generation*/
+#define LAN969X_RGMII_TX_CLK_125MHZ 1   /* 1000Mbps */
+#define LAN969X_RGMII_TX_CLK_25MHZ  2   /* 100Mbps */
+#define LAN969X_RGMII_TX_CLK_2M5MHZ 3   /* 10Mbps */
+#define LAN969X_RGMII_PORT_START_IDX 28 /* Index of the first RGMII port */
+#define LAN969X_RGMII_PORT_RATE 2       /* 1000Mbps  */
+#define LAN969X_RGMII_SHIFT_90DEG 3     /* Phase shift 90deg. (2 ns @ 125MHz) */
+#define LAN969X_RGMII_IFG_TX 4          /* TX Inter Frame Gap value */
+#define LAN969X_RGMII_IFG_RX1 5         /* RX1 Inter Frame Gap value */
+#define LAN969X_RGMII_IFG_RX2 1         /* RX2 Inter Frame Gap value */
+
 static const struct sparx5_main_io_resource lan969x_main_iomap[] =  {
 	{ TARGET_CPU,                   0xc0000, 0 }, /* 0xe00c0000 */
 	{ TARGET_FDMA,                  0xc0400, 0 }, /* 0xe00c0400 */
@@ -293,6 +304,99 @@ static irqreturn_t lan969x_ptp_irq_handler(int irq, void *args)
 	return IRQ_HANDLED;
 }
 
+static int lan969x_port_config_rgmii(struct sparx5 *sparx5,
+				     struct sparx5_port *port,
+				     struct sparx5_port_config *conf)
+{
+	int tx_clk_freq, idx = port->portno - LAN969X_RGMII_PORT_START_IDX;
+	enum sparx5_port_max_tags max_tags = port->max_vlan_tags;
+	enum sparx5_vlan_port_type vlan_type = port->vlan_type;
+	bool dtag, dotag, tx_delay = false, rx_delay = false;
+	u32 etype;
+
+	tx_clk_freq = (conf->speed == SPEED_10	? LAN969X_RGMII_TX_CLK_2M5MHZ :
+		       conf->speed == SPEED_100 ? LAN969X_RGMII_TX_CLK_25MHZ :
+						  LAN969X_RGMII_TX_CLK_125MHZ);
+
+	etype = (vlan_type == SPX5_VLAN_PORT_TYPE_S_CUSTOM ?
+		 port->custom_etype :
+		 vlan_type == SPX5_VLAN_PORT_TYPE_C ?
+		 SPX5_ETYPE_TAG_C : SPX5_ETYPE_TAG_S);
+
+	dtag = max_tags == SPX5_PORT_MAX_TAGS_TWO;
+	dotag = max_tags != SPX5_PORT_MAX_TAGS_NONE;
+
+	if (conf->phy_mode == PHY_INTERFACE_MODE_RGMII ||
+	    conf->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID)
+		rx_delay = true;
+
+	if (conf->phy_mode == PHY_INTERFACE_MODE_RGMII ||
+	    conf->phy_mode == PHY_INTERFACE_MODE_RGMII_RXID)
+		tx_delay = true;
+
+	/* Take the RGMII clock domains out of reset and set tx clock
+	 * frequency.
+	 */
+	spx5_rmw(HSIO_WRAP_RGMII_CFG_TX_CLK_CFG_SET(tx_clk_freq) |
+		HSIO_WRAP_RGMII_CFG_RGMII_TX_RST_SET(0) |
+		HSIO_WRAP_RGMII_CFG_RGMII_RX_RST_SET(0),
+		HSIO_WRAP_RGMII_CFG_TX_CLK_CFG |
+		HSIO_WRAP_RGMII_CFG_RGMII_TX_RST |
+		HSIO_WRAP_RGMII_CFG_RGMII_RX_RST,
+		sparx5, HSIO_WRAP_RGMII_CFG(idx));
+
+	/* Enable the RGMII0 on the GPIOs */
+	spx5_wr(HSIO_WRAP_XMII_CFG_GPIO_XMII_CFG_SET(1),
+		sparx5, HSIO_WRAP_XMII_CFG(!idx));
+
+	/* Configure rx delay, the signal is shifted 90 degrees. */
+	spx5_rmw(HSIO_WRAP_DLL_CFG_DLL_RST_SET(0) |
+		 HSIO_WRAP_DLL_CFG_DLL_ENA_SET(1) |
+		 HSIO_WRAP_DLL_CFG_DLL_CLK_ENA_SET(rx_delay) |
+		 HSIO_WRAP_DLL_CFG_DLL_CLK_SEL_SET(LAN969X_RGMII_SHIFT_90DEG),
+		 HSIO_WRAP_DLL_CFG_DLL_RST |
+		 HSIO_WRAP_DLL_CFG_DLL_ENA |
+		 HSIO_WRAP_DLL_CFG_DLL_CLK_ENA |
+		 HSIO_WRAP_DLL_CFG_DLL_CLK_SEL,
+		 sparx5, HSIO_WRAP_DLL_CFG(idx, 0));
+
+	/* Configure tx delay, the signal is shifted 90 degrees. */
+	spx5_rmw(HSIO_WRAP_DLL_CFG_DLL_RST_SET(0) |
+		 HSIO_WRAP_DLL_CFG_DLL_ENA_SET(1) |
+		 HSIO_WRAP_DLL_CFG_DLL_CLK_ENA_SET(tx_delay) |
+		 HSIO_WRAP_DLL_CFG_DLL_CLK_SEL_SET(LAN969X_RGMII_SHIFT_90DEG),
+		 HSIO_WRAP_DLL_CFG_DLL_RST |
+		 HSIO_WRAP_DLL_CFG_DLL_ENA |
+		 HSIO_WRAP_DLL_CFG_DLL_CLK_ENA |
+		 HSIO_WRAP_DLL_CFG_DLL_CLK_SEL,
+		 sparx5, HSIO_WRAP_DLL_CFG(idx, 1));
+
+	/* Configure the port now */
+	spx5_wr(DEVRGMII_MAC_ENA_CFG_RX_ENA_SET(1) |
+		DEVRGMII_MAC_ENA_CFG_TX_ENA_SET(1),
+		sparx5, DEVRGMII_MAC_ENA_CFG(idx));
+
+	/* Configure the Inter Frame Gap */
+	spx5_wr(DEVRGMII_MAC_IFG_CFG_TX_IFG_SET(LAN969X_RGMII_IFG_TX) |
+		DEVRGMII_MAC_IFG_CFG_RX_IFG1_SET(LAN969X_RGMII_IFG_RX1) |
+		DEVRGMII_MAC_IFG_CFG_RX_IFG2_SET(LAN969X_RGMII_IFG_RX2),
+		sparx5, DEVRGMII_MAC_IFG_CFG(idx));
+
+	/* Configure port data rate */
+	spx5_wr(DEVRGMII_DEV_RST_CTRL_SPEED_SEL_SET(LAN969X_RGMII_PORT_RATE),
+		sparx5, DEVRGMII_DEV_RST_CTRL(idx));
+
+	/* Configure VLAN awareness */
+	spx5_wr(DEVRGMII_MAC_TAGS_CFG_TAG_ID_SET(etype) |
+		DEVRGMII_MAC_TAGS_CFG_PB_ENA_SET(dtag) |
+		DEVRGMII_MAC_TAGS_CFG_VLAN_AWR_ENA_SET(dotag) |
+		DEVRGMII_MAC_TAGS_CFG_VLAN_LEN_AWR_ENA_SET(dotag),
+		sparx5,
+		DEVRGMII_MAC_TAGS_CFG(idx));
+
+	return 0;
+}
+
 static const struct sparx5_regs lan969x_regs = {
 	.tsize = lan969x_tsize,
 	.gaddr = lan969x_gaddr,
@@ -337,6 +441,7 @@ static const struct sparx5_ops lan969x_ops = {
 	.set_port_mux            = &lan969x_port_mux_set,
 	.ptp_irq_handler         = &lan969x_ptp_irq_handler,
 	.dsm_calendar_calc       = &lan969x_dsm_calendar_calc,
+	.rgmii_config            = &lan969x_port_config_rgmii,
 };
 
 const struct sparx5_match_data lan969x_desc = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index a622c01930e7..763c827c01f3 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -324,6 +324,8 @@ struct sparx5_ops {
 	irqreturn_t (*ptp_irq_handler)(int irq, void *args);
 	int (*dsm_calendar_calc)(struct sparx5 *sparx5, u32 taxi,
 				 struct sparx5_calendar_data *data);
+	int (*rgmii_config)(struct sparx5 *sparx5, struct sparx5_port *port,
+			    struct sparx5_port_config *conf);
 };
 
 struct sparx5_main_io_resource {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index bd1fa5da47d7..ef61e8164e21 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -1009,6 +1009,9 @@ int sparx5_port_config(struct sparx5 *sparx5,
 	if (err)
 		return err;
 
+	if (rgmii)
+		ops->rgmii_config(sparx5, port, conf);
+
 	/* high speed device is already configured */
 	if (!rgmii && !high_speed_dev)
 		sparx5_port_config_low_set(sparx5, port, conf);

-- 
2.34.1


