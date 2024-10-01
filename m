Return-Path: <netdev+bounces-130942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871CA98C235
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9A11F2609E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8507C1CB312;
	Tue,  1 Oct 2024 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="j4VaZRGS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08B61CB314
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798677; cv=none; b=AhwXrKLOYp3dz6WVklXj3nvFGnFTtXRAZlmDfB006idrgUwWCDtZBnBSZlLF9z9usYK0Qu974YeZQZrf3cjat+unwmFrJZ94C9FnvQ3HrdBi5T+AavTE6qAe03yrV+Vz/Ivz5o0JOGIDtaVhUxlrwlFrhLXlyqlAqOo1jqLuojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798677; c=relaxed/simple;
	bh=Be2e2AL8pV5Vo4b1OOQgdwKzodn6bm9coAvMwM9CLBw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=txYoKSTGdIBNATL6eMi+XaK9CAMufkpZbQXlg3xjWBHdJUYW3/2Qc78ysXLHjrCMKriirl7E5Q+wJOl9H3geM80Vh94aWxPxXBfhrDozly7RH3rPoEpRDpJP+o5d80/UYDTJ4z5EuDrpkvdtM6T7NGOwlcZXAUuktCPkSaqO6DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=j4VaZRGS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9g72xzBXGrc10DA+eWe+Gs/39JKsuvziiPT5W/UDDiI=; b=j4VaZRGSfG4bx8FwfakKHsR1bQ
	ML11Z5DPSSbGmulJcLCu/g64gzW+MYq6W/lmbb1FuQ4Q5lzNimylHs8lt+6e4RvjdyhnHsDVT6pUq
	0HlwD848PwaId1Crf4mGW2Ji0BsoyMaGF3q6MNpfh1dNZAs0dUw/MU7dnzyCvtZxGEfdhmlmy+cs4
	a8aD8J4oxLY3kIt/5syfTEpAk8lu8szJVsfe5EoUVuV7x4a1VXkmUsctc+Z1VRfaA2vK2u2Udze2c
	nl3ZVbCSmZexpu0bG8Z845OwDm+9cAjQK1Wt3N+lLTAOozHVSvRIyJFtG2miOo1HPTiH6ywidKd9F
	LnPBy1iw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33288 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1svfMM-00065Z-35;
	Tue, 01 Oct 2024 17:04:22 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1svfML-005ZIF-84; Tue, 01 Oct 2024 17:04:21 +0100
In-Reply-To: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 03/10] net: pcs: xpcs: get rid of xpcs_init_iface()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1svfML-005ZIF-84@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 01 Oct 2024 17:04:21 +0100

xpcs_init_iface() no longer does anything with the interface mode, and
now merely does configuration related to the PMA ID. Move this back
into xpcs_create() as it doesn't warrant being a separate function
anymore.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 2d8cc3959b4c..8765b01c0b5d 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1483,16 +1483,6 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
 	return 0;
 }
 
-static int xpcs_init_iface(struct dw_xpcs *xpcs)
-{
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
-		xpcs->pcs.poll = false;
-	else
-		xpcs->need_reset = true;
-
-	return 0;
-}
-
 static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
 {
 	struct dw_xpcs *xpcs;
@@ -1510,9 +1500,10 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
 	if (ret)
 		goto out_clear_clks;
 
-	ret = xpcs_init_iface(xpcs);
-	if (ret)
-		goto out_clear_clks;
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
+		xpcs->pcs.poll = false;
+	else
+		xpcs->need_reset = true;
 
 	return xpcs;
 
-- 
2.30.2


