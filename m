Return-Path: <netdev+bounces-208548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AC7B0C1BB
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 12:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025633ACD7E
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F04A290D94;
	Mon, 21 Jul 2025 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bB29Vzlk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C821A457
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095208; cv=none; b=C7g/hg06VT/TxNC/FxkYDQJiZD5ccU328SnZ1UX2JnU1ZYVljQJMvJfNWtknNNmUwtf1ObWUkPK+P3SwOhWUyyDlrlYQNip6Pwdr6h94VYpKHckFK8H3C/OcVZDcnmXfEJ5cmfLChWoHmPfkQv0djMQ1LQF1tOAp1rusaVl00Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095208; c=relaxed/simple;
	bh=lB87yi5nN4yz6HzlKD+M+xogq3q7UfciSes7Znk2kw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rcBxhop+enasO8NpN6tS8wXhmcKBBLJuHLF6QQEcauI4oCLNIX4hcCS6LGyAVysXYXizIDIpsh5LloQSPGipDEhHJns9KppIr3HjnglzGBOkdtHWav1egKZag8AAqjkOlgwZv2NpHyzQbEkTXBHD8FzvJtbIa+3Ie1/pI5lBPAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bB29Vzlk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso728806466b.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 03:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753095205; x=1753700005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHhT0Ee0SSUxOeVpPwIaqDvctNMu/1WkFtaxfPY2ARk=;
        b=bB29VzlkRwMZiztGcsfFgJxHRHvRtf9HcN+WluDM/3YQsCiduY6prV7nbBGgUUbI7z
         DQ5ozE92U2530/Ehgy77IKOH4TvSjX4CG2oTFQK7tzcroEbZyeMQYeVHGXBQcCJLa8GD
         Xz5t9Gz2yK0g65TdnaAgnGYTF0SzbpR1qU8cSiU8STrS1SOelO4pPcpXi8O4CEJ9Mt4Y
         nuOMvsSZS/rYNigAG60pvcu3KQhTltR9A641jLP993l9Jrhe32L2uMprkuwO8KVFJKQ/
         p0Den/h7NeYkKc8tFGtOWGTRgR+0VlMPjZOZ/QNNCptaqmvP15ygzrgZhSu+VoSlp/z+
         83wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095205; x=1753700005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHhT0Ee0SSUxOeVpPwIaqDvctNMu/1WkFtaxfPY2ARk=;
        b=Q5mTxBk5xQio+2+0GIH4ZdAHh6hJNVQnRjn3ruTfklVbtZmK9o7vNTEpD+/N9DMHlD
         9BIYV6bfl7Uj0G4Eou7pkwCV/Dnd2KoiENbtkPyoxNnoZEMuojXRsOSw77BpMRfO8ehJ
         YtDVmRvlDd8gPFIbXtv016NCw1zGJMMj3H00kfYX4QwUioU1La1mnJYj9SYsf9pF6ESr
         e1HB/65KWjMntJIGD9d8qB2vJuv2fa10xsLiBlX7zVwvI9Gi8/zH7YKlGipCv1H5RcL1
         TwrbVvPkeqRHVQXtWzBpzScSAG1GhuUHKFlC++iFNPyGsgsfupVcG2kYjzGk9T18vpc9
         dhxg==
X-Forwarded-Encrypted: i=1; AJvYcCV+gushMvAilQ4NSHwjF09xDEPIU8Dmkz6yIgOSmJY2bdnLIUP//C4ne9WH/iIXOV3I4HNlttk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUXCzIu8aNiHOY28x8GVKOcPwYf4bh17YWu0LYEWX95Kdgzaa0
	p6j9Rr/s5ovAG2IdAJXeIkykq4j4U5S05+dCoOYrkejh1rvI+RzNemArkTeFeabXPzE=
X-Gm-Gg: ASbGncvKEpTshefwlR6yZv7Tzz9hWkOm6yOxIExRU2qMSoMAkPzzyheTwwLLa9mpawa
	UL79gIeIh7keaHp6FUg9nNo6BoxcXV/sB0htoaHZACDbvHWCsaHzNLtpfPFDga1i7xUtZTfSyT7
	xhLlPLTgUoGPBKffMJlZvxqjB34DG+HCQGXgk5RyNE7LiwWAk/r1GsDS/k455jQEgLvUYGWtBU5
	qhQZzL5fcm/n9aw871JIaaknzsJ+Op2mdvMKpajhW5OBy0GXdUTvV3j1cl+Ry+7Gi7X/m6NQAQq
	gFrJ/J2xVInMAmAwAMHK1GOvolUY1akW4HT+/CmUA72kxLnqnFUZgl2Y+H6WTnNX07R1enjcULH
	USqOtCJC+Hd0cVQ==
X-Google-Smtp-Source: AGHT+IGGfc5RFiUW/rgf22j8XZnNhh8mAWKQmtfdlKPweZZFPR/Eb+CmOwzmUpmMjm2nHINCP+7Jaw==
X-Received: by 2002:a17:907:724d:b0:ae3:6ff6:1aad with SMTP id a640c23a62f3a-aec6a4df503mr805464566b.14.1753095204888;
        Mon, 21 Jul 2025 03:53:24 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af0edcf759fsm18309766b.89.2025.07.21.03.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:53:24 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 21 Jul 2025 12:52:40 +0200
Subject: [PATCH bpf-next v3 02/10] bpf: Enable read access to skb metadata
 with bpf_dynptr_read
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-skb-metadata-thru-dynptr-v3-2-e92be5534174@cloudflare.com>
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
index 9552b32208c5..34027a799679 100644
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
diff --git a/net/core/filter.c b/net/core/filter.c
index c17b628c08f5..4b787c56b220 100644
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


