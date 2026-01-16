Return-Path: <netdev+bounces-250643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7AFD38754
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FDCB31A1533
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670C43A4F20;
	Fri, 16 Jan 2026 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAFkN+Tp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iu9kQ+IS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E918C3A4AD2
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594530; cv=none; b=dci4WVRi8WQChPLMJVW9wKUrp/hWN/tAwvGp2KNtzRZc73cZQMqmzExy1FBldG6ggPb0y0lMAamez1ndkZayzfe6lWA2qNlitsTGu1cG/k/fZAwctOiXF8AgzWcN6Nl1g0nnp0gnFZgfvz3N6QkA9ETNcQlOY7fujfXgCZ30JCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594530; c=relaxed/simple;
	bh=A/Z6X724OpOjH0JR1tZITqCXaxlg20lb95ngLUoUj2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmPQ3nE2papf4IfzMsU9STYwQduvepzIlUT6xschvJF+wi5VF/ky2NBM3/1S1NSiFVhSDHDgWX4NDpT+td1itJ3HAFoBYIjvSacdFPmgHNgnBwE4RTDK3lEC5zjD1rRyMLp1hQoVIa1UziMt/0Z9cI4JfO8cEiWfJJQ88rD86uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bAFkN+Tp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iu9kQ+IS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768594528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArUbsQ+kNBjAUv+ApSXUG5Hd0kEcrS3qPgkd0OoiEwI=;
	b=bAFkN+TpdJg195+YfAgNXqXU4kI55VyUHADtAP1353XJYCn/KONOM3/3DmAVvO1pV05s//
	gh76LkSeVGZhOiM+uVnv7jPj6UEb96ApQO3+SW5nio4qXx5JntoxFSVVfL30yVh7GGoSKc
	M8Vd+N7HP39E1Dj3HHfRZmnW55cNT4Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-8vVndACROSWhTldRaSVQFA-1; Fri, 16 Jan 2026 15:15:26 -0500
X-MC-Unique: 8vVndACROSWhTldRaSVQFA-1
X-Mimecast-MFC-AGG-ID: 8vVndACROSWhTldRaSVQFA_1768594526
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d5c7a2f54so25854475e9.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 12:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768594525; x=1769199325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArUbsQ+kNBjAUv+ApSXUG5Hd0kEcrS3qPgkd0OoiEwI=;
        b=iu9kQ+ISQWJqsK5FtvBvvLkJHqRuxrbRBbDMK9HHXNpRKYVDbZqDkGT/pgvbQWDgp0
         VtxfTWp5E3P5F+tGuFQMQIXUKWPx1SYqD2HH1FwNUmGYGfADPc/rzgPcxEGolpoq9DUD
         rOBrtOaRMDRt2Pm7igYdm2L92CAcg+A9Xij6Lu5e1GYjAsUJKnbSIiJ/mqSKv2F2cv4s
         xeUDIiWvgoc87MhPgd5WFaNrM2VcXgh/QiFi5+R4hbZXFKyPcOSh4b5MD+Qo+MkHGaxA
         qzEdokb5DfEzSg6x8D66yielR38HC05Kw6UevKqJmsR4K1Wr6em5Rv0IYBOxlxVxiRRD
         d7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594525; x=1769199325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ArUbsQ+kNBjAUv+ApSXUG5Hd0kEcrS3qPgkd0OoiEwI=;
        b=CAwppShfF0uqni4d1FtW3T7znekYlsIg4e3tY5Mt8BM+ipgrpDK4O37xPF0KiUHJ3i
         OLw42TXq8OXL7N94Obz7UHKicyT+UWPRZxWaAKfPsC6DqnFr8KgH5yb3VsPu6qNYsxmp
         T4pJZjzcZALq0kg4kEhB8MIjcUhKPu2kzAaJBTIEiIgA2IIPfKwGAT8sebR/nHJlRhmC
         DDWOZVpDWvndcXB2kZIvnh+PfxXgwArhL+9T2+oeRpeek+xxlvzNcNr6lGstQs4ZUIFo
         D7079kpfNtA6OabYOFRNpLTPsLOX5p8cBKTfgKnyR+DfZ1KXLb3WOjxOrxfVR0dpV51F
         QB3g==
X-Gm-Message-State: AOJu0Yzch2vrkEy8252QUlZUdwWDdPEzwXS2YgUXOuFqW1qpisYTiNmF
	rucVUJYNkQWHKmlJ3FDzn2KqzsMgQ9DxH/6M/Psg1E9E1j1wtWv++uYYiYoSotl1iKf9HUv9nVl
	D4bPBSVTLVw4ugWxfR8wNXfNS0PtJkOyBXOoDjLtKRcKZMGQFCA3NKwSYOZ3W65WQDUqEF/5st3
	yEAxvXG6iOmzmP1uyn8CxB6ta6SrIYXJILc0Q0OliDAg==
X-Gm-Gg: AY/fxX5Qxo/Ge4mcsd52pmtqklzFkosfH4YkYiqcH/UdJ73kfyNhE8g7fqJpFGSvVUH
	7+hpU3J4aT/BGYg323nKBAi2ojVYm9e98GFdDyu9ruozt7RCiPezYnVtflOUIYMqBGfUd/968bN
	X4a50z6fpgU6RhJN4mtuhDgNES25UzC6FeQUJJfWABz3VdQEtCUL9bGAG0ulHcGJrhyx94CTO76
	kXHNqE+PEO8Q8xkiM6S7n5E10ofNqN6xetn+e95nkxqfPxkiqxxkEHtWWgpx/wPe0NHejVvScf4
	Zneg2En5Wq4agCamG3/L0W9dFluhJ8+v91tf4MyTO5tAvAaL2x8BFREO6cZIWdNFzlT8ZSZDj1y
	0sU1LlyZoHcf0nAj8DoZIj+7evXa1yxkd817Ubj+G6sLg+8gpxpxZ1WIj13wE
X-Received: by 2002:a05:600c:1f86:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-4801e53ca36mr57538875e9.5.1768594524972;
        Fri, 16 Jan 2026 12:15:24 -0800 (PST)
X-Received: by 2002:a05:600c:1f86:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-4801e53ca36mr57538465e9.5.1768594524424;
        Fri, 16 Jan 2026 12:15:24 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e879537sm57802005e9.5.2026.01.16.12.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:15:23 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Asias He <asias@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH RESEND net v5 1/4] vsock/virtio: fix potential underflow in virtio_transport_get_credit()
Date: Fri, 16 Jan 2026 21:15:14 +0100
Message-ID: <20260116201517.273302-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116201517.273302-1-sgarzare@redhat.com>
References: <20260116201517.273302-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Melbin K Mathew <mlbnkm1@gmail.com>

The credit calculation in virtio_transport_get_credit() uses unsigned
arithmetic:

  ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);

If the peer shrinks its advertised buffer (peer_buf_alloc) while bytes
are in flight, the subtraction can underflow and produce a large
positive value, potentially allowing more data to be queued than the
peer can handle.

Reuse virtio_transport_has_space() which already handles this case and
add a comment to make it clear why we are doing that.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
[Stefano: use virtio_transport_has_space() instead of duplicating the code]
[Stefano: tweak the commit message]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e..2fe341be6ce2 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -28,6 +28,7 @@
 
 static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
 					       bool cancel_timeout);
+static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
 
 static const struct virtio_transport *
 virtio_transport_get_ops(struct vsock_sock *vsk)
@@ -499,9 +500,7 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 		return 0;
 
 	spin_lock_bh(&vvs->tx_lock);
-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
-	if (ret > credit)
-		ret = credit;
+	ret = min_t(u32, credit, virtio_transport_has_space(vvs));
 	vvs->tx_cnt += ret;
 	vvs->bytes_unsent += ret;
 	spin_unlock_bh(&vvs->tx_lock);
@@ -877,11 +876,14 @@ u32 virtio_transport_seqpacket_has_data(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_has_data);
 
-static s64 virtio_transport_has_space(struct vsock_sock *vsk)
+static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
 {
-	struct virtio_vsock_sock *vvs = vsk->trans;
 	s64 bytes;
 
+	/* Use s64 arithmetic so if the peer shrinks peer_buf_alloc while
+	 * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction
+	 * does not underflow.
+	 */
 	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
@@ -895,7 +897,7 @@ s64 virtio_transport_stream_has_space(struct vsock_sock *vsk)
 	s64 bytes;
 
 	spin_lock_bh(&vvs->tx_lock);
-	bytes = virtio_transport_has_space(vsk);
+	bytes = virtio_transport_has_space(vvs);
 	spin_unlock_bh(&vvs->tx_lock);
 
 	return bytes;
@@ -1490,7 +1492,7 @@ static bool virtio_transport_space_update(struct sock *sk,
 	spin_lock_bh(&vvs->tx_lock);
 	vvs->peer_buf_alloc = le32_to_cpu(hdr->buf_alloc);
 	vvs->peer_fwd_cnt = le32_to_cpu(hdr->fwd_cnt);
-	space_available = virtio_transport_has_space(vsk);
+	space_available = virtio_transport_has_space(vvs);
 	spin_unlock_bh(&vvs->tx_lock);
 	return space_available;
 }
-- 
2.52.0


