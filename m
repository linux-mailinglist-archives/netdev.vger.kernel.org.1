Return-Path: <netdev+bounces-240690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC85EC77EEB
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE8534E9979
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531DC33C50D;
	Fri, 21 Nov 2025 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cmc7duB6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870933C1A5
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713989; cv=none; b=ajd5qSwYUG/tkXMRJ2H2/1I3V61hfA3U+pYkIYO+4AO9CHYlI9pmNBxfuAjqQ0Q8BDpka+C5iod0RTNcEZ1n8yCg3x4RYl7kgL1GH8169y82St744XelvLSicceVR3xr+MeLNGBZeptMkauvsBWehxSMd65e8HmUTC0oune7wfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713989; c=relaxed/simple;
	bh=XFqUHjvSLue/QWMCGsMmcrVc0elHs4WFzSTYSTFkjC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BofIu4uT2xUv++LH9pp/auQ/i7HfqyugtKY1FEqdGRRONiANHv0OBwk0bKjtsHNnAd5GAghqys24q+Bt3fsaiwFCeHpKMGxFX9tAU2Dxbef5NsEJ5ulFP63Qz8fM1c61b+fUJIuHheXjmCyzf5uR7JMCeATatCZ5u7QVYd/dJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cmc7duB6; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-880501dcc67so82393966d6.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763713986; x=1764318786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uNdhzEsBsFO6H5IIdiKTSR/LaiuSK2adJi0pugGVspc=;
        b=Cmc7duB6qTQssvCfamA17YtxLEOx3QPXDRiZ79UMb1mIZ8cbOf0sQ9U7KjIb2WiZlT
         JBdqU4jziN7JtcLHAINcx7hdWjft6p0MaTskP7v6fSokkk+lUqaYy6hR+ZVwJh1IPGSk
         FGVdEPZ6wMVZdftlClVIl4olq1MQKtf/WHxpmGvpVHSRk26aZrxaWBSSdbei2v/K93Bl
         5fI4J0OxAiO0t7GSx6qjpwK2I6t6W83HYKjOZ/HmmlYU/nioj3e6gzP6Sor0MS3GM5v/
         6iK5Js1Lmh1eKagB3pvWfYGu1aWpmgGSBawH30gRWUxLQ3VN7eQ+K+h1kaW0XSZ1M+ex
         fYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713986; x=1764318786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNdhzEsBsFO6H5IIdiKTSR/LaiuSK2adJi0pugGVspc=;
        b=gg8NfcEkxB2h2gW3wZrxL/AvYBxZ9i/pXlvgwLR0qFu8iO0/HAydFCfhrOdXVMsiFz
         pNFp52GOU9ivK1Nm2WqUuYeBUdiXH29UqM9fXY3Zpp9b7RQ9OEGmX/1p4nClVCSmvg8o
         8Z7OzV5HQrk/0qSGyC+YiSbqAAJdeLmBKHsdIdrD9evQcJXi1YMXW0lVe3Ehtej1POie
         JDVtwRWYhVrC5BltwwWUhmfGkqPvEjNXb93JLW9yY+Td2W+CjkqXBBHZqktwyu2cUNTf
         5ttMUqWm2sxssdN4GcApfr48oVp9COWDnp9zX6FI9ksgnrh77+RgCzl9/mr0iCQ9JhkA
         9T9A==
X-Forwarded-Encrypted: i=1; AJvYcCUV7gqaOIIXQ1gZvCCLXP9yRgs09cUxlku8bvAXbrfK/d/eUtXr3IcTmlm0pncA4qWP+RizOYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYC5L76JHouTG5WJwmEKwyjPrl2ZbfQJY3PZzOHMjUp7H3q+n6
	ttxEW9mdCeJ2waSlssNOv9Khmxk0e2IBDyJhzvPaUCnNdG7iqoXYG9Dtp3+gWSF6iEskvV7k6Uy
	luxpTRwROGuTEQQ==
X-Google-Smtp-Source: AGHT+IFd+jVeSYSUIaQcqjXim1UU93MqmtBL+PcI9ynj+OUtPkfMjQQ5sPtfwMStIOIyaHNOg0SITG7NitAadw==
X-Received: from qvbmw1.prod.google.com ([2002:a05:6214:33c1:b0:882:5544:5991])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:15c4:b0:4ee:1727:10bb with SMTP id d75a77b69052e-4ee58b047fbmr15999171cf.73.1763713986494;
 Fri, 21 Nov 2025 00:33:06 -0800 (PST)
Date: Fri, 21 Nov 2025 08:32:48 +0000
In-Reply-To: <20251121083256.674562-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121083256.674562-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251121083256.674562-7-edumazet@google.com>
Subject: [PATCH v3 net-next 06/14] net_sched: cake: use qdisc_pkt_segs()
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
2.52.0.460.gd25c4c69ec-goog


