Return-Path: <netdev+bounces-211159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77670B16F81
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 12:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0906C3B4D95
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 10:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D162BE64A;
	Thu, 31 Jul 2025 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="d21qpCf9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164A52BE62B
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957718; cv=none; b=HLelrhh1m7BNfOI8nMmL9j/BeiAzvJiHkmPz+ZL1vWyoMnS5GvfyFlj/NInEaXxI8OFw6WQjVcBXeG6CvIrLd25MRl5rfBhwBN1o9RaBSU8fo/YcBDf7DTZr7aaO3+M/duq75pIRYrZEKNlzV4X/alH25xGIve3g5CW1pklSiiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957718; c=relaxed/simple;
	bh=RXk+qk+s6UQY7yvKq/I4XiJoyR3sBQyLwqHlSsOM5mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B2DrpMvsMHNCisLV5djR+vRtSbjFN+ngsMKo8FP+T8MiNmLYGbhZi7ywpJ8vm7w0Ytqj9D2D9QC9XAN9mgYAA36UwkETbYizQfbyN0yaD1ThZ0FaOhvL80lN9F53GN/VAUsvGXCYRQFvG/ORatR18sAvI3EcUq5JcOaafbE7nzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=d21qpCf9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-615aa7de35bso1236418a12.2
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 03:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753957714; x=1754562514; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8Dy00T6GZIA8aYOf2PXZe1Qcn9nzk9Nw4gH7seFRug=;
        b=d21qpCf997g+0raxJ7dgbI01lCwRzaRONFxnwkkwcZMc8hDzmaYwgL1nLBw52E4yc2
         d02O4rvISUQzMLlFK4347YV50xH9Fuaz5TZ/+0OEArDgzeEnzo2NPFEQN06ecMwWa2B4
         xJBrpBrZMHiO88MPpXaf4ei+MzSReA2IfVoxDVDuAfeOAYV8h0cA+ySVEw/FU1hdskE8
         YuVWI3Drk0iP+Yx/BwLkTu32RRczMuqTucYkNTp0fRRD9+g+CLW2NzJVDDKCniWO4dPh
         SYwCWanB3IhMctIVHRKgfAUbUo2wFCSrLxW6iSR9LRmNx/rE6oQpyDYZrC3UjBWv6uqy
         HzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957714; x=1754562514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8Dy00T6GZIA8aYOf2PXZe1Qcn9nzk9Nw4gH7seFRug=;
        b=nEEnaf5wR9aSHe++SYrS1ZqSOjxjU68Fh1/okrjRc5iGNJDv0dQfp5SNQujU1if9S7
         GxHeNyDkY0z4b0/m7kZJnfYloOTdREeKbYamNIimsvZSckZyn6GV7U0tnun+Ap8B7RCR
         ddILtB3NwftJZNTU0gRv4Z0UCySy1WkkIXBGbLQ2gmRELU2DDLs0vY9QQviZt7AWU/DJ
         C+aEWlHMUlg9b1W7RkkzuBQN32qcG9qziTfjJ4Hx0wELyUw9m7Wy0Z2QizAz0vBMNKLz
         KYkSBou4W79+q6k1l0qoB5Jha9Koc9y01c6/6RNeQm50A/+kls/yk1iERn/n4aXLIcHg
         Bogw==
X-Forwarded-Encrypted: i=1; AJvYcCV0naafX1RbE59nJAEPI7SZWIPCzrPjMMdI1xyOAkXKHXqN8NTHdP10DIece0z2kNvTVs6JowI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7SRgxnop4fZkwjTaqwiG2X1T1zdRFXHNiCMETCu3M93Iabxh7
	WwyQAYzgBglGWa3Q8CBCw99OMT6uNH0Wh2zEifjKnvAs/XU7WK36DebzuzgseE2dkVQ=
X-Gm-Gg: ASbGncuMmL21M+SFJI/DTDWHgM2Yj6NuOe9g04VwFbVvLPhNNHzGVSdvnDsZFvIGab2
	UjKXuip+Qvf1lyXbQbKz2wftVooHShpQtFkJ8AInIml5clKfaRetrNUkg2CTM9D/KRbh3HSen4Q
	pBUaDlDaWKtbPylcaYccrHKn1Hnn86mYzzUACzAD2S2qzHLjeO0b/Ny1J+5PIxEzgEBMI6abPsO
	UjmZPjbijdONXPXJu8w1XeL6ianiiEcxEYtLrAXHCRpZOW43q2ltAcmXRZVKjwqOL5lREJsGoIY
	OaUh4d+Qdx+IfSad3blTAszGFa0mdV3RbzSoiv162lyC8aGTJVB/lWm9UuVmOwHV174C83Cfgyh
	/jWTkRx0oSfteiK8=
X-Google-Smtp-Source: AGHT+IGl4y8H8c1Wi3IPSOKPyMvXNslw0cMaid7x3nTfnV4PIDGBuzhUxUexLMDB1e3slqDl4UJOTg==
X-Received: by 2002:a05:6402:42cb:b0:615:b9cf:ef65 with SMTP id 4fb4d7f45d1cf-615b9cff470mr862949a12.1.1753957714096;
        Thu, 31 Jul 2025 03:28:34 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:eb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffa3c4sm898841a12.46.2025.07.31.03.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:28:33 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 31 Jul 2025 12:28:16 +0200
Subject: [PATCH bpf-next v5 2/9] bpf: Enable read/write access to skb
 metadata through a dynptr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-skb-metadata-thru-dynptr-v5-2-f02f6b5688dc@cloudflare.com>
References: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
In-Reply-To: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
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

Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h |  6 ++++++
 kernel/bpf/helpers.c   | 10 +++++++---
 net/core/filter.c      | 10 ++++++++++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1e7fd3ee759e..9ed21b65e2e9 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1784,6 +1784,7 @@ int __bpf_xdp_store_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u32 len);
 void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len);
 void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		      void *buf, unsigned long len, bool flush);
+void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset);
 #else /* CONFIG_NET */
 static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
 				       void *to, u32 len)
@@ -1818,6 +1819,11 @@ static inline void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off, voi
 				    unsigned long len, bool flush)
 {
 }
+
+static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
+{
+	return NULL;
+}
 #endif /* CONFIG_NET */
 
 #endif /* __LINUX_FILTER_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9552b32208c5..cdffd74ddbe6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1781,7 +1781,8 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
 	case BPF_DYNPTR_TYPE_XDP:
 		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return -EOPNOTSUPP; /* not implemented */
+		memmove(dst, bpf_skb_meta_pointer(src->data, src->offset + offset), len);
+		return 0;
 	default:
 		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -1839,7 +1840,10 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 			return -EINVAL;
 		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return -EOPNOTSUPP; /* not implemented */
+		if (flags)
+			return -EINVAL;
+		memmove(bpf_skb_meta_pointer(dst->data, dst->offset + offset), src, len);
+		return 0;
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -2716,7 +2720,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
 		return buffer__opt;
 	}
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return NULL; /* not implemented */
+		return bpf_skb_meta_pointer(ptr->data, ptr->offset + offset);
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
 		return NULL;
diff --git a/net/core/filter.c b/net/core/filter.c
index 83df346b474e..6cce89bef456 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11987,6 +11987,16 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	return func;
 }
 
+/**
+ * bpf_skb_meta_pointer() - Gets a mutable pointer within the skb metadata area.
+ * @skb: socket buffer carrying the metadata
+ * @offset: offset into the metadata area, must be <= skb_metadata_len()
+ */
+void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
+{
+	return skb_metadata_end(skb) - skb_metadata_len(skb) + offset;
+}
+
 __bpf_kfunc_start_defs();
 __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 				    struct bpf_dynptr *ptr__uninit)

-- 
2.43.0


