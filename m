Return-Path: <netdev+bounces-150758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAA09EB6E0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10162166DFA
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9BA2343C0;
	Tue, 10 Dec 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FuzGJLY0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF802343CD
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849157; cv=none; b=BKAN6ktcKRvOSQdKnpDtqBU/La7KPvPCpUd6cC7B1XY+tm4Gg+firn2/SAOD2G2L/UywVXFn+30CPQIcGY8uXRDDZ5HQSqZP3LrHK4CzG7pCVIKW0V+mZUqLWm1ANcfV7a6k2Ilf9UwGzRcTPL8XVyidiVhnbcZuLDqzo+Pxo00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849157; c=relaxed/simple;
	bh=YOfWaYqxdg6bK9f7Uz3VKPypKGPg3DU2DtQ1pCaatEA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrAiiIHWPB2Xm5JGBhwpBryWay1gSjQ77Xgx+WjPi/69lBLYjYIFSHME6tuDgrmY0z7xfnm8Pa8R7c+usrtddaqRDNuKMrhXSWjK/BxoS9ScC4bzkxpIq33304yOUfXO7q1+V1bjNqBSr/W+eZxoLL42zUZaXbaEk1kjOcEry8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FuzGJLY0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733849155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+cFVaqbbEd48elKSFqv37dUABY9S1RJqNxZsF1midck=;
	b=FuzGJLY0h7d0lEimUrxF/NswTLeGbSp31IaHf/EV84KTi+xPqS9Z1MmMhrDroasu1OUyaO
	WYg/5uGIkmx6a4390tRvSsTIU3RAyubBEqHP/v4VIF2nOnComf7Qc0Uo8cyxxuNOCXiv9T
	pMoTI4D1SUpQ/jCCBq/Y7amODbFkzTo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-yhwMGRfEMTaFixChVawAGA-1; Tue,
 10 Dec 2024 11:45:53 -0500
X-MC-Unique: yhwMGRfEMTaFixChVawAGA-1
X-Mimecast-MFC-AGG-ID: yhwMGRfEMTaFixChVawAGA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7D64195609D;
	Tue, 10 Dec 2024 16:45:52 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.152])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6BD8E19560A2;
	Tue, 10 Dec 2024 16:45:48 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 5/8] vhost: Add kthread support in function vhost_worker_queue()
Date: Wed, 11 Dec 2024 00:41:44 +0800
Message-ID: <20241210164456.925060-6-lulu@redhat.com>
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

The function vhost_worker_queue() uses a function pointer in
vhost_worker, which is initialized based on the inherit_owner
value.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 0175bbf4d8b3..d1aec41bcd56 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -237,13 +237,16 @@ EXPORT_SYMBOL_GPL(vhost_poll_stop);
 static void vhost_worker_queue(struct vhost_worker *worker,
 			       struct vhost_work *work)
 {
+	if (!worker)
+		return;
+
 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
 		/* We can only add the work to the list after we're
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &worker->work_list);
-		vhost_task_wake(worker->vtsk);
+		worker->task_wakeup(worker);
 	}
 }
 
-- 
2.45.0


