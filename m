Return-Path: <netdev+bounces-230717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FA6BEE530
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 14:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFA9189641B
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 12:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC12E8B85;
	Sun, 19 Oct 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XrcvctAp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BAD2E8B61
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877943; cv=none; b=SfPRNsDRyEl1v7nZYKJsFh6gFVkceyyK7b9Ahzb8wM4xjZo6MwSh6sOJ/DN0lIl/3S2l3IZMJ3oiXwJFeR+h+gRg2kGrVtKSrIoQ7wGzR0kPMqzs3Hk0wO0wSzsteaBqL27LLmzVnkqiU88tL6UGCabVjMut96gt6Ys97NrO0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877943; c=relaxed/simple;
	bh=KhuYxnJEHq5CFYCn+pyNoEbpe8HKuPYNzX4WAR/9efA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RjG+Xsg9S6mbJP/aPooYRVkyJAy/u1oaUUeHubZxyEuHr2RB0uCLRrRuHPUCd77Mg0xQaPzkkzAu5Kr7VenAwe5JwrLsmG0h8+EtI24s7W4xfhDb6UIGaj8aSsdgF+Ut0aQV1RZX6Ioi432owO1IgKw0BcVtC74oEDIgK+PbjBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XrcvctAp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c1006fdcfso6501209a12.2
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877940; x=1761482740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wf9aBWGoVu9eQPsO6dCihEsriv6AslJ/nwpVUK+i0LE=;
        b=XrcvctApcbCaOmMWbNYV4FkZEzDBzjDS3TWs3L90eE/dW7HTjc1KHR5egXxfM98UHB
         EDld65jnTPC5LzlCl60MMbHZx+X1Fd4cct7gBLZLxVgmIEDbU1brHDb+xCSBsVF//1wB
         uGw13FbxjoXUMTKhb6dB46cvvgFV2biPC04nFHiDMZFzdAn/DeC49NnZzBDdtF/IibV6
         picdwQwzOXJvDxIUe0q5d2TAuTvcdXd16UxouCUOk0N4PoQj2xRAFWMKnjSxRSWEKl1X
         XOl3lL7WRypabuDVm8NtveikClY3ECkA/WS4V8xf3Fs1uvquSNpoXIPSHnF1RuCmII2Y
         UwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877940; x=1761482740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wf9aBWGoVu9eQPsO6dCihEsriv6AslJ/nwpVUK+i0LE=;
        b=GM0dhIrvLDrIodh+62jIk9hatQErNgF+alTOEYyiSMnIL/zRt5G8lQwk95UNLoK1TZ
         nBDHBg33R+uhBdgpYEuEd7NC6eXY/cqqcOqnuDzzCkFhZqtN1+DT84eS0Fav4fuYjj8s
         xjQStvG1irVTIaHqt+Ag7QpqM2xFlb1OxQzdLDmRklnfY8HHR9jyIc/07/phS8Xu+lca
         ZZYoaKIBz3yyzd/WRoaAV5jCoY8x1+lIA8aGOcCZdpQbppO5V9rheqOAlKISnKqS4jc6
         g5KspnIuDr6vWJhi9VnM05Quv2puqHxTn9ToNuqlj/RykudvVlAYuGY6+rl+1fRRtbqc
         FEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPCdMkb6EUNE2h51SHQzr1Msw5lFogDYOj1NBs61+SiJhvCIsDP2fHr1+/4OGlsZU5R0zQ0lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhhNf8XbkXO/GU8zckf3NdTNmFzLclGduOtnV6SNO3++o+mL1r
	bPqy1aKPfmg3AvUqRfuzD+Q1locBdYLqD3KDY6fqJKbOZIWQl+v/V0knpWV1ljVuqHaxfCW7XFI
	V+i+6
X-Gm-Gg: ASbGnctDb4gm4eue3rk5XeHAalsZTpTGoLNpiW9GY5162BqzpAyYou9l9qlHDAGo1Cv
	GuOiODWaN84u21yJY275clxj7Mvr3aOvlpfwMBwmm5WQ7LE+takeBpOa3DyyKiG1EqPfDwg/vvV
	mOvv8wTasI086id2mry0tqNhPfkO8WoVQ7lGwsNfpGZPP8XREEJYeODor1ShE+jG0mFzSydnanA
	GkoIDmRyjdRXZJjjqjRmJHclP9TJQXGudBZQ8+8oLQ8b/0cKvs/wW0xWbQ1L4FBAkYzEcY7S8gX
	ikXY6ppqdwy7QASuWGZyv/dwkzGbUlfyzkfx0F5jHogdxysSHr0GWeZCpkq8yXC6/B66froJt7w
	LAvvwqNqOZkWLFUKKx/VipJENXSM4OR8mbo7METL4QYK75zMa9cEQJyIl4Uci0+eUMLAWQH88C8
	EHxAKuVOus+p65ALZr8e96OFZYcIOJBe2HOeVS6/qlwT+wnMFA
X-Google-Smtp-Source: AGHT+IFNMqon6T6uuaSPtPWzeC6hvMBM21Bgd3h3q8kWyLROPmC5WUKidH8PCwxmeMXxs3ib6zKAZA==
X-Received: by 2002:a05:6402:f11:b0:63c:25fb:19ea with SMTP id 4fb4d7f45d1cf-63c25fb1c51mr6038774a12.18.1760877939999;
        Sun, 19 Oct 2025 05:45:39 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4949bfd3sm4102549a12.41.2025.10.19.05.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:25 +0200
Subject: [PATCH bpf-next v2 01/15] net: Preserve metadata on
 pskb_expand_head
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-1-f9a58f3eb6d6@cloudflare.com>
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

pskb_expand_head() copies headroom, including skb metadata, into the newly
allocated head, but then clears the metadata. As a result, metadata is lost
when BPF helpers trigger an skb head reallocation.

Let the skb metadata remain in the newly created copy of head.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/skbuff.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6be01454f262..6e45a40e5966 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2289,8 +2289,6 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	skb->nohdr    = 0;
 	atomic_set(&skb_shinfo(skb)->dataref, 1);
 
-	skb_metadata_clear(skb);
-
 	/* It is not generally safe to change skb->truesize.
 	 * For the moment, we really care of rx path, or
 	 * when skb is orphaned (not attached to a socket).

-- 
2.43.0


