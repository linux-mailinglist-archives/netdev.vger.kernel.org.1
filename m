Return-Path: <netdev+bounces-29609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D16C87840AD
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 14:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7401C20ABE
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 12:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739131C29F;
	Tue, 22 Aug 2023 12:24:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A2E8839
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 12:24:09 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903121BE
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 05:24:07 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVT3y44ptzVkvj;
	Tue, 22 Aug 2023 20:21:50 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 20:24:04 +0800
Subject: Re: [RFC PATCH net-next v3 0/2] net: veth: Optimizing page pool usage
To: Jesper Dangaard Brouer <jbrouer@redhat.com>, Liang Chen
	<liangchen.linux@gmail.com>, <hawk@kernel.org>, <horms@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <brouer@redhat.com>, <ilias.apalodimas@linaro.org>,
	<daniel@iogearbox.net>, <ast@kernel.org>, <netdev@vger.kernel.org>, Lorenzo
 Bianconi <lorenzo.bianconi@redhat.com>, Stanislav Fomichev <sdf@google.com>,
	Maryam Tahhan <mtahhan@redhat.com>
References: <20230816123029.20339-1-liangchen.linux@gmail.com>
 <05eec0a4-f8f8-ef68-3cf2-66b9109843b9@redhat.com>
 <a7e72202-0fa1-633e-1564-132a1984aba1@redhat.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <a4e49ab5-fdc5-971a-47e6-30c002ad513f@huawei.com>
Date: Tue, 22 Aug 2023 20:24:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a7e72202-0fa1-633e-1564-132a1984aba1@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/22 5:54, Jesper Dangaard Brouer wrote:
> On 21/08/2023 16.21, Jesper Dangaard Brouer wrote:
>>
>> On 16/08/2023 14.30, Liang Chen wrote:
>>> Page pool is supported for veth, but at the moment pages are not properly
>>> recyled for XDP_TX and XDP_REDIRECT. That prevents veth xdp from fully
>>> leveraging the advantages of the page pool. So this RFC patchset is mainly
>>> to make recycling work for those cases. With that in place, it can be
>>> further optimized by utilizing the napi skb cache. Detailed figures are
>>> presented in each commit message, and together they demonstrate a quite
>>> noticeable improvement.
>>>
>>
>> I'm digging into this code path today.
>>
>> I'm trying to extend this and find a way to support SKBs that used
>> kmalloc (skb->head_frag=0), such that we can remove the
>> skb_head_is_locked() check in veth_convert_skb_to_xdp_buff(), which will
>> allow more SKBs to avoid realloc.  As long as they have enough headroom,
>> which we can dynamically control for netdev TX-packets by adjusting
>> netdev->needed_headroom, e.g. when loading an XDP prog.
>>
>> I noticed netif_receive_generic_xdp() and bpf_prog_run_generic_xdp() can
>> handle SKB kmalloc (skb->head_frag=0).  Going though the code, I don't
>> think it is a bug that generic-XDP allows this.

Is it possible to relaxe other checking too, and implement something like
pskb_expand_head() in xdp core if xdp core need to modify the data?


>>
>> Deep into this rabbit hole, I start to question our approach.
>>   - Perhaps the veth XDP approach for SKBs is wrong?
>>
>> The root-cause of this issue is that veth_xdp_rcv_skb() code path (that
>> handle SKBs) is calling XDP-native function "xdp_do_redirect()". I
>> question, why isn't it using "xdp_do_generic_redirect()"?
>> (I will jump into this rabbit hole now...)

Is there any reason why xdp_do_redirect() can not handle the slab-allocated
data? Can we change the xdp_do_redirect() to handle slab-allocated
data, so that it can benefit other case beside veth too?

