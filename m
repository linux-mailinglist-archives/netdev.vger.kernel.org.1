Return-Path: <netdev+bounces-248842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEA2D0F8B0
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 18:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 235593048EDA
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 17:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27950348884;
	Sun, 11 Jan 2026 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkvR4pj6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BF61CFBA
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768154287; cv=none; b=arhKvvccMcfKTaZegTDbhMFKCP+dF61FjFEzCNKCqUWKu5F7VcHfI+nhtpn3KumhJTo3BKnE2+LbtP67a2iU7eJRgGSr5f3hR5LHiisEwZc86MvmbdkRp5bNpHt2MRe6x6oz5D1fOs/kx3LKsU4dxtXo5Y5CoJOpg+dQTf7Cxis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768154287; c=relaxed/simple;
	bh=3qhXbyQ4KgTtnyczvOVLffVm4U2O70yUhi20rTSaZ0M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EHtj7J3QQzME3ydjkY0Scq7kv+3vLT6aDdwMW0QrtTzQq1jwOERmzrTeqxJT90YN1suion4oREBjXuMG8kg+KTe8b8brGR30eU3DHAm+BGahTmKoqFrvJuC9Uh/rK9t0FfRv8K/nCgDwvU4yVzZZ8721LZB0ZqgCjNlvPO0qYPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkvR4pj6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso26134705e9.2
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 09:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768154283; x=1768759083; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhIkgMi0F4Vy+DlsyBVLNODhNUMFYIX4eyLeE+Rp62Y=;
        b=dkvR4pj6DjOUhS5/zs9ce8vq7nH/rwFHB+5TCLucpEintqEL21kB5Onty/bkivHDto
         hvENWe9bPc1aFueOil3xFCq8MGvlQyG25R8+yOwIC1bevte85m3DPH7wJVSF/6MnAJAe
         wpk1srQrMpP0/ur2PXqhqquv2swclRyo14pViMYiN4jUaxbIoEQKEWGepfNxfjVVkyTq
         DmhsT3Fb/9a8LCXLN03cMkpg0Vxs5JgecPVLNOemCIgCbhJNi8AwDtBdmTdwJHLTIaE+
         zFraebRnW+Zjx4sRQCV7TigUSTKpeYmJft0IKu5fcWqwTtUf77xX5BhTIKzmwOoLh/H/
         ozjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768154283; x=1768759083;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhIkgMi0F4Vy+DlsyBVLNODhNUMFYIX4eyLeE+Rp62Y=;
        b=gCQzBLXYtr2OH/FgK4tFY3U5Zkr1INtZgByBkxSRbooC4E/6tQT2iYHCWS7makZyLS
         P/+vScTehM3YAjNdFTLZZVv7MC3plg2dMB9A3fwCqdkTovgSCoNIoyD3RHDxu7J6l0Ti
         sJ9+jXJEgdQ2OetCYsdixqkdvOE7/4XKKDoZjmDnRugsXXchWKHjaHOulPItraHvzqPt
         +76rSJSserj9xtW72E5M8YR0kFM6xhB6mmF4ROxKnz41gS9xQRR5r/RIYVagRNDmOf32
         kgTEN1tpT7jxfp/yBPz7JyEK90amhFXpK62GVCsC0ULXxKjVleNZgwdiyY98MxfyBbHJ
         zTuQ==
X-Gm-Message-State: AOJu0YyV3Imj1rSXOYNw2ZWbLuFNGQvaU5Evh8YZ36YRbvCWB/lpdWWh
	4RA/83y+0YxSo8TVFvjIZKeQt//+TmmmOCygoeM6p/fkoXDp/v+zZPSS
X-Gm-Gg: AY/fxX6GUYsdj6VQ80Ug7ZT6vpPEO3C8vlV2FbkMQ6EXDiQ/6dLu0rGnCPzHxSC0O/K
	yHcbHphPZBMfnV+rt3OQIzV4vpOB/0ejkwrJK0OjSCKypXWFdxuoyRZuMdZBzJbA5A3tPldoPSu
	oSeT/5oU3T6GEBTVgu1AX7CMWAN6Orb3Cpd+YNJkTvmJvBtU10sNSewWU+KLUaM7uqvd3Ahivel
	bPtkqJpV6KEbEZUI0ifldgsJKCSY6ds0oq8Y/S5qF/v/nNeY5udfqpVfK7RNz5X4xPluHQnTP2o
	dJg+0YIwFKtmhf4+vKU0aBJhwRLNrtrqV/Hs2RmQuG4A4ZBe8x86qmBs0lDov0r1j+ymAd+QrKJ
	j6HVwEAAiT8Xlyb+wIMdsQNu34Ph9KPcuiaY381xaoDgfs/+x5/93z3sGImFCQ9VCaAoInZSGJG
	psSma0YX1CvAOkR6LedeJCrhwgDOtttwspheNzM9QLcXCA8VY4pfnntZl1omzs3Kx0SoqDifzV5
	ss2UShJkWKBruzAyb0tX1ilN7XWwkN1jXsFOWIALeX7dyuuSFP8nyFPlEI2VWPY
X-Google-Smtp-Source: AGHT+IF7NqGoUKssh/I4ZRtNEBE+AiAqiOFazEDV33K2ZH1Ju1yU5H2EClVhWcHQdP/u7l+4D8GQ0A==
X-Received: by 2002:a05:600c:470c:b0:477:7a78:3016 with SMTP id 5b1f17b1804b1-47d84b0a5bemr167976305e9.8.1768154282337;
        Sun, 11 Jan 2026 09:58:02 -0800 (PST)
Received: from ?IPV6:2003:ea:8f47:8300:6996:b28c:496c:1292? (p200300ea8f4783006996b28c496c1292.dip0.t-ipconnect.de. [2003:ea:8f47:8300:6996:b28c:496c:1292])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0860f5sm34023739f8f.0.2026.01.11.09.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 09:58:01 -0800 (PST)
Message-ID: <24dbdb3c-67df-4949-a278-0e41c25e7b20@gmail.com>
Date: Sun, 11 Jan 2026 18:58:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: ethernet: dnet: remove driver
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This legacy platform driver was used with some Qong board. Support for
this board was removed with e731f3146ff3 ("Merge tag 'armsoc-soc' of
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc") in 2020.
This patch removed arch/arm/mach-imx/mach-qong.c.
So remove the now orphaned dnet driver.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/Kconfig  |  12 -
 drivers/net/ethernet/Makefile |   1 -
 drivers/net/ethernet/dnet.c   | 877 ----------------------------------
 drivers/net/ethernet/dnet.h   | 220 ---------
 4 files changed, 1110 deletions(-)
 delete mode 100644 drivers/net/ethernet/dnet.c
 delete mode 100644 drivers/net/ethernet/dnet.h

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 4a1b368ca7e..678beefe314 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -55,18 +55,6 @@ source "drivers/net/ethernet/cirrus/Kconfig"
 source "drivers/net/ethernet/cisco/Kconfig"
 source "drivers/net/ethernet/cortina/Kconfig"
 source "drivers/net/ethernet/davicom/Kconfig"
-
-config DNET
-	tristate "Dave ethernet support (DNET)"
-	depends on HAS_IOMEM
-	select PHYLIB
-	help
-	  The Dave ethernet interface (DNET) is found on Qong Board FPGA.
-	  Say Y to include support for the DNET chip.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called dnet.
-
 source "drivers/net/ethernet/dec/Kconfig"
 source "drivers/net/ethernet/dlink/Kconfig"
 source "drivers/net/ethernet/emulex/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 2e18df8ca8e..c9922628d8d 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -34,7 +34,6 @@ obj-$(CONFIG_NET_VENDOR_CISCO) += cisco/
 obj-$(CONFIG_NET_VENDOR_CORTINA) += cortina/
 obj-$(CONFIG_CX_ECAT) += ec_bhf.o
 obj-$(CONFIG_DM9000) += davicom/
-obj-$(CONFIG_DNET) += dnet.o
 obj-$(CONFIG_NET_VENDOR_DEC) += dec/
 obj-$(CONFIG_NET_VENDOR_DLINK) += dlink/
 obj-$(CONFIG_NET_VENDOR_EMULEX) += emulex/
diff --git a/drivers/net/ethernet/dnet.c b/drivers/net/ethernet/dnet.c
deleted file mode 100644
index 0de3cd660ec..00000000000
--- a/drivers/net/ethernet/dnet.c
+++ /dev/null
@@ -1,877 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Dave DNET Ethernet Controller driver
- *
- * Copyright (C) 2008 Dave S.r.l. <www.dave.eu>
- * Copyright (C) 2009 Ilya Yanok, Emcraft Systems Ltd, <yanok@emcraft.com>
- */
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-#include <linux/phy.h>
-
-#include "dnet.h"
-
-#undef DEBUG
-
-/* function for reading internal MAC register */
-static u16 dnet_readw_mac(struct dnet *bp, u16 reg)
-{
-	u16 data_read;
-
-	/* issue a read */
-	dnet_writel(bp, reg, MACREG_ADDR);
-
-	/* since a read/write op to the MAC is very slow,
-	 * we must wait before reading the data */
-	ndelay(500);
-
-	/* read data read from the MAC register */
-	data_read = dnet_readl(bp, MACREG_DATA);
-
-	/* all done */
-	return data_read;
-}
-
-/* function for writing internal MAC register */
-static void dnet_writew_mac(struct dnet *bp, u16 reg, u16 val)
-{
-	/* load data to write */
-	dnet_writel(bp, val, MACREG_DATA);
-
-	/* issue a write */
-	dnet_writel(bp, reg | DNET_INTERNAL_WRITE, MACREG_ADDR);
-
-	/* since a read/write op to the MAC is very slow,
-	 * we must wait before exiting */
-	ndelay(500);
-}
-
-static void __dnet_set_hwaddr(struct dnet *bp)
-{
-	u16 tmp;
-
-	tmp = be16_to_cpup((const __be16 *)bp->dev->dev_addr);
-	dnet_writew_mac(bp, DNET_INTERNAL_MAC_ADDR_0_REG, tmp);
-	tmp = be16_to_cpup((const __be16 *)(bp->dev->dev_addr + 2));
-	dnet_writew_mac(bp, DNET_INTERNAL_MAC_ADDR_1_REG, tmp);
-	tmp = be16_to_cpup((const __be16 *)(bp->dev->dev_addr + 4));
-	dnet_writew_mac(bp, DNET_INTERNAL_MAC_ADDR_2_REG, tmp);
-}
-
-static void dnet_get_hwaddr(struct dnet *bp)
-{
-	u16 tmp;
-	u8 addr[6];
-
-	/*
-	 * from MAC docs:
-	 * "Note that the MAC address is stored in the registers in Hexadecimal
-	 * form. For example, to set the MAC Address to: AC-DE-48-00-00-80
-	 * would require writing 0xAC (octet 0) to address 0x0B (high byte of
-	 * Mac_addr[15:0]), 0xDE (octet 1) to address 0x0A (Low byte of
-	 * Mac_addr[15:0]), 0x48 (octet 2) to address 0x0D (high byte of
-	 * Mac_addr[15:0]), 0x00 (octet 3) to address 0x0C (Low byte of
-	 * Mac_addr[15:0]), 0x00 (octet 4) to address 0x0F (high byte of
-	 * Mac_addr[15:0]), and 0x80 (octet 5) to address * 0x0E (Low byte of
-	 * Mac_addr[15:0]).
-	 */
-	tmp = dnet_readw_mac(bp, DNET_INTERNAL_MAC_ADDR_0_REG);
-	*((__be16 *)addr) = cpu_to_be16(tmp);
-	tmp = dnet_readw_mac(bp, DNET_INTERNAL_MAC_ADDR_1_REG);
-	*((__be16 *)(addr + 2)) = cpu_to_be16(tmp);
-	tmp = dnet_readw_mac(bp, DNET_INTERNAL_MAC_ADDR_2_REG);
-	*((__be16 *)(addr + 4)) = cpu_to_be16(tmp);
-
-	if (is_valid_ether_addr(addr))
-		eth_hw_addr_set(bp->dev, addr);
-}
-
-static int dnet_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
-{
-	struct dnet *bp = bus->priv;
-	u16 value;
-
-	while (!(dnet_readw_mac(bp, DNET_INTERNAL_GMII_MNG_CTL_REG)
-				& DNET_INTERNAL_GMII_MNG_CMD_FIN))
-		cpu_relax();
-
-	/* only 5 bits allowed for phy-addr and reg_offset */
-	mii_id &= 0x1f;
-	regnum &= 0x1f;
-
-	/* prepare reg_value for a read */
-	value = (mii_id << 8);
-	value |= regnum;
-
-	/* write control word */
-	dnet_writew_mac(bp, DNET_INTERNAL_GMII_MNG_CTL_REG, value);
-
-	/* wait for end of transfer */
-	while (!(dnet_readw_mac(bp, DNET_INTERNAL_GMII_MNG_CTL_REG)
-				& DNET_INTERNAL_GMII_MNG_CMD_FIN))
-		cpu_relax();
-
-	value = dnet_readw_mac(bp, DNET_INTERNAL_GMII_MNG_DAT_REG);
-
-	pr_debug("mdio_read %02x:%02x <- %04x\n", mii_id, regnum, value);
-
-	return value;
-}
-
-static int dnet_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
-			   u16 value)
-{
-	struct dnet *bp = bus->priv;
-	u16 tmp;
-
-	pr_debug("mdio_write %02x:%02x <- %04x\n", mii_id, regnum, value);
-
-	while (!(dnet_readw_mac(bp, DNET_INTERNAL_GMII_MNG_CTL_REG)
-				& DNET_INTERNAL_GMII_MNG_CMD_FIN))
-		cpu_relax();
-
-	/* prepare for a write operation */
-	tmp = (1 << 13);
-
-	/* only 5 bits allowed for phy-addr and reg_offset */
-	mii_id &= 0x1f;
-	regnum &= 0x1f;
-
-	/* only 16 bits on data */
-	value &= 0xffff;
-
-	/* prepare reg_value for a write */
-	tmp |= (mii_id << 8);
-	tmp |= regnum;
-
-	/* write data to write first */
-	dnet_writew_mac(bp, DNET_INTERNAL_GMII_MNG_DAT_REG, value);
-
-	/* write control word */
-	dnet_writew_mac(bp, DNET_INTERNAL_GMII_MNG_CTL_REG, tmp);
-
-	while (!(dnet_readw_mac(bp, DNET_INTERNAL_GMII_MNG_CTL_REG)
-				& DNET_INTERNAL_GMII_MNG_CMD_FIN))
-		cpu_relax();
-
-	return 0;
-}
-
-static void dnet_handle_link_change(struct net_device *dev)
-{
-	struct dnet *bp = netdev_priv(dev);
-	struct phy_device *phydev = dev->phydev;
-	unsigned long flags;
-	u32 mode_reg, ctl_reg;
-
-	int status_change = 0;
-
-	spin_lock_irqsave(&bp->lock, flags);
-
-	mode_reg = dnet_readw_mac(bp, DNET_INTERNAL_MODE_REG);
-	ctl_reg = dnet_readw_mac(bp, DNET_INTERNAL_RXTX_CONTROL_REG);
-
-	if (phydev->link) {
-		if (bp->duplex != phydev->duplex) {
-			if (phydev->duplex)
-				ctl_reg &=
-				    ~(DNET_INTERNAL_RXTX_CONTROL_ENABLEHALFDUP);
-			else
-				ctl_reg |=
-				    DNET_INTERNAL_RXTX_CONTROL_ENABLEHALFDUP;
-
-			bp->duplex = phydev->duplex;
-			status_change = 1;
-		}
-
-		if (bp->speed != phydev->speed) {
-			status_change = 1;
-			switch (phydev->speed) {
-			case 1000:
-				mode_reg |= DNET_INTERNAL_MODE_GBITEN;
-				break;
-			case 100:
-			case 10:
-				mode_reg &= ~DNET_INTERNAL_MODE_GBITEN;
-				break;
-			default:
-				printk(KERN_WARNING
-				       "%s: Ack!  Speed (%d) is not "
-				       "10/100/1000!\n", dev->name,
-				       phydev->speed);
-				break;
-			}
-			bp->speed = phydev->speed;
-		}
-	}
-
-	if (phydev->link != bp->link) {
-		if (phydev->link) {
-			mode_reg |=
-			    (DNET_INTERNAL_MODE_RXEN | DNET_INTERNAL_MODE_TXEN);
-		} else {
-			mode_reg &=
-			    ~(DNET_INTERNAL_MODE_RXEN |
-			      DNET_INTERNAL_MODE_TXEN);
-			bp->speed = 0;
-			bp->duplex = -1;
-		}
-		bp->link = phydev->link;
-
-		status_change = 1;
-	}
-
-	if (status_change) {
-		dnet_writew_mac(bp, DNET_INTERNAL_RXTX_CONTROL_REG, ctl_reg);
-		dnet_writew_mac(bp, DNET_INTERNAL_MODE_REG, mode_reg);
-	}
-
-	spin_unlock_irqrestore(&bp->lock, flags);
-
-	if (status_change) {
-		if (phydev->link)
-			printk(KERN_INFO "%s: link up (%d/%s)\n",
-			       dev->name, phydev->speed,
-			       DUPLEX_FULL == phydev->duplex ? "Full" : "Half");
-		else
-			printk(KERN_INFO "%s: link down\n", dev->name);
-	}
-}
-
-static int dnet_mii_probe(struct net_device *dev)
-{
-	struct dnet *bp = netdev_priv(dev);
-	struct phy_device *phydev = NULL;
-
-	/* find the first phy */
-	phydev = phy_find_first(bp->mii_bus);
-
-	if (!phydev) {
-		printk(KERN_ERR "%s: no PHY found\n", dev->name);
-		return -ENODEV;
-	}
-
-	/* TODO : add pin_irq */
-
-	/* attach the mac to the phy */
-	if (bp->capabilities & DNET_HAS_RMII) {
-		phydev = phy_connect(dev, phydev_name(phydev),
-				     &dnet_handle_link_change,
-				     PHY_INTERFACE_MODE_RMII);
-	} else {
-		phydev = phy_connect(dev, phydev_name(phydev),
-				     &dnet_handle_link_change,
-				     PHY_INTERFACE_MODE_MII);
-	}
-
-	if (IS_ERR(phydev)) {
-		printk(KERN_ERR "%s: Could not attach to PHY\n", dev->name);
-		return PTR_ERR(phydev);
-	}
-
-	/* mask with MAC supported features */
-	if (bp->capabilities & DNET_HAS_GIGABIT)
-		phy_set_max_speed(phydev, SPEED_1000);
-	else
-		phy_set_max_speed(phydev, SPEED_100);
-
-	phy_support_asym_pause(phydev);
-
-	bp->link = 0;
-	bp->speed = 0;
-	bp->duplex = -1;
-
-	return 0;
-}
-
-static int dnet_mii_init(struct dnet *bp)
-{
-	int err;
-
-	bp->mii_bus = mdiobus_alloc();
-	if (bp->mii_bus == NULL)
-		return -ENOMEM;
-
-	bp->mii_bus->name = "dnet_mii_bus";
-	bp->mii_bus->read = &dnet_mdio_read;
-	bp->mii_bus->write = &dnet_mdio_write;
-
-	snprintf(bp->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
-		bp->pdev->name, bp->pdev->id);
-
-	bp->mii_bus->priv = bp;
-
-	if (mdiobus_register(bp->mii_bus)) {
-		err = -ENXIO;
-		goto err_out;
-	}
-
-	if (dnet_mii_probe(bp->dev) != 0) {
-		err = -ENXIO;
-		goto err_out_unregister_bus;
-	}
-
-	return 0;
-
-err_out_unregister_bus:
-	mdiobus_unregister(bp->mii_bus);
-err_out:
-	mdiobus_free(bp->mii_bus);
-	return err;
-}
-
-/* For Neptune board: LINK1000 as Link LED and TX as activity LED */
-static int dnet_phy_marvell_fixup(struct phy_device *phydev)
-{
-	return phy_write(phydev, 0x18, 0x4148);
-}
-
-static void dnet_update_stats(struct dnet *bp)
-{
-	u32 __iomem *reg = bp->regs + DNET_RX_PKT_IGNR_CNT;
-	u32 *p = &bp->hw_stats.rx_pkt_ignr;
-	u32 *end = &bp->hw_stats.rx_byte + 1;
-
-	WARN_ON((unsigned long)(end - p - 1) !=
-		(DNET_RX_BYTE_CNT - DNET_RX_PKT_IGNR_CNT) / 4);
-
-	for (; p < end; p++, reg++)
-		*p += readl(reg);
-
-	reg = bp->regs + DNET_TX_UNICAST_CNT;
-	p = &bp->hw_stats.tx_unicast;
-	end = &bp->hw_stats.tx_byte + 1;
-
-	WARN_ON((unsigned long)(end - p - 1) !=
-		(DNET_TX_BYTE_CNT - DNET_TX_UNICAST_CNT) / 4);
-
-	for (; p < end; p++, reg++)
-		*p += readl(reg);
-}
-
-static int dnet_poll(struct napi_struct *napi, int budget)
-{
-	struct dnet *bp = container_of(napi, struct dnet, napi);
-	struct net_device *dev = bp->dev;
-	int npackets = 0;
-	unsigned int pkt_len;
-	struct sk_buff *skb;
-	unsigned int *data_ptr;
-	u32 int_enable;
-	u32 cmd_word;
-	int i;
-
-	while (npackets < budget) {
-		/*
-		 * break out of while loop if there are no more
-		 * packets waiting
-		 */
-		if (!(dnet_readl(bp, RX_FIFO_WCNT) >> 16))
-			break;
-
-		cmd_word = dnet_readl(bp, RX_LEN_FIFO);
-		pkt_len = cmd_word & 0xFFFF;
-
-		if (cmd_word & 0xDF180000)
-			printk(KERN_ERR "%s packet receive error %x\n",
-			       __func__, cmd_word);
-
-		skb = netdev_alloc_skb(dev, pkt_len + 5);
-		if (skb != NULL) {
-			/* Align IP on 16 byte boundaries */
-			skb_reserve(skb, 2);
-			/*
-			 * 'skb_put()' points to the start of sk_buff
-			 * data area.
-			 */
-			data_ptr = skb_put(skb, pkt_len);
-			for (i = 0; i < (pkt_len + 3) >> 2; i++)
-				*data_ptr++ = dnet_readl(bp, RX_DATA_FIFO);
-			skb->protocol = eth_type_trans(skb, dev);
-			netif_receive_skb(skb);
-			npackets++;
-		} else
-			printk(KERN_NOTICE
-			       "%s: No memory to allocate a sk_buff of "
-			       "size %u.\n", dev->name, pkt_len);
-	}
-
-	if (npackets < budget) {
-		/* We processed all packets available.  Tell NAPI it can
-		 * stop polling then re-enable rx interrupts.
-		 */
-		napi_complete_done(napi, npackets);
-		int_enable = dnet_readl(bp, INTR_ENB);
-		int_enable |= DNET_INTR_SRC_RX_CMDFIFOAF;
-		dnet_writel(bp, int_enable, INTR_ENB);
-	}
-
-	return npackets;
-}
-
-static irqreturn_t dnet_interrupt(int irq, void *dev_id)
-{
-	struct net_device *dev = dev_id;
-	struct dnet *bp = netdev_priv(dev);
-	u32 int_src, int_enable, int_current;
-	unsigned long flags;
-	unsigned int handled = 0;
-
-	spin_lock_irqsave(&bp->lock, flags);
-
-	/* read and clear the DNET irq (clear on read) */
-	int_src = dnet_readl(bp, INTR_SRC);
-	int_enable = dnet_readl(bp, INTR_ENB);
-	int_current = int_src & int_enable;
-
-	/* restart the queue if we had stopped it for TX fifo almost full */
-	if (int_current & DNET_INTR_SRC_TX_FIFOAE) {
-		int_enable = dnet_readl(bp, INTR_ENB);
-		int_enable &= ~DNET_INTR_ENB_TX_FIFOAE;
-		dnet_writel(bp, int_enable, INTR_ENB);
-		netif_wake_queue(dev);
-		handled = 1;
-	}
-
-	/* RX FIFO error checking */
-	if (int_current &
-	    (DNET_INTR_SRC_RX_CMDFIFOFF | DNET_INTR_SRC_RX_DATAFIFOFF)) {
-		printk(KERN_ERR "%s: RX fifo error %x, irq %x\n", __func__,
-		       dnet_readl(bp, RX_STATUS), int_current);
-		/* we can only flush the RX FIFOs */
-		dnet_writel(bp, DNET_SYS_CTL_RXFIFOFLUSH, SYS_CTL);
-		ndelay(500);
-		dnet_writel(bp, 0, SYS_CTL);
-		handled = 1;
-	}
-
-	/* TX FIFO error checking */
-	if (int_current &
-	    (DNET_INTR_SRC_TX_FIFOFULL | DNET_INTR_SRC_TX_DISCFRM)) {
-		printk(KERN_ERR "%s: TX fifo error %x, irq %x\n", __func__,
-		       dnet_readl(bp, TX_STATUS), int_current);
-		/* we can only flush the TX FIFOs */
-		dnet_writel(bp, DNET_SYS_CTL_TXFIFOFLUSH, SYS_CTL);
-		ndelay(500);
-		dnet_writel(bp, 0, SYS_CTL);
-		handled = 1;
-	}
-
-	if (int_current & DNET_INTR_SRC_RX_CMDFIFOAF) {
-		if (napi_schedule_prep(&bp->napi)) {
-			/*
-			 * There's no point taking any more interrupts
-			 * until we have processed the buffers
-			 */
-			/* Disable Rx interrupts and schedule NAPI poll */
-			int_enable = dnet_readl(bp, INTR_ENB);
-			int_enable &= ~DNET_INTR_SRC_RX_CMDFIFOAF;
-			dnet_writel(bp, int_enable, INTR_ENB);
-			__napi_schedule(&bp->napi);
-		}
-		handled = 1;
-	}
-
-	if (!handled)
-		pr_debug("%s: irq %x remains\n", __func__, int_current);
-
-	spin_unlock_irqrestore(&bp->lock, flags);
-
-	return IRQ_RETVAL(handled);
-}
-
-#ifdef DEBUG
-static inline void dnet_print_skb(struct sk_buff *skb)
-{
-	int k;
-	printk(KERN_DEBUG PFX "data:");
-	for (k = 0; k < skb->len; k++)
-		printk(" %02x", (unsigned int)skb->data[k]);
-	printk("\n");
-}
-#else
-#define dnet_print_skb(skb)	do {} while (0)
-#endif
-
-static netdev_tx_t dnet_start_xmit(struct sk_buff *skb, struct net_device *dev)
-{
-
-	struct dnet *bp = netdev_priv(dev);
-	unsigned int i, tx_cmd, wrsz;
-	unsigned long flags;
-	unsigned int *bufp;
-	u32 irq_enable;
-
-	dnet_readl(bp, TX_STATUS);
-
-	pr_debug("start_xmit: len %u head %p data %p\n",
-	       skb->len, skb->head, skb->data);
-	dnet_print_skb(skb);
-
-	spin_lock_irqsave(&bp->lock, flags);
-
-	dnet_readl(bp, TX_STATUS);
-
-	bufp = (unsigned int *)(((unsigned long) skb->data) & ~0x3UL);
-	wrsz = (u32) skb->len + 3;
-	wrsz += ((unsigned long) skb->data) & 0x3;
-	wrsz >>= 2;
-	tx_cmd = ((((unsigned long)(skb->data)) & 0x03) << 16) | (u32) skb->len;
-
-	/* check if there is enough room for the current frame */
-	if (wrsz < (DNET_FIFO_SIZE - dnet_readl(bp, TX_FIFO_WCNT))) {
-		for (i = 0; i < wrsz; i++)
-			dnet_writel(bp, *bufp++, TX_DATA_FIFO);
-
-		/*
-		 * inform MAC that a packet's written and ready to be
-		 * shipped out
-		 */
-		dnet_writel(bp, tx_cmd, TX_LEN_FIFO);
-	}
-
-	if (dnet_readl(bp, TX_FIFO_WCNT) > DNET_FIFO_TX_DATA_AF_TH) {
-		netif_stop_queue(dev);
-		dnet_readl(bp, INTR_SRC);
-		irq_enable = dnet_readl(bp, INTR_ENB);
-		irq_enable |= DNET_INTR_ENB_TX_FIFOAE;
-		dnet_writel(bp, irq_enable, INTR_ENB);
-	}
-
-	skb_tx_timestamp(skb);
-
-	spin_unlock_irqrestore(&bp->lock, flags);
-
-	/* free the buffer */
-	dev_kfree_skb(skb);
-
-	return NETDEV_TX_OK;
-}
-
-static void dnet_reset_hw(struct dnet *bp)
-{
-	/* put ts_mac in IDLE state i.e. disable rx/tx */
-	dnet_writew_mac(bp, DNET_INTERNAL_MODE_REG, DNET_INTERNAL_MODE_FCEN);
-
-	/*
-	 * RX FIFO almost full threshold: only cmd FIFO almost full is
-	 * implemented for RX side
-	 */
-	dnet_writel(bp, DNET_FIFO_RX_CMD_AF_TH, RX_FIFO_TH);
-	/*
-	 * TX FIFO almost empty threshold: only data FIFO almost empty
-	 * is implemented for TX side
-	 */
-	dnet_writel(bp, DNET_FIFO_TX_DATA_AE_TH, TX_FIFO_TH);
-
-	/* flush rx/tx fifos */
-	dnet_writel(bp, DNET_SYS_CTL_RXFIFOFLUSH | DNET_SYS_CTL_TXFIFOFLUSH,
-			SYS_CTL);
-	msleep(1);
-	dnet_writel(bp, 0, SYS_CTL);
-}
-
-static void dnet_init_hw(struct dnet *bp)
-{
-	u32 config;
-
-	dnet_reset_hw(bp);
-	__dnet_set_hwaddr(bp);
-
-	config = dnet_readw_mac(bp, DNET_INTERNAL_RXTX_CONTROL_REG);
-
-	if (bp->dev->flags & IFF_PROMISC)
-		/* Copy All Frames */
-		config |= DNET_INTERNAL_RXTX_CONTROL_ENPROMISC;
-	if (!(bp->dev->flags & IFF_BROADCAST))
-		/* No BroadCast */
-		config |= DNET_INTERNAL_RXTX_CONTROL_RXMULTICAST;
-
-	config |= DNET_INTERNAL_RXTX_CONTROL_RXPAUSE |
-	    DNET_INTERNAL_RXTX_CONTROL_RXBROADCAST |
-	    DNET_INTERNAL_RXTX_CONTROL_DROPCONTROL |
-	    DNET_INTERNAL_RXTX_CONTROL_DISCFXFCS;
-
-	dnet_writew_mac(bp, DNET_INTERNAL_RXTX_CONTROL_REG, config);
-
-	/* clear irq before enabling them */
-	config = dnet_readl(bp, INTR_SRC);
-
-	/* enable RX/TX interrupt, recv packet ready interrupt */
-	dnet_writel(bp, DNET_INTR_ENB_GLOBAL_ENABLE | DNET_INTR_ENB_RX_SUMMARY |
-			DNET_INTR_ENB_TX_SUMMARY | DNET_INTR_ENB_RX_FIFOERR |
-			DNET_INTR_ENB_RX_ERROR | DNET_INTR_ENB_RX_FIFOFULL |
-			DNET_INTR_ENB_TX_FIFOFULL | DNET_INTR_ENB_TX_DISCFRM |
-			DNET_INTR_ENB_RX_PKTRDY, INTR_ENB);
-}
-
-static int dnet_open(struct net_device *dev)
-{
-	struct dnet *bp = netdev_priv(dev);
-
-	/* if the phy is not yet register, retry later */
-	if (!dev->phydev)
-		return -EAGAIN;
-
-	napi_enable(&bp->napi);
-	dnet_init_hw(bp);
-
-	phy_start_aneg(dev->phydev);
-
-	/* schedule a link state check */
-	phy_start(dev->phydev);
-
-	netif_start_queue(dev);
-
-	return 0;
-}
-
-static int dnet_close(struct net_device *dev)
-{
-	struct dnet *bp = netdev_priv(dev);
-
-	netif_stop_queue(dev);
-	napi_disable(&bp->napi);
-
-	if (dev->phydev)
-		phy_stop(dev->phydev);
-
-	dnet_reset_hw(bp);
-	netif_carrier_off(dev);
-
-	return 0;
-}
-
-static inline void dnet_print_pretty_hwstats(struct dnet_stats *hwstat)
-{
-	pr_debug("%s\n", __func__);
-	pr_debug("----------------------------- RX statistics "
-		 "-------------------------------\n");
-	pr_debug("RX_PKT_IGNR_CNT %-8x\n", hwstat->rx_pkt_ignr);
-	pr_debug("RX_LEN_CHK_ERR_CNT %-8x\n", hwstat->rx_len_chk_err);
-	pr_debug("RX_LNG_FRM_CNT %-8x\n", hwstat->rx_lng_frm);
-	pr_debug("RX_SHRT_FRM_CNT %-8x\n", hwstat->rx_shrt_frm);
-	pr_debug("RX_IPG_VIOL_CNT %-8x\n", hwstat->rx_ipg_viol);
-	pr_debug("RX_CRC_ERR_CNT %-8x\n", hwstat->rx_crc_err);
-	pr_debug("RX_OK_PKT_CNT %-8x\n", hwstat->rx_ok_pkt);
-	pr_debug("RX_CTL_FRM_CNT %-8x\n", hwstat->rx_ctl_frm);
-	pr_debug("RX_PAUSE_FRM_CNT %-8x\n", hwstat->rx_pause_frm);
-	pr_debug("RX_MULTICAST_CNT %-8x\n", hwstat->rx_multicast);
-	pr_debug("RX_BROADCAST_CNT %-8x\n", hwstat->rx_broadcast);
-	pr_debug("RX_VLAN_TAG_CNT %-8x\n", hwstat->rx_vlan_tag);
-	pr_debug("RX_PRE_SHRINK_CNT %-8x\n", hwstat->rx_pre_shrink);
-	pr_debug("RX_DRIB_NIB_CNT %-8x\n", hwstat->rx_drib_nib);
-	pr_debug("RX_UNSUP_OPCD_CNT %-8x\n", hwstat->rx_unsup_opcd);
-	pr_debug("RX_BYTE_CNT %-8x\n", hwstat->rx_byte);
-	pr_debug("----------------------------- TX statistics "
-		 "-------------------------------\n");
-	pr_debug("TX_UNICAST_CNT %-8x\n", hwstat->tx_unicast);
-	pr_debug("TX_PAUSE_FRM_CNT %-8x\n", hwstat->tx_pause_frm);
-	pr_debug("TX_MULTICAST_CNT %-8x\n", hwstat->tx_multicast);
-	pr_debug("TX_BRDCAST_CNT %-8x\n", hwstat->tx_brdcast);
-	pr_debug("TX_VLAN_TAG_CNT %-8x\n", hwstat->tx_vlan_tag);
-	pr_debug("TX_BAD_FCS_CNT %-8x\n", hwstat->tx_bad_fcs);
-	pr_debug("TX_JUMBO_CNT %-8x\n", hwstat->tx_jumbo);
-	pr_debug("TX_BYTE_CNT %-8x\n", hwstat->tx_byte);
-}
-
-static struct net_device_stats *dnet_get_stats(struct net_device *dev)
-{
-
-	struct dnet *bp = netdev_priv(dev);
-	struct net_device_stats *nstat = &dev->stats;
-	struct dnet_stats *hwstat = &bp->hw_stats;
-
-	/* read stats from hardware */
-	dnet_update_stats(bp);
-
-	/* Convert HW stats into netdevice stats */
-	nstat->rx_errors = (hwstat->rx_len_chk_err +
-			    hwstat->rx_lng_frm + hwstat->rx_shrt_frm +
-			    /* ignore IGP violation error
-			    hwstat->rx_ipg_viol + */
-			    hwstat->rx_crc_err +
-			    hwstat->rx_pre_shrink +
-			    hwstat->rx_drib_nib + hwstat->rx_unsup_opcd);
-	nstat->tx_errors = hwstat->tx_bad_fcs;
-	nstat->rx_length_errors = (hwstat->rx_len_chk_err +
-				   hwstat->rx_lng_frm +
-				   hwstat->rx_shrt_frm + hwstat->rx_pre_shrink);
-	nstat->rx_crc_errors = hwstat->rx_crc_err;
-	nstat->rx_frame_errors = hwstat->rx_pre_shrink + hwstat->rx_drib_nib;
-	nstat->rx_packets = hwstat->rx_ok_pkt;
-	nstat->tx_packets = (hwstat->tx_unicast +
-			     hwstat->tx_multicast + hwstat->tx_brdcast);
-	nstat->rx_bytes = hwstat->rx_byte;
-	nstat->tx_bytes = hwstat->tx_byte;
-	nstat->multicast = hwstat->rx_multicast;
-	nstat->rx_missed_errors = hwstat->rx_pkt_ignr;
-
-	dnet_print_pretty_hwstats(hwstat);
-
-	return nstat;
-}
-
-static void dnet_get_drvinfo(struct net_device *dev,
-			     struct ethtool_drvinfo *info)
-{
-	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
-	strscpy(info->bus_info, "0", sizeof(info->bus_info));
-}
-
-static const struct ethtool_ops dnet_ethtool_ops = {
-	.get_drvinfo		= dnet_get_drvinfo,
-	.get_link		= ethtool_op_get_link,
-	.get_ts_info		= ethtool_op_get_ts_info,
-	.get_link_ksettings     = phy_ethtool_get_link_ksettings,
-	.set_link_ksettings     = phy_ethtool_set_link_ksettings,
-};
-
-static const struct net_device_ops dnet_netdev_ops = {
-	.ndo_open		= dnet_open,
-	.ndo_stop		= dnet_close,
-	.ndo_get_stats		= dnet_get_stats,
-	.ndo_start_xmit		= dnet_start_xmit,
-	.ndo_eth_ioctl		= phy_do_ioctl_running,
-	.ndo_set_mac_address	= eth_mac_addr,
-	.ndo_validate_addr	= eth_validate_addr,
-};
-
-static int dnet_probe(struct platform_device *pdev)
-{
-	struct resource *res;
-	struct net_device *dev;
-	struct dnet *bp;
-	struct phy_device *phydev;
-	int err;
-	unsigned int irq;
-
-	irq = platform_get_irq(pdev, 0);
-
-	dev = alloc_etherdev(sizeof(*bp));
-	if (!dev)
-		return -ENOMEM;
-
-	/* TODO: Actually, we have some interesting features... */
-	dev->features |= 0;
-
-	bp = netdev_priv(dev);
-	bp->dev = dev;
-
-	platform_set_drvdata(pdev, dev);
-	SET_NETDEV_DEV(dev, &pdev->dev);
-
-	spin_lock_init(&bp->lock);
-
-	bp->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(bp->regs)) {
-		err = PTR_ERR(bp->regs);
-		goto err_out_free_dev;
-	}
-
-	dev->irq = irq;
-	err = request_irq(dev->irq, dnet_interrupt, 0, DRV_NAME, dev);
-	if (err) {
-		dev_err(&pdev->dev, "Unable to request IRQ %d (error %d)\n",
-		       irq, err);
-		goto err_out_free_dev;
-	}
-
-	dev->netdev_ops = &dnet_netdev_ops;
-	netif_napi_add(dev, &bp->napi, dnet_poll);
-	dev->ethtool_ops = &dnet_ethtool_ops;
-
-	dev->base_addr = (unsigned long)bp->regs;
-
-	bp->capabilities = dnet_readl(bp, VERCAPS) & DNET_CAPS_MASK;
-
-	dnet_get_hwaddr(bp);
-
-	if (!is_valid_ether_addr(dev->dev_addr)) {
-		/* choose a random ethernet address */
-		eth_hw_addr_random(dev);
-		__dnet_set_hwaddr(bp);
-	}
-
-	err = register_netdev(dev);
-	if (err) {
-		dev_err(&pdev->dev, "Cannot register net device, aborting.\n");
-		goto err_out_free_irq;
-	}
-
-	/* register the PHY board fixup (for Marvell 88E1111) */
-	err = phy_register_fixup_for_uid(0x01410cc0, 0xfffffff0,
-					 dnet_phy_marvell_fixup);
-	/* we can live without it, so just issue a warning */
-	if (err)
-		dev_warn(&pdev->dev, "Cannot register PHY board fixup.\n");
-
-	err = dnet_mii_init(bp);
-	if (err)
-		goto err_out_unregister_netdev;
-
-	dev_info(&pdev->dev, "Dave DNET at 0x%p (0x%08x) irq %d %pM\n",
-	       bp->regs, (unsigned int)res->start, dev->irq, dev->dev_addr);
-	dev_info(&pdev->dev, "has %smdio, %sirq, %sgigabit, %sdma\n",
-	       (bp->capabilities & DNET_HAS_MDIO) ? "" : "no ",
-	       (bp->capabilities & DNET_HAS_IRQ) ? "" : "no ",
-	       (bp->capabilities & DNET_HAS_GIGABIT) ? "" : "no ",
-	       (bp->capabilities & DNET_HAS_DMA) ? "" : "no ");
-	phydev = dev->phydev;
-	phy_attached_info(phydev);
-
-	return 0;
-
-err_out_unregister_netdev:
-	unregister_netdev(dev);
-err_out_free_irq:
-	free_irq(dev->irq, dev);
-err_out_free_dev:
-	free_netdev(dev);
-	return err;
-}
-
-static void dnet_remove(struct platform_device *pdev)
-{
-
-	struct net_device *dev;
-	struct dnet *bp;
-
-	dev = platform_get_drvdata(pdev);
-
-	if (dev) {
-		bp = netdev_priv(dev);
-		if (dev->phydev)
-			phy_disconnect(dev->phydev);
-		mdiobus_unregister(bp->mii_bus);
-		mdiobus_free(bp->mii_bus);
-		unregister_netdev(dev);
-		free_irq(dev->irq, dev);
-		free_netdev(dev);
-	}
-}
-
-static struct platform_driver dnet_driver = {
-	.probe		= dnet_probe,
-	.remove		= dnet_remove,
-	.driver		= {
-		.name		= "dnet",
-	},
-};
-
-module_platform_driver(dnet_driver);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Dave DNET Ethernet driver");
-MODULE_AUTHOR("Ilya Yanok <yanok@emcraft.com>, "
-	      "Matteo Vit <matteo.vit@dave.eu>");
diff --git a/drivers/net/ethernet/dnet.h b/drivers/net/ethernet/dnet.h
deleted file mode 100644
index 030724484b4..00000000000
--- a/drivers/net/ethernet/dnet.h
+++ /dev/null
@@ -1,220 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Dave DNET Ethernet Controller driver
- *
- * Copyright (C) 2008 Dave S.r.l. <www.dave.eu>
- */
-#ifndef _DNET_H
-#define _DNET_H
-
-#define DRV_NAME		"dnet"
-#define PFX				DRV_NAME ": "
-
-/* Register access macros */
-#define dnet_writel(port, value, reg)	\
-	writel((value), (port)->regs + DNET_##reg)
-#define dnet_readl(port, reg)	readl((port)->regs + DNET_##reg)
-
-/* ALL DNET FIFO REGISTERS */
-#define DNET_RX_LEN_FIFO		0x000	/* RX_LEN_FIFO */
-#define DNET_RX_DATA_FIFO		0x004	/* RX_DATA_FIFO */
-#define DNET_TX_LEN_FIFO		0x008	/* TX_LEN_FIFO */
-#define DNET_TX_DATA_FIFO		0x00C	/* TX_DATA_FIFO */
-
-/* ALL DNET CONTROL/STATUS REGISTERS OFFSETS */
-#define DNET_VERCAPS			0x100	/* VERCAPS */
-#define DNET_INTR_SRC			0x104	/* INTR_SRC */
-#define DNET_INTR_ENB			0x108	/* INTR_ENB */
-#define DNET_RX_STATUS			0x10C	/* RX_STATUS */
-#define DNET_TX_STATUS			0x110	/* TX_STATUS */
-#define DNET_RX_FRAMES_CNT		0x114	/* RX_FRAMES_CNT */
-#define DNET_TX_FRAMES_CNT		0x118	/* TX_FRAMES_CNT */
-#define DNET_RX_FIFO_TH			0x11C	/* RX_FIFO_TH */
-#define DNET_TX_FIFO_TH			0x120	/* TX_FIFO_TH */
-#define DNET_SYS_CTL			0x124	/* SYS_CTL */
-#define DNET_PAUSE_TMR			0x128	/* PAUSE_TMR */
-#define DNET_RX_FIFO_WCNT		0x12C	/* RX_FIFO_WCNT */
-#define DNET_TX_FIFO_WCNT		0x130	/* TX_FIFO_WCNT */
-
-/* ALL DNET MAC REGISTERS */
-#define DNET_MACREG_DATA		0x200	/* Mac-Reg Data */
-#define DNET_MACREG_ADDR		0x204	/* Mac-Reg Addr  */
-
-/* ALL DNET RX STATISTICS COUNTERS  */
-#define DNET_RX_PKT_IGNR_CNT		0x300
-#define DNET_RX_LEN_CHK_ERR_CNT		0x304
-#define DNET_RX_LNG_FRM_CNT		0x308
-#define DNET_RX_SHRT_FRM_CNT		0x30C
-#define DNET_RX_IPG_VIOL_CNT		0x310
-#define DNET_RX_CRC_ERR_CNT		0x314
-#define DNET_RX_OK_PKT_CNT		0x318
-#define DNET_RX_CTL_FRM_CNT		0x31C
-#define DNET_RX_PAUSE_FRM_CNT		0x320
-#define DNET_RX_MULTICAST_CNT		0x324
-#define DNET_RX_BROADCAST_CNT		0x328
-#define DNET_RX_VLAN_TAG_CNT		0x32C
-#define DNET_RX_PRE_SHRINK_CNT		0x330
-#define DNET_RX_DRIB_NIB_CNT		0x334
-#define DNET_RX_UNSUP_OPCD_CNT		0x338
-#define DNET_RX_BYTE_CNT		0x33C
-
-/* DNET TX STATISTICS COUNTERS */
-#define DNET_TX_UNICAST_CNT		0x400
-#define DNET_TX_PAUSE_FRM_CNT		0x404
-#define DNET_TX_MULTICAST_CNT		0x408
-#define DNET_TX_BRDCAST_CNT		0x40C
-#define DNET_TX_VLAN_TAG_CNT		0x410
-#define DNET_TX_BAD_FCS_CNT		0x414
-#define DNET_TX_JUMBO_CNT		0x418
-#define DNET_TX_BYTE_CNT		0x41C
-
-/* SOME INTERNAL MAC-CORE REGISTER */
-#define DNET_INTERNAL_MODE_REG		0x0
-#define DNET_INTERNAL_RXTX_CONTROL_REG	0x2
-#define DNET_INTERNAL_MAX_PKT_SIZE_REG	0x4
-#define DNET_INTERNAL_IGP_REG		0x8
-#define DNET_INTERNAL_MAC_ADDR_0_REG	0xa
-#define DNET_INTERNAL_MAC_ADDR_1_REG	0xc
-#define DNET_INTERNAL_MAC_ADDR_2_REG	0xe
-#define DNET_INTERNAL_TX_RX_STS_REG	0x12
-#define DNET_INTERNAL_GMII_MNG_CTL_REG	0x14
-#define DNET_INTERNAL_GMII_MNG_DAT_REG	0x16
-
-#define DNET_INTERNAL_GMII_MNG_CMD_FIN	(1 << 14)
-
-#define DNET_INTERNAL_WRITE		(1 << 31)
-
-/* MAC-CORE REGISTER FIELDS */
-
-/* MAC-CORE MODE REGISTER FIELDS */
-#define DNET_INTERNAL_MODE_GBITEN			(1 << 0)
-#define DNET_INTERNAL_MODE_FCEN				(1 << 1)
-#define DNET_INTERNAL_MODE_RXEN				(1 << 2)
-#define DNET_INTERNAL_MODE_TXEN				(1 << 3)
-
-/* MAC-CORE RXTX CONTROL REGISTER FIELDS */
-#define DNET_INTERNAL_RXTX_CONTROL_RXSHORTFRAME		(1 << 8)
-#define DNET_INTERNAL_RXTX_CONTROL_RXBROADCAST		(1 << 7)
-#define DNET_INTERNAL_RXTX_CONTROL_RXMULTICAST		(1 << 4)
-#define DNET_INTERNAL_RXTX_CONTROL_RXPAUSE		(1 << 3)
-#define DNET_INTERNAL_RXTX_CONTROL_DISTXFCS		(1 << 2)
-#define DNET_INTERNAL_RXTX_CONTROL_DISCFXFCS		(1 << 1)
-#define DNET_INTERNAL_RXTX_CONTROL_ENPROMISC		(1 << 0)
-#define DNET_INTERNAL_RXTX_CONTROL_DROPCONTROL		(1 << 6)
-#define DNET_INTERNAL_RXTX_CONTROL_ENABLEHALFDUP	(1 << 5)
-
-/* SYSTEM CONTROL REGISTER FIELDS */
-#define DNET_SYS_CTL_IGNORENEXTPKT			(1 << 0)
-#define DNET_SYS_CTL_SENDPAUSE				(1 << 2)
-#define DNET_SYS_CTL_RXFIFOFLUSH			(1 << 3)
-#define DNET_SYS_CTL_TXFIFOFLUSH			(1 << 4)
-
-/* TX STATUS REGISTER FIELDS */
-#define DNET_TX_STATUS_FIFO_ALMOST_EMPTY		(1 << 2)
-#define DNET_TX_STATUS_FIFO_ALMOST_FULL			(1 << 1)
-
-/* INTERRUPT SOURCE REGISTER FIELDS */
-#define DNET_INTR_SRC_TX_PKTSENT			(1 << 0)
-#define DNET_INTR_SRC_TX_FIFOAF				(1 << 1)
-#define DNET_INTR_SRC_TX_FIFOAE				(1 << 2)
-#define DNET_INTR_SRC_TX_DISCFRM			(1 << 3)
-#define DNET_INTR_SRC_TX_FIFOFULL			(1 << 4)
-#define DNET_INTR_SRC_RX_CMDFIFOAF			(1 << 8)
-#define DNET_INTR_SRC_RX_CMDFIFOFF			(1 << 9)
-#define DNET_INTR_SRC_RX_DATAFIFOFF			(1 << 10)
-#define DNET_INTR_SRC_TX_SUMMARY			(1 << 16)
-#define DNET_INTR_SRC_RX_SUMMARY			(1 << 17)
-#define DNET_INTR_SRC_PHY				(1 << 19)
-
-/* INTERRUPT ENABLE REGISTER FIELDS */
-#define DNET_INTR_ENB_TX_PKTSENT			(1 << 0)
-#define DNET_INTR_ENB_TX_FIFOAF				(1 << 1)
-#define DNET_INTR_ENB_TX_FIFOAE				(1 << 2)
-#define DNET_INTR_ENB_TX_DISCFRM			(1 << 3)
-#define DNET_INTR_ENB_TX_FIFOFULL			(1 << 4)
-#define DNET_INTR_ENB_RX_PKTRDY				(1 << 8)
-#define DNET_INTR_ENB_RX_FIFOAF				(1 << 9)
-#define DNET_INTR_ENB_RX_FIFOERR			(1 << 10)
-#define DNET_INTR_ENB_RX_ERROR				(1 << 11)
-#define DNET_INTR_ENB_RX_FIFOFULL			(1 << 12)
-#define DNET_INTR_ENB_RX_FIFOAE				(1 << 13)
-#define DNET_INTR_ENB_TX_SUMMARY			(1 << 16)
-#define DNET_INTR_ENB_RX_SUMMARY			(1 << 17)
-#define DNET_INTR_ENB_GLOBAL_ENABLE			(1 << 18)
-
-/* default values:
- * almost empty = less than one full sized ethernet frame (no jumbo) inside
- * the fifo almost full = can write less than one full sized ethernet frame
- * (no jumbo) inside the fifo
- */
-#define DNET_CFG_TX_FIFO_FULL_THRES	25
-#define DNET_CFG_RX_FIFO_FULL_THRES	20
-
-/*
- * Capabilities. Used by the driver to know the capabilities that the ethernet
- * controller inside the FPGA have.
- */
-
-#define DNET_HAS_MDIO		(1 << 0)
-#define DNET_HAS_IRQ		(1 << 1)
-#define DNET_HAS_GIGABIT	(1 << 2)
-#define DNET_HAS_DMA		(1 << 3)
-
-#define DNET_HAS_MII		(1 << 4) /* or GMII */
-#define DNET_HAS_RMII		(1 << 5) /* or RGMII */
-
-#define DNET_CAPS_MASK		0xFFFF
-
-#define DNET_FIFO_SIZE		1024 /* 1K x 32 bit */
-#define DNET_FIFO_TX_DATA_AF_TH	(DNET_FIFO_SIZE - 384) /* 384 = 1536 / 4 */
-#define DNET_FIFO_TX_DATA_AE_TH	384
-
-#define DNET_FIFO_RX_CMD_AF_TH	(1 << 16) /* just one frame inside the FIFO */
-
-/*
- * Hardware-collected statistics.
- */
-struct dnet_stats {
-	u32 rx_pkt_ignr;
-	u32 rx_len_chk_err;
-	u32 rx_lng_frm;
-	u32 rx_shrt_frm;
-	u32 rx_ipg_viol;
-	u32 rx_crc_err;
-	u32 rx_ok_pkt;
-	u32 rx_ctl_frm;
-	u32 rx_pause_frm;
-	u32 rx_multicast;
-	u32 rx_broadcast;
-	u32 rx_vlan_tag;
-	u32 rx_pre_shrink;
-	u32 rx_drib_nib;
-	u32 rx_unsup_opcd;
-	u32 rx_byte;
-	u32 tx_unicast;
-	u32 tx_pause_frm;
-	u32 tx_multicast;
-	u32 tx_brdcast;
-	u32 tx_vlan_tag;
-	u32 tx_bad_fcs;
-	u32 tx_jumbo;
-	u32 tx_byte;
-};
-
-struct dnet {
-	void __iomem			*regs;
-	spinlock_t			lock;
-	struct platform_device		*pdev;
-	struct net_device		*dev;
-	struct dnet_stats		hw_stats;
-	unsigned int			capabilities; /* read from FPGA */
-	struct napi_struct		napi;
-
-	/* PHY stuff */
-	struct mii_bus			*mii_bus;
-	unsigned int			link;
-	unsigned int			speed;
-	unsigned int			duplex;
-};
-
-#endif /* _DNET_H */
-- 
2.52.0


