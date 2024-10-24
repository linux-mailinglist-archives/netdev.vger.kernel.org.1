Return-Path: <netdev+bounces-138596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2499AE410
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FF9B22F58
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9431CFEA9;
	Thu, 24 Oct 2024 11:39:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049D1B85DB;
	Thu, 24 Oct 2024 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769967; cv=none; b=Gad1LsIum69j3CiQaSqdmSgnz51ucyiE/pKW24lFAJo7at1T/7o9Q0xTc9a83Q1YRFWzpObNkg/NzJr3r7VwjLppnXebqSr1f7MzduZNlwlIZuDJSmNowUQoqM7pHYZIHe6f9oCK2YCB5/XroHjqvprSpGvYUokvvP67SmJlU6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769967; c=relaxed/simple;
	bh=KwBiN5rgNTlmkT22f6vVpY6v7mrOcGjlI7NoYPdSbxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gJbKhZtQ1ZdT3dBa7FawXpHyfsVe2vnAOJOCxUUCvUSzVCP7NTa/D0s84QAMfMIDwoINgvE1t/9yzZHC9vnRaXQ/ncn+3hL+bMJntMRmGW1g2XDRkHOWjpZx6LpcbA3SlYWrB/fdRxHsfafr/Cmmu9hhVzeOk2nHGc5/FJ6N0p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XZ3q40sxlz1ynQl;
	Thu, 24 Oct 2024 19:39:28 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A0DA01A0188;
	Thu, 24 Oct 2024 19:39:20 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Oct 2024 19:39:20 +0800
Message-ID: <a96aed59-8a58-41a9-80ad-5a4825fed6ec@huawei.com>
Date: Thu, 24 Oct 2024 19:39:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v22 00/14] Replace page_frag with page_frag_cache
 for sk_page_frag()
To: Paolo Abeni <pabeni@redhat.com>, Yunsheng Lin <yunshenglin0825@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>, Eric Dumazet <edumazet@google.com>, Alexander
 Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<linux-mm@kvack.org>
References: <20241018105351.1960345-1-linyunsheng@huawei.com>
 <CAKgT0Uft5Ga0ub_Fj6nonV6E0hRYcej8x_axmGBBX_Nm_wZ_8w@mail.gmail.com>
 <02d4971c-a906-44e8-b694-bd54a89cf671@gmail.com>
 <add10dd4-7f5d-4aa1-aa04-767590f944e0@redhat.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <add10dd4-7f5d-4aa1-aa04-767590f944e0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/24 17:05, Paolo Abeni wrote:
> Hi,
> 
> I just noted MM maintainer and ML was not CC on the cover-letter (but
> they were on the relevant patches), adding them now.
> 
> On 10/19/24 10:27, Yunsheng Lin wrote:
>> On 10/19/2024 1:39 AM, Alexander Duyck wrote:
>>> So I still think this set should be split in half in order to make
>>> this easier to review. The ones I have provided a review-by for so far
>>> seem fine to me. I really think if you just submitted that batch first
>>> we can get that landed and let them stew in the kernel for a bit to
>>> make sure we didn't miss anything there.
>>
>> It makes sense to me too that it might be better to get those submitted
>> to get more testing if there is no more comment about it.
>>
>> I am guessing they should be targetting net-next tree to get more
>> testing as all the callers of page_frag API seem to be in the
>> networking, right?
>>
>> Hi, David, Jakub & Paolo
>> It would be good if those patches are just cherry-picked from this
>> patchset as those patches with 'Reviewed-by' tag seem to be applying
>> cleanly. Or any better suggestion here?
> 
> We can cherry pick the patches from the posted series, applying the
> review tags as needed, but we need an explicit ack from the mm

Thanks.
I would be good to cherry pick the below one too, as it has also a
'Reviewed-by' tag. I mentioned that it might be easier to miss that
one because it sits after one without 'Reviewed-by' and it seems to
be also applied cleanly:

[net-next,v22,08/14] mm: page_frag: use __alloc_pages() to replace alloc_pages_node()

https://patchwork.kernel.org/project/netdevbpf/patch/20241018105351.1960345-9-linyunsheng@huawei.com/

> maintainer, given the mentioned patches touch mostly such code.

Sorry for missing to cc Andrew and MM ML.
Maybe I should have mentioned that Andrew provided an 'Acked-by' in
patch 2, but it is always safer to double check it.

> 
> I would like to avoid repeating a recent incident of unintentionally
> stepping on other subsystem toes.
> 
> @Andrew: are you ok with the above plan?
> 
> Thank you,
> 
> Paolo
> 
> 

