Return-Path: <netdev+bounces-141819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD099BC6F0
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 08:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65371F23828
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 07:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6981D1FEFBA;
	Tue,  5 Nov 2024 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpwHMB11"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C971FEFA7
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791632; cv=none; b=KBjLEFy5/Rv1dws9nQzBGE8W7GZ2eexvb7PIIrRICS2Rcg+Sj/qShyMxRlgf330eSB1LyTMLcalUMC/NNhN/2RQmM2oa6gjG8FhqCzCyfFyLmrf+RFUdtw0zovQvMFP6gABwGv72VLvFrk7bwNcmf7HAqxt5hpHpRYD+Cwi5tio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791632; c=relaxed/simple;
	bh=l9RbpjgxGo9MDgdsXYvwzNMY7RifCS985yCLpV8udPU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3oNDiMuPmoWrgTvRrqnt8wTb3nfhVoiB/+HVsulrR051hKnFCVTrTOXQoCRm8eWdrxLfpeAgUwFFefQ69gS09NK2Pcnq1uKkMzA1t2hE9apxf6KvV7Pn60kpWO6uf/oUG2R+fChyQEX6j1MomK+4CAw83dkbzb++kxfcg3rv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpwHMB11; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730791629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YrN25r/0W16IYmHHoUR1xxPmflO4UlfZvP9MJNNbpL4=;
	b=EpwHMB11KkxRHk6uIukao9SD3ezpgr2yQQIxwlwz6W97a9PUwyHK2O7bH0tcMK7Iew9Hag
	C9VZ41hIH5xSHO+A28wUpX7QTbLFKwAT88zHDvqQufgy1VoE0yDXg/310wQiYNP3TYqGlv
	hT//Feg+GcVqHk3NA07apq5gm0IoTt4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-jAnLrO4_OO-yjG_WIvM1-g-1; Tue,
 05 Nov 2024 02:27:06 -0500
X-MC-Unique: jAnLrO4_OO-yjG_WIvM1-g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCD631956083;
	Tue,  5 Nov 2024 07:27:05 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6BA081955F42;
	Tue,  5 Nov 2024 07:27:01 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 1/9] vhost: Add a new parameter to allow user select kthread
Date: Tue,  5 Nov 2024 15:25:20 +0800
Message-ID: <20241105072642.898710-2-lulu@redhat.com>
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

The vhost now uses vhost_task and workers as a child of the owner thread.
While this aligns with containerization principles,it confuses some legacy
userspace app, Therefore, we are reintroducing kthread API support.

Introduce a new parameter to enable users to choose between
kthread and task mode. This will be exposed by module_param() later.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 2 ++
 drivers/vhost/vhost.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9ac25d08f473..eff6acbbb63b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -41,6 +41,7 @@ static int max_iotlb_entries = 2048;
 module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 	"Maximum number of iotlb entries. (default: 2048)");
+static bool inherit_owner_default = true;
 
 enum {
 	VHOST_MEMORY_F_LOG = 0x1,
@@ -552,6 +553,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
+	dev->inherit_owner = inherit_owner_default;
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


