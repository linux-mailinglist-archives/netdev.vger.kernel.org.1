Return-Path: <netdev+bounces-53703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCAB804355
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 01:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6B21C209B3
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 00:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86B9392;
	Tue,  5 Dec 2023 00:26:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D467BA0
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 16:26:06 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SkhBt5BqqzvRZs;
	Tue,  5 Dec 2023 08:25:26 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Dec
 2023 08:26:04 +0800
Subject: Re: [PATCH net] net: veth: fix packet segmentation in
 veth_convert_skb_to_xdp_buff
To: Lorenzo Bianconi <lorenzo@kernel.org>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <lorenzo.bianconi@redhat.com>,
	<alexander.duyck@gmail.com>, <aleksander.lobakin@intel.com>,
	<liangchen.linux@gmail.com>
References: <eddfe549e7e626870071930964ac3c38a1dc8068.1701702000.git.lorenzo@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <eccc6a46-77a0-3980-1b7b-c4a07560cc42@huawei.com>
Date: Tue, 5 Dec 2023 08:26:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <eddfe549e7e626870071930964ac3c38a1dc8068.1701702000.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/12/4 23:01, Lorenzo Bianconi wrote:
> Based on the previous allocated packet, page_offset can be not null
> in veth_convert_skb_to_xdp_buff routine.
> Take into account page fragment offset during the skb paged area copy
> in veth_convert_skb_to_xdp_buff().
> 
> Fixes: 2d0de67da51a ("net: veth: use newly added page pool API for veth with xdp")

LGTM.
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>

Thanks for the fix.

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/veth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 57efb3454c57..977861c46b1f 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -790,7 +790,8 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>  
>  			skb_add_rx_frag(nskb, i, page, page_offset, size,
>  					truesize);
> -			if (skb_copy_bits(skb, off, page_address(page),
> +			if (skb_copy_bits(skb, off,
> +					  page_address(page) + page_offset,
>  					  size)) {
>  				consume_skb(nskb);
>  				goto drop;
> 

