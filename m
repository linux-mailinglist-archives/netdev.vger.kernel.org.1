Return-Path: <netdev+bounces-201145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BEEAE8430
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0904A8066
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41395265282;
	Wed, 25 Jun 2025 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWT6vpi5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10802264F9F;
	Wed, 25 Jun 2025 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857357; cv=none; b=UwEIgOdAvfgb6a6i2zVA4hSLdbAw+QlLk1R2Mxz/8RByglfhIP0q04758GxfkKElInG4ASumd0ra3m9wyiUsEjskyRkANktADqKX4qSzXlWgsuURxtiGn5AgQjrfRIGSmIAaI8GiwYuxFG3FhkW0s+mpZZREss3jLuW61+bbR6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857357; c=relaxed/simple;
	bh=tzu8C7G0MXN2UCFhPls8DX7uDkR2X/rKpQJD5CnqN8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AWm6IkPfu1jbLDoNQ+I0GMcJ6GW0CM+k2ZFPfXwlcwsCrXHE1jV4zy+BW76y5iI5lgciGxwoDZXGlyiRmlDn+XMzASur4O7tkedNkgowjCfpTksQ/J4/yfPLTOSEEfDwGqkCSDsO6LZ/yNpxNuk5S9eAili5Pts3C4zk6Yqkla0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWT6vpi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48213C4CEF0;
	Wed, 25 Jun 2025 13:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750857356;
	bh=tzu8C7G0MXN2UCFhPls8DX7uDkR2X/rKpQJD5CnqN8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWT6vpi5BODHPyeVqzNQJeFoRruUOyzf+nuN/Vbk1yO1fGiePeTUm3kaWPxO5Sncu
	 mFvn0biHHgL/IrQI4LjX3M3Ji7qn2PorTm08rNQiigEUORqJjiTfV9/Ov6LfsrVqa7
	 Or632OZbPTLpFo0DqhzElhPJklq+zGMaEk84XJvUNQ+qvHI+5Psc3Pof65fdnbVKGs
	 WjBmeJM4OjItEOGxLs8PX2EdqX+u6AC3IYOPfDhU4E1bcK2shrnnRPl5h0SMnpOmPK
	 ZZXG4KHYXsP2c9quWr2apNoJOCfS3TLkV/AAs9SsfA0Mb1XMRehXyTFzkz2y0LqMNE
	 1NVVuBcFQQsgQ==
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
Subject: [PATCH 2/5] vsock/virtio: Resize receive buffers so that each SKB fits in a page
Date: Wed, 25 Jun 2025 14:15:40 +0100
Message-Id: <20250625131543.5155-3-will@kernel.org>
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

When allocating receive buffers for the vsock virtio RX virtqueue, an
SKB is allocated with a 4140 data payload (the 44-byte packet header +
VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE). Even when factoring in the SKB
overhead, the resulting 8KiB allocation thanks to the rounding in
kmalloc_reserve() is wasteful (~3700 unusable bytes) and results in a
higher-order page allocation for the sake of a few hundred bytes of
packet data.

Limit the vsock virtio RX buffers to a page per SKB, resulting in much
better memory utilisation and removing the need to allocate higher-order
pages entirely.

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/virtio_vsock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 36fb3edfa403..67ffb64325ef 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -111,7 +111,8 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
 	return (size_t)(skb_end_pointer(skb) - skb->head);
 }
 
-#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
+#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(SKB_WITH_OVERHEAD(PAGE_SIZE) \
+						 - VIRTIO_VSOCK_SKB_HEADROOM)
 #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
 #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
 
-- 
2.50.0.714.g196bf9f422-goog


