Return-Path: <netdev+bounces-19807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DB675C61D
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61831C2167F
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203051E511;
	Fri, 21 Jul 2023 11:53:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1551E1E50F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:53:38 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56262130;
	Fri, 21 Jul 2023 04:53:36 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R6nvC73z1zHqR9;
	Fri, 21 Jul 2023 19:51:03 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 19:53:33 +0800
Subject: Re: [PATCH RFC net-next v2 7/7] net: skbuff: always try to recycle PP
 pages directly when in softirq
To: Jakub Kicinski <kuba@kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
 <20230714170853.866018-10-aleksander.lobakin@intel.com>
 <20230718174042.67c02449@kernel.org>
 <d7cd1903-de0e-0fe3-eb15-0146b589c7b0@intel.com>
 <20230719135150.4da2f0ff@kernel.org>
 <48c1d70b-d4bd-04c0-ab46-d04eaeaf4af0@intel.com>
 <20230720101231.7a5ff6cd@kernel.org>
 <8e65c3d3-c628-2176-2fc2-a1bc675ad607@intel.com>
 <20230720110027.4bd43ee7@kernel.org>
 <988fc62d-2329-1560-983a-79ff5653a6a6@intel.com>
 <b3884ff9-d903-948d-797a-1830a39b1e71@intel.com>
 <20230720122015.1e7efc21@kernel.org>
 <e542f6b5-4eea-5ac6-a034-47e9f92dbf7e@intel.com>
 <20230720124647.413363d5@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <406885ee-8dd0-1654-ec13-914ed8986c24@huawei.com>
Date: Fri, 21 Jul 2023 19:53:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230720124647.413363d5@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/21 3:46, Jakub Kicinski wrote:
> On Thu, 20 Jul 2023 21:33:40 +0200 Alexander Lobakin wrote:
>>> We can as well check
>>> 	(in_softirq() && !irqs_disabled() && !in_hardirq())
>>> ?  
>>
>> Yes, something like that. Messy, but I see no other options...
>>
>> So, I guess you want to add an assertion to make sure that we're *not*
>> in this:
>>
>> in_hardirq() || irqs_disabled()
>>
>> Does this mean that after it's added, my patch is sane? :p
> 
> Well... it's acceptable. Make sure you add a good, informative
> but concise comment :)
> 

Does it mean ptr_ring_produce_any() is needed in
page_pool_recycle_in_ring() too?

As it is assumed that page pool API can be called in the context with
irqs_disabled() || in_hardirq(), and force recylcling happens in the
prt_ring.

Isn't it conflit with the below patch? as the below patch assume page
pool API can not be called in the context with irqs_disabled() || in_hardirq():
[PATCH net-next] page_pool: add a lockdep check for recycling in hardirq

Or am I missing something obvious here?

