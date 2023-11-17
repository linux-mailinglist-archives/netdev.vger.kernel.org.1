Return-Path: <netdev+bounces-48679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56CF7EF31D
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 13:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6BFB209A8
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB282FE3A;
	Fri, 17 Nov 2023 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BplqTlgB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92E7D5C
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 04:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tlSpC6H3tk3ffjTtHtu78Ey9L8tuFjAc0oy9uoABr9E=; b=BplqTlgBTGJ2b9MjJyby83f31e
	1yxez5sU2R2V9Mu9kJC1+K6GAGp2FWMSEYH6YqjGIQj06dkvyPMqworXZ6m4Eeu82oV2Z0+5BtCG0
	Gs/e8Wiylbi5zpeHQ/NntGN77Sm0j82+IGWvKtSNsExuyvr/ZdEXWm/G/DgteFgGfykSMP7dBT+jx
	MUiz1u9PdCbzXr8nkwDMWLhIwwLnX7G6OPBEhWNm+bHnxXFXVfWp2znvTEn+bqXCG2hO/GSCPRLSF
	9JHdEOTtHjufFJ5mC8hAKiVpL07TP/SuBf7Mby2WrAWwtp0VMgk2Z30OBG7zQXJ13oMAJugDtbyba
	VTigOuVw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60560 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r3yPm-0002rC-29;
	Fri, 17 Nov 2023 12:57:42 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r3yPo-00CnKQ-JG; Fri, 17 Nov 2023 12:57:44 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: phylink: use for_each_set_bit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r3yPo-00CnKQ-JG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 17 Nov 2023 12:57:44 +0000

Use for_each_set_bit() rather than open coding the for() test_bit()
loop.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index d2fa949ff1ea..4d0f39410ad0 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -697,21 +697,20 @@ static int phylink_validate_mask(struct phylink *pl, unsigned long *supported,
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(all_s) = { 0, };
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(s);
 	struct phylink_link_state t;
-	int intf;
+	int interface;
 
-	for (intf = 0; intf < PHY_INTERFACE_MODE_MAX; intf++) {
-		if (test_bit(intf, interfaces)) {
-			linkmode_copy(s, supported);
+	for_each_set_bit(interface, interfaces, PHY_INTERFACE_MODE_MAX) {
+		linkmode_copy(s, supported);
 
-			t = *state;
-			t.interface = intf;
-			if (!phylink_validate_mac_and_pcs(pl, s, &t)) {
-				linkmode_or(all_s, all_s, s);
-				linkmode_or(all_adv, all_adv, t.advertising);
-			}
+		t = *state;
+		t.interface = interface;
+		if (!phylink_validate_mac_and_pcs(pl, s, &t)) {
+			linkmode_or(all_s, all_s, s);
+			linkmode_or(all_adv, all_adv, t.advertising);
 		}
 	}
 
+
 	linkmode_copy(supported, all_s);
 	linkmode_copy(state->advertising, all_adv);
 
-- 
2.30.2


