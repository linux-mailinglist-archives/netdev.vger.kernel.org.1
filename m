Return-Path: <netdev+bounces-141822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF029BC6FE
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 08:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3CE1C21437
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 07:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CB71FEFA3;
	Tue,  5 Nov 2024 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghCjANkL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B961FDF95
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791671; cv=none; b=iiq193x72oelrFCpOBi65EdAhbWG0OutpLHoXCuMg7snZdbkp1szPVvdG4VCBybYuJZocDyVO9df4srd523fAHs6lXExZyQply06C91T7I8xLvrv8nq3GWFeVFgL2HDLy3I03C+vFd6a2ly/+5jN6qLKRMiBQb1dVwh52hmT29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791671; c=relaxed/simple;
	bh=px/d7GxNDVWjUeXbE2siNdRGmuGHmt+Dj/2C3sOfk6E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hxa0N4zKoJrSjgy++RE98XQJJMfRBvu4r6Yx6FGYc+UH00Yp/WDQbt3TXQnM0rSnXE3QcG7W8HOkaAuJJQ1hMmguiRldnnL3s2H/KbVkV9Nu6WsuN3Wqr+CcRBpM4Ibu1cAznXKEUEjhj4htkhVzdeCbZLOsKDgL70RMxhppAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghCjANkL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730791668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZXrpm6Hjv9R5RedbyYefAVChV5g9ZLlA5EfzIRNc4s=;
	b=ghCjANkLACDTehsBDtRhB0Me2suBMPtIPw8Mibue6ZMY6Du9Mzw8pz+Oy3SJItf6BD9Gdt
	X/WlHeSzUBT9fkwmb4fcin8vWPVUXQBPqgjywytcmeQVh969riKYnSajbKDeZcMlsQz0XO
	pDUMQVkxMYVqmR6SLiyio9jVxGd6i3s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-irnbstHlPvKijBtIh1Pthg-1; Tue,
 05 Nov 2024 02:27:45 -0500
X-MC-Unique: irnbstHlPvKijBtIh1Pthg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 928681956048;
	Tue,  5 Nov 2024 07:27:44 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DDEEE1956086;
	Tue,  5 Nov 2024 07:27:39 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 4/9] vhost: Add kthread support in function vhost_worker_create
Date: Tue,  5 Nov 2024 15:25:23 +0800
Message-ID: <20241105072642.898710-5-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-1-lulu@redhat.com>
References: <20241105072642.898710-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Restored the previous functions kthread_wakeup and kthread_stop.
Also add a new structure, vhost_task_fn. The function vhost_worker_create
Will initializes this structure based on the value of inherit_owner.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 71 ++++++++++++++++++++++++++++++++++++-------
 drivers/vhost/vhost.h |  6 ++++
 2 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index e40cef3a1fa5..603b146fccc1 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -741,43 +741,92 @@ static void vhost_workers_free(struct vhost_dev *dev)
 	xa_destroy(&dev->worker_xa);
 }
 
+static int vhost_task_wakeup_fn(void *vtsk)
+{
+	vhost_task_wake((struct vhost_task *)vtsk);
+	return 0;
+}
+static int vhost_kthread_wakeup_fn(void *p)
+{
+	return wake_up_process((struct task_struct *)p);
+}
+static int vhost_task_stop_fn(void *vtsk)
+{
+	vhost_task_stop((struct vhost_task *)vtsk);
+	return 0;
+}
+static int vhost_kthread_stop_fn(void *k)
+{
+	return kthread_stop((struct task_struct *)k);
+}
+
 static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
-	struct vhost_task *vtsk;
+	struct vhost_task *vtsk = NULL;
+	struct task_struct *task = NULL;
 	char name[TASK_COMM_LEN];
 	int ret;
 	u32 id;
 
+	/* Allocate resources for the worker */
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
 	if (!worker)
 		return NULL;
 
+	worker->fn = kzalloc(sizeof(struct vhost_task_fn), GFP_KERNEL_ACCOUNT);
+	if (!worker->fn) {
+		kfree(worker);
+		return NULL;
+	}
+
 	worker->dev = dev;
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
 
-	vhost_task_start(vtsk);
+	if (dev->inherit_owner) {
+		/* Create and start a vhost task */
+		vtsk = vhost_task_create(vhost_run_work_list,
+					 vhost_worker_killed, worker, name);
+		if (!vtsk)
+			goto free_worker;
+
+		worker->vtsk = vtsk;
+		worker->fn->wakeup = vhost_task_wakeup_fn;
+		worker->fn->stop = vhost_task_stop_fn;
+
+		vhost_task_start(vtsk);
+	} else {
+		/* Create and start a kernel thread */
+		task = kthread_create(vhost_run_work_kthread_list, worker,
+				      "vhost-%d", current->pid);
+		if (IS_ERR(task)) {
+			ret = PTR_ERR(task);
+			goto free_worker;
+		}
+		worker->task = task;
+		worker->fn->wakeup = vhost_kthread_wakeup_fn;
+		worker->fn->stop = vhost_kthread_stop_fn;
+
+		wake_up_process(task);
+		/* Attach to the vhost cgroup */
+		ret = vhost_attach_cgroups(dev);
+		if (ret)
+			goto stop_worker;
+	}
 
 	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
 	if (ret < 0)
 		goto stop_worker;
 	worker->id = id;
-
 	return worker;
-
 stop_worker:
-	vhost_task_stop(vtsk);
+	worker->fn->stop(dev->inherit_owner ? (void *)vtsk : (void *)task);
 free_worker:
+	kfree(worker->fn);
 	kfree(worker);
 	return NULL;
 }
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index c650c4506c70..ebababa4e340 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -25,8 +25,13 @@ struct vhost_work {
 	vhost_work_fn_t		fn;
 	unsigned long		flags;
 };
+struct vhost_task_fn {
+	int (*wakeup)(void *task);
+	int (*stop)(void *task);
+};
 
 struct vhost_worker {
+	struct task_struct	*task;
 	struct vhost_task	*vtsk;
 	struct vhost_dev	*dev;
 	/* Used to serialize device wide flushing with worker swapping. */
@@ -36,6 +41,7 @@ struct vhost_worker {
 	u32			id;
 	int			attachment_cnt;
 	bool			killed;
+	struct vhost_task_fn *fn;
 };
 
 /* Poll a file (eventfd or socket) */
-- 
2.45.0


