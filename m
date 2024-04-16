Return-Path: <netdev+bounces-88264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E018A6825
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0103FB2160B
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE98A127B66;
	Tue, 16 Apr 2024 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VYiRPX7C"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692E11272C0
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262760; cv=none; b=ulId6bu0E6Lsry+SMtDN8/WaGzFNhLNufl4VhPGRD3FuQX2YgwhddaWGkNQQBiKSyVpwNhHPaiDQVFQ/PcqnbSJWbVltwVkB559QQ2NYfvOZ1/ZQfG1bzZOg++N8xS7axZeAovzHA7xiro+QRaUqAmy9d9FGE2anV603od97jiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262760; c=relaxed/simple;
	bh=0i0fbq7ZxCufz1qM95HmCtNJSK/7T7s2UOROhSGFAvo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=geEQ5W0zLp+pvGgY98XH+LIeVIcgohp8OlgXHn6j0ao+3q09i1uOJmdaVu5UAwhdX1n/Rd/Ar/TzCXhBtLizo2mbNuUQQVTjzB/jALnsr5hEYDr1RLAJuYSMYZZujbnv7cxokJLs86mNBj4H1tgbulvNd23svPoy7dCB+28Ewe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VYiRPX7C; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZJdesVBGXpllB0+wd5jNhT03t0Bq07oYWxkGLqR0mQ0=; b=VYiRPX7C5s6dSMhqi2w3d61KOC
	W6hVoy0t/yHsiFOxZLS8HJ2iiSJFyIiV3tjP2T9KQfF8/5Zdwmlx3PjurPE7mUz27NSIXMdMTS668
	4BzPxBhVHdrdaHC91pLESYcBo2Q6gwd7ba53VWiAAt6e2uoLcTu4yyfb8u8MZKxHm+ZtcGIYDlKfx
	BVasPjANpX6uFfgomxWL8qv3xAEqE9pGTfbhowBoHRzLrJa+bu9x+nuH9PtM+cDxwSnD18Psd6GUw
	icv5BjqbE1ouHPiKkozFAAeB70oajA5KdiiHkac0mlw7TkMQSB18oUVPJoz0SmesNJaZVkUInMYHp
	QvnJ/ugw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49976 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rwfu8-0008Pt-0E;
	Tue, 16 Apr 2024 11:19:08 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rwfu8-007531-TG; Tue, 16 Apr 2024 11:19:08 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Vladimir Oltean <olteanv@gmail.com>
Cc: George McCollister <george.mccollister@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: xrs700x: provide own phylink MAC
 operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rwfu8-007531-TG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 16 Apr 2024 11:19:08 +0100

Convert xrs700x to provide its own phylink MAC operations, thus
avoiding the shim layer in DSA's port.c. We need to provide stubs for
the mac_link_down() and mac_config() methods which are mandatory.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/xrs700x/xrs700x.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/xrs700x/xrs700x.c b/drivers/net/dsa/xrs700x/xrs700x.c
index 96db032b478f..6605fa44bcf0 100644
--- a/drivers/net/dsa/xrs700x/xrs700x.c
+++ b/drivers/net/dsa/xrs700x/xrs700x.c
@@ -466,13 +466,25 @@ static void xrs700x_phylink_get_caps(struct dsa_switch *ds, int port,
 	}
 }
 
-static void xrs700x_mac_link_up(struct dsa_switch *ds, int port,
-				unsigned int mode, phy_interface_t interface,
+static void xrs700x_mac_config(struct phylink_config *config, unsigned int mode,
+			       const struct phylink_link_state *state)
+{
+}
+
+static void xrs700x_mac_link_down(struct phylink_config *config,
+				  unsigned int mode, phy_interface_t interface)
+{
+}
+
+static void xrs700x_mac_link_up(struct phylink_config *config,
 				struct phy_device *phydev,
+				unsigned int mode, phy_interface_t interface,
 				int speed, int duplex,
 				bool tx_pause, bool rx_pause)
 {
-	struct xrs700x *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct xrs700x *priv = dp->ds->priv;
+	int port = dp->index;
 	unsigned int val;
 
 	switch (speed) {
@@ -699,13 +711,18 @@ static int xrs700x_hsr_leave(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static const struct phylink_mac_ops xrs700x_phylink_mac_ops = {
+	.mac_config		= xrs700x_mac_config,
+	.mac_link_down		= xrs700x_mac_link_down,
+	.mac_link_up		= xrs700x_mac_link_up,
+};
+
 static const struct dsa_switch_ops xrs700x_ops = {
 	.get_tag_protocol	= xrs700x_get_tag_protocol,
 	.setup			= xrs700x_setup,
 	.teardown		= xrs700x_teardown,
 	.port_stp_state_set	= xrs700x_port_stp_state_set,
 	.phylink_get_caps	= xrs700x_phylink_get_caps,
-	.phylink_mac_link_up	= xrs700x_mac_link_up,
 	.get_strings		= xrs700x_get_strings,
 	.get_sset_count		= xrs700x_get_sset_count,
 	.get_ethtool_stats	= xrs700x_get_ethtool_stats,
-- 
2.30.2


