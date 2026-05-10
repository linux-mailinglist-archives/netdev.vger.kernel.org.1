Return-Path: <netdev+bounces-286260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG9gF7dMAGqsGAEAu9opvQ
	(envelope-from <netdev+bounces-286260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:15:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AAE50346A
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB9FE3017019
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 09:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5588336DA0A;
	Sun, 10 May 2026 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJ8orM6/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4566366DB5
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778404501; cv=none; b=aMK0lxNwNIRCVGLZjB09QQd8JMM7o5nu6knPPD8zOdjhjbp3LtQcKCx5iU8cJqwUAQ3cyFS8cp//0keqWVJKo63JxNjjBXTHICnn92O7yrKMP1qjNLGayvBPh64jnG7IQBvvWDim8utyZVyn4yysB3S1dFVS5EKIsRNTCuy4Uek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778404501; c=relaxed/simple;
	bh=+KCAirgd7r7eFIl2O0hGNpNJ3U6W5UCLU8KE4ODXhco=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lgjCPui72fGSjNgX88qQCh7ckzCqNSWdpNpsCgyQC4zXEwZhmmDhHcyb6UCi8HFtQxogYpoFMk3oW/FdO7XnEd3wVrDo42nLfOjWdTbjvJjiYxb/Hn5dREtlghTFDpgF1HBhnaSul+5+ynoZAgGw96eKRjpGASZ9U73KafASQgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJ8orM6/; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50e2592ea3bso7388521cf.2
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 02:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778404499; x=1779009299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOglpBhTFNNNTPCJN+FqA5y+7b269n1Bm9vi5MkWMDc=;
        b=NJ8orM6/cmQ+zb9lX49AVGokQNxMvkM7dDgvLRZTWNzR7VNe3B2aWP00sBuDhBTXjb
         8fVr6SpH8Bt7mD0+AcPlDDJx/QNt8BZ3vgElNFC0T/0JOKs080lYt31hmtYKwhq+zk+W
         4hqR4a7q4eoMfBQ2ec1d++SmN1E7JKSK7kSMFSVZ36lthKfnehLdlFbypndwmkAVCG6Q
         kX8uxZraMkYI2VcKd0hkQXSuj6BB1lcVuvUrU1fJRDTpdEQheAs0TCXvu1iMGJq8HJwA
         X9JAR6utNdt9wvv00U+kLwDjVd1ctvKJxT+JLnnC46FmWw+G4njDA/WOMrA7dbyTDt+w
         J3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778404499; x=1779009299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOglpBhTFNNNTPCJN+FqA5y+7b269n1Bm9vi5MkWMDc=;
        b=LSV0mo0sCesr47ethna+PsJcNwyt7FS0QQ/N5ax5Erm05gCHUSphSDKCTO4tFGtk89
         8bM3I1cvxrUmPT9+du4geHqBqS2V5LScoUx2w45Na2Z9+FiyuBQW2ywDgX8gOpfn1hXE
         EGP5s0xdqYW/EjvI2frzrw0tR5CifK8qKdgYYBaQ3XxKX7VXTprdvjQY4+VXtvqMZ2xa
         pfwvB95nHmIEkdCLOtCUGNNRDrmyd2rr0XLKyfDdlIZAxMEOX9i0fxavbYAJ8IleEQYO
         iGctoeFK9jMZvtcd2ae0pbNG2RzS/llsM0hB1OGTSH8Hk6S/Zg6DxCckyJNYbDqrUBKz
         bf9w==
X-Forwarded-Encrypted: i=1; AFNElJ8reB6wyP+grjydF/X6/3Imric7rgS4psVhIkHu97Ll/ACYX7RWVjEu03Q0BsJ6ZN9kkR1gmHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGMWs5B5iQVrynaTZ7ra0E3FxkWqOtTvZ10mzXQf3Sngjrhafw
	pImpRtr/lKXVphjKwTpCGKHB0xi6K/iuNB6Jomk63RTjmOaO08mkr/wnTJj5QKU8GUy8sjNxe0q
	8sIR5sfJmexZ2bg==
X-Received: from qtbhf6.prod.google.com ([2002:a05:622a:6086:b0:50f:9c36:1323])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5a9b:b0:50e:6139:492b with SMTP id d75a77b69052e-51461c3620dmr260327941cf.23.1778404498588;
 Sun, 10 May 2026 02:14:58 -0700 (PDT)
Date: Sun, 10 May 2026 09:14:48 +0000
In-Reply-To: <20260510091455.4039245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260510091455.4039245-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260510091455.4039245-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/8] net/sched: add READ_ONCE() in gnet_stats_add_queue[_cpu]
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B3AAE50346A
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286260-lists,netdev=lfdr.de];
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
X-Rspamd-Action: no action

Stats are read locklessly, add READ_ONCE() to prevent load-tearing.

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


