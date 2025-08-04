Return-Path: <netdev+bounces-211561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57989B1A24B
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF50E188D687
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10B626A095;
	Mon,  4 Aug 2025 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RNAF+v3J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA0B266B64
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311968; cv=none; b=k/R0DokXxq6X7QtEw8lmK5vyDtc6Y/XmbtpGYJM1hQuzJ88ncsfADcCUJHpaOSBMHQxuzat6F3OQsw89MWSSi1vyzjLlWVCjXk2ycYfMUSdG+EdIBPjVKb/Z96R6baoUpxV1YWolnxRHXE04PeLMPI7Ab/D/zGaDGuWKieyewJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311968; c=relaxed/simple;
	bh=RXk+qk+s6UQY7yvKq/I4XiJoyR3sBQyLwqHlSsOM5mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YssZrA0byEi3VcP8IjM8tOWdsUaZKXlBCEsDczJjMTDVf3BBpwRKYuyqBfW+mJMyUocBXNEPS9xEFYDh6U4AmgMSC+hx7oaHNLQ+S37tQrhgAzwD3KKKWoEyIZAE7PMGYlDi0LpspZ4t/cyMcKU6rH6ZU3L2/3LB5Rrwv1IykWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RNAF+v3J; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61553a028dfso4100270a12.0
        for <netdev@vger.kernel.org>; Mon, 04 Aug 2025 05:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754311965; x=1754916765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8Dy00T6GZIA8aYOf2PXZe1Qcn9nzk9Nw4gH7seFRug=;
        b=RNAF+v3JdsLlnKGmiR8XZQKyYHarRsB9zdQK7dsbnLUsv4142nmzPDGkqjWVSl61YK
         XU4dwa5Fycj+lkV/3Qayv4zSzGufpdkwSoOKg0XSjK4qeJ8/yCyJy9GiBIUitr59SpWM
         U7efRjVcu0DtM54iMH0XPTQyJwU3w9A7eDMAVOWuSOcbVVjGMqnGZjS4x/hL85zSjNpY
         YmxO/THCyinVabZs9TQPPXMN2MXU7kYq81p+A2GVsGhhG01f79m3J9PAmJMdR+1zzkjS
         8I5Fnf+epjoFPQczIOKL9ZO2+iODYH2Kd79rIYtFRTlWRwT1irQPuZQ3oZtEQYaVUK/D
         aTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311965; x=1754916765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8Dy00T6GZIA8aYOf2PXZe1Qcn9nzk9Nw4gH7seFRug=;
        b=iaUvukIgQ1z5xMqHy8VteLI6Or/LSmd7wlsVPJqucYgTMvdtZRTyYJIGmkadAyqVmw
         oRjm5B5FFIGHH8P2S68B6elf1rKEGxiqHeTNjlk1xMbvOIA57PAza3qA86G/JP2CQvW9
         Vuza+wg5Gyc25vSq1O03+OBCH0eYyJwES7qxPoQF/kKuhnxwUmH7T7firy0cKAMSUhOj
         aSkHPHod7PJ4nSLgDwYXk5Qx9vKshSuH9fTvL23elwfYVm5FRdwufjWdWA9NZB9nCSpN
         sKS+86KuP7gyQ0cz77C1j2CnaHSpg3M2AalKNVYBL1FZZ/1o7f5V8e8Wog9A6IEPxef5
         nSmA==
X-Forwarded-Encrypted: i=1; AJvYcCUp8q5A6l3vRpL/ZvvGX8P4omutT7L7Hn6FosqDLyD9VomjM/XT5cYliy/lDY9lfs9CpdqDBfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyepeBRVhWNngiH0SZ+aPkbb44ME83r5OJADRekxANpksX1L/Uc
	5IFlBJ07VjzUBj6JxZTS68SS1VeM97muC1mfg+fW3nZHwrVdv9UfB/hvDFQRoxrHkKM=
X-Gm-Gg: ASbGncsfAEYiiUUQICQAFD6bNLvcY8sTW/MPXlCfsTcj8wGAB4hGRfOwrpHiZHkxl2X
	gvEjkYiz5nEPFcbUn+I+QmV/1nMmJAV/symXzz/agJesUM4rtCbcbwjgbnoBJ76B/A3fR1KHOkZ
	xmuqrrZz+epFMdGT6N+oMPy2Qpclg1p5OA35tVNGA1QOivcnkVF1tGoEowl2IsnhjR5sKVcobC9
	Vo2ggRuhHFzUKv2BOE6n57gkmXfKMfqa3ADtTk4GKPWiGbqMYqnF/CRhFvyX1R3KFKfiYVFmTVU
	tNoQo+5CbEsolOf+XbrR7iiVe/1sKxxygwb8Nc5w+jJT4jhFuZvTHcoDBDsBIvIzht1LLdcHKRH
	UVRzFq177Zqkahu0=
X-Google-Smtp-Source: AGHT+IHRvUJaAsAhLMBd9JIM1XtV25tSZiYS+aO/f/yjHNY2Rh5ORYvYKxPOzheOSHNUsuaitGjhqw==
X-Received: by 2002:a17:906:478c:b0:ae9:c2b9:7eba with SMTP id a640c23a62f3a-af940044e2dmr877265766b.24.1754311964983;
        Mon, 04 Aug 2025 05:52:44 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0761f2sm731738066b.11.2025.08.04.05.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:52:44 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 04 Aug 2025 14:52:25 +0200
Subject: [PATCH bpf-next v6 2/9] bpf: Enable read/write access to skb
 metadata through a dynptr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-skb-metadata-thru-dynptr-v6-2-05da400bfa4b@cloudflare.com>
References: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
In-Reply-To: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
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


