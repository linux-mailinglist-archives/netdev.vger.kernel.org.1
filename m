Return-Path: <netdev+bounces-277515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI3mLANC2WnCnwgAu9opvQ
	(envelope-from <netdev+bounces-277515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:31:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 511453DB76C
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABCA73015701
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB86A2D3EC1;
	Fri, 10 Apr 2026 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tvWinTmj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F7D3DA7DF
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845857; cv=none; b=ujS8xW0vSJWzs5Jpb0u3de2fazfYjPfICjT0iyBR9YsX+2jyfeewWaj0WthtbXu1VJBTyLtBUbY3a4y8mPztu4dmJKYTOFLKXGzg0+PE3X3A0BidfT522dXvM4jImfWxFwknZGG6BKEPCIm230YcZitBSz0HJvJjyuJ7Lgl+efQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845857; c=relaxed/simple;
	bh=C3lB+1f0qaR30gLOF4c1HLoWdHCA1gdjUjWrDfHvPAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XfPgcYAaiPo2enAUptoBnfTt5xffxAGKq211Q8mvd5/fo5jfQmLonnEbIUFUGs7Shrd0ae3MtQr74Tq9q8NEvpzBYzrioE8W6yE5wBvyIEjI/pygo0HRluQZFynTDAwg6oiV1k92R+R/ExCh++5KhVNqHrWMvV3m9f+Te50CY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tvWinTmj; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-94ad0ada31bso3441635241.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775845855; x=1776450655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8lRHl8je5D2ZkoXYt/ZWfeFEvt0P0M+HOlaF2F0zd1Y=;
        b=tvWinTmjgC3bGPfK7qpWPPyUDpOyHYIuWuMJqOnE+8sKfTcn9rF12PkoWHpdppYKAN
         jClJgNJ9c77MOzjuY683twYFxHmNu33gt6I2CTt+zks+NrmgbLno9iqltrZA2CnCb2lb
         USmdZBMQq8U9AGEExSdT9gKBa7I/Tt+jOX8IY7NE0qy6/iPoniz2ZkGiG/SkpnNxZk0R
         xH+CIBWTc9G1/iT8pZLzO70VRjhgNsEcT2vVqkJ0BsyRbgov4o/9v8AsWKSwfv3juSOC
         PZiq9ADOyBZ+DghfzmJFQux/aaBq8Hp00bsw/Bc19mO4mXTgkF29DJojUneY/X/No/2z
         t/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845855; x=1776450655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lRHl8je5D2ZkoXYt/ZWfeFEvt0P0M+HOlaF2F0zd1Y=;
        b=D3qtrPDToGtvZnTA+RP60KhXe6bOQryrPV55z36jlrWmgu+djA0eO73H+ccjbB9sUg
         jygqGvFuLCImIAUIsAbwrqwvSUZ7IvryY3WOXbnBySetSDieSL2s+l1+CDUOB8NxXlid
         p3EjxdpuMcF62sG6C4WiNFrFJGSowz4vgb1SPCL5u/T8ly904DlgLk6RC3Zum/LuWXFQ
         y8MiSsLRzujYSxKFdXrYgBR/cR+XngkJAbrZRLwiGhj8pJxa7iFVWBQ4xvEShMEYI1Dg
         lDUvIeudqcvMsSAj41hLl8/JWDjfLZbnfR7a50DW5kVlgGWO6gHtNWPCGq1rJF7alRNR
         X0Gw==
X-Forwarded-Encrypted: i=1; AJvYcCULKv3pC60DyT6CrFwoIoxmo2W/eHtsn8ZGBMGbn8b6yqdxBjdwzdMKeVZYlErx7sKkYQkjU0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxqt9Yk8UxB/qJwB3ID0hpqu9IW58O2f6EpTG9sEozeubrFejl
	75nsFk/btjXv1ZReCV6XTcI2f4qj+9m/rB9QRp8AqD8fvzTPF//pUGlMq03+Jfu2liRL4PKxWyX
	2wMRy9u1glWQihg==
X-Received: from qtpp5-n1.prod.google.com ([2002:a05:622a:9c5:10b0:50d:b6bd:a750])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1187:b0:50d:a142:7ce4 with SMTP id d75a77b69052e-50dd6c2b4fbmr49819151cf.31.1775845390367;
 Fri, 10 Apr 2026 11:23:10 -0700 (PDT)
Date: Fri, 10 Apr 2026 18:22:45 +0000
In-Reply-To: <20260410182257.774311-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410182257.774311-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410182257.774311-4-edumazet@google.com>
Subject: [PATCH v3 net-next 03/15] net/sched: add READ_ONCE() in gnet_stats_add_queue[_cpu]
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277515-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 511453DB76C
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


