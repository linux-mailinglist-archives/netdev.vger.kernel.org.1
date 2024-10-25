Return-Path: <netdev+bounces-138972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3029AF8DE
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 06:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8332A1C21066
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 04:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5D418A95F;
	Fri, 25 Oct 2024 04:17:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07C22B657
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 04:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729829853; cv=none; b=c4tAYGrez6bFXB2N9vhMXqisBVTaVdzGO7Xpq/EnEihs53R+V9pky8KoZj9qtYHsNPzfWGtrf+CW1EI7c2cb8hwoXamZsckRYtoIHJR0U3DJoGbqm+wHpRTo9UQIGUvoOnjXohiekEWDI9uMGKSHiqtrlAdtg4PRuSZg3SygIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729829853; c=relaxed/simple;
	bh=1hrhyJSBqbyPpIJ4ytP3zkuz6gijHwnO9sYkD5IY10A=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=V39yJTSgA75VuO4X3vZSFmwnuCkhzqlSVmCLxY9Zdm5bG7Nk6p9huct0zCiGV8Et6spFiLfJpLHzg/XIl6EWvuHB4oB2tRPfCFCy1lfDYOcQvTyba+dqnmn67xgBhCdFHjLML1L+cP+mn7MXisgl5D106YWYUgZbYMFcWiVVylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XZTw25t37z1T8vQ;
	Fri, 25 Oct 2024 12:15:14 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id BD5381400E3;
	Fri, 25 Oct 2024 12:17:18 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Oct 2024 12:17:18 +0800
Subject: Re: [PATCH 1/2] bna: Fix return value check for debugfs create APIs
To: Simon Horman <horms@kernel.org>
CC: Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
References: <20241023080921.326-1-thunder.leizhen@huawei.com>
 <20241023080921.326-2-thunder.leizhen@huawei.com>
 <20241024121325.GJ1202098@kernel.org>
 <19322579-a24b-679a-051b-c202eb3750f7@huawei.com>
 <20241024152704.GZ1202098@kernel.org>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c04f1ab2-54de-368c-d80b-f9716a944c30@huawei.com>
Date: Fri, 25 Oct 2024 12:17:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241024152704.GZ1202098@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/24 23:27, Simon Horman wrote:
> On Thu, Oct 24, 2024 at 09:26:30PM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2024/10/24 20:13, Simon Horman wrote:
>>> On Wed, Oct 23, 2024 at 04:09:20PM +0800, Zhen Lei wrote:
>>>> Fix the incorrect return value check for debugfs_create_dir() and
>>>> debugfs_create_file(), which returns ERR_PTR(-ERROR) instead of NULL
>>>> when it fails.
>>>>
>>>> Commit 4ad23d2368cc ("bna: Remove error checking for
>>>> debugfs_create_dir()") allows the program to continue execution if the
>>>> creation of bnad->port_debugfs_root fails, which causes the atomic count
>>>> bna_debugfs_port_count to be unbalanced. The corresponding error check
>>>> need to be added back.
>>>
>>> Hi Zhen Lei,
>>>
>>> The documentation for debugfs_create_dir states:
>>>
>>>  * NOTE: it's expected that most callers should _ignore_ the errors returned
>>>  * by this function. Other debugfs functions handle the fact that the "dentry"
>>>  * passed to them could be an error and they don't crash in that case.
>>>  * Drivers should generally work fine even if debugfs fails to init anyway.
>>>
>>> Which makes me wonder why we are checking the return value of
>>> debugfs_create_dir() at all. Can't we just take advantage of
>>> it not mattering, to debugfs functions, if the return value
>>> is an error or not?
>>
>> Do you want to ignore all the return values of debugfs_create_dir() and debugfs_create_file()?
>> "bna_debugfs_root = debugfs_create_dir("bna", NULL);" and debugfs_create_file() is OK.
>> I've carefully analyzed the current code, and "bnad->port_debugfs_root = debugfs_create_dir(...);"
>> is also OK for now.
> 
> What I'm saying is that it is unusual to depend on the return value of
> debugfs_create_dir() for anything. And it would be best to avoid doing so.
> 
> But perhaps that isn't possible for some reason?

OK, I understand now. Please forgive my poor English. Combine Andrew's reply
and my analysis above. The return value check for the remaining two places
should now be removed.

> 
>>
>> bnad_debugfs_init():
>> 	bnad->port_debugfs_root = debugfs_create_dir(name, bna_debugfs_root);	//IS_ERR() if fails
>> (1)
>> 	atomic_inc(&bna_debugfs_port_count);
>>
>> bnad_debugfs_uninit():
>> (2)	if (bnad->port_debugfs_root)						//It still works when it's IS_ERR()
>> 		atomic_dec(&bna_debugfs_port_count);
>>
>> 	if (atomic_read(&bna_debugfs_port_count) == 0)
>> 		debugfs_remove(bna_debugfs_root);
>>
>> If we want the code to be more robust or easier to understand, it is better
>> to modify (1) and (2) above as follows:
>> (1) if (IS_ERR(bnad->port_debugfs_root))
>> 	return;
>> (2) if (!IS_ERR_OR_NULL(bnad->port_debugfs_root))
>>
>>>
>>>> Fixes: 4ad23d2368cc ("bna: Remove error checking for debugfs_create_dir()")
>>>> Fixes: 7afc5dbde091 ("bna: Add debugfs interface.")
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>
>>> ...
>>> .
>>>
>>
>> -- 
>> Regards,
>>   Zhen Lei
>>
> .
> 

-- 
Regards,
  Zhen Lei

