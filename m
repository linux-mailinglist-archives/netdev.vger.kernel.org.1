Return-Path: <netdev+bounces-99728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE6A8D612E
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 14:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDC51C20C03
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 12:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDF7157E99;
	Fri, 31 May 2024 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Hhn9Q2pI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91197156C7C
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717156936; cv=none; b=LzagPjnidXwPegaC7SqeCX72bF7mHChDt01pNfT4l4g1y4voV0IleBqqQhnYbMv6YjtoT/dHI1eqDb+vrdZLyjLlb6gM2g6p9ask5gkW9y/pvnM6v3uwY0MfFb2pNBKU43PBRA0h/Wru9jy8Cn9IXO/81y+L4eSIpRNzLwaNluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717156936; c=relaxed/simple;
	bh=BhrEVabLMT9xolSiF/6YszyixoFMRwY+xBpHtpZ2xds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KML8qpeGvQTTHJH6Yiwpe9TQ9Fh1J2raTF0DGI0dpvwybNHlVcFf7Yhs1F7ysqik0xn+7BVWCTp57cKOaqLY5pDr7pFcFtycsu8q5OtpryLvpaGRxGUMRPlE8XcFWSgH/Sj9Ab6o5KCRLgTFHl+u8JeBualrXKRu6+/W+xDUwT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Hhn9Q2pI; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a63359aaacaso224317766b.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 05:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717156932; x=1717761732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n5ltd+Q1r31hNsOKM+mo5WJDGkDt77P5jodMkGj2DWE=;
        b=Hhn9Q2pIzF24TjKi7XYjYE55x8PXxX+izThq98nB5WR6GnFOjTB4qkOdC1z8isHMIL
         j+00u75WnXvCmTF21sbrmQq09x8QVVN6m6bAbofIwQTyYx6DlA3tzEdDl3+QIVq0G8ur
         kAzqC+MZfVzcfu6mWKKYdKE0L/UIevLv2ldMyYOAsACnJEI8ENHul93nELaLvF+qJSbk
         3tFO8X6/oSBQWgHQuLurpJo5hxfDPYPa/mVoi3QiwZUmY7LydIopodrm3fCwvsdnBZDv
         DWO8F32riuAE9CEqVUFU5Zx12PSLGR99UGdiXWU8/l8DBSQsUR+VYksWgRayabP31Uh8
         MFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717156932; x=1717761732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5ltd+Q1r31hNsOKM+mo5WJDGkDt77P5jodMkGj2DWE=;
        b=HbIpN9/nwFmV+53G4MQRgrGh/5hgclpIj1I0Ta4vlBPBfjmzwuZfIeO6WGkq/mhxgA
         s1eSxAPHbXcuh5FTj2oJU9dKNQ7DtcwAKLeGMKX+enEZzZs6V63xuSTmK2O4aD28WHEr
         BvuUBRzMMCzNEM7XoCK0AfbUtFlsx36xemYdbpz+hfPrSUU2EADYKi8ZrIDlnm1cwusj
         3j/eCfw8aQ4Jm/i+P6W2Q+uXRpszluE6xlbEfQmDCCfTIpe7XpYD1jf9d4o8EZ9UUUsC
         +t0oGsyMnusjSBsW/9A9NwQR9ECvpZw/E1v27+ZDfY+gTH4BISQ1XFQP5cT+9LkuF2Ki
         m0GQ==
X-Gm-Message-State: AOJu0YxHYOoURzCejRYzGKz6gvFrVXlkEuk2CLRFUXudLA1WyuUU6bDX
	9b2H7O5XlbCvVtiMIWbygQsjsqZqVi8Ta22A1pZpZLKEGF8gfnP2tWVEnZGsvM8=
X-Google-Smtp-Source: AGHT+IGCXVfciDl7JiSO6buExLa3+C8TnQurwuTFrk5f2JHildkzakc9BuJ3BXKSKyYrUkWQHb1c5w==
X-Received: by 2002:a17:907:1314:b0:a68:86b9:52e8 with SMTP id a640c23a62f3a-a6886b9537dmr64684866b.68.1717156931323;
        Fri, 31 May 2024 05:02:11 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-160.dynamic.mnet-online.de. [82.135.80.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e6f030f7sm81539066b.10.2024.05.31.05.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 05:02:10 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Nicolas Pitre <nico@fluxnic.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Arnd Bergmann <arnd@arndb.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH net-next v2] net: smc91x: Refactor SMC_* macros
Date: Fri, 31 May 2024 14:01:04 +0200
Message-ID: <20240531120103.565490-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the macro parameter lp directly instead of relying on ioaddr being
defined in the surrounding scope.

The macros SMC_CURRENT_BANK(), SMC_SELECT_BANK(), SMC_GET_BASE(), and
SMC_GET_REV() take an additional parameter ioaddr to use a different
address if necessary (e.g., as in smc_probe()).

Relying on implicitly defined variable names in C macros is generally
considered bad practice and can be avoided by using explicit parameters.

Compile-tested only.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Add macro parameter ioaddr where necessary to fix smc_probe() after
  feedback from Jakub Kicinski
- Update patch description
- Link to v1: https://lore.kernel.org/linux-kernel/20240528104421.399885-3-thorsten.blum@toblux.com/
---
 drivers/net/ethernet/smsc/smc91x.c | 132 +++++++++++--------------
 drivers/net/ethernet/smsc/smc91x.h | 152 ++++++++++++++---------------
 2 files changed, 131 insertions(+), 153 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 78ff3af7911a..b008385a92dd 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -239,7 +239,6 @@ static inline void PRINT_PKT(u_char *buf, int length) { }
 static void smc_reset(struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	unsigned int ctl, cfg;
 	struct sk_buff *pending_skb;
 
@@ -247,7 +246,7 @@ static void smc_reset(struct net_device *dev)
 
 	/* Disable all interrupts, block TX tasklet */
 	spin_lock_irq(&lp->lock);
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 	SMC_SET_INT_MASK(lp, 0);
 	pending_skb = lp->pending_tx_skb;
 	lp->pending_tx_skb = NULL;
@@ -264,7 +263,7 @@ static void smc_reset(struct net_device *dev)
 	 * This resets the registers mostly to defaults, but doesn't
 	 * affect EEPROM.  That seems unnecessary
 	 */
-	SMC_SELECT_BANK(lp, 0);
+	SMC_SELECT_BANK(lp, 0, lp->base);
 	SMC_SET_RCR(lp, RCR_SOFTRST);
 
 	/*
@@ -272,7 +271,7 @@ static void smc_reset(struct net_device *dev)
 	 * This is necessary because the CONFIG_REG is not affected
 	 * by a soft reset
 	 */
-	SMC_SELECT_BANK(lp, 1);
+	SMC_SELECT_BANK(lp, 1, lp->base);
 
 	cfg = CONFIG_DEFAULT;
 
@@ -303,11 +302,11 @@ static void smc_reset(struct net_device *dev)
 	udelay(1);
 
 	/* Disable transmit and receive functionality */
-	SMC_SELECT_BANK(lp, 0);
+	SMC_SELECT_BANK(lp, 0, lp->base);
 	SMC_SET_RCR(lp, RCR_CLEAR);
 	SMC_SET_TCR(lp, TCR_CLEAR);
 
-	SMC_SELECT_BANK(lp, 1);
+	SMC_SELECT_BANK(lp, 1, lp->base);
 	ctl = SMC_GET_CTL(lp) | CTL_LE_ENABLE;
 
 	/*
@@ -322,7 +321,7 @@ static void smc_reset(struct net_device *dev)
 	SMC_SET_CTL(lp, ctl);
 
 	/* Reset the MMU */
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 	SMC_SET_MMU_CMD(lp, MC_RESET);
 	SMC_WAIT_MMU_BUSY(lp);
 }
@@ -333,24 +332,23 @@ static void smc_reset(struct net_device *dev)
 static void smc_enable(struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	int mask;
 
 	DBG(2, dev, "%s\n", __func__);
 
 	/* see the header file for options in TCR/RCR DEFAULT */
-	SMC_SELECT_BANK(lp, 0);
+	SMC_SELECT_BANK(lp, 0, lp->base);
 	SMC_SET_TCR(lp, lp->tcr_cur_mode);
 	SMC_SET_RCR(lp, lp->rcr_cur_mode);
 
-	SMC_SELECT_BANK(lp, 1);
+	SMC_SELECT_BANK(lp, 1, lp->base);
 	SMC_SET_MAC_ADDR(lp, dev->dev_addr);
 
 	/* now, enable interrupts */
 	mask = IM_EPH_INT|IM_RX_OVRN_INT|IM_RCV_INT;
 	if (lp->version >= (CHIP_91100 << 4))
 		mask |= IM_MDINT;
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 	SMC_SET_INT_MASK(lp, mask);
 
 	/*
@@ -367,14 +365,13 @@ static void smc_enable(struct net_device *dev)
 static void smc_shutdown(struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	struct sk_buff *pending_skb;
 
 	DBG(2, dev, "%s: %s\n", CARDNAME, __func__);
 
 	/* no more interrupts for me */
 	spin_lock_irq(&lp->lock);
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 	SMC_SET_INT_MASK(lp, 0);
 	pending_skb = lp->pending_tx_skb;
 	lp->pending_tx_skb = NULL;
@@ -382,13 +379,13 @@ static void smc_shutdown(struct net_device *dev)
 	dev_kfree_skb(pending_skb);
 
 	/* and tell the card to stay away from that nasty outside world */
-	SMC_SELECT_BANK(lp, 0);
+	SMC_SELECT_BANK(lp, 0, lp->base);
 	SMC_SET_RCR(lp, RCR_CLEAR);
 	SMC_SET_TCR(lp, TCR_CLEAR);
 
 #ifdef POWER_DOWN
 	/* finally, shut the chip down */
-	SMC_SELECT_BANK(lp, 1);
+	SMC_SELECT_BANK(lp, 1, lp->base);
 	SMC_SET_CONFIG(lp, SMC_GET_CONFIG(lp) & ~CONFIG_EPH_POWER_EN);
 #endif
 }
@@ -399,7 +396,6 @@ static void smc_shutdown(struct net_device *dev)
 static inline void  smc_rcv(struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	unsigned int packet_number, status, packet_len;
 
 	DBG(3, dev, "%s\n", __func__);
@@ -540,7 +536,6 @@ static void smc_hardware_send_pkt(struct tasklet_struct *t)
 {
 	struct smc_local *lp = from_tasklet(lp, t, tx_task);
 	struct net_device *dev = lp->dev;
-	void __iomem *ioaddr = lp->base;
 	struct sk_buff *skb;
 	unsigned int packet_no, len;
 	unsigned char *buf;
@@ -590,7 +585,7 @@ static void smc_hardware_send_pkt(struct tasklet_struct *t)
 	SMC_PUSH_DATA(lp, buf, len & ~1);
 
 	/* Send final ctl word with the last byte if there is one */
-	SMC_outw(lp, ((len & 1) ? (0x2000 | buf[len - 1]) : 0), ioaddr,
+	SMC_outw(lp, ((len & 1) ? (0x2000 | buf[len - 1]) : 0), lp->base,
 		 DATA_REG(lp));
 
 	/*
@@ -630,7 +625,6 @@ static netdev_tx_t
 smc_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	unsigned int numPages, poll_count, status;
 	unsigned long flags;
 
@@ -703,7 +697,6 @@ smc_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 static void smc_tx(struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	unsigned int saved_packet, packet_no, tx_status;
 	unsigned int pkt_len __always_unused;
 
@@ -751,9 +744,9 @@ static void smc_tx(struct net_device *dev)
 	SMC_SET_PN(lp, saved_packet);
 
 	/* re-enable transmit */
-	SMC_SELECT_BANK(lp, 0);
+	SMC_SELECT_BANK(lp, 0, lp->base);
 	SMC_SET_TCR(lp, lp->tcr_cur_mode);
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 }
 
 
@@ -762,7 +755,6 @@ static void smc_tx(struct net_device *dev)
 static void smc_mii_out(struct net_device *dev, unsigned int val, int bits)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	unsigned int mii_reg, mask;
 
 	mii_reg = SMC_GET_MII(lp) & ~(MII_MCLK | MII_MDOE | MII_MDO);
@@ -784,7 +776,6 @@ static void smc_mii_out(struct net_device *dev, unsigned int val, int bits)
 static unsigned int smc_mii_in(struct net_device *dev, int bits)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	unsigned int mii_reg, mask, val;
 
 	mii_reg = SMC_GET_MII(lp) & ~(MII_MCLK | MII_MDOE | MII_MDO);
@@ -809,10 +800,9 @@ static unsigned int smc_mii_in(struct net_device *dev, int bits)
 static int smc_phy_read(struct net_device *dev, int phyaddr, int phyreg)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	unsigned int phydata;
 
-	SMC_SELECT_BANK(lp, 3);
+	SMC_SELECT_BANK(lp, 3, lp->base);
 
 	/* Idle - 32 ones */
 	smc_mii_out(dev, 0xffffffff, 32);
@@ -829,7 +819,7 @@ static int smc_phy_read(struct net_device *dev, int phyaddr, int phyreg)
 	DBG(3, dev, "%s: phyaddr=0x%x, phyreg=0x%x, phydata=0x%x\n",
 	    __func__, phyaddr, phyreg, phydata);
 
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 	return phydata;
 }
 
@@ -840,9 +830,8 @@ static void smc_phy_write(struct net_device *dev, int phyaddr, int phyreg,
 			  int phydata)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 
-	SMC_SELECT_BANK(lp, 3);
+	SMC_SELECT_BANK(lp, 3, lp->base);
 
 	/* Idle - 32 ones */
 	smc_mii_out(dev, 0xffffffff, 32);
@@ -856,7 +845,7 @@ static void smc_phy_write(struct net_device *dev, int phyaddr, int phyreg,
 	DBG(3, dev, "%s: phyaddr=0x%x, phyreg=0x%x, phydata=0x%x\n",
 	    __func__, phyaddr, phyreg, phydata);
 
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 }
 
 /*
@@ -902,7 +891,6 @@ static void smc_phy_detect(struct net_device *dev)
 static int smc_phy_fixed(struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	int phyaddr = lp->mii.phy_id;
 	int bmcr, cfg1;
 
@@ -929,9 +917,9 @@ static int smc_phy_fixed(struct net_device *dev)
 	smc_phy_write(dev, phyaddr, MII_BMCR, bmcr);
 
 	/* Re-Configure the Receive/Phy Control register */
-	SMC_SELECT_BANK(lp, 0);
+	SMC_SELECT_BANK(lp, 0, lp->base);
 	SMC_SET_RPC(lp, lp->rpc_cur_mode);
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 
 	return 1;
 }
@@ -1005,7 +993,6 @@ static void smc_phy_powerdown(struct net_device *dev)
 static void smc_phy_check_media(struct net_device *dev, int init)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 
 	if (mii_check_media(&lp->mii, netif_msg_link(lp), init)) {
 		/* duplex state has changed */
@@ -1015,7 +1002,7 @@ static void smc_phy_check_media(struct net_device *dev, int init)
 			lp->tcr_cur_mode &= ~TCR_SWFDUP;
 		}
 
-		SMC_SELECT_BANK(lp, 0);
+		SMC_SELECT_BANK(lp, 0, lp->base);
 		SMC_SET_TCR(lp, lp->tcr_cur_mode);
 	}
 }
@@ -1034,7 +1021,6 @@ static void smc_phy_configure(struct work_struct *work)
 	struct smc_local *lp =
 		container_of(work, struct smc_local, phy_configure);
 	struct net_device *dev = lp->dev;
-	void __iomem *ioaddr = lp->base;
 	int phyaddr = lp->mii.phy_id;
 	int my_phy_caps; /* My PHY capabilities */
 	int my_ad_caps; /* My Advertised capabilities */
@@ -1064,7 +1050,7 @@ static void smc_phy_configure(struct work_struct *work)
 		PHY_INT_SPDDET | PHY_INT_DPLXDET);
 
 	/* Configure the Receive/Phy Control register */
-	SMC_SELECT_BANK(lp, 0);
+	SMC_SELECT_BANK(lp, 0, lp->base);
 	SMC_SET_RPC(lp, lp->rpc_cur_mode);
 
 	/* If the user requested no auto neg, then go set his request */
@@ -1122,7 +1108,7 @@ static void smc_phy_configure(struct work_struct *work)
 	smc_phy_check_media(dev, 1);
 
 smc_phy_configure_exit:
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 	spin_unlock_irq(&lp->lock);
 }
 
@@ -1158,14 +1144,13 @@ static void smc_phy_interrupt(struct net_device *dev)
 static void smc_10bt_check_media(struct net_device *dev, int init)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	unsigned int old_carrier, new_carrier;
 
 	old_carrier = netif_carrier_ok(dev) ? 1 : 0;
 
-	SMC_SELECT_BANK(lp, 0);
+	SMC_SELECT_BANK(lp, 0, lp->base);
 	new_carrier = (SMC_GET_EPH_STATUS(lp) & ES_LINK_OK) ? 1 : 0;
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 
 	if (init || (old_carrier != new_carrier)) {
 		if (!new_carrier) {
@@ -1182,16 +1167,15 @@ static void smc_10bt_check_media(struct net_device *dev, int init)
 static void smc_eph_interrupt(struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	unsigned int ctl;
 
 	smc_10bt_check_media(dev, 0);
 
-	SMC_SELECT_BANK(lp, 1);
+	SMC_SELECT_BANK(lp, 1, lp->base);
 	ctl = SMC_GET_CTL(lp);
 	SMC_SET_CTL(lp, ctl & ~CTL_LE_ENABLE);
 	SMC_SET_CTL(lp, ctl);
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 }
 
 /*
@@ -1202,7 +1186,6 @@ static irqreturn_t smc_interrupt(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	int status, mask, timeout, card_stats;
 	int saved_pointer;
 
@@ -1227,9 +1210,9 @@ static irqreturn_t smc_interrupt(int irq, void *dev_id)
 
 		DBG(2, dev, "INT 0x%02x MASK 0x%02x MEM 0x%04x FIFO 0x%04x\n",
 		    status, mask,
-		    ({ int meminfo; SMC_SELECT_BANK(lp, 0);
+		    ({ int meminfo; SMC_SELECT_BANK(lp, 0, lp->base);
 		       meminfo = SMC_GET_MIR(lp);
-		       SMC_SELECT_BANK(lp, 2); meminfo; }),
+		       SMC_SELECT_BANK(lp, 2, lp->base); meminfo; }),
 		    SMC_GET_FIFO(lp));
 
 		status &= mask;
@@ -1255,9 +1238,9 @@ static irqreturn_t smc_interrupt(int irq, void *dev_id)
 			mask &= ~IM_TX_EMPTY_INT;
 
 			/* update stats */
-			SMC_SELECT_BANK(lp, 0);
+			SMC_SELECT_BANK(lp, 0, lp->base);
 			card_stats = SMC_GET_COUNTER(lp);
-			SMC_SELECT_BANK(lp, 2);
+			SMC_SELECT_BANK(lp, 2, lp->base);
 
 			/* single collisions */
 			dev->stats.collisions += card_stats & 0xF;
@@ -1267,9 +1250,9 @@ static irqreturn_t smc_interrupt(int irq, void *dev_id)
 			dev->stats.collisions += card_stats & 0xF;
 		} else if (status & IM_RX_OVRN_INT) {
 			DBG(1, dev, "RX overrun (EPH_ST 0x%04x)\n",
-			    ({ int eph_st; SMC_SELECT_BANK(lp, 0);
+			    ({ int eph_st; SMC_SELECT_BANK(lp, 0, lp->base);
 			       eph_st = SMC_GET_EPH_STATUS(lp);
-			       SMC_SELECT_BANK(lp, 2); eph_st; }));
+			       SMC_SELECT_BANK(lp, 2, lp->base); eph_st; }));
 			SMC_ACK_INT(lp, IM_RX_OVRN_INT);
 			dev->stats.rx_errors++;
 			dev->stats.rx_fifo_errors++;
@@ -1325,7 +1308,6 @@ static void smc_poll_controller(struct net_device *dev)
 static void smc_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	int status, mask, eph_st, meminfo, fifo;
 
 	DBG(2, dev, "%s\n", __func__);
@@ -1334,10 +1316,10 @@ static void smc_timeout(struct net_device *dev, unsigned int txqueue)
 	status = SMC_GET_INT(lp);
 	mask = SMC_GET_INT_MASK(lp);
 	fifo = SMC_GET_FIFO(lp);
-	SMC_SELECT_BANK(lp, 0);
+	SMC_SELECT_BANK(lp, 0, lp->base);
 	eph_st = SMC_GET_EPH_STATUS(lp);
 	meminfo = SMC_GET_MIR(lp);
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 	spin_unlock_irq(&lp->lock);
 	PRINTK(dev, "TX timeout (INT 0x%02x INTMASK 0x%02x MEM 0x%04x FIFO 0x%04x EPH_ST 0x%04x)\n",
 	       status, mask, meminfo, fifo, eph_st);
@@ -1367,7 +1349,6 @@ static void smc_timeout(struct net_device *dev, unsigned int txqueue)
 static void smc_set_multicast_list(struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	unsigned char multicast_table[8];
 	int update_multicast = 0;
 
@@ -1443,13 +1424,13 @@ static void smc_set_multicast_list(struct net_device *dev)
 	}
 
 	spin_lock_irq(&lp->lock);
-	SMC_SELECT_BANK(lp, 0);
+	SMC_SELECT_BANK(lp, 0, lp->base);
 	SMC_SET_RCR(lp, lp->rcr_cur_mode);
 	if (update_multicast) {
-		SMC_SELECT_BANK(lp, 3);
+		SMC_SELECT_BANK(lp, 3, lp->base);
 		SMC_SET_MCAST(lp, multicast_table);
 	}
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 	spin_unlock_irq(&lp->lock);
 }
 
@@ -1625,17 +1606,16 @@ static int smc_write_eeprom_word(struct net_device *dev, u16 addr, u16 word)
 {
 	u16 ctl;
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 
 	spin_lock_irq(&lp->lock);
 	/* load word into GP register */
-	SMC_SELECT_BANK(lp, 1);
+	SMC_SELECT_BANK(lp, 1, lp->base);
 	SMC_SET_GP(lp, word);
 	/* set the address to put the data in EEPROM */
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 	SMC_SET_PTR(lp, addr);
 	/* tell it to write */
-	SMC_SELECT_BANK(lp, 1);
+	SMC_SELECT_BANK(lp, 1, lp->base);
 	ctl = SMC_GET_CTL(lp);
 	SMC_SET_CTL(lp, ctl | (CTL_EEPROM_SELECT | CTL_STORE));
 	/* wait for it to finish */
@@ -1644,7 +1624,7 @@ static int smc_write_eeprom_word(struct net_device *dev, u16 addr, u16 word)
 	} while (SMC_GET_CTL(lp) & CTL_STORE);
 	/* clean up */
 	SMC_SET_CTL(lp, ctl);
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 	spin_unlock_irq(&lp->lock);
 	return 0;
 }
@@ -1653,14 +1633,13 @@ static int smc_read_eeprom_word(struct net_device *dev, u16 addr, u16 *word)
 {
 	u16 ctl;
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 
 	spin_lock_irq(&lp->lock);
 	/* set the EEPROM address to get the data from */
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 	SMC_SET_PTR(lp, addr | PTR_READ);
 	/* tell it to load */
-	SMC_SELECT_BANK(lp, 1);
+	SMC_SELECT_BANK(lp, 1, lp->base);
 	SMC_SET_GP(lp, 0xffff);	/* init to known */
 	ctl = SMC_GET_CTL(lp);
 	SMC_SET_CTL(lp, ctl | (CTL_EEPROM_SELECT | CTL_RELOAD));
@@ -1672,7 +1651,7 @@ static int smc_read_eeprom_word(struct net_device *dev, u16 addr, u16 *word)
 	*word = SMC_GET_GP(lp);
 	/* clean up */
 	SMC_SET_CTL(lp, ctl);
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 	spin_unlock_irq(&lp->lock);
 	return 0;
 }
@@ -1773,7 +1752,6 @@ static const struct net_device_ops smc_netdev_ops = {
  */
 static int smc_findirq(struct smc_local *lp)
 {
-	void __iomem *ioaddr = lp->base;
 	int timeout = 20;
 	unsigned long cookie;
 
@@ -1787,7 +1765,7 @@ static int smc_findirq(struct smc_local *lp)
 	 * when done.
 	 */
 	/* enable ALLOCation interrupts ONLY */
-	SMC_SELECT_BANK(lp, 2);
+	SMC_SELECT_BANK(lp, 2, lp->base);
 	SMC_SET_INT_MASK(lp, IM_ALLOC_INT);
 
 	/*
@@ -1857,7 +1835,7 @@ static int smc_probe(struct net_device *dev, void __iomem *ioaddr,
 	DBG(2, dev, "%s: %s\n", CARDNAME, __func__);
 
 	/* First, see if the high byte is 0x33 */
-	val = SMC_CURRENT_BANK(lp);
+	val = SMC_CURRENT_BANK(lp, ioaddr);
 	DBG(2, dev, "%s: bank signature probe returned 0x%04x\n",
 	    CARDNAME, val);
 	if ((val & 0xFF00) != 0x3300) {
@@ -1874,8 +1852,8 @@ static int smc_probe(struct net_device *dev, void __iomem *ioaddr,
 	 * The above MIGHT indicate a device, but I need to write to
 	 * further test this.
 	 */
-	SMC_SELECT_BANK(lp, 0);
-	val = SMC_CURRENT_BANK(lp);
+	SMC_SELECT_BANK(lp, 0, ioaddr);
+	val = SMC_CURRENT_BANK(lp, ioaddr);
 	if ((val & 0xFF00) != 0x3300) {
 		retval = -ENODEV;
 		goto err_out;
@@ -1887,8 +1865,8 @@ static int smc_probe(struct net_device *dev, void __iomem *ioaddr,
 	 * register to bank 1, so I can access the base address
 	 * register
 	 */
-	SMC_SELECT_BANK(lp, 1);
-	val = SMC_GET_BASE(lp);
+	SMC_SELECT_BANK(lp, 1, ioaddr);
+	val = SMC_GET_BASE(lp, ioaddr);
 	val = ((val & 0x1F00) >> 3) << SMC_IO_SHIFT;
 	if (((unsigned long)ioaddr & (0x3e0 << SMC_IO_SHIFT)) != val) {
 		netdev_warn(dev, "%s: IOADDR %p doesn't match configuration (%x).\n",
@@ -1900,8 +1878,8 @@ static int smc_probe(struct net_device *dev, void __iomem *ioaddr,
 	 * recognize.  These might need to be added to later,
 	 * as future revisions could be added.
 	 */
-	SMC_SELECT_BANK(lp, 3);
-	revision_register = SMC_GET_REV(lp);
+	SMC_SELECT_BANK(lp, 3, ioaddr);
+	revision_register = SMC_GET_REV(lp, ioaddr);
 	DBG(2, dev, "%s: revision = 0x%04x\n", CARDNAME, revision_register);
 	version_string = chip_ids[ (revision_register >> 4) & 0xF];
 	if (!version_string || (revision_register & 0xff00) != 0x3300) {
@@ -1923,7 +1901,7 @@ static int smc_probe(struct net_device *dev, void __iomem *ioaddr,
 	spin_lock_init(&lp->lock);
 
 	/* Get the MAC address */
-	SMC_SELECT_BANK(lp, 1);
+	SMC_SELECT_BANK(lp, 1, lp->base);
 	SMC_GET_MAC_ADDR(lp, addr);
 	eth_hw_addr_set(dev, addr);
 
diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 45ef5ac0788a..561a1b958fd0 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -815,7 +815,7 @@ static const char * chip_ids[ 16 ] =  {
 #if SMC_DEBUG > 0
 #define SMC_REG(lp, reg, bank)					\
 	({								\
-		int __b = SMC_CURRENT_BANK(lp);			\
+		int __b = SMC_CURRENT_BANK(lp, lp->base);		\
 		if (unlikely((__b & ~0xf0) != (0x3300 | bank))) {	\
 			pr_err("%s: bank reg screwed (0x%04x)\n",	\
 			       CARDNAME, __b);				\
@@ -839,64 +839,64 @@ static const char * chip_ids[ 16 ] =  {
 #define SMC_MUST_ALIGN_WRITE(lp)	SMC_32BIT(lp)
 
 #define SMC_GET_PN(lp)						\
-	(SMC_8BIT(lp)	? (SMC_inb(ioaddr, PN_REG(lp)))	\
-				: (SMC_inw(ioaddr, PN_REG(lp)) & 0xFF))
+	(SMC_8BIT(lp)	? (SMC_inb(lp->base, PN_REG(lp)))	\
+				: (SMC_inw(lp->base, PN_REG(lp)) & 0xFF))
 
 #define SMC_SET_PN(lp, x)						\
 	do {								\
 		if (SMC_MUST_ALIGN_WRITE(lp))				\
-			SMC_outl((x)<<16, ioaddr, SMC_REG(lp, 0, 2));	\
+			SMC_outl((x)<<16, lp->base, SMC_REG(lp, 0, 2));	\
 		else if (SMC_8BIT(lp))				\
-			SMC_outb(x, ioaddr, PN_REG(lp));		\
+			SMC_outb(x, lp->base, PN_REG(lp));		\
 		else							\
-			SMC_outw(lp, x, ioaddr, PN_REG(lp));		\
+			SMC_outw(lp, x, lp->base, PN_REG(lp));		\
 	} while (0)
 
 #define SMC_GET_AR(lp)						\
-	(SMC_8BIT(lp)	? (SMC_inb(ioaddr, AR_REG(lp)))	\
-				: (SMC_inw(ioaddr, PN_REG(lp)) >> 8))
+	(SMC_8BIT(lp)	? (SMC_inb(lp->base, AR_REG(lp)))	\
+				: (SMC_inw(lp->base, PN_REG(lp)) >> 8))
 
 #define SMC_GET_TXFIFO(lp)						\
-	(SMC_8BIT(lp)	? (SMC_inb(ioaddr, TXFIFO_REG(lp)))	\
-				: (SMC_inw(ioaddr, TXFIFO_REG(lp)) & 0xFF))
+	(SMC_8BIT(lp)	? (SMC_inb(lp->base, TXFIFO_REG(lp)))	\
+				: (SMC_inw(lp->base, TXFIFO_REG(lp)) & 0xFF))
 
 #define SMC_GET_RXFIFO(lp)						\
-	(SMC_8BIT(lp)	? (SMC_inb(ioaddr, RXFIFO_REG(lp)))	\
-				: (SMC_inw(ioaddr, TXFIFO_REG(lp)) >> 8))
+	(SMC_8BIT(lp)	? (SMC_inb(lp->base, RXFIFO_REG(lp)))	\
+				: (SMC_inw(lp->base, TXFIFO_REG(lp)) >> 8))
 
 #define SMC_GET_INT(lp)						\
-	(SMC_8BIT(lp)	? (SMC_inb(ioaddr, INT_REG(lp)))	\
-				: (SMC_inw(ioaddr, INT_REG(lp)) & 0xFF))
+	(SMC_8BIT(lp)	? (SMC_inb(lp->base, INT_REG(lp)))	\
+				: (SMC_inw(lp->base, INT_REG(lp)) & 0xFF))
 
 #define SMC_ACK_INT(lp, x)						\
 	do {								\
 		if (SMC_8BIT(lp))					\
-			SMC_outb(x, ioaddr, INT_REG(lp));		\
+			SMC_outb(x, lp->base, INT_REG(lp));		\
 		else {							\
 			unsigned long __flags;				\
 			int __mask;					\
 			local_irq_save(__flags);			\
-			__mask = SMC_inw(ioaddr, INT_REG(lp)) & ~0xff; \
-			SMC_outw(lp, __mask | (x), ioaddr, INT_REG(lp)); \
+			__mask = SMC_inw(lp->base, INT_REG(lp)) & ~0xff; \
+			SMC_outw(lp, __mask | (x), lp->base, INT_REG(lp)); \
 			local_irq_restore(__flags);			\
 		}							\
 	} while (0)
 
 #define SMC_GET_INT_MASK(lp)						\
-	(SMC_8BIT(lp)	? (SMC_inb(ioaddr, IM_REG(lp)))	\
-				: (SMC_inw(ioaddr, INT_REG(lp)) >> 8))
+	(SMC_8BIT(lp)	? (SMC_inb(lp->base, IM_REG(lp)))	\
+				: (SMC_inw(lp->base, INT_REG(lp)) >> 8))
 
 #define SMC_SET_INT_MASK(lp, x)					\
 	do {								\
 		if (SMC_8BIT(lp))					\
-			SMC_outb(x, ioaddr, IM_REG(lp));		\
+			SMC_outb(x, lp->base, IM_REG(lp));		\
 		else							\
-			SMC_outw(lp, (x) << 8, ioaddr, INT_REG(lp));	\
+			SMC_outw(lp, (x) << 8, lp->base, INT_REG(lp));	\
 	} while (0)
 
-#define SMC_CURRENT_BANK(lp)	SMC_inw(ioaddr, BANK_SELECT)
+#define SMC_CURRENT_BANK(lp, ioaddr)	SMC_inw(ioaddr, BANK_SELECT)
 
-#define SMC_SELECT_BANK(lp, x)					\
+#define SMC_SELECT_BANK(lp, x, ioaddr)					\
 	do {								\
 		if (SMC_MUST_ALIGN_WRITE(lp))				\
 			SMC_outl((x)<<16, ioaddr, 12<<SMC_IO_SHIFT);	\
@@ -904,125 +904,125 @@ static const char * chip_ids[ 16 ] =  {
 			SMC_outw(lp, x, ioaddr, BANK_SELECT);		\
 	} while (0)
 
-#define SMC_GET_BASE(lp)		SMC_inw(ioaddr, BASE_REG(lp))
+#define SMC_GET_BASE(lp, ioaddr)	SMC_inw(ioaddr, BASE_REG(lp))
 
-#define SMC_SET_BASE(lp, x)	SMC_outw(lp, x, ioaddr, BASE_REG(lp))
+#define SMC_SET_BASE(lp, x)	SMC_outw(lp, x, lp->base, BASE_REG(lp))
 
-#define SMC_GET_CONFIG(lp)	SMC_inw(ioaddr, CONFIG_REG(lp))
+#define SMC_GET_CONFIG(lp)	SMC_inw(lp->base, CONFIG_REG(lp))
 
-#define SMC_SET_CONFIG(lp, x)	SMC_outw(lp, x, ioaddr, CONFIG_REG(lp))
+#define SMC_SET_CONFIG(lp, x)	SMC_outw(lp, x, lp->base, CONFIG_REG(lp))
 
-#define SMC_GET_COUNTER(lp)	SMC_inw(ioaddr, COUNTER_REG(lp))
+#define SMC_GET_COUNTER(lp)	SMC_inw(lp->base, COUNTER_REG(lp))
 
-#define SMC_GET_CTL(lp)		SMC_inw(ioaddr, CTL_REG(lp))
+#define SMC_GET_CTL(lp)		SMC_inw(lp->base, CTL_REG(lp))
 
-#define SMC_SET_CTL(lp, x)	SMC_outw(lp, x, ioaddr, CTL_REG(lp))
+#define SMC_SET_CTL(lp, x)	SMC_outw(lp, x, lp->base, CTL_REG(lp))
 
-#define SMC_GET_MII(lp)		SMC_inw(ioaddr, MII_REG(lp))
+#define SMC_GET_MII(lp)		SMC_inw(lp->base, MII_REG(lp))
 
-#define SMC_GET_GP(lp)		SMC_inw(ioaddr, GP_REG(lp))
+#define SMC_GET_GP(lp)		SMC_inw(lp->base, GP_REG(lp))
 
 #define SMC_SET_GP(lp, x)						\
 	do {								\
 		if (SMC_MUST_ALIGN_WRITE(lp))				\
-			SMC_outl((x)<<16, ioaddr, SMC_REG(lp, 8, 1));	\
+			SMC_outl((x)<<16, lp->base, SMC_REG(lp, 8, 1));	\
 		else							\
-			SMC_outw(lp, x, ioaddr, GP_REG(lp));		\
+			SMC_outw(lp, x, lp->base, GP_REG(lp));		\
 	} while (0)
 
-#define SMC_SET_MII(lp, x)	SMC_outw(lp, x, ioaddr, MII_REG(lp))
+#define SMC_SET_MII(lp, x)	SMC_outw(lp, x, lp->base, MII_REG(lp))
 
-#define SMC_GET_MIR(lp)		SMC_inw(ioaddr, MIR_REG(lp))
+#define SMC_GET_MIR(lp)		SMC_inw(lp->base, MIR_REG(lp))
 
-#define SMC_SET_MIR(lp, x)	SMC_outw(lp, x, ioaddr, MIR_REG(lp))
+#define SMC_SET_MIR(lp, x)	SMC_outw(lp, x, lp->base, MIR_REG(lp))
 
-#define SMC_GET_MMU_CMD(lp)	SMC_inw(ioaddr, MMU_CMD_REG(lp))
+#define SMC_GET_MMU_CMD(lp)	SMC_inw(lp->base, MMU_CMD_REG(lp))
 
-#define SMC_SET_MMU_CMD(lp, x)	SMC_outw(lp, x, ioaddr, MMU_CMD_REG(lp))
+#define SMC_SET_MMU_CMD(lp, x)	SMC_outw(lp, x, lp->base, MMU_CMD_REG(lp))
 
-#define SMC_GET_FIFO(lp)	SMC_inw(ioaddr, FIFO_REG(lp))
+#define SMC_GET_FIFO(lp)	SMC_inw(lp->base, FIFO_REG(lp))
 
-#define SMC_GET_PTR(lp)		SMC_inw(ioaddr, PTR_REG(lp))
+#define SMC_GET_PTR(lp)		SMC_inw(lp->base, PTR_REG(lp))
 
 #define SMC_SET_PTR(lp, x)						\
 	do {								\
 		if (SMC_MUST_ALIGN_WRITE(lp))				\
-			SMC_outl((x)<<16, ioaddr, SMC_REG(lp, 4, 2));	\
+			SMC_outl((x)<<16, lp->base, SMC_REG(lp, 4, 2));	\
 		else							\
-			SMC_outw(lp, x, ioaddr, PTR_REG(lp));		\
+			SMC_outw(lp, x, lp->base, PTR_REG(lp));		\
 	} while (0)
 
-#define SMC_GET_EPH_STATUS(lp)	SMC_inw(ioaddr, EPH_STATUS_REG(lp))
+#define SMC_GET_EPH_STATUS(lp)	SMC_inw(lp->base, EPH_STATUS_REG(lp))
 
-#define SMC_GET_RCR(lp)		SMC_inw(ioaddr, RCR_REG(lp))
+#define SMC_GET_RCR(lp)		SMC_inw(lp->base, RCR_REG(lp))
 
-#define SMC_SET_RCR(lp, x)		SMC_outw(lp, x, ioaddr, RCR_REG(lp))
+#define SMC_SET_RCR(lp, x)		SMC_outw(lp, x, lp->base, RCR_REG(lp))
 
-#define SMC_GET_REV(lp)		SMC_inw(ioaddr, REV_REG(lp))
+#define SMC_GET_REV(lp, ioaddr)	SMC_inw(ioaddr, REV_REG(lp))
 
-#define SMC_GET_RPC(lp)		SMC_inw(ioaddr, RPC_REG(lp))
+#define SMC_GET_RPC(lp)		SMC_inw(lp->base, RPC_REG(lp))
 
 #define SMC_SET_RPC(lp, x)						\
 	do {								\
 		if (SMC_MUST_ALIGN_WRITE(lp))				\
-			SMC_outl((x)<<16, ioaddr, SMC_REG(lp, 8, 0));	\
+			SMC_outl((x)<<16, lp->base, SMC_REG(lp, 8, 0));	\
 		else							\
-			SMC_outw(lp, x, ioaddr, RPC_REG(lp));		\
+			SMC_outw(lp, x, lp->base, RPC_REG(lp));		\
 	} while (0)
 
-#define SMC_GET_TCR(lp)		SMC_inw(ioaddr, TCR_REG(lp))
+#define SMC_GET_TCR(lp)		SMC_inw(lp->base, TCR_REG(lp))
 
-#define SMC_SET_TCR(lp, x)	SMC_outw(lp, x, ioaddr, TCR_REG(lp))
+#define SMC_SET_TCR(lp, x)	SMC_outw(lp, x, lp->base, TCR_REG(lp))
 
 #ifndef SMC_GET_MAC_ADDR
 #define SMC_GET_MAC_ADDR(lp, addr)					\
 	do {								\
 		unsigned int __v;					\
-		__v = SMC_inw(ioaddr, ADDR0_REG(lp));			\
+		__v = SMC_inw(lp->base, ADDR0_REG(lp));			\
 		addr[0] = __v; addr[1] = __v >> 8;			\
-		__v = SMC_inw(ioaddr, ADDR1_REG(lp));			\
+		__v = SMC_inw(lp->base, ADDR1_REG(lp));			\
 		addr[2] = __v; addr[3] = __v >> 8;			\
-		__v = SMC_inw(ioaddr, ADDR2_REG(lp));			\
+		__v = SMC_inw(lp->base, ADDR2_REG(lp));			\
 		addr[4] = __v; addr[5] = __v >> 8;			\
 	} while (0)
 #endif
 
 #define SMC_SET_MAC_ADDR(lp, addr)					\
 	do {								\
-		SMC_outw(lp, addr[0] | (addr[1] << 8), ioaddr, ADDR0_REG(lp)); \
-		SMC_outw(lp, addr[2] | (addr[3] << 8), ioaddr, ADDR1_REG(lp)); \
-		SMC_outw(lp, addr[4] | (addr[5] << 8), ioaddr, ADDR2_REG(lp)); \
+		SMC_outw(lp, addr[0] | (addr[1] << 8), lp->base, ADDR0_REG(lp)); \
+		SMC_outw(lp, addr[2] | (addr[3] << 8), lp->base, ADDR1_REG(lp)); \
+		SMC_outw(lp, addr[4] | (addr[5] << 8), lp->base, ADDR2_REG(lp)); \
 	} while (0)
 
 #define SMC_SET_MCAST(lp, x)						\
 	do {								\
 		const unsigned char *mt = (x);				\
-		SMC_outw(lp, mt[0] | (mt[1] << 8), ioaddr, MCAST_REG1(lp)); \
-		SMC_outw(lp, mt[2] | (mt[3] << 8), ioaddr, MCAST_REG2(lp)); \
-		SMC_outw(lp, mt[4] | (mt[5] << 8), ioaddr, MCAST_REG3(lp)); \
-		SMC_outw(lp, mt[6] | (mt[7] << 8), ioaddr, MCAST_REG4(lp)); \
+		SMC_outw(lp, mt[0] | (mt[1] << 8), lp->base, MCAST_REG1(lp)); \
+		SMC_outw(lp, mt[2] | (mt[3] << 8), lp->base, MCAST_REG2(lp)); \
+		SMC_outw(lp, mt[4] | (mt[5] << 8), lp->base, MCAST_REG3(lp)); \
+		SMC_outw(lp, mt[6] | (mt[7] << 8), lp->base, MCAST_REG4(lp)); \
 	} while (0)
 
 #define SMC_PUT_PKT_HDR(lp, status, length)				\
 	do {								\
 		if (SMC_32BIT(lp))					\
-			SMC_outl((status) | (length)<<16, ioaddr,	\
+			SMC_outl((status) | (length)<<16, lp->base,	\
 				 DATA_REG(lp));			\
 		else {							\
-			SMC_outw(lp, status, ioaddr, DATA_REG(lp));	\
-			SMC_outw(lp, length, ioaddr, DATA_REG(lp));	\
+			SMC_outw(lp, status, lp->base, DATA_REG(lp));	\
+			SMC_outw(lp, length, lp->base, DATA_REG(lp));	\
 		}							\
 	} while (0)
 
 #define SMC_GET_PKT_HDR(lp, status, length)				\
 	do {								\
 		if (SMC_32BIT(lp)) {				\
-			unsigned int __val = SMC_inl(ioaddr, DATA_REG(lp)); \
+			unsigned int __val = SMC_inl(lp->base, DATA_REG(lp)); \
 			(status) = __val & 0xffff;			\
 			(length) = __val >> 16;				\
 		} else {						\
-			(status) = SMC_inw(ioaddr, DATA_REG(lp));	\
-			(length) = SMC_inw(ioaddr, DATA_REG(lp));	\
+			(status) = SMC_inw(lp->base, DATA_REG(lp));	\
+			(length) = SMC_inw(lp->base, DATA_REG(lp));	\
 		}							\
 	} while (0)
 
@@ -1031,10 +1031,10 @@ static const char * chip_ids[ 16 ] =  {
 		if (SMC_32BIT(lp)) {				\
 			void *__ptr = (p);				\
 			int __len = (l);				\
-			void __iomem *__ioaddr = ioaddr;		\
+			void __iomem *__ioaddr = lp->base;		\
 			if (__len >= 2 && (unsigned long)__ptr & 2) {	\
 				__len -= 2;				\
-				SMC_outsw(ioaddr, DATA_REG(lp), __ptr, 1); \
+				SMC_outsw(lp->base, DATA_REG(lp), __ptr, 1); \
 				__ptr += 2;				\
 			}						\
 			if (SMC_CAN_USE_DATACS && lp->datacs)		\
@@ -1042,12 +1042,12 @@ static const char * chip_ids[ 16 ] =  {
 			SMC_outsl(__ioaddr, DATA_REG(lp), __ptr, __len>>2); \
 			if (__len & 2) {				\
 				__ptr += (__len & ~3);			\
-				SMC_outsw(ioaddr, DATA_REG(lp), __ptr, 1); \
+				SMC_outsw(lp->base, DATA_REG(lp), __ptr, 1); \
 			}						\
 		} else if (SMC_16BIT(lp))				\
-			SMC_outsw(ioaddr, DATA_REG(lp), p, (l) >> 1);	\
+			SMC_outsw(lp->base, DATA_REG(lp), p, (l) >> 1);	\
 		else if (SMC_8BIT(lp))				\
-			SMC_outsb(ioaddr, DATA_REG(lp), p, l);	\
+			SMC_outsb(lp->base, DATA_REG(lp), p, l);	\
 	} while (0)
 
 #define SMC_PULL_DATA(lp, p, l)					\
@@ -1055,7 +1055,7 @@ static const char * chip_ids[ 16 ] =  {
 		if (SMC_32BIT(lp)) {				\
 			void *__ptr = (p);				\
 			int __len = (l);				\
-			void __iomem *__ioaddr = ioaddr;		\
+			void __iomem *__ioaddr = lp->base;		\
 			if ((unsigned long)__ptr & 2) {			\
 				/*					\
 				 * We want 32bit alignment here.	\
@@ -1080,9 +1080,9 @@ static const char * chip_ids[ 16 ] =  {
 			__len += 2;					\
 			SMC_insl(__ioaddr, DATA_REG(lp), __ptr, __len>>2); \
 		} else if (SMC_16BIT(lp))				\
-			SMC_insw(ioaddr, DATA_REG(lp), p, (l) >> 1);	\
+			SMC_insw(lp->base, DATA_REG(lp), p, (l) >> 1);	\
 		else if (SMC_8BIT(lp))				\
-			SMC_insb(ioaddr, DATA_REG(lp), p, l);		\
+			SMC_insb(lp->base, DATA_REG(lp), p, l);		\
 	} while (0)
 
 #endif  /* _SMC91X_H_ */
-- 
2.45.1


