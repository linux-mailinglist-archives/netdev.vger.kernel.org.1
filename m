Return-Path: <netdev+bounces-182511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A84D0A88F4D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B638C17A8C8
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53271FF1B2;
	Mon, 14 Apr 2025 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a19FHhEP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B71FDA61
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744670839; cv=none; b=Jx/4FAZtK0HLTuR8T2wveB8y8S3HDvHBcAo0rjYI/SYbz9BMthBuhdHXm7qHF6vN2A5iggxM3l0VL+O36pqVQf/tJNUMpaxlmMpNNF+Zn6nuQTkaxZt7oy2rD7KTiJ3C73R7dkkwg0WBXkdNqr9klD4IjLMGO2idGZ53l8VG4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744670839; c=relaxed/simple;
	bh=J3lyhXSkfi4TP1V762iaGYiaEaH4Y0EalBfsL69MhO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmsjIaQHmqPH47ZPKX3KBXqU+4c0bbcZa3Cfs1Qu8Fk+tZujr8PAx2DcHeEuxQz5TNf8pzV+ssYuHEF0fKadc13uL6al1hzd1QjZbxKiTbRtzjYiA12wtOs/agCQHmxggny6VMzLSEaVW3OrXOGUYSci03ho4kQadeIrp4JgHXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a19FHhEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16912C4CEEC;
	Mon, 14 Apr 2025 22:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744670837;
	bh=J3lyhXSkfi4TP1V762iaGYiaEaH4Y0EalBfsL69MhO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a19FHhEPOqKdSO/FC16sJmlic8WkDz9lDiMr4XQbcTilVIgfZanfwHDpmOXAuka2Z
	 NG9ozQvltqXDdn1iWCwFY4YrlBQg6fz5C9mdK0PdPWD69q8JO9odOiXboi6ssFJEPL
	 9l8Wsm10xo0FZ5W98XuXnY54zVhaf2cnqNXpx1eX5FYu3m/xUNKJe6gvHTY9OpfTN/
	 9+2qzEAR0eqZAKoMhxiWApO5r3klgKOebXdBiDhkEpn2wMWKhIgNhMq9FImk45VU4k
	 lcEbzz4mu/xHb7UngvxrbXG1nASZizMqnlX9UPUI1AIzKn8Zf20Tw2Bv/b8LS5BnQh
	 qzwBS4pdWu6Lg==
Date: Mon, 14 Apr 2025 15:47:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 netdev@vger.kernel.org, dw@davidwei.uk, kuniyu@amazon.com, sdf@fomichev.me,
 ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 hongguang.gao@broadcom.com, Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH v2 net-next] eth: bnxt: add support rx side device
 memory TCP
Message-ID: <20250414154716.67412a8d@kernel.org>
In-Reply-To: <20250410074351.4155508-1-ap420073@gmail.com>
References: <20250410074351.4155508-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 07:43:51 +0000 Taehee Yoo wrote:
> @@ -1251,27 +1269,41 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
>  			    RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
>  
>  		cons_rx_buf = &rxr->rx_agg_ring[cons];
> -		skb_frag_fill_page_desc(frag, cons_rx_buf->page,
> -					cons_rx_buf->offset, frag_len);
> -		shinfo->nr_frags = i + 1;
> +		if (skb) {
> +			skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netmem,
> +					       cons_rx_buf->offset,
> +					       frag_len, BNXT_RX_PAGE_SIZE);

I thought BNXT_RX_PAGE_SIZE is the max page size supported by HW.
We currently only allocate order 0 pages/netmems, so the truesize
calculation should use PAGE_SIZE, AFAIU?

> +		} else {
> +			skb_frag_t *frag = &shinfo->frags[i];
> +
> +			skb_frag_fill_netmem_desc(frag, cons_rx_buf->netmem,
> +						  cons_rx_buf->offset,
> +						  frag_len);
> +			shinfo->nr_frags = i + 1;
> +		}
>  		__clear_bit(cons, rxr->rx_agg_bmap);
>  
> -		/* It is possible for bnxt_alloc_rx_page() to allocate
> +		/* It is possible for bnxt_alloc_rx_netmem() to allocate
>  		 * a sw_prod index that equals the cons index, so we
>  		 * need to clear the cons entry now.
>  		 */
> -		mapping = cons_rx_buf->mapping;
> -		page = cons_rx_buf->page;
> -		cons_rx_buf->page = NULL;
> +		netmem = cons_rx_buf->netmem;
> +		cons_rx_buf->netmem = 0;
>  
> -		if (xdp && page_is_pfmemalloc(page))
> +		if (xdp && netmem_is_pfmemalloc(netmem))
>  			xdp_buff_set_frag_pfmemalloc(xdp);
>  
> -		if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_ATOMIC) != 0) {
> +		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_ATOMIC) != 0) {
> +			if (skb) {
> +				skb->len -= frag_len;
> +				skb->data_len -= frag_len;
> +				skb->truesize -= BNXT_RX_PAGE_SIZE;

and here.

> +			}

> +bool dev_is_mp_channel(struct net_device *dev, int i)
> +{
> +	return !!dev->_rx[i].mp_params.mp_priv;
> +}
> +EXPORT_SYMBOL(dev_is_mp_channel);

Sorry for a late comment but since you only use this helper after
allocating the payload pool -- do you think we could make the helper
operate on a page pool rather than device? I mean something like:

bool page_pool_is_unreadable(pp)
{
	return !!pp->mp_ops;
}

? I could be wrong but I'm worried that we may migrate the mp
settings to dev->cfg at some point, and then this helper will 
be ambiguous (current vs pending settings).

The dev_is_mp_channel() -> page_pool_is_readable() refactor is up to
you, but I think the truesize needs to be fixed.
-- 
pw-bot: cr

