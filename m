Return-Path: <netdev+bounces-180327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720A7A80F9C
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C52C88072B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E11B222595;
	Tue,  8 Apr 2025 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRlWSMM/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C8157A72;
	Tue,  8 Apr 2025 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125294; cv=none; b=bu2hUj2A3yf+eE5mTucKH4NDtobv1olWbyefBmhifQKLCgiHkagQb9cT9k3DUNCL+G2DcVIWWRUkjI8wPZgismUqW1YAqUVSXVwcPoS1pEPAK1W8buS+MdmJcJGSRab08y/kLnpXqwUrZSsemnTbGntWAfeU8JsJvIj5p99y/QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125294; c=relaxed/simple;
	bh=TT1IZ7K7Y6UPbWpcMAaki5Xun2Oty3CS7nlOytanxV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/5HZ/wuu+ah3k8JBMYDFXRI5NcFCj8HmKd3F3l72GEaKitjt36zXQAZD6I8ZBvYY4XNoRCI8L/mDiwTleg+oj1EztT6SL5jCyKvM9yvZOwS/GQJMFa5FWbFwO/F072hi+OwdU0L4vVUUKVhMQcaKgOanxz0FHyiSQUeNAsv6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRlWSMM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC72C4CEE5;
	Tue,  8 Apr 2025 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744125293;
	bh=TT1IZ7K7Y6UPbWpcMAaki5Xun2Oty3CS7nlOytanxV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRlWSMM/uEFbtcJwhokBF3pWePUeDJiwtIQWN3wSCJfeksOTToTN0zoG/V06H5hWy
	 Ws1CCqQLGEJoNji8+po+bydOPhfdLl7WK9XSqOL6sANdfa5Mi2rWhMPhm7RrjcFMSf
	 N2zj+hhM53rnkEBKDFDt5lhhmf5DVV5vgcZR4tQfMhtj0Z65LYVv9sxDsDjv58CYy4
	 lYbAwWTR6DzbYKkVyeHGiG3zDnvYgph/94cSX243jKG2ej4zqL8WGvPyT+j4Bq3aT/
	 fYrIrzbY1xtIIhj+ptygs6cuXTiDqETYwDtkFs+ggczIe9oA0z+bax9pQAFXa8bNiC
	 15TweIa12L8uw==
Date: Tue, 8 Apr 2025 16:14:47 +0100
From: Simon Horman <horms@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [net-next v4 4/5] net: mtip: The L2 switch driver for imx287
Message-ID: <20250408151447.GX395307@horms.kernel.org>
References: <20250407145157.3626463-1-lukma@denx.de>
 <20250407145157.3626463-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407145157.3626463-5-lukma@denx.de>

On Mon, Apr 07, 2025 at 04:51:56PM +0200, Lukasz Majewski wrote:
> This patch series provides support for More Than IP L2 switch embedded
> in the imx287 SoC.
> 
> This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
> which can be used for offloading the network traffic.
> 
> It can be used interchangeably with current FEC driver - to be more
> specific: one can use either of it, depending on the requirements.
> 
> The biggest difference is the usage of DMA - when FEC is used, separate
> DMAs are available for each ENET-MAC block.
> However, with switch enabled - only the DMA0 is used to send/receive data
> to/form switch (and then switch sends them to respecitive ports).
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Hi Lukasz,

This is not a complete review, but I did spend a bit of time
looking over this and have provided some feedback on
things I noticed below.

...

> diff --git a/drivers/net/ethernet/freescale/mtipsw/Kconfig b/drivers/net/ethernet/freescale/mtipsw/Kconfig
> new file mode 100644
> index 000000000000..450ff734a321
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config FEC_MTIP_L2SW
> +	tristate "MoreThanIP L2 switch support to FEC driver"
> +	depends on OF
> +	depends on NET_SWITCHDEV
> +	depends on BRIDGE
> +	depends on ARCH_MXS || ARCH_MXC || COMPILE_TEST
> +	help
> +	  This enables support for the MoreThan IP L2 switch on i.MX
> +	  SoCs (e.g. iMX28, vf610). It offloads bridging to this IP block's
> +	  hardware and allows switch management with standard Linux tools.
> +	  This switch driver can be used interchangeable with the already
> +	  available FEC driver, depending on the use case's requirments.

nit: requirements

Flagged by checkpatch.pl --codespell

...

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c

...

> +static void mtip_enet_init(struct switch_enet_private *fep, int port)
> +{
> +	void __iomem *enet_addr = fep->enet_addr;
> +	u32 mii_speed, holdtime, tmp;

I think it would be best to avoid variable names like tmp which have little
meaning. Although still rather generic, perhaps reg would be more
appropriate. Or better still something relating to the name the register,
say rcr.

> +
> +	if (port == 2)
> +		enet_addr += MCF_ESW_ENET_PORT_OFFSET;
> +
> +	tmp = MCF_FEC_RCR_PROM | MCF_FEC_RCR_MII_MODE |
> +		MCF_FEC_RCR_MAX_FL(1522);
> +
> +	if (fep->phy_interface[port - 1]  == PHY_INTERFACE_MODE_RMII)
> +		tmp |= MCF_FEC_RCR_RMII_MODE;
> +
> +	writel(tmp, enet_addr + MCF_FEC_RCR);
> +
> +	/* TCR */
> +	writel(MCF_FEC_TCR_FDEN, enet_addr + MCF_FEC_TCR);
> +
> +	/* ECR */
> +	writel(MCF_FEC_ECR_ETHER_EN, enet_addr + MCF_FEC_ECR);
> +
> +	/* Set MII speed to 2.5 MHz
> +	 */
> +	mii_speed = DIV_ROUND_UP(clk_get_rate(fep->clk_ipg), 5000000);
> +	mii_speed--;
> +
> +	/* The i.MX28 and i.MX6 types have another filed in the MSCR (aka
> +	 * MII_SPEED) register that defines the MDIO output hold time. Earlier
> +	 * versions are RAZ there, so just ignore the difference and write the
> +	 * register always.
> +	 * The minimal hold time according to IEE802.3 (clause 22) is 10 ns.
> +	 * HOLDTIME + 1 is the number of clk cycles the fec is holding the
> +	 * output.
> +	 * The HOLDTIME bitfield takes values between 0 and 7 (inclusive).
> +	 * Given that ceil(clkrate / 5000000) <= 64, the calculation for
> +	 * holdtime cannot result in a value greater than 3.
> +	 */
> +	holdtime = DIV_ROUND_UP(clk_get_rate(fep->clk_ipg), 100000000) - 1;
> +
> +	fep->phy_speed = mii_speed << 1 | holdtime << 8;
> +
> +	writel(fep->phy_speed, enet_addr + MCF_FEC_MSCR);
> +}
> +
> +static int mtip_setup_mac(struct net_device *dev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	unsigned char *iap, tmpaddr[ETH_ALEN];

Maybe mac_addr instead of tmpaddr.

> +
> +	/* Use MAC address from DTS */
> +	iap = &fep->mac[priv->portnum - 1][0];
> +
> +	/* Use MAC address set by bootloader */
> +	if (!is_valid_ether_addr(iap)) {
> +		*((unsigned long *)&tmpaddr[0]) =
> +			be32_to_cpu(readl(fep->enet_addr + MCF_FEC_PALR));
> +		*((unsigned short *)&tmpaddr[4]) =
> +			be16_to_cpu(readl(fep->enet_addr +
> +					  MCF_FEC_PAUR) >> 16);

* Above, and elsewhere in this patch unsigned long seems to be
  used for 32 bit values. But unsigned long can be 64 bits wide.

  I would suggest using u32, u16, and friends throughout this
  patch where an integer has a specific number of bits.

* readl returns a 32-bit value in host byte order.
  But the above assumes it returns a big endian value.

  This does not seem correct.

* The point immediately above aside, the assignment of
  host byte order values to the byte-array tmpaddr
  seems to assume an endianness (little endian?).

  It should work on either endian.

> +		iap = &tmpaddr[0];
> +	}
> +
> +	/* Use random MAC address */
> +	if (!is_valid_ether_addr(iap)) {
> +		eth_hw_addr_random(dev);
> +		dev_info(&fep->pdev->dev, "Using random MAC address: %pM\n",
> +			 dev->dev_addr);
> +		iap = (unsigned char *)dev->dev_addr;
> +	}
> +
> +	/* Adjust MAC if using macaddr (and increment if needed) */
> +	eth_hw_addr_gen(dev, iap, priv->portnum - 1);
> +
> +	return 0;
> +}
> +
> +/**
> + * crc8_calc - calculate CRC for MAC storage
> + *
> + * @pmacaddress: A 6-byte array with the MAC address. The first byte is
> + *               the first byte transmitted.
> + *
> + * Calculate Galois Field Arithmetic CRC for Polynom x^8+x^2+x+1.
> + * It omits the final shift in of 8 zeroes a "normal" CRC would do
> + * (getting the remainder).
> + *
> + *  Examples (hexadecimal values):<br>
> + *   10-11-12-13-14-15  => CRC=0xc2
> + *   10-11-cc-dd-ee-00  => CRC=0xe6
> + *
> + * Return: The 8-bit CRC in bits 7:0
> + */
> +static int crc8_calc(unsigned char *pmacaddress)

Can lib/crc8.c:crc8() be used here?

> +{
> +	int byt; /* byte index */
> +	int bit; /* bit index */
> +	int crc = 0x12;
> +	int inval;
> +
> +	for (byt = 0; byt < 6; byt++) {
> +		inval = (((int)pmacaddress[byt]) & 0xff);
> +		/* shift bit 0 to bit 8 so all our bits
> +		 * travel through bit 8
> +		 * (simplifies below calc)
> +		 */
> +		inval <<= 8;
> +
> +		for (bit = 0; bit < 8; bit++) {
> +			/* next input bit comes into d7 after shift */
> +			crc |= inval & 0x100;
> +			if (crc & 0x01)
> +				/* before shift  */
> +				crc ^= 0x1c0;
> +
> +			crc >>= 1;
> +			inval >>= 1;
> +		}
> +	}
> +	/* upper bits are clean as we shifted in zeroes! */
> +	return crc;
> +}
> +
> +static void mtip_read_atable(struct switch_enet_private *fep, int index,
> +			     unsigned long *read_lo, unsigned long *read_hi)
> +{
> +	unsigned long atable_base = (unsigned long)fep->hwentry;
> +
> +	*read_lo = readl((const void *)atable_base + (index << 3));
> +	*read_hi = readl((const void *)atable_base + (index << 3) + 4);
> +}

It is unclear why hwentry, which is a pointer, is being cast to an
integer and then back to a pointer. I see pointer arithmetic, but
that can operate on pointers just as well as integers, without making
assumptions about how wide pointers are with respect to longs.

And in any case, can't the types be used to directly access the
offsets needed like this?

	atable = fep->hwentry.mtip_table64b_entry;

	*read_lo = readl(&atable[index].lo);
	*read_hi = readl(&atable[index].hi);

Also, and perhaps more importantly, readl expects to be passed
a pointer to __iomem. But the appropriate annotations seem
to be missing (forcing them with a cast is not advisable here IMHO).

Please do run sparse over your patches to iron out __iomem
(and endian) issues.

> +
> +static void mtip_write_atable(struct switch_enet_private *fep, int index,
> +			      unsigned long write_lo, unsigned long write_hi)
> +{
> +	unsigned long atable_base = (unsigned long)fep->hwentry;
> +
> +	writel(write_lo, (void *)atable_base + (index << 3));
> +	writel(write_hi, (void *)atable_base + (index << 3) + 4);

Likewise here.

> +}

...

> +/* Clear complete MAC Look Up Table */
> +void mtip_clear_atable(struct switch_enet_private *fep)
> +{
> +	int index;
> +
> +	for (index = 0; index < 2048; index++)
> +		mtip_write_atable(fep, index, 0, 0);
> +}
> +
> +/**
> + * mtip_update_atable_static - Update switch static address table
> + *
> + * @mac_addr: Pointer to the array containing MAC address to
> + *            be put as static entry
> + * @port:     Port bitmask numbers to be added in static entry,
> + *            valid values are 1-7
> + * @priority: The priority for the static entry in table

@fep should also be documented here.

Flagged by ./scripts/kernel-doc -none
and W=1 builds.

> + *
> + * Updates MAC address lookup table with a static entry.
> + *
> + * Searches if the MAC address is already there in the block and replaces
> + * the older entry with the new one. If MAC address is not there then puts
> + * a new entry in the first empty slot available in the block.
> + *
> + * Return: 0 for a successful update else -ENOSPC when no slot available
> + */
> +static int mtip_update_atable_static(unsigned char *mac_addr, unsigned int port,
> +				     unsigned int priority,
> +				     struct switch_enet_private *fep)

...

> +/* During a receive, the cur_rx points to the current incoming buffer.
> + * When we update through the ring, if the next incoming buffer has
> + * not been given to the system, we just set the empty indicator,
> + * effectively tossing the packet.
> + */
> +static int mtip_switch_rx(struct net_device *dev, int budget, int *port)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	struct switch_t *fecp = fep->hwp;
> +	unsigned short status, pkt_len;
> +	struct net_device *pndev;
> +	u8 *data, rx_port = 0xFF;
> +	struct ethhdr *eth_hdr;
> +	int pkt_received = 0;
> +	struct sk_buff *skb;
> +	unsigned long flags;
> +	struct cbd_t *bdp;
> +
> +	spin_lock_irqsave(&fep->hw_lock, flags);
> +
> +	/* First, grab all of the stats for the incoming packet.
> +	 * These get messed up if we get called due to a busy condition.
> +	 */
> +	bdp = fep->cur_rx;
> +
> +	while (!((status = bdp->cbd_sc) & BD_ENET_RX_EMPTY)) {

...

> +	} /* while (!((status = bdp->cbd_sc) & BD_ENET_RX_EMPTY)) */
> +
> +	writel(bdp, &fep->cur_rx);

I'm confused buy this.

At the top of this function, bdp is assigned using:

	bdp = fep->cur_rx;

But here writel() is used to assign bdp to &fep->cur_rx.
Which assumes that bdp is a 32-bit little endian value.
But it is a pointer in host byte order which may be wide than 32-bits.

On x86_64 int is 32-bits while pointers are 64 bits.
W=1 builds with gcc 14.2.0 flag this problem like this:


.../mtipl2sw.c:1108:9: error: incompatible pointer to integer conversion passing 'struct cbd_t *' to parameter of type 'unsigned int' [-Wint-conversion]
 1108 |         writel(bdp, &fep->cur_rx);
      |                ^~~


This also assumes that &fep->cur_rx is a pointer to __iomem,
but that does not seem to be the case.

> +	spin_unlock_irqrestore(&fep->hw_lock, flags);
> +
> +	return pkt_received;
> +}

...

> +static int __init mtip_switch_dma_init(struct switch_enet_private *fep)
> +{
> +	struct cbd_t *bdp, *cbd_base;
> +	int ret, i;
> +
> +	/* Check mask of the streaming and coherent API */
> +	ret = dma_set_mask_and_coherent(&fep->pdev->dev, DMA_BIT_MASK(32));
> +	if (ret < 0) {
> +		dev_err(&fep->pdev->dev, "No suitable DMA available\n");
> +		return ret;
> +	}
> +
> +	/* Allocate memory for buffer descriptors */
> +	cbd_base = dma_alloc_coherent(&fep->pdev->dev, PAGE_SIZE, &fep->bd_dma,
> +				      GFP_KERNEL);
> +	if (!cbd_base)
> +		return -ENOMEM;
> +
> +	/* Set receive and transmit descriptor base */
> +	fep->rx_bd_base = cbd_base;
> +	fep->tx_bd_base = cbd_base + RX_RING_SIZE;
> +
> +	/* Initialize the receive buffer descriptors */
> +	bdp = fep->rx_bd_base;
> +	for (i = 0; i < RX_RING_SIZE; i++) {
> +		bdp->cbd_sc = 0;
> +		bdp++;
> +	}
> +
> +	/* Set the last buffer to wrap */
> +	bdp--;
> +	bdp->cbd_sc |= BD_SC_WRAP;
> +
> +	/* ...and the same for transmmit */

nit: transmit

> +	bdp = fep->tx_bd_base;
> +	for (i = 0; i < TX_RING_SIZE; i++) {
> +		/* Initialize the BD for every fragment in the page */
> +		bdp->cbd_sc = 0;
> +		bdp->cbd_bufaddr = 0;
> +		bdp++;
> +	}
> +
> +	/* Set the last buffer to wrap */
> +	bdp--;
> +	bdp->cbd_sc |= BD_SC_WRAP;
> +
> +	return 0;
> +}
> +
> +static void mtip_ndev_cleanup(struct switch_enet_private *fep)
> +{
> +	int i;
> +
> +	for (i = 0; i < SWITCH_EPORT_NUMBER; i++) {
> +		if (fep->ndev[i]) {
> +			unregister_netdev(fep->ndev[i]);
> +			free_netdev(fep->ndev[i]);
> +		}
> +	}
> +}

...

> +static const struct of_device_id mtipl2_of_match[] = {
> +	{ .compatible = "nxp,imx28-mtip-switch",
> +	  .data = &mtip_imx28_l2switch_info},
> +	{ /* sentinel */ }
> +}

There should be a trailing ';' on the line above.

...

> +struct  addr_table64b_entry {

One space after struct is enough.

> +	unsigned int lo;  /* lower 32 bits */
> +	unsigned int hi;  /* upper 32 bits */
> +};
> +
> +struct  mtip_addr_table_t {

I think you can drop the '_t' from the name of this struct.
We know it is a type :)

> +	struct addr_table64b_entry  mtip_table64b_entry[2048];

One space is enough after addr_table64b_entry.
And in general, unless the aim is to align field names
(not here because there is only one field :)

> +};
> +
> +#define MCF_ESW_LOOKUP_MEM_OFFSET      0x4000
> +#define MCF_ESW_ENET_PORT_OFFSET      0x4000
> +#define ENET_SWI_PHYS_ADDR_OFFSET	0x8000

Ditto.

...

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c

> new file mode 100644
> index 000000000000..0b76a60858a5
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  L2 switch Controller driver for MTIP block - bridge network interface
> + *
> + *  Copyright (C) 2025 DENX Software Engineering GmbH
> + *  Lukasz Majewski <lukma@denx.de>
> + */
> +
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <linux/platform_device.h>
> +
> +#include "mtipl2sw.h"

Blank line here please.

> +static int mtip_ndev_port_link(struct net_device *ndev,
> +			       struct net_device *br_ndev,
> +			       struct netlink_ext_ack *extack)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(ndev), *other_priv;
> +	struct switch_enet_private *fep = priv->fep;
> +	struct net_device *other_ndev;
> +
> +	/* Check if one port of MTIP switch is already bridged */
> +	if (fep->br_members && !fep->br_offload) {
> +		/* Get the second bridge ndev */
> +		other_ndev = fep->ndev[fep->br_members - 1];
> +		other_priv = netdev_priv(other_ndev);
> +		if (other_priv->master_dev != br_ndev) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "L2 offloading only possible for the same bridge!");
> +			return notifier_from_errno(-EOPNOTSUPP);
> +		}
> +
> +		fep->br_offload = 1;
> +		mtip_switch_dis_port_separation(fep);
> +		mtip_clear_atable(fep);
> +	}
> +
> +	if (!priv->master_dev)
> +		priv->master_dev = br_ndev;
> +
> +	fep->br_members |= BIT(priv->portnum - 1);
> +
> +	dev_dbg(&ndev->dev,
> +		"%s: ndev: %s br: %s fep: 0x%x members: 0x%x offload: %d\n",
> +		__func__, ndev->name,  br_ndev->name, (unsigned int)fep,

Perhaps it would be best to use %p as the format specifier for fep
and not cast it.

On x86_64 int is 32-bits while pointers are 64 bits.
W=1 builds with gcc 14.2.0 flag this problem like this:

.../mtipl2sw_br.c:45:55: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
   45 |                 __func__, ndev->name,  br_ndev->name, (unsigned int)fep,
      |                                                       ^

> +		fep->br_members, fep->br_offload);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static void mtip_netdevice_port_unlink(struct net_device *ndev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(ndev);
> +	struct switch_enet_private *fep = priv->fep;
> +
> +	dev_dbg(&ndev->dev, "%s: ndev: %s members: 0x%x\n", __func__,
> +		ndev->name, fep->br_members);
> +
> +	fep->br_members &= ~BIT(priv->portnum - 1);
> +	priv->master_dev = NULL;
> +
> +	if (!fep->br_members) {
> +		fep->br_offload = 0;
> +		mtip_switch_en_port_separation(fep);
> +		mtip_clear_atable(fep);
> +	}
> +}

...

-- 
pw-bot: changes-requested

