Return-Path: <netdev+bounces-202126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5BAAEC5BE
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 10:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B78C7A47DD
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 08:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB11221F26;
	Sat, 28 Jun 2025 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y7O3ZS+k"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A043AA1;
	Sat, 28 Jun 2025 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751098449; cv=none; b=W4yutaXTM9WPgZmP8Dau0qxJXpyStkAEBBcCFSWmtaS7KRWmju1yPOl8RDJwNgY5s7U4xSGvwdHtMDWQ2mv8M+ISqzJtuyGmydg58n/IrxnltqMAbqyBxlfB1BnujivJVT7T5h/gonPxMl9XdVBbYg8r03YPFbDguh6mU16lnw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751098449; c=relaxed/simple;
	bh=SIQH7VRbD0Uzwp1VMHZwhtyTf8NgBvkSohUTtWyPLqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJpwtYuiaVX5xclwcUEEN5g9J7jjjzpu2Wi1Da10xbKpLItQ2bdLS0vkKwNyLKtVSUDOCvifWxYnARPaxZA6qBymk1U7B8Qn6dkCNfqmagg2R1M2gRPW0JRKdWebz6oY9QlAQVIPxsIeSJYuRYaZUB9RBaXDe4XsTSAEfl4ncEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y7O3ZS+k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CpQ5LeQKLn8DmQkgnLVtZRFeuVCA8DvcNVHpHbSb/zo=; b=Y7O3ZS+kX6ozjbiZFxL/E7Aiyb
	qhUaXUzRpe4wxEySlH4Pzl3f3E/nJNucCdluAS7TjBczAA5/tbO40+Jl3IAbaAb3NKhnzcFmpIh4M
	edGZyyZAQYvS3yr2fgMLBguNF2D8983l2oHX7k3zQm29+qffImlGIhpWrdjevUrWqM1A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uVQh5-00HDrs-JU; Sat, 28 Jun 2025 10:13:51 +0200
Date: Sat, 28 Jun 2025 10:13:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>,
	Frank Wunderlich <frank-w@public-files.de>,
	Eric Woudstra <ericwouds@gmail.com>, Elad Yifee <eladwf@gmail.com>,
	Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Sky Huang <skylake.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net/next 3/3] net: ethernet: mtk_eth_soc: use genpool
 allocator for SRAM
Message-ID: <f9bec387-1858-4c79-bb4b-60e744457c9f@lunn.ch>
References: <cover.1751072868.git.daniel@makrotopia.org>
 <566ca90fc59ad0d3aff8bc8dc22ebaf0544bce47.1751072868.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566ca90fc59ad0d3aff8bc8dc22ebaf0544bce47.1751072868.git.daniel@makrotopia.org>

> +static void *mtk_dma_ring_alloc(struct mtk_eth *eth, size_t size,
> +				dma_addr_t *dma_handle)
> +{
> +	void *dma_ring;
> +
> +	if (WARN_ON(mtk_use_legacy_sram(eth)))
> +		return -ENOMEM;
> +
> +	if (eth->sram_pool) {
> +		dma_ring = (void *)gen_pool_alloc(eth->sram_pool, size);
> +		if (!dma_ring)
> +			return dma_ring;
> +		*dma_handle = gen_pool_virt_to_phys(eth->sram_pool, (unsigned long)dma_ring);

I don't particularly like all the casting backwards and forwards
between unsigned long and void *. These two APIs are not really
compatible with each other. So any sort of wrapping is going to be
messy.

Maybe define a cookie union:

struct mtk_dma_cookie {
	union {
		unsigned long gen_pool;
		void *coherent;
	}
}

Only dma_handle appears to be used by the rest of the code, so only
the _alloc and _free need to know about the union.

	Andrew

