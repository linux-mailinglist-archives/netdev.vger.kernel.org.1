Return-Path: <netdev+bounces-231257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD0EBF6AF9
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652C519A4F0C
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB9B334C3D;
	Tue, 21 Oct 2025 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYca6u56"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF4334C34
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052344; cv=none; b=ehFW9LoHaCTxQ/c9GhiD4jOp8NzkAyXn2pLpFPJ7CHNWBhzP4N8yaTC1nPMxhqK0tTk8CmJdZTXgDLuGDELeIxL5jQBzAgxpJVftxzxVvjieiGMSxIefWFu3bShHdYfag85XQoix/gOh87GafwdMKB6zgDdEWunAhwSkeHOpH7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052344; c=relaxed/simple;
	bh=pQPr7htILs16jic9LGLLgnMQ6ijlAqDBjUrkgVTGwJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vh7VofCite8lAGIx6qW5BaKHcQo3eEKq/peZOoasRfyUiz64OmIb1EuhcionL62voR5uUO//+1lBHKSxYyN5XCQ6vraiRkF44OyJ2myb8BmgSM4rCcPbAtoBoedOWzpkVmgaUurYQxjH4D8ja2+0huI8tTUes6CLgcXzAaWbgcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYca6u56; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-782023ca359so5497291b3a.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 06:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052342; x=1761657142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/dnLWTXFqXm9s9XxXu0cafb5DL+nQFgTeQspmwu09w=;
        b=RYca6u56war0QxnjTIT9I0xjrODdab/pxsHUpvSChL1Yif+9d3X34m5nbX7Vyqno4h
         tq21gSzc0afSrOgdbsQaKzWNjcvD0NyJmZo7cC2ZvGslH+XM8N2cHKjbuO0nTEub+dA2
         P23a8TdjPiK+bL50Y8prJEF38n1s6E/SNYtjMgxKR45UMi40Yia3rh1Y7FMvPJQ2c7Jj
         vGNTeHvCX/jk8/N59KBXfvaKqzhMq4DYAqqTnpPLyNmAUBvIfLtttjvuvdtKZUcOHEx6
         N5E4+LbSRywOcSk/sNyZCobwPNR7OWdccewW/ilW47+/yNZwiEppE3FBLj9WFMdeYqJz
         irzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052342; x=1761657142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/dnLWTXFqXm9s9XxXu0cafb5DL+nQFgTeQspmwu09w=;
        b=rb/81xTw+twShg4fsw0CwJxvmxmmTR7+Q1RangWeLCsunZJHOPIbAO5DmPNIbF0TWp
         XiUpNCHs6ILZUmSCMctECvwJLmNXB0Tkn6Yb9bzMm2E1shX3CEbJQB7XJeVyKvvVUBuo
         XdAVe1lHzJHoSpqDEA6mME1hJjc4Vo8vSzu8c9ogqjbkKwTCcp5LYKSmUIoDtCOq8RMc
         POmuer7t/GLQMpZ7mh20zw4lgDbxDwgBPUQUyA1Nt/37juLiyTL5/LaAtmRRtBiLBj+Q
         3f+fjYasYCftp5HwMvR+KE2NBpCgalE3DRha/CO3NjPZCUaM+GNTb/MiJRItDCAWiqQr
         gg+A==
X-Forwarded-Encrypted: i=1; AJvYcCXQeROw86ES5fjRcbruL+PHI7arHXFKIYRRqae7XJzLlSptcGXKBrIHuYvr2pCNY8TFVFTIZQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyVYDopm3iVR54Z/dduSxpMYOPouCFmJ6NCAPf9IUe1Hkkxlhc
	UqwjkrE3qImeifRjvK+x5uQtnS9KZMe3zJbFzjuGNitP+HF9mXKpduzU
X-Gm-Gg: ASbGncu6BCVwb8mWYvkcSFjsSLWSVJA26sXRK0BqeuGx83zryQ2Djd3aRmiWQmaPRIB
	7tqAMoyHCjUHyEkE1nwGMVSkHaza2GcsVzEWIVYq9//0lBaDcy9QqgxAo3SIje0Q7Pf1rlxAg8y
	feuX4NvXq/jp0YRagF0bZ5WqTzJxs09HXXySJvY7mYat7QRjcFUpjk0iIwxtER6tFbT1wyryxLK
	L0R/+/8gjZiWW/0kbIEELrbprPLHHC/uQN0eugkv+zlB3GGqF8tY2zP4XSFWywXKTSOxtE2n4A2
	0yCUltZOKNIkAblGXc/lsF3Q5gZG0RN5LeZTApFHp0gF/gFJUAn5sqCEbP76FxfOSowEqsJ7q/P
	zwxlUB+pMpohe9vxl50E1i1jn3p2aVLQOtpPlt9FtsImqikSnPdt1q2sGHETXxipWzr7ze//hA/
	HnQwpxUJJPGCFtj/JbH2Uif0Y3z9ImnNtHHR8zUL+YnDSIQAvBkbK9HPXw3w==
X-Google-Smtp-Source: AGHT+IEcf3sRiDeIqkzjrl4nyqdLulMa3wDRCJ44nvcE0oww6QkDtoBkOGRxj/mKX3YCR8vazUB1MA==
X-Received: by 2002:a17:903:2990:b0:264:8a8d:92e8 with SMTP id d9443c01a7336-290ccab59b1mr206049925ad.59.1761052341628;
        Tue, 21 Oct 2025 06:12:21 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9ddsm109248175ad.89.2025.10.21.06.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:12:21 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 1/9] xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
Date: Tue, 21 Oct 2025 21:12:01 +0800
Message-Id: <20251021131209.41491-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251021131209.41491-1-kerneljasonxing@gmail.com>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add a new socket option to provide an alternative to achieve a higher
overall throughput with the rest of series applied. As the corresponding
documentataion I added says, it might increase the latency because the
heavy allocation cannot be avoided especially when the shortage of
memory occurs. So this patch don't turn this feature as default.

Add generic_xmit_batch to tertermine how many descriptors are handled
at one time. It shouldn't be larger than max_tx_budget.

Introduce skb_cache when setting setsockopt with xs->mutex protection to
store newly allocated skbs at one time.

Introduce desc_cache to temporarily cache what descriptors the xsk is
about to send each round.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 Documentation/networking/af_xdp.rst | 17 ++++++++++
 include/net/xdp_sock.h              |  7 ++++
 include/uapi/linux/if_xdp.h         |  1 +
 net/xdp/xsk.c                       | 51 +++++++++++++++++++++++++++++
 tools/include/uapi/linux/if_xdp.h   |  1 +
 5 files changed, 77 insertions(+)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index 50d92084a49c..7a8d219efe71 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -447,6 +447,23 @@ mode to allow application to tune the per-socket maximum iteration for
 better throughput and less frequency of send syscall.
 Allowed range is [32, xs->tx->nentries].
 
+XDP_GENERIC_XMIT_BATCH
+----------------------
+
+It provides an option that allows application to use batch xmit in the copy
+mode. Batch process tries to allocate a certain number skbs through bulk
+mechanism first and then initialize them and finally send them out at one
+time.
+It applies efficient bulk allocation/deallocation function, avoid frequently
+grabbing/releasing a few locks (like cache lock and queue lock), minimizing
+triggering IRQs from the driver side, which generally gain the overall
+performance improvement as observed by xdpsock benchmark.
+Potential side effect is that it might increase the latency of per packet
+due to memory allocation that is unavoidable and time-consuming.
+Setting a relatively large value of batch size could benifit for scenarios
+like bulk transmission. The maximum value shouldn't be larger than
+xs->max_tx_budget.
+
 XDP_STATISTICS getsockopt
 -------------------------
 
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index ce587a225661..f33f1e7dcea2 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -45,6 +45,12 @@ struct xsk_map {
 	struct xdp_sock __rcu *xsk_map[];
 };
 
+struct xsk_batch {
+	u32 generic_xmit_batch;
+	struct sk_buff **skb_cache;
+	struct xdp_desc *desc_cache;
+};
+
 struct xdp_sock {
 	/* struct sock must be the first member of struct xdp_sock */
 	struct sock sk;
@@ -89,6 +95,7 @@ struct xdp_sock {
 	struct mutex mutex;
 	struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
 	struct xsk_queue *cq_tmp; /* Only as tmp storage before bind */
+	struct xsk_batch batch;
 };
 
 /*
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 23a062781468..44cb72cd328e 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -80,6 +80,7 @@ struct xdp_mmap_offsets {
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
 #define XDP_MAX_TX_SKB_BUDGET		9
+#define XDP_GENERIC_XMIT_BATCH		10
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b0c68a70888..ace91800c447 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1210,6 +1210,8 @@ static int xsk_release(struct socket *sock)
 	xskq_destroy(xs->tx);
 	xskq_destroy(xs->fq_tmp);
 	xskq_destroy(xs->cq_tmp);
+	kfree(xs->batch.skb_cache);
+	kvfree(xs->batch.desc_cache);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -1544,6 +1546,55 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 		WRITE_ONCE(xs->max_tx_budget, budget);
 		return 0;
 	}
+	case XDP_GENERIC_XMIT_BATCH:
+	{
+		struct xsk_buff_pool *pool = xs->pool;
+		struct xsk_batch *batch = &xs->batch;
+		struct xdp_desc *descs;
+		struct sk_buff **skbs;
+		unsigned int size;
+		int ret = 0;
+
+		if (optlen != sizeof(size))
+			return -EINVAL;
+		if (copy_from_sockptr(&size, optval, sizeof(size)))
+			return -EFAULT;
+		if (size == batch->generic_xmit_batch)
+			return 0;
+		if (size > xs->max_tx_budget || !pool)
+			return -EACCES;
+
+		mutex_lock(&xs->mutex);
+		if (!size) {
+			kfree(batch->skb_cache);
+			kvfree(batch->desc_cache);
+			batch->generic_xmit_batch = 0;
+			goto out;
+		}
+
+		skbs = kmalloc(size * sizeof(struct sk_buff *), GFP_KERNEL);
+		if (!skbs) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		descs = kvcalloc(size, sizeof(struct xdp_desc), GFP_KERNEL);
+		if (!descs) {
+			kfree(skbs);
+			ret = -ENOMEM;
+			goto out;
+		}
+		if (batch->skb_cache)
+			kfree(batch->skb_cache);
+		if (batch->desc_cache)
+			kvfree(batch->desc_cache);
+
+		batch->skb_cache = skbs;
+		batch->desc_cache = descs;
+		batch->generic_xmit_batch = size;
+out:
+		mutex_unlock(&xs->mutex);
+		return ret;
+	}
 	default:
 		break;
 	}
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 23a062781468..44cb72cd328e 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -80,6 +80,7 @@ struct xdp_mmap_offsets {
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
 #define XDP_MAX_TX_SKB_BUDGET		9
+#define XDP_GENERIC_XMIT_BATCH		10
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
-- 
2.41.3


