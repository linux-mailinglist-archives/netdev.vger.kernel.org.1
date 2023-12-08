Return-Path: <netdev+bounces-55412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F6F80ACFF
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25DA9B209BE
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AB34CB34;
	Fri,  8 Dec 2023 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="kLFhBHlE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E474F1712
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 11:29:06 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso1728613a12.3
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 11:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702063746; x=1702668546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JYXG18rR1lOhxgEBZsv1oPV1xcAMW0c00Yv1ji57428=;
        b=kLFhBHlECFph07b8QNVnKxeudOE+GCHMLasKKR4pYR47cJf7uydpBQVQrYj+SsfP1E
         4cqFs1BLvfzHArfm60HGQ0ukfo/r83W38/3p4wrvEDH7urFPywbho4GWGd+HrK/XFRkR
         j/sTktq0gCW5PALfTVF+bzueYBh2gjA0wBAQ6sbU1c5U9dOtmcREkt7+wfm6IB4YFljx
         wWMF9PPD7fObgfofIvRxvdOiTQN2h0PF43H9xObGFJ13p1Hz3jCWZOiYFWv72FsFrHc+
         LUBRuUyP4+WMgO6uHI4BP/sEIZsoa42Ej+4nWoVNn98cfXndva/VVcY/9ZBQg8bro5cU
         ULoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702063746; x=1702668546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYXG18rR1lOhxgEBZsv1oPV1xcAMW0c00Yv1ji57428=;
        b=HJEPQxBvaDOQOat7VBUvDEAmES2HjqZ9+2rU2SXfNLvmlnXZE1LwQNQuRBY66KFkNc
         NGODEifxsw5zFCGAF2iIKb5rPKkRyjxSWlW/9Z0a86w12Z4GMQGmdWg4EtECcm0Rheqb
         q15c8rFZMxeVeVl8UO4Nit/hTD4WJpoS0kmtoPjVSeDaeSYaPppejOz5RYg5PESur25P
         WtUt8qBW5/bXV7bSi264py5FZmOjQ0FoioYFfWdRg3YWcYF6xVRqnrle9DPrsW7B319b
         N6Wc8jMhpbMTkitaPY/4jKmsLagYx+ki6fZwoLsTXtC2vj0lV2RLM3Zr3gIvoGcr5fVw
         xRHA==
X-Gm-Message-State: AOJu0YwFJQv7JDBpvVvEWpVo12HuPK5ExICMhg25DeUNHMvFHLJ2JyXa
	u6t87VEWWwBcChWnuOunKo9tRZh7Jm7wv2hWhQc=
X-Google-Smtp-Source: AGHT+IERutx7a10QuAMKyxuL4bQm1nG/X2n7Np30IPDKVufHFnDHv3COd9n4uwFkoM14eIAslzkg7A==
X-Received: by 2002:a05:6a20:9149:b0:18c:a9d3:4f96 with SMTP id x9-20020a056a20914900b0018ca9d34f96mr592622pzc.32.1702063746071;
        Fri, 08 Dec 2023 11:29:06 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id p4-20020a634204000000b005b856fab5e9sm1916787pga.18.2023.12.08.11.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:29:05 -0800 (PST)
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
	horms@kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v4 0/7] net/sched: conditional notification of events for cls and act
Date: Fri,  8 Dec 2023 16:28:40 -0300
Message-Id: <20231208192847.714940-1-pctammela@mojatatu.com>
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

v3->v4:
- Collected Simon review tags
- Addressed Simon comments
- Added 2 more patches

v2->v3:
- Collected Jiri review tags
- Fixed commit messages to refer to rtnl_notify_needed

v1->v2:
- Addressed Jakub comments

Jamal Hadi Salim (1):
  rtnl: add helper to check if rtnl group has listeners

Pedro Tammela (5):
  rtnl: add helper to send if skb is not null
  net/sched: act_api: don't open code max()
  net/sched: act_api: conditional notification of events
  net/sched: cls_api: remove 'unicast' argument from delete notification
  net/sched: cls_api: conditional notification of events

Victor Nogueira (1):
  rtnl: add helper to check if a notification is needed

 include/linux/rtnetlink.h |  29 +++++++++++
 net/sched/act_api.c       | 107 +++++++++++++++++++++++++++-----------
 net/sched/cls_api.c       |  38 ++++++++------
 3 files changed, 128 insertions(+), 46 deletions(-)

-- 
2.40.1


