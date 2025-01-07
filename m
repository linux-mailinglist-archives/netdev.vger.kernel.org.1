Return-Path: <netdev+bounces-155960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78874A04667
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C3937A3177
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9CA1F709C;
	Tue,  7 Jan 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BftMc+tD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8A01F708B
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267393; cv=none; b=XL3EGFjTKagVgBz2B2WSwO9N3x4DZJuGUB1nNun42WcWbLW2detZeTDibwabrIQovV1ioRbXEDaNw1PRVuMpUEiq66DC6hCSq8IVLPyVBws/GA8mgVHmgtPQX8ZT1JYaegpqU40MP509BCOvBWGqNCXBtjFvROF8onsNuv1Ygkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267393; c=relaxed/simple;
	bh=N5xE7KL1nMb5Cie6NsoLk/Sd/S1DY19s5keOkmgatPU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=rbdSnQQe6i1kIMeO0AjmN+gLZ82kHZ+amZbuRmK4VE7e3q9OkTMe5kw9omHnsxan0Cl0vl8bYk4sVuXqHm1340aEs8SW51Hi2SdPtz/ZAJG8KM3bIlqRGoDM42IyNn5m33wPH3NsQsafo7NmzDm4eC+hEsLMmt/3mSCyb2xWJWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BftMc+tD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qm2Cf1BaSz15K4PsGl3xyn8XApkKB5nwZMBaIeywDjc=; b=BftMc+tDMdP13nYTQJ+MD6pNQ6
	h0c0M1qARwtVqPx8zfyKwTQ9yc+jEN9KgqKPLTJq2nKYWbYKDxKvcWfhxDW41QNy5+2TZiXy8InQq
	3bIyOggB8xnH21xsVs3FJPX2/qX7fhvvVfoG5QohY9KI+Kxm0ywRanbHg1rkv99NZcryp0rpAhNwp
	XjM5i5AQYiijyENWy0dqMNXVQCK+xb2DlXOalMYQk3PkYXSg1QdfI+4l0kCl+XrxtT32lvp1tm1E+
	zZ84TaIZeptyxoruxnGvlrqOn2OX+LVr/Mnjr4bzRjo/FdYod+SaksxTZLDKioEi5zEL5W/PrFyXG
	WetQSx4w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42170 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVCSb-0007oY-2G;
	Tue, 07 Jan 2025 16:29:41 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVCSY-007Y4F-Mz; Tue, 07 Jan 2025 16:29:38 +0000
In-Reply-To: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
References: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 14/18] net: stmmac: use boolean for eee_enabled
 and eee_active
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVCSY-007Y4F-Mz@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 07 Jan 2025 16:29:38 +0000

priv->eee_enabled and priv->eee_active are both assigned using boolean
values. Type them as bool rather than int.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 1556804cca38..25ad3f92e14d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -305,9 +305,9 @@ struct stmmac_priv {
 	int clk_csr;
 	struct timer_list eee_ctrl_timer;
 	int lpi_irq;
-	int eee_enabled;
-	int eee_active;
 	u32 tx_lpi_timer;
+	bool eee_enabled;
+	bool eee_active;
 	bool eee_sw_timer_en;
 	unsigned int mode;
 	unsigned int chain_mode;
-- 
2.30.2


