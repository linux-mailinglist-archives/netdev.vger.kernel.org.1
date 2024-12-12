Return-Path: <netdev+bounces-151352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B86709EE4EC
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D35280DD8
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8360C210F6B;
	Thu, 12 Dec 2024 11:24:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB0F1C5497
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734002640; cv=none; b=EIqUgE6XBUyiixYCWrWQHKgm6ifj9VKSPNqPo46Xqs6xWG7JPJoMFvKNG+eQsvUhjikee7jSpyBnvJlPL5MM3TsDu9R9Z/buA8/sJyHqt2dCeMRanmH6d76thpKNibYFYZDt+labIz8tQYZdMc/ZkWqTwV2CvkllO9aXiGYqiyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734002640; c=relaxed/simple;
	bh=s3WthF9DmRCbwaJCHzafVNxQ1Iiwhe+3pvCEFgfomIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kWVuREPqMPgzbb3dnzzTXfkIjmkriOLEUQc2ZpbJNV7UyS8vQjV9Kbv42bxDDT8JklYJLTZCIOL6NlW5lC1DlbjXw09rScTahvQFDprB3jjjZ7OsMO6+ixa735dpgC6/JsmqiMckgnR3T5QX4P4HVJtygH9kcgyjVHLgQuvu1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Y896Q23gxzqTv3;
	Thu, 12 Dec 2024 19:22:06 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E919180106;
	Thu, 12 Dec 2024 19:23:53 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Dec 2024 19:23:53 +0800
Message-ID: <b0a4f301-9dfa-4785-9468-85f3849db81d@huawei.com>
Date: Thu, 12 Dec 2024 19:23:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] bnxt_en: handle tpa_info in queue API
 implementation
To: Jakub Kicinski <kuba@kernel.org>, Michael Chan <michael.chan@broadcom.com>
CC: David Wei <dw@davidwei.uk>, <netdev@vger.kernel.org>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20241204041022.56512-1-dw@davidwei.uk>
 <20241204041022.56512-4-dw@davidwei.uk>
 <9ca8506d-c42d-40a0-9532-7a95c06fed39@huawei.com>
 <0bc60b9d-fbf7-4421-ab6a-5854355d68f4@davidwei.uk>
 <a1d5ffda-1e6c-4730-8b36-6ba644bb0118@huawei.com>
 <fedc8606-b3bc-4fb1-8803-a004cb24216e@davidwei.uk>
 <CACKFLik1-rQB2QHY1pZ3eF0GYGUCgXFHvhh50DNboXV+A7MCuA@mail.gmail.com>
 <20241211164841.44cba0ad@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241211164841.44cba0ad@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/12/12 8:48, Jakub Kicinski wrote:
 > But, Yunsheng, I hope it is clear that the sync RCU is needed even
> if driver disables NAPI for the reconfiguration. Unless you see a
> RCU sync in napi_disable() / napi_enable()..

It seems that depends on calling order of napi_disable()/napi_enable()
and page_pool_destroy() for old page_pool.
It seems an extra RCU sync is not really needed if page_pool_destroy()
for the old page_pool is called between napi_disable() and napi_enable()
as page_pool_destroy() already have a RCU sync.

