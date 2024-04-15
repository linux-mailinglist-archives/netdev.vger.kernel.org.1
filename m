Return-Path: <netdev+bounces-87954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 391018A514B
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5930284149
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998E583CD2;
	Mon, 15 Apr 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dyzs/HKD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D5083CB6
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187268; cv=none; b=dy9u10vNUbS65QwuFX9zs+xsc2nRp2J9kV2SiirQEWumCN17EMFaM8cyfvfVZN8LUytvbf/CGnQT6WkwgcgtGVZx+On0ESo1syhR6X4U5OQUEXzJGVvEOBJd2FIpPEbIuUNEZiJW53S9gQvPQeiep6fIkWJKAsstgJ2nsC6rvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187268; c=relaxed/simple;
	bh=5GcSjD5Ym+nqccmyQLd6LAe0ImS79AgIRrEIxO96ny4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kpp8MRg0nlNB5O/fSSlt7bM9Bp4FqUH0ZOm3OZKVcaWZ8OHwngglxLXPC2rBGMvlEU3zeHKJcyp13ZwzRBHoFpxGN8JlamvoHBsdwJz+8mr80HZ76HBKbMNuoVd2zT+4ZPeb+49n234w9RJUOfuFpHzWdpLMgn/RDKB3NFuJo28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dyzs/HKD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-618891b439eso49545577b3.3
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713187266; x=1713792066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9w4FpwtNbIZ1f6iZyUM+W9GcBTruH/kwzNUAVqphXM=;
        b=dyzs/HKDBbpZo6PDSlO24h4v2dVaCMne9L9FUiivf3hhBfqCLPCZGAKWiiH9yX8LsQ
         jf7QI3bZlMGwWa0osvLnGhk8NUdKvP4lAvqQQ9JxXX19y9G2oCIFfktaPAGWgcadKgiW
         Ha+hRqI4mytz8LemPTk8fLx+kvmjBxr7S1Je5bUqmFHBAJrdiA/0rDPod0C18jO+anJq
         u8xnpW1gI900tdLNOWT71zEeA/RRdST6uDmE6Ex2x/dVHHyHwBNtz9y24ksTC5khRlyy
         5uPpPuDfOjRT3nRoEfPAVo3MZrN/kNXh9JDHAR81mLsTfKmm/6/VRti2vGzCBfU6YT/7
         I+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187266; x=1713792066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9w4FpwtNbIZ1f6iZyUM+W9GcBTruH/kwzNUAVqphXM=;
        b=Ijh77MlhAKYPF5xa10qClL00/5EL0V0p/wQpUBGKb6iaPozyhzkcQ9EpxHe2YuXN0s
         KG35QA/kLICWw1rCF2ihOfFdLIws1XgBRpyQZo9uv+xmMZV1D3vLz9mjoUVU77Ekzb5K
         OpekrLQRkI5sJsVx4T9c4lTyUXxMXle56HjTmR3pWVbdUBpmfVXMbniUDr2VbipUuxny
         c36Rq7mnxQ8+qdA1m0yl4/abuc/N/CxyHJhWmnigg/dw7G/wRyr3wALiZDBvmp1eVDML
         u3RPGY0nyXmB9ZkOZfka2uvk7EyZjJm2vOUs/R4dl9QhvydzTZYLFSkgBnKaZXmujTTJ
         q4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/3UO266FTIikQ1AjjLqhr5cCByH1C8Lh04HOX4zFL3jvSy0dLivrgAqSHURtcDZXM1u2MJiENYi2kP6/e9Es7SK7yePjW
X-Gm-Message-State: AOJu0YxhK75NT7MY2VJ5/Hbc9s7IunvpDuViPIYUi9MTOPZLv56/WkvW
	OIzxrCwXExQoclJ4iz6bJNDZpGrgVukwHKMphWFnw2cSaawRfF8xjBz6J1Q6EGe/y/SJ9Y7T9Zi
	lc0stvKUD7A==
X-Google-Smtp-Source: AGHT+IFg7Diji1Un3wK6mnePZN7mYKBF/w2QVgvNxbwfAWtYTIdkaHyIM225wdh0ul7FEpqZHuHN+k/uhwHPHQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:d17:b0:611:2c40:e8d0 with SMTP
 id cn23-20020a05690c0d1700b006112c40e8d0mr2536454ywb.3.1713187266160; Mon, 15
 Apr 2024 06:21:06 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:20:47 +0000
In-Reply-To: <20240415132054.3822230-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415132054.3822230-8-edumazet@google.com>
Subject: [PATCH net-next 07/14] net_sched: sch_ets: implement lockless ets_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, ets_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in ets_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_ets.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 835b4460b44854a803d3054e744702022b7551f4..f80bc05d4c5a5050226e6cfd30fa951c0b61029f 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -646,7 +646,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 
 	sch_tree_lock(sch);
 
-	q->nbands = nbands;
+	WRITE_ONCE(q->nbands, nbands);
 	for (i = nstrict; i < q->nstrict; i++) {
 		if (q->classes[i].qdisc->q.qlen) {
 			list_add_tail(&q->classes[i].alist, &q->active);
@@ -658,11 +658,11 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 			list_del(&q->classes[i].alist);
 		qdisc_tree_flush_backlog(q->classes[i].qdisc);
 	}
-	q->nstrict = nstrict;
+	WRITE_ONCE(q->nstrict, nstrict);
 	memcpy(q->prio2band, priomap, sizeof(priomap));
 
 	for (i = 0; i < q->nbands; i++)
-		q->classes[i].quantum = quanta[i];
+		WRITE_ONCE(q->classes[i].quantum, quanta[i]);
 
 	for (i = oldbands; i < q->nbands; i++) {
 		q->classes[i].qdisc = queues[i];
@@ -676,7 +676,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 	for (i = q->nbands; i < oldbands; i++) {
 		qdisc_put(q->classes[i].qdisc);
 		q->classes[i].qdisc = NULL;
-		q->classes[i].quantum = 0;
+		WRITE_ONCE(q->classes[i].quantum, 0);
 		q->classes[i].deficit = 0;
 		gnet_stats_basic_sync_init(&q->classes[i].bstats);
 		memset(&q->classes[i].qstats, 0, sizeof(q->classes[i].qstats));
@@ -733,6 +733,7 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct ets_sched *q = qdisc_priv(sch);
 	struct nlattr *opts;
 	struct nlattr *nest;
+	u8 nbands, nstrict;
 	int band;
 	int prio;
 	int err;
@@ -745,21 +746,22 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct sk_buff *skb)
 	if (!opts)
 		goto nla_err;
 
-	if (nla_put_u8(skb, TCA_ETS_NBANDS, q->nbands))
+	nbands = READ_ONCE(q->nbands);
+	if (nla_put_u8(skb, TCA_ETS_NBANDS, nbands))
 		goto nla_err;
 
-	if (q->nstrict &&
-	    nla_put_u8(skb, TCA_ETS_NSTRICT, q->nstrict))
+	nstrict = READ_ONCE(q->nstrict);
+	if (nstrict && nla_put_u8(skb, TCA_ETS_NSTRICT, nstrict))
 		goto nla_err;
 
-	if (q->nbands > q->nstrict) {
+	if (nbands > nstrict) {
 		nest = nla_nest_start(skb, TCA_ETS_QUANTA);
 		if (!nest)
 			goto nla_err;
 
-		for (band = q->nstrict; band < q->nbands; band++) {
+		for (band = nstrict; band < nbands; band++) {
 			if (nla_put_u32(skb, TCA_ETS_QUANTA_BAND,
-					q->classes[band].quantum))
+					READ_ONCE(q->classes[band].quantum)))
 				goto nla_err;
 		}
 
@@ -771,7 +773,8 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct sk_buff *skb)
 		goto nla_err;
 
 	for (prio = 0; prio <= TC_PRIO_MAX; prio++) {
-		if (nla_put_u8(skb, TCA_ETS_PRIOMAP_BAND, q->prio2band[prio]))
+		if (nla_put_u8(skb, TCA_ETS_PRIOMAP_BAND,
+			       READ_ONCE(q->prio2band[prio])))
 			goto nla_err;
 	}
 
-- 
2.44.0.683.g7961c838ac-goog


