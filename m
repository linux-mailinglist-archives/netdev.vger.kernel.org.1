Return-Path: <netdev+bounces-256795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NSINGlqXg2lJpwMAu9opvQ
	(envelope-from <netdev+bounces-256795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 20:00:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B70EBCD6
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 20:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DB903006169
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 19:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B7C2DEA97;
	Wed,  4 Feb 2026 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQ1pCHsX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470E21FE47C
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770231637; cv=none; b=EZ5aKVEkuM/gdcGi9WorMyXnp2bD04/w5zKpfvqH0Cu21sYz34M14IDy65+E03LHSyiFA8MASAzjNBCAWxS9YnDbo/T+kbnv/0LSpBH+ox/zWVyqfIqBs5o2mSJjhgVagaa+J54CDgGs6Se5XMs2Eqghz76E/IQmq1t8EHZZCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770231637; c=relaxed/simple;
	bh=8syvRdHk7voisrY9qvZAEl64Ex9aE08T/BesmWPptuY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NWUEZv6cM1RGkpJCC/UhPSe5y8Re5b3Uc0cJI4I4+5ljebDGxjVFEbN45PEScPEbn2cdgtTpM8RQQCXP9H89hWyMh6b1nZJcQbctRlFx1RAqnxsId1rpXJQD6Wrds2BlnxzVoVfIQXP0f3VHWvczzyjyqz61IzIFxGammgRwAls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQ1pCHsX; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c6a5bc8c43so14190585a.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 11:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770231636; x=1770836436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TZL2xET17oGD1nDHcnZUQZ+mBsflQzWb9OHo6Pl4jKQ=;
        b=uQ1pCHsXs1Yh2PukYaiVXXO3E8wvH0MLOHDKR93B6h7FwjVSwLZpj+mC/KJY4b95mq
         x1cIxuYdbT77WUj0atmovKzEfMh8pcfEUOi0sWhA764yqq1oXJURsYtUfiOdb/ZECWUu
         sMRpmKkP7sx+ltXxW1yoY2CdwOR7RWYwgq2LdFWh/Zu4GYCpyiyXTmqP9d/A+QsKDViC
         rANLMqyF6MSn36DICg6cIj2v4lxS6JU9HvbankxoOQgjzKYVOVlIpkij2qagUJU+UC5Z
         Nd8yh8HoJVRhw2kTx3yQVD6t5XqOVt+L68lNfrBTwHLs0PyEDfOIiTKoErbL8/Kr+op5
         pwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770231636; x=1770836436;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TZL2xET17oGD1nDHcnZUQZ+mBsflQzWb9OHo6Pl4jKQ=;
        b=Gm1uv53rpHOFUz13Id3wdmzNkfIw74nUvmjHnU3XoOG4lFZ+xk0KY6pn5k6mi28/8Y
         6oTPheFnD0vsKIQIY5dxQUhQPhVgOHRGvL1CWPiz+SNnqxHM8yqNBbOKwvx6Z1w+cmBv
         N/83KzDZnYWmozH7BQkis+eFqa84vEJ0TlQs/0JMN42IDiMY5LO32449NbaeLVRzqXog
         MbZyEGC2G8/Z7Tibx0UsedtSJPMpQ+2YoFPmcfysvYnHRsedMIGuglRnTdUwlN4qS1Pz
         jzHdCNPcTYp/aTo9W94L5di9L5IuzalWEr0KZ4X+qxZeL2fVcuQzwiiqMMBJVNXTTphL
         fjdw==
X-Forwarded-Encrypted: i=1; AJvYcCVB0waeXazlfIMQNAc7xuX5RDT4K+E4Hwp8samolHzXZ+CPfEt2HkaDIqPcxY8uT4Nnolt/ecs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/x8eSg8KGAiG/FjQx/4FE4GU5Q/zJdAliskhshLhZCEi35V2d
	hfja1MxGJP1WE7kTIKFtoIpoB0BYKw/NI8pG53lvRTyVqOtWe4+/PAHQ0ymz5X8Y6wNY9dom6pT
	ojk1VzledXdqEww==
X-Received: from qkaq11.prod.google.com ([2002:a05:620a:aa0b:b0:8bb:38a9:e9d0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4805:b0:8c5:2ce6:db1 with SMTP id af79cd13be357-8ca2f81cd7dmr470577685a.3.1770231635799;
 Wed, 04 Feb 2026 11:00:35 -0800 (PST)
Date: Wed,  4 Feb 2026 19:00:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260204190034.76277-1-edumazet@google.com>
Subject: [PATCH net-next] net_sched: sch_fq: rework fq_gc() to avoid stack canary
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256795-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93B70EBCD6
X-Rspamd-Action: no action

Using kmem_cache_free_bulk() in fq_gc() was not optimal.

1) It needs an array.
2) It is only saving cpu cycles for large batches.

The automatic array forces a stack canary, which is expensive.

In practive fq_gc was finding zero, one or two flows at most
per round.

Remove the array, use kmem_cache_free().

This makes fq_enqueue() smaller and faster.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-79 (-79)
Function                                     old     new   delta
fq_enqueue                                  1629    1550     -79
Total: Before=24886583, After=24886504, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index d0200ec8ada62e86f10d823556bedcaefb470e6c..80235e85f8440ee83032f171cf28df6f161473db 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -245,8 +245,6 @@ static void fq_flow_set_throttled(struct fq_sched_data *q, struct fq_flow *f)
 static struct kmem_cache *fq_flow_cachep __read_mostly;
 
 
-/* limit number of collected flows per round */
-#define FQ_GC_MAX 8
 #define FQ_GC_AGE (3*HZ)
 
 static bool fq_gc_candidate(const struct fq_flow *f)
@@ -259,10 +257,9 @@ static void fq_gc(struct fq_sched_data *q,
 		  struct rb_root *root,
 		  struct sock *sk)
 {
+	struct fq_flow *f, *tofree = NULL;
 	struct rb_node **p, *parent;
-	void *tofree[FQ_GC_MAX];
-	struct fq_flow *f;
-	int i, fcnt = 0;
+	int fcnt;
 
 	p = &root->rb_node;
 	parent = NULL;
@@ -274,9 +271,8 @@ static void fq_gc(struct fq_sched_data *q,
 			break;
 
 		if (fq_gc_candidate(f)) {
-			tofree[fcnt++] = f;
-			if (fcnt == FQ_GC_MAX)
-				break;
+			f->next = tofree;
+			tofree = f;
 		}
 
 		if (f->sk > sk)
@@ -285,18 +281,20 @@ static void fq_gc(struct fq_sched_data *q,
 			p = &parent->rb_left;
 	}
 
-	if (!fcnt)
+	if (!tofree)
 		return;
 
-	for (i = fcnt; i > 0; ) {
-		f = tofree[--i];
+	fcnt = 0;
+	while (tofree) {
+		f = tofree;
+		tofree = f->next;
 		rb_erase(&f->fq_node, root);
+		kmem_cache_free(fq_flow_cachep, f);
+		fcnt++;
 	}
 	q->flows -= fcnt;
 	q->inactive_flows -= fcnt;
 	q->stat_gc_flows += fcnt;
-
-	kmem_cache_free_bulk(fq_flow_cachep, fcnt, tofree);
 }
 
 /* Fast path can be used if :
-- 
2.53.0.rc2.204.g2597b5adb4-goog


