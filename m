Return-Path: <netdev+bounces-154539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4309FE617
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 13:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598591625ED
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 12:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E52F1A8405;
	Mon, 30 Dec 2024 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVMgUTO0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902211A2C0E
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 12:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735562828; cv=none; b=VbDAEwr/6NDDFnNrinHokX4CuzQmKD/gHZ2Yh4iR+ltxVNFXrQIpyvGavhlXfEW43h/jSXhPeFb/VkXzYcBE3yuN0Ptvr071ezRxvwtkW4y2yQ5xl65rEuhdPZUKuPqgdN3kMQTFxLS49+tyohMh9iCe5vzjpnvmipdTwCWkMtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735562828; c=relaxed/simple;
	bh=zJ7gQ1kSqCdMUp9Tx832EuPhAuNPPcp41jJMW9X3QaE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvIFp8NjS5wTGOHebqaUdmHFx3m9rEiQoQ3q3jjI2/6mE1qfdXuJF+n42MMGyEmJa/iMIqnlnuFya7EVraMjjcQFO2+tDQu8Y2jehota51dWa+sKscpVbXy+0FoUXOsG4J+avCT40aAdi577Fjr7xFe8X3S3NeXO1fIAYzYWotg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVMgUTO0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735562824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDGpQBYYbqEvdCGufJQtc26EbONqPNkQa5s9LCtzmcU=;
	b=EVMgUTO0VTpPwaKU9NvrcVPfDQcwfYG5CPcdejgwNOHVKheYVvpZzs3HfLR+7EdL9rBx/0
	aGmR28eBy/KTIKtA+yrX8wC/iqenH/NQW0KldxtdCIsvD1iCJtDlAWs4cTrHphd1dhhKbV
	c1kwrNZQKxJToT+z0tPIqT8rGrdxdkg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-_PZL29MePRm7ojIGFhQoiQ-1; Mon,
 30 Dec 2024 07:45:09 -0500
X-MC-Unique: _PZL29MePRm7ojIGFhQoiQ-1
X-Mimecast-MFC-AGG-ID: _PZL29MePRm7ojIGFhQoiQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CE7319560BE;
	Mon, 30 Dec 2024 12:45:08 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46C361956053;
	Mon, 30 Dec 2024 12:45:03 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 2/6] vhost: Add the vhost_worker to support kthread
Date: Mon, 30 Dec 2024 20:43:49 +0800
Message-ID: <20241230124445.1850997-3-lulu@redhat.com>
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

Add the previously removed function vhost_worker() back to support the
kthread and rename it to vhost_run_work_kthread_list.

The old function vhost_worker() was changed to support tasks in
commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
and to support multiple workers per device using xarray in
commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray").

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index eaddbd39c29b..1feba29abf95 100644
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


