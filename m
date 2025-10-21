Return-Path: <netdev+bounces-231111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8938BF53A9
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B8218A7D19
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 08:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E944E2EC0B8;
	Tue, 21 Oct 2025 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ig1V57Zw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226492EDD62
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035337; cv=none; b=uKE+LAzdMliiBJGjpCXxv0mBJzRBDxJG5quvHouHnpvEf4e2LCJKE95diFzgOkKz99nNFOs7bYDraPCgQSCEkdG6rJjQZNU4yGg0HTIVtLGGah4pJ6iaS2zjXVig1O1ISzy2dmHX4AIyKqcZvMr4XsX1NkQXGbxIwTB8T9QrRM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035337; c=relaxed/simple;
	bh=Llb6Mu/Qzp3KAkvhKucDNfnZkdk23hyq8tqolEyL7TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVWzioEwBw8YprlMFm/1gQ97byefCMoFBaCqoRdrKbY6eYRwAi/t8h7rI4uAT0Mrq8wlVx5/9WI4A9v1XlamsONykX0g7InxKEfCDUT3B3pf7WIyhlU1Nbl2x1h98GblrWuCurIwo2btJQoMtSJlL/BUinEz2UGP3JsJqpRTyvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ig1V57Zw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761035335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMU6o4Jt+vodf4FtawGFzUrN+0OYiSFdWa4g70abTLI=;
	b=ig1V57Zw/ir2q56S0OBRCcj4VXzWCJVff0QLLQWI8hsDNq29y6VqXFRikzmmRKnD3Eu9Lc
	DQ7LudKASuJBmsJtZPra0njwsyGH1S5899Fa8XMIDkPu81jVT3KOa4IXpUplU8WxoJKh/R
	/73I5OjxRVisLO5zU7/lPaDtUVDZ0NQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-NM2I_EAXOcKGCFEMSx5LgQ-1; Tue, 21 Oct 2025 04:28:53 -0400
X-MC-Unique: NM2I_EAXOcKGCFEMSx5LgQ-1
X-Mimecast-MFC-AGG-ID: NM2I_EAXOcKGCFEMSx5LgQ_1761035333
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471125c8bc1so59077515e9.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 01:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035333; x=1761640133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMU6o4Jt+vodf4FtawGFzUrN+0OYiSFdWa4g70abTLI=;
        b=CYTcPu1yzmDPiZWutPstOC1TKN2A5NbqP71Ibq34w1LSjVasKpkHgyGkkVGF35Hni2
         7dvKq0I0B2tLc7KSC8ZWDVHMiHpmuTVDi3PVWUMheRAZfHE3dU8hZ5h6+aCeKAZEvsCT
         SB/uAhTQtlXLMWxm6pGvjkJbX512csLgiV7ko0mXb0fduCempV7pJV6F97jYiKJ0xR0a
         xQLzRn5cLRtvuTo142apiUvIFmQaqSqNAe0mctVwZj7Vo8dX2uUo3biwsUHG4zmLAyH5
         vU4FQAn8f8i7vBkSCsoSzDdPGfYnDhUtjC2DD5VqvKkME0k0HIEoAweDERLgukJ4/XDK
         bTSg==
X-Forwarded-Encrypted: i=1; AJvYcCXNr3XDFDOFXLH/21hcP5hX8ESVAXhjF+A+lCqppFiEHiJnYhagfK6Bs9HU7g5Ap7FT+7o1rXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gOM3AMY4AOrl/7J86y0Fo6oKEK38hRZw2Epo+uiuSoF6gIhi
	+0Z0Cdnai37+sUKWF5WJzCh/VfziLGj7XF/RpfDpWRYRf/6wtg1OO5Ewmdo3w3SdKoe/LVcuEbY
	pP8lo9IZYGxpKxn1L/XYO69wo/s+CatGBDavgjsiihU7KRMEu2rLqKslMGA==
X-Gm-Gg: ASbGncu82f09XZvXOnmS8zWOpnHxF5IzpX4jPCS4XNjJ19nKyeo0VdXqpl+RdB5tTF5
	1WeKvCP2FF0MnS+WJC+PF4M7PzWHqM8Goh84edoB70ioMtL966Yd1ZRHj4ER0pSNwPe//KhOmKp
	8Oqzk01uSTOjKhf+qJst2xFTERoU8f+HHWTAN/wlPuWwDQr23peO0OeFO/zn2w5PzSBFUTkOnpe
	PG7SmwLryimwQZ10Y+yx5x8WtbOv8/5n+xIA+nUvVJkyN5BQmfF75a2txffhB1zMgMdvzPZPwHA
	2+n317mlkJEL9Uy/mSifGwfzMQSJdLKem8kx3MKc5gudMUTH5DmwddlKEnbGD9wk4QR3VNNnYc/
	C1t0iYnTxFLloQkEuPU84xF+R2DPEf5NIcqvbKVF8zLhOnTA=
X-Received: by 2002:a05:600c:871a:b0:45d:d68c:2a36 with SMTP id 5b1f17b1804b1-471179168b9mr109668245e9.27.1761035332628;
        Tue, 21 Oct 2025 01:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo8XR8nuuLa6SGKoeaAQG9CDQCiyMecyUf1fc8YCtki5RtHjregaAKgLpQ8YPCdSNFsZEsSw==
X-Received: by 2002:a05:600c:871a:b0:45d:d68c:2a36 with SMTP id 5b1f17b1804b1-471179168b9mr109668075e9.27.1761035332153;
        Tue, 21 Oct 2025 01:28:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3b45sm19325468f8f.11.2025.10.21.01.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 01:28:51 -0700 (PDT)
Message-ID: <1b1697fe-2393-4959-b29e-59fb30e5ed49@redhat.com>
Date: Tue, 21 Oct 2025 10:28:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 4/5] eea: create/destroy rx,tx queues for
 netdevice open and stop
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20251016110617.35767-1-xuanzhuo@linux.alibaba.com>
 <20251016110617.35767-5-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251016110617.35767-5-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/25 1:06 PM, Xuan Zhuo wrote:
> +/* resources: ring, buffers, irq */
> +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_tmp *tmp)
> +{
> +	struct eea_net_tmp _tmp;
> +	int err;
> +
> +	if (!tmp) {
> +		enet_init_cfg(enet, &_tmp);
> +		tmp = &_tmp;

As suggested on v5, you should:

		enet_init_cfg(enet, &status);
		eea_reset_hw_resources(enet, &status);

in the caller currently using a NULL argument.

> +	}
> +
> +	if (!netif_running(enet->netdev)) {
> +		enet->cfg = tmp->cfg;
> +		return 0;
> +	}
> +
> +	err = eea_alloc_rxtx_q_mem(tmp);
> +	if (err) {
> +		netdev_warn(enet->netdev,
> +			    "eea reset: alloc q failed. stop reset. err %d\n",
> +			    err);
> +		return err;
> +	}
> +
> +	eea_netdev_stop(enet->netdev);
> +
> +	enet_bind_new_q_and_cfg(enet, tmp);
> +
> +	err = eea_active_ring_and_irq(enet);
> +	if (err) {
> +		netdev_warn(enet->netdev,
> +			    "eea reset: active new ring and irq failed. err %d\n",
> +			    err);
> +		return err;
> +	}
> +
> +	err = eea_start_rxtx(enet->netdev);
> +	if (err)
> +		netdev_warn(enet->netdev,
> +			    "eea reset: start queue failed. err %d\n", err);

Following-up on v5 discussion, I see this function is used to handle
scenario where the entire setup fails, but it's also used in the next
patch to do set_ring/set_channel operations. The latter should leave the
device in a working state even when the requested change is not
possible, so this function should need gracefully failures at least on
such invocations.

[...]
> +/* ha handle code */
> +static void eea_ha_handle_work(struct work_struct *work)
> +{
> +	struct eea_pci_device *ep_dev;
> +	struct eea_device *edev;
> +	struct pci_dev *pci_dev;
> +	u16 reset;
> +
> +	ep_dev = container_of(work, struct eea_pci_device, ha_handle_work);
> +	edev = &ep_dev->edev;
> +
> +	/* Ha interrupt is triggered, so there maybe some error, we may need to
> +	 * reset the device or reset some queues.
> +	 */
> +	dev_warn(&ep_dev->pci_dev->dev, "recv ha interrupt.\n");
> +
> +	if (ep_dev->reset_pos) {
> +		pci_read_config_word(ep_dev->pci_dev, ep_dev->reset_pos,
> +				     &reset);
> +		/* clear bit */
> +		pci_write_config_word(ep_dev->pci_dev, ep_dev->reset_pos,
> +				      0xFFFF);
> +
> +		if (reset & EEA_PCI_CAP_RESET_FLAG) {
> +			dev_warn(&ep_dev->pci_dev->dev,
> +				 "recv device reset request.\n");
> +
> +			pci_dev = ep_dev->pci_dev;
> +
> +			/* The pci remove callback may hold this lock. If the
> +			 * pci remove callback is called, then we can ignore the
> +			 * ha interrupt.
> +			 */
> +			if (mutex_trylock(&edev->ha_lock)) {
> +				edev->ha_reset = true;
> +
> +				__eea_pci_remove(pci_dev, false);
> +				__eea_pci_probe(pci_dev, ep_dev);
> +
> +				edev->ha_reset = false;
> +				mutex_unlock(&edev->ha_lock);
> +			} else {
> +				dev_warn(&ep_dev->pci_dev->dev,
> +					 "ha device reset: trylock failed.\n");
> +			}
> +			return;

Nesting here is quite high, possibly move the above in a separate helper.

> @@ -45,9 +52,17 @@ u16 eea_pci_dev_id(struct eea_device *edev);
>  
>  int eea_device_reset(struct eea_device *dev);
>  void eea_device_ready(struct eea_device *dev);
> +

Minor nit: either do not introduce this whitespace, or add it together
with the surronding chunk of code

[...]> +static void meta_align_offset(struct eea_net_rx *rx, struct
eea_rx_meta *meta)
> +{
> +	int h, b;
> +
> +	h = rx->headroom;
> +	b = meta->offset + h;
> +
> +	b = ALIGN(b, 128);

Out of sheer curiosity, why the above align? Possibly a comment and a
macro instead of a magic number would be useful.

> +static int eea_alloc_rx_hdr(struct eea_net_tmp *tmp, struct eea_net_rx *rx)
> +{
> +	struct page *hdr_page = NULL;
> +	struct eea_rx_meta *meta;
> +	u32 offset = 0, hdrsize;
> +	struct device *dmadev;
> +	dma_addr_t dma;
> +	int i;
> +
> +	dmadev = tmp->edev->dma_dev;
> +	hdrsize = tmp->cfg.split_hdr;
> +
> +	for (i = 0; i < tmp->cfg.rx_ring_depth; ++i) {
> +		meta = &rx->meta[i];
> +
> +		if (!hdr_page || offset + hdrsize > PAGE_SIZE) {
> +			hdr_page = dev_alloc_page();
> +			if (!hdr_page)
> +				return -ENOMEM;

Why you are not using the page pool for the headers?

> +
> +			dma = dma_map_page(dmadev, hdr_page, 0, PAGE_SIZE,
> +					   DMA_FROM_DEVICE);
> +
> +			if (unlikely(dma_mapping_error(dmadev, dma))) {
> +				put_page(hdr_page);
> +				return -ENOMEM;
> +			}
> +
> +			offset = 0;
> +			meta->hdr_page = hdr_page;
> +			meta->dma = dma;
> +		}
> +
> +		meta->hdr_dma = dma + offset;
> +		meta->hdr_addr = page_address(hdr_page) + offset;
> +		offset += hdrsize;
> +	}
> +
> +	return 0;
> +}
> +
> +static void eea_rx_meta_dma_sync_for_cpu(struct eea_net_rx *rx,
> +					 struct eea_rx_meta *meta, u32 len)
> +{
> +	dma_sync_single_for_cpu(rx->enet->edev->dma_dev,
> +				meta->dma + meta->offset + meta->headroom,
> +				len, DMA_FROM_DEVICE);
> +}
> +
> +static int eea_harden_check_overflow(struct eea_rx_ctx *ctx,
> +				     struct eea_net *enet)
> +{
> +	if (unlikely(ctx->len > ctx->meta->truesize - ctx->meta->room)) {

Give the above, it looks like the hypervisor could corrupt the guest
driver memory. If so, are any defensive, related, checks in the guests
really effective?

> +		pr_debug("%s: rx error: len %u exceeds truesize %u\n",
> +			 enet->netdev->name, ctx->len,
> +			 ctx->meta->truesize - ctx->meta->room);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}



> +static bool eea_rx_post(struct eea_net *enet,
> +			struct eea_net_rx *rx, gfp_t gfp)

It looks like this function is always called with gfp == GFP_ATOMIC. If
so, just drop the argument.

[...]> +static int eea_tx_post_skb(struct eea_net_tx *tx, struct sk_buff
*skb)
> +{
> +	const struct skb_shared_info *shinfo = skb_shinfo(skb);
> +	u32 hlen = skb_headlen(skb);
> +	struct eea_tx_meta *meta;
> +	dma_addr_t addr;
> +	int i, err;
> +	u16 flags;
> +
> +	addr = dma_map_single(tx->dma_dev, skb->data, hlen, DMA_TO_DEVICE);
> +	if (unlikely(dma_mapping_error(tx->dma_dev, addr)))
> +		return -ENOMEM;
> +
> +	flags = skb->ip_summed == CHECKSUM_PARTIAL ? EEA_DESC_F_DO_CSUM : 0;
> +
> +	meta = eea_tx_desc_fill(tx, addr, hlen, !shinfo->nr_frags, skb, flags);
> +
> +	if (eea_fill_desc_from_skb(skb, tx->ering, meta->desc))
> +		goto err;
> +
> +	for (i = 0; i < shinfo->nr_frags; i++) {
> +		const skb_frag_t *frag = &shinfo->frags[i];
> +		bool is_last = i == (shinfo->nr_frags - 1);
> +
> +		err = eea_tx_add_skb_frag(tx, meta, frag, is_last);
> +		if (err)
> +			goto err;
> +	}
> +
> +	meta->num = shinfo->nr_frags + 1;

It looks like there is no memory barrier after filling the descriptor
and before commiting it. Whoever is processing this data could possibly
observe inconsistent/corrupted descriptors.

/P


