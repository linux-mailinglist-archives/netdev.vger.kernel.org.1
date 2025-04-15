Return-Path: <netdev+bounces-182534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D057A8904C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83364189714B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA4C849C;
	Tue, 15 Apr 2025 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="JhmHsfTC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FBD4414
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 00:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744675417; cv=none; b=R2+ukx5DOEw/l72UTLxeNcxqPceKSZIqH8FE7C5lzBbSO3hDDjyTn69JpzLi264kPNIaO4CfhVCNSYcIppTBfD+zxQsqB0UG1GCaPqWsWfgMpcIDohnrLDJFmNGfnUkOInCpnf5jbVVxY4jWPWU6VPTIjbE7svhwk8YVxk4J1/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744675417; c=relaxed/simple;
	bh=mGM+U6Ab3pcLgpbn2ls0PvUsPn6LL9K2qy3oUk6Kabc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvkfNMCkn8TnqpjqZ6gKN/ixf295Lmz4xkTGEiz1H4VlHz07Ay1W+NF9a2if+HxLPPjzHy0qpomnUBXyY9eqJXw7D5tCZ/BnADB1oWcyKHpVaWFb3ZH7kJsSZ2lBaqbI2oDbpl0QcKiBxeodjPix7OUNhLDeFeJFXHdHTvm6CwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=JhmHsfTC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73972a54919so4138341b3a.3
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744675413; x=1745280213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rnc9keEx/KQrSRBqTQY5ZIEv+apf5oShby/Q9Q6vEY=;
        b=JhmHsfTC4h1xzoS1KActhrhNTOn42+BiDXGEfEYu6Egs1u/P8T8rHp+vvZLEVjZBl+
         Luyp0bTYZbDVII3G0HUyTNRgzdb0Ln80v6J0r8R/3E12x2HYz6nVEYsVt67dxob4FvTv
         3bPTITSlOkBFmGadVXKArkhPUv0HozHh/dTb1tKeodkfYh6Te1KpS/dTI8xBIwQ1HNpf
         8NFZLiODn7ELtUqhGpFAJrqIb0PT24mv6rPloJ+UBS+2ZQQ6P6DSHWWnSYailMzJp7qg
         zQjhc9iVlVUQ+f97u3mEgXfhhvWGt1YLK2clRlqyPpw/Wsxucc8YvfYOuasqJpOS80cF
         JiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744675413; x=1745280213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rnc9keEx/KQrSRBqTQY5ZIEv+apf5oShby/Q9Q6vEY=;
        b=bAnIDEpSvvZZpWSa27AbrHhOnc0fFDFpQT2GpBiZzNIWYf8S4q67j8RghdfQQnMj5l
         dHv3pj8BB28JP+O3pM6DOQPDfhOFAYPptZTTUxtg9fiPTVBuE+T9DcU3eiQdYx9zzyGO
         ae2kSGIgYh64Qoj0zphHzJsGHjtUcQeHKbzBdjYWb7YQRHLWc18V5gHpFXdGGYJGHBEY
         ntaPtcWHsQG/fSKuIXOBD5SgQt0QZguqlVdhJpwfkeTCIo7ME9PyTiqi+exFsjVKzy+l
         rg2oYiWGWOS5uIj1lLIaRVPDsAVChSGf0za5HWQ8Y6zNna7Y264kstAx6Sud3IC6UD8y
         8ctg==
X-Gm-Message-State: AOJu0YzTYesBoU/MmokKkKJd8x6q6D8FZHr8ysSeTaPwNJ2lBONOTWog
	AY5PJRZQPTr55C57MdG4Bwzqn8A+3JkMalBL+GGKU4kyR8TF2lbSppGoXP+bW6SabVmwIASpAJw
	=
X-Gm-Gg: ASbGnct6XCoMmMhaD7qv3dFzIjWZ7j2rLQ8apHZoiXmJ75ROX8ZEPriNxCr+FMPQTP7
	b8APkdM9vET8Wae/e8Mh/cTtDbdxSlB2T6O/GZpT/pvrqnlZcD0FuTlLJl8ydhVSRfZOq0Foo8H
	o+eLb+hDVysftJqdimE5kDvU9B6D7fD8DA9aIT475v/2KiwDHskwtLRyMKcuycCexbN+454/ICb
	aGFvs6y/NuhMeuBxA61d6foN8RQa763cRoIIn1Eau0Y044lgX2+1jp2HhPiASma1U+ajnhMJGMk
	OpIvzm4qAj5cQ+dzgPqgUc2vRhDuZnO2NccWq4y/IBXQKifcqEw8wHaO8g8CMT+p
X-Google-Smtp-Source: AGHT+IEAFDUjEzE+Jtk18z3pHCBwwjd7GZfCotnKQa1TL1iS3y+7X/aLZUr5p6ksgwOAV991hv0WHQ==
X-Received: by 2002:a05:6a00:8d4:b0:736:3fa8:cf7b with SMTP id d2e1a72fcca58-73bd1202d50mr18136654b3a.13.1744675413449;
        Mon, 14 Apr 2025 17:03:33 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c4db9sm7445615b3a.58.2025.04.14.17.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 17:03:33 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	gerrard.tai@starlabs.sg,
	pctammela@mojatatu.com
Subject: [RFC PATCH net 3/4] net_sched: ets: Fix double list add in class with netem as child qdisc
Date: Mon, 14 Apr 2025 21:03:15 -0300
Message-ID: <20250415000316.3122018-4-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415000316.3122018-1-victor@mojatatu.com>
References: <20250415000316.3122018-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in Gerrard's report [1], there are use cases where a netem
child qdisc will make the parent qdisc's enqueue callback reentrant.
In the case of ets, there won't be a UAF, but the code will add the same
classifier to the list twice, which will cause memory corruption.

This patch checks, in parallel with the qlen being zero, whether the
class was already added to the active_list (cl_is_initialised) before
doing the addition.

Fixes: 37d9cf1a3ce3 ("sched: Fix detection of empty queues in child qdiscs")

[1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_ets.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index c3bdeb14185b..b62aace5bc46 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -74,6 +74,11 @@ static const struct nla_policy ets_class_policy[TCA_ETS_MAX + 1] = {
 	[TCA_ETS_QUANTA_BAND] = { .type = NLA_U32 },
 };
 
+static bool cl_is_initialised(struct ets_class *cl)
+{
+	return !list_empty(&cl->alist);
+}
+
 static int ets_quantum_parse(struct Qdisc *sch, const struct nlattr *attr,
 			     unsigned int *quantum,
 			     struct netlink_ext_ack *extack)
@@ -415,8 +420,8 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	unsigned int len = qdisc_pkt_len(skb);
 	struct ets_sched *q = qdisc_priv(sch);
 	struct ets_class *cl;
+	bool is_empty;
 	int err = 0;
-	bool first;
 
 	cl = ets_classify(skb, sch, &err);
 	if (!cl) {
@@ -426,7 +431,7 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	first = !cl->qdisc->q.qlen;
+	is_empty = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		if (net_xmit_drop_count(err)) {
@@ -436,7 +441,7 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	if (first && !ets_class_is_strict(q, cl)) {
+	if (is_empty && cl_is_initialised(cl) && !ets_class_is_strict(q, cl)) {
 		list_add_tail(&cl->alist, &q->active);
 		cl->deficit = cl->quantum;
 	}
-- 
2.34.1


