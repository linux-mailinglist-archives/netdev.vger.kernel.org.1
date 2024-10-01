Return-Path: <netdev+bounces-130943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796E198C236
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018D71F2607F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AC71CB51C;
	Tue,  1 Oct 2024 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="o2bC1KgG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577221CB528
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798681; cv=none; b=HF4Z5d3klV9+fl+Ja3hD/bsSg8AhYR9U9s84ku10IKL+6oZNf9gCUEQGU6s2dUEI2oqA//UomHm/xXMTSN6HcVkFYxPqK4DhVrOYDb0J14xth2bIHqHm9JJFRwE88EReJyRS+nSFjA6fQUnuRfA1D63v2q8ne9FoVV4KSMYkBUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798681; c=relaxed/simple;
	bh=z2iLz5Mu5hVdvhavvr0yOpS9bzmDAdburTkZdT0YnCY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=e0dcP71JH7VD2Vh8zNWCAyXJmBeZOVNrY8BofRBS5IAm2m2391F+xUW0u+MvgH5vslJ7N4+Yu73KmUGpp6VZdDk0GAMyvq3dzvCVRsjVDZmkVv99/6soc/I5Kbu9OHrNnTsbSuCcAOSHuDQrP5YV/PPBOA3HY/lUWtiq2+IB7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=o2bC1KgG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A2w5MpCx/7Xy1Sbu6TO9m5eeuE/bkTx+lPNVRYJeLoQ=; b=o2bC1KgGxX9+U5DiMA5ijt8nnh
	aTBaoIYQ+6rWvB2Cj5Rddw6F2j4qMGMFSD663OM6HJW8vCNOMYSREPm37erRe4qgvpcAzCF1vOYNN
	NPaoDH21Kubo7Q0wUASXcVmBR9X0QAqctiM53MAfFVGssMXhZC+9+UEbKuR04BMiPd/ypeGnC2Y20
	4YApgjgUmf5qjk0We8EmXA9mRRzqPt0+7HhIQHAIMNjsFbHEYjQe+PD7uiiyPyPGwyA+N4CT1uqqa
	nVfI8qfMKJ3PlJIsjvPQKU55vHFNd9mOEL9ZECUNSz3QdnW4hvc25X1bRcMgEN6TSMsVgb9dc8Sab
	JTR0bkrA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33294 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1svfMS-00065q-0j;
	Tue, 01 Oct 2024 17:04:27 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1svfMQ-005ZIL-Bi; Tue, 01 Oct 2024 17:04:26 +0100
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
Subject: [PATCH net-next 04/10] net: pcs: xpcs: add xpcs_destroy_pcs() and
 xpcs_create_pcs_mdiodev()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1svfMQ-005ZIL-Bi@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 01 Oct 2024 17:04:26 +0100

Provide xpcs create/destroy functions that return and take a phylink_pcs
pointer instead of an xpcs pointer. This will be used by drivers that
have been converted to use phylink_pcs pointers internally, rather than
dw_xpcs pointers.

As xpcs_create_mdiodev() no longer makes use of its interface argument,
pass PHY_INTERFACE_MODE_NA into xpcs_create_mdiodev() until it is
removed later in the series.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c   | 18 ++++++++++++++++++
 include/linux/pcs/pcs-xpcs.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 8765b01c0b5d..9b61f97222b9 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1550,6 +1550,18 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
 }
 EXPORT_SYMBOL_GPL(xpcs_create_mdiodev);
 
+struct phylink_pcs *xpcs_create_pcs_mdiodev(struct mii_bus *bus, int addr)
+{
+	struct dw_xpcs *xpcs;
+
+	xpcs = xpcs_create_mdiodev(bus, addr, PHY_INTERFACE_MODE_NA);
+	if (IS_ERR(xpcs))
+		return ERR_CAST(xpcs);
+
+	return &xpcs->pcs;
+}
+EXPORT_SYMBOL_GPL(xpcs_create_pcs_mdiodev);
+
 /**
  * xpcs_create_fwnode() - Create a DW xPCS instance from @fwnode
  * @fwnode: fwnode handle poining to the DW XPCS device
@@ -1599,5 +1611,11 @@ void xpcs_destroy(struct dw_xpcs *xpcs)
 }
 EXPORT_SYMBOL_GPL(xpcs_destroy);
 
+void xpcs_destroy_pcs(struct phylink_pcs *pcs)
+{
+	xpcs_destroy(phylink_pcs_to_xpcs(pcs));
+}
+EXPORT_SYMBOL_GPL(xpcs_destroy_pcs);
+
 MODULE_DESCRIPTION("Synopsys DesignWare XPCS library");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index fd75d0605bb6..a4e2243ce647 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -78,4 +78,7 @@ struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode,
 				   phy_interface_t interface);
 void xpcs_destroy(struct dw_xpcs *xpcs);
 
+struct phylink_pcs *xpcs_create_pcs_mdiodev(struct mii_bus *bus, int addr);
+void xpcs_destroy_pcs(struct phylink_pcs *pcs);
+
 #endif /* __LINUX_PCS_XPCS_H */
-- 
2.30.2


