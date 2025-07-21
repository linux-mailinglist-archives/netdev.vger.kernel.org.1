Return-Path: <netdev+bounces-208550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0BCB0C1C0
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 12:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBF918C16C9
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BFD291C2E;
	Mon, 21 Jul 2025 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="T7EPI8K2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1E428DB74
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095211; cv=none; b=qarVUMzCa4TDxjEmFYgMEJt1GW6oVh+H7FSbocgpB+osP0ktDm2lh+HON2maTsHIg5lIxBc3vnbPyXUKtbU3hemqcaoSSq59CTTMtuBZ+6QZj0LvLgy7inBLZep9Q/raowh7GVft72bjF8ljUz6LENnOxtDVRBR6X3OXVd1Ka1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095211; c=relaxed/simple;
	bh=EKVi1B3hsRotODsWoGkxDTX90Rkv3IWwN+P0v/vZVnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLmHLFxLCBafSX8DFy3PRxhox8s8tGLHpdjveW3EldfHFyQTGp8GEYkeuZn+R0yvCM+5zm4K2BFqzdSyLrOXfoPycCVkGYVMP9nrRs5YITm2JI4/McHKK1kEN9KFafI87wFo+aNJLEeuvUrjsvtttWjG0OLYy+X8wb4mK4H8Z7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=T7EPI8K2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae3a604b43bso701482366b.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 03:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753095208; x=1753700008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Mcg0TVj8ngK79VTI2Bs4Da/ye+s62cZ/CuyUgnB6vM=;
        b=T7EPI8K2uYRtjNphog1stCv0NOeu/qgxjuiIyQP7B20cUEh+j1sF9UruU37cgQCBGB
         eCjVRnecWOZV8vcXip5qTsC5l9wstVtFlj3M9Gbwyv3c6VcBHkf0qwUJ8vgVN7QQV0+c
         yKqHm7ByGmgDwkPGffJlwDeyWXwJLv0TG3qpU2NeJS3nRO5pKR0NYVJhvu8owCofvBov
         4jo0cUY1yIfaPl0dIysUPnU1Tsj/48pFzHXK8vR+MOYO2eSJIOzeIj0OurH299/3D3fi
         hFvm17E223gEgEr634Yw9zX0YqGhJkn6dzHRoFZq5RaF45ah/RgBjR/6JXzgaR5IPqni
         orCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095208; x=1753700008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Mcg0TVj8ngK79VTI2Bs4Da/ye+s62cZ/CuyUgnB6vM=;
        b=OG9QSh1HMLlD7yHlk+5HKQCpGLcy3iX7JvAd4cAaHDNqx6swJ1tYVYQ9QH09em3YEP
         oB+3TjMiIJl1xymHTORDQhS3EkgFbL9uknLtrgtq0LxLo/0RBb6T3SIzhgoqgMwlxOzF
         lpkoMiRGFBIAyJUsvkFiEhYfWIOzQtKzeDEkAxgjlah5yL00QkpWY0OM8C7skhBPTrCy
         ciYLCcZ6HR3zRRKO5ZpvhZX7EG0/hToaHPEsFGy+MZF6SvBaevd81b8tPmngnVlNjuIV
         I7o423PAKnzHaHVYcA3a2BurNij4xXDRURPABmZExCHMOcgZ87JRKRoR53DrVAUKF3Nh
         YOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5uw8uSv51pA+yoJsScHVa5qkYHVeBJvGcAtH+UYuC7NQI2b+nJqW3f5stlCon8bsi1zlzKZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBZH1enNV5fUmCXuWi2gaCib/87cNUV6pISGie/Vm1NXH3UCPT
	FIz82afCd7aevHzhJ55Lagvk8X3VTcJlpacV7AsZltr44XlKazNi1+MxKIHt8oupjsA=
X-Gm-Gg: ASbGncvQAb/UVLRKE7pvkBkOP3E6COxKFFSO2stus5q1e70Ln+REoXAecTAufQX4CI/
	a42bPXMz+kK2yAp2l7ILqrIm8GNJiXGeYt/N/D4v24d7xttFdMLGOup/s2kjEu8C223H571xgvo
	Mx9zc9qqd7jKSzuBHvIK+2zbHrfjqTVrak+K4CBJtmJjMp/WD+3rPFawFEGm6upcwpVOGsG4Vdj
	AUsEK0C/lq/6HrHckEZ3EOi6H8a63FiMOb3hIU5AcZjFh81c8SFt4q82Xm3N118VGaUWGSKmkj8
	BgGcIgnb06rfVKif4V9gyq+K1QtK/3QjKB4uugSq+vPGHeiw5ihAYIv5lYrZU/NNE3mpxWeyZHQ
	RlyVeU1+vyrVBwg==
X-Google-Smtp-Source: AGHT+IHU8cbhUbH372jlIjFTbW3xDwcMnrAOKgillcYTDe0KbOG1cWXGC2TNwN1bSrLAt3Woa5wdRA==
X-Received: by 2002:a17:907:7286:b0:ae3:74be:49ab with SMTP id a640c23a62f3a-ae9cddb3a1fmr2121032166b.10.1753095208522;
        Mon, 21 Jul 2025 03:53:28 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d9941sm657741566b.56.2025.07.21.03.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:53:27 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 21 Jul 2025 12:52:42 +0200
Subject: [PATCH bpf-next v3 04/10] bpf: Enable read-write access to skb
 metadata with dynptr slice
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-skb-metadata-thru-dynptr-v3-4-e92be5534174@cloudflare.com>
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

Make it possible to read from or write to skb metadata area using the
dynptr slices creates with bpf_dynptr_slice() or bpf_dynptr_slice_rdwr().

This prepares ground for access to skb metadata from all BPF hooks
which operate on __sk_buff context.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h |  6 ++++++
 kernel/bpf/helpers.c   |  2 +-
 net/core/filter.c      | 10 ++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7709e30ce2bb..a28c3a1593c9 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1776,6 +1776,7 @@ int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 offset,
 			    void *dst, u32 len);
 int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 offset,
 			     const void *src, u32 len);
+void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset, u32 len);
 #else /* CONFIG_NET */
 static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
 				       void *to, u32 len)
@@ -1822,6 +1823,11 @@ static inline int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 offset,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset, u32 len)
+{
+	return NULL;
+}
 #endif /* CONFIG_NET */
 
 #endif /* __LINUX_FILTER_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index ee057051db94..237fb5f9d625 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
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
index 3cbadee77492..6d9a462a0042 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12002,6 +12002,16 @@ int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 offset,
 	return 0;
 }
 
+void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset, u32 len)
+{
+	u32 meta_len = skb_metadata_len(skb);
+
+	if (len > meta_len || offset > meta_len - len)
+		return NULL; /* out of bounds */
+
+	return skb_metadata_end(skb) - meta_len + offset;
+}
+
 static int dynptr_from_skb_meta(struct __sk_buff *skb_, u64 flags,
 				struct bpf_dynptr *ptr_, bool rdonly)
 {

-- 
2.43.0


