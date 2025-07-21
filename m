Return-Path: <netdev+bounces-208547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2279DB0C1BA
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 12:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750253ACCD2
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1766628FFE3;
	Mon, 21 Jul 2025 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ROvAK7v0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC81285C87
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095206; cv=none; b=TVdBxZEIR3vk+956ktXlbfL4YOriV9BvRe7DiwR8DL+4AP6KpInn2kgMT6QOfUQ2KrvNupqfWSq9gV0mfRmCZ2GDMY+cR79YZRgrRO35NeUAa9vnxpCPRDA3Z22K6RBePAO7eIIPPYcorBJHvvSS0GJYSi8gJ/uq5Q62CxTwcmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095206; c=relaxed/simple;
	bh=Oo4kMVsx7ZooTDymDMAK7H9tMt11YTiAvZEf/x+DgYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FAKs/IgAANSupi7cx6xcK0u/+ooUAbDa8CF0wT1J4DOW+5O10yKfFkz5eeRCiDPO9nkmPpZnZsr9gakHQLW8Yg8vajyddn3SUhhD5cH+4ID1bDmHKQWuUwsLAhy2p1r1gy0pjiPOtNhiMe9yJA3C+j2OpA/gljkgcOooPpzIMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ROvAK7v0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so832388466b.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 03:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753095203; x=1753700003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owUJ8Gv9MIW5ZRdzl0DYdWGTFOtwpeoBmnLH2OxedCk=;
        b=ROvAK7v0atTTk1m6KdEzSwwiSZ0eZewnwIqGZUynNiiBJRdzchiD/AVV+TfqoSLZf5
         OJpcVaIHT3fZuC4hJ1JzHslL6VM3om5Jg36SHMd2pJmi6EThfb4L2apbStKObkG/cxnf
         ub3Uf1GZG8YIf5la88NA96+D32s54wC6aQqajilzMEFLH05BBY2HopXkTwQYKwyBnPH4
         adeZENqYG+ALD8JhzAb6G00N7pGpu+krdbE4NTZoPmHEkoNS9+s17KxIHpgzl0RRl5Q/
         REgqCJ/ark1Z9CghhyOmecthHwvfKmlUcwTzi2c9McPQ9VNI5ApnI6bpteUjlX9RqQuz
         f32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095203; x=1753700003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owUJ8Gv9MIW5ZRdzl0DYdWGTFOtwpeoBmnLH2OxedCk=;
        b=LmpHp/CDGLT2cmiOoW+W6y7WV7AIvRyr7OF+vwbXnYgYy8swgqPyIIHwQMoeI6lYjG
         v9a7h3CTFnU5VDRucUV5NcfRZGMhGm+DVAJz9qv7hVxYMaq+nHPs0kkKvMRE5jNBHzDo
         U0VlaRxYMjrKmRirgQzGT7hk1ChvhtiEGLINWwuSFPRjyAdtD6FSvLOFGLNFasMz0y1N
         X3MX3kAm6igdZKSG5PslKPOtBOs/W1F+/x8uLAoRb7B3PY3lx64QgwWsO8YuDHg0ALdn
         yZXnwhhs4kRe2Cb+ZeUZTY9gLf5gSRFPNqEvTuh6hR9WSuXoZZ6NBotLSLv/uJMilJ/6
         HKyw==
X-Forwarded-Encrypted: i=1; AJvYcCUi/QI4GPKXmj+5igsN7G3mAnhRBcGWF+RIb3IuaQM098ANBZ31iGC/0lXuq/dkSSMZXcJlUTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxJD+r+/VPb9d0TR41KDHtX8Pbp7+900d/zqUCPyJyNAkSQ1zr
	zcVIw5UoJzhXDXueCG5HFUCXZDrUF2zvxX4dmd9iINTozk/CWHH/La7/kuhsBSiUi+c=
X-Gm-Gg: ASbGncvFCxt1Ock4UfVUkYBJ0VIVwtZ7M3n8hb2VWhjqRDi+e/rvEqxqKOc2VU+HDJw
	pZXDGNO+AQ/EFf4T65HRRWCfEbcaN7gcF2HmB46zhalVIYLHpiXfQjJPGDBaeFeUbQX8yqJude4
	Z9QM3gqwHoX8yPoh7cOPV0fXPOL3daMouyjV1MmwwnzGbDeRcQhvTNnz7UG0ZaJlShF4mEhPg/Z
	X/ZyEvg44eR2H4GG60vLrULevMSA/tezVYInBcLE9UgelWrq1NTo9jfKNydzKYO1gjQGpY9Pcty
	MUYPGk6JPhIDCMiMVJ2zGUvL7kpzJqtDLjLHWKOtqClwczN9Fx4Qm+DT1hvtP9rQIp5VQxmzZPS
	E5AtmM2L5KTzwjA==
X-Google-Smtp-Source: AGHT+IF7jkXG7SrtfFp6JhxYuHr6YVSFPY11fq9qpow2NyuWcl9jYWdnV2c6RPE0rqETAm9r5qWJiQ==
X-Received: by 2002:a17:906:8c2:b0:ae3:f3c1:a5dd with SMTP id a640c23a62f3a-aec4fca259amr1229791066b.61.1753095203038;
        Mon, 21 Jul 2025 03:53:23 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7dcf71sm656576066b.64.2025.07.21.03.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:53:22 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 21 Jul 2025 12:52:39 +0200
Subject: [PATCH bpf-next v3 01/10] bpf: Add dynptr type for skb metadata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-skb-metadata-thru-dynptr-v3-1-e92be5534174@cloudflare.com>
References: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Add a dynptr type, similar to skb dynptr, but for the skb metadata access.

The dynptr provides an alternative to __sk_buff->data_meta for accessing
the custom metadata area allocated using the bpf_xdp_adjust_meta() helper.

More importantly, it abstracts away the fact where the storage for the
custom metadata lives, which opens up the way to persist the metadata by
relocating it as the skb travels through the network stack layers.

A notable difference between the skb and the skb_meta dynptr is that writes
to the skb_meta dynptr don't invalidate either skb or skb_meta dynptr
slices, since they cannot lead to a skb->head reallocation.

skb_meta dynptr ops are stubbed out and implemented by subsequent changes.

Only the program types which can access __sk_buff->data_meta today are
allowed to create a dynptr for skb metadata at the moment. We need to
modify the network stack to persist the metadata across layers before
opening up access to other BPF hooks.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf.h   | 14 +++++++++++++-
 kernel/bpf/helpers.c  |  7 +++++++
 kernel/bpf/log.c      |  2 ++
 kernel/bpf/verifier.c | 23 +++++++++++++++++++----
 net/core/filter.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f9cd2164ed23..1f5e170d19df 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -749,12 +749,15 @@ enum bpf_type_flag {
 	 */
 	MEM_WRITE		= BIT(18 + BPF_BASE_TYPE_BITS),
 
+	/* DYNPTR points to skb_metadata_end()-skb_metadata_len() */
+	DYNPTR_TYPE_SKB_META	= BIT(19 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
 
 #define DYNPTR_TYPE_FLAG_MASK	(DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF | DYNPTR_TYPE_SKB \
-				 | DYNPTR_TYPE_XDP)
+				 | DYNPTR_TYPE_XDP | DYNPTR_TYPE_SKB_META)
 
 /* Max number of base types. */
 #define BPF_BASE_TYPE_LIMIT	(1UL << BPF_BASE_TYPE_BITS)
@@ -1348,6 +1351,8 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_SKB,
 	/* Underlying data is a xdp_buff */
 	BPF_DYNPTR_TYPE_XDP,
+	/* Points to skb_metadata_end()-skb_metadata_len() */
+	BPF_DYNPTR_TYPE_SKB_META,
 };
 
 int bpf_dynptr_check_size(u32 size);
@@ -3491,6 +3496,8 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
 				u32 *target_size);
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 			       struct bpf_dynptr *ptr);
+int bpf_dynptr_from_skb_meta_rdonly(struct __sk_buff *skb, u64 flags,
+				    struct bpf_dynptr *ptr);
 #else
 static inline bool bpf_sock_common_is_valid_access(int off, int size,
 						   enum bpf_access_type type,
@@ -3517,6 +3524,11 @@ static inline int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 {
 	return -EOPNOTSUPP;
 }
+static inline int bpf_dynptr_from_skb_meta_rdonly(struct __sk_buff *skb, u64 flags,
+						  struct bpf_dynptr *ptr)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #ifdef CONFIG_INET
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6b4877e85a68..9552b32208c5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1780,6 +1780,8 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
 		return __bpf_skb_load_bytes(src->data, src->offset + offset, dst, len);
 	case BPF_DYNPTR_TYPE_XDP:
 		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
+	case BPF_DYNPTR_TYPE_SKB_META:
+		return -EOPNOTSUPP; /* not implemented */
 	default:
 		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -1836,6 +1838,8 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 		if (flags)
 			return -EINVAL;
 		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len);
+	case BPF_DYNPTR_TYPE_SKB_META:
+		return -EOPNOTSUPP; /* not implemented */
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -1882,6 +1886,7 @@ BPF_CALL_3(bpf_dynptr_data, const struct bpf_dynptr_kern *, ptr, u32, offset, u3
 		return (unsigned long)(ptr->data + ptr->offset + offset);
 	case BPF_DYNPTR_TYPE_SKB:
 	case BPF_DYNPTR_TYPE_XDP:
+	case BPF_DYNPTR_TYPE_SKB_META:
 		/* skb and xdp dynptrs should use bpf_dynptr_slice / bpf_dynptr_slice_rdwr */
 		return 0;
 	default:
@@ -2710,6 +2715,8 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
 		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer__opt, len, false);
 		return buffer__opt;
 	}
+	case BPF_DYNPTR_TYPE_SKB_META:
+		return NULL; /* not implemented */
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
 		return NULL;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 38050f4ee400..e4983c1303e7 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -498,6 +498,8 @@ const char *dynptr_type_str(enum bpf_dynptr_type type)
 		return "skb";
 	case BPF_DYNPTR_TYPE_XDP:
 		return "xdp";
+	case BPF_DYNPTR_TYPE_SKB_META:
+		return "skb_meta";
 	case BPF_DYNPTR_TYPE_INVALID:
 		return "<invalid>";
 	default:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e2fcea860755..d0a12397d42b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -674,6 +674,8 @@ static enum bpf_dynptr_type arg_to_dynptr_type(enum bpf_arg_type arg_type)
 		return BPF_DYNPTR_TYPE_SKB;
 	case DYNPTR_TYPE_XDP:
 		return BPF_DYNPTR_TYPE_XDP;
+	case DYNPTR_TYPE_SKB_META:
+		return BPF_DYNPTR_TYPE_SKB_META;
 	default:
 		return BPF_DYNPTR_TYPE_INVALID;
 	}
@@ -690,6 +692,8 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
 		return DYNPTR_TYPE_SKB;
 	case BPF_DYNPTR_TYPE_XDP:
 		return DYNPTR_TYPE_XDP;
+	case BPF_DYNPTR_TYPE_SKB_META:
+		return DYNPTR_TYPE_SKB_META;
 	default:
 		return 0;
 	}
@@ -2274,7 +2278,8 @@ static bool reg_is_pkt_pointer_any(const struct bpf_reg_state *reg)
 static bool reg_is_dynptr_slice_pkt(const struct bpf_reg_state *reg)
 {
 	return base_type(reg->type) == PTR_TO_MEM &&
-		(reg->type & DYNPTR_TYPE_SKB || reg->type & DYNPTR_TYPE_XDP);
+	       (reg->type &
+		(DYNPTR_TYPE_SKB | DYNPTR_TYPE_XDP | DYNPTR_TYPE_SKB_META));
 }
 
 /* Unmodified PTR_TO_PACKET[_META,_END] register from ctx access. */
@@ -12189,6 +12194,7 @@ enum special_kfunc_type {
 	KF_bpf_rbtree_right,
 	KF_bpf_dynptr_from_skb,
 	KF_bpf_dynptr_from_xdp,
+	KF_bpf_dynptr_from_skb_meta,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
@@ -12238,9 +12244,11 @@ BTF_ID(func, bpf_rbtree_right)
 #ifdef CONFIG_NET
 BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
+BTF_ID(func, bpf_dynptr_from_skb_meta)
 #else
 BTF_ID_UNUSED
 BTF_ID_UNUSED
+BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
@@ -13214,6 +13222,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				dynptr_arg_type |= DYNPTR_TYPE_SKB;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp]) {
 				dynptr_arg_type |= DYNPTR_TYPE_XDP;
+			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta]) {
+				dynptr_arg_type |= DYNPTR_TYPE_SKB_META;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_clone] &&
 				   (dynptr_arg_type & MEM_UNINIT)) {
 				enum bpf_dynptr_type parent_type = meta->initialized_dynptr.type;
@@ -21788,12 +21798,17 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
 	if (offset)
 		return;
 
-	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
+	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb] ||
+	    func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta]) {
 		seen_direct_write = env->seen_direct_write;
 		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
 
-		if (is_rdonly)
-			*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
+		if (is_rdonly) {
+			if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb])
+				*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
+			else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta])
+				*addr = (unsigned long)bpf_dynptr_from_skb_meta_rdonly;
+		}
 
 		/* restore env->seen_direct_write to its original value, since
 		 * may_access_direct_pkt_data mutates it
diff --git a/net/core/filter.c b/net/core/filter.c
index 7a72f766aacf..c17b628c08f5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11978,6 +11978,25 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	return func;
 }
 
+static int dynptr_from_skb_meta(struct __sk_buff *skb_, u64 flags,
+				struct bpf_dynptr *ptr_, bool rdonly)
+{
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)ptr_;
+	struct sk_buff *skb = (struct sk_buff *)skb_;
+
+	if (flags) {
+		bpf_dynptr_set_null(ptr);
+		return -EINVAL;
+	}
+
+	bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB_META, 0, skb_metadata_len(skb));
+
+	if (rdonly)
+		bpf_dynptr_set_rdonly(ptr);
+
+	return 0;
+}
+
 __bpf_kfunc_start_defs();
 __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 				    struct bpf_dynptr *ptr__uninit)
@@ -11995,6 +12014,12 @@ __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 	return 0;
 }
 
+__bpf_kfunc int bpf_dynptr_from_skb_meta(struct __sk_buff *skb, u64 flags,
+					 struct bpf_dynptr *ptr__uninit)
+{
+	return dynptr_from_skb_meta(skb, flags, ptr__uninit, false);
+}
+
 __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_md *x, u64 flags,
 				    struct bpf_dynptr *ptr__uninit)
 {
@@ -12165,10 +12190,20 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 	return 0;
 }
 
+int bpf_dynptr_from_skb_meta_rdonly(struct __sk_buff *skb, u64 flags,
+				    struct bpf_dynptr *ptr__uninit)
+{
+	return dynptr_from_skb_meta(skb, flags, ptr__uninit, true);
+}
+
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
 
+BTF_KFUNCS_START(bpf_kfunc_check_set_skb_meta)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
+
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
@@ -12190,6 +12225,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.set = &bpf_kfunc_check_set_skb,
 };
 
+static const struct btf_kfunc_id_set bpf_kfunc_set_skb_meta = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kfunc_check_set_skb_meta,
+};
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_xdp,
@@ -12225,6 +12265,8 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kfunc_set_skb);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb_meta);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb_meta);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);

-- 
2.43.0


