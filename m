Return-Path: <netdev+bounces-41406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ED37CADDF
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 664B0B20F0C
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E642B5FE;
	Mon, 16 Oct 2023 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="reWTqXQD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC702E62E;
	Mon, 16 Oct 2023 15:43:09 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D277183;
	Mon, 16 Oct 2023 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vJRa6n/yvbGm0vpr/A2SjdFWmcjKfMU7QRBEDwYB6ik=; b=reWTqXQDWscBmiND6ky4cj9Dl+
	KYVkocTzyjG8P/7unz/w9c+zVVuvm+HqMiUKFcF2xEynt5UStuaXwAYMz4hx+Vo1DUpnJKrOwBBBu
	lekEywQ6cKWwBahRwETRfYNlBwyJKWorE1wsAG+MpuZa7KYQl4APi5n4EVjByr6Ounc3wI3Uewnh6
	Rtn0l8kFSmeQiduA5pFqWiRlpR/Ixz3vg/nUZ/0jZwaniGBixXQKINNtPTCJ++9g3XKCwghU5w2z3
	SXkFZTOaTNi77RGE1ZfCT+lCuAwMIqDC+pJ1fVPyqfY+53ogK9/tbmlNF1XUIp1ZES1etCZE4rinv
	7poode/Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57056 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qsPkE-0001fZ-1i;
	Mon, 16 Oct 2023 16:43:02 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qsPkF-009wij-QM; Mon, 16 Oct 2023 16:43:03 +0100
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
Subject: [PATCH net-next 3/4] net: phylink: remove .validate() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qsPkF-009wij-QM@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 16 Oct 2023 16:43:03 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The MAC .validate() method is no longer used, so remove it from the
phylink_mac_ops structure, and remove the callsite in
phylink_validate_mac_and_pcs().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 Documentation/networking/sfp-phylink.rst |  5 ----
 drivers/net/phy/phylink.c                | 16 ++++------
 include/linux/phylink.h                  | 38 ------------------------
 3 files changed, 6 insertions(+), 53 deletions(-)

diff --git a/Documentation/networking/sfp-phylink.rst b/Documentation/networking/sfp-phylink.rst
index b069d34d7f5c..8054d33f449f 100644
--- a/Documentation/networking/sfp-phylink.rst
+++ b/Documentation/networking/sfp-phylink.rst
@@ -207,11 +207,6 @@ this documentation.
    capabilities for ``interface`` to determine the allowable ethtool link
    modes.
 
-   The :c:func:`validate` method should mask the supplied supported mask,
-   and ``state->advertising`` with the supported ethtool link modes.
-   These are the new ethtool link modes, so bitmask operations must be
-   used. For an example, see ``drivers/net/ethernet/marvell/mvneta.c``.
-
    The :c:func:`mac_link_state` method is used to read the link state
    from the MAC, and report back the settings that the MAC is currently
    using. This is particularly important for in-band negotiation
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index f5c2ba15d701..1c7e73fa58e4 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -697,17 +697,13 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
 	}
 
 	/* Then validate the link parameters with the MAC */
-	if (pl->mac_ops->validate) {
-		pl->mac_ops->validate(pl->config, supported, state);
-	} else {
-		if (pl->mac_ops->mac_get_caps)
-			capabilities = pl->mac_ops->mac_get_caps(pl->config,
-							state->interface);
-		else
-			capabilities = pl->config->mac_capabilities;
+	if (pl->mac_ops->mac_get_caps)
+		capabilities = pl->mac_ops->mac_get_caps(pl->config,
+							 state->interface);
+	else
+		capabilities = pl->config->mac_capabilities;
 
-		phylink_validate_mask_caps(supported, state, capabilities);
-	}
+	phylink_validate_mask_caps(supported, state, capabilities);
 
 	return phylink_is_empty_linkmode(supported) ? -EINVAL : 0;
 }
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 0798198a09ef..0cf559bae1ff 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -227,7 +227,6 @@ void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed);
 
 /**
  * struct phylink_mac_ops - MAC operations structure.
- * @validate: Validate and update the link configuration.
  * @mac_get_caps: Get MAC capabilities for interface mode.
  * @mac_select_pcs: Select a PCS for the interface mode.
  * @mac_prepare: prepare for a major reconfiguration of the interface.
@@ -239,9 +238,6 @@ void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed);
  * The individual methods are described more fully below.
  */
 struct phylink_mac_ops {
-	void (*validate)(struct phylink_config *config,
-			 unsigned long *supported,
-			 struct phylink_link_state *state);
 	unsigned long (*mac_get_caps)(struct phylink_config *config,
 				      phy_interface_t interface);
 	struct phylink_pcs *(*mac_select_pcs)(struct phylink_config *config,
@@ -261,40 +257,6 @@ struct phylink_mac_ops {
 };
 
 #if 0 /* For kernel-doc purposes only. */
-/**
- * validate - Validate and update the link configuration
- * @config: a pointer to a &struct phylink_config.
- * @supported: ethtool bitmask for supported link modes.
- * @state: a pointer to a &struct phylink_link_state.
- *
- * Clear bits in the @supported and @state->advertising masks that
- * are not supportable by the MAC.
- *
- * Note that the PHY may be able to transform from one connection
- * technology to another, so, eg, don't clear 1000BaseX just
- * because the MAC is unable to BaseX mode. This is more about
- * clearing unsupported speeds and duplex settings. The port modes
- * should not be cleared; phylink_set_port_modes() will help with this.
- *
- * When @config->supported_interfaces has been set, phylink will iterate
- * over the supported interfaces to determine the full capability of the
- * MAC. The validation function must not print errors if @state->interface
- * is set to an unexpected value.
- *
- * When @config->supported_interfaces is empty, phylink will call this
- * function with @state->interface set to %PHY_INTERFACE_MODE_NA, and
- * expects the MAC driver to return all supported link modes.
- *
- * If the @state->interface mode is not supported, then the @supported
- * mask must be cleared.
- *
- * This member is optional; if not set, the generic validator will be
- * used making use of @config->mac_capabilities and
- * @config->supported_interfaces to determine which link modes are
- * supported.
- */
-void validate(struct phylink_config *config, unsigned long *supported,
-	      struct phylink_link_state *state);
 /**
  * mac_get_caps: Get MAC capabilities for interface mode.
  * @config: a pointer to a &struct phylink_config.
-- 
2.30.2


