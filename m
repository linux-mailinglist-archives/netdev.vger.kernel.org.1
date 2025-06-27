Return-Path: <netdev+bounces-202031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5FCAEC0BE
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A95563F70
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444B31FC7E7;
	Fri, 27 Jun 2025 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7qYhb9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CED1C2FB;
	Fri, 27 Jun 2025 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055380; cv=none; b=fmKvuk3epD/dQ5tLC4gMvLTzq4HWC8HbuS6AZvpvSZIhvuBqzPwet+ufx2rUKe+DbR/6+fA2sZcogfCzmNaM/7zJvgFgAIuov+8mDSEBoLQ+xDcZwWJ1eOznepR/2ZeG+ynYeZ32X7HARWQwCqQWBlfJMDZKlTiqX1kLLtgMiVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055380; c=relaxed/simple;
	bh=fKapYQk7U8tZWifCrdrg51mbJpimAj9qgWpP9zGghR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klRZiB2qgLbr5EH6btYdOuur1VzipuxLM33WEEzU0pFFL3wNEu2L69EvuzGTg5JhdncG5Iw5KQmkVjv4jfZncR46jEaTLFB4R/VkgmQYPHQSyOku+MSvQWrMn1yZ1udEBvzB3IdkTbL6B/A4YXPzj3V2STdohCtlICTzHrGf3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7qYhb9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBD9C4CEE3;
	Fri, 27 Jun 2025 20:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751055380;
	bh=fKapYQk7U8tZWifCrdrg51mbJpimAj9qgWpP9zGghR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7qYhb9l+RHIFU6tLblAzp0DEkXHc4KVBJeDn68xpiPYbh8NHS3/Mu0PJiqKGHvOB
	 cPQpxv5gc97EZPlA3RQxEh/5zpETFjFgxbsfelhEX8v0ar2boTtM3oWf4O2E2M37CN
	 7+wFR5wjZJUN7rBpetuD+gQJ0Hh/a1cHJbUZ9/BeuEn8vszHOMe/tdQPGqin+72vIn
	 b7UxayTiTGaW1cxJt9Qtn8XHUFwvXCJQ/EEwiEc/Us6i+Ck0OxsaiI5/0x1txelg1E
	 5QbbXwZdf1NyE/eO+Nr7K43yiK6ovtUsvFlbuxiEEBlVtAzqxXWDbmEC5QZCU7EE1S
	 VlXVHs2oHA7Mg==
Date: Fri, 27 Jun 2025 21:16:15 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Jonathan Currier <dullfire@yahoo.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] nui: Fix dma_mapping_error() check
Message-ID: <20250627201615.GH1776@horms.kernel.org>
References: <20250627144823.250224-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627144823.250224-2-fourier.thomas@gmail.com>

On Fri, Jun 27, 2025 at 04:48:19PM +0200, Thomas Fourier wrote:
> dma_map_XXX() functions return as error values DMA_MAPPING_ERROR which
> is often ~0. The error value should be tested with dma_mapping_error().
> 
> Fixes: ec2deec1f352 ("niu: Fix to check for dma mapping errors.")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/net/ethernet/sun/niu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
> index ddca8fc7883e..11ff08373de4 100644
> --- a/drivers/net/ethernet/sun/niu.c
> +++ b/drivers/net/ethernet/sun/niu.c
> @@ -3336,7 +3336,7 @@ static int niu_rbr_add_page(struct niu *np, struct rx_ring_info *rp,
>  
>  	addr = np->ops->map_page(np->device, page, 0,
>  				 PAGE_SIZE, DMA_FROM_DEVICE);
> -	if (!addr) {
> +	if (dma_mapping_error(np->device, addr)) {
>  		__free_page(page);
>  		return -ENOMEM;
>  	}

Hi Thomas,

Looking over niu.c I see two implementations of the .map_page callback.

1. niu_pci_map_page is a trivial wrapper around dma_map_page.
   And in that case your change looks good.

2. niu_phys_map_page, which looks like this:

static u64 niu_phys_map_page(struct device *dev, struct page *page,
                             unsigned long offset, size_t size,
                             enum dma_data_direction direction)
{
        return page_to_phys(page) + offset;
}

In this case dma_mapping_error may well correctly detect (no) errors.
But it will call debug_dma_mapping_error(), which doesn't seem ideal.

