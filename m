Return-Path: <netdev+bounces-157665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB5AA0B2A1
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3FD18867F5
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3850023314E;
	Mon, 13 Jan 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ElvuuZkT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A0231CA3
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760203; cv=none; b=iBApySrvDoitpy6qvux6bcntElEVpesTk9fyPPUUhxffEmRn/sh9qPEfMBK0voGgX7BS/PjHN5VL5+CCa+y4stwkMtKGuAaUUxO9K+Xus9nFAXU9lsUDReXMMetjyySkZCbGJcRcd34jl+i4XG591nnUZpqTzqtiYlqgCQ68Q0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760203; c=relaxed/simple;
	bh=sB7xOoGxnsj3DZBZVAuhNczWggnBzyXp9Uu+U9qnhlc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=DclsIZ+9uauRMaU4AkbWG08x7IyHD5f4lPI1g1tcj2kif7b0ZbML5/lWQ7/pF7drT1eb9Nkfk0N6pmROIbhhEK5uqxb41KpGz9K2Mtw4y9dFxP3NPq81XZU0dr/+Os48M3pbNL6hdoax21LWXU3tYEGn3tTulmJZwWEStah8qN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ElvuuZkT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EPdy4BPERTnLbmDgPw9nRNno9SSxaofX4cvpIH3U9fw=; b=ElvuuZkTLSBTcqfiqbMMBgMXv4
	Gwq48/8T+sGg1s+3cZ+aJpecUPSN31D8mVBOdPJdJpKc1BGcmBlj9mAxVhCKDQL2p6G1qcc+fKLzt
	AxER0QB8hbvRyWoMp4z8gxe/aTkbfCw3AClXiaG0LShnaWwn0Hk8adCPs1Pc3nzHdW5NiU9sjV7+k
	SBJYY7xx4mbNcJbEw970MbKgIerDzarG5QVAarppLHgv32RSfQ6qo6jgTled+65o2NS6u51G7cFGX
	Jit7fVZVGO6U70UDudyNSGXXpOmA/hgw2zKIrmsFynZhVCn3a4RTibhnswZsJRJyYpbdtA77JapJY
	7HdgRgcA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36114 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXGew-0006Hq-2Q;
	Mon, 13 Jan 2025 09:22:58 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXGed-000EtF-CN; Mon, 13 Jan 2025 09:22:39 +0000
In-Reply-To: <Z4TbR93B-X8A8iHe@shell.armlinux.org.uk>
References: <Z4TbR93B-X8A8iHe@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Golle <daniel@makrotopia.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	netdev@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH net-next v2 4/5] net: phylink: use neg_mode in
 phylink_mii_c22_pcs_decode_state()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXGed-000EtF-CN@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 13 Jan 2025 09:22:39 +0000

Rather than using the state of the Autoneg bit, which is unreliable
with the new PCS neg mode support, use the passed neg_mode to decide
whether to decode the link partner advertisement data.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index b29b7e73b5bd..b79f975bc164 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3877,11 +3877,15 @@ void phylink_mii_c22_pcs_decode_state(struct phylink_link_state *state,
 {
 	state->link = !!(bmsr & BMSR_LSTATUS);
 	state->an_complete = !!(bmsr & BMSR_ANEGCOMPLETE);
-	/* If there is no link or autonegotiation is disabled, the LP advertisement
-	 * data is not meaningful, so don't go any further.
+
+	/* If the link is down, the advertisement data is undefined. */
+	if (!state->link)
+		return;
+
+	/* If in-band is disabled, then the advertisement data is not
+	 * meaningful.
 	 */
-	if (!state->link || !linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
-					       state->advertising))
+	if (neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED)
 		return;
 
 	switch (state->interface) {
-- 
2.30.2


