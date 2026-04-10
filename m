Return-Path: <netdev+bounces-277510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNdUJB1A2WkHnwgAu9opvQ
	(envelope-from <netdev+bounces-277510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:23:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4710B3DB6D9
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B125300ACA2
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1569E3DEACF;
	Fri, 10 Apr 2026 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUXFqwXp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CD33E2758
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845401; cv=none; b=WRVU235pzKKvtV6ggpU42iDBfn0anG7cBufE7F71teNP2CLCO/0e913fgyUzJcRbb+tJIdmFtOH40+TnCffcuqZ6WhACKa7qcJwTUhu9XVu5HYO4b7h+brDX+9VqmqZzY7M135pUt0Qm8NcGYDbLkYP0DwClxr4sEUuoaRL87Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845401; c=relaxed/simple;
	bh=pDCZY5ZoCU2KpvGwpyol+n3OHp48m/POByjEHiCAj3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AMMisn+g7VeJhTq4/N338SQHm9zqnbMGcNYN/duaZkSwMW+IjgEOGGXSnU7QvJX3zl5EgSPA0oy85l6byQ5k40+UcnDaSjCfg88EvrAgvVVHAx4qSK2FGa54qvIVE9kI5dyoqfaVSWwVT/8pcbbmYqvwFamM0RfQuofLEH7V/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUXFqwXp; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-649f0d26e5eso3602342d50.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775845399; x=1776450199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hoauGp/7txP/5885ISwwYzf3YpJqXBJ3wQBs1AuOuAo=;
        b=mUXFqwXpnt4FKSsD1eHvYbSNqsANICAoN0p2VyUKhLM7nCmoYzaMTZWMi++pDIABDw
         XQez6uo+n+WpRnzpZlYw2AGrGG8I8uzKfQUN3Mv95QyGXIktMYdW7eyhBwqpF3XHKi4e
         V2AH3fzHWm/Ya2Pi85psHnX5OXAg44tVVDCIh5/PiYa89wWUFXaq8sEd1j8Q5c+SEbjN
         hIJgQh03lbZOZh4x40WPLNb0q9q1oIxVFPRJMixPclVSr9/BW25xPbuztsE75bqXcTtK
         nR4TW124VVSWY04oAmdd7UQlmm1S0k85rDljKRulIy63F5GyuPa0c1KF2Gu9/9Fvbyh9
         8cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845399; x=1776450199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hoauGp/7txP/5885ISwwYzf3YpJqXBJ3wQBs1AuOuAo=;
        b=KOwIpTa8oGPA6+aojoIs4+0fEpuIgq9N7f+SSW6/WfDPOmPjnuGxaguUOFaU0dHJBP
         GUzr2pXTh6wHPnJjj7kVcVFf7/M1Ur84u8uU3apfC/7piU7eTDQcTcK0qfR24iQX3SoB
         4s8e5rzFgAjBwraTEgQt1rESjS9vFFasLc2LeR+qCNfqSuKiJUYkJcobGPvft+dT0hdH
         8SNhuObaoRt14i4TXIQEpSQbBJIt3ZNjZvUVH42lRge585zcNv448CNdMsbkz7+PvGRe
         cnIQxD9UCBbGgFU2IuO6/QbzPhKbkxCoo7gPT+XDmxZnzuHUD99gcZFDuDGSxs6IhGhM
         Pnag==
X-Forwarded-Encrypted: i=1; AJvYcCX65ObFECQATiYYlAuBFp77BBNR8O6J7K4xsP1meO60pWWB4J9UI+hxXBZSS4K4s63BTAyfn2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8TyuVUUWCuwRPZPSjN23WXg7iTWG+baUFrfpVMFMu1AWWWzx0
	4YRcVnoQpEQfHmo26NQVVUDDRLfjWtmTWI9zTmqLYoV/EMXM/9B3daPCI9StrChbYK01ZDiOQxD
	phcLvcNlcmERqUw==
X-Received: from yxuo2.prod.google.com ([2002:a53:dac2:0:b0:64e:b46e:f25d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:a0c3:0:b0:650:19e5:860 with SMTP id 956f58d0204a3-65198c1a531mr2995962d50.46.1775845398578;
 Fri, 10 Apr 2026 11:23:18 -0700 (PDT)
Date: Fri, 10 Apr 2026 18:22:50 +0000
In-Reply-To: <20260410182257.774311-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410182257.774311-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410182257.774311-9-edumazet@google.com>
Subject: [PATCH v3 net-next 08/15] net/sched: sch_fq_codel: remove data-races
 from fq_codel_dump_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277510-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4710B3DB6D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fq_codel_dump_stats() acquires the qdisc spinlock a bit too late.

Move this acquisition before we fill st.qdisc_stats with live data.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq_codel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 3a348be18551033dcf41ce632eb4b563221040fa..95769b19a04fb392e14a48353e94fb2ee299565a 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -586,6 +586,8 @@ static int fq_codel_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	};
 	struct list_head *pos;
 
+	sch_tree_lock(sch);
+
 	st.qdisc_stats.maxpacket = q->cstats.maxpacket;
 	st.qdisc_stats.drop_overlimit = q->drop_overlimit;
 	st.qdisc_stats.ecn_mark = q->cstats.ecn_mark;
@@ -594,7 +596,6 @@ static int fq_codel_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	st.qdisc_stats.memory_usage  = q->memory_usage;
 	st.qdisc_stats.drop_overmemory = q->drop_overmemory;
 
-	sch_tree_lock(sch);
 	list_for_each(pos, &q->new_flows)
 		st.qdisc_stats.new_flows_len++;
 
-- 
2.53.0.1213.gd9a14994de-goog


