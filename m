Return-Path: <netdev+bounces-168832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B82B5A40F8B
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 16:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4711897EEF
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7E520CCDC;
	Sun, 23 Feb 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFrPbp/8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A920C02B
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740325274; cv=none; b=FbvoiLoiWx8K/d+vUuLUEyX6Qq3caQmo/juU0HutGgtqX0Y7lDBdmsd/LWsMw8KH/FUYM4S61yTbnHDPDtW+Acqg9bGL81G4jbJ0b2h2zrtu4S5vLltCOh/Tvs+oXJ/tWAtKOc32MGxvNECCt6UxISs6/czdDyLeLLXMtg0gEK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740325274; c=relaxed/simple;
	bh=mSf1YOOT4rT+xoFBikEdZRvyB8BOLcKa4G4tDStOsjY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cw0NcOM0oht3FzlHZr3yDS0028JMTLXnT0MV9AzFVQBrG07GEdKrenp5H8pGit5ZW3TI/qXv4E9NTCSgSZC2qdtwMC2t9QsZSVrFzTZ7iAAFQHfz58IpbOErdlwmrJ20MQ6QnGtZLxaDMXGwri2j3LyGuSCzfmA7eoR1OmXzv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFrPbp/8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740325271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4frTMdgbHHhGI0JKe/2KXP6ad1stTd1tmXcRu+Jrt+g=;
	b=CFrPbp/8b3zf8USmVT99pDsZ8yaP9KuuuKjePyHUJrBi1GJg+C6iM/O46WRiqAjlEgcysO
	VuBsVMxzezIxQWkHilOkjD8HU8+L6n4nj/MJ40sxOc90QjdvMmrgJF6D9Ll177pLtoldLD
	Jl+2unQlEmBDdL/npTwF32Dzj0PENp0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-9mArNKYWPXWjRLorh-iofg-1; Sun,
 23 Feb 2025 10:41:07 -0500
X-MC-Unique: 9mArNKYWPXWjRLorh-iofg-1
X-Mimecast-MFC-AGG-ID: 9mArNKYWPXWjRLorh-iofg_1740325266
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7B7E18004A7;
	Sun, 23 Feb 2025 15:41:06 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.28])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4489619412A3;
	Sun, 23 Feb 2025 15:41:01 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 3/6] vhost: Add the cgroup related function
Date: Sun, 23 Feb 2025 23:36:18 +0800
Message-ID: <20250223154042.556001-4-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-1-lulu@redhat.com>
References: <20250223154042.556001-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add back the previously removed cgroup function to support the kthread
The biggest change for this part is in vhost_attach_cgroups() and
vhost_attach_task_to_cgroups().

Reuse the function __vhost_worker_flush, but in this situation, the
attachment_cnt is 0. Therefore, add a boolean to disable this check.

The old function was remove in
commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 1feba29abf95..adbb957c8b5f 100644
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
@@ -269,11 +270,12 @@ EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
  *
  * The worker's flush_mutex must be held.
  */
-static void __vhost_worker_flush(struct vhost_worker *worker)
+static void __vhost_worker_flush(struct vhost_worker *worker,
+				 bool ignore_attachment)
 {
 	struct vhost_flush_struct flush;
 
-	if (!worker->attachment_cnt || worker->killed)
+	if ((!ignore_attachment && !worker->attachment_cnt) || worker->killed)
 		return;
 
 	init_completion(&flush.wait_event);
@@ -292,7 +294,7 @@ static void __vhost_worker_flush(struct vhost_worker *worker)
 static void vhost_worker_flush(struct vhost_worker *worker)
 {
 	mutex_lock(&worker->mutex);
-	__vhost_worker_flush(worker);
+	__vhost_worker_flush(worker, false);
 	mutex_unlock(&worker->mutex);
 }
 
@@ -620,6 +622,36 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
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
+
+	attach.owner = current;
+
+	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
+	vhost_worker_queue(worker, &attach.work);
+
+	mutex_lock(&worker->mutex);
+	__vhost_worker_flush(worker, true);
+	mutex_unlock(&worker->mutex);
+
+	return attach.ret;
+}
+
 /* Caller should have device mutex */
 bool vhost_dev_has_owner(struct vhost_dev *dev)
 {
@@ -793,7 +825,7 @@ static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 	/* Make sure new vq queue/flush/poll calls see the new worker */
 	synchronize_rcu();
 	/* Make sure whatever was queued gets run */
-	__vhost_worker_flush(old_worker);
+	__vhost_worker_flush(old_worker, false);
 	old_worker->attachment_cnt--;
 	mutex_unlock(&old_worker->mutex);
 }
@@ -852,7 +884,7 @@ static int vhost_free_worker(struct vhost_dev *dev,
 	 * to zero. Make sure flushes are flushed from the queue before
 	 * freeing.
 	 */
-	__vhost_worker_flush(worker);
+	__vhost_worker_flush(worker, false);
 	mutex_unlock(&worker->mutex);
 
 	vhost_worker_destroy(dev, worker);
-- 
2.45.0


