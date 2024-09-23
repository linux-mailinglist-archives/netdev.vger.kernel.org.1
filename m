Return-Path: <netdev+bounces-129309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A106297ECB3
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8001B2229F
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A32197A97;
	Mon, 23 Sep 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xJNnFaT2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB82AEE7
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727100089; cv=none; b=I/AHQ3NUyJbb3AJIi87VpnPeXq/EBql6yusmeOgVIn1LTmfEbyJy2aBSzJaWPC1tpRJlI6hOetjgyf7+N6W1LfhBtSNymlyonYf3jT3WuTVV26bMLn4InQN/lv+Yp4+xO+XLbQEzgr4JDQ65shkAfB7j6mUV6QfJIjVuXH70IfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727100089; c=relaxed/simple;
	bh=q0SkBAeWeq27d40SPzPo56etH1Px97gJCkY+idRnfd4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=hTlyUHFRJcvi6HB7MB9Xf+Pe8pNtDy8vgiywf1zl59rdfQBoSr7Q+vHlqPkDf9mn2iXvuRhwa5O4mojD4+8FgEwbdqbySdRgDJr69YaOLlCoCj0h1tUkJrPc9Pq+KG0eEPagAEaMr0nWZRL79EmM1kF76qXPflMc6vSsjejE2/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xJNnFaT2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=isI9/PQ4DNC7EKY1B/11YlS7bxB+io0C0j25LXSzHHY=; b=xJNnFaT2NHx16n7wv0Nu4a1Rsf
	xNjbRMpG15/iOSxgO1mVSTXH82KTiZhtgKVzonPbF1ultXD1sed1nqg4lSFTAOZdddVRixh54vIOv
	QcX3eFkCoGp7gkspMvZ+db81CPVX/ZBiBpQ7E8BcBfzqn+W5zhneQr03+yToAtbeW79upE91OliXe
	WUjcMjnV49JuAK5DFkbnd7a903cz5g/EZ6PVNmsrNar3xtXBVxjIqkQEX3QklnM0/vuz7l7Uvtjj+
	xJx7LD5MhvJSyJ8U6G6Jc0kwWcgVmvJwne50TaNB89ew91OG2pIY53mr3kDgCT9k0zQI9GwKSZXSD
	IzqPTChQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56744 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ssjcl-0004HY-1o;
	Mon, 23 Sep 2024 15:01:11 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ssjck-005Nrr-2B; Mon, 23 Sep 2024 15:01:10 +0100
In-Reply-To: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
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
Subject: [PATCH RFC net-next 03/10] net: pcs: xpcs: get rid of
 xpcs_init_iface()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ssjck-005Nrr-2B@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 23 Sep 2024 15:01:10 +0100

xpcs_init_iface() no longer does anything with the interface mode, and
now merely does configuration related to the PMA ID. Move this back
into xpcs_create() as it doesn't warrant being a separate function
anymore.

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


