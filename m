Return-Path: <netdev+bounces-110125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A2292B0B3
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB02281F7B
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45BD13E40D;
	Tue,  9 Jul 2024 06:58:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932A613DBA2;
	Tue,  9 Jul 2024 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720508292; cv=none; b=jkmtHcbTe5mQK3P6oKaC6UTeOKFxS+a7GbIhtf4+GH1BGSRR2OrFX9i6JY0vfd4klZsapH60784o/yW6WEpP4YY9o3YQIUF4iDx8wMmnCrFMZzPdPAGl+cZVIA5hAp5hnIHXDvio7G6MF+XA9K0Wi5ORqn11YDHTnh92bSHDfWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720508292; c=relaxed/simple;
	bh=dB5OLaUU1vnf+HXn6ajIikCkxqoPen39u8scohwcq/0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=T/a97RZX0oDTCGq623frSgGD+c/Y9Hxep4M9yPc4PmC1aSq9mpCukShvV4hFRH7vH5HVJTsjWePTcFDBvxIGNdKve3mqJZzWTVcvpXhpqpPivhRJbTgJx2BGbyRstfUcLDxSZFsPh9Veh/8gU0lVdX7HhOqWet/VBmW+0jKVjLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WJBXH2YMszwWYR;
	Tue,  9 Jul 2024 14:53:19 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 85476180064;
	Tue,  9 Jul 2024 14:58:00 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Jul
 2024 14:58:00 +0800
Subject: Re: [PATCH net-next v9 10/13] mm: page_frag: introduce
 prepare/probe/commit API
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: Yunsheng Lin <yunshenglin0825@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-11-linyunsheng@huawei.com>
 <33c3c7fc00d2385e741dc6c9be0eade26c30bd12.camel@gmail.com>
 <38da183b-92ba-ce9d-5472-def199854563@huawei.com>
 <CAKgT0Ueg1u2S5LJuo0Ecs9dAPPDujtJ0GLcm8BTsfDx9LpJZVg@mail.gmail.com>
 <0a80e362-1eb7-40b0-b1b9-07ec5a6506ea@gmail.com>
 <CAKgT0UcRbpT6UFCSq0Wd9OHrCqOGR=BQ063-zNBZ4cVNmduZGw@mail.gmail.com>
 <15623dac-9358-4597-b3ee-3694a5956920@gmail.com>
 <200ee8ff-557f-e17b-e71f-645267a49831@huawei.com>
 <CAKgT0UcpLBtkX9qrngJAtpnnxT-YRqLFc+J4oMMVnTCPG5sMug@mail.gmail.com>
 <83cf5a36-055a-f590-9d41-59c45f93e7c5@huawei.com>
 <CAKgT0UdH1yD=LSCXFJ=YM_aiA4OomD-2wXykO42bizaWMt_HOA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <2b7ecaca-9a17-e057-8897-d0684b31591d@huawei.com>
Date: Tue, 9 Jul 2024 14:57:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdH1yD=LSCXFJ=YM_aiA4OomD-2wXykO42bizaWMt_HOA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/8 22:30, Alexander Duyck wrote:
> On Mon, Jul 8, 2024 at 3:58 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/7/8 1:12, Alexander Duyck wrote:
>>
>> ...
>>
>>> The issue is the dependency mess that has been created with patch 11
>>> in the set. Again you are conflating patches which makes this really
>>> hard to debug or discuss as I make suggestions on one patch and you
>>> claim it breaks things that are really due to issues in another patch.
>>> So the issue is you included this header into include/linux/sched.h
>>> which is included in linux/mm_types.h. So what happens then is that
>>> you have to include page_frag_cache.h *before* you can include the
>>> bits from mm_types.h
>>>
>>> What might make more sense to solve this is to look at just moving the
>>> page_frag_cache into mm_types_task.h and then having it replace the
>>> page_frag struct there since mm_types.h will pull that in anyway. That
>>> way sched.h can avoid having to pull in page_frag_cache.h.
>>
>> It seems the above didn't work either, as asm-offsets.c does depend on
>> mm_types_task.h too.
>>
>> In file included from ./include/linux/mm.h:16,
>>                  from ./include/linux/page_frag_cache.h:10,
>>                  from ./include/linux/mm_types_task.h:11,
>>                  from ./include/linux/mm_types.h:5,
>>                  from ./include/linux/mmzone.h:22,
>>                  from ./include/linux/gfp.h:7,
>>                  from ./include/linux/slab.h:16,
>>                  from ./include/linux/resource_ext.h:11,
>>                  from ./include/linux/acpi.h:13,
>>                  from ./include/acpi/apei.h:9,
>>                  from ./include/acpi/ghes.h:5,
>>                  from ./include/linux/arm_sdei.h:8,
>>                  from arch/arm64/kernel/asm-offsets.c:10:
>> ./include/linux/mmap_lock.h: In function ‘mmap_assert_locked’:
>> ./include/linux/mmap_lock.h:65:23: error: invalid use of undefined type ‘const struct mm_struct’
>>    65 |  rwsem_assert_held(&mm->mmap_lock);
> 
> Do not include page_frag_cache.h in mm_types_task.h. Just move the
> struct page_frag_cache there to replace struct page_frag.

The above does seem a clever idea, but doesn't doing above also seem to
defeat some purpose of patch 1? Anyway, it seems workable for trying
to avoid adding a new header for a single struct.

About the 'replace' part, as mentioned in [1], the 'struct page_frag'
is still needed as this patchset is large enough that replacing is only
done for sk_page_frag(), there are still other places using page_frag
that can be replaced by page_frag_cache in the following patchset.

1. https://lore.kernel.org/all/b200a609-2f30-ec37-39b6-f37ed8092f41@huawei.com/

> .
> 

