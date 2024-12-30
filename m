Return-Path: <netdev+bounces-154537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5C19FE60D
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 13:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE85188288E
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE45E1B4233;
	Mon, 30 Dec 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQoVXVMS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34A31B4226
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735562751; cv=none; b=m7LZ2Y349QqxSbg5W1m6q+0XT0SgXHae941fsn+mcdZ+1Z7OhR715L8ZlJUslK36wzdXhWaOQ5M28Z1iUVnaDUkZlCKMr0YmECoaNOuMGJYRTcL3DVd3mkwmKcCbTQTm4l57aDflfSssCgyG/QD9RBNpldcHd7C5907VcPfYa8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735562751; c=relaxed/simple;
	bh=OGzW+SnQ3xR3XeDgv9+sPtHgQMdqMojO7S8Pp2pmps0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4rOtSjRKwiAppVgEbbL7TCpfnD3eb2JGVc6KDrVoM5slnMny3G0n5KbQ1EP6+zicT0FlulCwEhs0ZtbaRT5BElyM++MoDh0nSWefzWazOhSl+CnNg86iXAc19pqzx2OPImmeyegVlXDZiPIRvlBIbZBiLGcbgt1/3FN1HZgr9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQoVXVMS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735562748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOLNm7RgGjm+/oknkrmt1JKCoXNQL051GSrtvQZUvKg=;
	b=NQoVXVMSdODBuR0NJqlxTpS/G5livfgNiWFz+jruPGEMF7ArHIhYh/gdF4Sy5xJWiAbkPS
	6jVfBN4Ua3GDn5JpWSyNIHXnzfchuOxkD8zSZ7I5fD5VexpX3dXoYWynygdI+i9jZIDycW
	tq70KHySV/ZLtGvz8i+4usrxfiXnpqA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-Bsm6_zAdMOCXSGDiO3J0Jw-1; Mon,
 30 Dec 2024 07:45:45 -0500
X-MC-Unique: Bsm6_zAdMOCXSGDiO3J0Jw-1
X-Mimecast-MFC-AGG-ID: Bsm6_zAdMOCXSGDiO3J0Jw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7977519560B1;
	Mon, 30 Dec 2024 12:45:44 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 759C419560A2;
	Mon, 30 Dec 2024 12:45:40 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 5/6] vhost: Add new UAPI to support change to task mode
Date: Mon, 30 Dec 2024 20:43:52 +0800
Message-ID: <20241230124445.1850997-6-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-1-lulu@redhat.com>
References: <20241230124445.1850997-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a new UAPI to enable setting the vhost device to task mode.
The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
to configure the mode if necessary.
This setting must be applied before VHOST_SET_OWNER, as the worker
will be created in the VHOST_SET_OWNER function

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
 include/uapi/linux/vhost.h | 19 +++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index ff17c42e2d1a..47c1329360ac 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2250,15 +2250,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 {
 	struct eventfd_ctx *ctx;
 	u64 p;
-	long r;
+	long r = 0;
 	int i, fd;
+	u8 inherit_owner;
 
 	/* If you are not the owner, you can become one */
 	if (ioctl == VHOST_SET_OWNER) {
 		r = vhost_dev_set_owner(d);
 		goto done;
 	}
+	if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {
+		/*inherit_owner can only be modified before owner is set*/
+		if (vhost_dev_has_owner(d)) {
+			r = -EBUSY;
+			goto done;
+		}
+		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
+			r = -EFAULT;
+			goto done;
+		}
+		/* Validate the inherit_owner value, ensuring it is either 0 or 1 */
+		if (inherit_owner > 1) {
+			r = -EINVAL;
+			goto done;
+		}
+
+		d->inherit_owner = (bool)inherit_owner;
 
+		goto done;
+	}
 	/* You must be the owner to do anything else */
 	r = vhost_dev_check_owner(d);
 	if (r)
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index b95dd84eef2d..f5fcf0b25736 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -235,4 +235,23 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+/**
+ * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the vhost device
+ *
+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
+ *
+ * When inherit_owner is set to 1 (default behavior):
+ *   - The VHOST worker threads inherit their values/checks from
+ *     the thread that owns the VHOST device. The vhost threads will
+ *     be counted in the nproc rlimits.
+ *
+ * When inherit_owner is set to 0:
+ *   - The VHOST worker threads will use the traditional kernel thread (kthread)
+ *     implementation, which may be preferred by older userspace applications that
+ *     do not utilize the newer vhost_task concept.
+ */
+
+#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
+
 #endif
-- 
2.45.0


