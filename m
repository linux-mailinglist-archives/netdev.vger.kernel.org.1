Return-Path: <netdev+bounces-235980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A706C37AF7
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 21:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8366118C2EC7
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 20:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB3D34B1A3;
	Wed,  5 Nov 2025 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TmQ2OmUU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7763469EE
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373998; cv=none; b=fvlM0mkqHxqXQxVyx7Pbr1bMFPITX7mKZ7ZtV2szcL207Uqg2Zv5slbxZdQgvPP2+8X3NzGMIySRuVMBGGo97WyYO0y6I553T5Txkq64dp4TSkKn9WiFV+9uwfd3ecwlSHU2OztmrHm66OXyewFlL8FZt1fJV10xnGWs83bWhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373998; c=relaxed/simple;
	bh=jphV3hLYyJpq5wHhzxxIdaldllEhemXAkq3l8pQxo6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=quHxuPGHOhQC9CMlFTJRPE64ED5sD1vFwZGTcdNB4QA2+taf2kO6ndcHLJD+/NBPEblYaH4OB4fgS81t1yg+yAxR2xheREaNak3mYbkeeIaq0ETtzZQgjVarK93QK7rlj1A/1J5joLdLxoljjoH2e2NvNo1KRT9uYoG3kx4IslM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TmQ2OmUU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b725ead5800so32176866b.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 12:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762373996; x=1762978796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phiaj2apVtnJOs8yCgS1f4Ia15HnRGM+EMU3gmWsJiA=;
        b=TmQ2OmUUQcbgAtLleqsWKrPvpJARe2KvDz7PKAOiSngv378eiPZpBf3oYGZ54HR4vP
         xxpi6ef5qM77bafrJma0I9hk3itg9Bbx3cVpWF7GwFb1iuxgNrYM10zTydJVRuBgtTzF
         wXB6s4I9jk+qookJr03mBFSGFwOig/5P1aR9c22fvjpoMCKd1a9l8BR8v0gQ+Dd17/Hq
         O3LO/BZ1omMROKsUVyMJSWUNJAxarVa51UZ1tL771QHAC4o2i1BxoZ+RSjAVgvCEihD1
         JgAB3Zws7LvqYWM3AhWEVaPL5K0h9cw+gotmgrsLiiDTepCYRPVcjeMDsJPR3NJjqeuZ
         JA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373996; x=1762978796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phiaj2apVtnJOs8yCgS1f4Ia15HnRGM+EMU3gmWsJiA=;
        b=Rq4LZ8CnDQnEF/bYf7DPXD6eN0lJ+Qb18oEpQbbFKFqO8cGW9a8q8F6UrRvQWc9SMU
         e+LvMJ5YnDTTG7XKBZCGQtmF5ablJEWzXXEZzyhW6dtle0fHeN1lBQ5AWyjxi6Cezi32
         Td46wZf9r4bWmR4oY908PZBQseqoxVjy6dKyvD8gwrAYTOO0Ro/wB6E6ayaezAnyqPyy
         CgPUcd9iMZ+63h6sTURPkkGoySL0tCytaaKX5K7RajNk++5IZJwoVHMCD39VYJ94VgQH
         VrAjaUYWGtVEq6jyCYnDeyJGdF8r18yKsqRjj7HTCQZQPOaMWqGCyXRuNvvDHNSg6zJH
         EWaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm/CjY9fYUQ+g9tZhDHMD3F9tyLBsRZYsXQTba4SdUBL8KY6o9MyCkcaNFPLHVwA0kxp1LJS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/ujPN56vMEv9sO9xLz23U+PYJ7ApWqF3LMYw6PXuqtZPX/Wv
	7nY4/+7VZb9x3TN8wG5zvG9BivnH/mHhwszqqPLjQc2VWFbL2bPqfeiROLKiwOv2B08=
X-Gm-Gg: ASbGncsOeMKqiYf377Gai+I2XhnppqofRmVHRrWO92VkgruwYm8AyAgEX7w+qwFJYFA
	8oHLrA22rnFImp3n1iu1jPqmcc/kNr2Q+N184ZvvLeQxYAWIXswVsF7sw3lCOoyauHzjNAEhmDb
	W3/z5OwQrReOx0+X749zHp/ae3Wa/QIyMLKMHlghrzE+W1ZHn2DxeSF/VWm44UnyhXnAhg5diV0
	wOHWz/cPMBhM/6LAoKB4muZrJjxxr9Akfk4m71/2blwRHK4W06DeJoHcksWbIWONDpDWAobOia4
	KRigJuMa5m2/Ih1MJlOGCVoTFqfdSawGtF7SD71SIh6lD0aEnDqDXLnxIXHZCKAV1GLDCi8m542
	WPpDVqnV6YA7QsiixPyovty9wGrIpTotMq9k7U1VZgK7fsGJizjU+Ku/xE3Qi1sgjuelZSXSwiv
	5DnfVIA9fwih4JsQb4dn5zOoWeLoiPaaExumG566RuLtqDkQ==
X-Google-Smtp-Source: AGHT+IFm9pf1vsVOIIHhPivCTPoKVlXmRUuAQTrkB71LUzQ59fpA8pCc7dnsNTcgjtp5Xl/+1npLuA==
X-Received: by 2002:a17:907:7e9b:b0:b6d:2c75:3c57 with SMTP id a640c23a62f3a-b72654f55afmr421981466b.39.1762373995677;
        Wed, 05 Nov 2025 12:19:55 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713a7esm57006a12.7.2025.11.05.12.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:19:55 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:41 +0100
Subject: [PATCH bpf-next v4 04/16] vlan: Make vlan_remove_tag return
 nothing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-4-5ceb08a9b37b@cloudflare.com>
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

All callers ignore the return value.

Prepare to reorder memmove() after skb_pull() which is a common pattern.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/if_vlan.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 15e01935d3fa..afa5cc61a0fa 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -731,10 +731,8 @@ static inline void vlan_set_encap_proto(struct sk_buff *skb,
  *
  * Expects the skb to contain a VLAN tag in the payload, and to have skb->data
  * pointing at the MAC header.
- *
- * Returns: a new pointer to skb->data, or NULL on failure to pull.
  */
-static inline void *vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
+static inline void vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 {
 	struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data + ETH_HLEN);
 
@@ -742,7 +740,7 @@ static inline void *vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 
 	memmove(skb->data + VLAN_HLEN, skb->data, 2 * ETH_ALEN);
 	vlan_set_encap_proto(skb, vhdr);
-	return __skb_pull(skb, VLAN_HLEN);
+	__skb_pull(skb, VLAN_HLEN);
 }
 
 /**

-- 
2.43.0


