Return-Path: <netdev+bounces-118320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F09169513DB
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A401A28536A
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 05:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807A213C80A;
	Wed, 14 Aug 2024 05:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUWTkfyK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD8E13B59B
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 05:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723612997; cv=none; b=fY+m1ohLCMLuu3vwibLgGuNH++JXiDV/HvwYeGyMEI6caaO9iPbfTXgWTVJfW/PSTcSPqcGk+RjCF6M/2aBbHVtU5dzjpTtCXVElFlQ//Kz53r9wZAuggxIVLqs3y0gdQ7yWk+9NUjXGpkqIrwnFahbHqndeQwPYS8rifbDalkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723612997; c=relaxed/simple;
	bh=XJEvt+yIN4yZx5BK8Fprghh8IxukmlAPgsAMgtIfSNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqrL5oTt/UYNiIC/qgOoxhqP8903x8AAnJDl7CC3kB49RJdIZIKsMOADjJpVHMXswzezhQOnVvuas6Ey6A5VikrUh0X07Fke1Shohb6lFRyWG2wJOsEiIhLLUONUmSJne6irjPy+hEaaIJ9G5AsSzgETqN4ZXym1Pt95LLq0nbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUWTkfyK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723612994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfwh1eGCzguoUvuJz78z6dH7f3hxP70/1uP7cAzG5qY=;
	b=GUWTkfyKfzXPuhWQTDCiu4zQ0pPWHbAZYptM0pAZlgKwqhArYJxnBC1HkfYx1iRyBvh7/6
	IfJw53uyz0uXvMaDo+GlxH68UV7rHig0onRHJ2MlpAe1bsxno5/DL3+q8/39ib709oETVw
	7JVZHG5KLhzKDvPN5mpAZZyvAsrxOro=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-fhVs7HFGNlKlMCBwDsygtg-1; Wed,
 14 Aug 2024 01:23:11 -0400
X-MC-Unique: fhVs7HFGNlKlMCBwDsygtg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 860ED18EB232;
	Wed, 14 Aug 2024 05:23:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.38])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E1F4A1944A95;
	Wed, 14 Aug 2024 05:23:02 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: [PATCH net-next v7 4/4] virtio-net: synchronize probe with ndo_set_features
Date: Wed, 14 Aug 2024 13:22:28 +0800
Message-ID: <20240814052228.4654-5-jasowang@redhat.com>
In-Reply-To: <20240814052228.4654-1-jasowang@redhat.com>
References: <20240814052228.4654-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

We calculate guest offloads during probe without the protection of
rtnl_lock. This lead to race between probe and ndo_set_features. Fix
this by moving the calculation under the rtnl_lock.

Fixes: 3f93522ffab2 ("virtio-net: switch off offloads on demand if possible on XDP set")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 55b712a71e63..6c79fc43fa31 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6606,6 +6606,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 		netif_carrier_on(dev);
 	}
 
+	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
+		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
+			set_bit(guest_offloads[i], &vi->guest_offloads);
+	vi->guest_offloads_capable = vi->guest_offloads;
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
@@ -6614,11 +6619,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_unregister_netdev;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
-		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
-			set_bit(guest_offloads[i], &vi->guest_offloads);
-	vi->guest_offloads_capable = vi->guest_offloads;
-
 	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
 		 dev->name, max_queue_pairs);
 
-- 
2.31.1


