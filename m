Return-Path: <netdev+bounces-150638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B84AC9EB0BD
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B44D168A4B
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A77F1A2846;
	Tue, 10 Dec 2024 12:25:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA21A3BD7
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833521; cv=none; b=iybEbICbETO0kaHc/Fbw1Ha38AJ3TYY3T2a1xGWFuo0a7imV0vI14EaaDEOVX5cLCQv03WMRIhkrqV9V0m1APgMUO97xKgyYkJ3qq8vXFggLhLezA4+ZGPc5GJz8uM0toDPMtedB8WmwDG6PSGoF6pppHqPVyA/kxAdqsH/gafE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833521; c=relaxed/simple;
	bh=UhsG9CRW4AMj8eY5Gfh+GtL4qRysz0cxgiL514EAz+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KKN1HtF9rL0YuIs9qYCWx8kDuZrCIs2wS9Hf9+H4B5esIMycS5W5+grehcYzxSGZugnEIQJVDD6u9nD50vjGBnR3Dekw6gCHLKpfVrWh4d+E/4VzGkpWX+K2/s3n/jcKG3KaEeOuKPB0xrOrknz2S0tDIUhMY+1HVS749MNSgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Y6yXt6WR6zHwrk;
	Tue, 10 Dec 2024 20:22:22 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9460D1800CE;
	Tue, 10 Dec 2024 20:25:15 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Dec 2024 20:25:15 +0800
Message-ID: <9ca8506d-c42d-40a0-9532-7a95c06fed39@huawei.com>
Date: Tue, 10 Dec 2024 20:25:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] bnxt_en: handle tpa_info in queue API
 implementation
To: David Wei <dw@davidwei.uk>, <netdev@vger.kernel.org>, Michael Chan
	<michael.chan@broadcom.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20241204041022.56512-1-dw@davidwei.uk>
 <20241204041022.56512-4-dw@davidwei.uk>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241204041022.56512-4-dw@davidwei.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/12/4 12:10, David Wei wrote:

>  	bnxt_copy_rx_ring(bp, rxr, clone);
> @@ -15563,6 +15580,8 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>  	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
>  	rxr->rx_next_cons = 0;
>  	page_pool_disable_direct_recycling(rxr->page_pool);
> +	if (bnxt_separate_head_pool())
> +		page_pool_disable_direct_recycling(rxr->head_pool);

Hi, David
As mentioned in [1], is the above page_pool_disable_direct_recycling()
really needed?

Is there any NAPI API called in the implementation of netdev_queue_mgmt_ops?
It doesn't seem obvious there is any NAPI API like napi_enable() &
____napi_schedule() that is called in bnxt_queue_start()/bnxt_queue_stop()/
bnxt_queue_mem_alloc()/bnxt_queue_mem_free() through code reading.

1. https://lore.kernel.org/all/c2b306af-4817-4169-814b-adbf25803919@huawei.com/

