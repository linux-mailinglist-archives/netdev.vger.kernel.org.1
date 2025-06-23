Return-Path: <netdev+bounces-200107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCEFAE3363
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 03:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123C21882188
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 01:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BDB8634F;
	Mon, 23 Jun 2025 01:44:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B574C08;
	Mon, 23 Jun 2025 01:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750643096; cv=none; b=FYNQ8uo0Uxov3ZC3/hayFMmHitkczPMcIqgtsLxPjt+iFEM3wygq/nJRVyu1RBXJ7KScJ6mmvfXkR7s09Ipk47RXKJY/L1EAz2Y9AzsiKPVIFV+gqUiNgEbgXh8+O5FWMCca2lWbsuZJuxVrA95giB9qI09XXW0l4QEyGPYv7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750643096; c=relaxed/simple;
	bh=ArOcBnYF1MTtOomMuMRQm3V2zqzHpmv9R+rStWD+jUU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cTf+RTYhxIPAvWSlBtYN9G/g/CJlC3RLxDi2hcDh8lw81OOEf+IzLqFasedSOUoSfCYEHtfZlyJgOjG5/MUlMkMK8ZDRluza5E8KUg6fHi7iYXNgpI1nBSD4h4/BWU/+ZLwybSJqXDCV8xSP7TEecLsSGHNQSGN29S3p3XFNwqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bQW7M63Bjz29djk;
	Mon, 23 Jun 2025 09:43:11 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CCF791402C1;
	Mon, 23 Jun 2025 09:44:46 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 09:44:46 +0800
Message-ID: <fc76feab-8390-43dc-9de6-e1d53bd9986d@huawei.com>
Date: Mon, 23 Jun 2025 09:44:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 net-next 5/8] net: hns3: set the freed pointers to NULL
 when lifetime is not end
To: Jakub Kicinski <kuba@kernel.org>
References: <20250619144057.2587576-1-shaojijie@huawei.com>
 <20250619144057.2587576-6-shaojijie@huawei.com>
 <20250621083310.52c8e7ae@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250621083310.52c8e7ae@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/6/21 23:33, Jakub Kicinski wrote:
> On Thu, 19 Jun 2025 22:40:54 +0800 Jijie Shao wrote:
>> ChangeLog:
>> v2 -> v3:
>>    - Remove unnecessary pointer set to NULL operation, suggested by Simon Horman.
>>    v2: https://lore.kernel.org/all/20250617010255.1183069-1-shaojijie@huawei.com/
> You removed a single case, but I'm pretty sure Simon meant _all_
> cases setting local variables to NULL in this patch are pointless.

Ok, I will drop this patch in V4

Thanks,
Jijie Shao



