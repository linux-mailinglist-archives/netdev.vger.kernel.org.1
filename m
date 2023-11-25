Return-Path: <netdev+bounces-51025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F267F8AC2
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 13:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DEF5281404
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 12:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD02DF66;
	Sat, 25 Nov 2023 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC228BF;
	Sat, 25 Nov 2023 04:29:24 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ScrdJ16N2zMnKp;
	Sat, 25 Nov 2023 20:24:36 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 25 Nov
 2023 20:29:22 +0800
Subject: Re: [PATCH net-next v5 01/14] page_pool: make sure frag API fields
 don't span between cachelines
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Michal Kubiak
	<michal.kubiak@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>, David Christensen
	<drc@linux.vnet.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Paul Menzel
	<pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
 <20231124154732.1623518-2-aleksander.lobakin@intel.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <9902d1c4-5e51-551a-3b66-c078c217c5ad@huawei.com>
Date: Sat, 25 Nov 2023 20:29:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231124154732.1623518-2-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/24 23:47, Alexander Lobakin wrote:
> After commit 5027ec19f104 ("net: page_pool: split the page_pool_params
> into fast and slow") that made &page_pool contain only "hot" params at
> the start, cacheline boundary chops frag API fields group in the middle
> again.
> To not bother with this each time fast params get expanded or shrunk,
> let's just align them to `4 * sizeof(long)`, the closest upper pow-2 to
> their actual size (2 longs + 2 ints). This ensures 16-byte alignment for
> the 32-bit architectures and 32-byte alignment for the 64-bit ones,
> excluding unnecessary false-sharing.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/page_pool/types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index e1bb92c192de..989d07b831fc 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -127,7 +127,7 @@ struct page_pool {
>  
>  	bool has_init_callback;

It seems odd to have only a slow field between tow fast
field group, isn't it better to move it to the end of
page_pool or where is more appropriate?

>  
> -	long frag_users;
> +	long frag_users __aligned(4 * sizeof(long));

If we need that, why not just use '____cacheline_aligned_in_smp'?

>  	struct page *frag_page;
>  	unsigned int frag_offset;
>  	u32 pages_state_hold_cnt;
> 

