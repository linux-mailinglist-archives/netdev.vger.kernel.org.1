Return-Path: <netdev+bounces-17471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB7D751BEF
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2511C21312
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9388C14;
	Thu, 13 Jul 2023 08:42:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE43F9F3
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:42:43 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68E130DF
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 01:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JMKnyUMYTxIbGD3BegiUxLFU5nRkd7WCXTmkX6rxLnY=; b=gVzMVgAb8wGt6xQ+wbPSLccChC
	tNbSnDOuszV/J90K8JPkhVgjxm9yc5X9bThsoZUOoNGvrdxaAsQ6vWCgp183PJ2Q0IJLRjJd41EEL
	9BgVHLVCth3wpMOY4drfMgxzGLihboVfaVXc1ma3bomU+r7oxWWud/af5rkAduwOZoImt3kz491nS
	lOr4Z8iwzux5g/WulSP7QQqp8zb6OGCQNlPPMmfzKmHzEwHnCpzyfRppqiWfDeKv7eA5VDEr0aEoB
	/6k4lFqXIZiLMHUmJAMNmhdhe8hwrpX17gOUdCpS86qVmGvNYtzYm5BkI1NIrkoV6voInpbojyZKz
	jmrmmUVg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38674 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qJruD-000690-1S;
	Thu, 13 Jul 2023 09:42:33 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qJruD-00Gkjk-8o; Thu, 13 Jul 2023 09:42:33 +0100
In-Reply-To: <ZK+4tOD4EpFzNM9x@shell.armlinux.org.uk>
References: <ZK+4tOD4EpFzNM9x@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 06/11] net: dsa: mv88e6xxx: add infrastructure for
 phylink_pcs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qJruD-00Gkjk-8o@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Jul 2023 09:42:33 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add infrastructure for phylink_pcs to the mv88e6xxx driver. This
involves adding a mac_select_pcs() hook so we can pass the PCS to
phylink at the appropriate time, and a PCS initialisation function.

As the various chip implementations are converted to use phylink_pcs,
they are no longer reliant on the legacy phylink behaviour. We detect
this by the use of this infrastructure, or the lack of any serdes.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 48 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h | 12 ++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 42c325409ac4..acbe55762f5e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -844,6 +844,31 @@ static void mv88e6xxx_get_caps(struct dsa_switch *ds, int port,
 		__set_bit(PHY_INTERFACE_MODE_GMII,
 			  config->supported_interfaces);
 	}
+
+	/* If we have a .pcs_ops, or don't have a .serdes_pcs_get_state,
+	 * serdes_pcs_config, serdes_pcs_an_restart, or serdes_pcs_link_up,
+	 * we are not legacy.
+	 */
+	if (chip->info->ops->pcs_ops ||
+	    (!chip->info->ops->serdes_pcs_get_state &&
+	     !chip->info->ops->serdes_pcs_config &&
+	     !chip->info->ops->serdes_pcs_an_restart &&
+	     !chip->info->ops->serdes_pcs_link_up))
+		config->legacy_pre_march2020 = false;
+}
+
+static struct phylink_pcs *mv88e6xxx_mac_select_pcs(struct dsa_switch *ds,
+						    int port,
+						    phy_interface_t interface)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	struct phylink_pcs *pcs = ERR_PTR(-EOPNOTSUPP);
+
+	if (chip->info->ops->pcs_ops)
+		pcs = chip->info->ops->pcs_ops->pcs_select(chip, port,
+							   interface);
+
+	return pcs;
 }
 
 static int mv88e6xxx_mac_prepare(struct dsa_switch *ds, int port,
@@ -3582,6 +3607,10 @@ static int mv88e6xxx_port_enable(struct dsa_switch *ds, int port,
 	struct mv88e6xxx_chip *chip = ds->priv;
 	int err;
 
+	/* Do not control power or request irqs if using PCS */
+	if (chip->info->ops->pcs_ops)
+		return 0;
+
 	mv88e6xxx_reg_lock(chip);
 	err = mv88e6xxx_serdes_power(chip, port, true);
 	mv88e6xxx_reg_unlock(chip);
@@ -3593,6 +3622,10 @@ static void mv88e6xxx_port_disable(struct dsa_switch *ds, int port)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
 
+	/* Do not control power or request irqs if using PCS */
+	if (chip->info->ops->pcs_ops)
+		return;
+
 	mv88e6xxx_reg_lock(chip);
 	if (mv88e6xxx_serdes_power(chip, port, false))
 		dev_err(chip->dev, "failed to power off SERDES\n");
@@ -4061,12 +4094,26 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 
 static int mv88e6xxx_port_setup(struct dsa_switch *ds, int port)
 {
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int err;
+
+	if (chip->info->ops->pcs_ops->pcs_init) {
+		err = chip->info->ops->pcs_ops->pcs_init(chip, port);
+		if (err)
+			return err;
+	}
+
 	return mv88e6xxx_setup_devlink_regions_port(ds, port);
 }
 
 static void mv88e6xxx_port_teardown(struct dsa_switch *ds, int port)
 {
+	struct mv88e6xxx_chip *chip = ds->priv;
+
 	mv88e6xxx_teardown_devlink_regions_port(ds, port);
+
+	if (chip->info->ops->pcs_ops->pcs_teardown)
+		chip->info->ops->pcs_ops->pcs_teardown(chip, port);
 }
 
 static int mv88e6xxx_get_eeprom_len(struct dsa_switch *ds)
@@ -7061,6 +7108,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.port_setup		= mv88e6xxx_port_setup,
 	.port_teardown		= mv88e6xxx_port_teardown,
 	.phylink_get_caps	= mv88e6xxx_get_caps,
+	.phylink_mac_select_pcs	= mv88e6xxx_mac_select_pcs,
 	.phylink_mac_link_state	= mv88e6xxx_serdes_pcs_get_state,
 	.phylink_mac_prepare	= mv88e6xxx_mac_prepare,
 	.phylink_mac_config	= mv88e6xxx_mac_config,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 0ad34b2d8913..1dd310a3c41f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -205,6 +205,7 @@ struct mv88e6xxx_irq_ops;
 struct mv88e6xxx_gpio_ops;
 struct mv88e6xxx_avb_ops;
 struct mv88e6xxx_ptp_ops;
+struct mv88e6xxx_pcs_ops;
 
 struct mv88e6xxx_irq {
 	u16 masked;
@@ -288,6 +289,7 @@ struct mv88e6xxx_port {
 	unsigned int serdes_irq;
 	char serdes_irq_name[64];
 	struct devlink_region *region;
+	void *pcs_private;
 
 	/* MacAuth Bypass control flag */
 	bool mab;
@@ -664,6 +666,8 @@ struct mv88e6xxx_ops {
 	void (*phylink_get_caps)(struct mv88e6xxx_chip *chip, int port,
 				 struct phylink_config *config);
 
+	const struct mv88e6xxx_pcs_ops *pcs_ops;
+
 	/* Max Frame Size */
 	int (*set_max_frame_size)(struct mv88e6xxx_chip *chip, int mtu);
 };
@@ -736,6 +740,14 @@ struct mv88e6xxx_ptp_ops {
 	u32 cc_mult_dem;
 };
 
+struct mv88e6xxx_pcs_ops {
+	int (*pcs_init)(struct mv88e6xxx_chip *chip, int port);
+	void (*pcs_teardown)(struct mv88e6xxx_chip *chip, int port);
+	struct phylink_pcs *(*pcs_select)(struct mv88e6xxx_chip *chip, int port,
+					  phy_interface_t mode);
+
+};
+
 #define STATS_TYPE_PORT		BIT(0)
 #define STATS_TYPE_BANK0	BIT(1)
 #define STATS_TYPE_BANK1	BIT(2)
-- 
2.30.2


