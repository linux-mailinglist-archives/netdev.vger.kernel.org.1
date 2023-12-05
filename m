Return-Path: <netdev+bounces-54086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CA7805FC1
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF9B281B26
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DAC6A022;
	Tue,  5 Dec 2023 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="n0yKK8/c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120BB1A5
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 12:50:37 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d048c171d6so42823745ad.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 12:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701809436; x=1702414236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=huvs9nxXI09o58dQl/b7HbJI2UBofd/HvQmjByCraCM=;
        b=n0yKK8/ckCMrp+Gtd8TG6YsgFZQjsqZ47lcQKsKTDo0JSuKxxnWm3rODqVEo1MZdiR
         XtFZGb1CQklQF0lKqyLy/N1DQLpzfQD5vFbQA7qnsLjzK1393pEkMdmOkvIrJ6Qv/pdC
         pb+LSStSJcXZkKnWnievuEvzGThxjEZYHgWn9uZlzAAvx/9iepZv6aQYkRMJQCqm/SvR
         VUf/zuh2cjqQUyV215JcP8fIz24Ch85Coq3sgc8QPEdvGIbdoeS83chcT0tpzeKasDqP
         WM0Nn6Lv1bk2BGXK+U3Us0HsrYGeXbBugagqLsw27ls3SBtFjyjPrIkyuTOWRMBNO+M9
         t+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701809436; x=1702414236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huvs9nxXI09o58dQl/b7HbJI2UBofd/HvQmjByCraCM=;
        b=B3x7hkPpjNt2P4xbZkH5BCeR8Qz0zgu7LJOLkiKiwiWjXeuD2UyZZjTPUJUjKSo3fp
         0VgGiBp15qtol5fhZDnTR8tFAx2qPsl7544ZGKb1PD3/QDvp+UEg4MBJAhZ47wriWPUW
         4QPrRfQBFQXN6wpgpinkeyqvTg+C+uxPUzXwHUzgI42QXUqoLi3znaku0eb1gqoIs1M9
         B3PWH8wWyw7JryqqRYJX+c0J+qBG91WdWUJ/1iyyy7i40QDwYWTjalKPhO2jkbO2/7lB
         EWjOPF9XfKQDDz2JGya+OpKsBggp0a2WbGNrOs80hWgUn8cD5x7PuzGuKSqBrg4NJYE1
         +afw==
X-Gm-Message-State: AOJu0YyuhBFnQKkTDsGowa7QcBLcagdyp9tmbmBqniMx35tUY2Zjsenp
	aXmjLzgmFoj/I/X1JZ0LbccFSCjglgEVztGLdyg=
X-Google-Smtp-Source: AGHT+IFIFgLU/aFhL23pyqBmcRXTFcfmMaArPu3CVdA0q7WqOx2swCrEw2OUogWD2FxAgSQsL80tIw==
X-Received: by 2002:a17:902:b491:b0:1cf:9c44:62e with SMTP id y17-20020a170902b49100b001cf9c44062emr5202149plr.34.1701809436483;
        Tue, 05 Dec 2023 12:50:36 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:638:b3b3:3480:1b98:451d])
        by smtp.gmail.com with ESMTPSA id iw13-20020a170903044d00b001bf52834696sm8772788plb.207.2023.12.05.12.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 12:50:36 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net
Cc: dcaratti@redhat.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v3 0/3] net: sched: Make tc-related drop reason more flexible for remaining qdiscs
Date: Tue,  5 Dec 2023 17:50:27 -0300
Message-ID: <20231205205030.3119672-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch builds on Daniel's patch[1] to add initial support of tc drop
reason. The main goal is to distinguish between policy and error drops for
the remainder of the egress qdiscs (other than clsact).
The drop reason is set by cls_api and act_api in the tc skb cb in case
any error occurred in the data path.

Also add new skb drop reasons that are idiosyncratic to TC.

[1] https://lore.kernel.org/all/20231009092655.22025-1-daniel@iogearbox.net

Changes in V3:
- Removed duplicate assignment
- Rename function tc_skb_cb_drop_reason to tcf_get_drop_reason
- Move zone field upwards in struct tc_skb_cb to move hole to the end of 
  the struct

Changes in V2:
- Dropped RFC tag
- Removed check for drop reason being overwritten by filter in cls_api.c
- Simplified logic and removed function tcf_init_drop_reason

Victor Nogueira (3):
  net: sched: Move drop_reason to struct tc_skb_cb
  net: sched: Make tc-related drop reason more flexible for remaining
    qdiscs
  net: sched: Add initial TC error skb drop reasons

 include/net/dropreason-core.h | 30 +++++++++++++++++++++++++++---
 include/net/pkt_cls.h         |  6 ------
 include/net/pkt_sched.h       | 18 ------------------
 include/net/sch_generic.h     | 32 +++++++++++++++++++++++++++++++-
 net/core/dev.c                | 11 +++++++----
 net/sched/act_api.c           |  3 ++-
 net/sched/cls_api.c           | 31 +++++++++++++++----------------
 7 files changed, 82 insertions(+), 49 deletions(-)

-- 
2.25.1


