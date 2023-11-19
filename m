Return-Path: <netdev+bounces-49070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B8F7F0914
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 22:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24B11C20846
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 21:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297E1107AC;
	Sun, 19 Nov 2023 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RVHTk/yQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EED115
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 13:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=514jJBS+4BvDFkMU7gnrmpLSn5y8EtqlN9K55rcFhco=; b=RVHTk/yQbW3vXCNJ6WB6fXtw5F
	u4pUkCLAOVpbXCz2awHva+kGHXfm/soAxbqvkEVI6W9Jnw9oD5yXlXziaE6+EOuigRXlPe9pf5txl
	q/v/LsjkfWk0oiyH8KRmfgXXGIOw2u/dy209NRldI66DK7YP9bYb+wX2Q6QYU+CRcqnIOe4MapsL8
	TYNCzZor1CONyNNd9JhVW3XviI5KmS6JvXg8YmeMeFRRxJWMwlnmzlunMzQNIZMRUEvtDJ4NrOBkv
	jX09osfNQZzmyeGpYXnp6Jq49jgtqppQZKXDOw7hHhnK/u7AmjJjt60VOwqssd893UhKaGskgSpx6
	IBSJ14xg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58328 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r4p13-0004kw-1P;
	Sun, 19 Nov 2023 21:07:41 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r4p15-00Cpxe-C7; Sun, 19 Nov 2023 21:07:43 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] net: phylink: use for_each_set_bit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r4p15-00Cpxe-C7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 19 Nov 2023 21:07:43 +0000

Use for_each_set_bit() rather than open coding the for() test_bit()
loop.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index d2fa949ff1ea..c276f9482f78 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -697,18 +697,16 @@ static int phylink_validate_mask(struct phylink *pl, unsigned long *supported,
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
 
-- 
2.30.2


