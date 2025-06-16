Return-Path: <netdev+bounces-197951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9AFADA83F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 08:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8E81891D97
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 06:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2634B1E47AD;
	Mon, 16 Jun 2025 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPABX7MT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF9A1E377F
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750055386; cv=none; b=mEjNKG6RWZe8UTPb62eXqS1YNBZQjZkkFRp7cxZkt4HtoNyigGoAGm4FytXnb1EgwrRZ5st/NskZKP/zUgz3CZNCfc46DpOfnaYDKY3/EfGMqN6n7c4ybkLBOnVcFHZP1hSBQkZCsxe/wlxcu9c02LbGWLECiekRFOV5DbjDgEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750055386; c=relaxed/simple;
	bh=MRiH+2QXABNppur1WKgwtvhShzyJKwl/ffPfSML+840=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vvchmyd9iswVAECQG67okx6J8qUYk2d/c8gl+57z8muasPdReLruhYks0MbdzAhKmevowALKS7fUHWxtfRATrdXXd9z+Vxk+750yXRiNhX8tdRXPMZmoYXg7d/s1XFXfLrVUNd61EXdCuDuEkFZYfUuB98FVUi5PmesDdTCojVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPABX7MT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750055382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5j8SRyWZ7Oklp16sDmt+SppBJMkGPvvN/Xj4RgTDpPQ=;
	b=QPABX7MTiIiHGazEYcsKhx8c4a+SckCCmx2EIK/MTujH7C1oHBzuJM4aS0FSOCvzg6OwNR
	5K7F27Bo5bLXXMkKhI5YJKFuIp7aL0AjUmh5Bw73cL6KY3x2pZWl4knjsJ4FeSuQKF/M2p
	fiE/dZcAX0K6XUKJk9+TvBTUmWsuN04=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-LuJ-coVMOpC4kSZz6saW9Q-1; Mon,
 16 Jun 2025 02:29:39 -0400
X-MC-Unique: LuJ-coVMOpC4kSZz6saW9Q-1
X-Mimecast-MFC-AGG-ID: LuJ-coVMOpC4kSZz6saW9Q_1750055378
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 562FC1808993;
	Mon, 16 Jun 2025 06:29:38 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.46])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 723B719560AB;
	Mon, 16 Jun 2025 06:29:34 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v12 1/1] vhost: Reintroduces support of kthread API and adds mode selection
Date: Mon, 16 Jun 2025 14:28:19 +0800
Message-ID: <20250616062922.682558-2-lulu@redhat.com>
In-Reply-To: <20250616062922.682558-1-lulu@redhat.com>
References: <20250616062922.682558-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patch reintroduces kthread mode for vhost workers and provides
configuration to select between kthread and task worker.

- Add 'fork_owner' parameter to vhost_dev to let users select kthread
  or task mode. Default mode is task mode(VHOST_FORK_OWNER_TASK).

- Reintroduce kthread mode support:
  * Bring back the original vhost_worker() implementation,
    and renamed to vhost_run_work_kthread_list().
  * Add cgroup support for the kthread
  * Introduce struct vhost_worker_ops:
    - Encapsulates create / stop / wake‑up callbacks.
    - vhost_worker_create() selects the proper ops according to
      inherit_owner.

- Userspace configuration interface:
  * New IOCTLs:
      - VHOST_SET_FORK_FROM_OWNER lets userspace select task mode
        (VHOST_FORK_OWNER_TASK) or kthread mode (VHOST_FORK_OWNER_KTHREAD)
      - VHOST_GET_FORK_FROM_OWNER reads the current worker mode
  * Expose module parameter 'fork_from_owner_default' to allow system
    administrators to configure the default mode for vhost workers
  * Kconfig option CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL controls whether
    these IOCTLs and the parameter are available (for distros that may
    want to disable them)

- The VHOST_NEW_WORKER functionality requires fork_owner to be set
  to true, with validation added to ensure proper configuration

This partially reverts or improves upon:
  commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
  commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/Kconfig      |  17 +++
 drivers/vhost/vhost.c      | 244 ++++++++++++++++++++++++++++++++++---
 drivers/vhost/vhost.h      |  22 ++++
 include/uapi/linux/vhost.h |  29 +++++
 4 files changed, 294 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index 020d4fbb947c..1b3602b1f8e2 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -95,4 +95,21 @@ config VHOST_CROSS_ENDIAN_LEGACY
 
 	  If unsure, say "N".
 
+config VHOST_ENABLE_FORK_OWNER_CONTROL
+	bool "Enable VHOST_ENABLE_FORK_OWNER_CONTROL"
+	default n
+	help
+	  This option enables two IOCTLs: VHOST_SET_FORK_FROM_OWNER and
+	  VHOST_GET_FORK_FROM_OWNER. These allow userspace applications
+	  to modify the vhost worker mode for vhost devices.
+
+	  Also expose module parameter 'fork_from_owner_default' to allow users
+	  to configure the default mode for vhost workers.
+
+	  By default, `VHOST_ENABLE_FORK_OWNER_CONTROL` is set to `n`,
+	  which disables the IOCTLs and parameter.
+	  When enabled (y), users can change the worker thread mode as needed.
+
+	  If unsure, say "N".
+
 endif
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 3a5ebb973dba..84c9bdf9aedd 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/kthread.h>
+#include <linux/cgroup.h>
 #include <linux/module.h>
 #include <linux/sort.h>
 #include <linux/sched/mm.h>
@@ -41,6 +42,13 @@ static int max_iotlb_entries = 2048;
 module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 	"Maximum number of iotlb entries. (default: 2048)");
+static bool fork_from_owner_default = VHOST_FORK_OWNER_TASK;
+
+#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL
+module_param(fork_from_owner_default, bool, 0444);
+MODULE_PARM_DESC(fork_from_owner_default,
+		 "Set task mode as the default(default: Y)");
+#endif
 
 enum {
 	VHOST_MEMORY_F_LOG = 0x1,
@@ -242,7 +250,7 @@ static void vhost_worker_queue(struct vhost_worker *worker,
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &worker->work_list);
-		vhost_task_wake(worker->vtsk);
+		worker->ops->wakeup(worker);
 	}
 }
 
@@ -388,6 +396,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	__vhost_vq_meta_reset(vq);
 }
 
+static int vhost_run_work_kthread_list(void *data)
+{
+	struct vhost_worker *worker = data;
+	struct vhost_work *work, *work_next;
+	struct vhost_dev *dev = worker->dev;
+	struct llist_node *node;
+
+	kthread_use_mm(dev->mm);
+
+	for (;;) {
+		/* mb paired w/ kthread_stop */
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (kthread_should_stop()) {
+			__set_current_state(TASK_RUNNING);
+			break;
+		}
+		node = llist_del_all(&worker->work_list);
+		if (!node)
+			schedule();
+
+		node = llist_reverse_order(node);
+		/* make sure flag is seen after deletion */
+		smp_wmb();
+		llist_for_each_entry_safe(work, work_next, node, node) {
+			clear_bit(VHOST_WORK_QUEUED, &work->flags);
+			__set_current_state(TASK_RUNNING);
+			kcov_remote_start_common(worker->kcov_handle);
+			work->fn(work);
+			kcov_remote_stop();
+			cond_resched();
+		}
+	}
+	kthread_unuse_mm(dev->mm);
+
+	return 0;
+}
+
 static bool vhost_run_work_list(void *data)
 {
 	struct vhost_worker *worker = data;
@@ -552,6 +598,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
+	dev->fork_owner = fork_from_owner_default;
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
@@ -581,6 +628,46 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
 
+struct vhost_attach_cgroups_struct {
+	struct vhost_work work;
+	struct task_struct *owner;
+	int ret;
+};
+
+static void vhost_attach_cgroups_work(struct vhost_work *work)
+{
+	struct vhost_attach_cgroups_struct *s;
+
+	s = container_of(work, struct vhost_attach_cgroups_struct, work);
+	s->ret = cgroup_attach_task_all(s->owner, current);
+}
+
+static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
+{
+	struct vhost_attach_cgroups_struct attach;
+	int saved_cnt;
+
+	attach.owner = current;
+
+	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
+	vhost_worker_queue(worker, &attach.work);
+
+	mutex_lock(&worker->mutex);
+
+	/*
+	 * Bypass attachment_cnt check in __vhost_worker_flush:
+	 * Temporarily change it to INT_MAX to bypass the check
+	 */
+	saved_cnt = worker->attachment_cnt;
+	worker->attachment_cnt = INT_MAX;
+	__vhost_worker_flush(worker);
+	worker->attachment_cnt = saved_cnt;
+
+	mutex_unlock(&worker->mutex);
+
+	return attach.ret;
+}
+
 /* Caller should have device mutex */
 bool vhost_dev_has_owner(struct vhost_dev *dev)
 {
@@ -626,7 +713,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
 
 	WARN_ON(!llist_empty(&worker->work_list));
 	xa_erase(&dev->worker_xa, worker->id);
-	vhost_task_stop(worker->vtsk);
+	worker->ops->stop(worker);
 	kfree(worker);
 }
 
@@ -649,42 +736,115 @@ static void vhost_workers_free(struct vhost_dev *dev)
 	xa_destroy(&dev->worker_xa);
 }
 
+static void vhost_task_wakeup(struct vhost_worker *worker)
+{
+	return vhost_task_wake(worker->vtsk);
+}
+
+static void vhost_kthread_wakeup(struct vhost_worker *worker)
+{
+	wake_up_process(worker->kthread_task);
+}
+
+static void vhost_task_do_stop(struct vhost_worker *worker)
+{
+	return vhost_task_stop(worker->vtsk);
+}
+
+static void vhost_kthread_do_stop(struct vhost_worker *worker)
+{
+	kthread_stop(worker->kthread_task);
+}
+
+static int vhost_task_worker_create(struct vhost_worker *worker,
+				    struct vhost_dev *dev, const char *name)
+{
+	struct vhost_task *vtsk;
+	u32 id;
+	int ret;
+
+	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
+				 worker, name);
+	if (IS_ERR(vtsk))
+		return PTR_ERR(vtsk);
+
+	worker->vtsk = vtsk;
+	vhost_task_start(vtsk);
+	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
+	if (ret < 0) {
+		vhost_task_do_stop(worker);
+		return ret;
+	}
+	worker->id = id;
+	return 0;
+}
+
+static int vhost_kthread_worker_create(struct vhost_worker *worker,
+				       struct vhost_dev *dev, const char *name)
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
+	vhost_kthread_do_stop(worker);
+	return ret;
+}
+
+static const struct vhost_worker_ops kthread_ops = {
+	.create = vhost_kthread_worker_create,
+	.stop = vhost_kthread_do_stop,
+	.wakeup = vhost_kthread_wakeup,
+};
+
+static const struct vhost_worker_ops vhost_task_ops = {
+	.create = vhost_task_worker_create,
+	.stop = vhost_task_do_stop,
+	.wakeup = vhost_task_wakeup,
+};
+
 static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
-	struct vhost_task *vtsk;
 	char name[TASK_COMM_LEN];
 	int ret;
-	u32 id;
+	const struct vhost_worker_ops *ops = dev->fork_owner ? &vhost_task_ops :
+							       &kthread_ops;
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
 	if (!worker)
 		return NULL;
 
 	worker->dev = dev;
+	worker->ops = ops;
 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
 
-	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
-				 worker, name);
-	if (IS_ERR(vtsk))
-		goto free_worker;
-
 	mutex_init(&worker->mutex);
 	init_llist_head(&worker->work_list);
 	worker->kcov_handle = kcov_common_handle();
-	worker->vtsk = vtsk;
-
-	vhost_task_start(vtsk);
-
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
@@ -865,6 +1025,14 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 	switch (ioctl) {
 	/* dev worker ioctls */
 	case VHOST_NEW_WORKER:
+		/*
+		 * vhost_tasks will account for worker threads under the parent's
+		 * NPROC value but kthreads do not. To avoid userspace overflowing
+		 * the system with worker threads fork_owner must be true.
+		 */
+		if (!dev->fork_owner)
+			return -EFAULT;
+
 		ret = vhost_new_worker(dev, &state);
 		if (!ret && copy_to_user(argp, &state, sizeof(state)))
 			ret = -EFAULT;
@@ -982,6 +1150,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
 
 	vhost_dev_cleanup(dev);
 
+	dev->fork_owner = fork_from_owner_default;
 	dev->umem = umem;
 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
 	 * VQs aren't running.
@@ -2135,6 +2304,45 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 		goto done;
 	}
 
+#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL
+	if (ioctl == VHOST_SET_FORK_FROM_OWNER) {
+		/* Only allow modification before owner is set */
+		if (vhost_dev_has_owner(d)) {
+			r = -EBUSY;
+			goto done;
+		}
+		u8 fork_owner_val;
+
+		if (get_user(fork_owner_val, (u8 __user *)argp)) {
+			r = -EFAULT;
+			goto done;
+		}
+		if (fork_owner_val != VHOST_FORK_OWNER_TASK &&
+		    fork_owner_val != VHOST_FORK_OWNER_KTHREAD) {
+			r = -EINVAL;
+			goto done;
+		}
+		d->fork_owner = !!fork_owner_val;
+		r = 0;
+		goto done;
+	}
+	if (ioctl == VHOST_GET_FORK_FROM_OWNER) {
+		u8 fork_owner_val = d->fork_owner;
+
+		if (fork_owner_val != VHOST_FORK_OWNER_TASK &&
+		    fork_owner_val != VHOST_FORK_OWNER_KTHREAD) {
+			r = -EINVAL;
+			goto done;
+		}
+		if (put_user(fork_owner_val, (u8 __user *)argp)) {
+			r = -EFAULT;
+			goto done;
+		}
+		r = 0;
+		goto done;
+	}
+#endif
+
 	/* You must be the owner to do anything else */
 	r = vhost_dev_check_owner(d);
 	if (r)
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index bb75a292d50c..ab704d84fb34 100644
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
@@ -176,6 +188,16 @@ struct vhost_dev {
 	int byte_weight;
 	struct xarray worker_xa;
 	bool use_worker;
+	/*
+	 * If fork_owner is true we use vhost_tasks to create
+	 * the worker so all settings/limits like cgroups, NPROC,
+	 * scheduler, etc are inherited from the owner. If false,
+	 * we use kthreads and only attach to the same cgroups
+	 * as the owner for compat with older kernels.
+	 * here we use true as default value.
+	 * The default value is set by fork_from_owner_default
+	 */
+	bool fork_owner;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
 };
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index d4b3e2ae1314..e72f2655459e 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -235,4 +235,33 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+/* fork_owner values for vhost */
+#define VHOST_FORK_OWNER_KTHREAD 0
+#define VHOST_FORK_OWNER_TASK 1
+
+/**
+ * VHOST_SET_FORK_FROM_OWNER - Set the fork_owner flag for the vhost device,
+ * This ioctl must called before VHOST_SET_OWNER.
+ * Only available when CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=y
+ *
+ * @param fork_owner: An 8-bit value that determines the vhost thread mode
+ *
+ * When fork_owner is set to VHOST_FORK_OWNER_TASK(default value):
+ *   - Vhost will create vhost worker as tasks forked from the owner,
+ *     inheriting all of the owner's attributes.
+ *
+ * When fork_owner is set to VHOST_FORK_OWNER_KTHREAD:
+ *   - Vhost will create vhost workers as kernel threads.
+ */
+#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
+
+/**
+ * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhost device.
+ * Only available when CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=y
+ *
+ * @return: An 8-bit value indicating the current thread mode.
+ */
+#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x84, __u8)
+
 #endif
-- 
2.45.0


