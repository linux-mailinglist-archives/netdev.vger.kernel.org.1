Return-Path: <netdev+bounces-116641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96D794B481
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B60281B01
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 01:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA8C4A33;
	Thu,  8 Aug 2024 01:12:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78634A21
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723079523; cv=none; b=UuwJC3bFNtZAnkllfPsuYX6KVi1GK0DiwQGPKIjmETlxy51frQJgvyfQDx42FieGbVfzTPwBBmwISWyukKdN2A1BxsZh5JG7VpcRta4WJVpVVKxOHsmmI3JZiKJRXOE9/Ir53h0lroLxy/V25RZaSJUK6qrOgxhnKH3PuC+a1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723079523; c=relaxed/simple;
	bh=LlMYzfeeJE8EFlILMUvgPZ81lO5MaaBDL5MPag94n4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MB/h8oz9EZG6mngLZFcHVE6mStTXdVwpf5JYigzd4/mnzXwrP/8y2my0rUQv+DfISdDKg7tLmZkebAgLuZb7Bd5qHRO9TB6a/c+pt0n1THS06qYdlT0xb1C70AeCgRgWL0bWLdxQZpdgEAonXQbyyHWzZYPwpKPW/eeJckCtDuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WfTR111yvz1j6MR;
	Thu,  8 Aug 2024 09:07:09 +0800 (CST)
Received: from kwepemf200007.china.huawei.com (unknown [7.202.181.233])
	by mail.maildlp.com (Postfix) with ESMTPS id AEA661400CB;
	Thu,  8 Aug 2024 09:11:52 +0800 (CST)
Received: from [10.67.121.184] (10.67.121.184) by
 kwepemf200007.china.huawei.com (7.202.181.233) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 09:11:52 +0800
Message-ID: <6a7dba70-6179-4027-be70-65544f5bf912@huawei.com>
Date: Thu, 8 Aug 2024 09:11:51 +0800
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
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <ilias.apalodimas@linaro.org>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Yunsheng Lin
	<linyunsheng@huawei.com>
References: <20240806151618.1373008-1-kuba@kernel.org>
 <e4b58020-4ff8-44bc-9779-54bc9e1bf593@huawei.com>
 <20240807072710.0e7934e1@kernel.org>
From: Yonglong Liu <liuyonglong@huawei.com>
In-Reply-To: <20240807072710.0e7934e1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf200007.china.huawei.com (7.202.181.233)


On 2024/8/7 22:27, Jakub Kicinski wrote:
> On Wed, 7 Aug 2024 15:03:06 +0800 Yonglong Liu wrote:
>> I tested this patch, have the same crash as I reported...
> Which driver, this is only gonna work if the driver hooks the netdev
> to the page pool. Which is still rare for drivers lacking community
> involvement.
hns3 driver, we didn't hooks the netdev to the page pool, will try this 
later, thanks : )

