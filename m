Return-Path: <netdev+bounces-246149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 650DFCE018A
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 20:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08DE030161AD
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 19:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E04C32860F;
	Sat, 27 Dec 2025 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6OyArXv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3FD32825D
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766864500; cv=none; b=l1iNg1Hg7IdjIjsg8bXJHXBFh73ll8G+lm2WDklVLI+rn+ql4/edGI3zbJlNN3rauuh9m0WGqbEBMJ4fLycUEVTIi0xSw89GU10Dv+xfTx+SK6008mXfS0zzJyK2Y2nWWxi4vME3uvRl2dw5hNAcR9RoK9sosDWSw2zhsiQaq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766864500; c=relaxed/simple;
	bh=ZS/o8vghJ5h/BMSisAqRUvGjgb71TXnPUFp74NnqLMA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fueb7rz2p5QrLY8AdmGMpOHmEwEbbcx6a4k2OVT9oz4gTsGKv2kDj20qz0pVPt0aq7Y8II4zcya0cYg6XuDICBYC0HEaJSueWI8ku2DgeGplu6CksNtaahi622IQKnhGUtNGnzJTxYvnvJXhMjbOAvsqIwtD+I25K1aghrdbxgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6OyArXv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0bae9aca3so117488435ad.3
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 11:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766864498; x=1767469298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HfQ34W5EDtkf/Oqe7WH83aJ2lwQHmBlnyORVV0lhhvo=;
        b=G6OyArXvqzdImEXLOgwZK8sgi9voeYz/ijnUMgAU1OmVKoU5BRY4LNTOHCJvkjo/xr
         8jUsowlXarmED3T/FJ9ur4xVEW9cDk+fsiIGXthcUCZxmEIJkkn35tLn5GOr8Ch5SqtF
         sLjPuWjRhE1sx8WeLncy2zZfiPis7Y70M18Mwpx8HYJTfpURi6dZfw6t3sAaFEtLk/yy
         P00fpcW3L9FI/LRDbl2bY0PvSppCvlk88U9Lms/ceH/T8mUniI/fXg/11uduL7lzG0v4
         Ct9UdWi2EQ/zRtPDv45WZExzqOuB1LiFiAOsKfEsFes55eIl8cmQWc4ecnZ6KmABbADj
         Povw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766864498; x=1767469298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfQ34W5EDtkf/Oqe7WH83aJ2lwQHmBlnyORVV0lhhvo=;
        b=ZUltbHrsMCTvKgC7Lz9q/91jxxgl0wGIVz0qVcYG/IF8y0jdrV4ZWSciI3CrXdDWtE
         HaK1i2KFoB9HHIRWoIHvU0EZOou9l3oOZnUbmqy4up0javUz1f23rAcTuVS8CFt07y1J
         XRlPMfb9k5pV+a5tfHylTZ4iEo2JY7SU0G4LzdZV2jBigR3+eLbiyEWNsLb8DviTJI20
         Xh9/mIWXCKlTdVXwfVNf6Pje7C+PDr7hR2fACz4feprBr0qD82hP3CHV/UI5MySbLlFQ
         syv17NXnXANcbqAeDVZPp3aPrx9psZX29pYkBLuWM7gkfyIF7fPyO09IyfbgqwHCX7Le
         kuZw==
X-Gm-Message-State: AOJu0Yx1tmD4/hBVwFKOhaP9rw4EmQcBDmiz1y+A7bPmAw5zBhJS4fPz
	YD3AhrxIwA9btBXovjeX2Diha8RTqxds6S6t5U0wCSu7ZT0sk+kYfjcB0Ktycg==
X-Gm-Gg: AY/fxX6rXNSLLRlSbm5ZmqfceoUtno69bJkCcsPgC3lLrT1oAZ8Xm2b5xchdZjR5NOY
	sGkaJrTgbbmhgHBYcvjzOhvw5JP7z9rlg1RJRrh5q9KrDt+lDTptUOhPA8xBcGHyUco5/ALczVx
	9ee916Zz4lgqC/gvm2hwjw+Xzqx1qsMHv9XfD/gutrEJNBb/tAdwEnWdC7cqSFN/r26GcfGSCJd
	2CGrg2TBz10LDk8jjaX+Dh6E1uNdRh4mAgbupLaeL1UJGHhFOOImSO7pEiCFYASlZEFQXZzQW7q
	o9cIpIGqN1SYuvt9AaBBjguIup7m/kPu4AUWOePlnnsesTRp/JrVLijaZ6zEFHscZg8+wrtsEyd
	m6ys+J1xjI5OONh8XHto3yw8BSCyEdL1V2DcDvZUIGQw8A7rgZx5ZX5IUdcUgc5qIAeoJ9NkWrq
	h589FfGKSMi6Rw2P58gk+9fKW0U0o=
X-Google-Smtp-Source: AGHT+IE0gjvr7JdOcoXtXSCfnuHbPpU+FHMIKrWr1aWnsT+hE7eIma0exFae4q7bJaus+xIini6PZQ==
X-Received: by 2002:a05:693c:809c:b0:2b0:4943:8999 with SMTP id 5a478bee46e88-2b05ec47b9emr22757685eec.33.1766864497538;
        Sat, 27 Dec 2025 11:41:37 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:de11:3cdc:eebf:e8cf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe5653esm59087584eec.1.2025.12.27.11.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 11:41:36 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v6 0/8] netem: Fix skb duplication logic and prevent infinite loops
Date: Sat, 27 Dec 2025 11:41:27 -0800
Message-Id: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
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

Please see more details in patch 4/8 which contains two pages of detailed
explanation including why it is safe and better.

This reverts the offending commits from William which clearly broke
mq+netem use cases, as reported by two users.

All the TC test cases pass with this patchset.

---
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

Cong Wang (8):
  net_sched: Check the return value of qfq_choose_next_agg()
  Revert "net/sched: Restrict conditions for adding duplicating netems
    to qdisc tree"
  Revert "selftests/tc-testing: Add tests for restrictions on netem
    duplication"
  net_sched: Implement the right netem duplication behavior
  selftests/tc-testing: Add a nested netem duplicate test
  selftests/tc-testing: Add a test case for piro with netem duplicate
  selftests/tc-testing: Add a test case for mq with netem duplicate
  selftests/tc-testing: Update test cases with netem duplicate

 net/sched/sch_netem.c                         |  66 +++-------
 net/sched/sch_qfq.c                           |   2 +
 .../tc-testing/tc-tests/infra/qdiscs.json     | 115 +++++++++++++-----
 .../tc-testing/tc-tests/qdiscs/netem.json     |  90 +++-----------
 4 files changed, 120 insertions(+), 153 deletions(-)

-- 
2.34.1


