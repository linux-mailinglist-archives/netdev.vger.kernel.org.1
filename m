Return-Path: <netdev+bounces-21433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B4E763978
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4D1281F34
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77EF1DA3B;
	Wed, 26 Jul 2023 14:45:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE811DA27
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:45:27 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A121BF2
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j31ms1ChU/V/xRNailWaZ1oO2kKqhcW/c4es6Q2G9Pw=; b=Yydm/1swu2tuOg4uAYCVL3vTUq
	4+r0x/KoCSEDHHSqlzOgtI6naa6x0/+2G9x4Zc0mOAwuN+ZpAh0RomCXm7XFPW/6/gqhpW3hNGQPb
	pCT/AXqHcwLM6JxGjHMcKWvoj6sOQGH+Jrk3oXEteNuXWBEbZaJKJgNXDGgzOA9j3O3VBC6+8zldq
	+qAfNw7YsEMzpeNJd/csfevR73m291D9hbhtix1aKYwmLaRSpVsKa+cqwMO0HnId07Ho3e3UZeSOc
	mjopMv0Qqn+5U4Md6lP3cspXLtTt9Pazidpsl5tKJvWY31Naftr2kq7V7vZVbd0+nOeliANH8bBlP
	sx29MOsQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33758 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qOflM-0004Y7-1C;
	Wed, 26 Jul 2023 15:45:16 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qOflM-001AEz-D3; Wed, 26 Jul 2023 15:45:16 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net] net: dsa: fix older DSA drivers using phylink
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qOflM-001AEz-D3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 26 Jul 2023 15:45:16 +0100
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Older DSA drivers that do not provide an dsa_ops adjust_link method end
up using phylink. Unfortunately, a recent phylink change that requires
its supported_interfaces bitmap to be filled breaks these drivers
because the bitmap remains empty.

Rather than fixing each driver individually, fix it in the core code so
we have a sensible set of defaults.

Reported-by: Sergei Antonov <saproj@gmail.com>
Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be filled")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 net/dsa/port.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 0ce8fd311c78..2f6195d7b741 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1727,8 +1727,15 @@ int dsa_port_phylink_create(struct dsa_port *dp)
 	    ds->ops->phylink_mac_an_restart)
 		dp->pl_config.legacy_pre_march2020 = true;
 
-	if (ds->ops->phylink_get_caps)
+	if (ds->ops->phylink_get_caps) {
 		ds->ops->phylink_get_caps(ds, dp->index, &dp->pl_config);
+	} else {
+		/* For legacy drivers */
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  dp->pl_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_GMII,
+			  dp->pl_config.supported_interfaces);
+	}
 
 	pl = phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn),
 			    mode, &dsa_port_phylink_mac_ops);
-- 
2.30.2


