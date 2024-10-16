Return-Path: <netdev+bounces-136141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFE39A0899
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 13:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B2E287BFF
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B7F206E9C;
	Wed, 16 Oct 2024 11:44:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B47206066;
	Wed, 16 Oct 2024 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079054; cv=none; b=PDUU7mZ+Udsk+QvE/9FTQZG6Nk9F0xshwv5p2RdQ2zBeawRrqu0F+KK8D4NF66wFILV592omRzqRkpwOCk+8O9RsImcKyMb8iEeLevaI1TZKEGXZNQDiibbD+JMByVI3TMv0kgzazZPCeH1l6u2svV/gN54DSzqoWiP7TKZ/lhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079054; c=relaxed/simple;
	bh=lWu/eJGxWC/MEmN5hUSxpztsApgCY9co9LzEtyYVJ8M=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ps4H8BUhpy3JhqJduRO1NFn8BxxPTn7iOTuqQQGfhXDmUyFN9pULg7kAI3nA4NNLBkQjRkgMALPxPoBrjwQuEfGVymroBGvySHu6u+34OlTKYmQuxuTWVoMhpSqypE/H7xd6US5VDveLF15TuzMQcf4Nh+LaJD3jFQTbdPVSpFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XT8GY2qg1zyTCr;
	Wed, 16 Oct 2024 19:42:45 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 5620F140257;
	Wed, 16 Oct 2024 19:44:09 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 19:44:08 +0800
Message-ID: <cf89bdd3-9c1a-4cc0-ba64-2b66e5ff2a4c@huawei.com>
Date: Wed, 16 Oct 2024 19:44:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <salil.mehta@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <lanhao@huawei.com>,
	<chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/9] net: hns3: default enable tx bounce buffer when
 smmu enabled
To: Jakub Kicinski <kuba@kernel.org>
References: <20241011094521.3008298-1-shaojijie@huawei.com>
 <20241011094521.3008298-2-shaojijie@huawei.com>
 <20241015181657.14fe9227@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241015181657.14fe9227@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/16 9:16, Jakub Kicinski wrote:
> On Fri, 11 Oct 2024 17:45:13 +0800 Jijie Shao wrote:
>> From: Peiyang Wang <wangpeiyang1@huawei.com>
>>
>> When TX bounce buffer is enabled, dma map is used only when the buffer
>> initialized. When spending packages, the driver only do dma sync. To
> packages -> packets
>
>> avoid SMMU prefetch, default enable tx bounce buffer if smmu enabled.
> you seem to force it to be enabled, rather than just changing
> the default. That is strange. Why not let the user lower the value?
>
> Also I don't see why this is a fix. Seems like a performance
> improvement.

Sorry, there's a problem with the layout of the first reply.

The SMMU engine on HIP09 chip has a hardware issue.
SMMU pagetable prefetch features may prefetch and use a invalid PTE
even the PTE is valid at that time. This will cause the device trigger fake pagefaults.
The solution is to avoid prefetching by adding a SYNC command when smmu mapping a iova.
But the performance of nic has a sharp drop. Then we do this workaround, always enable tx bounce buffer,
avoid mapping/unmapping on TX path.

This issue only affects HNS3, so we always enable tx bounce buffer to improve performance.

Thanks
Jijie Shao




