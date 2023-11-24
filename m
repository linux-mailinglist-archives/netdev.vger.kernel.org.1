Return-Path: <netdev+bounces-50824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F97F73CA
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D81C281EB9
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27B228378;
	Fri, 24 Nov 2023 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="K+9c7QHR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC69D71
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2CFPbyibtVfOsRf+YphPOock4Nnbi1wbF+Z1LjAfT6E=; b=K+9c7QHRtya2hMc/4XG0neQbmS
	6zbcRktYUwcE7IAVuh9Tvcyd32k4F8bHfYZPdrVnU51cDzqIl3Y3NzGQEGPPAnEsrIbdZG3/sqKpC
	TxDIHlHMVkUwaMGHqKp+zvt3Lcy5lzlN/ZtHvx6U7HUe6I7LuaffNxNJGLAKE3WS3HXK1DDgVbf47
	b+tRGt8bqdjdm+iLYzTbapRhavutj2isydL4ktfMBXADyenYNQez7osyrrqY9eu27itN4vDWEAoJE
	CkLJ1owKUR+ybfyvIvAstLR5S6/x0opE8IJjJzoi/csOygqbCL1Okcffk9FMnkUYLjl0+WpiD/UTJ
	zxZC0z3Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33084 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r6VI9-0002tT-0f;
	Fri, 24 Nov 2023 12:28:17 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r6VIB-00DDLr-7g; Fri, 24 Nov 2023 12:28:19 +0000
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
Subject: [PATCH net-next 06/10] net: phylink: split out per-interface
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
Message-Id: <E1r6VIB-00DDLr-7g@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 24 Nov 2023 12:28:19 +0000

Split out the internals of phylink_validate_mask() to make the code
easier to read.

Tested-by: Luo Jie <quic_luoj@quicinc.com>
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


