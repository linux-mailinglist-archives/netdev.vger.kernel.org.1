Return-Path: <netdev+bounces-26132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AE8776E5E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 05:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3176B1C21446
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 03:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1F181C;
	Thu, 10 Aug 2023 03:13:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16067E4
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:13:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00439C6
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691637186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x9L6xP3gYbtAj0NCz8uLq+ActI3o6tJnEr7jbjLqmsY=;
	b=GE0jWwTFjmNqwbfU/VfUqap4lOwMtnLQXtILQHznhKtrSPlM1bxAofx/MYTWqbSqml4NCH
	5tJSJYe8HuhGbv3Dfs/k+3MNvE3mL4f08XtsU7loB8wU9eVtdeaTc4o3R2am3eTgATg4LY
	KNhs+9lCPMYJ5AVHMlRtWa6u+dXpOvA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-695-PMEYTa7MMwCIYYLCdWABiQ-1; Wed, 09 Aug 2023 23:13:03 -0400
X-MC-Unique: PMEYTa7MMwCIYYLCdWABiQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E0113C0CEEE;
	Thu, 10 Aug 2023 03:13:02 +0000 (UTC)
Received: from dell-per430-12.lab.eng.pek2.redhat.com (dell-per430-12.lab.eng.pek2.redhat.com [10.73.196.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C39642166B25;
	Thu, 10 Aug 2023 03:12:58 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net V2] virtio-net: set queues after driver_ok
Date: Wed,  9 Aug 2023 23:12:56 -0400
Message-Id: <20230810031256.813284-1-jasowang@redhat.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 25266128fe16 ("virtio-net: fix race between set queues and
probe") tries to fix the race between set queues and probe by calling
_virtnet_set_queues() before DRIVER_OK is set. This violates virtio
spec. Fixing this by setting queues after virtio_device_ready().

Note that rtnl needs to be held for userspace requests to change the
number of queues. So we are serialized in this way.

Fixes: 25266128fe16 ("virtio-net: fix race between set queues and probe")
Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
The patch is needed for -stable.
Changes since V1: Tweak the commit log.
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1270c8d23463..ff03921e46df 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4219,8 +4219,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
-	_virtnet_set_queues(vi, vi->curr_queue_pairs);
-
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -4233,6 +4231,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+
 	/* a random MAC address has been assigned, notify the device.
 	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
 	 * because many devices work fine without getting MAC explicitly
-- 
2.39.3


