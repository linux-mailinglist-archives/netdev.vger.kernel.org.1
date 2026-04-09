Return-Path: <netdev+bounces-277141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBbtNEof2GlaYAgAu9opvQ
	(envelope-from <netdev+bounces-277141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:51:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A98A3D0068
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E1F43037DEF
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE146375ACB;
	Thu,  9 Apr 2026 21:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sryLvQ3r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C50355F47
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771373; cv=none; b=Q/FuAZMpi4zDR+bt4TeLt5UK7gdYKVSgAEPtuhH8zliAKBTCNl7UIfU3vyNH3UXWUyRs2akKHK1qrJwX0tNRsc8/Mxlf8II+aluxnur8dkWGqXhFJ1Cw9RbghCrVewleSv9o44IBWo4rzhz4y7x95Axb+/JZtDOZS3GdXHb/duQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771373; c=relaxed/simple;
	bh=NLlOCX8azWcJx65h66z85wsmonxZA2LSWRD6jzZ1lQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S22NwkWQ1O07tS+0d2eAHJpl9lyKWfJZl+mX6qgdIFPeG7bNdHvXCUCvKiKXe28TXQX3ib9V25JjY/MVwJPFklK14rQzWYf3eTJz7oUZVYWo6wwtYFKc5Z4Nub+PUVE02jZ1zMguTN8/aa+SiLF1/nlvkOwJcu/3PjfBTGp9y88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sryLvQ3r; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d5aa81907so36565291cf.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775771371; x=1776376171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge1KbPtPse9CG3yxMaUrV47O0RjfiawbyUAvHe0Yefw=;
        b=sryLvQ3rwMQYkeHSMaxV+9CT6xOf4qBN/0yYD7S1A5fsY2hXIfH02m8dyFqoxfG9oM
         Qe4ZmI2gIk2nudfZ+1JUUQVKFHD/m29zEs5UBqokgncwE7dpeoNIF76teIW5qeDUWubG
         xM8KZK9SvpkQydyXa8yro27VtSo3NpEotE4ucI6RM8dK0bW5Nr8AG/+RTfYIRsmDIxoE
         cvxdBKeHHUBB/LO1Lks/jlQ+t/ljmZh+fXigE8IqP5oOrdzqina6X8wHxS5BIuWa5xM6
         mEMw2digu6fKmG6O9B7hjKMk96jqIn6tZX/RB8UBZoGHnb2Gabr96LmCpIxWKnKdXr1M
         1LMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775771371; x=1776376171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge1KbPtPse9CG3yxMaUrV47O0RjfiawbyUAvHe0Yefw=;
        b=nogAJKZnO+NETGBpreRm+3rz/OYDP9H3OhiYUb9/OOcXqh4p2EeTd2WgC1aMYPhJ85
         Mk3kpB1AzazRFDFSI1E+bm8S430gK1lmlaZOxA+jnZRvf/l35yS1XBpNs7ss+MBAJeaH
         7H+997o0OmelbXSi+tL28jWhjNOPaR4C7jcH62Hpb5mcm1MVpIfhd9RMwxnYXTee4iXK
         IINbjkAx4vRQ908LlA18spRGCyRnQjChtm16O3EbUCpHOJwB2UN7cnEeW6jN08rko9F2
         bOxz2MmSHLxZQQQnD1vC5/AQpsBWuSxV5PanXGV5dZRKSzK2bPasw/93Y2D7IXZuHMNq
         xQhg==
X-Forwarded-Encrypted: i=1; AJvYcCVSbXClKGp0Hp5fRiYCQBgHN+lFaHRqeYGBfdbE8LE7WsHIFpClL3aVtYLXfh5LPGZ4+7BsVm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVPEukzPTIZyxSvMCTfjBMTXg1IjROrKlLZ3lIScXrl3dwqEgH
	twThC/+NnWYLmf/2Nkh45EhFd/nn0HbNDf5PaBvP9VISiAkyfbjc+HEYiUHbn+b+u7vDT7nSgaL
	8LvOOD6O6NedTlg==
X-Received: from qtxo14.prod.google.com ([2002:a05:622a:44e:b0:509:2144:daad])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:244c:b0:50d:6557:5c97 with SMTP id d75a77b69052e-50dd5752452mr16775541cf.0.1775771371359;
 Thu, 09 Apr 2026 14:49:31 -0700 (PDT)
Date: Thu,  9 Apr 2026 21:49:07 +0000
In-Reply-To: <20260409214914.3072827-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409214914.3072827-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409214914.3072827-9-edumazet@google.com>
Subject: [PATCH v2 net-next 08/15] net/sched: sch_fq_codel: remove data-races
 from fq_codel_dump_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
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
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277141-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 3A98A3D0068
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
index 5c88278a30b3cd92ae525d1a88eb692ff0e296e0..db5cf578cbd63e842381cb147ced145fed4cca3e 100644
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


