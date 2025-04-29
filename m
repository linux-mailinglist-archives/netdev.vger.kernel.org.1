Return-Path: <netdev+bounces-186797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8605DAA11C6
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160B31B658A3
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7D6243364;
	Tue, 29 Apr 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q32lQCkF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD43242D6E;
	Tue, 29 Apr 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945006; cv=none; b=KNV0GHq9ZKXxOrBMKnetuFAhOhKME29cJpP5txBIg2H5eI3TGnJa2e6kecC4G6h0wjLAVXCk6rMBwZjk6UiugvR4ECgPN9LRxXcaXk2ocnl7BcaHpT/OlSNCIq2cgDl7kTJ1C/PCcz5uhXCKXxvbbvUc3nNJE4r6uHs+OA3xNzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945006; c=relaxed/simple;
	bh=v4HYRW3IdUqTT2QWf/d9Tt5mMI3zidThP9+8m01Fppc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WmTv2x1AUeXbhh2YgvLdrnbukkMHeQgFPzQlIfPN017UK0bWvXwbRdzVsMh/PZAvriWKw9aGOgJn/+3nu3lub4UhZmDTXegs77Kmy8JTIgY2cEWZW/ldte+VreNvxpkNcDHZcdaz12ZGeToAVSB2XwcnQSN8z1VS3N0/XMUlXc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q32lQCkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEABC4CEE3;
	Tue, 29 Apr 2025 16:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745945006;
	bh=v4HYRW3IdUqTT2QWf/d9Tt5mMI3zidThP9+8m01Fppc=;
	h=From:To:Cc:Subject:Date:From;
	b=q32lQCkFNSkYeE2Pyl+ZWmnc95ZLWQ2abEqGokSsfHwhlwSEmhvRIgWIO7xm144ff
	 /nokDyZx1nnXW378xCZAhlxEVsP0Ls3BhPNRWk+AtWDVb+F4wtGsu67IkRDr8+ogDf
	 VYJ015xR2haIikjqbNZg0TKtCO7sMnLk+SY7YkZHU4+H02tFd11F7tzcO+fNLIsmh4
	 N6NJkdEIdlw5aDu1v+UmDlQm8fITG9UVX9mdcnKZZ573Su1qcFVn549TUcM7AbdnDS
	 POZ6USkiv0nSNrfSQlKNT5Rv6v/kYmY1fuhix4cS5J8HUsqfQBzP1dv+pjkEPQUHP/
	 ier68dPLY3w/Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	virtualization@lists.linux.dev,
	minhquangbui99@gmail.com
Subject: [PATCH net] virtio-net: free xsk_buffs on error in virtnet_xsk_pool_enable()
Date: Tue, 29 Apr 2025 09:43:23 -0700
Message-ID: <20250429164323.2637891-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The selftests added to our CI by Bui Quang Minh recently reveals
that there is a mem leak on the error path of virtnet_xsk_pool_enable():

unreferenced object 0xffff88800a68a000 (size 2048):
  comm "xdp_helper", pid 318, jiffies 4294692778
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    __kvmalloc_node_noprof+0x402/0x570
    virtnet_xsk_pool_enable+0x293/0x6a0 (drivers/net/virtio_net.c:5882)
    xp_assign_dev+0x369/0x670 (net/xdp/xsk_buff_pool.c:226)
    xsk_bind+0x6a5/0x1ae0
    __sys_bind+0x15e/0x230
    __x64_sys_bind+0x72/0xb0
    do_syscall_64+0xc1/0x1d0
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: e9f3962441c0 ("virtio_net: xsk: rx: support fill with xsk buffer")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: mst@redhat.com
CC: jasowang@redhat.com
CC: xuanzhuo@linux.alibaba.com
CC: eperezma@redhat.com
CC: hawk@kernel.org
CC: john.fastabend@gmail.com
CC: virtualization@lists.linux.dev
CC: minhquangbui99@gmail.com
---
 drivers/net/virtio_net.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 848fab51dfa1..a3d4e666c2a0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5886,7 +5886,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	hdr_dma = virtqueue_dma_map_single_attrs(sq->vq, &xsk_hdr, vi->hdr_len,
 						 DMA_TO_DEVICE, 0);
 	if (virtqueue_dma_mapping_error(sq->vq, hdr_dma))
-		return -ENOMEM;
+		goto err_free_buffs;
 
 	err = xsk_pool_dma_map(pool, dma_dev, 0);
 	if (err)
@@ -5914,6 +5914,8 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 err_xsk_map:
 	virtqueue_dma_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
 					 DMA_TO_DEVICE, 0);
+err_free_buffs:
+	kvfree(rq->xsk_buffs);
 	return err;
 }
 
-- 
2.49.0


