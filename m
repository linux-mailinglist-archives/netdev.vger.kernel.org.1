Return-Path: <netdev+bounces-276518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OAxCvlR1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:02:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C329A3BC895
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4113304A6C5
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEAF3C1401;
	Wed,  8 Apr 2026 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t6YTXZ80"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41053C73FF
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652981; cv=none; b=O2yJyKi0yf9c7Qzj3ZSlo64Y+YQbjiBYab1SGLILgmFtetGceIVXDayAdKXIW9yOyQKr5S7MVmWNaVWq9Uk7KHcscL2F85j2KmcY46sWH8/MXM2F+2K0Az05iACV5CYqOwKiGhtWLGCczscJRzmnOzuDglgaWd5ABe1Ye8QBU/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652981; c=relaxed/simple;
	bh=C3lB+1f0qaR30gLOF4c1HLoWdHCA1gdjUjWrDfHvPAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lGmvdwxN6CSARYGyYNavyZl/butmHCjigS+wkJcBOVpUcWZAUsHN4dlPHXPLPKv/Aq2dlioqcSmqEMKya3VwaXG+fX25rf3ZCpuKA5CQOyPibJhBogKfzXrRAL6bGtAaG5i8Jy2J7DoWPFlVnNi2JA8Ukk/Xt7hfqQ4gBBL6nrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t6YTXZ80; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50d84b5f73bso97613151cf.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775652979; x=1776257779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8lRHl8je5D2ZkoXYt/ZWfeFEvt0P0M+HOlaF2F0zd1Y=;
        b=t6YTXZ80ZiCWGwYkxnGZDMVslhFej2JlZcjZzdbED4utaNoOwcPQDtT8EbHJ1Ijft2
         nJe1nFc5jEfa/RNbcCySwojmxiJrHB34ZRpZqDEutaAByAkESbCh6ORAxYC/KK8KSHQY
         uI/nTuFVQdqBwMW3OwnW3eSX+0nXG8Tk6SWM9IZMoGzx1qVe4kd1n++hPOPZKx1XgG4K
         MDjjM0zxjjJwfzCV1tE13nzSKdez3S8uArhGjgRrX24A9ODZHzF27rfctSDErRvGQGxV
         Tbeg3dBp7ej+YZIDPvpKtUVcT1BKWowu2bLcVWucrqghKe3cSsypyWLZebN7DKgRxVza
         ePrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652979; x=1776257779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lRHl8je5D2ZkoXYt/ZWfeFEvt0P0M+HOlaF2F0zd1Y=;
        b=h2bee3neSjAoEzchqGl3tLeOQ42xQFVw7ZjN9NdvahIMIGHeC89Lj0B+zl9j2r+QOM
         As1AQRjonvX+FlUfvkpaVkL+fv/ZOeWXdv3F+PnQfHwaBcuiWgjZ+u9Qh+2xA2TFtExZ
         e9Pk3vdF026jzjkVFvN2eo3gaw4bvuz9d3JSqiAdgtRPqiRPRIWjmOS1N7mzu0AJJ5C3
         HokLRn1nG1r+NYE9VyGqPd8+xjVO7CZzEtbtzBhRiYNRPCnNQI+iQ32UfaTVDBDgg6A4
         MREL1eFQ96ZoiJp3oPUCO8C2CRV/MdcXUt31nGisevvjFWoJSge7kK+SRuvpSzkcWpp+
         fqKw==
X-Forwarded-Encrypted: i=1; AJvYcCXs36oZTuf7kM6KoH6OqrGb8scYzVTinUUP56cYuU/LEFAA6wFqaV3TyGlh7eINNHUlhg6+cok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7OydDfcXHXlSjnz2uuda2PC2wEmpoFL5oNS039HHYi1pjRUTD
	TL9rA3rNqP5LcdW3jRdXpNO2n0UY22Crvo6UXY+WM9hSj/iXWXfzBMnwM5aDf6Qew86ABSD60iZ
	JXHv/jrNWXscM2A==
X-Received: from qtwq16.prod.google.com ([2002:a05:622a:310:b0:506:bc2d:8fb2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:15ca:b0:50d:b6dc:e4e0 with SMTP id d75a77b69052e-50db6dcea51mr25401741cf.29.1775652978731;
 Wed, 08 Apr 2026 05:56:18 -0700 (PDT)
Date: Wed,  8 Apr 2026 12:55:59 +0000
In-Reply-To: <20260408125611.3592751-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408125611.3592751-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408125611.3592751-4-edumazet@google.com>
Subject: [PATCH net-next 03/15] net/sched: add READ_ONCE() in gnet_stats_add_queue[_cpu]
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
	TAGGED_FROM(0.00)[bounces-276518-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: C329A3BC895
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Stats are read locklessly, add READ_ONCE() to prevent load-stearing.

Write side will be handled in separate patches.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/gen_stats.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/core/gen_stats.c b/net/core/gen_stats.c
index b71ccaec0991461333dbe465ee619bca4a06e75b..1a2380e74272de8eaf3d4ef453e56105a31e9edf 100644
--- a/net/core/gen_stats.c
+++ b/net/core/gen_stats.c
@@ -345,11 +345,11 @@ static void gnet_stats_add_queue_cpu(struct gnet_stats_queue *qstats,
 	for_each_possible_cpu(i) {
 		const struct gnet_stats_queue *qcpu = per_cpu_ptr(q, i);
 
-		qstats->qlen += qcpu->qlen;
-		qstats->backlog += qcpu->backlog;
-		qstats->drops += qcpu->drops;
-		qstats->requeues += qcpu->requeues;
-		qstats->overlimits += qcpu->overlimits;
+		qstats->qlen += READ_ONCE(qcpu->qlen);
+		qstats->backlog += READ_ONCE(qcpu->backlog);
+		qstats->drops += READ_ONCE(qcpu->drops);
+		qstats->requeues += READ_ONCE(qcpu->requeues);
+		qstats->overlimits += READ_ONCE(qcpu->overlimits);
 	}
 }
 
@@ -360,11 +360,11 @@ void gnet_stats_add_queue(struct gnet_stats_queue *qstats,
 	if (cpu) {
 		gnet_stats_add_queue_cpu(qstats, cpu);
 	} else {
-		qstats->qlen += q->qlen;
-		qstats->backlog += q->backlog;
-		qstats->drops += q->drops;
-		qstats->requeues += q->requeues;
-		qstats->overlimits += q->overlimits;
+		qstats->qlen += READ_ONCE(q->qlen);
+		qstats->backlog += READ_ONCE(q->backlog);
+		qstats->drops += READ_ONCE(q->drops);
+		qstats->requeues += READ_ONCE(q->requeues);
+		qstats->overlimits += READ_ONCE(q->overlimits);
 	}
 }
 EXPORT_SYMBOL(gnet_stats_add_queue);
-- 
2.53.0.1213.gd9a14994de-goog


