Return-Path: <netdev+bounces-24136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0843876EEC8
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A6A1C215DF
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A8324168;
	Thu,  3 Aug 2023 15:56:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0709182C8
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 15:56:44 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60D33A9A
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I10oY8Hl8vWefNceKI3VUQ2LHqzlwumwJI8aH+Zj7FI=; b=GUnyuz80+pDDRWfbXMl+XoXkUq
	U+Q6t5+zx/+IvNh0HIrKcsT2VUBwn+wv0RoOd9ebEMpzETDcruVAc/P0h8Yr/GRaSBCz5UOLzfU4D
	21WMifpibk+2pwWf4o3K+FzrtjB1acF5X/yYxv6f46QiRJLGPoab+xvU4TwWQwbo5YEcugkcfBHG8
	HcOhMGa2X9CDFqy/veu43kOLeg0stVnymkZq1J5xJ+eSI6e5nHvOG+lFtY+6GBDzgE2Ygv6FD5hzD
	hSf18lAIY+f+b+9eN6bVfAGXuS/v8MYkiBKrmSgOjBHezB9zY6spOqc2H82TJIDnJ53SHbp4u9vHa
	HI/onFhQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48320 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qRaga-000787-0X;
	Thu, 03 Aug 2023 16:56:24 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qRaga-001vKt-8X; Thu, 03 Aug 2023 16:56:24 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: phy: move marking PHY on SFP module into
 SFP code
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qRaga-001vKt-8X@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 03 Aug 2023 16:56:24 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move marking the PHY as being on a SFP module into the SFP code between
getting the PHY device (and thus initialising the phy_device structure)
and registering the discovered device.

This means that PHY drivers can use phy_on_sfp() in their match and
get_features methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Eric Woudstra has a SFP module that has a realtek PHY on that could
be driven by the realtek PHY driver - except that the PHY is behind
a Rollball access implementation that only supports clause 45 access.

This is a work in progress, but it seems useful in these situations
that drivers should know whether the PHY is on a module very early on,
so that a particular PHY driver instance can choose whether or not to
drive the instance, or maybe use a different PHY driver instance to
drive it - thus allowing a separate set of function pointers for the
clause-45 only accessable PHY.

Some experimental patches can be found at:

https://gist.github.com/ericwoud/d912301a93cd41b39621a65cc372a5c0#file-0000-oem-sfp-2-5g-t-patches-realtek-short-c

and onward discussion prompted this patch. Ignore the first non-patch
C file!

Tested on Armada 388 Clearfog (with additional code in phy_probe() to
print the state of phy_on_sfp().)

 drivers/net/phy/phy_device.c | 2 --
 drivers/net/phy/sfp.c        | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 61921d4dbb13..da544faf1661 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1487,8 +1487,6 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 		if (phydev->sfp_bus_attached)
 			dev->sfp_bus = phydev->sfp_bus;
-		else if (dev->sfp_bus)
-			phydev->is_on_sfp_module = true;
 	}
 
 	/* Some Ethernet drivers try to connect to a PHY device before
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index d855a18308d7..4ecfac227865 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1763,6 +1763,9 @@ static int sfp_sm_probe_phy(struct sfp *sfp, int addr, bool is_c45)
 		return PTR_ERR(phy);
 	}
 
+	/* Mark this PHY as being on a SFP module */
+	phy->is_on_sfp_module = true;
+
 	err = phy_device_register(phy);
 	if (err) {
 		phy_device_free(phy);
-- 
2.30.2


