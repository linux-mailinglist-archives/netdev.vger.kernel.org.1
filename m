Return-Path: <netdev+bounces-210728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FA7B14943
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0088C3BC536
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 07:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DC8264A9C;
	Tue, 29 Jul 2025 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3zPV60x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5402083A14
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753774775; cv=none; b=u2ZiPdvRThlE/WwdSymv4LehEW15b+XY5sqC/PLSP0YKDNFRcZd3Q4fwJ9iRKPSz/jbi4Q37drO9xMt1KbpBu7sRRcMQ+mgTYB2fInQuPpDqarL9hfn/ND1JypCSV8BUSqYflYNLrEPel9XwGBqXwEe2ioOwUbXKtcPiY3LKM/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753774775; c=relaxed/simple;
	bh=+Ysl3if1SXWQNZXdxFII6Dm8CGdVoYzAanR1NGAweUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fltjxLDVM1KMfi5RiJnqkDv9Bt4pdT3dDNRWDgaX/Pe/BuMAGr5QZKCXmIWmhpl86QGvTyZVprTuCwlF7npmUUiqq8M1ItHouditRTR1MGD1mXHKeKVAfAE0c11IMMo9H0rE0vk5HS757rYL1V/8w+DP8sV1bnkM1gucc1h27VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3zPV60x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753774772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nlhCSY/x94o/wsdtYQRoNxvT9uh4LXdBuYPdAR6ApYw=;
	b=J3zPV60xKOoT2xhFLR7SW5HxiA4+qLFs9mUwp1KbbhNnF0IKvIu6o7oPpu/d4VRoqEIAzM
	+xcmLd8KcBzxISWvW25TrVmnWU9jA/pBeKkZG5VdiHov4tDRZB2w15LOd+kBvPu+nAGpj6
	0sarxTysAtpE4MQNGvuT/BXINKi8vlI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-f6heyX8hODe7jUb8lZsN3w-1; Tue,
 29 Jul 2025 03:39:29 -0400
X-MC-Unique: f6heyX8hODe7jUb8lZsN3w-1
X-Mimecast-MFC-AGG-ID: f6heyX8hODe7jUb8lZsN3w_1753774766
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 851AB19560AE;
	Tue, 29 Jul 2025 07:39:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.89])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10DD41800285;
	Tue, 29 Jul 2025 07:39:19 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sgarzare@redhat.com,
	will@kernel.org,
	JAEHOON KIM <jhkim@linux.ibm.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH] vhost: initialize vq->nheads properly
Date: Tue, 29 Jul 2025 15:39:16 +0800
Message-ID: <20250729073916.80647-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Commit 7918bb2d19c9 ("vhost: basic in order support") introduces
vq->nheads to store the number of batched used buffers per used elem
but it forgets to initialize the vq->nheads to NULL in
vhost_dev_init() this will cause kfree() that would try to free it
without be allocated if SET_OWNER is not called.

Reported-by: JAEHOON KIM <jhkim@linux.ibm.com>
Reported-by: Breno Leitao <leitao@debian.org>
Fixes: 7918bb2d19c9 ("vhost: basic in order support")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a4873d116df1..b4dfe38c7008 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -615,6 +615,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 		vq->log = NULL;
 		vq->indirect = NULL;
 		vq->heads = NULL;
+		vq->nheads = NULL;
 		vq->dev = dev;
 		mutex_init(&vq->mutex);
 		vhost_vq_reset(dev, vq);
-- 
2.39.5


