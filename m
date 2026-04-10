Return-Path: <netdev+bounces-277504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFOwNA5A2WkHnwgAu9opvQ
	(envelope-from <netdev+bounces-277504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:23:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B50F3DB6D1
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99FDD300C31F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF352877F4;
	Fri, 10 Apr 2026 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EqLUJsdV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB463DF015
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845388; cv=none; b=olc1qCErdKZU301okViETUuZFWBnzfwK2hF7dtpZk507xgvenNFBf2Ip9x90xmBsTrlJRcSV4ANjilCebcS2YpjF63sgb0NkhxXNS28+jTZ/6AhGehZA3Czk9tR1+lgKdgquhCvtD8kGk6zByueb8AlpvDVaUGmmTzoCz61B1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845388; c=relaxed/simple;
	bh=k3Z+VKm11U2wFMZp8QGVYxSRJWsJQcRXmayl9r1uU5M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ac3LOSm5xh32tq7mATo03u2pIfUJ70MO+6c4yvSbUikR5BTOci2pjrSZ9JrK4k1KdzOmzIacjLEfg/9qBLq+PRlQb8CvtLopRfnhu5N309kcb0AOuOxZsQppjmhJe7dy7Nps/am4kDRL4Qv7BjcoEbXXa3Id6SeVTqJY30RBwgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EqLUJsdV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-794b240c0d3so85104557b3.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775845386; x=1776450186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aAxQqIg+tD08hU0bo7Zc9rgyZTkeR/8JtD8kRtRkDac=;
        b=EqLUJsdVV0zrIhhUbx8k3d2sgJyE8IuWcwCbF24L+52y9eMcivxCoOIjL1Z95p2nFb
         QSCjgK9rLrsDrCaKMan0fLlDnSFqv/ML8XJD//CsHyUkBAwS8A4OVI2d4yxf+oVo1J2Y
         cuiqEoWe4SiwF/E7Cvkc/zOavCskb1xZS2KGG7DqPhA1xZxbo7UMK6E57oWomVBY9635
         4LJPnZ2z3L8IeR0rBw9ijXyYxzSDGG3DgcBTju1ewlWxLs9N7G+B71gBEp0i2g82VPW9
         /j6qS8nIhvAlHLM3btX2or9ue2wb1WOjr6FL4Vhr9oDyaJOEUzHiv88yxF66wiOgH2wO
         8nSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845386; x=1776450186;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aAxQqIg+tD08hU0bo7Zc9rgyZTkeR/8JtD8kRtRkDac=;
        b=MvhjucPkMkouI0TDQVLLISnuJENWtORdc95tqOm/Gtw7CKAgIgmxqZ0r+LXg8l3hVA
         woheA4J3c0FU6hbfUFlEgADCpNGnEviecwyTd9qXPIXEeM1OGHJXl1ryC2yJl2EXprHs
         0r7SozqENE9sh8DlRz1ZRCmEC1Xp3IlfnM3gJXRpZu7JII4CQ4IsRb7UEDHe+oo0ey/T
         UyhAdrmjwp2pWNtBv42RgrAOFKyK2QFoQL6fKqXyiaT/NKdLNMCzSRqaiLXqkc3MUTkV
         RoKZwYiLFlUxkmVCln6K/7X4PaQBckirqv9MY/tasEYZnZ+HYDXFwtt+DX3Qt1PTlwZC
         jY2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhkeXNP0AI3cJaXStaW1/2fcDClc65RIWLkC2acvL6clrgjI0Bmo3zN+jgFsY5AuoIWc4yr0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxERggm61pxoTriRCenTzYNTFLSwhJj5u61dU55cFfo0Slvrk2V
	uf5RO2IkC/FoyP7CEkLUm05kYS0uULsGAGmbIUWedGfx4VputA9rMKPCXRc+TZq8icmBODH4gcL
	jjjY5hieqoe5Azg==
X-Received: from ywbdy19.prod.google.com ([2002:a05:690c:2713:b0:796:2d2c:6a9e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6e0a:b0:794:c2fc:73b1 with SMTP id 00721157ae682-7adec6e643bmr84316167b3.2.1775845385478;
 Fri, 10 Apr 2026 11:23:05 -0700 (PDT)
Date: Fri, 10 Apr 2026 18:22:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410182257.774311-1-edumazet@google.com>
Subject: [PATCH v3 net-next 00/15] net/sched: prepare RTNL removal from qdisc dumps
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
	TAGGED_FROM(0.00)[bounces-277504-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 7B50F3DB6D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We add annotations for data-races, so that most dump methods
can run in parallel with data path.

Then change mq and mqprio to no longer acquire each children
qdisc spinlock.

Next round of patches will wait for linux-7.2.

v2/v3: addressed most sashiko.dev feedbacks.
       I think remaining problems (in red offloads) are minor
       and can be fixed later.

Eric Dumazet (15):
  net/sched: rename qstats_overlimit_inc() to qstats_cpu_overlimit_inc()
  net/sched: add qstats_cpu_drop_inc() helper
  net/sched: add READ_ONCE() in gnet_stats_add_queue[_cpu]
  net/sched: add qdisc_qlen_inc() and qdisc_qlen_dec()
  net/sched: annotate data-races around sch->qstats.backlog
  net/sched: sch_sfb: annotate data-races in sfb_dump_stats()
  net/sched: sch_red: annotate data-races in red_dump_stats()
  net/sched: sch_fq_codel: remove data-races from fq_codel_dump_stats()
  net/sched: sch_pie: annotate data-races in pie_dump_stats()
  net/sched: sch_fq_pie: annotate data-races in fq_pie_dump_stats()
  net_sched: sch_hhf: annotate data-races in hhf_dump_stats()
  net/sched: sch_choke: annotate data-races in choke_dump_stats()
  net/sched: sch_cake: annotate data-races in cake_dump_stats()
  net/sched: mq: no longer acquire qdisc spinlocks in dump operations
  net/sched: taprio: prepare taprio_dump() for RTNL removal

 include/net/act_api.h     |   4 +-
 include/net/gen_stats.h   |   9 +-
 include/net/pie.h         |   2 +-
 include/net/sch_generic.h |  71 +++++--
 net/core/gen_estimator.c  |  24 +--
 net/core/gen_stats.c      |  37 ++--
 net/sched/act_api.c       |   2 +-
 net/sched/act_bpf.c       |   2 +-
 net/sched/act_ife.c       |  12 +-
 net/sched/act_mpls.c      |   2 +-
 net/sched/act_police.c    |   4 +-
 net/sched/act_skbedit.c   |   2 +-
 net/sched/act_skbmod.c    |   2 +-
 net/sched/sch_api.c       |   4 +-
 net/sched/sch_cake.c      | 422 +++++++++++++++++++++-----------------
 net/sched/sch_cbs.c       |   6 +-
 net/sched/sch_choke.c     |  34 +--
 net/sched/sch_codel.c     |   2 +-
 net/sched/sch_drr.c       |   6 +-
 net/sched/sch_dualpi2.c   |   4 +-
 net/sched/sch_etf.c       |   8 +-
 net/sched/sch_ets.c       |   6 +-
 net/sched/sch_fq.c        |   6 +-
 net/sched/sch_fq_codel.c  |  16 +-
 net/sched/sch_fq_pie.c    |  27 +--
 net/sched/sch_generic.c   |   8 +-
 net/sched/sch_gred.c      |   4 +-
 net/sched/sch_hfsc.c      |   6 +-
 net/sched/sch_hhf.c       |  26 +--
 net/sched/sch_htb.c       |   6 +-
 net/sched/sch_mq.c        |  36 ++--
 net/sched/sch_mqprio.c    |  81 ++++----
 net/sched/sch_multiq.c    |   4 +-
 net/sched/sch_netem.c     |  12 +-
 net/sched/sch_pie.c       |  38 ++--
 net/sched/sch_prio.c      |   6 +-
 net/sched/sch_qfq.c       |   8 +-
 net/sched/sch_red.c       |  37 ++--
 net/sched/sch_sfb.c       |  54 +++--
 net/sched/sch_sfq.c       |  11 +-
 net/sched/sch_skbprio.c   |   4 +-
 net/sched/sch_taprio.c    |  46 +++--
 net/sched/sch_tbf.c       |  10 +-
 net/sched/sch_teql.c      |   2 +-
 44 files changed, 624 insertions(+), 489 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog


