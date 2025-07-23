Return-Path: <netdev+bounces-209454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307D2B0F96C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20FA177F16
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1F823ABAA;
	Wed, 23 Jul 2025 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ys+4YOLq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED57238C08
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292217; cv=none; b=HiHu4D90cIO1kp2AntF1uQzVsuuFXy58TzO8G2cIsUmwlsX01UG6dcJqfHPely7psq5sXD5GQqST3uDNAw35/XuXDzS+YPzbwC1NDaPoTY8Oj10i5aaApP+2ylCPsyQdtLkYdRDM/CK/JB2Kwd7xmvSzTsd7pi29b7W4wxFqj98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292217; c=relaxed/simple;
	bh=UrcEjAg7GAkkGyQDzwig33nkBHzaiJ8mDJM9SnuShQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DMA68wqS1zmiE6ulO3UPjOyCzri/SG24iDJNghjaTwluXOvo4NW4lL5ZdwSin4UHBLQHOhnTqsMAaHp3EOsYOD1SHA04SLybw68/RFXv+Ms2OMOduxbXQLbkfCHdIPQ3BmK7o8WzIfvYAJhYd2j5wdOmnVDHrOofZQvo7zGDooM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ys+4YOLq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso21469666b.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 10:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753292213; x=1753897013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLwPvI2GvffjhdIVFmDYNGuO77u+LYC11J3gQUdVDAE=;
        b=Ys+4YOLqd1qswoeSDDIpvRdWMWmFM/C0sNMryFEiacpXlFONyFfishqKrj89HQPtEG
         UeDAcn/Vs248SLjBibsHtjj+aD7wr9q/gBECBsxG+tnYIEuhQVznaieAsPzZGeU6XK5w
         aF0+eoeOhY77cluoZJNmVYF3eVbsE79duJm3DvAKHmCCKs5/FjnxyY1x7YV8u1APkIzv
         KSif+vx9pIC3+dUJhOTKxM02mUNkl6EhKjj9RaiuWUQpbQb3y8mXxnAWQICDT9gX6imH
         xxiZTbHiaL7G0Hyjk8wz351oV4c6PMtrUOH/m7rZOPui0yccakFD1+Pm14Y+TUELqkeq
         xDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753292213; x=1753897013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLwPvI2GvffjhdIVFmDYNGuO77u+LYC11J3gQUdVDAE=;
        b=fKEL06pE/xLXl4ysZhzCQlSS4XeY3mucOvXhFLLIOH25EoFDULE+czw0RBtz4YliNK
         PKGa8RCQaFUKhfrcLngio+mitrZJWtJfyQWjQ94WJzFLAE9PxOoatYfgwCNeQ/UKeGuH
         XQtu4fpUALIGGkdzY7zkZAxdQ2XMGon99jCYgCOykaDksoLntDn9b5sC8jxoHxaAyczi
         eNJE2Po5E8mxFBLom8pA4629Sr4gJcZvds7jll+s0a8dDqY/hXEvL5UrPKZPIPmF7GEK
         5kMuh2VVanzfaLg13cUnEDgDdyHcKfA0+tklx4tu/NxylHvO/rmWtsNEAlRzNAV5Bi2S
         STOA==
X-Forwarded-Encrypted: i=1; AJvYcCXqYAIgQRPDdV3EENA5mkzA1WMtFnJaexqq1UhVzPlFCuDQyN9M13cmcPrsCcd7FGSAr4Xuvbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1H/mf6M+gndLo75bNeqlqUIlMIoC5tCwqLDKhbIDAqAgtxpKJ
	gz1su2ALgkapzNadKNkhUd6g0p9A+HJQ6RCvrNStxhgXHUQFEnudZO57WMaWVitRskk=
X-Gm-Gg: ASbGncsqKHiKnFgXQOLY8ClyjFn/yZ5ncMv2Bb/gzmUGBc2nVbYngpS/0FlfcJcRs5r
	OpF5Y3Vo6mkDmIvwDHaVVa2jeLBlHgldfX1CCtuFhMTrC0Mp1mEst8RnCD5P46avIV6q8QhZ0/L
	XbVgCTMYwMZvcQ1+taWVwyMw/nI0zkoMzgGTaUTUPQ0A28O5kGKVmY7t4jyfjXMgP9spr1GNb7m
	TcFzWEM/iGGzuTkobhtmJAO3YP+SyfmcL1t8IOVECngjSN2dkReOT7P3UVawfYEZIE/k6w655lQ
	GU9HCq7dbrCBFNdKqVRlqjfL4TpZM3syB+078DToHNv7BP6Ud8YL1GWi5RID8I1xUkXgOdKRiCB
	htfOtqH+Q1cTvCTjmk2qC4iDI8CS4m4xlggr5VG+KeM+Ch1Mw/elDEXRcgKhmSwrfbpQavJs=
X-Google-Smtp-Source: AGHT+IEKt1szq1AgthAoyHz3xsCLWcLUsOd2yTZiQRB78er7+8JcTBfOEed/FITXGWgXbiSpPnnW0Q==
X-Received: by 2002:a17:907:6e8e:b0:ae8:476c:3b85 with SMTP id a640c23a62f3a-af2f66d4e72mr369058166b.8.1753292212965;
        Wed, 23 Jul 2025 10:36:52 -0700 (PDT)
Received: from cloudflare.com (79.184.149.187.ipv4.supernova.orange.pl. [79.184.149.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af23e1288f2sm266167866b.65.2025.07.23.10.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:36:52 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 23 Jul 2025 19:36:47 +0200
Subject: [PATCH bpf-next v4 2/8] bpf: Enable read/write access to skb
 metadata through a dynptr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-skb-metadata-thru-dynptr-v4-2-a0fed48bcd37@cloudflare.com>
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
In-Reply-To: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Now that we can create a dynptr to skb metadata, make reads to the metadata
area possible with bpf_dynptr_read() or through a bpf_dynptr_slice(), and
make writes to the metadata area possible with bpf_dynptr_write() or
through a bpf_dynptr_slice_rdwr().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h | 18 ++++++++++++++++++
 kernel/bpf/helpers.c   |  6 +++---
 net/core/filter.c      | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index eca229752cbe..d0f39bf6828c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1772,6 +1772,9 @@ int __bpf_xdp_store_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u32 len);
 void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len);
 void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		      void *buf, unsigned long len, bool flush);
+int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 off, void *dst, u32 len);
+int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 off, const void *src, u32 len);
+void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 off, u32 len);
 #else /* CONFIG_NET */
 static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
 				       void *to, u32 len)
@@ -1806,6 +1809,21 @@ static inline void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off, voi
 				    unsigned long len, bool flush)
 {
 }
+
+static inline int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 off, void *dst, u32 len)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 off, const void *src, u32 len)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 off, u32 len)
+{
+	return NULL;
+}
 #endif /* CONFIG_NET */
 
 #endif /* __LINUX_FILTER_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9552b32208c5..237fb5f9d625 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1781,7 +1781,7 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
 	case BPF_DYNPTR_TYPE_XDP:
 		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return -EOPNOTSUPP; /* not implemented */
+		return bpf_skb_meta_load_bytes(src->data, src->offset + offset, dst, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -1839,7 +1839,7 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 			return -EINVAL;
 		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return -EOPNOTSUPP; /* not implemented */
+		return bpf_skb_meta_store_bytes(dst->data, dst->offset + offset, src, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -2716,7 +2716,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
 		return buffer__opt;
 	}
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return NULL; /* not implemented */
+		return bpf_skb_meta_pointer(ptr->data, ptr->offset + offset, len);
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
 		return NULL;
diff --git a/net/core/filter.c b/net/core/filter.c
index 0755dfc0fc2f..cf095897d4c1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11978,6 +11978,45 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	return func;
 }
 
+static void *skb_metadata_pointer(const struct sk_buff *skb, u32 off, u32 len)
+{
+	u32 meta_len = skb_metadata_len(skb);
+
+	if (len > meta_len || off > meta_len - len)
+		return ERR_PTR(-E2BIG); /* out of bounds */
+
+	return skb_metadata_end(skb) - meta_len + off;
+}
+
+int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 off, void *dst, u32 len)
+{
+	const void *p = skb_metadata_pointer(src, off, len);
+
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+
+	memmove(dst, p, len);
+	return 0;
+}
+
+int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 off, const void *src, u32 len)
+{
+	void *p = skb_metadata_pointer(dst, off, len);
+
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+
+	memmove(p, src, len);
+	return 0;
+}
+
+void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 off, u32 len)
+{
+	void *p = skb_metadata_pointer(skb, off, len);
+
+	return IS_ERR(p) ? NULL : p;
+}
+
 __bpf_kfunc_start_defs();
 __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 				    struct bpf_dynptr *ptr__uninit)

-- 
2.43.0


