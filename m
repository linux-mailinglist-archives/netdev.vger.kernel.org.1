Return-Path: <netdev+bounces-23630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F04C76CCB1
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 14:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1EB281DD5
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A227568B;
	Wed,  2 Aug 2023 12:32:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C816566C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 12:32:08 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A665194
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 05:32:07 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RGBBz4457zVjrY;
	Wed,  2 Aug 2023 20:30:19 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 20:32:03 +0800
Subject: Re: [RFC PATCH net-next v2 2/2] net: veth: Improving page pool pages
 recycling
To: Liang Chen <liangchen.linux@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <daniel@iogearbox.net>,
	<ast@kernel.org>, <netdev@vger.kernel.org>
References: <20230801061932.10335-1-liangchen.linux@gmail.com>
 <20230801061932.10335-2-liangchen.linux@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <dd263b2b-4030-f274-7fe8-7ba751f04ab6@huawei.com>
Date: Wed, 2 Aug 2023 20:32:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230801061932.10335-2-liangchen.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/1 14:19, Liang Chen wrote:

> @@ -862,9 +865,18 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>  	case XDP_PASS:
>  		break;
>  	case XDP_TX:
> -		veth_xdp_get(xdp);
> -		consume_skb(skb);
> -		xdp->rxq->mem = rq->xdp_mem;
> +		if (skb != skb_orig) {
> +			xdp->rxq->mem = rq->xdp_mem_pp;
> +			kfree_skb_partial(skb, true);

For this case, I suppose that we can safely call kfree_skb_partial()
as we allocate the skb in the veth_convert_skb_to_xdp_buff(), but
I am not sure about the !skb->pp_recycle case.

> +		} else if (!skb->pp_recycle) {
> +			xdp->rxq->mem = rq->xdp_mem;
> +			kfree_skb_partial(skb, true);

For consume_skb(), there is skb_unref() checking and other checking/operation.
Can we really assume that we can call kfree_skb_partial() with head_stolen
being true? Is it possible that skb->users is bigger than 1? If it is possible,
don't we free the 'skb' back to skbuff_cache when other may still be using
it?

> +		} else {
> +			veth_xdp_get(xdp);
> +			consume_skb(skb);
> +			xdp->rxq->mem = rq->xdp_mem;
> +		}
> +


