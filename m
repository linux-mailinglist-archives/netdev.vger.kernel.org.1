Return-Path: <netdev+bounces-17467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08F3751BE9
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15711C21292
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE4E8835;
	Thu, 13 Jul 2023 08:42:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DE38C0D
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:42:17 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8302723
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SfAcoBzLewE30RbNHGMkEM4YXx21y4R+4JeMtDrDCGA=; b=SpWTIoaHV+/fW2VDBWFdrXf0S5
	MVSbs5KFboi45zihMp35JsRA5FeLYs7YxKyuJPE/1At9qqYSbV4xGdmbjpzGYQ+g+uvY/WbATEfIn
	97RxTvL4JFytvOrRWs7ncnzim3o1+1KGxXsmCFfAxQJ1CoykdOdY8fxYWmtfPnO1owucP1RAdm8KP
	pp1/mlM7nvTzoQMEvpDP88TY/hLGxFWNWvYyPFdOsm39F4apMVx4GiSJ9QeVUhhTmB/tQXtJdB9Y+
	kGwAZPnkmowAdcTidmGI4qIs+nM6w/pCOSYaZzWtPTRl++FbLJnsHAz4WTTEmcqlwT+3y3Y2gObdX
	BJo8+nyw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57578 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qJrts-00068F-2p;
	Thu, 13 Jul 2023 09:42:12 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qJrts-00GkjM-Lj; Thu, 13 Jul 2023 09:42:12 +0100
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
Subject: [PATCH net-next 02/11] net: phylink: add
 pcs_pre_config()/pcs_post_config() methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qJrts-00GkjM-Lj@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Jul 2023 09:42:12 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add hooks that are called before and after the mac_config() call,
which will be needed to deal with errata workarounds for the
Marvell 88e639x DSA switches.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 24 ++++++++++++++++++++++++
 include/linux/phylink.h   |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 748c62efceb8..9840a2952309 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -998,6 +998,24 @@ static void phylink_resolve_an_pause(struct phylink_link_state *state)
 	}
 }
 
+static void phylink_pcs_pre_config(struct phylink_pcs *pcs,
+				   phy_interface_t interface)
+{
+	if (pcs && pcs->ops->pcs_pre_config)
+		pcs->ops->pcs_pre_config(pcs, interface);
+}
+
+static int phylink_pcs_post_config(struct phylink_pcs *pcs,
+				   phy_interface_t interface)
+{
+	int err = 0;
+
+	if (pcs && pcs->ops->pcs_post_config)
+		err = pcs->ops->pcs_post_config(pcs, interface);
+
+	return err;
+}
+
 static void phylink_pcs_disable(struct phylink_pcs *pcs)
 {
 	if (pcs && pcs->ops->pcs_disable)
@@ -1122,8 +1140,14 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 		pl->pcs = pcs;
 	}
 
+	if (pl->pcs)
+		phylink_pcs_pre_config(pl->pcs, state->interface);
+
 	phylink_mac_config(pl, state);
 
+	if (pl->pcs)
+		phylink_pcs_post_config(pl->pcs, state->interface);
+
 	if (pl->pcs_state == PCS_STATE_STARTING || pcs_changed)
 		phylink_pcs_enable(pl->pcs);
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 8e2fdd48a935..99fc2fa60695 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -537,6 +537,8 @@ struct phylink_pcs {
  * @pcs_validate: validate the link configuration.
  * @pcs_enable: enable the PCS.
  * @pcs_disable: disable the PCS.
+ * @pcs_pre_config: pre-mac_config method (for errata)
+ * @pcs_post_config: post-mac_config method (for arrata)
  * @pcs_get_state: read the current MAC PCS link state from the hardware.
  * @pcs_config: configure the MAC PCS for the selected mode and state.
  * @pcs_an_restart: restart 802.3z BaseX autonegotiation.
@@ -548,6 +550,10 @@ struct phylink_pcs_ops {
 			    const struct phylink_link_state *state);
 	int (*pcs_enable)(struct phylink_pcs *pcs);
 	void (*pcs_disable)(struct phylink_pcs *pcs);
+	void (*pcs_pre_config)(struct phylink_pcs *pcs,
+			       phy_interface_t interface);
+	int (*pcs_post_config)(struct phylink_pcs *pcs,
+			       phy_interface_t interface);
 	void (*pcs_get_state)(struct phylink_pcs *pcs,
 			      struct phylink_link_state *state);
 	int (*pcs_config)(struct phylink_pcs *pcs, unsigned int neg_mode,
-- 
2.30.2


