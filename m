Return-Path: <netdev+bounces-223788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A68B7E4B4
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C85CD7B5349
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FFD2F2906;
	Tue, 16 Sep 2025 23:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFDCioro"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29FD2D8383
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066236; cv=none; b=gcEdnrq0L3AFCrrhTiC8Jl3nNmqMQUuk4MaGjMHkTiy0gG8H4jtKtzkdkdWC/YgugZSnbNLq7hW5nqmuUOedEqvLw9KmRABQkE2SzUmsE6sCcIDx9N0B3mRE0zSUcbDxs36+c6O5jSEgGGNhQ2nXya8WlmgVj30bpvNcuJBFis4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066236; c=relaxed/simple;
	bh=W8gd6XhWQ6pvri0xbAF1EAgDb4RZn2xcu5cNNgZFNfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsgSKt/2mNuwakJjZcjxR/yPG4zY2ViA7BvtHN4ZV81V3sdtrNvOTI7W3eGvDLdLhGgDqD8HZj/r2Nf5j8BU7XTExP0B0RfBoOfVFxvITI/xLz48iZUKNPVoMZB7L9pUahilrsgC0lG6xoPBdt/KMTIRbSkwFcQHq/BOm8SI0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFDCioro; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2680cf68265so687765ad.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066234; x=1758671034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJb7YbnroGsFtLz5T9G1lwB92kjtyMi3xE/F7vK5JjQ=;
        b=CFDCiorouBgrTtHADayhVGin8siFjn9RXQTl6LQ5IEBv65PSBsrOMVLddUYCO2gv6S
         SpSK+2+/J4Ndv8/onlVkAJtF++c+FmUGVplPAi6XwrqHTI0UpTSPuHXSkhKvmErilHUe
         GNTBDFCdyzSC2LR2YZojmo/DiLSAf6Q6JzIZcCqb4GZ1cOIWY1QiNPZkgFtmrm30QOCq
         WZlJdpiSXeX/rtB3XwG98VVVXp8NvmMtssvV5In/KCOq+lYwbPnj4WLRpt/3b2hWKjyi
         elDtaa4Yfh4WeSAI4grmazua+vRUqDHdJPrvbsqT4JOauddLfwkTi1cN4uqQt/fvWbPE
         deWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066234; x=1758671034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJb7YbnroGsFtLz5T9G1lwB92kjtyMi3xE/F7vK5JjQ=;
        b=qAq+2QDichuqyr0jC7afkl2PoXtkM0MamzIA+36Vx9H7HvpCQF0iar5d2rXOKfzUnn
         s0P5fbJuoo2+sdx1GERl5f0ZmarMg3r4hJ+b3eTy81QoQOGuzL0RnOlXypXxNiFiHGEw
         6N/rIwqc7dW1VcDGYV5CmoH+G4X7RstVGw4Kk8V//ZJ+tLvanmUExp4hGLgdpUgsXnvW
         1ACFsW+GqbVq8J7ycqgtBhAo1iDZQD9p9C1pAcFh2bBU5CeKWclptk1BYbQkgI7oFpdM
         3gB9ZhKN9EmH3pM1sJueaRICyvYvV/Ah6KhOkVwiPw3zHS1R6EzWOK7XMfc0apO+RHeb
         XDVA==
X-Forwarded-Encrypted: i=1; AJvYcCX7GL2BqxTqf8jKBA7+M1AWHUrVspFkl+Mm37zdJLGK+PDQ5eoRxt+WAOmhw/ByN00DIkWkMa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxogiHuqV+5DXWZlshWFamdxAaGulFREK3YLC1UDQ+KsLU+g+5k
	hWJx7q4VBFF9MFe+qY+wR7tRmvvN6ey+UZZL5K0x734cENw93EF0Uhdb
X-Gm-Gg: ASbGncuVobv3wEvjcEbyAu4rHkMD6oW8qEoHEE7pkvLmJnhz/P2HAgoE4mWaLdbNwsA
	zPzjPVd2VrPx9/OfW0N1xRgJtBz5RJ7ho1JXbCE7bNnzS9aYathbPjwcv/O8UQ+P2QWG+29zjYE
	eQMMXuIEfVQL3ZpECXfQjG8cglDdFndikynDeJb4QiFq/hF4NXXJvdHyUwnDLB4sUZ+xCw4K9p+
	b15RV2yJaElhDI3wb7E+UUFzGTx010+iSRmkePHC8wT6sj+Nr5XvW17GPlzf2giD5OKlBAkaDSp
	shDLXaxli/sd18hKT06/Jgcb1XbO7+Ed4kBPnOhLQTHgmRX+GO998q/mbrcFDdDcFrL/KCU6Its
	/zKBGPVnZVm2qkr6HDOZd
X-Google-Smtp-Source: AGHT+IF/xw2akPqfiTx346iDoeH7Z1/kqJEVjbR3GnSIaOpGaqTCjMLhCHfObu3TSyZ9Zry5A1RkkQ==
X-Received: by 2002:a17:902:ec91:b0:267:b357:9450 with SMTP id d9443c01a7336-26812179838mr1096375ad.17.1758066234099;
        Tue, 16 Sep 2025 16:43:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2679423db7fsm59353765ad.70.2025.09.16.16.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:43:53 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 16 Sep 2025 16:43:46 -0700
Subject: [PATCH net-next v6 2/9] vsock: add net to vsock skb cb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-vsock-vmtest-v6-2-064d2eb0c89d@meta.com>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
In-Reply-To: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
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
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a net pointer and orig_net_mode to the vsock skb and helpers for
getting/setting them.  This is in preparation for adding vsock NS
support.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v5:
- some diff context change due to rebase to current net-next
---
 include/linux/virtio_vsock.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0c67543a45c8..ea955892488a 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -13,6 +13,8 @@ struct virtio_vsock_skb_cb {
 	bool reply;
 	bool tap_delivered;
 	u32 offset;
+	struct net *net;
+	enum vsock_net_mode orig_net_mode;
 };
 
 #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
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
+static inline enum vsock_net_mode virtio_vsock_skb_orig_net_mode(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->orig_net_mode;
+}
+
+static inline void virtio_vsock_skb_set_orig_net_mode(struct sk_buff *skb,
+						      enum vsock_net_mode orig_net_mode)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->orig_net_mode = orig_net_mode;
+}
+
 /* Dimension the RX SKB so that the entire thing fits exactly into
  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
  * rounding up to the next page order and also means that we

-- 
2.47.3


