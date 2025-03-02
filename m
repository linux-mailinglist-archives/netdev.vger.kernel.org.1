Return-Path: <netdev+bounces-171016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B67F4A4B23F
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 15:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BACD16D687
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9B91E7C08;
	Sun,  2 Mar 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WX6g+RoK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC091E5B79
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740926021; cv=none; b=ngpbCgDIO2XEoC5ZO/zSvSqTEUD54BseVoY7tFXp9p5R0qfueuX10Cm8ApC6lR2UFVRFZePd+oVb7tyasf8xBAsbFjPJr1PfPeHdXgVJ8OStsg0qcQnpE6AD50ttPYNQanu8f0vQJxt6h858SmqJUWSj0sRQYu4w3ZVVXUwNjNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740926021; c=relaxed/simple;
	bh=tcyBwdgr2YlItLRbbxG+qVgq+GW1dlqK36utI5TcPo0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SC/GsBeVkMSa+fNq8JSt0gFOUPfatAEQvr8vnrLMiYK7EehBb3UqAM5+P5fu6oJfEzCSKseZIAx9mBp71DjO0oV+yb8kPbbKtZ7PhUCCD7TbvN2mXdh3Q/rbucrHhYjr1ZIPqiUp8qP3M+9XPJPUOT5FKoHFFvufWaHbLaCPOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WX6g+RoK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740926018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePoKzvLFT6RYs8QjlwPr44Qcs7l2YXCu4ibp5I+WQTY=;
	b=WX6g+RoKP892+bXELH8+YitIKpfLBXV6uSSGHT0wm6qp18jhudsIlbcAx/hMNDSmfkhpVR
	rHYT/UsCxXeS/MAYgjYXzeQ1RS6mIBVjYaQV+tyD+4lZDKIWU6NgXpPWwzUmSP4t+JrYXt
	oEgeOvxgYgGTpQZKyyjkicFaPoTas0A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-9uGaB7YjMDaKKndjTzXKhg-1; Sun,
 02 Mar 2025 09:33:30 -0500
X-MC-Unique: 9uGaB7YjMDaKKndjTzXKhg-1
X-Mimecast-MFC-AGG-ID: 9uGaB7YjMDaKKndjTzXKhg_1740926009
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6A6F193585F;
	Sun,  2 Mar 2025 14:33:29 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.49])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 093F01800359;
	Sun,  2 Mar 2025 14:33:24 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v7 3/8] vhost: Add the cgroup related function
Date: Sun,  2 Mar 2025 22:32:05 +0800
Message-ID: <20250302143259.1221569-4-lulu@redhat.com>
In-Reply-To: <20250302143259.1221569-1-lulu@redhat.com>
References: <20250302143259.1221569-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add back the previously removed cgroup function to support the kthread
The biggest change for this part is in vhost_attach_cgroups() and
vhost_attach_task_to_cgroups().

The old function was remove in
commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9500e85b42ce..20571bd6f7bd 100644
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
@@ -620,6 +621,46 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
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
-- 
2.45.0


