Return-Path: <netdev+bounces-230721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CA8BEE540
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 14:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3B6189E121
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 12:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3442E8B8A;
	Sun, 19 Oct 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="adPtU8rK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCFE2E972E
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877952; cv=none; b=RAaP0Rj7NQk5sDc67QxM+6Q8hvX0Kph4SQGB7FWCXrzea2PVDSZyGgUOH8S+YYzbQfuGGUJYgzie7dlnW8LORdg+bu7NC0DATlc3B3WltDjPhFR2O+/6rjhLGocjFvht/ca5MqEWenPHbaPN7zqYursDnAJcxkfq9E1CuegtX74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877952; c=relaxed/simple;
	bh=xleLnqeTmax3LL9D8FWb7af2lc6VsV84ywgJTWC3NVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZ+pb3WzISviPEwYjBNC9I/aRvRctKEJf1qDSEIBAybKcswhuYFVHZXWAnEjFiNglnNPKW/z0L8TCXCvcU/tjW2ZZflpIZwtn/eQsuaDrPgzK7VBhQFi/XzN/Hdhj9QmQGr17Sn6Euk3sxSwXh/EvC0xORWgQ3byVwTO4UFEfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=adPtU8rK; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so5682439a12.1
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877949; x=1761482749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isGYaQWo1V/ui7jH0r+jvXI+ZaW6MhGNSYr2vGlL7Vw=;
        b=adPtU8rKN/NuKMrS3UXb0UDajnJeT3WggmwkNsOk4Ojt0hp3pYWCQbDtRbf8r0ey8o
         KFjQ9LWLu81GohlWE3/9PHOx/BNVYol9SvuDqVSEoZvDfeIjiX9NtZVQcTWGCWr5fAHh
         e3qNFoRflv0BBWMvnAdMLJOad8x6RZDTA5yvE24TWpv6hfYiEL6NpgY8I5ly1gloidlK
         pCXKTvDgnRfGx5GvqqtI4ODDevtNP1X52t28wIAfp2IJLkOovPLjKC+i7DwfpnMunWHu
         leIQqSxoWrDLKA+dRhQuIS8kKv629IPzKvHGFN8ui7/Nj2UBWOjdclx+Jx/U08AZgMl3
         6knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877949; x=1761482749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isGYaQWo1V/ui7jH0r+jvXI+ZaW6MhGNSYr2vGlL7Vw=;
        b=uzTp+AiKd9/kbANIrAK5VLmH02/L/V/NDBWsbqs+z7RE+2v5dSmvdw/tLe/xCizSku
         rfUKhCmYWt8RGGpj4qoS9rXuD2ysFECMj2DS7kMB9h2C/NawEEK54ceEjgEkew8Y9qBy
         YFhV8E34Yt3rZSf4IgPk1zPynIwinQXd3D/bnofkKljxtvkN5G3/eOD2cC2NL4w+foru
         +xYugWUcHxiAd40t+zkXLdSTwqU2jRXWQr608NhfCbVTvMoFdaZgmdtWy9x1oYnoMU/G
         opZZhWnF+ookOiIS62rj5RPwpR7m1mrfM9QO+TvJwVP6VBAwGpc0Ey6BtzoaGq7n20Ky
         XiSA==
X-Forwarded-Encrypted: i=1; AJvYcCXnChqYizKS/W4zZ3hcdA2jeq4AebMXR/RyBEGPRiFqPkXUlMLa8vXiLu7dG96acJiRxRSWFhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrkn67rfCXUVWx57DRWQMSN9cz6EHJWzsYkNhG10N3k3LMMChI
	TjkP4w1vYuQnI60c/bac3gKPVnw11opXE4hVMMvxDaUFTiGCZ8hO+FWiOg9to9vh/Fpqj45/5xT
	8TQdn
X-Gm-Gg: ASbGnct9RoBF7CGWq073mtb2uH/pTerWvqu85j1LOX8Oe7/4wo9zHxQ7xJ2/a8izFCz
	D5zU7smIIuaM2KFH1Mhej9n6j0xAER5HJ1JP0NOWteqQs/Gs5DsPDIFzY4BegnUf1pBU2vogWwM
	Sgo6ZLbGvfNUdpUlUNOnrpXmjM6WYAN3mApYv3WGMtwf57StJGuvr+P25+nLN1Ec5HNhwdcWnjS
	JV5/KqV6xLJca5uH4IYFwtVRkH5nb3Hf3inGaDn03TGqX9OH2IeWCoZY467+Ha4PoKk099gH5G0
	SqxXhCCX9tX38+GlXOAJIXCHWWx+0cT8FtFBjIuCAEnuHu6058icOMFOnYirzWsp0jTCic9tKVk
	JQx3A9yk4YNREckVs0o4teRoXGV59bG1ag3PRDycRgqkClVjPD6lijXsvv2+10wPEiv8Ms+LdNu
	F0sifwudaETFEEeCYVkRwCJbCoxCptWODhKmQi67L8zrNxG8fH
X-Google-Smtp-Source: AGHT+IFm+13/Usyf+mPKHCUlEAe+40VXIyegDq6lyi/sldF2K3bcIYC07yC5iWlYMl11WZINFUSf/Q==
X-Received: by 2002:a05:6402:146e:b0:63a:3e7:49f0 with SMTP id 4fb4d7f45d1cf-63c1f6f5e6bmr9507256a12.33.1760877948902;
        Sun, 19 Oct 2025 05:45:48 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c7267319esm1381222a12.36.2025.10.19.05.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:47 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:29 +0200
Subject: [PATCH bpf-next v2 05/15] bpf: Make bpf_skb_vlan_push helper
 metadata-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-5-f9a58f3eb6d6@cloudflare.com>
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


