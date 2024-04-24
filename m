Return-Path: <netdev+bounces-90803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739EF8B0402
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 10:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D450FB21D1C
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 08:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD65158855;
	Wed, 24 Apr 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gjjd6eKU"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728E1586FB
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946603; cv=none; b=VsuQApim2dudHtIzaMu4woCWe0MLaRezCIZyLbkns/dH3Gc8vClte3tiBj7zBTuaIvU6+3x0PikBOzI8I0L7+Ek5RC9X6Pu95pATNy3C09bpzL5Nv2EZSWYetXXwE+GXUWcoYoZeJkhHDgGxhR0q6emb5+r0T2loBLc5hi0NQRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946603; c=relaxed/simple;
	bh=h+HWLUrAW5e7xBsvzKTtlyoQXQ7HQM/LgpA6NCvHAtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CYzFfrvTEdlS0YQ5hEI9Q0nvj9anS0FCBc+ImMH6rblkOXKXhqxBNphg+/DTEpk7oDaqLmjJNr66nyA4fdvLRgFwn+9uopHIcTyMFtGY2xPtpsXZ2slZ7rKdZT6GD8dqzechOmZT6DkXsvOtmPmDwJlkkCqR5vhFjSF+WlaqHwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gjjd6eKU; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713946598; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7lHN09cekx6TYYRu7A9/mXzw2lcd+cr9qiKnNTZ3WYY=;
	b=gjjd6eKUpvd/bdsrR3KWM68LEhf1GlWHqpXy7hrkoFVpihHHnvLl31LuToFd/ByWQ+SbMOnDqMiA06NvcIfXXyhWtmNUSY0kYV9WjHC/MOW6vnAwQKhGNwIIngNe5p19Y+Hc3Tgjxh9qYfzb1FzTtPmrutpp5/2ngVGkw+spP58=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014016;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5BlXn6_1713946596;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5BlXn6_1713946596)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 16:16:37 +0800
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
Subject: [PATCH vhost v3 0/4] virtio_net: rx enable premapped mode by default
Date: Wed, 24 Apr 2024 16:16:32 +0800
Message-Id: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 55c7001bc45b
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
    5. And we need space the chain the pages submitted once to virtio core.

    More:
        https://lore.kernel.org/all/CACGkMEu=Aok9z2imB_c5qVuujSh=vjj1kx12fy9N7hqyi+M5Ow@mail.gmail.com/

Why we do not use the page space to store the dma?
    http://lore.kernel.org/all/CACGkMEuyeJ9mMgYnnB42=hw6umNuo=agn7VBqBqYPd7GN=+39Q@mail.gmail.com

Please review.

v3:
    1. big mode still use the mode that virtio core does the dma map/unmap

v2:
    1. make gcc happy in page_chain_get_dma()
        http://lore.kernel.org/all/202404221325.SX5ChRGP-lkp@intel.com

v1:
    1. discussed for using page pool
    2. use dma sync to replace the unmap for the first page

Thanks.




Xuan Zhuo (4):
  virtio_ring: enable premapped mode whatever use_dma_api
  virtio_net: big mode skip the unmap check
  virtio_net: rx remove premapped failover code
  virtio_net: remove the misleading comment

 drivers/net/virtio_net.c     | 90 +++++++++++++++---------------------
 drivers/virtio/virtio_ring.c |  7 +--
 2 files changed, 38 insertions(+), 59 deletions(-)

--
2.32.0.3.g01195cf9f


