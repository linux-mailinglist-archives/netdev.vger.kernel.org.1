Return-Path: <netdev+bounces-276515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA4fH8ZR1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:01:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D6C3BC876
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7E2430469A8
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739423C4540;
	Wed,  8 Apr 2026 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pwsc40hJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A1718A6A7
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652976; cv=none; b=tydJ+W3Cdf7nEB+d5h8Xpvgp7NtMwX5qp4psTVHTv2INFV2+S7Q/RWRgZMO0n2qQf1USBW6EndvZEtbI2ZbsgLp16yIGxJ9+7f/0zvyRMSPTxxPsF2EQmKqJorg1Iv4DcjbEWX6snZrV6HsRyxLe0sc8xn2T3xxmuN5SzwqGF/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652976; c=relaxed/simple;
	bh=OkOs324D5UFGeJx9j0kaz1JeVe0CAsi1sQn3snBHMQ4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=exym/tb6xD4SAt63+2lWm9Ecvf4xDrBesx8db2foMScDwq4T37IvCLds88Tyj3NAVDMJTdTeWe+slkm4XW0/OPwvQCzD0KmY0CXZxlOBWyMvGSK8F3WM4gRnN+Q/IsSwOO3KnSZU/kShJHbVFCxdep0BxaAe0tyHzOZb4fyJIic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pwsc40hJ; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50d8ed08aa4so103053181cf.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775652974; x=1776257774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X3HRUBvBx+t3OSy4POcT0Q2jtaq5wPw/+bi/QpUoUKc=;
        b=pwsc40hJK8QxmOI5YQJU4b5tCHMI0RYu9j6qCMANZc1+Of02O1d3Jsb2h86hNVdaaD
         tz/t2WT9U1hFvPjiK1CSb3OAaiEBPLxEyBaGHST+B8aLJFYXe3kCtTJA+SGB1gxwlExN
         2P6eva4nsI9GV2EOBGZyJ4v3OJQXOTgbW74fLeNhMXr8ic5ttjqcxdYnIVvdHciWjHrC
         I5PXDr+CSDO1toakzYfNoVEMCEBCiOgqpzbVmTL1q4K4X7kygHN2/aEH1jbEciqllrHr
         YLCc8C98MrNQa32l/sJpyh1y8JlVjpPsRqaeue8CYqFFPYD9ZCguoNhgAmJjQasTdNKn
         q7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652974; x=1776257774;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3HRUBvBx+t3OSy4POcT0Q2jtaq5wPw/+bi/QpUoUKc=;
        b=da4L9j4HQLOI9w1gaajyH87vPtks7aN5LhQijTJOA7Ll/OMJnFXZWWKmPSwAWbCjIv
         QJxHV7wsVxu6uJQXMFvW4JtrGURpS6lnNwZW/Yd61pgpisdsS7t6+A8exi2/a3R/4okl
         H02LVEg6Xnjsv1ZeinE+2Td1m89HgcZWyFREjU/xwu67qCeAePz2g0EWr1otIUHU/J2D
         h7BnibP+CHKlwuiTn3xbkrztLXLMUDANyU/ugWPIgQHW9DiXafNeo/QPrVjgR7O3JQQK
         q0DFKZ4P9tuBA2e+GAC6O+Pijnmg5Ygxu5cfMPDoQEwObjkifnzLVTonv7Oh2Cam85L3
         qPYA==
X-Forwarded-Encrypted: i=1; AJvYcCVz9MfoPEtpoVvTN0snAVpU8N7BGibSUP9z6XJC6bHOv/4uf7igZBBL/GuCEw8Erxt77msmWts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJoxuOHcREjW7ygUqBNWTs6+PsTg18kvdd0vNUAJ+yrVKZaw7b
	8D7HATpGApI79PZV+0t9Ouq+tl2FY4rP1BJw+wXxAIjcUK16OMTUaIwuvIS1PvUSefGZl8sMAmJ
	Xk7z7AcbxZsZ5og==
X-Received: from qttt19-n1.prod.google.com ([2002:a05:622a:aa13:10b0:50d:bd90:b3e2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:986:b0:50b:3c78:de09 with SMTP id d75a77b69052e-50d62a3dd40mr309509101cf.34.1775652973671;
 Wed, 08 Apr 2026 05:56:13 -0700 (PDT)
Date: Wed,  8 Apr 2026 12:55:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408125611.3592751-1-edumazet@google.com>
Subject: [PATCH net-next 00/15] net/sched: no longer acquire RTNL in qdisc dumps
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
	TAGGED_FROM(0.00)[bounces-276515-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: D2D6C3BC876
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This (large) series bring RTNL avoidance to qdisc dumps.

We first add annotations for data-races, so that most dump methods
can run in parallel with data path.

Then change mq and mqprio to no longer acquire each children
qdisc spinlock.

Last patch replaces RTNL with RCU for tc_dump_qdisc() and the
qdisc ops->dump() methods.

Series was too big, RTNL avoidance for class dumps will be done later.

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
  net/sched: convert tc_dump_qdisc() to RCU

 include/net/act_api.h     |   4 +-
 include/net/gen_stats.h   |   9 +-
 include/net/pie.h         |   2 +-
 include/net/sch_generic.h |  75 ++++++--
 net/core/gen_estimator.c  |  24 ++-
 net/core/gen_stats.c      |  42 ++---
 net/sched/act_api.c       |   2 +-
 net/sched/act_bpf.c       |   2 +-
 net/sched/act_ife.c       |  12 +-
 net/sched/act_mpls.c      |   2 +-
 net/sched/act_police.c    |   4 +-
 net/sched/act_skbedit.c   |   2 +-
 net/sched/act_skbmod.c    |   2 +-
 net/sched/sch_api.c       |  25 ++-
 net/sched/sch_cake.c      | 353 +++++++++++++++++++++-----------------
 net/sched/sch_cbs.c       |   6 +-
 net/sched/sch_choke.c     |  34 ++--
 net/sched/sch_codel.c     |   2 +-
 net/sched/sch_drr.c       |   6 +-
 net/sched/sch_dualpi2.c   |   4 +-
 net/sched/sch_etf.c       |   8 +-
 net/sched/sch_ets.c       |   6 +-
 net/sched/sch_fq.c        |   8 +-
 net/sched/sch_fq_codel.c  |  16 +-
 net/sched/sch_fq_pie.c    |  31 ++--
 net/sched/sch_generic.c   |   8 +-
 net/sched/sch_gred.c      |   4 +-
 net/sched/sch_hfsc.c      |   6 +-
 net/sched/sch_hhf.c       |  26 +--
 net/sched/sch_htb.c       |   6 +-
 net/sched/sch_mq.c        |  30 ++--
 net/sched/sch_mqprio.c    |  69 ++++----
 net/sched/sch_multiq.c    |   4 +-
 net/sched/sch_netem.c     |  12 +-
 net/sched/sch_pie.c       |  38 ++--
 net/sched/sch_prio.c      |   6 +-
 net/sched/sch_qfq.c       |   8 +-
 net/sched/sch_red.c       |  37 ++--
 net/sched/sch_sfb.c       |  54 +++---
 net/sched/sch_sfq.c       |   9 +-
 net/sched/sch_skbprio.c   |   4 +-
 net/sched/sch_taprio.c    |  20 +--
 net/sched/sch_tbf.c       |  10 +-
 net/sched/sch_teql.c      |   2 +-
 44 files changed, 571 insertions(+), 463 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog


