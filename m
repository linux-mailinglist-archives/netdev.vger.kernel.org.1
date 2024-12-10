Return-Path: <netdev+bounces-150761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9AA9EB6E8
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB99416462E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A82309A7;
	Tue, 10 Dec 2024 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WthUIAl8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27931B86DC
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849195; cv=none; b=QDs57tIBbPUEjRJd+QxBQRmXiAdDzgPhdMhv4B63SKkHsa/PbtC8fhqT9H8BmB84OEqSW2GZktDRWLUVWYCai0u8WwAcX9VEIII8EjnkQi2nLFB9sMzZNQmofuz/jgOtYCjfPYQV4Up4T5MuJnMb4CIKDnCxvnodV2TsrffPDSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849195; c=relaxed/simple;
	bh=ya0jLzzyRV4JPRzvVhGgoWSL9yvZjTh8Fu2M3ibVj+k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mm9lt8cK2QY3n+NucWlOyx9ReTnR/x1ZediFA9dw2EO2bgzr9eXe1y9MMnr41kysP92tsO5lIe28jZDGTIr0ehN/GBCwDUCqVNG98NHoQNQ28QHjf9kGoncy7d/sPNIH7gvRI67TiCbhxi0MiY7QeI5KEdGxpEmRCGcB5ZGt0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WthUIAl8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733849193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xX4qyypEHsNe4ER87SJ3OZmlnLp0lW0wrG4GS+lDAg=;
	b=WthUIAl8nkf1qdYvT0yw5hrU6KdTYoufoLI4MPDHPSd6/zDi+fXzdecfCJOcvUm7MLRRpG
	eQQm9HhiHgIA+IR4o1XBI+87ocTC5lKpcXpqaSU2+dIlwJplRd3NIU/iMgvg416V9DCBIL
	Vk4WQA1ES93Zuz4VMkKHE1RNaOzqlo0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-PN06NUaXOWS9-zksu7JJqQ-1; Tue,
 10 Dec 2024 11:46:31 -0500
X-MC-Unique: PN06NUaXOWS9-zksu7JJqQ-1
X-Mimecast-MFC-AGG-ID: PN06NUaXOWS9-zksu7JJqQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0BFD1956057;
	Tue, 10 Dec 2024 16:46:30 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.152])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 185A019560A7;
	Tue, 10 Dec 2024 16:46:25 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 8/8] vhost_scsi: Add check for inherit_owner status
Date: Wed, 11 Dec 2024 00:41:47 +0800
Message-ID: <20241210164456.925060-9-lulu@redhat.com>
In-Reply-To: <20241210164456.925060-1-lulu@redhat.com>
References: <20241210164456.925060-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The vhost_scsi VHOST_NEW_WORKER requires the inherit_owner
setting to be true. So we need to implement a check for this.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/scsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 718fa4e0b31e..0d63b6b5c852 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2086,6 +2086,14 @@ vhost_scsi_ioctl(struct file *f,
 			return -EFAULT;
 		return vhost_scsi_set_features(vs, features);
 	case VHOST_NEW_WORKER:
+		/*
+		 * vhost_tasks will account for worker threads under the parent's
+		 * NPROC value but kthreads do not. To avoid userspace overflowing
+		 * the system with worker threads inherit_owner must be true.
+		 */
+		if (!vs->dev.inherit_owner)
+			return -EFAULT;
+		fallthrough;
 	case VHOST_FREE_WORKER:
 	case VHOST_ATTACH_VRING_WORKER:
 	case VHOST_GET_VRING_WORKER:
-- 
2.45.0


