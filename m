Return-Path: <netdev+bounces-277133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M5kNeMe2GlaYAgAu9opvQ
	(envelope-from <netdev+bounces-277133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:49:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 398863D000A
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 662D1300BDB6
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2592E7F20;
	Thu,  9 Apr 2026 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwndprBp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CBE3630AE
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771360; cv=none; b=VXiT7vyl8bt2tpEdvYZABA8y7QcZtqatmKvIdqrYjaZYn+M7hwXRyGe9a+N1O2akzJxRk2GrjGGpREzD2VOxYQ/wiYhw7L+b4hQ78T5VliI20jJtMOFH6QD/W/R0yFGfvibOXy9PHMfveHGaAqPzGXdPjf5Zvhz2MTCZ6p+FXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771360; c=relaxed/simple;
	bh=TV3IiMH/8wuNchToN6TFAb53yymPiKkopqrltzGjSrQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VeJyGL0j/PEO0FacfiHoxp+Svxdtw91IBvAfC3oSKvAuS8BU+0uIZUTBggoaioDKdVLp9ltssAmF3fjIO98cH95beb1X4wUJSvSAHlEkhLQzIsGnb9NTZZXP0o3cff0jRAO7UyMQ1p+4BQpAH2UO3Is7Srv//SFadKr95+Fev/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwndprBp; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-89ebd9e1ee4so30120876d6.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 14:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775771358; x=1776376158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BBBZHkDAdCP0XnRn0KowIfM19kbJXW62NexU6cHj4x0=;
        b=MwndprBpLLvZLPd8vLk2GqZVq14WxG3yKoTc8xNupbRqUJbgfCj0a88Zi9BdLubgOi
         ER0zDRifS/LmCNWQwQtZyZGIQvT6oEMbBdF/hxKH684jYJXBsC3DhKtZn9bAIX0Sc+dh
         R91gA7GG4gJgisYfGplxLisAURMvq7pA90pvAreFWdwP4Dkh6eO8g6cIVGTp4QjDfhI0
         WDC/NhRhikLQa9SpOFHtCYKTP/gc4cXFbd690Zu47OG8KEM19jDgyjQiyoJXncM3RuOY
         MpaxXQxJwgcAWtCAzpKpMc8Qtfp8op18tVVAiYtHGdbFTZB76U4zSlM0GRpqMleNTQYJ
         yybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775771358; x=1776376158;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBBZHkDAdCP0XnRn0KowIfM19kbJXW62NexU6cHj4x0=;
        b=PUE27eAStqXGc6IAtQAVkqC+HerK/4YDH6LUPBmzF40Qn1tCJWx+ygVVtPEwAU9cWf
         9WNzojtNUOO5Er5eW3C4IU4OOYK9cLpqT/l6iyaUgRPQFUVorDl7sBKdr/8JTxtOIGhJ
         ZExrdPOFxoeoftqD3l4KZoYjQWiITozaxlwFUtpJ+o0mrIqWRmyHjisj45uLIkkDBCXs
         0U35Dao6Q3GF/iDfNhfJFu0OvEp/7AsRc2A5DhsQ29vKbVZJEvQ04m/o4MFXYHDTSg3T
         zrrqZrsTD2VfQBd7EKTIw6RzE2LhQeKFF5gcjOdAzXgJSjnuHRVoDWHDpwLzJunV0tp0
         gh7w==
X-Forwarded-Encrypted: i=1; AJvYcCWiCHw3SSx9fPiYyWMoENRhIyJJ2ndtVgNyvLlmNkLeJN8IMqqkub/udZSvwXWmSEz/b4w+N6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkSyG9gHzBZ+6fJ2trGR1y10F1UCsy7L6hV5Agvp86kgSwjClX
	9FljtSxx/7Y+Wi1k/StRlFNDWAZ8NnO3hO2X/Xx4jtP7Vgp+nW4lX2vZ7FWMSvClKAjlPwD3pn+
	GJJ9Fb1ub59rm4g==
X-Received: from qtkf21.prod.google.com ([2002:ac8:7f15:0:b0:50d:b6bd:a750])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5a51:0:b0:509:44c3:5fe7 with SMTP id d75a77b69052e-50dd5d104b3mr14778441cf.46.1775771357525;
 Thu, 09 Apr 2026 14:49:17 -0700 (PDT)
Date: Thu,  9 Apr 2026 21:48:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409214914.3072827-1-edumazet@google.com>
Subject: [PATCH v2 net-next 00/15] net/sched: prepare RTNL removal from qdisc dumps
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
	TAGGED_FROM(0.00)[bounces-277133-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 398863D000A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We add annotations for data-races, so that most dump methods
can run in parallel with data path.

Then change mq and mqprio to no longer acquire each children
qdisc spinlock.

Next round of patches will wait for linux-7.2.

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
 include/net/sch_generic.h |  60 +++++--
 net/core/gen_estimator.c  |  24 ++-
 net/core/gen_stats.c      |  37 ++--
 net/sched/act_api.c       |   2 +-
 net/sched/act_bpf.c       |   2 +-
 net/sched/act_ife.c       |  12 +-
 net/sched/act_mpls.c      |   2 +-
 net/sched/act_police.c    |   4 +-
 net/sched/act_skbedit.c   |   2 +-
 net/sched/act_skbmod.c    |   2 +-
 net/sched/sch_api.c       |   4 +-
 net/sched/sch_cake.c      | 353 +++++++++++++++++++++-----------------
 net/sched/sch_cbs.c       |   6 +-
 net/sched/sch_choke.c     |  34 ++--
 net/sched/sch_codel.c     |   2 +-
 net/sched/sch_drr.c       |   6 +-
 net/sched/sch_dualpi2.c   |   4 +-
 net/sched/sch_etf.c       |   8 +-
 net/sched/sch_ets.c       |   6 +-
 net/sched/sch_fq.c        |   4 +-
 net/sched/sch_fq_codel.c  |  14 +-
 net/sched/sch_fq_pie.c    |  27 +--
 net/sched/sch_generic.c   |   8 +-
 net/sched/sch_hfsc.c      |   6 +-
 net/sched/sch_hhf.c       |  26 +--
 net/sched/sch_htb.c       |   6 +-
 net/sched/sch_mq.c        |  34 ++--
 net/sched/sch_mqprio.c    |  79 +++++----
 net/sched/sch_multiq.c    |   4 +-
 net/sched/sch_netem.c     |  12 +-
 net/sched/sch_pie.c       |  38 ++--
 net/sched/sch_prio.c      |   6 +-
 net/sched/sch_qfq.c       |   8 +-
 net/sched/sch_red.c       |  37 ++--
 net/sched/sch_sfb.c       |  54 +++---
 net/sched/sch_sfq.c       |   9 +-
 net/sched/sch_skbprio.c   |   4 +-
 net/sched/sch_taprio.c    |  46 ++---
 net/sched/sch_tbf.c       |  10 +-
 net/sched/sch_teql.c      |   2 +-
 43 files changed, 569 insertions(+), 450 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog


