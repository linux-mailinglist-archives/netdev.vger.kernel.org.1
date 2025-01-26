Return-Path: <netdev+bounces-160946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3C1A1C646
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 05:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9010E3A55C9
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 04:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A76218E02A;
	Sun, 26 Jan 2025 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8clctW+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1754925A625
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 04:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737864799; cv=none; b=qrNiRbwsu86dJ8bipKakbV+b/4J6mLtMsTBYezHUNtEXijyal2GXgPN9UEFGtsZQeD/3UlmrJArkhAnESQAJCujuXvM4omSn5BTv67nZ6hHPe+OeUGxiHLktnu9Q5G0yiYqNjRxlVJF25/RqOVEB5APfOqrsSp4zwpLXJkFRDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737864799; c=relaxed/simple;
	bh=dD1cX4LBaRLqF7ag2QQ+/MrZekfQkVNBfCRIDJlKDt0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HMqJiXdIU8q2yuvOQ+m6RsZTYjOmznwwMYxdBI1lE1erUQBpjBZjr5Mi9DsGdGT2TIZwDIQ8XTiWSyLPmp8nR1qxe/1W63LrjYsGKtsam3DxEfKn4Py97MLGBrrgj2jtfeYMAexG8UhgIijhV5jMlh8ogwuht/ngVRQNeQD/Tec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8clctW+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f441904a42so6184086a91.1
        for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 20:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737864797; x=1738469597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wKgnxZHap4PSerglZMLCCZUmbZQv2mYv89iOAlprveA=;
        b=e8clctW+oUbijFNSZcSXkGUPLxgHyM+Cc7akYvdF/tirjBhG+jFQEpzyyYo/9vB4Eo
         5XfUodDUrpY4kobTkQpQHKMhxm+6N+aMKjb8673C1q2T4FKadf0R9Sik29HBWvKD2O0e
         frudWQQULggc8P+XLic7Y/nvd4MDlR4FPV4gDpVgbpOj9tAweaRQQe2nUN7DKwr7cupb
         xw5QtISaGr4dWUMpLC8QLfvqtQ0mkXnoz2fse5WCDieOzjUKUiKLSlVumEmnVrkakDbX
         zh3uVFUUqhq7V0khkrLNaLguNmMZW8ycC4j4Hbwj2E2lG670z9tZeLiJg2SUEQ/ZcXEX
         47Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737864797; x=1738469597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKgnxZHap4PSerglZMLCCZUmbZQv2mYv89iOAlprveA=;
        b=ggnm/wQVa/TdH9d7CQI7HqOZDbKfdWQKHuz5CG4Sr+ZT/MGrgvy9lPA7HW1/w7031z
         3bce4DOrhrGL7ov4+T/O0N0tVJObKTGJdd/O0AQ2FqtnJ+dXBxk/OJSjth+BtPFa6i2b
         +vxC1Zsc6AqsJqle9DfGkVgD+krPwt+jF2/Ljv0mY2SGi1HqR/mXk9JihQ+oOc+anezD
         L5pD9a9qLm7s6+BSoKTkYO/C2baBYlg0sjrodWapKxMkgsJTE/RiHVgKMxA3f4FcaGh4
         NQ8UKTP2krYCHt2WWe+a2LkMtRiV+UUiKVH3hJLKO2C8RCRnzDTxPgfPmoMEa/IaOt6+
         uFQQ==
X-Gm-Message-State: AOJu0YzKZ6iv7wnh1sQReeGEKcdj99xC3Gbv3IJ3+bPsDggqThoPhdSU
	CN6wKiePQldJgne21nRj+ln1c+BdnsNycYTku//Sx7UeEzLgqfBADQ0kmA==
X-Gm-Gg: ASbGncsXKoNYszy5tsYpae0ZI+0+drIvLk7U59EGgszW4AJRoV+ZVE0B3YsAF3Ec0GX
	qkvQfdhcOXP509ayvX+HN0PKV8LFpDIbIkxzow0tGDbm3I8XB4EZsqM9+o3bodJ8/sPK8RQXdY5
	1GePtHLL40S4YC4Hi/OMU+kTBElPc0BhjtJirByGMIdlrhjOyklbjgJCNhXSlrtbv1mFoJ1oIp/
	8yZzqBcIZaiO45RV0XePnlnbEBKC59V2IJldLHvBpm4RtiZvYnS0dp0HI087y8QkcgcCkCDt+Ck
	aiOxack6kuTqNk+7lLCFU8hrLuZ9fkN1Cg==
X-Google-Smtp-Source: AGHT+IEPWNELN/o7+TKqDu7ZRAvYwOovovanCCjOM7nG2B+IO+Hyk1WWHqiX83GfaE11Vylkyv+xlQ==
X-Received: by 2002:a05:6a00:1f11:b0:725:e444:2505 with SMTP id d2e1a72fcca58-72daf9bed3cmr51321958b3a.4.1737864796979;
        Sat, 25 Jan 2025 20:13:16 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:86c9:5de5:8784:6d0b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a69fd40sm4514213b3a.3.2025.01.25.20.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 20:13:16 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	quanglex97@gmail.com,
	mincho@theori.io,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch net v2 0/4] net_sched: two security bug fixes and test cases
Date: Sat, 25 Jan 2025 20:12:20 -0800
Message-Id: <20250126041224.366350-1-xiyou.wangcong@gmail.com>
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
and test cases for both of them.

---
v2: replaced dummy2 with $DUMMY in pfifo_head_drop test
    reduced the number of ping's in pfifo_head_drop test
    improved commit messages

Cong Wang (2):
  netem: update sch->q.qlen before qdisc_tree_reduce_backlog()
  selftests/tc-testing: add a test case for qdisc_tree_reduce_backlog()

Quang Le (2):
  pfifo_tail_enqueue: Drop new packet when sch->limit == 0
  selftests/tc-testing: Add a test case for pfifo_head_drop qdisc when
    limit==0

 net/sched/sch_fifo.c                          |  3 ++
 net/sched/sch_netem.c                         |  2 +-
 .../tc-testing/tc-tests/infra/qdiscs.json     | 34 ++++++++++++++++++-
 .../tc-testing/tc-tests/qdiscs/fifo.json      | 25 ++++++++++++++
 4 files changed, 62 insertions(+), 2 deletions(-)

-- 
2.34.1


