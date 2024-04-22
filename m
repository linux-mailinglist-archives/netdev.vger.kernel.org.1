Return-Path: <netdev+bounces-89968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CD88AC596
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1171C213DA
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD19F482FF;
	Mon, 22 Apr 2024 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnwPlIZJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD09D48CDD
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770970; cv=none; b=eMmx2NsTJ4cGmqcXNXy1Hhaos1NgKOdOHRvB0kFKZnpS8EH/nSpo9aFw1zKu3CKWphZtXKmIsT9XtThcU+6dplD7JdL6UKucIrfEH269EgJD8SFP3Ir0p6C3m4Xmd4thYyKj4biAQUY5C77+qVfGWkktr/rjb1PIslxrmvLlYvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770970; c=relaxed/simple;
	bh=RpOISxBuJ63WcBb7EkPUe5loZSZ8yAMe3kiRT8wBYGM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WxPvxgKI/xZQESv+aV3qdTxCPFLU/MAMslOucghhak5s40mvJC7lBmrTOSDPixq2uJIFWHkI4AF3KVoce3gXQauvdMcvtisWuh9n83IxXqK7ymkzJMt5FHY25bBxiABnBLqcLICCwuwKKJhFdCQkUVBJy9r9BQjj3a7SFhDbzEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnwPlIZJ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ab48c1c007so1033840a91.2
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713770968; x=1714375768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o306ElyH8sYSCSJxMkuvWK/BoyXwmglcU+Z1C85Th3Q=;
        b=OnwPlIZJFMGLFirA2MOqAb4P3CVL/7BuXJ+5EZUo46hRBs6nEsG/A1xJQynNtFF+9Z
         rYXD0y65AIvB701V4UVaXQefvaJSURzLreBxfj6PwRdho0W32IM5tsKrV77Hjj5K5RA0
         fUcLQa1agQ2lCWqdOIYXdeS7fxmVJiaq5ZeEhTAMaXBShHrrkEdcPn/WlpPJx8tcRzgK
         Uxz1oFJD7zCydEpNUDt3Mr5zXCyNVEy9plY7behGWfUKW0MKjZV3cNRdyzqmHIlgy0co
         CfteynG441CALgnIQ6ynu0F+a0eh8o8qMY0c3KmDGZ8kjBQeocGx7Sh+Sx36XuX3skjH
         V3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713770968; x=1714375768;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o306ElyH8sYSCSJxMkuvWK/BoyXwmglcU+Z1C85Th3Q=;
        b=TziNJlwZq+UwwzfxBAFe3sX3qnNZQ5Rgf1L4nreYAq65RtgmwjI6RJE1D6mhF47n9l
         CvEwVQkxFclhUzQR3gj2M/WKA50dpDFDO5rZfkOlqO/YaFplrLuEzusndn/sB7VUNAXR
         i0SZ1rHm4fxhfiAL0pxDNJj1gQOjXVfmvbNlCt675Z8UpPQgDMay9Mjz4aO38R6mirso
         e/79056Pws9Jvy/KVjExoUduzb0CdQO7Z6vQR9nwuQblWVCx/vU/84o5f8/ajBdxHRRp
         Rss7T7nK/AyoHXANMZoPYrVA2Ell85t7nZLG7Zm+H8NAbckG7mhv7onKlXdHyJ6ZU/92
         kAig==
X-Forwarded-Encrypted: i=1; AJvYcCWgFJ+3bpQB4ix2QU7/ctgQeZ6ssHdTCTkvMP9TIQutjnMjJO7xnrijroRkvsjVRYSzWaZJsOVJ58V7uws0N3bHu+vCkSDn
X-Gm-Message-State: AOJu0Yzy4W3IzBN+kt2cK6wUgwRVAw1P2+PAHb73EtYyhhHffu//VQR1
	cJNM7+zb8XCKAyN7Tymtl2F6LGHqXIBjBF5WF5GIObLE/fC8GgGI
X-Google-Smtp-Source: AGHT+IHoJPoC0GKsSHwdjzl87Km8CyWkkzIe7q85qQ75tb8MarjJcFn9YbdOn7bPs+qEYJINlIvG2A==
X-Received: by 2002:a17:90a:b292:b0:29c:7487:43b8 with SMTP id c18-20020a17090ab29200b0029c748743b8mr8644999pjr.1.1713770967820;
        Mon, 22 Apr 2024 00:29:27 -0700 (PDT)
Received: from localhost (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id s19-20020a17090a881300b002a5d684a6a7sm6972911pjn.10.2024.04.22.00.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:29:27 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:29:13 +0900 (JST)
Message-Id: <20240422.162913.1504058338048849274.fujita.tomonori@gmail.com>
To: horms@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch
Subject: Re: [PATCH net-next v1 3/5] net: tn40xx: add basic Tx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240418172306.GH3975545@kernel.org>
References: <20240415104352.4685-1-fujita.tomonori@gmail.com>
	<20240415104352.4685-4-fujita.tomonori@gmail.com>
	<20240418172306.GH3975545@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 18 Apr 2024 18:23:06 +0100
Simon Horman <horms@kernel.org> wrote:

> On Mon, Apr 15, 2024 at 07:43:50PM +0900, FUJITA Tomonori wrote:
>> This patch adds device specific structures to initialize the hardware
>> with basic Tx handling. The original driver loads the embedded
>> firmware in the header file. This driver is implemented to use the
>> firmware APIs.
>> 
>> The Tx logic uses three major data structures; two ring buffers with
>> NIC and one database. One ring buffer is used to send information
>> about packets to be sent for NIC. The other is used to get information
>> from NIC about packet that are sent. The database is used to keep the
>> information about DMA mapping. After a packet is sent, the db is used
>> to free the resource used for the packet.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> Hi Fujita-san,
> 
> Some review from my side.

Thanks a lot!

>> +static int bdx_fifo_alloc(struct bdx_priv *priv, struct fifo *f, int fsz_type,
>> +			  u16 reg_cfg0, u16 reg_cfg1, u16 reg_rptr, u16 reg_wptr)
> 
> Please consider using a soft limit on line length of 80 characters
> in Networking code.

Sure, fixed.

>> +{
>> +	u16 memsz = FIFO_SIZE * (1 << fsz_type);
> 
> I'm not sure if fsz_type has a meaning here - perhaps it comes from the
> datasheet. But if not, perhaps 'order' would be a more intuitive
> name for this parameter. Similarly for the txd_size and txf_size
> fields of struct bdx_priv, the sz_type field of bdx_tx_db_init(),
> and possibly elsewhere.

I don't have the datasheet of this hardware (so I have to leave alone
many magic values from the original driver).

The driver writes this 'fsz_type' to a register so I guess this is
called something like fifo_size_type for the hardware. I'll rename if
you prefer.


>> +
>> +	memset(f, 0, sizeof(struct fifo));
>> +	/* 1K extra space is allocated at the end of the fifo to simplify
>> +	 * processing of descriptors that wraps around fifo's end.
>> +	 */
>> +	f->va = dma_alloc_coherent(&priv->pdev->dev,
>> +				   memsz + FIFO_EXTRA_SPACE, &f->da, GFP_KERNEL);
>> +	if (!f->va)
>> +		return -ENOMEM;
>> +
>> +	f->reg_cfg0 = reg_cfg0;
>> +	f->reg_cfg1 = reg_cfg1;
>> +	f->reg_rptr = reg_rptr;
>> +	f->reg_wptr = reg_wptr;
>> +	f->rptr = 0;
>> +	f->wptr = 0;
>> +	f->memsz = memsz;
>> +	f->size_mask = memsz - 1;
>> +	write_reg(priv, reg_cfg0, (u32)((f->da & TX_RX_CFG0_BASE) | fsz_type));
> 
> For consistency should this be use H32_64()?:
> 
> 		H32_64((f->da & TX_RX_CFG0_BASE) | fsz_type)

L32_64() if we use here?

The driver splits 64 bits value (f->da) and writes them to reg_cfg0
and reg_cfg1?

>> +	write_reg(priv, reg_cfg1, H32_64(f->da));
>> +	return 0;
>> +}

(snip)

>> +static inline int bdx_tx_db_size(struct txdb *db)
>> +{
>> +	int taken = db->wptr - db->rptr;
>> +
>> +	if (taken < 0)
>> +		taken = db->size + 1 + taken;	/* (size + 1) equals memsz */
>> +	return db->size - taken;
>> +}
> 
> bdx_tx_db_size seems to be unused. Perhaps it can be removed.
> 
> Flagged by W=1 build with clang-18.

My bad, removed.

> ...
> 
>> +/* Sizes of tx desc (including padding if needed) as function of the SKB's
>> + * frag number
>> + */
>> +static struct {
>> +	u16 bytes;
>> +	u16 qwords;		/* qword = 64 bit */
>> +} txd_sizes[MAX_PBL];
>> +
>> +inline void bdx_set_pbl(struct pbl *pbl, dma_addr_t dma, int len)
>> +{
>> +	pbl->len = cpu_to_le32(len);
>> +	pbl->pa_lo = cpu_to_le32(L32_64(dma));
>> +	pbl->pa_hi = cpu_to_le32(H32_64(dma));
>> +}
> 
> The type of the pa_lo and pa_high fields of struct pbl are both u32.
> But here they are assigned little-endian values. This doesn't seem right
> (I expect the types of the fields should be changed to __le32).

Right, fixed. I use __le* for all the members in txd_desc and pbl.

> This was flagged by Sparse, along with a number of other problems
> (which I didn't look into). Please ensure that patches do
> not introduce new Sparse warnings.

Sorry, I'll try.

> ...
> 
>> +/**
>> + * txdb_map_skb - create and store DMA mappings for skb's data blocks
> 
> nit: bdx_tx_map_skb
> 
> Flagged by ./scripts/kernel-doc -Wall -none

Oops, fixed.

>> + * @priv: NIC private structure
>> + * @skb: socket buffer to map
>> + * @txdd: pointer to tx descriptor to be updated
>> + * @pkt_len: pointer to unsigned long value
>> + *
>> + * This function creates DMA mappings for skb's data blocks and writes them to
>> + * PBL of a new tx descriptor. It also stores them in the tx db, so they could
>> + * be unmapped after the data has been sent. It is the responsibility of the
>> + * caller to make sure that there is enough space in the txdb. The last
>> + * element holds a pointer to skb itself and is marked with a zero length.
>> + *
>> + * Return: 0 on success and negative value on error.
>> + */
>> +static inline int bdx_tx_map_skb(struct bdx_priv *priv, struct sk_buff *skb,
>> +				 struct txd_desc *txdd, unsigned int *pkt_len)
>> +{
>> +	dma_addr_t dma;
>> +	int i, len, err;
>> +	struct txdb *db = &priv->txdb;
>> +	struct pbl *pbl = &txdd->pbl[0];
>> +	int nr_frags = skb_shinfo(skb)->nr_frags;
>> +	unsigned int size;
>> +	struct mapping_info info[MAX_PBL];
> 
> nit: Please arrange local variables in new Networking code in reverse
>      xmas tree order - longest line to shortest.
> 
>      This tool is your friend: https://github.com/ecree-solarflare/xmastree

Fixed all the places.

>> +
>> +	netdev_dbg(priv->ndev, "TX skb %p skbLen %d dataLen %d frags %d\n", skb,
>> +		   skb->len, skb->data_len, nr_frags);
>> +	if (nr_frags > MAX_PBL - 1) {
>> +		err = skb_linearize(skb);
>> +		if (err)
>> +			return -1;
>> +		nr_frags = skb_shinfo(skb)->nr_frags;
>> +	}
>> +	/* initial skb */
>> +	len = skb->len - skb->data_len;
>> +	dma = dma_map_single(&priv->pdev->dev, skb->data, len,
>> +			     DMA_TO_DEVICE);
>> +	if (dma_mapping_error(&priv->pdev->dev, dma))
>> +		return -1;
> 
> As I believe Andrew mentioned elsewhere, it's best
> to use standard error values. Perhaps here:
> 
> 	ret = dma_mapping_error(...);
> 	if (ret)
> 		return ret;

Fixed.

>> +
>> +	bdx_set_txdb(db, dma, len);
>> +	bdx_set_pbl(pbl++, db->wptr->addr.dma, db->wptr->len);
>> +	*pkt_len = db->wptr->len;
>> +
>> +	for (i = 0; i < nr_frags; i++) {
>> +		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
>> +
>> +		size = skb_frag_size(frag);
>> +		dma = skb_frag_dma_map(&priv->pdev->dev, frag, 0,
>> +				       size, DMA_TO_DEVICE);
>> +
>> +		if (dma_mapping_error(&priv->pdev->dev, dma))
>> +			goto mapping_error;
>> +		info[i].dma = dma;
>> +		info[i].size = size;
>> +	}
>> +
>> +	for (i = 0; i < nr_frags; i++) {
>> +		bdx_tx_db_inc_wptr(db);
>> +		bdx_set_txdb(db, info[i].dma, info[i].size);
>> +		bdx_set_pbl(pbl++, db->wptr->addr.dma, db->wptr->len);
>> +		*pkt_len += db->wptr->len;
>> +	}
>> +
>> +	/* SHORT_PKT_FIX */
>> +	if (skb->len < SHORT_PACKET_SIZE)
>> +		++nr_frags;
>> +
>> +	/* Add skb clean up info. */
>> +	bdx_tx_db_inc_wptr(db);
>> +	db->wptr->len = -txd_sizes[nr_frags].bytes;
>> +	db->wptr->addr.skb = skb;
>> +	bdx_tx_db_inc_wptr(db);
>> +
>> +	return 0;
>> + mapping_error:
>> +	dma_unmap_page(&priv->pdev->dev, db->wptr->addr.dma, db->wptr->len, DMA_TO_DEVICE);
>> +	for (; i > 0; i--)
>> +		dma_unmap_page(&priv->pdev->dev, info[i - 1].dma, info[i - 1].size, DMA_TO_DEVICE);
>> +	return -1;
> 
> And here:
> 
> 	return -ENOMEM;

Fixed.

>> +static int create_tx_ring(struct bdx_priv *priv)
>> +{
>> +	int ret;
>> +
>> +	ret = bdx_fifo_alloc(priv, &priv->txd_fifo0.m, priv->txd_size,
>> +			     REG_TXD_CFG0_0, REG_TXD_CFG1_0,
>> +			     REG_TXD_RPTR_0, REG_TXD_WPTR_0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = bdx_fifo_alloc(priv, &priv->txf_fifo0.m, priv->txf_size,
>> +			     REG_TXF_CFG0_0, REG_TXF_CFG1_0,
>> +			     REG_TXF_RPTR_0, REG_TXF_WPTR_0);
>> +	if (ret)
>> +		goto err_free_txd;
>> +
>> +	/* The TX db has to keep mappings for all packets sent (on
>> +	 * TxD) and not yet reclaimed (on TxF).
>> +	 */
>> +	ret = bdx_tx_db_init(&priv->txdb, max(priv->txd_size, priv->txf_size));
>> +	if (ret)
>> +		goto err_free_txf;
>> +
>> +	/* SHORT_PKT_FIX */
>> +	priv->b0_len = 64;
>> +	priv->b0_va =
>> +		dma_alloc_coherent(&priv->pdev->dev, priv->b0_len, &priv->b0_dma, GFP_KERNEL);
> 
> nit: I think this indentation would be more in keeping with normal practices:
> 
> 	priv->b0_va = dma_alloc_coherent(&priv->pdev->dev, priv->b0_len,
> 					 &priv->b0_dma, GFP_KERNEL);

Fixed.

>> +	if (!priv->b0_va)
>> +		goto err_free_db;
> 
> The goto above will result in the function returning ret.
> But ret is 0 here. Should it be set to a negative error value,
> f.e. -ENOMEM?
> 
> Flagged by Smatch.

Oops, fixed.

>> +
>> +	priv->tx_level = BDX_MAX_TX_LEVEL;
>> +	priv->tx_update_mark = priv->tx_level - 1024;
>> +	return 0;
>> +err_free_db:
>> +	bdx_tx_db_close(&priv->txdb);
>> +err_free_txf:
>> +	bdx_fifo_free(priv, &priv->txf_fifo0.m);
>> +err_free_txd:
>> +	bdx_fifo_free(priv, &priv->txd_fifo0.m);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * bdx_tx_space - Calculate the available space in the TX fifo.
>> + *
>> + * @priv - NIC private structure
> 
> nit: '@priv: NIC private structure'

Fixed.

>> + * Return: available space in TX fifo in bytes
>> + */
> 
> ...
> 
>> +static int bdx_set_link_speed(struct bdx_priv *priv, u32 speed)
>> +{
>> +	int i;
>> +	u32 val;
>> +
>> +	netdev_dbg(priv->ndev, "speed %d\n", speed);
>> +
>> +	switch (speed) {
>> +	case SPEED_10000:
>> +	case SPEED_5000:
>> +	case SPEED_2500:
>> +		netdev_dbg(priv->ndev, "link_speed %d\n", speed);
>> +
> 
> There are a lot of magic numbers below.
> Could these be converted into #defines with meaningful names?

Without the datasheet, I'm not sure what names are appropriate..

>> +		write_reg(priv, 0x1010, 0x217);	/*ETHSD.REFCLK_CONF  */
>> +		write_reg(priv, 0x104c, 0x4c);	/*ETHSD.L0_RX_PCNT  */
>> +		write_reg(priv, 0x1050, 0x4c);	/*ETHSD.L1_RX_PCNT  */
>> +		write_reg(priv, 0x1054, 0x4c);	/*ETHSD.L2_RX_PCNT  */
>> +		write_reg(priv, 0x1058, 0x4c);	/*ETHSD.L3_RX_PCNT  */
>> +		write_reg(priv, 0x102c, 0x434);	/*ETHSD.L0_TX_PCNT  */
>> +		write_reg(priv, 0x1030, 0x434);	/*ETHSD.L1_TX_PCNT  */
>> +		write_reg(priv, 0x1034, 0x434);	/*ETHSD.L2_TX_PCNT  */
>> +		write_reg(priv, 0x1038, 0x434);	/*ETHSD.L3_TX_PCNT  */
>> +		write_reg(priv, 0x6300, 0x0400);	/*MAC.PCS_CTRL */
> 
> ...
> 
>> +static int bdx_hw_reset(struct bdx_priv *priv)
>> +{
>> +	u32 val, i;
>> +
>> +	/* Reset sequences: read, write 1, read, write 0 */
>> +	val = read_reg(priv, REG_CLKPLL);
>> +	write_reg(priv, REG_CLKPLL, (val | CLKPLL_SFTRST) + 0x8);
>> +	udelay(50);
> 
> Checkpatch recommends using usleep_range() here
> after consulting with Documentation/timers/timers-howto.rst.
> TBH, I'm unsure of the merit of this advice.

Yeah, I run checkpatch but don't have the datascheet so I'm not sure
what range are appropriate.


>> +	val = read_reg(priv, REG_CLKPLL);
>> +	write_reg(priv, REG_CLKPLL, val & ~CLKPLL_SFTRST);
>> +
>> +	/* Check that the PLLs are locked and reset ended */
>> +	for (i = 0; i < 70; i++, mdelay(10)) {
>> +		if ((read_reg(priv, REG_CLKPLL) & CLKPLL_LKD) == CLKPLL_LKD) {
>> +			udelay(50);
> 
> Ditto.
> 
>> +			/* Do any PCI-E read transaction */
>> +			read_reg(priv, REG_RXD_CFG0_0);
>> +			return 0;
>> +		}
>> +	}
>> +	return 1;
>> +}
>> +
>> +static int bdx_sw_reset(struct bdx_priv *priv)
> 
> nit: This function always returns zero, and the caller ignores the
>      return value. It's return type could be void.

Fixed.

>> +static void bdx_setmulti(struct net_device *ndev)
>> +{
>> +	struct bdx_priv *priv = netdev_priv(ndev);
>> +
>> +	u32 rxf_val =
>> +	    GMAC_RX_FILTER_AM | GMAC_RX_FILTER_AB | GMAC_RX_FILTER_OSEN |
>> +	    GMAC_RX_FILTER_TXFC;
>> +	int i;
>> +
>> +	/* IMF - imperfect (hash) rx multicast filter */
>> +	/* PMF - perfect rx multicast filter */
>> +
>> +	/* FIXME: RXE(OFF) */
> 
> Is there a plan to fix this, and the TBD below?

I just left the original code comment alone. Not sure what I should do
here. better to remove completely?

>> diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
> 
> ...
> 
>> +#if BITS_PER_LONG == 64
>> +#define H32_64(x) ((u32)((u64)(x) >> 32))
>> +#define L32_64(x) ((u32)((u64)(x) & 0xffffffff))
>> +#elif BITS_PER_LONG == 32
>> +#define H32_64(x) 0
>> +#define L32_64(x) ((u32)(x))
>> +#else /* BITS_PER_LONG == ?? */
>> +#error BITS_PER_LONG is undefined. Must be 64 or 32
>> +#endif /* BITS_PER_LONG */
> 
> I am curious to know why it is valid to mask off the upper 64 bits
> on systems with 32 bit longs. As far as I see this is used
> in conjunction for supplying DMA addresses to the NIC.
> But it's not obvious how that relates to the length
> of longs on the host.

I suppose that the original driver tries to use the length of
dma_addr_t (CONFIG_ARCH_DMA_ADDR_T_64BIT?) here.

> Probably I'm missing something very obvious here.
> But if not, my follow-up would be to suggest using
> upper_32_bits() and lower_32_bits().

You prefer to remove ifdef 

#define H32_64(x) upper_32_bits(x)
#define L32_64(x) lower_32_bits(x)

?

or replace H32_64 and L32_64 with upper_32_bits and lower_32_bits
respectively?

>> +#define BDX_TXF_DESC_SZ 16
>> +#define BDX_MAX_TX_LEVEL (priv->txd_fifo0.m.memsz - 16)
>> +#define BDX_MIN_TX_LEVEL 256
>> +#define BDX_NO_UPD_PACKETS 40
>> +#define BDX_MAX_MTU BIT(14)
>> +
>> +#define PCK_TH_MULT 128
>> +#define INT_COAL_MULT 2
>> +
>> +#define BITS_MASK(nbits) ((1 << (nbits)) - 1)
> 
>> +#define GET_BITS_SHIFT(x, nbits, nshift) (((x) >> (nshift)) & BITS_MASK(nbits))
>> +#define BITS_SHIFT_MASK(nbits, nshift) (BITS_MASK(nbits) << (nshift))
>> +#define BITS_SHIFT_VAL(x, nbits, nshift) (((x) & BITS_MASK(nbits)) << (nshift))
>> +#define BITS_SHIFT_CLEAR(x, nbits, nshift) \
>> +	((x) & (~BITS_SHIFT_MASK(nbits, (nshift))))
>> +
>> +#define GET_INT_COAL(x) GET_BITS_SHIFT(x, 15, 0)
>> +#define GET_INT_COAL_RC(x) GET_BITS_SHIFT(x, 1, 15)
>> +#define GET_RXF_TH(x) GET_BITS_SHIFT(x, 4, 16)
>> +#define GET_PCK_TH(x) GET_BITS_SHIFT(x, 4, 20)
> 
> It feels like using of GENMASK and FIELD_GET is appropriate here.

Sure, I'll replace the above macros with GENMASK and FIELD_GET. 

>> +#define INT_REG_VAL(coal, coal_rc, rxf_th, pck_th) \
>> +	((coal) | ((coal_rc) << 15) | ((rxf_th) << 16) | ((pck_th) << 20))
> 
> This looks like a candidate for GENMASK and FILED_PREP.

like the following?

#define INT_REG_VAL(coal, coal_rc, rxf_th, pck_th)      \
	FIELD_PREP(GENMASK(14, 0), (coal)) |            \
	FIELD_PREP(GENMASK(15, 15), (coal_rc)) |        \
	FIELD_PREP(GENMASK(19, 16), (rxf_th)) |         \
	FIELD_PREP(GENMASK(31, 20), (pck_th))


>> +#define MAX_PBL (19)
>> +/* PBL describes each virtual buffer to be transmitted from the host. */
>> +struct pbl {
>> +	u32 pa_lo;
>> +	u32 pa_hi;
>> +	u32 len;
>> +};
>> +
>> +/* First word for TXD descriptor. It means: type = 3 for regular Tx packet,
>> + * hw_csum = 7 for IP+UDP+TCP HW checksums.
>> + */
>> +#define TXD_W1_VAL(bc, checksum, vtag, lgsnd, vlan_id)               \
>> +	((bc) | ((checksum) << 5) | ((vtag) << 8) | ((lgsnd) << 9) | \
>> +	 (0x30000) | ((vlan_id & 0x0fff) << 20) |                    \
>> +	 (((vlan_id >> 13) & 7) << 13))
> 
> Likewise, here.
> 
> Also, it would be nice to use a #define for 0x3000
> (or 0x3 used with FIELD_PREP with a mask of 0xffff).

Understood, I'll try.


>> +struct txd_desc {
>> +	u32 txd_val1;
>> +	u16 mss;
>> +	u16 length;
>> +	u32 va_lo;
>> +	u32 va_hi;
>> +	struct pbl pbl[0]; /* Fragments */
> 
> I think it is more appropriate to use a flex array here.
> 
> 	struct pbl pbl[]; /* Fragments */
> 
> Flagged by gcc-13 W=1 allmodconfig build (on x86_64).
> Please make sure each patch does not introduce new warnings
> for such builds.

Fixed. seems that gcc-12 doesn't complain. I'll set up and try gcc-13.


>> +} __packed;
>> +
>> +struct txf_desc {
>> +	u32 status;
>> +	u32 va_lo; /* VAdr[31:0] */
>> +	u32 va_hi; /* VAdr[63:32] */
>> +	u32 pad;
>> +} __packed;
>> +
>> +/* 32 bit kernels use 16 bits for page_offset. Do not increase
>> + * LUXOR__MAX_PAGE_SIZE beyind 64K!
> 
> nit: beyond

Oops, fixed.


Thanks a lot!

