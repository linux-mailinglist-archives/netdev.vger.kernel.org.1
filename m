Return-Path: <netdev+bounces-141824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0FF9BC706
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 08:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C0B1F237F7
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 07:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B2020010A;
	Tue,  5 Nov 2024 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvEb9Lbu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85BE1FF7C8
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791682; cv=none; b=YFi71q+CoRpqhsClAUeofjolqHk7Ta0SLrSIBk2MApjZ8rK6VgiqdYUZOcLlRKvopRbSoD6naqevD8cBIw5nd2Bhr8mQaoJIhOnUgUe2w+5/bn0o4pbzkXKlfUzcWbDpYgPNrdMqsMoCW+v3l7ZZ6Kl6c3elXcopRWRkvGd3uLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791682; c=relaxed/simple;
	bh=M49i9Z80LvRN1KH00nCqmQiLAV5d1TcbHzx3zh4khGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcv7jA0mijoqyPD1q2GHGzgXyYX4igHTUf0teh0NMslsL6U31zvd6JkleCljp2Mn11Ak8irvJvr/NPQJI4TkUb/OFcokg8VO+SrE+ex+jb9RkKPEEpCu9FTD21Ddm3DCz27IcXio/Ghl1e7k5s3l01GLXONe+tgKTzrveknwC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvEb9Lbu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730791679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1m4NUSQOwh8h3S2yfP06X/nb4pg21Jt9eMtwUyyXqBQ=;
	b=hvEb9LbuYa6PsyJRfKycrFF43B6eG9+kY9jde3HGDXdvqVB51o3RBPLFSDoDRvFFbXuuZj
	oHwRYykoFxbA/MuXYYSrgzZA1IceSWV2IiP7D2PELy10C55euWf1XSrzj+KBig2jJ+uPjP
	DfUZURD75CUiml2QspTQWT+fxEBD+8A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-p_ZQeHAjNgOwXe-RNXUbxQ-1; Tue,
 05 Nov 2024 02:27:56 -0500
X-MC-Unique: p_ZQeHAjNgOwXe-RNXUbxQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCC5519560AB;
	Tue,  5 Nov 2024 07:27:54 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B52F1956086;
	Tue,  5 Nov 2024 07:27:50 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 6/9] vhost: Add kthread support in function vhost_worker_destroy()
Date: Tue,  5 Nov 2024 15:25:25 +0800
Message-ID: <20241105072642.898710-7-lulu@redhat.com>
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

The function vhost_worker_destroy() will use struct vhost_task_fn and
selects the different mode based on the value of inherit_owner.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 8b7ddfb33c61..c17dc01febcc 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -718,12 +718,14 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 static void vhost_worker_destroy(struct vhost_dev *dev,
 				 struct vhost_worker *worker)
 {
-	if (!worker)
+	if (!worker && !worker->fn)
 		return;
 
 	WARN_ON(!llist_empty(&worker->work_list));
 	xa_erase(&dev->worker_xa, worker->id);
-	vhost_task_stop(worker->vtsk);
+	worker->fn->stop(dev->inherit_owner ? (void *)worker->vtsk :
+					      (void *)worker->task);
+	kfree(worker->fn);
 	kfree(worker);
 }
 
-- 
2.45.0


