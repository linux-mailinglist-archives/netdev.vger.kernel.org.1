Return-Path: <netdev+bounces-134621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE45499A844
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6D21C22B7F
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 15:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6EE823DD;
	Fri, 11 Oct 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b15jSpFh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D3F10F7;
	Fri, 11 Oct 2024 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661765; cv=none; b=Os/ijGthY+ZdFrAT7F0ZhGXhMiYSu9tYANGmyVKrfU1PQ4qb2BZWZC/AGfjOT7WSOX3mEQlbWUTIkj3hlMn7iBRukYQG8y8T8NchWDFDsSYmfpqprq3coHkPYdAXUu92ZuJMJl3h9U3LoP1sHCw9BEem4RxsTtdfvysFXOI0FlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661765; c=relaxed/simple;
	bh=pSy1MK1YaflqwCzh6P1vtL7L/EAZ5Pq58NwxmcnsFcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LsBZifA4hIaSp4TZSgAjtOT+mtNNxkPcJAzeZdmPMkj3UKvSWjMWcQKfGhw09MRtc9PA/3QmK0JQ78Ks0ohtNXnQzx9ldK/8SK8u8j6Vftd9cDPL2meVycaw82JbOB5/NkBgCkCCL31qVBRyhSzXJqea/OQqA3npg/SkraiRNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b15jSpFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA26C4CEC3;
	Fri, 11 Oct 2024 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728661765;
	bh=pSy1MK1YaflqwCzh6P1vtL7L/EAZ5Pq58NwxmcnsFcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b15jSpFh8bXXqrlw18PZY75DNXVhGS97yt42xfGNDuV+Riu35A4Ud8LLkgaY5gRSF
	 OAlRRjC/u8omL6lGZctxTBd6UnivhOAwya6HWFDht7+gm/r2A44nact+pZr1lFOZsL
	 TnmYdt9bRdVGrDUoJtqnJaIvBwJ7y0WLbAvhVnfCupi/qOpyiPYWHbeQq/ZTt1ofFm
	 /zvShPRVMn9ssZ3xXziqv+Udx/zJClsPTNBuAEBvA9KdPK9P/AWl5PbBn85LsAh5mR
	 W42PpdEd2tQxzSKSWojnY9xHrlm4X0bxoXQz6C83N3Q7gFL0NIKVlRLPYAXmbnhWU9
	 frNe4/YMWgnuQ==
Date: Fri, 11 Oct 2024 08:49:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, <xfr@outlook.com>
Subject: Re: [PATCH net-next v1] page_pool: check for dma_sync_size earlier
Message-ID: <20241011084924.1fa2eb7d@kernel.org>
In-Reply-To: <20241011172605.0000142f@gmail.com>
References: <20241010114019.1734573-1-0x1207@gmail.com>
	<601d59f4-d554-4431-81ca-32bb02fb541f@huawei.com>
	<20241011101455.00006b35@gmail.com>
	<CAC_iWjL7Z6qtOkxXFRUnnOruzQsBNoKeuZ1iStgXJxTJ_P9Axw@mail.gmail.com>
	<20241011143158.00002eca@gmail.com>
	<21036339-3eeb-4606-9a84-d36bddba2b31@huawei.com>
	<20241011172605.0000142f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 17:26:05 +0800 Furong Xu wrote:
> > In order to support the above use case, it seems there might be two
> > options here:
> > 1. Driver calls page_pool_create() without PP_FLAG_DMA_SYNC_DEV and
> >    handle the dma sync itself.
> > 2. Page_pool may provides a non-dma-sync version of page_pool_put_page()
> >    API even when Driver calls page_pool_create() with PP_FLAG_DMA_SYNC_DEV.
> > 
> > Maybe option 2 is better one in the longer term as it may provide some
> > flexibility for the user and enable removing of the DMA_SYNC_DEV in the
> > future?  
> 
> What is your opinion about this?

I think your patch is fine, but it's a micro optimization so you need 
to provide some measurement data to show how much of a performance
improvement you're getting.

