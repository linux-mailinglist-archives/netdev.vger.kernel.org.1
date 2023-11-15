Return-Path: <netdev+bounces-47956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 154727EC15F
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0CA3B20B45
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9B1171B8;
	Wed, 15 Nov 2023 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OOUaNiMS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CBE171A9
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 11:39:33 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0700B101
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 03:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AtuKZGRr3qRmO03Of5QOO9pbvgkfvh2OJ3BN7Wq6FiQ=; b=OOUaNiMS4axlbuwHXYgui4cEsx
	2lf6FSz3rcK8vp78ucF7Zg/kZ5EfKOckzqdfsnxIcv8CpbTRdlVpj+l4vs6QaO+1xyiXZ96+mKl14
	OG3Fak77nJNbeBmQ7hD9qoWrsRDqW034fmb4QRizLV30IhGSftOfC4/WKRuLO1U5h1z0pwVBofyHM
	7oz7anIOCMADr66TkV5+qcNxHld8C9y1yG6mdANiEUKv2ekgymGDb5UHEhkraGNSStCmaCKYlgLsS
	ItGg5FRsHdhYn1W2uQo4bbqv+wmrAEdq0ksWqlkuYAJs++FmRbAqykZxbo8sDx+LYny/kxqQvywz5
	6tN9s1XQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47246 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r3EEw-0000ad-2g;
	Wed, 15 Nov 2023 11:39:26 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r3EEy-00CfCI-O7; Wed, 15 Nov 2023 11:39:28 +0000
In-Reply-To: <ZVSt2e9Z5swJNf+7@shell.armlinux.org.uk>
References: <ZVSt2e9Z5swJNf+7@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/3] net: sfp: use linkmode_*() rather than open
 coding
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r3EEy-00CfCI-O7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 15 Nov 2023 11:39:28 +0000

Use the linkmode_*() helpers rather than open coding the calls to the
bitmap operators.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/sfp-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index 208a9393c2df..6fa679b36290 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -328,7 +328,7 @@ void sfp_parse_support(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
 	 * modules use 2500Mbaud rather than 3100 or 3200Mbaud for
 	 * 2500BASE-X, so we allow some slack here.
 	 */
-	if (bitmap_empty(modes, __ETHTOOL_LINK_MODE_MASK_NBITS) && br_nom) {
+	if (linkmode_empty(modes) && br_nom) {
 		if (br_min <= 1300 && br_max >= 1200) {
 			phylink_set(modes, 1000baseX_Full);
 			__set_bit(PHY_INTERFACE_MODE_1000BASEX, interfaces);
-- 
2.30.2


