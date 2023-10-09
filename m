Return-Path: <netdev+bounces-39052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856D07BD8DF
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 12:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A839F1C20A26
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070446FB9;
	Mon,  9 Oct 2023 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="M+TghXXA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6016434
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 10:40:00 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4479F
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 03:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eQTQxkT99gbQLkcHXnbxPYUEFWsdUMLYPIlH46TIrog=; b=M+TghXXAMmOY0kOwscfIpWtpYd
	K0PdP94vqcZbt8Bz3EsbT1d7wBKbpTkvTMdiCmlr9IoLJbJVMmL9R8GOGrlDTlyJyayGiYvTUtQgm
	5pvhwR/ksXhvsMHo+KDPcg/pOwe3gwql7UB66NVXzI2iHO2XHz9ajW/xKhU+pXedTfGRGEmlC9lvr
	hgMbCcfKcbNazV9CbM32x5fCVQ25w9mTy4r1n8AcAmFFIvGHoodNg1ukN8VX3zeqeQNZkS6Yzhifb
	nXH4ze/I3P55G+At8HTnDkjkXGVzgxCJ9/OnNtu2piu6jmrIW/l/F2TKlcKdnnO7JLljdzvmOdwJA
	PzM8iOsQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46958 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qpng2-0008MU-0o;
	Mon, 09 Oct 2023 11:39:54 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qpng3-009Ncs-EC; Mon, 09 Oct 2023 11:39:55 +0100
In-Reply-To: <ZSPOV+GhEQkwhoz9@shell.armlinux.org.uk>
References: <ZSPOV+GhEQkwhoz9@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next 3/3] net: dsa: remove dsa_port_phylink_validate()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qpng3-009Ncs-EC@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 09 Oct 2023 11:39:55 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As all drivers now provide phylink capabilities (including MAC), the
if() condition in dsa_port_phylink_validate() will always be true. We
will always use the generic validator, which phylink will call itself
if the .validate method isn't populated. Thus, there is now no need to
implement the .validate method, so this implementation can be removed.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 net/dsa/port.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 5f01bd4f9dec..6e0d000a97c4 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1554,20 +1554,6 @@ static struct phy_device *dsa_port_get_phy_device(struct dsa_port *dp)
 	return phydev;
 }
 
-static void dsa_port_phylink_validate(struct phylink_config *config,
-				      unsigned long *supported,
-				      struct phylink_link_state *state)
-{
-	/* Skip call for drivers which don't yet set mac_capabilities,
-	 * since validating in that case would mean their PHY will advertise
-	 * nothing. In turn, skipping validation makes them advertise
-	 * everything that the PHY supports, so those drivers should be
-	 * converted ASAP.
-	 */
-	if (config->mac_capabilities)
-		phylink_generic_validate(config, supported, state);
-}
-
 static struct phylink_pcs *
 dsa_port_phylink_mac_select_pcs(struct phylink_config *config,
 				phy_interface_t interface)
@@ -1666,7 +1652,6 @@ static void dsa_port_phylink_mac_link_up(struct phylink_config *config,
 }
 
 static const struct phylink_mac_ops dsa_port_phylink_mac_ops = {
-	.validate = dsa_port_phylink_validate,
 	.mac_select_pcs = dsa_port_phylink_mac_select_pcs,
 	.mac_prepare = dsa_port_phylink_mac_prepare,
 	.mac_config = dsa_port_phylink_mac_config,
-- 
2.30.2


