Return-Path: <netdev+bounces-201147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD4CAE8446
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4581B4C0C42
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FDB267B94;
	Wed, 25 Jun 2025 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uzi6pbmt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9D267B7F;
	Wed, 25 Jun 2025 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857362; cv=none; b=s9Qs99Q2O5ZGuajUM/GivIYVpFilgfDHN6HQe3J74fEHtjgYWjdw+Yo4z2u6SohqFK8hAeLOjPgih5UAs5oc2g/Q/pX6maMDOb6KOdGo5fHP1Je/8HwtOeHtdj4Ez1MUK9VXGqo9pVDWosJe1TysJMEz8s23hfS/sEx4JHC7A4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857362; c=relaxed/simple;
	bh=Ikr9BmRhSKTp5eLQeoRaFu56Cz49I5eK9mJ0EqkLrrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HpIdDS/UNBlU4QPQIi9KY26yq7oX01H41LELCVvObep7P4QxTjGkjRmHcxyzM++oRV/LIThl+xyzvbZvCeq6DY3bM1EToYaPOHgQjjc3QULEDq4ibJWXjUiE/duCf7jNw/s1mKmjkxMxudiQgxFEbZv7iOp0eX+oFvgYxoHehxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uzi6pbmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27C9C4CEF0;
	Wed, 25 Jun 2025 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750857361;
	bh=Ikr9BmRhSKTp5eLQeoRaFu56Cz49I5eK9mJ0EqkLrrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uzi6pbmtdcz63Oy6YzgyGgA/fkzZu6QxuynWYcMkq0hPknSusPfyEtmOofpeR+K/q
	 iYjEW5H2O4XTLU66YRjgYzAtBdOIAqfkZUcqJVwFERx84dDh0mAOeFF6qJPrkmbdcU
	 1gwo/HOsm2aZ5N0Kbjc+cuYjlnGRNnru+zcK2y0COEXgK3HrjkyhqfehfUzpIPcNsc
	 K/tMmAtFr+g6lxWa12hoA1H7XJfZPmZ4S+roAOrFVL/3JCqQ9KGqshep4NFDL1r2Mu
	 7tux6AxvVBWCC02uXeQaP2pl2aJ0BISbtnMAgS/+BcL8FGmcGkcu0jCLyUC6MIo0W1
	 g10YY8FrM41tA==
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
Subject: [PATCH 4/5] vsock/virtio: Rename virtio_vsock_skb_rx_put() to virtio_vsock_skb_put()
Date: Wed, 25 Jun 2025 14:15:42 +0100
Message-Id: <20250625131543.5155-5-will@kernel.org>
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

In preparation for using virtio_vsock_skb_rx_put() when populating SKBs
on the vsock TX path, rename virtio_vsock_skb_rx_put() to
virtio_vsock_skb_put().

No functional change.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/vhost/vsock.c            | 2 +-
 include/linux/virtio_vsock.h     | 2 +-
 net/vmw_vsock/virtio_transport.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index cfa4e1bcf367..3799c0aeeec5 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -380,7 +380,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		return NULL;
 	}
 
-	virtio_vsock_skb_rx_put(skb);
+	virtio_vsock_skb_put(skb);
 
 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
 		vq_err(vq, "Failed to copy %zu byte payload\n", payload_len);
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 8f9fa1cab32a..d237ca0fc320 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -47,7 +47,7 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
 	VIRTIO_VSOCK_SKB_CB(skb)->tap_delivered = false;
 }
 
-static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
+static inline void virtio_vsock_skb_put(struct sk_buff *skb)
 {
 	u32 len;
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f0e48e6911fc..3319be2ee3aa 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -648,7 +648,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 				continue;
 			}
 
-			virtio_vsock_skb_rx_put(skb);
+			virtio_vsock_skb_put(skb);
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
 		}
-- 
2.50.0.714.g196bf9f422-goog


