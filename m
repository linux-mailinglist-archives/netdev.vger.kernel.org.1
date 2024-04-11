Return-Path: <netdev+bounces-86828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 181728A062A
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 04:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC281F2538B
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F35F13B2B4;
	Thu, 11 Apr 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vI2C5hAd"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840CE5F870
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803893; cv=none; b=aW7c9PQuXhBruC8mBRH4RemN1YF/1fEQzk6p+SmryrrMtkr7VRdn0hGtj/r9wXpRTfAbeeIACy15P10aI9M4raKRDJI8bRmZwWpTKDsMmGWXrGzIqEsKULYFDwXjTUqGqVbPUi9xm6zB1w2uMCSPziyn7pRlHHNKIyalB1SYF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803893; c=relaxed/simple;
	bh=9Irr4zllPp0JGg+cpzSFxL3Rj5pz8tp0bd+xkGpnl1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E5zwM5k//CGi7XTCF5/e9m8x8EhASE3aoBJ0DOt2+szF59omb8ryvXVU7THoGMwzIelfCl1dKncTW4q5+zEVDj50IsRiDm6eEikFTeTtBunGNKE1GJy1HgyjrUTKT5/Q+cTq/vTpL4Njt9QsFma7U96PxthcpfDh9pms+yp/yKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vI2C5hAd; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712803888; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=iMiyojIQf+nzC637PiG8Hcf5B124m+eXDgPjrAOzIuw=;
	b=vI2C5hAdNX/D6qrs7OYOByBmfK8c3Kq3Ijkhi2be9IhOutczdGNnG5SDFV2/8RNd74f1Tn6IdTEwz+TYmwY73I4sPFYRzMYIVfjmsgmg7q4l9ewmp7XotEjNKq6TBaU7pnQJxG6MJtxi1IO4370ce0XS9Pw/3wbpmx45/GKiwCQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4JPo7i_1712803887;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4JPo7i_1712803887)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 10:51:27 +0800
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
Subject: [PATCH vhost 0/6] virtio_net: rx enable premapped mode by default
Date: Thu, 11 Apr 2024 10:51:21 +0800
Message-Id: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: aa9dfb80fb4a
Content-Transfer-Encoding: 8bit

Actually, for the virtio drivers, we can enable premapped mode whatever
the value of use_dma_api. Because we provide the virtio dma apis.
So the driver can enable premapped mode unconditionally.

This patch set makes the big mode of virtio-net to support premapped mode.
And enable premapped mode for rx by default.

Please review.

Thanks.

Xuan Zhuo (6):
  virtio_ring: introduce dma map api for page
  virtio_ring: enable premapped mode whatever use_dma_api
  virtio_net: replace private by pp struct inside page
  virtio_net: big mode support premapped
  virtio_net: enable premapped by default
  virtio_net: rx remove premapped failover code

 drivers/net/virtio_net.c     | 213 ++++++++++++++++++++++-------------
 drivers/virtio/virtio_ring.c |  59 +++++++++-
 include/linux/virtio.h       |   7 ++
 3 files changed, 192 insertions(+), 87 deletions(-)

--
2.32.0.3.g01195cf9f


