Return-Path: <netdev+bounces-207524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFA0B07AF2
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09A4585ABB
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED94C2F5465;
	Wed, 16 Jul 2025 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SMWG6Xm6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2601F2F5C52
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682678; cv=none; b=kqyRY4OVHQ/LhI7zGGcpFCqbG2RTB9vBB2U44RDuOMPnjeENZUSYuG8dYdvsRRi4JFYxshrnT1SK+trf4tB2IcGwHA5+s4Koe8K+u/uhnLX2UmcRPjheOiXMfxd5DpAPvWSdN4tbjVQCHmgiUeXpYM54XPIVMoBa+Wn+Y497ziM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682678; c=relaxed/simple;
	bh=ewNf/yPyalb1C4TBp8pHMc0BV1sFO7SHvBFjDhYkbro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k34DBQYMXRKghU8ov1hLv8Urvwcol15MozbGpApA0tZseR2gWqmUQ/r1VGlRZeOn4VHiziQ1kkMDJx82ZqhSOb9EbBEhL22+a1pFpI9vcFsRM8seJSh5QSCfgEhkVxnR3rTsqXViwxRrr63cmJSeLzyWJONTBmBuiZMU3gB+M6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SMWG6Xm6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553d52cb80dso73064e87.1
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752682675; x=1753287475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bl7XwzUExtDfNh5T4XxzNX3UfEJKH3S69WMxYHoR2+8=;
        b=SMWG6Xm65B81XIynBnIOWy/mdKPbTme7q8p2NshfB3pUBXvsTH3UfL5JklN5l3MS3f
         gmPKk6UIhCwq+8hbokYNBwW5DdC8uePrCCAboaMhzvBw6bwQD//sXt4HG/bcQ+37BLqu
         /jLKMtBbPnjARhhjfi11CiY9geSX/+FSvw1fnfUHC8PJRYAMgMzYg5p86hKMtiewAIdF
         peURXgrIApsmyWOrbgN0+UdU6O0eeccC14v7wLVymRs78rSIZWoL5SpwjoA6/poRMskc
         y/zslxhU3/+cjOos5gBlJXNWuHAfw+5zhO6WcyV4kGzHaqVFEFtibCLO8zen7evmzfn6
         +9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682675; x=1753287475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bl7XwzUExtDfNh5T4XxzNX3UfEJKH3S69WMxYHoR2+8=;
        b=U0J/9EXKcK3GRq+NNvqD2O8IB0jXxF6YWnYPWmg5r+luvVo2G6frLeNgZ8nT9WoE+J
         EROMJVr9uGD/TzcBGWlLSwRmN8B/j7KhyTeD3kGd5+dIcQz7XEiHxXiYwg3gr20FBbR1
         bjURKbIFN4mCrzG44WC+txHaqQkv4kH1PBYKly6sdHtWgTO8j1YeWLTTsfQKdFbuM8Zm
         EH8lZDiuDJZ6+pW5hJi44EM7Lm147EGvWWMCVyr7mMNC23nFNCALkIHOrlTzmpK55hB0
         JPhDL+yzDS/q882f4ooea/BLc0nqJz3pRKp8GUjn8YxswUXaJz4xvMDw8lpEhnidxwci
         H8Og==
X-Forwarded-Encrypted: i=1; AJvYcCVsWNdTDVd4AM6Nbpe4A5QxhwdlX+LWOTtw7CNkrYRS1eCWs3cy5/Y1ETpF7YpOQNpZxX66cyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQyMeNxubsbDA+0wTBp9ZEO/PTErbWeoFx+wzoMD9Y1j4fhqgp
	9tLigdsjOI858mASi6OW6VU24czvGQCWnWqY5+KsEWvR1+B3Q/idoN/RmvoWZSbcdhA=
X-Gm-Gg: ASbGnctgu68GzQ2PJ8vjgkCKprnINis88GVocYHPI5m6GzG/jr7Ju9SGhRLbEk/FAWo
	Y8aA8+Kc2/0qaJe5v+5o0682BDPW7ZJR+yiGJZISybMoMVG1sljiaYtaXMngygBHCuFPsGffIU3
	QXQKN2P6glLZ4qxVYh+xPOKpXn7F11WMvVVVVUuggmN9vu1ZKaamDDePZErZeAe6jsHVfV3sgJG
	/88dzAwABEjq3D6bXh5H6DE+0H1x8la0akiLY2JBNbgXR+b43UjD6KL09dvi6Xx4RkOvF/AFEV/
	wFqtAcnHAL1DufWI/EBC3pAalw2mbsqZ5iksUDbjp6bBqwq90jvzpvYLB+KcpyOBxzwr88VaB+C
	+hnT5MlRmH88FThOlKPsVsoKCjj0KN3kJM+IAqNgK8M+s1jqSYQUZZV0NGwRrg0Md7G5M
X-Google-Smtp-Source: AGHT+IHT+yoSwkaf6TogUHQSXHE4d+/03H76idGOIyP7T+08yIuaBRthlv71/3rA3dTNKmenJ2M65w==
X-Received: by 2002:ac2:51ce:0:b0:553:9d73:cb15 with SMTP id 2adb3069b0e04-55a28b1f15cmr7942e87.15.1752682675173;
        Wed, 16 Jul 2025 09:17:55 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b72f3bsm2696567e87.208.2025.07.16.09.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:17:53 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 16 Jul 2025 18:16:48 +0200
Subject: [PATCH bpf-next v2 04/13] bpf: Enable read-write access to skb
 metadata with dynptr slice
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-skb-metadata-thru-dynptr-v2-4-5f580447e1df@cloudflare.com>
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
index a264a6a3b4e4..f599a254b284 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2711,7 +2711,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
 		return buffer__opt;
 	}
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return NULL; /* not implemented */
+		return bpf_skb_meta_pointer(ptr->data, ptr->offset + offset, len);
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
 		return NULL;
diff --git a/net/core/filter.c b/net/core/filter.c
index 86b1572e8424..d9cd73b70b2a 100644
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


