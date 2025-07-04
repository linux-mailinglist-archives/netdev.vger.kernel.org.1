Return-Path: <netdev+bounces-204050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE984AF8ACA
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364151BC5AB9
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE952F530D;
	Fri,  4 Jul 2025 07:55:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9AF2F4315;
	Fri,  4 Jul 2025 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615706; cv=none; b=qulbYgToINrDMO9/64LnMI6mSXCiVBkqEsHymxWetF4lULwfdA1s7T0F39jXH53Ug0NZeMMIdBfxz3KyDJtWkJL3HgT2R2FZg3V0fcTWu1x9/KNvqUy9LgikegK+Jjwmf4xdyhfynhrSPNbi44iWSNuHlrhtq+O2/hDkzB48JNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615706; c=relaxed/simple;
	bh=x9A3hNhSIv1JfhUbvnxXKeblQ+dzPJLL+9vPRTOw4PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cpMiwwyCJGYU2WjxuWXAOHwlhA4Kuvs7vssCArtKmnUjfyNJ4RkuqNQwDmIeNx/oMKe4I9vwi5qpzQqnljMh1DN0Gbv31+iMvSiy3ipAjvmQ8mJp9PfoPnLPRkqPerfZ+EV8VYZemxTil69cqWTZfTfPAwe3GBLldVkUER73n1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bYQqD0Hdfz2BdWG;
	Fri,  4 Jul 2025 15:53:12 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B79B1402CB;
	Fri,  4 Jul 2025 15:55:00 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 4 Jul 2025 15:54:59 +0800
Message-ID: <d1bb9101-f826-4d79-a74d-dabcbcac351d@huawei.com>
Date: Fri, 4 Jul 2025 15:54:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] atm: clip: Fix NULL pointer dereference in vcc_sendmsg()
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
References: <20250704023914.3876975-1-yuehaibing@huawei.com>
 <20250704065353.1621693-1-kuniyu@google.com>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <20250704065353.1621693-1-kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/7/4 14:53, Kuniyuki Iwashima wrote:
> Please specify 'net' in subject:
> 
>   [PATCH net v2] atm: clip: ...
> 
> From: Yue Haibing <yuehaibing@huawei.com>
> Date: Fri, 4 Jul 2025 10:39:14 +0800
[...]
>> as above.
> 
> Please move commit message before the splat.

ok
> 
> 
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Reported-by: syzbot+e34e5e6b5eddb0014def@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/682f82d5.a70a0220.1765ec.0143.GAE@google.com/T
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>>  net/atm/clip.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/atm/clip.c b/net/atm/clip.c
>> index b234dc3bcb0d..c02ba9d64bc3 100644
>> --- a/net/atm/clip.c
>> +++ b/net/atm/clip.c
>> @@ -616,8 +616,15 @@ static void atmarpd_close(struct atm_vcc *vcc)
>>  	module_put(THIS_MODULE);
>>  }
>>  
>> +static int atmarpd_send(struct atm_vcc *vcc, struct sk_buff *skb)
>> +{
>> +	dev_kfree_skb_any(skb);
> 
> This is not enough, see:

Thanks, will check this and rework.

> commit 7851263998d4269125fd6cb3fdbfc7c6db853859
> Author: Kuniyuki Iwashima <kuniyu@google.com>
> Date:   Mon Jun 16 18:21:15 2025
> 
>     atm: Revert atm_account_tx() if copy_from_iter_full() fails.
> 
> 
>> +	return 0;
>> +}
>> +
>>  static const struct atmdev_ops atmarpd_dev_ops = {
>> -	.close = atmarpd_close
>> +	.close = atmarpd_close,
>> +	.send = atmarpd_send
>>  };
>>  
>>  
>> -- 
>> 2.34.1

