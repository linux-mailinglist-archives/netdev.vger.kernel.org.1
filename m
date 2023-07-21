Return-Path: <netdev+bounces-19810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B8775C6C4
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574D5282219
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B731E513;
	Fri, 21 Jul 2023 12:18:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365E83D75
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:18:20 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561572D4A
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 05:18:17 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R6pTg63Yjz18MB5;
	Fri, 21 Jul 2023 20:17:27 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 20:18:14 +0800
Subject: Re: [RFC PATCH net-next 2/2] net: veth: Improving page pool recycling
To: Liang Chen <liangchen.linux@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <daniel@iogearbox.net>,
	<ast@kernel.org>, <netdev@vger.kernel.org>
References: <20230719072907.100948-1-liangchen.linux@gmail.com>
 <20230719072907.100948-2-liangchen.linux@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <d38e4df7-3a7c-d3b3-53ee-77db8d5f8d94@huawei.com>
Date: Fri, 21 Jul 2023 20:18:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230719072907.100948-2-liangchen.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/19 15:29, Liang Chen wrote:

...

> 
> The reason behind is some skbs received from the veth peer are not page
> pool pages, and remain so after conversion to xdp frame. In order to not
> confusing __xdp_return with mixed regular pages and page pool pages, they
> are all converted to regular pages. So registering xdp memory model as
> MEM_TYPE_PAGE_SHARED is sufficient.
> 
> If we replace the above code with kfree_skb_partial, directly releasing
> the skb data structure, we can retain the original page pool page behavior.
> However, directly changing the xdp memory model to MEM_TYPE_PAGE_POOL is
> not a solution as explained above. Therefore, we introduced an additionally
> MEM_TYPE_PAGE_POOL model for each rq.
> 

...

> @@ -874,9 +862,9 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>  		rcu_read_unlock();
>  		goto xdp_xmit;
>  	case XDP_REDIRECT:
> -		veth_xdp_get(xdp);
> -		consume_skb(skb);
> -		xdp->rxq->mem = rq->xdp_mem;
> +		xdp->rxq->mem = skb->pp_recycle ? rq->xdp_mem_pp : rq->xdp_mem;

I am not really familiar with the veth here, so some question here:
Is it possible that skbs received from the veth peer are also page pool pages?
Does using the local rq->xdp_mem_pp for page allocated from veth peer cause
some problem here? As there is type and id for a specific page_pool instance,
type may be the same, but I suppose id is not the same for veth and it's veth
peer.

> +		kfree_skb_partial(skb, true);
> +

