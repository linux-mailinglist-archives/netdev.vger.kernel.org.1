Return-Path: <netdev+bounces-195645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886A6AD1908
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 09:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C64E3A762F
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 07:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA854281378;
	Mon,  9 Jun 2025 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjxwUnvP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017CF281353
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749454487; cv=none; b=r1WRjpmFO6V0MYoAD4c1414ne2e2tjahwGRPEkjHKcYyYmrNX1gEuQNU+rVuAQrGDlY4XO/kianzEMXqiQxLTTx+Cc8FC0O9ugaHRFeN+WX9AUKVtBNmimB22f9lOprIwaTCN8FGghF18BYVzBjK1NEa6d66CGzE89ncswn8Fnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749454487; c=relaxed/simple;
	bh=emKpWqLl5JLygWqoSXQwHO3pFHeD+p6GG66wVQ1KWBc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGtUdoazOnFUmrAN60MWyGxyKzTbpE5ye52pnCMEs0rMDGdJ6S0e5vOxFEJmaAFheIb8bFbjaZiDIMXlwqg8ePkQb/RsynJglJqPkPQwHnHA6nJTHnXUTQl5TTYs5CLmkBjSisXG++/S50WwM+6Qk0l5I8ROOXHunDHub9mbj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjxwUnvP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749454484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIjJofS0tTiTa0RdUTlpYlx1pCTQd5RICVY9zy46fmg=;
	b=TjxwUnvPH6pqLqstvQi3KdaWSd3ylu9um62fhc2CmwY8yLrzntkUE6wT4QPONT6EZqc58E
	LrQi4GYPOxwm3eeKJLgb5Ukz0KUQhuvlaZrciUodTINm7F6stw/aIqwp97NvV8TQ25kUl1
	fNrwTWV91sXMD7dvYwIoYMrvElWYZyA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-NfOQ9ESpMAu7m7SCQzmRyw-1; Mon,
 09 Jun 2025 03:34:42 -0400
X-MC-Unique: NfOQ9ESpMAu7m7SCQzmRyw-1
X-Mimecast-MFC-AGG-ID: NfOQ9ESpMAu7m7SCQzmRyw_1749454482
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF7F6195608C;
	Mon,  9 Jun 2025 07:34:41 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC63819560AB;
	Mon,  9 Jun 2025 07:34:37 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v11 1/3] vhost: Add a new parameter in vhost_dev to allow user select kthread
Date: Mon,  9 Jun 2025 15:33:07 +0800
Message-ID: <20250609073430.442159-2-lulu@redhat.com>
In-Reply-To: <20250609073430.442159-1-lulu@redhat.com>
References: <20250609073430.442159-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The vhost now uses vhost_task and workers as a child of the owner thread.
While this aligns with containerization principles, it confuses some
legacy userspace applications, therefore, we are reintroducing kthread
API support.

Introduce a new parameter to enable users to choose between kthread and
task mode.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c |  2 ++
 drivers/vhost/vhost.h | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 3a5ebb973dba..ff3052858308 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -41,6 +41,7 @@ static int max_iotlb_entries = 2048;
 module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 	"Maximum number of iotlb entries. (default: 2048)");
+static bool fork_from_owner_default = true;
 
 enum {
 	VHOST_MEMORY_F_LOG = 0x1,
@@ -552,6 +553,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
+	dev->fork_owner = fork_from_owner_default;
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index bb75a292d50c..e3d4732883af 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -176,6 +176,16 @@ struct vhost_dev {
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
-- 
2.45.0


