Return-Path: <netdev+bounces-117096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9070694CA0C
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 08:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39911288C3E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 06:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CA816C86B;
	Fri,  9 Aug 2024 06:06:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C34184
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 06:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183577; cv=none; b=q8T5QgxYupG/nKYsOuYl6veKpYfaic7AcckEASo4QvRlQU+6X1r5zEwgRA8vytPRedBcXk4NrvuqnfaQhhiXlemsh3zkr1pWaDC+vPmTg24/i7hWGS2ZU8NYmNRR+nXEjpGsGoBXho64+DUpkacuZVOfZW6/7GMjtBcfSsbLo+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183577; c=relaxed/simple;
	bh=8SZtBr63RxcZZoD//IN+qTlK1ZM/mAIjtdlQQVvoAvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XRSjVXOSDRhIaZuYC/v1/WQzRtZHOu4Ymz939uf8PUIoDzrvpCYAI1Qe1Ob4X7XwdRUIwZTe5HAEAechFUi9k+e2lHlbfNURq+la/NrwOF6trboQjOcgz5O4JUj2dfvfH7iItSZjToZ29Jc5as2sFn1hEnSEezJjfTPrLemnJHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WgCvy1cMdz1j6P0;
	Fri,  9 Aug 2024 14:01:18 +0800 (CST)
Received: from kwepemf200007.china.huawei.com (unknown [7.202.181.233])
	by mail.maildlp.com (Postfix) with ESMTPS id 585CA140159;
	Fri,  9 Aug 2024 14:06:03 +0800 (CST)
Received: from [10.67.121.184] (10.67.121.184) by
 kwepemf200007.china.huawei.com (7.202.181.233) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 9 Aug 2024 14:06:02 +0800
Message-ID: <758b4d47-c980-4f66-b4a4-949c3fc4b040@huawei.com>
Date: Fri, 9 Aug 2024 14:06:02 +0800
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
CC: Yunsheng Lin <linyunsheng@huawei.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<ilias.apalodimas@linaro.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>
References: <20240806151618.1373008-1-kuba@kernel.org>
 <523894ab-2d38-415f-8306-c0d1abd911ec@huawei.com>
 <20240807072908.1da91994@kernel.org>
 <977c3d82-e2f0-4466-9100-7ea781e91ce1@huawei.com>
 <20240808070511.0befbdde@kernel.org>
From: Yonglong Liu <liuyonglong@huawei.com>
In-Reply-To: <20240808070511.0befbdde@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf200007.china.huawei.com (7.202.181.233)


On 2024/8/8 22:05, Jakub Kicinski wrote:
> On Thu, 8 Aug 2024 20:52:52 +0800 Yonglong Liu wrote:
>> I hooks the netdev to the page pool, and run with this patch for a
>> while, then get
>>
>> the following messages, and the vf can not disable:
>> [ 1950.137586] hns3 0000:7d:01.0 eno1v0: link up
>> [ 1950.137671] hns3 0000:7d:01.0 eno1v0: net open
>> [ 1950.147098] 8021q: adding VLAN 0 to HW filter on device eno1v0
>> [ 1974.287476] hns3 0000:7d:01.0 eno1v0: net stop
>> [ 1974.294359] hns3 0000:7d:01.0 eno1v0: link down
>> [ 1975.596916] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool
>> release stalling device unregister
>> [ 1976.744947] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool
>> release stalling device unregister
> So.. the patch works? :) We may want to add this to get the info prints
> back:
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 2abe6e919224..26bc1618de7c 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1021,11 +1021,12 @@ static void page_pool_release_retry(struct work_struct *wq)
>   	/* Periodic warning for page pools the user can't see */
>   	netdev = READ_ONCE(pool->slow.netdev);
>   	if (time_after_eq(jiffies, pool->defer_warn) &&
> -	    (!netdev || netdev == NET_PTR_POISON)) {
> +	    (!netdev || netdev == NET_PTR_POISON || netdev->pp_unreg_pending)) {
>   		int sec = (s32)((u32)jiffies - (u32)pool->defer_start) / HZ;
>   
> -		pr_warn("%s() stalled pool shutdown: id %u, %d inflight %d sec\n",
> -			__func__, pool->user.id, inflight, sec);
> +		pr_warn("%s(): %s stalled pool shutdown: id %u, %d inflight %d sec (hold netdev: %d)\n",
> +			__func__, netdev ? netdev_name(netdev) : "",
> +			pool->user.id, inflight, sec, pool->defer_warn);
>   		pool->defer_warn = jiffies + DEFER_WARN_INTERVAL;
>   	}
>   

Here is the log:

[ 1018.059215] hns3 0000:7d:01.0 eno1v0: net stop
[ 1018.066095] hns3 0000:7d:01.0 eno1v0: link down
[ 1019.340845] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1020.492848] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1021.648849] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1022.796850] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1023.980837] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1025.132850] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1026.284851] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1027.500853] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1028.364855] unregister_netdevice: waiting for eno1v0 to become free. 
Usage count = 2
[ 1028.652851] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1029.808845] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister
[ 1030.956843] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
release stalling device unregister

...

[ 1078.476854] hns3 0000:7d:01.0: page_pool_release_retry(): eno1v0 
stalled pool shutdown: id 553, 82 inflight 60 sec (hold netdev: 194039)

...

[ 1138.892838] hns3 0000:7d:01.0: page_pool_release_retry(): eno1v0 
stalled pool shutdown: id 553, 82 inflight 120 sec (hold netdev: 209147)

...

[ 1199.308841] hns3 0000:7d:01.0: page_pool_release_retry(): eno1v0 
stalled pool shutdown: id 553, 82 inflight 181 sec (hold netdev: 224251)

...

[ 1199.308841] hns3 0000:7d:01.0: page_pool_release_retry(): eno1v0 
stalled pool shutdown: id 553, 82 inflight 181 sec (hold netdev: 224251)

...

[ 1259.724849] hns3 0000:7d:01.0: page_pool_release_retry(): eno1v0 
stalled pool shutdown: id 553, 82 inflight 241 sec (hold netdev: 239355)

...

[ 7603.436840] hns3 0000:7d:01.0: page_pool_release_retry(): eno1v0 
stalled pool shutdown: id 553, 82 inflight 6585 sec (hold netdev: 1825283)
[ 7663.852858] hns3 0000:7d:01.0: page_pool_release_retry(): eno1v0 
stalled pool shutdown: id 553, 82 inflight 6645 sec (hold netdev: 1840387)
[ 7724.272853] hns3 0000:7d:01.0: page_pool_release_retry(): eno1v0 
stalled pool shutdown: id 553, 82 inflight 6706 sec (hold netdev: 1855491)


And also have the follow INFO (last time I forgot this):

[ 1211.213006] INFO: task systemd-journal:1598 blocked for more than 120 
seconds.
[ 1211.220217]       Not tainted 6.10.0-rc4+ #1
[ 1211.224480] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1211.232284] task:systemd-journal state:D stack:0     pid:1598 
tgid:1598  ppid:1      flags:0x00000801
[ 1211.241568] Call trace:
[ 1211.244005]  __switch_to+0xec/0x138
[ 1211.247509]  __schedule+0x2f4/0x10e0
[ 1211.251080]  schedule+0x3c/0x148
[ 1211.254308]  schedule_preempt_disabled+0x2c/0x50
[ 1211.258927]  __mutex_lock.constprop.0+0x2b0/0x618
[ 1211.263625]  __mutex_lock_slowpath+0x1c/0x30
[ 1211.267888]  mutex_lock+0x40/0x58
[ 1211.271203]  uevent_show+0x90/0x140
[ 1211.274687]  dev_attr_show+0x28/0x80
[ 1211.278265]  sysfs_kf_seq_show+0xb4/0x138
[ 1211.282277]  kernfs_seq_show+0x34/0x48
[ 1211.286029]  seq_read_iter+0x1bc/0x4b8
[ 1211.289780]  kernfs_fop_read_iter+0x148/0x1c8
[ 1211.294128]  vfs_read+0x25c/0x308
[ 1211.297443]  ksys_read+0x70/0x108
[ 1211.300745]  __arm64_sys_read+0x24/0x38
[ 1211.304581]  invoke_syscall+0x50/0x128
[ 1211.308331]  el0_svc_common.constprop.0+0xc8/0xf0
[ 1211.313023]  do_el0_svc+0x24/0x38
[ 1211.316326]  el0_svc+0x38/0x100
[ 1211.319470]  el0t_64_sync_handler+0xc0/0xc8
[ 1211.323647]  el0t_64_sync+0x1a4/0x1a8

>> I install drgn, but don't know how to find out the using pages, would
>> you guide me on how to use it?
> You can use this sample as a starting point:
>
> https://github.com/osandov/drgn/blob/main/contrib/tcp_sock.py
>
> but if the pages are actually leaked (rather than sitting in a socket),
> you'll have to scan pages, not sockets. And figure out how they got leaked.
> Somehow...

Thanks : )


