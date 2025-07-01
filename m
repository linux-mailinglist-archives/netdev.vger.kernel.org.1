Return-Path: <netdev+bounces-202983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF45AAF0094
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CF7442A7F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E503C28312D;
	Tue,  1 Jul 2025 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McUT/a0E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76EA2820DC;
	Tue,  1 Jul 2025 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388323; cv=none; b=QzUQuwQgBTmvHwDqR/+fasnWcwQzq4fn1gJ4j+wn4I3GT2A5yXeOHIaJ0nT6CqLDrMEmDjDrMsCcywgC7e2qTMZXF0yXmg0p+0PC7I6u457fALZmWTsGA4RRu3oBNUvjotAcDVtOvw6X5Erx09OeLAC+wSKEEhDpWWbIIbOnf/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388323; c=relaxed/simple;
	bh=GgQ5G49UOh/QqE8jeN3uL8vKvyjvdeIwwuEdW9qSZAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UtVdMU9kHZgXGo91XCdKtJ23/de1YUekeY9Fz2VA5N0TjlUFQAKnPTnIcBzjJOrNF0Ii1YpzrNBXBfD8mKMcn35fTh7G1Flq62EtFbdraeFYqkUjRXogz/MjWChXxPhxcpQ631ZC0zffjlQAXsDONQjNLbsdiHp1qHn54spC6OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McUT/a0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63902C4AF09;
	Tue,  1 Jul 2025 16:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751388323;
	bh=GgQ5G49UOh/QqE8jeN3uL8vKvyjvdeIwwuEdW9qSZAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=McUT/a0EQskzE+/VPkVpz8d6gCSjc7EPrQhKVcvPgcjw4br9dKzO42S/ReJXLM2Df
	 SAjukmrIpEIoSVYztLgnCuH1/Re/tz3oDFL+XqsShLgAsEpwkLiYm9gRDGHD+HKV2p
	 3O5nIML2cm4F6qNc91yIVhGTsbLMsHradGRLQkYLfOPxKEkbvDuVgtLBb9dJJ3RUhW
	 n/YGZaaz4Fg49p3ympbb+B7yRqB4hx8f4+6O4lOUXohptZUItX5DZGResObYHr7eOp
	 EfyHdsorAjIqMnUmmeXkwoibZKLlmYX4z0sTi+RP96jQAeXtm8n+FFQg2NnV7Em+Ga
	 lO7MSt3rVTmmg==
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
Subject: [PATCH v2 3/8] vsock/virtio: Move length check to callers of virtio_vsock_skb_rx_put()
Date: Tue,  1 Jul 2025 17:45:02 +0100
Message-Id: <20250701164507.14883-4-will@kernel.org>
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

virtio_vsock_skb_rx_put() only calls skb_put() if the length in the
packet header is not zero even though skb_put() handles this case
gracefully.

Remove the functionally redundant check from virtio_vsock_skb_rx_put()
and, on the assumption that this is a worthwhile optimisation for
handling credit messages, augment the existing length checks in
virtio_transport_rx_work() to elide the call for zero-length payloads.
Note that the vhost code already has similar logic in
vhost_vsock_alloc_skb().

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/virtio_vsock.h     | 4 +---
 net/vmw_vsock/virtio_transport.c | 4 +++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 36fb3edfa403..eb6980aa19fd 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -52,9 +52,7 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
 	u32 len;
 
 	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
-
-	if (len > 0)
-		skb_put(skb, len);
+	skb_put(skb, len);
 }
 
 static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index bd2c6aaa1a93..488e6ddc6ffa 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -656,7 +656,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
 				continue;
 			}
 
-			virtio_vsock_skb_rx_put(skb);
+			if (payload_len)
+				virtio_vsock_skb_rx_put(skb);
+
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
 		}
-- 
2.50.0.727.gbf7dc18ff4-goog


