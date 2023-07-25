Return-Path: <netdev+bounces-20703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 034E2760B8D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE12E1C20D5C
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C480F8F72;
	Tue, 25 Jul 2023 07:21:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84778F64
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:21:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BC03C14
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690269663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O4NPnIwLWASrkcbTpOvlLNlC5PapC0fYAT3vFFR10cU=;
	b=c0fSrFcuGVSfaBUqiGcXkvW5z5YcXvmMjs5H3N2vh+VfW4G8QvFPoDbpU7jrgrQHQentNh
	x2JLodoggwsXh+lDiOFk8sDVGjN7+BP0AeNtHi5VW3FMZXxTg59VF01n6yjTmoJD5dU773
	H4s6HJm3DrJuVhb4PHZbq0r+5tkSrG4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-696-Zs9cRlWzO76qNXedwhkqXQ-1; Tue, 25 Jul 2023 03:20:55 -0400
X-MC-Unique: Zs9cRlWzO76qNXedwhkqXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B562800159;
	Tue, 25 Jul 2023 07:20:55 +0000 (UTC)
Received: from dell-per430-12.lab.eng.pek2.redhat.com (dell-per430-12.lab.eng.pek2.redhat.com [10.73.196.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7101C2166B25;
	Tue, 25 Jul 2023 07:20:51 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH net] virtio-net: fix race between set queues and probe
Date: Tue, 25 Jul 2023 03:20:49 -0400
Message-Id: <20230725072049.617289-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A race were found where set_channels could be called after registering
but before virtnet_set_queues() in virtnet_probe(). Fixing this by
moving the virtnet_set_queues() before netdevice registering. While at
it, use _virtnet_set_queues() to avoid holding rtnl as the device is
not even registered at that time.

Fixes: a220871be66f ("virtio-net: correctly enable multiqueue")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0db14f6b87d3..1270c8d23463 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4219,6 +4219,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
+	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -4257,8 +4259,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_unregister_netdev;
 	}
 
-	virtnet_set_queues(vi, vi->curr_queue_pairs);
-
 	/* Assume link up if device can't report link status,
 	   otherwise get link status from config. */
 	netif_carrier_off(dev);
-- 
2.39.3


