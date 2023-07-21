Return-Path: <netdev+bounces-19802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2C975C5EF
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4551C21687
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779AF1E507;
	Fri, 21 Jul 2023 11:34:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AC21D2F4
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:34:37 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894C92D4D
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 04:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bOqrkVh53/UTrc1E/Sk4PZloOATbPGJ3uK44hF/V2pI=; b=zewbHCqy8ZGhqI8EHJIxuu6RX+
	i6I1q9tG5o48JLES69vsAFkKlcdCdCDfDHZkhrLHrWJRdkqNzoWhFUWEK0QEgOGDg+WgjcxHykKln
	3u3vYequRc0b5PZkLrjH0Cy0+Zib6Lwc4hYv8K9HS5ri376RH5xMt7QNstXVfSDGFdxZgBbMdisrc
	A2fJb4/OnUTq2HNRrZKj4ls07BrXHP3RxJA3vKET17aTJLFTZRViOVjQh/UD2rTPGuATQWh02c51k
	3CgodBVKE0Hx575/D7IUxrpov5B5pvtv0fjL4BoJtg8aSCm8RuOcCX1ePuSiyd0N/vC42uMas7xii
	k1meJ8KQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45354 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qMoOv-0003oF-0n;
	Fri, 21 Jul 2023 12:34:25 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qMoOv-000hhR-6f; Fri, 21 Jul 2023 12:34:25 +0100
In-Reply-To: <ZLptIKEb7qLY5LmS@shell.armlinux.org.uk>
References: <ZLptIKEb7qLY5LmS@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	 Ar__n__ __NAL <arinc.unal@arinc9.com>,
	 Frank Wunderlich <frank-w@public-files.de>,
	 David Woodhouse <dwmw@amazon.co.uk>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Fietkau <nbd@nbd.name>,
	Jakub Kicinski <kuba@kernel.org>,
	John Crispin <john@phrozen.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH net-next 3/4] net: phylink: strip out pre-March 2020 legacy
 code
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qMoOv-000hhR-6f@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 21 Jul 2023 12:34:25 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Strip out all the pre-March 2020 legacy code from phylink now that the
last user of it is gone.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 25 ++++------------------
 include/linux/phylink.h   | 45 ++++++---------------------------------
 2 files changed, 10 insertions(+), 60 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index f07e496319b4..df413fb15088 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1198,13 +1198,6 @@ static int phylink_change_inband_advert(struct phylink *pl)
 	if (test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state))
 		return 0;
 
-	if (!pl->pcs && pl->config->legacy_pre_march2020) {
-		/* Legacy method */
-		phylink_mac_config(pl, &pl->link_config);
-		phylink_pcs_an_restart(pl);
-		return 0;
-	}
-
 	phylink_dbg(pl, "%s: mode=%s/%s adv=%*pb pause=%02x\n", __func__,
 		    phylink_an_mode_str(pl->cur_link_an_mode),
 		    phy_modes(pl->link_config.interface),
@@ -1257,9 +1250,6 @@ static void phylink_mac_pcs_get_state(struct phylink *pl,
 
 	if (pl->pcs)
 		pl->pcs->ops->pcs_get_state(pl->pcs, state);
-	else if (pl->mac_ops->mac_pcs_get_state &&
-		 pl->config->legacy_pre_march2020)
-		pl->mac_ops->mac_pcs_get_state(pl->config, state);
 	else
 		state->link = 0;
 }
@@ -1492,13 +1482,6 @@ static void phylink_resolve(struct work_struct *w)
 			}
 			phylink_major_config(pl, false, &link_state);
 			pl->link_config.interface = link_state.interface;
-		} else if (!pl->pcs && pl->config->legacy_pre_march2020) {
-			/* The interface remains unchanged, only the speed,
-			 * duplex or pause settings have changed. Call the
-			 * old mac_config() method to configure the MAC/PCS
-			 * only if we do not have a legacy MAC driver.
-			 */
-			phylink_mac_config(pl, &link_state);
 		}
 	}
 
@@ -3513,7 +3496,7 @@ static void phylink_decode_usgmii_word(struct phylink_link_state *state,
  *
  * Parse the Clause 37 or Cisco SGMII link partner negotiation word into
  * the phylink @state structure. This is suitable to be used for implementing
- * the mac_pcs_get_state() member of the struct phylink_mac_ops structure if
+ * the pcs_get_state() member of the struct phylink_pcs_ops structure if
  * accessing @bmsr and @lpa cannot be done with MDIO directly.
  */
 void phylink_mii_c22_pcs_decode_state(struct phylink_link_state *state,
@@ -3563,7 +3546,7 @@ EXPORT_SYMBOL_GPL(phylink_mii_c22_pcs_decode_state);
  * Read the MAC PCS state from the MII device configured in @config and
  * parse the Clause 37 or Cisco SGMII link partner negotiation word into
  * the phylink @state structure. This is suitable to be directly plugged
- * into the mac_pcs_get_state() member of the struct phylink_mac_ops
+ * into the pcs_get_state() member of the struct phylink_pcs_ops
  * structure.
  */
 void phylink_mii_c22_pcs_get_state(struct mdio_device *pcs,
@@ -3674,8 +3657,8 @@ EXPORT_SYMBOL_GPL(phylink_mii_c22_pcs_config);
  * clause 37 negotiation.
  *
  * Restart the clause 37 negotiation with the link partner. This is
- * suitable to be directly plugged into the mac_pcs_get_state() member
- * of the struct phylink_mac_ops structure.
+ * suitable to be directly plugged into the pcs_get_state() member
+ * of the struct phylink_pcs_ops structure.
  */
 void phylink_mii_c22_pcs_an_restart(struct mdio_device *pcs)
 {
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 9e861c8316d0..789c516c6b4a 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -201,8 +201,6 @@ enum phylink_op_type {
  * struct phylink_config - PHYLINK configuration structure
  * @dev: a pointer to a struct device associated with the MAC
  * @type: operation type of PHYLINK instance
- * @legacy_pre_march2020: driver has not been updated for March 2020 updates
- *	(See commit 7cceb599d15d ("net: phylink: avoid mac_config calls")
  * @poll_fixed_state: if true, starts link_poll,
  *		      if MAC link is at %MLO_AN_FIXED mode.
  * @mac_managed_pm: if true, indicate the MAC driver is responsible for PHY PM.
@@ -216,7 +214,6 @@ enum phylink_op_type {
 struct phylink_config {
 	struct device *dev;
 	enum phylink_op_type type;
-	bool legacy_pre_march2020;
 	bool poll_fixed_state;
 	bool mac_managed_pm;
 	bool ovr_an_inband;
@@ -230,7 +227,6 @@ struct phylink_config {
  * struct phylink_mac_ops - MAC operations structure.
  * @validate: Validate and update the link configuration.
  * @mac_select_pcs: Select a PCS for the interface mode.
- * @mac_pcs_get_state: Read the current link state from the hardware.
  * @mac_prepare: prepare for a major reconfiguration of the interface.
  * @mac_config: configure the MAC for the selected mode and state.
  * @mac_finish: finish a major reconfiguration of the interface.
@@ -245,8 +241,6 @@ struct phylink_mac_ops {
 			 struct phylink_link_state *state);
 	struct phylink_pcs *(*mac_select_pcs)(struct phylink_config *config,
 					      phy_interface_t interface);
-	void (*mac_pcs_get_state)(struct phylink_config *config,
-				  struct phylink_link_state *state);
 	int (*mac_prepare)(struct phylink_config *config, unsigned int mode,
 			   phy_interface_t iface);
 	void (*mac_config)(struct phylink_config *config, unsigned int mode,
@@ -312,25 +306,6 @@ void validate(struct phylink_config *config, unsigned long *supported,
 struct phylink_pcs *mac_select_pcs(struct phylink_config *config,
 				   phy_interface_t interface);
 
-/**
- * mac_pcs_get_state() - Read the current inband link state from the hardware
- * @config: a pointer to a &struct phylink_config.
- * @state: a pointer to a &struct phylink_link_state.
- *
- * Read the current inband link state from the MAC PCS, reporting the
- * current speed in @state->speed, duplex mode in @state->duplex, pause
- * mode in @state->pause using the %MLO_PAUSE_RX and %MLO_PAUSE_TX bits,
- * negotiation completion state in @state->an_complete, and link up state
- * in @state->link. If possible, @state->lp_advertising should also be
- * populated.
- *
- * Note: This is a legacy method. This function will not be called unless
- * legacy_pre_march2020 is set in &struct phylink_config and there is no
- * PCS attached.
- */
-void mac_pcs_get_state(struct phylink_config *config,
-		       struct phylink_link_state *state);
-
 /**
  * mac_prepare() - prepare to change the PHY interface mode
  * @config: a pointer to a &struct phylink_config.
@@ -367,17 +342,9 @@ int mac_prepare(struct phylink_config *config, unsigned int mode,
  * guaranteed to be correct, and so any mac_config() implementation must
  * never reference these fields.
  *
- * Note: For legacy March 2020 drivers (drivers with legacy_pre_march2020 set
- * in their &phylnk_config and which don't have a PCS), this function will be
- * called on each link up event, and to also change the in-band advert. For
- * non-legacy drivers, it will only be called to reconfigure the MAC for a
- * "major" change in e.g. interface mode. It will not be called for changes
- * in speed, duplex or pause modes or to change the in-band advertisement.
- * In any case, it is strongly preferred that speed, duplex and pause settings
- * are handled in the mac_link_up() method and not in this method.
- *
- * (this requires a rewrite - please refer to mac_link_up() for situations
- *  where the PCS and MAC are not tightly integrated.)
+ * This will only be called to reconfigure the MAC for a "major" change in
+ * e.g. interface mode. It will not be called for changes in speed, duplex
+ * or pause modes or to change the in-band advertisement.
  *
  * In all negotiation modes, as defined by @mode, @state->pause indicates the
  * pause settings which should be applied as follows. If %MLO_PAUSE_AN is not
@@ -409,7 +376,7 @@ int mac_prepare(struct phylink_config *config, unsigned int mode,
  *   1000base-X or Cisco SGMII mode depending on the @state->interface
  *   mode). In both cases, link state management (whether the link
  *   is up or not) is performed by the MAC, and reported via the
- *   mac_pcs_get_state() callback. Changes in link state must be made
+ *   pcs_get_state() callback. Changes in link state must be made
  *   by calling phylink_mac_change().
  *
  *   Interface mode specific details are mentioned below.
@@ -601,8 +568,8 @@ void pcs_disable(struct phylink_pcs *pcs);
  * in @state->link. If possible, @state->lp_advertising should also be
  * populated.
  *
- * When present, this overrides mac_pcs_get_state() in &struct
- * phylink_mac_ops.
+ * When present, this overrides pcs_get_state() in &struct
+ * phylink_pcs_ops.
  */
 void pcs_get_state(struct phylink_pcs *pcs,
 		   struct phylink_link_state *state);
-- 
2.30.2


