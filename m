Return-Path: <netdev+bounces-286263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNSkEeZMAGqsGAEAu9opvQ
	(envelope-from <netdev+bounces-286263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:16:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA445503488
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7111E30247D9
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 09:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A590236F420;
	Sun, 10 May 2026 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2vDKNON"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B86336D9E1
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778404505; cv=none; b=pPiRplw6yWaS/K3Jy6svOJVKHFgy84KB9Z6DtPKBHH26JTBFsuXCn3L1jp7x3k12dutOSZjITrhgU8vk7cOQfKLPfhe70gtvdaQDjYoiT0nSK+6DfajOJ8TxmkA58cbR3cMQkR2CWicLeSF/7Bfq39HyRhVf3exsvzZBhfH62qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778404505; c=relaxed/simple;
	bh=0pUjR6wq12wBPrrmgaXMy8WrQBVnfrxoCWfJmcBiwqg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fUe2ynZEVcWq1WZh5aFo/wJ01mKEyNJLWoGi5EX2jMg1qJzE9tWAHER8lzcsHwBgcVfqb2xVvF8GDd+E++qTFmZLrG6qGV0gfahM0Ig3D+Q5jRmfvt1GpH25HT/rCNxpInZbDkcxeJNXIcgdJxVMKHuTr4+RW7H/QB9DoGVKWk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2vDKNON; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-909120afff9so77529685a.1
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 02:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778404503; x=1779009303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lyERt3Es54U7Hk4ia2nthelmQDyAbSxosUrEc1wr080=;
        b=C2vDKNONT26H//fha6Juurx82WW48LxiBxcqRbiyo8Q3+uCwfI5SU5IvGPp0Uk48Of
         qDM9pJL5U4fYO3K3PjqmOIpFpXSfxpF29QO7Z8E5WvqPV3zU7mh3rXH72rd+tZ8vW/ks
         CeLEaY39S+qdw7Sl0wZLRKJIVaQedW2kiuOj4oc68n9LiCwUUilPng7XmDruWCsTVy6I
         r2N6MvxkgBbq42AibSU/gq6MLJehCm9pF2H9iWIlnw9Nwx5RYTZU/qFs+3TLjpYIulIT
         IHtmZQ+bZ2OjYzqmloOl0qXt3ByyJoy8NTnP3F7X+C5IQH8gJxPNAsK5Au56ENFdSHUT
         EGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778404503; x=1779009303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyERt3Es54U7Hk4ia2nthelmQDyAbSxosUrEc1wr080=;
        b=ZpHYGhG1DbBoUs8rAamuXAzDyy52YFlUbTl4LOeDng4hXhYj8Rt+Rov4Hk8N2cxW+x
         +bZQp5h6MIKXSRvv5aWm47gxDdZ8dINOOpeCq3PxCN1tsiJwz6J0uov4NqRsXV90j3zn
         5kmrqCNHs6wcGySLLJBSHFlfAFXMHQTCc/TAaI1vHzgmIvptBr2aJ/Prs6dwZJASxKZr
         t1/GAHK4Bt87zHsoPGVNL0WE78BV/iGkoax6KEPMxJsZzqFNo9ExF7TmtZOUTaJmNmxk
         QBQPL1759Fav/2CHX+LsZIFjLqxrMeHKifuhSx8ptkWrNplS/OjFI1V7JVjCXrPnc1Ll
         KOJw==
X-Forwarded-Encrypted: i=1; AFNElJ8mu/vR1kHPwEcXlLP3tgM8EWyIOXnlqebQ7srqGUxctE998ty3P94cQ6ugjP11pszM6zv/TdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ4iZNG92yjGvJc9cxyAA4aLEm2FK+Y8gcJ5v3/iBkZpbsyU0E
	MNz9Ap/v9/CDwkwuGt2koYtW0lLfF/XwzIrzsgvcjUkEs0sirM+b0ZSwYPlOzaI7Le1NhsisSpL
	ge73K48gcGrmSog==
X-Received: from qkjz17.prod.google.com ([2002:a05:620a:1011:b0:906:e916:ddce])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2096:b0:908:a0e2:28a1 with SMTP id af79cd13be357-908a0e22a0fmr707362285a.24.1778404502591;
 Sun, 10 May 2026 02:15:02 -0700 (PDT)
Date: Sun, 10 May 2026 09:14:51 +0000
In-Reply-To: <20260510091455.4039245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260510091455.4039245-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260510091455.4039245-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/8] net/sched: add qdisc_qlen_lockless() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: BA445503488
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
	TAGGED_FROM(0.00)[bounces-286263-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Used in contexts were qdisc spinlock is not held.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h | 7 ++++++-
 net/sched/sch_mq.c        | 2 +-
 net/sched/sch_mqprio.c    | 4 ++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 391ee85300172fced9bd7c8918727f01662c4a11..0edf05d56862b113a9468ef2175d203123814ec5 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -542,6 +542,11 @@ static inline int qdisc_qlen(const struct Qdisc *q)
 	return q->q.qlen;
 }
 
+static inline int qdisc_qlen_lockless(const struct Qdisc *q)
+{
+	return READ_ONCE(q->q.qlen);
+}
+
 static inline void qdisc_qlen_inc(struct Qdisc *q)
 {
 	WRITE_ONCE(q->q.qlen, q->q.qlen + 1);
@@ -561,7 +566,7 @@ static inline int qdisc_qlen_sum(const struct Qdisc *q)
 		for_each_possible_cpu(i)
 			qlen += READ_ONCE(per_cpu_ptr(q->cpu_qstats, i)->qlen);
 	} else {
-		qlen += READ_ONCE(q->q.qlen);
+		qlen += qdisc_qlen_lockless(q);
 	}
 
 	return qlen;
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index ec8c91d3fde04e59daec2aecdb14d6bf50715e15..4172ec24a43d1c2fe56789986a46da93eb522721 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -163,7 +163,7 @@ void mq_dump_common(struct Qdisc *sch, struct sk_buff *skb)
 				     &qdisc->bstats, false);
 		gnet_stats_add_queue(&sch->qstats, qdisc->cpu_qstats,
 				     &qdisc->qstats);
-		qlen += qdisc_qlen(qdisc);
+		qlen += qdisc_qlen_lockless(qdisc);
 
 		spin_unlock_bh(qdisc_lock(qdisc));
 	}
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 91a92992cd24ab6c30bf7db2288c08cd493c7bc3..3b4881c389c535368687454ea268bec892ecb942 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -576,7 +576,7 @@ static int mqprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 				     &qdisc->bstats, false);
 		gnet_stats_add_queue(&sch->qstats, qdisc->cpu_qstats,
 				     &qdisc->qstats);
-		qlen += qdisc_qlen(qdisc);
+		qlen += qdisc_qlen_lockless(qdisc);
 
 		spin_unlock_bh(qdisc_lock(qdisc));
 	}
@@ -691,7 +691,7 @@ static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 					     &qdisc->bstats, false);
 			gnet_stats_add_queue(&qstats, qdisc->cpu_qstats,
 					     &qdisc->qstats);
-			qlen += qdisc_qlen(qdisc);
+			qlen += qdisc_qlen_lockless(qdisc);
 
 			spin_unlock_bh(qdisc_lock(qdisc));
 		}
-- 
2.54.0.563.g4f69b47b94-goog


