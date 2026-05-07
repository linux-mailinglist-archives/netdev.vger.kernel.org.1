Return-Path: <netdev+bounces-285529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP/yEigQ/WmwXAAAu9opvQ
	(envelope-from <netdev+bounces-285529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:20:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE534EFB92
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE3123002B7C
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 22:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ED138839D;
	Thu,  7 May 2026 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wbZZW5Gj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411393859D2
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192401; cv=none; b=SLGbAUYKRH1/ydmZzEZtn85N0aFVIuyjb69UutZTkJpDuCpNbw5mal4g//MEfOeMuLYduvS6xiJeIB7URNDrRThAMwRzC798QXIUi6T6opyqiTRZtysoB6OwYnD2OFwQprFcjMYHMXShpK9cJn67QsXHua7OIBAtFRq4bSA5BD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192401; c=relaxed/simple;
	bh=e7q4zWUZvc+hAsIV0knipe+VhakwT/Kh7QTtkXzAG7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mFfMgcpVVuoBaismn+/zgWZb1mCY787hzfOQtw0eBGnR3YvqnHaiKLZOcoMCgWQK6BLa0cn1+YfWjG825za8wyF5DJ1qqq+6CSfLJ9U6cEtaH1OVnyQS2z/NmCGlFGYUJIkuIgQAc7aN0+OPm7uLviKYoeSmYhZHUjomSaO1rOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wbZZW5Gj; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8b58065ea15so34233956d6.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778192396; x=1778797196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5HW2Y9lvYg6QeUVgeM7ekVgUKK6q1Dm/tCZ2xRqHbho=;
        b=wbZZW5Gj1RD4UKWCmXCRI5xanyoXFI6YZcxvPP9Rs0Mi4KDXsutEfrb3w6B0KzohFI
         KVw/IG2PGikYOtMTLZ1XyPbD2HzwLLEqlY+ZMhw6oX8SmetE9uxFde0nEFHJgwWC3yAp
         cSDLMWvuQf21+gg6PA2TPftJOrVMVOdzLx90qzrGepa26ieA7Nby5hyvSNq8Rj0KAKlF
         nXQCW9gqHveGPEOxIK0rCu8SGNq230Jc29x3I6pk1GxABuBsCrpwJSU6VQTe3DFAFiqu
         dHDKBNG5PLLHSJ1Ilb1J+oe6q6x4jvylycXiHLzZzZbbg3YvPJ3SF40wPIuB/lCXqxQK
         wRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192396; x=1778797196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5HW2Y9lvYg6QeUVgeM7ekVgUKK6q1Dm/tCZ2xRqHbho=;
        b=R97YH/V0FDarN0p0dWAHXV2kmro6JqcRVwXc0y9tzZz/fJQTG7CjsHCcPOaOeCu8K5
         VLD6TaEmfrU/WdruR1ZaEppLND9WgOP/IY3I4eanc/Z8QRN8ryKZAu7J26aDiQCTPnbX
         pG8MetUwRRpjivXvIlwGLV9jYzWDWWhjx9qyYMogSEiIjItObY+IOlPUtzHnNmhN+iiS
         1wW9k07Aqq97RD2iTU9EL1sCsPzs1rzq6dhuuPt9wKlQkM/0ZcAKdb4U9jLwtQ9xcO03
         sU2CfpJlJZoEOm5RCvUa5of4ptvL66eC/aqG2UUBFwaczOFsyiVhNEHHLJYUMzA/6o0O
         gpNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Y2SEFlfprH7Z5fBe439DFoijmhfTQy6VcGNtUfgeYdAMFNzRpfEq/obXNPgo3JNuITyotUKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvbwEDHhEXNnx8djcPmclqOyRbnaMgdIWIcqyi9F3pAzKhH0VC
	C0BbYax+LJ3nTKb4QbyrRpM93VaxFKBiNirOV4J+WgOOwh8peLr4UvcKyzCZEi4buD0Ts2NBhJA
	iGCBQTxn638+JIg==
X-Received: from qvbjp11.prod.google.com ([2002:ad4:5f8b:0:b0:89c:6289:f17b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4a88:b0:8a7:3317:6043 with SMTP id 6a1803df08f44-8bc42492ae8mr146935616d6.3.1778192396016;
 Thu, 07 May 2026 15:19:56 -0700 (PDT)
Date: Thu,  7 May 2026 22:19:44 +0000
In-Reply-To: <20260507221948.335726-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507221948.335726-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507221948.335726-5-edumazet@google.com>
Subject: [PATCH net-next 4/8] net/sched: add qdisc_qlen_lockless() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6AE534EFB92
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285529-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Used in contexts were qdisc spinlock is not held.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h | 7 ++++++-
 net/sched/sch_mq.c        | 2 +-
 net/sched/sch_mqprio.c    | 4 ++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d147549169a4d43c80684db2e1815a8a0d6596c6..3070a717bb98386838f3e8149f34d52572fe208f 100644
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


