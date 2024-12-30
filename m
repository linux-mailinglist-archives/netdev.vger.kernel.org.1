Return-Path: <netdev+bounces-154536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A449FE609
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 13:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196D47A126E
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 12:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FEB1A7AF7;
	Mon, 30 Dec 2024 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdQD0aNN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6091AA781
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735562744; cv=none; b=SHArPmFNeRJk0tYh2jpfP6lMHLf5M8vqBAovxx8Y7rzmlFI1QaZigvpIdI6P2IYJZe48u02tKzy91q8I+Ut8r38/o9cDL9vIyHqg1mtM8bCYP8hzj6ga170JqaSfMZbyrFn5HfXbAEtBJygmRaAnMMI0CMI9z+Q+q00F32FBz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735562744; c=relaxed/simple;
	bh=merdHWDONAbu6sbJILjbIpHE9fjKrx85ebbEc61iUxQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfzQawlekU1UK3yX/Yyv9rtoa3tx0ORxQR2xK2XR1366lQVF+MyFBnsnJQao0zgQC8TPITWAFJGWpGnbPTfm4cY1d70Ykk9s2eZumpl1HChxfR7hJarITygDq9I+a/Jl86BkbRad8F4MaftB51LBPie95fYIFxryXF7w5Ji55ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdQD0aNN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735562742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWfiK+MXrYcFg+E5mVFexunT6ykM6I0gV5eHLwqgzag=;
	b=JdQD0aNN0NLijdMnyj0789T39BAxsduaShPO2klWDYP8NCkycs7h42X41RabFjilUisCPi
	AyWAKiWEpC52PuiaEdhxZ8PPVGZOCZ07+p6lpzKpvUlho5kDHocMmLE7E9BFUVqG4Thls3
	raew3aWR8eYl9UBe4RGaNxlPMpAkc68=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-aelkPqn7MMOTV9yEka2DzQ-1; Mon,
 30 Dec 2024 07:45:40 -0500
X-MC-Unique: aelkPqn7MMOTV9yEka2DzQ-1
X-Mimecast-MFC-AGG-ID: aelkPqn7MMOTV9yEka2DzQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B243019560AB;
	Mon, 30 Dec 2024 12:45:39 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F67619560A2;
	Mon, 30 Dec 2024 12:45:35 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 4/6] vhost: Add worker related functions to support kthread
Date: Mon, 30 Dec 2024 20:43:51 +0800
Message-ID: <20241230124445.1850997-5-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-1-lulu@redhat.com>
References: <20241230124445.1850997-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Restore the previously removed functions kthread_wakeup and
kthread_stop, and add two new function pointers to wake up and stop
the workers. The function vhost_worker_create will initialize these
pointers based on the value of inherit_owner.

The functions vhost_worker_queue() and vhost_worker_destroy() will
use the function pointer in vhost_worker, which is initialized
according to the inherit_owner value.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 84 ++++++++++++++++++++++++++++++++++---------
 drivers/vhost/vhost.h |  3 ++
 2 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 812dfd218bc2..ff17c42e2d1a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -243,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *worker,
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &worker->work_list);
-		vhost_task_wake(worker->vtsk);
+		worker->worker_wakeup(worker);
 	}
 }
 
@@ -698,7 +698,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
 
 	WARN_ON(!llist_empty(&worker->work_list));
 	xa_erase(&dev->worker_xa, worker->id);
-	vhost_task_stop(worker->vtsk);
+	worker->worker_stop(worker);
 	kfree(worker);
 }
 
@@ -721,14 +721,36 @@ static void vhost_workers_free(struct vhost_dev *dev)
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
@@ -736,27 +758,57 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
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
+    /*
+     * If inherit_owner is true we use vhost_tasks to create
+     * the worker so all settings/limits like cgroups, NPROC,
+     * scheduler, etc are inherited from the owner.
+     * If false,we use kthreads and only attach to the same
+     * cgroups as the owner for compat with older kernels.
+     */
+	if (dev->inherit_owner) {
+		vtsk = vhost_task_create(vhost_run_work_list,
+					 vhost_worker_killed, worker, name);
+		if (!vtsk)
+			goto free_worker;
+
+		worker->vtsk = vtsk;
+		worker->worker_wakeup = vhost_task_wakeup_fn;
+		worker->worker_stop = vhost_task_stop_fn;
+
+		vhost_task_start(vtsk);
+		ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b,
+			       GFP_KERNEL);
+		if (ret < 0)
+			goto stop_worker;
+	} else {
+		task = kthread_create(vhost_run_work_kthread_list, worker,
+				      "vhost-%d", current->pid);
+		if (IS_ERR(task)) {
+			ret = PTR_ERR(task);
+			goto free_worker;
+		}
+		worker->kthread_task = task;
+		worker->worker_wakeup = vhost_kthread_wakeup_fn;
+		worker->worker_stop = vhost_kthread_stop_fn;
 
-	vhost_task_start(vtsk);
+		wake_up_process(task);
+		ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b,
+			       GFP_KERNEL);
+		if (ret < 0)
+			goto stop_worker;
 
-	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
-	if (ret < 0)
-		goto stop_worker;
-	worker->id = id;
+		ret = vhost_attach_task_to_cgroups(worker);
+		if (ret)
+			goto stop_worker;
+	}
 
+	worker->id = id;
 	return worker;
-
 stop_worker:
-	vhost_task_stop(vtsk);
+	worker->worker_stop(worker);
 free_worker:
 	kfree(worker);
 	return NULL;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index c650c4506c70..63b1da08a2b0 100644
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
+	void (*worker_wakeup)(struct vhost_worker *worker);
+	void (*worker_stop)(struct vhost_worker *worker);
 };
 
 /* Poll a file (eventfd or socket) */
-- 
2.45.0


