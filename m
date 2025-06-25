Return-Path: <netdev+bounces-201148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805DAE845B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DADA188CCB6
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288AB2690EC;
	Wed, 25 Jun 2025 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6clDI6u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15CB2690D9;
	Wed, 25 Jun 2025 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857365; cv=none; b=iFokQ1YvSMl6V9gttmuJZeDl83Cx63hNH3o8gMouTdY+Bu8SfBWQ15kuZ7UaB5BLl9X4Zpb7jWLB75yEdmL75tcbOBXohhXYuK/Buzal+ZxWbe3Y7AQlQgGTshxouN+Bjn0oOWrWbymR400Nh6jWEuludWvBGckyo8h3BQaKzl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857365; c=relaxed/simple;
	bh=47+rWBkW5T9ldh2nVz1QhH5OlPRIa49bdi0RnHpxrJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NO8nAOGEKQDu0bceynWwdwBPIu8fe06CGZJ6ZKUC9soAbvVaA+KTa/2Kp08oS9Kgo9Y9BbFaReD8cbJOrpeI17RralN/AYVlGgYnuITXcyNKsbndJIDOzwT3Gbo1ilnlXqihNj3+rktSGtR+UjDLkAHx16KNb0xzJs8HygONMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6clDI6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56660C4CEEA;
	Wed, 25 Jun 2025 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750857364;
	bh=47+rWBkW5T9ldh2nVz1QhH5OlPRIa49bdi0RnHpxrJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6clDI6uglgTscVNsSEyVq1VgDkkZSq6qTwx3X58T2ENqGSO780wRagTtNexP10OT
	 Bq9EjQt8y64thrAPRiVzE9sfYWDRn/oM0ad4UXLvHT/D3c8k1wXgKIuLQ6pf8f35ss
	 iZTEs8Dn6hHacrecfqwn6vy5Qnlg10cZUiKoyAKrj4M0tU/f+GNJxds6VHaZc6odvS
	 Xvh+vNqsZs2OInTtrsMSu47g+AZiWGA0O+dk9baAdPKDpmfpPcXh9ScHTXKt6tSmc2
	 Cst3A920d4vuz3GMA973XkbaKzTPmqCqWPqKjBsu0fvOp29pA6MvSiMLJSgJek6u0j
	 FdBxwEpDWQnPg==
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
Subject: [PATCH 5/5] vhost/vsock: Allocate nonlinear SKBs for handling large transmit buffers
Date: Wed, 25 Jun 2025 14:15:43 +0100
Message-Id: <20250625131543.5155-6-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250625131543.5155-1-will@kernel.org>
References: <20250625131543.5155-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
virtio_transport_alloc_skb() to allocate and fill SKBs with the transmit
data. Unfortunately, these are always linear allocations and can
therefore result in significant pressure on kmalloc() considering that
the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
allocation for each packet.

Rework the vsock SKB allocation so that, for sizes with page order
greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
instead with the packet header in the SKB and the transmit data in the
fragments.

Signed-off-by: Will Deacon <will@kernel.org>
---
 net/vmw_vsock/virtio_transport_common.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1b5d9896edae..424eb69e84f9 100644
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
@@ -261,7 +262,11 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 	if (!zcopy)
 		skb_len += payload_len;
 
-	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
+	if (skb_len > SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
+		skb = virtio_vsock_alloc_skb_with_frags(skb_len, GFP_KERNEL);
+	else
+		skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
+
 	if (!skb)
 		return NULL;
 
-- 
2.50.0.714.g196bf9f422-goog


