Return-Path: <netdev+bounces-16165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B7A74BA44
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 01:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE741C210ED
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 23:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C5417FFA;
	Fri,  7 Jul 2023 23:59:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3E72F28
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 23:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C342C433C7;
	Fri,  7 Jul 2023 23:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688774362;
	bh=WTd56ApkF2fKz1PpSSnKiKBr0pj8GEdOUW1JlxQoa/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j2DETU06+q5ZvHqx28PK3xLWmURczDOHwZEvX3m3J7ML63Ryrv6z6fGVNpGjaPIOQ
	 wy4but5fBtDcnJvVj6cNlrVxFWdbxZEzCiqp4tGLWod1OntLH8dF+MevIUnWxGbzm4
	 4FD7KJaFlpL/NhlgoXLQxT0lYfmGPxLFvCXlzf8LwEAESEymBUsaSd+fUymVkZsaPt
	 9KqOaZRV60dmYf6Y/MaQF5XoeFGkbeFzxFuKIdKKKcRD++j3sDU+a5ZdP/b2810Qwb
	 OaM9uOTIH06UAZ+lPf47zIVYpXZM7qyLK8duxAIe4QlLXdwuOVkzOgc2t+uw1Ihvl2
	 68WGjdEaPM4hg==
Date: Fri, 7 Jul 2023 16:59:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Alexander Duyck <alexander.duyck@gmail.com>, Liang Chen
 <liangchen.linux@gmail.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Message-ID: <20230707165921.565b1228@kernel.org>
In-Reply-To: <20230629120226.14854-2-linyunsheng@huawei.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
	<20230629120226.14854-2-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jun 2023 20:02:21 +0800 Yunsheng Lin wrote:
> +		/* Return error here to avoid mlx5e_page_release_fragmented()
> +		 * calling page_pool_defrag_page() to write to pp_frag_count
> +		 * which is overlapped with dma_addr_upper in 'struct page' for
> +		 * arch with PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true.
> +		 */
> +		if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT) {
> +			err = -EINVAL;
> +			goto err_free_by_rq_type;
> +		}

I told you not to do this in a comment on v4.
Keep the flag in page pool params and let the creation fail.

