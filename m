Return-Path: <netdev+bounces-247012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBD2CF37AB
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C361330C2B69
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3323358B0;
	Mon,  5 Jan 2026 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eUswfjxd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FAB327C10
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615288; cv=none; b=Dxpiymptx3+K6tZ2i2Gyff3Vnbw+E5CEFcXBEPfBzoZE3akKbdfrsOF+zbbToc3a5em358p6yURDxNwVdDurrBMsuFFrd10tToxhwwsturSB2pIqqVFM5UyEcfaKitCmqXgm3hwxNtwc0E8WdPVA9hzoK6BDNZ6PtFMY2rM1PWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615288; c=relaxed/simple;
	bh=EqBhB6y4nXWzGaTVlNv0CC/SrtIcyYjJWnFdNxvlzoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h7KLuoFO15Y0mc2Z8qk1or2+SGxgykDatyuRbXcO925O+7j/gGHw9b3+Pco94pr5fQ1+R7eX+ooqxRH7SkXzOCckvDa01T1tuLxeVljwKzuTl6l2JHqPvjTZVoY+YYyEIFTj6p8zSF7+h5jAMpc5chFGoA9DNAvKslRjiGbq2gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eUswfjxd; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b79ea617f55so2719787966b.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615285; x=1768220085; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEldMdCG0j62Bqlt11G+kGjryDuviTYdgTtDogGixLQ=;
        b=eUswfjxdcCrwPvWXzka52q1/ujcrK6ijUNprqDWbiWlcToa7DDyls3FkEcJqx03b2x
         gzlX4+NY9cZnS/0kCn+P0qBhLq/Kak6YINYSlJ1XY/1xiCbxUJIjTi91LZVk2EMPwRh+
         xYM44hXMXCnnbyp7Pd/p4Ib/Fv1J9hbSV95Z/wHAGz3hyQJnb71+6B6mQzbS4JyBhRuI
         XRoWPSJggItU9HlV8OQWplMuX4hVRRh7moGfDgTCn7v2I1lVxobciPoLdaXgavQMRYeE
         OvyxyJk8uUv9n+et7uy1v0jSvnqy6jlmIbr29l9Jb2k8FvKM9i2rUQaEsCb9RWj7kE2d
         BwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615285; x=1768220085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eEldMdCG0j62Bqlt11G+kGjryDuviTYdgTtDogGixLQ=;
        b=I8Mihha5gbcVgHb0/TzGOEIt9As5BurYVLa1+Gpl5iNl97B/XriGRL7ib5BqY255TZ
         bGQkJ5+c5FTj6acW3oF69tknevxnbTITedq6BeqQnPaWQJGmHZl0s0MQuEo70JRVfZCP
         uDB7S1AjnDmasQUJYRoQYn0HyhqBrASLlXq++S6NpuhbeBvAq0jEfr+8xYHfjiwvdSJN
         oeqjie2j3oPVHT8DYGRnnzXclRY7vxexhc5h5yQazDGpr2/egzAKRqPyxgzMfzZySBJh
         nWFCL5WslI9l56ZCjDHDICtgNQcI6x0XY2GTvOyTCAW8s1FNL9PQIQW12Grwn2i46I7j
         tpFg==
X-Gm-Message-State: AOJu0YwFQ08f57D7+svE+mLAerfjxTQaLaGbpZbcoPHvADBq0lOjFv9r
	zk2fi1hcnvPdUvo7unKCoAvUk5VuVueTS0mRrrtC5ERiLhElTTHw756yY02Li08igg6Z8pkg06O
	kgvYL27Y=
X-Gm-Gg: AY/fxX7IH1++YQgjXsiKhm/8vgcNqn1PzFsBhsMyBRUAtnJbA/uztVvBkyXcorKWI0Q
	ljYxcLdMEolBgAuTQWU/5ytLr6UwtNM4DquT0WX4655jLm3/CLlg82HT2hcCJzbnhRgjRIcWtt9
	lJ2XHSyzJWqgDCz++6qo1fH2nV6GFwS4gN3TUBklz2VmWVU1rOTuS5dFueJpmYim4TDfzlqe6yh
	yYNkuv9455dXhWReiPPv+gM1Uya+hqKmcMPBOYv93PuxaPVW6UDDS728pW8S8qdbjuDcoNdkgZI
	brypaTVcDe+GQVe5F0Y15mq76UKs4svGU7txjLe7WX7nNzYDvLVR2UqE1ONgr2Brf8FroTzEfmO
	p3m9HtG6wkaQMCmykw5VmePDOGheqWGgUyrPzxsQeBBllvHwqzkFMIPgjzAecVazKATLHL+HqEv
	8HAMNlhbYNFEYLMorqkMbw9wEVhArcK3x1hjCSDebcKSPHo46K80caw7iy2Uo=
X-Google-Smtp-Source: AGHT+IHmtQcwTn+OIhQ8dF8VLcGJ4Z+GHOroMq5kD3E4xsPBO57+1N1lpzN1hU7M8hT2FCPBk/amUQ==
X-Received: by 2002:a17:907:1caa:b0:b77:1b03:66a1 with SMTP id a640c23a62f3a-b80371756c1mr5773762666b.41.1767615284726;
        Mon, 05 Jan 2026 04:14:44 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm5327889966b.57.2026.01.05.04.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:44 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:29 +0100
Subject: [PATCH bpf-next v2 04/16] igc: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-4-a21e679b5afa@cloudflare.com>
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
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7aafa60ba0c8..ba758399615b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2024,8 +2024,8 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
 	       ALIGN(headlen + metasize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	/* update all of the pointers */
@@ -2752,8 +2752,8 @@ static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	if (ctx->rx_ts) {

-- 
2.43.0


