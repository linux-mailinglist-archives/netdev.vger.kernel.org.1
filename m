Return-Path: <netdev+bounces-156292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09613A05EC6
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5607A3A1282
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 14:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938F21EBA08;
	Wed,  8 Jan 2025 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsCWzG0o"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A3A7DA6A
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346928; cv=none; b=hN0kJ9ALinI05vV0HEQB+1ZWAbHqfk/J5sqICIKEFFQMSnv5CQ6t/50xURjAU88exJ1TB6Hpvot9kH4Rn/sTBwTZR+H7YYDjRWqBw9mBP2LNhxnoWCj462vEKSI8yQwhsWbk2/AzgewqbbEhsSzP7PHSpjpuUvg0NBezivvR0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346928; c=relaxed/simple;
	bh=cGZJRyPafRKNJJY5vcDxe6f14C30b1JFes5npfM4sq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqs7rkB715kqoya2g/G6lAoWTs2L7niyfhbcJkmuzrZtZktBZkxC+GZqwvGDTtOjugs9gWpdzMqUb9mEgNfjQJ6HNfgntI7ERhJFcuXUgYXIuk8LcSxBjmia+oibXChIN2XWGxEh3pCMBqgPqJFcQikwCfkojPpZbBtv6hFLpt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KsCWzG0o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736346925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/5ZTMHD9LRSOsMkn2E1KdU1LHI0MWopp6tiSITVH5L0=;
	b=KsCWzG0o0JAgP4JDv+xiwRAgUj6ceIrbxdIemZlDbB2tZldmIO0J4TZCpgR814xkpJpwyY
	hWL9k2h0kc7F2rlutx9pfiO1oUP3nkENpxmBGHGAFz/LTfqyGJqPe5L6ElBI243YY181IU
	mzg6/LL5dnpPKT8nnzwcIOnhRv2dQGI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-EJ72wHe2OxSLaC9i8Z8VLQ-1; Wed, 08 Jan 2025 09:35:24 -0500
X-MC-Unique: EJ72wHe2OxSLaC9i8Z8VLQ-1
X-Mimecast-MFC-AGG-ID: EJ72wHe2OxSLaC9i8Z8VLQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-388d1f6f3b2so6754964f8f.0
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 06:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736346923; x=1736951723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5ZTMHD9LRSOsMkn2E1KdU1LHI0MWopp6tiSITVH5L0=;
        b=QOQbylf3H5tl7WKu3OVCZ9JBmXYh6+sqFEh7dFoG9RsSFwYVgxy6Zcdu4V1SO7GEyC
         Xs8gY6VAGUU4A9yPur8Wvt0LSQiz86FUneirP0aIXUJogWdt2UBDx6enekPlawbfDGu/
         nPNPwvRxHhuuu1qnBHk/4Tz37Vi+2s6VKSGm1FLAbQRagXGlCHhGDzdLwym0GheWObdp
         GP4ggYtMOySgN3Udw8hc7nquFcEaznQvscEn884Ro8wTLsdMzgOxCIjBhdGAfhzeljlO
         wJEzuQMYUbyxQEZ8MeBfO88O1hdPO/SPl5dG989btq4lVNg9F3V22HG6onrEvowX2oMw
         Hb+A==
X-Forwarded-Encrypted: i=1; AJvYcCXfFSYd8Hs2t2qoPtH8WPWi2/kj6oOJV3LsRqTyVN/ez5h5v+wWGxuRvGGp0jjRQnBhHGmF2uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxPb6OzQUGXB/y9JzPQm8NZHAK6WyJ6y+6FWBTmZgDrwDlgmhd
	QE0uxiacnoQxJ2UbxidQUsJesRPpojSREVJIdafVcKzlaQYNeNQodaqZOP1z4BYsxI9jlYQZAkm
	N8SvYuG1j+8FLr7A3Veb4Q8H+G5hE+J0q0iq44+sTmqba9cIqON2Klw==
X-Gm-Gg: ASbGncsmuNDjnVIdkpxEmi0/po1FAQSH9idCfWxHgraVyZHxyOf7av33T2g7tFs23/Q
	KdgUjY+1O7dd1zr2vX4VZxS3S/gSDFs55sF7ITBtbcOXMC758ycr3BrWqED8D2TQZomYsaSK1aC
	wPzu8/cYZnS++7nN64ChSEGTEe8dgl1yjFTkNL4OZ4VDv8DRYnU9l66TNhyI2k7LEKpSTaphig+
	a774VFvSqnjVvS/XKBISoYxK7FAMnVx7QSxJgHQ5KJgcqWtTGF8UfB77w==
X-Received: by 2002:a05:6000:719:b0:385:e879:45cc with SMTP id ffacd0b85a97d-38a873045d9mr2369579f8f.19.1736346922754;
        Wed, 08 Jan 2025 06:35:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmXEY/7tcjhjyBGapU8wmd3WjpH1fL63j8ZoTYBsDKD9dKaBd2q4JDYo9XrZZQc+PlVC9+Tg==
X-Received: by 2002:a05:6000:719:b0:385:e879:45cc with SMTP id ffacd0b85a97d-38a873045d9mr2369547f8f.19.1736346922181;
        Wed, 08 Jan 2025 06:35:22 -0800 (PST)
Received: from sgarzare-redhat ([5.77.93.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8289a0sm54534369f8f.7.2025.01.08.06.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:35:21 -0800 (PST)
Date: Wed, 8 Jan 2025 15:35:15 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 4/6] vhost: Add worker related functions to support
 kthread
Message-ID: <foiitmbzkjjjbnz46sfy627jsfwkvya42zujxiigykzj2dluya@iumroiukvfld>
References: <20241230124445.1850997-1-lulu@redhat.com>
 <20241230124445.1850997-5-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241230124445.1850997-5-lulu@redhat.com>

On Mon, Dec 30, 2024 at 08:43:51PM +0800, Cindy Lu wrote:
>Restore the previously removed functions kthread_wakeup and
>kthread_stop, and add two new function pointers to wake up and stop
>the workers. The function vhost_worker_create will initialize these
>pointers based on the value of inherit_owner.
>
>The functions vhost_worker_queue() and vhost_worker_destroy() will
>use the function pointer in vhost_worker, which is initialized
>according to the inherit_owner value.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 84 ++++++++++++++++++++++++++++++++++---------
> drivers/vhost/vhost.h |  3 ++
> 2 files changed, 71 insertions(+), 16 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 812dfd218bc2..ff17c42e2d1a 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c

[...]

>@@ -736,27 +758,57 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> 	worker->dev = dev;
> 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
>
>-	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
>-				 worker, name);
>-	if (!vtsk)
>-		goto free_worker;
>-
> 	mutex_init(&worker->mutex);
> 	init_llist_head(&worker->work_list);
> 	worker->kcov_handle = kcov_common_handle();
>-	worker->vtsk = vtsk;
>+    /*
>+     * If inherit_owner is true we use vhost_tasks to create
>+     * the worker so all settings/limits like cgroups, NPROC,
>+     * scheduler, etc are inherited from the owner.
>+     * If false,we use kthreads and only attach to the same
>+     * cgroups as the owner for compat with older kernels.
>+     */

This comment block seems to have incorrect indentation, perhaps you need 
to replace the spaces with at least one tab.

>+	if (dev->inherit_owner) {
>+		vtsk = vhost_task_create(vhost_run_work_list,
>+					 vhost_worker_killed, worker, name);
>+		if (!vtsk)
>+			goto free_worker;
>+
>+		worker->vtsk = vtsk;
>+		worker->worker_wakeup = vhost_task_wakeup_fn;
>+		worker->worker_stop = vhost_task_stop_fn;
>+
>+		vhost_task_start(vtsk);
>+		ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b,
>+			       GFP_KERNEL);
>+		if (ret < 0)
>+			goto stop_worker;
>+	} else {
>+		task = kthread_create(vhost_run_work_kthread_list, worker,
>+				      "vhost-%d", current->pid);
>+		if (IS_ERR(task)) {
>+			ret = PTR_ERR(task);
>+			goto free_worker;
>+		}
>+		worker->kthread_task = task;
>+		worker->worker_wakeup = vhost_kthread_wakeup_fn;
>+		worker->worker_stop = vhost_kthread_stop_fn;
>
>-	vhost_task_start(vtsk);
>+		wake_up_process(task);
>+		ret = xa_alloc(&dev->worker_xa, &id, worker, 
>xa_limit_32b,
>+			       GFP_KERNEL);
>+		if (ret < 0)
>+			goto stop_worker;
>
>-	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
>-	if (ret < 0)
>-		goto stop_worker;
>-	worker->id = id;
>+		ret = vhost_attach_task_to_cgroups(worker);
>+		if (ret)
>+			goto stop_worker;
>+	}
>
>+	worker->id = id;
> 	return worker;
>-
> stop_worker:
>-	vhost_task_stop(vtsk);
>+	worker->worker_stop(worker);
> free_worker:
> 	kfree(worker);
> 	return NULL;
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index c650c4506c70..63b1da08a2b0 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -27,6 +27,7 @@ struct vhost_work {
> };
>
> struct vhost_worker {
>+	struct task_struct *kthread_task;
> 	struct vhost_task	*vtsk;
> 	struct vhost_dev	*dev;
> 	/* Used to serialize device wide flushing with worker swapping. */
>@@ -36,6 +37,8 @@ struct vhost_worker {
> 	u32			id;
> 	int			attachment_cnt;
> 	bool			killed;
>+	void (*worker_wakeup)(struct vhost_worker *worker);
>+	void (*worker_stop)(struct vhost_worker *worker);
> };
>
> /* Poll a file (eventfd or socket) */
>-- 
>2.45.0
>


