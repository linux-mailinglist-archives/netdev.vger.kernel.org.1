Return-Path: <netdev+bounces-247769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E68EACFE501
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 15:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E90F9305EFB4
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 14:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B48D34D388;
	Wed,  7 Jan 2026 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PwnWum4Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A334C13B
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796098; cv=none; b=Ohv+zt/xvgc/dKOJ94FyLAHzTw2jjs4kw5hgojjQMkpl6BwKkfGQ3+jirK3HTi5c1ZPPWnK1ENB7J7N8ECjL8rxJJybnPwu/wr4JL8Y80RREkNYs0mxmqbQ1rAzy9EeefKih8Y5qk22dqj+M093Sc0RPtWlILyIywkcNKAWARR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796098; c=relaxed/simple;
	bh=EqBhB6y4nXWzGaTVlNv0CC/SrtIcyYjJWnFdNxvlzoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FM+vJnucwQ2/QN9iqtt3hJ/ffWBLLyOyGWzUjoPLDeNBWJ2VuujnNHTTsZLBwuqZSJfHCZlYPElmibNoeT2ffInMrRrR47fZR2egzV4u91yZrQcWnyKcMYE3YWVbETWSuI5PAttEWvEkAK2owTgLJNjLpV5jDYFMH1fq/SCsx9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PwnWum4Y; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b73161849e1so371677366b.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 06:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796095; x=1768400895; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEldMdCG0j62Bqlt11G+kGjryDuviTYdgTtDogGixLQ=;
        b=PwnWum4YQxv/4sRr3Wi2yZY9u3+t6iknJBIUtrLoxGDpGeQDjv7YZbUOJJ9wOlkE0c
         /7VIZlSAkJNuVFHe9lpFcdKZPdCsPj7jJuoEmfFgCPA2P38tG72f6sBtkov1DFWYFs9z
         akgEmiPnvSo3xCiwFAeXZuFHHURyn2Uz0JnLfrfRZa68brH7TUgxdy8shO9ygd+Sz1rh
         l3YMoz5FBG55dggmiyU4K+sePSyz9BTJ1e8FVJ5EZpz3t2pQSegTloxICs4x+r9bGrc7
         T0Gzt1dkuETFVuyd4RJgYEwEa2gHcmX8wVdZIzDY3yXn9wC7Lwb7Ieet6fWQ5lBAjE/G
         HbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796095; x=1768400895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eEldMdCG0j62Bqlt11G+kGjryDuviTYdgTtDogGixLQ=;
        b=Rq8lV/LKRN1ZR5TFElNH/03P/sKR5V1UPbXe214fD2AOD5e65UQ8+e/c5Kebf0T4hD
         Gi7xOPLI3sa3G3sA4HLKJnXlCeGUE2UNoJVs57/nRCX+cFNC4dJeyq9kv/LSqYNLReZf
         rnMCG4MKPe88eCmAqSLLR1ZGrt4nQNETkhPdBBMXoUSWQtS2+kbtJGEgQ4Ry0JQc/+s6
         Vr07tFdzGjYgKvedRpWBGk6G9t4KCSIaNfyzNtWFduic+OuYKZ2MH0WZwvaamtcp7G12
         /qZUcMr8tSqwqON1SOaQlTD/qJk/e/GolC0Ntz0V/igKO5oBsecTV6zjl6tgattUssik
         KbVQ==
X-Gm-Message-State: AOJu0YwwAKQVnmHph7k8keJ9Z9FXo3J69Dm75VkqQJGnFkLPt1nDoWkM
	8Nw+NhxD3x6bK6JEjJReouVuGcjGoEq6tPClwU4QAM605F8Yrf8ZTAT0sQvucsidpa4=
X-Gm-Gg: AY/fxX6VjCvAnBbKrP3nprHgC6wcAXh+jBaRFNZEvUfr2NR8duSJlC7oes5qCNwlgZL
	iD0VeP0+RfMIAR9QzF4/6h4PkmdYn0QNaaT/b7oi/sOqe65QzabTvE1LYdc5UaT3Qq4jzL67UK1
	GH4HFJInQLuz9DCiAU27c0qt4JcoixDqVyrhl5i19YFLW4lLjFv6ayUck1deId5pMyx2OrcE7ZF
	+hAUXv4Wf0kAO5GL6uehxOJqfeQY0GRUQC8MRv0j/0wYxdfOC2Pvqzd2p6vQvYhMv9BqMfHr0wH
	gWyOcvocMk+0oKKL5vpSVCYOx0mPpa0alyVHnpZUNf+gsD8pjLkI0Ii1awn1pTU8cYl4eQJjw5a
	6GV+kIMDaFgpD/QVaaO1z4X/C4P7JCljKzYZkkIGA6wecerxke5d8WcRtiF0PO5jlO9o7ji516o
	IqbV4IqRIMfvmwvN0ijALKP3H8MeeW+rpvUH4fZWYPB2myCYVunwsSB4T5kzA=
X-Google-Smtp-Source: AGHT+IFKcPUGIq+mmaMwAEQLCwLx+EsZkE4IjALey6nG5MPGe8BgpahZ8lbyqj5flRXjNA4QXcGT7Q==
X-Received: by 2002:a17:907:7f8d:b0:b84:41c0:94ea with SMTP id a640c23a62f3a-b84451dedf4mr261454066b.23.1767796094756;
        Wed, 07 Jan 2026 06:28:14 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a235c0fsm527821566b.9.2026.01.07.06.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:14 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:04 +0100
Subject: [PATCH bpf-next v3 04/17] igc: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-4-0d461c5e4764@cloudflare.com>
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
In-Reply-To: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
already points past the metadata area.

Adjust the driver to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7aafa60ba0c8..ba758399615b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2024,8 +2024,8 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
 	       ALIGN(headlen + metasize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	/* update all of the pointers */
@@ -2752,8 +2752,8 @@ static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	if (ctx->rx_ts) {

-- 
2.43.0


