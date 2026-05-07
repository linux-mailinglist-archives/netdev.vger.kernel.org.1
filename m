Return-Path: <netdev+bounces-285525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKecIwwQ/WnJXAAAu9opvQ
	(envelope-from <netdev+bounces-285525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:19:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6C44EFB7D
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1A4C301BA62
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 22:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02453859DA;
	Thu,  7 May 2026 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSrFLLAv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915E1381B08
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192393; cv=none; b=dBoFT7XABat585etkE5sbAGl1DqXQtPfxGhN3npaiSYlc+nODlecRjw57WbdW4LYEEbhUmQ+Tz5tM0bmASPmZzxpfJDkLYkLnttsn6hm+antD8LyIO2TdEb/Q2hmBBmop2FKkOp2u5cP0tFFq81bJuQNuO9UH2J28I6rrVtj5Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192393; c=relaxed/simple;
	bh=qq1bvFc69B4e2REahz9uE7Y0uCS1DU49gU3TjTskWmk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rF5V+a59YPkqRYppCgRl51A3BUGx6Wjyjfvzfy+jd0TfrLrcmrrovNmSqdeDQN+sA6MQoy4C0JVXXAhAamRXON26/cVRRu0h3ETZU6GqEyxqyJhZRLCdWuYVrehYUk2FFv3h1hXhrU4+GsrOsb0guMpl1qKWi7hdZKVFkQG+Hcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSrFLLAv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7bd49a2467eso27890557b3.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778192390; x=1778797190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8NuEqfRHqQkJdW1na8Of/tbwrAKQo6V7V2W5adD6DLQ=;
        b=KSrFLLAvkNh2Yqofy59Ya0l+7zQrCf8UhlEB1LNAH4nHE2n7JwU/Sh+WEhdVLj2HKs
         qqJ3X/mGLAcMiJCjzoc/F8qtdlmjj8LyGdhY33H/CJtsmTMYgBglMGXQyQEAAozbm9Vp
         EMBM5pIZ5+VizHcVq7q4/F0+Xq97qsoV0QDtsmb7jgqJ4fHo5FUvGIpavAiwFApPsqAl
         jojsGukIH/w3f8QaSAju5qKdDJ43HwlNej39hV/Sq+QYQincdcMit66e4FP8BdCEElt3
         Ggq6cf/TCUrlO0l/0Irttk8Jso5AR1ey42vmoHSTqtfu9XvOFd1psAKKrmTWmAIT6JS7
         /j0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192390; x=1778797190;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NuEqfRHqQkJdW1na8Of/tbwrAKQo6V7V2W5adD6DLQ=;
        b=I5OdWlk9ybo+7dXHtbxi46qd1GBHRhdJ84s5YeLBJwqyHzIvElveJ4Q6JFNMfXRSXq
         zGcKO+LySJ4/bXBimbijQnPQInYG+fJfQt8CgbfS4oa+B09eVPTNXBBImi1NRdQvcgxU
         x5atXSsv74MaXZqat5aAoKUIzpV6jhA7unmdE60bEXpoyb8DXVyZfd7HmW4cAZwM0TiH
         hhWTtTCSpGXP4VT7bOsitb3cViswqAT6iB6YQgz4EMk+E8Tl5lTfiSvdxW53OrcEzMMH
         /peOnJQV53YhAEf52s+1PUNoNpwE3F+4uLoa1bpUCvdaYMlBZ7861sq8xiClJmu/CDAy
         sogw==
X-Forwarded-Encrypted: i=1; AFNElJ9UlU0rT2xbI7fGmkf5sywyXAy/wlUL6koIg/5m+IntxBO95iiCZSUUxYcy2hELUHUrNotfrY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeMloJY0FGwP9H7y1S8+kaOD0kufndkwO78nZngff7yoAi0XrL
	xPUzKwf4dYlTpRp9N4RGPAC67RqorVaxqzMep7zd2KtGcidRQZ0wy/SgqOycvZfUzNhiqTNp0MT
	n5Z57DP8dYhptLQ==
X-Received: from ywuu26.prod.google.com ([2002:a05:690c:a5da:b0:7ba:e579:5e52])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6e83:b0:7bd:7b2e:f09a with SMTP id 00721157ae682-7bdf5edb503mr105435357b3.35.1778192390012;
 Thu, 07 May 2026 15:19:50 -0700 (PDT)
Date: Thu,  7 May 2026 22:19:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507221948.335726-1-edumazet@google.com>
Subject: [PATCH net-next 0/8] net/sched: prepare lockless qdisc dumps
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EA6C44EFB7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285525-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Goal is to no longer acquire RTNL in qdisc dumps.

This series annotate data-races, and change mq and mq_prio to
no longer acquire children qdisc spinlocks.

Eric Dumazet (8):
  net/sched: add READ_ONCE() in gnet_stats_add_queue[_cpu]
  net/sched: add qdisc_qlen_inc() and qdisc_qlen_dec()
  net/sched: annotate data-races around sch->qstats.backlog
  net/sched: add qdisc_qlen_lockless() helper
  net/sched: add const qualifiers to gnet_stats helpers
  net/sched: mq: no longer acquire qdisc spinlocks in dump operations
  net/sched: mq_prio: no longer acquire qdisc spinlocks in mqprio_dump()
  net/sched: mq_prio: no longer acquire qdisc spinlocks in
    mqprio_dump_class_stats()

 include/net/gen_stats.h   | 12 +++---
 include/net/sch_generic.h | 56 ++++++++++++++++++++-----
 net/core/gen_stats.c      | 44 ++++++++++----------
 net/sched/sch_api.c       |  4 +-
 net/sched/sch_cake.c      | 15 ++++---
 net/sched/sch_cbs.c       |  6 +--
 net/sched/sch_choke.c     |  8 ++--
 net/sched/sch_codel.c     |  2 +-
 net/sched/sch_drr.c       |  6 +--
 net/sched/sch_dualpi2.c   |  6 +--
 net/sched/sch_etf.c       |  8 ++--
 net/sched/sch_ets.c       |  6 +--
 net/sched/sch_fq.c        |  8 ++--
 net/sched/sch_fq_codel.c  | 11 ++---
 net/sched/sch_fq_pie.c    |  8 ++--
 net/sched/sch_generic.c   | 12 +++---
 net/sched/sch_gred.c      |  2 +-
 net/sched/sch_hfsc.c      |  6 +--
 net/sched/sch_hhf.c       |  7 ++--
 net/sched/sch_htb.c       |  6 +--
 net/sched/sch_mq.c        | 35 +++++++++++-----
 net/sched/sch_mqprio.c    | 86 +++++++++++++++++++++------------------
 net/sched/sch_multiq.c    |  4 +-
 net/sched/sch_netem.c     | 12 +++---
 net/sched/sch_prio.c      |  6 +--
 net/sched/sch_qfq.c       |  8 ++--
 net/sched/sch_red.c       |  6 +--
 net/sched/sch_sfb.c       |  8 ++--
 net/sched/sch_sfq.c       | 11 ++---
 net/sched/sch_skbprio.c   |  4 +-
 net/sched/sch_taprio.c    |  4 +-
 net/sched/sch_tbf.c       | 10 ++---
 net/sched/sch_teql.c      |  2 +-
 33 files changed, 242 insertions(+), 187 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog


