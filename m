Return-Path: <netdev+bounces-138550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4781E9AE132
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718D91C2127F
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6960D1D5151;
	Thu, 24 Oct 2024 09:38:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842251D0159;
	Thu, 24 Oct 2024 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762699; cv=none; b=K72/YyG3jEtebTH6AsMymKTHYX8oxO+7Gd8GXdGDi/ZBmnHBFxGeP20P0tkQlcglgcyhrqi+X1yk1USlXDY3uXxAZOvscCJ7lCuHb9X2pTIvKuSsTH+TQUUFC7LGAzCk7ccMfQFUQJnOPQRJhFVYXYLClVBiMoJAv/S9zzXBjSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762699; c=relaxed/simple;
	bh=kzbk/zuWas4flGeKz32PRmxuVJ+50Dk8mIjxzl5ItdE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hK5gmdpYkKM97kYfcibI/MS6e+FNnvmihNKijd0isFCuOdV0QypiOTybT7s/Iuq2zSltYJn8Tv7VfW5RFxTI8r6MhzKTPiTOxMSfLIVg9Y5SWse18uCGUJgWefum1EyaNaFUdI+CsgwPAieROvAcapTcbFwBjg6lYKQkc3oAvU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XZ15T3g60z2FbWw;
	Thu, 24 Oct 2024 17:36:45 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id E1D6E14037C;
	Thu, 24 Oct 2024 17:38:09 +0800 (CST)
Received: from [10.67.120.135] (10.67.120.135) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 17:38:09 +0800
Subject: Re: [PATCH V2 net 2/9] net: hns3: add sync command to sync io-pgtable
To: Paolo Abeni <pabeni@redhat.com>, Jijie Shao <shaojijie@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<salil.mehta@huawei.com>
CC: <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <lanhao@huawei.com>,
	<chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241018101059.1718375-1-shaojijie@huawei.com>
 <20241018101059.1718375-3-shaojijie@huawei.com>
 <214d37cc-96c0-4d47-bea0-3985e920d88c@redhat.com>
From: "shenjian (K)" <shenjian15@huawei.com>
Message-ID: <e8f83833-940a-3542-5c68-3dc25a230383@huawei.com>
Date: Thu, 24 Oct 2024 17:38:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <214d37cc-96c0-4d47-bea0-3985e920d88c@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)


在 2024/10/24 16:36, Paolo Abeni 写道:
> On 10/18/24 12:10, Jijie Shao wrote:
>> From: Jian Shen <shenjian15@huawei.com>
>>
>> To avoid errors in pgtable prefectch, add a sync command to sync
>> io-pagtable.
>>
>> In the case of large traffic, the TX bounce buffer may be used up.
> It's unclear to me what do you mean for large traffic. Is that large
> packets instead?
>
> Skimming over the previous patch, it looks like the for the bugger H/W
> driver will use the bounce buffer for all packets with len < 64K. As
> this driver does not support big tcp, such condition means all packets.
>
> So its not clear to me the 'may' part - it looks like the critical path
> will always happen on the bugged H/W

Sorry for the unclear commit log.

Yes, we don't support big tcp, so <64K is worked for all packets. The 
large traffic

here is just want to describe a case that tx bounce buffer is used up, 
and there is

no enough space for new tx packets.


>> At this point, we go to mapping/unmapping on TX path again.
>> So we added the sync command in driver to avoid hardware issue.
> I thought the goal of the previous patch was to avoid such sync-up.
>
> So I don't understand why it's there.
>
> A more verbose explanation will help.

This is a supplement for the previous patch. We want all the tx packet can

be handled with tx bounce buffer path. But it depends on the remain space

of the spare buffer, checked by the function hns3_can_use_tx_bounce(). In

most cases, maybe 99.99%, it returns true. But once it return false by no

available space, the packet will be handled with the former path, which

will map/unmap the skb buffer. Then we will face the smmu prefetch risk 
again.

So I add a sync command in this case to avoid smmu prefectch,

just protects corner scenes.


>> Signed-off-by: Jian Shen <shenjian15@huawei.com>
>> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Also we need a fixes tag.

We considered this issue, and since this is not a software defect, we 
were not too

sure which commit should be blamed.

It makes sense to choose the commit introducing the support for the 
buggy H/W, we will add

it.


Thanks!

Jian Shen


> Thanks,
>
> Paolo
>
>
> .
>

