Return-Path: <netdev+bounces-115757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1B8947B3B
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4CA1C20F9B
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E6F158DC8;
	Mon,  5 Aug 2024 12:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C4D1E49F;
	Mon,  5 Aug 2024 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862227; cv=none; b=JTm1gmpwnBxu9Vn8gPtp4yCkQ8/8Mvg+TFSX3VanQTBiii913zoDe4I2knErmibOKGMADpSBxS51yjeH6HicORNMI3i/Su8AoNmKol0udyxgTOVJWalKZs40jgnSW1Ay0hp0Ak0ncTYADTgLKN5zBpLy/F5AngTlwUHoawyvo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862227; c=relaxed/simple;
	bh=WcZYtR0vQGiiG2E/rclHtMpg+6mjPk1BE2+xYZ8hRQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QwfVYWnHlDId+sssvUkkyDvX3L58VRk1VmtvhK5o/IQUEKQWg/GD/8F+/m7uZvSCGEMWUPwF5mW6Pj7aO+6RjDgoeKobi6hsdlZx/gD+g9s8zJrQk8PDGVzJWz4mAIkvlFR1enbIcK2mqcB9QEl+dTgJ2Ufi+fN5kG5hMUZzlKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wcx9S5J2Yz1L9s9;
	Mon,  5 Aug 2024 20:50:04 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B7A7E14037B;
	Mon,  5 Aug 2024 20:50:22 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 5 Aug 2024 20:50:22 +0800
Message-ID: <8d4b6398-1b7d-4c14-b390-0456a6158681@huawei.com>
Date: Mon, 5 Aug 2024 20:50:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at
 iommu_get_dma_domain+0xc/0x20
To: Alexander Duyck <alexander.duyck@gmail.com>, Yonglong Liu
	<liuyonglong@huawei.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<pabeni@redhat.com>, <hawk@kernel.org>, <ilias.apalodimas@linaro.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, "shenjian (K)" <shenjian15@huawei.com>, Salil Mehta
	<salil.mehta@huawei.com>, <iommu@lists.linux.dev>
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
 <8743264a-9700-4227-a556-5f931c720211@huawei.com>
 <CAKgT0Uf4xBJDLMxa3awSnzgZvbb-LN82APkPi7uVpWw+j7wqRA@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0Uf4xBJDLMxa3awSnzgZvbb-LN82APkPi7uVpWw+j7wqRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/3 0:38, Alexander Duyck wrote:

...

> 
> The issue as I see it is that we aren't unmapping the pages when we
> call page_pool_destroy. There need to be no pages remaining with a DMA
> unmapping needed *after* that is called. Otherwise we will see this
> issue regularly.
> 
> What we probably need to look at doing is beefing up page_pool_release
> to add a step that will take an additional reference on the inflight
> pages, then call __page_pool_put_page to switch them to a reference
> counted page.

I am not sure if I understand what you meant about, did you mean making
page_pool_destroy() synchronously wait for the all in-flight pages to
come back before returning to driver?

> 
> Seems like the worst case scenario is that we are talking about having
> to walk the page table to do the above for any inflight pages but it

Which page table are we talking about here?

> would certainly be a much more deterministic amount of time needed to
> do that versus waiting on a page that may or may not return.
> 
> Alternatively a quick hack that would probably also address this would
> be to clear poll->dma_map in page_pool_destroy or maybe in

It seems we may need to clear pool->dma_sync too, and there may be some
time window between clearing and checking/dma_unmap?

> page_pool_unreg_netdev so that any of those residual mappings would
> essentially get leaked, but we wouldn't have to worry about trying to
> unmap while the device doesn't exist.

But how does the page_pool know if it is just the normal unloading processing
without VF disabling where the device still exists or it is the abnormal one
caused by the VF disabling where the device will disappear? If it is the first
one, does it cause resource leaking problem for iommu if some calling for iommu
is skipped?

