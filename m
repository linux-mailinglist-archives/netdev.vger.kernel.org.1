Return-Path: <netdev+bounces-178087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CC8A7474F
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 11:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A038C17DE42
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 10:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FCB21C167;
	Fri, 28 Mar 2025 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4rCipIF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3796A21A434
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156318; cv=none; b=R/JFKDKuwED9eY9ZrkA3Iod/NtWbyQ9Dc4btgzJFVC8kAgHz/VzqJptYgVu+s0aWx8t8j7uB3rMiwIWUk4X+C4Y/s59wJuwNE+iKMW7NfBxHNhCMWknAuwyDlk7PuwsK8bTXROGm01zrv5A5UMSELKh7uB6RcundbNwLIT/oCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156318; c=relaxed/simple;
	bh=uvSR+nHkOyddC0QdPQ72//WOuIk64mxGFFY2EA8HABQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qU+x0tBSjlW5b+zUFQT8wmDddS2ErZFTfYcmPLowj4prnhQesPFGtQ3om2BRTXEGCYIpjInvxx5YwQ2rwKAd47BF3epeOg1FLRSLYQNY3D5B8uIdP5/uLCNV3HaxiRMePwM3WNjBX++y8MmliduWboSiSeXJgrStnnu8uziDW8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4rCipIF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743156313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlJT47zLkSfn9zom7PdH4akIw1D+Y3HK6R7VYjb50+Q=;
	b=L4rCipIFHx2Kvky9pL0GPbmsKnK7lZ58/SewOAEy5bFfX9Z45ex0GrdC2a0FWiXfgGVniY
	nRi+sjFIBCy2KPdtjCG3zLMhu8ip/yyaloCjkoipSdepWXsmr/VkD9mXhRpt1f8tmxlmy0
	WLbXUORW6d5Mlb17KewrZ1LJT2OcDxQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-HiBbKl8yOjeI9ZL1yBl2Fg-1; Fri,
 28 Mar 2025 06:05:10 -0400
X-MC-Unique: HiBbKl8yOjeI9ZL1yBl2Fg-1
X-Mimecast-MFC-AGG-ID: HiBbKl8yOjeI9ZL1yBl2Fg_1743156309
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DE2C1800260;
	Fri, 28 Mar 2025 10:05:09 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4D4619541A5;
	Fri, 28 Mar 2025 10:05:04 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v8 7/8] vhost: Add check for inherit_owner status
Date: Fri, 28 Mar 2025 18:02:51 +0800
Message-ID: <20250328100359.1306072-8-lulu@redhat.com>
In-Reply-To: <20250328100359.1306072-1-lulu@redhat.com>
References: <20250328100359.1306072-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The VHOST_NEW_WORKER requires the inherit_owner
setting to be true. So we need to add a check for this.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index ff930c2e5b78..fb0c7fb43f78 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1018,6 +1018,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
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


