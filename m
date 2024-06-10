Return-Path: <netdev+bounces-102301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51246902445
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62DBCB25B4C
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43E312FF88;
	Mon, 10 Jun 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bySBVZ1W"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54C380BE5
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030456; cv=none; b=pMU8+lrYzRhFOTq5sVewaCv+lGKtEdoK+s2wWO78CjYYDBkus0QbDdTyQJXfdEZdPRW79fOkgFa2f3hlh1PZy+2HkGR8IC+TfYJjugCXej3kxCN7ZXXH4qWlZEx3mMq/IFb8LF9LBaC3pjDsGijTb1Zf1PoxJtuGqVreTy/7OeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030456; c=relaxed/simple;
	bh=dXlScvBx0DRQYqk5UBcpMatM/k7plPNnT01AfHVOHKo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=tzQkLKiUuVqCZECcf2JDeqXC0x9143hVkGciq4gmbsW9/hUMV2y5tyU8tcwyMvMU3JUwAomQxS6JdmEQW+qa8UPp9o3anONJ6ZKQxpruBHpY/85ikLp4enkgsak2tVdSN9YAxt1RzqIbM8OOVCMzgkf7lh6kD8VMPSEQQUkygT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bySBVZ1W; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SNwgbigX1ci9uok9QpNvOvvdhi7uYTHIbZL8XLOiAs0=; b=bySBVZ1WVTUaoTnpKTwXy1Z7E7
	DQGEvSoqKScAb2H2fddu2Qy7vV9RGb7kWfcnFiTSQbGmGJTARrhoVJNhxfLW+t/FZs42Kf+UGi7fG
	RwlDENxPiankwnNmb5k3OORLHwWTgYA2+/iWPwVESd0JuByfLe5QYQLvvLYwJTE/f1Z8P06jAWuNr
	SUELNmBj+qZwDP3ezMXQ77NKluM5KghinbGqMkrunCyVF6R6puCuPzXFW8iNk4tI1V4IrF8tfLbFA
	D72ePVbov/VWWFERK9cCH47wSkQNL42/pnAlkq3TNvc4lD4FLedDTAowgEpFn8EWp0q3KdYbifhab
	RSO2GzBQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55864 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sGgCP-0001fH-0F;
	Mon, 10 Jun 2024 15:40:41 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sGgCS-00Facz-4s; Mon, 10 Jun 2024 15:40:44 +0100
In-Reply-To: <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
References: <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 3/5] net: stmmac: dwmac-rzn1: provide select_pcs()
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
Message-Id: <E1sGgCS-00Facz-4s@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Jun 2024 15:40:44 +0100

Provide a .select_pcs() implementation which returns the phylink PCS
that was created in the .pcs_init() method.

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


