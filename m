Return-Path: <netdev+bounces-232973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3F2C0A969
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 15:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503E33B2035
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 14:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DDA2DF718;
	Sun, 26 Oct 2025 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LZAW6Yum"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA952D7DCD
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488326; cv=none; b=Qe1aiQvox7ovbD8IMGupWa8dtkf9JWsZPK7pNrnfgJ3c/iY7HNgAfDIMpSle+d3Cym/Qd0FHV6kotIhPnU0VbcY41dC2h3mxNKwgBvggMxjpe9EyTiZa08gXZdDE1pnRq6+d68fi+RaS8vRH+20Nd+1simTkuGpYOhPwRW9RzgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488326; c=relaxed/simple;
	bh=1I+ZsuBg0UdnoIKEEzTbkQeFlzkeHVAGD2Ztup8Ifyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0CRHcYWiSKM845eHdnaC90JtKG5dxxOUdAOoVjqSB2ndVvsg2PBMS64zxsZzwWvdd67PzlWPtBLkAv1R2cluKSD/Yq8VQGndjOIfUuft9j5ZLh/qT6l8USYRK+hRM+On3azVLWm0+EMrPTJwbGfUk4C2ZzRuacGtYrDPjaW16E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LZAW6Yum; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b6d78062424so612330566b.1
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488323; x=1762093123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sB4CC5zvn+S4YI0MbjpF4L6Qba6coIxIhHj/jqUzm+s=;
        b=LZAW6YumlqSB9wpH+qxBEGKPw/1xdPeV18jZvb1hpzhAE1igRwfVuavYi4z9cYvRoP
         cTH68YOxUxYoWop2WIXSJJeoq903tJBt1N3nWPQL7AOFl2HwUmQBVW9sKH6WLF8xHdxI
         fwjEyVn5c5k1PDtXGOcMfYDkLeyBXtwcNUU4+Z2fghyVSdvytMK9hAzVJGzpIFtbJbBh
         1BcNvdw2JNZW64cwTvyVQNIz3HUXB+/vhNtafQaBTMnxeRcAGjuIKKpryH9hhC4qsu8x
         19V55a++l6B//bufB/tUnUmbIl78ePhg9VB60/+rtCqrCihYGUdmvESVp9Oz9t06D0Bl
         7d0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488323; x=1762093123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sB4CC5zvn+S4YI0MbjpF4L6Qba6coIxIhHj/jqUzm+s=;
        b=KpAY/909Amm4Tlyf6hS33IdibFFoggSGsI6M7ph5/Z5SW6AWRdYqgQdX8yure3d2ZK
         Fp24T8IA0idc8jOnGsezAGmcJe6KHpO8YSsGqiI9LJb0g2DyFPVsys9cghb4cZVkf9Od
         6MRY5ExiaYwuC79956EWvCp4eUn47Tu5/hEq5k+UH+vJ3SZfM/qNBkonSV7h6JPuSz6u
         n0ZMxDGLhm8uaQXUCc8mmFkIW7EiFnjss6f/5LK0tU5E+88MRZYCI7kWaOm2X1WdbH3/
         VNCbNQoaymmvHQVu/BzT7qOxuIhjyAPOmIwPacnTIUqT1/jXRK1kx4O09ZmtEZQyU9Ag
         KdMw==
X-Forwarded-Encrypted: i=1; AJvYcCXT9MtOsiPOWdUlwUS1Zhvv+k1Ffljx3Erp4jPLCKioYlHausVIQK+sFrZkuWIAA/A24tTXmwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+3n6nd0h1aEP2J95QrsITkQiYM2fJMoRpu86WBkavc32PnIG9
	hG9Y4fAR3VqYhMj3uxVJCCQ7N144lUSnUUUVbEJ2C2+La51bfAG2YWT0KSsgxe+5jRw=
X-Gm-Gg: ASbGnctYLLtGX0XofZBnYciPhX6ljuJUgvl8nplxOLp9C1bMqyL78bH81DmFwMmIkZ3
	Gv4bJl43wkVwZ1553KRq5L5Td+GfQEg4gABbdWMdeg9l1MzGgWc1B5oHOqYjK3dsIJfjJvMcX4a
	5rZ9dW2wDtHdXt9uP43x9oLxHYEr2vNw0ZHWw1Puv9johe4N/gZEpMxJzcLJ3jAm4YQsg0i6L/e
	uqxuitwV2PU9N87DGzRfUyb7mbCA6btvTeTiVSbuuLG8A7cDDWhPYsQJLtxv7VG78J5+WSPXBEO
	yAWXYa6z474P40j+9JXceSaKzG57AK6WDS4+hb9e0MFXdQlVdRika0yCB47yfvvxMrQY8eZevBO
	FaVWkp+hkQIA9DnUtUfCmUWs3JaTYKRiUkR/wMb+5pIrVnMT6bxZJKRlv2y2WPJnQAupTyiffN/
	D1nUI/YL2AYquZChstjIwIYBCTE8V4jhcGVb/CFvwwWrA1pbZQPf4jG6xj
X-Google-Smtp-Source: AGHT+IFHjCvGznHoXbRKlNIuABB8ua+WfnBq/S0K3UgEEOiI5fXfYf25nOEruhcpenxxpmu6ueKwlA==
X-Received: by 2002:a17:907:3f8e:b0:b6d:7d46:52b2 with SMTP id a640c23a62f3a-b6d7d465bd3mr681142066b.15.1761488322925;
        Sun, 26 Oct 2025 07:18:42 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85413b88sm466099666b.55.2025.10.26.07.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:42 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:25 +0100
Subject: [PATCH bpf-next v3 05/16] bpf: Make bpf_skb_vlan_pop helper
 metadata-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-5-37cceebb95d3@cloudflare.com>
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

Use the metadata-aware helper to move packet bytes after skb_pull(),
ensuring metadata remains valid after calling the BPF helper.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/if_vlan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index afa5cc61a0fa..4ecc2509b0d4 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -738,9 +738,9 @@ static inline void vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 
 	*vlan_tci = ntohs(vhdr->h_vlan_TCI);
 
-	memmove(skb->data + VLAN_HLEN, skb->data, 2 * ETH_ALEN);
 	vlan_set_encap_proto(skb, vhdr);
 	__skb_pull(skb, VLAN_HLEN);
+	skb_postpull_data_move(skb, VLAN_HLEN, 2 * ETH_ALEN);
 }
 
 /**

-- 
2.43.0


