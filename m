Return-Path: <netdev+bounces-230724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AA3BEE551
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 14:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AD104EB41F
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 12:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FB62EA156;
	Sun, 19 Oct 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Y38kWrOn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448D52E9ECE
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877957; cv=none; b=KAWb1ybg/4LQ1GWs/8HEmpFiKly6/1z1hHi5jb4HB/DwM43UAACGBqn7Sz8JSAheWWI1g0lnB4SMmqKOG0R5yZLe5OuVe5eRbR2cp6KEM6fGNhzfYjHHQUCIOA+mXzO6q0GonH3qUmoVQyI5VBUAGNwMlUeNEF4rfdqju9t/2tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877957; c=relaxed/simple;
	bh=UHcbyxEtsQIQOQPkDZD3sw+qx3C40IcIAUyBFPC/W0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UMhg7nuhzCTq99QeiPgop55IgLAwicefcpiyhdeh9QxGxQsiBqLU2EWW2fk9bAdV2A8fLpeLDJnAZNzqtJlMGX5XGA5XhbMMWWwGYVCq5oth/33l2x4Oc4OtXAgqlKic7rpYO4/Rn2h6cDnamPaS3HcbjwYTBQFcxUSQrJd+/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Y38kWrOn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b40f11a1027so665535966b.2
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 05:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877954; x=1761482754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dt7AuteTVa42+A8b61PSRaLCuKGLTn4vxWnXwMfk5fc=;
        b=Y38kWrOnS11nxniRrY3t/OtiDys+GWAcrOWGARlhrNzEWefebi1ldr23GtWZkQXGlz
         F+m+vZ8+5J/d8ZQju+YtuDuGxzV7j5ApVE8CvL19GKoE5s8GvnWCpiiChBAbLpWoSpcp
         THTRyPINg6JxMbAdDqt9itGGPVZO9eDi/iUqxjSfD7E+ylN3nCZ8x1/eMthO7hjRQY15
         e1VcHhGv5C5yX7Mkhbdi1syjo7xRiU/RJ5dFLzT9jStRhrbcp/YrPpg94/gh6ckCwb2C
         FGy76gFZJEhhXMDQPVtxVnwqln3qE0px6oWne4gT4v2+D5jRXE7MhBkZQ4Mm5OZ1LMOn
         tBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877954; x=1761482754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dt7AuteTVa42+A8b61PSRaLCuKGLTn4vxWnXwMfk5fc=;
        b=v0FEj3NHuFPITo0vpzJCshVoMs2JE6OBPOya4VMMH14Cag7EBOOQnJLHj3Sb79ZnX9
         LQdVNUMGTang6kWEnnpyWjzcU+pLwYzt+YhHxbnZdjvETiPLGPedhUwKSQdJkx0N65ma
         a/XiBM4hKqIffvkatTHZiAT4GTlBm8T3azBg1gqD/Myjgl2Dz8Xl/F9VMgUNBz3U6kxV
         JJZl+eWTylgyioesoad3CkRjI3Bnj4VOqfrb5tx05iYQGNb/zCbhcrTf13JJOr73bjfj
         /wZT8RpYPmMrD0CTKCswD7SkkLfdaJchAxZtevzRF/rrctfHOgZ6+ZiMN8IPRP54Tf5+
         y+4w==
X-Forwarded-Encrypted: i=1; AJvYcCUhCbDiWk7poXXRWivL4zssmvJ2ZGz8CNwmX7a9RifKgYgo5ainUah/Ma+bHqteZMCJP7nukIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ftsLd5OXkQGjgZ414Vy9f2o1xxH9U3EjG987C9E5qs9y3sx0
	BYmZ8BbIe3sa4vHZCv6iupoAP+Fw7Y9jTCyiLqyMfi6bQ4TeFyZhWGPo6Zg1eAISQnvgPOgoG5e
	KmJsk
X-Gm-Gg: ASbGncvkZSOTO63DzY6rTYqTcROykH3cZLrkGwW69C6WWzrEjp2LbJSwJi+EfuzppGI
	DtoTVBVmo8s7svNuInZ/WoS71AO79mDZEDsKNRc3dxy9mpMpIObMpVN1NojXcbRuWje+sbJT2Q7
	YeJjpecuicoXmftXm308zC391iug+rV53NiQ39qIpK9jG6qypLkSlMDeFr1Vch39DRfj/hsPL6C
	zJPt3/Wd077pjtJ3tjt8bDjW6fHZYkuhs3xJDaplOLp+ZDBaDOt3vfqJQXfn+xnyJCmZA1kIo0z
	1+ow4H2sTLL6ORUdQFjwR4A+J9K7IpX1o8dvGEXbpCwQpkkQ22EjiyMmZDkWOcBndvTwBrpDCOS
	cvihl25qpNCrKhUsJLH0EoxA0nL/sgq49RmlQH1f5tJ78QIkzTtkKg94YA3VRf2J1eb40kXe6ad
	nQIPuPqqZ4/tV/GWcLtyLUy5Zl8mROKwUxmWZVLz+adDCroGHR
X-Google-Smtp-Source: AGHT+IEyImHX6d99mwNK4GhLUVX4Wch1W/SxZcrcIr0bKWWkAjUctI9d/1EAKYqB6wL6C/dhcu/Dmw==
X-Received: by 2002:a17:907:7f22:b0:b49:96e4:1846 with SMTP id a640c23a62f3a-b6473245c5dmr1248212466b.20.1760877954202;
        Sun, 19 Oct 2025 05:45:54 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8581780sm488729566b.31.2025.10.19.05.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:53 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:32 +0200
Subject: [PATCH bpf-next v2 08/15] bpf: Make bpf_skb_change_head helper
 metadata-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-8-f9a58f3eb6d6@cloudflare.com>
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

Although bpf_skb_change_head() doesn't move packet data after skb_push(),
skb metadata still needs to be relocated. Use the dedicated helper to
handle it.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 52e496a4ff27..5ad2af9441a3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3875,6 +3875,7 @@ static const struct bpf_func_proto sk_skb_change_tail_proto = {
 static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 					u64 flags)
 {
+	const u8 meta_len = skb_metadata_len(skb);
 	u32 max_len = BPF_SKB_MAX_LEN;
 	u32 new_len = skb->len + head_room;
 	int ret;
@@ -3883,7 +3884,7 @@ static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 		     new_len < skb->len))
 		return -EINVAL;
 
-	ret = skb_cow(skb, head_room);
+	ret = skb_cow(skb, meta_len + head_room);
 	if (likely(!ret)) {
 		/* Idea for this helper is that we currently only
 		 * allow to expand on mac header. This means that
@@ -3895,6 +3896,7 @@ static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 		 * for redirection into L2 device.
 		 */
 		__skb_push(skb, head_room);
+		skb_postpush_data_move(skb, head_room, 0);
 		memset(skb->data, 0, head_room);
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);

-- 
2.43.0


