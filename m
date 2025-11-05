Return-Path: <netdev+bounces-235692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5E7C33C63
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 03:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821E33B4B56
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 02:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C00D7263B;
	Wed,  5 Nov 2025 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIvtc6Lq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2756514A8E
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309830; cv=none; b=HEIwC9LKZTk7//pLRJlEIIGS8mm/IKmh8VT8nLnF2EB/kLLafiJXEzS1npdfiMVzrPITRSYs6lP49pGNQiaEE4fHDLV/QzuoArJDQuO3JncT3Im3YPMt2cy14G6KnT925CyotQ/WZx04sbww2QObHGNigo10KsSvwxLyuR4XSnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309830; c=relaxed/simple;
	bh=bQOzSQvNbzdGQPklRvcil44cM6pFiQzeZeHosNNfvcc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRmZXPl5yRI3qbYAidcDkHlHSXcxm7SWc7sFN+0mT/Mlk2o/3iEurgQaOlmqH9qZGJzBIW5pF4PkcUgBKCUDYo/J/6H+gFH0otrmXYA2rwapR/8Ao1KHXlbccYDtH/BxImXkOmmGDovCyDQ81CSmBVt5EPezPB9V4nvIum3Fk1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIvtc6Lq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4DAC4CEF7;
	Wed,  5 Nov 2025 02:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762309829;
	bh=bQOzSQvNbzdGQPklRvcil44cM6pFiQzeZeHosNNfvcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nIvtc6LqIfLFYinQoIaHxlMUrq8wPRdx01P+TKN4gYUGSLW/63TYX+e1xwo52U44+
	 dfDNz5kEdgoKvfbPeDFsLGJfiVjvr4QXhnHgz0D/TWQ+CiCA+kf/OErQwYiwS+PL/w
	 ntLGWbf85n86vjKO6dfEwfO3Z6zVKuIrRPPLbxBh3jxjKrpc6N1UGes8yhdGA5FJjd
	 tP0CdqbnSXckVsOT1rN7WSEvcOLdm1eWAOfmFtx+2AdJVE0tGqIqZpjYlwSbsjzZZR
	 btMyNcbUdCJ0QCoPOvS5UMb3/k1ntcUOfO4CvPmXlLd8DUZWuHNDq1wnpjdXmQHhJf
	 EDFzEMuK4MICw==
Date: Tue, 4 Nov 2025 18:30:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, Xuegang Lu
 <xuegang.lu@airoha.com>
Subject: Re: [PATCH net-next 1/2] net: airoha: Add the capability to consume
 out-of-order DMA tx descriptors
Message-ID: <20251104183028.7412aba6@kernel.org>
In-Reply-To: <20251103-airoha-tx-linked-list-v1-1-baa07982cc30@kernel.org>
References: <20251103-airoha-tx-linked-list-v1-0-baa07982cc30@kernel.org>
	<20251103-airoha-tx-linked-list-v1-1-baa07982cc30@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 03 Nov 2025 11:27:55 +0100 Lorenzo Bianconi wrote:
> +		__list_del_entry(&e->list);
> +		list_add_tail(&e->list, &tx_list);

list_move_tail()

> +		e->skb = i ? NULL : skb;
> +		e->dma_addr = addr;
> +		e->dma_len = len;
> +
> +		e = list_first_entry(&q->tx_list, struct airoha_queue_entry,
> +				     list);
> +		index = e - q->entry;
>  
>  		val = FIELD_PREP(QDMA_DESC_LEN_MASK, len);
>  		if (i < nr_frags - 1)

> @@ -2029,10 +2020,14 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
>  	return NETDEV_TX_OK;
>  
>  error_unmap:
> -	for (i--; i >= 0; i--) {
> -		index = (q->head + i) % q->ndesc;
> -		dma_unmap_single(dev->dev.parent, q->entry[index].dma_addr,
> -				 q->entry[index].dma_len, DMA_TO_DEVICE);
> +	while (!list_empty(&tx_list)) {
> +		e = list_first_entry(&tx_list, struct airoha_queue_entry,
> +				     list);
> +		__list_del_entry(&e->list);
> +		dma_unmap_single(dev->dev.parent, e->dma_addr, e->dma_len,
> +				 DMA_TO_DEVICE);
> +		e->dma_addr = 0;
> +		list_add_tail(&e->list, &q->tx_list);

and here

