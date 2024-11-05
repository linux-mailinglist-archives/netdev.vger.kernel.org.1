Return-Path: <netdev+bounces-141820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928B19BC6F3
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 08:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F21FB2198B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 07:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBFC1FEFDF;
	Tue,  5 Nov 2024 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbH/5zJG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A971FDF9B
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791636; cv=none; b=PaBg/Da5EUFkhMTVKP0lD8rwV2eI38Tkmn5oesddASXYi5edyN/mhS4i1w/g44qg5D0+0CLFknznj1xy0lrbTPuMIKcJXiixph9Z2BHyAvvjRhQL07Lelgf4dhVqN06WDixaHL/hKiE+y6JLGTe1JKXZo0RiiSbn4bszht8hmm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791636; c=relaxed/simple;
	bh=THdCA1jm90rs4duE7RiNf95OSIxka9SsAUBHQ2Ghxko=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2RmHfn0MO0PGa6VLMXF/YJmu7FxVB7NAe0VNeoPIs28Nug+9PDMQP4przV7NQcL355GHUrRGzMQY6YUKJ7t7PtmZrEijl6PpaPJa4xHux07b4qj8P5vdvNodJZfjuELWAtX0aCUvU66Fqcpq2oBn3gF8E180B1HC4QElLMCk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbH/5zJG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730791633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtnVyGCllOzCsvYTHj412veayAw36T4Mk750trb6Njs=;
	b=BbH/5zJGi2AoTj1WJXPSVRvnEKll5A5tyj/pA/Ki/J6bFrUkMfxtF/nlFBUxJwDuVg6UZ+
	4KedPwNT3ZmLhifkN/6rVpvaIpTT1oWMt5VDwuKImnb+1/7Tj3jWFKP855jf8hjl8DCzYp
	7lMajxLB9cbYEYJTIYaMO4To2jgnf9k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-HPKtw0OaP6mHrdqRF2XsXA-1; Tue,
 05 Nov 2024 02:27:12 -0500
X-MC-Unique: HPKtw0OaP6mHrdqRF2XsXA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D8D01955F43;
	Tue,  5 Nov 2024 07:27:11 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90EAA195607C;
	Tue,  5 Nov 2024 07:27:06 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 2/9] vhost: Add the vhost_worker to support kthread
Date: Tue,  5 Nov 2024 15:25:21 +0800
Message-ID: <20241105072642.898710-3-lulu@redhat.com>
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
index eff6acbbb63b..65fda810b96e 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -389,6 +389,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
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


