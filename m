Return-Path: <netdev+bounces-124067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D86967D56
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 03:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65447B212FD
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 01:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0961175A5;
	Mon,  2 Sep 2024 01:27:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC04171C9;
	Mon,  2 Sep 2024 01:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725240477; cv=none; b=lvpzOLfduuOEl7xUzpPf3leFT1hjD+HXQfQTaNNT28wvN7GN8tFmm1t8yT9Y9WtU416XNjuTwr7j+PqrSeG63oT2c6t3kWNDD7I0jnCqNkGmCJ/doPXtEZnCU3L6EyHuTxO6NrAXiKuwMpT5/AvhIaf4t2LnL6kE/+4BTi6mQwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725240477; c=relaxed/simple;
	bh=G+UAgqhT/VjKnWynqGylXvw0SEuYscTjATUtVIIOxuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qiy+1MKZ1enKupAJh9Z934zCjYEeJ81TJfA5d6eSMIG6GL4itHNqffiLm7odLNqVXnepCvHU9xwIupPH3T8ZViAXV3y8Ds6r8mEgAbvsZ9qMX1k1s3lsqMzOXcB3Y3L5nTXoIx+Rb9uq1Q/oUH/uZ4k1SUcn3nMV+HWayvs7gVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WxrhK5Dbdz1BFLk;
	Mon,  2 Sep 2024 09:26:57 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id F04031800A7;
	Mon,  2 Sep 2024 09:27:51 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 09:27:51 +0800
Message-ID: <5b1b6fbc-6135-47ae-af32-60ef71595666@huawei.com>
Date: Mon, 2 Sep 2024 09:27:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/4] tun: Make use of str_disabled_enabled helper
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <kees@kernel.org>, <andy@kernel.org>, <willemdebruijn.kernel@gmail.com>,
	<jasowang@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <akpm@linux-foundation.org>,
	<linux-hardening@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20240831095840.4173362-1-lihongbo22@huawei.com>
 <20240831095840.4173362-3-lihongbo22@huawei.com>
 <20240831130741.768da6da@kernel.org>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240831130741.768da6da@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/9/1 4:07, Jakub Kicinski wrote:
> On Sat, 31 Aug 2024 17:58:38 +0800 Hongbo Li wrote:
>> Use str_disabled_enabled() helper instead of open
>> coding the same.
> 
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 6fe5e8f7017c..29647704bda8 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -3178,7 +3178,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>   
>>   		/* [unimplemented] */
>>   		netif_info(tun, drv, tun->dev, "ignored: set checksum %s\n",
>> -			   arg ? "disabled" : "enabled");
>> +			   str_disabled_enabled(arg));
> 
> You don't explain the 'why'. How is this an improvement?
> nack on this and 2 similar networking changes you sent
> 
This just give an example of using lib/string_choices' helper which 
prevents the function from being removed due to detection of non-use. 
These helpers are convenient. It's functionally equivalent, this avoids 
the dispersion of such writing styles( ? XXX : noXXX) everywhere.

Thanks,
Hongbo

