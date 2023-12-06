Return-Path: <netdev+bounces-54508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B514A807587
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7811F21252
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576F13E48B;
	Wed,  6 Dec 2023 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="UUhfeTkD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17943D47
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 08:44:38 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d08a924fcfso34426675ad.2
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 08:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701881077; x=1702485877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XsCMB6uvft/P0Kzq8vYo58p7DgwQkKyvKz9sLTHsADc=;
        b=UUhfeTkDDUJyk15aaa9WhRZhD3F8sM0axP2wwIYhjGhElJ3X5WEjNvrwqyEMNOtU1R
         3bVcBCZ6K6UAJ9C05E6zpEDVCO2WKyJYujfCvCqIQGOm1Op5qNomgC3+yWtYjoypI3Bk
         lp7KeXQ0xiQWlSspviH4SUoA/6Guy3LNN4sptJZnGYEKP2nYr3CLaN8EfboiaMmoqL3i
         QcDK2UZDbk6lbMBVJkED+AU4E8HlGiXVRDwuxoIr3LOE9cIZaHXTgCbzLFU9HVy14IHN
         8RtVO/OyEpqtxuak0ggSP40zq/irhgvZI4L/kL8s5fhItlNqmN8lPv1z00M5zaW+BOao
         y59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881077; x=1702485877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsCMB6uvft/P0Kzq8vYo58p7DgwQkKyvKz9sLTHsADc=;
        b=hfcI3I/sIK2MjRn+hfsWQudIc2s2SHaqhdKgTh7chZvANRw8QspQuGDySwnhV0UWry
         M8azDhR0d+HLFTmrn9+YYzcaCZBXsvrx2h5PUH1cX3dFGDSN1uHntUEPMbnhN6lEP3mB
         z2+3C44aMv8wxCMi2f5Jom6VNywvRkUZKPT6hBjLi9MVLC6xp75H6ZBXQL3nxmX8n2Rx
         39hyGQH2uwlzPu9p446xX2QEk2DITuZ39M/DEdKrbx7u01z9EmG/furJX5qo+CSbcMzJ
         m1PP40fzjydhSFtBE7iRX9LTXKHrAAiTwy7VIWFKjcIYXt2yYevkN6UGps/6VylZfSy6
         yVYQ==
X-Gm-Message-State: AOJu0YzzEiZUlvkFg7Y6OIa0CepKA1tdeBnM4l37IpO5S14ZFgEJJy+H
	YcQA05OD0qwQ2RNcXT/YYoQM09renl3S2gdQ21w=
X-Google-Smtp-Source: AGHT+IGt5/PcVUngrSgcEFfLS3AO9UTsOAH+9D9v+/GaY0pNDG6jW+Y1Wz4xUtmSXugn1csDKj9aVw==
X-Received: by 2002:a17:902:c411:b0:1d0:8e61:1020 with SMTP id k17-20020a170902c41100b001d08e611020mr1403447plk.89.1701881077293;
        Wed, 06 Dec 2023 08:44:37 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902740100b001cfc3f73920sm36719pll.227.2023.12.06.08.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:44:36 -0800 (PST)
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
Subject: [PATCH net-next v3 0/5] net/sched: conditional notification of events for cls and act
Date: Wed,  6 Dec 2023 13:44:11 -0300
Message-Id: <20231206164416.543503-1-pctammela@mojatatu.com>
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

The qdisc side needs some refactoring of the notification routines to fit in
this new model, so they will be sent in a later patchset.

v2->v3:
- Collected Jiri review tags
- Fixed commit messages to refer to rtnl_notify_needed

v1->v2:
- Address Jakub comments

Jamal Hadi Salim (1):
  rtnl: add helper to check if rtnl group has listeners

Pedro Tammela (3):
  rtnl: add helper to send if skb is not null
  net/sched: act_api: conditional notification of events
  net/sched: cls_api: conditional notification of events

Victor Nogueira (1):
  rtnl: add helper to check if a notification is needed

 include/linux/rtnetlink.h |  29 +++++++++++
 net/sched/act_api.c       | 105 +++++++++++++++++++++++++++-----------
 net/sched/cls_api.c       |  12 +++++
 3 files changed, 117 insertions(+), 29 deletions(-)

-- 
2.40.1


