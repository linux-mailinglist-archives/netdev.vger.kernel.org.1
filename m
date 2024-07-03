Return-Path: <netdev+bounces-108852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325EB92607B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652781C2233F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE51178369;
	Wed,  3 Jul 2024 12:36:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A316EC0F;
	Wed,  3 Jul 2024 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010181; cv=none; b=S3MAagJoOdAnh5+1UVbx1S7/ihJagyLnZxLa89AQX3lgd9xg/ei6twciW9WXFYxebxLXAQ4gbf8O+CBJ72rjKt/LB3csBoM/DfwsDM08j390bKTsm8I7CJgxJuHfDJ3abTBozJPPgxoa7UtqaOSbWxdeUj8FnnDtPxaky9/5k/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010181; c=relaxed/simple;
	bh=uMXn3Tgos8fGdrRn6yNxIH22isFtg2IbdQ5k7ajZXjc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FSOlh7f5704JrkX3vnaN8YHSOX8BZQO9K6AlWtsjGN1GvJ3NbScwzCq/W5LUV/QqjfzboBPak8u3Rx/UiX0Mw4HBbur8kToawJL2lP9rZa+nZoZx6ii1LJIWu22dnieuIulkGyY6OQpZsGpJcob5H4Jixa3OlMTS6uCp88nRNoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WDfLP0v47zQk7Y;
	Wed,  3 Jul 2024 20:32:29 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B65A180087;
	Wed,  3 Jul 2024 20:36:17 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Jul
 2024 20:36:17 +0800
Subject: Re: [PATCH net-next v9 09/13] net: introduce the
 skb_copy_to_va_nocache() helper
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-10-linyunsheng@huawei.com>
 <16f0d900bff994c1e23fe3862c3953819bf6a63a.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <d2e4d25d-33d8-22d9-c5e0-16be802ad39a@huawei.com>
Date: Wed, 3 Jul 2024 20:36:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <16f0d900bff994c1e23fe3862c3953819bf6a63a.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/2 23:52, Alexander H Duyck wrote:
> On Tue, 2024-06-25 at 21:52 +0800, Yunsheng Lin wrote:
>> introduce the skb_copy_to_va_nocache() helper to avoid
>> calling virt_to_page() and skb_copy_to_page_nocache().
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  include/net/sock.h | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index cce23ac4d514..7ad235465485 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -2201,6 +2201,21 @@ static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_iter *fro
>>  	return 0;
>>  }
>>  
>> +static inline int skb_copy_to_va_nocache(struct sock *sk, struct iov_iter *from,
>> +					 struct sk_buff *skb, char *va, int copy)
>> +{
>> +	int err;
>> +
>> +	err = skb_do_copy_data_nocache(sk, skb, from, va, copy, skb->len);
>> +	if (err)
>> +		return err;
>> +
>> +	skb_len_add(skb, copy);
>> +	sk_wmem_queued_add(sk, copy);
>> +	sk_mem_charge(sk, copy);
>> +	return 0;
>> +}
>> +
>>  /**
>>   * sk_wmem_alloc_get - returns write allocations
>>   * @sk: socket
> 
> One minor nit. Rather than duplicate skb_copy_to_page_nocache you would
> be better served to implement this one before it, and then just update
> skb_copy_to_page_nocache to be:
> 	return skb_copy_to_va_nocache(sk, from, skb,
> 				      page_address(page) + off, copy);
> 
> We can save ourselves at least a few lines of code that way and it
> creates one spot to do any changes.

Looking at more closely, it seems we may be able to just rename
skb_copy_to_page_nocache() to skb_copy_to_va_nocache() as there
is no caller for skb_copy_to_page_nocache() after this patchset.

> 				
> .
> 

