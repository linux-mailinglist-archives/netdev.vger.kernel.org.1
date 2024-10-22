Return-Path: <netdev+bounces-137893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A79579AB09D
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24149B23B52
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBC219E994;
	Tue, 22 Oct 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oh/Nfdb+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B7328B6
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606635; cv=none; b=PjROdMhafhg40keQv6XdpdtJ7oLFzNfgHxsXK4kvJWgYQwjPu1fJX1hYjficC+l0T5WZRlvCBN2o3HfIrmCWuqI306pPp+5JF/lzhB/e5OFleBN5iJa2rrc0WRd1LGufogotyUxrbf/mW/8pMvTPqdSNHUbuLi3jAYKpVftGCiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606635; c=relaxed/simple;
	bh=kB4AQmKXnEj3mMwuybTVSyOiZK3Wl/5pqa6E4i3zPiE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=RcWuGgf8EM+HF/QywZ+G4ikct7FX6MlvbWAExQcw594kAdcNlezK2nLbyJ+0T6qFZ6AepljqE7fejCM1Z5eX3b3UAyMT6W2XxhUeSDwG5/8/WFJzLXde2qCWvei5MgaOniQr7DoHh9pRX4fHCblI2NB0vPPC2x9j6keECwL28Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oh/Nfdb+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7c9tnmhXOK/X9nFPJrdwQKm3/UQITbTdRclLDK9uWMo=; b=oh/Nfdb+K8LsbJfU0psGwEIQyK
	pAtBwsv9LW0irELsDkWxPtOII4Xv65SbKxjiUtKsTos17o4/wae3ldqAoffIiPK74sQqgqrHzV1IS
	4PZilPSyjWfWmmrEkuijO/ulnmG09qLADs8qpPWwx2wTN7E09MSNbV3Ap2Ri7kZCJsFrFWZOLg+6T
	6y3+O4fUtfJZvo+lYttfJTWMOsK45WWZQ0hGFKhkzaD+Q1PNlRBqpbxY+w1D+X3ltI6BgD11q7oPo
	SB8ZKzQTVACvUISkXJQ4GxJW+ES0EICgPrGXznK4Xbsgb22v/J8dDvD7ZywmW10dhI4bE+3MyE9y3
	gxauugzg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57356 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t3Fh5-00050N-1h;
	Tue, 22 Oct 2024 15:17:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t3Fh5-000aQi-Nk; Tue, 22 Oct 2024 15:17:07 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: phylink: simplify phylink_parse_fixedlink()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t3Fh5-000aQi-Nk@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 22 Oct 2024 15:17:07 +0100

phylink_parse_fixedlink() wants to preserve the pause, asym_pause and
autoneg bits in pl->supported. Rather than reading the bits into
separate bools, zeroing pl->supported, and then setting them if they
were previously set, use a mask and linkmode_and() to achieve the same
result.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 29206f72ab8b..6ca7ea970f51 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -764,8 +764,8 @@ static int phylink_validate(struct phylink *pl, unsigned long *supported,
 static int phylink_parse_fixedlink(struct phylink *pl,
 				   const struct fwnode_handle *fwnode)
 {
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
 	struct fwnode_handle *fixed_node;
-	bool pause, asym_pause, autoneg;
 	const struct phy_setting *s;
 	struct gpio_desc *desc;
 	u32 speed;
@@ -838,22 +838,15 @@ static int phylink_parse_fixedlink(struct phylink *pl,
 	linkmode_copy(pl->link_config.advertising, pl->supported);
 	phylink_validate(pl, pl->supported, &pl->link_config);
 
-	pause = phylink_test(pl->supported, Pause);
-	asym_pause = phylink_test(pl->supported, Asym_Pause);
-	autoneg = phylink_test(pl->supported, Autoneg);
 	s = phy_lookup_setting(pl->link_config.speed, pl->link_config.duplex,
 			       pl->supported, true);
-	linkmode_zero(pl->supported);
-	phylink_set(pl->supported, MII);
 
-	if (pause)
-		phylink_set(pl->supported, Pause);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, mask);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, mask);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, mask);
+	linkmode_and(pl->supported, pl->supported, mask);
 
-	if (asym_pause)
-		phylink_set(pl->supported, Asym_Pause);
-
-	if (autoneg)
-		phylink_set(pl->supported, Autoneg);
+	phylink_set(pl->supported, MII);
 
 	if (s) {
 		__set_bit(s->bit, pl->supported);
-- 
2.30.2


