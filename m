Return-Path: <netdev+bounces-242029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFAAC8BB84
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9DA74E9103
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DB6340D86;
	Wed, 26 Nov 2025 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWyjlOWX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14D1E572F
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186778; cv=none; b=u9+31TsFGm+Yzz6bEy0MkKCWwbiuy4TugT3UkKGe43FLRsVrB36ecLSJsqWDaRIRwxuKBSxqoXPEFBvsg9jv1NTyNJ/NkNmqqzcd+2sOJTErwrQXNlYfSwQ1wMtHaRqmEV5MWS6I89f0RiYpPZ918xACMHM+ghw8JUJd0a4soQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186778; c=relaxed/simple;
	bh=t0j3RbhhMhRHO5nhAy9D+RhQQFbTi/w1c15W45HtnXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=owOSZRoBeJ6+8wxrMzYY1YkPjgl81nwc65q4V1LduKpox9e9w+VCe/GNnCHGaGPwnre6yXdRLoLwAkYVAb7tQ4BHfxc24qCyAt46AR68l49ncPI1op2TvsxA5CUr2CDck7pIbJkiL6aZYY82ZRucHekRsYYbsCCteWdgwT+Q78E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWyjlOWX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso68255b3a.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764186776; x=1764791576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gfJZ3ZUNuxJ94cohgbBImMsremXIC7tJxEGhwsxb7zg=;
        b=eWyjlOWXys3lS9UvSJEffmgRUG3by8z20465l9HBIhszlYXiiSsLxhNnwaN9hODyrf
         evnlfi2XgNctwHKs6EF/9Ea/JcMhMrhfB27ltw0EiT8ZAkmNqnlF+8nQkqd+wkWcBtj+
         yoIUtZMslbIAciJgz9ugYP4e1nEQnEZHNmAnpY4SNhaWkTqwW0DW6aGL09Qud0M0pewQ
         DXgBwyji4f0AGiKjjHPd4+S9qsDyUMZxovGCH5PqRrqgkl6SWyzQHl0lsYdfEPWTo6Ck
         McRlmgYOXgr/vwwd/ANPzHWwhPB7MDMrnqaF+7Sua/417asK3PmiHkZgiQBPJ2Ah7ry+
         0eCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186776; x=1764791576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfJZ3ZUNuxJ94cohgbBImMsremXIC7tJxEGhwsxb7zg=;
        b=exfUz+qr6AHnZfolNBXehsClaYcqc97C00nOqx0ZBEkKh2cTWkDK0eugXrqNx8AvaO
         P6rKzkKtKn9CWQSlvtF080h/AgoU7p5U0B9R1PHWKXk2L4Q91Zcfiklga754qRmQqXPy
         xSicp1LxSsybSK4730i4dKyLi8CRzmlzyRU5jr4eu5J+AwnIWJHMcGPXiXOQjL6p8L64
         16LYiI5eMqiZ71HiXQfpmueIbciOAgooUooeVAPxxCekCgxQqOqoO5fKa4iT/MwSKQPS
         WZC4M5Che6Sm5CkVEsqrTQZvqKUFHbOzMjcsuZAnPKrQNxwxspyROZx9rJ6nMwcnn29q
         qAxA==
X-Gm-Message-State: AOJu0YzWjDDhbEZ7kqBsbMGmFp5c+NZBfLwmOsCHgV8y9E36UB17QeIQ
	bcim74+VahuuiSRZciyYQgTxawTug/UiGSaclb6eJ3Za9N2oOZaPxZJLH6qiAlET
X-Gm-Gg: ASbGncup+6Ejex7BQIqxl6oOAyJP9xRO8iXSUF6MxE07GJbNOrC0L+Q6V7PawLP/JJr
	+ngTatNyO/LZOXgmuH5mi/b8YOXjSZXHg/245yS0kPbHZ3QzrOeOLdtNNV+sqFrbfkzibbNPu5B
	0RB1gKpCAZpWwKHwfgXNb7ipkS11sHNixGeldOBfW5Gm1EJuTtW2gZyGsLsAzm3ToOpVmacvo3V
	dnu7vAinwAsYK2rLv9lBw0cXuqRwKYhzsMOWTFfYZ5JepRTiDgF529aPzOU45mSBxjuty71sZmu
	TgzjlpjoCPK6RSl10noXYV8KKxc6lsagntCHgrgNWC5Ep6WoZoEAGkqYm59rFIjZMvU7i6Z85eN
	gTXXa9uxOArahv0slAZx4+Y9VFm3O08Jf3cLT6yOkjrOp87b6ejZi9o4PltckjaFBNjANIu7BiF
	fOP+eQW4JyONf0N1kvBjTJrA==
X-Google-Smtp-Source: AGHT+IEzyZXhuXCQxX22g0sbH5B+GPjNwcp8R1t+oZztqjf/HBHTfiM1QASjB6ZN75Q5RMYTmf+hbw==
X-Received: by 2002:a05:701b:2702:b0:11b:99a2:9082 with SMTP id a92af1059eb24-11c9d812c95mr7760945c88.15.1764186775898;
        Wed, 26 Nov 2025 11:52:55 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db4a23sm101508235c88.2.2025.11.26.11.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:52:55 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	kuba@kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v5 0/9] netem: Fix skb duplication logic and prevent infinite loops
Date: Wed, 26 Nov 2025 11:52:35 -0800
Message-Id: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
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
more predictable from users' perspective, less error-proone and more elegant.

Please see more details in patch 1/6 which contains two pages of detailed
explanation including why it is safe and better.

This reverts the offending commits from William which clearly broke
mq+netem use cases.

All the test cases pass with this patchset.

---
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
  Revert "net/sched: Restrict conditions for adding duplicating netems
    to qdisc tree"
  Revert "selftests/tc-testing: Add tests for restrictions on netem
    duplication"
  net_sched: Implement the right netem duplication behavior
  net_sched: Prevent using netem duplication in non-initial user
    namespace
  net_sched: Check the return value of qfq_choose_next_agg()
  selftests/tc-testing: Add a nested netem duplicate test
  selftests/tc-testing: Add a test case for piro with netem duplicate
  selftests/tc-testing: Add a test case for mq with netem duplicate
  selftests/tc-testing: Update test cases with netem duplicate

 net/sched/sch_netem.c                         |  72 ++++-------
 net/sched/sch_qfq.c                           |   2 +
 .../tc-testing/tc-tests/infra/qdiscs.json     | 115 +++++++++++++-----
 .../tc-testing/tc-tests/qdiscs/netem.json     |  90 +++-----------
 4 files changed, 126 insertions(+), 153 deletions(-)

-- 
2.34.1


