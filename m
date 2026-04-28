Return-Path: <netdev+bounces-282011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENgDBdrq8GmBbAEAu9opvQ
	(envelope-from <netdev+bounces-282011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:14:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97948489B80
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F03831464D5
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A31E37F8B2;
	Tue, 28 Apr 2026 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GxZ01DAG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E9337F014
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395861; cv=none; b=fUBEN1OuruvkSQ4FxwmizpWV47WHLx1zbcrbfRQ2opA3lqK02M95jWIOLVY8XmpKASi3gPlk+XIfJWvvCi8wEgF3ljka/vXJXw8WM6rX/R6in7l3uUbaeEcDDS1UGqcifiW3FDT2rnfihvZvnXwbkj+wvVKEYzFJdk1lBTjGnVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395861; c=relaxed/simple;
	bh=7A2RTAO1vCMQzh9X6fi6pwsBr0zbFETbvkfBJKkLZlA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HIhJVr+q8HKKzXzGvX3+yyKT2uMvUZMEuhcYJ8KtAgqQfysgF7OPQQtbklW1mNCmDL2mZwoFG5nbaoR8WCzwko9lHCR26bVYIR9zhafUSY+uRpLfR59zQHR3N+/GLjVhaa8eacLpI2++TQvT2jqH6kNJWR2qEtaLYWZmvKrdnTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GxZ01DAG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7985951fa83so292138177b3.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777395860; x=1778000660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZWwt6zOBMPtP6sQuMfSc4hvexqrhZskEJYlUMoZdIQ=;
        b=GxZ01DAGfnmhTviJ7jFfXBtw/v5D5pitRk9iWh2DlTxNXsWJDYqsGj5/YkmyEET597
         +Qjqg5iPePOdwP6QPMsioE35d10ESEwrsLfVyHas4nhh3t9VIJ6u+JKRgnMN1IEA8Ytj
         Wz14yhKb6LoNUFbd4LsVxHVnuXvjJ3uovpkiH5YJxzy4fvZxyFgZosvMgf/y3FD93WCN
         IxlufXwd25K7YK8wkA76qgBvT4+YuC6MWehXGc96jQy9ZnuHH2VjCAWX+k47UTs11vXf
         DA4Z5eVkgNf5ESKriIsbT/yC9xMjPZqar2SKI07t4t3pCnnoheA07N6T+WYkWcw0m74k
         xOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777395860; x=1778000660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZWwt6zOBMPtP6sQuMfSc4hvexqrhZskEJYlUMoZdIQ=;
        b=KfTgRxgNqHScGpvuu6cQaKJTJM2NYwNboTx2IZ8/kJqtgUGlu358Ete09GKl/AVlUZ
         kbtDxv5W1tCfT4MeoCxkikuyUTZV46ct9v6wTzlJBBHG0cGy+aVUeYV3OL8cCPtIMZZo
         uq0h5C9jfPqfk+FKHtmDu5vVpPJiGFl+/vvQ0oCGgzsAautfBFJLAjPmJ/8tj8zscc7Y
         qFKG5MVvw4aIcr5+rEgaHhpNmin5FBVeVRmDEK141GjGQXSZxZb1t1GNzXiVWiCvC8pI
         t63BqYjP+gbMmhBmyhZzPWjUdwoI4w4BZje1d1V7j5tFOq6/1uXSChvTLF/WtEIlzER/
         khKg==
X-Forwarded-Encrypted: i=1; AFNElJ84pOe4URvESbaxmXMAJzLNRHEy4UuigUrz7q0atl5SZUPe2HQoRCg8ix6EU3pO41ITDEekhgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgMb2fIlcpSEdxTkj3BTEzVmp1zy7T3a/gp2xBz2c8OHQM0j5I
	Asuz7a6V4ed7kdrJTSAj+WZftPmJ/MSMM9pKx5SRpmIrnXSyzSeqBm0Ims6hOYLzdX3hIr4GcrR
	OBQYcwitgOJbCxQ==
X-Received: from ywbmq2.prod.google.com ([2002:a05:690c:5882:b0:7bb:be9:4d6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:660c:b0:7b3:9f53:9374 with SMTP id 00721157ae682-7bd1d378604mr4704237b3.3.1777395859433;
 Tue, 28 Apr 2026 10:04:19 -0700 (PDT)
Date: Tue, 28 Apr 2026 17:04:12 +0000
In-Reply-To: <20260428170414.250566-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428170414.250566-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428170414.250566-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/4] net/sched: tc_dump_qdisc_root() refactor
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 97948489B80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282011-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Change tc_fill_qdisc() to return -EMSGSIZE when skb is too small.

Change tc_dump_qdisc_root() to propagate tc_fill_qdisc() error to its callers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_api.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 32ccd4672083aa19340520155aeba6d8b6ff546c..029e0f87ea9c61cc757432a07a6af92c90c551ef 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -976,7 +976,7 @@ static int tc_fill_qdisc(struct sk_buff *skb, struct Qdisc *q, u32 clid,
 out_nlmsg_trim:
 nla_put_failure:
 	nlmsg_trim(skb, b);
-	return -1;
+	return -EMSGSIZE;
 }
 
 static bool tc_qdisc_dump_ignore(struct Qdisc *q, bool dump_invisible)
@@ -1836,11 +1836,13 @@ static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 	if (q_idx < s_q_idx) {
 		q_idx++;
 	} else {
-		if (!tc_qdisc_dump_ignore(q, dump_invisible) &&
-		    tc_fill_qdisc(skb, q, q->parent, NETLINK_CB(cb->skb).portid,
-				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				  RTM_NEWQDISC, NULL) <= 0)
-			goto done;
+		if (!tc_qdisc_dump_ignore(q, dump_invisible))
+		    ret = tc_fill_qdisc(skb, q, q->parent,
+					NETLINK_CB(cb->skb).portid,
+					cb->nlh->nlmsg_seq, NLM_F_MULTI,
+					RTM_NEWQDISC, NULL);
+		if (ret < 0)
+			goto out;
 		q_idx++;
 	}
 
@@ -1858,20 +1860,19 @@ static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 			q_idx++;
 			continue;
 		}
-		if (!tc_qdisc_dump_ignore(q, dump_invisible) &&
-		    tc_fill_qdisc(skb, q, q->parent, NETLINK_CB(cb->skb).portid,
-				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				  RTM_NEWQDISC, NULL) <= 0)
-			goto done;
+		if (!tc_qdisc_dump_ignore(q, dump_invisible))
+			ret = tc_fill_qdisc(skb, q, q->parent,
+					    NETLINK_CB(cb->skb).portid,
+					    cb->nlh->nlmsg_seq, NLM_F_MULTI,
+					    RTM_NEWQDISC, NULL);
+		if (ret < 0)
+			goto out;
 		q_idx++;
 	}
 
 out:
 	*q_idx_p = q_idx;
 	return ret;
-done:
-	ret = -1;
-	goto out;
 }
 
 static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
-- 
2.54.0.545.g6539524ca2-goog


