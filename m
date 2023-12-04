Return-Path: <netdev+bounces-53642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C762580402E
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040721C20BCB
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BFD26AF0;
	Mon,  4 Dec 2023 20:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="PFwODN/V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DE72717
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:39:36 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d053c45897so31297165ad.2
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 12:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701722376; x=1702327176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XQsAgBsAatFS/0UatgzC3fx3wpsAB8/XsuWWVK8JeFI=;
        b=PFwODN/VEIbjoESTgylNBRw2xa+AU4WbyBCb5p6A4MaiR3M6/eCv/J1yg3N4t7198T
         QW2bPXPKB358cOfDNcZ7fLkLajpy7Dhdy/19JvNltbDdDi+KKRCKAj9emdPAE1UKWGdU
         1vA3eg+ZCsjzpgFgJXVCNUTpfjsuLj0cfmzZ3cDN6rp5SOfA7hq/OgxYMGMI2fkU4yCY
         kxSPw6Iod3++IF4bhfCmInXE4aRH/yZqU8+fND6FGNCZRfQxW92uAIShzOzTsVFC6ej7
         adm9LxBXQE41XKZvAXAeAVCG4owiGVE76wbxrvtZQlbinWLXBIC0AvzRJuCuIIvLHscN
         YP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701722376; x=1702327176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQsAgBsAatFS/0UatgzC3fx3wpsAB8/XsuWWVK8JeFI=;
        b=bFInXb3KA+zluLbBmXf9JP9swmqe9rnFtlp13Cm6bfMR0TBEPKd/yTxqsTYIDk2bac
         00HiEAkepne+F5Pr3Cyt3s9ylYhtH/PeIVD5B/xbjk0O0dsDiCHr93qmvH/+DlEN78DX
         z+8hsrHzN++hLw2K6gpQ4cAvK6EQ3SDu07gxPJ6sfSh7ZBO3ItPdhjhoLahypCwuTIrm
         m+RU6U348VDCRl6g1wxoyAg0wttn3XyPWfVcMK81iqlcr1fusG+dxse5S54FdHhwXrvI
         XnYcCD1xxMsrtK8uI9xakcuRxxd3vzMnu8lJ4ILBIjw/mqPL51J1QZOy/22hm8oEm+Yq
         cSDA==
X-Gm-Message-State: AOJu0YwUXL7BOg6EphAUHRu3Nklk9hqTnYNT0zLe7lWHfHsr3N+JCfeI
	5y1nPLETBZAawCdas9703C6VgDsqiz/NAvJ9MDU=
X-Google-Smtp-Source: AGHT+IE/nzXFHOZiY4f5AeihB7YOIh459slXk2LH1ws7ys8D1IDzX9uTwdDucX3PB8Ewv7/0J7HU6Q==
X-Received: by 2002:a17:902:da86:b0:1d0:8cb5:49dd with SMTP id j6-20020a170902da8600b001d08cb549ddmr3774353plx.69.1701722375879;
        Mon, 04 Dec 2023 12:39:35 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b001cf83962743sm2669584plg.250.2023.12.04.12.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:39:35 -0800 (PST)
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
Subject: [PATCH net-next v2 0/5] net/sched: conditional notification of events for cls and act
Date: Mon,  4 Dec 2023 17:39:02 -0300
Message-Id: <20231204203907.413435-1-pctammela@mojatatu.com>
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


