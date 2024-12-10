Return-Path: <netdev+bounces-150787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5492B9EB8C5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9CB167417
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DD61C5CAE;
	Tue, 10 Dec 2024 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCBcFWjW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709391C2DB0
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853231; cv=none; b=gjj9Pt6Qg1sCvQGilPlWXN3te68DSpg3zptaj2MB9engfv+tCaV7cJ0vgxKz3tFXJu6SQCHneTd+01wTAm2VwJNpeftTC1zfEmyOem/C/GykvPjkYqMmpXeW/L+jKgULMAy+0tIA19CrPxYeyJuL5JKQztHuvl8FV27lleYkrxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853231; c=relaxed/simple;
	bh=MNqAkPSPphqjJu0FajBa+/GSbOj+dbdFL2TppIrfy8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeiMOX+LIxGAifTwaQl51JwHoxJ0t5ZQWI/iuMQz19M4bT+U4KMH3YrOiKR30YEdoCzZZtdNDqDrjE4ouEvEt9yCibFzRaYiI3TcXllPYxAhRk3OGQ3aiUEzlJX8JNXY14dxjd425cWOHeB2/jN4dWSZlVkLIniYQisP1hOvKjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCBcFWjW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733853228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFSgmN6SpEZv7ied5w57JWzZ05da8WEnfkAl6Ff6sig=;
	b=aCBcFWjWGu3LfGJ051lq0745olbjNGRyDIkbJN6QuU7TCfaXL2WRJH+CD+bET/RXAdLroA
	AJIB3cDkGKCzQQjM1A3Zyi8b5an0v7kX1cTQdKQlm5oAwuuj/NS0Tv9wHilMKZ8c42ULdb
	vwd7C5SnaKCXw0YE8YmZ3n+avVo2Ebc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-lA2poINxMSio2EDUq9NiZQ-1; Tue, 10 Dec 2024 12:53:47 -0500
X-MC-Unique: lA2poINxMSio2EDUq9NiZQ-1
X-Mimecast-MFC-AGG-ID: lA2poINxMSio2EDUq9NiZQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361ac607b6so3180055e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853226; x=1734458026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFSgmN6SpEZv7ied5w57JWzZ05da8WEnfkAl6Ff6sig=;
        b=SM8cjornieu4CQLlTztWb4Ze2fM/M1gRmCzEtWuzXofGEGKbnU+jfNVOQjmQvoCY6U
         jCJzlfApQC5F16afB/BqzaPwOr6sdyCycMCwDHQXUFHTwlniRb1U0vf2m5MGdR0pVe9Z
         cJE8DFOpr1av7YQbuuJvd5MRZp6BIo/dVz0yCGQF3k0xoZO1LVifnJylXJMTT/QPB/Lo
         X8P2j3SU/3JVfXO3DeyYlu6vAZO62eTlBtyT7eOy+WNPxBPM03E8osMXJkNmUTgD6//C
         VY5inzJgUdwMqZx63qRGukvZczbtKpCPj9GChDPrRsTpDV401GLbwnAMIbpsXRDDmidd
         kUog==
X-Forwarded-Encrypted: i=1; AJvYcCUD4B2xuG21QTMwcpSx9BbhJlqnA4qGOCsrzqn7CUD/5xOflR2Noq3gusd+/XJntAWGEYwn4D4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx37+M3B0pa6K01TDzrlJKl659C+njHVuwwCXuMXT8XNNCketYm
	zmMik372s/UETlnt/2z7hIcCT05b/zZpUMtNMjNqAwEs+mzkyFDxUTFV8ABHIj5jyJk4iXYBKbo
	WQCJ9UY1ViQ0bCPxYGxzowlSyGcxLoVcL6xGdGylIMhtbvlYUGu9R6A==
X-Gm-Gg: ASbGncsMh67eNiEe0elNx3j3o3+1kRJFyElzvlN/ChAVBGeFGitX5rI1Ai6tmeaxTO6
	zOvvvUFqL2K98y3d0bw8vULg7mefxR/oS7I0a5PhCTfQFsWpGI+JrZgfQY7p9+s+0XTtDE5OxiY
	LewpckKNCS1X1CZQ1BGk/Le/v/gr7JCytVSmMP+ac4ahl9p9Ke0/djrkJTupp24MXWBT/mfcS1I
	mW0vQpNOogvdJkvy6UkaMroam1rTf2HdjqEJo6ZHKj1qgzuvhAytKyM2ZflPtveRx7jE3k1LEjI
	C0+7RcWyJBR194kiTf9rT8F7uhs0vQ==
X-Received: by 2002:a05:600c:511e:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-435032e83damr32933225e9.14.1733853226347;
        Tue, 10 Dec 2024 09:53:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN1ImdeWiX02Zft7WQtaNeqCqOw1VECCxaDxN2w3/vQtjXRD+3ejKXYKSfaeaXKQQHoQPWCg==
X-Received: by 2002:a05:600c:511e:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-435032e83damr32932745e9.14.1733853225666;
        Tue, 10 Dec 2024 09:53:45 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da119abbsm202901785e9.43.2024.12.10.09.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:53:45 -0800 (PST)
Date: Tue, 10 Dec 2024 18:53:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 4/8] vhost: Add kthread support in function
 vhost_worker_create
Message-ID: <timclk34js4wmtlsnvpjl3fuq3p2e5stdqxr47mky42hctgsl2@r3hhc3lx6wig>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-5-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241210164456.925060-5-lulu@redhat.com>

On Wed, Dec 11, 2024 at 12:41:43AM +0800, Cindy Lu wrote:
>Restored the previous functions kthread_wakeup and kthread_stop.

nit: "Add back the previously removed"

>Also add 2 new function pointer. 

"Also add 2 new function pointers to wakeup and stop the workers."

> The function vhost_worker_create
>Will initializes this pointer based on the value of inherit_owner.

nit: s/Will/will

>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 84 +++++++++++++++++++++++++++++++++++--------
> drivers/vhost/vhost.h |  3 ++
> 2 files changed, 73 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 812dfd218bc2..0175bbf4d8b3 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -721,14 +721,38 @@ static void vhost_workers_free(struct vhost_dev *dev)
> 	xa_destroy(&dev->worker_xa);
> }
>
>+static int vhost_task_wakeup_fn(struct vhost_worker *worker)
>+{
>+	vhost_task_wake(worker->vtsk);
>+	return 0;
>+}
>+
>+static int vhost_kthread_wakeup_fn(struct vhost_worker *worker)
>+{
>+	return wake_up_process(worker->kthread_task);
>+}
>+
>+static int vhost_task_stop_fn(struct vhost_worker *worker)
>+{
>+	vhost_task_stop(worker->vtsk);
>+	return 0;
>+}
>+
>+static int vhost_kthread_stop_fn(struct vhost_worker *worker)
>+{
>+	return kthread_stop(worker->kthread_task);
>+}
>+
> static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> {
> 	struct vhost_worker *worker;
>-	struct vhost_task *vtsk;
>+	struct vhost_task *vtsk = NULL;
>+	struct task_struct *task = NULL;
> 	char name[TASK_COMM_LEN];
> 	int ret;
> 	u32 id;
>
>+	/* Allocate resources for the worker */
> 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
> 	if (!worker)
> 		return NULL;
>@@ -736,27 +760,59 @@ static struct vhost_worker 
>*vhost_worker_create(struct vhost_dev *dev)
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
>
>-	vhost_task_start(vtsk);
>+	if (dev->inherit_owner) {
>+		/*
>+		 * If inherit_owner is true we use vhost_tasks to create
>+		 * the worker so all settings/limits like cgroups, NPROC,
>+		 * scheduler, etc are inherited from the owner. If false,
>+		 * we use kthreads and only attach to the same cgroups
>+		 * as the owner for compat with older kernels.
>+		 */
>+		vtsk = vhost_task_create(vhost_run_work_list,
>+					 vhost_worker_killed, worker, name);
>+		if (!vtsk)
>+			goto free_worker;
>+
>+		worker->vtsk = vtsk;
>+		worker->task_wakeup = vhost_task_wakeup_fn;
>+		worker->task_stop = vhost_task_stop_fn;
>+
>+		vhost_task_start(vtsk);
>+		ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b,
>+			       GFP_KERNEL);
>+		if (ret < 0)
>+			goto stop_worker;
>+	} else {
>+		/* Create and start a kernel thread */

I would move here the comment included in the previous branch:
"If false we use kthreads and only attach to... "

Or move the entire comment block before the if.

>+		task = kthread_create(vhost_run_work_kthread_list, worker,
>+				      "vhost-%d", current->pid);
>+		if (IS_ERR(task)) {
>+			ret = PTR_ERR(task);
>+			goto free_worker;
>+		}
>+		worker->kthread_task = task;
>+		worker->task_wakeup = vhost_kthread_wakeup_fn;
>+		worker->task_stop = vhost_kthread_stop_fn;
>
>-	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
>-	if (ret < 0)
>-		goto stop_worker;
>-	worker->id = id;
>+		wake_up_process(task);
>+		ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b,
>+			       GFP_KERNEL);
>+		if (ret < 0)
>+			goto stop_worker;
>
>-	return worker;
>+		ret = vhost_attach_task_to_cgroups(worker);
>+		if (ret)
>+			goto stop_worker;
>+	}
>
>+	worker->id = id;
>+	return worker;
> stop_worker:
>-	vhost_task_stop(vtsk);
>+	worker->task_stop(worker);
> free_worker:
> 	kfree(worker);
> 	return NULL;
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index c650c4506c70..a7dc6e168753 100644
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
>+	int (*task_wakeup)(struct vhost_worker *worker);
>+	int (*task_stop)(struct vhost_worker *worker);

We never read the return values of these functions, so either mark them 
both void or check their return value.

What about renaming in worker_wakeup and worker_stop?
Or even better since they are part of vhost_worker, just wakeup and 
stop.

Thanks,
Stefano

> };
>
> /* Poll a file (eventfd or socket) */
>-- 
>2.45.0
>


