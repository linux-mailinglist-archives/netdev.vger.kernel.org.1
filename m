Return-Path: <netdev+bounces-207522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DB8B07AED
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3EA4E2CBE
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4214B2F5C2B;
	Wed, 16 Jul 2025 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ernp7EVr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA62F5498
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682673; cv=none; b=FcPDvLtzjzyDEHYIaj3Y0MpA0Vn13YQEOyxZLpY0KWoWwGKNnsShLHwgYclN7NZepVgDRib9rT5I8VDG7o7lkHpkxmRDwYuhk34v/R+P0NfGEoMfeWdKEw6miRo82SVPZjexWATHcQLnOhbAoex8cVR6tiD+97tAziQHEPJ+eng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682673; c=relaxed/simple;
	bh=6eIezERHSEJDrLELSSOVOtga8/X4c5EdZF4sdI1shSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKefs5vqgqWl+lLIXGpRQGubIIyM7XK82+ZFNf8JOb9cmIqEfeDAKbdJn7YFtlD8KWW3Pw7ECdXHUmkH/9dJkJBgbuXRQvvYqJ1efIZeIQxrApODB5LAWXlwBlcctRW8AZaOuavlnJ2Fhb8/Z55l7mNWa3irQaI9hZwtAz5w+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ernp7EVr; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-558fa0b2cc8so55991e87.1
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 09:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752682669; x=1753287469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxsnNkoNeId37gYv7lFeotBiBqj7qAXOOGCVwl+Z3pg=;
        b=ernp7EVrG8uYMS0TVNYLiUkXOYHeysRw3A6Mtj3ZEn4+87UA5NkJUg3IKaJgyFWcwA
         RU/MpxjZrUEpMKuQag3VA3oiUiowhDv/pcPYn3GCh7mdfQTQv+t0pAk+h7dKKSG7pML2
         nJI1GDfHJQzr1rxWRhmfHe+Zzx1PRfwHfUPvS7nvFCAyd9mq+bkrvo6CUiXUDE6eS6ro
         MQX5nu0QkxDUd7zkt4kaNE6ELOYOyQbKT6tFwSHpdHxqZ5Q8HpR5N46vbGCf895+7H/o
         Xt756OkrHR7vD0gRSMlXY1K/sHiX8Ig6ILwELasXg1DhnyW3GLm9LShSfcJQZ4vg+wgV
         /TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682669; x=1753287469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxsnNkoNeId37gYv7lFeotBiBqj7qAXOOGCVwl+Z3pg=;
        b=Rjd1oaiJJVuoymVgwXvs0LeePrrvJHM30GjWvyYBSnxpOUwJ8jHJHGRUgjxu3N1bye
         iBt1t/1OpKpBhrSm1PGLmAWy1hrInyvL2VJhnQ6suOm3QHEULZ0GNMRUs/fXUP2P9O8M
         9E1G2wq0rJhGbyU4EMNjfT/EZ59bfNo5vj1rsE7O8WL7rA/rhbh9h9F4h8Yy9Ck946md
         ze3RjQ0Fvpbvb9Ggof5odm7RpJbjvBwKxl8x8JfdQanmFEHePBasBK+G2T1m0xhjx5p9
         Z7wye6XXKYogV1h4G01fMuMJnABdfPaiDiwhlniJDgt7moXzxymE4zoyHcIL3EXhBjol
         eTpA==
X-Forwarded-Encrypted: i=1; AJvYcCVrliV4HEh2BjVAxuyB28T0809C0AeANC5r0XpQDrFIeXDw6pwnNcK9PEfqgx2PbAVerYV4kQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzn+EqsRwH8LJvPzW1T76H7g7vLjOMHsQYt17Bkd2cJgt+NUWZ
	OdqlTvyrR0t0GfBwH9yO/iMSvgQuzxT/V0PhAiNNlHL6Pb2/iBOUWS1wq/toDo3N8Jo=
X-Gm-Gg: ASbGncvj3Vey3sYaqW+j7YqXYHKOUrmRsMDsS6uLxl4mzPT7BU71coFrjQfsSQirLrJ
	88j3NrBwKlLviZ5zEYRNdzRI+WLJUHK2ybwKit7GydGebD4WjPxUPbzt+7u6o9pWl3zcGkWUoEo
	7xgvRGG0ZK8btQV4eZozTfY3YmxbamhXJxHllQuwM6IccZXMszakNnmwBAOkKfclXM530iGdX4L
	AXiNbYuPT0TBo1ftgWT52R77JUthjbEtHiYw5hgxN2w/8TKDP3UOC0XMJZ+OVRHLp3X9Qhsb6hj
	bIPSZjZ6gNm9tjJrT3TXSElcQgrL69iWY+/Jsl6Oa2XPpD8UeIqklOJAXgSDeyMjKlmfUIXsp/e
	8SCmsX4SOnNEb++zaMd9K2GExujFfiZcsD8+e8K4xCbGEHP5B2VqwKJBRr3925ndumLMz
X-Google-Smtp-Source: AGHT+IGep7V0feDwt2PUV6FXqpmhT4mmi0143EAelThxhRN/ULVg7dxkFr9Np2Vcd0QuxntWIYYY0Q==
X-Received: by 2002:a05:6512:ac2:b0:553:2480:2309 with SMTP id 2adb3069b0e04-55a23edceddmr1215783e87.3.1752682669427;
        Wed, 16 Jul 2025 09:17:49 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7ee97asm2667076e87.78.2025.07.16.09.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:17:47 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 16 Jul 2025 18:16:46 +0200
Subject: [PATCH bpf-next v2 02/13] bpf: Enable read access to skb metadata
 with bpf_dynptr_read
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-skb-metadata-thru-dynptr-v2-2-5f580447e1df@cloudflare.com>
References: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
In-Reply-To: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Make it possible to read from skb metadata area using the
bpf_dynptr_read() BPF helper.

This prepares ground for access to skb metadata from all BPF hooks
which operate on __sk_buff context.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h |  8 ++++++++
 kernel/bpf/helpers.c   |  2 +-
 net/core/filter.c      | 12 ++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index eca229752cbe..de0d1ce34f0d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1772,6 +1772,8 @@ int __bpf_xdp_store_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u32 len);
 void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len);
 void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		      void *buf, unsigned long len, bool flush);
+int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 offset,
+			    void *dst, u32 len);
 #else /* CONFIG_NET */
 static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
 				       void *to, u32 len)
@@ -1806,6 +1808,12 @@ static inline void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off, voi
 				    unsigned long len, bool flush)
 {
 }
+
+static inline int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 offset,
+					  void *dst, u32 len)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_NET */
 
 #endif /* __LINUX_FILTER_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e25a6d44efd6..54b0e8dd747e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1776,7 +1776,7 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
 	case BPF_DYNPTR_TYPE_XDP:
 		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return -EOPNOTSUPP; /* not implemented */
+		return bpf_skb_meta_load_bytes(src->data, src->offset + offset, dst, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
 		return -EFAULT;
diff --git a/net/core/filter.c b/net/core/filter.c
index e4a1f50904db..93524839a49f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11978,6 +11978,18 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	return func;
 }
 
+int bpf_skb_meta_load_bytes(const struct sk_buff *skb, u32 offset,
+			    void *dst, u32 len)
+{
+	u32 meta_len = skb_metadata_len(skb);
+
+	if (len > meta_len || offset > meta_len - len)
+		return -E2BIG; /* out of bounds */
+
+	memmove(dst, skb_metadata_end(skb) - meta_len + offset, len);
+	return 0;
+}
+
 static int dynptr_from_skb_meta(struct __sk_buff *skb_, u64 flags,
 				struct bpf_dynptr *ptr_, bool rdonly)
 {

-- 
2.43.0


