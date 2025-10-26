Return-Path: <netdev+bounces-232974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A9AC0A95D
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 15:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0544D18A0469
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 14:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86472E8B83;
	Sun, 26 Oct 2025 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LYTHa7El"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C1F2E2EF9
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488328; cv=none; b=NwNiAr1EqNwb0/cjJzK2WEtq6/6GbdVt6o2LBarCL4x1IAWeM8ur/VR1MMyAdV4hXLFHRAHCS5f3y7d6vD25EWax7vUrwQbSY0zbbC2ASSPVzL0ORBPHbGROsJUO/85+1S/7Ic7tcTxGhV7rddy/t8XGTftKXAapXUzN6TLlPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488328; c=relaxed/simple;
	bh=xleLnqeTmax3LL9D8FWb7af2lc6VsV84ywgJTWC3NVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lScMYqlwbuHh/9Rf7QAuxM0b2+9fUs/2lOC6bQJsaI8WO/3/iq/mxZ3XLle6zpdX/rzfsw1ju9NJ3377iDqacs6la5JPtWSWHMtsB/9s9qq2gLCgMuIdBzudJP/OqWCE9ZR26Y4bMTtOSm090qeUvoicMwbitZIMNlwmaQ6uL7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LYTHa7El; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso6022611a12.3
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488325; x=1762093125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isGYaQWo1V/ui7jH0r+jvXI+ZaW6MhGNSYr2vGlL7Vw=;
        b=LYTHa7ElXVOWVQHy9F+4tNWQfuuVUdG2eQG1mdwZUy6aItfTUakDm42UvYZMHGRHAH
         IoRiefXsJAGiY0cDLgVkXSa8qX4rrfkVJOpZkWOWgMkn35RpzsLYuF16dLe0JWVbOxT4
         IR521eAmRdklxxg1Daq3hNzlITdaDR0R2r+wnW/gTZuWf0xJvCHiHyy0MTvAxtGHQi4b
         n5U+dmGI5yT21fkj633tpYeBGt67idV9E+ZZvroijEiPVlg/rTCwR0a6Toiw/aTeO6+F
         bRFv2Hsq2IxGNTpXZCIOsdihGA0IOevG9jWVEmUYPNym1FZS62vdu7ohbOMTfbPAUQvq
         c6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488325; x=1762093125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isGYaQWo1V/ui7jH0r+jvXI+ZaW6MhGNSYr2vGlL7Vw=;
        b=Lk+20kzf8kca5mu8shGjmqqHXpBtLp/Z9DwL4pRdgrNVwZ4gbyQphVQVGXo2/NvKRq
         VZFSCTCufkeodvTQz4qSkDfdHOQ8/xcHEpiBLb9leuTizFc6I8q4eoBw7h0gY7010iiT
         lVy4J8AxQnXw9B/z3BSiDfeETsg8JBMY3jdC3E/Ky//9eMhbV+c4HLLO8KGnZmB2JIgS
         m7Pk5/gKNN2IE/4WtzSRAAk0aYfsQ8FvpmKtBxTHSq6yy63R08WO0awZwZXMxIzSHYaw
         C0dPW0YEVx5dI6ku1TRtf4OXiIuBn3+EzaBjYnqf30Rhxc7zcaIzo3toqvOeJqZx+tAf
         c7Ew==
X-Forwarded-Encrypted: i=1; AJvYcCW5vFTkap1EWVH6Da42IZENjNhJq6LvqiOr97Rwxgr3COxfSPQDN7AgR5L6ktxVHZGQNAAVq18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWjhaVgoQOYs6NHozj+B/CmRQoxj5RM162afAoQX28K/cNnMvk
	vBMa4KPrktmLbZl3h9duiMU3dtZ7nm8i5QCdHb+rSEOQckThjLIvKAxQzqOc6WrhywE=
X-Gm-Gg: ASbGncvfR0U16fzZzsG95SZNydSAvoSi2YPW7xeJwEildx05me0Tl0ZWHss2P5e3t2V
	/8vbxOe2iosBHUZSMLbNQxIOqjWSGR4PM7oyWYPsUy1rM3CCbDGPCZoJlGeHrB5L4if4oLEzT12
	AvFTBSiQ/eJygYq/c6m6ihXtotp3qRZlD4MSWoifg6FvTpylIoaQV+pqLSK5FTwqyJUtQQX4FcO
	bjAILGva92+dCx2eLwV1a5KgkEMfU1WR4qdkxIc0mjg/1hwu/pdSWDpGt8zNTLK6hhq/QaPAj2l
	67eMMh2nRIGDbgaKiu1FitPR4YCFBxSc/Ox+Oi4+3IdlmvsgXZcZTTokBtgTZpxFUKtDrA62cxR
	hp7Sez7igbmrPFbwbaxB/KkVRYsPMUSluJux/634MPFxkOxKhLR7AGdSoKtet74a4LO3hL0eStn
	UVSavwJU1mxGv6KnOuBJ+CzhtIc2LM4cZ3ZW1oleHLJ7HR/g==
X-Google-Smtp-Source: AGHT+IFQRTyElOtU4RyzWvGnSDXeWSJDk/6TYhzt7r/pJ/mjLfZhfdy+LnatdvgFi/Jk/qUbnvatnw==
X-Received: by 2002:a05:6402:524c:b0:639:1ee3:4e83 with SMTP id 4fb4d7f45d1cf-63c1f64f094mr33757924a12.8.1761488324821;
        Sun, 26 Oct 2025 07:18:44 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef8288asm4021766a12.10.2025.10.26.07.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:44 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:26 +0100
Subject: [PATCH bpf-next v3 06/16] bpf: Make bpf_skb_vlan_push helper
 metadata-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-6-37cceebb95d3@cloudflare.com>
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

Use the metadata-aware helper to move packet bytes after skb_push(),
ensuring metadata remains valid after calling the BPF helper.

Also, take care to reserve sufficient headroom for metadata to fit.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/if_vlan.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 4ecc2509b0d4..f7f34eb15e06 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -355,16 +355,17 @@ static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
 					  __be16 vlan_proto, u16 vlan_tci,
 					  unsigned int mac_len)
 {
+	const u8 meta_len = mac_len > ETH_TLEN ? skb_metadata_len(skb) : 0;
 	struct vlan_ethhdr *veth;
 
-	if (skb_cow_head(skb, VLAN_HLEN) < 0)
+	if (skb_cow_head(skb, meta_len + VLAN_HLEN) < 0)
 		return -ENOMEM;
 
 	skb_push(skb, VLAN_HLEN);
 
 	/* Move the mac header sans proto to the beginning of the new header. */
 	if (likely(mac_len > ETH_TLEN))
-		memmove(skb->data, skb->data + VLAN_HLEN, mac_len - ETH_TLEN);
+		skb_postpush_data_move(skb, VLAN_HLEN, mac_len - ETH_TLEN);
 	if (skb_mac_header_was_set(skb))
 		skb->mac_header -= VLAN_HLEN;
 

-- 
2.43.0


