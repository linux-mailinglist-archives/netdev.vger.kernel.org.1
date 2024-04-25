Return-Path: <netdev+bounces-91302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C698B2219
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 14:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77921F24305
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720EB1494D8;
	Thu, 25 Apr 2024 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XeCLN6ul"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C91494C9
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049942; cv=none; b=FM1r1LKE2fWhpUz7+lYKSKAn+ig9/o1UiSNXTmfUyxuuSrknsP5R2pKOhKOuF0XD/quWDSrOmKd5GcDK9TqdzliZVyJwSW7R+m/j6T4ZTPT+QDVxsYKCxrR/uLOLx588ihmCA865IHnX2DnXxtftxHPw3h6q5dqIFwX1yKRTzb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049942; c=relaxed/simple;
	bh=tyVjat1rjW2MAao+7FrJyWEzcCabOzU4xQ5JCwwV9uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QeS6qKs31Riukpiy9QfZg5WC244cZ1px9T+BOjYUiqLZCv+Bc15mMpDektdZyFl7qrqWMMXnyvrlBzswnRvELsbLQD7IK33hobbpf0qJfpxJuQXC7ZVwqzreTke6JwYwsoWjp6UYQvE/b202YmcPZCmyLnWWeuR8iDZD2Ysbzpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XeCLN6ul; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714049937; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=WLs6Yn5APuAIgojgCyiuTy7J9kuBh6CD/M/N8iA90a0=;
	b=XeCLN6uldvpUkndUBP5VNjRkyD/bDrrH0Oy6vpbQGiok40GLieJ3OKoccypFZgaBI/Ltxmr5WPy5FWKtXapxiOgHSRDQ/1yB5DK4PkOQPcPIgiR0GfBCJtblGzCDBHs2woNPRcYh1WKY6l/mco3uRRSKN/oh/BTFX5brfcT0WAE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014016;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5FRGNX_1714049935;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5FRGNX_1714049935)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 20:58:56 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/3] virtio_net: enable the irq for ctrlq
Date: Thu, 25 Apr 2024 20:58:52 +0800
Message-Id: <20240425125855.87025-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ctrlq in polling mode may cause the virtual machine to hang and
occupy additional CPU resources. Enabling the irq for ctrlq
alleviates this problem and allows commands to be requested
concurrently.

This patch set is on top of
https://lore.kernel.org/all/20240423035746.699466-1-danielj@nvidia.com/ ,
so patchwork may cause warnings.

Heng Qi (3):
  virtio_net: enable irq for the control vq
  virtio_net: fix possible dim status unrecoverable
  virtio_net: improve dim command request efficiency

 drivers/net/virtio_net.c | 268 +++++++++++++++++++++++++++++++++++----
 1 file changed, 240 insertions(+), 28 deletions(-)

-- 
2.32.0.3.g01195cf9f


