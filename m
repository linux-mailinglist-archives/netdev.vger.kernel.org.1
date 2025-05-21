Return-Path: <netdev+bounces-192291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0311EABF43A
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A898E3410
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71793268C55;
	Wed, 21 May 2025 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGhDyJw5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A215267B83
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829847; cv=none; b=qif1wm5JzPRuJO19nWb+2Z/NYVD5siTfzHxBgOW89WO0oRLVjKJ9MH9cX2VLZEy5n8gDSR8ULNc2YZD7RoCcetofX5/4zs5nuuPapEHnTT7oW3aGuUtd/U21q8JBgdYUKE+0IdPh8eoweBNCLrkfQU6VYhjJUj9Dh1Ags+6Es8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829847; c=relaxed/simple;
	bh=CfktD8zgoXzFHpGPN33h183DcOy5eNSJ26il1oP9PIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MGZTm0rNGSrVsmZBWA0i7aSrafZ3WUp0CmXbG9kuprnJ39SY7QKWH17l3XSwMnvo1GL2tbVOdokQ/E3ES7D48sAxhe+B3+e1K+I+33Oax5lqLx8gYfVFaVeeTEPmcZnO7uTgKKSllR4geXpgsJH7LZcuSl2oMAfknVYsyWH8z44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGhDyJw5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747829844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=koXbHLCrgYB2PDtOqNQzcLGwc+0kyTs5q0PGoBFShLg=;
	b=FGhDyJw5A/D+71fcoQDy9ELEdIy7vzzotG18jfrNvz+YATmAyTstjDg8ytP3ycVL0w2vXQ
	qBuQeoy+O1AOGTvdAoB6//5tgPnjbAYKrGj77WCG+PdX6oli3woJyf769V9U4xgv+A2tgl
	RXWYRnjS52khtT/FKzpe8TwtLr53Gx8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-GPl-hxYTOniw9ZjXQ4Kasg-1; Wed, 21 May 2025 08:17:18 -0400
X-MC-Unique: GPl-hxYTOniw9ZjXQ4Kasg-1
X-Mimecast-MFC-AGG-ID: GPl-hxYTOniw9ZjXQ4Kasg_1747829837
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6023963c69aso662835a12.1
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 05:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747829836; x=1748434636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=koXbHLCrgYB2PDtOqNQzcLGwc+0kyTs5q0PGoBFShLg=;
        b=GyaJKY0anGeVSZmPKswG/57e9/64BrcnzOay4PDEuN0jKYKlCIGIHGRA9uSK3Rl5Wb
         nNS6BXaz8KGXKgxhW4YCNggez1Yg9En5aD0hwltA52BvPIpXXAOJEmPt7diEUo147aqp
         VD8TSsNmy1tJ33dT3xpbyl690Rb2+gos21yh1ajXz41Az53SwFgNeXYN6Plunw9v7EKC
         91LcyxAJzRgU+R4VCqbLQBqPhe00SDt/3XPeS3SL00syXjg3IgX09c8WTsewYXEq7hLo
         munAHOvuQ50u2YmD2n7zwjphEXDkH/IXMESgIvnWA7+xMXjn83+/mxfHTvrg152KRI4a
         /BGA==
X-Gm-Message-State: AOJu0YwzmKyR630YAKrIU1e28SiDLJchLsssYTyhJoFTsLT+m0i5qwAC
	FG3k6DbdN6iKdMbH98JNiqCzgamjen2mW5H3nrpPqpChYdXyWmeCw0wpba7ipej2wyZjTVxTi1n
	dax4tR+14pbLr9Iq+jFJ0Ynj7OwynU5JLSWXAn7C5woslErjsYjV32IBRjWwr64hw8JMI4qZfHf
	C4IUX/UigxUamA2IXb1jAUbVknGvZYe5D4ENRqEDR1UQ==
X-Gm-Gg: ASbGnctL4kjjBiCJfVH0y6NMHgsAKjwvbU/kO0UMGpWr2gYjwV6Yy7NBip5C4uyVGHD
	Uw9bBtps4C+jGTMJEfOjSwYwa0pgvV4OMlsD7kkt/DpuL1Jgl9WgnxGCrlaPfcsWf5KTFLiPicT
	a997+LpvpDVtX95L1TxH+a9n5OW3DJv6EYL7SBPROsA8urEXc5lz1vUdx3ghMWsxGTV43hEYsqa
	fbYJuKY7RBsOfruPUFomXdvakpi4KfDtsXy3MT370f/EHtsqLgk+5wXq1yDMj0rPoEpcsbKvI2S
	UOATZ4EDXmh0VXzRnzNJPMD+ZdbohUMacn7kqIesPKGnalPPnjycVK1wPQoCvmxhYMGg
X-Received: by 2002:a05:6402:50c9:b0:601:a681:4d5c with SMTP id 4fb4d7f45d1cf-601a6814f05mr12934893a12.32.1747829836087;
        Wed, 21 May 2025 05:17:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4cgb/1piVsTbjdMMKwjk3dNR8qjrtqCCwZsJc1XfaRl4HuQDjqQbxQefkqEDzpnU155bKIg==
X-Received: by 2002:a05:6402:50c9:b0:601:a681:4d5c with SMTP id 4fb4d7f45d1cf-601a6814f05mr12934847a12.32.1747829835404;
        Wed, 21 May 2025 05:17:15 -0700 (PDT)
Received: from localhost.localdomain (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005ae3918esm8725254a12.68.2025.05.21.05.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 05:17:14 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuewei Niu <niuxuewei97@gmail.com>,
	Krasnov Arseniy <Oxffffaa@gmail.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH net] vsock/virtio: fix `rx_bytes` accounting for stream sockets
Date: Wed, 21 May 2025 14:17:05 +0200
Message-ID: <20250521121705.196379-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

In `struct virtio_vsock_sock`, we maintain two counters:
- `rx_bytes`: used internally to track how many bytes have been read.
  This supports mechanisms like .stream_has_data() and sock_rcvlowat().
- `fwd_cnt`: used for the credit mechanism to inform available receive
  buffer space to the remote peer.

These counters are updated via virtio_transport_inc_rx_pkt() and
virtio_transport_dec_rx_pkt().

Since the beginning with commit 06a8fc78367d ("VSOCK: Introduce
virtio_vsock_common.ko"), we call virtio_transport_dec_rx_pkt() in
virtio_transport_stream_do_dequeue() only when we consume the entire
packet, so partial reads, do not update `rx_bytes` and `fwd_cnt`.

This is fine for `fwd_cnt`, because we still have space used for the
entire packet, and we don't want to update the credit for the other
peer until we free the space of the entire packet. However, this
causes `rx_bytes` to be stale on partial reads.

Previously, this didn’t cause issues because `rx_bytes` was used only by
.stream_has_data(), and any unread portion of a packet implied data was
still available. However, since commit 93b808876682
("virtio/vsock: fix logic which reduces credit update messages"), we now
rely on `rx_bytes` to determine if a credit update should be sent when
the data in the RX queue drops below SO_RCVLOWAT value.

This patch fixes the accounting by updating `rx_bytes` with the number
of bytes actually read, even on partial reads, while leaving `fwd_cnt`
untouched until the packet is fully consumed. Also introduce a new
`buf_used` counter to check that the remote peer is honoring the given
credit; this was previously done via `rx_bytes`.

Fixes: 93b808876682 ("virtio/vsock: fix logic which reduces credit update messages")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport_common.c | 26 +++++++++++++++----------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0387d64e2c66..36fb3edfa403 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -140,6 +140,7 @@ struct virtio_vsock_sock {
 	u32 last_fwd_cnt;
 	u32 rx_bytes;
 	u32 buf_alloc;
+	u32 buf_used;
 	struct sk_buff_head rx_queue;
 	u32 msg_count;
 };
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 7f7de6d88096..2c9b1011cdcc 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -441,18 +441,20 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	if (vvs->rx_bytes + len > vvs->buf_alloc)
+	if (vvs->buf_used + len > vvs->buf_alloc)
 		return false;
 
 	vvs->rx_bytes += len;
+	vvs->buf_used += len;
 	return true;
 }
 
 static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
-					u32 len)
+					u32 bytes_read, u32 bytes_dequeued)
 {
-	vvs->rx_bytes -= len;
-	vvs->fwd_cnt += len;
+	vvs->rx_bytes -= bytes_read;
+	vvs->buf_used -= bytes_dequeued;
+	vvs->fwd_cnt += bytes_dequeued;
 }
 
 void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb)
@@ -581,11 +583,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 				   size_t len)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
-	size_t bytes, total = 0;
 	struct sk_buff *skb;
 	u32 fwd_cnt_delta;
 	bool low_rx_bytes;
 	int err = -EFAULT;
+	size_t total = 0;
 	u32 free_space;
 
 	spin_lock_bh(&vvs->rx_lock);
@@ -597,6 +599,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 	}
 
 	while (total < len && !skb_queue_empty(&vvs->rx_queue)) {
+		size_t bytes, dequeued = 0;
+
 		skb = skb_peek(&vvs->rx_queue);
 
 		bytes = min_t(size_t, len - total,
@@ -620,12 +624,12 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 		VIRTIO_VSOCK_SKB_CB(skb)->offset += bytes;
 
 		if (skb->len == VIRTIO_VSOCK_SKB_CB(skb)->offset) {
-			u32 pkt_len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
-
-			virtio_transport_dec_rx_pkt(vvs, pkt_len);
+			dequeued = le32_to_cpu(virtio_vsock_hdr(skb)->len);
 			__skb_unlink(skb, &vvs->rx_queue);
 			consume_skb(skb);
 		}
+
+		virtio_transport_dec_rx_pkt(vvs, bytes, dequeued);
 	}
 
 	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
@@ -781,7 +785,7 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
 				msg->msg_flags |= MSG_EOR;
 		}
 
-		virtio_transport_dec_rx_pkt(vvs, pkt_len);
+		virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
 		kfree_skb(skb);
 	}
 
@@ -1735,6 +1739,7 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 	struct sock *sk = sk_vsock(vsk);
 	struct virtio_vsock_hdr *hdr;
 	struct sk_buff *skb;
+	u32 pkt_len;
 	int off = 0;
 	int err;
 
@@ -1752,7 +1757,8 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count--;
 
-	virtio_transport_dec_rx_pkt(vvs, le32_to_cpu(hdr->len));
+	pkt_len = le32_to_cpu(hdr->len);
+	virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
 	spin_unlock_bh(&vvs->rx_lock);
 
 	virtio_transport_send_credit_update(vsk);
-- 
2.49.0


