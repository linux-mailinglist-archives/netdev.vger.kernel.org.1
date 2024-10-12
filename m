Return-Path: <netdev+bounces-134795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2809699B35D
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 13:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACBB285645
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 11:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E2C145A1C;
	Sat, 12 Oct 2024 11:16:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69472B9A9;
	Sat, 12 Oct 2024 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731778; cv=none; b=srW/MODOoW3HgEWB5Sn9d2BSbc1e/RYq25peZMGKG3clAJJL/8oZ1/8XeFNO4+3/qk2mJUdOzv8tCQhGuku9lHr1Mh0+FsaBKPtSShK4nHT91SAlAIWs4qpTSNKluVtbRsPQGcyjFWjw0ixHr1L5cJajUE0O/4oZNktqzFRzRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731778; c=relaxed/simple;
	bh=3VkUv22cBbsez+d4gFS6qiQBa0yFs/qqI5re8YUOiT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J4VfLYGomlfmSIK+0e3ovTcJzHpFdlkvxqYDVhB+KJkfMMwj+a8xuw90rYpnE1oUW/O7YwOQOtd3TOs2PfWKnaWG5s1X6/EyS03VpbdWCqmAAxNvFyFk4pKGe4oHwxYQIDmbGp4z4cToyKoP9Aelw1azsouqDkhp+PMvRp+Fp1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XQgqK2Q8NzpWPj;
	Sat, 12 Oct 2024 19:14:05 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (unknown [7.193.23.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 80C591402CB;
	Sat, 12 Oct 2024 19:16:04 +0800 (CST)
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 12 Oct 2024 19:16:03 +0800
Message-ID: <539a13f9-d3b8-43f0-a5a4-158261408c07@huawei.com>
Date: Sat, 12 Oct 2024 19:16:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: aeroflex: fix potential memory leak in
 greth_start_xmit_gbit()
To: Gerhard Engleder <gerhard@engleder-embedded.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<andreas@gaisler.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <kristoffer@gaisler.com>
References: <20241011113908.43966-1-wanghai38@huawei.com>
 <3d26ab3e-2a3c-4c36-b165-06a1029bb0b0@engleder-embedded.com>
Content-Language: en-US
From: Wang Hai <wanghai38@huawei.com>
In-Reply-To: <3d26ab3e-2a3c-4c36-b165-06a1029bb0b0@engleder-embedded.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600001.china.huawei.com (7.193.23.3)


On 2024/10/12 4:41, Gerhard Engleder wrote:
> On 11.10.24 13:39, Wang Hai wrote:
>> The greth_start_xmit_gbit() returns NETDEV_TX_OK without freeing skb
>> in case of skb->len being too long, add dev_kfree_skb() to fix it.
>>
>> Fixes: d4c41139df6e ("net: Add Aeroflex Gaisler 10/100/1G Ethernet 
>> MAC driver")
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
>> ---
>>   drivers/net/ethernet/aeroflex/greth.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/aeroflex/greth.c 
>> b/drivers/net/ethernet/aeroflex/greth.c
>> index 27af7746d645..8f6835a710b9 100644
>> --- a/drivers/net/ethernet/aeroflex/greth.c
>> +++ b/drivers/net/ethernet/aeroflex/greth.c
>> @@ -484,6 +484,7 @@ greth_start_xmit_gbit(struct sk_buff *skb, struct 
>> net_device *dev)
>>         if (unlikely(skb->len > MAX_FRAME_SIZE)) {
>>           dev->stats.tx_errors++;
>> +        dev_kfree_skb(skb);
>>           goto out;
>
> dev_kfree_skb(skb) is already part of the error handling, one line above
> the "out" label. Why don't you just add another label which includes
> dev_kfree_skb(skb) and goto that label?
>
> Gerhard

Hi, Gerhard.

Thanks for the suggestion, I just sent the v2 version.

[PATCH v2 net] net: ethernet: aeroflex: fix potential memory leak in 
greth_start_xmit_gbit()



