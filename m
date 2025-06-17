Return-Path: <netdev+bounces-198788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587C4ADDD30
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 22:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E469717FC81
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 20:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8DA1AAA1E;
	Tue, 17 Jun 2025 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChjX9hAs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178F82EFD8D
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750192071; cv=none; b=rVPJscNcsZaWDNpQRdNLHQQ4U5tVYxLz+nIle4QqYF56+wHvuUB9vnTwmaam62U755yYAmYEWx7KNIVJldaS5aRJ0lbXle0uEKEO0p4fo3NBMIKaRtfggi0l782Ab7J1qGw6Eg0NkNyNe7b4EE51yPLg6uRNsGrOTTpR2sAS/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750192071; c=relaxed/simple;
	bh=y3oN5cWkKoeXRklWqhxri4Xo8B5Vi721r94UK9FuXRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATg4Xgj+Iv6SCium1LXf/owl3zhfIMNAkFH6HyEtDW4MORWbddDqYAJLZNhcAX5o5MmndaBljRwt3MULBCDRBnytO8Qc5ZhjTclhdONlFaAlFd2x8QlWKxei9V+cPsLxEJDgbQr4aXJsVXLC0az4HkTO3HxU7TsCQkD9DZJYpT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChjX9hAs; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31393526d0dso4337148a91.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750192069; x=1750796869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L0Zis8AI166cUWxZcWi/SCQInk6ZejRyeyjXVdjiLtk=;
        b=ChjX9hAssulAxHYvpfqJHyM654MIL8V9AMw3XblMn/G21zaCpOcIwsJ+EboF+pQsue
         rfey/0+INYnDF3mx4HuIxvTT10e4J++L2ZMS/bWag2sOQ/X+nmGTPYmOv6pJRhJzIeHI
         MuaqzowoW5fZnFx5EquJvlkLp/HbP2rh8NhBboQb+VaEYphqvOesJbGxor7QlKl9i4Mk
         ThUc9Jga54hqWZlLlzQKCqIELc67DqUpbVqD7SefbDAmF4t9T608YsWn1tIrvTy1TTaZ
         HdhvzZ4SxTVHSYPFW8Izj/AiuIXFtEcUkByRTK5mcE6RCpQtosdG53LyOesMX4XyMfKM
         7tfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750192069; x=1750796869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0Zis8AI166cUWxZcWi/SCQInk6ZejRyeyjXVdjiLtk=;
        b=D87ej8LY+0+keMD+jKopI8r5mVB7Nd4/cNXKGuBUhf8nZleSZrZtwa7+dWjMoKgyKk
         ajIbNYF8jiONTy86VpULQuOx41vKnK/pTxQBB0Op8tB5OTp1jZSm7oZ0S8vh1jLgeKV+
         JqlEO5aq+nnB7PAQ7E2QfOKaZIWaeyZzCtulhaW9t0I139733yLBQQQNiXOz9CJotCSe
         uUjPpWTKMvYDgjFvVIG08WOC9ANv6jOWh31+coLgkoG0+DaKb7MNZs5lmRyn1tR0s9h9
         zyPK7b6KkDqar5uXy2BRMb+G4AyH+pCYkuDUShanNbjnX81mundjEc+9aFTZZFwYChjw
         FJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsqn6rJbMMGG3QuJv6JEtjiCoMddguU+xYfS/kwEISkcD35pxjYIjCEaVohZDFu2LTRPyzbb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/MCZf6mOKtIJwmFuKjApNK8QJZDaYTSloXB4ZgYO3JujODuB6
	yar04/vdfB8RCeyHXW4l7G5FP2UJ7YWWxpsLcaSszr5bl8OnvIYZ7x8=
X-Gm-Gg: ASbGncsPs3GJ06xlbH0lJkiQ8G+1W4GbowPlnNkovABxEd0Uz5e7zRCmtgGeabxUi5H
	ay+Sui9Xse1qIm2KsZEPMNVTnccRx6mtWEb4+gOK0Cdfh3OkbDV1fLZoh1mzfaUw/h8yd2eOHnk
	AThYbPQqsQ5JX/7ZPY+pIEX8aMbrc1Jsku1Np890wymY4b4GxxDnzApKc6mNChspW7kzU2OnkvX
	nRj+Z3Tr+a2Fdv4X1SE0BexLvz/sQtqf/FqLmLKhQzrD5zJTGDhzfcR1N4Ip/ns8i7Q8tDfZzhw
	vHfff+UEY5pgOKbK0FEg+j95nDWBMN+jD1QRQfitshQGgSzHqTalcty9QM3aqYnNX6yf3n21hBe
	ymB0abSt76qW9FOIbGUjO8K4=
X-Google-Smtp-Source: AGHT+IGRYpjZ+ttHz/AZqk31jyLlyAMALeWq00IkD0blKZW4JflRIUssgDlNh5CjoT5zIRby68MvMg==
X-Received: by 2002:a17:90b:5242:b0:311:c1ec:7cfd with SMTP id 98e67ed59e1d1-313f1daf690mr21090668a91.26.1750192068770;
        Tue, 17 Jun 2025 13:27:48 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-313c19dcd05sm12533539a91.14.2025.06.17.13.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 13:27:48 -0700 (PDT)
Date: Tue, 17 Jun 2025 13:27:47 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	almasrymina@google.com, sdf@fomichev.me, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] eth: bnxt: add netmem TX support
Message-ID: <aFHPw5pjyA9yIepf@mini-arch>
References: <20250617094540.819832-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250617094540.819832-1-ap420073@gmail.com>

On 06/17, Taehee Yoo wrote:
> Use netmem_dma_*() helpers and declare netmem_tx to support netmem TX.
> By this change, all bnxt devices will support the netmem TX.
> 
> bnxt_start_xmit() uses memcpy() if a packet is too small. However,
> netmem packets are unreadable, so memcpy() is not allowed.
> It should check whether an skb is readable, and if an SKB is unreadable,
> it is processed by the normal transmission logic.
> 
> netmem TX can be tested with ncdevmem.c
> 
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 28 ++++++++++++++---------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 869580b6f70d..4de9dc123a18 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -477,6 +477,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct bnxt_tx_ring_info *txr;
>  	struct bnxt_sw_tx_bd *tx_buf;
>  	__le32 lflags = 0;
> +	skb_frag_t *frag;
>  
>  	i = skb_get_queue_mapping(skb);
>  	if (unlikely(i >= bp->tx_nr_rings)) {
> @@ -563,7 +564,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		lflags |= cpu_to_le32(TX_BD_FLAGS_NO_CRC);
>  
>  	if (free_size == bp->tx_ring_size && length <= bp->tx_push_thresh &&
> -	    !lflags) {
> +	    skb_frags_readable(skb) && !lflags) {
>  		struct tx_push_buffer *tx_push_buf = txr->tx_push;
>  		struct tx_push_bd *tx_push = &tx_push_buf->push_bd;
>  		struct tx_bd_ext *tx_push1 = &tx_push->txbd2;
> @@ -598,9 +599,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		skb_copy_from_linear_data(skb, pdata, len);
>  		pdata += len;
>  		for (j = 0; j < last_frag; j++) {
> -			skb_frag_t *frag = &skb_shinfo(skb)->frags[j];
>  			void *fptr;
>  
> +			frag = &skb_shinfo(skb)->frags[j];
>  			fptr = skb_frag_address_safe(frag);
>  			if (!fptr)
>  				goto normal_tx;
> @@ -708,8 +709,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  			cpu_to_le32(cfa_action << TX_BD_CFA_ACTION_SHIFT);
>  	txbd0 = txbd;
>  	for (i = 0; i < last_frag; i++) {
> -		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
> -
> +		frag = &skb_shinfo(skb)->frags[i];
>  		prod = NEXT_TX(prod);
>  		txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
>  
> @@ -721,7 +721,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  			goto tx_dma_error;
>  
>  		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
> -		dma_unmap_addr_set(tx_buf, mapping, mapping);
> +		netmem_dma_unmap_addr_set(skb_frag_netmem(frag), tx_buf,
> +					  mapping, mapping);
>  
>  		txbd->tx_bd_haddr = cpu_to_le64(mapping);
>  
> @@ -778,9 +779,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	for (i = 0; i < last_frag; i++) {
>  		prod = NEXT_TX(prod);
>  		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
> -		dma_unmap_page(&pdev->dev, dma_unmap_addr(tx_buf, mapping),
> -			       skb_frag_size(&skb_shinfo(skb)->frags[i]),
> -			       DMA_TO_DEVICE);
> +		frag = &skb_shinfo(skb)->frags[i];
> +		netmem_dma_unmap_page_attrs(&pdev->dev,
> +					    dma_unmap_addr(tx_buf, mapping),
> +					    skb_frag_size(frag),
> +					    DMA_TO_DEVICE, 0);
>  	}
>  
>  tx_free:
> @@ -3422,9 +3425,11 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
>  			skb_frag_t *frag = &skb_shinfo(skb)->frags[j];
>  
>  			tx_buf = &txr->tx_buf_ring[ring_idx];
> -			dma_unmap_page(&pdev->dev,
> -				       dma_unmap_addr(tx_buf, mapping),
> -				       skb_frag_size(frag), DMA_TO_DEVICE);
> +			netmem_dma_unmap_page_attrs(&pdev->dev,
> +						    dma_unmap_addr(tx_buf,
> +								   mapping),
> +						    skb_frag_size(frag),
> +						    DMA_TO_DEVICE, 0);
>  		}
>  		dev_kfree_skb(skb);
>  	}
> @@ -16713,6 +16718,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (BNXT_SUPPORTS_QUEUE_API(bp))
>  		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
>  	dev->request_ops_lock = true;
> +	dev->netmem_tx = true;
>  
>  	rc = register_netdev(dev);
>  	if (rc)

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Similar to what I had internally for testing. One thing to think about
here might be to put that netmem_tx=true under BNXT_SUPPORTS_QUEUE_API
conditional. This way both rx/tx will either be supported or not. But
since there is probably no real FW requirement for TX, should be good
as is.

