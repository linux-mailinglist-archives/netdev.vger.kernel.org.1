Return-Path: <netdev+bounces-205328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645EAAFE36C
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660703B315F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F72820D7;
	Wed,  9 Jul 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVymaxie"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0131281525
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051728; cv=none; b=gQJbL/MrZIWKAgZscUcIS71nxm9Fqc5AX8PcP0ZudC3H21HG+JttY8UbAoUYsDIYs+gPrymjPuos5eXGZOKCQySacsNVfyecuSCdS2YSUvLvG2YIXNq2v1a8rBB5+Lznc4LZGrUi51zaY/xqZL154OvfXueBVvJqcc846uBFMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051728; c=relaxed/simple;
	bh=atmiDJrboOkfDDWO6nD1oGjW0CRX7ox7eJrX2CM+8aQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EbBgQXnHZX/pJV8udqQt6g/0qL1lnSkpblZyqp2gKishQvG+yz1RhEKdZ1/bGO7ZUxhzJ4W/bCaMFZsd8MPjda2cvz2nRz7TJ1gLMwrJ3t3+101+YM0FdC5gW/jsA+JcK5HHBw882tzhggzSyQkNZUWetn+0sNw+mIc6c1PzgFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XVymaxie; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a587c85a60so105191941cf.2
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 02:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752051725; x=1752656525; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vrm1hxP6Wd3QsuOErDQZsOg+RCEgzZAvuYkGG75xjDA=;
        b=XVymaxieUBU3oj0E+KZpMfVx2xros1NrQpJWpENt568TmLbznNfRyVWnr/HysmdElQ
         QMLUCznDxlSfoIq2OYHY2m2GtTH+qWPkqBlvwdgDjQUGrzz6Ze43CgPqkhDXQ3F8x72F
         UcROkd3Q7cIUAADmYUSOVtlIsd/DF0tXRJ9rnK7baMmsepqgH6qv1gns4LZiuQgwWPDY
         rNJlj70qYMnJFCxeDeiJdbHtUc0qZe1vBkraDK/uDp9rZNA2gItF7T7btv5lovBA4+Cc
         imLhN12jK/P9iQzkQT9gmJaRK7v5iyS4s+TaGwD2HTi23K9eh10XmRA6x3JlnZ948bqu
         DtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051725; x=1752656525;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrm1hxP6Wd3QsuOErDQZsOg+RCEgzZAvuYkGG75xjDA=;
        b=VWZzlwfDrMAj55SNLbEnlm/NeynrNn5orwACa0re+Da6EriGwmBuAu3omygBP3ppTP
         xgVpHIymWn/XHS4aFF1FNzNVj7bs+s1fmt9exu5DOCdsp6YAI2qmHlr+CYBIP4K+UQ5/
         ohPVDXwN1L2hmy19Y27H3Is3iTfs5VP/lCjFV0R4yhz/bmZSuskzbK3y7EmAIecmzUzY
         itg9Cp4NXUY/oNfSOnab46hHC6dX3E/kFdaMPy8KvXC/RAo61cGyOCTC3Vy2KzkLcren
         l+1I6ibnIamtU2qD5QMgYqDlF0IyamzX/PJVIklCmwA10mfVLbmWFhBDZJRyi1rxJl8v
         Y19Q==
X-Forwarded-Encrypted: i=1; AJvYcCXi1ceNyPmxM7HUMH+Qztct9Rn+WBmze5xHXxjZYnTMM97fjQ7KP0m7QHB363aK331mFkm/Z54=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDo9yA7CNMv8cydx5m4eB+U53nK9IJqO7TNYs6NXNLrELN7Zt/
	L32GGzsH9yv3zcPTaEBA2iOEMQXyKNi+6WAJS0Mwiy+EUlQ0hBFjbdbT78zm1jCIVPzU9qDYHsb
	ZP4NxEC65aG+/ag==
X-Google-Smtp-Source: AGHT+IE/ODqGORu9/AYKJzuU0oKrYtbH4Etl6ybBFOzJowUE0afQgHd6ra0n+m7FDgzv6kim59XN1rbBRxzB+A==
X-Received: from qtbgc14.prod.google.com ([2002:a05:622a:59ce:b0:4a7:6291:94f0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:15ce:b0:494:f1e7:65ef with SMTP id d75a77b69052e-4a9ded33fe5mr29317501cf.44.1752051725534;
 Wed, 09 Jul 2025 02:02:05 -0700 (PDT)
Date: Wed,  9 Jul 2025 09:01:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709090204.797558-1-edumazet@google.com>
Subject: [PATCH v2 net-next 00/11] net_sched: act: extend RCU use in dump() methods
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We are trying to get away from central RTNL in favor of fine-grained
mutexes. While looking at net/sched, I found that act already uses
RCU in the fast path for the most cases, and could also be used
in dump() methods.

This series is not complete and will be followed by a second one.

v2: fix act_nat patch (Simon)
v1: https://lore.kernel.org/netdev/20250707130110.619822-1-edumazet@google.com/

Eric Dumazet (11):
  net_sched: act: annotate data-races in tcf_lastuse_update() and
	tcf_tm_dump()
  net_sched: act_connmark: use RCU in tcf_connmark_dump()
  net_sched: act_csum: use RCU in tcf_csum_dump()
  net_sched: act_ct: use RCU in tcf_ct_dump()
  net_sched: act_ctinfo: use atomic64_t for three counters
  net_sched: act_ctinfo: use RCU in tcf_ctinfo_dump()
  net_sched: act_mpls: use RCU in tcf_mpls_dump()
  net_sched: act_nat: use RCU in tcf_nat_dump()
  net_sched: act_pedit: use RCU in tcf_pedit_dump()
  net_sched: act_police: use RCU in tcf_police_dump()
  net_sched: act_skbedit: use RCU in tcf_skbedit_dump()

 include/net/act_api.h			  | 23 ++++++++++-------
 include/net/tc_act/tc_connmark.h |  1 +
 include/net/tc_act/tc_csum.h	  |  1 +
 include/net/tc_act/tc_ct.h 	  |  2 +-
 include/net/tc_act/tc_ctinfo.h   |  7 +++---
 include/net/tc_act/tc_mpls.h	  |  1 +
 include/net/tc_act/tc_nat.h	  |  1 +
 include/net/tc_act/tc_pedit.h	  |  1 +
 include/net/tc_act/tc_police.h   |  3 ++-
 include/net/tc_act/tc_skbedit.h  |  1 +
 net/sched/act_connmark.c		  | 18 ++++++++------
 net/sched/act_csum.c			  | 18 +++++++-------
 net/sched/act_ct.c 			  | 30 +++++++++++------------
 net/sched/act_ctinfo.c 		  | 42 +++++++++++++++++---------------
 net/sched/act_mpls.c			  | 21 ++++++++--------
 net/sched/act_nat.c			  | 25 +++++++++----------
 net/sched/act_pedit.c			  | 20 +++++++--------
 net/sched/act_police.c 		  | 18 +++++++-------
 net/sched/act_skbedit.c		  | 20 +++++++--------
 19 files changed, 133 insertions(+), 120 deletions(-)

--
2.50.0.727.gbf7dc18ff4-goog


