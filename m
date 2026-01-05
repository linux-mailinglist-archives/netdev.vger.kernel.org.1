Return-Path: <netdev+bounces-247011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6F7CF3778
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 316223020154
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CB4335543;
	Mon,  5 Jan 2026 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QOS48JTI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEBA334C22
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615287; cv=none; b=R/VzwQFMjFy7vH/mJ9BBUlcFsfTGoGbLn2wyweqHCAKqEOQdnl9wiB3Ilv4EXtWdfH0wz0upM7oAGFG60KQqEiOXM3S80kC9fmPuhrhIEYjN/KGl9+tmphg00Xr+QrcF49ch1ZesvSYnIdJWW+z9UrL4QPNwV6nsMSooumtHJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615287; c=relaxed/simple;
	bh=Jw4sZlwfvlCw9U70oFYHFDt2JUDMKantZkYZjOZFw6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uOQF0anpWAQkuU57G4ZemBc7EtQdH3xBvlt0tc6Nd7pwqPYn5vnz5f0dj1W7VDJrle/89WBo9nr4RY0W98Xyra2mwk9U3ihyZH5TVMGVn4G/pCwHK2TY+XRwQmhEmbw9+r0mmi/EpYeWkyo5i6YPhiRnVKU05EtF7CXF5enW0c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QOS48JTI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b802d5e9f06so1781915466b.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615284; x=1768220084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nT0a9okVqQVqG4JPUviJUmT9EW1WnhugEMsAcr4nqg8=;
        b=QOS48JTI/P7Yyy5cuGUkCQBKfRGFS8iIXRxmpBOMMBE5xPmnLNsTM/BUb8OS0U7S4O
         /kiJsXTUA2OUyGzp989ukwfNKFL5YWg4cXPQ52juDmjEDPFH6yHysQ0njo9JqX4/mfrk
         huoIA/AL8Lmd/bFZXpK538rinuf0Y2YHqN0YJh9VV1Kg9CJFwe9JZnn4dV2I5tiBL4sV
         4ajx74/okN3SfncJ94c1fmHa2bEl7IwyEeMHyXo/IpHgK9+0DAM/ft9Sa0mTYk4VUl5d
         gFgM4xwXu6Hq9NfswoSZ3j6zTOtbFzLIrj3eml3vMZk9d/tEyx5t1avPcfb35CHFc6nn
         z1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615284; x=1768220084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nT0a9okVqQVqG4JPUviJUmT9EW1WnhugEMsAcr4nqg8=;
        b=dVjKiP23NBg6jM5RfIrzIpjdVgYRsBlkvMTTwplrjCXgaThVaOR/h6DVaOAD96adpQ
         ce98mc8apef23+CJvYJsNb561yXxOfBMApOgkR00kkn3+2C21szvLIGI3dJE/OSYrri+
         UCOLeCF2FPmxvVCGfMN6YQnGcIYvlWb+C+d4wUhNXy/MevvZfXku6TfxDJ/Q1oWhyLlu
         KdFis5WMLitkGYRhhxUfUK60oFJtxHVkbFDnAOeHReaRvGwGw8PX7p8qk7WPyX63e+tu
         nYMXHDabknSpQ2d0RsO5D46ErJ+Gks/TzSryva8XiOi1Srh9eXQ+V31DP3RHjb3Qt28c
         CVYg==
X-Gm-Message-State: AOJu0Yz3KJXhw62LOK7OCEHK7ylAMzLCe0tbtzrCssW7xBJpF/tk+ojo
	rLVF7liPPLQ3+pDJ2Qpwjgkcmn5mwYUBit2On7GkWdy3yOKb2RoMzx8Djn2Wi0zBr44=
X-Gm-Gg: AY/fxX6QwJBWn484Yho2WVrnYvXjb8ZP8ByUnp8zlH8+BkR6QKy7epLXe/cGH6W9EEP
	qADO0s7jfIuV5HCiifSU2baRK0JN3ENWhEOVQnSDCsAAYYTRJZvVxIg9rDLL8duV5Aqa4UeDUf+
	4hHODD5tPOQP346/JLoFBlDFrMbIMMKDdwfaG2HDLLdOiRY0OPVUaLjB/NIeq4t9XwRIwOO97Bz
	bcVpzqo1ovhpQSkCFkkCtoP9SD7sDO49ayCXKhxchW/gDz9XLkuA0O/UO7+EnRb4kvrxIVu64sN
	oh544hFKN5xppxAqkw92E02cMinU48jnV1Fg5+cytyq2rNbURHrk9KGDLmCe0GyEvlRI5bvEEcT
	Fh/GgxHyeXNR4os2429G8YSz1e5H4ZIr+vMPSzuwxbbkMABGFZSN5Cj/wbKrTh1hwHDfcF/5KMU
	wgPwXNPeQLXfLg6Hz13m3Dhiw1pE0zBDxJl4UT2AvFhqDbduPScFjUY90Pt/8=
X-Google-Smtp-Source: AGHT+IHnCZ5omgu7ZRNjq2O1BB6JNDBHj6Vw8V7C0m2iRJcZNjtbxb29+5EsB+UFZxxKS5F3ve2vqA==
X-Received: by 2002:a17:907:9722:b0:b83:13ac:a3c4 with SMTP id a640c23a62f3a-b8313aca9dcmr3790232666b.52.1767615283518;
        Mon, 05 Jan 2026 04:14:43 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0cea9sm5458801566b.50.2026.01.05.04.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:43 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:28 +0100
Subject: [PATCH bpf-next v2 03/16] igb: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-3-a21e679b5afa@cloudflare.com>
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
 drivers/net/ethernet/intel/igb/igb_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 30ce5fbb5b77..9202da66e32c 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -284,8 +284,8 @@ static struct sk_buff *igb_construct_skb_zc(struct igb_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


