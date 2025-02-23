Return-Path: <netdev+bounces-168835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28026A40F8F
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 16:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE5916FAAB
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 15:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349DE20CCE3;
	Sun, 23 Feb 2025 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ffkj0MM/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8BC20C490
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740325315; cv=none; b=hS7/ve7rv2E6bLEpx0NF0kvVnW0S93EmBmVjiFofVijMrosqioMlagcUvd0VMa4xA9ND4uVh8F1vyuw875jJQuhm5sqmBmxI0ikUlQhjTaPnkfdFyODz0nO7ataSPm9r06DIxvAGENi0zyCs3QqbGCDEcQV5MA+wf8khlxQFyiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740325315; c=relaxed/simple;
	bh=ZGGr8CpUC2KsJpl4JTjnc3CvTn1h9z7S+oOYdP7bE20=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY4seh+G1+qExXwrxYXVxEwdUTsgwKYMdDoO5pH8zCOoC29uYddtr/s+2f+jzO4no2kFz99RVBQkgGPxt+d3mDEMEpbpQK7y5wQOhCLnjG6Ep5EJ8AoJ/2WTvkp0pI0kQWMssjbg3goLzLIoRZ/PFNwcQ+mIUQe6QWnsgMnF6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ffkj0MM/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740325312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvywjBt9qiVEE9rGZyn5DkXXMEjJbM4TB/T7cbHYBEo=;
	b=Ffkj0MM/C4SAaRHKIe2Jr3MWTR9rGMGiFgZzHHyIT2Jh52qe7wDwjD1mrszn6Co+vJUBVT
	LcE7BP2Kbc4rHU1IOUARYFbkR9Fj9SFd1mQXW//AVFy/f3OlkheJzAF9wqdIgsBp6G+Y8L
	m2shsbUG94RRkffL38NU/jK2nE3KAGc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-B0X9Vo8lOo6-dJW4ojwo4g-1; Sun,
 23 Feb 2025 10:41:47 -0500
X-MC-Unique: B0X9Vo8lOo6-dJW4ojwo4g-1
X-Mimecast-MFC-AGG-ID: B0X9Vo8lOo6-dJW4ojwo4g_1740325304
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9510519783BA;
	Sun, 23 Feb 2025 15:41:44 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.28])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EEEE1800359;
	Sun, 23 Feb 2025 15:41:39 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 6/6] vhost: Add check for inherit_owner status
Date: Sun, 23 Feb 2025 23:36:21 +0800
Message-ID: <20250223154042.556001-7-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-1-lulu@redhat.com>
References: <20250223154042.556001-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The VHOST_NEW_WORKER requires the inherit_owner
setting to be true. So we need to add a check for this.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 45d8f5c5bca9..26da561c6685 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1017,6 +1017,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 	switch (ioctl) {
 	/* dev worker ioctls */
 	case VHOST_NEW_WORKER:
+		/*
+		 * vhost_tasks will account for worker threads under the parent's
+		 * NPROC value but kthreads do not. To avoid userspace overflowing
+		 * the system with worker threads inherit_owner must be true.
+		 */
+		if (!dev->inherit_owner)
+			return -EFAULT;
 		ret = vhost_new_worker(dev, &state);
 		if (!ret && copy_to_user(argp, &state, sizeof(state)))
 			ret = -EFAULT;
-- 
2.45.0


