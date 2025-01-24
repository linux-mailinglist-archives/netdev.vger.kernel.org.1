Return-Path: <netdev+bounces-160732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABD4A1B033
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 07:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6208B188DDF8
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 06:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCB71D88B4;
	Fri, 24 Jan 2025 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+ba2qjg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA41D7E4B
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737698873; cv=none; b=ArFVPghToSyOYOeRoFj9qvU+MzA/69sqELnKGWWFjgdfUTY2LeDMnWEr16ThxsDKzI9CSCO/Cil23vuSDP7Mzf6FAzMEyKqBRvgy/m5qHSxbg2/avnpKYKE1ECWg5zF77cJV6CxjXzWase3Nx1dK9ORro9cv0BGOzVFyFtXC8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737698873; c=relaxed/simple;
	bh=qQh5cgs7HrP8UbErgLPeCgr/sjVZyGiHOXB7Kz4v+/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KQbyAIXSHEsyiemhsKpq6272ZZ+ybsR1Wfc3L8I57TnTK1gYQ/ARl1ZBrXXmxluR5r7dA5O/20TLaFpZHSdciIIapaeDiZd47ejTzwp4gfUarghRATKo5aMmq7GflFjVy4JzBCDe3T7zmRY6KUUxpX/OglTZLkd60H/axP/WKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+ba2qjg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2164b1f05caso29459055ad.3
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 22:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737698871; x=1738303671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zsS6S9Opt3ODI/3xV6nXBX9m3AmRUKoZi6srD/Iczro=;
        b=K+ba2qjgPFbPeMJxMi9+Zb0+6NiwRlxiZCA5zCR4wg436lpNSeuuRxasXVcHyAtl5j
         d6+EYJadB5jlvd824NJ6k4LkoxlykpBd65N3LCd1haTiFImVdDZQjustaXh0pNshKI5l
         G0s3kU/DpGFhNg3EbtEKA1t7jb9rAS/i88Zu9+1ZNZiuY4nst6pOcw0L+6d1N7lGJXkS
         opHyOcKUwkjX0hiVGD8g2A36pUzM+M9AdSRRJVfr11lFllzQef0bzqJKfbl3c3WguCWp
         gd4XVil9e9oR3CWZjc+68fERZRyWGileHgBifvDH+g6hPUbVtIU9K1FNH3a4kLH0XMfK
         pfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737698871; x=1738303671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsS6S9Opt3ODI/3xV6nXBX9m3AmRUKoZi6srD/Iczro=;
        b=sgiYpVmc0s9ir+mHjPuC9WPFDoVtEdobF/jWj8ZslDIe1qKFHgTr/QGSfq2QtliLBu
         tUJFb9JG38+LxsUt/zne5mXfs4q5mZ5E9ElcgqpwiZlspY5p3yLL2guM+EKl/Uxe8Pqh
         vOmARXJsXZw246MdVznu/WZGeWcpZcOheHxEz5DaZLT1WaKNjkWbUzz7BtFsZ3spB11K
         I2o1+63w8qofOvBMi8ZzkA3yfkG44csezA2ZyHcokA5J14KQ8hKJG1A8QSjfL/HIXzPE
         cMeTJyyaA0V8VSfCJwlmeQFMW1CUsa0XjmU2yzwNfb7Pv5NtP356vdrnXeYABPUne2Um
         +QqA==
X-Gm-Message-State: AOJu0YxrI0IrzEyXMW2LlQiR1NgblVpdFUyedd/p9p43wlqHiMyhNCWJ
	oGDqnaIMvAFSTMgE4HYS3YxFGi3XXsjfjG7xWpBGweUp7m0G5zzE8+GXfQ==
X-Gm-Gg: ASbGncvGqfP66sc5BOaW0QX/wSczoZYMmUpw5sVCr7QV7I18AVX0KGAJjRPuI+fUzJ3
	rKmWs1Ps26cwpxe+ByYc+5fyXvO8FBrQBlV9kkOuJCjEJXV3m5zDLgFH8mn+Or0csvWUTtj8dcw
	Qf/XJ7FRstc2mV8T/CbywUogGhz4T+X2eVdEl76Hj2hopDoOBReIpjFD5Jamt7yK1EOkWcRJeH3
	JpLmbs+Ez+XOiFLmbFp92KZs7dQXH+UWaAlg+ND5ut4EQcLSFWTQxEia1eI2dTEPr8+TSEnpwEH
	5yCQ37rEVxgcAOVsOVwUccUnJmm8Nt/0
X-Google-Smtp-Source: AGHT+IG59lSNoRWi4D6WcLCJGJj0TgFnmyMQYLfGs1hQqQ/sknQiNFfOznO9XgxiXxyhlfTypeGKzQ==
X-Received: by 2002:a17:902:f70a:b0:215:a7e4:8475 with SMTP id d9443c01a7336-21c35557a0bmr504333845ad.24.1737698870949;
        Thu, 23 Jan 2025 22:07:50 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:2d85:604b:726:74b9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea55dasm8696095ad.101.2025.01.23.22.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 22:07:50 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	quanglex97@gmail.com,
	mincho@theori.io,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch net 0/4] net_sched: two security bug fixes and test cases
Date: Thu, 23 Jan 2025 22:07:36 -0800
Message-Id: <20250124060740.356527-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

This patchset contains two bug fixes reported in security mailing list,
and test cases for each of them.

---

Cong Wang (2):
  netem: update sch->q.qlen before qdisc_tree_reduce_backlog()
  selftests/tc-testing: add tests for qdisc_tree_reduce_backlog

Quang Le (2):
  pfifo_tail_enqueue: Drop new packet when sch->limit == 0
  Add test case to check for pfifo_tail_enqueue() behaviour when limit
    == 0

 net/sched/sch_fifo.c                          |  3 ++
 net/sched/sch_netem.c                         |  2 +-
 .../tc-testing/tc-tests/infra/qdiscs.json     | 34 ++++++++++++++++++-
 .../tc-testing/tc-tests/qdiscs/fifo.json      | 25 ++++++++++++++
 4 files changed, 62 insertions(+), 2 deletions(-)

-- 
2.34.1


