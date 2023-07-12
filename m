Return-Path: <netdev+bounces-17270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58428750FA5
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCCA2817F1
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8693720F92;
	Wed, 12 Jul 2023 17:26:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E56C20F85
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 17:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568FBC433A9;
	Wed, 12 Jul 2023 17:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689182765;
	bh=pG6AfeQoMQzPU4mvPY+9mXce5KZBxglpwtexIBwtYiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XRowKNSn1KVUX3wG5wtCbshtxTkV3qoGx60izDxqap1T6aBFZjWbARoKikKbawfAb
	 b/4/XBiDgUsoGDJl/kH+PMYI7Ocq+m34rE1cf9Cft4bZFJDYlXHDH3x4d2KfC61ds1
	 z83EIvQyIKHcXHo7zh6EhnvADi9C6SoKrC93g2uuHe1Gv1BrjCNNTYRU2tQvgBXEt8
	 omR7EjZhMLN0Mq22Zb/ynOdZMHqTfoswFU+rt3uuIDrkvdEsxdfRAv3gXYb6LWoCWb
	 UlQe5CYSXwHee90E0pe6Q5+XCpF/jslF29tTY9JyZh5xOsgVKOc7v3OKMT0ZfBNrEt
	 NyAN+iJqLP3Kw==
Date: Wed, 12 Jul 2023 10:26:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Yunsheng Lin
 <yunshenglin0825@gmail.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Liang
 Chen <liangchen.linux@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Message-ID: <20230712102603.5038980e@kernel.org>
In-Reply-To: <46ad09d9-6596-cf07-5cab-d6ceb1e36f3c@huawei.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
	<20230629120226.14854-2-linyunsheng@huawei.com>
	<20230707170157.12727e44@kernel.org>
	<3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
	<20230710113841.482cbeac@kernel.org>
	<8639b838-8284-05a2-dbc3-7e4cb45f163a@intel.com>
	<20230711093705.45454e41@kernel.org>
	<1bec23ff-d38b-3fdf-1bb3-89658c1d465a@intel.com>
	<46ad09d9-6596-cf07-5cab-d6ceb1e36f3c@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 20:34:12 +0800 Yunsheng Lin wrote:
> >> C sources can include $path/page_pool.h, headers should generally only
> >> include $path/page_pool/types.h.  
> 
> Does spliting the page_pool.h as above fix the problem about including
> a ton of static inline functions from "linux/dma-mapping.h" in skbuff.c?
> 
> As the $path/page_pool/helpers.h which uses dma_get_cache_alignment()
> must include the "linux/dma-mapping.h" which has dma_get_cache_alignment()
> defining as a static inline function.
> and if skbuff.c include $path/page_pool.h or $path/page_pool/helpers.h,
> doesn't we still have the same problem? Or do I misunderstand something
> here?

I should have clarified that "types.h" should also include pure
function declarations (and possibly static line wrappers like
pure get/set functions which only need locally defined types).

The skbuff.h only needs to include $path/page_pool/types.h, right?

I know that Olek has a plan to remove the skbuff dependency completely
but functionally / for any future dependencies - this should work?

