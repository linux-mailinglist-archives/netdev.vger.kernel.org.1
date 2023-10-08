Return-Path: <netdev+bounces-38887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7837BCD8C
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 11:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6215B1C20896
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 09:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA768C11;
	Sun,  8 Oct 2023 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382DD8C00
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 09:37:04 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12B5B6;
	Sun,  8 Oct 2023 02:37:01 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S3H5Y26QpzRhp3;
	Sun,  8 Oct 2023 17:33:05 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sun, 8 Oct
 2023 17:36:59 +0800
Subject: Re: [PATCH net-next v10 1/6] page_pool: fragment API support for
 32-bit arch with 64-bit DMA
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: Alexander Duyck <alexander.duyck@gmail.com>, Paolo Abeni
	<pabeni@redhat.com>, <davem@davemloft.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, Liang
 Chen <liangchen.linux@gmail.com>, Guillaume Tucker
	<guillaume.tucker@collabora.com>, Matthew Wilcox <willy@infradead.org>,
	Linux-MM <linux-mm@kvack.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet
	<edumazet@google.com>
References: <20230922091138.18014-1-linyunsheng@huawei.com>
 <20230922091138.18014-2-linyunsheng@huawei.com>
 <b70b44bec789b60a99c18e43f6270f9c48e3d704.camel@redhat.com>
 <20231003151216.1a3d6901@kernel.org>
 <c2ef79ea-468e-ce25-a597-cc1684389143@intel.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <943e7a57-1285-4123-578c-1bb8d1a926c4@huawei.com>
Date: Sun, 8 Oct 2023 17:36:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c2ef79ea-468e-ce25-a597-cc1684389143@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/10/4 17:31, Alexander Lobakin wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Tue, 3 Oct 2023 15:12:16 -0700
> 
>> On Tue, 03 Oct 2023 09:45:56 +0200 Paolo Abeni wrote:
>>> I think it would be nice also an explicit ack from Jesper and/or Ilias.
>>
>> Also a review tag from one or both of the Alexanders would be great!
> 
> I got back to libie/iavf this week, hoping I'll rebase without major
> issues and will be able to give a Tested-by as well, will see :>
>

It is great to have some Tested-by tag to confirm that this patchset
works for other driver. Please let me know if there is any problem when
rebasing and testing, thanks.


> Thanks,
> Olek
> 
> .
> 

