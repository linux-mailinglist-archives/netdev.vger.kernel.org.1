Return-Path: <netdev+bounces-135620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8935A99E877
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9891C2231E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321C01EABA8;
	Tue, 15 Oct 2024 12:06:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FC91EBFF5;
	Tue, 15 Oct 2024 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993966; cv=none; b=bYYE5XLrWaF4Q5M85O+GC6uuT/f4mZbsFNva5d9Yjpr4mYLJhphz8smAiOASsKjpzpR2dzXIfQjtR6yn4XHO2De7o9+suSFwzttvC8wd9BA72NQpPzMAPwr152k6uGoFc58+TdsTa+el5ed7r+5SpV5HpJTlAKViI4Dbb2xzDRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993966; c=relaxed/simple;
	bh=7HYLHQnjC/lS+BhsffFXfrfGzpb+/qTKgWGBH4Y2fp8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WzZv0g51ZYl4CN7frfpNI7WGdxTk7MVsnfLxk0Z7PC9vKznY2D9fkvo65rhkYtzCrTIbmdeXRFnkyHYBaz8p6q0imQoTPl1XGiE57ybpggoGJ3PA8SUA6rebmYW6AR1CoQJZvNJG99X78mdkzQ+VGbdZM0VhZ0SmR4wGRQKtFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XSXnt5N71z2DdVZ;
	Tue, 15 Oct 2024 20:04:18 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id BA7711A016C;
	Tue, 15 Oct 2024 20:05:31 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:05:30 +0800
Message-ID: <25f04101-d92a-466e-9824-098e7c723188@huawei.com>
Date: Tue, 15 Oct 2024 20:05:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <andrew@lunn.ch>, <jdamato@fastly.com>,
	<horms@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>,
	<christophe.jaillet@wanadoo.fr>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V12 net-next 07/10] net: hibmcge: Implement rx_poll
 function to receive packets
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>
References: <20241010142139.3805375-1-shaojijie@huawei.com>
 <20241010142139.3805375-8-shaojijie@huawei.com>
 <2dd71e95-5fb2-42c9-aff0-3189e958730a@redhat.com>
 <44023e6f-5a52-4681-84fc-dd623cd9f09d@huawei.com>
 <ee1205d6-3d6b-447f-991e-903936d45ac7@redhat.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <ee1205d6-3d6b-447f-991e-903936d45ac7@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/15 19:57, Paolo Abeni wrote:
> On 10/15/24 13:41, Jijie Shao wrote:
>> on 2024/10/15 18:28, Paolo Abeni wrote:
>>> Side note: the above always uses the maximum MTU for the packet size,
>>> if the device supports jumbo frames (8Kb size packets), it will
>>> produce quite bad layout for the incoming packets... Is the device
>>> able to use multiple buffers for the incoming packets?
>>
>> In fact, jumbo frames are not supported in device, and the maximum 
>> MTU is 4Kb.
>
> FTR, even 4Kb is bad enough: tiny packets (tcp syn, UDP dns req) will 
> use a truesize above 5K. You can get a much better the layout using 
> copybreak.
>
> Cheers,
>
> Paolo

Sorry, Actually 4KB。the default mtu is 1500


