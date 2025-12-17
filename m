Return-Path: <netdev+bounces-245225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E54CC93B2
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 146C0303A72C
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 18:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FC232B994;
	Wed, 17 Dec 2025 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnTyEwHI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0372D1931
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995159; cv=none; b=pubY5nJ3cl6aLj+H4HjBosMpVCTnKv+ErkqmQTEqM4IZi91qWL3n1psfcIzCIg3g0t3Hey7HaJbHRsc2Fq2CCXDwnrBxSUNNuEbPyYnDOSVR5sKb0q/F4WxHJol0PngflOqBhXyWcZPE61DKWxPRMze9JSTyYtNMlAo8sm87k9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995159; c=relaxed/simple;
	bh=+q4OPt2stNgoEY1wZPAOuLkUrNjM0zDoFE6c77HSEmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGuGW7gn6xmIagsP3Ut7BQ6WGspFrZ9H4aHZ1+D6CVwr+PTEVlpLfjYLK0j2GG86RPzOcWtcKPbVeYIgXHAL4mUDADxwLhT/4D1PETgpWalwGOObOJ/MNfwon5cQIJUZi+3OA+xI7+fuvG3JPtMHBoBsVolgGDV71aKcSaSoOaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnTyEwHI; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5957db5bdedso7551069e87.2
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 10:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765995152; x=1766599952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6L/g6AKDLzO2oXAkjTlOO45wco9Gy2vbAOvP3aPl+o=;
        b=XnTyEwHIIEqjaz4eoNNWFhuIVDNC7jYrsKnczJ8o7QN33hJJWzZ9t6YwHEteGxvbPz
         C7QTwxwJd1hSe2oonJGQiY5uXVU20XMd9XfKiPiKudBPGoTbWL34cx0TeazEelbSC0sM
         hJJga/C6+m4DS3DB95HBTe98LjDiFhJk2oQR6whiOGGDpQsfntXckxqnV5MA55RO2AxB
         BxHcUcSHqmQU6/g8Fga67iObhFm4sR8v7sADrJPjh4Je/ZPX67a1SL+kWe0A/8MAoBuN
         zLoONQAvJai7Q4RnZIDldV0YJTGFSvrmk5rSYQtWHbSx5xqUkVT0LgXBvoObtmC/HwGT
         PAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765995152; x=1766599952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C6L/g6AKDLzO2oXAkjTlOO45wco9Gy2vbAOvP3aPl+o=;
        b=onaNn7jEiikG4A0aP7VgPvkZfrYUyG7Tx6jOILBH0iuzbi9+cBUiGrgFVF/auGHgIl
         p7KPoxFRZugk95bIOBeEw+3IHa/P3TtVuBfSPNtAjjwID8sT2Jifhbxe52oCDJYn0vOs
         Rjc8PaRLuXCfJENUy8nyLcSNFDBsEgiYOdWfrqykiCcz32Ug4UiYFDiM15izRvbbokxA
         4m1mJC/N4Tro9LesaKdnk/CqnES5QQ4UNbkSoqZlhOPs3o0aG0itNV9CSMwCLKTQpYQF
         pvntl+Gc5HXNr3XZ9TDSUu0pC4asZ6U7bYPd78i4yC+EggadCDQplxd4uvmy8Qabnm1D
         R0OA==
X-Forwarded-Encrypted: i=1; AJvYcCVJhrA+7hcnwz2Mfy0t0QwmTMqsJjU6OsiN/bKQ0+rXSgxlh83i8SxNJu7k56O4qFiFOtYqdus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7AsUkTlbUvdnai9o9AycDCZx0D5E9rQwS0B28RLKynl299FLM
	nMk1SyaW1vmDYL1TY1k/A7g88qbbChJQARrfk3/ZIjIgqGn/ezqKZwPG
X-Gm-Gg: AY/fxX7MXib6/je3GfaipQ8flwnPHceaDVsNMVvkJ89Vo4rZztQcipAGnaR3VtQr83i
	YsvN4iMqtbd7kaq7jTQAMVztj3gXG+Ct3HmLoyVt1+RNbvS+X63jEemTfITwv2CzJDIE54/PaI+
	3Zug2T514ClfAQ1Q6lhdYvlznMUB40Jc9aE5/rr5afW5hJKRI9HEQEChC7jqpyGNJy/VGSgClC9
	qBmwjq1ZF8fQWOQ1ysqhO7adQ6U9qzBzWqPLqIFraM0v9Rz7eA6ijrMNB2Gz8bM+jHq669xIgiS
	4oF2FiMKe2TSXyv9krKbL2vwW1f2aib9ZrAkUMiylI8PrVCk42GNEHypszwp1vdEdjmhxQpT0t2
	7gdeCQJuwO+DQaH37gvgnztT8ryvYhLj8TB5e9V6ddwFnQ0TiGGX/qD+APgq+AjPchHj6GSgKvA
	ZjV2cvyeeOixE=
X-Google-Smtp-Source: AGHT+IFoJv0VtI+duA1BFZ1b2nyx/9qNil7UNuQ2voy1UQrqjVxXTqBKmiQjS+TdeaY4sOWMw/E4ZA==
X-Received: by 2002:a05:6512:3b86:b0:597:d7dc:b7ce with SMTP id 2adb3069b0e04-598faa3bd8amr6715768e87.30.1765995151819;
        Wed, 17 Dec 2025 10:12:31 -0800 (PST)
Received: from Ubuntu-2204-jammy-amd64-base.. ([2a01:4f9:6a:4e9f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5990da790efsm2591419e87.102.2025.12.17.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 10:12:31 -0800 (PST)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v4 2/4] vsock/virtio: cap TX credit to local buffer size
Date: Wed, 17 Dec 2025 19:12:04 +0100
Message-Id: <20251217181206.3681159-3-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217181206.3681159-1-mlbnkm1@gmail.com>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio vsock transport derives its TX credit directly from
peer_buf_alloc, which is set from the remote endpoint's
SO_VM_SOCKETS_BUFFER_SIZE value.

On the host side this means that the amount of data we are willing to
queue for a connection is scaled by a guest-chosen buffer size, rather
than the host's own vsock configuration. A malicious guest can advertise
a large buffer and read slowly, causing the host to allocate a
correspondingly large amount of sk_buff memory.

Introduce a small helper, virtio_transport_tx_buf_alloc(), that
returns min(peer_buf_alloc, buf_alloc), and use it wherever we consume
peer_buf_alloc:

  - virtio_transport_get_credit()
  - virtio_transport_has_space()
  - virtio_transport_seqpacket_enqueue()

This ensures the effective TX window is bounded by both the peer's
advertised buffer and our own buf_alloc (already clamped to
buffer_max_size via SO_VM_SOCKETS_BUFFER_MAX_SIZE), so a remote guest
cannot force the host to queue more data than allowed by the host's own
vsock settings.

On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
32 guest vsock connections advertising 2 GiB each and reading slowly
drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
recovered after killing the QEMU process.

With this patch applied:

  Before:
    MemFree:        ~61.6 GiB
    Slab:           ~142 MiB
    SUnreclaim:     ~117 MiB

  After 32 high-credit connections:
    MemFree:        ~61.5 GiB
    Slab:           ~178 MiB
    SUnreclaim:     ~152 MiB

Only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the guest
remains responsive.

Compatibility with non-virtio transports:

  - VMCI uses the AF_VSOCK buffer knobs to size its queue pairs per
    socket based on the local vsk->buffer_* values; the remote side
    cannot enlarge those queues beyond what the local endpoint
    configured.

  - Hyper-V's vsock transport uses fixed-size VMBus ring buffers and
    an MTU bound; there is no peer-controlled credit field comparable
    to peer_buf_alloc, and the remote endpoint cannot drive in-flight
    kernel memory above those ring sizes.

  - The loopback path reuses virtio_transport_common.c, so it
    naturally follows the same semantics as the virtio transport.

This change is limited to virtio_transport_common.c and thus affects
virtio and loopback, bringing them in line with the "remote window
intersected with local policy" behaviour that VMCI and Hyper-V already
effectively have.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index d692b227912d..92575e9d02cd 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -491,6 +491,18 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
 
+/*
+ * Return the effective peer buffer size for TX credit.
+ *
+ * The peer advertises its receive buffer via peer_buf_alloc, but we cap
+ * it to our local buf_alloc so a remote peer cannot force us to queue
+ * more data than our own buffer configuration allows.
+ */
+static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
+{
+	return min(vvs->peer_buf_alloc, vvs->buf_alloc);
+}
+
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 {
 	u32 ret;
@@ -508,7 +520,7 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 	 * its advertised buffer while data is in flight).
 	 */
 	inflight = vvs->tx_cnt - vvs->peer_fwd_cnt;
-	bytes = (s64)vvs->peer_buf_alloc - inflight;
+	bytes = (s64)virtio_transport_tx_buf_alloc(vvs) - inflight;
 	if (bytes < 0)
 		bytes = 0;
 
@@ -842,7 +854,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 
 	spin_lock_bh(&vvs->tx_lock);
 
-	if (len > vvs->peer_buf_alloc) {
+	if (len > virtio_transport_tx_buf_alloc(vvs)) {
 		spin_unlock_bh(&vvs->tx_lock);
 		return -EMSGSIZE;
 	}
@@ -893,7 +905,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	s64 bytes;
 
-	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
+		(vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
 
-- 
2.34.1


