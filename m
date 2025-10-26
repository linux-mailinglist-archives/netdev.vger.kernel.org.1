Return-Path: <netdev+bounces-232971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2823DC0A954
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 15:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203FF3B0E7B
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAE92C11C0;
	Sun, 26 Oct 2025 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YH3U2Ime"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78477256C9F
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488324; cv=none; b=QBuYOJtAqTM0pdrohzYj3pdq8LU3bkg5jFknlmqNyAzODy+yC4HCtA8R3wV5irFExBzbJwOXYl+x9YsT0Q1EzPD2rVQTC/Ibmwdo5VvHao6RR59MV1rvwkp7C0xAfBL1Q9vljAYBuJN3edUoI1tPM4XyhP6bslALC0VYzyHliwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488324; c=relaxed/simple;
	bh=Q3MTKpFXBmeuHsk2LNigWyOZO/7FRjOOFC7vdk21HrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kKuqs99MhiOYpPWEtI67VqKcMh5yHZu1Gq7uuoE4rbD6eKms176QL3ngdLVvoYspin7Kui9fiUR/m7lsQdgJ2mv6nbqIku8Ylgzjhq9OndSaA5hIvN1fmY8HwDXnIjXzLVrHGgixB4gWO79iND5LxvDKdPPB/B8JKaFIsfKFrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YH3U2Ime; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63e0abe71a1so7544519a12.1
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 07:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488321; x=1762093121; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGYJhxrTJ68z2dk0/14b4PuvkhwRu3VHllEhyEgQEHE=;
        b=YH3U2Ime/bxV7jG4OkLERUuSKLydmv1pysjKp7xBHhC5y9Kyh9odHXgisf2QGixRU3
         /X0MS+t0MP9OaUQIE3DgHaCBj6muqriKhqfR3Af1ZLLKt+AidLfrdoDti1DYcgZCmCsd
         M4Hz9p2C8kVzfXtpmhbZv9V6CDr22j+Kgm+ZXGSgTDK7Jc5+rCoEU+2GBX9gmbcyCgp+
         fPlgPMf0+umgEgo8GSBKM7qD2cfZ3Kb+ziLZ+d/y7fP4zie7Il2vJsvF7TKl26HfM85b
         xzktxqzGo6hkc1YbkSXdcEH1ocVADa0mEdj0NXQUvZvItg5ihb2wnEL21ICQH4lmzTMl
         pQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488321; x=1762093121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGYJhxrTJ68z2dk0/14b4PuvkhwRu3VHllEhyEgQEHE=;
        b=Ek5+Ih5KH0COz+3vddhlowjqunfVnW5PQV85lEfTattvlREcduBQ7TrdhSsC2GGvh1
         28XIS3boy/RA5wYcJpykPPN0yZWww//OFGd+Amtva8RQpQcuzvWvADWbE3IT51CWdJj1
         z5DGiIo7I5EdyTCV+HnPHh43yNGt/caNW66NAAWNXpVPb+rStz1pomJxarheTLlv/Log
         FrBhQzl1AK8k6wRk+F6QFWmfEQLcQe2gK7DH/Xymv3QW9MAs8f3v3MBWk97I7JGXTSo7
         XGinkLg9JlHip8vGyqePfMM08khFnWuDyCrvpeM7K3fQkLaC+iei1LzStA/iAkLVEetz
         dDpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAliNvK7RKkGW4e0AV2V4MH92o5TG0wABYOUj3KIfBwmMNqPfIj+pRl9+L2CujoelSivi8Fx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAXDSzJdQ4Vgs7UffJ7rn9jYo+n384rIVOy2lgJ/Esoudohi7H
	l0IqDzsmuw1gC72tEPqAdhRh2y4xdsz4MAgfzUQc0mo+qdARJdkJ7LqOyuXEVSK+OCk=
X-Gm-Gg: ASbGncucMpfmTMJKXZtgh/xfQ/TiziSIM85Ij+eIGi1yUh2AHOTyh/gDaFIp8M4LJGp
	zHm+pYxWbBOpxnOZDQqNeeVshhtVwfVx5s9cNhaClevvzM5j7DavMouHEgTmRsqUPgarW2O746D
	ojg4KSd9zGYIjgSieFjcIlc9bPeJU5errxE2NwLTIWO0n92HvCV1Gy32JWp8lCv/GXemhpaM+zk
	4gC/XkWqkhIsaYcFG5dbEgY+kOKBGGWA8DdS+YB/92GTSVBiz9DM8Mjb54OrcipVzTSmSZtC19J
	U1sxOT643oaQj1ocTBCtNRBhn//+Oes2RImTR0VIgzwNtGNEXHzCdhp/04nsA3bjtUcoJW+yNFt
	fyHajRn4CZHPSVFbg8mwuMhk5R8/wTnM/kx0u7KHq+xuKGR+a5cUKrINuYjGuSOym+HHxjJml9g
	JjZChPNAhW8P+Z7rcajm4tZqowLYo+HcFJYK28Ybfn+7MF6gyKIB3WULI6/XzgQkTRhFw=
X-Google-Smtp-Source: AGHT+IGLDCtW+rkVJlDsTfobSmt/SX7OpF0NsbfxdsekDiotLq0v+xiOxU+o063u2gx5m3AtnAV+mA==
X-Received: by 2002:a05:6402:440a:b0:63b:6b46:a494 with SMTP id 4fb4d7f45d1cf-63e3e10eea6mr10711569a12.14.1761488320595;
        Sun, 26 Oct 2025 07:18:40 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd0c1fsm3981358a12.37.2025.10.26.07.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:23 +0100
Subject: [PATCH bpf-next v3 03/16] bpf: Unclone skb head on
 bpf_dynptr_write to skb metadata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-3-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Currently bpf_dynptr_from_skb_meta() marks the dynptr as read-only when
the skb is cloned, preventing writes to metadata.

Remove this restriction and unclone the skb head on bpf_dynptr_write() to
metadata, now that the metadata is preserved during uncloning. This makes
metadata dynptr consistent with skb dynptr, allowing writes regardless of
whether the skb is cloned.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h |  9 +++++++++
 kernel/bpf/helpers.c   |  6 ++----
 net/core/filter.c      | 18 ++++++++++++------
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5c859b8131a..2ff4fc1c2386 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1781,6 +1781,8 @@ int __bpf_xdp_store_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u32 len);
 void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len);
 void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		      void *buf, unsigned long len, bool flush);
+int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
+			       const void *from, u32 len, u64 flags);
 void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset);
 #else /* CONFIG_NET */
 static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
@@ -1817,6 +1819,13 @@ static inline void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off, voi
 {
 }
 
+static inline int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
+					     const void *from, u32 len,
+					     u64 flags)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
 {
 	return ERR_PTR(-EOPNOTSUPP);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b9ec6ee21c94..f9cb026514db 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1838,10 +1838,8 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 			return -EINVAL;
 		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		if (flags)
-			return -EINVAL;
-		memmove(bpf_skb_meta_pointer(dst->data, dst->offset + offset), src, len);
-		return 0;
+		return __bpf_skb_meta_store_bytes(dst->data, dst->offset + offset, src,
+						  len, flags);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;
diff --git a/net/core/filter.c b/net/core/filter.c
index 9d67a34a6650..a64272957601 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12022,6 +12022,18 @@ void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
 	return skb_metadata_end(skb) - skb_metadata_len(skb) + offset;
 }
 
+int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
+			       const void *from, u32 len, u64 flags)
+{
+	if (unlikely(flags))
+		return -EINVAL;
+	if (unlikely(bpf_try_make_writable(skb, 0)))
+		return -EFAULT;
+
+	memmove(bpf_skb_meta_pointer(skb, offset), from, len);
+	return 0;
+}
+
 __bpf_kfunc_start_defs();
 __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 				    struct bpf_dynptr *ptr__uninit)
@@ -12049,9 +12061,6 @@ __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
  * XDP context with bpf_xdp_adjust_meta(). Serves as an alternative to
  * &__sk_buff->data_meta.
  *
- * If passed @skb_ is a clone which shares the data with the original, the
- * dynptr will be read-only. This limitation may be lifted in the future.
- *
  * Return:
  * * %0         - dynptr ready to use
  * * %-EINVAL   - invalid flags, dynptr set to null
@@ -12069,9 +12078,6 @@ __bpf_kfunc int bpf_dynptr_from_skb_meta(struct __sk_buff *skb_, u64 flags,
 
 	bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB_META, 0, skb_metadata_len(skb));
 
-	if (skb_cloned(skb))
-		bpf_dynptr_set_rdonly(ptr);
-
 	return 0;
 }
 

-- 
2.43.0


