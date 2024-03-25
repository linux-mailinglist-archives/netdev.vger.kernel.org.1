Return-Path: <netdev+bounces-81545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 756A188A1B8
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2F91F3B5AD
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F252E1598E3;
	Mon, 25 Mar 2024 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kLp8xg/S"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27801158A11
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356875; cv=none; b=RpE/s+uCO5NE19jWZD9aReLqTHdC+HrYnxMIEA79DovZbg1wYv7TOmw/uvlrKPRQsrasn07SBcId5BfW/Qfb2IpVbXBcyWzvB99J79Blas60uZvIBKHuuo+8pphuJsyn+N1cOub/pvNClE9eltHBBfWx1JDeBQtRm//frYFd6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356875; c=relaxed/simple;
	bh=bRKawB110iOt1HJP4ZI3cUFgYTMQ9gAVw5d+n+wFqQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iWFvIloiZQDOjd6PoI6ednV/+7s1ZoSm+SGMbytKXcUuTYbFy07/n86ltvmPfiV+KAErzaEoQAIH93Orny5UKaku7X/eMf90eszGIXfcbtYIUn4MFeSXJYITGdJnB4tC3AUmwAtGJk0d3iKOGpTWoN8kHUZgOnDFbFWYBQOP1r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kLp8xg/S; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711356870; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tO+mQTU2Ki77/+Bj0jlrpd0M6eyxBcA5OVSJmRQLYjo=;
	b=kLp8xg/S+fKlYhJdDsCajKJVnIKPLPmCS/DaAwWOZce9diCs16xQNBJLsA925i8McDHSXmZ6I92H6phlX+Ltggm7ruVTLr7HyR7SPBJ5mZLHXj482tbKhsRnlwsyUw7v5ev4dfJXQ7Srj+kTsRCAajNM+1bX/X6U2QCs570ysFE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3DYiHR_1711356868;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3DYiHR_1711356868)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 16:54:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH vhost v5 00/10] virtio: drivers maintain dma info for premapped vq
Date: Mon, 25 Mar 2024 16:54:18 +0800
Message-Id: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 630d711f51f7
Content-Transfer-Encoding: 8bit

As discussed:

http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYqRZxYg@mail.gmail.com

If the virtio is premapped mode, the driver should manage the dma info by self.
So the virtio core should not store the dma info. We can release the memory used
to store the dma info.

For virtio-net xmit queue, if the virtio-net maintains the dma info,
the virtio-net must allocate too much memory(19 * queue_size for per-queue), so
we do not plan to make the virtio-net to maintain the dma info by default. The
virtio-net xmit queue only maintain the dma info when premapped mode is enable
(such as AF_XDP is enable).

So this patch set try to do:

1. make the virtio core to do not store the dma info when driver can do that
    - But if the desc_extra has not dma info, we face a new question,
      it is hard to get the dma info of the desc with indirect flag.
      For split mode, that is easy from desc, but for the packed mode,
      it is hard to get the dma info from the desc. And hardening
      the dma unmap is safe, we should store the dma info of indirect
      descs when the virtio core does not store the bufer dma info.

      The follow patches to this:
         * virtio_ring: packed: structure the indirect desc table
         * virtio_ring: split: structure the indirect desc table

    - On the other side, in the umap handle, we mix the indirect descs with
      other descs. That make things too complex. I found if we we distinguish
      the descs with VRING_DESC_F_INDIRECT before unmap, thing will be clearer.

      The follow patches do this.
         * virtio_ring: packed: remove double check of the unmap ops
         * virtio_ring: split: structure the indirect desc table

2. make the virtio core to enable premapped mode by find_vqs() params
    - Because the find_vqs() will try to allocate memory for the dma info.
      If we set the premapped mode after find_vqs() and release the
      dma info, that is odd.


Please review.

Thanks

v5:
    1. use the existing structure to replace vring_split_desc_indir

v4:
    1. virtio-net xmit queue does not enable premapped mode by default

v3:
    1. fix the conflict with the vp_modern_create_avq().

v2:
    1. change the dma item of virtio-net, every item have MAX_SKB_FRAGS + 2 addr + len pairs.
    2. introduce virtnet_sq_free_stats for __free_old_xmit

v1:
    1. rename transport_vq_config to vq_transport_config
    2. virtio-net set dma meta number to (ring-size + 1)(MAX_SKB_FRGAS +2)
    3. introduce virtqueue_dma_map_sg_attrs
    4. separate vring_create_virtqueue to an independent commit


Xuan Zhuo (10):
  virtio_ring: introduce vring_need_unmap_buffer
  virtio_ring: packed: remove double check of the unmap ops
  virtio_ring: packed: structure the indirect desc table
  virtio_ring: split: remove double check of the unmap ops
  virtio_ring: split: structure the indirect desc table
  virtio_ring: no store dma info when unmap is not needed
  virtio: find_vqs: add new parameter premapped
  virtio_ring: export premapped to driver by struct virtqueue
  virtio_net: set premapped mode by find_vqs()
  virtio_ring: virtqueue_set_dma_premapped support disable

 drivers/net/virtio_net.c      |  57 +++--
 drivers/virtio/virtio_ring.c  | 430 +++++++++++++++++++++-------------
 include/linux/virtio.h        |   3 +-
 include/linux/virtio_config.h |  17 +-
 4 files changed, 301 insertions(+), 206 deletions(-)

--
2.32.0.3.g01195cf9f


