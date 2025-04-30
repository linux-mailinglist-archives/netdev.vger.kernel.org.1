Return-Path: <netdev+bounces-187125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5B2AA51C7
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 18:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DC1F7AB844
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0F62609FA;
	Wed, 30 Apr 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+nJPxvK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A72609CB;
	Wed, 30 Apr 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031120; cv=none; b=ojagNVH6V0xDoIvRQNBnF7MqpD9TH95eNv2kJEBxSo068SnBj/thgntrQkMSo1h4AnqT/Z394xtGoAyRZ17Wc6g8aiCJW9ZzvWHvWzeLlXITetealHKmFcvL5zj9n9encURcSqNYC7zgWuwxwLn6iAzwFpP5VmAXbVIxE1lc07U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031120; c=relaxed/simple;
	bh=sTUHXrpvWbBmLoVSvQCq6iPznegP/mPeO9mAVlWZ1kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pys/gW8ubqDxq0WOHI5y1w+EXt1iZXeFipJF+EuU53nQYCeXjZCotOhTbcadcpqysFZuCymEVAsiP1d0HXES9brJB5fBkYnLp+XP2dA0tJbCQP8pPsS0cWGJTLiKH0IfAOSA6/h855/Di2JsF70aZ3p4EXxqyXceovFOvxuKLx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+nJPxvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4D7C4CEE7;
	Wed, 30 Apr 2025 16:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746031119;
	bh=sTUHXrpvWbBmLoVSvQCq6iPznegP/mPeO9mAVlWZ1kw=;
	h=From:To:Cc:Subject:Date:From;
	b=Z+nJPxvKgMChoR0FLK79zGQeL/3sOLIrIAECg1z4BB+0WFoIUNctuiJxdyjAaPoc3
	 o8lb1E2Ij1AqpxAZu63v47EzhcdyJPqrmWPQBIxBiiADwRsyoPFBVoPXoP3UkO+4Rw
	 EeMGVR5nNxEaZxUqne1/c5mqbl3ZYVBoBoJW54lKLSmLYLSFgABkoFvl5RcQSKtVDz
	 tDlYDWBjqNkv8ToJlvQ5kK25LZmyiBwdChyIthUzdeIDu9+j1vKawBsgMNzRATdhdw
	 cb8mJreqpaokaIQxR5uxvpgMVjN0oGT9/44bO4mSXqlj8WMFkdL8HOCdcz+/e3ThUw
	 XSwZtg+XB2mZg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	virtualization@lists.linux.dev,
	minhquangbui99@gmail.com
Subject: [PATCH net v2] virtio-net: free xsk_buffs on error in virtnet_xsk_pool_enable()
Date: Wed, 30 Apr 2025 09:38:36 -0700
Message-ID: <20250430163836.3029761-1-kuba@kernel.org>
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

Acked-by: Jason Wang <jasowang@redhat.com>
Fixes: e9f3962441c0 ("virtio_net: xsk: rx: support fill with xsk buffer")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - remember to set the err
v1: https://lore.kernel.org/20250429164323.2637891-1-kuba@kernel.org

CC: mst@redhat.com
CC: jasowang@redhat.com
CC: xuanzhuo@linux.alibaba.com
CC: eperezma@redhat.com
CC: hawk@kernel.org
CC: john.fastabend@gmail.com
CC: virtualization@lists.linux.dev
CC: minhquangbui99@gmail.com
---
 drivers/net/virtio_net.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 848fab51dfa1..c107916b685e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5885,8 +5885,10 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 
 	hdr_dma = virtqueue_dma_map_single_attrs(sq->vq, &xsk_hdr, vi->hdr_len,
 						 DMA_TO_DEVICE, 0);
-	if (virtqueue_dma_mapping_error(sq->vq, hdr_dma))
-		return -ENOMEM;
+	if (virtqueue_dma_mapping_error(sq->vq, hdr_dma)) {
+		err = -ENOMEM;
+		goto err_free_buffs;
+	}
 
 	err = xsk_pool_dma_map(pool, dma_dev, 0);
 	if (err)
@@ -5914,6 +5916,8 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 err_xsk_map:
 	virtqueue_dma_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
 					 DMA_TO_DEVICE, 0);
+err_free_buffs:
+	kvfree(rq->xsk_buffs);
 	return err;
 }
 
-- 
2.49.0


