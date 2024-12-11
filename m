Return-Path: <netdev+bounces-150975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D089EC3B9
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 04:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DF3188B6C0
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED48B23236B;
	Wed, 11 Dec 2024 03:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbIsJENH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB2A217F40;
	Wed, 11 Dec 2024 03:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733888867; cv=none; b=HGs4WpMCzduSHah8iVT05S8yXAee76fII++yj9Wti/mvB8BISIcAKGjQj+66+mVpiMm1chftLj4w4hC5qJh+qf4toxMEvATaEl+eUWMpDPQGkhgshWTMBx5JftiGaNryk/6x8VtpVa/YAIqrz23SbHKguFhMzoDkSPQXOntU/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733888867; c=relaxed/simple;
	bh=4VXvFe7m050VpSVNBvTDwFfGuKPuf2l5vzRdP3v5/38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSzoxaOSqAsrOjy3RsAZ5Lsb7JKrtJ5EOarpiQyLqCR//YZyusiYmRDiIsPov61AtVPe/ORbdv8BmraNoBGPpa4SkpF4ANgdjiPUK+iEhb9fECp3zR/8UGIINnXK+Szu13HQsn/aMwm+sX1rP0AyrZtMeYPt4OYdcDX0DX0shUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbIsJENH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86041C4CED2;
	Wed, 11 Dec 2024 03:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733888867;
	bh=4VXvFe7m050VpSVNBvTDwFfGuKPuf2l5vzRdP3v5/38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fbIsJENHb8B/oO7g0wQh/evbS6I87BuukPBtB+x9SvC74OEqDcRqtobK9rzX1bewj
	 CCYKFmGmRcHlbX18y+CMzs25nqfW7lvg7XSaDAjTISRDUNstRxvgTserXRCfdn1rZX
	 wqfSWP+u7FfNZR2qbA1FtPKtF8ro3KGEsVto0s3ckulJgE09n4eI8LUNxut5SiKwgq
	 BPiXWKrZYWUj5YaExjUrnXHwATFtCBXtgb8Pgzoiim+MKV9Ea/RIx8Nz5rm5dZ1CAf
	 gxsfiszwIbWz6rOWyXa9/JlZ2lzp/7nQEU+mF+zVCod1WZxeQC9qmlL+q/v63JNcmk
	 FbJWus52JkPlw==
Date: Tue, 10 Dec 2024 19:47:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, Kaiyuan
 Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next v3 4/5] page_pool: disable sync for cpu for
 dmabuf memory provider
Message-ID: <20241210194745.7a0a319e@kernel.org>
In-Reply-To: <20241209172308.1212819-5-almasrymina@google.com>
References: <20241209172308.1212819-1-almasrymina@google.com>
	<20241209172308.1212819-5-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Dec 2024 17:23:07 +0000 Mina Almasry wrote:
> -static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
> -					      const struct page *page,
> -					      u32 offset, u32 dma_sync_size)
> +static inline void
> +page_pool_dma_sync_netmem_for_cpu(const struct page_pool *pool,
> +				  const netmem_ref netmem, u32 offset,
> +				  u32 dma_sync_size)
>  {
> +	if (pool->mp_priv)

Let's add a dedicated bit to skip sync. The io-uring support feels
quite close. Let's not force those guys to have to rejig this.

> +		return;
> +
>  	dma_sync_single_range_for_cpu(pool->p.dev,
> -				      page_pool_get_dma_addr(page),
> +				      page_pool_get_dma_addr_netmem(netmem),
>  				      offset + pool->p.offset, dma_sync_size,
>  				      page_pool_get_dma_dir(pool));
>  }
>  
> +static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
> +					      struct page *page, u32 offset,
> +					      u32 dma_sync_size)
> +{
> +	page_pool_dma_sync_netmem_for_cpu(pool, page_to_netmem(page), offset,
> +					  dma_sync_size);

I have the feeling Olek won't thank us for this extra condition and
bit clearing. If driver calls page_pool_dma_sync_for_cpu() we don't
have to check the new bit / mp_priv. Let's copy & paste the
dma_sync_single_range_for_cpu() call directly here.

