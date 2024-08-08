Return-Path: <netdev+bounces-116854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF60994BDF9
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772BE1F214D2
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F091891AC;
	Thu,  8 Aug 2024 12:52:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6F4149DFA
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723121579; cv=none; b=Dt0aByZxa9OaP6aurH+2oIPlGZOPTNKlKwjshwHf1iJWxc3ycCAU3e221GYWmpkvGi/Ux7XMLjiIO46ia7j52rzZTW9XVO9N6h0zk2qMRkdQ2HqQ76Pj8w3KYDfSNyyZ0snMfDjxAg8hhgM/+7TpCjnRlTPrqmlk/gP4AHuxZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723121579; c=relaxed/simple;
	bh=+DbrqPF6QaIBT1E2YsIpWp0lUcV08SCCHuIGXTHKcd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XhFkBFAR5VmQ9u4+WwptEva3r931Ka56VHTg6JV37ALyJ/JoSEz3PMZi8Eqc3JGg2wVHYCe06xEm+yAGr2XCfbSE7YsyXVcw7m+ANQkGAeuG362Xw5I7XqKvsDNHYV9L/rlveMri+Dp0RJK3doYaD4xdAhdcxtFFQn16/7rwHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wfn1v4k2qz1HFxM;
	Thu,  8 Aug 2024 20:49:55 +0800 (CST)
Received: from kwepemf200007.china.huawei.com (unknown [7.202.181.233])
	by mail.maildlp.com (Postfix) with ESMTPS id 818F8180018;
	Thu,  8 Aug 2024 20:52:53 +0800 (CST)
Received: from [10.67.121.184] (10.67.121.184) by
 kwepemf200007.china.huawei.com (7.202.181.233) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 20:52:52 +0800
Message-ID: <977c3d82-e2f0-4466-9100-7ea781e91ce1@huawei.com>
Date: Thu, 8 Aug 2024 20:52:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net] net: make page pool stall netdev unregistration to
 avoid IOMMU crashes
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Yunsheng Lin <linyunsheng@huawei.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <ilias.apalodimas@linaro.org>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>
References: <20240806151618.1373008-1-kuba@kernel.org>
 <523894ab-2d38-415f-8306-c0d1abd911ec@huawei.com>
 <20240807072908.1da91994@kernel.org>
From: Yonglong Liu <liuyonglong@huawei.com>
In-Reply-To: <20240807072908.1da91994@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf200007.china.huawei.com (7.202.181.233)


On 2024/8/7 22:29, Jakub Kicinski wrote:
> On Wed, 7 Aug 2024 19:00:35 +0800 Yunsheng Lin wrote:
>>> Note that page pool pages may last forever, we have seen it happen
>>> e.g. when application leaks a socket and page is stuck in its rcv queue.
>> We saw some page_pool pages might last forever too, but were not sure
>> if it was the same reason as above? Are there some cmds/ways to debug
>> if a application leaks a socket and page is stuck in its rcv queue?
> I used drgn to scan all sockets to find the page.

I hooks the netdev to the page pool, and run with this patch for a 
while, then get

the following messages, and the vf can not disable:

[ 1950.137586] hns3 0000:7d:01.0 eno1v0: link up
[ 1950.137671] hns3 0000:7d:01.0 eno1v0: net open
[ 1950.147098] 8021q: adding VLAN 0 to HW filter on device eno1v0
[ 1974.287476] hns3 0000:7d:01.0 eno1v0: net stop
[ 1974.294359] hns3 0000:7d:01.0 eno1v0: link down
[ 1975.596916] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1976.744947] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1977.900916] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1979.080929] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1980.236914] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1981.384913] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1982.568918] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1983.720912] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1984.584941] unregister_netdevice: waiting for eno1v0 to become free. 
Usage count = 2
[ 1984.872930] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1986.024924] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1987.176927] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1988.328922] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1989.480917] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1990.632913] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1991.784915] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister

...

[ 8640.008931] unregister_netdevice: waiting for eno1v0 to become free. 
Usage count = 2
[ 8640.300912] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 8641.452910] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 8642.600939] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 8643.756914] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 8644.904922] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 8646.060910] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 8647.208909] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 8648.360931] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister


I install drgn, but don't know how to find out the using pages, would 
you guide me on how to use it?

>>> Hopefully this is fine in this particular case, as we will only stall
>>> unregistering of devices which want the page pool to manage the DMA
>>> mapping for them, i.e. HW backed netdevs. And obviously keeping
>>> the netdev around is preferable to a crash.

