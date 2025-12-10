Return-Path: <netdev+bounces-244261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4567CCB33C3
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 16:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 399983015415
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 15:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AE02F12D3;
	Wed, 10 Dec 2025 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLa6A+Aq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0652E92B4
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765378838; cv=none; b=Dnslva0cGWkn8lgle0k3DjmPazgPgGpHOuEs+UwVF1s2plSVFYY9xFtWblohQpphMB1uQZ8PwTNGh0c13zAjdBmaQ7MAk12ZVD/D2cN+hG4CrnBn/W8is7e0tLs9nGVJBtn1XLJDjDUq3H71k/DB03BVu/XbKl4m5g597YA5cjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765378838; c=relaxed/simple;
	bh=MSr5XEHUW9lfwx8ONZK435PWQbRzcsG+H/xw66VcApY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uOGZa5w5gbshb3KJKjamxWN+++IyUvLHlJ045wnlJ2VYwh+KK9ws+NgyRyQnJwRNzwm9tu2Rp7SCBnU40NqRAkooQIBX7ibMNEtPwICXSw27Ne5D/hHCiDsnLlZzGogGxE2D6YJOpvAPSvYHcUPCOh+c1akzyaqsibvfp5+H+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLa6A+Aq; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59577c4c7c1so920434e87.1
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 07:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765378835; x=1765983635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BCCa/WDuQFIGFlF08+35rlR/K3A+HtplJl47l9oHX5w=;
        b=NLa6A+AqakMxOR4GWKh1SuMDznwKJfGVi+3pmG3GYWbvZW3d88tPZdV17KfQP6/UQB
         dvgJqZ+5gijqrEF8Uvcm2YT8A4Krutpvoo83j1YiB1XK9yYHbpnJoll2a7abePC30KEi
         LByuugeRX1jJM0mKNWz/W14FSMemW6CMYyxRi+9t5ABSlwd8WXyZR9TJq8dEUkzPxfN6
         aeb1Dm+H6oFv/cZ9qtrUK2FCXhwLhNUIldmM4kFB9OpVX8Xi7MoOyjlabP5BLwdKRKyG
         gNyScnsQJZZwRIYjizUzhaVLIdKEQNlaUmcAy8yBDBcdqrHqyLq+HDHrDUIBjOReh9z2
         He3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765378835; x=1765983635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCCa/WDuQFIGFlF08+35rlR/K3A+HtplJl47l9oHX5w=;
        b=Gg8no4lg1rbEV8OlGlT4vyv7iXgsBD0lUEY6U/Xii6VIFhGD1E0A3LU+vbRj6GEKTV
         Kql60ZIts+OLM+2L42rJvslUi+dAL4pgQSuoEcyB0AWk8BZNkm9CjARtZa44wQ+9XdOt
         WQqEQ9ljr+mJZ5TRJ7elM+OAabv675dQb51m0hKaizjFn3r/k0F+vdmn6vzetbvhHUhK
         NMoxE8pN52eXVGXe5JJ9rw7D8gTH8k52vRlGl+BM5zJpJihAWOaW9GH3jrFY6MBy3/IF
         bkRMWzs4fvbw1bF5HANl/gvF86MW222TkKb8kwd6q9RmM3qgXl620w0oRna1Iu85fGzU
         hTLA==
X-Forwarded-Encrypted: i=1; AJvYcCWFpmmXfMt6b4yTXqenfsS5hZPMhGXty8pgGUBza6bV9aRSgLI1zuoF+Mu7a/nSe4US99V1G4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wwdH8oUW8O/tPQ8pnAPcA+natMR9mXeyUGymf0Tao/byDAbL
	wdlNwFBAxaLW6gOBQbvP4HSsqQXtxm11U3+/dC8k6Crx7g4ADGmYcs0l
X-Gm-Gg: AY/fxX7VzNML9rIb5PwfmeJS/xQ4tL2ScUwEyWJ3zBPpkSVLVfwSts9JDKLYEUc9G5K
	p7UhZlHLASWTJFYxE3PIrz6aHVYgA6oefQ7jKM4mfND1F8OrFmtrxLPETUvduX58nT2di42cIff
	Ljb0uENlU146jytSJ5GG59hleqSvbtuvIclofejN5oviqllXHUcshOabKLHHaCKjsWU1DnuwpM9
	VIF34d/4Vi4q97CNDZKoTPHs4Q9xs2WIugnFpjKAelx5vqHxGVD7wb1J+IWLbhLaHV23zOwvsP8
	gITjQuQJ9lNuKxlv0wZQZbSkC3wW9IXyfXOSb6CWpmmMnTk5VEY9Ymf8UJ+dMwg/blROmzUZJVA
	gUGgOlmvOOp0c+F1Rq62EkwZ1BcJvD2gRHiWl2mHkwfEWh6YyRJ+dWbSHFzZZq7ukxLZ3t9meBA
	l78gRzR9XOOZA=
X-Google-Smtp-Source: AGHT+IEk2aJ9UE/bZeArjHeXKBRUIba+EThMiA73rubHvR6dRlwwPP/qhKuoL9TgS40b/KEUUho3HQ==
X-Received: by 2002:a05:6512:b8c:b0:595:99c3:cc1c with SMTP id 2adb3069b0e04-598eae5a7edmr1945468e87.14.1765378834679;
        Wed, 10 Dec 2025 07:00:34 -0800 (PST)
Received: from Ubuntu-2204-jammy-amd64-base.. ([2a01:4f9:6a:4e9f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7b1a3d9sm6467904e87.4.2025.12.10.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 07:00:33 -0800 (PST)
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
Subject: [PATCH] vsock/virtio: cap TX credit to local buffer size
Date: Wed, 10 Dec 2025 16:00:19 +0100
Message-Id: <20251210150019.48458-1-mlbnkm1@gmail.com>
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
 
+/*
+ * Return the effective peer buffer size for TX credit computation.
+ *
+ * The peer advertises its receive buffer via peer_buf_alloc, but we
+ * cap that to our local buf_alloc (derived from
+ * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
+ * so that a remote endpoint cannot force us to queue more data than
+ * our own configuration allows.
+ */
+static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
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
+	ret = virtio_transport_tx_buf_alloc(vvs) -
+	      (vvs->tx_cnt - vvs->peer_fwd_cnt);
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
+	      (vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
 
-- 
2.34.1


