Return-Path: <netdev+bounces-154534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB669FE5FE
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 13:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2789F3A25D6
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 12:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D230A1A9B24;
	Mon, 30 Dec 2024 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBk5lw4C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A881A8F6B
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735562711; cv=none; b=UeU9sxUy354TplgLRYtyGHVCC8sraphotAGFojM++iwTFeJLFiN0CZtKEKacof+A5EB0kCJ1ltQ1haM5QtECXlaTXQ4X9/ga9s7mUvNwEBv/Xe2F6qfyl6/4ZO+mnRldMRyp+DfT9uOu73b08WjpQ3xNoP47uBX+ILnujd/VJNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735562711; c=relaxed/simple;
	bh=jeWjZGyVq++I2IUyvncBX3PW15I/qkhjeCkZYe2n4iM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbyRAqWzDr7cpB1FbeGb1BzRlEbvjUOIvmTwQKxkWHdKCXHDsvodoKVgCLnv1FEEmrOEpr544XE+bblJJw1otdHugD9BWDr8cx73FzaiAQTkjRzapSS4rX/9qHi6Wr4Yjz1zHcYi7ABUHl7xSrMtQkbPqDwvEuyZNpcDmQKhZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBk5lw4C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735562709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMBEQFgZfioBrCNsFkZVI/KneYN1UfIwkiutolEo20E=;
	b=TBk5lw4CUc3E0mmZUEJuthRJWT5Egmd3V4ZR7sZHHz2DYZN2/H9FZBSAHvt6lFVXgdKOhB
	KjKsVQ/vtO6hBc++7ipW2DDI+msysvQ/J7u7K2V8WIv2JYPqwqTHIJ9ga6PpEJhNoIwiXy
	uouAfR26HmMvP14bKSk4x8NKfsJTGoY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-ziJisQehMaCGzvhRWamPew-1; Mon,
 30 Dec 2024 07:45:04 -0500
X-MC-Unique: ziJisQehMaCGzvhRWamPew-1
X-Mimecast-MFC-AGG-ID: ziJisQehMaCGzvhRWamPew
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83CF01956064;
	Mon, 30 Dec 2024 12:45:03 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93C4D1956053;
	Mon, 30 Dec 2024 12:44:59 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 1/6] vhost: Add a new parameter in vhost_dev to allow user select kthread
Date: Mon, 30 Dec 2024 20:43:48 +0800
Message-ID: <20241230124445.1850997-2-lulu@redhat.com>
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

The vhost now uses vhost_task and workers as a child of the owner
thread. While this aligns with containerization principles, it confuses
some legacy userspace applications. Therefore, we are reintroducing
support for the kthread API.

Introduce a new parameter to enable users to choose between kthread and
task mode.

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


