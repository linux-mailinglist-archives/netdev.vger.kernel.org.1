Return-Path: <netdev+bounces-219921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB3EB43B2F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B7F687F48
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008B82D5C92;
	Thu,  4 Sep 2025 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hoFnOagA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A22D5410
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987889; cv=none; b=K0n+0hKh1l57cIxba+9DRHonRf9xIhphnT9SpsJLtTOgH+rtmYwA0iOnU2lNgWM2Oz5i6ynpBNMlBibYky75jMp2hFc+x+Ex3qvySTR65qthhFmCrbMuJebE3+EVJChubEyMKOLfRc5QYmUhxWzkE0qD3TAsk6QJkX0KHSuHmwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987889; c=relaxed/simple;
	bh=39/43brg4HOZGmwhQ6n63pRToGGjEHkpf6yW9nAuj0c=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=YPxUF1MhUU5jky2Ne+gUJoNf9h5eWykHZ6yy3qwvN6utAsys8FATNdvcFH21ErrjBxEquBGBOZ6/gQFLJl6WICN12WT62kE2NNdvbGXXBBQvQcVUMSS2scSCnsw0OTz4/39JmDCbk5nlvQ5z/w9joYxUoI8CAFCp1dUbTCJcX7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hoFnOagA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RrMWG5cWBmM+XR+/vkLCxhlAh3UTzPrNoo8dEeCIYHM=; b=hoFnOagACWv2EH9UbaNPdQunoc
	2k5STtElXx5ZSXnvrSY+H6X8Qw/P6T3DpKVEbboy2cbEGRh/j6sV/LYTAvifugyjqqxIL9taaF3UK
	W8yskkiAsjWTlJCLVr7EoilgVPRnps/T4zFDg4Fpsm6o22AXCgNKZZPcfeqy6ruOCcjFkazQSBr/l
	0+vm+P6/pq95LqNMm+ms6uOUx9RvdmqWNr6UKg9LQSwEj8yKyGYZbcHGbhvCdNNpj2+0W1Dc2SqLh
	k2w2CwecGBrzFz56nhzQmIZbL5+XfviJ6MOykNHrGAz2yIcP4S4ElA1CDVtw+RO6w+hAPKDPVPKCG
	+Y3ka4Yg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36312 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uu8oD-000000001y6-1lGM;
	Thu, 04 Sep 2025 13:11:21 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uu8oC-00000001vos-2JnA;
	Thu, 04 Sep 2025 13:11:20 +0100
In-Reply-To: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 05/11] net: stmmac: mdio: merge stmmac_mdio_read()
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
Message-Id: <E1uu8oC-00000001vos-2JnA@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 04 Sep 2025 13:11:20 +0100

stmmac_mdio_read() and stmmac_mdio_write() are virtually identical
except for the final read in the stmmac_mdio_read(). Handle this as
a flag.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 59 ++++++++-----------
 1 file changed, 24 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index d588475b4279..4e2eb206a234 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -240,29 +240,41 @@ static u32 stmmac_mdio_format_addr(struct stmmac_priv *priv,
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
@@ -330,29 +342,6 @@ static int stmmac_mdio_read_c45(struct mii_bus *bus, int phyaddr, int devad,
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


