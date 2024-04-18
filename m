Return-Path: <netdev+bounces-89338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9157F8AA0F8
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7383B21B72
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4D6172BBC;
	Thu, 18 Apr 2024 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnJV1GhL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B167171093
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460989; cv=none; b=L6NAOp3SMZ8M/XWimafkGxzdbXcxPU7BCzTN9xZh5C3AVmv9xe/rvoPzHdT+FVZrf3aeT2WwdjCPNNuujRxrVxQ/vi8XkO1qtE8mUQkydRju78uEi5DdU2HRd2HbrwRmrgQqsPY1lzlSOIW9kITMhLDBaUkRF7PH+jNNY9siPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460989; c=relaxed/simple;
	bh=Vckyslihcj70m4txugGjj9/acUU5o/rBu4iKdupWQOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lgk72F1Zdgnhys5Psyo/NWR2X3iso+bMfSU+qJM05cc5JJkpQe39/s6cSxHaAE2KofATP6Qd+kQVxz+yilsyEd+rb1NYakrZESOPmiu/oVXD2lZzyQSTyj+erotHuLWxSwh9sMOg+Zx8rq+3kBddjImocxqxt1GJkyk/lNBfnTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnJV1GhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C56C113CC;
	Thu, 18 Apr 2024 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713460989;
	bh=Vckyslihcj70m4txugGjj9/acUU5o/rBu4iKdupWQOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WnJV1GhLhfmbiMn1eJ0VhGDjVrSfqqQO08jhp5oW6+0rI+++KDtAmjOmzkEmjdpwI
	 Irnj7cOImDX+CpJSEk0Se5PWBvEauG9Q5LlYrrK7V5QrMeW3ZrP/amrz3hhcgxG0nv
	 capebId4H7qeP4Kw3zhEYnU9gUEhHvl3SDMQIzLXjeAg4FkfZJeb+RgsN6uQYilVZ0
	 T2pchAGStrvZjP9gCUwoD9e2AfiS+nQgUSZjXAmsiYXV898dId2tdv6wEZuxXSj13x
	 d8+d6oadBuLKYa0bQ+i3dORUzsxWEO789242bn6jPOdeExJ9CmJmfoLMhiDmJq2zzz
	 3NaUvcnW+z0+w==
Date: Thu, 18 Apr 2024 18:23:06 +0100
From: Simon Horman <horms@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch
Subject: Re: [PATCH net-next v1 3/5] net: tn40xx: add basic Tx handling
Message-ID: <20240418172306.GH3975545@kernel.org>
References: <20240415104352.4685-1-fujita.tomonori@gmail.com>
 <20240415104352.4685-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415104352.4685-4-fujita.tomonori@gmail.com>

On Mon, Apr 15, 2024 at 07:43:50PM +0900, FUJITA Tomonori wrote:
> This patch adds device specific structures to initialize the hardware
> with basic Tx handling. The original driver loads the embedded
> firmware in the header file. This driver is implemented to use the
> firmware APIs.
> 
> The Tx logic uses three major data structures; two ring buffers with
> NIC and one database. One ring buffer is used to send information
> about packets to be sent for NIC. The other is used to get information
> from NIC about packet that are sent. The database is used to keep the
> information about DMA mapping. After a packet is sent, the db is used
> to free the resource used for the packet.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Hi Fujita-san,

Some review from my side.

> ---
>  drivers/net/ethernet/tehuti/Kconfig |    1 +
>  drivers/net/ethernet/tehuti/tn40.c  | 1251 +++++++++++++++++++++++++++
>  drivers/net/ethernet/tehuti/tn40.h  |  192 +++-
>  3 files changed, 1443 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
> index 849e3b4a71c1..4198fd59e42e 100644
> --- a/drivers/net/ethernet/tehuti/Kconfig
> +++ b/drivers/net/ethernet/tehuti/Kconfig
> @@ -26,6 +26,7 @@ config TEHUTI
>  config TEHUTI_TN40
>  	tristate "Tehuti Networks TN40xx 10G Ethernet adapters"
>  	depends on PCI
> +	select FW_LOADER
>  	help
>  	  This driver supports 10G Ethernet adapters using Tehuti Networks
>  	  TN40xx chips. Currently, adapters with Applied Micro Circuits

Not strictly related to this patch, but did you consider
adding an entry in the MAINTAINERS file for this driver?

> diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
> index 368a73300f8a..0798df468fc3 100644
> --- a/drivers/net/ethernet/tehuti/tn40.c
> +++ b/drivers/net/ethernet/tehuti/tn40.c
> @@ -3,9 +3,1170 @@
>  
>  #include "tn40.h"
>  
> +#define SHORT_PACKET_SIZE 60
> +
> +static void bdx_enable_interrupts(struct bdx_priv *priv)
> +{
> +	write_reg(priv, REG_IMR, priv->isr_mask);
> +}
> +
> +static void bdx_disable_interrupts(struct bdx_priv *priv)
> +{
> +	write_reg(priv, REG_IMR, 0);
> +}
> +
> +static int bdx_fifo_alloc(struct bdx_priv *priv, struct fifo *f, int fsz_type,
> +			  u16 reg_cfg0, u16 reg_cfg1, u16 reg_rptr, u16 reg_wptr)

Please consider using a soft limit on line length of 80 characters
in Networking code.

> +{
> +	u16 memsz = FIFO_SIZE * (1 << fsz_type);

I'm not sure if fsz_type has a meaning here - perhaps it comes from the
datasheet. But if not, perhaps 'order' would be a more intuitive
name for this parameter. Similarly for the txd_size and txf_size
fields of struct bdx_priv, the sz_type field of bdx_tx_db_init(),
and possibly elsewhere.

> +
> +	memset(f, 0, sizeof(struct fifo));
> +	/* 1K extra space is allocated at the end of the fifo to simplify
> +	 * processing of descriptors that wraps around fifo's end.
> +	 */
> +	f->va = dma_alloc_coherent(&priv->pdev->dev,
> +				   memsz + FIFO_EXTRA_SPACE, &f->da, GFP_KERNEL);
> +	if (!f->va)
> +		return -ENOMEM;
> +
> +	f->reg_cfg0 = reg_cfg0;
> +	f->reg_cfg1 = reg_cfg1;
> +	f->reg_rptr = reg_rptr;
> +	f->reg_wptr = reg_wptr;
> +	f->rptr = 0;
> +	f->wptr = 0;
> +	f->memsz = memsz;
> +	f->size_mask = memsz - 1;
> +	write_reg(priv, reg_cfg0, (u32)((f->da & TX_RX_CFG0_BASE) | fsz_type));

For consistency should this be use H32_64()?:

		H32_64((f->da & TX_RX_CFG0_BASE) | fsz_type)

> +	write_reg(priv, reg_cfg1, H32_64(f->da));
> +	return 0;
> +}
> +
> +static void bdx_fifo_free(struct bdx_priv *priv, struct fifo *f)
> +{
> +	dma_free_coherent(&priv->pdev->dev,
> +			  f->memsz + FIFO_EXTRA_SPACE, f->va, f->da);
> +}
> +
> +/* TX HW/SW interaction overview
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + * There are 2 types of TX communication channels between driver and NIC.
> + * 1) TX Free Fifo - TXF - Holds ack descriptors for sent packets.
> + * 2) TX Data Fifo - TXD - Holds descriptors of full buffers.
> + *
> + * Currently the NIC supports TSO, checksumming and gather DMA
> + * UFO and IP fragmentation is on the way.
> + *
> + * RX SW Data Structures
> + * ~~~~~~~~~~~~~~~~~~~~~
> + * TXDB is used to keep track of all skbs owned by SW and their DMA addresses.
> + * For TX case, ownership lasts from getting the packet via hard_xmit and
> + * until the HW acknowledges sending the packet by TXF descriptors.
> + * TXDB is implemented as a cyclic buffer.
> + *
> + * FIFO objects keep info about the fifo's size and location, relevant HW
> + * registers, usage and skb db. Each RXD and RXF fifo has their own fifo
> + * structure. Implemented as simple struct.
> + *
> + * TX SW Execution Flow
> + * ~~~~~~~~~~~~~~~~~~~~
> + * OS calls the driver's hard_xmit method with a packet to send. The driver
> + * creates DMA mappings, builds TXD descriptors and kicks the HW by updating
> + * TXD WPTR.
> + *
> + * When a packet is sent, The HW write a TXF descriptor and the SW
> + * frees the original skb. To prevent TXD fifo overflow without
> + * reading HW registers every time, the SW deploys "tx level"
> + * technique. Upon startup, the tx level is initialized to TXD fifo
> + * length. For every sent packet, the SW gets its TXD descriptor size
> + * (from a pre-calculated array) and subtracts it from tx level.  The
> + * size is also stored in txdb. When a TXF ack arrives, the SW fetched
> + * the size of the original TXD descriptor from the txdb and adds it
> + * to the tx level. When the Tx level drops below some predefined
> + * threshold, the driver stops the TX queue. When the TX level rises
> + * above that level, the tx queue is enabled again.
> + *
> + * This technique avoids excessive reading of RPTR and WPTR registers.
> + * As our benchmarks shows, it adds 1.5 Gbit/sec to NIS's throughput.
> + */
> +static inline int bdx_tx_db_size(struct txdb *db)
> +{
> +	int taken = db->wptr - db->rptr;
> +
> +	if (taken < 0)
> +		taken = db->size + 1 + taken;	/* (size + 1) equals memsz */
> +	return db->size - taken;
> +}

bdx_tx_db_size seems to be unused. Perhaps it can be removed.

Flagged by W=1 build with clang-18.

...

> +/* Sizes of tx desc (including padding if needed) as function of the SKB's
> + * frag number
> + */
> +static struct {
> +	u16 bytes;
> +	u16 qwords;		/* qword = 64 bit */
> +} txd_sizes[MAX_PBL];
> +
> +inline void bdx_set_pbl(struct pbl *pbl, dma_addr_t dma, int len)
> +{
> +	pbl->len = cpu_to_le32(len);
> +	pbl->pa_lo = cpu_to_le32(L32_64(dma));
> +	pbl->pa_hi = cpu_to_le32(H32_64(dma));
> +}

The type of the pa_lo and pa_high fields of struct pbl are both u32.
But here they are assigned little-endian values. This doesn't seem right
(I expect the types of the fields should be changed to __le32).

This was flagged by Sparse, along with a number of other problems
(which I didn't look into). Please ensure that patches do
not introduce new Sparse warnings.

...

> +/**
> + * txdb_map_skb - create and store DMA mappings for skb's data blocks

nit: bdx_tx_map_skb

Flagged by ./scripts/kernel-doc -Wall -none

> + * @priv: NIC private structure
> + * @skb: socket buffer to map
> + * @txdd: pointer to tx descriptor to be updated
> + * @pkt_len: pointer to unsigned long value
> + *
> + * This function creates DMA mappings for skb's data blocks and writes them to
> + * PBL of a new tx descriptor. It also stores them in the tx db, so they could
> + * be unmapped after the data has been sent. It is the responsibility of the
> + * caller to make sure that there is enough space in the txdb. The last
> + * element holds a pointer to skb itself and is marked with a zero length.
> + *
> + * Return: 0 on success and negative value on error.
> + */
> +static inline int bdx_tx_map_skb(struct bdx_priv *priv, struct sk_buff *skb,
> +				 struct txd_desc *txdd, unsigned int *pkt_len)
> +{
> +	dma_addr_t dma;
> +	int i, len, err;
> +	struct txdb *db = &priv->txdb;
> +	struct pbl *pbl = &txdd->pbl[0];
> +	int nr_frags = skb_shinfo(skb)->nr_frags;
> +	unsigned int size;
> +	struct mapping_info info[MAX_PBL];

nit: Please arrange local variables in new Networking code in reverse
     xmas tree order - longest line to shortest.

     This tool is your friend: https://github.com/ecree-solarflare/xmastree

> +
> +	netdev_dbg(priv->ndev, "TX skb %p skbLen %d dataLen %d frags %d\n", skb,
> +		   skb->len, skb->data_len, nr_frags);
> +	if (nr_frags > MAX_PBL - 1) {
> +		err = skb_linearize(skb);
> +		if (err)
> +			return -1;
> +		nr_frags = skb_shinfo(skb)->nr_frags;
> +	}
> +	/* initial skb */
> +	len = skb->len - skb->data_len;
> +	dma = dma_map_single(&priv->pdev->dev, skb->data, len,
> +			     DMA_TO_DEVICE);
> +	if (dma_mapping_error(&priv->pdev->dev, dma))
> +		return -1;

As I believe Andrew mentioned elsewhere, it's best
to use standard error values. Perhaps here:

	ret = dma_mapping_error(...);
	if (ret)
		return ret;

> +
> +	bdx_set_txdb(db, dma, len);
> +	bdx_set_pbl(pbl++, db->wptr->addr.dma, db->wptr->len);
> +	*pkt_len = db->wptr->len;
> +
> +	for (i = 0; i < nr_frags; i++) {
> +		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
> +
> +		size = skb_frag_size(frag);
> +		dma = skb_frag_dma_map(&priv->pdev->dev, frag, 0,
> +				       size, DMA_TO_DEVICE);
> +
> +		if (dma_mapping_error(&priv->pdev->dev, dma))
> +			goto mapping_error;
> +		info[i].dma = dma;
> +		info[i].size = size;
> +	}
> +
> +	for (i = 0; i < nr_frags; i++) {
> +		bdx_tx_db_inc_wptr(db);
> +		bdx_set_txdb(db, info[i].dma, info[i].size);
> +		bdx_set_pbl(pbl++, db->wptr->addr.dma, db->wptr->len);
> +		*pkt_len += db->wptr->len;
> +	}
> +
> +	/* SHORT_PKT_FIX */
> +	if (skb->len < SHORT_PACKET_SIZE)
> +		++nr_frags;
> +
> +	/* Add skb clean up info. */
> +	bdx_tx_db_inc_wptr(db);
> +	db->wptr->len = -txd_sizes[nr_frags].bytes;
> +	db->wptr->addr.skb = skb;
> +	bdx_tx_db_inc_wptr(db);
> +
> +	return 0;
> + mapping_error:
> +	dma_unmap_page(&priv->pdev->dev, db->wptr->addr.dma, db->wptr->len, DMA_TO_DEVICE);
> +	for (; i > 0; i--)
> +		dma_unmap_page(&priv->pdev->dev, info[i - 1].dma, info[i - 1].size, DMA_TO_DEVICE);
> +	return -1;

And here:

	return -ENOMEM;

> +}

...

> +static int create_tx_ring(struct bdx_priv *priv)
> +{
> +	int ret;
> +
> +	ret = bdx_fifo_alloc(priv, &priv->txd_fifo0.m, priv->txd_size,
> +			     REG_TXD_CFG0_0, REG_TXD_CFG1_0,
> +			     REG_TXD_RPTR_0, REG_TXD_WPTR_0);
> +	if (ret)
> +		return ret;
> +
> +	ret = bdx_fifo_alloc(priv, &priv->txf_fifo0.m, priv->txf_size,
> +			     REG_TXF_CFG0_0, REG_TXF_CFG1_0,
> +			     REG_TXF_RPTR_0, REG_TXF_WPTR_0);
> +	if (ret)
> +		goto err_free_txd;
> +
> +	/* The TX db has to keep mappings for all packets sent (on
> +	 * TxD) and not yet reclaimed (on TxF).
> +	 */
> +	ret = bdx_tx_db_init(&priv->txdb, max(priv->txd_size, priv->txf_size));
> +	if (ret)
> +		goto err_free_txf;
> +
> +	/* SHORT_PKT_FIX */
> +	priv->b0_len = 64;
> +	priv->b0_va =
> +		dma_alloc_coherent(&priv->pdev->dev, priv->b0_len, &priv->b0_dma, GFP_KERNEL);

nit: I think this indentation would be more in keeping with normal practices:

	priv->b0_va = dma_alloc_coherent(&priv->pdev->dev, priv->b0_len,
					 &priv->b0_dma, GFP_KERNEL);

> +	if (!priv->b0_va)
> +		goto err_free_db;

The goto above will result in the function returning ret.
But ret is 0 here. Should it be set to a negative error value,
f.e. -ENOMEM?

Flagged by Smatch.

> +
> +	priv->tx_level = BDX_MAX_TX_LEVEL;
> +	priv->tx_update_mark = priv->tx_level - 1024;
> +	return 0;
> +err_free_db:
> +	bdx_tx_db_close(&priv->txdb);
> +err_free_txf:
> +	bdx_fifo_free(priv, &priv->txf_fifo0.m);
> +err_free_txd:
> +	bdx_fifo_free(priv, &priv->txd_fifo0.m);
> +	return ret;
> +}
> +
> +/**
> + * bdx_tx_space - Calculate the available space in the TX fifo.
> + *
> + * @priv - NIC private structure

nit: '@priv: NIC private structure'

> + * Return: available space in TX fifo in bytes
> + */

...

> +static int bdx_set_link_speed(struct bdx_priv *priv, u32 speed)
> +{
> +	int i;
> +	u32 val;
> +
> +	netdev_dbg(priv->ndev, "speed %d\n", speed);
> +
> +	switch (speed) {
> +	case SPEED_10000:
> +	case SPEED_5000:
> +	case SPEED_2500:
> +		netdev_dbg(priv->ndev, "link_speed %d\n", speed);
> +

There are a lot of magic numbers below.
Could these be converted into #defines with meaningful names?

> +		write_reg(priv, 0x1010, 0x217);	/*ETHSD.REFCLK_CONF  */
> +		write_reg(priv, 0x104c, 0x4c);	/*ETHSD.L0_RX_PCNT  */
> +		write_reg(priv, 0x1050, 0x4c);	/*ETHSD.L1_RX_PCNT  */
> +		write_reg(priv, 0x1054, 0x4c);	/*ETHSD.L2_RX_PCNT  */
> +		write_reg(priv, 0x1058, 0x4c);	/*ETHSD.L3_RX_PCNT  */
> +		write_reg(priv, 0x102c, 0x434);	/*ETHSD.L0_TX_PCNT  */
> +		write_reg(priv, 0x1030, 0x434);	/*ETHSD.L1_TX_PCNT  */
> +		write_reg(priv, 0x1034, 0x434);	/*ETHSD.L2_TX_PCNT  */
> +		write_reg(priv, 0x1038, 0x434);	/*ETHSD.L3_TX_PCNT  */
> +		write_reg(priv, 0x6300, 0x0400);	/*MAC.PCS_CTRL */

...

> +static int bdx_hw_reset(struct bdx_priv *priv)
> +{
> +	u32 val, i;
> +
> +	/* Reset sequences: read, write 1, read, write 0 */
> +	val = read_reg(priv, REG_CLKPLL);
> +	write_reg(priv, REG_CLKPLL, (val | CLKPLL_SFTRST) + 0x8);
> +	udelay(50);

Checkpatch recommends using usleep_range() here
after consulting with Documentation/timers/timers-howto.rst.
TBH, I'm unsure of the merit of this advice.

> +	val = read_reg(priv, REG_CLKPLL);
> +	write_reg(priv, REG_CLKPLL, val & ~CLKPLL_SFTRST);
> +
> +	/* Check that the PLLs are locked and reset ended */
> +	for (i = 0; i < 70; i++, mdelay(10)) {
> +		if ((read_reg(priv, REG_CLKPLL) & CLKPLL_LKD) == CLKPLL_LKD) {
> +			udelay(50);

Ditto.

> +			/* Do any PCI-E read transaction */
> +			read_reg(priv, REG_RXD_CFG0_0);
> +			return 0;
> +		}
> +	}
> +	return 1;
> +}
> +
> +static int bdx_sw_reset(struct bdx_priv *priv)

nit: This function always returns zero, and the caller ignores the
     return value. It's return type could be void.

> +{
> +	int i;
> +
> +	/* 1. load MAC (obsolete) */
> +	/* 2. disable Rx (and Tx) */
> +	write_reg(priv, REG_GMAC_RXF_A, 0);
> +	mdelay(100);
> +	/* 3. Disable port */
> +	write_reg(priv, REG_DIS_PORT, 1);
> +	/* 4. Disable queue */
> +	write_reg(priv, REG_DIS_QU, 1);
> +	/* 5. Wait until hw is disabled */
> +	for (i = 0; i < 50; i++) {
> +		if (read_reg(priv, REG_RST_PORT) & 1)
> +			break;
> +		mdelay(10);
> +	}
> +	if (i == 50) {
> +		netdev_err(priv->ndev, "%s SW reset timeout. continuing anyway\n",
> +			   priv->ndev->name);
> +	}
> +	/* 6. Disable interrupts */
> +	write_reg(priv, REG_RDINTCM0, 0);
> +	write_reg(priv, REG_TDINTCM0, 0);
> +	write_reg(priv, REG_IMR, 0);
> +	read_reg(priv, REG_ISR);
> +
> +	/* 7. Reset queue */
> +	write_reg(priv, REG_RST_QU, 1);
> +	/* 8. Reset port */
> +	write_reg(priv, REG_RST_PORT, 1);
> +	/* 9. Zero all read and write pointers */
> +	for (i = REG_TXD_WPTR_0; i <= REG_TXF_RPTR_3; i += 0x10)
> +		write_reg(priv, i, 0);
> +	/* 10. Unset port disable */
> +	write_reg(priv, REG_DIS_PORT, 0);
> +	/* 11. Unset queue disable */
> +	write_reg(priv, REG_DIS_QU, 0);
> +	/* 12. Unset queue reset */
> +	write_reg(priv, REG_RST_QU, 0);
> +	/* 13. Unset port reset */
> +	write_reg(priv, REG_RST_PORT, 0);
> +	/* 14. Enable Rx */
> +	/* Skipped. will be done later */
> +	return 0;
> +}

...

> +static void bdx_setmulti(struct net_device *ndev)
> +{
> +	struct bdx_priv *priv = netdev_priv(ndev);
> +
> +	u32 rxf_val =
> +	    GMAC_RX_FILTER_AM | GMAC_RX_FILTER_AB | GMAC_RX_FILTER_OSEN |
> +	    GMAC_RX_FILTER_TXFC;
> +	int i;
> +
> +	/* IMF - imperfect (hash) rx multicast filter */
> +	/* PMF - perfect rx multicast filter */
> +
> +	/* FIXME: RXE(OFF) */

Is there a plan to fix this, and the TBD below?

> +	if (ndev->flags & IFF_PROMISC) {
> +		rxf_val |= GMAC_RX_FILTER_PRM;
> +	} else if (ndev->flags & IFF_ALLMULTI) {
> +		/* set IMF to accept all multicast frames */
> +		for (i = 0; i < MAC_MCST_HASH_NUM; i++)
> +			write_reg(priv, REG_RX_MCST_HASH0 + i * 4, ~0);
> +	} else if (netdev_mc_count(ndev)) {
> +		u8 hash;
> +		struct netdev_hw_addr *mclist;
> +		u32 reg, val;
> +
> +		/* Set IMF to deny all multicast frames */
> +		for (i = 0; i < MAC_MCST_HASH_NUM; i++)
> +			write_reg(priv, REG_RX_MCST_HASH0 + i * 4, 0);
> +
> +		/* Set PMF to deny all multicast frames */
> +		for (i = 0; i < MAC_MCST_NUM; i++) {
> +			write_reg(priv, REG_RX_MAC_MCST0 + i * 8, 0);
> +			write_reg(priv, REG_RX_MAC_MCST1 + i * 8, 0);
> +		}
> +		/* Use PMF to accept first MAC_MCST_NUM (15) addresses */
> +
> +		/* TBD: Sort the addresses and write them in ascending
> +		 * order into RX_MAC_MCST regs. we skip this phase now
> +		 * and accept ALL multicast frames through IMF. Accept
> +		 * the rest of addresses throw IMF.
> +		 */
> +		netdev_for_each_mc_addr(mclist, ndev) {
> +			hash = 0;
> +			for (i = 0; i < ETH_ALEN; i++)
> +				hash ^= mclist->addr[i];
> +
> +			reg = REG_RX_MCST_HASH0 + ((hash >> 5) << 2);
> +			val = read_reg(priv, reg);
> +			val |= (1 << (hash % 32));
> +			write_reg(priv, reg, val);
> +		}
> +	} else {
> +		rxf_val |= GMAC_RX_FILTER_AB;
> +	}
> +	write_reg(priv, REG_GMAC_RXF_A, rxf_val);
> +	/* Enable RX */
> +	/* FIXME: RXE(ON) */
> +}

...

> diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h

...

> +#if BITS_PER_LONG == 64
> +#define H32_64(x) ((u32)((u64)(x) >> 32))
> +#define L32_64(x) ((u32)((u64)(x) & 0xffffffff))
> +#elif BITS_PER_LONG == 32
> +#define H32_64(x) 0
> +#define L32_64(x) ((u32)(x))
> +#else /* BITS_PER_LONG == ?? */
> +#error BITS_PER_LONG is undefined. Must be 64 or 32
> +#endif /* BITS_PER_LONG */

I am curious to know why it is valid to mask off the upper 64 bits
on systems with 32 bit longs. As far as I see this is used
in conjunction for supplying DMA addresses to the NIC.
But it's not obvious how that relates to the length
of longs on the host.

Probably I'm missing something very obvious here.
But if not, my follow-up would be to suggest using
upper_32_bits() and lower_32_bits().

> +
> +#define BDX_TXF_DESC_SZ 16
> +#define BDX_MAX_TX_LEVEL (priv->txd_fifo0.m.memsz - 16)
> +#define BDX_MIN_TX_LEVEL 256
> +#define BDX_NO_UPD_PACKETS 40
> +#define BDX_MAX_MTU BIT(14)
> +
> +#define PCK_TH_MULT 128
> +#define INT_COAL_MULT 2
> +
> +#define BITS_MASK(nbits) ((1 << (nbits)) - 1)

> +#define GET_BITS_SHIFT(x, nbits, nshift) (((x) >> (nshift)) & BITS_MASK(nbits))
> +#define BITS_SHIFT_MASK(nbits, nshift) (BITS_MASK(nbits) << (nshift))
> +#define BITS_SHIFT_VAL(x, nbits, nshift) (((x) & BITS_MASK(nbits)) << (nshift))
> +#define BITS_SHIFT_CLEAR(x, nbits, nshift) \
> +	((x) & (~BITS_SHIFT_MASK(nbits, (nshift))))
> +
> +#define GET_INT_COAL(x) GET_BITS_SHIFT(x, 15, 0)
> +#define GET_INT_COAL_RC(x) GET_BITS_SHIFT(x, 1, 15)
> +#define GET_RXF_TH(x) GET_BITS_SHIFT(x, 4, 16)
> +#define GET_PCK_TH(x) GET_BITS_SHIFT(x, 4, 20)

It feels like using of GENMASK and FIELD_GET is appropriate here.

> +
> +#define INT_REG_VAL(coal, coal_rc, rxf_th, pck_th) \
> +	((coal) | ((coal_rc) << 15) | ((rxf_th) << 16) | ((pck_th) << 20))

This looks like a candidate for GENMASK and FILED_PREP.

> +#define MAX_PBL (19)
> +/* PBL describes each virtual buffer to be transmitted from the host. */
> +struct pbl {
> +	u32 pa_lo;
> +	u32 pa_hi;
> +	u32 len;
> +};
> +
> +/* First word for TXD descriptor. It means: type = 3 for regular Tx packet,
> + * hw_csum = 7 for IP+UDP+TCP HW checksums.
> + */
> +#define TXD_W1_VAL(bc, checksum, vtag, lgsnd, vlan_id)               \
> +	((bc) | ((checksum) << 5) | ((vtag) << 8) | ((lgsnd) << 9) | \
> +	 (0x30000) | ((vlan_id & 0x0fff) << 20) |                    \
> +	 (((vlan_id >> 13) & 7) << 13))

Likewise, here.

Also, it would be nice to use a #define for 0x3000
(or 0x3 used with FIELD_PREP with a mask of 0xffff).

> +
> +struct txd_desc {
> +	u32 txd_val1;
> +	u16 mss;
> +	u16 length;
> +	u32 va_lo;
> +	u32 va_hi;
> +	struct pbl pbl[0]; /* Fragments */

I think it is more appropriate to use a flex array here.

	struct pbl pbl[]; /* Fragments */

Flagged by gcc-13 W=1 allmodconfig build (on x86_64).
Please make sure each patch does not introduce new warnings
for such builds.

> +} __packed;
> +
> +struct txf_desc {
> +	u32 status;
> +	u32 va_lo; /* VAdr[31:0] */
> +	u32 va_hi; /* VAdr[63:32] */
> +	u32 pad;
> +} __packed;
> +
> +/* 32 bit kernels use 16 bits for page_offset. Do not increase
> + * LUXOR__MAX_PAGE_SIZE beyind 64K!

nit: beyond

> + */
> +#if BITS_PER_LONG > 32
> +#define LUXOR__MAX_PAGE_SIZE 0x40000
> +#else
> +#define LUXOR__MAX_PAGE_SIZE 0x10000
> +#endif

...

