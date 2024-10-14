Return-Path: <netdev+bounces-135023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20A99BE08
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 05:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414381C20EFB
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 03:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9983B57C8E;
	Mon, 14 Oct 2024 03:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h8twCrAV"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59A43ACB
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 03:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728875565; cv=none; b=porUX57eVzJDp3rvpFYTBt8ad/2mF9UkLxvtsmywlLb5MdCNEMsz/qBWWc1fdQegiTxvl+dxBTSA5j2LYROxdV24QIClLSEy5fv2phy9qBmEC/Zl0bknIxVGIVLsr3Dz5s3+ZHfP5JYO1IkMoeBxEu83qs9hZrOwSe3C4UIK0zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728875565; c=relaxed/simple;
	bh=9Yrh2Vjow15ezj1gKMnRRLy5ct9UaH0gpmCz2JfuK+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MkitcXr//GcS6PuVMaA0qPnOZ7cLF0y0CGpBxQ55XVrbUTVBuFefTd6NWV7i0orqTx5K7ROqREkD/03wOqIPFINUT5pwebFf+3ieXOjDdutUqyl/leMU9xvzarn1icOD4c3D+EPH0zsJyTCzcyTHncea4wEnab8936F81nnz1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h8twCrAV; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728875555; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gaop84a8mzYbIuzv4fvPhmp2O3iiUfbkV9o+jY53Xcc=;
	b=h8twCrAVAIa511L81FyYU1evc0k76nJB25MZH58E5O60vjyQ/QzKkl5Y81Hxy/RW+bz+tIFEFSvKJq1VK3u6FZVeC7MTV92YWeRHm5H9lx6FrHFQqdNotbgwMOVB+Wj0qjbEkULPsYstUl1eYIAtDu5vx3gnznK+2RJDF/E2mC8=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WH.FFkV_1728875554 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 11:12:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 0/5] virtio_net: enable premapped mode by default
Date: Mon, 14 Oct 2024 11:12:29 +0800
Message-Id: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: bba499faae26
Content-Transfer-Encoding: 8bit

In the last linux version, we disabled this feature to fix the
regress[1].

The patch set is try to fix the problem and re-enable it.

More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com

Thanks.

[1]: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com

Xuan Zhuo (5):
  virtio-net: fix overflow inside virtnet_rq_alloc
  virtio_net: introduce vi->mode
  virtio_net: big mode skip the unmap check
  virtio_net: enable premapped mode for merge and small by default
  virtio_net: rx remove premapped failover code

 drivers/net/virtio_net.c | 168 ++++++++++++++++++++++++---------------
 1 file changed, 105 insertions(+), 63 deletions(-)

--
2.32.0.3.g01195cf9f


