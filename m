Return-Path: <netdev+bounces-178082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC82A74720
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 11:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4208809EA
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 10:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEC221B18B;
	Fri, 28 Mar 2025 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWZ9of6k"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53FC21ADB9
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156267; cv=none; b=ZBm5iuwBR8/Y8boO8P3Oo8hgCIXEZCwSK+WZ/L8It/2ItTChvbdu5oeJ+QQi/s3e0j5ipnBy3TM1l48CUeWQ+YMXDrTDHmpsZzYguW1uX25ZIqoqoUL1lRenyjVI1P7EHQzjrTpwh5CI0Xp1rqM8Oymjfym9R2W9y8WChyHQscA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156267; c=relaxed/simple;
	bh=YUc7c9MXgNwcjHIY/6Aj5gIGWVEuIKPw42UQXK+Og6M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpii5+qryO+Gt01nhy4O6lZv8l5cWByhO7rqIgTxmaR1scTBU77Z8TJT/pYXh+f217mXS2tsVnJjYVDXYKvA4guk+fln8sghrDYzaKIEZawVk1AVJ1ovvuiOqV3CIltaJ7WKCZEPdf3gaVNHOQru+n2G5BIqvkzgUKV6EbuCuPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWZ9of6k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743156264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Sc1dvTB3dN9eSkDmtrVWCVhuubTwR7VYeyfTnHnq6Y=;
	b=XWZ9of6k8z4K7r12i8iW2mXh7z+uX+nRH3JQUgG2ywrR3BU7rigIMz8MPWaOD2ZQndzOuT
	npi0rkvDnrKA/zW3ujcXRKGASnsZbUOPZ21LghlM1T8IKgzu6qpvVyRTAjIu5GPwbKjGrQ
	RnaQVN8Usavb/algKe41pgsbls1FylQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-m6STFpomMGS1OwcxcNGOzA-1; Fri,
 28 Mar 2025 06:04:21 -0400
X-MC-Unique: m6STFpomMGS1OwcxcNGOzA-1
X-Mimecast-MFC-AGG-ID: m6STFpomMGS1OwcxcNGOzA_1743156260
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E6E8196B36E;
	Fri, 28 Mar 2025 10:04:20 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB7C330001A1;
	Fri, 28 Mar 2025 10:04:15 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v8 2/8] vhost: Reintroduce vhost_worker to support kthread
Date: Fri, 28 Mar 2025 18:02:46 +0800
Message-ID: <20250328100359.1306072-3-lulu@redhat.com>
In-Reply-To: <20250328100359.1306072-1-lulu@redhat.com>
References: <20250328100359.1306072-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add the previously removed function vhost_worker() back
to support the kthread and rename it to vhost_run_work_kthread_list.

The old function vhost_worker was change to support task in
commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
change to xarray in
commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 250dc43f1786..9500e85b42ce 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -388,6 +388,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
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
-- 
2.45.0


