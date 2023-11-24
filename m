Return-Path: <netdev+bounces-50825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D574A7F73CB
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131831C20A12
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CA620B09;
	Fri, 24 Nov 2023 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="D0qa5dU4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BD2D71
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WUl6KG9zhwQ/eBRGuDJai/K+oPJ8cAljFtHiE99zKIs=; b=D0qa5dU4EfiUwWbBK1d8OcMGw8
	J4J3rbQEMeksLXozvowhN/G0g5YidcFxbUqtd2kRmkH9HpYX6Hpjum48lJF4Q4sDXzmaMw71vlp0h
	xf9JjvEpLDTV6i/V3R54rVOYMmOf5+krzimfsgU2+Ks17HpfRIQFkbHyfB3/BPzet0ZvGH3yZNjRe
	RBd+PDeOtHeZGYyE26uW0d7M1C3HZ8FyAd4Y4cXhNtZUidxVePz+OwKWABko1wzABccHY5B1gysAq
	RpeMO4+a8TkdfJl0sZFq8OzKDtbCUo1D2L/f2Yl5zYaqD7P3tDBq8gHCUQ7pQFJHxsWcsjo1C/LwS
	HINgxXNg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33090 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r6VIE-0002ti-18;
	Fri, 24 Nov 2023 12:28:22 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r6VIG-00DDLx-Cb; Fri, 24 Nov 2023 12:28:24 +0000
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
Subject: [PATCH net-next 07/10] net: phylink: pass PHY into
 phylink_validate_one()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r6VIG-00DDLx-Cb@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 24 Nov 2023 12:28:24 +0000

Pass the phy (if any) into phylink_validate_one() so that we can
validate each interface with its rate matching setting.

Tested-by: Luo Jie <quic_luoj@quicinc.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 11dd743141d5..52414af5c93f 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -689,7 +689,7 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
 	return phylink_is_empty_linkmode(supported) ? -EINVAL : 0;
 }
 
-static void phylink_validate_one(struct phylink *pl,
+static void phylink_validate_one(struct phylink *pl, struct phy_device *phy,
 				 const unsigned long *supported,
 				 const struct phylink_link_state *state,
 				 phy_interface_t interface,
@@ -704,6 +704,9 @@ static void phylink_validate_one(struct phylink *pl,
 	tmp_state = *state;
 	tmp_state.interface = interface;
 
+	if (phy)
+		tmp_state.rate_matching = phy_get_rate_matching(phy, interface);
+
 	if (!phylink_validate_mac_and_pcs(pl, tmp_supported, &tmp_state)) {
 		phylink_dbg(pl, " interface %u (%s) rate match %s supports %*pbl\n",
 			    interface, phy_modes(interface),
@@ -725,7 +728,7 @@ static int phylink_validate_mask(struct phylink *pl, unsigned long *supported,
 	int interface;
 
 	for_each_set_bit(interface, interfaces, PHY_INTERFACE_MODE_MAX)
-		phylink_validate_one(pl, supported, state, interface,
+		phylink_validate_one(pl, NULL, supported, state, interface,
 				     all_s, all_adv);
 
 	linkmode_copy(supported, all_s);
-- 
2.30.2


