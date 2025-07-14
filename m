Return-Path: <netdev+bounces-206728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A28B043C0
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01860168D12
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5D826772A;
	Mon, 14 Jul 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXNhauAR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20AC267701;
	Mon, 14 Jul 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506488; cv=none; b=AGfcfdZax25clPBMcFk3UVKusIpm8h5znLAgSHMpWyOVs2O9Qer0HqmB4mtC5acp57aFEzyNAtpjI6gMSIg+kHR8lT0qcSC4b4wyGF29S8PKEj7r3HKV18AQukggAfBhqfy0CXEldgeoL6Pza0bCvzk2lP361miXJtbWgXP/K6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506488; c=relaxed/simple;
	bh=aXuehvXRYvlandQmY0urJztIprrr/Nm70E9dGNiRXL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gpL+4ynonczSdjiZp33K6Wd0XU6gUHsnJdUjvVNvj+84VPLDAH2RVAHaxNbtl85Li6SM3YqJS31SAuJb7BVJNR9d6NGVzEumu5oGxbdmhey2hL5RE3R+J/ntsgS4VKMqOveE1q0Mxpa34ined8Xacz716PRyuqpOjcS9mx9NQ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXNhauAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B53C4CEF0;
	Mon, 14 Jul 2025 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506488;
	bh=aXuehvXRYvlandQmY0urJztIprrr/Nm70E9dGNiRXL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXNhauARGx6jZs0Wtlh7QraW7W7BAy2zQ+WYBs6JaMz+vWHg/cCK9OTUoAeZDn0n7
	 TMvlYK2RZMM/J4AuvWbsTR6eNCMB6A1At9JJBFqcTDV/RZ+vK5D63Po+amFzol5QRi
	 p70lglecPHd8NeOz08HdSOgy2Mw77ICokUOc/D5riJhD6UY15YvyZNHrUKfVLfmfi0
	 jaRKuruEbXN4h+uC4XFKHDG1yFXuneEV9dQUM82p2NJj2a0jvcv2eMk8yMBqhs8vSo
	 WsyJC0AaFBe4+EseRIaj/WowXpc0ai2OZn0OV85NDsr1yCn2hNZSM8/S2ZacKZeUZI
	 er0k1auGt7KeQ==
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
Subject: [PATCH v3 6/9] vsock/virtio: Move SKB allocation lower-bound check to callers
Date: Mon, 14 Jul 2025 16:21:00 +0100
Message-Id: <20250714152103.6949-7-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250714152103.6949-1-will@kernel.org>
References: <20250714152103.6949-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_vsock_alloc_linear_skb() checks that the requested size is at
least big enough for the packet header (VIRTIO_VSOCK_SKB_HEADROOM).

Of the three callers of virtio_vsock_alloc_linear_skb(), only
vhost_vsock_alloc_skb() can potentially pass a packet smaller than the
header size and, as it already has a check against the maximum packet
size, extend its bounds checking to consider the minimum packet size
and remove the check from virtio_vsock_alloc_linear_skb().

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/vhost/vsock.c        | 3 ++-
 include/linux/virtio_vsock.h | 3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 1ad96613680e..24b7547b05a6 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -344,7 +344,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 
 	len = iov_length(vq->iov, out);
 
-	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
+	if (len < VIRTIO_VSOCK_SKB_HEADROOM ||
+	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
 		return NULL;
 
 	/* len contains both payload and hdr */
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 4504ea29ff82..36dd0cd55368 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -57,9 +57,6 @@ virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
 {
 	struct sk_buff *skb;
 
-	if (size < VIRTIO_VSOCK_SKB_HEADROOM)
-		return NULL;
-
 	skb = alloc_skb(size, mask);
 	if (!skb)
 		return NULL;
-- 
2.50.0.727.gbf7dc18ff4-goog


