Return-Path: <netdev+bounces-249554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85488D1AF07
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8328930239E2
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0120357A39;
	Tue, 13 Jan 2026 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPJWkua9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0FC357A2D
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331213; cv=none; b=hDgIuvPkbaV8wpor52NK7YCIvWMeMlFVLBiRZst+7ppI4QqI6/3oWjqk/taR0MuNBOUFOFQICGEAn9Fkqs7UX5voULbYNgRijRjV2PZvLvpnm9MdgydbEUB55kgn920Nf05O6C0RByF1fT+y5Sv2iGg/4NG0PWWJJJUsOk8we2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331213; c=relaxed/simple;
	bh=ncUAVH9ehC6L/wCnjAFGTe046mRwzZ0HuLvR3zPDK/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Nx2gjLmnkrZeh6ybhd4rBTdB1RBIrGRbKjQkmLPU9IICq0kcHilzpddJVpeWofUKTGKt6i6OVSAIPRZzNt+AEqOKRqM46qEDKVOcNTuzbTV3PJtwXc/yY6eJw9NF85IWyHC5pRGIPfypqi9kVGTxNZp4H0ylazpdnAzEKK7FflM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPJWkua9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81f5381d168so2265033b3a.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768331211; x=1768936011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HTSrTgOaFnwaMAZErOhBRRfxcTBi6c+WfHTamYOdAqg=;
        b=dPJWkua9WaCo8kA5OR2T1mtl87hy6Cb1O3aZbuuOKL8sJGYV+uqXSUa+tRnNGhRoIS
         3uwdHk4gEgjkvvlx0nywAzKL+HVhnrSVbl8QXwc3Ikn2bmizYbbLbC1odfrt9dn58T52
         UtdZkpIQokj7mArGcNVGfWck4OO+UGPmXDvKDkgvMrbttczpFx580JUCsQ6pof8EEu2I
         nPHIt/asG74scIJN1NI2H2VxyTRU6uklEuRLWDA4YrOtDDMitim0QfvXuDSS1Ro0jned
         veJvaCKS16ZPdjeV9ejP6802jPdlNQwoRmH9I2Uh+uzA24L+WtCKaeIRVqR0t0hYo3uQ
         5d4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768331211; x=1768936011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTSrTgOaFnwaMAZErOhBRRfxcTBi6c+WfHTamYOdAqg=;
        b=Sr3uwOLnaVezqZS+uhs5D4+A9pNFYBlY8u20qZyBVdwYAOAqI4ZhtpuO84Jr1jYfGW
         /qjGKa1gF7RbwyAykpooC0btJ40g711kLHN7CqyeYZS88Rbcso17u9lJsb01HGUkTcEY
         Jc9qooYfcDophAA6lOINGyDsm2Qs4UCgoFlh4uWEZIIpcevi/QSrNrWdx5vFTMHyN+kA
         ScAlUnemRcKuwwIntJqo7g1ItJim9pn19Gg49JT7mB7vdDmrvAtfqOG8E8JeeELyehOd
         DGnj+yuo1lH0ddN+b2dogsljKn8vbimZ9hGMLY7NBBYdeY+BQbDmrrA2xFdTlZYHDX5S
         AVGA==
X-Gm-Message-State: AOJu0YzJNBF35mqmM+iqWTnQ+8g+rXaiWWbZ8oI3NIyYG6w7833wzQPG
	5md/kT5khFPLFiHClUpc+iXB7kyUjHWJR/7zEs1tkG4GfCmAOb71+bdGZk38oQ==
X-Gm-Gg: AY/fxX7zjM++RC8HuS69flMXyHFekk9FOmPebHcTn4aFfiUIieC84EBAwnXOdBar3T2
	ycS4xlT9HgMFalSGF7s4G9tFK16H5XsDaSjaZF8azBUpcooNyzTdQQAOsZGqOXCe4vnpv4nwTAp
	J0aDQ1msBmPtaqUGWtn87seZw2U37T8nNQ3dbbi81EecP2CkO+ca4LC2pQ8943tBojmpuzCkpPL
	DFUYyIhFnW5nL1arAcro1TZzMJwDyrb7Bga/2OWab6se4eQOKt4T03QN2foE2mX4UJtFweZYTuL
	JAyG3SvfqfssUowgvgyZtcM788ziQUGXbxIFajzzZFl7qDHMa3XXe23ZcgqedagCj/cGnM7IknX
	sHJpV+awiQ3PnzDhNJKYVJ0GWGqThQgeEoCa97dCiVAiRi/nOPfenN22qt3vLxL7qOMr9ClvPMS
	I6H59559OTnPklxqKA
X-Google-Smtp-Source: AGHT+IGnbGZLU374CRF2W1V2jZZh644u4RWFfq39PVD6DhXlAU1nZsDI7MHm5NKQ1lleoOX7K4xL4w==
X-Received: by 2002:a05:6a00:44cc:b0:81e:d84:91d3 with SMTP id d2e1a72fcca58-81e0d8497f6mr13117655b3a.19.1768331211205;
        Tue, 13 Jan 2026 11:06:51 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:7269:2bf1:da7f:a929])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8058d144sm187780b3a.51.2026.01.13.11.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:06:50 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v7 0/9] netem: Fix skb duplication logic and prevent infinite loops
Date: Tue, 13 Jan 2026 11:06:25 -0800
Message-Id: <20260113190634.681734-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset fixes the infinite loops due to duplication in netem, the
real root cause of this problem is enqueuing to the root qdisc, which is
now changed to enqueuing to the same qdisc. This is more reasonable,
more intuitive from users' perspective, less error-prone and more elegant
from kernel developers' perspective.

Please see more details in patch 4/9 which contains two pages of detailed
explanation including why it is safe and better.

This reverts the offending commits from William which clearly broke
mq+netem use cases, as reported by two users.

All the TC test cases pass with this patchset.

---
v7: Fixed a typo in subject
    Fixed a missing qdisc_tree_reduce_backlog()
    Added a new selftest for backlog validation

v6: Dropped the init_user_ns check patch
    Reordered the qfq patch
    Rebased to the latest -net branch

v5: Reverted the offending commits
    Added a init_user_ns check (4/9)
    Rebased to the latest -net branch

v4: Added a fix for qfq qdisc (2/6)
    Updated 1/6 patch description
    Added a patch to update the enqueue reentrant behaviour tests

v3: Fixed the root cause of enqueuing to root
    Switched back to netem_skb_cb safely
    Added two more test cases

v2: Fixed a typo
    Improved tdc selftest to check sent bytes

Cong Wang (9):
  net_sched: Check the return value of qfq_choose_next_agg()
  Revert "net/sched: Restrict conditions for adding duplicating netems
    to qdisc tree"
  Revert "selftests/tc-testing: Add tests for restrictions on netem
    duplication"
  net_sched: Implement the right netem duplication behavior
  selftests/tc-testing: Add a nested netem duplicate test
  selftests/tc-testing: Add a test case for prio with netem duplicate
  selftests/tc-testing: Add a test case for mq with netem duplicate
  selftests/tc-testing: Update test cases with netem duplicate
  selftests/tc-testing: Add a test case for HTB with netem

 net/sched/sch_netem.c                         |  67 ++------
 net/sched/sch_qfq.c                           |   2 +
 .../tc-testing/tc-tests/infra/qdiscs.json     | 148 ++++++++++++++----
 .../tc-testing/tc-tests/qdiscs/netem.json     |  90 ++---------
 4 files changed, 155 insertions(+), 152 deletions(-)

-- 
2.34.1


