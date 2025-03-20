Return-Path: <netdev+bounces-176610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D53A6B18E
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B69D1756CF
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C54822A7EA;
	Thu, 20 Mar 2025 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSg0Kfm+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6425218ADD
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512940; cv=none; b=YotqQCnduswk8D01zCsJUXuLmF9UlXgTsRfTbA6TZowQRySyOpkkfIbQEAy0HJyW+am8qcCtflFkqUhxSwrwNNN0ZzSDTvwbpE8HaCg/w83TUWsrmjnO/1MLHgKZPjQgxS1KdFQUNjavr2vbgExmIcGS39/dNnvct4sKI4WForw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512940; c=relaxed/simple;
	bh=sCU0/Eo4TAsKWpieWGkZeAT5GohthcjAImdHmTvi5Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EPgQuRM7Cq4VdRhnmUW1Mg7oNkr3r7vkqXG+ya8mW7W2GKOxbOTizsnf/2GoLiF049LlK4ZdWbQpfUFvivRDrbol077XOoAP04vDRZT9cjmZ2bcQl6pIfjKMoCTPdNAsgI8N/1VQUIDXz0haWAR9hl++YlLXK+GOMfAWfsfY5Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSg0Kfm+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224100e9a5cso26620895ad.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742512936; x=1743117736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cAIVyEuPFl3Zca2lBtscJz1cQwal2/qaGjOjwY8NJC8=;
        b=OSg0Kfm+BIuP1NEDa55H3xYa/G+U68YNuoj5l7KLUSjbr0jmNjltAZ2Pf8IPKNceDs
         XmXHRHhC37gOo8TxV6zavhtJ1pNs2hbb1wMcLuOnRAiESrG+lkYuvPTHV4oPbNbJ5pAI
         uDNuwWiHAQkzr4VT32K+LrVEp95keOoTsHqEbelDquorntnwOh0CsyrGhfISjWcf32Js
         8PoBhzmYGnL88R04d4Lag+vW5R5HGhPRG+B3TDEcQs1k8NSgxUplJLpg6Wdxld9WXQo5
         QZHnY0RS8cA3KI5o1MEactrPRz/5amZ+AR2IrGnrkEqqlRVC/Rk6wmZG6zQnklLSAX4n
         0OOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742512936; x=1743117736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAIVyEuPFl3Zca2lBtscJz1cQwal2/qaGjOjwY8NJC8=;
        b=mj8qaI/8LEXwepaPmbFUW0sO+SYzh9X+TBLHquMGPlUPYXBPZxNXAr58UNDqgJZDtr
         1fD4KxgXFnG1nkBJpOb8zeD54QTlbhmA51BcaQlrxyj/yP0YyoxIseBV1UnG3ww9pVQ9
         Y4BXFjyRcYKSzytSCRP7UAFX3GidMROuKiIxXNTdrAib+EFiOwlgJ/93U7uq/cLLMSR2
         ghxsMNiPsrGNQQr211pUKW/zT2MyQwnXq0Lz8z5DGO8WHNH4X48V09tnHpo1PmSWw7ol
         pmes7N1tcCvoV7TJedxFzCzWhdaYy7btceVdjvlMYoyeMHvdRomRhjuGQQL2xL3SQyHj
         JN8w==
X-Gm-Message-State: AOJu0YzNxmU18GfHmINRriAx3yLKASdPBA6X2GKVXV/RaLr0sRDVAskc
	FQHGV0CfZj+E9e46DKdHcqYoEnDA/oNG0QgVowIAqpn/3VO1G04/d7DPJQ==
X-Gm-Gg: ASbGncs5TTmuh+2/iQnmA8Xf3LSwAe4A+NP8KKzxx8w+OHNpbmZKsTDbA8ThFFKzWDu
	dG+NW3ZXfVzzTVIzLpgyLhzSQNLJT8ar3fPJMtwSoaMTdz7qjwkLJvyGNt8WOsb017UkE7h73Bd
	nLhAR3rpT4yGCxqnuG2msVxLDECh9dmeKegWoH8dYL5ZzgkrnJClcPfPhqqPhHAxkQ5l9OTVStr
	zNYb66C0nS46TZHP8NYyveslOGxu2OIu0zgJkYHPy59sS8139QOHTxKuoyA9MF0egYtn++phlvs
	YrRbdPufetKStY8Mu/CiZks69SU9lSxnY7XAV46i3oTeRBwCb2ophoI=
X-Google-Smtp-Source: AGHT+IG2wGy/Oh9ladmgKcIG3FDE916MBEhWcwPngoLiswC1atRbtYqRmg5o4DGCDdWLnWJ9yom0GQ==
X-Received: by 2002:a17:902:e78f:b0:224:c46:d162 with SMTP id d9443c01a7336-22780c7bfecmr18829255ad.20.1742512936523;
        Thu, 20 Mar 2025 16:22:16 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da38asm3695525ad.186.2025.03.20.16.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:22:15 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 00/12] net_sched: make ->qlen_notify() idempotent
Date: Thu, 20 Mar 2025 16:21:59 -0700
Message-Id: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gerrard reported a vulnerability exists in fq_codel where manipulating
the MTU can cause codel_dequeue() to drop all packets. The parent qdisc's
sch->q.qlen is only updated via ->qlen_notify() if the fq_codel queue
remains non-empty after the drops. This discrepancy in qlen between
fq_codel and its parent can lead to a use-after-free condition.

Let's fix this by making all existing ->qlen_notify() idempotent so that
the sch->q.qlen check is no longer necessary.

Patch 1~5 make all existing ->qlen_notify() idempotent to prepare for
patch 6 which removes the sch->q.qlen check. They are followed by 6
selftests for each type of Qdisc's we touch here.

All existing and new Qdisc selftests pass after this patchset.

Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")

---
Cong Wang (12):
  sch_htb: make htb_qlen_notify() idempotent
  sch_drr: make drr_qlen_notify() idempotent
  sch_hfsc: make hfsc_qlen_notify() idempotent
  sch_qfq: make qfq_qlen_notify() idempotent
  sch_ets: make est_qlen_notify() idempotent
  codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()
  selftests/tc-testing: Add a test case for FQ_CODEL with HTB parent
  selftests/tc-testing: Add a test case for CODEL with HTB parent
  selftests/tc-testing: Add a test case for FQ_CODEL with QFQ parent
  selftests/tc-testing: Add a test case for FQ_CODEL with HFSC parent
  selftests/tc-testing: Add a test case for FQ_CODEL with DRR parent
  selftests/tc-testing: Add a test case for FQ_CODEL with ETS parent

 net/sched/sch_codel.c                         |   5 +-
 net/sched/sch_drr.c                           |   7 +-
 net/sched/sch_ets.c                           |   8 +-
 net/sched/sch_fq_codel.c                      |   6 +-
 net/sched/sch_hfsc.c                          |   8 +-
 net/sched/sch_htb.c                           |   2 +
 net/sched/sch_qfq.c                           |   7 +-
 .../tc-testing/tc-tests/infra/qdiscs.json     | 188 +++++++++++++++++-
 8 files changed, 211 insertions(+), 20 deletions(-)

-- 
2.34.1


