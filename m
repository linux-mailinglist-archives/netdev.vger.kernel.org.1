Return-Path: <netdev+bounces-244378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 218A7CB5F30
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 13:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E95FA3051174
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 12:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BC63126D3;
	Thu, 11 Dec 2025 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUQZ70TD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B12F693A
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765457514; cv=none; b=Th9Pmv02fXyGDz95nuyIhB0HILGG/vwJldF/naGPlKKgP9KATdc3W6XvFXAn6ah0fB8aN9ODGbVIvkvvFu1aYL8ggtZbt7k7Hx3Bdm8yzGp94YdeiA1PmElTF9/OxFulos7hcRsJdQGHf5FXK16owT5t0eh6dCVhBG0pNZJ0Ddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765457514; c=relaxed/simple;
	bh=UtcSCFo4lcJ+VNXPCswEjoKkIm8zmXXMCuHRDIRT/lI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FIC5Te0UL/QlXm0WG7ucAlKfapZG3TgfyuYHmCkgQA7msTlSAS1smIzFW1fZnOvRIRkKkzS+te/XJ9FqRn0lPph/6I4pkSHnGzOJKReha+G0FBPAN+XcHDiD4QJBRboU6jth0WxDKdrmoKgNiFSm5J0jQQ0nIH+n/XJ9+zuTowQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUQZ70TD; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37b99da107cso442061fa.1
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 04:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765457510; x=1766062310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUQdXYP6pOfCpe/+KEFALT6gCZMNZ8lZXJxhEyfJhoM=;
        b=mUQZ70TDbzSE6P9Yp2X6KM+lzKckPoibpuwRUja1cL7UzmYLBgEkY2SpALi8wFH2XA
         ckxcqQMMpprRfhVuRXJp/f0IJ5Usm+GKv3FnQVIF7KHCYPzGbi6ZJABG9XMpFfKMHe8O
         /kNPTiR7PW41LktFROiFsa8fnvKEpNQX+BFLwsNXM0fFL7Q9U7RPEWTyxncYSCExMZmE
         HOpFTKwc+BK+5dO+1+YzW9dQCQsanpkJ/JjOT4RwBcz07WLlmGiw+Ewgmviz6RQpeJhV
         94CKsBLHP+eJe1us9ZXOrjuRfedpxBFUwbtQPGzZybpfpymYq992xPOFrpw3KYiI9N4v
         6ouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765457510; x=1766062310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUQdXYP6pOfCpe/+KEFALT6gCZMNZ8lZXJxhEyfJhoM=;
        b=mTr3EF6y203pJFSRFlwQS8FJ1C83KoJfV+GJ/UgRio79rnFmE1eME9bjcK0RPccKL1
         G474sv//BBxBIbBgvFFtMLvZqryO9BzeqzzcaJTF9EqsXCHlBkdMDV2VJjDh0s4dvV47
         XanAAowMHMFRHr9AzMiPVR07WSElT+vN6CRgdARLPBwktbGMdHwmLHpsbirKAAH6eIjc
         KyVQ8dGQIMxj9J2qPLBSD6ZVwHjD4XaQMkaedcU3mRy6Wol1tW5AuHn+tRhmsaZ4TdpM
         MzixuB/bWAIMh1jwXm9UV3Zd7/ba4BMGZjwqTZ/9QQb6x1gtBwsuT0N+2JXJaaHCWx5L
         q1+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeP0kYsXQfiVwIQFnVxxBc7mjClB2mGGYEfpGkXvQl2G1aVsI+SKTONal8Zafqh0h8ZYO/8Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkpOwT+UE2LGoqMQs8reIZTiPDVrX/S2xIefPRql3gPW7dKS7d
	jqFr2OUsgEg89mgjXhO50AOm2OYCTyEI6IOBYQO7Pehtl2AaRSL1LExF
X-Gm-Gg: AY/fxX7+VDKSEK/gMUHFxxF7HiLYPVKMWBY+t8n6e2wQVw991BAWV1uwkpt61K9rWA6
	uxqA1ezvb0NDeeH8xmaTaNVxX2CDqzwXmSwDygbQSnBEcRDPoYz+VjHmJlsCH0t7dVG6luBJOI8
	ObPakilRk+RxfHSsAE1aaatKWRpUU8bkCJ4rBYGoBfHfT4RC6pU4QD83xuH1h6E4dp1emlFH4OB
	pO6+26hhUf5VOusOuBQfqqUiXZKaqPAXaCncOTDKZXtLCKqZBjsSkNw5p6/fT/ld3UitymeaUMp
	FO53n/WcevppX9CvS+AEi/CalHTpwr5jhf2UOzIjpsF6hexIlnbPXdrdOdG8IIqHSpkDmHofc6W
	wXK2FhQ9lWXzbDp/jvZaf2xbefU/zvQ34JgVrHyKkiOjVgl3drDjijQG8jD0lErsawuFBt5ZOdz
	HEeV0c1wm27tc=
X-Google-Smtp-Source: AGHT+IGENgtK1gusynnKiA94NWiQgv3EAxKkdXwr/sY+k3BPHQ54cU7oSPuV1/QDYEzaMtvI1s0nZQ==
X-Received: by 2002:a05:6512:2316:b0:595:81ce:ff83 with SMTP id 2adb3069b0e04-598ee527456mr2125540e87.25.1765457508314;
        Thu, 11 Dec 2025 04:51:48 -0800 (PST)
Received: from Ubuntu-2204-jammy-amd64-base.. ([2a01:4f9:6a:4e9f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-598f2f379d4sm835021e87.21.2025.12.11.04.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:51:47 -0800 (PST)
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
Subject: [PATCH net v3] vsock/virtio: cap TX credit to local buffer size
Date: Thu, 11 Dec 2025 13:51:04 +0100
Message-Id: <20251211125104.375020-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The virtio vsock transport currently derives its TX credit directly from
peer_buf_alloc, which is populated from the remote endpoint's
SO_VM_SOCKETS_BUFFER_SIZE value.

On the host side, this means the amount of data we are willing to queue
for a given connection is scaled purely by a peer-chosen value, rather
than by the host's own vsock buffer configuration. A guest that
advertises a very large buffer and reads slowly can cause the host to
allocate a correspondingly large amount of sk_buff memory for that
connection.

In practice, a malicious guest can:

  - set a large AF_VSOCK buffer size (e.g. 2 GiB) with
    SO_VM_SOCKETS_BUFFER_MAX_SIZE / SO_VM_SOCKETS_BUFFER_SIZE, and

  - open multiple connections to a host vsock service that sends data
    while the guest drains slowly.

On an unconstrained host this can drive Slab/SUnreclaim into the tens of
GiB range, causing allocation failures and OOM kills in unrelated host
processes while the offending VM remains running.

On non-virtio transports and compatibility:

  - VMCI uses the AF_VSOCK buffer knobs to size its queue pairs per
    socket based on the local vsk->buffer_* values; the remote side
    can’t enlarge those queues beyond what the local endpoint
    configured.

  - Hyper-V’s vsock transport uses fixed-size VMBus ring buffers and
    an MTU bound; there is no peer-controlled credit field comparable
    to peer_buf_alloc, and the remote endpoint can’t drive in-flight
    kernel memory above those ring sizes.

  - The loopback path reuses virtio_transport_common.c, so it
    naturally follows the same semantics as the virtio transport.

Make virtio-vsock consistent with that model by intersecting the peer’s
advertised receive window with the local vsock buffer size when
computing TX credit. We introduce a small helper and use it in
virtio_transport_get_credit(), virtio_transport_has_space() and
virtio_transport_seqpacket_enqueue(), so that:

    effective_tx_window = min(peer_buf_alloc, buf_alloc)

This prevents a remote endpoint from forcing us to queue more data than
our own configuration allows, while preserving the existing credit
semantics and keeping virtio-vsock compatible with the other transports.

On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
32 guest vsock connections advertising 2 GiB each and reading slowly
drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB and the system only
recovered after killing the QEMU process.

With this patch applied, rerunning the same PoC yields:

  Before:
    MemFree:        ~61.6 GiB
    MemAvailable:   ~62.3 GiB
    Slab:           ~142 MiB
    SUnreclaim:     ~117 MiB

  After 32 high-credit connections:
    MemFree:        ~61.5 GiB
    MemAvailable:   ~62.3 GiB
    Slab:           ~178 MiB
    SUnreclaim:     ~152 MiB

i.e. only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the
guest remains responsive.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d58..02eeb96dd 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
 
+/* Return the effective peer buffer size for TX credit computation.
+ *
+ * The peer advertises its receive buffer via peer_buf_alloc, but we
+ * cap that to our local buf_alloc (derived from
+ * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
+ * so that a remote endpoint cannot force us to queue more data than
+ * our own configuration allows.
+ */
+static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
+{
+	return min(vvs->peer_buf_alloc, vvs->buf_alloc);
+}
+
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 {
 	u32 ret;
@@ -499,7 +518,8 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 		return 0;
 
 	spin_lock_bh(&vvs->tx_lock);
-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	ret = virtio_transport_tx_buf_alloc(vvs) -
+		(vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (ret > credit)
 		ret = credit;
 	vvs->tx_cnt += ret;
@@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 
 	spin_lock_bh(&vvs->tx_lock);
 
-	if (len > vvs->peer_buf_alloc) {
+	if (len > virtio_transport_tx_buf_alloc(vvs)) {
 		spin_unlock_bh(&vvs->tx_lock);
 		return -EMSGSIZE;
 	}
@@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	s64 bytes;
 
-	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
+		(vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
 
-- 
2.34.1


