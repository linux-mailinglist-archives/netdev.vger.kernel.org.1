Return-Path: <netdev+bounces-230718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AED4CBEE533
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 14:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D38D189CE5E
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 12:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0B92E8DF0;
	Sun, 19 Oct 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BlRzTJvX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0760C2E8B8E
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877945; cv=none; b=SJW4ynyKDCRFZfD12cI87fqHd9q8v0i2L5T+4Fm2Ha4UVWFzzsJ71R4Dmqz1AUrMFud1Q9PiNI5/DO8b9oZ1JTZFz6QMFKxhReeaSAO/RFl8jgqdFdOo/ITJYmktrBVXJvMvizJm6ccpevGLYk08/Ioay3uBYmT8Qtc1ZRoGfGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877945; c=relaxed/simple;
	bh=4FM5pTwRyNDxGKVJYoT9oserXe9/LVm7gaunHIrA810=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y58UJDyXLx8vwBwiOafzgJZORmYEsuRJuoBAV3552hjwlfKuJfceRVolx686l1BhKQRV21tkyzEUu+cjxF87GPErlh8y8rRSYoUVKbGT03Gwz76TtoyiQlMHI3sWkaMhiVrm4Us3GEbmzswsnYB2q5CRvGVl+IG3z3PWuCyd774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BlRzTJvX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b48d8deafaeso760733466b.1
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 05:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877942; x=1761482742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPijv+eQjDmgih+DpQJQJFNWzM+qXCvpQajzPenBLoM=;
        b=BlRzTJvXL4+2sQyoA0uQrSi5V2Ll8bZoVgqdKcRVDhv/FZdQIxzZWUpG+y4MmyydVX
         qhRN3wnnMawiYBQHhBE3CEJi/Wl9E9yA6lvDSKabU6+grqblLCw5qh2WIF+e4mzIV8US
         4NaH0asFF9mpW2/rXHtLZE5mf2pbPkSboYyxo3nBEz9C5sDb3efymr7W0xLl3ajIm1M9
         wr09AJySoTKTGnRqxSTbORihVeFPxJH8TVBgqi8/hZD1LV/E0oUrtqrdNh4PatSydrGn
         g2hIdEneGHbSyLSBddCi5zsbV1qUz4kDQn+gsshMkG1WUZ6HmC5ly9jzgEN7n/hhoQH3
         tgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877942; x=1761482742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPijv+eQjDmgih+DpQJQJFNWzM+qXCvpQajzPenBLoM=;
        b=nNqsi9Exlv07OHHeup5T508ZjxAfDi7XXWtKR+gQz4f//bMQDKVs7PE4WhyQuVMuJG
         sukPb4Ly/6WSPwLaHIVdtFPfstqBWlyRLIB0qObhmACUTMSTaMo6miVrEcYZSkp4oSMy
         MI6OVCnysw5Ck3Fh+p6mfb7MB48tQO4GMKVOYhZioWoN2ErdWNGHHmu9esuOPwJK/OUy
         RzNn2S0IfxavLhorw2GVckeMb89wZgmtEl1qw18c09V4QsFb7vEyyUenP+tpVAmZv2sf
         3ZqSOGY4E50BKegIr+WhSOFlYJ1sZPr5IX+wIFhNMQTm+K58hJINLxMSEYazHZmYb2jR
         /qCg==
X-Forwarded-Encrypted: i=1; AJvYcCV/9l5VAnZkaxp7OzRS8JDikh37eD18zn34k0uyTaXTBAvoTNYi+CY35/7ri/unAnVyNM38QJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU7kFTQTEy0LK+A2Pn9hCzAo66Mo/CXUd8VAxqtZJB9diNtXpk
	iKDq5QbqJa42uz+cWyJZMk6u4BghpIHkL808NoFUUkSQ3mSY5GPzsnJ8W0J74aQBwyIBzNuVHs2
	YUxP2
X-Gm-Gg: ASbGnctRrurOh4Mn1h8PuMXDG7BPuMi/W6bRi4HExIkCr3bxCd1xQXcEgPyzeAdQvhV
	2b6KU3nDqUW8rqt1LMHHmdY6AEqiY79G9PBMxt+WMxsww8f/swVboWCK8gnLZ+XX7r/Smn1xUz8
	Qc+h/dvcWWB5wtZegvR120gEpUnV2y7WUwWX9YmjF+buNe1m8qZsyoZAtE6nnQjbHCaPyvY7rL0
	XaTC9D0f58/LdMxWDOBQgNFn1pgPMuSfa2sG5b4z8rla9y5f2Wql4R+ilpngjDypv+uJ/zfvSCB
	AVUMmHQyqhEYL1/g0lNDqS3BfqMKIQNe3LLGFSrfwN0jkMo0dlYeOtIxJGNs+JNHt0+Rtzowvsh
	zo2NnxeD4foDxzyBo4iJ8P1F/vJmVFXWuH4PzPidwOcOB9pSmGGQxM9t5ax+0Yhupqxuyfe3YW5
	r+8JsUXOc6EKocXaYJvkzoS6LfRRjsaGe+6sBvr7dBBSW18TFK
X-Google-Smtp-Source: AGHT+IEBNRih2WL6eZLwqgUZiAfDtnFB6140e6RbS45QXX1oWPSZjQKAqFHJ3k16cAJboJyl7lPezA==
X-Received: by 2002:a17:907:6d25:b0:b45:cd43:8a93 with SMTP id a640c23a62f3a-b6474833449mr1160088266b.62.1760877941875;
        Sun, 19 Oct 2025 05:45:41 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83914fasm492050666b.20.2025.10.19.05.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:26 +0200
Subject: [PATCH bpf-next v2 02/15] net: Helper to move packet data and
 metadata after skb_push/pull
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-2-f9a58f3eb6d6@cloudflare.com>
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
In-Reply-To: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
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
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Lay groundwork for fixing BPF helpers available to TC(X) programs.

When skb_push() or skb_pull() is called in a TC(X) ingress BPF program, the
skb metadata must be kept in front of the MAC header. Otherwise, BPF
programs using the __sk_buff->data_meta pseudo-pointer lose access to it.

Introduce a helper that moves both metadata and a specified number of
packet data bytes together, suitable as a drop-in replacement for
memmove().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skbuff.h | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fb3fec9affaa..1a0c9fbbbb92 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4561,6 +4561,80 @@ static inline void skb_metadata_clear(struct sk_buff *skb)
 	skb_metadata_set(skb, 0);
 }
 
+/**
+ * skb_data_move - Move packet data and metadata after skb_push() or skb_pull().
+ * @skb: packet to operate on
+ * @len: number of bytes pushed or pulled from &sk_buff->data
+ * @n: number of bytes to memmove() from pre-push/pull &sk_buff->data
+ *
+ * Moves both packet data (@n bytes) and metadata. Assumes metadata is located
+ * immediately before &sk_buff->data prior to the push/pull, and that sufficient
+ * headroom exists to hold it after an skb_push(). Otherwise, metadata is
+ * cleared and a one-time warning is issued.
+ *
+ * Use skb_postpull_data_move() or skb_postpush_data_move() instead of calling
+ * this helper directly.
+ */
+static inline void skb_data_move(struct sk_buff *skb, const int len,
+				 const unsigned int n)
+{
+	const u8 meta_len = skb_metadata_len(skb);
+	u8 *meta, *meta_end;
+
+	if (!len || (!n && !meta_len))
+		return;
+
+	if (!meta_len)
+		goto no_metadata;
+
+	meta_end = skb_metadata_end(skb);
+	meta = meta_end - meta_len;
+
+	if (WARN_ON_ONCE(meta_end + len != skb->data ||
+			 meta_len > skb_headroom(skb))) {
+		skb_metadata_clear(skb);
+		goto no_metadata;
+	}
+
+	memmove(meta + len, meta, meta_len + n);
+	return;
+
+no_metadata:
+	memmove(skb->data, skb->data - len, n);
+}
+
+/**
+ * skb_postpull_data_move - Move packet data and metadata after skb_pull().
+ * @skb: packet to operate on
+ * @len: number of bytes pulled from &sk_buff->data
+ * @n: number of bytes to memmove() from pre-pull &sk_buff->data
+ *
+ * See skb_data_move() for details.
+ */
+static inline void skb_postpull_data_move(struct sk_buff *skb,
+					  const unsigned int len,
+					  const unsigned int n)
+{
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+	skb_data_move(skb, len, n);
+}
+
+/**
+ * skb_postpush_data_move - Move packet data and metadata after skb_push().
+ * @skb: packet to operate on
+ * @len: number of bytes pushed onto &sk_buff->data
+ * @n: number of bytes to memmove() from pre-push &sk_buff->data
+ *
+ * See skb_data_move() for details.
+ */
+static inline void skb_postpush_data_move(struct sk_buff *skb,
+					  const unsigned int len,
+					  const unsigned int n)
+{
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+	skb_data_move(skb, -len, n);
+}
+
 struct sk_buff *skb_clone_sk(struct sk_buff *skb);
 
 #ifdef CONFIG_NETWORK_PHY_TIMESTAMPING

-- 
2.43.0


