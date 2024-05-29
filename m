Return-Path: <netdev+bounces-99032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 660FE8D379D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223FC287994
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1070B134D1;
	Wed, 29 May 2024 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="n5UU+q/0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D64D12E7E
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989373; cv=none; b=U5/kYSTOTIFqCuMTrsuy7vXpSS4X9tgwgKBlNqjzZo8JQf4KyTbbaW98UQjUtXUieDQuXDw5t9VJa26GqoUwhkikRAbSiMS7LGPPGPcd/j/scW0SMYK7MKHK8x7Lp8zga/+0IoshAg4TL5c3htZCCEINi7+FTyVVzyXkTjFNl5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989373; c=relaxed/simple;
	bh=e4Rve+86ThEL12SV4fP+Xz2rtCXS1IP63nfZ4j4Bq34=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ZWOKweWjSFGnjxCKXhKEqS7VrfSqgglYAFJyhdkaIQf5B/WatVD/u+dTpn13PjOcgovRjD/yy89AoucAiv5psgIyXPa9nA9+1msh6yb98cs0MlEdXGyZZnks3sHWc/B/dIP8EZqvAEsHbksyl14nVsCDdlyBbGVDiEooyyHLfY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=n5UU+q/0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0nQ7u6L97LCdFFVUjGvL2ohDdGy+s5i+RiEbfyEYVuk=; b=n5UU+q/0e8ySAW6l5/F5Zj5mVJ
	XyXq58iuNvCcWD2eaSYtRTHIdsvUs8m3f9aTBBzGM14CyAvxkGRlVH9B3bJRm83ueIqokrJvOHNgp
	OlXgFaVsiSKSmal2zOJvSjHdyU+mctxAKzDhIwcH5UH3GPgpjO0HAuN6eGdrlDmOs0dB7ueVUj3c3
	oGjwJ8OvIRyk6o/xM0RsoGgt3YnHL9o9ZXqBWKBfk9awdvaiArTgO/OvkWpFXu0TXQdqvighX5Zdw
	HfGkD7h0xl9VjKAnlmi+ad7odx5R5CRrIxsyxFo50OpM1aJnmkuwhYfRK2GV2vA1kQFG8fTGrjWNY
	TIG5rm8Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55560 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sCJMo-0006A4-07;
	Wed, 29 May 2024 14:29:22 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sCJMq-00Ecqv-P8; Wed, 29 May 2024 14:29:24 +0100
In-Reply-To: <ZlctinnTT8Xhemsm@shell.armlinux.org.uk>
References: <ZlctinnTT8Xhemsm@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	 Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/6] net: phylink: move test for ovr_an_inband
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sCJMq-00Ecqv-P8@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 May 2024 14:29:24 +0100

Of the two users of phylink_config->ovr_an_inband, both manually check
for a fixed link before setting this flag (or clearing it if they find
a fixed link.) This is unnecessary complication.

Test ovr_an_inband before checking for the fixed-link properties, which
will allow ovr_an_inband to be overriden by a fixed link specification.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 5abd12713598..c81f1c1ee675 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -885,14 +885,16 @@ static int phylink_parse_mode(struct phylink *pl,
 	const char *managed;
 	unsigned long caps;
 
+	if (pl->config->ovr_an_inband)
+		pl->cfg_link_an_mode = MLO_AN_INBAND;
+
 	dn = fwnode_get_named_child_node(fwnode, "fixed-link");
 	if (dn || fwnode_property_present(fwnode, "fixed-link"))
 		pl->cfg_link_an_mode = MLO_AN_FIXED;
 	fwnode_handle_put(dn);
 
 	if ((fwnode_property_read_string(fwnode, "managed", &managed) == 0 &&
-	     strcmp(managed, "in-band-status") == 0) ||
-	    pl->config->ovr_an_inband) {
+	     strcmp(managed, "in-band-status") == 0)) {
 		if (pl->cfg_link_an_mode == MLO_AN_FIXED) {
 			phylink_err(pl,
 				    "can't use both fixed-link and in-band-status\n");
-- 
2.30.2


