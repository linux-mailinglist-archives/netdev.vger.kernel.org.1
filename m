Return-Path: <netdev+bounces-232970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A633C0A94E
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 15:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63533B0925
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4212580CA;
	Sun, 26 Oct 2025 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UhcTDHGC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232222494F8
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488322; cv=none; b=nZXo6Bdt5lWbph083CseFiDeKO89QQyOUIGCU2KlBQ0cR7N6aVt3QiJhT7VOk54EAqbgu/7rAwvtQbGwZU56kUhwBLq4z4THTvx/bMINfWfR6chGdQxGRwOzjHDd0ECEiDXmmAOX8Gzj9A90fvRNbNuJHKreLKHy/9qp52AVojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488322; c=relaxed/simple;
	bh=dg/CQiJ9SH+N8WLjJ8P6Yi5KMCvTXCf9lbKxGs0ohNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gKjMaZSh1M/Jy4bMbdz31NJiYDMm/VyzNGFrFnFA9jpl95SkYRhC2v8ubVzT9zU7VmcLE4St6fXDZfl+ctFt25oARZVN4Ved1oz7iXv58SlV2PWcvmE7F9jxN/A05E41+wOe9qhtJPYEaiyCVmOmcK2iQnNdUzL5wKCMTdaN5H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UhcTDHGC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6d5b756284so785914966b.1
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 07:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488319; x=1762093119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXk2q4ALXb4iHS81FjGOoDSTFyJQhG/HclBi/7HNWrs=;
        b=UhcTDHGCHBtU22Y2SlwQz1QVUphuAnTjNAgoaXTlprgEMgv02s9QzMXJX9cMHT6i9u
         /KuyU1sV5QynrBRSaspQVXXBFAZJwMqfWOW0jksA3msoTb6KEDBaeO6/bMqUpPJteXPW
         P7aSfsfaztNowzwKLDbGixMekOR7QzS0z+UTPxAuFdQvkVsvQRP2Cls/hDn14UNbrT6c
         KYxV4zdE31cttfxOlhvTMre/3H0Ym+W8E6kzvyEALQh4Zzaq7JuCKwnOyzoLlzBkGN0j
         FNJi0X5wTqADPoHyk/Z1Am7Mi+Jhm5Y94IO+hfoDD5uYC09YovIv0iNZOdopDQkCRbct
         hZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488319; x=1762093119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXk2q4ALXb4iHS81FjGOoDSTFyJQhG/HclBi/7HNWrs=;
        b=RK3lthEpts+Hn2Bo7g/y2WjOKHQqOsqtDCKqlJIync5H54Tw7UX+PfMNb0P+l0+zq2
         v4f9IpSymfXHkzO4Mq2rwBd+nVsvk7TpTCS7hLetLf+57JEcgHabW1e7xYkridAvHK9m
         rzYczUR+6hX46q4BcHCaBoCK8Lbh8x2+IHvnUvPBYe5lcL1eW3rOQtHEcKXCh2SyRz4N
         2WAZgdXpUV1+uaOqbmrD2rFNyrreoIJIvP0tf7TE1fqwsM4xruS3ALtJFlktPrI0yw8R
         Be6JSpdj2XdQERrHt8CNdP38k4AkuBOEFnTPEV+4rUaNwmPghowd5QanNOOoN8Hry//r
         izJA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ3r/V776aluWnFFJmECYPZNTD0wTXIyY+2NIo0gpHlrJbzJmkMlKZLLQ2FGq4kXntlXytZvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0n4R3eVgQeE9TLSiEjGbfGhq2WS7HnOxU4fdHpxKuwE+5ks8d
	mtO2qbbv7jaG9V60Bq0iluzQxYcFNXYvCYlsHPt0oCMqckdCYZHykthom0HwGPU7wsM=
X-Gm-Gg: ASbGncu35EdhZaVvGzAjKcCegffLhHftSXgvOflxh7g1fomZdTV/zrDZ6tIimB/cfXs
	BlLrrcHwlqjWDTZ4idh3QCN4LdpP+8DPjKnVsbudBepnMrLx7pyer1UoaDUHKJcRcztqCYsHT1w
	aEk+LJw7vLhR6GjxNq9ppB9+wmSpzk9Hxowix2D1sePnWZAtO1T61m64M9MLswpjW2oDXD/SypQ
	5K3eTQHj4V1GMMGP0irCDc4fpxiX/nHKsvd7Z5xfE7uWyGemlqONPzRzkiiYGZzqz5jiGxDny19
	25OZQs03mzHYXUpxNhZB3LLj2vCaDstBLcpXY33n/B2h8vaSjTjwb5zOpL55gSSsH1PFyt37c0Z
	vqBiZkjaLYiVO/yX4k4e70ModFvItS13OWNRwjAzbJMOZaY7wCFouxAIyVFcSaW9TqpDFuUGRBy
	CV8vvr/nKeAqnDSdJz5ixnRfMifzxPrSXsc9V9M2xBVkGUBQ==
X-Google-Smtp-Source: AGHT+IHsg2UYIBjTMv00llWKSnCWyz7iHgjt1py2DwYGsX2VBRlcMH1w9sckI9tXRwYDIwGh1mKrnQ==
X-Received: by 2002:a17:907:7e8e:b0:b40:cfe9:ed41 with SMTP id a640c23a62f3a-b6473b530f0mr4016640966b.34.1761488319403;
        Sun, 26 Oct 2025 07:18:39 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm469815766b.39.2025.10.26.07.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:39 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:22 +0100
Subject: [PATCH bpf-next v3 02/16] net: Preserve metadata on
 pskb_expand_head
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-2-37cceebb95d3@cloudflare.com>
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

pskb_expand_head() copies headroom, including skb metadata, into the newly
allocated head, but then clears the metadata. As a result, metadata is lost
when BPF helpers trigger an skb head reallocation.

Let the skb metadata remain in the newly created copy of head.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/skbuff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6be01454f262..b4fa9aa2df22 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2218,6 +2218,10 @@ EXPORT_SYMBOL(__pskb_copy_fclone);
  *
  *	All the pointers pointing into skb header may change and must be
  *	reloaded after call to this function.
+ *
+ *	Note: If you skb_push() the start of the buffer after reallocating the
+ *	header, call skb_postpush_data_move() first to move the metadata out of
+ *	the way before writing to &sk_buff->data.
  */
 
 int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
@@ -2289,8 +2293,6 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	skb->nohdr    = 0;
 	atomic_set(&skb_shinfo(skb)->dataref, 1);
 
-	skb_metadata_clear(skb);
-
 	/* It is not generally safe to change skb->truesize.
 	 * For the moment, we really care of rx path, or
 	 * when skb is orphaned (not attached to a socket).

-- 
2.43.0


