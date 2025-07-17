Return-Path: <netdev+bounces-207784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50386B088DC
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50B83B39D7
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDFB2980B2;
	Thu, 17 Jul 2025 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otEWzRLD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124C288C33;
	Thu, 17 Jul 2025 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742907; cv=none; b=oy2exyqj6uLMG5MXiax0QjEQDk46mNpVEmFan59QosQq5lSKturVliDxII/omvuiaq9I1CCkKW1CMyo9Za6+9CI6znEhZtaSLMz7UQLjYqwj51kNKR3Hvp90jCo12/lpDrkeCKmPQNSAMp6zitXf6TuA8/LIgczvxEXD1adg7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742907; c=relaxed/simple;
	bh=tWBft60ygd6gngCGX7mXJTwPqVkgMB4+83ojVoEpFi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RphxDmKvjpTXrMX8mbaMvrJItOpyjtOO1Z2XWcbM7lhSVJ9F0dViGv2AJLqMMgbBcHW0YbVvCsqzcrI8Azr0Zw/w5FBsN+LoaJ4iPgTTxGfQq4Dn9kG+42Oh+EjIPCpAl4G0v5yktxP1scubErnj1I6X+S8f0LjMrBWSL/3POKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otEWzRLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D6EC4CEEB;
	Thu, 17 Jul 2025 09:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752742907;
	bh=tWBft60ygd6gngCGX7mXJTwPqVkgMB4+83ojVoEpFi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=otEWzRLDXZQDwtPujyy82OfLxmGjrLjC4FO/Rlnbv635mdYQDGAMI/SCK6Jj8YQ7d
	 RLbzarPAfVcKj2a5cdBHr8YIit2NL1tQeXaxA2nDGyFB0InH09R7uR1dzX0TkfXnBQ
	 JYILx+mgkkn0LFsrQWpTbhUfFDzD86QXUZUwP+HDyTMyAbcjUdk0A/XPpuHYjdIg6V
	 Kxz9jJalT5vJtS/EDmfhGvvBOL1dfj99VV8017J557CS1yqpgom3AW6jphlzoQJ4a7
	 17MRJx/X9mJNDkEA0AutRhlG4khnaNLGdget1zCx4ftD4O0hF+5bFtE/GV7oEwDxd9
	 1JV/LVgNi+F7w==
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
Subject: [PATCH v4 9/9] vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
Date: Thu, 17 Jul 2025 10:01:16 +0100
Message-Id: <20250717090116.11987-10-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717090116.11987-1-will@kernel.org>
References: <20250717090116.11987-1-will@kernel.org>
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
fragments. Note that this affects both the vhost and virtio transports.

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


