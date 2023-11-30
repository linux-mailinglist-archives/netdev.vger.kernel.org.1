Return-Path: <netdev+bounces-52508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3556E7FEECE
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 13:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C98FBB20B22
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 12:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E0246438;
	Thu, 30 Nov 2023 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D54610DE;
	Thu, 30 Nov 2023 04:20:47 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SgwDK5kSSz1P91Y;
	Thu, 30 Nov 2023 20:17:05 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 Nov
 2023 20:20:44 +0800
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 03/14] page_pool: avoid
 calling no-op externals when possible
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Christoph Hellwig <hch@lst.de>, Paul Menzel <pmenzel@molgen.mpg.de>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Larysa Zaremba <larysa.zaremba@intel.com>,
	<netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, <linux-kernel@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>, Michal Kubiak <michal.kubiak@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, David Christensen
	<drc@linux.vnet.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
 <20231124154732.1623518-4-aleksander.lobakin@intel.com>
 <6bd14aa9-fa65-e4f6-579c-3a1064b2a382@huawei.com>
 <a1a0c27f-f367-40e7-9dc2-9421b4b6379a@intel.com>
 <534e7752-38a9-3e7e-cb04-65789712fb66@huawei.com>
 <8c6d09be-78d0-436e-a5a6-b94fb094b0b3@intel.com>
 <4814a337-454b-d476-dabe-5035dd6dc51f@huawei.com>
 <d8631d76-4bb3-41a4-a2b2-86725867d2a9@intel.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <6c234df1-d20a-812e-3c58-7e3941d8309b@huawei.com>
Date: Thu, 30 Nov 2023 20:20:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d8631d76-4bb3-41a4-a2b2-86725867d2a9@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/30 19:58, Alexander Lobakin wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> Date: Thu, 30 Nov 2023 16:46:11 +0800
> 
>> On 2023/11/29 21:17, Alexander Lobakin wrote:
>>> From: Yunsheng Lin <linyunsheng@huawei.com>
>>> Date: Wed, 29 Nov 2023 11:17:50 +0800
>>>
>>>> On 2023/11/27 22:32, Alexander Lobakin wrote:
>>>>>
>>>>> Chris, any thoughts on a global flag for skipping DMA syncs ladder?
>>>>
>>>> It seems there was one already in the past:
>>>>
>>>> https://lore.kernel.org/netdev/7c55a4d7-b4aa-25d4-1917-f6f355bd722e@arm.com/T/
>>>
>>> It addresses a different problem, meaningless indirect calls, while this
>>> one addresses meaningless direct calls :>
>>> When the above gets merged, we could combine these two into one global,
>>> but Eric wasn't active with his patch and I remember there were some
>>> problems, so I wouldn't count on that it will arrive soon.
>>
>> I went through the above patch, It seems to me that there was no
>> fundamental problem that stopping us from implementing it in the dma
>> layer basing on Eric' patch if Eric is no longer interested in working
>> on a newer version?
> 
> I'm somewhat interested in continuing working on Eric's patch, but not
> now. Have some urgent projects to work on, I could take this in January
> I guess...
> This PP-specific shortcut was done earlier and gives good boosts. It
> would be trivial to remove it together with the XSk shortcut once a
> generic both indirect and direct call DMA shortcut lands.
> Does this sounds good / justified enough? Or you and other
> reviewers/maintainers would prefer to wait for the generic one without
> taking this patch?
> 

I would prefer we could wait for the generic one as there is only about one
month between now and january:)

