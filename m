Return-Path: <netdev+bounces-212823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8A2B22271
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42AD7188C621
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0E82E7BB7;
	Tue, 12 Aug 2025 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YQoExukR"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323212E0B6E
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989712; cv=none; b=Sx6WjHXwsmxISNQYvH40DPfC4jWcecJN1ntMaSjTbOeldqhLONtKpWjif4xDh9tkx+l+ruaI+aW4Ptzt6AYcJrovufj1S1nuF9xLuAdBxs9nfDIviRCD3uLpYopZi0c/8VoDxR6G31x/MioG9cI1LQ3fFx/vvHWu7oZtNrAYQIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989712; c=relaxed/simple;
	bh=XFOPORjq8GcREkHwBlxSYHtm0NpOHASGisBz2Dt78UQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=qSMEDQHT49JW3pnEbLnio98VCMzPt54ZypT2AtJFYttJQQ2I9ck2DeAzbGpUYjaSKdoB0zqEVZCiliEo8NQHlA0yWdJGv/gPCntHvXuN4gFVspnvE5iVA/ejca7RYOrwdIhNnP+zoQOGs9YRgRQSoSRFzpOEOrpftzvs+yDFMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YQoExukR; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250812090827epoutp01203dc11c05b3cb63971f309951eaee12~a_dcnT1wL0896408964epoutp01g
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 09:08:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250812090827epoutp01203dc11c05b3cb63971f309951eaee12~a_dcnT1wL0896408964epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754989707;
	bh=8xEd4SUUha0bAbY0XzlCiDYrRhqQiem5yvi1bXt6EQ0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=YQoExukRTbEqryD0ozd4DGOJFAgr77RVRQZa9r8qi38alGCzUMPDsS3pbo+XeSZqD
	 1vS0MgeFixfY6eXtcI9dZdCQR2+Oax/KewTSPpaMuByKm42hSy3DDnaxJaMsDbxzY8
	 IaTq1hDCZgVreh/HC4o88572+Mf5P/iCVNiK2gfg=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250812090825epcas5p2da0ef83e97d363373011084787aecf0d~a_dbXvRMy2934229342epcas5p29;
	Tue, 12 Aug 2025 09:08:25 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4c1Qf06zQvz3hhTT; Tue, 12 Aug
	2025 09:08:24 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250812090805epcas5p25ba25ca1c5c68bbdf9df27d95ccae4f5~a_dIDowPa1993619936epcas5p21;
	Tue, 12 Aug 2025 09:08:05 +0000 (GMT)
Received: from asg29.. (unknown [109.105.129.29]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250812090803epsmtip2d22a0d6f203ef7877ab182f5c7ef7b83~a_dGj1rlf2788827888epsmtip2E;
	Tue, 12 Aug 2025 09:08:03 +0000 (GMT)
From: Junnan Wu <junnan01.wu@samsung.com>
To: mst@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ying123.xu@samsung.com,
	lei19.wang@samsung.com, q1.huang@samsung.com, Junnan Wu
	<junnan01.wu@samsung.com>
Subject: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
Date: Tue, 12 Aug 2025 17:08:17 +0800
Message-Id: <20250812090817.3463403-1-junnan01.wu@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250812090805epcas5p25ba25ca1c5c68bbdf9df27d95ccae4f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250812090805epcas5p25ba25ca1c5c68bbdf9df27d95ccae4f5
References: <CGME20250812090805epcas5p25ba25ca1c5c68bbdf9df27d95ccae4f5@epcas5p2.samsung.com>

"Use after free" issue appears in suspend once race occurs when
napi poll scheduls after `netif_device_detach` and before napi disables.

For details, during suspend flow of virtio-net,
the tx queue state is set to "__QUEUE_STATE_DRV_XOFF" by CPU-A.

And at some coincidental times, if a TCP connection is still working,
CPU-B does `virtnet_poll` before napi disable.
In this flow, the state "__QUEUE_STATE_DRV_XOFF"
of tx queue will be cleared. This is not the normal process it expects.

After that, CPU-A continues to close driver then virtqueue is removed.

Sequence likes below:
--------------------------------------------------------------------------
              CPU-A                            CPU-B
              -----                            -----
         suspend is called                  A TCP based on
                                        virtio-net still work
 virtnet_freeze
 |- virtnet_freeze_down
 | |- netif_device_detach
 | | |- netif_tx_stop_all_queues
 | |  |- netif_tx_stop_queue
 | |   |- set_bit
 | |     (__QUEUE_STATE_DRV_XOFF,...)
 | |                                     softirq rasied
 | |                                    |- net_rx_action
 | |                                     |- napi_poll
 | |                                      |- virtnet_poll
 | |                                       |- virtnet_poll_cleantx
 | |                                        |- netif_tx_wake_queue
 | |                                         |- test_and_clear_bit
 | |                                          (__QUEUE_STATE_DRV_XOFF,...)
 | |- virtnet_close
 |  |- virtnet_disable_queue_pair
 |   |- virtnet_napi_tx_disable
 |- remove_vq_common
--------------------------------------------------------------------------

When TCP delayack timer is up, a cpu gets softirq and irq handler
`tcp_delack_timer_handler` will be called, which will finally call
`start_xmit` in virtio net driver.
Then the access to tx virtq will cause panic.

The root cause of this issue is that napi tx
is not disable before `netif_tx_stop_queue`,
once `virnet_poll` schedules in such coincidental time,
the tx queue state will be cleared.

To solve this issue, adjusts the order of
function `virtnet_close` in `virtnet_freeze_down`.

Co-developed-by: Ying Xu <ying123.xu@samsung.com>
Signed-off-by: Ying Xu <ying123.xu@samsung.com>
Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
---
 drivers/net/virtio_net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d14e6d602273..975bdc5dab84 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5758,14 +5758,15 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	disable_rx_mode_work(vi);
 	flush_work(&vi->rx_mode_work);
 
-	netif_tx_lock_bh(vi->dev);
-	netif_device_detach(vi->dev);
-	netif_tx_unlock_bh(vi->dev);
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
 		virtnet_close(vi->dev);
 		rtnl_unlock();
 	}
+
+	netif_tx_lock_bh(vi->dev);
+	netif_device_detach(vi->dev);
+	netif_tx_unlock_bh(vi->dev);
 }
 
 static int init_vqs(struct virtnet_info *vi);
-- 
2.34.1


