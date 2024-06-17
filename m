Return-Path: <netdev+bounces-104025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FDF90AEDD
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAFD0B28A3C
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A86219882C;
	Mon, 17 Jun 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LwwaE5lY"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1A11E4A4
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630137; cv=none; b=D8nopY1FVAVmYJvVAT8cNwAeRvaEt+5wTIz8DZxYj51ik35cU0kEJiMy33AtcCyiy5LPvoga+45Y5DPY0aq4wLwoOvVB/1MZtjX7TJuvlilcsCg3QUBI0mxc5ctqotMLn0QpaWfFWZakd82N912dU/hn/OkdphernxbvQFgj1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630137; c=relaxed/simple;
	bh=YKWSFpD2t9smMqHR0OzAK7RWGnx1qZClN3jUQUQbWik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAfc/mGmAu2daxcqRpUhHqUUh2hzI49zn1p+UDXT3MELcBqrArvvRsa5CuVkmKsFBS3bLiItmskrGzSFHo1wqQYw/A42V+f9vdEDd3pE69PDapC4AR0Rm7jjvDp1UiDz9apwiVnD6b97XTeeonpvLyEK23Wp1k8wLtzdyqkDAzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LwwaE5lY; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718630127; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gWO6nXsDoeWzECozLUEzwbIZkC4rZqgmByjQv8l6vag=;
	b=LwwaE5lYuaFhzlzhwNJTI8Fuv3hzUFwaxvUYmk5lqC709E+q6C/equasRGDkp7YoDW7l6D3ENVI/oBhS4yeww/2BbYxEVifKjZESFiS9iNLKiXh5Efe2AjZCw4luPLYzzL49D0z4EfiMNjtN6hlHzAI18NlnwxmDKSQOK3INPmU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8enhhB_1718630125;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8enhhB_1718630125)
          by smtp.aliyun-inc.com;
          Mon, 17 Jun 2024 21:15:26 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Thomas Huth <thuth@linux.vnet.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH 1/2] virtio_net: checksum offloading handling fix
Date: Mon, 17 Jun 2024 21:15:23 +0800
Message-Id: <20240617131524.63662-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240617131524.63662-1-hengqi@linux.alibaba.com>
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In virtio spec 0.95, VIRTIO_NET_F_GUEST_CSUM was designed to handle
partially checksummed packets, and the validation of fully checksummed
packets by the device is independent of VIRTIO_NET_F_GUEST_CSUM
negotiation. However, the specification erroneously stated:

  "If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device MUST set flags
   to zero and SHOULD supply a fully checksummed packet to the driver."

This statement is inaccurate because even without VIRTIO_NET_F_GUEST_CSUM
negotiation, the device can still set the VIRTIO_NET_HDR_F_DATA_VALID flag.
Essentially, the device can facilitate the validation of these packets'
checksums - a process known as RX checksum offloading - removing the need
for the driver to do so.

This scenario is currently not implemented in the driver and requires
correction. The necessary specification correction[1] has been made and
approved in the virtio TC vote.
[1] https://lists.oasis-open.org/archives/virtio-comment/202401/msg00011.html

Fixes: 4f49129be6fa ("virtio-net: Set RXCSUM feature if GUEST_CSUM is available")
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 61a57d134544..aa70a7ed8072 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5666,8 +5666,16 @@ static int virtnet_probe(struct virtio_device *vdev)
 			dev->features |= dev->hw_features & NETIF_F_ALL_TSO;
 		/* (!csum && gso) case will be fixed by register_netdev() */
 	}
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_CSUM))
-		dev->features |= NETIF_F_RXCSUM;
+
+	/* 1. With VIRTIO_NET_F_GUEST_CSUM negotiation, the driver doesn't
+	 * need to calculate checksums for partially checksummed packets,
+	 * as they're considered valid by the upper layer.
+	 * 2. Without VIRTIO_NET_F_GUEST_CSUM negotiation, the driver only
+	 * receives fully checksummed packets. The device may assist in
+	 * validating these packets' checksums, so the driver won't have to.
+	 */
+	dev->features |= NETIF_F_RXCSUM;
+
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
 		dev->features |= NETIF_F_GRO_HW;
-- 
2.32.0.3.g01195cf9f


