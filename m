Return-Path: <netdev+bounces-237131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A91E7C45B41
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BEC1891934
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ADB301474;
	Mon, 10 Nov 2025 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8+0RiMP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CD030170D
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767931; cv=none; b=g9kXqoTiODZ6eD8hYq4Dsw1KUKcgXLmmin/iDHN1aPik/92Xhzf9W8zwnBwrZbLDQ3nFA17A/0GIZ97/3XB6X/KuVyQjifHfJMbGH9qZdAgEvC0YVugmRmcgvTQJDY9iKw/3hyZ6ITNYWGDAX6gAsJS5n12ucYeSOtNDIomQH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767931; c=relaxed/simple;
	bh=MmkVIj4n0upJLodoyrmJum6NFdWY5A4EQ5wYiKhZqvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lv2XoKyEAsmsDUNPX0pegoI3lw4Li1TTn38NnaDvMpIR76B4FZPbCEgqLoN/8Kl2rV7QnBQ5wZEUj9+hU1dV+WFu6enXhPreznG1ZKsqUilyBIJPjpzLgnDtGY3svv3vKRn39MchVbCoX5nhFr/u6p2cCpa42GDXAFNTja/IleQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K8+0RiMP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-785ebbc739bso45783277b3.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 01:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762767929; x=1763372729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lPs1WIklJtNt0Mkkj3RC31St+eogTaHxBurdW/y8Dpg=;
        b=K8+0RiMP1tBy5PS6kN5+YQzd/Unp05gUitKY57u7pzeHkROXsTeffIL5JtgU3a/TBQ
         fgq+HJawKOCwLsuvZsWHzcF3vsvAJ8fFvI7e9dt+b3/SBOVcRQ9LbRS9YxbPma2f/LRJ
         /FJV+CofJivlBdJiY+4Q0OLd/E1jEsv9+AYAp+u84Ss69NmBvIX82NVB7mRfC23CvgBf
         GKIzlpyB90dfzGh22Bddciv1dGRlCubqd6JRUL93xWLg9Vn6xy+j9kdSsK0Q9U/pjRCB
         GA7T7bwyWT3nCoXEH1warTDHIiWdq1iOZMKZ/EX4isdGRlr3kZ28vZrTd79pJF/+cnAY
         t5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767929; x=1763372729;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPs1WIklJtNt0Mkkj3RC31St+eogTaHxBurdW/y8Dpg=;
        b=agjMZ/PoFwxt5izhTFGf6svlPh6SpcqYFcR80ZVQ/SyLdOO/uRc75drxnHlgSNI3y4
         Ydq31a2ZNGF7vjBh6RkHj9lAm6PT/32QhVE/3IVqgALBOkUQatO8xhm5cmDf0Zlw2Qy7
         +HFm5Mylm4q/m201a5iEbb3kOJfu66iRqim5359Vo/kFsv5BFdN+aXpQs9cRADtSaLLL
         P3Okz/ImykzLAYqakCQNMwplq6ojOLAUV3qfR+tCoau9Nbwim92ahczDi3YZXN9yDosr
         wMFecCBmX/2SIREvJhOVwdaNERchm+V/YtmgcTCfbYlnjxKoKg1MtzaJeRVaVxCG0lvb
         C30A==
X-Forwarded-Encrypted: i=1; AJvYcCWB8BnHgihcusdEgKjVlFe6hQpmSwd4J4Vz3opICdcML7Nt4wW9OP7hd7dPIJQiEgUJLrggSx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiJL9ROKwSKr1bZpAMfAbsgLhtCwElGVA//c7Y2VyHHvkBse4W
	O36pEU8odSOehRQDnVykCpOK7yDI2kxKzWVK45X2L98gvF1bz6zlzv3LWQeOHhm21GIffAATI/y
	Iq/F/06Z3Ra/pKw==
X-Google-Smtp-Source: AGHT+IFeG6LxQwKjuhQAS+gdhdQXkfrlV+55iTnVPcX70jP1vScYsvTmEh5/VJ9i1CFOmhzAbgcXxrSZ3hJBYw==
X-Received: from yxak7-n1.prod.google.com ([2002:a53:c047:0:10b0:63f:a7b9:3d4c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:160f:b0:63f:b4db:91fa with SMTP id 956f58d0204a3-640d45426ffmr5912595d50.15.1762767928964;
 Mon, 10 Nov 2025 01:45:28 -0800 (PST)
Date: Mon, 10 Nov 2025 09:45:00 +0000
In-Reply-To: <20251110094505.3335073-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110094505.3335073-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110094505.3335073-6-edumazet@google.com>
Subject: [PATCH net-next 05/10] net_sched: cake: use qdisc_pkt_segs()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use new qdisc_pkt_segs() to avoid a cache line miss in cake_enqueue()
for non GSO packets.

cake_overhead() does not have to recompute it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_cake.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 993ce808230fb7d4769c926f6c8368d927f5a45f..312f5b000ffb67d74faf70f26d808e26315b4ab8 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1398,12 +1398,12 @@ static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
 	const struct skb_shared_info *shinfo = skb_shinfo(skb);
 	unsigned int hdr_len, last_len = 0;
 	u32 off = skb_network_offset(skb);
+	u16 segs = qdisc_pkt_segs(skb);
 	u32 len = qdisc_pkt_len(skb);
-	u16 segs = 1;
 
 	q->avg_netoff = cake_ewma(q->avg_netoff, off << 16, 8);
 
-	if (!shinfo->gso_size)
+	if (segs == 1)
 		return cake_calc_overhead(q, len, off);
 
 	/* borrowed from qdisc_pkt_len_init() */
@@ -1430,12 +1430,6 @@ static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
 			hdr_len += sizeof(struct udphdr);
 	}
 
-	if (unlikely(shinfo->gso_type & SKB_GSO_DODGY))
-		segs = DIV_ROUND_UP(skb->len - hdr_len,
-				    shinfo->gso_size);
-	else
-		segs = shinfo->gso_segs;
-
 	len = shinfo->gso_size + hdr_len;
 	last_len = skb->len - shinfo->gso_size * (segs - 1);
 
@@ -1788,7 +1782,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (unlikely(len > b->max_skblen))
 		b->max_skblen = len;
 
-	if (skb_is_gso(skb) && q->rate_flags & CAKE_FLAG_SPLIT_GSO) {
+	if (qdisc_pkt_segs(skb) > 1 && q->rate_flags & CAKE_FLAG_SPLIT_GSO) {
 		struct sk_buff *segs, *nskb;
 		netdev_features_t features = netif_skb_features(skb);
 		unsigned int slen = 0, numsegs = 0;
-- 
2.51.2.1041.gc1ab5b90ca-goog


