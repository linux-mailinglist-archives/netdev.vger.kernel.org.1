Return-Path: <netdev+bounces-247017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1557DCF37D5
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AE6430ED97C
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107F1336EF7;
	Mon,  5 Jan 2026 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Fdv8Fmsq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE49335BCD
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615294; cv=none; b=GlpW0m9GOmD4aTCqQwn7jYrc9BRlaAcUPvBDwfERyQVrWDEfaoKVDgwfNpNwvz8U2FZSt/D7tLgbEFfk5fGPtRFaXrCuvK5JIs2Wt+1YjpZWApN/slcWzsheUZViiwTFKFMoNqG2myVy5l6nCsq0o1W+kpPLEseRJThPcKl+cMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615294; c=relaxed/simple;
	bh=NaLr3kuYmZoB45GFF481B9GG1CmkcJsN17rUBCCL3X0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y82GwTodqvfHRsA9w6BBoEtDT1ASslkJLoIpJOkKuMC6G9q5bmPKGXqVFZHkdrGzI9mApDabCCLhaJt0asQOcJHHr/2XBq7kpqeWJeN/CRs0VFTNLuf5E12DwIVgJ6WswMSHvkMSV/aexHCkyRLJbpOiKvUZ3IOI2z8p2ua05JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Fdv8Fmsq; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso506134a12.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615290; x=1768220090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BAkb07UvD2AJKDS63sluZRYEIGpz2hmyS1/vul3M/g=;
        b=Fdv8FmsqIP9oEyJgiz7/cRZsgcOEtDxBOpqXEvo0Dx7Ekqf341/ELQ0LpRJxXuF7WB
         8iER8irfxoqjUw4WsaboAzXJpsKwxTRnbnJsec7DLA01TzZe4ff0BVoP6UL7rq/hQ9qq
         eb6ctCce99ESX9D1ird0AJGpC2KgV8EUUWgxlTMm6KlYHKncQYEkd63F9GuvkKvVpnWk
         qfYAxoZwLCSPjiOx4Rp7FPz9UETSeaz9yWH+yjxSVxbZvZ/s4QRJn9+yhlosLwwp+rIu
         cW1MKE0fBpV6BVIx7+SmGy7jddVglLP6kueDZdtDs+3B0x0W3iXoqjCSXeiybL0Q4Vci
         fONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615290; x=1768220090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2BAkb07UvD2AJKDS63sluZRYEIGpz2hmyS1/vul3M/g=;
        b=cxUEglTUSu/3hXyDeFXn4juWe48GnmAgIngNhSYAB8UDPPIvyt/vB3UrqjcEnvurAp
         mkvn2mH6nHnGwqegkJc3kh437pEm/ap02Gy4SZ6hSQbGHtML4zB8+3A7VW+VFHGYRmMi
         4kg+1Y5tMXIYh65BdW1TJwYViAG/u0k6T8Y2fy/+wwV75u0I67J+DKAe73p8JIiXJtKc
         zurr/Pi1r9LU1uoTnsOkKMYuqhiWm6h0VIXVE6HA7WCjHuxlWePOKw/ZPeRQn2Jdl8dj
         CbTB39noYACN6CldP2N68X/AOaNB8My7ZV6AHu4AvdXwt1FKbuiwZqrbL0PT7gTN5BMv
         FH5g==
X-Gm-Message-State: AOJu0YyLqlHwoKe8Um6/VbiN0H060vRJGkI/2KHaJnp1xnOC6dfGMCHM
	F6dxyuplC27uWVJo8s9SbaSHdvAr7XEhaIxuAgh4fXhd6YCXTmHodcIcDEab0jMuUbU=
X-Gm-Gg: AY/fxX6OuTDop6QIXYw6OvFAxqYV+nEluAc0fK4RoEG1aac5CYp3Z964dgE49Hsgv8M
	Kx+PqnDoj40TonSC3Ha+Xoak6eB4YqVtDmOszJuk5CWeuW12YB88tnQ9WWYMW1LJjaUuX0f+TS0
	arbD7zg8P/alzHncWdTxJkZVoP8xDXOqOzjBDWTi/19m+D8zdn8DG/VAL3+LW3rDEmtKbr+RZRC
	GA27QYF1qiLj7WrAZXBCNk22PPKe/fyp7aplnkxjRWcUwDIwbsrvxfQgfwGhdp/tPYKZatNK59b
	dcEuH/7QeEVtyWRjQdOnvqDlk7k2jzwCkFxyGN8VJaSEdTa58hS8OIsPFQZq+FQZR1XGYmSL0jj
	EfEV6IlH3ovK5PuKo9Qs5Oa9u+5dzOU7PFQqzQU6W8tGX+QXhR+yO1xTOKd1zCSXwaTrfOZb/n1
	fNrYMQSbqCVP73TGq8agmRuWfX14qUiBP0pOG63oqEtGZevYUf3RB/l2j/6T0=
X-Google-Smtp-Source: AGHT+IFZbTDVGR2JrAuiEMqmDHBbbvEX92cxXAfcOOxKTm/GmwV3C8zNEedPki8j4tnnxUYBhiRLlQ==
X-Received: by 2002:a05:6402:4311:b0:64b:6e20:c92e with SMTP id 4fb4d7f45d1cf-64b8ea4b945mr46593884a12.10.1767615290543;
        Mon, 05 Jan 2026 04:14:50 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91494c0esm53415488a12.20.2026.01.05.04.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:50 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:34 +0100
Subject: [PATCH bpf-next v2 09/16] xdp: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-9-a21e679b5afa@cloudflare.com>
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


