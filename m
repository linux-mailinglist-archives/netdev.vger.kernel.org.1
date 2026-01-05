Return-Path: <netdev+bounces-247010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04294CF379F
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91962309F72F
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D075335544;
	Mon,  5 Jan 2026 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JasSORni"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C14335072
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615286; cv=none; b=kFE9sCLGWEOOWkoQReO78aNWfiQG5P56LRpL5iVniKCPoiCzeqLEED2CIRnIb4Tanr5pMrd3y48hrEXzM/OkjF7arLMy5GEuhw+vTco/3ZgrllG+lCOluyYu2ow9kix6OyCNE2JRTbwdV7IYary6F7+a06dqTrb2GcH7Ll+wxqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615286; c=relaxed/simple;
	bh=oMHmrv504DpK3sDJkcM25UNgfzziW6gjvBfOPGWboAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhnM3LDJ9IDb9leg+aFnd8xA3aj8JcMR8X2cuR3PYQT7LNxQBnl9n9dSQRhNikJMuJuzfkAdFNKPSVLNvFgWqsu+Dq8KP5CyMDZWjgjw2DSmoiZHNUteN4CW79Du+6hZaHGxvRqpY8SB020CI8gkzcwdqTuQSdebO7o5IMzt8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JasSORni; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b725ead5800so1980254966b.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615282; x=1768220082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhn4HZ+NklBudGUcJpb0YU7dEzH4q1ZmXiPPH0r44sQ=;
        b=JasSORni3SGFg1SvuUvndtb6mBN10PVTTpaFqJK+k6WBa99alT+7Fv03U9o3k2nUdk
         CUgIPgmhhpigUcBMFZCuBH8uN0f15A2PqA6kv1g2dQ7U6tbLgY+GnGNaaPfI0os0y2PF
         cT6H3w72d74R253H2AEXWqFy9iXgz3F7ZCKPwPJ77Bb08AQebeane/A6T/+r6QFl/3UL
         uIoCixNribDxhlmwy62OZg6IWdMw3Rdu/3uAnhU+57Q1SqvLLW8Y75xVhU5vCO2RWP05
         R0QDbfn9FOwPY4yc+nGSP6RgM+o90jE97ty4PkyFLnylUOZ7nDt5gUgTdnH8IaHdkvl3
         8FSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615282; x=1768220082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xhn4HZ+NklBudGUcJpb0YU7dEzH4q1ZmXiPPH0r44sQ=;
        b=cyQAL54GlgrNwW1NT22KtL1K67P2zOhMdcROZNvvfYGB2GDSr9gysy3reSC7PBuZTR
         ItPUfwHvh0Y3V53h2m486b12keFzBcDfHVkLQ1BF1fjH9Yn9i29E/in4/0zIcsOmKucp
         RivWwvLhphuFKag2dt87lqdlXsL1L2AF01A2trmoU91IivnMn1kmn3LRZHwgSgDsvXlt
         49dschf4VC2mx/bL9CGAwbc+8iYDeraWB/DzDwZ39XKJ+VaNnGalOgYbKZCRe789yhyq
         lCUr6DyOmhme+aScsw8HYquU1Hp/A0PYcNd7+aG/FzTcJcojvNcL3NTDcysEdkChQJvZ
         B1lw==
X-Gm-Message-State: AOJu0YxKUCSJA5DbW+tnHXNrXVpE8MwTiVZfMwURZorMrO3OvWMQiICP
	wptj+OaqRiJxY7bxbLqXPWP4Uc3QS/lK7JBkorMW2c6bvp6NAClOpS7+dhfnl9LO/8s=
X-Gm-Gg: AY/fxX6529dgtTvqcGpJEcNFPfpxBguvuUhIjoAV9YC2Vloq+TRfibAAOM1hzpnl3qv
	8p/RTTRoyEVEWBjBW9NgZEqU765h9Lg+ki57DE1CCRFAxrfW4G1oJbzgbuFrKDy8PJQaFBUXn3C
	w43rWUIln/feFiewI4KgQTvZC7wSlQR2snAtt2UnPskAbCqBt4ofE8GujnELd8ycpbuyCMM51wj
	bBmu+44sBwt21spTo0x83eCeDDD2a0uGdhefSu3qKdwbKY+4L3mfl1McghkYjqAE/KTSoZkOmdi
	qHlAClyUri4rY8EvkdZAMSGWjz1KzIcsXgHB6DazJaR3Ma4ZjNXrvY8GdC9Da8C+qbW46Eijy7R
	62wIddT646aZd68BW0Kr488IEJD7gZfikobNm/5I4y8gl67cIf6k/QBE7CowwrQGgUzPXlBl8Sp
	cLPr7nMVrEnr2CkGqRMeYnR1SEHHDVp7CLFU1CIRstf5siw5FSbzx2nsAhEqE=
X-Google-Smtp-Source: AGHT+IEzR8UiPgOwvsgT+xP6okgmIV8TAjb8DBcV9yRJuXjUDaccDus6pJOrK4chKxcxEZN8ldHefA==
X-Received: by 2002:a17:907:9717:b0:b84:1fc8:2fb3 with SMTP id a640c23a62f3a-b841fc8efafmr95959766b.4.1767615282283;
        Mon, 05 Jan 2026 04:14:42 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b803d3cea32sm5367128266b.34.2026.01.05.04.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:41 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:27 +0100
Subject: [PATCH bpf-next v2 02/16] i40e: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-2-a21e679b5afa@cloudflare.com>
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
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
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..11eff5bd840b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -310,8 +310,8 @@ static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	if (likely(!xdp_buff_has_frags(xdp)))

-- 
2.43.0


