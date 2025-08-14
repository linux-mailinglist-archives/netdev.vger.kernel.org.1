Return-Path: <netdev+bounces-213657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D25BB261C2
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDDC9E70B3
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629632F83DA;
	Thu, 14 Aug 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Zqfl4nO4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF232F60C0
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165593; cv=none; b=ZRFyDpIWvgBmUmiEwMJCSyF6qc31dVl2l3EYieWN+8jMaT6nSss6EeO5G61H3Uw5Vq6FIUDJG/R8GV8i96046Onidm9YLry0pLysA84rdPGTSV4IF9vlmgnHo6G7Ld37f+2Zd8FCcy7sojXmI0uLAeYjRSLNVjkY9AlS0+4PlRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165593; c=relaxed/simple;
	bh=hB7BDwBslgoWPQJOgZqNgp5clzfV5ofq22Ba55DUsmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U7Ej8kyNe6o4cHNgU+BY2pHjUa/11aVNzJMKYt+Kdca1dRPWVp6hrN4C3EoSYWrWra+4yRObYSQyNRVwUdsmoP+SB0cgEFKyisyJvzlQJY4AaHM5cjS0AS/e2wcDBJLZJVA2sTRbkGrboE/5zo7zSXl7z2YjHt75Szitkw6+cso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Zqfl4nO4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61868d83059so3240151a12.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755165590; x=1755770390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gh6oWWj+mVQ/w92jaEyisWnjV5H2EiveHHUL2sW+9es=;
        b=Zqfl4nO4+pqjQia3C/QVXVDyxg/Ls6NZbYbOSM16y9J7mXuLf36UJpIkiG4t8sqnt4
         FFt0VHbKK5T9MK9bjwhkz9JM2cgGZXwGdORM7u8pPlDqkgRzE8GYZV09DvZ/nBYQW14Y
         C320DKmh6oCpu/jNK/eGVNrGiotVp6GASDelW5fjpEBsbcqaO/6vFDbZIh8YBtHjbEQE
         5W8ZCGUqhwAxVHrliTasqn85fcTbg7MbwYH4PzfuETNhG+xXcnPToiw+jXVZ6p71feMb
         Me/1AJ06Ic6q0DW54e3Ajmklq1y+3PdfV4EQNHVA2TcynGu4/C1H7GoL19kTLhwWh3q9
         s8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165590; x=1755770390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gh6oWWj+mVQ/w92jaEyisWnjV5H2EiveHHUL2sW+9es=;
        b=uvHbzV52Znpi1aXf0PA4+dgbAGy4H2ATtJY0oBIRJGhQPqe+sOQc+yF2DMNcID27KH
         F/m+pVnRNodADF9xtAjYG233oLSYjX/iV5swfyhezxgim8otHTr8vHW6R8Fz6nl6mT+I
         5FENVao2DkYrU6fLsl6MnQYHkSQIfAE+Oi0tnyl9Y1QNvi37oLis4xWbfZxUxeWs+tW5
         rYcpT4CIFMeNwR2IAVgvzzn1ZnH5spDYWmkEyworxgv4gCsdyo3pBiELSFnls5wSa+I1
         wQcRsfBPg6qq+6Cm2lnFFbnBfM4s+qD9S1RenGQiZVGSY0GJqYhzDBvcHVLtBWbwhC3I
         8c2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXkNLycIbxwXYk7E1FQIHMoY0GHXb9FMEsZwCbrGz1aYOB2EoT9SqSZUtrVEwOJ8YnHSKDfsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKoA2SruE668yPat1726pU0yuWEi7E/uEemjGDqVfpHhJ/DXYe
	MdpAAx31nEGzfxSQKZ4DM0bkcYcnnP9prMe9hTIpNq7CqYODuaJqsHYPpJLbabbjSQo=
X-Gm-Gg: ASbGncsVaK8zqVgHyeCOSpe67Peego6Ih1UPxRGsAdvAPpH+ztaOAQYWz01H0ABk6Vd
	TCr1svgZkmntA1ZNykRZ+mAz7u5aT8motSDrtB+RCyYZMCgATlY98WXk0RjbRRUGHtxecDBqk/F
	nORGqfrSM9ubOhlToPn49tu774LtDyfBBSNtv4yNKA3p0wQr9ALzKFHK/yCRIp6Ln+WxC8GXwsD
	H1U59FUsxMS2ZlZjyFwfvZBo0kt+sV/coUX6WlC28bQ6Z8uy9LPHYfBcrrpGTufgJVHO9/QQoOZ
	fXgfZYmeY/0FWguSlWz2lQdx4g5AEzmOg+APLB9ZoktMZGPkk+K90aQDScwBre0lmXkB/OILBn1
	JzMjy3yCIxfxWJW7eXoE1
X-Google-Smtp-Source: AGHT+IFUSVwCIEK7vXvr7u4WD6A1HvKq4V0+RaF2KXgmekrxMADT+IXF0bokcjtj6N4r+zL3u1MOLw==
X-Received: by 2002:a17:907:72ca:b0:ae9:c8f6:bd3 with SMTP id a640c23a62f3a-afcbd61ca56mr199000966b.7.1755165589696;
        Thu, 14 Aug 2025 02:59:49 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:f6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a24370asm2560064366b.128.2025.08.14.02.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:59:48 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 14 Aug 2025 11:59:28 +0200
Subject: [PATCH bpf-next v7 2/9] bpf: Enable read/write access to skb
 metadata through a dynptr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-skb-metadata-thru-dynptr-v7-2-8a39e636e0fb@cloudflare.com>
References: <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
In-Reply-To: <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
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

Note that for cloned skbs which share data with the original, we limit the
skb metadata dynptr to be read-only since we don't unclone on a
bpf_dynptr_write to metadata.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h |  6 ++++++
 kernel/bpf/helpers.c   | 10 +++++++---
 net/core/filter.c      | 16 ++++++++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 52fecb7a1fe3..c0a74fb9fcb1 100644
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
index 31b4b50dbadf..63f3baee2daf 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11990,6 +11990,16 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -12017,6 +12027,9 @@ __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
  * XDP context with bpf_xdp_adjust_meta(). Serves as an alternative to
  * &__sk_buff->data_meta.
  *
+ * If passed @skb_ is a clone which shares the data with the original, the
+ * dynptr will be read-only. This limitation may be lifted in the future.
+ *
  * Return:
  * * %0         - dynptr ready to use
  * * %-EINVAL   - invalid flags, dynptr set to null
@@ -12034,6 +12047,9 @@ __bpf_kfunc int bpf_dynptr_from_skb_meta(struct __sk_buff *skb_, u64 flags,
 
 	bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB_META, 0, skb_metadata_len(skb));
 
+	if (skb_cloned(skb))
+		bpf_dynptr_set_rdonly(ptr);
+
 	return 0;
 }
 

-- 
2.43.0


