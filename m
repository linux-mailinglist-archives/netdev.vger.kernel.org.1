Return-Path: <netdev+bounces-147372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B09B9D946A
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896EA165EE9
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BA61D517A;
	Tue, 26 Nov 2024 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="R1xRbhVb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F921D5170
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613139; cv=none; b=jIiqN7xT7iEzBSfGbC4vzjTDmd2kyArAs9HES2XgL5jUg7kQ9affQLdE1kiv7CFfwsvZwR4hwurpqA1S6opZygNHQCK+m9h0Pw6TtWQH3RRuHMORp7LzkZRVaqUOCpaYFKIPjxE9QnO203AwQXJWqNJQf96oChD5JkLO8VfkGCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613139; c=relaxed/simple;
	bh=YOAX/kDYS93CRTAyV9yok+iJG4ddKJPCQWoCW1sl50o=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=OBCK1XmxQCuwsXdFjRxq3T1vuNJa4CWF3X2pBSJSox6KXLx+qh3ctQAzjmcdNEX3z5QBSEiFZUjyH6Sq6lsU3xzsY+jXJetYfD494w58DZOFkRIRK1yWfTnS7TO3sQtU7Gu68lOZ1uSYEfNXAYucUhUj+BxxgrlmyvJxwrdk3WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=R1xRbhVb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7vuVuSz1ikyfCg09UlbCqoDgZ9MeD4Xre3c4jOWt9Zo=; b=R1xRbhVbO3X3ElH4ipfqT/sK3y
	szMeNVq21WHN7qs2wvbMNb9qbnbl+JF0622GZnG45lZ7rCpOo0YHbU7o+85uWT+w2L7CjTC2Rkb1t
	mHjvzLol0WlhBZqsmSwDg3akFga0vh+UxwtRjBEv+MiFJiAviKNqrr9vPLNZjNZPDcrNhuUa1jNNs
	OZVkCwdwVeJum3obf8al8s5xLMohBDAzUW6bnh/RXS8ySAWrKWPgFQvaFZ0n+nrVTn5Wd8cfd3kqN
	+VMC6lrnBch4o//zG6joUVGNaAT4cs3O0BtThbsH+dayQXFhN11VecEBXxGPv+zzxFBN8Y8gVhoN0
	hqvDMV0g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35162 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFrox-0006Vi-25;
	Tue, 26 Nov 2024 09:25:24 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFrov-005xQq-W8; Tue, 26 Nov 2024 09:25:22 +0000
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
Subject: [PATCH RFC net-next 13/16] net: pcs: pcs-mtk-lynxi: implement
 pcs_inband_caps() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFrov-005xQq-W8@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 09:25:21 +0000

Report the PCS in-band capabilities to phylink for the LynxI PCS.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-mtk-lynxi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 4f63abe638c4..7de804535229 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -88,6 +88,21 @@ static struct mtk_pcs_lynxi *pcs_to_mtk_pcs_lynxi(struct phylink_pcs *pcs)
 	return container_of(pcs, struct mtk_pcs_lynxi, pcs);
 }
 
+static unsigned int mtk_pcs_lynxi_inband_caps(struct phylink_pcs *pcs,
+					      phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+
+	default:
+		return 0;
+	}
+}
+
 static void mtk_pcs_lynxi_get_state(struct phylink_pcs *pcs,
 				    struct phylink_link_state *state)
 {
@@ -241,6 +256,7 @@ static void mtk_pcs_lynxi_disable(struct phylink_pcs *pcs)
 }
 
 static const struct phylink_pcs_ops mtk_pcs_lynxi_ops = {
+	.pcs_inband_caps = mtk_pcs_lynxi_inband_caps,
 	.pcs_get_state = mtk_pcs_lynxi_get_state,
 	.pcs_config = mtk_pcs_lynxi_config,
 	.pcs_an_restart = mtk_pcs_lynxi_restart_an,
-- 
2.30.2


