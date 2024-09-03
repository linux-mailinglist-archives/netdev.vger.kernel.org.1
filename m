Return-Path: <netdev+bounces-124400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADAA96939E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 08:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3657CB240A2
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 06:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64841CF2B6;
	Tue,  3 Sep 2024 06:26:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E8A5F;
	Tue,  3 Sep 2024 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725344761; cv=none; b=sIQ9tEnvvEHLqwCqsLeni3MFVhH5nzC1EBbKiuI2V19ys/J94WTrWo8H3rPE+LlXO7KVegJ/x/AtrlsyjIIN0/iWL0P+c0cVpABOng5Fq0/4tcYfujCvM4zrGcp06+qQaEX43aEMuz5FypSBdfH9NrZlDvkkQSoM8h/gZJgPkho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725344761; c=relaxed/simple;
	bh=RveC8/MtBdXkAVZAvb4sx93mHUq7TmZDF/eGhgAu8Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XMNz2vaUIVOVyz+I8NvSEz+vbEbl6vBYmny9L6GniVWxU9JiFEXowwXDtFwg4/U+30bHuh1aV85lM2AHy0MZdW5ZwhAx/7UztK7xpIAEMbpG0mJz+I5YHPo1iGELBoQ313H5vrZ/VPw7rDyN4EnNJPf48XfLU45qwL566/oBtFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WybBr3K9dz1HHkC;
	Tue,  3 Sep 2024 14:22:28 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id A1EC81A016C;
	Tue,  3 Sep 2024 14:25:54 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 14:25:54 +0800
Message-ID: <9d844c72-bda6-4e28-b48c-63c4f8855ae7@huawei.com>
Date: Tue, 3 Sep 2024 14:25:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/4] tun: Make use of str_disabled_enabled helper
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andy Shevchenko
	<andy@kernel.org>, Jakub Kicinski <kuba@kernel.org>
CC: <kees@kernel.org>, <jasowang@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <akpm@linux-foundation.org>,
	<linux-hardening@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20240831095840.4173362-1-lihongbo22@huawei.com>
 <20240831095840.4173362-3-lihongbo22@huawei.com>
 <20240831130741.768da6da@kernel.org> <ZtWYO-atol0Qx58h@smile.fi.intel.com>
 <66d5cc19d34c6_613882942a@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <66d5cc19d34c6_613882942a@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/9/2 22:30, Willem de Bruijn wrote:
> Andy Shevchenko wrote:
>> On Sat, Aug 31, 2024 at 01:07:41PM -0700, Jakub Kicinski wrote:
>>> On Sat, 31 Aug 2024 17:58:38 +0800 Hongbo Li wrote:
>>>> Use str_disabled_enabled() helper instead of open
>>>> coding the same.
>>
>> ...
>>
>>>>   		netif_info(tun, drv, tun->dev, "ignored: set checksum %s\n",
>>>> -			   arg ? "disabled" : "enabled");
>>>> +			   str_disabled_enabled(arg));
>>>
>>> You don't explain the 'why'. How is this an improvement?
>>> nack on this and 2 similar networking changes you sent
>>
>> Side opinion: This makes the messages more unified and not prone to typos
>> and/or grammatical mistakes. Unification allows to shrink binary due to
>> linker efforts on string literals deduplication.
> 
> This adds a layer of indirection.
> 
> The original code is immediately obvious. When I see the new code I
> have to take a detour through cscope to figure out what it does.
If they have used it once, there is no need for more jumps, because it's 
relatively simple.

Using a dedicated function seems very elegant and unified, especially 
for some string printing situations, such as disable/enable. Even in 
today's kernel tree, there are several different formats that appear: 
'enable/disable', 'enabled/disabled', 'en/dis'.

Thanks,
Hongbo

> 
> To me, in this case, the benefit is too marginal to justify that.

