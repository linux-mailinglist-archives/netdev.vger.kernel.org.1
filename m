Return-Path: <netdev+bounces-207523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5C2B07AEF
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9A74E56C4
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F8B2F5C46;
	Wed, 16 Jul 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KGN5DK/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FDD2F5C41
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682676; cv=none; b=BNuTJDbXCjq2pZSa63tPSc0bfjju7uKBjG6ekVkGqCFDVgB+SLJTFFJmYNQcIWmnO8BBOtHI/+PP1y3AriUpmoStQQHG5QyjWWAZuwZFqYv2pp8XxgwgGqKul6R5g2y+GJcOZFn30RNNF5wKLRLk0uQAaFSNuNmdJHIe7NcfE60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682676; c=relaxed/simple;
	bh=JFIPahAiD0S7HsBpke/RZEbMLXbwVGk2s1FtL6LTWAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UUZWi3wLAj2gXtRvT0yLdTOcr/fK3Kj0KsslRSFl1YnuwFAs2I3EPw1gJYnGEJDob8l/nOjnHhlFAc0efRaBLRiIn4iyg6CuDyEcpK+L8PNEHUKNY8KEMS9k7DO1M0/iEDcR/U2vDy2TEkfEYp53Zr1Wbamd08vTsyHxRyJqCZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KGN5DK/E; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b43c5c04fso10539471fa.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752682673; x=1753287473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mpc9897NG2ftoPu05usDVcGrykyyCose3qXOwJWywwI=;
        b=KGN5DK/EtkoeZBtDyy8FCwohoC9HIiFBcpZM73ikqGbvvpzTKgv8PgPXt6SdTOYnKP
         TOecHZLr6TiXc1q3Zo9A7GI/vSyjbejTDhFYW6INGKbqxSOFYgv2ML4heWSZn2n9VoMR
         4cvj4TZK91AOO011ZO0zZkGA0tMSxVD6tIGKERuRcmUDUVbAiBW/A2bWMGyMubroiJkQ
         FHhYi4i6T1PqM+EsBnABL51war6hYTeHpM5Ilc7djAgwGbU4r0OFfFZaTENFL76OhzO5
         4xMn6eWCrVOYGZ/RN6Vou8RSUT7TXCs0tvpjsh1fzO37LWUzviI4ei8Qn54bL9lhupMu
         +0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682673; x=1753287473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mpc9897NG2ftoPu05usDVcGrykyyCose3qXOwJWywwI=;
        b=FEUecFcC57LgFakcwG6DDpa2zbeIqI7xKnvvYlYuDiPREq96UqEN/+h7GLoekIrVRu
         +Uf1mUhlEIpjJEj9C/Qq0CCFAVAZwW4O9sH4st1AizJvfKSvY2D8NK5FhmaztNR32vvn
         /RoNHj2Snd11Lr8ltEK93tfAzSIFfMuLPSdTJdGsCXieKVP3GZF7QONVpbjhw4vaCvG5
         Kt1EOnjHbM/ghHVn3oeZCu1hYSv9gOPDpHK+PLAsnM207mNNjU8n12gmTqAnUoZgdLbW
         /F42XUmRAOYgs6s3QHkve7CklGBzh5l8Q0MA6Y6RoR9x0P2HwYFAN3OEIGnntO7O/WfY
         1e5g==
X-Forwarded-Encrypted: i=1; AJvYcCW4YajIIfOTlzZ950jCOgjAwsPeucV0TqRA5YKr6iEdjdkAX4KMaMEnDSp2p+SmcCvAOsMkr2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YycYOF5ZX3B5GqMU+MCe4aOgKkN7FLv3ozyn1wpEoe2QMO6IsY0
	tBnh0BaICf+f24O21TCqjVbYW52t2TvkcuXFiMsANWXrn7sl4G+RUIxF+X18WQ4gwYY=
X-Gm-Gg: ASbGncsIV19Khufp8FFK/ZbT0ybX4CrHqCqywg6udkul8DGo+yZ5FF8DhU34iys3c3d
	A5W3rQQAaI7LYTpBRScALbi6e//9i+1z7CZbAgJdDrtonxYYFyrlMbZ6tfa/3o83UMNy0wjwEQN
	nz5ZTE81BQtB4SD3yZvV6j8428YBB7mtcac2NCZpcVFyu3J7h3ooJePTvRYLfOJD29O2/GpVRb0
	eiVGc8DcKBiorTTiWTKN9TBYktHaXUXRrhNkTn5T0ZO71CTLoUmdng8gCeNiG1RAfjmYucW8cW9
	ZxyP34u0o6WxM7/D1QkZ2aJIxi8ruehw03DIzeqKDFKsO4I2DI0tZ7doSmJwuOs3aRGV7168oEi
	LBZ/GhyyBU7x+jvho7GRT77wOzbiSsBS9fHn5Oo8dk8zPvpsjoO0JXRCiQ5fJg2TNj+qV
X-Google-Smtp-Source: AGHT+IG5fHYm5DfMrn0ILUmvEuxKl6DoA5SDDt0HM3v0vmT5V6a7U33fuwM+eoxZlI8cr8trjwANLw==
X-Received: by 2002:a2e:9950:0:b0:32a:82d7:6d63 with SMTP id 38308e7fff4ca-33098baeb31mr106681fa.12.1752682672507;
        Wed, 16 Jul 2025 09:17:52 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab8ede38sm22547371fa.87.2025.07.16.09.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:17:50 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 16 Jul 2025 18:16:47 +0200
Subject: [PATCH bpf-next v2 03/13] bpf: Enable write access to skb metadata
 with bpf_dynptr_write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-skb-metadata-thru-dynptr-v2-3-5f580447e1df@cloudflare.com>
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
index 54b0e8dd747e..a264a6a3b4e4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1834,7 +1834,7 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 			return -EINVAL;
 		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return -EOPNOTSUPP; /* not implemented */
+		return bpf_skb_meta_store_bytes(dst->data, dst->offset + offset, src, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;
diff --git a/net/core/filter.c b/net/core/filter.c
index 93524839a49f..86b1572e8424 100644
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


