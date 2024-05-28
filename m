Return-Path: <netdev+bounces-98481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741248D18DE
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB86AB2316C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA9F16B74A;
	Tue, 28 May 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="VKUjT7ya"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41E4D13B
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893211; cv=none; b=dVJ8rannD9eIzcmnnNExiOAcFnusGh0JWHH2qnCSbbZRrDg946kxr4I1RHgEvhs9Y5ZXrNoq8/YNt08GQqkrI2vSgNEb4V5cUqIXo6TinlpioMjWzGCn8GWgRt3e9wnr0WyYfkvhIpLqZpYLjfeHL7cascu60dCHtt1HG0CNPQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893211; c=relaxed/simple;
	bh=+LFqwk0T9BTpho0w/5hCjt8lu0k/iXZRaB2kk5rGlbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jPViIOl/ud2D9HTnJcPr661KnltjmAvvntIHlTUeRNvC9R8JlSDryfdDmgYkvuJrvwhZZfy4Q07krGEBZ6ruTixWgx47KENo/il13oroG2a9PY7dmTl4j93lL1TdnjGNFRnc4hELJGhtQ//gHVozXSNjFYS9deTk8SHlDGGXMlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=VKUjT7ya; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57822392a0dso856833a12.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 03:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716893206; x=1717498006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DYUMG/oOF7KzG2twqtpaluS6EY8hWEw6iX5ET7GP+pc=;
        b=VKUjT7yaRIXJUBYRsy0RAguwL620vlLfGO0MOOQXKwEKKgLSlRLaefxaEs+nTx146M
         R8gZq8Mt3iS83CyQW4qbLHk1KpjEApuqjRGSpRp/da3/e7Oz1NQCFQHmbwikKxe0o3fM
         yW30pkRjIBE0DIkOsZoP6kbBUS8Gf68CtLjxvaDASJyfhkIislA1OyODrG8yjaNEVnkL
         mqfp25AAntgKk15MkFernFtcFTdqADyJQFLpelmT1NhwoJc42WN4vNWYvnJ5HVa6qIeF
         utXaCLs8fbRlq0BAWYKzzmhXBwb5FwBFQJB8/CnbHuCLITo2q2/jHNTJObU89VWGNd3H
         1koA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716893206; x=1717498006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYUMG/oOF7KzG2twqtpaluS6EY8hWEw6iX5ET7GP+pc=;
        b=cFYQolblfaocF/XOV6JlaQdHfbwkAQ+lq1kI61eGx3JHJillfLS4od6f9kO7q4gqu9
         LJqoLr2f/PPz/Sg4KWAC5iF4eSwPKUb+UxZ0PSlTUkKqVu2uLocV9OqDhHzpOm6uZtaP
         LVf8nwg7CmAWFvg6N3Vz7L3lTzTYYBeSxaQqcxWO02gSWyzQwEFWwKcVoEzLfXDCN0cd
         fW+5hXS0mJAiEKGXWt13UestPpB9bVP5ToPJGbY8pfqTbyR+XaPA0qPA98oq82vKSQJu
         Yibv26Tr78MlX2IDWcrjiN/pwSihT4C+P5+/ASsxZ5lJx5cIEc1Ej3hxWWUzPmNdSBZK
         hi0w==
X-Forwarded-Encrypted: i=1; AJvYcCXIaR/mqUq8zsxvjqBbN1jY7r591/puY6327rlW8+LFmMZ0BRag6hKcXqMxeh24KN4OQ1I0DRy5UPHO4XeP69zkmXbARbfN
X-Gm-Message-State: AOJu0YyHBp5fhjQ8izkXtAAbTeCyKGGCPa9iQOpSZRvdfeJ5aA8NqSk9
	1N3onVnIDXRLL+GC9juchUSn3P/n8iRhyCPOGVTbL8iEtmmmBd/K0cyJk1GgCL8=
X-Google-Smtp-Source: AGHT+IFCq3BGFnBCOMmFqQbYIc5KnY2WOKVg/eJ/ReLEk3aHXa6LHqk/D2w+ilJW4ls3mZ9969tt/Q==
X-Received: by 2002:a17:907:971c:b0:a62:cecd:26e3 with SMTP id a640c23a62f3a-a62cecd2767mr552224866b.39.1716893205894;
        Tue, 28 May 2024 03:46:45 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda1a97sm601160066b.188.2024.05.28.03.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 03:46:45 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Nicolas Pitre <nico@fluxnic.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH net-next] net: smc91x: Refactor SMC_* macros
Date: Tue, 28 May 2024 12:44:23 +0200
Message-ID: <20240528104421.399885-3-thorsten.blum@toblux.com>
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

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/smsc/smc91x.c |  24 +----
 drivers/net/ethernet/smsc/smc91x.h | 152 ++++++++++++++---------------
 2 files changed, 77 insertions(+), 99 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 78ff3af7911a..2518953fe565 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -239,7 +239,6 @@ static inline void PRINT_PKT(u_char *buf, int length) { }
 static void smc_reset(struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	unsigned int ctl, cfg;
 	struct sk_buff *pending_skb;
 
@@ -333,7 +332,6 @@ static void smc_reset(struct net_device *dev)
 static void smc_enable(struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	int mask;
 
 	DBG(2, dev, "%s\n", __func__);
@@ -367,7 +365,6 @@ static void smc_enable(struct net_device *dev)
 static void smc_shutdown(struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	struct sk_buff *pending_skb;
 
 	DBG(2, dev, "%s: %s\n", CARDNAME, __func__);
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
@@ -809,7 +800,6 @@ static unsigned int smc_mii_in(struct net_device *dev, int bits)
 static int smc_phy_read(struct net_device *dev, int phyaddr, int phyreg)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	unsigned int phydata;
 
 	SMC_SELECT_BANK(lp, 3);
@@ -840,7 +830,6 @@ static void smc_phy_write(struct net_device *dev, int phyaddr, int phyreg,
 			  int phydata)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 
 	SMC_SELECT_BANK(lp, 3);
 
@@ -902,7 +891,6 @@ static void smc_phy_detect(struct net_device *dev)
 static int smc_phy_fixed(struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	int phyaddr = lp->mii.phy_id;
 	int bmcr, cfg1;
 
@@ -1005,7 +993,6 @@ static void smc_phy_powerdown(struct net_device *dev)
 static void smc_phy_check_media(struct net_device *dev, int init)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 
 	if (mii_check_media(&lp->mii, netif_msg_link(lp), init)) {
 		/* duplex state has changed */
@@ -1034,7 +1021,6 @@ static void smc_phy_configure(struct work_struct *work)
 	struct smc_local *lp =
 		container_of(work, struct smc_local, phy_configure);
 	struct net_device *dev = lp->dev;
-	void __iomem *ioaddr = lp->base;
 	int phyaddr = lp->mii.phy_id;
 	int my_phy_caps; /* My PHY capabilities */
 	int my_ad_caps; /* My Advertised capabilities */
@@ -1158,7 +1144,6 @@ static void smc_phy_interrupt(struct net_device *dev)
 static void smc_10bt_check_media(struct net_device *dev, int init)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	unsigned int old_carrier, new_carrier;
 
 	old_carrier = netif_carrier_ok(dev) ? 1 : 0;
@@ -1182,7 +1167,6 @@ static void smc_10bt_check_media(struct net_device *dev, int init)
 static void smc_eph_interrupt(struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	unsigned int ctl;
 
 	smc_10bt_check_media(dev, 0);
@@ -1202,7 +1186,6 @@ static irqreturn_t smc_interrupt(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	int status, mask, timeout, card_stats;
 	int saved_pointer;
 
@@ -1325,7 +1308,6 @@ static void smc_poll_controller(struct net_device *dev)
 static void smc_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	int status, mask, eph_st, meminfo, fifo;
 
 	DBG(2, dev, "%s\n", __func__);
@@ -1367,7 +1349,6 @@ static void smc_timeout(struct net_device *dev, unsigned int txqueue)
 static void smc_set_multicast_list(struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 	unsigned char multicast_table[8];
 	int update_multicast = 0;
 
@@ -1625,7 +1606,6 @@ static int smc_write_eeprom_word(struct net_device *dev, u16 addr, u16 word)
 {
 	u16 ctl;
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 
 	spin_lock_irq(&lp->lock);
 	/* load word into GP register */
@@ -1653,7 +1633,6 @@ static int smc_read_eeprom_word(struct net_device *dev, u16 addr, u16 *word)
 {
 	u16 ctl;
 	struct smc_local *lp = netdev_priv(dev);
-	void __iomem *ioaddr = lp->base;
 
 	spin_lock_irq(&lp->lock);
 	/* set the EEPROM address to get the data from */
@@ -1773,7 +1752,6 @@ static const struct net_device_ops smc_netdev_ops = {
  */
 static int smc_findirq(struct smc_local *lp)
 {
-	void __iomem *ioaddr = lp->base;
 	int timeout = 20;
 	unsigned long cookie;
 
diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 38aa4374e813..2be9ea33a36c 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -839,190 +839,190 @@ static const char * chip_ids[ 16 ] =  {
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
+#define SMC_CURRENT_BANK(lp)	SMC_inw(lp->base, BANK_SELECT)
 
 #define SMC_SELECT_BANK(lp, x)					\
 	do {								\
 		if (SMC_MUST_ALIGN_WRITE(lp))				\
-			SMC_outl((x)<<16, ioaddr, 12<<SMC_IO_SHIFT);	\
+			SMC_outl((x)<<16, lp->base, 12<<SMC_IO_SHIFT);	\
 		else							\
-			SMC_outw(lp, x, ioaddr, BANK_SELECT);		\
+			SMC_outw(lp, x, lp->base, BANK_SELECT);		\
 	} while (0)
 
-#define SMC_GET_BASE(lp)		SMC_inw(ioaddr, BASE_REG(lp))
+#define SMC_GET_BASE(lp)		SMC_inw(lp->base, BASE_REG(lp))
 
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
+#define SMC_GET_REV(lp)		SMC_inw(lp->base, REV_REG(lp))
 
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


