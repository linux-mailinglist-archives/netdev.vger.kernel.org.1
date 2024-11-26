Return-Path: <netdev+bounces-147362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2621D9D9499
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21670B2CCB5
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A301D0B82;
	Tue, 26 Nov 2024 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="S11dqHZK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250638DE0
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613087; cv=none; b=G9V2bC8a66x5KOR1U4SJjxsEMcl+hHCefQ3oDRgmT8WgCxZikVAYvBl3OfHi3pvJHfmIvob1ru8rJuDPSCsoAP8CcYV/lC/5Lba0MM2mBTvhWFSZaqDs4egj2tVt2AN3IHpv0S+v1oBTP438pEdoayWnXDZRZFUkj1rNz3MqbLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613087; c=relaxed/simple;
	bh=Ww5+G53IsJC0srqQjuwVctTk+cr89lw9N9OYjDY6QsA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=PFbr8XzW5KWTOPD2KOe18V5MfpGLFh2NWR87yZ0N4i5bEA1RDiF/vOL8F9/fKbsQNJZ4c4Xylq92q/G4X8pS/P7SoahJKd9hkcC2sv5D3d5bcWJ5ejiDD2gbTnz/BcdPWu2cJ16Qqd/e07xeECb/FRaZlWNJNpA4opMoJFzBXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=S11dqHZK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=538ON5EPZTBMBX3+al1tdLxWXuKOKR+PvV1XuIE1imE=; b=S11dqHZK7HrPo/UXqJai8zRyvl
	1JuxX7nIV7wvR4ffWWtihwnXdH2MyJzO1NRQ5V4sxZDeY3fuYYTbir1JxOKsBcFs4YXToaesHyZqw
	XgcerYg5PL+2cANaFi9DKegtqevg4wzGGCBkJTO0UkQ59ueG2XkPOZ944KPH3zE/vX8Fqu+t5j/iy
	TddSLwbKQhMe6WXuHqURWFvfqVUVzW4worReUja5FQyweE4O+QYYn026hv4P/dsFGKO6+8LvLIVfD
	TBvC4ZU9pFe5VHtyW8dga3EUl1mnu8JznvfzFEpfkdjYnuUirUo54tsHl2BKOiBlmWQKkC9Ka0m97
	YkprexXA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37306 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFro8-0006SK-1F;
	Tue, 26 Nov 2024 09:24:32 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFro6-005xPq-S1; Tue, 26 Nov 2024 09:24:30 +0000
In-Reply-To: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 03/16] net: phylink: add debug for
 phylink_major_config()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFro6-005xPq-S1@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 09:24:30 +0000

Now that we have a more complexity in phylink_major_config(), augment
the debugging so we can see what's going on there.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 43a817de4bc8..e43a083cec57 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -175,6 +175,24 @@ static const char *phylink_an_mode_str(unsigned int mode)
 	return mode < ARRAY_SIZE(modestr) ? modestr[mode] : "unknown";
 }
 
+static const char *phylink_pcs_mode_str(unsigned int mode)
+{
+	if (!mode)
+		return "none";
+
+	if (mode & PHYLINK_PCS_NEG_OUTBAND)
+		return "outband";
+
+	if (mode & PHYLINK_PCS_NEG_INBAND) {
+		if (mode & PHYLINK_PCS_NEG_ENABLED)
+			return "inband,an-enabled";
+		else
+			return "inband,an-disabled";
+	}
+
+	return "unknown";
+}
+
 static unsigned int phylink_interface_signal_rate(phy_interface_t interface)
 {
 	switch (interface) {
@@ -1164,7 +1182,9 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 	unsigned int neg_mode;
 	int err;
 
-	phylink_dbg(pl, "major config %s\n", phy_modes(state->interface));
+	phylink_dbg(pl, "major config, requested %s/%s\n",
+		    phylink_an_mode_str(pl->req_link_an_mode),
+		    phy_modes(state->interface));
 
 	if (pl->mac_ops->mac_select_pcs) {
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
@@ -1180,6 +1200,11 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 
 	phylink_pcs_neg_mode(pl, pcs, state->interface, state->advertising);
 
+	phylink_dbg(pl, "major config, active %s/%s/%s\n",
+		    phylink_an_mode_str(pl->act_link_an_mode),
+		    phylink_pcs_mode_str(pl->pcs_neg_mode),
+		    phy_modes(state->interface));
+
 	phylink_pcs_poll_stop(pl);
 
 	if (pl->mac_ops->mac_prepare) {
-- 
2.30.2


