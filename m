Return-Path: <netdev+bounces-285684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB3lGzSS/WnWfgAAu9opvQ
	(envelope-from <netdev+bounces-285684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:35:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6CA4F30F4
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1649330037F8
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 07:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C599F37C926;
	Fri,  8 May 2026 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/WeU3YD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3240732E75A
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225378; cv=none; b=EN/hXJ+LogOoudLdaGogdLTmei32PXh1EWEXU4pe4+Sk9cVbyTjXrnaKM+xTFJguC8SHVWJbMoZvX5vXYootWfk2iDoihryc6ZnYwJhn55WEJ2Qohl4bQeB1tRMNhU9OGyK7jeEWrkWHOWGJgVdHmoSnc5w+VtOC6IVi8F3m3DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225378; c=relaxed/simple;
	bh=UV3vDUx/ixtawujq7y2yE/TpVHRoU97zTaYwMc423Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3GgdBCHs9o123Y5CM560kl3mb6Ok3Ydrx5q1ycC6KzDrWud54dPEULZ0/0onznaNE2LJWY9h090BUB7nlcLZohRyPfpxtA4wQBlFdyUG9bo77arbMTJjR6wCEUGt2jZrce1dHMYllVLsonreJn5XBQwdbTLTGtMunyKKwdhX3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/WeU3YD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-824c9da9928so779052b3a.3
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 00:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778225372; x=1778830172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XjD1HhPcdD65F14qBieogarf7PMcv4Y5ezZjnzuo9jw=;
        b=R/WeU3YDpMOQ55eXsdI3PbJpfS7Vlr3JoQwvnVsYoGufFXHb7E8HUVBud3QXuPxwTG
         8Ax9SBmNnO+vSHzTLJDoq6fA+tCHq52LvK3GO3j67NDvx5vR5aGRc12l1J5ATXzEGPLM
         fdMJ6ZkdXVWpl5fQnyHf17SA0sPFNBleB0vyC3FfnEMlHcJy1egMOTABMN412yx/m+6j
         pKlVWKnIs7Eow7oKMZa6JTD71r6WzM3ZLo26o6iR0D1hEKmbp5CYwUVsY0B4IjR1h6Gv
         Lbw10Emly/PBr6dCORjgVxsBwtOA/8bdqvt0gXF3sJBYBSIy9pfrftNuitKJ2MvGWKgQ
         CATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778225372; x=1778830172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjD1HhPcdD65F14qBieogarf7PMcv4Y5ezZjnzuo9jw=;
        b=VETzM33ge5TPx4veNHCLD4HAaBZfFYgsmy9r0DlqnmYUX5jPxioni82jWg7Ola8NI4
         /bFqnvIu//ScGxk4ofP+5pT1mq810bGnk5VEDpqlyEaPDkvEkt4xravZY8YcDp49l6gu
         Aild+2oIOwnQQ950GoUu/LYl+m3NmRI0M3gT+2gSty93IWx97dVnEJMqqnLSRQMR5Ax7
         2JbW+o9jDEwY9MhDuJ4wUUzZoY/QOWhBM7aWqUsQNBGHc+VomtQThNS9e3hPce+7AyPp
         Xt4Aj03Vt8uP2ugAbdEzxQYuP9sPF37mX5M63KOJxbAoXWskSe2LCVqfrHpZhcPJ4R2V
         VAqQ==
X-Gm-Message-State: AOJu0YzqzPTVVx85PxSHqE7+1TjLJ426JNMufhNXcTNp7jVGP2K0jRt8
	YNwrJcVzvXIJz/5cFad3z5TVG3lSII+mYkDIibGEao7YsSRzdIiduKAH34dkcL5Fr30=
X-Gm-Gg: AeBDieuK0sb4+s5kF8N2OIRiZG1fPznSOyFlTbIdc1NEioAJuqxAkcvdynWSg1QjJDe
	KkiRyWW66HUOMs+aiNVK1fjIxvjMKFJQabuAA0W4O9Qf+uJDOIF9/yuG00mv/HhKfWYkZVxvb/S
	kWHM1hg3ZFl0RV6YQW3q3JKA9mGtpMnzgm84t0DVmwpHzOjsdQHh4g6Dytho7DKI2kIBD9rV0Xs
	O9h9LCXeA8GBHTC+JsXyw41wLZMebHrruGndAAeWie41JLfN1Hlqfq5nknS4HMQhL8h78azyLxF
	8VdjfxCeiWiMI/mXzBv3WbfUSpBjHr+GkH4zTFFIQq7SaPKBQaPnueDEqx2AK59YIok+dthf5Sc
	XVwCrS2KH98XEp6r9hraf4dbDJyouQTPnEBs+ozCH3H+ie1ZlmS5K+v0NQyCId8vDDvZBaedeKN
	Req80ru1b9lc59KMkTAh5g1mUtXqibuM5tLwM/Pi0=
X-Received: by 2002:a05:6a21:e082:b0:3a2:ebfc:6bf3 with SMTP id adf61e73a8af0-3aab16e6a17mr1973716637.29.1778225372273;
        Fri, 08 May 2026 00:29:32 -0700 (PDT)
Received: from vini ([2401:4900:8fc9:edb:b9ff:550d:d955:a799])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267696787sm967701a12.13.2026.05.08.00.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 00:29:31 -0700 (PDT)
From: Vineet Agarwal <agarwal.vineet2006@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Vineet Agarwal <agarwal.vineet2006@gmail.com>
Subject: [PATCH net-next v2] net/sched: sch_dualpi2: annotate lockless stats reads in dump path
Date: Fri,  8 May 2026 12:59:18 +0530
Message-ID: <20260508072918.324797-1-agarwal.vineet2006@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD6CA4F30F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285684-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agarwalvineet2006@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

dualpi2_dump_stats() runs without holding the qdisc lock and provides
best-effort statistics to userspace.

These fields are updated concurrently from enqueue and dequeue paths
and may be observed locklessly in the dump path.

Use READ_ONCE() to ensure safe single-copy loads of these counters and
prevent compiler optimizations that could otherwise result in torn or
inconsistent observations on weakly ordered architectures.

No WRITE_ONCE() annotations are added because these statistics are
maintained as best-effort counters, and the update paths already use
simple non-synchronized increments consistent with existing qdisc
statistics patterns. The intent of this change is only to make the
lockless read semantics explicit.

Signed-off-by: Vineet Agarwal <agarwal.vineet2006@gmail.com>
---
 net/sched/sch_dualpi2.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 241e6a46bd00..40035f70db80 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -1046,14 +1046,14 @@ static int dualpi2_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	struct dualpi2_sched_data *q = qdisc_priv(sch);
 	struct tc_dualpi2_xstats st = {
 		.prob			= READ_ONCE(q->pi2_prob),
-		.packets_in_c		= q->packets_in_c,
-		.packets_in_l		= q->packets_in_l,
-		.maxq			= q->maxq,
-		.ecn_mark		= q->ecn_mark,
-		.credit			= q->c_protection_credit,
-		.step_marks		= q->step_marks,
-		.memory_used		= q->memory_used,
-		.max_memory_used	= q->max_memory_used,
+		.packets_in_c		= READ_ONCE(q->packets_in_c),
+		.packets_in_l		= READ_ONCE(q->packets_in_l),
+		.maxq			= READ_ONCE(q->maxq),
+		.ecn_mark		= READ_ONCE(q->ecn_mark),
+		.credit                 = q->c_protection_credit,
+		.step_marks		= READ_ONCE(q->step_marks),
+		.memory_used		= READ_ONCE(q->memory_used),
+		.max_memory_used	= READ_ONCE(q->max_memory_used),
 		.memory_limit		= q->memory_limit,
 	};
 	u64 qc, ql;
-- 
2.54.0


