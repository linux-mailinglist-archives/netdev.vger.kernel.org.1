Return-Path: <netdev+bounces-230723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF333BEE56F
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 14:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C582C3AE601
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC702E9ECB;
	Sun, 19 Oct 2025 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Z5uyaqzZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED702E9EB1
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877956; cv=none; b=trdRXhLu/XZICsFSvl3MZ0jpilRjGDFeG/KSQHPV0kqfSa1tXqlyMjB9LYuDDb1ECTsp+n0XYtibfw4RHTpLLvt/yycIzT/o/fV2V5frh3+bLZ6w+gxZH02Vy53aQyCPQuNfsGgQ/UJcrsME/dV72K8VRl+MUuxsItriVcY1wbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877956; c=relaxed/simple;
	bh=Dpo1MHnhWXyr+fuQYgrkB5o0Ycz8VFedY0IVeyWKR9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Az0dyCR1RMxb/sGodjqxpDGwP7vuSuGou8otll7S9w8OpoYXJ4uj35PQdh169qe9yQA8yjvEhC197xIVMjYmt/JF+I0zQMHFP4B/K5SVv8I49QD27PUMWFkdwfauehKIWmYGS03B5mV7Y3XF8inMqy3+bWtuMzg+dZ422NRT1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Z5uyaqzZ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3d80891c6cso844850766b.1
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877952; x=1761482752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lePNzez0IJKAF9x8/QAXM92ZwfXE4CTTFNo/I1ractM=;
        b=Z5uyaqzZWjYrmCxmdDWwsTscGh9C5jI8d9ADavX59J7F7tH6Lyx10B/L6i6nPasNck
         LvmFcMEiJE1zkO4GvHTxId1NjppICDSgBuzIUGvPpt6IGAwd2LCnnZ3xVXjKoNjZ8pA1
         oBgVcLR2MYhAa4mFNgmWiVSMeGBKtGRruSl5b8QzcEjxDohtdmiHwpR17Xf4l/n7o0jL
         +tDxycaIrbeEwNEwLzKsxsXVVubqbDGX62e5mNU+PhxGW5yxRjqb7dewPRchXqI/31P9
         kWx5Q1Cnf4putRmLJraxeys+kX74uV5Z2bK6Bq+JodL+FX82Axo8u2rSXVwAYove9ZGc
         Vaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877952; x=1761482752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lePNzez0IJKAF9x8/QAXM92ZwfXE4CTTFNo/I1ractM=;
        b=kpnsNq/lpqr4XLH7tf2xgbWoXyHr5OllG/wBPerpmA21JJ1XL22+UBDpZW8nlactvP
         RCyLpgMC1TynhAdem35RLMiu8+bccvPg6Q7z1+Ql3DuTKXLGLTZc/+sQZFnTwf5jdiA4
         mA8k0+u5Z1+XndUuWfeNUN1tiZrCWROPNppKRNNGg4aHwFIZdE5615L4bsQ9+JuiG5SJ
         W+TsNE1CmBpMjz549DG3eWEdGMIrqPXWY6zkOdoNqXKCMi4zex7Dzm8pCAJ7CAPUi/Yv
         GEh7hdKQ7aKqZmi6bDYKjc2ZeNI6ZwrWfNjPogaysJ7fsEB9kMptUH6LjpOxZFUCl410
         JGaw==
X-Forwarded-Encrypted: i=1; AJvYcCXIYWWzUyzXcc6lq3caHlkJ3sesLulyTlQLrEryl8E/tmuUgHZhTjGQMktjlhbnc1kXBrcxOew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8yU5WCrhv6/3WwG5N+z90kBrdvul56hwgiJoLoar82M1IlHa
	qUaDBoPuvHpgtXWZ83g3IUYsHU5qfeziuQOyYs9TDUA1YXzLI2iuD0g+aEEVdmK+zkMmUPlDywP
	3wRut
X-Gm-Gg: ASbGncs9szGwzhJ6BSzJQs8j/Q/Lx++RkkAWxMvWq/hqxuGQoy5QVZTAL0CZSKaP6s7
	w6hJoRMvMmcxflQB6BHQOo1fUU3Epd+xAb4Rf+l4TyYYMROhjNWCp/2igp7nYhNvNsqZXOY3bLP
	GYVqnYYcydIXl6mjtTV6qLFKfNSgjatgATE0eP/12PrE2l8B3oJvFdJzvsYJVQ2pcOZys2Z0jFu
	JTA5Ailn/lK14bBswBq8HVyoESByXr2QnYhPfsiYipEsPU57l4G94GYF7EF5NQLqeX/fq0ucYNl
	FZLQFeWULz1ljpMHBcL2KK73hfP/RPeEK//hzV28BJ5KEIQynUMOIH8V8lBmHtufJxvDTC2z65h
	nhpJfsAKMrq0TV+d+pyQz6mvB8Qm97kD/ngKmndPXO7qXQjw4rTMozJNq+xgUGgOzXKdk1Lkj4Z
	eIAOtIPb6X3HvmeYrFXq4UoBOZN8SK8oml0Y91QcLJxqpnvYb+9PCrfF/gJdQOSFgPss/TrA==
X-Google-Smtp-Source: AGHT+IE5QxJtuh/2HWQE8IlaiHQmI1YRxJ2D2O/f+fM8sFxzwfMZzu+YE7Ei/qXC7jt98nZh29ccsA==
X-Received: by 2002:a17:907:c304:b0:b57:d5de:444a with SMTP id a640c23a62f3a-b6054400322mr1722241066b.15.1760877952425;
        Sun, 19 Oct 2025 05:45:52 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da35c3sm495619366b.4.2025.10.19.05.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:51 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:31 +0200
Subject: [PATCH bpf-next v2 07/15] bpf: Make bpf_skb_change_proto helper
 metadata-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-7-f9a58f3eb6d6@cloudflare.com>
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

bpf_skb_change_proto reuses the same headroom operations as
bpf_skb_adjust_room, already updated to handle metadata safely.

The remaining step is to ensure that there is sufficient headroom to
accommodate metadata on skb_push().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 5e1a52694423..52e496a4ff27 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3326,10 +3326,11 @@ static int bpf_skb_net_hdr_pop(struct sk_buff *skb, u32 off, u32 len)
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


