Return-Path: <netdev+bounces-41403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6E77CADD5
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBA02815E4
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376B32AB58;
	Mon, 16 Oct 2023 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DCnYrBVl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090B2AB23;
	Mon, 16 Oct 2023 15:42:58 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF96B4;
	Mon, 16 Oct 2023 08:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MdPKoAhty5b5uAZHqEW0f42zACuJIFNLoNvxPIyqWIg=; b=DCnYrBVleoHT03I2fChRPKyHF0
	dtIbSb/KFtBnxOWOKM7A/iIUrSE0E3BzLd8Xs1Y59Z//piODATCQdatXbhFOzASGe4Xp2zdotXLri
	HwrCw+eD7XgJAlu2yJmBhF8SgpC1rHAmH8iOQijnWjgizTlUBfkOZ4QPi+fCBakWwSPaAs1VK43D/
	Mq0KCg6+NOhOonHJYpM7llZnnWy52HAt8um/9+0qaAZQqLdO6ycNUR1qF+rv8e7C0puuhs0n8WPfQ
	esa3yRvQDrnSuN2iT6p1iUm2N7q4vk8z4XHBTzt5nkwzwQVqOw0j/Dl0vPJELZxlaoEV5Opg6XO38
	MH7TyOxg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38474 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qsPk4-0001f5-0V;
	Mon, 16 Oct 2023 16:42:52 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qsPk5-009wiX-G5; Mon, 16 Oct 2023 16:42:53 +0100
In-Reply-To: <ZS1Z5DDfHyjMryYu@shell.armlinux.org.uk>
References: <ZS1Z5DDfHyjMryYu@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH net-next 1/4] net: phylink: provide mac_get_caps() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qsPk5-009wiX-G5@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 16 Oct 2023 16:42:53 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Provide a new method, mac_get_caps() to get the MAC capabilities for
the specified interface mode. This is for MACs which have special
requirements, such as not supporting half-duplex in certain interface
modes, and will replace the validate() method.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 Documentation/networking/sfp-phylink.rst |  7 +++++++
 drivers/net/phy/phylink.c                | 14 +++++++++++---
 include/linux/phylink.h                  | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/sfp-phylink.rst b/Documentation/networking/sfp-phylink.rst
index 55b65f607a64..b069d34d7f5c 100644
--- a/Documentation/networking/sfp-phylink.rst
+++ b/Documentation/networking/sfp-phylink.rst
@@ -200,6 +200,13 @@ this documentation.
    when the in-band link state changes - otherwise the link will never
    come up.
 
+   The :c:func:`mac_get_caps` method is optional, and if provided should
+   return the phylink MAC capabilities that are supported for the passed
+   ``interface`` mode. In general, there is no need to implement this method.
+   Phylink will use these capabilities in combination with permissible
+   capabilities for ``interface`` to determine the allowable ethtool link
+   modes.
+
    The :c:func:`validate` method should mask the supplied supported mask,
    and ``state->advertising`` with the supported ethtool link modes.
    These are the new ethtool link modes, so bitmask operations must be
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0d7354955d62..f5c2ba15d701 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -657,6 +657,7 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
 					unsigned long *supported,
 					struct phylink_link_state *state)
 {
+	unsigned long capabilities;
 	struct phylink_pcs *pcs;
 	int ret;
 
@@ -696,10 +697,17 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
 	}
 
 	/* Then validate the link parameters with the MAC */
-	if (pl->mac_ops->validate)
+	if (pl->mac_ops->validate) {
 		pl->mac_ops->validate(pl->config, supported, state);
-	else
-		phylink_generic_validate(pl->config, supported, state);
+	} else {
+		if (pl->mac_ops->mac_get_caps)
+			capabilities = pl->mac_ops->mac_get_caps(pl->config,
+							state->interface);
+		else
+			capabilities = pl->config->mac_capabilities;
+
+		phylink_validate_mask_caps(supported, state, capabilities);
+	}
 
 	return phylink_is_empty_linkmode(supported) ? -EINVAL : 0;
 }
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 2b886ea654bb..0798198a09ef 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -228,6 +228,7 @@ void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed);
 /**
  * struct phylink_mac_ops - MAC operations structure.
  * @validate: Validate and update the link configuration.
+ * @mac_get_caps: Get MAC capabilities for interface mode.
  * @mac_select_pcs: Select a PCS for the interface mode.
  * @mac_prepare: prepare for a major reconfiguration of the interface.
  * @mac_config: configure the MAC for the selected mode and state.
@@ -241,6 +242,8 @@ struct phylink_mac_ops {
 	void (*validate)(struct phylink_config *config,
 			 unsigned long *supported,
 			 struct phylink_link_state *state);
+	unsigned long (*mac_get_caps)(struct phylink_config *config,
+				      phy_interface_t interface);
 	struct phylink_pcs *(*mac_select_pcs)(struct phylink_config *config,
 					      phy_interface_t interface);
 	int (*mac_prepare)(struct phylink_config *config, unsigned int mode,
@@ -292,6 +295,18 @@ struct phylink_mac_ops {
  */
 void validate(struct phylink_config *config, unsigned long *supported,
 	      struct phylink_link_state *state);
+/**
+ * mac_get_caps: Get MAC capabilities for interface mode.
+ * @config: a pointer to a &struct phylink_config.
+ * @interface: PHY interface mode.
+ *
+ * Optional method. When not provided, config->mac_capabilities will be used.
+ * When implemented, this returns the MAC capabilities for the specified
+ * interface mode where there is some special handling required by the MAC
+ * driver (e.g. not supporting half-duplex in certain interface modes.)
+ */
+unsigned long mac_get_caps(struct phylink_config *config,
+			   phy_interface_t interface);
 /**
  * mac_select_pcs: Select a PCS for the interface mode.
  * @config: a pointer to a &struct phylink_config.
-- 
2.30.2


