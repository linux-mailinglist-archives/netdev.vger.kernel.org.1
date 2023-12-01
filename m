Return-Path: <netdev+bounces-53101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBE18014B8
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 21:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4069C1C20A6E
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 20:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D842629C;
	Fri,  1 Dec 2023 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="3OFa4kHT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354EEFF
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 12:43:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28659348677so816181a91.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 12:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701463418; x=1702068218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yQePDAVtqlA0TnF3guE1EYTqQ7Uy6jv2L2LXnjupLU0=;
        b=3OFa4kHTwngD8ni5LzIvueovCIEaHnJb+/Oj7OsfXdnwSGvvaty4y98uWqyb9dJQh0
         BQLJK0P2sZqg2k+sv9t22X8B4fJspV+zaFM9d0vbO+AqCUN7JxXbBBwQBxHU7VE5He+o
         FuBR+hvgWJ1aSy/LcweIGgIphbNMOH34Qeyk7RL+/c8jtBMcoC5NtvMKkkwHLOOV2vub
         Lki53Yd1EWVmdwzSRhOJzMVJ/uPCJJ6GmmzzANk/5Af2FE48bIkMaDUppNxO2SN0oRUW
         iB0N/0AeFWOTjdudWj8XUAuP/v2La62fXsnTsjXA1zmciZqh1LdJURxb0589/COBKqu8
         IM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701463418; x=1702068218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQePDAVtqlA0TnF3guE1EYTqQ7Uy6jv2L2LXnjupLU0=;
        b=Xs5S2pVazV9SVaJI+Tm0cThnuWsKrm1tlhxK2oA/0l/xkNw0lKTOaf79Jp9luThapN
         v/x/mnGdGWWOPC7eV6NQicKjX1Eo/re8cUVRUXzx8tayJVBjyHy+elrfp9XPYLA7U7t/
         92D9/HRbYVAxrNeKhUlAEE/NSCvyENECfDDB4P7L3rPAk8pR9OgxNDNll+roH5Qit8z+
         0Zy2pi5LFfNjDXFg2s59P9QmEQgv1LEdzeNLyFKnJS4LLWvMMGU3x7qf36FYkFLgTRym
         dT65Fw4YWddLcMFYnZPbnr4F0+BxCuus23DRLW+By6rK7qqiYLi4c+eMZCIu9G2H7thA
         DqIg==
X-Gm-Message-State: AOJu0Yz5zqDrKPtUpM1c48ZDye8V6EH7nxrwSjMu59EENmzpprN6Jgmu
	k1evJODLikTF1H8HKjgQYEPegcCBqWo3dog0LNo=
X-Google-Smtp-Source: AGHT+IGf6yKSarHJUBWyCkQhr7u1RFDbFJQ+FGTcYUFlZZzFzzvTtFPDW2HIBYAOHqW0yxrL397pAQ==
X-Received: by 2002:a17:90a:f016:b0:286:44ca:425a with SMTP id bt22-20020a17090af01600b0028644ca425amr188001pjb.18.1701463418377;
        Fri, 01 Dec 2023 12:43:38 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id mz18-20020a17090b379200b002865683a7c8sm1933467pjb.25.2023.12.01.12.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 12:43:38 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	marcelo.leitner@gmail.com,
	vladbu@nvidia.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 0/4] net/sched: conditional notification of events for cls and act
Date: Fri,  1 Dec 2023 17:43:10 -0300
Message-Id: <20231201204314.220543-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an optimization we have been leveraging on P4TC but we believe
it will benefit rtnl users in general.

It's common to allocate an skb, build a notification message and then
broadcast an event. In the absence of any user space listeners, these
resources (cpu and memory operations) are wasted. In cases where the subsystem
is lockless (such as in tc-flower) this waste is more prominent. For the
scenarios where the rtnl_lock is held it is not as prominent.

The idea is simple. Build and send the notification iif:
   - The user requests via NLM_F_ECHO or
   - Someone is listening to the rtnl group (tc mon)

On a simple test with tc-flower adding 1M entries, using just a single core,
there's already a noticeable difference in the cycles spent in tc_new_tfilter
with this patchset.

before:
   - 43.68% tc_new_tfilter
      + 31.73% fl_change
      + 6.35% tfilter_notify
      + 1.62% nlmsg_notify
        0.66% __tcf_qdisc_find.part.0
        0.64% __tcf_chain_get
        0.54% fl_get
      + 0.53% tcf_proto_lookup_ops

after:
   - 39.20% tc_new_tfilter
      + 34.58% fl_change
        0.69% __tcf_qdisc_find.part.0
        0.67% __tcf_chain_get
      + 0.61% tcf_proto_lookup_ops

Note, the above test is using iproute2:tc which execs a shell.
We expect people using netlink directly to observe even greater
reductions.

The qdisc side needs some refactorings of the notification routines to fit in
this new model, so they will be sent in a later patchset.

Jamal Hadi Salim (1):
  rtnl: add helper to check if rtnl group has listeners

Pedro Tammela (2):
  net/sched: act_api: conditional notification of events
  net/sched: cls_api: conditional notification of events

Victor Nogueira (1):
  net/sched: add helper to check if a notification is needed

 include/linux/rtnetlink.h |  7 +++++++
 include/net/pkt_cls.h     |  5 +++++
 net/sched/act_api.c       | 17 +++++++++++++++++
 net/sched/cls_api.c       | 12 ++++++++++++
 4 files changed, 41 insertions(+)

-- 
2.40.1


