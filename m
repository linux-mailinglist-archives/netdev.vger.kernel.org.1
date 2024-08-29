Return-Path: <netdev+bounces-123041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FF6963835
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 04:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEEFE2857EF
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B398322EF0;
	Thu, 29 Aug 2024 02:32:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9041E4C70;
	Thu, 29 Aug 2024 02:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724898760; cv=none; b=FZbJhh9laqM3l3QydaUJesg1O0KK3plLY5QsRfsIoDikkvRlI3SxGB8IjTU2oNE1Jz9XmVS85PzIrN7B8b6hjE2XQ/2dWNRyicsYbL9WyuCOAKWNnX4qXkN3S49xk+5JEa1weRykGbvudYpFBHr3hu10iUykW0Y0MeXd/DU3eBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724898760; c=relaxed/simple;
	bh=+gYMgrzYbBYnKqgQoT73eCkdic2wIQKKFdgu6jv/Utc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JEagoxwLdVO3UoHmS7vGLqEt+eN8WGThcMg69/lzNkUiwln7BOJnH0VA4aZ/G679cKWIuwC5Ouq+ZlHL3sdufpIZs2IUocpWirT3YAQplTD3yGiTKo1CnC1FbuHNdzons0+V2PcAQRrcWx4Sj8blv1EyD4z6exyOxzPAOa9Hpkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WvQHd0GHYz1xwW0;
	Thu, 29 Aug 2024 10:30:37 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id EFC7A1A016C;
	Thu, 29 Aug 2024 10:32:34 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 10:32:33 +0800
Message-ID: <df861206-0a7a-4744-98f6-6335303d29ef@huawei.com>
Date: Thu, 29 Aug 2024 10:32:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 06/11] net: hibmcge: Implement .ndo_start_xmit
 function
To: Jakub Kicinski <kuba@kernel.org>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
 <20240827131455.2919051-7-shaojijie@huawei.com>
 <20240828184120.07102a2f@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240828184120.07102a2f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/29 9:41, Jakub Kicinski wrote:
> On Tue, 27 Aug 2024 21:14:50 +0800 Jijie Shao wrote:
>> @@ -111,6 +135,14 @@ static int hbg_init(struct hbg_priv *priv)
>>   	if (ret)
>>   		return ret;
>>   
>> +	ret = hbg_txrx_init(priv);
>> +	if (ret)
>> +		return ret;
> You allocate buffers on the probe path?
> The queues and all the memory will be sitting allocated but unused if
> admin does ip link set dev $eth0 down?

The network port has only one queue and
the TX queue depth is 64, RX queue depth is 127.
so it doesn't take up much memory.

Also, I plan to add the self_test feature in a future patch.
If I don't allocate buffers on the probe path,
I won't be able to do a loopback test if the network port goes down unexpectedly.

So, if there are no other constraints, I prefer to alloc buffer memory in probe path.

	Thanks,
	Jijie Shao


