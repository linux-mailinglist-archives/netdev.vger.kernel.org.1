Return-Path: <netdev+bounces-41404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FA47CADDB
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA742B20E64
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EA42C84A;
	Mon, 16 Oct 2023 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eWlwq27E"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ACB2AB23;
	Mon, 16 Oct 2023 15:43:04 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47FDAB;
	Mon, 16 Oct 2023 08:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RIF1Y7UsyoqksolgEuNqtzMryFLWp1UkhBcEXy8CtJc=; b=eWlwq27Eagm6FF+ohfawheTz+J
	+Y/lohtYbcesOYCdyMTsejipzVf5QXJ0AISD5nJSIfvR9+a1Ie459FnaQizoVeiZwG7XlBjruoXOY
	0naDpDNXoYNYcB6I4KLxUKw0aQN0UxQycGC/pyw66D/+ITYF2BthmxkN+TehO83BtwN57mRhpyzLh
	KB3Y70TemrNZ0uo2NC/jfp2+mdiguUiMtQjla0ImWOeOlVSdsu6BbtC7CIMFHNZgAlQfav95jyHFL
	NgWvndXxiEcqc88XTK1tsLe1Qdr4ETgpCSRNEJwSNQQYXWDSR1SDdHlafgIbygiwrt3FrPpSKb0F8
	6Ni1gdOg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57050 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qsPk9-0001fK-15;
	Mon, 16 Oct 2023 16:42:57 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qsPkA-009wid-Kv; Mon, 16 Oct 2023 16:42:58 +0100
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
Subject: [PATCH net-next 2/4] net: fman: convert to .mac_get_caps()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qsPkA-009wid-Kv@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 16 Oct 2023 16:42:58 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Convert fman to use the .mac_get_caps() method rather than the
.validate() method.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/freescale/fman/fman_memac.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index 3b75cc543be9..9ba15d3183d7 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -618,18 +618,17 @@ static int memac_accept_rx_pause_frames(struct fman_mac *memac, bool en)
 	return 0;
 }
 
-static void memac_validate(struct phylink_config *config,
-			   unsigned long *supported,
-			   struct phylink_link_state *state)
+static unsigned long memac_get_caps(struct phylink_config *config,
+				    phy_interface_t interface)
 {
 	struct fman_mac *memac = fman_config_to_mac(config)->fman_mac;
 	unsigned long caps = config->mac_capabilities;
 
-	if (phy_interface_mode_is_rgmii(state->interface) &&
+	if (phy_interface_mode_is_rgmii(interface) &&
 	    memac->rgmii_no_half_duplex)
 		caps &= ~(MAC_10HD | MAC_100HD);
 
-	phylink_validate_mask_caps(supported, state, caps);
+	return caps;
 }
 
 /**
@@ -776,7 +775,7 @@ static void memac_link_down(struct phylink_config *config, unsigned int mode,
 }
 
 static const struct phylink_mac_ops memac_mac_ops = {
-	.validate = memac_validate,
+	.mac_get_caps = memac_get_caps,
 	.mac_select_pcs = memac_select_pcs,
 	.mac_prepare = memac_prepare,
 	.mac_config = memac_mac_config,
-- 
2.30.2


