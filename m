Return-Path: <netdev+bounces-277136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JOsLggf2GlaYAgAu9opvQ
	(envelope-from <netdev+bounces-277136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:50:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E253D003D
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F208302262D
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADA6339719;
	Thu,  9 Apr 2026 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nLOO7Dn0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1008E34750A
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771365; cv=none; b=EiH7QSKjVho4opWfQtxoSLN2rLHoIWwjbI0511D9HQFPqCDn5A+ApChxV4UPkGKUxt4Hu9OohwGSUybGs0LzxV4d7KX5XSLf86EJhiNTl1hTEM66jNI9olc/7oFrxK6UMZzAikMG6TumNdyivo0SeJw5jp4X+gTSdzoGsPz6Nns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771365; c=relaxed/simple;
	bh=C3lB+1f0qaR30gLOF4c1HLoWdHCA1gdjUjWrDfHvPAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NXmqgfSSomhvHZeveZdytbBmvKZsSqu7D0dN0UL5leLlEymMect3xv/TSGzlQ5u4wh+V/mDj020rz+MgBzfKs4RkaH6XtrOYsgplTfUr4jEdJmPJaEIwhJW2ue2gNakH4o/4teCk72lQHhgiXxATQ5GyxQxeCoonjCkdLaF547M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nLOO7Dn0; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-6500c962881so2935178d50.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 14:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775771363; x=1776376163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8lRHl8je5D2ZkoXYt/ZWfeFEvt0P0M+HOlaF2F0zd1Y=;
        b=nLOO7Dn0Sv/6jX9s2qnjNS7oofcfp1Ibvy3y68nEwBu58hxOTE01A9oGfmCUCfv/25
         9hZoeHz3jA71F2k2MGhbInc7S2zW/gTUhVDEyt4NnfWqnzULDdcYPG2pICF0tAruxCKm
         ZDPA+AgglGS19oVu3OtXJLEQtk0yNFwkx7R5RBwK1BF/qMoZ6sFtXOtEaGhojF/mVI2O
         3Rq7ZCJB8uE3eWAAxBQfqfEazpTDMeC24uihOKY2c8JVG9WnMX+1EGGzDa/8VmeuVmvH
         on27zcWa28qg3+RPSO60IrR7zc4TrfB8YnfZ0W38qyx4jIXAygUqC7043+Dc+lyo1aTM
         yEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775771363; x=1776376163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lRHl8je5D2ZkoXYt/ZWfeFEvt0P0M+HOlaF2F0zd1Y=;
        b=o1Aay+An1Ji6vuPDocIyITLYhxOsii0v7LrFUjpojqLXfrfP9pAHinI75s9XObE4yF
         kTcZ59QT/NAe5p9kvBfOqHgV2E/bZ/TRgMp3TrMo1mUqV1Thddbrh6yidFfD4vUaOW57
         pymKGH0KrE3XQaiX3rdsiphgU3DQLNLqYqKGoO7T5P6ZbNOdIy2NVA8RT41NOhtbljNO
         xzXQRPB9v4EjVUXvdONAzukpdJ9xIiUBo6MXbWJgCHAwof/R1mV+GSS9OqnCspb4Qvz7
         5y1IT7DMA3OnTLZiVjnPZDhdWvKdqRbpm6Dggl1HqhWFnA/Q70K83ce/WHSr0rpzp3Yi
         Ip7w==
X-Forwarded-Encrypted: i=1; AJvYcCWpjp6wE/TTjYED+Hz8g9Sff/UPUCGjSDsw6ag6qzEzvOcriQAWSoBTMhftDMRCXx6U9OF2/hI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx56DtphTSfIiR9CF+SwxT+3Eqt315tejF/ijZ0ylWM81ElBgmQ
	46FvHeUpUlnaMtWEJQ8GC8ysr+nt4xWoXo5zoe5uUMSLN6C+VZkmDoHoutwOWu3H1ncX4AtIbCk
	gCFo8CjkHlWqQQg==
X-Received: from yxqq15-n2.prod.google.com ([2002:a05:690e:250f:20b0:650:8d03:5280])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:bb86:0:b0:650:7a79:219 with SMTP id 956f58d0204a3-65198aad325mr510558d50.11.1775771362764;
 Thu, 09 Apr 2026 14:49:22 -0700 (PDT)
Date: Thu,  9 Apr 2026 21:49:02 +0000
In-Reply-To: <20260409214914.3072827-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409214914.3072827-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409214914.3072827-4-edumazet@google.com>
Subject: [PATCH v2 net-next 03/15] net/sched: add READ_ONCE() in gnet_stats_add_queue[_cpu]
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277136-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23E253D003D
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


