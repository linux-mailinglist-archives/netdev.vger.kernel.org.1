Return-Path: <netdev+bounces-250640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3639D386C0
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D12853009254
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B0834AB16;
	Fri, 16 Jan 2026 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZ6w5I0q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPTvVqDV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6864397AC5
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594313; cv=none; b=cNX858YCRJ03R/TsN36aBni1ATMl9pzQzwNogkrWCKApomLYa9gvKrytZ5ETkitZ5t2Q5VGhIy2P+OYkBdS49rFvMbm6HovjJkGF9z5j9G9TlfXHSEGhER8r+BoKk1XIemn19P14dEr3JmUnpPHjFM7UIA5pMaYU6lgcaxyjHWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594313; c=relaxed/simple;
	bh=vfLaZ/x6PhPiKKL/eiQKsaUIp8fH+OSFlnq0nAGw7+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqg0LX1f107oNW3LnO5r1R7EM3jQRMz33O82sW8SG7rVG/QhGFfe3WoJgzsamW0nFlDj6m+mXfeeA7WlY2aOOd/fWoeBhw2FiSf4sl8Sg18osswZU8SuUZwjBV/yyBiVSy+B5gZbob+E6SOZfT2jDDqWtxKyJtx6yua2nDF3/qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZ6w5I0q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPTvVqDV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768594310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOY0EgIBRqk7jAnNyMBWfVkbAAKnvpv7/putmSk3IKk=;
	b=dZ6w5I0qkQjjipb1Vx/oG/Sm8+zYY1/PDmJAh5kEIyWAS5QTmMByRIvSkuOY3F8J4fFQFW
	Ky2c6XZilncx4kEfZ7k3w2wxO480cuL4NGZA6c9XbvEPFiqvhP02aJ7bWCMOPAaSh6pb+s
	m8zYz/zgstC8JJ383LG8uwYYNmB+T7o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-i0cHxRUJOzSBTLVDi6TaFg-1; Fri, 16 Jan 2026 15:11:49 -0500
X-MC-Unique: i0cHxRUJOzSBTLVDi6TaFg-1
X-Mimecast-MFC-AGG-ID: i0cHxRUJOzSBTLVDi6TaFg_1768594308
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d3ba3a49cso26106905e9.2
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 12:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768594308; x=1769199108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOY0EgIBRqk7jAnNyMBWfVkbAAKnvpv7/putmSk3IKk=;
        b=SPTvVqDVNdGK96tUbUGV0SLN65pOsegsD8+jYANhNLrEpxoob/7e48aQ+Ne69pNXdb
         4mXb0c5Xvozqs7vyWs9/1Oser0Aag2HufRifdOI2C7jg95GCIgm/wBrJl+5aK0yNAu5D
         c1E2HFwM1DQyTtog4rDOy0z1ERZkce1g79t8niSuPEoROuP5rSQC1eD0+lyEDUZ2+91T
         gCnh3bNNLP3m+klgmIMX7zsDDtrCRQJtLmdOBvP/c8kWMBtrQeNozG/qG7r5emTWrAZu
         gH3GTjlf7ferglGw/GMtXgPva3B3CO1UoZqozFOcJIzUFxtcjxhr0YSAk8S9CIQdY1e5
         PsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594308; x=1769199108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JOY0EgIBRqk7jAnNyMBWfVkbAAKnvpv7/putmSk3IKk=;
        b=uu8KNMjpz6SQrsJ2JCREDZ+I5o12FhbgsPLO8fcF4Wi8bt5qniTuCTmZ9YZfyuQ+51
         B3zFDB1uN3rSEB2hCoW3X4GBEVGcDAABFNFkpno1umV/FLFXi/kxd2H+pq0SKj+w336T
         GacsdMYuKE9cZfVogGtH+1VnBwSoPUzYyvtNHOigP9WLaQsu1AFJd2YUQgzz+wlxa4M8
         11h/9GSTes3KKINfhCV7evKCSf0VbogNPGYBC2DSCqbZNzRCXdB7APUlzA8dU5Xl2MT/
         aKKs9Xb6lNAbcLcU6p8W7qdA44YTJtQSrPcITattjEgxIbOEhEN/E0hkWI4F7wzRFvya
         LpRA==
X-Gm-Message-State: AOJu0YwmMnksUnsMMKgIylJzaTP5sya/FrHp+1LOZO+0vHsOQvWA9ZWQ
	RRGPQ0QTuSLDzXZbe5MELiB+EibdVzETfDDmhiCWy4Kt6HmKdqbkjdko9Y8GQboT89GE2wA3Rnd
	4Xn4zGA5mVNkEtMX7Vym3K+R7QJNOHZxi8VgA9huXxjOsgGT5OZpK6qp9OmAMnuSQJov3F7c4rO
	5tLnjUBuL2nbSubQxfXaN6bBzLbgTJICp5KIuG8vhbzw==
X-Gm-Gg: AY/fxX5M3nE6b1gFfWQMBwYluhP7Ci1j1hW1Xa7Pdz6rR12RESDFL4kv7TDc8zhgXsH
	BU37J2VajWnUuKPNbVKYa9U04tN888DKN0QQ6X4L8TzzLybrGotX2axQb8F2SVKj1kpgBByl042
	OWW2fjuonkqr7erEQDudt4IK4H4Gm/KDTo3RvtUralkMyL02RL7oh8tRW21AFzTbORcjXbkRYrZ
	O1QJ4PJKacAabg0nAdKOi/gqzwEDMxklUtcIILnhozec1KW32oT0tLHMZ0cRBAg6+IUKV46y3yz
	1/5d3si+uTUS4hEioroxLxXDmQSZNQdOCeaxqk5Y42GM8be4mQU9hM9NfM3vMb57Iqwg7woxSf1
	z2Xh9Why9G+Z1mWh5kn91tcIRg8ImIJ0kvv4Gl8p5W+02rmcdVfMF7EuXCvsi
X-Received: by 2002:a05:600c:4e4e:b0:47e:e5c5:f3a3 with SMTP id 5b1f17b1804b1-4801eb03400mr47229105e9.24.1768594307694;
        Fri, 16 Jan 2026 12:11:47 -0800 (PST)
X-Received: by 2002:a05:600c:4e4e:b0:47e:e5c5:f3a3 with SMTP id 5b1f17b1804b1-4801eb03400mr47228855e9.24.1768594307209;
        Fri, 16 Jan 2026 12:11:47 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6cdsm7578089f8f.31.2026.01.16.12.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:11:46 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v5 3/4] vsock/virtio: cap TX credit to local buffer size
Date: Fri, 16 Jan 2026 21:11:22 +0100
Message-ID: <20260116201123.271102-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116201123.271102-1-sgarzare@redhat.com>
References: <20260116201123.271102-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Melbin K Mathew <mlbnkm1@gmail.com>

The virtio transports derives its TX credit directly from peer_buf_alloc,
which is set from the remote endpoint's SO_VM_SOCKETS_BUFFER_SIZE value.

On the host side this means that the amount of data we are willing to
queue for a connection is scaled by a guest-chosen buffer size, rather
than the host's own vsock configuration. A malicious guest can advertise
a large buffer and read slowly, causing the host to allocate a
correspondingly large amount of sk_buff memory.
The same thing would happen in the guest with a malicious host, since
virtio transports share the same code base.

Introduce a small helper, virtio_transport_tx_buf_size(), that
returns min(peer_buf_alloc, buf_alloc), and use it wherever we consume
peer_buf_alloc.

This ensures the effective TX window is bounded by both the peer's
advertised buffer and our own buf_alloc (already clamped to
buffer_max_size via SO_VM_SOCKETS_BUFFER_MAX_SIZE), so a remote peer
cannot force the other to queue more data than allowed by its own
vsock settings.

On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
32 guest vsock connections advertising 2 GiB each and reading slowly
drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
recovered after killing the QEMU process. That said, if QEMU memory is
limited with cgroups, the maximum memory used will be limited.

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
virtio-vsock, vhost-vsock, and loopback, bringing them in line with the
"remote window intersected with local policy" behaviour that VMCI and
Hyper-V already effectively have.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
[Stefano: small adjustments after changing the previous patch]
[Stefano: tweak the commit message]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 2fe341be6ce2..00f4cf86beac 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -821,6 +821,15 @@ virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
 }
 EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
 
+static u32 virtio_transport_tx_buf_size(struct virtio_vsock_sock *vvs)
+{
+	/* The peer advertises its receive buffer via peer_buf_alloc, but we
+	 * cap it to our local buf_alloc so a remote peer cannot force us to
+	 * queue more data than our own buffer configuration allows.
+	 */
+	return min(vvs->peer_buf_alloc, vvs->buf_alloc);
+}
+
 int
 virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 				   struct msghdr *msg,
@@ -830,7 +839,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 
 	spin_lock_bh(&vvs->tx_lock);
 
-	if (len > vvs->peer_buf_alloc) {
+	if (len > virtio_transport_tx_buf_size(vvs)) {
 		spin_unlock_bh(&vvs->tx_lock);
 		return -EMSGSIZE;
 	}
@@ -884,7 +893,8 @@ static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
 	 * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction
 	 * does not underflow.
 	 */
-	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	bytes = (s64)virtio_transport_tx_buf_size(vvs) -
+		(vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
 
-- 
2.52.0


