Return-Path: <netdev+bounces-204574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4029BAFB3CD
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E85E1AA4300
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DFC29B8CE;
	Mon,  7 Jul 2025 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RRMSX6UC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375F929ACDD
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893283; cv=none; b=llw9yERnLmHfBjYgwGpRuydPpogqG+tmBdX3E7DhaCaiQ/0Ydv8TydO6wt+g8aLfRA+gXV5C2fGSSTY9aUw4pBbqfHNkDH8EQpo3iqiG2xRHbzQBdGLEo6IrJWX2V3ZsUGgKye27rGB3GwsGWnTKDW8wTsgRvgzROdepfxYG8qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893283; c=relaxed/simple;
	bh=rHUaWYehaV3SXzIPuKqlkmn5W/0hMR+XRlmChi6u0eQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MtbLe5Af0kEDpofGbwc3HkO7SQodaHm7n0TJJz0UQKOwiPoU5os4QTTYZDcYWwiTywjmxJlb5YbHbbC3Zd4MHXhPBdOTXaEjmvqVnCkAmHcI7h0pfgJrH1qiiTljO9EJZQC0FfPNRN2+dHBBWjmrokK59b00L7fp2Nrf6TRlLUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RRMSX6UC; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a6fb9bbbc9so95542771cf.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 06:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751893280; x=1752498080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KFLPcquzAzAcFobjEI2/GPU6G6Q1aopeHejEHX50vpU=;
        b=RRMSX6UCUMHmIFqWh7swLOFNDqOXuziLCOctsYlVAfYBQ/EgPL/riKZDdkYFN1IE9z
         Rs1XTCb0sJJqwpI7eT/Rb6YKEGqqPAWfStSgIoeabJMvQ4lHztedqyb4b1jRRwki0mCb
         DMci4ctD47nWgShIEEEusZJupaBPrhwDkGZ+gDOWpbiz6ag2OaLJWtKblFuyrnRKGeCm
         NqN80TPCy4ZJSIo8LGCjg17seXb6rskv4Gzgr4TemDSzZFasAkU6yxkj7Ifgam3ZURby
         dKtyJe4Sivk84LMkJZlbB1FRlyIdOEdRwWx5FiKPa8mn91wgcca2oCz+cAWVUasVMAVR
         tlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751893280; x=1752498080;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KFLPcquzAzAcFobjEI2/GPU6G6Q1aopeHejEHX50vpU=;
        b=DC24KkQZt5tOT5klzzVq2RNFP8pbnTTqYnwHC7qzSOdCYRyuVVY6CNtTLr/F2aupye
         6Ii6Xr/pC3FHxMLXXJLvphku42j9/wxAdbKKj3nuY4UgSFqfxW3RMIYHTQeGV56L8YhS
         F75BUgOGQtsd9uH6lJsStUMlUi2taKGkMdzEILK82Hdb7TvQ6LczBp4q7ARIYT3e8Zzf
         nIQsj84YOl1xQ+oesNxvMBP79+YVxK0uoLWVweCNGHwgPPD0HmmJe+8oIUVXjtoSCJWt
         r9iEWj0hARt7wxZNNDlSiipH+SF6xOCI7DJUvH2apSXiFhEr2ZxyVV2rrI3SGINSq9eV
         l3Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUpGuM9zO0CU/go4Wx48k4/lP3QP+RZ+tp38h+GjxzSuTKdh1GSzYCSTStxW1SHdQ8+kT3RjDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweZ/8TRNXVkfZTGxAP5mGKeN1OrjMpYyPTa12cQj/bau+AKoUL
	PTTwcZ46AiBpXi69VuMW1MKzfHzM0WM03P/LHA7N9+erD8yXkSgBj/q7Pe5YJTM0hed6+RjHZwe
	aMWp+5Liug30sLQ==
X-Google-Smtp-Source: AGHT+IFpmr3kDgk5owG1vxyV0rS93GDk+LLqkWh2twxyV4eewzKwdj4SdZ6L0tOVg7P7sXubaX+FV9hLCkH5tg==
X-Received: from qtbbl10.prod.google.com ([2002:a05:622a:244a:b0:4a7:13da:3dea])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7f47:0:b0:4a7:22fd:682f with SMTP id d75a77b69052e-4a9a68c1692mr144285031cf.3.1751893274560;
 Mon, 07 Jul 2025 06:01:14 -0700 (PDT)
Date: Mon,  7 Jul 2025 13:00:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707130110.619822-1-edumazet@google.com>
Subject: [PATCH net-next 00/11] net_sched: act: extend RCU use in dump() methods
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

 include/net/act_api.h            | 23 ++++++++++-------
 include/net/tc_act/tc_connmark.h |  1 +
 include/net/tc_act/tc_csum.h     |  1 +
 include/net/tc_act/tc_ct.h       |  2 +-
 include/net/tc_act/tc_ctinfo.h   |  7 +++---
 include/net/tc_act/tc_mpls.h     |  1 +
 include/net/tc_act/tc_nat.h      |  1 +
 include/net/tc_act/tc_pedit.h    |  1 +
 include/net/tc_act/tc_police.h   |  3 ++-
 include/net/tc_act/tc_skbedit.h  |  1 +
 net/sched/act_connmark.c         | 18 ++++++++------
 net/sched/act_csum.c             | 18 +++++++-------
 net/sched/act_ct.c               | 30 +++++++++++------------
 net/sched/act_ctinfo.c           | 42 +++++++++++++++++---------------
 net/sched/act_mpls.c             | 21 ++++++++--------
 net/sched/act_nat.c              | 25 +++++++++----------
 net/sched/act_pedit.c            | 20 +++++++--------
 net/sched/act_police.c           | 18 +++++++-------
 net/sched/act_skbedit.c          | 20 +++++++--------
 19 files changed, 133 insertions(+), 120 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


