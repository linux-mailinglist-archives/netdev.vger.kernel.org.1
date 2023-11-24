Return-Path: <netdev+bounces-50826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 790637F73CC
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9281C20E4E
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4572837D;
	Fri, 24 Nov 2023 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DLzDYsYC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391EDD43
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0+7DNIHJOkWskatzhZyRnUlymUx+Hw8Q9v8VSANpLRI=; b=DLzDYsYCMNnY0zfSYYtqJYn3n2
	RdAL5rnizFUc8YMT62V8xBdh7MpPIZ3Nyh8rdMzvv+MSHIs6UDk05UiC7fvNQj7vStuBU5Wam1dds
	GqZQ9U0K70Jehr3gavuXif73qDhgNRR8PXlu3gy5CEmU3DjEPmIPpUmLGf7eRM1o/1btCoUjqiKpz
	cZcor5GIDn7MszXNsdbqqbHKVorfGZ/cloB3WiBlaeHxrNh//8rAY7z7Q384+ji4ZKstAPXtbBeYD
	J0rptiFSZebw2Wecou8ivMMfPu9tvmhxNMx3/X3qRZeE5vOyma/bT1EqYeympnDLJfQ9rMkvjgeVt
	mjkhf7zw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59298 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r6VIJ-0002tv-1X;
	Fri, 24 Nov 2023 12:28:27 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r6VIL-00DDM3-HJ; Fri, 24 Nov 2023 12:28:29 +0000
In-Reply-To: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
References: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 08/10] net: phylink: pass PHY into
 phylink_validate_mask()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r6VIL-00DDM3-HJ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 24 Nov 2023 12:28:29 +0000

Pass the phy (if any) into phylink_validate_mask() so that we can
validate each interface with its rate matching setting.

Tested-by: Luo Jie <quic_luoj@quicinc.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 52414af5c93f..ac48a1db9979 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -719,7 +719,8 @@ static void phylink_validate_one(struct phylink *pl, struct phy_device *phy,
 	}
 }
 
-static int phylink_validate_mask(struct phylink *pl, unsigned long *supported,
+static int phylink_validate_mask(struct phylink *pl, struct phy_device *phy,
+				 unsigned long *supported,
 				 struct phylink_link_state *state,
 				 const unsigned long *interfaces)
 {
@@ -728,7 +729,7 @@ static int phylink_validate_mask(struct phylink *pl, unsigned long *supported,
 	int interface;
 
 	for_each_set_bit(interface, interfaces, PHY_INTERFACE_MODE_MAX)
-		phylink_validate_one(pl, NULL, supported, state, interface,
+		phylink_validate_one(pl, phy, supported, state, interface,
 				     all_s, all_adv);
 
 	linkmode_copy(supported, all_s);
@@ -743,7 +744,8 @@ static int phylink_validate(struct phylink *pl, unsigned long *supported,
 	const unsigned long *interfaces = pl->config->supported_interfaces;
 
 	if (state->interface == PHY_INTERFACE_MODE_NA)
-		return phylink_validate_mask(pl, supported, state, interfaces);
+		return phylink_validate_mask(pl, NULL, supported, state,
+					     interfaces);
 
 	if (!test_bit(state->interface, interfaces))
 		return -EINVAL;
@@ -3179,7 +3181,8 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 	/* For all the interfaces that are supported, reduce the sfp_support
 	 * mask to only those link modes that can be supported.
 	 */
-	ret = phylink_validate_mask(pl, pl->sfp_support, &config, interfaces);
+	ret = phylink_validate_mask(pl, NULL, pl->sfp_support, &config,
+				    interfaces);
 	if (ret) {
 		phylink_err(pl, "unsupported SFP module: validation with support %*pb failed\n",
 			    __ETHTOOL_LINK_MODE_MASK_NBITS, support);
-- 
2.30.2


