Return-Path: <netdev+bounces-87947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBA78A5143
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA1A1C22251
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0BE7581B;
	Mon, 15 Apr 2024 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1z9GvBZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0CD2B9CE
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187258; cv=none; b=uNaPAW5HLiDo60kRNlwZ8nZmfR+qqgRZWDNWkqtH/w5SDh2rg48FLjCIqsSZQSL1Pi8ht8bVHrclfqh8TECeO+enKMigNVyA4R7nJfA53f3SlNeRi+/EKlomUhSicC+v9rXnyrhfauCsSJprtIjPmNZFw221hRz7uPe6nSfSlDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187258; c=relaxed/simple;
	bh=mRRZlFMmeWU39RtIdVFz5w8h30FqVcKjh+wdMphzK2I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L/gwPBeXqUYNF0vz1tFx3ncL10EjXBFO2JODWks8BvNWP/66EXiiubnMmUY6wXwEXO4YkLjxzJxrBn0dqInzkHUzuQytPMFYEEx0uJZW3McdlWGA3R6wB4gKaK/Wl9d+xYXUTBpbyHWy+cEQb3lSaziPk0CsP9PvN3VNWqdadnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o1z9GvBZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc691f1f83aso1225395276.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713187256; x=1713792056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nVMb4XQxlDWPU7fnX8u1os01pxIWLwcob5nQXbjSFAo=;
        b=o1z9GvBZvZ3cudCc1y4Q4pl1sKJ7oHoooDzQVouoZcL9tCirQ/YnVyvrNhk+ItPX6X
         EIEVlQJ7abVhwYYx6nqnmggTjADxuRSjS2IWnnLW566QQrRrWhm8qKOsWJ2vE37kUqrc
         83/qQOJ/7OGhOzPjZqBRtzRAfutvLFJTHAb8aRTP/R8zZJfinm7SBE2QMMLzEJmgI3R5
         9pf4+mmZchoeyL3VIqtSXWohs2w/doz3jBeu3+gOaYZKWKwR+pZlh0y7zYVeF7oKe1N3
         txnqL9199nh6E6Trc54xs+fRbGXKtbbrysQdkXtaCKalTqrlvdY3mrxwXoxtbpYGdYcw
         tHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187256; x=1713792056;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVMb4XQxlDWPU7fnX8u1os01pxIWLwcob5nQXbjSFAo=;
        b=Y4wezDRr8lUQI3TS4LrxgLUsby36upLZRiXDyWFnDBJ+99+pILjNV+EYrEM4mCTmsB
         VwGZLmaSoQuMLxeRfdC8rV8CK2ZcW9IlUSnY6lN2Cxol+z+EfRQP5YK6n4/YXhaDi9g2
         jZ1Zq63vNCSqAWKaUng0SprEl77Opoo1MrMqpzzKlmwznMxW6Rdg48nzR4BnZZnDgUjs
         FhpNTYOQlofRhNp3kKSDChbj9g52JOkyC3yNqaGKzuTwMbiiQ+Vvt5mj+XSQPNFiFUIR
         fXKbfD6sjrjhZXrLax100J6sfvHIegnf9W7xvVzoNttTv1gUFhILcPpI/iMIHx5RU1/5
         5yNw==
X-Forwarded-Encrypted: i=1; AJvYcCWliL26rptuWpgzSb0cyVfEtraLYtw3rx4Xm5uZJt9ICvLqPxGqDuj3jQDY227MOpg9Fn5NBk7R5zlIkNh6WGYLKjN15/7+
X-Gm-Message-State: AOJu0YxDhtcvV77kWZ2PUVcztVbKkVnV8AGgZRRvTBFEtjDJaxdRxF0Q
	IIvbKpqTqAUQ1SQMX//Z7j5AK/TUCl6BonkvLSK1+5s4yh9M/o85oQfAhVsrrEONMoN0CwKSL+r
	lg5lmEum41A==
X-Google-Smtp-Source: AGHT+IH+WM0JpLBDjNSln/X7O3Pfs/n0o08lq415lUDsjghD81I+RLY7kRiP1N1dcdkmKK1QZdwtgKZMx4OHhg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:e0ce:0:b0:dc6:deca:8122 with SMTP id
 x197-20020a25e0ce000000b00dc6deca8122mr2471720ybg.5.1713187255745; Mon, 15
 Apr 2024 06:20:55 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:20:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415132054.3822230-1-edumazet@google.com>
Subject: [PATCH net-next 00/14] net_sched: first series for RTNL-less qdisc dumps
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Medium term goal is to implement "tc qdisc show" without needing
to acquire RTNL.

This first series makes the requested changes in 14 qdisc.

Eric Dumazet (14):
  net_sched: sch_fq: implement lockless fq_dump()
  net_sched: cake: implement lockless cake_dump()
  net_sched: sch_cbs: implement lockless cbs_dump()
  net_sched: sch_choke: implement lockless choke_dump()
  net_sched: sch_codel: implement lockless codel_dump()
  net_sched: sch_tfs: implement lockless etf_dump()
  net_sched: sch_ets: implement lockless ets_dump()
  net_sched: sch_fifo: implement lockless __fifo_dump()
  net_sched: sch_fq_codel: implement lockless fq_codel_dump()
  net_sched: sch_fq_pie: implement lockless fq_pie_dump()
  net_sched: sch_hfsc: implement lockless accesses to q->defcls
  net_sched: sch_hhf: implement lockless hhf_dump()
  net_sched: sch_pie: implement lockless pie_dump()
  net_sched: sch_skbprio: implement lockless skbprio_dump()

 include/net/red.h        | 10 ++--
 net/sched/sch_cake.c     | 98 ++++++++++++++++++++++------------------
 net/sched/sch_cbs.c      | 20 ++++----
 net/sched/sch_choke.c    | 23 +++++-----
 net/sched/sch_codel.c    | 29 +++++++-----
 net/sched/sch_etf.c      | 10 ++--
 net/sched/sch_ets.c      | 25 +++++-----
 net/sched/sch_fifo.c     | 13 +++---
 net/sched/sch_fq.c       | 96 ++++++++++++++++++++++++---------------
 net/sched/sch_fq_codel.c | 57 ++++++++++++++---------
 net/sched/sch_fq_pie.c   | 61 ++++++++++++++-----------
 net/sched/sch_hfsc.c     |  9 ++--
 net/sched/sch_hhf.c      | 35 ++++++++------
 net/sched/sch_pie.c      | 39 ++++++++--------
 net/sched/sch_skbprio.c  |  8 ++--
 15 files changed, 306 insertions(+), 227 deletions(-)

-- 
2.44.0.683.g7961c838ac-goog


