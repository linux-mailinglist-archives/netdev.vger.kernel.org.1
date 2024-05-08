Return-Path: <netdev+bounces-94411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF8C8BF658
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1249B211C4
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 06:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B377A94D;
	Wed,  8 May 2024 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U3CdjCXj"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89EA182C5
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 06:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150245; cv=none; b=JqxF7W/hVfJrf5D83SGxfNS5ofIOTdhOLZ66pRGcgCGls+cwV1vRZ+kLkbPY1AdOgHTym+a7N28CAoVNxVjIJ6uUxx2mZC0kn7311VeFrbJs3D02lgxnmGIpjgAd4wR2GvRk0kbhOMEJu97oD/+QYqVI9Gi5cWFZdYTWiG6nE6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150245; c=relaxed/simple;
	bh=lfQ98rSdtELe0s93PdWvn+1kLbAPyOnDhSjMuXZVjhU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IJqRcImb7Qoux08flMf2XkMV23W4siMDsIEsN/M4sllPFk2bPxWVoBbzOb0cK3OCLU8acOfIVSSoLtVjnotXv5aWsfF8jQBxMv1lRsb99VOFfu+SnLKwMiQtXxXmfF1F52OSl2muCD4VYIdmzaoACIfz1A8rkvXnaMtRVkq4hOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U3CdjCXj; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715150240; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IlnRCma/l3j1KcDF+G4YXH3HV1fmi4HSz0rum4rbgrI=;
	b=U3CdjCXjLZDaHZ1LvJEXAv4zHYlIPSDk8iHrz3lPPcTaltxmgfrLMs2kG61y8aO4rqx5PIC6J4QQws0rv4Q6FHOGzx5B/JSiwneLQHXHl5XRnHGfOcyntvHIL4+W3LqJDLFUGZ7ZT3BQXGjy9HDe20siLLw/rZwON5ez1FPII0Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W62Y4ts_1715150238;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W62Y4ts_1715150238)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 14:37:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next v4 0/4] virtio_net: rx enable premapped mode by default
Date: Wed,  8 May 2024 14:37:14 +0800
Message-Id: <20240508063718.69806-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: cadd21343bbc
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

v4:
    1. For the conflict, switch to the net-next branch

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


