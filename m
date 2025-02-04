Return-Path: <netdev+bounces-162336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CDDA2692B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27799164034
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8CC1F949;
	Tue,  4 Feb 2025 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVM7lAGc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4AB25A629
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630745; cv=none; b=rKLx/f7sZZo6NfZGvqvR9/73xl0LrdIHZwmgDcVJ77oJg8CDi77yYODk8MxcPFahNUS/+x54b+MlvIx/A62Zv0I3a4yGgAuZZkelHh7mP2IqDUXsTo1owiay6ot4z8hdmNP7MTxZWqoB8p0NPBfanDnLHNnqRF7N0HDi7mLFqCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630745; c=relaxed/simple;
	bh=QIhpQqs2GzDkUdJqx0d5np3KVmwfRSvCLYvEijp92ns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h5xb8Sk1hb+LjV439sHZHcIVboNF2qlx/sjaO0e+fu8+uYv3SmljYFbkQLmGa9v5wV+0BVKgacoCGoGq4QHduQhfyJjN7EDt51jJM00SLSFHTsja1b9WhLDGlyBGRznLyTlJqwJ1AtDt3TAHzXf1Ay/YvriJyGRrvFRq/Wi+5sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVM7lAGc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21ddb406f32so79868595ad.2
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 16:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738630743; x=1739235543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zlfSYYh8kMYnVgGb4qhNfyKP7GWDSHYfd2m5KHf1us8=;
        b=VVM7lAGcmdzc5PeOFq24wlCISLIburqtpjn1720CUHZ4IOTNvCAl8ds+uAQpvA1YaC
         FhCBIaHZn3Dxc8WV15IIKCvoo3XeNBkxs3M8I0Rz9LVNmTpXzk51EVt29t2ZxWdo2LCL
         a6M9F/YTEpL5DEHlFPVnqQ3nZMRAyDj+M4yFdEP4iPcQGliUNtdakyl42+INqzzbShJE
         G12q2dfUjIHFoHWQxSPcj6T+iQG8b0FSGIXJZ4FzNIwr/gbMt82kyoTSQS/LLcfCnVQJ
         RnytDIT3aXdG2JKqDvUebVSII4bBQNyEs+G3LVuGcVtVDUzqw9P+JqAiLD2NZPqyfXor
         G0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630743; x=1739235543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlfSYYh8kMYnVgGb4qhNfyKP7GWDSHYfd2m5KHf1us8=;
        b=BN8nuyIxnWqK1xwGDBEXvA2FsdIHwLuz/YOvMtgiHID1n4cwWNRQA8oaVjxoCVz2jK
         pm+BxD8JLf20s0BEhGL1zzomlzrh3gRS3CGDn7SG0UDOIjWyEHr5uflRUz+4hwmwuvgU
         /giwcmbGgotE1cvkIFvGhylJk+4CASZlyaJ/tU+wo5eJzNOAPHcbWWi0zBaXvlzKLtSk
         poSTD4QRUzosDa1AUN6umfcXRUpGiqA+KXFq9PU4M76yphvH+7COd2qGIY0GG+QSJQGZ
         kF2JOBSL/cqeepv6pd727DWWrFTgm6vV9bgWv6w1ZfX7UgQIDptrinDv5JXL7/FUCjcy
         wl8w==
X-Gm-Message-State: AOJu0YyKr3l6WGq2CVxYq8Le0pLHI6idcfwW/WDuYNAhhKJUO42iJfgI
	oyQZiWpsc3aF2U/1P1VvNrB3gDJnGSM0GDixs3P7y0kIq3aDzdVKZHXLzw==
X-Gm-Gg: ASbGncsm1S/6u5+8VvDA/gseJfMLlVUtT141gQ0Aj69tGZqwIdEMAkmj+b5VGWT6qdZ
	67+76RVwUlg4csIQywMsi3k5Sjz/6AeF5ao+0aVu2xUFHe2euNsEPHPZKrOqhNiJ8lrXdt6yWlS
	pqba/b86uVUfYN2/EoJuJT1YlxbzoRQSY/dBMO9rWg8hsVlgIxCT8BwRngXv9wuADCRXhjkrY6V
	S7SavcUtjfRb4BXHWPwESzsBiYKggiQIUWfvXWAt1UCAWL8dUW+p8dLuAPDBH/KlIf3w8a3LdaI
	0M4cIXt1k/FjFifKeZYPaqBMp9r65u7dOY/tBrxd1EgG
X-Google-Smtp-Source: AGHT+IGv/nSyVEVvC7d5xfa4BP7vgzfneQ7BdLbMYZPSqxw4lS4HHfVoZsDUda8nhQH246ttMRnJrg==
X-Received: by 2002:a05:6a00:3cc1:b0:72d:8d98:c250 with SMTP id d2e1a72fcca58-72fd0bbd6e7mr37612415b3a.4.1738630742756;
        Mon, 03 Feb 2025 16:59:02 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:90d2:24fd:b5ba:920d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6427b95sm9207069b3a.49.2025.02.03.16.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:59:02 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	pctammela@mojatatu.com,
	mincho@theori.io,
	quanglex97@gmail.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch net v3 0/4] net_sched: two security bug fixes and test cases
Date: Mon,  3 Feb 2025 16:58:37 -0800
Message-Id: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
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
v3: added Fixes tag for patch 1/4
    removed a redudant ip link add/del in patch 2/4 (thanks to Pedro Tammela)

v2: replaced dummy2 with $DUMMY in pfifo_head_drop test
    reduced the number of ping's in pfifo_head_drop test
    improved commit messages

Cong Wang (2):
  netem: Update sch->q.qlen before qdisc_tree_reduce_backlog()
  selftests/tc-testing: Add a test case for qdisc_tree_reduce_backlog()

Quang Le (2):
  pfifo_tail_enqueue: Drop new packet when sch->limit == 0
  selftests/tc-testing: Add a test case for pfifo_head_drop qdisc when
    limit==0

 net/sched/sch_fifo.c                          |  3 ++
 net/sched/sch_netem.c                         |  2 +-
 .../tc-testing/tc-tests/infra/qdiscs.json     | 34 ++++++++++++++++++-
 .../tc-testing/tc-tests/qdiscs/fifo.json      | 23 +++++++++++++
 4 files changed, 60 insertions(+), 2 deletions(-)

-- 
2.34.1


