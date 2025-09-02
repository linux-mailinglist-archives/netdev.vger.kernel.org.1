Return-Path: <netdev+bounces-219088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3F1B3FBD5
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390147A3424
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4D7275860;
	Tue,  2 Sep 2025 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA91XbgT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192FA2EDD75;
	Tue,  2 Sep 2025 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807642; cv=none; b=hiJPDZAmFVEYYU0bJjklHPr99qZ9eYT2ncyUy5CIz4gafOIs3XReSp01+SAU+mMSdU2YAW7LrTojydRr0HjZBSIn79Nqj9FmImiKQ78xpaSlw3HifAQ3dwSqVQ1Wrtr6nN0b1f0WCGpCGaUbkQqnG/wsPdG/nL+p+Ooy7wMHkCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807642; c=relaxed/simple;
	bh=n7Zz7ESKe5II1Hc9wcpMJplkj2h3aSHW/mqP+X4a2OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFMDxV3MG/RQzzNLTmUgG4OY6hJ4Pq/B6eIOEdeIbu7aeFmSYYI3fL8UhNpav6dtxd3e3SEPZkEbpIbxPWo88W8qUPopxwwZFMjAJy2/y1Ysqx9Ip2bH2BhQHgzthizGnOaE9bqy2BfAe9UHjRv65XYQd0ZhM27/5D3t0MNGpZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA91XbgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A45C4CEF5;
	Tue,  2 Sep 2025 10:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756807640;
	bh=n7Zz7ESKe5II1Hc9wcpMJplkj2h3aSHW/mqP+X4a2OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LA91XbgT4K2NDijDbGqZDA9oYV74S4KF428MgMtzcmWF0Dx8+7OMzNQk9aIeyrBB7
	 +IhG/ynsQwLIoq+KF5nYJ9Jr5Bw55OKEpFavGXGrTt2++CS8rHpzhXPm941zHMTqa1
	 skomXzPWgQ3roQukXTvQYUOZmARVKk7ny3cmbR8SaAYg9H8ydgBxRP+1FxO23zUgE/
	 Hk+ts5DKvo4AWw6T8B77/FPP57iOFrIa2LTp72knO6hlC/ncgbkqOTITZV1jG01F3F
	 XMU5Dhslw1GlpBxGGtU9d1gWOPBO50bTzHHxKlA1psgjoaN21llaupaubYnFp5cmf1
	 lEcVLrDCOVunQ==
Date: Tue, 2 Sep 2025 11:07:16 +0100
From: Simon Horman <horms@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kuniyu@google.com, kay.sievers@vrfy.org,
	gregkh@suse.de, yuehaibing@huawei.com, zhangchangzhong@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: atm: fix memory leak in atm_register_sysfs when
 device_register fail
Message-ID: <20250902100716.GB15473@horms.kernel.org>
References: <20250901063537.1472221-1-wangliang74@huawei.com>
 <20250901190140.GO15473@horms.kernel.org>
 <4ae3ca7b-dc64-4ab5-b1bf-e357ccc449b4@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ae3ca7b-dc64-4ab5-b1bf-e357ccc449b4@huawei.com>

On Tue, Sep 02, 2025 at 09:41:33AM +0800, Wang Liang wrote:
> 
> 在 2025/9/2 3:01, Simon Horman 写道:
> > On Mon, Sep 01, 2025 at 02:35:37PM +0800, Wang Liang wrote:
> > > When device_register() return error in atm_register_sysfs(), which can be
> > > triggered by kzalloc fail in device_private_init() or other reasons,
> > > kmemleak reports the following memory leaks:
> > > 
> > > unreferenced object 0xffff88810182fb80 (size 8):
> > >    comm "insmod", pid 504, jiffies 4294852464
> > >    hex dump (first 8 bytes):
> > >      61 64 75 6d 6d 79 30 00                          adummy0.
> > >    backtrace (crc 14dfadaf):
> > >      __kmalloc_node_track_caller_noprof+0x335/0x450
> > >      kvasprintf+0xb3/0x130
> > >      kobject_set_name_vargs+0x45/0x120
> > >      dev_set_name+0xa9/0xe0
> > >      atm_register_sysfs+0xf3/0x220
> > >      atm_dev_register+0x40b/0x780
> > >      0xffffffffa000b089
> > >      do_one_initcall+0x89/0x300
> > >      do_init_module+0x27b/0x7d0
> > >      load_module+0x54cd/0x5ff0
> > >      init_module_from_file+0xe4/0x150
> > >      idempotent_init_module+0x32c/0x610
> > >      __x64_sys_finit_module+0xbd/0x120
> > >      do_syscall_64+0xa8/0x270
> > >      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > 
> > > When device_create_file() return error in atm_register_sysfs(), the same
> > > issue also can be triggered.
> > > 
> > > Function put_device() should be called to release kobj->name memory and
> > > other device resource, instead of kfree().
> > > 
> > > Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
> > > Signed-off-by: Wang Liang <wangliang74@huawei.com>
> > Thanks Wang Liang,
> > 
> > I agree this is a bug.
> > 
> > I think that the guiding principle should be that on error functions
> > unwind any resource allocations they have made, rather than leaving
> > it up to callers to clean things up.
> > 
> > So, as the problem you describe seems to be due to atm_register_sysfs()
> > leaking resources if it encounters an error, I think the problem would
> > best be resolved there.
> > 
> > Perhaps something like this.
> > (Compile tested only!)
> > 
> > diff --git a/net/atm/atm_sysfs.c b/net/atm/atm_sysfs.c
> > index 54e7fb1a4ee5..62f3d520a80a 100644
> > --- a/net/atm/atm_sysfs.c
> > +++ b/net/atm/atm_sysfs.c
> > @@ -148,20 +148,23 @@ int atm_register_sysfs(struct atm_dev *adev, struct device *parent)
> >   	dev_set_name(cdev, "%s%d", adev->type, adev->number);
> >   	err = device_register(cdev);
> >   	if (err < 0)
> > -		return err;
> > +		goto err_put_dev;
> >   	for (i = 0; atm_attrs[i]; i++) {
> >   		err = device_create_file(cdev, atm_attrs[i]);
> >   		if (err)
> > -			goto err_out;
> > +			goto err_remove_file;
> >   	}
> >   	return 0;
> > -err_out:
> > +err_remove_file:
> >   	for (j = 0; j < i; j++)
> >   		device_remove_file(cdev, atm_attrs[j]);
> >   	device_del(cdev);
> > +err_put_dev:
> > +	put_device(cdev);
> > +
> >   	return err;
> >   }
> 
> 
> Thanks for your replies, it is very clear!
> 
> But the above code may introduce a use-after-free issue. If
> device_register()
> fails, put_device() call atm_release() to free atm_dev, and
> atm_proc_dev_deregister() will visit it.
> 
> And kfree() should be removed in atm_dev_register() to avoid double-free.

Thanks, I see that now.

I do think that it would be nice to untangle the error handling here.
But, as a but fix I now think your original approach is good.
Because it addresses the issue in a minimal way.

Reviewed-by: Simon Horman <horms@kernel.org>

> > Looking over atm_dev_register, it seems to me that it will deadlock
> > if it calls atm_proc_dev_deregister() if atm_register_sysfs() fails.
> > This is because atm_dev_register() is holding atm_dev_mutex,
> > and atm_proc_dev_deregister() tries to take atm_dev_mutex().
> 
> 
> I cannot find somewhere tries to take atm_dev_mutex(), can you give some
> hints?

Sorry, my mistake. I was looking at atm_dev_deregister()
rather than atm_proc_dev_deregister().

...

-- 
pw-bot: under-review

