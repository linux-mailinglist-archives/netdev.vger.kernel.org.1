Return-Path: <netdev+bounces-138629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B5D9AE67F
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B7B1C236AB
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3541EC012;
	Thu, 24 Oct 2024 13:26:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F7C1DD524
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776401; cv=none; b=BUwTxXclSxBi+mFefNG3f4eJocpUWrdiCmbdwT4YiHrwom7+NaVP7ysaYf5sj6tv74nyLDc4zyMD6skwCO3C2nJFcglfJH6zCScdlosklG+iReXCebrwFGZuUTlaR3lQ++zhJuKdrM5krbtSn4nH2gt6x8Xs24gXNje4LRJfGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776401; c=relaxed/simple;
	bh=Coajt4Owld0LwUpNn37brlQV6tDRBW0waM8Z9leyTQs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Rr/4UewQwL9CGt5bizxNaIrkaWCcrhfdPaxZ7eecvF+FkDYNIp+lkJIRaDz+IZXlZbki6My6lRZUBkCc23XWXrzsJsWv+aD0oHSQgxIBdSp9MTjSy4yevoKW71GHHcywLBLucbJX6aLW7UD17pqCedBuuKYQ4K7n2Iy0uHs+rtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XZ68y4nrNz2FbMF;
	Thu, 24 Oct 2024 21:25:06 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 4696B14037C;
	Thu, 24 Oct 2024 21:26:31 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Oct 2024 21:26:30 +0800
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
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <19322579-a24b-679a-051b-c202eb3750f7@huawei.com>
Date: Thu, 24 Oct 2024 21:26:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241024121325.GJ1202098@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/24 20:13, Simon Horman wrote:
> On Wed, Oct 23, 2024 at 04:09:20PM +0800, Zhen Lei wrote:
>> Fix the incorrect return value check for debugfs_create_dir() and
>> debugfs_create_file(), which returns ERR_PTR(-ERROR) instead of NULL
>> when it fails.
>>
>> Commit 4ad23d2368cc ("bna: Remove error checking for
>> debugfs_create_dir()") allows the program to continue execution if the
>> creation of bnad->port_debugfs_root fails, which causes the atomic count
>> bna_debugfs_port_count to be unbalanced. The corresponding error check
>> need to be added back.
> 
> Hi Zhen Lei,
> 
> The documentation for debugfs_create_dir states:
> 
>  * NOTE: it's expected that most callers should _ignore_ the errors returned
>  * by this function. Other debugfs functions handle the fact that the "dentry"
>  * passed to them could be an error and they don't crash in that case.
>  * Drivers should generally work fine even if debugfs fails to init anyway.
> 
> Which makes me wonder why we are checking the return value of
> debugfs_create_dir() at all. Can't we just take advantage of
> it not mattering, to debugfs functions, if the return value
> is an error or not?

Do you want to ignore all the return values of debugfs_create_dir() and debugfs_create_file()?
"bna_debugfs_root = debugfs_create_dir("bna", NULL);" and debugfs_create_file() is OK.
I've carefully analyzed the current code, and "bnad->port_debugfs_root = debugfs_create_dir(...);"
is also OK for now.

bnad_debugfs_init():
	bnad->port_debugfs_root = debugfs_create_dir(name, bna_debugfs_root);	//IS_ERR() if fails
(1)
	atomic_inc(&bna_debugfs_port_count);

bnad_debugfs_uninit():
(2)	if (bnad->port_debugfs_root)						//It still works when it's IS_ERR()
		atomic_dec(&bna_debugfs_port_count);

	if (atomic_read(&bna_debugfs_port_count) == 0)
		debugfs_remove(bna_debugfs_root);

If we want the code to be more robust or easier to understand, it is better
to modify (1) and (2) above as follows:
(1) if (IS_ERR(bnad->port_debugfs_root))
	return;
(2) if (!IS_ERR_OR_NULL(bnad->port_debugfs_root))

> 
>> Fixes: 4ad23d2368cc ("bna: Remove error checking for debugfs_create_dir()")
>> Fixes: 7afc5dbde091 ("bna: Add debugfs interface.")
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> ...
> .
> 

-- 
Regards,
  Zhen Lei

