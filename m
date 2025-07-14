Return-Path: <netdev+bounces-206731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BE8B043D6
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEC01886DAE
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6178E26AA94;
	Mon, 14 Jul 2025 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/Dg0YK7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A122690CB;
	Mon, 14 Jul 2025 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506497; cv=none; b=QdxxpdfsJKA3H6chc9vkuG7mkhJGGfNnrNdXjhGMU06zCok7yum05sjdSFHIp3gMagkWlh1XTCuBopC5+FJ883CGSmhX2fOtzW6LtNoSh34RyBCDwiC4dTMs38p7oV1OV6xSdfPpRR4QuWHU33zICpWQgYkhJ0JbPlIqyQnNmRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506497; c=relaxed/simple;
	bh=VC+ApeBCzBvySjxO+5RtrC8kfJb3G3Dm+10WW4fjuOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gAl1No+sjWhW4c9bdzbz+Aq74jy96hAyXpzvnGrXW1RNVKJEl1xllWzgIJ/eXaaPO1iRMbvBZae5patZfwgrpQUMIssNYTrelkrCBYuIW3o/npdUjx4FDCWYFnlc7xnFuCCCXajns/jX9iZ2ewsMim5fdaVVW+Ldy7jL+5eJaq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/Dg0YK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD69C4CEED;
	Mon, 14 Jul 2025 15:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506496;
	bh=VC+ApeBCzBvySjxO+5RtrC8kfJb3G3Dm+10WW4fjuOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/Dg0YK7VVpqlxi6jGzlQbBi0jkqGeBzsmhRp1bJpie+mZwa3XqOK5DalJAe79gbz
	 +j1CVnIbRPSBmiH3eXf3tLNU73P/liN+4BOw57lL5vBvzp5hW7l2NqTvsa3uxu8Dom
	 BO0Zg1qETSn9Ey2PnIdGjliDesuWY5TMILr5d1iN7MuVN3Xl+Yuv01EOhH4xq0Py0P
	 dyBycMNqcVPGBBk+G/1WyD+J+ZBYBBiwBUnlK6B6nUttCkOH8Kj8Pgp+i9odAEnbCu
	 lEyhXHs4GiXhvdju1bP3NqLieqZjm/oeHjh1+nVQKOm8a/Z2c7u9TT40erRrbSt//y
	 OyQYwtGONWCag==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 9/9] vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
Date: Mon, 14 Jul 2025 16:21:03 +0100
Message-Id: <20250714152103.6949-10-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250714152103.6949-1-will@kernel.org>
References: <20250714152103.6949-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
virtio_transport_alloc_linear_skb() to allocate and fill SKBs with the
transmit data. Unfortunately, these are always linear allocations and
can therefore result in significant pressure on kmalloc() considering
that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
allocation for each packet.

Rework the vsock SKB allocation so that, for sizes with page order
greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
instead with the packet header in the SKB and the transmit data in the
fragments. No that this affects both the vhost and virtio transports.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 net/vmw_vsock/virtio_transport_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index c9eb7f7ac00d..fe92e5fa95b4 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -109,7 +109,8 @@ static int virtio_transport_fill_skb(struct sk_buff *skb,
 		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
 					       &info->msg->msg_iter, len, NULL);
 
-	return memcpy_from_msg(skb_put(skb, len), info->msg, len);
+	virtio_vsock_skb_put(skb, len);
+	return skb_copy_datagram_from_iter(skb, 0, &info->msg->msg_iter, len);
 }
 
 static void virtio_transport_init_hdr(struct sk_buff *skb,
@@ -261,7 +262,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 	if (!zcopy)
 		skb_len += payload_len;
 
-	skb = virtio_vsock_alloc_linear_skb(skb_len, GFP_KERNEL);
+	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
 	if (!skb)
 		return NULL;
 
-- 
2.50.0.727.gbf7dc18ff4-goog


