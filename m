Return-Path: <netdev+bounces-168830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D40CA40F83
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 16:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB05B16F96C
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3684420B20B;
	Sun, 23 Feb 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbNvG7fy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25020C008
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740325266; cv=none; b=crK9N2Q5l7KaP3m9FxEOtBgj8V6j8t3cZ2yKhG8ZMEqX69EhPM/Jsir/teEXzNfQrzPlEjkwRF/EyF8WelKAAJlfxTeFOWCDizHTJzacAB5iVCK3u8Zhj1VCG1EV0Q6n706NaG9MBApYafEP6MOJxntODO1y4QGy8IlT2Ky9Ol8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740325266; c=relaxed/simple;
	bh=jZWHDBC1em9YSxJA7OCoxzWdArjA3A0TYOkpGg7ZSRk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ycx4tYde8nBm+gSIgzaxV86T/CGKbR93OiEG/LU0puDi49sGeS6uY/ed4vav8SJU/rZS0417kCKI+1lXDnT20QjGbkRgy5ABsNpkCjqoYNs9IIGS72n2m7NNIj2ynU9VXpfosOTgK2UPjMUYsQwEBdPqE6mLye9S98SdT9RgcTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbNvG7fy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740325261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kx5deBxNNDBqr/ibOJLZi9NoxS8td60GQR/dfMsL+Dk=;
	b=ZbNvG7fyFWL7/2dRBOJIh2gj3lWcKDZxyc6QdyMNTFC/Zo1luQWO3HALto40CF7azBfHxL
	RpGhe156BnbpfLdWm/zAb2TW2kkhAlD7HqQdhZM/nkuN/+6PLXX07NQPExU7iCqBn5ywtE
	LayxGbNgTptolJvYRPjiI5zd35tBof0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-urbtvVcWOyqwV6w3ExLEig-1; Sun,
 23 Feb 2025 10:40:57 -0500
X-MC-Unique: urbtvVcWOyqwV6w3ExLEig-1
X-Mimecast-MFC-AGG-ID: urbtvVcWOyqwV6w3ExLEig_1740325256
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E03819560B5;
	Sun, 23 Feb 2025 15:40:56 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.28])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C04D419412A3;
	Sun, 23 Feb 2025 15:40:51 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 1/6] vhost: Add a new parameter in vhost_dev to allow user select kthread
Date: Sun, 23 Feb 2025 23:36:16 +0800
Message-ID: <20250223154042.556001-2-lulu@redhat.com>
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

The vhost now uses vhost_task and workers as a child of the owner thread.
While this aligns with containerization principles,it confuses some legacy
userspace app, Therefore, we are reintroducing kthread API support.

Introduce a new parameter to enable users to choose between
kthread and task mode.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 1 +
 drivers/vhost/vhost.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9ac25d08f473..eaddbd39c29b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -552,6 +552,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
+	dev->inherit_owner = true;
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index bb75a292d50c..c650c4506c70 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -176,6 +176,7 @@ struct vhost_dev {
 	int byte_weight;
 	struct xarray worker_xa;
 	bool use_worker;
+	bool inherit_owner;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
 };
-- 
2.45.0


