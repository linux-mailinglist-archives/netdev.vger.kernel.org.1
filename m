Return-Path: <netdev+bounces-218970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2A7B3F1F3
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 03:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C29482A67
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 01:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F242DF6F8;
	Tue,  2 Sep 2025 01:41:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1565B26AF3;
	Tue,  2 Sep 2025 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756777302; cv=none; b=Km56Sa7DTwzPdxESLDEUrtV5jFvYfNTnmQPrkASkTWQBV3kZZoz+gRQnI+AFq9oaQpULN6fxJanRnyROTgrXbNGgPSJWyXCfPc/IGJ/P5qvg6HN4hb7BGXOxleCdhfXUbNjgg+qujm3500pvCcpywrYtg8JRNxneJW6da890TfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756777302; c=relaxed/simple;
	bh=8y6UXf1cJCy0O9hqwY5iin2/oHnrp2C623DlqT0lLAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EVxIWJjqk86t9qHcpLr7DzC5msVjp1I8U/oZRWHdfW1BtQqhBfHh3IZd6Q5QWte5KSWFMs76kxvamiFwKQJCtH3dKZR3B8sYiKQXYe7OYpKGhG1OVRRxSj7V26pYo3/bfu9xA4fG8LAimVHEWRO+hkKUcM6iDJc84VPmJ8fqn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cG7jg25YdztTSQ;
	Tue,  2 Sep 2025 09:40:39 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id E3C24180483;
	Tue,  2 Sep 2025 09:41:35 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Sep 2025 09:41:34 +0800
Message-ID: <4ae3ca7b-dc64-4ab5-b1bf-e357ccc449b4@huawei.com>
Date: Tue, 2 Sep 2025 09:41:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: atm: fix memory leak in atm_register_sysfs when
 device_register fail
To: Simon Horman <horms@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <kuniyu@google.com>, <kay.sievers@vrfy.org>,
	<gregkh@suse.de>, <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250901063537.1472221-1-wangliang74@huawei.com>
 <20250901190140.GO15473@horms.kernel.org>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <20250901190140.GO15473@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/9/2 3:01, Simon Horman 写道:
> On Mon, Sep 01, 2025 at 02:35:37PM +0800, Wang Liang wrote:
>> When device_register() return error in atm_register_sysfs(), which can be
>> triggered by kzalloc fail in device_private_init() or other reasons,
>> kmemleak reports the following memory leaks:
>>
>> unreferenced object 0xffff88810182fb80 (size 8):
>>    comm "insmod", pid 504, jiffies 4294852464
>>    hex dump (first 8 bytes):
>>      61 64 75 6d 6d 79 30 00                          adummy0.
>>    backtrace (crc 14dfadaf):
>>      __kmalloc_node_track_caller_noprof+0x335/0x450
>>      kvasprintf+0xb3/0x130
>>      kobject_set_name_vargs+0x45/0x120
>>      dev_set_name+0xa9/0xe0
>>      atm_register_sysfs+0xf3/0x220
>>      atm_dev_register+0x40b/0x780
>>      0xffffffffa000b089
>>      do_one_initcall+0x89/0x300
>>      do_init_module+0x27b/0x7d0
>>      load_module+0x54cd/0x5ff0
>>      init_module_from_file+0xe4/0x150
>>      idempotent_init_module+0x32c/0x610
>>      __x64_sys_finit_module+0xbd/0x120
>>      do_syscall_64+0xa8/0x270
>>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> When device_create_file() return error in atm_register_sysfs(), the same
>> issue also can be triggered.
>>
>> Function put_device() should be called to release kobj->name memory and
>> other device resource, instead of kfree().
>>
>> Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> Thanks Wang Liang,
>
> I agree this is a bug.
>
> I think that the guiding principle should be that on error functions
> unwind any resource allocations they have made, rather than leaving
> it up to callers to clean things up.
>
> So, as the problem you describe seems to be due to atm_register_sysfs()
> leaking resources if it encounters an error, I think the problem would
> best be resolved there.
>
> Perhaps something like this.
> (Compile tested only!)
>
> diff --git a/net/atm/atm_sysfs.c b/net/atm/atm_sysfs.c
> index 54e7fb1a4ee5..62f3d520a80a 100644
> --- a/net/atm/atm_sysfs.c
> +++ b/net/atm/atm_sysfs.c
> @@ -148,20 +148,23 @@ int atm_register_sysfs(struct atm_dev *adev, struct device *parent)
>   	dev_set_name(cdev, "%s%d", adev->type, adev->number);
>   	err = device_register(cdev);
>   	if (err < 0)
> -		return err;
> +		goto err_put_dev;
>   
>   	for (i = 0; atm_attrs[i]; i++) {
>   		err = device_create_file(cdev, atm_attrs[i]);
>   		if (err)
> -			goto err_out;
> +			goto err_remove_file;
>   	}
>   
>   	return 0;
>   
> -err_out:
> +err_remove_file:
>   	for (j = 0; j < i; j++)
>   		device_remove_file(cdev, atm_attrs[j]);
>   	device_del(cdev);
> +err_put_dev:
> +	put_device(cdev);
> +
>   	return err;
>   }
>   


Thanks for your replies, it is very clear!

But the above code may introduce a use-after-free issue. If 
device_register()
fails, put_device() call atm_release() to free atm_dev, and
atm_proc_dev_deregister() will visit it.

And kfree() should be removed in atm_dev_register() to avoid double-free.

>
>
> Looking over atm_dev_register, it seems to me that it will deadlock
> if it calls atm_proc_dev_deregister() if atm_register_sysfs() fails.
> This is because atm_dev_register() is holding atm_dev_mutex,
> and atm_proc_dev_deregister() tries to take atm_dev_mutex().


I cannot find somewhere tries to take atm_dev_mutex(), can you give some
hints?

------
Best regards
Wang Liang

> If so, I wonder if this can be resolved (in a separate patch to
> the fix for atm_register_sysfs()) like this.
> (Also compile tested only!)
>
> diff --git a/net/atm/resources.c b/net/atm/resources.c
> index b19d851e1f44..3002ff5b60f8 100644
> --- a/net/atm/resources.c
> +++ b/net/atm/resources.c
> @@ -112,13 +110,12 @@ struct atm_dev *atm_dev_register(const char *type, struct device *parent,
>   
>   	if (atm_proc_dev_register(dev) < 0) {
>   		pr_err("atm_proc_dev_register failed for dev %s\n", type);
> -		goto out_fail;
> +		goto err_free_dev;
>   	}
>   
>   	if (atm_register_sysfs(dev, parent) < 0) {
>   		pr_err("atm_register_sysfs failed for dev %s\n", type);
> -		atm_proc_dev_deregister(dev);
> -		goto out_fail;
> +		goto err_proc_dev_unregister;
>   	}
>   
>   	list_add_tail(&dev->dev_list, &atm_devs);
> @@ -127,7 +124,9 @@ struct atm_dev *atm_dev_register(const char *type, struct device *parent,
>   	mutex_unlock(&atm_dev_mutex);
>   	return dev;
>   
> -out_fail:
> +err_proc_dev_unregister:
> +	atm_proc_dev_deregister(dev);
> +err_free_dev:
>   	kfree(dev);
>   	dev = NULL;
>   	goto out;
>
> Lastly, while not a bug and not material for net, it would be nice to
> follow-up on the above and consolidate the error handling in
> atm_dev_register().
>
> Something like this (compile tested only!):
>
> diff --git a/net/atm/resources.c b/net/atm/resources.c
> index b19d851e1f44..3002ff5b60f8 100644
> --- a/net/atm/resources.c
> +++ b/net/atm/resources.c
> @@ -89,9 +89,7 @@ struct atm_dev *atm_dev_register(const char *type, struct device *parent,
>   		inuse = __atm_dev_lookup(number);
>   		if (inuse) {
>   			atm_dev_put(inuse);
> -			mutex_unlock(&atm_dev_mutex);
> -			kfree(dev);
> -			return NULL;
> +			goto err_free_dev;
>   		}
>   		dev->number = number;
>   	} else {
>
> ...
>

