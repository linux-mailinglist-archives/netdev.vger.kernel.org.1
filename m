Return-Path: <netdev+bounces-124784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 461E196AE8D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 04:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7079B20D6C
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 02:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2072E383A3;
	Wed,  4 Sep 2024 02:27:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1838385;
	Wed,  4 Sep 2024 02:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725416845; cv=none; b=q8qIBUA9dXWyGoj1OZgU5fDuju9jVeYmUtgO+XDjM9vqSGh7FDgztKff/S9wakzhHhXqi7pCX9p9VVSr75jyQhqmaOyj90zpN0PnEftjiOokB9+B2XJ1wfA4zrXuW8OINM30i1L+FRGtT0o1ymfjAzgATfxdQuJtYhyKlEzA+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725416845; c=relaxed/simple;
	bh=lccjj/bVgVammQjpy/xfBs7vvJklhqIWZwiQmaIEHIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g7C/6nabEPOifRuC66JGQSODMJAMaTCrIF9C+lIUhGMPEsEi+EvilkkvzKCh/MZBWxOXXOuLP92QFIY1mh00Bg+n6BecEJPY2LZ3+DLb+eCcZkv2blQx6pSegREDHdNA3HKoTe1YiWnVVHguiJWASqjPXfH8VCsIoyV6SSjoGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wz5wg2TTNz2CpPc;
	Wed,  4 Sep 2024 10:26:59 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FD621A0188;
	Wed,  4 Sep 2024 10:27:19 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 10:27:18 +0800
Message-ID: <56a4c8ec-2cc1-4078-b5d9-fb128be3efeb@huawei.com>
Date: Wed, 4 Sep 2024 10:27:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/4] tun: Make use of str_disabled_enabled helper
Content-Language: en-US
To: Andy Shevchenko <andy@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: <kees@kernel.org>, <jasowang@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <akpm@linux-foundation.org>,
	<linux-hardening@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20240831095840.4173362-1-lihongbo22@huawei.com>
 <20240831095840.4173362-3-lihongbo22@huawei.com>
 <20240831130741.768da6da@kernel.org> <ZtWYO-atol0Qx58h@smile.fi.intel.com>
 <66d5cc19d34c6_613882942a@willemb.c.googlers.com.notmuch>
 <9d844c72-bda6-4e28-b48c-63c4f8855ae7@huawei.com>
 <ZtcmjI-C3zfqjooc@smile.fi.intel.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <ZtcmjI-C3zfqjooc@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/9/3 23:09, Andy Shevchenko wrote:
> On Tue, Sep 03, 2024 at 02:25:53PM +0800, Hongbo Li wrote:
>> On 2024/9/2 22:30, Willem de Bruijn wrote:
>>> Andy Shevchenko wrote:
>>>> On Sat, Aug 31, 2024 at 01:07:41PM -0700, Jakub Kicinski wrote:
>>>>> On Sat, 31 Aug 2024 17:58:38 +0800 Hongbo Li wrote:
> 
> ...
> 
>>>>>>    		netif_info(tun, drv, tun->dev, "ignored: set checksum %s\n",
>>>>>> -			   arg ? "disabled" : "enabled");
>>>>>> +			   str_disabled_enabled(arg));
>>>>>
>>>>> You don't explain the 'why'. How is this an improvement?
>>>>> nack on this and 2 similar networking changes you sent
>>>>
>>>> Side opinion: This makes the messages more unified and not prone to typos
>>>> and/or grammatical mistakes. Unification allows to shrink binary due to
>>>> linker efforts on string literals deduplication.
>>>
>>> This adds a layer of indirection.
>>>
>>> The original code is immediately obvious. When I see the new code I
>>> have to take a detour through cscope to figure out what it does.
>> If they have used it once, there is no need for more jumps, because it's
>> relatively simple.
>>
>> Using a dedicated function seems very elegant and unified, especially for
>> some string printing situations, such as disable/enable. Even in today's
>> kernel tree, there are several different formats that appear:
>> 'enable/disable', 'enabled/disabled', 'en/dis'.
> 
> Not to mention that the longer word is the more error prone the spelling.
> 
>>> To me, in this case, the benefit is too marginal to justify that.
> 
> Hongbo, perhaps you need to add a top comment to the string_choices.h to
> explain the following:
> 1) the convention to use is str_$TRUE_$FALSE(), where $TRUE and $FALSE the
> respective words printed;
> 2) the pros of having unified output,
> 3) including but not limited to the linker deduplication facilities, making
> the binary smaller.
> 
> With that you may always point people to the ad-hoc documentation.
> 

ok, thank you, and I can try it.

However, with these modifications, I'm not sure whether Willem and Jakub 
agree with the changes. If they don't agree, then I'll have to remove 
this example in the next version. In the future, we can guide other 
developers to use these helpers directly instead of rewriting it themselves.

Thanks,
Hongbo

