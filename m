Return-Path: <netdev+bounces-247766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A519CFE4E0
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 15:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DDF4307C5D3
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 14:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD86B34C9B5;
	Wed,  7 Jan 2026 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Hs1dFJf4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D81E34C13B
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796094; cv=none; b=ZazWsDGUhSxI6i2z46Py2Yoxwsbyhj4NP9aiyne+eUN6tPapXcXjI0+cxF4ftg7JF16dPqQTwodqWW2CVOzkwwCtn76zU1Jo3iNVTgCN26LtitDXpmD38yHlsOelewLlaGn8YF9pgB8I4uPJGRCjKSrIkawBvWpVfvsVMqVMXlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796094; c=relaxed/simple;
	bh=1ck6tutHU4Ma4Atw3X74zSh/n05QAkXfc1PVlu4d8xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rNy1v9gCDGjCTO5uAlcamdS0+PlAE4/YeQFzrkXhBfx8Pd/BOiWc9fFzAdc+r/qIz1w14NFkyyXChhLAVlGUT8hzMzpUSlD8un393fjCPbtwUFkfL+MLtiRsDEi5QPuZaJ4DCRw/61uBtOEhiWCgn0HIRxquroY8hSWOsC7hEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Hs1dFJf4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7eff205947so291066066b.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 06:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796091; x=1768400891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJsFK03V0pNRh3ST65sOF8XcGbv2MZfFShwn+TGVpfQ=;
        b=Hs1dFJf4Tg3BGlWCgMSW8QAWX3p5UWr724grLcREC+jfdSey1d1axiH/CCcrFx+vgG
         LWqL+LEncdnLwDjWRr96N18UggTmpAQWdA6Z/wV5JvSoR/Dhh8AA7JFhnvO6lYQKwIjR
         WXxmg8BJth3cIUicsPX/ktbeVRYfH3DkkzNAjS01o0Y2Bb4Om++pVEeLcTtYYP3d7d8s
         froSH9H45zzrUyd924Mw7MENOpx8pTP0mrCwm6+BIzbf4ouGQI5y747kr8A9CQFwQryF
         XxkaTEb5J+teqPsWMTPh2WyWI2VxTmuoTbGp/fe5gmOngjk/tDOjrXGYznU6L5f7s3gY
         ejcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796091; x=1768400891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TJsFK03V0pNRh3ST65sOF8XcGbv2MZfFShwn+TGVpfQ=;
        b=RIu3GshokXvpWX40HcHkGf4HxOYEDz5yaYOfguXpHU2F0OnvcRBFa57HAEMI/ZRFYh
         4xSycYbcLBT0Sx/19D50wOXZXzaLd85MPdiQSlK5kNYP0ja5vzsylyLVKHFaqpJ5wB3L
         emPPv2agsWkvZZaxpeHfASL/QsBRiEvuhqgSKuyGg8ldh/ZncCVpQ9q9W+6UWa/1n5mj
         qNDpEx50UrFzGPPqMZ5y9RQ7kzFQ3S7J61+P7J4yxl94/DTiUbz36+FW5ouJZDnZpoJy
         BRH8SIg6Ee84Ac9zWjtFTbVAFO0wnEUnz+2HuKrz1jQSHg/nbjtV/wapvmdWI17iufyO
         9lMg==
X-Gm-Message-State: AOJu0YzySOxwhVbmg7oEg89WN0NjyBn5Fa+5CLIQftr4NR5mTkxP85eJ
	pTcOcTd0wcdJWcgrNJr9T6LT7x6Wn7LzqthyFEvn9Cd9FGCruG74oIlVPlnJZJD7/7qxq4XxSVB
	PSdUr
X-Gm-Gg: AY/fxX4dB/ifZJqjo9JWsHgB0qvODJ9nyL77mH8hEXe7X6JLR+MCUZbTaYtV8oPKsMM
	SAP/IGFlk4l9y+ba1Y7gzF947V/MKgysyx1CRRA2nh1JfzVhc2KI069Cy9bt7OJ7gxH6oVD6bY/
	gSGr8iKVfxvK0PqKhpGp2N7Pd7gtx9nKlPDzTj2MtvPfZMXvIlj5hQ9HbrMw5H1IPQHGLCL6iSK
	75sfRGzkd5BlJW/yWTqaWSgp+TDnHN/4GvpkM9D2r//6R0eE/NPoE7UBLZg+2KmzTCMene8K/VJ
	LRMH2e14CVFUNeUPXJDNI6dpkGefnFPY+UJXOVg+aVTsNkgM80y67wOb0TUa+aMRBZmZjo0/4zf
	RTaJGiQpNbW1Q2QyWagH4E7G2dgpOZ+HkQbIt0ZDOVzSWWtvqI6DsA+TjziSDBkYI5nY8XtzMgO
	Gc94fMayNAeQbFINTZF1Z5mTfvE0YTpy8j4BF3U4oF219sOqiXBMQEPl0My5o=
X-Google-Smtp-Source: AGHT+IE+q5X9qXosYEtHOjNIL3TLphMDufwJ7KJssSgQQY8hodUtwxtN4kg1hMoWfCz3BVk7EQ/yKA==
X-Received: by 2002:a17:907:96aa:b0:b76:8074:344b with SMTP id a640c23a62f3a-b8444c5a094mr223930266b.8.1767796091166;
        Wed, 07 Jan 2026 06:28:11 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a2cffb3sm528626066b.31.2026.01.07.06.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:10 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:01 +0100
Subject: [PATCH bpf-next v3 01/17] bnxt_en: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-1-0d461c5e4764@cloudflare.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d17d0ea89c36..cb1aa2895172 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1440,8 +1440,8 @@ static struct sk_buff *bnxt_copy_xdp(struct bnxt_napi *bnapi,
 		return skb;
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


