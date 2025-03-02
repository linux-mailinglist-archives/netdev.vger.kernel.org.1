Return-Path: <netdev+bounces-171020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 796B9A4B24D
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 15:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0DE616EBB4
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 14:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7981E9B33;
	Sun,  2 Mar 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biUCawkf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9941E9B0B
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740926064; cv=none; b=Ty2lbPGSpviqGiutwllcB475/sQAqXpgyFnqDhglDxX9qEdZotOHVw3jM5Ok5STfbVs4oIVJO0fRWRZ9xSxEQLEIb/xnqLOya0pHLsSohSmW2D8jKBZ7isTEu5xf+bkga3keKuA60VqfpSmIWoz9ASLNQINfS8kiq1PK15pwz38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740926064; c=relaxed/simple;
	bh=FDMYH+VuvPX7L7xdXXrSDlUL9wJ9IlCFimDvXX9FoIU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzDBnFwJz+kDn9itv5PU+sjg388Z/165f6wtrjnfu94H5yvRI5dXBAgN+9xw7ZBCkZ88i1TXrTsJcGpqO+K+sSiuKKUJr1jKJO6jiyl9rlWjPLaavynW2qRhALwXPtraNUjAD0V6Qn25Nf10Dx64jWrMIRQ6+EULUE8k6VUN0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=biUCawkf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740926062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHLTuC4KWZdovhJ3UQM5fvJjtH+elhHPHMwqnZsGpc4=;
	b=biUCawkfGqrqMjiB8AxiFhwv4SX9R6gF9HEZ1fROrkKXtuQjNeVjjoEhryEA8+agfLQlgC
	tvKZaIRwS6c3gdPEpY4JZS1MvcxO8AK+McTszE34z3hDRf9+lHdhmp1ssp5RD1ff8Kf4YM
	/ARdpx1Ge1ym7qs8AtjzD391YwD+jKY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-wCVH1V7xMHm6zpkDPX0G7g-1; Sun,
 02 Mar 2025 09:34:03 -0500
X-MC-Unique: wCVH1V7xMHm6zpkDPX0G7g-1
X-Mimecast-MFC-AGG-ID: wCVH1V7xMHm6zpkDPX0G7g_1740926042
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3C861975AFC;
	Sun,  2 Mar 2025 14:34:02 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.49])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 507A819560AB;
	Sun,  2 Mar 2025 14:33:57 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v7 5/8] vhost: Reintroduce kthread mode support in vhost
Date: Sun,  2 Mar 2025 22:32:07 +0800
Message-ID: <20250302143259.1221569-6-lulu@redhat.com>
In-Reply-To: <20250302143259.1221569-1-lulu@redhat.com>
References: <20250302143259.1221569-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This commit restores the previously removed functions kthread
wake/stop/create, and use ops structure vhost_worker_ops to
manage worker wakeup, stop and creation. The function
vhost_worker_create initializes these ops pointers based on
the value of inherit_owner

The old function was remove in
commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  1 +
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c162ad772f8f..be97028a8baf 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -734,11 +734,21 @@ static void vhost_task_wakeup(struct vhost_worker *worker)
 	return vhost_task_wake(worker->vtsk);
 }
 
+static void vhost_kthread_wakeup(struct vhost_worker *worker)
+{
+	wake_up_process(worker->kthread_task);
+}
+
 static void vhost_task_do_stop(struct vhost_worker *worker)
 {
 	return vhost_task_stop(worker->vtsk);
 }
 
+static void vhost_kthread_do_stop(struct vhost_worker *worker)
+{
+	kthread_stop(worker->kthread_task);
+}
+
 static int vhost_task_worker_create(struct vhost_worker *worker,
 				    struct vhost_dev *dev, const char *name)
 {
@@ -762,6 +772,41 @@ static int vhost_task_worker_create(struct vhost_worker *worker,
 	return 0;
 }
 
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
 static const struct vhost_worker_ops vhost_task_ops = {
 	.create = vhost_task_worker_create,
 	.stop = vhost_task_do_stop,
@@ -773,7 +818,8 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	struct vhost_worker *worker;
 	char name[TASK_COMM_LEN];
 	int ret;
-	const struct vhost_worker_ops *ops = &vhost_task_ops;
+	const struct vhost_worker_ops *ops =
+		dev->inherit_owner ? &vhost_task_ops : &kthread_ops;
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
 	if (!worker)
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 98895e299efa..af4b2f7d3b91 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -37,6 +37,7 @@ struct vhost_worker_ops {
 };
 
 struct vhost_worker {
+	struct task_struct *kthread_task;
 	struct vhost_task	*vtsk;
 	struct vhost_dev	*dev;
 	/* Used to serialize device wide flushing with worker swapping. */
-- 
2.45.0


