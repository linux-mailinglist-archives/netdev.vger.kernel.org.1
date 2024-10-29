Return-Path: <netdev+bounces-139757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DD89B3FC2
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 02:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B00B28335C
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 01:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DBD73477;
	Tue, 29 Oct 2024 01:31:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E5D126BE6;
	Tue, 29 Oct 2024 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730165471; cv=none; b=TEYMpGxBR15g8+qxDQVX9rvYFWVBW2F9v8jLB5/iqPgLSDP3T6PGimxXskdr5zcsUasDxQoubW6bWk8TVM1NxcCdg+Y13GDscUU5wxpvDXkhmRGh0ubx8yWbbrFn2Lmf1a2W6afQu5hZDXXNaih0N/mt6hpZU+GtBI4y9EJy+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730165471; c=relaxed/simple;
	bh=JAqAv0C+GuV/zTwM4dv+mBDukOTwjKtbkYEQ/98gOPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IF5R1Lrsurl62k37QXM9UslkVvULVXIVGFQK9fSMoopZrX5x2cMK+9R/XwzZ34TfijX3wY8yKp+vtZVoUjbWaufEoXYgOv6YfrKF5TYEZAmag3IgSWSbr9Ep37NkLQHlsaxO9nIrpSdO1Ni15Xl/4nVR9VkBeAuAlZ3QJfDrMM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xct1l36V4zfdDM;
	Tue, 29 Oct 2024 09:28:27 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 626F8180064;
	Tue, 29 Oct 2024 09:31:00 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Oct 2024 09:30:59 +0800
Message-ID: <a88119f3-3968-e072-6caa-8229e2e470bf@huawei.com>
Date: Tue, 29 Oct 2024 09:30:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net] netlink: Fix off-by-one error in netlink_proto_init()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <a.kovaleva@yadro.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<lirongqing@baidu.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
References: <20241028080515.3540779-1-ruanjinjie@huawei.com>
 <20241028182421.6692-1-kuniyu@amazon.com>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241028182421.6692-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/10/29 2:24, Kuniyuki Iwashima wrote:
> From: Jinjie Ruan <ruanjinjie@huawei.com>
> Date: Mon, 28 Oct 2024 16:05:15 +0800
>> In the error path of netlink_proto_init(), frees the already allocated
>> bucket table for new hash tables in a loop, but the loop condition
>> terminates when the index reaches zero, which fails to free the first
>> bucket table at index zero.
>>
>> Check for >= 0 so that nl_table[0].hash is freed as well.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  net/netlink/af_netlink.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
>> index 0a9287fadb47..9601b85dda95 100644
>> --- a/net/netlink/af_netlink.c
>> +++ b/net/netlink/af_netlink.c
>> @@ -2936,7 +2936,7 @@ static int __init netlink_proto_init(void)
>>  	for (i = 0; i < MAX_LINKS; i++) {
>>  		if (rhashtable_init(&nl_table[i].hash,
>>  				    &netlink_rhashtable_params) < 0) {
>> -			while (--i > 0)
>> +			while (--i >= 0)
>>  				rhashtable_destroy(&nl_table[i].hash);
>>  			kfree(nl_table);
>>  			goto panic;
> 
> I remember the same question was posted in the past.
> https://lore.kernel.org/netdev/ZfOalln%2FmyRNOkH6@cy-server/
> 
> As Eric alreday pointed out (and as mentioned in the thread above too),
> it's going to panic, and we need not clean up resources here, so let's
> remove rhashtable_destroy() and kfree() instead of adjusting the loop
> condition.

Thank you very much, remove it is fine.

> 

