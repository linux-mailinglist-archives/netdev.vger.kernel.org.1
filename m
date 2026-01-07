Return-Path: <netdev+bounces-247768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A992DCFE4FE
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 15:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AEE63087408
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849EA34CFDB;
	Wed,  7 Jan 2026 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AbZeKMyO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9814D34CFBD
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796097; cv=none; b=kbXRU9fYwS6+9Al4wsHyI57Ii+iV6mkJpzoZ854NLrv5xdMi841+CD0IJy4ei9TyUTLsVkIo7PvWHb9LsObWkMAEPRZprbQUM3M2ZsrHXlZty/dXgDdDOHriiENCfHHukUuI6P9ishpOqhkjmXBaML/PtlHooxGf9/UWQ5shVi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796097; c=relaxed/simple;
	bh=Jw4sZlwfvlCw9U70oFYHFDt2JUDMKantZkYZjOZFw6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/2l58mtGUKlWj9JGSQov1vnc+assK3DWoxpPSmJAsMAi90XFLEO0HhDi4SUuUP5V84n3DKJitbs47AKJGUhxXKr6NM7yEf9H5Jpv/73zMnkZGlp/8Bzubm+g7wQKSM2kCWP9uI7TyQ0uZED/ifI3CCKx+483c6GsgzUUCWtalU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AbZeKMyO; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8427c74ef3so325896466b.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 06:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796094; x=1768400894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nT0a9okVqQVqG4JPUviJUmT9EW1WnhugEMsAcr4nqg8=;
        b=AbZeKMyOqpvQMiznN6rgqUyVYWJyCMl1fWGB40d+EnG+Mv7fQjG/CSTJeK63i7LpVJ
         TlGH8JG1U7LoY+XdEZp67ROHwYnKv72zMbPjR5899nXsah3qAVPtjySPJH7UaB2p3qnB
         r+VQTqt2zkFnt15zWm8BeApz9NvDEadVjaJgIyJssGwPTCRHcqEwaG5DK/yPe7sz+FDF
         hNzzjJK50aTPuaSfoXugKXRvJq7dX7MuQsmncQHnEYrK0SRVJphVqVJB8LEhadZnxkOZ
         FG4+Rp6F5oTS1g8cEkY9o2UOxqa6rmDHauhVJ13mZZIHNjVXV7blPk4bwt2P7fK20PJd
         KKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796094; x=1768400894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nT0a9okVqQVqG4JPUviJUmT9EW1WnhugEMsAcr4nqg8=;
        b=w4WeFR7bXRpsr+sOX6V6Xbpr6KEgdYmavaYqOK01Gmjw591MgeyqSPywCZTRBnm1PP
         z3G8vHohUbsnUW6qSAximRK4Pidknnz4DEqqYt0zqp7Vc7eiaNnM3EkXXlOaYCteTnla
         WG3mU05jffVTyz8QCLIfjx9mIlDf4oMnFuoJLaXwE5T7mahiVMHdNJyqWumrZWpRzFL1
         4LXVOjlA9e34Zmk6YwKRtoMb1uEVvgHGI1Cf1nqQ6dc/kSSM7RExTnWlEz12UcITLqAz
         ZlmA3XkLgTegrdlPfvxv8E1kFniiLsijk6VGF+3FF+ZSMy8DYnO2VaiIPuIU6eRDyOfA
         mPJw==
X-Gm-Message-State: AOJu0YwgNwbg0+wPl9QLLggrzK2rRjBCWdFPJXZLcYFZ31lx6LtQjRAf
	b9WADEhPlojO0DEII7lC+x/d0yvUgijwisNJuVW9aOQG9xNSBms/DyODyzr9YJEnhUU=
X-Gm-Gg: AY/fxX6rsut1fAIzoVvW4tB/H4W5i4PMEA1hcYEnKcQw7goa3QKXI/jey+zmbgapyu5
	MJzBW9H8VZiHY+N9Pa47g0mUFhAKSXoxjR4oKkuY6C3Xr8ygXKRV2iZY+KyM36LwLGGM6wWFgOs
	prrOScMg8NRgH2L2uPYL5Pine5MApRN2a3ZJJMq+fX7hJ09RQey60P+srXe/l1tdEJbfHaveei+
	OzlzK5S8vh+jnxQET+AjlLq5pMRx8Z1NK697nZFqcXYj6VKyRN4dcuelPmFjCwXcY+thu72qEBq
	0n6cfx8I4nw1hzoH89ckmRZSm22Rj+P0pCtg1EGh94F5FOqZRn9VV4Thb+zilPLKbrC3IQ4wfXp
	TjjTFNNYU9kT19I1oEhQd+BtxhLYhDSf9nhwb8gF2ZKg8ar2rbR7kE1K8anPuT+NkYwJ+25Days
	XAS5xYXYU3yWXpPPw6s7F0fUd7yP9+wRsGJYAU1vYv6B2cYDgzyT0a72rdJA0=
X-Google-Smtp-Source: AGHT+IEQyUNgEE5LhBCFBn9LcA6fi0sPlJEzbNogQ1M20LW35Y5E+tEoz6NaQqd6J136m44VqzesBg==
X-Received: by 2002:a17:907:6ea4:b0:b84:41c0:950b with SMTP id a640c23a62f3a-b84453e8681mr235912566b.62.1767796093526;
        Wed, 07 Jan 2026 06:28:13 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27c760sm544507666b.24.2026.01.07.06.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:13 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:03 +0100
Subject: [PATCH bpf-next v3 03/17] igb: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-3-0d461c5e4764@cloudflare.com>
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


