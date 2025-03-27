Return-Path: <netdev+bounces-177879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 956A9A7280A
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 02:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C821661EF
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 01:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74EF25771;
	Thu, 27 Mar 2025 01:19:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF819A;
	Thu, 27 Mar 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743038398; cv=none; b=IyTwK4wuJNFbULDQyfTlXwzZjFdTzwXpuJp5dky+tUF0bCp8FC1Eqb2OBey1q2byt15tqCDFlE3BmMtGThB+maYpc2TuxbP3fKfx0gU3Gf9wzTYEXRDmMxWu1xVk6bSffIA4u8WuGibE1sGfNSyrNyVNs20wnpUWJiAC3fqwL84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743038398; c=relaxed/simple;
	bh=59mpYoI/fSyzOLOzXr+qV2DWnvnvooc/sQuTpm3TbO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RYgcpA6+xNmclLjCJt554aS1g/lAK47YZUjLHUWstq8NL830KVSstIvwP3bJs2EQVekOhaHAC9Zq+A0wjIXocaUZOtvz8ZnLPQz8B3h3tCPsYpWTLBDGYE/BKcz7Z+sxUOVHxqOEl1pu9aSCLc/z6IpjKQ5n3bQwFv1Ra8P82Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZNQkt74kwz1FNKq;
	Thu, 27 Mar 2025 09:17:58 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 94E72140156;
	Thu, 27 Mar 2025 09:19:46 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Mar 2025 09:19:45 +0800
Message-ID: <a063dbc7-341e-4ec5-b989-0e8007900a4c@huawei.com>
Date: Thu, 27 Mar 2025 09:19:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: sit: fix skb_under_panic with overflowed
 needed_headroom
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <cong.wang@bytedance.com>,
	<kuniyu@amazon.com>, <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250325095449.2594874-1-wangliang74@huawei.com>
 <20250326044715.6d071be3@kernel.org>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <20250326044715.6d071be3@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2025/3/26 19:47, Jakub Kicinski 写道:
> On Tue, 25 Mar 2025 17:54:49 +0800 Wang Liang wrote:
>> When create ipip6 tunnel, if tunnel->parms.link is assigned to the previous
>> created tunnel device, the dev->needed_headroom will increase based on the
>> previous one.
> Sorry for the inconvenience but could you repost this patch?
> Our CI was broken when you posted and we currently don't have
> a way to re-trigger it :(


Ok, I will send this patch again.


