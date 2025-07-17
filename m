Return-Path: <netdev+bounces-207781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B22F0B088C6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C6A172CC4
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7616290BCD;
	Thu, 17 Jul 2025 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWej8tKI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56428D8C9;
	Thu, 17 Jul 2025 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742899; cv=none; b=m1Whsp/AsrG4Ca0zgGoIWOmqso8Q6emCNtnMpJrLy1S2KWfTe127ZUKZh1AECuL++lyt/d580udGbsGSZ59OkrHAXECzbRI9bwIMSkCuMiRuNPDlxfeXcqIbOBWUSMMChTkK/egYBKUSXRaSScW2co37kelGqLd/eUENr3RNgZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742899; c=relaxed/simple;
	bh=oTtY3jHyStEX2GnaGcXZjfEA5bS7mFHBhZ1ogKJDpQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MI5eEGL9zJU8Y6GdZWIgilUKT3fbx3g/W+PkfntPvVxRO1tDiEsA4B5PhFBRfSkiZPVsgVsR8ejhUzJwoN4BQthx0tt2KpZwwwjU1M+nfsb4M3WV2qtdVdRctpEmG7k9weOzC+r82SNTni4b9zqtPpm7iFq8yAMG3y0PWY+RPWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWej8tKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320E0C4CEF5;
	Thu, 17 Jul 2025 09:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752742899;
	bh=oTtY3jHyStEX2GnaGcXZjfEA5bS7mFHBhZ1ogKJDpQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sWej8tKIFVvEZ5VKIpU2h/5bUSPSI/FJB6b0tDr4CZTEHPfEdup+lfrtcFKOdf8ov
	 HfxAM/0nszu2FQ5dYuOisWOEBgWP1FwFLmoHeJXLyH691CIdexwr/9V40fjk6aSBUM
	 zH0eYfI0hfJuR5GSwFRKhg14dA3lJGH2dwdYiK625Ns4j5VWigZbYY8lWbiIHMh5Ni
	 mG29pB1ijlfVjgxyKVsunSmHyeGK0DCglT7z1ZBrFobBnbwoGwWngmOQ2w6BIePvI4
	 NVw89ZhcPlSYykoR5WMAueT1MA4Nm87h8d2mUqsBY+Bp/dQk35wBAjaLTtJPWGpqej
	 b++YspBsrSOpQ==
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
Subject: [PATCH v4 6/9] vsock/virtio: Move SKB allocation lower-bound check to callers
Date: Thu, 17 Jul 2025 10:01:13 +0100
Message-Id: <20250717090116.11987-7-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717090116.11987-1-will@kernel.org>
References: <20250717090116.11987-1-will@kernel.org>
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

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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


