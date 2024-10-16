Return-Path: <netdev+bounces-136140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498F39A0888
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 13:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E101F232AE
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247BC20897C;
	Wed, 16 Oct 2024 11:37:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83C92076CB;
	Wed, 16 Oct 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078633; cv=none; b=XoQnZJYFVaIxSzGJfyeflYGSSAKWfA0MtjogE0EynmEV5IiFFLAniHdPT3uXS//RJ0iifGfjlbFjmQUM7PIURpAqVKq9jYnhEBWpAG1rjmbzpB7an7tphQuT9npb7h/cdbzEAvmlzIrNqJ7s9SvCbf2iDKLqNUC2Gzu3au43gjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078633; c=relaxed/simple;
	bh=XmT6/qpQYuafRC7vpReyn5bI9r22CRroPgAxEDA1uww=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tlu7JxxF3Ib9IPeUVjd4llQfah6h2XnNneYUW5GglZqzlKYyjIcU6xfnDLSZWBW6fqz8ezsnfFuzS+4J9rqsafBXNQIVtL2vTkDsApvxSbaQHdTkp0C88za+QFm0LzGSLytkYU25c5l5GhKR1oTvHPYNvuoaqZUVedb9ckPGFrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XT8893jccz1xx82;
	Wed, 16 Oct 2024 19:37:13 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D3EA180042;
	Wed, 16 Oct 2024 19:37:07 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 19:37:06 +0800
Message-ID: <67bf12d3-db22-4344-aaa3-9e40c7a0ea52@huawei.com>
Date: Wed, 16 Oct 2024 19:37:05 +0800
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
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

The SMMU engine on HIP09 chip has a hardware issue. SMMU pagetable 
prefetch features may prefetch and use a invalid PTE even the PTE is 
valid at that time. This will cause the device trigger fake pagefaults. 
The solution is to avoid prefetching by adding a SYNC command when smmu 
mapping a iova. But the performance of nic has a sharp drop. Then we do 
this workaround, always enable tx bounce buffer, avoid mapping/unmapping 
on TX path. This issue only affects HNS3, so we always enable tx bounce 
buffer to improve performance. Thanks， Jijie Shao


