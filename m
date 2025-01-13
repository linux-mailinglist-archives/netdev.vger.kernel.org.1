Return-Path: <netdev+bounces-157663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B3CA0B29F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D7A7A1879
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB668239781;
	Mon, 13 Jan 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QK32azYn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3F231CA3
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760191; cv=none; b=pCrAOMeFC1sHCNXIfJA7QUObBMHiagnWiL2LqR1BVO+p5nzo5jTQb30QHUcZZ6UUjLQRGJB1TvFJ4WDLNs2xauUJzhMnhpAyD5O7O9HuvLziSPAAFqmnz1rBL+TdHcP+vi357b87sRwF5DG4a47ZZdoePccZdY6Kaz+BiKjxtmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760191; c=relaxed/simple;
	bh=2WVvjzrtGwYEUZ2ozrgqlq9Vd6U0J+uRZUPcxbbyi2M=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=APKQ9fovgJ8GNerHHYsL9TdDlYrse6UU95rFW01W63wY69iRlrqeob3zpIMLIiAC4VfDh6G8BWF26raV5zf7Z2B/i715sKpgdVP/Yo009SsmWamdzVO/SaYl92rmQrjK6nxmT2f6FroScRvKF50nUYWKnj/cAheXT8ODsyXKZls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QK32azYn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Jv8WbSOe+ev25axRxGKIjYrw/TKgxrTrxWr8y1atOHU=; b=QK32azYn2Kji7O1W6WFIToKi7w
	29fq+S9IRha0dknJHZ++yJ/nggIRrSoEA6CBSKpO1sB8sMV49lRZwdi4VJSTBQSOCOur5QH0oJ6TD
	4KDFTHgeudXvTAnhvmSdgxsSjCyRbGv0kE/JK0G5efLFsXcIX/opMuPG9n9sTJDzdQ58DoRLmeRyN
	uwtwnyQUJNiUU4wTX7td9ifn97WSHD3UyHJDCElTFJlM1mrIYmmOKw/+pbWSh9nd1zQeUiUCu4D2U
	X/E54rXHy18wc8lYCJsQl4o9FwP4kL51dGdgzgwPpclrosnA6bCmN7WTvUcaWAuwCf68ZDDVXyiSB
	i6AiGvkw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36330 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXGem-0006HC-16;
	Mon, 13 Jan 2025 09:22:48 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXGeT-000Et3-4L; Mon, 13 Jan 2025 09:22:29 +0000
In-Reply-To: <Z4TbR93B-X8A8iHe@shell.armlinux.org.uk>
References: <Z4TbR93B-X8A8iHe@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Golle <daniel@makrotopia.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	netdev@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH net-next v2 2/5] net: phylink: pass neg_mode into
 .pcs_get_state() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXGeT-000Et3-4L@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 13 Jan 2025 09:22:29 +0000

Pass the current neg_mode into the .pcs_get_state() method. Update all
users of phylink PCS.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/b53/b53_serdes.c                         | 4 ++--
 drivers/net/dsa/mt7530.c                                 | 2 +-
 drivers/net/dsa/mv88e6xxx/pcs-6185.c                     | 1 +
 drivers/net/dsa/mv88e6xxx/pcs-6352.c                     | 1 +
 drivers/net/dsa/mv88e6xxx/pcs-639x.c                     | 5 ++++-
 drivers/net/dsa/qca/qca8k-8xxx.c                         | 2 +-
 drivers/net/ethernet/cadence/macb_main.c                 | 3 ++-
 drivers/net/ethernet/freescale/fman/fman_dtsec.c         | 2 +-
 drivers/net/ethernet/marvell/mvneta.c                    | 2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c          | 2 ++
 drivers/net/ethernet/marvell/prestera/prestera_main.c    | 1 +
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c          | 2 +-
 drivers/net/ethernet/microchip/lan966x/lan966x_phylink.c | 1 +
 drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c   | 2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c        | 1 +
 drivers/net/pcs/pcs-lynx.c                               | 2 +-
 drivers/net/pcs/pcs-mtk-lynxi.c                          | 1 +
 drivers/net/pcs/pcs-xpcs.c                               | 2 +-
 drivers/net/phy/phylink.c                                | 2 +-
 include/linux/phylink.h                                  | 8 ++++++--
 20 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
index 3f8a491ce885..4730982b6840 100644
--- a/drivers/net/dsa/b53/b53_serdes.c
+++ b/drivers/net/dsa/b53/b53_serdes.c
@@ -99,8 +99,8 @@ static void b53_serdes_an_restart(struct phylink_pcs *pcs)
 			 SERDES_MII_BLK, reg);
 }
 
-static void b53_serdes_get_state(struct phylink_pcs *pcs,
-				  struct phylink_link_state *state)
+static void b53_serdes_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
+				 struct phylink_link_state *state)
 {
 	struct b53_device *dev = pcs_to_b53_pcs(pcs)->dev;
 	u8 lane = pcs_to_b53_pcs(pcs)->lane;
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index d2d0f091e49e..1c83af805209 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2994,7 +2994,7 @@ static int mt753x_pcs_validate(struct phylink_pcs *pcs,
 	return 0;
 }
 
-static void mt7530_pcs_get_state(struct phylink_pcs *pcs,
+static void mt7530_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 				 struct phylink_link_state *state)
 {
 	struct mt7530_priv *priv = pcs_to_mt753x_pcs(pcs)->priv;
diff --git a/drivers/net/dsa/mv88e6xxx/pcs-6185.c b/drivers/net/dsa/mv88e6xxx/pcs-6185.c
index 5a27d047a38e..75ed1fa500a5 100644
--- a/drivers/net/dsa/mv88e6xxx/pcs-6185.c
+++ b/drivers/net/dsa/mv88e6xxx/pcs-6185.c
@@ -55,6 +55,7 @@ static irqreturn_t mv88e6185_pcs_handle_irq(int irq, void *dev_id)
 }
 
 static void mv88e6185_pcs_get_state(struct phylink_pcs *pcs,
+				    unsigned int neg_mode,
 				    struct phylink_link_state *state)
 {
 	struct mv88e6185_pcs *mpcs = pcs_to_mv88e6185_pcs(pcs);
diff --git a/drivers/net/dsa/mv88e6xxx/pcs-6352.c b/drivers/net/dsa/mv88e6xxx/pcs-6352.c
index 88f624b65470..143fe21d1834 100644
--- a/drivers/net/dsa/mv88e6xxx/pcs-6352.c
+++ b/drivers/net/dsa/mv88e6xxx/pcs-6352.c
@@ -158,6 +158,7 @@ static void marvell_c22_pcs_disable(struct phylink_pcs *pcs)
 }
 
 static void marvell_c22_pcs_get_state(struct phylink_pcs *pcs,
+				      unsigned int neg_mode,
 				      struct phylink_link_state *state)
 {
 	struct marvell_c22_pcs *mpcs = pcs_to_marvell_c22_pcs(pcs);
diff --git a/drivers/net/dsa/mv88e6xxx/pcs-639x.c b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
index d758a6c1b226..026b7bfb7ee5 100644
--- a/drivers/net/dsa/mv88e6xxx/pcs-639x.c
+++ b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
@@ -257,6 +257,7 @@ static int mv88e639x_sgmii_pcs_post_config(struct phylink_pcs *pcs,
 }
 
 static void mv88e639x_sgmii_pcs_get_state(struct phylink_pcs *pcs,
+					  unsigned int neg_mode,
 					  struct phylink_link_state *state)
 {
 	struct mv88e639x_pcs *mpcs = sgmii_pcs_to_mv88e639x_pcs(pcs);
@@ -395,6 +396,7 @@ static void mv88e639x_xg_pcs_disable(struct mv88e639x_pcs *mpcs)
 }
 
 static void mv88e639x_xg_pcs_get_state(struct phylink_pcs *pcs,
+				       unsigned int neg_mode,
 				       struct phylink_link_state *state)
 {
 	struct mv88e639x_pcs *mpcs = xg_pcs_to_mv88e639x_pcs(pcs);
@@ -889,6 +891,7 @@ static int mv88e6393x_xg_pcs_post_config(struct phylink_pcs *pcs,
 }
 
 static void mv88e6393x_xg_pcs_get_state(struct phylink_pcs *pcs,
+					unsigned int neg_mode,
 					struct phylink_link_state *state)
 {
 	struct mv88e639x_pcs *mpcs = xg_pcs_to_mv88e639x_pcs(pcs);
@@ -896,7 +899,7 @@ static void mv88e6393x_xg_pcs_get_state(struct phylink_pcs *pcs,
 	int err;
 
 	if (state->interface != PHY_INTERFACE_MODE_USXGMII)
-		return mv88e639x_xg_pcs_get_state(pcs, state);
+		return mv88e639x_xg_pcs_get_state(pcs, neg_mode, state);
 
 	state->link = false;
 
diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 750fc76a6e11..e8cb4da15dbe 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1491,7 +1491,7 @@ static struct qca8k_pcs *pcs_to_qca8k_pcs(struct phylink_pcs *pcs)
 	return container_of(pcs, struct qca8k_pcs, pcs);
 }
 
-static void qca8k_pcs_get_state(struct phylink_pcs *pcs,
+static void qca8k_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 				struct phylink_link_state *state)
 {
 	struct qca8k_priv *priv = pcs_to_qca8k_pcs(pcs)->priv;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 640f500f989d..48496209fb16 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -568,6 +568,7 @@ static void macb_usx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 }
 
 static void macb_usx_pcs_get_state(struct phylink_pcs *pcs,
+				   unsigned int neg_mode,
 				   struct phylink_link_state *state)
 {
 	struct macb *bp = container_of(pcs, struct macb, phylink_usx_pcs);
@@ -598,7 +599,7 @@ static int macb_usx_pcs_config(struct phylink_pcs *pcs,
 	return 0;
 }
 
-static void macb_pcs_get_state(struct phylink_pcs *pcs,
+static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 			       struct phylink_link_state *state)
 {
 	state->link = 0;
diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
index 85617bb94959..c47108c820ea 100644
--- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
@@ -755,7 +755,7 @@ static struct fman_mac *pcs_to_dtsec(struct phylink_pcs *pcs)
 	return container_of(pcs, struct fman_mac, pcs);
 }
 
-static void dtsec_pcs_get_state(struct phylink_pcs *pcs,
+static void dtsec_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 				struct phylink_link_state *state)
 {
 	struct fman_mac *dtsec = pcs_to_dtsec(pcs);
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index fe6261b81540..9e79a60baebc 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3983,7 +3983,7 @@ static unsigned int mvneta_pcs_inband_caps(struct phylink_pcs *pcs,
 	return LINK_INBAND_DISABLE;
 }
 
-static void mvneta_pcs_get_state(struct phylink_pcs *pcs,
+static void mvneta_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 				 struct phylink_link_state *state)
 {
 	struct mvneta_port *pp = mvneta_pcs_to_port(pcs);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index f85229a30844..d294580f4832 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6188,6 +6188,7 @@ static struct mvpp2_port *mvpp2_pcs_gmac_to_port(struct phylink_pcs *pcs)
 }
 
 static void mvpp2_xlg_pcs_get_state(struct phylink_pcs *pcs,
+				    unsigned int neg_mode,
 				    struct phylink_link_state *state)
 {
 	struct mvpp2_port *port = mvpp2_pcs_xlg_to_port(pcs);
@@ -6247,6 +6248,7 @@ static unsigned int mvpp2_gmac_pcs_inband_caps(struct phylink_pcs *pcs,
 }
 
 static void mvpp2_gmac_pcs_get_state(struct phylink_pcs *pcs,
+				     unsigned int neg_mode,
 				     struct phylink_link_state *state)
 {
 	struct mvpp2_port *port = mvpp2_pcs_gmac_to_port(pcs);
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 22ca6ee9665e..440a4c42b405 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -280,6 +280,7 @@ prestera_mac_select_pcs(struct phylink_config *config,
 }
 
 static void prestera_pcs_get_state(struct phylink_pcs *pcs,
+				   unsigned int neg_mode,
 				   struct phylink_link_state *state)
 {
 	struct prestera_port *port = container_of(pcs, struct prestera_port,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 1a5e1e719b30..bb11fc83367d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -15,7 +15,7 @@ fbnic_pcs_to_net(struct phylink_pcs *pcs)
 }
 
 static void
-fbnic_phylink_pcs_get_state(struct phylink_pcs *pcs,
+fbnic_phylink_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 			    struct phylink_link_state *state)
 {
 	struct fbnic_net *fbn = fbnic_pcs_to_net(pcs);
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_phylink.c b/drivers/net/ethernet/microchip/lan966x/lan966x_phylink.c
index 1d63903f9006..a761777259bf 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_phylink.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_phylink.c
@@ -88,6 +88,7 @@ static struct lan966x_port *lan966x_pcs_to_port(struct phylink_pcs *pcs)
 }
 
 static void lan966x_pcs_get_state(struct phylink_pcs *pcs,
+				  unsigned int neg_mode,
 				  struct phylink_link_state *state)
 {
 	struct lan966x_port *port = lan966x_pcs_to_port(pcs);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c b/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c
index 035d2f1bea0d..cfb4b2e17ace 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c
@@ -89,7 +89,7 @@ static struct sparx5_port *sparx5_pcs_to_port(struct phylink_pcs *pcs)
 	return container_of(pcs, struct sparx5_port, phylink_pcs);
 }
 
-static void sparx5_pcs_get_state(struct phylink_pcs *pcs,
+static void sparx5_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 				 struct phylink_link_state *state)
 {
 	struct sparx5_port *port = sparx5_pcs_to_port(pcs);
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 0f4b02fe6f85..f9e695d7cc4a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2331,6 +2331,7 @@ static struct axienet_local *pcs_to_axienet_local(struct phylink_pcs *pcs)
 }
 
 static void axienet_pcs_get_state(struct phylink_pcs *pcs,
+				  unsigned int neg_mode,
 				  struct phylink_link_state *state)
 {
 	struct mdio_device *pcs_phy = pcs_to_axienet_local(pcs)->pcs_phy;
diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index 6457190ec6e7..f359f62f69ad 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -100,7 +100,7 @@ static void lynx_pcs_get_state_2500basex(struct mdio_device *pcs,
 	state->duplex = DUPLEX_FULL;
 }
 
-static void lynx_pcs_get_state(struct phylink_pcs *pcs,
+static void lynx_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 			       struct phylink_link_state *state)
 {
 	struct lynx_pcs *lynx = phylink_pcs_to_lynx(pcs);
diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 4fe0fb6d12a4..e1b6f332c3c2 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -105,6 +105,7 @@ static unsigned int mtk_pcs_lynxi_inband_caps(struct phylink_pcs *pcs,
 }
 
 static void mtk_pcs_lynxi_get_state(struct phylink_pcs *pcs,
+				    unsigned int neg_mode,
 				    struct phylink_link_state *state)
 {
 	struct mtk_pcs_lynxi *mpcs = pcs_to_mtk_pcs_lynxi(pcs);
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index c06b66f40022..4cd0c4fe6496 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1086,7 +1086,7 @@ static int xpcs_get_state_2500basex(struct dw_xpcs *xpcs,
 	return 0;
 }
 
-static void xpcs_get_state(struct phylink_pcs *pcs,
+static void xpcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 			   struct phylink_link_state *state)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 31f2d8a8ff19..a8d443ee18be 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1520,7 +1520,7 @@ static void phylink_mac_pcs_get_state(struct phylink *pl,
 	}
 
 	if (pcs)
-		pcs->ops->pcs_get_state(pcs, state);
+		pcs->ops->pcs_get_state(pcs, pl->pcs_neg_mode, state);
 	else
 		state->link = 0;
 }
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 4b7a20620b49..0bbcb4898e93 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -446,7 +446,7 @@ struct phylink_pcs_ops {
 			       phy_interface_t interface);
 	int (*pcs_post_config)(struct phylink_pcs *pcs,
 			       phy_interface_t interface);
-	void (*pcs_get_state)(struct phylink_pcs *pcs,
+	void (*pcs_get_state)(struct phylink_pcs *pcs, unsigned int neg_mode,
 			      struct phylink_link_state *state);
 	int (*pcs_config)(struct phylink_pcs *pcs, unsigned int neg_mode,
 			  phy_interface_t interface,
@@ -505,6 +505,7 @@ void pcs_disable(struct phylink_pcs *pcs);
 /**
  * pcs_get_state() - Read the current inband link state from the hardware
  * @pcs: a pointer to a &struct phylink_pcs.
+ * @neg_mode: link negotiation mode (PHYLINK_PCS_NEG_xxx)
  * @state: a pointer to a &struct phylink_link_state.
  *
  * Read the current inband link state from the MAC PCS, reporting the
@@ -513,8 +514,11 @@ void pcs_disable(struct phylink_pcs *pcs);
  * negotiation completion state in @state->an_complete, and link up state
  * in @state->link. If possible, @state->lp_advertising should also be
  * populated.
+ *
+ * Note that the @neg_mode parameter is always the PHYLINK_PCS_NEG_xxx
+ * state, not MLO_AN_xxx.
  */
-void pcs_get_state(struct phylink_pcs *pcs,
+void pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 		   struct phylink_link_state *state);
 
 /**
-- 
2.30.2


