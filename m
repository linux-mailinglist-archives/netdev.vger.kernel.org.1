Return-Path: <netdev+bounces-286259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id asPSJ5pMAGqsGAEAu9opvQ
	(envelope-from <netdev+bounces-286259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:15:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3E9503463
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0325B3001396
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 09:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEB4369990;
	Sun, 10 May 2026 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpZr0Cgh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3CC3659FB
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778404500; cv=none; b=dOGNn3DqLnIrj0y1kh/iaw4Ruvzy/yNpKLtLtMHnySvdEwmh4lmIG04pXdL+xdgOgoBxvb3yP6RnzWgtHFOsC3WOC39a1yhraU//pMBRwARzE85FFHJSiB+p4TO4zaFnrkEDNTQNu5d8Aj+c0USEbEXz9TQVBuEbAZG6Vdx+agY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778404500; c=relaxed/simple;
	bh=zFGpbRmXJmtISqQ6W38C0c2InPMul9jzQ0fNzX93Xbs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ltzLms4wS5b3vPPYg1kjdtfczVRGCATS5RxJASXczbde9P6HJ6AkFx6AcTVYD9NM+wB0RKLklTN6lcBUEQIUmp2YEgOlo1UY9cECfoa+rYpBU0AivWKKbJ+hF0Bolt++YeDsFWB5DTACMIjU0L2+fePD2qsuf9qztn7/UiEOwQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gpZr0Cgh; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-902e1e4f8ccso868470085a.0
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 02:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778404497; x=1779009297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tLU8kmIXcjd7Jeyv8LgTTbgS1adx/RbAwP4ogy/RtaY=;
        b=gpZr0Cgh/jvgIz+GJ9Nq5qBf7SXjReKWG0szSTisl+Yhe/v/dVW4i4tl1ALeNlwO51
         JLEt24hUoJditBOJyz/PPbmfvE/R01WTjtcQNrjtt++h0qLEPN8Jh9nDBYCJYVNAYJQy
         B9wCb/BH5ftdsrCC8m/5p3Q/o9oGQQe3PcSr5X60ddiH4RO2b8Ufvli6ObeG+ymIdjOB
         uxskK//+M2F/mooIDD+T3HBVEIbb39IQ8n1yuE3EY//RR7W5aheYsVUEMJ+kKX4SsrMg
         fvXO3g62K2DgvLaCIJbfDwq4DwHXBXEvemJesTSlVh9Qrzr7Op0GPID9rZx2U6Zccijo
         VeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778404497; x=1779009297;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tLU8kmIXcjd7Jeyv8LgTTbgS1adx/RbAwP4ogy/RtaY=;
        b=jhkGI/9gzSj9WunUKCQt1uGIZq3HO/saspP+sSoy9XUpXEiSR+G1yi/LLpyEnZnFln
         Zi7esnQSmOkn/idKLk7cgYfi/3qwBvGH5KfqLmPAcPf6i/zcQCDYc9xEoIBfIwz+N2/B
         LNV6ryaQcM/456GKFi5iIiahO8jDDTdsPLnhB6ts8U/VhLYPViARI8kBiImR8gZ9+cxY
         Kno5apBKhkADx9KRQb0DvtiT864LA1SUkBfI+pagHvbgm/z1HJVlkPvPqR3pOJnIkhSh
         FvGM3oHVs+YVLW/HiqFCPRlU/bKYaKaq7zcCpkl9d9aFM5Kv3ga4n6+LBiwiyrAYF35O
         G3Gg==
X-Forwarded-Encrypted: i=1; AFNElJ9IKIzGCtvLb0OuTlxKMARmt/OOLrRng/dpT71QG+9yqqJvlRIwC7QFR/D93TehE3AO366DIDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx50G0NSJ4keaABrECiJ6XlVPg8PMrY/SbEEbXMnavbIolvP/RB
	7eRepFOcENWxti+T/oiAri9dP3B6RouajYYxVLhbOipxE5Yk64F2h1DCdByMPaZAp7YtHbKXvAd
	g5Nqd2/pNOUqgFw==
X-Received: from qknre13.prod.google.com ([2002:a05:620a:8e0d:b0:8eb:3b7:ad98])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2982:b0:8cd:8ee1:2eec with SMTP id af79cd13be357-904d0b9d392mr2828902485a.0.1778404497231;
 Sun, 10 May 2026 02:14:57 -0700 (PDT)
Date: Sun, 10 May 2026 09:14:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260510091455.4039245-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/8] net/sched: prepare lockless qdisc dumps
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7F3E9503463
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286259-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Goal is to no longer acquire RTNL in qdisc dumps.

This series annotate data-races, and change mq and mq_prio to
no longer acquire children qdisc spinlocks.

v2: addressed sashiko (and Victor Nogueira) feedback.

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

 include/net/gen_stats.h   | 16 +++----
 include/net/sch_generic.h | 64 ++++++++++++++++++++-------
 net/core/gen_stats.c      | 51 +++++++++++----------
 net/sched/sch_api.c       |  4 +-
 net/sched/sch_cake.c      | 18 ++++----
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
 net/sched/sch_generic.c   | 12 ++---
 net/sched/sch_gred.c      |  2 +-
 net/sched/sch_hfsc.c      |  6 +--
 net/sched/sch_hhf.c       |  7 +--
 net/sched/sch_htb.c       |  6 +--
 net/sched/sch_mq.c        | 37 +++++++++++-----
 net/sched/sch_mqprio.c    | 93 ++++++++++++++++++++-------------------
 net/sched/sch_multiq.c    |  4 +-
 net/sched/sch_netem.c     | 12 ++---
 net/sched/sch_prio.c      |  6 +--
 net/sched/sch_qfq.c       |  8 ++--
 net/sched/sch_red.c       |  6 +--
 net/sched/sch_sfb.c       |  8 ++--
 net/sched/sch_sfq.c       | 11 ++---
 net/sched/sch_skbprio.c   |  4 +-
 net/sched/sch_taprio.c    |  4 +-
 net/sched/sch_tbf.c       | 10 ++---
 net/sched/sch_teql.c      |  2 +-
 33 files changed, 256 insertions(+), 204 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog


