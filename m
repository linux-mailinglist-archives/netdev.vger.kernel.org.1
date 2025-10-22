Return-Path: <netdev+bounces-231618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6F8BFB905
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33153A633F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F292F1FE6;
	Wed, 22 Oct 2025 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b0XYqmwL"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3761911CA9
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131570; cv=none; b=nTEjWibeIZEtSRDHLNGv1zYQoKlXljkCu4ixwaGCLgJu52YXegDzBM64U3BwlM/wrlXGU/JRkiyQbl8056SMHWooZMRU352g1RdBjvYZje1NeXCruOiij8uWQ6M//g1AAH81ebUOjM2sI1ZqKnrrsZ7/cbuSc3i86ogenVJXxWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131570; c=relaxed/simple;
	bh=GLEtLX0EX4+VTL8sESR8sSRLcZQykRROatGHBmjo3VE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=LgjfGKdB6Pm/jlbopYoWKR3zTI/WJWsmKqyrvRVUQC0Ogfsr20KJv+/ooF6KleN8jpm3frlenZfsUCCVq8n03BDMWzY+0fcxcdCWx3fUtkpZxBKNngC+TM+CZvmdEI0LXtPzS/I6aLgoHqxiF4tV8mexa/qCEK4U2vH9b1KVfzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b0XYqmwL; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761131558; h=Message-ID:Subject:Date:From:To;
	bh=vBeMUNRy2ZjWJszR5X5SVHD1+3XUIiL0O7zlL5CT89U=;
	b=b0XYqmwL1ZZqki3JKnG1dA/QKQys+x7lRCHqSzZ3829qESHlydk0y+Xpl4Vff4G7Bo/3LUkoF/zrnIxxFUvo+x1/PwJSz/hlVV5Y1jmUwe72rEFQn3vazE+Ml2LLIQTonoW85W7oqPVM/Tut791f/DHxOKHuV3e6tmU2tw8WVg4=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wqmh2tb_1761131556 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 19:12:36 +0800
Message-ID: <1761130643.6132474-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v7 4/5] eea: create/destroy rx,tx queues for netdevice open and stop
Date: Wed, 22 Oct 2025 18:57:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20251016110617.35767-1-xuanzhuo@linux.alibaba.com>
 <20251016110617.35767-5-xuanzhuo@linux.alibaba.com>
 <1b1697fe-2393-4959-b29e-59fb30e5ed49@redhat.com>
In-Reply-To: <1b1697fe-2393-4959-b29e-59fb30e5ed49@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 21 Oct 2025 10:28:49 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> On 10/16/25 1:06 PM, Xuan Zhuo wrote:
> > +/* resources: ring, buffers, irq */
> > +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_tmp *tmp)
> > +{
> > +	struct eea_net_tmp _tmp;
> > +	int err;
> > +
> > +	if (!tmp) {
> > +		enet_init_cfg(enet, &_tmp);
> > +		tmp = &_tmp;
>
> As suggested on v5, you should:
>
> 		enet_init_cfg(enet, &status);
> 		eea_reset_hw_resources(enet, &status);
>
> in the caller currently using a NULL argument.
>
> > +	}
> > +
> > +	if (!netif_running(enet->netdev)) {
> > +		enet->cfg = tmp->cfg;
> > +		return 0;
> > +	}
> > +
> > +	err = eea_alloc_rxtx_q_mem(tmp);
> > +	if (err) {
> > +		netdev_warn(enet->netdev,
> > +			    "eea reset: alloc q failed. stop reset. err %d\n",
> > +			    err);
> > +		return err;
> > +	}
> > +
> > +	eea_netdev_stop(enet->netdev);
> > +
> > +	enet_bind_new_q_and_cfg(enet, tmp);
> > +
> > +	err = eea_active_ring_and_irq(enet);
> > +	if (err) {
> > +		netdev_warn(enet->netdev,
> > +			    "eea reset: active new ring and irq failed. err %d\n",
> > +			    err);
> > +		return err;
> > +	}
> > +
> > +	err = eea_start_rxtx(enet->netdev);
> > +	if (err)
> > +		netdev_warn(enet->netdev,
> > +			    "eea reset: start queue failed. err %d\n", err);
>
> Following-up on v5 discussion, I see this function is used to handle
> scenario where the entire setup fails, but it's also used in the next
> patch to do set_ring/set_channel operations. The latter should leave the
> device in a working state even when the requested change is not
> possible, so this function should need gracefully failures at least on
> such invocations.

Yes. In this function, I allocate memory for the queues, release the previously
allocated resources, activate the new ring, and then start the RX and TX
operations for the network device. If the allocation fails, we can return
directly.

The functions `eea_active_ring_and_irq()` and `eea_start_rxtx()` only fail under
exceptional circumstances. If such a failure occurs, there is little else we can
do.

>
> [...]
> > +/* ha handle code */
> > +static void eea_ha_handle_work(struct work_struct *work)
> > +{
> > +	struct eea_pci_device *ep_dev;
> > +	struct eea_device *edev;
> > +	struct pci_dev *pci_dev;
> > +	u16 reset;
> > +
> > +	ep_dev = container_of(work, struct eea_pci_device, ha_handle_work);
> > +	edev = &ep_dev->edev;
> > +
> > +	/* Ha interrupt is triggered, so there maybe some error, we may need to
> > +	 * reset the device or reset some queues.
> > +	 */
> > +	dev_warn(&ep_dev->pci_dev->dev, "recv ha interrupt.\n");
> > +
> > +	if (ep_dev->reset_pos) {
> > +		pci_read_config_word(ep_dev->pci_dev, ep_dev->reset_pos,
> > +				     &reset);
> > +		/* clear bit */
> > +		pci_write_config_word(ep_dev->pci_dev, ep_dev->reset_pos,
> > +				      0xFFFF);
> > +
> > +		if (reset & EEA_PCI_CAP_RESET_FLAG) {
> > +			dev_warn(&ep_dev->pci_dev->dev,
> > +				 "recv device reset request.\n");
> > +
> > +			pci_dev = ep_dev->pci_dev;
> > +
> > +			/* The pci remove callback may hold this lock. If the
> > +			 * pci remove callback is called, then we can ignore the
> > +			 * ha interrupt.
> > +			 */
> > +			if (mutex_trylock(&edev->ha_lock)) {
> > +				edev->ha_reset = true;
> > +
> > +				__eea_pci_remove(pci_dev, false);
> > +				__eea_pci_probe(pci_dev, ep_dev);
> > +
> > +				edev->ha_reset = false;
> > +				mutex_unlock(&edev->ha_lock);
> > +			} else {
> > +				dev_warn(&ep_dev->pci_dev->dev,
> > +					 "ha device reset: trylock failed.\n");
> > +			}
> > +			return;
>
> Nesting here is quite high, possibly move the above in a separate helper.
>
> > @@ -45,9 +52,17 @@ u16 eea_pci_dev_id(struct eea_device *edev);
> >
> >  int eea_device_reset(struct eea_device *dev);
> >  void eea_device_ready(struct eea_device *dev);
> > +
>
> Minor nit: either do not introduce this whitespace, or add it together
> with the surronding chunk of code
>
> [...]> +static void meta_align_offset(struct eea_net_rx *rx, struct
> eea_rx_meta *meta)
> > +{
> > +	int h, b;
> > +
> > +	h = rx->headroom;
> > +	b = meta->offset + h;
> > +
> > +	b = ALIGN(b, 128);
>
> Out of sheer curiosity, why the above align?

The hardware engineer asked me.

> Possibly a comment and a
> macro instead of a magic number would be useful.
>
> > +static int eea_alloc_rx_hdr(struct eea_net_tmp *tmp, struct eea_net_rx *rx)
> > +{
> > +	struct page *hdr_page = NULL;
> > +	struct eea_rx_meta *meta;
> > +	u32 offset = 0, hdrsize;
> > +	struct device *dmadev;
> > +	dma_addr_t dma;
> > +	int i;
> > +
> > +	dmadev = tmp->edev->dma_dev;
> > +	hdrsize = tmp->cfg.split_hdr;
> > +
> > +	for (i = 0; i < tmp->cfg.rx_ring_depth; ++i) {
> > +		meta = &rx->meta[i];
> > +
> > +		if (!hdr_page || offset + hdrsize > PAGE_SIZE) {
> > +			hdr_page = dev_alloc_page();
> > +			if (!hdr_page)
> > +				return -ENOMEM;
>
> Why you are not using the page pool for the headers?

The HDR buffers are not accessing with other layers. I will copy the header into
the skb, and the buffers will be reused directly without being released.

So, allocating pages are sufficient and simpler.

>
> > +
> > +			dma = dma_map_page(dmadev, hdr_page, 0, PAGE_SIZE,
> > +					   DMA_FROM_DEVICE);
> > +
> > +			if (unlikely(dma_mapping_error(dmadev, dma))) {
> > +				put_page(hdr_page);
> > +				return -ENOMEM;
> > +			}
> > +
> > +			offset = 0;
> > +			meta->hdr_page = hdr_page;
> > +			meta->dma = dma;
> > +		}
> > +
> > +		meta->hdr_dma = dma + offset;
> > +		meta->hdr_addr = page_address(hdr_page) + offset;
> > +		offset += hdrsize;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void eea_rx_meta_dma_sync_for_cpu(struct eea_net_rx *rx,
> > +					 struct eea_rx_meta *meta, u32 len)
> > +{
> > +	dma_sync_single_for_cpu(rx->enet->edev->dma_dev,
> > +				meta->dma + meta->offset + meta->headroom,
> > +				len, DMA_FROM_DEVICE);
> > +}
> > +
> > +static int eea_harden_check_overflow(struct eea_rx_ctx *ctx,
> > +				     struct eea_net *enet)
> > +{
> > +	if (unlikely(ctx->len > ctx->meta->truesize - ctx->meta->room)) {
>
> Give the above, it looks like the hypervisor could corrupt the guest
> driver memory. If so, are any defensive, related, checks in the guests
> really effective?

This is merely a check; we do not consider this case here.


>
> > +		pr_debug("%s: rx error: len %u exceeds truesize %u\n",
> > +			 enet->netdev->name, ctx->len,
> > +			 ctx->meta->truesize - ctx->meta->room);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
>
>
>
> > +static bool eea_rx_post(struct eea_net *enet,
> > +			struct eea_net_rx *rx, gfp_t gfp)
>
> It looks like this function is always called with gfp == GFP_ATOMIC. If
> so, just drop the argument.
>
> [...]> +static int eea_tx_post_skb(struct eea_net_tx *tx, struct sk_buff
> *skb)
> > +{
> > +	const struct skb_shared_info *shinfo = skb_shinfo(skb);
> > +	u32 hlen = skb_headlen(skb);
> > +	struct eea_tx_meta *meta;
> > +	dma_addr_t addr;
> > +	int i, err;
> > +	u16 flags;
> > +
> > +	addr = dma_map_single(tx->dma_dev, skb->data, hlen, DMA_TO_DEVICE);
> > +	if (unlikely(dma_mapping_error(tx->dma_dev, addr)))
> > +		return -ENOMEM;
> > +
> > +	flags = skb->ip_summed == CHECKSUM_PARTIAL ? EEA_DESC_F_DO_CSUM : 0;
> > +
> > +	meta = eea_tx_desc_fill(tx, addr, hlen, !shinfo->nr_frags, skb, flags);
> > +
> > +	if (eea_fill_desc_from_skb(skb, tx->ering, meta->desc))
> > +		goto err;
> > +
> > +	for (i = 0; i < shinfo->nr_frags; i++) {
> > +		const skb_frag_t *frag = &shinfo->frags[i];
> > +		bool is_last = i == (shinfo->nr_frags - 1);
> > +
> > +		err = eea_tx_add_skb_frag(tx, meta, frag, is_last);
> > +		if (err)
> > +			goto err;
> > +	}
> > +
> > +	meta->num = shinfo->nr_frags + 1;
>
> It looks like there is no memory barrier after filling the descriptor
> and before commiting it. Whoever is processing this data could possibly
> observe inconsistent/corrupted descriptors.

In our design, the device only accesses descriptors indexed by the doorbell;
therefore, we believe that the barrier associated with MMIO operations is
sufficient.

Thanks


>
> /P
>

