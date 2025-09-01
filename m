Return-Path: <netdev+bounces-218867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D049B3EE3E
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866D41A87E14
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 19:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A764E1EDA1E;
	Mon,  1 Sep 2025 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJqIcAtS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6BCC2EA;
	Mon,  1 Sep 2025 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756753305; cv=none; b=ADHhREk8K4vem4Dm6S0DdFhJRMerlYqMbzjwuWbG80eXuTaMHFWhd0oselFM6w8H8+Vr49dzzWgYADb6l7RHk9IHtmk/fWna/hbyxp3UMiJSa1ZCAQkAq3xnWVjAahjI205AFFDqn98iEIgZ8ByZ/Bv/edIZkdH1bEODK+Wuwi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756753305; c=relaxed/simple;
	bh=5OnM0jJZm89UsRUpF9KL6hzKhKJ3Cw3RgJN3zSjZYMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSR1tNB9cC5/2jzUvlCo96VR35lhZi6XEbH98l2uOVZ7W4vvGUGfHKkdWsK3/qEPvFhrhrIjxUUEImxe9Uy+VBIj5ohxASVfTEpOx2UnRnN7Q0CISHx4SR5M5fgcCjT+/8tsaOzpZ5ZEu8q7gaVhtrEuFCmCST1fhPkoH8bm42g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJqIcAtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D33C4CEF0;
	Mon,  1 Sep 2025 19:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756753305;
	bh=5OnM0jJZm89UsRUpF9KL6hzKhKJ3Cw3RgJN3zSjZYMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJqIcAtSD++5n/VNUkZO0Jwqw6yfKk3WPzouuLUcQV4OP3K06FBjOzhcZRsZz+vd8
	 5wu7HYq3f8KvbqPHwRvy79yY0EzjgXBArLHleKq2ZWch3OzfWiXZ6rqb4IDMBzk3wo
	 xRcq+H4ubUQFKxdzvEAFN3fSc8xL10AG9S2UI3WgGvb8xSpj03JKSnc72fly4wJTQe
	 2Z/G6jh4IVpYDUp0qkbJlzQr9I9kR/VILzhfrCbitXtGLQcNSLWW/qFtKtUCqobGpG
	 ZpQKgkcJoc1HY7vvoXXHYjmzgYtH8Thzygxnd4HeoymsoCcD8kH/Sj4bJ2nflrAra/
	 78d6uL09npK4w==
Date: Mon, 1 Sep 2025 20:01:40 +0100
From: Simon Horman <horms@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kuniyu@google.com, kay.sievers@vrfy.org,
	gregkh@suse.de, yuehaibing@huawei.com, zhangchangzhong@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: atm: fix memory leak in atm_register_sysfs when
 device_register fail
Message-ID: <20250901190140.GO15473@horms.kernel.org>
References: <20250901063537.1472221-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901063537.1472221-1-wangliang74@huawei.com>

On Mon, Sep 01, 2025 at 02:35:37PM +0800, Wang Liang wrote:
> When device_register() return error in atm_register_sysfs(), which can be
> triggered by kzalloc fail in device_private_init() or other reasons,
> kmemleak reports the following memory leaks:
> 
> unreferenced object 0xffff88810182fb80 (size 8):
>   comm "insmod", pid 504, jiffies 4294852464
>   hex dump (first 8 bytes):
>     61 64 75 6d 6d 79 30 00                          adummy0.
>   backtrace (crc 14dfadaf):
>     __kmalloc_node_track_caller_noprof+0x335/0x450
>     kvasprintf+0xb3/0x130
>     kobject_set_name_vargs+0x45/0x120
>     dev_set_name+0xa9/0xe0
>     atm_register_sysfs+0xf3/0x220
>     atm_dev_register+0x40b/0x780
>     0xffffffffa000b089
>     do_one_initcall+0x89/0x300
>     do_init_module+0x27b/0x7d0
>     load_module+0x54cd/0x5ff0
>     init_module_from_file+0xe4/0x150
>     idempotent_init_module+0x32c/0x610
>     __x64_sys_finit_module+0xbd/0x120
>     do_syscall_64+0xa8/0x270
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> When device_create_file() return error in atm_register_sysfs(), the same
> issue also can be triggered.
> 
> Function put_device() should be called to release kobj->name memory and
> other device resource, instead of kfree().
> 
> Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Thanks Wang Liang,

I agree this is a bug.

I think that the guiding principle should be that on error functions
unwind any resource allocations they have made, rather than leaving
it up to callers to clean things up.

So, as the problem you describe seems to be due to atm_register_sysfs()
leaking resources if it encounters an error, I think the problem would
best be resolved there.

Perhaps something like this.
(Compile tested only!)

diff --git a/net/atm/atm_sysfs.c b/net/atm/atm_sysfs.c
index 54e7fb1a4ee5..62f3d520a80a 100644
--- a/net/atm/atm_sysfs.c
+++ b/net/atm/atm_sysfs.c
@@ -148,20 +148,23 @@ int atm_register_sysfs(struct atm_dev *adev, struct device *parent)
 	dev_set_name(cdev, "%s%d", adev->type, adev->number);
 	err = device_register(cdev);
 	if (err < 0)
-		return err;
+		goto err_put_dev;
 
 	for (i = 0; atm_attrs[i]; i++) {
 		err = device_create_file(cdev, atm_attrs[i]);
 		if (err)
-			goto err_out;
+			goto err_remove_file;
 	}
 
 	return 0;
 
-err_out:
+err_remove_file:
 	for (j = 0; j < i; j++)
 		device_remove_file(cdev, atm_attrs[j]);
 	device_del(cdev);
+err_put_dev:
+	put_device(cdev);
+
 	return err;
 }
 


Looking over atm_dev_register, it seems to me that it will deadlock
if it calls atm_proc_dev_deregister() if atm_register_sysfs() fails.
This is because atm_dev_register() is holding atm_dev_mutex,
and atm_proc_dev_deregister() tries to take atm_dev_mutex().

If so, I wonder if this can be resolved (in a separate patch to
the fix for atm_register_sysfs()) like this.
(Also compile tested only!)

diff --git a/net/atm/resources.c b/net/atm/resources.c
index b19d851e1f44..3002ff5b60f8 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -112,13 +110,12 @@ struct atm_dev *atm_dev_register(const char *type, struct device *parent,
 
 	if (atm_proc_dev_register(dev) < 0) {
 		pr_err("atm_proc_dev_register failed for dev %s\n", type);
-		goto out_fail;
+		goto err_free_dev;
 	}
 
 	if (atm_register_sysfs(dev, parent) < 0) {
 		pr_err("atm_register_sysfs failed for dev %s\n", type);
-		atm_proc_dev_deregister(dev);
-		goto out_fail;
+		goto err_proc_dev_unregister;
 	}
 
 	list_add_tail(&dev->dev_list, &atm_devs);
@@ -127,7 +124,9 @@ struct atm_dev *atm_dev_register(const char *type, struct device *parent,
 	mutex_unlock(&atm_dev_mutex);
 	return dev;
 
-out_fail:
+err_proc_dev_unregister:
+	atm_proc_dev_deregister(dev);
+err_free_dev:
 	kfree(dev);
 	dev = NULL;
 	goto out;

Lastly, while not a bug and not material for net, it would be nice to
follow-up on the above and consolidate the error handling in
atm_dev_register().

Something like this (compile tested only!):

diff --git a/net/atm/resources.c b/net/atm/resources.c
index b19d851e1f44..3002ff5b60f8 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -89,9 +89,7 @@ struct atm_dev *atm_dev_register(const char *type, struct device *parent,
 		inuse = __atm_dev_lookup(number);
 		if (inuse) {
 			atm_dev_put(inuse);
-			mutex_unlock(&atm_dev_mutex);
-			kfree(dev);
-			return NULL;
+			goto err_free_dev;
 		}
 		dev->number = number;
 	} else {

...

-- 
pw-bot: changes-requested

