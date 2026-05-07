Return-Path: <netdev+bounces-285526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OzRFA4Q/WnJXAAAu9opvQ
	(envelope-from <netdev+bounces-285526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:19:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E60D14EFB84
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 527AD301104F
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 22:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E115838735E;
	Thu,  7 May 2026 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5W4jQs0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F638383C92
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192395; cv=none; b=NyJvvqO02AX8jVusQJI6zVcoLAOt7YMY1zmFEIoe3u9Zc7KUtkwvj5+VPwfdL1T4sSJgnc9WnFjK0l/YGZITznsoLFwy9S2r0n4GGmursr///qS2j1UwBkxLi06oFalyWa+sANfKfJxfY4XXl03MsPU3TrW6Q+EKD+UtD29BbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192395; c=relaxed/simple;
	bh=L4CjySd8/XhcEsdAMjNHepGslzMpAWsnsnhmBh9a0oA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AExzhjCfQDrGEWKfI0xYlPfGoI8sbN12qTQb7feLW7gT0w908NDPbeB/hB4qqszIdtEUpXyq8WAdPRFyj+di4apws/b8cSQjeqtxJ9+gkjR3WQQTTgDrX2chncz6YPGgmgRc3Xs0Hp0Zvod6czhJIOPzmaTMpbfAidTa9Zz3BMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5W4jQs0; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8aca172588cso32618126d6.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778192392; x=1778797192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tcJT2rEa2jIYaEp/6UXJxDV2mvHgKIFRuR59TisvGbc=;
        b=r5W4jQs0L0jV2vbP1oAoSZqF/aMdjZG0xS6+kXuTs8ZXEqXJweEyjFU0+6/wFfJ7id
         OWYAhIox+8KzPzhjYhLtXKO8KYWAIJJi7MRfej+J7lS2PZlkwPCCpHuKeUPd6V9HR7r7
         VzZRT6nAF7QJp3hZ3LTKJk2r9joM+KFNf23WfZ928GzySbS5pVSB40BRhStQNGTpQ8io
         fS2qqPcvzjmo/56Q0qZAVO23EssaxGvyHzl3UbGZRrKzgopE3ULdKlr2Ww/9Z4MjtR3I
         KvnftD789w6Pmiv7byiMevI+MDQTQj8KMlDVgXOlzt2u72R3GvVN0epRPKkDQM6pvByh
         YBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192392; x=1778797192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcJT2rEa2jIYaEp/6UXJxDV2mvHgKIFRuR59TisvGbc=;
        b=SJXouLSl4PdoYqerlUCyzsr8JY6xNKJIAiye9IVOPBfBF/12iO7ezY8MnDRRW5RnVy
         +Fzyg9LoS/OZlVWvTKcOF8w3puSXYDm0S3i4uzoUqOMmnecoSdmZaurxAaGl2JF8bUSW
         qIbNRURumUnnmgo9fjUfhzBG4bxbjJllZ8Ba344lsvzxq6ezN4iQ4EmqZJ2sRORpAqls
         zKK+Bj6f4DmJRTus63E9HxpgRMRIvG84DpXLtDfdGOqMsuz+xnnfzYtz0yW7b9EVVbm2
         rP45HnQXBCc+F90ylDWvdL/SE1gNlmEIeNzDrJkfJJKkbFQe/M9ZRyfPtC9m7THRNjOu
         eLXA==
X-Forwarded-Encrypted: i=1; AFNElJ8efPsxWVNkHydbXiUFv9AlycbbJPgSSQuoG5qnTwQv105anpFIx1D8SaK88kEvLqfdUpeR1F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWrsIOXi8za+r1RXSgSoP7XwZsHggznsC2cWBlozR8KJe//8h2
	GrwXIoKxDb9tAorHCK9qhlnyPAvhAjIcghA4DtqkV080f3amQ1L6xgwtNd9vYa7mvczHxs50JP/
	59SIy8wLJhhdNyw==
X-Received: from qttr2.prod.google.com ([2002:ac8:7942:0:b0:50f:ccdd:13f3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4cc7:b0:50d:e1c8:5ed with SMTP id d75a77b69052e-51461fdb32bmr143463471cf.52.1778192391594;
 Thu, 07 May 2026 15:19:51 -0700 (PDT)
Date: Thu,  7 May 2026 22:19:41 +0000
In-Reply-To: <20260507221948.335726-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507221948.335726-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507221948.335726-2-edumazet@google.com>
Subject: [PATCH net-next 1/8] net/sched: add READ_ONCE() in gnet_stats_add_queue[_cpu]
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E60D14EFB84
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285526-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
2.54.0.563.g4f69b47b94-goog


