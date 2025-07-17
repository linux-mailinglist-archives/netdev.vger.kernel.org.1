Return-Path: <netdev+bounces-207778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14314B088C4
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CDBB189D5DD
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C838228BABD;
	Thu, 17 Jul 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrIib8TX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9978528BA9C;
	Thu, 17 Jul 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742891; cv=none; b=MyGgCvGQU9mhN4pt3VzoHyxT5JZAz5G2DBmkhHk3kUJuDpHwIDsQX+VR86sKQjk26a6tjShQwm/Bhoy0hweOAIctDmweZziIXZJmuiv8VqjBbz2+M/hvbURJarzeJ0SmDiz7OOJ58yaWf+5EmBspyByerGk7DtXeB1omvToc4zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742891; c=relaxed/simple;
	bh=jGY71brbCxVnS7zG6bdYK5nYqAE6JIwRi73eOnclaeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XxPEvH8376WMF/NZNRoue32DACBs07gHz9dRSLeH0D7PMBu8V+OLnXXvQz34hKNKHLPMm1wnrseOolcf1VBGaC+WrgFdHC7fNZEV3ylMi1UV50dJk9vsD+edhduKfOxol/ry4TRS9nv/IhwboFwAVgzaWMpCEO5gpZIP8U61uO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrIib8TX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A541C4CEED;
	Thu, 17 Jul 2025 09:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752742891;
	bh=jGY71brbCxVnS7zG6bdYK5nYqAE6JIwRi73eOnclaeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrIib8TX64gvSL8fPYeug8DY7bXH1v3evjQ/EEOwOvPPt+D7M0xLW90RwDv/4Tk9k
	 lNi6SbrZg/Ueyib7I5B63HKu11Pz/m24tIzbR3UYhlNfbXszqrYAMuw/OOuQS6EX0r
	 ORCFo0QblHMdLeTumF03r146fH4UKo6C7KxUVwcnvGp80Bk5x1apU/Ne5KXTF71wa3
	 OBawlnw/sbl72EmvoPvk07ROAThBhuRPmMlckZFuMmza+vSJYaPWcelz9JQsUI3ikD
	 go7JUkxvKtOFCY5xXb/FGrFlqSEJQ7zJy2WMHCB4JoyPkVlX3A/O+IE1C7GgvP2zS6
	 6eR62UTY2MMjw==
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
Subject: [PATCH v4 3/9] vsock/virtio: Move length check to callers of virtio_vsock_skb_rx_put()
Date: Thu, 17 Jul 2025 10:01:10 +0100
Message-Id: <20250717090116.11987-4-will@kernel.org>
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

virtio_vsock_skb_rx_put() only calls skb_put() if the length in the
packet header is not zero even though skb_put() handles this case
gracefully.

Remove the functionally redundant check from virtio_vsock_skb_rx_put()
and, on the assumption that this is a worthwhile optimisation for
handling credit messages, augment the existing length checks in
virtio_transport_rx_work() to elide the call for zero-length payloads.
Since the callers all have the length, extend virtio_vsock_skb_rx_put()
to take it as an additional parameter rather than fish it back out of
the packet header.

Note that the vhost code already has similar logic in
vhost_vsock_alloc_skb().

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/vhost/vsock.c            | 2 +-
 include/linux/virtio_vsock.h     | 9 ++-------
 net/vmw_vsock/virtio_transport.c | 4 +++-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 66a0f060770e..4c4a642945eb 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -375,7 +375,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		return NULL;
 	}
 
-	virtio_vsock_skb_rx_put(skb);
+	virtio_vsock_skb_rx_put(skb, payload_len);
 
 	nbytes = copy_from_iter(skb->data, payload_len, &iov_iter);
 	if (nbytes != payload_len) {
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 36fb3edfa403..97465f378ade 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -47,14 +47,9 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
 	VIRTIO_VSOCK_SKB_CB(skb)->tap_delivered = false;
 }
 
-static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
+static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb, u32 len)
 {
-	u32 len;
-
-	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
-
-	if (len > 0)
-		skb_put(skb, len);
+	skb_put(skb, len);
 }
 
 static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index eb08a393413d..0166919f8705 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -656,7 +656,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
 				continue;
 			}
 
-			virtio_vsock_skb_rx_put(skb);
+			if (payload_len)
+				virtio_vsock_skb_rx_put(skb, payload_len);
+
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
 		}
-- 
2.50.0.727.gbf7dc18ff4-goog


