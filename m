Return-Path: <netdev+bounces-89024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 942518A9414
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC28B21D76
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58847A15C;
	Thu, 18 Apr 2024 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RPT0ziME"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D2F6CDDF
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425584; cv=none; b=iY3Y+rmD+8bc/aWHEzbz684HEqFwSmGjRWe2jkfzp3sFFCLr8ZK1IQfXMwtO5F1BWrcu3vjGzYLH1dX4keuBX1R5ICpQV+KcalT/AdXD2DibAZuPOtIrIJAdAMgbThS06Hh/R4Qzbu5dwU4m6XdCD4rWUrV8hrVgKT+cXVw9yO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425584; c=relaxed/simple;
	bh=Vmkft94CeXm1utOByhhbQk2dGA/tV6M1rzjjDE+0I8c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o+kxfpvtCgsRn8qNcbRzDwPbcrv8wP9uXXC7gAPXJYgaWIOS8BUFArXILLwqgy42Lz1NPT8AfoDDUh+VE5tmhDR771JacB09DcuZngZwARG5zpVeI0WjHKLzf95tLzFgLqUXKJKIPSfdS0xboIBGyRsJlaaI3kpM6vSV4H5tCoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RPT0ziME; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so1338647276.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713425582; x=1714030382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ6xGx7SCL04/2YLzMv5yVEEGM7jH9ixgUc8FyaXnxA=;
        b=RPT0ziMEuVv/5m40w3bN2j2W8Mi4BaQdqc/SJDe3jXP6r7rOOLvkmIOejwaP6h3NFC
         p5dusf2AgrrHmSPirNUof54oz1RTPXKJqkzdrSfjucY8z/K1fliBsZuyIz2dCQehmIHS
         h7LEdJmWZQbEAej3ErGXlvfkgW/YxDt+Sp9RbyOC7I0ntPejI+ESUKxueXLdcwjDnZJr
         nQID7UrBAT9eQ5tV2GwaTMNX40xt+sVoLgxJh3+B/TYTuK1aiz14/Hm017j1LTAfu/Tg
         Zu1zW2VQ+aDDBt4TYkQMKORUXi/KCMyPjh8lhfcxZ5kRtBq0FkEOy86aNzQbq6NuLbUd
         Q4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425582; x=1714030382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ6xGx7SCL04/2YLzMv5yVEEGM7jH9ixgUc8FyaXnxA=;
        b=Che5TmVSu/XcMfxYrekK6VNQ9Vj05jVhoNzHhBXGXRRm/vXvV9KS1/VCq8mcSIeoqm
         dofsImYBP18/3OOdVk8/codDjWvadNpkdaV+XSjpZslPdiatIMg10pY4A1z13JaqwlJb
         ihaUNC3C+/2ylfFSVwkykN1tvOhM0dEyCE7DBDGyEP/thCenE31H6wx58/qX8IrFXYfy
         7Q4WJzPp5IRJVEWT76tzpPRVa5qXKqZrmX9jGivVIvjB6RVvQPcZ1+MI7z8GbT5KPb+E
         0fbqmpJhor+C1cZsB1ruv0DDgrUTrnFedGIg0MTVWizDCTR1LG8AgYIH1fgee+nkl90F
         VmGg==
X-Forwarded-Encrypted: i=1; AJvYcCW4Q4Ms/P/07uNaG4lvJvHoLVy7Vi5vAkjQR7H3Y/q5utqpEBJZk/Lrl49JxY5VSuB2mk4kvTGLA4zThv5L6WJerkmxzCPW
X-Gm-Message-State: AOJu0Yzw0WQyp67GPeqo9sGITmXyQYbNHEMygK/dV7B8uEAmhtalvLHa
	1gNvk6MMHMSExs29sxdkhXVbhwGKxaY6Xqri8BuKNFIJJnPkvaqXb83mQ7V7TyiwOs8jHdf9st7
	6dKetjqGTGQ==
X-Google-Smtp-Source: AGHT+IEOysJ/o2JBt8MpjJNm9RKDrsiBVxPKyHFe5ZUYV92MyyJUCqpq9VAa9N2e7j7ZoIutIhPrJs5UvToKXA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:c0e:b0:dc2:550b:a4f4 with SMTP
 id fs14-20020a0569020c0e00b00dc2550ba4f4mr511441ybb.1.1713425582523; Thu, 18
 Apr 2024 00:33:02 -0700 (PDT)
Date: Thu, 18 Apr 2024 07:32:41 +0000
In-Reply-To: <20240418073248.2952954-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418073248.2952954-8-edumazet@google.com>
Subject: [PATCH v2 net-next 07/14] net_sched: sch_ets: implement lockless ets_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, ets_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in ets_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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


