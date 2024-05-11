Return-Path: <netdev+bounces-95669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D298C2F42
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 05:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381771C211AD
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 03:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ABF3F8F7;
	Sat, 11 May 2024 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ECGNnmI/"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627153716D
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 03:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715397256; cv=none; b=h+gWcq7MR6oWPcAptEAIDK1vzDGVHAfT9BU2TxY89qv4vPilIdL6EFKDG4HFAc+ySuLFjZcfJBvetjCniyFlHh+4LogtnYKFdyx8KoLZDRK3HVYaf2lSzEZt/KZLeUZ+3Zg43nFs8ZcixTH7M9yFT1A9PB4nHZWbObyiPJPfdJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715397256; c=relaxed/simple;
	bh=CcDkkWan88A1XCr91ZzWcpyz3A8ByzYbE5eLB9/o77M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JQrKshPQkG2R443pmCLrahtOLDTsHK12wN7M0L6itmKRrn1p9tw52/Du/u9e5qJYPwXm7PzE2X/MsY1Dkai/qQDl4aVcF5LTEweZBJoTLLrNthV49SaISp9cC1x1IsTH7FUvFHwIeH4/hG72JuhXNL1X+ieZ6/7uaBH2cOya7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ECGNnmI/; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715397246; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=htoVDchsx8815IcYZrFv1YVXLA73nTjibEg1V5cgDGs=;
	b=ECGNnmI/6qYflpc9pkTPud0AU8STwEIAzCYiBjhT/xzyv9X/QsgEEQx2DrKi0cywY/QU1cyX3u/+IN2/G8PvRSgNaPZKhYUvS6STtorkwInc+8zfhwNLN2XWyCuKGeYXr6amSh29RQd5obfLvaDRoTP4wOnsL0YgB+8CWSwc7/Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W6BzGt5_1715397244;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W6BzGt5_1715397244)
          by smtp.aliyun-inc.com;
          Sat, 11 May 2024 11:14:05 +0800
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
Subject: [PATCH net-next v5 0/4] virtio_net: rx enable premapped mode by default
Date: Sat, 11 May 2024 11:14:00 +0800
Message-Id: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: e1ef52e80115
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

v5: 1. Fix the comments from @Larysa Zaremba
        http://lore.kernel.org/all/20240508063718.69806-1-xuanzhuo@linux.alibaba.com

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


