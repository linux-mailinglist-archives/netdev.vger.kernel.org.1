Return-Path: <netdev+bounces-103165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EB3906A28
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93AB282824
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 10:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0971142640;
	Thu, 13 Jun 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sRvoPdsI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12660142630
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274990; cv=none; b=HmdXlyMvIq6VsSzzxIP3hs4EP7eSTZ8Vfhhj7gqwAO337HlLK2cfSflUTlTZRdgkYysixnRUu3BvF3Ke0xZ0j9OEfKS373JA5nRy7f9yYDRgWNRl12Z9zg+3+Ii0N5Vu8TCzCySUxWeysUK8wDV8qPW3AqD/kYl6zoJ6KrQXiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274990; c=relaxed/simple;
	bh=G4qvkfHFOq+CBo37sC9jvLiFYXVV2qua7CQujku/G+Y=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=grv58WKHW2qj0lLx5byd32CPTelmXqFFCKmFBubNCx9PYGknRa+j26/mezh783DcTyYLErl7XakpK+ujFG98ZOGQuf3yWf+jSoHutb+TOjhA+zgZMROWJuqU7nfsxHfL/P14n+CKq9J9OYpS/1K3HbkDBdaf9wjZiKA7LsFkzx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sRvoPdsI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FGH5Eu+8hsWrvuPumFAHdOPOb5X0rHoQKGV+IhVzmYw=; b=sRvoPdsIEshpxB68kueQwnCrP/
	q5IE87pi/KfkUK4Jgz1v0/ysypIoeFHam+09/fQUOK/PEc/bt17ztENrN9RPs7D13Zl8MF/A6K6hb
	4ysrLcHvwDQ1O7JgbvjBv7OKg1X13k2EVfs1zE8yfKIaFS2RjQjsOSKrvNY1LmiSMVG9nQSQlCMwE
	HIVxbx/2NRGVpBaau4OqIU8BSfkn9qSBhpk2xrCicxSWuEcuLIVwUlyp67kqm6d8VwVksAxccN6HM
	ADhmSyC1bkSYlAGptpD0XHszhdMlJHj3IOQPDkJbWLuwGVFMo443n1/P4pIAnn4QsKNLwkKCO3rne
	WG+VTd0w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39592 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sHhoT-00065i-34;
	Thu, 13 Jun 2024 11:36:14 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sHhoW-00FetH-GD; Thu, 13 Jun 2024 11:36:16 +0100
In-Reply-To: <ZmrLbdwv6ALoy+gs@shell.armlinux.org.uk>
References: <ZmrLbdwv6ALoy+gs@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v2 3/5] net: stmmac: dwmac-rzn1: provide select_pcs()
 implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sHhoW-00FetH-GD@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Jun 2024 11:36:16 +0100

Provide a .select_pcs() implementation which returns the phylink PCS
that was created in the .pcs_init() method.

Tested-by: Romain Gantois <romain.gantois@bootlin.com>
Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
index 848cf3c01f4a..59a7bd560f96 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
@@ -39,6 +39,12 @@ static void rzn1_dwmac_pcs_exit(struct stmmac_priv *priv)
 		miic_destroy(priv->hw->phylink_pcs);
 }
 
+static struct phylink_pcs *rzn1_dwmac_select_pcs(struct stmmac_priv *priv,
+						 phy_interface_t interface)
+{
+	return priv->hw->phylink_pcs;
+}
+
 static int rzn1_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -57,6 +63,7 @@ static int rzn1_dwmac_probe(struct platform_device *pdev)
 	plat_dat->bsp_priv = plat_dat;
 	plat_dat->pcs_init = rzn1_dwmac_pcs_init;
 	plat_dat->pcs_exit = rzn1_dwmac_pcs_exit;
+	plat_dat->select_pcs = rzn1_dwmac_select_pcs;
 
 	ret = stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
 	if (ret)
-- 
2.30.2


