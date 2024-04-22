Return-Path: <netdev+bounces-90079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D21E8ACAFB
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 12:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0B51F20FDB
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE8C1509B3;
	Mon, 22 Apr 2024 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hq1ypL6L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F4415098A
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782330; cv=none; b=skxBhAJmK8cLnwsgPm74In7W1xxOmvHhRITcfvDQojNTy7bpsluIEZ0IzKpZEcVjl64gwztNgH8rXKTNtBX7WBSolcDwrvtqd98vTx+Z7AVA+OXljeks3hEXCqUqjRXeR5VPUC9jgN0c5bgW1iXQ5gtpCy03Z/OiLs3O27eRQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782330; c=relaxed/simple;
	bh=t7eZABX7alb5f6WrZvhkqzJfgirL388XD29ssTdM5bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cz9vmdMFJdjk9Q7nNjRXioWNYnZHjCojHMH7za9ULCsHKMZTqhA2bV/gMBuNDGHxowqm8QCnic4OiJuf/lL6p9YCyO/vIwiTcy/L85HIUHVtLwekJ3iwlNuOROR24b9fxyflYpkcCq1yBX+eUie7vHNxkJTHnO+3AD10Jf3kylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hq1ypL6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD4AC2BD11;
	Mon, 22 Apr 2024 10:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713782330;
	bh=t7eZABX7alb5f6WrZvhkqzJfgirL388XD29ssTdM5bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hq1ypL6LpLb/61FhzyGvJdS3aVP3QizUlj/iyxN2BTa94BjJC7s9CPy+zbQfR6Sgd
	 xrF0+ILbWRc06yoYozHfunZlc/VF9s//fcsq8KIPr7FpsCEutbPFDM4UEhjdZUohdZ
	 5eUAThHAISUkt6mtZRck6vpbIg9+fzBAzjKN+/9Wvu7Wvzk0Ld7R1OE50SkZ25Le5O
	 72as34BGA5wUzEQZq3UywyJzjsS3N3akMf/rrxjpWII3238KZr6C91a8nzPPeHeVUk
	 OjT172QuATOQpioNvQy7jhBU+FC+4TjxKP/sQdHelwgPSXCmgmr6Ngcs5egRRSsR2J
	 SI+zf/FUxS70A==
Date: Mon, 22 Apr 2024 11:38:46 +0100
From: Simon Horman <horms@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch
Subject: Re: [PATCH net-next v1 3/5] net: tn40xx: add basic Tx handling
Message-ID: <20240422103846.GB42092@kernel.org>
References: <20240415104352.4685-1-fujita.tomonori@gmail.com>
 <20240415104352.4685-4-fujita.tomonori@gmail.com>
 <20240418172306.GH3975545@kernel.org>
 <20240422.162913.1504058338048849274.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422.162913.1504058338048849274.fujita.tomonori@gmail.com>

On Mon, Apr 22, 2024 at 04:29:13PM +0900, FUJITA Tomonori wrote:
> Hi,
> 
> On Thu, 18 Apr 2024 18:23:06 +0100
> Simon Horman <horms@kernel.org> wrote:
> 
> > On Mon, Apr 15, 2024 at 07:43:50PM +0900, FUJITA Tomonori wrote:
> >> This patch adds device specific structures to initialize the hardware
> >> with basic Tx handling. The original driver loads the embedded
> >> firmware in the header file. This driver is implemented to use the
> >> firmware APIs.
> >> 
> >> The Tx logic uses three major data structures; two ring buffers with
> >> NIC and one database. One ring buffer is used to send information
> >> about packets to be sent for NIC. The other is used to get information
> >> from NIC about packet that are sent. The database is used to keep the
> >> information about DMA mapping. After a packet is sent, the db is used
> >> to free the resource used for the packet.
> >> 
> >> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > 
> > Hi Fujita-san,
> > 
> > Some review from my side.
> 
> Thanks a lot!

Likewise, thanks for addressing most of my concerns.

> >> +static int bdx_fifo_alloc(struct bdx_priv *priv, struct fifo *f, int fsz_type,
> >> +			  u16 reg_cfg0, u16 reg_cfg1, u16 reg_rptr, u16 reg_wptr)
> > 
> > Please consider using a soft limit on line length of 80 characters
> > in Networking code.
> 
> Sure, fixed.
> 
> >> +{
> >> +	u16 memsz = FIFO_SIZE * (1 << fsz_type);
> > 
> > I'm not sure if fsz_type has a meaning here - perhaps it comes from the
> > datasheet. But if not, perhaps 'order' would be a more intuitive
> > name for this parameter. Similarly for the txd_size and txf_size
> > fields of struct bdx_priv, the sz_type field of bdx_tx_db_init(),
> > and possibly elsewhere.
> 
> I don't have the datasheet of this hardware (so I have to leave alone
> many magic values from the original driver).
> 
> The driver writes this 'fsz_type' to a register so I guess this is
> called something like fifo_size_type for the hardware. I'll rename if
> you prefer.

No strong preference here.

> >> +
> >> +	memset(f, 0, sizeof(struct fifo));
> >> +	/* 1K extra space is allocated at the end of the fifo to simplify
> >> +	 * processing of descriptors that wraps around fifo's end.
> >> +	 */
> >> +	f->va = dma_alloc_coherent(&priv->pdev->dev,
> >> +				   memsz + FIFO_EXTRA_SPACE, &f->da, GFP_KERNEL);
> >> +	if (!f->va)
> >> +		return -ENOMEM;
> >> +
> >> +	f->reg_cfg0 = reg_cfg0;
> >> +	f->reg_cfg1 = reg_cfg1;
> >> +	f->reg_rptr = reg_rptr;
> >> +	f->reg_wptr = reg_wptr;
> >> +	f->rptr = 0;
> >> +	f->wptr = 0;
> >> +	f->memsz = memsz;
> >> +	f->size_mask = memsz - 1;
> >> +	write_reg(priv, reg_cfg0, (u32)((f->da & TX_RX_CFG0_BASE) | fsz_type));
> > 
> > For consistency should this be use H32_64()?:
> > 
> > 		H32_64((f->da & TX_RX_CFG0_BASE) | fsz_type)
> 
> L32_64() if we use here?
>
> The driver splits 64 bits value (f->da) and writes them to reg_cfg0
> and reg_cfg1?

Yes, my mistake. L32_64() seems appropriate here.

...

> > There are a lot of magic numbers below.
> > Could these be converted into #defines with meaningful names?
> 
> Without the datasheet, I'm not sure what names are appropriate..

Ok, understood.

> >> +		write_reg(priv, 0x1010, 0x217);	/*ETHSD.REFCLK_CONF  */
> >> +		write_reg(priv, 0x104c, 0x4c);	/*ETHSD.L0_RX_PCNT  */
> >> +		write_reg(priv, 0x1050, 0x4c);	/*ETHSD.L1_RX_PCNT  */
> >> +		write_reg(priv, 0x1054, 0x4c);	/*ETHSD.L2_RX_PCNT  */
> >> +		write_reg(priv, 0x1058, 0x4c);	/*ETHSD.L3_RX_PCNT  */
> >> +		write_reg(priv, 0x102c, 0x434);	/*ETHSD.L0_TX_PCNT  */
> >> +		write_reg(priv, 0x1030, 0x434);	/*ETHSD.L1_TX_PCNT  */
> >> +		write_reg(priv, 0x1034, 0x434);	/*ETHSD.L2_TX_PCNT  */
> >> +		write_reg(priv, 0x1038, 0x434);	/*ETHSD.L3_TX_PCNT  */
> >> +		write_reg(priv, 0x6300, 0x0400);	/*MAC.PCS_CTRL */
> > 
> > ...
> > 
> >> +static int bdx_hw_reset(struct bdx_priv *priv)
> >> +{
> >> +	u32 val, i;
> >> +
> >> +	/* Reset sequences: read, write 1, read, write 0 */
> >> +	val = read_reg(priv, REG_CLKPLL);
> >> +	write_reg(priv, REG_CLKPLL, (val | CLKPLL_SFTRST) + 0x8);
> >> +	udelay(50);
> > 
> > Checkpatch recommends using usleep_range() here
> > after consulting with Documentation/timers/timers-howto.rst.
> > TBH, I'm unsure of the merit of this advice.
> 
> Yeah, I run checkpatch but don't have the datascheet so I'm not sure
> what range are appropriate.

I'd guess that a range of 50 - 100 would be fine.
But I take your point about not having the datasheet,
so perhaps it is safest to just keep the udelay() for now.

> 
> 
> >> +	val = read_reg(priv, REG_CLKPLL);
> >> +	write_reg(priv, REG_CLKPLL, val & ~CLKPLL_SFTRST);
> >> +
> >> +	/* Check that the PLLs are locked and reset ended */
> >> +	for (i = 0; i < 70; i++, mdelay(10)) {
> >> +		if ((read_reg(priv, REG_CLKPLL) & CLKPLL_LKD) == CLKPLL_LKD) {
> >> +			udelay(50);
> > 
> > Ditto.
> > 
> >> +			/* Do any PCI-E read transaction */
> >> +			read_reg(priv, REG_RXD_CFG0_0);
> >> +			return 0;
> >> +		}
> >> +	}
> >> +	return 1;
> >> +}
> >> +
> >> +static int bdx_sw_reset(struct bdx_priv *priv)
> > 
> > nit: This function always returns zero, and the caller ignores the
> >      return value. It's return type could be void.
> 
> Fixed.
> 
> >> +static void bdx_setmulti(struct net_device *ndev)
> >> +{
> >> +	struct bdx_priv *priv = netdev_priv(ndev);
> >> +
> >> +	u32 rxf_val =
> >> +	    GMAC_RX_FILTER_AM | GMAC_RX_FILTER_AB | GMAC_RX_FILTER_OSEN |
> >> +	    GMAC_RX_FILTER_TXFC;
> >> +	int i;
> >> +
> >> +	/* IMF - imperfect (hash) rx multicast filter */
> >> +	/* PMF - perfect rx multicast filter */
> >> +
> >> +	/* FIXME: RXE(OFF) */
> > 
> > Is there a plan to fix this, and the TBD below?
> 
> I just left the original code comment alone. Not sure what I should do
> here. better to remove completely?

Usually it's best not to have such comments.
But if it's a carry-over from existing code,
then I suppose it is best to leave it as is.

> 
> >> diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
> > 
> > ...
> > 
> >> +#if BITS_PER_LONG == 64
> >> +#define H32_64(x) ((u32)((u64)(x) >> 32))
> >> +#define L32_64(x) ((u32)((u64)(x) & 0xffffffff))
> >> +#elif BITS_PER_LONG == 32
> >> +#define H32_64(x) 0
> >> +#define L32_64(x) ((u32)(x))
> >> +#else /* BITS_PER_LONG == ?? */
> >> +#error BITS_PER_LONG is undefined. Must be 64 or 32
> >> +#endif /* BITS_PER_LONG */
> > 
> > I am curious to know why it is valid to mask off the upper 64 bits
> > on systems with 32 bit longs. As far as I see this is used
> > in conjunction for supplying DMA addresses to the NIC.
> > But it's not obvious how that relates to the length
> > of longs on the host.
> 
> I suppose that the original driver tries to use the length of
> dma_addr_t (CONFIG_ARCH_DMA_ADDR_T_64BIT?) here.
> 
> > Probably I'm missing something very obvious here.
> > But if not, my follow-up would be to suggest using
> > upper_32_bits() and lower_32_bits().
> 
> You prefer to remove ifdef 
> 
> #define H32_64(x) upper_32_bits(x)
> #define L32_64(x) lower_32_bits(x)
> 
> ?
> 
> or replace H32_64 and L32_64 with upper_32_bits and lower_32_bits
> respectively?

I'd go with the last option if you think it is safe to do so.
But if you think it's a bit risky, perhaps it's best to keep
the code as is for now.

> >> +#define BDX_TXF_DESC_SZ 16
> >> +#define BDX_MAX_TX_LEVEL (priv->txd_fifo0.m.memsz - 16)
> >> +#define BDX_MIN_TX_LEVEL 256
> >> +#define BDX_NO_UPD_PACKETS 40
> >> +#define BDX_MAX_MTU BIT(14)
> >> +
> >> +#define PCK_TH_MULT 128
> >> +#define INT_COAL_MULT 2
> >> +
> >> +#define BITS_MASK(nbits) ((1 << (nbits)) - 1)
> > 
> >> +#define GET_BITS_SHIFT(x, nbits, nshift) (((x) >> (nshift)) & BITS_MASK(nbits))
> >> +#define BITS_SHIFT_MASK(nbits, nshift) (BITS_MASK(nbits) << (nshift))
> >> +#define BITS_SHIFT_VAL(x, nbits, nshift) (((x) & BITS_MASK(nbits)) << (nshift))
> >> +#define BITS_SHIFT_CLEAR(x, nbits, nshift) \
> >> +	((x) & (~BITS_SHIFT_MASK(nbits, (nshift))))
> >> +
> >> +#define GET_INT_COAL(x) GET_BITS_SHIFT(x, 15, 0)
> >> +#define GET_INT_COAL_RC(x) GET_BITS_SHIFT(x, 1, 15)
> >> +#define GET_RXF_TH(x) GET_BITS_SHIFT(x, 4, 16)
> >> +#define GET_PCK_TH(x) GET_BITS_SHIFT(x, 4, 20)
> > 
> > It feels like using of GENMASK and FIELD_GET is appropriate here.
> 
> Sure, I'll replace the above macros with GENMASK and FIELD_GET. 
> 
> >> +#define INT_REG_VAL(coal, coal_rc, rxf_th, pck_th) \
> >> +	((coal) | ((coal_rc) << 15) | ((rxf_th) << 16) | ((pck_th) << 20))
> > 
> > This looks like a candidate for GENMASK and FILED_PREP.
> 
> like the following?
> 
> #define INT_REG_VAL(coal, coal_rc, rxf_th, pck_th)      \
> 	FIELD_PREP(GENMASK(14, 0), (coal)) |            \
> 	FIELD_PREP(GENMASK(15, 15), (coal_rc)) |        \
> 	FIELD_PREP(GENMASK(19, 16), (rxf_th)) |         \
> 	FIELD_PREP(GENMASK(31, 20), (pck_th))

Yes, I think so.
I think you can use BIT(15) in place of GENMASK(15, 15).

...

