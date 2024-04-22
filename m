Return-Path: <netdev+bounces-89908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5A08AC2A2
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 03:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636081F21231
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 01:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550B5DF49;
	Mon, 22 Apr 2024 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JuhPcqjK"
X-Original-To: netdev@vger.kernel.org
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D025746E
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713750864; cv=none; b=LfZ/Fvt3tjBwB/0o+us12kbdarquO57fwK+/aoe/yDXbAXjE9VAg/jt7pLWEBp52JzQMu3w6B5IFRb7jm+yOg30Oq4FkswFrSmFfoKMROIURQMOdRyEuaUxNNY1W9nemDHbCZnMvcXrSjHz+4kfVYlNDKESx3xlU2Sh0uiZU2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713750864; c=relaxed/simple;
	bh=ZSd37NZmwRJpjHAS9ajLmdk+WDKEomc1d5hGfAfOCQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dvD9+u5xbQysDr9zw8PbAGuL5lMWBP7kDFrhwlbyLg6nI82G8ynY4TIY2yZG1mHJz3lDqE3FqIesTMTlZJzWyBfAd+x9/G/KZKCB5/aLywht/PWdKvnvRo6MLJiw4YO7UCL5Aoj2HICRuM8dTL/5pvMquOV9+BtSvl1YjSIGFxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JuhPcqjK; arc=none smtp.client-ip=47.90.199.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713750845; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=qfFyaumVlpjGsrE/xHi1bO0ootxsSU/JVlrBiwyRb2Y=;
	b=JuhPcqjK87pHvG4qtkoiwMHypo3F46cXD4p8+c/ouKKJFiJmstkMN3///MOIap/rQYylhDfMY+FnsWZtGa5YK2wZyY3Ve48YtReWu9iaEtpjQNb0CwJfLEUL85SSf2IzZ/rrmF3V5bNzqSJxZgpoq2SqOhhT3qL8Bp/1k1Y1agg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4y4sJ2_1713750843;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4y4sJ2_1713750843)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 09:54:04 +0800
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
Subject: [PATCH vhost v1 0/7] virtio_net: rx enable premapped mode by default
Date: Mon, 22 Apr 2024 09:53:56 +0800
Message-Id: <20240422015403.72526-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 2c089e81de7e
Content-Transfer-Encoding: 8bit

Actually, for the virtio drivers, we can enable premapped mode whatever
the value of use_dma_api. Because we provide the virtio dma apis.
So the driver can enable premapped mode unconditionally.

This patch set makes the big mode of virtio-net to support premapped mode.
And enable premapped mode for rx by default.

Based on the following points, we do not use page pool to manage these
    pages:

    1. virtio-net uses the DMA APIs wrapped by virtio core. Therefore,
       we can only prevent the page pool from performing DMA operations, and
       let the driver perform DMA operations on the allocated pages.
    2. But when the page pool releases the page, we have no chance to
       execute dma unmap.
    3. A solution to #2 is to execute dma unmap every time before putting
       the page back to the page pool. (This is actually a waste, we don't
       execute unmap so frequently.)
    4. But there is another problem, we still need to use page.dma_addr to
       save the dma address. Using page.dma_addr while using page pool is
       unsafe behavior.

    More:
        https://lore.kernel.org/all/CACGkMEu=Aok9z2imB_c5qVuujSh=vjj1kx12fy9N7hqyi+M5Ow@mail.gmail.com/

Please review.


v1:
    1. discussed for using page pool
    2. use dma sync to replace the unmap for the first page

Thanks.


Xuan Zhuo (7):
  virtio_ring: introduce dma map api for page
  virtio_ring: enable premapped mode whatever use_dma_api
  virtio_net: replace private by pp struct inside page
  virtio_net: big mode support premapped
  virtio_net: enable premapped by default
  virtio_net: rx remove premapped failover code
  virtio_net: remove the misleading comment

 drivers/net/virtio_net.c     | 243 +++++++++++++++++++++++------------
 drivers/virtio/virtio_ring.c |  59 ++++++++-
 include/linux/virtio.h       |   7 +
 3 files changed, 222 insertions(+), 87 deletions(-)

--
2.32.0.3.g01195cf9f


