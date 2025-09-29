Return-Path: <netdev+bounces-227174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDEFBA97E7
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2965E7A2A52
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A6130BB86;
	Mon, 29 Sep 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="J3S+4xa6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC93A3090FF
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154974; cv=none; b=ZOIgyOtIz7slPKQ+k4xJmLNUC5gglPpyzx+6ebCfzfyndLSQT3UOP4jiV2aGlaB8ELe1+IlERSmLJTMTe5ocnXx1t4+CXEJOiilSbXnNOy9gKmOeCKgeeJndtTxsUlMMKdVFWmOWjoIB4tFvEmlffQW96osXTHw2CSpqkAf7xoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154974; c=relaxed/simple;
	bh=BgOR8bzAO8QkIkPvLUhe9jPbzwE7eBy+kPUbUnL7JiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZVk3VnAEOdepd0PrzH1fQBW8yEVX4FXoQW+aBLQtLcR8my0UZsjxzzsU0to6S3PjQ0R9o1T7vdLHpFU7ZtkgOw+u6qVO+dB562oRrfzbNAyMLdtA9dvZC5qKT6o8dOtSsvBHuHc6TlA5AsaigPiUy5RSml0ChutJ3j4WNfDh5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=J3S+4xa6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3d5088259eso225358566b.1
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154971; x=1759759771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/TmEkEKPYb4IvmOQwqL1V6bPCyihwKao023pDUBEQk=;
        b=J3S+4xa6fFKbpHCHWNww0X/A1q2QyavYV74PLZ//OdbOXs0vJnQlOvFOjTLjHASWCR
         Q2oEThCv4KCkpHvDZ5fM/7fZlORiV/dFdHcq0+rBBbnmecH7KR6r/unLq6ErTtIW8PVg
         /0tSfY2BmYwExs/CckehvqUlYr8UUVvMRUmF+I/X+t2Hf8Zt289dkPGXFiBKlyhc0+jH
         Akg+ghWY8TSqXedSLg7TdjwD1wrvLy5FDyWV3UqwHDCXcYozrX7p0o1hyEuL6EyFQJT4
         UpGgmDNF8DjkT1DEZjIF58xyJiwNZwshnT2fmsvoLGMtLKfIMn0iWwvv5f8e8ySytUac
         HkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154971; x=1759759771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/TmEkEKPYb4IvmOQwqL1V6bPCyihwKao023pDUBEQk=;
        b=ac5zweH62HJ+X8mPU8kDvj+oF0Jj6lWS/orsfjArfRz9t0uh3gZ50e6OLz9xH8jj3O
         JdghBmRBKnBnOMwGWrU62o2jMVkO1coglOr9h3qvJdCVRjTe6nGBmtgxWLNWKY/2dHvH
         n7ernifA4EagWfKJZ52VSZ1aVnoX6wFFPuIKgmA+hKtHmku8cZE9xJsTzBLJMDN1DOVM
         Z01iGEv381+A89eQ9n4Noh+44/5WYsOKlQBM0+ioHtP0zqp6E/6piNCoE0kdYttUikX5
         dltt/vKWltHqfn8irOIkXGb2FGBhi2897aZwvZIgdSff04N/PKl/JA/SWwx0EaAIKkmL
         7wbw==
X-Gm-Message-State: AOJu0YwzibCV5uCdKi2/ZelwJ1x5LGBcgsJl7UYV1O9CpuXgX486Ou5B
	FwYQUHOWOh+UXZGlDKjlmPIGLHBlEx3C7nqY8ujxUU9dx7BN71L1gDdxirt/f9ynsEg1O1TObKW
	+IeCK
X-Gm-Gg: ASbGnctt7xGZl583d6gIZTsuQdtMtPojbKgnR2jUit1oNpDncro0DcoRYle8UZzg+ax
	q9xJEbKXebgy4w5YxtQJYPTTMAc5fcLGEaqPCdZ1HdlvD4yv3FJTY2VexgJveX/zexKQEnL+LEk
	f8tnmZQOewDqVk13cE+jFfZoAu4/4V0j7TJE9TIdnGX5D/fw6d2jHOGwHqNlqbQsJ3/8GH+78xa
	hKugkBSJTjAzYeU1mQMsq/4Mf9wZPZuhU1mGpS1XR0Qhr9I8QopigNlu55o0XfZ94xlC6tDoswH
	k678s7fFFYhR/UlXAFBW6AHCE5D370eHNWY40svw+3r672lz83KdAC4kjxFExwdbAfliXNzg2lT
	pAVS4ieMH4+J7Z+l33++6/nDnT5oXJXnlCOWNHd94jTdZ/KX2/x+Ks+DyzqeEZVF/+YyclOI=
X-Google-Smtp-Source: AGHT+IF2bkB5c0b7TIiqTGkEKYPqRERLoMjLoZPQYy8Agg2IXaG2QltRUgoaBeflXjkeWABgYm+dyg==
X-Received: by 2002:a17:907:3f12:b0:b04:7541:e695 with SMTP id a640c23a62f3a-b34bb9e9f27mr1788285366b.32.1759154970501;
        Mon, 29 Sep 2025 07:09:30 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3df8c7aef1sm261583766b.11.2025.09.29.07.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:29 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:12 +0200
Subject: [PATCH RFC bpf-next 7/9] bpf: Make bpf_skb_change_proto helper
 metadata-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-7-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

bpf_skb_change_proto reuses the same headroom operations as
bpf_skb_adjust_room, already updated to handle metadata safely.

The remaining step is to ensure that there is sufficient headroom to
accommodate metadata on skb_push().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 030349179b5a..c4b18b7fa95e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3324,10 +3324,11 @@ static int bpf_skb_net_hdr_pop(struct sk_buff *skb, u32 off, u32 len)
 static int bpf_skb_proto_4_to_6(struct sk_buff *skb)
 {
 	const u32 len_diff = sizeof(struct ipv6hdr) - sizeof(struct iphdr);
+	const u8 meta_len = skb_metadata_len(skb);
 	u32 off = skb_mac_header_len(skb);
 	int ret;
 
-	ret = skb_cow(skb, len_diff);
+	ret = skb_cow(skb, meta_len + len_diff);
 	if (unlikely(ret < 0))
 		return ret;
 

-- 
2.43.0


