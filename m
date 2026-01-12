Return-Path: <netdev+bounces-249126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C29F1D149C9
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40A5130012F2
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 17:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1237C37F735;
	Mon, 12 Jan 2026 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGxkZMXM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4137A37F725
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240623; cv=none; b=TpOoF+JKe/AXZmsRl9ytvsOiYEgI5u5gkV91mbc/MjKySyyS1WKleMv/QSTyp/wVPZ0gyAThOOQpUF40wDprc2gYVHA9csbM/GOPFYm2lsAknhvqbzqXeb5LJOtFCq58UJFQ7QLAG5R/7UJUkh2gRWvAyJ2PwzHJGdPfHGZrs1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240623; c=relaxed/simple;
	bh=tKr2FdRogJffKsB3IlkDbY1H3YduCuEHvm2MLB0EOls=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T9Ge9moA//XoK5IS1ivFkL0PKT8vBkKcU6qwHS8MFM5AmLpjvrboMRqsHwOmeG1tAwqpK7bELI2ndA9poLA3jyfL5KkaB2Pke/SXAr+769CzaIR6AOZ/xuFlOmPc/Pm7GG/0lKTHVRXlq7uQpUyT9MwtgSsJ2TKE2BWjv6Am/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGxkZMXM; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8bc4493d315so1747565885a.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 09:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768240617; x=1768845417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3+ahmaFQ98g49bOkW5FkCNIljAYXXqxbUcNrvFuXn6Y=;
        b=uGxkZMXMWw8IPUf30WLy+bYghd9V3cwA4BruJgaLNW7jo00mltPpQZ+81hSNzi4b2q
         f7DgGmtzpBi7ZQFVClpOpUz3K9wUvD+MUr8fdwHxfsSC61gu3Mgzn028tgSQaCStliGI
         nO7f5zEnZIVg5Aow16LQoOgoIeiZ/h6QIiQvpcDwrFAOEhIE0w96xhuS6KYAGYUK8uZW
         4RYfLh3ieU5ct/Yx22tZDb30kD7k1qrP69CKEBlDw12oqUv1AGR0wqe2s8ikTCDnhhxa
         Pwjc8+BWL/G2oob8GeZH2Sqg576DPPRgXHhaUPMq2MenXIpf1gDicJ4cAt4kM2YpSWHg
         CMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768240617; x=1768845417;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+ahmaFQ98g49bOkW5FkCNIljAYXXqxbUcNrvFuXn6Y=;
        b=TQlCaHWcerSKd8ekXRviCWgubGJhzkqDDCLvwjHcDUvAoaPvorITf8Tby4vMGMdgjY
         lwddke/rWBktA5st+LlGCS5yvaJ3PAEjjYFiwOE2I0GGJCHjMOIzbwp5mH3SGpVjCCNX
         kgwAytkFclnPlZFKtCqe7gIGSjbFOEyqB/vyXndn/i1UcZBj5eYv10ViVFey8rLQP5X9
         N5Pj7OcpaqQoXlvQzcefL1B5/ZxUqRYSPPYhKhyd+VYO0MuSAlyACOuNNSN8BBJVWimx
         vM8HSZgYXwEVHCfTtHgYdAUnbj/+9LBi/adCvzRKz39tkPntAJEcN26SE0/UvD23X0so
         fyXw==
X-Forwarded-Encrypted: i=1; AJvYcCVtTqo4asIjilibBDmYy5frh9rJoNlHWmMw2+8UMqDE9TrF0bon9KWKwfjyKAgIzhXCM8FNpcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWh9BgEugr+gEsVvnoWbEZxthgUIsoI/9GC1138+wQZ/ubv03W
	4xqwoR0sm6XSzwHrGJ39SbhkP+kFDz37pAQJtxmJ3vadBJ6LOiPN5WOG2TywkQeJrJ3iMLCfMOc
	u+iPflZkgVpRnYw==
X-Google-Smtp-Source: AGHT+IG/A7InCQZSyZOn/w+vECl+4K5n7JT7vKbhnd6ZYyvks5/3pjWu2xYeIIxsfnJ4Bfs6q5mYhM/nTKhQww==
X-Received: from qknvz23.prod.google.com ([2002:a05:620a:4957:b0:8b2:f30c:77fe])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4141:b0:8c0:e5ad:adbe with SMTP id af79cd13be357-8c389423dafmr2462507185a.90.1768240617625;
 Mon, 12 Jan 2026 09:56:57 -0800 (PST)
Date: Mon, 12 Jan 2026 17:56:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260112175656.17605-1-edumazet@google.com>
Subject: [PATCH net] net/sched: sch_qfq: do not free existing class in qfq_change_class()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+07f3f38f723c335f106d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Fixes qfq_change_class() error case.

cl->qdisc and cl should only be freed if a new class and qdisc
were allocated, or we risk various UAF.

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Reported-by: syzbot+07f3f38f723c335f106d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6965351d.050a0220.eaf7.00c5.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_qfq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index f4013b547438ffe1bdc8ba519971a1681df4700b..9d59090bbe934ad56ab08a59708aab375aa77cf0 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -529,8 +529,10 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	return 0;
 
 destroy_class:
-	qdisc_put(cl->qdisc);
-	kfree(cl);
+	if (!existing) {
+		qdisc_put(cl->qdisc);
+		kfree(cl);
+	}
 	return err;
 }
 
-- 
2.52.0.457.g6b5491de43-goog


