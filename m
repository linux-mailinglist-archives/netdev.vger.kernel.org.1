Return-Path: <netdev+bounces-50114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8627F4A49
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23343B2100A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998E15102E;
	Wed, 22 Nov 2023 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FTugl8OI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B9611F
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9Fycx6buKYhHvCg5aT8NUYctGbTQUME267VJAhu1KJk=; b=FTugl8OIuqnPwVwGr8UMbLTA67
	dAV2S6RvgC7gojc0957lDFvycx6Ft/e81PvNtXYK4FygKG77A0iOuZPlNE5m5MzDiUgY0ZBpMJmTM
	FQ9awXjNlRM4gB6shvoF7n5jUB9/IswbfuEG6/zPm5o2VJS7kPCwlhcEwTBHGIpi2AvNNbM5PZbKQ
	UpO8pOj5c0gvI/jnudBWEXcG/anfoqlA2DrC93uN0wzgQFO18gZCjztTCZikG8rIv2/O2k4/+drz6
	wZWVQ/ajwjumKgQIDHWLUo9hGyH5emtr16RvK/fejrcGRYb5LxZ4KawA1KDDDCjdeF2gx7dP1CNog
	3UZ39vPw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47552 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r5pCY-0000Lf-27;
	Wed, 22 Nov 2023 15:31:42 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r5pCa-00DAHP-Kc; Wed, 22 Nov 2023 15:31:44 +0000
In-Reply-To: <ZV4eolj9AI0b37y6@shell.armlinux.org.uk>
References: <ZV4eolj9AI0b37y6@shell.armlinux.org.uk>
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
Subject: [PATCH RFC net-next 06/10] net: phylink: split out per-interface
 validation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r5pCa-00DAHP-Kc@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 22 Nov 2023 15:31:44 +0000

Split out the internals of phylink_validate_mask() to make the code
easier to read.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 42 ++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index c276f9482f78..11dd743141d5 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -689,26 +689,44 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
 	return phylink_is_empty_linkmode(supported) ? -EINVAL : 0;
 }
 
+static void phylink_validate_one(struct phylink *pl,
+				 const unsigned long *supported,
+				 const struct phylink_link_state *state,
+				 phy_interface_t interface,
+				 unsigned long *accum_supported,
+				 unsigned long *accum_advertising)
+{
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp_supported);
+	struct phylink_link_state tmp_state;
+
+	linkmode_copy(tmp_supported, supported);
+
+	tmp_state = *state;
+	tmp_state.interface = interface;
+
+	if (!phylink_validate_mac_and_pcs(pl, tmp_supported, &tmp_state)) {
+		phylink_dbg(pl, " interface %u (%s) rate match %s supports %*pbl\n",
+			    interface, phy_modes(interface),
+			    phy_rate_matching_to_str(tmp_state.rate_matching),
+			    __ETHTOOL_LINK_MODE_MASK_NBITS, tmp_supported);
+
+		linkmode_or(accum_supported, accum_supported, tmp_supported);
+		linkmode_or(accum_advertising, accum_advertising,
+			    tmp_state.advertising);
+	}
+}
+
 static int phylink_validate_mask(struct phylink *pl, unsigned long *supported,
 				 struct phylink_link_state *state,
 				 const unsigned long *interfaces)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(all_adv) = { 0, };
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(all_s) = { 0, };
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(s);
-	struct phylink_link_state t;
 	int interface;
 
-	for_each_set_bit(interface, interfaces, PHY_INTERFACE_MODE_MAX) {
-		linkmode_copy(s, supported);
-
-		t = *state;
-		t.interface = interface;
-		if (!phylink_validate_mac_and_pcs(pl, s, &t)) {
-			linkmode_or(all_s, all_s, s);
-			linkmode_or(all_adv, all_adv, t.advertising);
-		}
-	}
+	for_each_set_bit(interface, interfaces, PHY_INTERFACE_MODE_MAX)
+		phylink_validate_one(pl, supported, state, interface,
+				     all_s, all_adv);
 
 	linkmode_copy(supported, all_s);
 	linkmode_copy(state->advertising, all_adv);
-- 
2.30.2


