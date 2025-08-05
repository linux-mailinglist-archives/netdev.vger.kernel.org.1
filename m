Return-Path: <netdev+bounces-211749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3ABB1B792
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 17:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BD8C4E2881
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BD827A127;
	Tue,  5 Aug 2025 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XKiL6+sy"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533F1275B07
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408119; cv=none; b=OuBwyK7Csn3ODFuE4I6uidAHU6zI1U9FVTjJNvd7jWjtl5I/rNHdTu4VQmkhEqkEp4a+eN3UBOoDM2lctBpMDlQ9Tu22mcAUIw/zqEt7rrbLG/s2nu9BmwKNtqkflgNzTvmqNhLK7ugb8PIjg8TvNraENEUNDE5OuBCwV5doUHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408119; c=relaxed/simple;
	bh=NREG7/jRvkNZrpdOCBLKO3g8W24+uCDycZzojHqEAGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTK8HBeo6jbzaucoQztzcqYAg8NIB8/Iyj9L8Ce/zw/uCdk967Djjv4mIF4vExDac0brxR2k4RLmoRhAXk4LQ1SFSXwJJ4knYL56qu1ahe8hJXqOyXpzus1jJfwuRHc+QN86dx0fEqKG1C6eItO3SDcWzTNEAmLvmf8HkSvfUSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XKiL6+sy; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754408115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nNBYWAsuzIbCLC3bKrAXDMPpx02Wco1ifzGZfSbmA94=;
	b=XKiL6+syGx8brdUMIVg+2pEOlXfLRLuYqP+45kzSWStGBd27ngIv1EWIZZ53FSaAV1sMIJ
	uN+yAiNwHtCklX5arBtJIslEuhqqW3JLPJcaSHAOIj6qVPtwE3p7jf7s9+bdY3pBGp2MTJ
	/TfMxiVBTb0NUb/GDgA4e+CCR0BygwE=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v4 2/7] net: axienet: Use ioread32/iowrite32 directly
Date: Tue,  5 Aug 2025 11:34:51 -0400
Message-Id: <20250805153456.1313661-3-sean.anderson@linux.dev>
In-Reply-To: <20250805153456.1313661-1-sean.anderson@linux.dev>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In preparation for splitting the MDIO bus into a separate driver,
convert all register reads/writes to use ioread32/iowrite32 directly
instead of using the axienet_ior/iow helpers. While we're at it, clean
up the register calculations a bit.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v3)

Changes in v3:
- New

 .../net/ethernet/xilinx/xilinx_axienet_mdio.c | 43 +++++++++----------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
index 9ca2643c921e..16f3581390dd 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -32,7 +32,7 @@ static int axienet_mdio_wait_until_ready(struct axienet_local *lp)
 {
 	u32 val;
 
-	return readx_poll_timeout(axinet_ior_read_mcr, lp,
+	return readx_poll_timeout(ioread32, lp->regs + XAE_MDIO_MCR_OFFSET,
 				  val, val & XAE_MDIO_MCR_READY_MASK,
 				  1, 20000);
 }
@@ -45,8 +45,8 @@ static int axienet_mdio_wait_until_ready(struct axienet_local *lp)
  */
 static void axienet_mdio_mdc_enable(struct axienet_local *lp)
 {
-	axienet_iow(lp, XAE_MDIO_MC_OFFSET,
-		    ((u32)lp->mii_clk_div | XAE_MDIO_MC_MDIOEN_MASK));
+	iowrite32((u32)lp->mii_clk_div | XAE_MDIO_MC_MDIOEN_MASK,
+		  lp->regs + XAE_MDIO_MC_OFFSET);
 }
 
 /**
@@ -59,9 +59,9 @@ static void axienet_mdio_mdc_disable(struct axienet_local *lp)
 {
 	u32 mc_reg;
 
-	mc_reg = axienet_ior(lp, XAE_MDIO_MC_OFFSET);
-	axienet_iow(lp, XAE_MDIO_MC_OFFSET,
-		    (mc_reg & ~XAE_MDIO_MC_MDIOEN_MASK));
+	mc_reg = ioread32(lp->regs + XAE_MDIO_MC_OFFSET);
+	iowrite32(mc_reg & ~XAE_MDIO_MC_MDIOEN_MASK,
+		  lp->regs + XAE_MDIO_MC_OFFSET);
 }
 
 /**
@@ -90,13 +90,11 @@ static int axienet_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 		return ret;
 	}
 
-	axienet_iow(lp, XAE_MDIO_MCR_OFFSET,
-		    (((phy_id << XAE_MDIO_MCR_PHYAD_SHIFT) &
-		      XAE_MDIO_MCR_PHYAD_MASK) |
-		     ((reg << XAE_MDIO_MCR_REGAD_SHIFT) &
-		      XAE_MDIO_MCR_REGAD_MASK) |
-		     XAE_MDIO_MCR_INITIATE_MASK |
-		     XAE_MDIO_MCR_OP_READ_MASK));
+	rc = FIELD_PREP(XAE_MDIO_MCR_PHYAD_MASK, phy_id) |
+	     FIELD_PREP(XAE_MDIO_MCR_REGAD_MASK, reg) |
+	     XAE_MDIO_MCR_INITIATE_MASK |
+	     XAE_MDIO_MCR_OP_READ_MASK;
+	iowrite32(rc, lp->regs + XAE_MDIO_MCR_OFFSET);
 
 	ret = axienet_mdio_wait_until_ready(lp);
 	if (ret < 0) {
@@ -104,7 +102,7 @@ static int axienet_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 		return ret;
 	}
 
-	rc = axienet_ior(lp, XAE_MDIO_MRD_OFFSET) & 0x0000FFFF;
+	rc = ioread32(lp->regs + XAE_MDIO_MRD_OFFSET) & 0x0000FFFF;
 
 	dev_dbg(lp->dev, "axienet_mdio_read(phy_id=%i, reg=%x) == %x\n",
 		phy_id, reg, rc);
@@ -129,8 +127,9 @@ static int axienet_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 static int axienet_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 			      u16 val)
 {
-	int ret;
 	struct axienet_local *lp = bus->priv;
+	int ret;
+	u32 mcr;
 
 	dev_dbg(lp->dev, "axienet_mdio_write(phy_id=%i, reg=%x, val=%x)\n",
 		phy_id, reg, val);
@@ -143,14 +142,12 @@ static int axienet_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 		return ret;
 	}
 
-	axienet_iow(lp, XAE_MDIO_MWD_OFFSET, (u32)val);
-	axienet_iow(lp, XAE_MDIO_MCR_OFFSET,
-		    (((phy_id << XAE_MDIO_MCR_PHYAD_SHIFT) &
-		      XAE_MDIO_MCR_PHYAD_MASK) |
-		     ((reg << XAE_MDIO_MCR_REGAD_SHIFT) &
-		      XAE_MDIO_MCR_REGAD_MASK) |
-		     XAE_MDIO_MCR_INITIATE_MASK |
-		     XAE_MDIO_MCR_OP_WRITE_MASK));
+	iowrite32(val, lp->regs + XAE_MDIO_MWD_OFFSET);
+	mcr = FIELD_PREP(XAE_MDIO_MCR_PHYAD_MASK, phy_id) |
+	      FIELD_PREP(XAE_MDIO_MCR_REGAD_MASK, reg) |
+	      XAE_MDIO_MCR_INITIATE_MASK |
+	      XAE_MDIO_MCR_OP_WRITE_MASK;
+	iowrite32(mcr, lp->regs + XAE_MDIO_MCR_OFFSET);
 
 	ret = axienet_mdio_wait_until_ready(lp);
 	if (ret < 0) {
-- 
2.35.1.1320.gc452695387.dirty


