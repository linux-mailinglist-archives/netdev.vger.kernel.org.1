Return-Path: <netdev+bounces-237512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B74C4CB44
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92BCA4EA751
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A83E2F39D6;
	Tue, 11 Nov 2025 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gKqIlwRg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1BA2F39C5
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853536; cv=none; b=VLCh6texk/U/JN31qdeCzUeaqeMrnnSTAwuZzhEw0L1SyG1aHHBDG8vuSSlJ1NZlf8Tc2qIN1ZTdzPGAa8DrDT3FJ1+QXnsueRyDWswtn82gNtL7lAQDDydrZRYR7pKiEv4gPVXa/d/TdKI0FSZhvkhiB2QmIK8eY5ZhJ0BS+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853536; c=relaxed/simple;
	bh=4SEPp3Iiy3zYQteFdAXWNr2X4PRLdp6ypjOv8Y9qBaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O77VqnhKEBXRsgrq9/jrYCw2TGB+4Ykg6VYJ0s8DwRJYkgwehiKEN8ekk3v8DUEw2BdR2DD9oLaCkCDa954y1aFpDhTUydDsFtNicb3faGzbPRDd+LzVrYFBuDct98Utsu4XxdUYjvdsbN6eRzDMTJkqUzVOMGJ9fbXc4J79GPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gKqIlwRg; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-88236279bd9so105667716d6.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853534; x=1763458334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O18ud+w3pTARjn4RIOoVqdpPYyJ0NxzNU+x1I77iXyo=;
        b=gKqIlwRgckPsLPX8mV+iq02YiC5xxPNugdSuLc0MhIpM3zF/p7fWgyB3thVHgue5la
         iXXZZmB6Ft4mv58zOAFlEVihG2DRFk/hEjIbrdrm4hZmMMMLCcWx1f08yD0QRKOu3qyn
         +PaG4b80RoTqth2twgVTWcpsxTRWXYh7Zz3w9s0Jb8kHZPkCogO1cifv8bqoOfAxdVic
         IIMrOJ7TTFdVDkE8G2+oQDVBN2VWY7wnW/YlwVheDw/msvbys5LLzcr+Kcik0lmeMEin
         tPf7lJs8U5t/QJeJppfdvmCzKcdoTOw43cq7VjSCaegpDJohLFBAjKLmI5zWdWlvh/Ql
         h4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853534; x=1763458334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O18ud+w3pTARjn4RIOoVqdpPYyJ0NxzNU+x1I77iXyo=;
        b=a3sAZy7Vl4kR22LSUWlTgIybbYPcfOnyN2DsDSN045HP2fClhuUWw76whzy7pI12py
         7IjEIQ7FIaIpsxrbZ/hBtu48sAGGFIZkEV/U73byjxqAvSAty8HB9tSi+Wl6ub7n/9R6
         RKczfKpQ/E3TC/jUswLz5iurFKCIiClDL/C1jXn8w+BA8+NbW+vO1/xxxwodxk83sRz7
         wE1ac0h3O/w7wbQOsuRdsUUE1X/4NK5uPeQUU3vka0uB4g9BdV5gjXEuOQ2QJgG+hFCG
         plg09APQ0ZP0xpN2I6OMVbdwCPq1fe1wD5IY7oN6FF9cgAqHeWlXwSsGeBgbwp8StDMX
         BuTA==
X-Forwarded-Encrypted: i=1; AJvYcCWP/1OvOQsovqJDDtbkVxXSmAc2A+u525xGjv9lWHOHRpqAFFYyE4gWDpmtgj9c71h+rPJ06S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGqnQ8zKnumfDUOsgKJWHQJUBzwl//45wLraTnNVj7EeA8HVF
	w1S3wlaDLSp3ua0SJqjlTZs3C+vlk2DXFkLeKGc28tLPEjRgRB+zdUqKyTX0cQ/G48pNH007oUt
	Wsky9VAop2TYHIg==
X-Google-Smtp-Source: AGHT+IGbHAaQ1IBBzerh3OvDZ1JkqRuEJhW9z++V3um3NciH1o9gbKSiDMVc21xWKPvI2zZ46o37X8CqX5PKYQ==
X-Received: from qvbrk3.prod.google.com ([2002:a05:6214:3483:b0:882:4972:afd9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:d0e:b0:880:1fb9:a30a with SMTP id 6a1803df08f44-882385b5058mr136096536d6.3.1762853534105;
 Tue, 11 Nov 2025 01:32:14 -0800 (PST)
Date: Tue, 11 Nov 2025 09:31:55 +0000
In-Reply-To: <20251111093204.1432437-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251111093204.1432437-7-edumazet@google.com>
Subject: [PATCH v2 net-next 06/14] net_sched: cake: use qdisc_pkt_segs()
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
index a20880034aa5eacec0c25977406104448b336397..5948a149129c6de041ba949e2e2b5b6b4eb54166 100644
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
 
 	/* borrowed from qdisc_pkt_len_segs_init() */
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
2.52.0.rc1.455.g30608eb744-goog


