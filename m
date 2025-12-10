Return-Path: <netdev+bounces-244255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 143AACB3090
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 14:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 666DC3023556
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 13:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77710316905;
	Wed, 10 Dec 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiVVUu75"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3B7218845
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765373606; cv=none; b=Nm6iYWIAPIg1e0nJX3hoHZMBt0lH3/heEi78Mgb9lcYwPhugpJxsqclgLorosNPCOP/MLei5H6u3LFERBq07xZ4YP8rD7Dxjs6ei2XtBToYfQmEWgLmOcIxuVJOPlznODw5qpZCaqsD7djgzkpWirjbrXrD+bMLvlTiNy3c6reg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765373606; c=relaxed/simple;
	bh=0wLH31HDwfSTe/1EuiWHtYsukRblUE1QRCxb3uKciDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pRiIoX7R8gfbMq3m6YZ3jXOS7LTmCIPLLWYEAdRbF6Rn0+nUscMUvgGuHlbFUwLDGoD4v9X8xAB5/4RSKPlqCcSjlkLieF4p5N4WpV3nELe71Snr66mKvhg1zuG27Mt95d6EwlOIVpfHKkNzIBbRG+GRN1ngLzwpOmXrSl8F9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiVVUu75; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-597d712c0a7so7273370e87.0
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 05:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765373602; x=1765978402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oD5ipYc8BirTwTUNyp9GQ08Nz/lO30YuP7q1nZr2KbU=;
        b=PiVVUu75bWCXiK4djEq6YzAIZ8Q2amFfFDi/kFoeq4EtsLT7j08dTo71s1+DR3SxyP
         o9K7U4zmpwbxhoUcHq/e0sGrjkoQ3PIbCugVdKqv8gMoaNDFyivxszgAEoHc+zql1tp3
         Y/n7+c0HNrku/xie9Z3hEAY2tHu/ySqcN3NCW7RNC23bfxRndrHJ3ESe8t9wg6wgfoHX
         G7YoSQ1gYgLUHpf6ZZQ7Vup73obRTEBYazzkNw8fSZQpbYN4FdQ34FXZgraDeI8440cZ
         J05chF8bw5oakZnDfayE8Xa8hI/5TJt54hgyyjKNuGVMywoB561xCW6YXKzgMmEDgTrn
         EgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765373602; x=1765978402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD5ipYc8BirTwTUNyp9GQ08Nz/lO30YuP7q1nZr2KbU=;
        b=iaj6UKvg4TdTCWrjge7r+FLoGN/46yf/6A3J/HCXp0lwsukBm5fXHOhZ02pitOYlh8
         dvRhyFSTbdDyaKJKtZ15VkaRh4NW+jo77MRmGuf5F8NoX9c7xwVf+lo2cDGUIFLbZlFo
         E1b67pdB+baKZgaudDAffX2gmd3akX5Ms/WYWdyUTraVEX0NTdDz/WMqjWzymmp9V91D
         v8+qWNMmp+lz2WcujMlMmB8rxquW6yk/z1JGK+P9hNbknmhON9Bd5lp/MBRnPS6orWq4
         tHeTtCIJH2X2z2nIv1BAv9Dywz4X6LcETOzVTK8byXTYZqIfp297QzsTwsZF3DfAabnY
         tLyg==
X-Gm-Message-State: AOJu0Yy26oknT9bcEexhyMj9Ql0B/m21k8L8UogqJw7N/jWMN0RLapqu
	dQJTmlM1DQqCTy6t7Xg/RNGI4XIhnWjEW88roxjl02u1qv5k8bSZFDXb0rb0d4+d
X-Gm-Gg: AY/fxX64eWtjhH7HUNTIgabgRXp8P7+jJTeWkzoIpMNm75mjIp4+7NFyvlyEb/S+JcD
	x1L2Inc191VdTySSsr3nL1JSPdyfgsvjN3yt0FHRFRn9OEKAOfGEdD/NaQFFZNrD1pP5gKlyEvF
	n01uCkzszaGGFFp+TwLxKWwYa35o8Ps6wNcw2c6wZeomKLhz1e6lQo7Y5ymUUAC/DdJBbOflCZN
	MmU3a06r6vB/HUT6FZicUd61u+Ad0I2XS+p5nTs/PbQC871N6459DLyCorGnpmKssihO70C5io/
	5rB/3rJJlntW9dyaoBSLR0FFI9+rtH2xQxKJTHZZTuQZCbzJ5iNqA08AJyXLSuZWHgbF4GCWgRv
	1vBn/ApZET6IoXjuTKV18NzceuZYf3YOfBB3GXoLcPYwH9ENmvLKnmmCcdrfHuruO4W153w57ND
	5gSj8t807Ellg=
X-Google-Smtp-Source: AGHT+IGuUo6ZoxmOLPJELy4E+MQsRaQCeY8UlKN8xDwSV5aN/WHR1k1qW9H8XravEGuc7+/9yStW0A==
X-Received: by 2002:a05:6512:3d8c:b0:595:9d90:5dc6 with SMTP id 2adb3069b0e04-598ee4e6446mr990906e87.19.1765373602129;
        Wed, 10 Dec 2025 05:33:22 -0800 (PST)
Received: from Ubuntu-2204-jammy-amd64-base.. ([2a01:4f9:6a:4e9f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7c1e2acsm6473621e87.61.2025.12.10.05.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 05:33:21 -0800 (PST)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net] vsock/virtio: cap TX credit to local buffer size
Date: Wed, 10 Dec 2025 14:32:59 +0100
Message-Id: <20251210133259.16238-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio vsock transport currently derives its TX credit directly
from peer_buf_alloc, which is set from the remote endpoint's
SO_VM_SOCKETS_BUFFER_SIZE value.

On the host side this means that the amount of data we are willing to
queue for a connection is scaled by a guest-chosen buffer size,
rather than the host's own vsock configuration. A malicious guest can
advertise a large buffer and read slowly, causing the host to allocate
a correspondingly large amount of sk_buff memory.

Introduce a small helper, virtio_transport_peer_buf_alloc(), that
returns min(peer_buf_alloc, buf_alloc), and use it wherever we consume
peer_buf_alloc:

  - virtio_transport_get_credit()
  - virtio_transport_has_space()
  - virtio_transport_seqpacket_enqueue()

This ensures the effective TX window is bounded by both the peer's
advertised buffer and our own buf_alloc (already clamped to
buffer_max_size via SO_VM_SOCKETS_BUFFER_MAX_SIZE), so a remote guest
cannot force the host to queue more data than allowed by the host's
own vsock settings.

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

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: Melbin K Mathew <mlbnkm1@gmail.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d58..f5afedf01 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
 
+/*
+ * Return the effective peer buffer size for TX credit computation.
+ *
+ * The peer advertises its receive buffer via peer_buf_alloc, but we
+ * cap that to our local buf_alloc (derived from
+ * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
+ * so that a remote endpoint cannot force us to queue more data than
+ * our own configuration allows.
+ */
+static u32 virtio_transport_peer_buf_alloc(struct virtio_vsock_sock *vvs)
+{
+	u32 peer  = vvs->peer_buf_alloc;
+	u32 local = vvs->buf_alloc;
+
+	if (peer > local)
+		return local;
+	return peer;
+}
+
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 {
 	u32 ret;
@@ -499,7 +518,8 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 		return 0;
 
 	spin_lock_bh(&vvs->tx_lock);
-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	ret = virtio_transport_peer_buf_alloc(vvs) -
+             (vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (ret > credit)
 		ret = credit;
 	vvs->tx_cnt += ret;
@@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 
 	spin_lock_bh(&vvs->tx_lock);
 
-	if (len > vvs->peer_buf_alloc) {
+	if (len > virtio_transport_peer_buf_alloc(vvs)) {
 		spin_unlock_bh(&vvs->tx_lock);
 		return -EMSGSIZE;
 	}
@@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	s64 bytes;
 
-	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	bytes = (s64)virtio_transport_peer_buf_alloc(vvs) -
+               (vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
 
-- 
2.34.1


