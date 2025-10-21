Return-Path: <netdev+bounces-231445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F70BF94B1
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1375B18C7FBD
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0082C3259;
	Tue, 21 Oct 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpaFAJxZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5FB24C676
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090424; cv=none; b=CmIqUl685oM2L4IWre1VeqCB5B7O12gAaqdU1feVquk5VhcdrddbiyjpG2L1UBIYzucamjCJV02d1px+No/a1Zxu4ESPP1/LkBdXZL4xQ45GskErhMoNyu0LoY7mse4z41GILlKS+H8XcTIcI4j/uOYpyYaoSHKcAaw7dkwUdpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090424; c=relaxed/simple;
	bh=5lT5a275Jig/x0y4MU1RBKKAqav6WdTww5TZeVBwOjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C3StSxRXbavI6072VElWwGb/hGUlARxMeWZt17OzrcN2ed6Ic1LBXTltV/psq55/9cD7OwlDrPNgJV3V3Vr3LKqj/WnFArQ9ByglHh47tNsn2s7EZhAAof3FPs+75bj+5TNpgwRUQWA6FLjW5FNCptTre3HGSVRajLjvEL0+EsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpaFAJxZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33ba2f134f1so5786282a91.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090421; x=1761695221; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8QAc03+caTvAAzxQiYsQ8xN61QvIP62Vy0HUa32Vyw=;
        b=fpaFAJxZILo96dTdXQYE9qtnCzZGvnNfx9C1TGKWaKTTtCljcSQWt7cq0lbPn8L5bK
         Dj14By71004rbyJLs+BpOdTQorjgq9zF9T9YkNu3J0odu5r4T36DNJbYR1hEL0zPPbNN
         0oXkB2kqaZqO8isDfoMDnyPf/yljTJ3uhuG69qgxGIH4A+VcvSCYILTCT9IyUmygzPZ/
         ZUH2QGJxbMZzApyTPtVKqn0F6pkU244es9W+haffDeiwLa5Cntuh6xxVrX3WeclGNPd6
         E0MiDd2O3g0jFRaH0jzBhlFW/o9GH6EeOWqCsaIQSzMnz3CzFw4Rb0Pdojr3/+wrzTs3
         I8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090421; x=1761695221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8QAc03+caTvAAzxQiYsQ8xN61QvIP62Vy0HUa32Vyw=;
        b=iVmBsVIwxA5WLteZuTYuApGqzpK89i9LpRTbOYP/31Crun/L+hi2NW11jgUABejwKG
         sUdinX6pP7iG35OgVJsE3oKOZX7sKkgXmSNxOY9+oUULQziEN6RJYVyWzknthNQtNEyl
         AfgC47bpQFamaCzMjhO4QB0ViEnT9CYhN9GrRv1BeGiw09DolLWPEJ9yNHMiDJm6XHlQ
         OklM2dti2AMERVXWbNORdzaNFAgrltXlj+dl8muyNdRkxEAVlMom+xpIXnnwgBDSkyND
         l2B6lskq0MgxvvIk4ROwQffia+r88IvlijIuJPbTm5QVybnA96nHEKFcSoTqRdwpsvlh
         OdVg==
X-Forwarded-Encrypted: i=1; AJvYcCUXW3XG+JaI1j+6qEnZoTSbDpCiKUtwbGhTlObC3aYIS7JK47j5yL2bG04Woxj2hajWA9zo+14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrUGHDrJDPfktRF+jEuKrcAmQ82JXhTKpbAcsEjvw0y0XLhQJm
	PEQ9gpuxeQsnmoAe4XgS94AlBYajilVQvmUVe+rbqO7onldsY4zDSBdN
X-Gm-Gg: ASbGncux2gaeu5V18twu3huj3GnB8JslgqkW4LbobcYuPaV0Oi8CfdAePOVtgmSDRWS
	oTo5R0WWdXgleHIViwv73aCPJoSeHaLyBkCn9htHXZZD1WK5977TffptN0Zi0PCS//6DzduD3g+
	Rc4ZMtWWPR2ylne8A6TKe2HOSVw+Le+dGYiLZIFBJ6/+XLRY4ACLjIqw9ynAuysymEfpw5Y2nkV
	8VxPiBNQacc9l1H5U8c9KAOEPeWSqXzkJUaOUt3is30lxSaQWKW2ZgcZELm3VKVQEO21mYv4h3V
	jJ862QdsjI56oCRBHBG/GYWVwRpI9y43edptd5BFj5B+Yp5gYaSZwTRKyu09h4mXKa+GXlxo2iO
	J8jGBFgmSJpSRGLGUZz2lkao3cGI/CxWyvvrJKIm+qDDlLw5K4qgav65ozT2LBbA1hzZsvC243B
	ipjgfvJko=
X-Google-Smtp-Source: AGHT+IFnLd8MEBHJWDP/6T0bT9CF6tUU40IwqT7WMWTgte724ObVfh7g7Y965ujhPSVyLp4smF4h2g==
X-Received: by 2002:a17:90b:3942:b0:336:bfce:3b48 with SMTP id 98e67ed59e1d1-33bcf87f431mr27158450a91.9.1761090421527;
        Tue, 21 Oct 2025 16:47:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e22428b1esm708138a91.22.2025.10.21.16.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:01 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:46 -0700
Subject: [PATCH net-next v7 03/26] vsock: add netns to vsock skb cb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-3-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
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
X-Mailer: b4 0.13.0

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


