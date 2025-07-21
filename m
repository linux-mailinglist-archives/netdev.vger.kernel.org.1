Return-Path: <netdev+bounces-208549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AEEB0C1BE
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 12:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3697A18C29A3
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673DF2918F0;
	Mon, 21 Jul 2025 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eQFQGtFi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77068290D98
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095210; cv=none; b=SlB1PbH3L+aJWzAHgXXUyud4yIQH+KMRMkk64Wwoba9R1snkJBt3S9WpfbsB7/Yc0EQBks22HoFAiJZKSXRNvkgSD27aq1cvwz1rG7J/0i/rJtpyem6Mf0LCXpUCwSqkkKkA0ogR2C/EfjeUMN54vLvwDRx7+YJwmtgMSgJwYVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095210; c=relaxed/simple;
	bh=euw0bEBEihuWjfbxfGYCR3XlEIRZMNUIivhhL3X6gwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5N2LSqIZEAL9X01e1H5YouUn63DJ0rt8Vq6a8EOpSukBLgSb2n+hdmZoyjnegjvw1iRPepJ4+hEO7spJ/M44igA1r7z9mOjLtPw0HbZg3kqY2CtamDgxBOsTlNc8OhSycBzTaWMe5AWSMHOs9/rXO04Wdu/Qoe/yLMRQ0zqpWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eQFQGtFi; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60cc11b34f6so9250935a12.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 03:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753095207; x=1753700007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwkIcxmxgSYAZjcqP36TMJr1KFk/TVEHFwh7s9QEtK0=;
        b=eQFQGtFiL9BQ5yc009dF6SOQdkvxPrDpeZc3LuqtrC/EV5XtGeecvgreT5nhfSn4lB
         5oGFEk3tunP/0hEyY/IwRwgTVekSbrRggGVw6kBK34TPEccsiWsRsAwoQhI+OIq7mR8v
         Q45Pn8POed+hKwJ5PjjRLgtF0s3mBBamMQsfXr1PH32cvNUPZZU9B3BYkq0IFgTLDXkX
         heUGjwcfVoFACeaJwQ9fyIU3bC5RniH/FOmLZr+KMamOdXE04Ho3fbw6hjjTOBKxgyBe
         A+3MnSGQT8mV0rj0LJ3wRavlZbUPU2xn2aX+YlTerK/FLYW2JfgbI10EfuRa0bpCxFdK
         M0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095207; x=1753700007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwkIcxmxgSYAZjcqP36TMJr1KFk/TVEHFwh7s9QEtK0=;
        b=m/OK9YJr/vd4b0DTDikocFNeYZJxp38PWJFhjnvvluKQfJc8r6gZSBAYvO52DcAD2+
         K6aBdIBbjy9JWXXIWvLh+a1EShjIY6wx9wQhtI2tATksmZMtxA3Ufv4ooQU6S5llb+DU
         pQvQgIDcNqjTcF8198XUWLAH4U9Zl0UK8EumC2tiBj5epW24l6HgJXsqS+3elckz824Q
         /IAYha2Auq55sYqVXU7nNNuEZA+Qu6OoLh734A50BNsIN1Ayr1mU96LXVGzdFJ8Cmojo
         kWRjqZ/KkIvYJp4hRsDCbVj6o3KyeTusxrJijRDliwjNzyrAvPY6z2jC5QJIhuumfE0E
         YsGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4/A371Rp5Be5IlrH+esR9WE9vIFKUMDaznkJ0jH22yg95l1Ko6L/yuE7ntpiXn5VGAnYnr2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUh+KA2vSqjySEqgJ2h77nz4lxCDgeJlgjWfxR5TT1QpzfGId5
	HtdvmrRaO5erAQy6hHOWkVRxnngmdkCbxbievfa/zsk5v2ddXhQAzNN9u5J8X4vxUqo=
X-Gm-Gg: ASbGncvZzAlL3t3j2YJuDyu2DubgRNlkq0696eGBF9kml/9ChEPlGHX+6TKnwwuFuFh
	qSomQHdQf9yBnBAq8ohI4up/fIqBGt7rn0VKCwhb3dEfzIF825MpskaQvCwaXICOcVs97tEpy1V
	/PaDq77dkECnGKIcBAY1EtfcirR1heRsyiNC7DRBBTjwBupP82OMF7G9vA/Ys3gFjpF13pI2+S+
	MZvgJyh+PXu41pA60CNJqRrLTejRszjyMZUFQcGsmVF0pcA56qMXV5LEVA0tfPBdOyZ0L2xiRy+
	Bg8IzGmaOP6KvTQLQkhxBz0QyyPmWLnLx8vSmvffcAjJzDdrBJxTt6KEHpEfqSH08SG/CcAJ1A4
	mQwuk3lAGOPPBgeUMaJ6nwybb
X-Google-Smtp-Source: AGHT+IGZrAZnlmlh6RuaHZKjaFg0Wjo1rdZLfn1fuceLoO51Mt2SYcNzHp2Z9doJIMhDMBBV5up8xQ==
X-Received: by 2002:a17:907:3cc4:b0:ae3:cec8:1c7e with SMTP id a640c23a62f3a-aec66017822mr1178222066b.20.1753095206643;
        Mon, 21 Jul 2025 03:53:26 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d8fcasm658996266b.68.2025.07.21.03.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:53:25 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 21 Jul 2025 12:52:41 +0200
Subject: [PATCH bpf-next v3 03/10] bpf: Enable write access to skb metadata
 with bpf_dynptr_write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-skb-metadata-thru-dynptr-v3-3-e92be5534174@cloudflare.com>
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

Make it possible to write to skb metadata area using the
bpf_dynptr_write() BPF helper.

This prepares ground for access to skb metadata from all BPF hooks
which operate on __sk_buff context.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h |  8 ++++++++
 kernel/bpf/helpers.c   |  2 +-
 net/core/filter.c      | 12 ++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index de0d1ce34f0d..7709e30ce2bb 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1774,6 +1774,8 @@ void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		      void *buf, unsigned long len, bool flush);
 int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 offset,
 			    void *dst, u32 len);
+int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 offset,
+			     const void *src, u32 len);
 #else /* CONFIG_NET */
 static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
 				       void *to, u32 len)
@@ -1814,6 +1816,12 @@ static inline int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 offset,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 offset,
+					   const void *src, u32 len)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_NET */
 
 #endif /* __LINUX_FILTER_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 34027a799679..ee057051db94 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1839,7 +1839,7 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 			return -EINVAL;
 		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return -EOPNOTSUPP; /* not implemented */
+		return bpf_skb_meta_store_bytes(dst->data, dst->offset + offset, src, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;
diff --git a/net/core/filter.c b/net/core/filter.c
index 4b787c56b220..3cbadee77492 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11990,6 +11990,18 @@ int bpf_skb_meta_load_bytes(const struct sk_buff *skb, u32 offset,
 	return 0;
 }
 
+int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 offset,
+			     const void *src, u32 len)
+{
+	u32 meta_len = skb_metadata_len(dst);
+
+	if (len > meta_len || offset > meta_len - len)
+		return -E2BIG; /* out of bounds */
+
+	memmove(skb_metadata_end(dst) - meta_len + offset, src, len);
+	return 0;
+}
+
 static int dynptr_from_skb_meta(struct __sk_buff *skb_, u64 flags,
 				struct bpf_dynptr *ptr_, bool rdonly)
 {

-- 
2.43.0


