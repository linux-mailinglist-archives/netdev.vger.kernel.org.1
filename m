Return-Path: <netdev+bounces-194489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 405C5AC9A5D
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 11:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546351BA08B3
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB35239E8D;
	Sat, 31 May 2025 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+RV2kt/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5E4239E76
	for <netdev@vger.kernel.org>; Sat, 31 May 2025 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748685501; cv=none; b=W/yz5pLNBDBS3FOQV887eZI6ZKl94PLgcwMr5O2x2YUetuZOLPCRLb6HutJ/yH3rMrRQDHXIW48Qv7hswNPK5h2cOswjjWabf1069+lDrleF2PA6Yf90CDppt1HVXy9IHfs+pAD/cld+BmUYKzmQkA3/OCizmJ64i9tEaXZ5fq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748685501; c=relaxed/simple;
	bh=mw/Qer8CeHGw4edMlvresJ7xkZve9Gz7YMI12DPZe2E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQJTyAYbJlh13iTXTEQRNNWfbbkj5smghQPK8TgXwANJ3B2YIR8ewmrYRp9xiJN8bWKhvzPAbnCC+YoIrj8GFHAq/6xOu5vcwqHy/fhEkLJOwmqEoNXliJ8pfuX6bGrn1syvl4ggzb7fzO9nX5Xd03XBmd35v3TRWU0Rkpvq2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+RV2kt/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748685498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrPgdD64vKDtkpdzZC+la9VolCi4JsMi5slKhfemFX0=;
	b=i+RV2kt/QSNcEvB1xQ+yrhM1M9epBC34gmV/eIq/R6mzyEsmjvZbdq+0PY9d/HL3A6AKw/
	nVVIC5TsTLESB8yrL1VY+tvLM/a9qyuffLkK7tl+IyUa67pmgnpmHcFvaPNNXgJdFBt60d
	dqLnkhDuvP3zx9QO33ARZc5gfYd5nvo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-5PmC2kcHMq6FaqEdTUVv3g-1; Sat,
 31 May 2025 05:58:16 -0400
X-MC-Unique: 5PmC2kcHMq6FaqEdTUVv3g-1
X-Mimecast-MFC-AGG-ID: 5PmC2kcHMq6FaqEdTUVv3g_1748685495
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 243C01956086;
	Sat, 31 May 2025 09:58:15 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03631180049D;
	Sat, 31 May 2025 09:58:10 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH RESEND v10 1/3] vhost: Add a new modparam to allow userspace select kthread
Date: Sat, 31 May 2025 17:57:26 +0800
Message-ID: <20250531095800.160043-2-lulu@redhat.com>
In-Reply-To: <20250531095800.160043-1-lulu@redhat.com>
References: <20250531095800.160043-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The vhost now uses vhost_task and workers as a child of the owner thread.
While this aligns with containerization principles, it confuses some
legacy userspace applications, therefore, we are reintroducing kthread
API support.

Add a new module parameter to allow userspace to select behavior
between using kthread and task.

By default, this parameter is set to true (task mode). This means the
default behavior remains unchanged by this patch.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c |  5 +++++
 drivers/vhost/vhost.h | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 3a5ebb973dba..240ba78b1e3f 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -41,6 +41,10 @@ static int max_iotlb_entries = 2048;
 module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 	"Maximum number of iotlb entries. (default: 2048)");
+bool inherit_owner_default = true;
+module_param(inherit_owner_default, bool, 0444);
+MODULE_PARM_DESC(inherit_owner_default,
+		 "Set task mode as the default(default: Y)");
 
 enum {
 	VHOST_MEMORY_F_LOG = 0x1,
@@ -552,6 +556,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
+	dev->inherit_owner = inherit_owner_default;
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index bb75a292d50c..c1ff4a92b925 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -176,6 +176,16 @@ struct vhost_dev {
 	int byte_weight;
 	struct xarray worker_xa;
 	bool use_worker;
+	/*
+	 * If inherit_owner is true we use vhost_tasks to create
+	 * the worker so all settings/limits like cgroups, NPROC,
+	 * scheduler, etc are inherited from the owner. If false,
+	 * we use kthreads and only attach to the same cgroups
+	 * as the owner for compat with older kernels.
+	 * here we use true as default value.
+	 * The default value is set by modparam inherit_owner_default
+	 */
+	bool inherit_owner;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
 };
-- 
2.45.0


