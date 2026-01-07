Return-Path: <netdev+bounces-247773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCD2CFE604
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 15:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5038D30DBBD8
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 14:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133DA34D4FA;
	Wed,  7 Jan 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UPOL8Vpf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904134D4E0
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796105; cv=none; b=GBjYJ9DPGNGXWI11j65aB/UYYK3+P3pywmBtxXB1fFWOP4dfmkpIhN+EsLE0AXSaYjs5D1+zYKmEWEuyeBKbUc1cqutMaWJhCdVKHouX94W/AU0wTZv3GWA6IO8p8DWBB6C/m55zqzBS2MGfWLobkz0Kv6dDEaAp41wAE1miZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796105; c=relaxed/simple;
	bh=NaLr3kuYmZoB45GFF481B9GG1CmkcJsN17rUBCCL3X0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISnWBAY8cXngi39xg1BwU53JuGXA82VCLQWuY4IVlTvBYOuc3VTzCda6JLfIY1Frw15mLEGzL494gHxTbf1J4oG1rY2NmX7IMVGtHtscX4E931wMNQZviRFFBb1csh0lrI0V3FAuU0jRbghhbUerTWYOse0hRNwzNqdfEgEsadA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UPOL8Vpf; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so3535305a12.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 06:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796100; x=1768400900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BAkb07UvD2AJKDS63sluZRYEIGpz2hmyS1/vul3M/g=;
        b=UPOL8VpfuzfUh3FI6D3L2ER6M04DjigHiZ7CZbaRgH3a/AuWjEwfBKUCOtfnTslerT
         X6XwbytS1loQr42ioieOG7/fkZ3NZ2hCL7d7h6qQ8tcQT6T/SSyRe1T3zOVwm4SaExr3
         mqBJDC3RqJkhLx/iFCNy/1eEfJRYsoE5xEXWD6yZpRCtIBJdH0ooZx8gK/zToURiEBCr
         6BbxTIjegrYLNOSYXxiS3LLYkjuPerRlmplfwSbGrN2EzbxkqHAi/Grxzs/STbsqZdE7
         6ZZS9jAIeBlQhf8UWR2D71iUa8G4otcr+SXhmqfVUfIgglb1gfU1HQbGKuIShM9CQPTH
         S/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796100; x=1768400900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2BAkb07UvD2AJKDS63sluZRYEIGpz2hmyS1/vul3M/g=;
        b=C6NKLsK/odHenpPRtcDR++IN5yvTCRTkoziCi6151JQQpABIx5NnTKad2UXQp+Cew6
         83X7jLhuUHQHKLegXChcxcJdbTAaw+D8340E7+fC0O27FDFunJk21YkU2Hfg4kgXz8s7
         /1chF4jl+bu+wMvc7UwfTmEC9vJ+CdSBDmj+HCIIVxdYprsa92PeyektFsKKZdmU66tL
         3kIMwwlFOz+d00LslEglgh36qtVTDut4rkjheFwqRdT9TI9BOKdGT5unX0ZWjJxFHK6X
         czmzKD0cdrU5rf7EIITuclhnkOJJ08/bUAizdqDtXjP/I2VhDexv4C2zylG6HIa5+5Sk
         4b9g==
X-Gm-Message-State: AOJu0YxG5uufkX/oUGqiH+HF+26SaSabP4guFKFm30PBBD08hO2qlX27
	9fB4q5sPwKUZiWBpJc7z/dloJ5ixu8Sb3A/fw6GBfA4h61aOEBC1Bl8k1liOOvp2mjU=
X-Gm-Gg: AY/fxX6veAjiYCAR6f3ZYd6id0CWA5mg1sILCmGpb9+D5kkLe8nbnu1dxonETFb7iJY
	EIVE+ImBocP73BbrAWROiZW/CAKKko6R2myAe/BGcvM2pARWsMLO53ODFJTalEmTRgNL6PXTVeZ
	WeW8+0BYGHXWc62SScrg/GcawfNNzyT6WDT+q0RJTo7Dx8f5JsXjVfvTUb7UYSEWCfhYpJKs/7+
	PCSF1wKpdln673Os5VnJ7qn5lu5hHMytTH/wKIX7027kFG4TRN83074TbM8TjgxG+4erEVkseIZ
	fM7XxDKACXfP/1nGvg1HzGMK3frOuM8rDPLvbWAnn5NjUVjy5ks/ZmDeIuUVW7xF5gU6rQE+SeE
	3FYqFZGunMaxP2gWSnaVMoR6EPWyxRwElqivCvKr+4nuL/wOayK+d+uYH1V/vmSpEgDKsAAU2xH
	dJd5vj1I76Q/3CHbkJ9d9S0Y+J60vUDmfTcQJHHpRo1stI1dc5z9dYRjesYkI=
X-Google-Smtp-Source: AGHT+IHitZah3Va/SbksXm73SZCgETkvGSFo9DYkkuJ9TIdifet1Vj9nG1ONYb08mumiFWDsb4Zn3Q==
X-Received: by 2002:a05:6402:51c6:b0:64b:7dd2:6ba4 with SMTP id 4fb4d7f45d1cf-65097dc62b6mr2416519a12.4.1767796100477;
        Wed, 07 Jan 2026 06:28:20 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c89sm4626004a12.10.2026.01.07.06.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:20 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:09 +0100
Subject: [PATCH bpf-next v3 09/17] xdp: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-9-0d461c5e4764@cloudflare.com>
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
points just past the metadata area.

Tweak XDP generic mode accordingly.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9094c0fb8c68..7f984d86dfe9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5467,8 +5467,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 		break;
 	case XDP_PASS:
 		metalen = xdp->data - xdp->data_meta;
-		if (metalen)
+		if (metalen) {
+			__skb_push(skb, mac_len);
 			skb_metadata_set(skb, metalen);
+			__skb_pull(skb, mac_len);
+		}
 		break;
 	}
 

-- 
2.43.0


