Return-Path: <netdev+bounces-202504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEEFAEE194
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A323B579E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DDC28D837;
	Mon, 30 Jun 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ff9BT+ER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007C28CF64
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295357; cv=none; b=PLtrv9CwN33QpxGAgRL4FQmveA2BWqdL2Pg2kdfaia6bSlxQYhjpdvEIyM1Vbz7alW4BkBlRw2tZWRbP7anuIV1+XmHQluelQB8Q4LcLMNnGifhuuApVlHERlE7jJY31xDagAcd4evit4ZDHqj3kyE1KnzWVRikQgEFYP/MPb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295357; c=relaxed/simple;
	bh=DG74tz99+RNpWARxwp3ttOL/CZmpYWPW2sRCH6lQ1wA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YSthxw/+jbTdu7efwCkHjITMHSZpRtb/rDdBEDrTqhBb477f+h2sgyYAiLDmwtcedTie07QWgcmYSo9O9glRAlEUyD8o/TKulq+BJB4WVsjzfqpBYtHZ5HOzgGJfFcI5fgvXo2k/U6rVSHNDqVH3PK60k/tlVZlc+OvS2g0L2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ff9BT+ER; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0d4451a3fso401508666b.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295353; x=1751900153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5F1doR37PVkKduT8JVZzI17nbFGqVxF8ogmtMY/QPI=;
        b=ff9BT+ERH8j66ApFoRRJ0oTvNn2cRZWRUIzq2iIOh0HuTwEUDYTmIaR6foaYd9318x
         hOLoUfdXt7wZRjokYyF73bkmoZdlwaNtzER6UjqWjigZbM3mNWG6JG9bEIKz26zu51FO
         HR4wCJrsNzmv0jX8BN3ypAs5EYA35WnVwb1BcmZZaMuJLOr+aVhzANF31O8eH/qAF+4o
         /TDELAdNaWJ4k3qRKJ/zvV5ZNAWvR8oCVZevVogt7+q4oubQUzt088BsaNvzjLfB6P+E
         kTE67SygPKQ6dg9LHnkQ3P8YLIHzs3oZ7xNc6DCM615jD3f4h46K1fw68a4hRa4l0N5r
         F2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295353; x=1751900153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5F1doR37PVkKduT8JVZzI17nbFGqVxF8ogmtMY/QPI=;
        b=EkZS79QXsJFO2hrYqUQHYNjZO3iGc8EKMwR4WOl+01UH/KfyX/xIP3k9Wk2KmPfoQK
         BXdXGbqFdAptKwKqEqG54pOGVTDlVGgkmXRzZBI71/bCsNsxyTXuvNPiUUbXpD5vEx0H
         qfYJ5izuFeKPG6eb4MWJyrh5R8UqmXtCFWTl9xHKxu/vbiz82YUHzR6aNUf7h08sGLuT
         ZmGoM5h81QT2KAXetXeurj9AOWGmduMsocpLL9EBf/iDz+640/36VVAAS2hp6IiP883j
         t3iSk3kSf6THV3E3ZQsLPJVjoqm2LD2LTvUhBB9oesmFI8Wf7oBl1PTaLWamhe89xAsu
         d4QA==
X-Forwarded-Encrypted: i=1; AJvYcCVYTPouRuCBkWL5HCYSc+TDa0yf8oY0oSYBhyAHZp2wXJ2MYc/3Q++raFkl3tZSw6oyDpsQTiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/icLtqz0ehdXhr36ifUGKfywX7vvV88HkbgD9Mxo5iqbul+V
	B+WegkqSFor8eKL2sic9XxglPCIx275t8X2+hmdtDCSqTfXg8Aj+BaJrpfYml60lSAs=
X-Gm-Gg: ASbGncu2jTnr+IjX25OfcRDFTpGBvtk0zqbnj+P6fNlq9HTARr9LjRh0+lqHNeq+rVj
	nZqY6jiMhup1e0a4U9yBdgzXBEbaKAaps8FsMUZIXF2VRh43JrW+lv/lsVp9Dd+84lMatlrGbKP
	DeeGOLY9il76LTw7+JFYOA6sZhWpHicfqFqWvUiqARuwA9AqYWJ3y+uBqpcgxTrbw/euOhYVfYy
	1s6Y9WwuW1LI/N27Auf28EajUhzPzngJ4Fidi7yfRpuJanrPixuVafR35bCQGBvjYGXUMLOEuQq
	fKWM/I0Wb7zKushQrCyV2IVcc7JW4qdxTbCwgI5MrRhg2Pst7bERxA==
X-Google-Smtp-Source: AGHT+IGCigiIKnYH1w3IAINizyWPEiDkdM3+rLAOpzIK1wcnKeVCE1XLcSb+89hDFm8KRjB/TeKo+w==
X-Received: by 2002:a17:907:3d8c:b0:adf:f82f:fe0a with SMTP id a640c23a62f3a-ae34fd729f7mr1423832266b.16.1751295353437;
        Mon, 30 Jun 2025 07:55:53 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353659ff5sm693860866b.61.2025.06.30.07.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:55:52 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 30 Jun 2025 16:55:35 +0200
Subject: [PATCH bpf-next 02/13] bpf: Helpers for skb dynptr
 read/write/slice
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-2-f17da13625d8@cloudflare.com>
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
In-Reply-To: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Arthur Fabre <arthur@arthurfabre.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Prepare to handle skb dynptrs for accessing the metadata area.

Code move. No observable changes.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h | 25 ++++++++++++++++++-------
 kernel/bpf/helpers.c   |  9 +++------
 net/core/filter.c      | 38 +++++++++++++++++++++++++++-----------
 3 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index eca229752cbe..468d83604241 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1764,27 +1764,38 @@ static __always_inline long __bpf_xdp_redirect_map(struct bpf_map *map, u64 inde
 }
 
 #ifdef CONFIG_NET
-int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset, void *to, u32 len);
-int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *from,
-			  u32 len, u64 flags);
+int bpf_dynptr_skb_read(const struct bpf_dynptr_kern *src, u32 offset,
+			void *dst, u32 len);
+int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst, u32 offset,
+			 const void *src, u32 len, u64 flags);
+void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
+			   void *buf, u32 len);
 int __bpf_xdp_load_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u32 len);
 int __bpf_xdp_store_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u32 len);
 void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len);
 void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		      void *buf, unsigned long len, bool flush);
 #else /* CONFIG_NET */
-static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
-				       void *to, u32 len)
+static inline int bpf_dynptr_skb_read(const struct bpf_dynptr_kern *src,
+				      u32 offset, void *dst, u32 len)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset,
-					const void *from, u32 len, u64 flags)
+static inline int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst,
+				       u32 offset, const void *src, u32 len,
+				       u64 flags);
 {
 	return -EOPNOTSUPP;
 }
 
+static inline void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr,
+					 u32 offset, void *buf, u32 len);
+
+{
+	return NULL;
+}
+
 static inline int __bpf_xdp_load_bytes(struct xdp_buff *xdp, u32 offset,
 				       void *buf, u32 len)
 {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 40c18b37ab05..da9c6ccd7cd7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1776,7 +1776,7 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
 		memmove(dst, src->data + src->offset + offset, len);
 		return 0;
 	case BPF_DYNPTR_TYPE_SKB:
-		return __bpf_skb_load_bytes(src->data, offset, dst, len);
+		return bpf_dynptr_skb_read(src, offset, dst, len);
 	case BPF_DYNPTR_TYPE_XDP:
 		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
 	default:
@@ -1829,7 +1829,7 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 		memmove(dst->data + dst->offset + offset, src, len);
 		return 0;
 	case BPF_DYNPTR_TYPE_SKB:
-		return __bpf_skb_store_bytes(dst->data, offset, src, len, flags);
+		return bpf_dynptr_skb_write(dst, offset, src, len, flags);
 	case BPF_DYNPTR_TYPE_XDP:
 		if (flags)
 			return -EINVAL;
@@ -2693,10 +2693,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
 	case BPF_DYNPTR_TYPE_RINGBUF:
 		return ptr->data + ptr->offset + offset;
 	case BPF_DYNPTR_TYPE_SKB:
-		if (buffer__opt)
-			return skb_header_pointer(ptr->data, offset, len, buffer__opt);
-		else
-			return skb_pointer_if_linear(ptr->data, offset, len);
+		return bpf_dynptr_skb_slice(ptr, offset, buffer__opt, len);
 	case BPF_DYNPTR_TYPE_XDP:
 	{
 		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
diff --git a/net/core/filter.c b/net/core/filter.c
index 7a72f766aacf..1fee51b72220 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1736,12 +1736,6 @@ static const struct bpf_func_proto bpf_skb_store_bytes_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
-int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *from,
-			  u32 len, u64 flags)
-{
-	return ____bpf_skb_store_bytes(skb, offset, from, len, flags);
-}
-
 BPF_CALL_4(bpf_skb_load_bytes, const struct sk_buff *, skb, u32, offset,
 	   void *, to, u32, len)
 {
@@ -1772,11 +1766,6 @@ static const struct bpf_func_proto bpf_skb_load_bytes_proto = {
 	.arg4_type	= ARG_CONST_SIZE,
 };
 
-int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset, void *to, u32 len)
-{
-	return ____bpf_skb_load_bytes(skb, offset, to, len);
-}
-
 BPF_CALL_4(bpf_flow_dissector_load_bytes,
 	   const struct bpf_flow_dissector *, ctx, u32, offset,
 	   void *, to, u32, len)
@@ -11978,6 +11967,33 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	return func;
 }
 
+int bpf_dynptr_skb_read(const struct bpf_dynptr_kern *src, u32 offset,
+			void *dst, u32 len)
+{
+	const struct sk_buff *skb = src->data;
+
+	return ____bpf_skb_load_bytes(skb, offset, dst, len);
+}
+
+int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst, u32 offset,
+			 const void *src, u32 len, u64 flags)
+{
+	struct sk_buff *skb = dst->data;
+
+	return ____bpf_skb_store_bytes(skb, offset, src, len, flags);
+}
+
+void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
+			   void *buf, u32 len)
+{
+	const struct sk_buff *skb = ptr->data;
+
+	if (buf)
+		return skb_header_pointer(skb, offset, len, buf);
+	else
+		return skb_pointer_if_linear(skb, offset, len);
+}
+
 __bpf_kfunc_start_defs();
 __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 				    struct bpf_dynptr *ptr__uninit)

-- 
2.43.0


