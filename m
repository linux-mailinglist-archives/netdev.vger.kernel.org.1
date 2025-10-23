Return-Path: <netdev+bounces-232221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B39BC02F50
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 20:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBC3E50393F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B9B34D4F5;
	Thu, 23 Oct 2025 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPRKKDH8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CBA34B1AE
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244094; cv=none; b=PikkZOGjcWjgka6tDf3o6c3JnzaIf43z9KZGLFclNyYv18K7QXkBreUdWvWhburQXcL3Pqai7hRevbUZJS7C0EwEqU65miMRdkLA3ohUHfWOOU+o3jKLEpFhXCizZanwGsmtY7aWfeN2zgJHo6jwo3OKPx98T9C40fpwTJl0b4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244094; c=relaxed/simple;
	bh=/NnsC3/kyQkEuJK5iOUFqzrZwSnxBzzrLIV6TJlSX58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SIMvdqua6fTHL73rfHe4ZA+dpNhAQbpRoS4j7Tg6GvGfO0nMLhBoxPZqSJTUH6aGzgp+9nyraN8B/jr/PJ+jRGUd23llpQLrUwpI99AQG2GEgUnZ3s4GUa6c83ApP1oRP9StjLLNiT2uAsyJfjn5A9akNnUX1gzQ3Mfiu+EVyO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPRKKDH8; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b55517e74e3so1115233a12.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244087; x=1761848887; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/1b6yRMCqBZzs7tcE4MzTOrQu/agnNRge7CXTKa+MI=;
        b=TPRKKDH8XrBk5rLrPo62mWYsMVyGUT1Dap05tyaLhbEe8BhVhGFYgWX94whDYZI987
         5sXL8jHFGMqdCUXNCoTIWrgxnSWyYN2tctS/AW53U1pKM+VkR1hl1O38k0UCk+PLd7Ik
         Gg1EQh0C80BhpMx8ST+tiQA4O2UIxt5k3lN+gAB4A5+AvPEcrgMLOyb000M3Kz6fcmGY
         qGpSzUtCOVtP1zxyuBsp2y/ywXm/162dCEUpH1+bgZUWRpEeqjk/iN6ClpCNrCrs2WYH
         jIg6eaVV3v4V0EBZOG8LtOABMzphoh9ZYmDdG0O76yF0pqQWnyEUGk6d4DEENKsHh/w8
         6k7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244087; x=1761848887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/1b6yRMCqBZzs7tcE4MzTOrQu/agnNRge7CXTKa+MI=;
        b=Z4eXWtZdzoEB5aoPoRgxen9cVao91dCDUhYcFjqd9/Lc6uottLdSAA37qQh+mQqwvv
         kg8RdUn6moPzTVytMar8eIQ0/LufD3Q26qRui9S8KU9NP3kHTnqWZqUE1AZwJAJvuXlQ
         /jvGx4vY8j+ra8x790K7x7ZxvfT5BNM44YfClxzvXVdvxv4lruXqYYy6h81/TseKrMXn
         7S1nxzUFCfM6ZmBTRvISCvzVhRBSxQfK2QR4XzCejFV/sEXJO9T0+/gIybBKpohjSkUX
         9NV/5HPDV1DUFI2B+bycdsOnlStSHEHI7jUd4gUnnrIHha+0HPgP/FuGD1lz7NHzxfhD
         Xdcg==
X-Forwarded-Encrypted: i=1; AJvYcCV1r8zUwb/ySJuQrg+OvXSswbaKtQvhCf3iMygZVAj4BfiH7qVcDz7ynYq+2OTOfR5xpptZf7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx42KLI7QJNnmMcBn+DxbAVdFhz55eoIZybuNHM2c+Xf/IFXaFX
	7Tk/l9hJxhyFk6TV/brhHQzJs5jvpROK1Qu7jzxNSp3Jc4fMo6EJIN/Fv9jUb0Re
X-Gm-Gg: ASbGncshmvays7McSJOIDgqoZmwzvSJGCqplwqGJyby000kK82sPkuSTRHnvM+akQ+X
	gBZT95ye8+zjrjHskCWPj6OdankSwdOnW6YCD85rsbogcAtG3sdof/gCDeNzF/v81ft/dzwHZ4x
	VApthHavONBnwUO8AQyTV8RgW/gENDWpZcto1ZUP9OqfEAHpXzY9UoE5vYTHt1a/pcBccReajf/
	isJYyfIKI9uYr6uVsXvpvc5SrF4ALOHAYOPYZYiXmwmibicVRYqY0dQq/gt277A9haMcLzh/mSp
	zZxfq7VA5CX7Vhp7xyqRwIJNXeMI9AvbrtvQNkkQ4FIpipIDr398ebFz2i8pRuRerWC4yv2LA8L
	2ci0H+/4/tU3xPWuvWav0op8mpciSRH15TO7qvfGQRzn+3/BzAFZlunXGGB0DTXJRc1VxLVK7O8
	wh7tDN+IPm
X-Google-Smtp-Source: AGHT+IGRrKHIe8i2PewhMjRBhP1W+eQCJR1uY99As6NL8XQQmuNG2L450IKTPePeAvu2qClkS7Jbsg==
X-Received: by 2002:a17:902:dad2:b0:293:e5f:85b7 with SMTP id d9443c01a7336-2930e5f9113mr89467435ad.11.1761244086676;
        Thu, 23 Oct 2025 11:28:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0f06d5sm30959555ad.82.2025.10.23.11.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:06 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:42 -0700
Subject: [PATCH net-next v8 03/14] vsock: add netns to vsock skb cb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-3-dea984d02bb0@meta.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a net pointer and net_mode to the vsock skb and helpers for
getting/setting them. When skbs are received the transport needs a way
to tell the vsock layer and/or virtio common layer which namespace and
what namespace mode the packet belongs to. This will be used by those
upper layers for finding the correct socket object. This patch stashes
these fields in the skb control buffer.

This extends virtio_vsock_skb_cb to 24 bytes:

struct virtio_vsock_skb_cb {
	struct net *               net;                  /*     0     8 */
	enum vsock_net_mode        net_mode;        /*     8     4 */
	u32                        offset;               /*    12     4 */
	bool                       reply;                /*    16     1 */
	bool                       tap_delivered;        /*    17     1 */

	/* size: 24, cachelines: 1, members: 5 */
	/* padding: 6 */
	/* last cacheline: 24 bytes */
};

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v7:
- rename `orig_net_mode` to `net_mode`
- update commit message with a more complete explanation of changes

Changes in v5:
- some diff context change due to rebase to current net-next
---
 include/linux/virtio_vsock.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 87cf4dcac78a..7f334a32133c 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -10,6 +10,8 @@
 #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
 
 struct virtio_vsock_skb_cb {
+	struct net *net;
+	enum vsock_net_mode net_mode;
 	u32 offset;
 	bool reply;
 	bool tap_delivered;
@@ -130,6 +132,27 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
 	return (size_t)(skb_end_pointer(skb) - skb->head);
 }
 
+static inline struct net *virtio_vsock_skb_net(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->net;
+}
+
+static inline void virtio_vsock_skb_set_net(struct sk_buff *skb, struct net *net)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->net = net;
+}
+
+static inline enum vsock_net_mode virtio_vsock_skb_net_mode(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->net_mode;
+}
+
+static inline void virtio_vsock_skb_set_net_mode(struct sk_buff *skb,
+						      enum vsock_net_mode net_mode)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->net_mode = net_mode;
+}
+
 /* Dimension the RX SKB so that the entire thing fits exactly into
  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
  * rounding up to the next page order and also means that we

-- 
2.47.3


