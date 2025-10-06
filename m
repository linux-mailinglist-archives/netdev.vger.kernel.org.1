Return-Path: <netdev+bounces-228018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3479BBF18A
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 21:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1E694E22FE
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 19:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FC01A83F7;
	Mon,  6 Oct 2025 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yNoKA4KK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B846EEDE
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779068; cv=none; b=XXL0d7NKjVes9TyB/IwXTOU4YLXWcdHMGgDW8ykR2o2vxxXDpnwt43QjWQIg5e/OQScMr8U4PR1JDqzhaf2ZEhlKpmTMoZUhxeds9zeXMD9D2YRtS4gJuXfKHcZbtvjCvPv2T9Ievpro58WpoR2ii8aVdCLXeqH+QvR0tUfsjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779068; c=relaxed/simple;
	bh=B264UE+siYOOF03S6Rq/Ksnv16F7Wcyt8/lnsmRwce8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mjWfTvA/hIQ04kk0pklBeAf6Xz4rY5XZt+m29NroFjjNRJcBcKDziZf+qaMowJmdl8vWRPMTWOtjPuhaDnevET/Oq19UbfMLMBRd65p87nsAEeXVzyyWnqsDsKUPO4y8OZqww1YTKIyhAv5ZVjB0IajPn10kLVKfjBUpj56n6gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yNoKA4KK; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4df80d0d4aaso84909201cf.2
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 12:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759779066; x=1760383866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rNdRvap89ID50VX7ju9SZ9t1Ke/o82spySdIkUQDxZo=;
        b=yNoKA4KKTfRaQWlkPC3QOkRhpuEOa3Q/Cr3A4cEa/KHG6Yk0ltwZluAF6sCMwYt/uw
         PNEJFcg0jj9af/9gneca6VAM8QTawzVVKxzIZfbD626uHrsenLJeiIu+PbtVszDTvRJ9
         YM/Gf663GV24aPFcUxo31Y1pwTOVMhaOx/qpr5CPiU9vLgejw3Vz0447GB/HaIMxHkJy
         fqpE9RnUyBqUzuUJztOoUOtUbPEeX6u+5zPvZkoNr/KK8AdyD027Dy547KBeeeRGNwkl
         AU0TBPphTy9AMKCPQMxf0OI8x6gulBqfxnavWch3KbuUYqmPifoSS5GMdv8xos6Eg/mT
         hiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759779066; x=1760383866;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNdRvap89ID50VX7ju9SZ9t1Ke/o82spySdIkUQDxZo=;
        b=n8Mb8Z/zDp3uxcau6GcYqOPaLsHGtBlAnoOzIGAtBfxZ4Dih0EvIHMG1CAkulziczE
         oHftBUUkCeheRaMjvhMVKhoNFrJY4n7z9PQUOBLCKpF/qwLUJ2heAodmEzdaFxdZNXqQ
         BE/XIbSuaE4cCN0nibBuW48aPHWJ3C2Xij+IdorAK+ScL9+9RwOIpJdqsVaIJoH3Zcxo
         1wDpd08ZVwy6nUdCGW7ZwhRB48yGpvAlaiOHfVbiAYHNPSHSFafs/ZYjZ3AJFaBQwLVa
         oMTKim3tbuQxO8ZaDzHgyxeLbJ67tHHuLEr2JC+mwM2CHsr9v9xX4exK1TMXD+4Nls8d
         /jOA==
X-Forwarded-Encrypted: i=1; AJvYcCWMZyecRH/snTJsOgWQjbJYbfYJQRAyvauhWPQStJ/qEqNlNoje4UQazUvA7p98C2mNYU1KUOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykCGDF/EbMnpQ5fxN44YNi8cc9NY+YhAEm/GnpkCBJAlpfdfy8
	wl5y1vuGwjjn/x7lqG4xRBT6KRtIsxn7+Ly0ZkhlpJ4XSYlfmPDWpj6uFYZ+wXKOLt7+tSUZfWk
	fjNeiYxU222R/UA==
X-Google-Smtp-Source: AGHT+IFvayjUiJfllaehnI8cfvvmovlVx3M5UkHMYXVCBppG/RbUNSUFRla4PWE2pPzLhe5MhahI0pbry6SgYA==
X-Received: from qtmr8.prod.google.com ([2002:ac8:4248:0:b0:4b5:ffbe:2eff])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5c0e:b0:4d2:db77:a652 with SMTP id d75a77b69052e-4e576a40fa3mr182598401cf.8.1759779065802;
 Mon, 06 Oct 2025 12:31:05 -0700 (PDT)
Date: Mon,  6 Oct 2025 19:30:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251006193103.2684156-1-edumazet@google.com>
Subject: [PATCH RFC net-next 0/5] net: optimize TX throughput and efficiency
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In this series, I replace the busylock spinlock we have in
__dev_queue_xmit() and use lockless list (llist) to reduce
spinlock contention to the minimum.

Idea is that only one cpu might spin on the qdisc spinlock,
while others simply add their skb in the llist.

After this series, we get a 300 % (4x) improvement on heavy TX workloads,
sending twice the number of packets per second, for half the cpu cycles.

Eric Dumazet (5):
  net: add add indirect call wrapper in skb_release_head_state()
  net/sched: act_mirred: add loop detection
  Revert "net/sched: Fix mirred deadlock on device recursion"
  net: sched: claim one cache line in Qdisc
  net: dev_queue_xmit() llist adoption

 include/linux/netdevice_xmit.h |  9 +++-
 include/net/sch_generic.h      | 23 ++++-----
 net/core/dev.c                 | 91 ++++++++++++++++++----------------
 net/core/skbuff.c              |  4 +-
 net/sched/act_mirred.c         | 62 +++++++++--------------
 net/sched/sch_generic.c        |  7 ---
 6 files changed, 93 insertions(+), 103 deletions(-)

-- 
2.51.0.618.g983fd99d29-goog


