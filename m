Return-Path: <netdev+bounces-202988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42D1AF009A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE81D166BE1
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705D4286409;
	Tue,  1 Jul 2025 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eR9QmGzH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B501F428F;
	Tue,  1 Jul 2025 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388337; cv=none; b=k/jN6hw/BSQHNKX6SzfQ64/HlwpRYQVQNGCi2s1Vq3dDxOITewe3LF8kekG24nQhe9IZJGXbKRCzdyM0E1O+vYS1cjugrRlArM3jQ0scJfsvxt7SagQY+uTNNwur67XDvOYFkY5DVqkgsPHwZR78WsnIWxb9GJVpyboHo9fN6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388337; c=relaxed/simple;
	bh=rxWh8Ki7CjYyO7eLldQromF2K92SNjwMD3JOw4J+aS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=raL2s83e0URX9cx5aoVzIahOrHjMuKbIvqKpqEHrvGZRIgy/f7EItclu4MMmeMEj1adMUWQ6K7VkBeMxFyGpveEGt+QKHUnNzCYimP+rlG/HKzqEAPb5NOQ5HrDXSjTb8pdhzL6HdHnYBUF84dlbPBenqfqfistUCaYnNat1Tzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eR9QmGzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E886CC4CEEB;
	Tue,  1 Jul 2025 16:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751388337;
	bh=rxWh8Ki7CjYyO7eLldQromF2K92SNjwMD3JOw4J+aS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eR9QmGzHQTPJOUXHscZaXBiFkTMBbyTzR7G/sBld7Ic9V60jXRqf0m5M5vMZ7wnKU
	 cGnWMNe+NAuvcs/Xk4dPNlNxSMBH3BBY6cXSO+ztptHOI/AsT9DSr4gJoHjC3wMhir
	 2uaEB2a2bLz6mV6zgTIDZ3pw2vIIv6qKD5oQynQ3S10ZaACE8f92q/ulo0Sd06tT9k
	 SXMkoKdYpgENjdYG+qf2++gTzhJDr5lvHbFli5S/CY4yOZvuRF5Ri2kb8EhxdW2aYu
	 Zc+a9cnrZl0qcGQ5/FXC4PTEFttpitUVXiV/QT5tVh/P2frGhVHvT65AWOfKc3sFG2
	 qOifKOFuNz3ng==
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
Subject: [PATCH v2 8/8] vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
Date: Tue,  1 Jul 2025 17:45:07 +0100
Message-Id: <20250701164507.14883-9-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701164507.14883-1-will@kernel.org>
References: <20250701164507.14883-1-will@kernel.org>
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

Signed-off-by: Will Deacon <will@kernel.org>
---
 net/vmw_vsock/virtio_transport_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index c9eb7f7ac00d..f74677c3511e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -109,7 +109,8 @@ static int virtio_transport_fill_skb(struct sk_buff *skb,
 		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
 					       &info->msg->msg_iter, len, NULL);
 
-	return memcpy_from_msg(skb_put(skb, len), info->msg, len);
+	virtio_vsock_skb_put(skb);
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


