Return-Path: <netdev+bounces-285227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBSoDWpn/GnPPgAAu9opvQ
	(envelope-from <netdev+bounces-285227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:20:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFFA4E6AE9
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1208300D4D9
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97CB35C19B;
	Thu,  7 May 2026 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceOPKJEz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D743D34AD
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778149221; cv=none; b=TjfxNXXyf0BEqaTpXKIn6mLsygg2JewPnAVZnz2BEWnPeo4AjdqaKUsSN142BHbvMY3SJBMZdpl7ZPnboXOR41AL81PKUAUgClaEDmTX1rr+XuWgTjbDZ7eXXqMtlgt/ELxux/+tCyALiR2p2R1QZCxN4G4lhYK2fg7wioW888E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778149221; c=relaxed/simple;
	bh=pTIS3ddteKk8VSJJdYgyLW3RXEMjDMZdMeaTc7I0pkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wdbp2jJSltcekDnWm+av/S90uFRs+Me0mTRyoNf0QVI71Hgkyp4Xy5k1dAoR5gsOB0tzDS4SKLEQdOFMDVUQO+aIrfX4UfFl8/RXMtcEwwr3Y860R6m9/tWIfCzLwONqeLIGEjMKE1EARH1AzzD9IN3mkgLxKHdscNH4FqeJwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceOPKJEz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b9ea536877so4493235ad.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 03:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778149218; x=1778754018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NGpQTvYvqnOwNGJCeLIE5VPDvaD2U3g1tZqZ1BVFSQk=;
        b=ceOPKJEztE0Dy8vu6gwu/zO+oKuWv49acEkStOBhD+F2HYDHM7i8lBnP5j5ENEE53X
         qiIuun/KMKvtebN3mm7x4hQuYWW2VbDHta2FH87b66urEqmPqb9opp6D5tJi8zyyrxf6
         w2stZJaYY0P0uafjt0cppAlkgZ2yzjuIKs0qSJt7HCdJEVY8QCkLWSq9ZJ05ixhSF/pS
         q8b88PMil8q/RIfCd3mu2xRjYPosqwg/ZuTYz3TwelqGCh/3m7aelChgohdXoF4/uu2J
         J5ecywdAVnglIxDuOx5xG1FyXvAJu0D9NuDxhxVTvLqunpc2pvSBUAHMhl5a8GsE0gBh
         LDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778149218; x=1778754018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGpQTvYvqnOwNGJCeLIE5VPDvaD2U3g1tZqZ1BVFSQk=;
        b=UllBXUqDWs9uWOzmEVsyoNHh0kVmf3pfaDwi6oiMIn+a1fkcO0dpL7/ULziWoIjxsS
         S2HSIWgj0ItQKF+6ZogXf+i8fr6fEWRlTnlcXVv548wxK54rrJfTV8/5Sw1/6czWkPJw
         5pCXi+Kz0S0jtDHo9XpKVpMrU4ggF2Hj9E9UhAnCOqXFSBOGfPmoMb3L+tl34zTSTB4A
         csxhMZSJGLSit6BdwRvasQR1hs85wnnD0QEalIktg842z0uk6sJ4ab8giBiAV4T5Cb/R
         qCe9owCfb4Nym3NfUDm2y3qcM1+N7tIw3KZkyb2a+mfmuwyzGdkttx5pYMTbA36wI9LV
         8w7A==
X-Gm-Message-State: AOJu0Yxu7sEBgRkf+jMbLzYibXQrZ0mL0GqQmwTyDoSZUT/j7ogJhXGO
	dBIbk+kjes3hYk4vWC3liXYE6fdD+XcTERYJdjBpy0ApsV4SkgRIAUbAwfSJK3vq+LcbzQ==
X-Gm-Gg: AeBDiesTzzehpfIFnRDRXM73zuU4c2Sbenizahl3w8D9W6li2P2+wwbgZJvXDesWJfe
	1fd7MzllV+JLGRDyiZzS73VU3C8vnxxuFldZckUYrKg1W3bRz/n8kFm0LT5m+lWKVtkbvj953t7
	RI5eFjr7IFaHGkMSpaOgVnoG3XyA00jLUTkytb4u7TapPPHl9oV6qpzk/TvYRGwarojj4opnfmf
	/lTM9oFpDJrGt47moil6PJ5NHjXUg+VcKK5WNVioKITMzBPgmnIR+CWyWYlBXMOTVGjzgkTYvFv
	z6ZqX9tAy23bbjlduKAmQsgzaXsueQNLfkYRnq/Eq9naEpg6xHjGbTqltZyFXEauUkDPQQYRbct
	+dRjL5iaXtlBQtJzjNogysxPb+kTYwJ/4o/OK8nME/VfYSdtSlH7Z78Diq6FWGpNlsvvVhyT7Yh
	lw49lR3Q7gsDWKII4eUoM7yek06d7onvfJ6Q2hGqc=
X-Received: by 2002:a17:902:ce0c:b0:2aa:e47d:e3b with SMTP id d9443c01a7336-2babbcf5c72mr23067595ad.0.1778149218103;
        Thu, 07 May 2026 03:20:18 -0700 (PDT)
Received: from vini ([2401:4900:8fc9:edb:b9ff:550d:d955:a799])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baba80ac1esm20431505ad.0.2026.05.07.03.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 03:20:17 -0700 (PDT)
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
Subject: [PATCH] net/sched: sch_dualpi2: annotate lockless accesses in dualpi2_dump_stats()
Date: Thu,  7 May 2026 15:49:30 +0530
Message-ID: <20260507102005.263436-1-agarwal.vineet2006@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CDFFA4E6AE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285227-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

dualpi2_dump_stats() is called without holding qdisc lock.

Several statistics fields are concurrently updated from enqueue and
dequeue paths while being read locklessly from dualpi2_dump_stats().

Annotate these accesses with READ_ONCE().

Signed-off-by: Vineet Agarwal <agarwal.vineet2006@gmail.com>
---
 net/sched/sch_dualpi2.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 241e6a46bd00..fd8d505b4688 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -1046,14 +1046,13 @@ static int dualpi2_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
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
+		.step_marks		= READ_ONCE(q->step_marks),
+		.memory_used		= READ_ONCE(q->memory_used),
+		.max_memory_used	= READ_ONCE(q->max_memory_used),
 		.memory_limit		= q->memory_limit,
 	};
 	u64 qc, ql;
-- 
2.54.0


