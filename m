Return-Path: <netdev+bounces-247771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44152CFE519
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 15:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4B7F306B049
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADB434D3A8;
	Wed,  7 Jan 2026 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TMSK+xP8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79DE34C13D
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796100; cv=none; b=IqIMfbTA1vON83qpp603bvWb6DRTyaAIVwNi6Pq5OCF7j/4mI4Lth+L051CnrihpAk/7vcXPZpO4SKd2W+8VRN/01bWxbCW7Cjog4jJSeyaZltxuNsZqj4SXDI/0y3ruyTcmVEfkOEmI/OXu188PhptqEnol7D4EDK0ye39rlWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796100; c=relaxed/simple;
	bh=vTSKYdEKalEEC0tYawisXPYcDqtHT/RCHD4qS7kEMbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z9+u0RF88KSFpWbrIWU3Dm7gFzMjxCsUcxl8q2WCCFGpo8rU6RhF/NTcSqNVAJF7d5TS2TTSSPurY05CFXMMWZ5Emy85a95UqFXjpVn7qk5oiQ7ki9vJ1CBcaMGWA2cPCpGH1UI7sHQA7hQTwvbazKa5mzT4jjBq/tzsG9OmxCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TMSK+xP8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65063a95558so2998572a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 06:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796097; x=1768400897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emFEi/HmqvIz35rZRGXX9ycinftRyGRx9vYGA+4BDMg=;
        b=TMSK+xP8RG3Y5lcmk/W4YIuTbj69Za3gF42TfXntt1XS+yrbdL2Bl+NCJqmjBzB422
         IVbWPfK6WR5qAB0/xeunba8SGCPEy9yCv+pXZCxsjM/MRhGdFaJXVJmvfXPI8oo87Miw
         +Cat794SJKVPGRSloO5WLbGOCNWSGiKbRO70eFEGUbafiSrD61IKoy/76Taa0hU2xSFS
         GxPMGPfWfFrTFc5EXotxj7yuYwpJ6O3Hvwp/XBKhZAnVlpdIObjLw3yh00pp3mVoPPHj
         wPpwfX/KRrmB1sII6TUMqYL2bkWeQF3wQyPAGXb0grzDoP0W2iUfynOkILuQinphN+cY
         THJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796097; x=1768400897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=emFEi/HmqvIz35rZRGXX9ycinftRyGRx9vYGA+4BDMg=;
        b=v7jqK6GxGHIM/07RG0ZmdKVhFnqlmcF41d3z36pPMWim660HoLqkkoe1vRaHV2NAxK
         LgeRZMjhbFokvYZ1Q2vC8hmN9JQiMsQAsCIlwD95OgEemR3mqgErNLg2Xs6y5pdjhRji
         uejqRVT437xDggqmqQGwbhQEbQzk/6H20Xh/kw3kWXsu/HsBgWTDJV3BRztrKf2zxMKA
         INuCOS1whi6pBoXIX10+yMCmbgvik89AvbMtJ9o16H7CbUajjpiHN85yKotX4AV3jehf
         03ItqLTipJfT7Zfal/PMYJIjvqhp49SWACT3++Rmt2ozcrwu6lVe6nnSRYKpEuEShmMQ
         2+FQ==
X-Gm-Message-State: AOJu0YysbKmN+83fa8SSJZ/pj4VHJ6pOgKgc0hffc2Sls6xLH2mdhcX5
	tqdtA3/7UEtlIEjhiphFXTjnpvzW5DKmTNCHE5i6yRPmO2LmjCkpw1sGhusPB6MHoms=
X-Gm-Gg: AY/fxX60jyX393Atr3SzJGMz0FvpUY168SV/6cUQW8a+LOCd/th9j8X133oU56+oT1G
	39Mn12xH4VWNTFZzdZ+IxnxZDvhghYPlL76jqTzZoibiP33OSNmdAGm9LLBBBxIiYhAQx2LaS+k
	Xi4LvsT/lAvduPOEfzPRMdQkFyJkEPFyJnNZx83gaah0XyJSTiCqMmH9c3mwVm120LJxRCb2Dir
	822XVgeuGFIe0XwxQxHnK9nZl/2odLua9PvTFblu519jHb/CZQxShm9qxiD+0uX5XtnweGH8efe
	Xh/SuS62eLTSHk+p/jpNv1B1rrf+NDzvJtCoxgX3i0oh0UJuV8Vy60PqGVSuBXMXazCO2N+2x5/
	dzaU1QwhUphKW3510mhWMqCUi0TcCv5c35ubTD60qIn0Kpfdv7oBCq7pG9UJ8mGHX1uHlAD98Ww
	GsXvNDuLE01U9oUDnx7RAZ4eJnQdfq9T+vuTT0lvPyGRHkJHYdLs6rWAXFfTwgPuJAUHMSmA==
X-Google-Smtp-Source: AGHT+IGM4L/5As1969KPTHQE48piWNYmGjpJT96e/8YSp6CD8TX1LSs5ocFakSsAK4mY6THqjPNpdg==
X-Received: by 2002:a05:6402:2347:b0:650:891f:1c07 with SMTP id 4fb4d7f45d1cf-65097dfa98amr2467937a12.14.1767796097014;
        Wed, 07 Jan 2026 06:28:17 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf667fcsm4716873a12.29.2026.01.07.06.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:16 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:06 +0100
Subject: [PATCH bpf-next v3 06/17] net/mlx5e: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-6-0d461c5e4764@cloudflare.com>
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
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index 2b05536d564a..20c983c3ce62 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -237,8 +237,8 @@ static struct sk_buff *mlx5e_xsk_construct_skb(struct mlx5e_rq *rq, struct xdp_b
 	skb_put_data(skb, xdp->data_meta, totallen);
 
 	if (metalen) {
-		skb_metadata_set(skb, metalen);
 		__skb_pull(skb, metalen);
+		skb_metadata_set(skb, metalen);
 	}
 
 	return skb;

-- 
2.43.0


