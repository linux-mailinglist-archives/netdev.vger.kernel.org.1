Return-Path: <netdev+bounces-168833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBECA40F89
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 16:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51EB17004F
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C6620A5C2;
	Sun, 23 Feb 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EgbuNogk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32D020A5E7
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740325299; cv=none; b=Ox5CGFfw3+oC3Llm8q8Vv2ZPzY6/fWrhDF1dx16qHuY21mcnX4azJpcsEE2o2Ki3vPonRjVo+qH4iPNHljPyMS1aaP/SJcfaDGODkaKboowtU5PxM/v0Y5HfFoo3n5THAXynsykauxVZPv5JswOa/BW2tFYjwodmORuTX0y9Kk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740325299; c=relaxed/simple;
	bh=ZXiEdTTDkzwOV/njsO665pJImpsVwviM91yrhio2Vu4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slyDJs+CQHdYG7XRK41Xuj0tJ5pWG1hScJt8TWrtiv0pTqJ8GhwX0EkYjgjg0fwGaF1xhS6YKvhuO67saBCp80sbqF/2K4uZV4OzuPoKB75umbLXwra2AGQ1irU9PIviOpSQ16WRPSh2jzSRoIVCV03SKKw61DNOO1xjVnXGbN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EgbuNogk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740325296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5Ma3bsAkPkhFtnIEw/9PBZEYBfxPhfHkVWn0LCGlvg=;
	b=EgbuNogkgCts6fPoQmX/vePz7gOHMJR9PO03skGeHObJrEpbGdvQ/jv4PwRiUYXijRrwR2
	XHQAwrkfuVfyGaZZxq/bJof0ObDGG5dN5ZZJj4FNjHUrLE5jK/ImbeNl2CRc4umVun0mBP
	IHCb5Y0/uGn4hyZMrPISBoaKAMeWYUU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-2ENMbybrPVK4rSVx4t1vnA-1; Sun,
 23 Feb 2025 10:41:35 -0500
X-MC-Unique: 2ENMbybrPVK4rSVx4t1vnA-1
X-Mimecast-MFC-AGG-ID: 2ENMbybrPVK4rSVx4t1vnA_1740325294
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AF0219560BC;
	Sun, 23 Feb 2025 15:41:34 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.28])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4C251800359;
	Sun, 23 Feb 2025 15:41:29 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 4/6] vhost: introduce worker ops to support multiple thread models
Date: Sun, 23 Feb 2025 23:36:19 +0800
Message-ID: <20250223154042.556001-5-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-1-lulu@redhat.com>
References: <20250223154042.556001-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This commit restores the previously removed functions kthread_wakeup and
kthread_stop, and introduces a new ops structure to handle worker wakeup,
stop, and creation. The function vhost_worker_create initializes these
ops pointers based on the inherit_owner value.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 115 +++++++++++++++++++++++++++++++++++-------
 drivers/vhost/vhost.h |  12 +++++
 2 files changed, 110 insertions(+), 17 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index adbb957c8b5f..d8c0ea118bb1 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -243,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *worker,
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &worker->work_list);
-		vhost_task_wake(worker->vtsk);
+		worker->ops->wakeup(worker);
 	}
 }
 
@@ -697,7 +697,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
 
 	WARN_ON(!llist_empty(&worker->work_list));
 	xa_erase(&dev->worker_xa, worker->id);
-	vhost_task_stop(worker->vtsk);
+	worker->ops->stop(worker);
 	kfree(worker);
 }
 
@@ -720,42 +720,123 @@ static void vhost_workers_free(struct vhost_dev *dev)
 	xa_destroy(&dev->worker_xa);
 }
 
+static void vhost_task_wakeup_fn(struct vhost_worker *worker)
+{
+	return vhost_task_wake(worker->vtsk);
+}
+
+static void vhost_kthread_wakeup_fn(struct vhost_worker *worker)
+{
+	wake_up_process(worker->kthread_task);
+}
+
+static void vhost_task_stop_fn(struct vhost_worker *worker)
+{
+	return vhost_task_stop(worker->vtsk);
+}
+
+static void vhost_kthread_stop_fn(struct vhost_worker *worker)
+{
+	kthread_stop(worker->kthread_task);
+}
+
+static int vhost_task_worker_create_fn(struct vhost_worker *worker,
+				       struct vhost_dev *dev, const char *name)
+{
+	struct vhost_task *vtsk;
+	u32 id;
+	int ret;
+
+	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
+				 worker, name);
+	if (!vtsk)
+		return -ENOMEM;
+
+	worker->vtsk = vtsk;
+	vhost_task_start(vtsk);
+	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
+	if (ret < 0) {
+		vhost_task_stop_fn(worker);
+		return ret;
+	}
+	worker->id = id;
+	return 0;
+}
+
+static int kthread_worker_create_fn(struct vhost_worker *worker,
+				    struct vhost_dev *dev, const char *name)
+{
+	struct task_struct *task;
+	u32 id;
+	int ret;
+
+	task = kthread_create(vhost_run_work_kthread_list, worker, "%s", name);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
+	worker->kthread_task = task;
+	wake_up_process(task);
+	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
+	if (ret < 0)
+		goto stop_worker;
+
+	ret = vhost_attach_task_to_cgroups(worker);
+	if (ret)
+		goto stop_worker;
+
+	worker->id = id;
+	return 0;
+
+stop_worker:
+	vhost_kthread_stop_fn(worker);
+	return ret;
+}
+
+static const struct vhost_worker_ops vhost_task_ops = {
+	.create = vhost_task_worker_create_fn,
+	.stop = vhost_task_stop_fn,
+	.wakeup = vhost_task_wakeup_fn,
+};
+
+static const struct vhost_worker_ops kthread_ops = {
+	.create = kthread_worker_create_fn,
+	.stop = vhost_kthread_stop_fn,
+	.wakeup = vhost_kthread_wakeup_fn,
+};
+
 static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
-	struct vhost_task *vtsk;
 	char name[TASK_COMM_LEN];
 	int ret;
-	u32 id;
+	const struct vhost_worker_ops *ops =
+		dev->inherit_owner ? &vhost_task_ops : &kthread_ops;
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
 	if (!worker)
 		return NULL;
 
 	worker->dev = dev;
+	worker->ops = ops;
 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
 
-	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
-				 worker, name);
-	if (!vtsk)
-		goto free_worker;
-
 	mutex_init(&worker->mutex);
 	init_llist_head(&worker->work_list);
 	worker->kcov_handle = kcov_common_handle();
-	worker->vtsk = vtsk;
-
-	vhost_task_start(vtsk);
+	/*
+	 * If inherit_owner is true we use vhost_tasks to create
+	 * the worker so all settings/limits like cgroups, NPROC,
+	 * scheduler, etc are inherited from the owner. If false,
+	 * we use kthreads and only attach to the same cgroups
+	 * as the owner for compat with older kernels.
+	 */
 
-	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
+	ret = ops->create(worker, dev, name);
 	if (ret < 0)
-		goto stop_worker;
-	worker->id = id;
+		goto free_worker;
 
 	return worker;
 
-stop_worker:
-	vhost_task_stop(vtsk);
 free_worker:
 	kfree(worker);
 	return NULL;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index c650c4506c70..029c203147be 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -26,7 +26,18 @@ struct vhost_work {
 	unsigned long		flags;
 };
 
+struct vhost_worker;
+struct vhost_dev;
+
+struct vhost_worker_ops {
+	int (*create)(struct vhost_worker *worker, struct vhost_dev *dev,
+		      const char *name);
+	void (*stop)(struct vhost_worker *worker);
+	void (*wakeup)(struct vhost_worker *worker);
+};
+
 struct vhost_worker {
+	struct task_struct *kthread_task;
 	struct vhost_task	*vtsk;
 	struct vhost_dev	*dev;
 	/* Used to serialize device wide flushing with worker swapping. */
@@ -36,6 +47,7 @@ struct vhost_worker {
 	u32			id;
 	int			attachment_cnt;
 	bool			killed;
+	const struct vhost_worker_ops *ops;
 };
 
 /* Poll a file (eventfd or socket) */
-- 
2.45.0


