Return-Path: <netdev+bounces-89029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D59FA8A9419
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D9CB21BAD
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941E77D08A;
	Thu, 18 Apr 2024 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E43GOGan"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1D87BB15
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425592; cv=none; b=MgbbnJyK2gH6ol8lzzHPb8oBDCJHiB4jXljSRnq1vvvEmeiUbieT4YnZaH8lKGUY4wiKnOItOhyOe3Q25yx0uA4CgeSydE0wKXFvY9AWIRmYQKIma1eXXJbd1U0keIe5wKm82m9B7Flm3qURlFQJne7PfJv+zO6p4xh49qsSHik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425592; c=relaxed/simple;
	bh=RrAEiqTycPvR23uJjnmgLpr6iHcROS6X7iTHehRp2Zc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SArLCTsvtxazsGv2K5OL5L/F/HW9ynXBFFFlZ4U44JnYDCoyQonOyjQh5C26UIC96xcmWOZbQyLw74ny7pYz1SgUbi+maD5NlENnbmEevXOhvHzaplsK+DEcUOXZIBxv7PheL1wgVheVgXcm/TMUSpwv16IxNZsD0edIayTnLVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E43GOGan; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609fe93b5cfso8198947b3.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713425590; x=1714030390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CpZjAKuvNjDoXx43qMPEogquDjmJ6HzWGNcLYJbWwN8=;
        b=E43GOGanb/QFiek3rmf68XqjDT2WE2a8xOB0zOopxIDwOXdAymDywru0qCyQgJLM8g
         KfPI5mqDj7usY312V0NyTZt0IUdmzqt1BWijnr+0A7QQa+t5NcWqPNYSBD3LsjeUmCB0
         e4ZLH/73cHfvZ2d70sP1326CAETTkk4mTvKagm7PH8ryLgkGSpX83sXyRoNuJBfUkwg8
         YAyF4o460/fp9Uy3U+WDeK0ykbJgnXz92S7Jj2bEYaB62bk5OsioP47NRSXzVp4wlXhx
         U2aJmDHa++cFH/Ih/hZ3Sv1KhwV3iXZwfJPXMW1g2ilE72SpntI1wzaOV54rVi/swcLA
         ZlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425590; x=1714030390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpZjAKuvNjDoXx43qMPEogquDjmJ6HzWGNcLYJbWwN8=;
        b=kf6Kj2w7aBdA5x8myASp7KRIlfeKbbKKPApvCCU9axRQaH4pP2aOlG/VGEXPUgrw+P
         pfFOQStLucQ1f+zA78/lJ5X2cYgcmX+cpPN/CNAEwHnLMM3xTNDCs7vFp1TcyIozAkn+
         D6DtZA65DYa14IRmQeGnx30hc/aqDV785C4csesYx0h2xTy8tpXvjLSw0AhYABbY6gtv
         zDD+O+FriBxxv984xu4babWnKiF8IlbwkDte1bmR/c1592WHZVSXSz3VkbU5D3CLlNx6
         0YV+/PjWjgsz3KZkqwU3x3gs2+XVXcXrblxI+yjo+ACNtHToI10rQtveBeOJ2NnOEG4W
         3C/A==
X-Forwarded-Encrypted: i=1; AJvYcCU35fjLLcj8OkAygD+j/fXMI7eSbzPaYmTVA4zEi0XSG151UhG2pLRUeXujw+0cpd7+5O+ijb6AuM3efYOVbPSsTlO5zEQV
X-Gm-Message-State: AOJu0Yyivo/xcwFYSywO2WVMjRscs2faDDXqYTG9zTb/95MLSWv5Iqxe
	2a2rRfd33dQMnk2I/mcdIbsQxZYGPkeg8Mb/6inu5nS2dS+Z8ymzelip61cKc/+inJbVbEdYZ+c
	MTGeIyvhxlA==
X-Google-Smtp-Source: AGHT+IFLhIKF2KRB7nroXxKAbixsG7ZmEMXkid7ZtRUKgbIowrzLTp6h2kJOLOWiIoXjgilVahiPCUE4ftxA/g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:83d3:0:b0:61a:e7f7:a4cc with SMTP id
 t202-20020a8183d3000000b0061ae7f7a4ccmr328640ywf.4.1713425590174; Thu, 18 Apr
 2024 00:33:10 -0700 (PDT)
Date: Thu, 18 Apr 2024 07:32:46 +0000
In-Reply-To: <20240418073248.2952954-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418073248.2952954-13-edumazet@google.com>
Subject: [PATCH v2 net-next 12/14] net_sched: sch_hhf: implement lockless hhf_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, hhf_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in hhf_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_hhf.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 3f906df1435b2edea4286ba56bab68066be238b1..44d9efe1a96a89bdb44a6d48071b3eed90fd5554 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -534,27 +534,31 @@ static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
 	sch_tree_lock(sch);
 
 	if (tb[TCA_HHF_BACKLOG_LIMIT])
-		sch->limit = nla_get_u32(tb[TCA_HHF_BACKLOG_LIMIT]);
+		WRITE_ONCE(sch->limit, nla_get_u32(tb[TCA_HHF_BACKLOG_LIMIT]));
 
-	q->quantum = new_quantum;
-	q->hhf_non_hh_weight = new_hhf_non_hh_weight;
+	WRITE_ONCE(q->quantum, new_quantum);
+	WRITE_ONCE(q->hhf_non_hh_weight, new_hhf_non_hh_weight);
 
 	if (tb[TCA_HHF_HH_FLOWS_LIMIT])
-		q->hh_flows_limit = nla_get_u32(tb[TCA_HHF_HH_FLOWS_LIMIT]);
+		WRITE_ONCE(q->hh_flows_limit,
+			   nla_get_u32(tb[TCA_HHF_HH_FLOWS_LIMIT]));
 
 	if (tb[TCA_HHF_RESET_TIMEOUT]) {
 		u32 us = nla_get_u32(tb[TCA_HHF_RESET_TIMEOUT]);
 
-		q->hhf_reset_timeout = usecs_to_jiffies(us);
+		WRITE_ONCE(q->hhf_reset_timeout,
+			   usecs_to_jiffies(us));
 	}
 
 	if (tb[TCA_HHF_ADMIT_BYTES])
-		q->hhf_admit_bytes = nla_get_u32(tb[TCA_HHF_ADMIT_BYTES]);
+		WRITE_ONCE(q->hhf_admit_bytes,
+			   nla_get_u32(tb[TCA_HHF_ADMIT_BYTES]));
 
 	if (tb[TCA_HHF_EVICT_TIMEOUT]) {
 		u32 us = nla_get_u32(tb[TCA_HHF_EVICT_TIMEOUT]);
 
-		q->hhf_evict_timeout = usecs_to_jiffies(us);
+		WRITE_ONCE(q->hhf_evict_timeout,
+			   usecs_to_jiffies(us));
 	}
 
 	qlen = sch->q.qlen;
@@ -657,15 +661,18 @@ static int hhf_dump(struct Qdisc *sch, struct sk_buff *skb)
 	if (opts == NULL)
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, TCA_HHF_BACKLOG_LIMIT, sch->limit) ||
-	    nla_put_u32(skb, TCA_HHF_QUANTUM, q->quantum) ||
-	    nla_put_u32(skb, TCA_HHF_HH_FLOWS_LIMIT, q->hh_flows_limit) ||
+	if (nla_put_u32(skb, TCA_HHF_BACKLOG_LIMIT, READ_ONCE(sch->limit)) ||
+	    nla_put_u32(skb, TCA_HHF_QUANTUM, READ_ONCE(q->quantum)) ||
+	    nla_put_u32(skb, TCA_HHF_HH_FLOWS_LIMIT,
+			READ_ONCE(q->hh_flows_limit)) ||
 	    nla_put_u32(skb, TCA_HHF_RESET_TIMEOUT,
-			jiffies_to_usecs(q->hhf_reset_timeout)) ||
-	    nla_put_u32(skb, TCA_HHF_ADMIT_BYTES, q->hhf_admit_bytes) ||
+			jiffies_to_usecs(READ_ONCE(q->hhf_reset_timeout))) ||
+	    nla_put_u32(skb, TCA_HHF_ADMIT_BYTES,
+			READ_ONCE(q->hhf_admit_bytes)) ||
 	    nla_put_u32(skb, TCA_HHF_EVICT_TIMEOUT,
-			jiffies_to_usecs(q->hhf_evict_timeout)) ||
-	    nla_put_u32(skb, TCA_HHF_NON_HH_WEIGHT, q->hhf_non_hh_weight))
+			jiffies_to_usecs(READ_ONCE(q->hhf_evict_timeout))) ||
+	    nla_put_u32(skb, TCA_HHF_NON_HH_WEIGHT,
+			READ_ONCE(q->hhf_non_hh_weight)))
 		goto nla_put_failure;
 
 	return nla_nest_end(skb, opts);
-- 
2.44.0.683.g7961c838ac-goog


