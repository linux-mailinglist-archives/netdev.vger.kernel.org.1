Return-Path: <netdev+bounces-219564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F7CB41F68
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 524DA7B534B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC312FE04E;
	Wed,  3 Sep 2025 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="O5g06AKD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E782FE56B
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903189; cv=none; b=p4V9Dj8whLtargvVp2iLJoS4v4XREtTF/n1gxpfdLnOcbbfuRwwt9kFDJfXS/EQiZpR2h2CmWVbhVzph+yNhUQy7f4PDijJA+NzoGMiSyCdJDr1BSOBVZQHthKD96jN4dlgYTg+J+G/qQvHDavy9zp4tMGC3U0N6Pw4r6QMnY7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903189; c=relaxed/simple;
	bh=jqUNvwgY3c0xnyMuyndfjJAMqyVhWKwbjfs3irWbfGE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=dPcJzyDPpKf9VL1CCb2ZkOSPJg+UUyIzyqMuE3435ZNoh+kYLTtEpKloUAAJNXBixtgzrhzjLgXXNX84rvjB4derjMHP0PaNZuI6uP8RJ/CX8r9PUyehJ/Eb2xqgY8sHQRCyQ9R7N5+FA6kIHkqVna+CZdeYSV28QkhzIhZvHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=O5g06AKD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZlhNYK+L2tHiDqFaydGPeXq43CQW4my5sqVxmqPsDSY=; b=O5g06AKDFXOIDaFtK35y+7Ak9b
	+sXbxEgd78km5A6djasxbDl5vATWW371aRVatv4OGDtZ/wFfmISo3h2mBve/2pJDK9vV/CiSXTriL
	wWZhwu7vrmkHH5bVgsxOnnBpKdW7c7T+jDEJcOzt36iUqTTpCbe5TKmUDo+xfhFKy5kAw+MpC/+yF
	+IuRU4QysHZQep4HdiiensQH1VFGczO9wbcgR5lXd55g4xU8bGXmeMRc1qpRcEnDU8gW+fVhnQsRo
	LwJBuIcYTxEI70KjQK1mkn/87HcV7GSNqJIyakKuQ2bZ5vi7hn5zoF7lRIdfhZckxRBuo3U0zWJQr
	91n/vkwA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36456 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1utmm4-000000000Vs-1hgM;
	Wed, 03 Sep 2025 13:39:40 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1utmm3-00000001s0O-1z3r;
	Wed, 03 Sep 2025 13:39:39 +0100
In-Reply-To: <aLg24RZ6hodr711j@shell.armlinux.org.uk>
References: <aLg24RZ6hodr711j@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 05/11] net: stmmac: mdio: merge stmmac_mdio_read()
 and stmmac_mdio_write()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1utmm3-00000001s0O-1z3r@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 03 Sep 2025 13:39:39 +0100

stmmac_mdio_read() and stmmac_mdio_write() are virtually identical
except for the final read in the stmmac_mdio_read(). Handle this as
a flag.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 59 ++++++++-----------
 1 file changed, 24 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index dafe97a49d1f..62e74467de49 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -238,29 +238,41 @@ static u32 stmmac_mdio_format_addr(struct stmmac_priv *priv,
 	       MII_BUSY;
 }
 
-static int stmmac_mdio_read(struct stmmac_priv *priv, unsigned int pa,
-			    unsigned int gr, u32 cmd, int data)
+static int stmmac_mdio_access(struct stmmac_priv *priv, unsigned int pa,
+			      unsigned int gr, u32 cmd, u32 data, bool read)
 {
-	unsigned int mii_address = priv->hw->mii.addr;
-	unsigned int mii_data = priv->hw->mii.data;
-	u32 value;
+	void __iomem *mii_address = priv->ioaddr + priv->hw->mii.addr;
+	void __iomem *mii_data = priv->ioaddr + priv->hw->mii.data;
+	u32 addr;
 	int ret;
 
-	ret = stmmac_mdio_wait(priv->ioaddr + mii_address, MII_BUSY);
+	ret = stmmac_mdio_wait(mii_address, MII_BUSY);
 	if (ret)
 		return ret;
 
-	value = stmmac_mdio_format_addr(priv, pa, gr) | cmd;
+	addr = stmmac_mdio_format_addr(priv, pa, gr) | cmd;
 
-	writel(data, priv->ioaddr + mii_data);
-	writel(value, priv->ioaddr + mii_address);
+	writel(data, mii_data);
+	writel(addr, mii_address);
 
-	ret = stmmac_mdio_wait(priv->ioaddr + mii_address, MII_BUSY);
+	ret = stmmac_mdio_wait(mii_address, MII_BUSY);
 	if (ret)
 		return ret;
 
-	/* Read the data from the MII data register */
-	return readl(priv->ioaddr + mii_data) & MII_DATA_MASK;
+	/* Read the data from the MII data register if in read mode */
+	return read ? readl(mii_data) & MII_DATA_MASK : 0;
+}
+
+static int stmmac_mdio_read(struct stmmac_priv *priv, unsigned int pa,
+			    unsigned int gr, u32 cmd, int data)
+{
+	return stmmac_mdio_access(priv, pa, gr, cmd, data, true);
+}
+
+static int stmmac_mdio_write(struct stmmac_priv *priv, unsigned int pa,
+			     unsigned int gr, u32 cmd, int data)
+{
+	return stmmac_mdio_access(priv, pa, gr, cmd, data, false);
 }
 
 /**
@@ -328,29 +340,6 @@ static int stmmac_mdio_read_c45(struct mii_bus *bus, int phyaddr, int devad,
 	return data;
 }
 
-static int stmmac_mdio_write(struct stmmac_priv *priv, unsigned int pa,
-			     unsigned int gr, u32 cmd, int data)
-{
-	unsigned int mii_address = priv->hw->mii.addr;
-	unsigned int mii_data = priv->hw->mii.data;
-	u32 value;
-	int ret;
-
-	/* Wait until any existing MII operation is complete */
-	ret = stmmac_mdio_wait(priv->ioaddr + mii_address, MII_BUSY);
-	if (ret)
-		return ret;
-
-	value = stmmac_mdio_format_addr(priv, pa, gr) | cmd;
-
-	/* Set the MII address register to write */
-	writel(data, priv->ioaddr + mii_data);
-	writel(value, priv->ioaddr + mii_address);
-
-	/* Wait until any existing MII operation is complete */
-	return stmmac_mdio_wait(priv->ioaddr + mii_address, MII_BUSY);
-}
-
 /**
  * stmmac_mdio_write_c22
  * @bus: points to the mii_bus structure
-- 
2.47.2


