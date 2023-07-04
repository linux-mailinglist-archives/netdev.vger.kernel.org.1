Return-Path: <netdev+bounces-15258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DE97466AD
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 02:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE401C20A9E
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 00:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0A3388;
	Tue,  4 Jul 2023 00:50:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADAC367
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 00:50:36 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BD5136
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 17:50:32 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qw3zb35pXztQwT;
	Tue,  4 Jul 2023 08:47:39 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 4 Jul
 2023 08:50:29 +0800
Subject: Re: [PATCH net-next] skbuff: Optimize SKB coalescing for page pool
 case
To: Jakub Kicinski <kuba@kernel.org>, Liang Chen <liangchen.linux@gmail.com>
CC: <ilias.apalodimas@linaro.org>, <hawk@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20230628121150.47778-1-liangchen.linux@gmail.com>
 <20230630160709.45ea4faa@kernel.org>
 <CAKhg4t+hoOiVWMbBiD7HCu_Z5pSdCsZrev2FMEKhbWvzgHCarw@mail.gmail.com>
 <20230703115326.69f8953b@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <8fb342b4-a843-6d67-b72f-19f2da38cfaa@huawei.com>
Date: Tue, 4 Jul 2023 08:50:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230703115326.69f8953b@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/4 2:53, Jakub Kicinski wrote:
> On Mon, 3 Jul 2023 17:12:46 +0800 Liang Chen wrote:
>> As for the "pp" reference, it has the test
>> page_pool_is_pp_page_frag(head_page) there. So for a non-frag pp page,
>> it will be a get_page call.
> 
> You don't understand - you can't put a page from a page pool in two
> skbs with pp_recycle set, unless the page is frag'ed.

Agreed. I think we should disallow skb coaleasing for non-frag pp page
instead of calling get_page(), as there is data race when calling
page_pool_return_skb_page() concurrently for the same non-frag pp page.

Even with my patchset, it may break the arch with
PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true.

> .
> 

