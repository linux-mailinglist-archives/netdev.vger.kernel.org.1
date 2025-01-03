Return-Path: <netdev+bounces-154971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9479AA0087D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F387E7A122F
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 11:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E461F9EDC;
	Fri,  3 Jan 2025 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MUzEwKxw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F9F1E3DCB
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735903020; cv=none; b=MxznawrcVO2iiq+0CYrkFv9oAuES5O0qwzLIMVoRQBsCM/s8I7pv/SAX2q1wRY0dXePMK1gI0g6FHzmlqe560VfFGI8CsFMIFzIqA+MYGZj4K8kr+0Q4fTcT5Crmys5PCP7H2b35zvuisTgFkkojZxCsE+BslYhdRLOSqKhfrJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735903020; c=relaxed/simple;
	bh=lD8uVLllakIu3EndDcdvmX7aHmWszMTl2C0agh4bTCA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=NqAUy2N7QZp5ejZG3XWpcUvnqX8/XN+/96lbyE64RpZqmhBoUhVfO3FjABaGEEi9S3FSv40QzLnxwPIyBDhj+VbmU1Wcz81MeCfyo3xzYN94aXXMdIcIcvx5+HYPcF1ykMUg+ymjjm8tLCH8P+456+lbZlNUagza2AmqWSEb5C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MUzEwKxw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IZCni5EAPNv32fyYrhVKtEvOmSsbHmeJ2aH/4kersBw=; b=MUzEwKxwl2kfzS6jbMSOKhZP7/
	tSLBVm0qPr+LmI6AZhac7wX95dFIehy7HllBfegUp5rPvNYDHJv+V6i2oxQqJQwb1IKJU31FSynQX
	yzUSBIKjmKv6lHJwTteE2lE9+xudM8nlUnyzYPtpyIcKiCHsvqghEwO0V/eG6smtEMEpnrshLFB0a
	z2k4gfZGGSj/oxVwUvpE3Xvlz3fpyR/lthYK1ug/BMHwflSDUvZNLJDDR9yYE6JqW8gw7CXyEUFOR
	87Yoe7bg03VBwt+pM/dAtL3pMUgu+oF2+PGP4BnPDt5BgaB6hxBDh+d0GLCVAtfhTSYatscZ/uTap
	ZPJ/OREg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55410 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tTffT-00030L-0N;
	Fri, 03 Jan 2025 11:16:39 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tTffQ-007RoJ-4u; Fri, 03 Jan 2025 11:16:36 +0000
In-Reply-To: <Z3fG9oTY9F9fCYHv@shell.armlinux.org.uk>
References: <Z3fG9oTY9F9fCYHv@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/6] net: pcs: xpcs: fill in PCS supported_interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tTffQ-007RoJ-4u@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 03 Jan 2025 11:16:36 +0000

Fill in the new PCS supported_interfaces member with the interfaces
that XPCS supports.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index f70ca39f0905..cf41dc5e74e8 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1446,6 +1446,8 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
 	if (ret)
 		goto out_clear_clks;
 
+	xpcs_get_interfaces(xpcs, xpcs->pcs.supported_interfaces);
+
 	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
 		xpcs->pcs.poll = false;
 	else
-- 
2.30.2


