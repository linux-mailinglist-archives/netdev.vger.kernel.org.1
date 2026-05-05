Return-Path: <netdev+bounces-284541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DYZOmAx+mlXKgMAu9opvQ
	(envelope-from <netdev+bounces-284541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:05:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E68B74D27AD
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76E873019068
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 18:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C7B48BD32;
	Tue,  5 May 2026 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Au7xYCEV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B6548BD2F
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778004313; cv=none; b=locOdYGEBvRe5FE8OpQgC4lJIpjXHCgeSkcl9mWC6wHmuyYy6FtV30LxYCDto85VeVpqvOIhr/Qk4A9ZDcduMWZtz/e+2h3IXzWo8o3TuyRRMhHeppe0VyE19CQm6dmh3hBx7W90ViqactX8ico2nV8RM/Q1C2ysK+JhYPn3zT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778004313; c=relaxed/simple;
	bh=jkEqRVqQvDb65He9tAcsxS0ujWjibB3/frpi9sN4tOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lWynOvAwCUqurS72gWf0kaEgdmnDqV4O+SzIdvnMmW7Gjeb6eZakpsRnKwasBRtACHTZuw7cn4pfii/4ugrTbY/ePIXTZCM4++EzWxVnu08S9kNandQjmMRFiBG3PWoG06WGmkBD4zaUmaeYLi4UXqBexqc3DSbmylej2iatvBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au7xYCEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C69EC2BCB4;
	Tue,  5 May 2026 18:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778004313;
	bh=jkEqRVqQvDb65He9tAcsxS0ujWjibB3/frpi9sN4tOo=;
	h=From:To:Cc:Subject:Date:From;
	b=Au7xYCEV1rn6aYipanai+7rpao/bZpXQkqQvvWa4gRwh1pOraBXzi86dMW/MYGohd
	 2i3X9TdsaQmfQoS1ll8ekvQXWTE9EloiZQaP2bfQB3avMjLP5pehAveJoqFu7h86GB
	 sNyPSuv6VW0oU+d0tmfWWLT8/5oi5gIMMnvjUOUp8I/YKzGUeVmRoRCzvOm4/zfEPr
	 0GgKfgOfE9fTKQqwqAIFNEC++KzP5fk0yK0xf3wUolQsCmS1KBCKG80KNQnzMGUiFL
	 jKge1TNFRX6zH6jkfCdMz87po3OMnhh66yJFes2H+K1YvIfrwrRqxOy303yGOI30D9
	 7dfuCe5gH6yKQ==
From: Arnd Bergmann <arnd@kernel.org>
To: netdev@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/3] [net-next] w5100: remove MMIO support
Date: Tue,  5 May 2026 20:04:57 +0200
Message-Id: <20260505180459.1247690-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E68B74D27AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284541-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Arnd Bergmann <arnd@arndb.de>

This driver supports both SPI and MMIO based register access, but only
the former has devicetree support. While MMIO mode would have worked
with old-style board files, those have never defined such a device
upstream.

Remove the MMIO mode, leaving SPI as the only way to use this driver,
but leave it in two loadable modules. More cleanups can be done by
combining the two into one file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/wiznet/Kconfig  |  19 +-
 drivers/net/ethernet/wiznet/Makefile |   3 +-
 drivers/net/ethernet/wiznet/w5100.c  | 350 ---------------------------
 include/linux/platform_data/wiznet.h |  23 --
 4 files changed, 3 insertions(+), 392 deletions(-)
 delete mode 100644 include/linux/platform_data/wiznet.h

diff --git a/drivers/net/ethernet/wiznet/Kconfig b/drivers/net/ethernet/wiznet/Kconfig
index 4bac2ad2d6a1..67b3376b39c7 100644
--- a/drivers/net/ethernet/wiznet/Kconfig
+++ b/drivers/net/ethernet/wiznet/Kconfig
@@ -5,7 +5,6 @@
 
 config NET_VENDOR_WIZNET
 	bool "WIZnet devices"
-	depends on HAS_IOMEM
 	default y
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
@@ -18,8 +17,8 @@ config NET_VENDOR_WIZNET
 if NET_VENDOR_WIZNET
 
 config WIZNET_W5100
-	tristate "WIZnet W5100 Ethernet support"
-	depends on HAS_IOMEM
+	tristate "WIZnet W5100/W5200/W5500 Ethernet support for SPI mode"
+	depends on SPI
 	help
 	  Support for WIZnet W5100 chips.
 
@@ -70,18 +69,4 @@ config WIZNET_BUS_ANY
 	  Performance may decrease compared to explicitly selected bus mode.
 endchoice
 
-config WIZNET_W5100_SPI
-	tristate "WIZnet W5100/W5200/W5500 Ethernet support for SPI mode"
-	depends on WIZNET_BUS_ANY && WIZNET_W5100
-	depends on SPI
-	help
-	  In SPI mode host system accesses registers using SPI protocol
-	  (mode 0) on the SPI bus.
-
-	  Performance decreases compared to other bus interface mode.
-	  In W5100 SPI mode, burst READ/WRITE processing are not provided.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called w5100-spi.
-
 endif # NET_VENDOR_WIZNET
diff --git a/drivers/net/ethernet/wiznet/Makefile b/drivers/net/ethernet/wiznet/Makefile
index 78104f0bf415..a97fdcdf4632 100644
--- a/drivers/net/ethernet/wiznet/Makefile
+++ b/drivers/net/ethernet/wiznet/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_WIZNET_W5100) += w5100.o
-obj-$(CONFIG_WIZNET_W5100_SPI) += w5100-spi.o
+obj-$(CONFIG_WIZNET_W5100) += w5100.o w5100-spi.o
 obj-$(CONFIG_WIZNET_W5300) += w5300.o
diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index c5424d882135..cfe6813ce805 100644
--- a/drivers/net/ethernet/wiznet/w5100.c
+++ b/drivers/net/ethernet/wiznet/w5100.c
@@ -11,7 +11,6 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/wiznet.h>
 #include <linux/ethtool.h>
 #include <linux/skbuff.h>
 #include <linux/types.h>
@@ -172,311 +171,6 @@ struct w5100_priv {
 	struct work_struct restart_work;
 };
 
-/************************************************************************
- *
- *  Lowlevel I/O functions
- *
- ***********************************************************************/
-
-struct w5100_mmio_priv {
-	void __iomem *base;
-	/* Serialize access in indirect address mode */
-	spinlock_t reg_lock;
-};
-
-static inline struct w5100_mmio_priv *w5100_mmio_priv(struct net_device *dev)
-{
-	return w5100_ops_priv(dev);
-}
-
-static inline void __iomem *w5100_mmio(struct net_device *ndev)
-{
-	struct w5100_mmio_priv *mmio_priv = w5100_mmio_priv(ndev);
-
-	return mmio_priv->base;
-}
-
-/*
- * In direct address mode host system can directly access W5100 registers
- * after mapping to Memory-Mapped I/O space.
- *
- * 0x8000 bytes are required for memory space.
- */
-static inline int w5100_read_direct(struct net_device *ndev, u32 addr)
-{
-	return ioread8(w5100_mmio(ndev) + (addr << CONFIG_WIZNET_BUS_SHIFT));
-}
-
-static inline int __w5100_write_direct(struct net_device *ndev, u32 addr,
-				       u8 data)
-{
-	iowrite8(data, w5100_mmio(ndev) + (addr << CONFIG_WIZNET_BUS_SHIFT));
-
-	return 0;
-}
-
-static inline int w5100_write_direct(struct net_device *ndev, u32 addr, u8 data)
-{
-	__w5100_write_direct(ndev, addr, data);
-
-	return 0;
-}
-
-static int w5100_read16_direct(struct net_device *ndev, u32 addr)
-{
-	u16 data;
-	data  = w5100_read_direct(ndev, addr) << 8;
-	data |= w5100_read_direct(ndev, addr + 1);
-	return data;
-}
-
-static int w5100_write16_direct(struct net_device *ndev, u32 addr, u16 data)
-{
-	__w5100_write_direct(ndev, addr, data >> 8);
-	__w5100_write_direct(ndev, addr + 1, data);
-
-	return 0;
-}
-
-static int w5100_readbulk_direct(struct net_device *ndev, u32 addr, u8 *buf,
-				 int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++, addr++)
-		*buf++ = w5100_read_direct(ndev, addr);
-
-	return 0;
-}
-
-static int w5100_writebulk_direct(struct net_device *ndev, u32 addr,
-				  const u8 *buf, int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++, addr++)
-		__w5100_write_direct(ndev, addr, *buf++);
-
-	return 0;
-}
-
-static int w5100_mmio_init(struct net_device *ndev)
-{
-	struct platform_device *pdev = to_platform_device(ndev->dev.parent);
-	struct w5100_mmio_priv *mmio_priv = w5100_mmio_priv(ndev);
-
-	spin_lock_init(&mmio_priv->reg_lock);
-
-	mmio_priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
-	if (IS_ERR(mmio_priv->base))
-		return PTR_ERR(mmio_priv->base);
-
-	return 0;
-}
-
-static const struct w5100_ops w5100_mmio_direct_ops = {
-	.chip_id = W5100,
-	.read = w5100_read_direct,
-	.write = w5100_write_direct,
-	.read16 = w5100_read16_direct,
-	.write16 = w5100_write16_direct,
-	.readbulk = w5100_readbulk_direct,
-	.writebulk = w5100_writebulk_direct,
-	.init = w5100_mmio_init,
-};
-
-/*
- * In indirect address mode host system indirectly accesses registers by
- * using Indirect Mode Address Register (IDM_AR) and Indirect Mode Data
- * Register (IDM_DR), which are directly mapped to Memory-Mapped I/O space.
- * Mode Register (MR) is directly accessible.
- *
- * Only 0x04 bytes are required for memory space.
- */
-#define W5100_IDM_AR		0x01   /* Indirect Mode Address Register */
-#define W5100_IDM_DR		0x03   /* Indirect Mode Data Register */
-
-static int w5100_read_indirect(struct net_device *ndev, u32 addr)
-{
-	struct w5100_mmio_priv *mmio_priv = w5100_mmio_priv(ndev);
-	unsigned long flags;
-	u8 data;
-
-	spin_lock_irqsave(&mmio_priv->reg_lock, flags);
-	w5100_write16_direct(ndev, W5100_IDM_AR, addr);
-	data = w5100_read_direct(ndev, W5100_IDM_DR);
-	spin_unlock_irqrestore(&mmio_priv->reg_lock, flags);
-
-	return data;
-}
-
-static int w5100_write_indirect(struct net_device *ndev, u32 addr, u8 data)
-{
-	struct w5100_mmio_priv *mmio_priv = w5100_mmio_priv(ndev);
-	unsigned long flags;
-
-	spin_lock_irqsave(&mmio_priv->reg_lock, flags);
-	w5100_write16_direct(ndev, W5100_IDM_AR, addr);
-	w5100_write_direct(ndev, W5100_IDM_DR, data);
-	spin_unlock_irqrestore(&mmio_priv->reg_lock, flags);
-
-	return 0;
-}
-
-static int w5100_read16_indirect(struct net_device *ndev, u32 addr)
-{
-	struct w5100_mmio_priv *mmio_priv = w5100_mmio_priv(ndev);
-	unsigned long flags;
-	u16 data;
-
-	spin_lock_irqsave(&mmio_priv->reg_lock, flags);
-	w5100_write16_direct(ndev, W5100_IDM_AR, addr);
-	data  = w5100_read_direct(ndev, W5100_IDM_DR) << 8;
-	data |= w5100_read_direct(ndev, W5100_IDM_DR);
-	spin_unlock_irqrestore(&mmio_priv->reg_lock, flags);
-
-	return data;
-}
-
-static int w5100_write16_indirect(struct net_device *ndev, u32 addr, u16 data)
-{
-	struct w5100_mmio_priv *mmio_priv = w5100_mmio_priv(ndev);
-	unsigned long flags;
-
-	spin_lock_irqsave(&mmio_priv->reg_lock, flags);
-	w5100_write16_direct(ndev, W5100_IDM_AR, addr);
-	__w5100_write_direct(ndev, W5100_IDM_DR, data >> 8);
-	w5100_write_direct(ndev, W5100_IDM_DR, data);
-	spin_unlock_irqrestore(&mmio_priv->reg_lock, flags);
-
-	return 0;
-}
-
-static int w5100_readbulk_indirect(struct net_device *ndev, u32 addr, u8 *buf,
-				   int len)
-{
-	struct w5100_mmio_priv *mmio_priv = w5100_mmio_priv(ndev);
-	unsigned long flags;
-	int i;
-
-	spin_lock_irqsave(&mmio_priv->reg_lock, flags);
-	w5100_write16_direct(ndev, W5100_IDM_AR, addr);
-
-	for (i = 0; i < len; i++)
-		*buf++ = w5100_read_direct(ndev, W5100_IDM_DR);
-
-	spin_unlock_irqrestore(&mmio_priv->reg_lock, flags);
-
-	return 0;
-}
-
-static int w5100_writebulk_indirect(struct net_device *ndev, u32 addr,
-				    const u8 *buf, int len)
-{
-	struct w5100_mmio_priv *mmio_priv = w5100_mmio_priv(ndev);
-	unsigned long flags;
-	int i;
-
-	spin_lock_irqsave(&mmio_priv->reg_lock, flags);
-	w5100_write16_direct(ndev, W5100_IDM_AR, addr);
-
-	for (i = 0; i < len; i++)
-		__w5100_write_direct(ndev, W5100_IDM_DR, *buf++);
-
-	spin_unlock_irqrestore(&mmio_priv->reg_lock, flags);
-
-	return 0;
-}
-
-static int w5100_reset_indirect(struct net_device *ndev)
-{
-	w5100_write_direct(ndev, W5100_MR, MR_RST);
-	mdelay(5);
-	w5100_write_direct(ndev, W5100_MR, MR_PB | MR_AI | MR_IND);
-
-	return 0;
-}
-
-static const struct w5100_ops w5100_mmio_indirect_ops = {
-	.chip_id = W5100,
-	.read = w5100_read_indirect,
-	.write = w5100_write_indirect,
-	.read16 = w5100_read16_indirect,
-	.write16 = w5100_write16_indirect,
-	.readbulk = w5100_readbulk_indirect,
-	.writebulk = w5100_writebulk_indirect,
-	.init = w5100_mmio_init,
-	.reset = w5100_reset_indirect,
-};
-
-#if defined(CONFIG_WIZNET_BUS_DIRECT)
-
-static int w5100_read(struct w5100_priv *priv, u32 addr)
-{
-	return w5100_read_direct(priv->ndev, addr);
-}
-
-static int w5100_write(struct w5100_priv *priv, u32 addr, u8 data)
-{
-	return w5100_write_direct(priv->ndev, addr, data);
-}
-
-static int w5100_read16(struct w5100_priv *priv, u32 addr)
-{
-	return w5100_read16_direct(priv->ndev, addr);
-}
-
-static int w5100_write16(struct w5100_priv *priv, u32 addr, u16 data)
-{
-	return w5100_write16_direct(priv->ndev, addr, data);
-}
-
-static int w5100_readbulk(struct w5100_priv *priv, u32 addr, u8 *buf, int len)
-{
-	return w5100_readbulk_direct(priv->ndev, addr, buf, len);
-}
-
-static int w5100_writebulk(struct w5100_priv *priv, u32 addr, const u8 *buf,
-			   int len)
-{
-	return w5100_writebulk_direct(priv->ndev, addr, buf, len);
-}
-
-#elif defined(CONFIG_WIZNET_BUS_INDIRECT)
-
-static int w5100_read(struct w5100_priv *priv, u32 addr)
-{
-	return w5100_read_indirect(priv->ndev, addr);
-}
-
-static int w5100_write(struct w5100_priv *priv, u32 addr, u8 data)
-{
-	return w5100_write_indirect(priv->ndev, addr, data);
-}
-
-static int w5100_read16(struct w5100_priv *priv, u32 addr)
-{
-	return w5100_read16_indirect(priv->ndev, addr);
-}
-
-static int w5100_write16(struct w5100_priv *priv, u32 addr, u16 data)
-{
-	return w5100_write16_indirect(priv->ndev, addr, data);
-}
-
-static int w5100_readbulk(struct w5100_priv *priv, u32 addr, u8 *buf, int len)
-{
-	return w5100_readbulk_indirect(priv->ndev, addr, buf, len);
-}
-
-static int w5100_writebulk(struct w5100_priv *priv, u32 addr, const u8 *buf,
-			   int len)
-{
-	return w5100_writebulk_indirect(priv->ndev, addr, buf, len);
-}
-
-#else /* CONFIG_WIZNET_BUS_ANY */
-
 static int w5100_read(struct w5100_priv *priv, u32 addr)
 {
 	return priv->ops->read(priv->ndev, addr);
@@ -508,8 +202,6 @@ static int w5100_writebulk(struct w5100_priv *priv, u32 addr, const u8 *buf,
 	return priv->ops->writebulk(priv->ndev, addr, buf, len);
 }
 
-#endif
-
 static int w5100_readbuf(struct w5100_priv *priv, u16 offset, u8 *buf, int len)
 {
 	u32 addr;
@@ -1035,38 +727,6 @@ static const struct net_device_ops w5100_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 };
 
-static int w5100_mmio_probe(struct platform_device *pdev)
-{
-	struct wiznet_platform_data *data = dev_get_platdata(&pdev->dev);
-	const void *mac_addr = NULL;
-	struct resource *mem;
-	const struct w5100_ops *ops;
-	int irq;
-
-	if (data && is_valid_ether_addr(data->mac_addr))
-		mac_addr = data->mac_addr;
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem)
-		return -EINVAL;
-	if (resource_size(mem) < W5100_BUS_DIRECT_SIZE)
-		ops = &w5100_mmio_indirect_ops;
-	else
-		ops = &w5100_mmio_direct_ops;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	return w5100_probe(&pdev->dev, ops, sizeof(struct w5100_mmio_priv),
-			   mac_addr, irq, data ? data->link_gpio : -EINVAL);
-}
-
-static void w5100_mmio_remove(struct platform_device *pdev)
-{
-	w5100_remove(&pdev->dev);
-}
-
 void *w5100_ops_priv(const struct net_device *ndev)
 {
 	return netdev_priv(ndev) +
@@ -1264,13 +924,3 @@ static int w5100_resume(struct device *dev)
 
 SIMPLE_DEV_PM_OPS(w5100_pm_ops, w5100_suspend, w5100_resume);
 EXPORT_SYMBOL_GPL(w5100_pm_ops);
-
-static struct platform_driver w5100_mmio_driver = {
-	.driver		= {
-		.name	= DRV_NAME,
-		.pm	= &w5100_pm_ops,
-	},
-	.probe		= w5100_mmio_probe,
-	.remove		= w5100_mmio_remove,
-};
-module_platform_driver(w5100_mmio_driver);
diff --git a/include/linux/platform_data/wiznet.h b/include/linux/platform_data/wiznet.h
deleted file mode 100644
index 1154c4db8a13..000000000000
--- a/include/linux/platform_data/wiznet.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Ethernet driver for the WIZnet W5x00 chip.
- */
-
-#ifndef PLATFORM_DATA_WIZNET_H
-#define PLATFORM_DATA_WIZNET_H
-
-#include <linux/if_ether.h>
-
-struct wiznet_platform_data {
-	int	link_gpio;
-	u8	mac_addr[ETH_ALEN];
-};
-
-#ifndef CONFIG_WIZNET_BUS_SHIFT
-#define CONFIG_WIZNET_BUS_SHIFT 0
-#endif
-
-#define W5100_BUS_DIRECT_SIZE	(0x8000 << CONFIG_WIZNET_BUS_SHIFT)
-#define W5300_BUS_DIRECT_SIZE	(0x0400 << CONFIG_WIZNET_BUS_SHIFT)
-
-#endif /* PLATFORM_DATA_WIZNET_H */
-- 
2.39.5


