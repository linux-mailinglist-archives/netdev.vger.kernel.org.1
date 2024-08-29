Return-Path: <netdev+bounces-123273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A8F964599
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA461C24152
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6094718A6D1;
	Thu, 29 Aug 2024 12:57:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7022339;
	Thu, 29 Aug 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936266; cv=none; b=XoXtLKe+jZDs6KUObDJMup2DTI2LeChAJtt1SCGyFkJXSGptSMQ7bmdcuN/6UYUckYZbh/CCXGoCv29iLhu6jLCIvXTQRGVImuHqlVTMq0t2TeT9WxxPAKMxWFs9ufB1pDvKEDXgwFMT0qgivbnvuBsfbTlGtAxEX7DY/Kaia3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936266; c=relaxed/simple;
	bh=rOnSi1Nhncfu5v6nwMQwEoIkqvXNF7pDJBVkmLJkhXE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BSsxE7Muw89XhmKojDQ4gmLGlew91GPLmWpcwRs4IVbB+09im38xEfCBBxir9SclUpiyiKhQa5FHNZGel3lnggrLFTJth22oTv38ipRYZ2tGytpGUIentYXJXQOtTuGb9A/msE5jZypvz/A3NaAh5dXEUvvjBbMfkhXWm5iuj1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wvh7G5RKWz1HGQs;
	Thu, 29 Aug 2024 20:54:18 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id B28081A0188;
	Thu, 29 Aug 2024 20:57:39 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 20:57:38 +0800
Message-ID: <cbed13c5-906a-4960-8994-ba745866e6ee@huawei.com>
Date: Thu, 29 Aug 2024 20:57:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Jakub Kicinski <kuba@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
	<shiyongbang@huawei.com>, <libaihan@huawei.com>, <jdamato@fastly.com>,
	<horms@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 06/11] net: hibmcge: Implement .ndo_start_xmit
 function
To: Andrew Lunn <andrew@lunn.ch>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
 <20240827131455.2919051-7-shaojijie@huawei.com>
 <20240828184120.07102a2f@kernel.org>
 <df861206-0a7a-4744-98f6-6335303d29ef@huawei.com>
 <83dce3bb-28c6-4021-a343-cff2410a463f@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <83dce3bb-28c6-4021-a343-cff2410a463f@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/29 11:02, Andrew Lunn wrote:
> On Thu, Aug 29, 2024 at 10:32:33AM +0800, Jijie Shao wrote:
>> on 2024/8/29 9:41, Jakub Kicinski wrote:
>>> On Tue, 27 Aug 2024 21:14:50 +0800 Jijie Shao wrote:
>>>> @@ -111,6 +135,14 @@ static int hbg_init(struct hbg_priv *priv)
>>>>    	if (ret)
>>>>    		return ret;
>>>> +	ret = hbg_txrx_init(priv);
>>>> +	if (ret)
>>>> +		return ret;
>>> You allocate buffers on the probe path?
>>> The queues and all the memory will be sitting allocated but unused if
>>> admin does ip link set dev $eth0 down?
>> The network port has only one queue and
>> the TX queue depth is 64, RX queue depth is 127.
>> so it doesn't take up much memory.
>>
>> Also, I plan to add the self_test feature in a future patch.
>> If I don't allocate buffers on the probe path,
>> I won't be able to do a loopback test if the network port goes down unexpectedly.
> When you come to implement ethtool --set-ring, you will need to
> allocate and free the ring buffers outside of probe.
>
> 	Andrew

We discussed this internally, and now we have a problem that we can't solve:

After allocate ring buffers, the driver will writes the address to the hardware FIFO
for receiving packets.

However, FIFO does not have a separate interface to clear ring buffers address.

If ring buffers can be allocated and released on other paths,
the driver buffer address is inconsistent with the hardware buffer address.
As a result, packet receiving is abnormal. The fault is rectified only
after the buffers of a queue depth are used up and new buffers are allocated for.

Actually, the buffer will be released during FLR reset and are allocated again after reset.
In this case, the FIFO are cleared. Therefore, driver writes the ring buffer address
to the hardware again to ensure that the driver address is the same as the hardware address.

If we do an FLR every time we allocate ring buffers on other path, It is expensive.

We will not implement re-allocate ring buffer interfaces like ethtool --set-ring.

	Thanks
	Jijie Shao



