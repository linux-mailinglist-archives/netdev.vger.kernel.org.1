Return-Path: <netdev+bounces-150757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0119EB6DF
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66E61889880
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774902343BA;
	Tue, 10 Dec 2024 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3BtGeHF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3B233D9D
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849155; cv=none; b=DO/+K1bnbqRePnyoDjEmY8z1TG/Am7P3lGgYI0aM6C4wb8pMQalTK4eOVnVbahC3lYFwM+3diOqayaw51hxgd2x5/rVqdHvwpgKKFNh4ZdH6lWyL3QLPHJSkeqvaardaGiX1xXZzL8LJb2pw5skHmZHuJhdbOvtH5N2ZrN0CsHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849155; c=relaxed/simple;
	bh=4B0ZpVZ34G6urTCswIW4fjE7WC33IuSy9G1WhtjJ4oc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rj1Z9wN6twpYtD0kYrwL+COTuEgwwABcT1b2DK9AD6KqnfdcV5eez8qUBLS96ygvIcRMrgPe+0nuI/L/zWqs/g0CptNTUuBx+AMED4iUaYacZLuCREdPHarBgdfoVZUSK3KkhMRVQX7x42AMqVdNy5PagsZF6HUbGskclk6d3xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3BtGeHF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733849152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjpO7WFrcW5swnLsneWZbZdM229f02z/cjRoCQsUlIs=;
	b=b3BtGeHFjCSiuOprxSmi51NMy8ZAfF7ivhgSfYLNYVbHlpXInS8ixdbRcEts7NNKdIAr6t
	+iTi6Sw+MSB5Rly7DT5/0k7mZovwuQtk19CWwl4q3lVSyVWYRd6YiF1wfSchGbeX9fvVDC
	9NzRm+R1TASMs/z0Jbpep9INmkwEnZc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-r9atTP5WPIGP6PDHxbghFQ-1; Tue,
 10 Dec 2024 11:45:48 -0500
X-MC-Unique: r9atTP5WPIGP6PDHxbghFQ-1
X-Mimecast-MFC-AGG-ID: r9atTP5WPIGP6PDHxbghFQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95B8719541BA;
	Tue, 10 Dec 2024 16:45:47 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.152])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2556019560A7;
	Tue, 10 Dec 2024 16:45:42 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 4/8] vhost: Add kthread support in function vhost_worker_create
Date: Wed, 11 Dec 2024 00:41:43 +0800
Message-ID: <20241210164456.925060-5-lulu@redhat.com>
In-Reply-To: <20241210164456.925060-1-lulu@redhat.com>
References: <20241210164456.925060-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Restored the previous functions kthread_wakeup and kthread_stop.
Also add 2 new function pointer. The function vhost_worker_create
Will initializes this pointer based on the value of inherit_owner.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 84 +++++++++++++++++++++++++++++++++++--------
 drivers/vhost/vhost.h |  3 ++
 2 files changed, 73 insertions(+), 14 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 812dfd218bc2..0175bbf4d8b3 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -721,14 +721,38 @@ static void vhost_workers_free(struct vhost_dev *dev)
 	xa_destroy(&dev->worker_xa);
 }
 
+static int vhost_task_wakeup_fn(struct vhost_worker *worker)
+{
+	vhost_task_wake(worker->vtsk);
+	return 0;
+}
+
+static int vhost_kthread_wakeup_fn(struct vhost_worker *worker)
+{
+	return wake_up_process(worker->kthread_task);
+}
+
+static int vhost_task_stop_fn(struct vhost_worker *worker)
+{
+	vhost_task_stop(worker->vtsk);
+	return 0;
+}
+
+static int vhost_kthread_stop_fn(struct vhost_worker *worker)
+{
+	return kthread_stop(worker->kthread_task);
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
@@ -736,27 +760,59 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
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
+		/*
+		 * If inherit_owner is true we use vhost_tasks to create
+		 * the worker so all settings/limits like cgroups, NPROC,
+		 * scheduler, etc are inherited from the owner. If false,
+		 * we use kthreads and only attach to the same cgroups
+		 * as the owner for compat with older kernels.
+		 */
+		vtsk = vhost_task_create(vhost_run_work_list,
+					 vhost_worker_killed, worker, name);
+		if (!vtsk)
+			goto free_worker;
+
+		worker->vtsk = vtsk;
+		worker->task_wakeup = vhost_task_wakeup_fn;
+		worker->task_stop = vhost_task_stop_fn;
+
+		vhost_task_start(vtsk);
+		ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b,
+			       GFP_KERNEL);
+		if (ret < 0)
+			goto stop_worker;
+	} else {
+		/* Create and start a kernel thread */
+		task = kthread_create(vhost_run_work_kthread_list, worker,
+				      "vhost-%d", current->pid);
+		if (IS_ERR(task)) {
+			ret = PTR_ERR(task);
+			goto free_worker;
+		}
+		worker->kthread_task = task;
+		worker->task_wakeup = vhost_kthread_wakeup_fn;
+		worker->task_stop = vhost_kthread_stop_fn;
 
-	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
-	if (ret < 0)
-		goto stop_worker;
-	worker->id = id;
+		wake_up_process(task);
+		ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b,
+			       GFP_KERNEL);
+		if (ret < 0)
+			goto stop_worker;
 
-	return worker;
+		ret = vhost_attach_task_to_cgroups(worker);
+		if (ret)
+			goto stop_worker;
+	}
 
+	worker->id = id;
+	return worker;
 stop_worker:
-	vhost_task_stop(vtsk);
+	worker->task_stop(worker);
 free_worker:
 	kfree(worker);
 	return NULL;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index c650c4506c70..a7dc6e168753 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -27,6 +27,7 @@ struct vhost_work {
 };
 
 struct vhost_worker {
+	struct task_struct *kthread_task;
 	struct vhost_task	*vtsk;
 	struct vhost_dev	*dev;
 	/* Used to serialize device wide flushing with worker swapping. */
@@ -36,6 +37,8 @@ struct vhost_worker {
 	u32			id;
 	int			attachment_cnt;
 	bool			killed;
+	int (*task_wakeup)(struct vhost_worker *worker);
+	int (*task_stop)(struct vhost_worker *worker);
 };
 
 /* Poll a file (eventfd or socket) */
-- 
2.45.0


