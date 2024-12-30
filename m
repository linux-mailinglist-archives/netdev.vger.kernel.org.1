Return-Path: <netdev+bounces-154535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D4E9FE606
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 13:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9BE37A083E
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 12:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06C91B0416;
	Mon, 30 Dec 2024 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQdFv+vR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13D41B0F2C
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735562718; cv=none; b=Yrrd5yF3+O5BVO6s+5rk42GASC4/R1xKLDsxQUQcqVY2HnzZvJzQDZ1RJiR02ACMX1iXfWhQWx7M65sXfsVPGowJc8RqKBeisEnRcv3nIYlBhFlzIHTqpKubF1nM3dgSdSPOrejnIunaVeDjOXiQgP6UpxUHugML/8eGRvW9rkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735562718; c=relaxed/simple;
	bh=C4GD7RVh/vxLlAuOqHzKJNvXqDyu3G+07lQPqd2fEic=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/4cF7VIq2FgacP6qhQBPNRXyWAmw24dyo3vC1G9N4yWimE7RA+PAYABZJdc1GiStV89Txi7mZjirkdwxC5Fzl9u/fPJQP0n5Zlag/YSw3ERGISHDb/D02WdY65Dn6MPOMbHOiZFDg10BQsLVW8634jYpalrOWkE8nBYGN10S6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQdFv+vR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735562716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNhKJ0c4+OPvS+8sgCm6iOkshVGfikTW1g2insQ4mn8=;
	b=GQdFv+vRNr9uTqNNtjKlVASm397krza+ZPuBakApWrkNEaHGp8jMRY2ShwnXmvT11ouaHK
	Xa8CTnsCradRK5Ag+HR66LdfizOLChXQceUkEZ5OETtsFWJ8GF9b5iTobwZg5+qjjT3qF5
	PzEkm8771ZkvVIO/oTgDzi1bqaXjaAU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-5v5RAxXjPjCvWzjKhCltKg-1; Mon,
 30 Dec 2024 07:45:14 -0500
X-MC-Unique: 5v5RAxXjPjCvWzjKhCltKg-1
X-Mimecast-MFC-AGG-ID: 5v5RAxXjPjCvWzjKhCltKg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 024031956089;
	Mon, 30 Dec 2024 12:45:13 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E50CE1956053;
	Mon, 30 Dec 2024 12:45:08 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 3/6] vhost: Add the cgroup related function
Date: Mon, 30 Dec 2024 20:43:50 +0800
Message-ID: <20241230124445.1850997-4-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-1-lulu@redhat.com>
References: <20241230124445.1850997-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Reintroduce the previously removed functions vhost_attach_cgroups_work()
and vhost_attach_cgroups() to support kthread mode. Rename
vhost_attach_cgroups() to vhost_attach_task_to_cgroups(), and include
the implementation of the old function vhost_dev_flush() in this
new function.

These function was removed in
commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 1feba29abf95..812dfd218bc2 100644
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
@@ -620,6 +621,38 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
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
+	struct vhost_flush_struct flush;
+	struct vhost_attach_cgroups_struct attach;
+
+	attach.owner = current;
+
+	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
+	vhost_worker_queue(worker, &attach.work);
+
+	init_completion(&flush.wait_event);
+	vhost_work_init(&flush.work, vhost_flush_work);
+	vhost_worker_queue(worker, &flush.work);
+	wait_for_completion(&flush.wait_event);
+
+	return attach.ret;
+}
+
 /* Caller should have device mutex */
 bool vhost_dev_has_owner(struct vhost_dev *dev)
 {
-- 
2.45.0


