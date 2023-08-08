Return-Path: <netdev+bounces-25399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297D3773DBE
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D795F280F67
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EB314268;
	Tue,  8 Aug 2023 16:22:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A33014015
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:22:13 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F84D26E46
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:21:57 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKrG320YxzrSBt;
	Tue,  8 Aug 2023 19:15:39 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 19:16:49 +0800
Subject: Re: [RFC PATCH net-next v2 2/2] net: veth: Improving page pool pages
 recycling
To: Liang Chen <liangchen.linux@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <hawk@kernel.org>, <ilias.apalodimas@linaro.org>,
	<daniel@iogearbox.net>, <ast@kernel.org>, <netdev@vger.kernel.org>
References: <20230801061932.10335-1-liangchen.linux@gmail.com>
 <20230801061932.10335-2-liangchen.linux@gmail.com>
 <dd263b2b-4030-f274-7fe8-7ba751f04ab6@huawei.com>
 <CAKhg4tKg7AjADOqpPMcdyu89pa3wox7t5VrTcj84ks-NGLhyXw@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <11eb970b-31e5-2330-65a6-7b9e33556489@huawei.com>
Date: Tue, 8 Aug 2023 19:16:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKhg4tKg7AjADOqpPMcdyu89pa3wox7t5VrTcj84ks-NGLhyXw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/7 20:20, Liang Chen wrote:
> On Wed, Aug 2, 2023 at 8:32 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2023/8/1 14:19, Liang Chen wrote:
>>
>>> @@ -862,9 +865,18 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>>>       case XDP_PASS:
>>>               break;
>>>       case XDP_TX:
>>> -             veth_xdp_get(xdp);
>>> -             consume_skb(skb);
>>> -             xdp->rxq->mem = rq->xdp_mem;
>>> +             if (skb != skb_orig) {
>>> +                     xdp->rxq->mem = rq->xdp_mem_pp;
>>> +                     kfree_skb_partial(skb, true);
>>
>> For this case, I suppose that we can safely call kfree_skb_partial()
>> as we allocate the skb in the veth_convert_skb_to_xdp_buff(), but
>> I am not sure about the !skb->pp_recycle case.
>>
>>> +             } else if (!skb->pp_recycle) {
>>> +                     xdp->rxq->mem = rq->xdp_mem;
>>> +                     kfree_skb_partial(skb, true);
>>
>> For consume_skb(), there is skb_unref() checking and other checking/operation.
>> Can we really assume that we can call kfree_skb_partial() with head_stolen
>> being true? Is it possible that skb->users is bigger than 1? If it is possible,
>> don't we free the 'skb' back to skbuff_cache when other may still be using
>> it?
>>
> 
> Thanks for raising the concern. If there are multiple references to
> the skb (skb->users is greater than 1), the skb will be reallocated in
> veth_convert_skb_to_xdp_buff(). So it should enter the skb != skb_orig
> case.
> 
> In fact, entering the !skb->pp_recycle case implies that the skb meets
> the following conditions:
> 1. It is neither shared nor cloned.
> 2. It is not allocated using kmalloc.
> 3. It does not have fragment data.
> 4. The headroom of the skb is greater than XDP_PACKET_HEADROOM.
> 

You are right, I missed the checking in veth_convert_skb_to_xdp_buff(),
it seems the xdp is pretty strict about the buffer owner, it need to
have exclusive access to all the buffer.

And it seems there is only one difference left then, with
kfree_skb_partial() calling 'kmem_cache_free(skbuff_cache, skb)' and
consume_skb() calling 'kfree_skbmem(skb)'. If we are true about
'skb' only allocated from 'skbuff_cache', this patch looks good to me
then.

> 

