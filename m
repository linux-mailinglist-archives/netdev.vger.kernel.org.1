Return-Path: <netdev+bounces-13433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A33173B9D1
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 16:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34758281C12
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4236AD25;
	Fri, 23 Jun 2023 14:17:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87ED8F6D
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 14:17:18 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6368FA2
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aHnWit7o/nv9RsHlP2yye0y15jZeCNSVgumhvHLc2IU=; b=oz82DBvXW9oolMgwk1yxfD+i2o
	BMresAoLjV3J5cjuEGOc0t3vFNQCNLbr9Z6kVsFIZ8u7D0fk/BH6j8nKktRqroNy11ogI3VDhLvBe
	HSDAOEzgVW5solhUNTyRGx5FZwHYfpn3Cu4IwRIf7jPltamqvEfvtz5mhTsI1CTDsv7PCo2lKExkg
	0CzfWgLEN7/vAvz/Ox0XH3Hx6UzGGnSoSWL6jZ2D8p+O8utMcjhmfVHlJlvKuZHMbkRsWOBEG6ATM
	x2VzVlbQSyuv8QHNV2tg2V2flFRRi4D1Ny6QSTlexKSVLpCbfP4SMCLGVR6ld/L71Dxgkuxaguz4w
	aBAUrgnA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53850 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qChaz-0005OU-D8; Fri, 23 Jun 2023 15:17:05 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qChay-00Fmrf-9Y; Fri, 23 Jun 2023 15:17:04 +0100
In-Reply-To: <ZJWpGCtIZ06jiBsO@shell.armlinux.org.uk>
References: <ZJWpGCtIZ06jiBsO@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Ar__n__ __NAL" <arinc.unal@arinc9.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 03/14] net: phylink: add support for PCS link
 change notifications
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qChay-00Fmrf-9Y@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 23 Jun 2023 15:17:04 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a function, phylink_pcs_change() which can be used by PCs drivers
to notify phylink about changes to the PCS link state.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 38 ++++++++++++++++++++++++++++++++++----
 include/linux/phylink.h   |  7 +++++++
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 9840a2952309..71b1012ef3be 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1137,6 +1137,11 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 	if (pcs_changed) {
 		phylink_pcs_disable(pl->pcs);
 
+		if (pl->pcs)
+			pl->pcs->phylink = NULL;
+
+		pcs->phylink = pl;
+
 		pl->pcs = pcs;
 	}
 
@@ -1991,6 +1996,14 @@ void phylink_disconnect_phy(struct phylink *pl)
 }
 EXPORT_SYMBOL_GPL(phylink_disconnect_phy);
 
+static void phylink_link_changed(struct phylink *pl, bool up, const char *what)
+{
+	if (!up)
+		pl->mac_link_dropped = true;
+	phylink_run_resolve(pl);
+	phylink_dbg(pl, "%s link %s\n", what, up ? "up" : "down");
+}
+
 /**
  * phylink_mac_change() - notify phylink of a change in MAC state
  * @pl: a pointer to a &struct phylink returned from phylink_create()
@@ -2001,13 +2014,30 @@ EXPORT_SYMBOL_GPL(phylink_disconnect_phy);
  */
 void phylink_mac_change(struct phylink *pl, bool up)
 {
-	if (!up)
-		pl->mac_link_dropped = true;
-	phylink_run_resolve(pl);
-	phylink_dbg(pl, "mac link %s\n", up ? "up" : "down");
+	phylink_link_changed(pl, up, "mac");
 }
 EXPORT_SYMBOL_GPL(phylink_mac_change);
 
+/**
+ * phylink_pcs_change() - notify phylink of a change to PCS link state
+ * @pcs: pointer to &struct phylink_pcs
+ * @up: indicates whether the link is currently up.
+ *
+ * The PCS driver should call this when the state of its link changes
+ * (e.g. link failure, new negotiation results, etc.) Note: it should
+ * not determine "up" by reading the BMSR. If in doubt about the link
+ * state at interrupt time, then pass true if pcs_get_state() returns
+ * the latched link-down state, otherwise pass false.
+ */
+void phylink_pcs_change(struct phylink_pcs *pcs, bool up)
+{
+	struct phylink *pl = pcs->phylink;
+
+	if (pl)
+		phylink_link_changed(pl, up, "pcs");
+}
+EXPORT_SYMBOL_GPL(phylink_pcs_change);
+
 static irqreturn_t phylink_link_handler(int irq, void *data)
 {
 	struct phylink *pl = data;
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index e609b208fa3d..734fb4ca9cf7 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -9,6 +9,7 @@ struct device_node;
 struct ethtool_cmd;
 struct fwnode_handle;
 struct net_device;
+struct phylink;
 
 enum {
 	MLO_PAUSE_NONE,
@@ -518,14 +519,19 @@ struct phylink_pcs_ops;
 /**
  * struct phylink_pcs - PHYLINK PCS instance
  * @ops: a pointer to the &struct phylink_pcs_ops structure
+ * @phylink: pointer to &struct phylink_config
  * @neg_mode: provide PCS neg mode via "mode" argument
  * @poll: poll the PCS for link changes
  *
  * This structure is designed to be embedded within the PCS private data,
  * and will be passed between phylink and the PCS.
+ *
+ * The @phylink member is private to phylink and must not be touched by
+ * the PCS driver.
  */
 struct phylink_pcs {
 	const struct phylink_pcs_ops *ops;
+	struct phylink *phylink;
 	bool neg_mode;
 	bool poll;
 };
@@ -697,6 +703,7 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
 void phylink_disconnect_phy(struct phylink *);
 
 void phylink_mac_change(struct phylink *, bool up);
+void phylink_pcs_change(struct phylink_pcs *, bool up);
 
 void phylink_start(struct phylink *);
 void phylink_stop(struct phylink *);
-- 
2.30.2


