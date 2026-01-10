Return-Path: <netdev+bounces-248747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BB7D0DDE5
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0883530845BF
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0A925771;
	Sat, 10 Jan 2026 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HRbnXVxh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278E2C15BB
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079143; cv=none; b=ZPcaVXZ0NZ7yCPINJGkPryYW/c2edSlqNDwwBDhrOpqy4VlD8dYkGEGJadiPZ8EaGX2p+XsMws8N77omF3rxDvi5mb3eivOZB/nMZ5WPDE7etZOq9rgw9e1Jrj4Av3MgYdZY3TRTswyZY4gesJhM8C4gVKYBjeOKNvmCKxwJ0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079143; c=relaxed/simple;
	bh=I8Ub+6vTkOU9LlgcA8t80PJC7kRZceopVhWvGXoTsW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=psBI8e3dGTLVHViahcqhKY+J2Q1r4lv5Gt4NVfY6rK/8XbUlb49wcnAQYvS/3yuDgJKCnOtpjBzGf+q+paUk2tIIL43zCrlPHH7uj3CPkGE51785ysvLspKW14ZfT9oaGtl/1HPIU4WZ0VGY4Nmdl61YXiRjICrN5l0P7d1XffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HRbnXVxh; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so8934248a12.1
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 13:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079135; x=1768683935; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qhyznqsQeHYrRcXEj2wKTRt+KnMhdHylhV/MRU3QAQ=;
        b=HRbnXVxhrVlXaM3caQF3j+NNuavbVAGQQiA+S20XjUmlUoBA+6BBXT/IaD+Xa/ba2O
         g0YwJ6kKKRbPRVB5mHgzlXgttty/BY9+BU/HIQN6q4UuV3gOqqnVFxazum39VYMFS3zR
         vThQdzIhuNabBgCo2ZYkvimuzQVhbh6+/75j9M4/JOjkpxHQ7y/cganGSpeuMwHjYz48
         CchdyLRsPu6rJM7L+CrKUKcMasXNNxFF0umDF5Z9Fh42sLspaHDo7WzKsckcY6ZS5XYi
         ZX9oPgiWLedvHlf9py7MjEVfBc7fhVUXvsfv/ED7c8XFa5aNoPQRbfrJLPB/C0vs0rnM
         mslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079135; x=1768683935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3qhyznqsQeHYrRcXEj2wKTRt+KnMhdHylhV/MRU3QAQ=;
        b=qHd2Q/qXTHRRlG/1Kww/flodq9UJdpYiEEhR2X+q1py8Ze1rXu5NnV6LxNWdRVYFKQ
         qQKLswKXiW9wuuUEJpuwRs7xDpLeACC/7yjnBXtlU50zC0xJ1BI3F3nO9r8RhlIw+2ZG
         Gl/eEsF+PlqEuYDb1AvfmNtCHfryWTEV84mERWpZDf+xdggW6FAczoUsuaoQry88u7F9
         sqqGFiMf0BEeDvMQ3AzibzG0PD1qZgTyxkuFmVxzinPKGorimdlZA0B+kaPx5ZWnAeZv
         z4ZBfSmhE0jXUYmtTSc3lhf81Ms2MU4DuLYcqTAbMRPZNJ0qz7SZdhLzl+HQbp4xIqUD
         jE/g==
X-Gm-Message-State: AOJu0YzbssZFji6ztvI60H+k/wOMAacI7TEiWAGgXdt6gtyIeFFLVXPH
	WEdSO102/+w6MsP80Uc6HbwdhKJWpHRQxUD+bBKqt/Q1o5ADKAliLwHJxANaquYpd5M=
X-Gm-Gg: AY/fxX6MVMVdWnJMTblzF0mZeXOBLzFbAQfL3EYF6iUahybJgHkWXnn0XXH5o3ag6fn
	U6zk5RVOuMJ/I5nbXaVzB9TBQvi9uPlkmbB92jEFRsAXdI45TPC3/visWB+b5RT+lexoJ9zpdSF
	UagBbfKaT3sSMQ2Ov4GeXCF+MTaS+1QylQl/OxIn39p7VDqKIo4nt6VLMknALTS66KnHOh563kP
	1zN9TMsMXbfoMnGf6b9ZD4j7Uqo8v88UzX9yxN6cH35q2VsoEngb15oxnrPvvYS9zleIIW3Wn3m
	+clUxNK7XpjeUDwbiojqeWPFSC5lIAwkOTf/P4gbeR6kmnAoHyNlJbc0NA6gACsEcwo9uDE2YvR
	+YGR5Rkk/rvD1JrPzZupE1cZ488VL4WxK70QIPFtt7+d5zYU+bKdegvZM5rAyffVo4zAfHjL/r+
	4f9CFP7MgmluQPxfwHNvpb2T3eDnDm0FjJ4OM+DlNWEG4CaTu0nKVKrcMDf9Q=
X-Google-Smtp-Source: AGHT+IHEj3UjKJezXJmgXkOXIgfXnXeUfZzoN/s16lHRjWyrvzci193qQh2S6+WItUf3e13YEOGqTA==
X-Received: by 2002:a17:907:2689:b0:b83:972a:6af6 with SMTP id a640c23a62f3a-b8444fa0b03mr1257356566b.44.1768079134594;
        Sat, 10 Jan 2026 13:05:34 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a23432dsm1467488166b.11.2026.01.10.13.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:34 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:23 +0100
Subject: [PATCH net-next 09/10] xsk: Call skb_metadata_set when skb->data
 points past metadata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-9-1047878ed1b0@cloudflare.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org, 
 bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to copy the XDP metadata into an skb extension in skb_metadata_set.

Adjust AF_XDP to pull from skb->data before calling skb_metadata_set.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9100e160113a..e86ac1d6ad6d 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -768,8 +768,8 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen > 0) {
-		skb_metadata_set(skb, metalen);
 		__skb_pull(skb, metalen);
+		skb_metadata_set(skb, metalen);
 	}
 
 	skb_record_rx_queue(skb, rxq->queue_index);

-- 
2.43.0


