Return-Path: <netdev+bounces-154538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F079FE611
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 13:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4F41882995
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 12:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741941B4255;
	Mon, 30 Dec 2024 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEVdY35s"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E671B4226
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735562756; cv=none; b=qQJJKXHKWJplnF1/m596ZuEUJ6XSd3mBxn1Z26YA2f6vCT3wjsSrVQMTLTyNhINbWSzFDDxvpG+UHI2IqnJDCINYeCUi0vmOV0FSctQEiild9j/eb0Wn37fzJvQYBLlVluCXHQwoHl3iYQX6KZYiIOMkR8fzyslL13l0J83uBxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735562756; c=relaxed/simple;
	bh=ya0jLzzyRV4JPRzvVhGgoWSL9yvZjTh8Fu2M3ibVj+k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+QH6q0aKOGyTaOQTcJZixQy3UVph1+K3EaigX/bVilvGbkaKDOjH+qX5qt9kpaFu92/fOUQuoo4JEEjlUEGXQwIOKxXk2xq0eCLB9UVS4bC/u92ResDQj9YGfSoFGk2a1GWeWyO9L9oKISRH1WX16u+ur95TEi3Uyj1mPYMjvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hEVdY35s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735562753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xX4qyypEHsNe4ER87SJ3OZmlnLp0lW0wrG4GS+lDAg=;
	b=hEVdY35s3g+5YngV62wKR8yXz9L6kDnRdoCUDveRnP468IWFbGyubsDQKxwHcSERtSlB4g
	wdgjUDxKQKIWHQFY0Y5jojbA161QRYJhKD46EyrfckdguW5WLn7Duazqos94CQThRC21qy
	zVvIuGUNf+MpEQVC+LXw730lLj8b92Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-I1gdlmexNoqjr8Xbbmryxw-1; Mon,
 30 Dec 2024 07:45:50 -0500
X-MC-Unique: I1gdlmexNoqjr8Xbbmryxw-1
X-Mimecast-MFC-AGG-ID: I1gdlmexNoqjr8Xbbmryxw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B5361956055;
	Mon, 30 Dec 2024 12:45:49 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3DC3C19560A2;
	Mon, 30 Dec 2024 12:45:44 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 6/6] vhost_scsi: Add check for inherit_owner status
Date: Mon, 30 Dec 2024 20:43:53 +0800
Message-ID: <20241230124445.1850997-7-lulu@redhat.com>
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


