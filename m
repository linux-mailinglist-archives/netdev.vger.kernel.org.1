Return-Path: <netdev+bounces-235977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE8EC37AE4
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 21:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36C43B6AD7
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 20:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26045346FB3;
	Wed,  5 Nov 2025 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ih1BllT5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC73431E5
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373995; cv=none; b=KTR8wRauoFYFFJpgJevOnBYpQkcqST2LTD87CzmOO98AvmKaNR9+13gjl9jeywrSdOSW2pCQODrSstIJ7JdkgIiDRqemam09PmnjDYs0rB2uNEiOJNkCUYvI6wtugpwKLDIsg1g2IZuphrgpuJYef5mFK3ZT2B71glwpzyGelWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373995; c=relaxed/simple;
	bh=+IZsv8bUzvX+j8yZwjOvjPLG0t53WwZ9DVonja+axmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ddHc/crIIhu0XdWqotCvgZTGs8jorw4gzo3n1r3hSqyXPN0M8ILJ5E8Pzn9mNoaWoRpY2yEfFYWhgbUYNf0pG8pfmK6DrEqV2ut/wmHWbm2Y4UVpATepY46K+YGPePL48tNz93ndhmJ3H5s9zHnkL2Rzkl0/HsyE8GzxAuv6CSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ih1BllT5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso44890066b.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 12:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762373992; x=1762978792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSCMhlQItRnMpGfsZXReXH0rCegBE+8tz6Hg/XHfL5M=;
        b=Ih1BllT5wLEbvT9JxJ14tIJo+8K0vq3+EGL6O5oHwgjgO9U6+U9C/djnOaTauiGVj3
         5WxXT+iEuY/j3ggGY2UBmZG2kN8VJpDXSmQYQ009hF1NURI+dMnbuSdMT2tEY4243twV
         3yfCNUwUakOhnVKcNEbYkwAzeaeLLAVzfoNKtzk5IRe/g7f7Ml0SK5FeQMOyM4glatsj
         OD+ZhkYbRU3ilsneX6SvtHmWyfA2S8uvjuBfAX2VHp8OjslpXlMRZ+3zPLfpNwO6ijJX
         h0AhB584wUDziZhLX9g+JI2O24LHRQeOq9Nnk4ZfR6MxV4tB/wK/16Uir5VOejGNaV4d
         snEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373992; x=1762978792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSCMhlQItRnMpGfsZXReXH0rCegBE+8tz6Hg/XHfL5M=;
        b=uNl49MVuQzkPClUmg52vWFLTuO2BB1k6ilHzGLyVYgj2ZnQFaCdL1cmH0x3AUBNmlU
         C54kQnhaEiK+RKG8jAN0/pZidWdUvqpeDcLWpmoVQUedlgNLX1QiNUnAHV2XJ9uOXsQU
         pCKBFZh6h6NV6ha7x3hE55EG3LAsXJJ/9EM0N/Pv382xlB04/Eq9CRM7LIPk09gmjyDZ
         UXZJX1wHkjdx6iIqetVzx2vuTDEo/A8GhDSwKbVhrzllxBGmF/kHJhD/+wQhriaZ43P7
         zKDyJldvrihw0a0c3sIBtOpqM45aU9nWOWcq4VwtKAxz1O9F+D+nrZvcQ5t0NHa0weeF
         /UIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWt1MgBOFYmu+RyjdhoObWdNTuk+eNN6L3q4Mjzc3Dp8nYBRLullS+5RowzIn43Kfc2svNZ9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbItZ8frmS8DBiNUtIKJPBfByHp35oZBAn75c1T9FynTXCukGR
	2VxhJblxOU2Ve8pMyYSx6vof8mw1naq41dI575ioa6Q8HFLfFk5mx/fYoKctNSzZ18Y=
X-Gm-Gg: ASbGncu/wxHl2in7Yzt6Jb5lfs8jY/9y2htmJTusiIaVkkFZ/YT58ziHQhjQfa7IU+o
	iaA/3oU30jrFEWfQZU5XesjnHWCbJXkWqAuGhvYHrIBJ9w1MlRd700AZKmdKHoh/UFi4SZfk86r
	5zb4AtHcr5snigTuF1OqDHdfzp7BE/QMH2fC/aGV2n2QLOQU4LDWlBpQKxELrOBco3p1P55qTHd
	Fx18xZgsex0Qmkv2AQGDDXgRFysfXwfuWJ5UOaSK+dLAFz99FQ3qffPZRiPCI1/MhpOc9n2qddX
	V3RByWgQb75btLKAm1PXLJ5W8Pwrj09d7BsmgxNrOXrmA2lKZkGln3TjLRMQhExeEyGLF4pz56Z
	NWQAmxAyiU5PaiBwC7rj4wl0ClOTuYMaljbk2K0cohNfWRuX/QDo6r9dsBmICCV63S+L6Yv1Myu
	9ie40VgjYMsWvRWY3fY7/zMsVyDMWH7hOWQwELhHX4f0dpNA==
X-Google-Smtp-Source: AGHT+IF07Dx5GtpeNwUcjPFYssQmnTuQ66L0fUjFMKdIx+JvJ9KtyYBgJgkLcezItt5mgTrctrPjjw==
X-Received: by 2002:a17:907:72d1:b0:b45:b078:c52d with SMTP id a640c23a62f3a-b72654d737bmr426268666b.35.1762373991556;
        Wed, 05 Nov 2025 12:19:51 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289645397sm45920066b.41.2025.11.05.12.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:19:51 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:38 +0100
Subject: [PATCH bpf-next v4 01/16] net: Helper to move packet data and
 metadata after skb_push/pull
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-1-5ceb08a9b37b@cloudflare.com>
References: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
In-Reply-To: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
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

Lay groundwork for fixing BPF helpers available to TC(X) programs.

When skb_push() or skb_pull() is called in a TC(X) ingress BPF program, the
skb metadata must be kept in front of the MAC header. Otherwise, BPF
programs using the __sk_buff->data_meta pseudo-pointer lose access to it.

Introduce a helper that moves both metadata and a specified number of
packet data bytes together, suitable as a drop-in replacement for
memmove().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skbuff.h | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a7cc3d1f4fd1..ff90281ddf90 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4564,6 +4564,81 @@ static inline void skb_metadata_clear(struct sk_buff *skb)
 	skb_metadata_set(skb, 0);
 }
 
+/**
+ * skb_data_move - Move packet data and metadata after skb_push() or skb_pull().
+ * @skb: packet to operate on
+ * @len: number of bytes pushed or pulled from &sk_buff->data
+ * @n: number of bytes to memmove() from pre-push/pull &sk_buff->data
+ *
+ * Moves @n bytes of packet data, can be zero, and all bytes of skb metadata.
+ *
+ * Assumes metadata is located immediately before &sk_buff->data prior to the
+ * push/pull, and that sufficient headroom exists to hold it after an
+ * skb_push(). Otherwise, metadata is cleared and a one-time warning is issued.
+ *
+ * Prefer skb_postpull_data_move() or skb_postpush_data_move() to calling this
+ * helper directly.
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


