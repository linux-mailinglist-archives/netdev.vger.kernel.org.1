Return-Path: <netdev+bounces-89017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F568A940D
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DAAEB21E1F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7753C473;
	Thu, 18 Apr 2024 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JVRLIHxD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0F7441A
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425573; cv=none; b=d0sxkkFAS4cOdMMpXel6Nnv5Qp0jqD1Sw9T2Rx2DHgaUS81r4muNtnJIh2zyNVbqxyXx0jMw5pbmRPzDhC8jFGLePM3dR0FyQR+CmRqywZSbFxOvnxEUmLaAUjIsNceDnsT3r+aeJZ5NALPU4WfhVoV/DQP4vFRx5o2Kw72Cx3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425573; c=relaxed/simple;
	bh=SJQuaahuFCL6UoxEDhB5oFCltamuJtFBv2+9yo16u6c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WjOy8ogd+LjRcwU/zT2IOGDwMk6VlirHqkmTEYOxQGz0Gr+7tPs6txxUp5EEMGSe8WpBprpyrLPipdkVXBdg7fCBIOSgVz6xllzEABwdANfq+qVmC4pytiyz+1vWIxvfVt9fhdzsasj7TAy6x8nel/u1Y7eANM1+VbccICRAhMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JVRLIHxD; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de45d0b7ffaso1225893276.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713425570; x=1714030370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0hx205bFsl0ohGBFDqw23KLOf+Sl+qO0ARfcDuNZ0YM=;
        b=JVRLIHxDknw2Bjh2YixWk1lRLKsuslbmG2Jx+BrXF+H42dIyVAOxiYdOMTc8Cq0uPL
         YT+/0p8Yph1/W5ydjvnmmIU3h0wvVHA+/ycOqPf44ccfEQ9YAPdta9xkxog4vxALObhE
         z3469Jy3lTsAShm/mCu0QZETJedPcWSfT1PuMlujOIWUPzAiI79CDHncUPiUaAmUkLtm
         8pTwSd3jbtrK3ohvxMTR7PHZ0Ak4cbUMUjdKoMgEpNtdGwTEpcNi3KF9Uz3YBleg95S0
         13i2G8aYOIURvCmotupLn6IFJo4Rj9NqEhyyYt7yVov1rVSVIdWLqzDSLyVi28YRNo+5
         UjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425570; x=1714030370;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hx205bFsl0ohGBFDqw23KLOf+Sl+qO0ARfcDuNZ0YM=;
        b=nv1/uPfwtcJ73R0K48+v0Gz18LRWyrdy2FObFg1ABLUmFETDkrBmGh8QlbCD1cAahz
         k/L45N3NS9YRTyy6tkHCdft6vbcAq+gtN8SZf0+P0ltOI+S227KB+Tb5uJK8L3Cx3R+g
         im7N2kRNosfHaRpxxBE4zhOwRoyPiGLO9fRxBM1s5+FW63aZ9g/KPTjvctNuK/QaYFCO
         kc/tlertsyxeXek7vZ8gmGM5bRZ1Qsb7SLXHF+GF4+DhpBrzIRZY+HebeXxDilrdrxeE
         jS07UiXpdEh0gRZ3obl7j2g9dcatUZBREa5hlN4M0n+W562NQA3edho8kkb/3bhD8s54
         iEOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVteJutEo6JLtwhTOdZBnw+x07ijFEc6jFjJVoTh3u4xnjgjbyxNiRKYwFEQ2uvt4iuxypUQ/Aaxil9gzx+Cl3w8ouOpp4h
X-Gm-Message-State: AOJu0YzhBHTwbN883rW1TCjYYDpKyFPAe0IFuvlgg9Yr1D2FL3j4WPrp
	CGTXYit9835dv5GgYSfm9SEEErlVgAtbO1+/+3qrjvnOWuFMoVddCKsjf2aWddjhSSFFluh27Pf
	scET1u8Is1A==
X-Google-Smtp-Source: AGHT+IGi3jCk5Zv7vIKnjyXNkVRfIc2jyjv32ANioZZHY9PtdFDz9OMAIPI4ogd0RMAC50bVcSqMlqbnM/fU+A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1083:b0:dbe:a0c2:df25 with SMTP
 id v3-20020a056902108300b00dbea0c2df25mr166148ybu.8.1713425570661; Thu, 18
 Apr 2024 00:32:50 -0700 (PDT)
Date: Thu, 18 Apr 2024 07:32:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418073248.2952954-1-edumazet@google.com>
Subject: [PATCH v2 net-next 00/14] net_sched: first series for RTNL-less qdisc dumps
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Medium term goal is to implement "tc qdisc show" without needing
to acquire RTNL.

This first series makes the requested changes in 14 qdisc.

Notes :

 - RTNL is still held in "tc qdisc show", more changes are needed.

 - Qdisc returning many attributes might want/need to provide
   a consistent set of attributes. If that is the case, their
   dump() method could acquire the qdisc spinlock, to pair the
   spinlock acquision in their change() method.

V2: Addressed Simon feedback (Thanks a lot Simon)

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

 include/net/red.h        |  12 ++---
 net/sched/sch_cake.c     | 110 ++++++++++++++++++++++-----------------
 net/sched/sch_cbs.c      |  20 +++----
 net/sched/sch_choke.c    |  21 ++++----
 net/sched/sch_codel.c    |  29 +++++++----
 net/sched/sch_etf.c      |  10 ++--
 net/sched/sch_ets.c      |  25 +++++----
 net/sched/sch_fifo.c     |  13 ++---
 net/sched/sch_fq.c       | 108 ++++++++++++++++++++++++--------------
 net/sched/sch_fq_codel.c |  57 ++++++++++++--------
 net/sched/sch_fq_pie.c   |  61 ++++++++++++----------
 net/sched/sch_hfsc.c     |   9 ++--
 net/sched/sch_hhf.c      |  35 ++++++++-----
 net/sched/sch_pie.c      |  39 +++++++-------
 net/sched/sch_skbprio.c  |   8 +--
 15 files changed, 323 insertions(+), 234 deletions(-)

-- 
2.44.0.683.g7961c838ac-goog


