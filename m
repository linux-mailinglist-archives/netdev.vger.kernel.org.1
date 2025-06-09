Return-Path: <netdev+bounces-195803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF0FAD24F6
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F0A3A8B6D
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1021219004A;
	Mon,  9 Jun 2025 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HIBnshG9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601021A428
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490220; cv=none; b=ADtfy1Jm+W9YYE0D1PJXmyYKy/6NtoV42ZmgI6lfIrakqKeMutIuw1o4/i+2+l94bUUVlMrMy0lwrCyKRlrq1i/BIzT0lOW7dwwowQecKo47iompifzTctFZ1frOpo2awVIbNeK/iMU7/u4JcVWTQ4VoiJCwHwB+L/zmZtHlyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490220; c=relaxed/simple;
	bh=mbVXgxCF1bCFRaxZ/hR3os5K6Kx79QhqsS4dwrNH0BM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q997PZNcsNCunuhGJ2AHgWRWTcYDiU1qWshnq8BptFOSjlrWHFv1wBMqUV4iQIXx7ZXLyvafZ8KH3I7KXzpulrDppWIKyt1y0ea5HeaaC8DypayCUpQ7NS/OkN1rHMMwBiElyKsAkEdnhOjiEO5zdGerj4aE8WKWV47I+3NbBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HIBnshG9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74620e98ec8so4107258b3a.1
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749490217; x=1750095017; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3M0xmKjnACa0sNnx5LtVqJP+BjBIiMeK6BpZq6Q4FnY=;
        b=HIBnshG96/sLvRi/1709EE1SQL9/3oS6MavXle7+0q6VVkxk8CW5LXfDvobjWcsnZM
         tXWZdOkWRwto3cH2XE3hAQbAMBSII86GQZHsPld+DKtM7kHxX5BunW3uL0+lUFjGQpnf
         teZC3xF5tOEdG8K/fDjXr/0KD9clzWZyOQrIyoXbsqUPpShSjHFibFIY0kiDtGSSk0gF
         t5HGWmA267BpF8jepEpUsZ1pJBjY/WzZnIp63KRzryjwwA+RhxsGVFg6C9a556iojVNz
         QWjxov/VtUu5hZ7Y3UTHn+i8jD+TfLSH0pzUOAW0YTPE8u6ZMugUofeohS2aqElk1c4W
         pQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749490217; x=1750095017;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3M0xmKjnACa0sNnx5LtVqJP+BjBIiMeK6BpZq6Q4FnY=;
        b=GTFSR+czK+IkopjhJ+oGgjDgeRA57+ogWV8BUecjEaoGoXZ3NvN0cUcbP4wkZROZ6t
         qmnzE9RdDWZR2br+1KueZRqFhAHrQAez6LJqGNkdFDtC5ORy8ZWWIzxDLj/zcl4KkCoI
         A8jRphbTNsfHISRht90/UGNjkS3+UYu5k+p4UTfOwuCl40p0LD0VftqGEF5OaW0WGYsw
         VvB2KYlGt7oG7Fnoc7BDmgSuOI5vFdhxDMceMeLoQDUenA9RpXpdJP854EmPjb2h4yio
         4ja/Ewg1W2lZzwm5I54qPgmFhlzn+SLB/HC78dmFkOSkCrNYiW2LZ8PEcVXxiKhw7Ps+
         2jbA==
X-Gm-Message-State: AOJu0YzQ2eP8fw9Glbrg4rvAQDiMdsNcLb2/8JZ6t0+Xq7v/RRHVUpS1
	CCtjDD9mmiumdDtGdfKSCgy07neXR/urZ7ePJcHR9bWvcWkLACumXpxN9hnrkSxbMma52uNviQT
	DPxCSHiTevMiTSA==
X-Google-Smtp-Source: AGHT+IGNMPd9Vy4rc1iygAgWj4Ua8XsVMPf1XYPjrlfgAkDFJDMDBXkQgjKwPZ6QwGhKwAoziIRcENCjTpI6Vw==
X-Received: from pfny12.prod.google.com ([2002:aa7:854c:0:b0:748:34d:6d4f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8102:b0:742:b928:59cb with SMTP id d2e1a72fcca58-7485eac8f54mr299595b3a.7.1749490217144;
 Mon, 09 Jun 2025 10:30:17 -0700 (PDT)
Date: Mon,  9 Jun 2025 17:30:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250609173015.3851695-1-skhawaja@google.com>
Subject: [PATCH net-next v3] net: stop napi kthreads when THREADED napi is disabled
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca, 
	weiwan@google.com
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Once the THREADED napi is disabled, the napi kthread should also be
stopped. Keeping the kthread intact after disabling THREADED napi makes
the PID of this kthread show up in the output of netlink 'napi-get' and
ps -ef output.

The is discussed in the patch below:
https://lore.kernel.org/all/20250502191548.559cc416@kernel.org

NAPI kthread should stop only if,

- There are no pending napi poll scheduled for this thread.
- There are no new napi poll scheduled for this thread while it has
  stopped.
- The ____napi_schedule can correctly fallback to the softirq for napi
  polling.

Since napi_schedule_prep provides mutual exclusion over STATE_SCHED bit,
it is safe to unset the STATE_THREADED when SCHED_THREADED is set or the
SCHED bit is not set. SCHED_THREADED being set means that SCHED is
already set and the kthread owns this napi.

To disable threaded napi, unset STATE_THREADED bit safely if
SCHED_THREADED is set or SCHED is unset. Once STATE_THREADED is unset
safely then wait for the kthread to unset the SCHED_THREADED bit so it
safe to stop the kthread.

Add a new test in nl_netdev to verify this behaviour.

Tested:
 ./tools/testing/selftests/net/nl_netdev.py
 TAP version 13
 1..6
 ok 1 nl_netdev.empty_check
 ok 2 nl_netdev.lo_check
 ok 3 nl_netdev.page_pool_check
 ok 4 nl_netdev.napi_list_check
 ok 5 nl_netdev.dev_set_threaded
 ok 6 nl_netdev.nsim_rxq_reset_down
 # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

Ran neper for 300 seconds and did enable/disable of thread napi in a
loop continuously.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---

v3:
- Rework the napi threaded disable logic to unset the threaded state
  when SCHED_THREADED is set or napi is idle.

v2:
- Handle the race where the STATE_THREADED is disabled and kthread is
  stopped while the ____napi_schedule code has already checked the
  STATE_THREADED and tries to wakeup napi kthread that is stopped.

 net/core/dev.c                           | 45 ++++++++++++++++++++++--
 tools/testing/selftests/net/nl_netdev.py | 38 ++++++++++++++++++--
 2 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d0563ddff6ca..3a0165b22f77 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6888,6 +6888,43 @@ static enum hrtimer_restart napi_watchdog(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+static void napi_stop_kthread(struct napi_struct *napi)
+{
+	unsigned long val, new;
+
+	/* Wait until the napi STATE_THREADED is unset. */
+	while (true) {
+		val = READ_ONCE(napi->state);
+
+		/* If napi kthread own this napi or the napi is idle,
+		 * STATE_THREADED can be unset here.
+		 */
+		if ((val & NAPIF_STATE_SCHED_THREADED) ||
+		    !(val & NAPIF_STATE_SCHED)) {
+			new = val & (~NAPIF_STATE_THREADED);
+		} else {
+			msleep(20);
+			continue;
+		}
+
+		if (try_cmpxchg(&napi->state, &val, new))
+			break;
+	}
+
+	/* Once STATE_THREADED is unset, wait for SCHED_THREADED to be unset by
+	 * the kthread.
+	 */
+	while (true) {
+		if (!test_bit(NAPIF_STATE_SCHED_THREADED, &napi->state))
+			break;
+
+		msleep(20);
+	}
+
+	kthread_stop(napi->thread);
+	napi->thread = NULL;
+}
+
 int dev_set_threaded(struct net_device *dev, bool threaded)
 {
 	struct napi_struct *napi;
@@ -6923,8 +6960,12 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 	 * softirq mode will happen in the next round of napi_schedule().
 	 * This should not cause hiccups/stalls to the live traffic.
 	 */
-	list_for_each_entry(napi, &dev->napi_list, dev_list)
-		assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+	list_for_each_entry(napi, &dev->napi_list, dev_list) {
+		if (!threaded && napi->thread)
+			napi_stop_kthread(napi);
+		else
+			assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+	}
 
 	return err;
 }
diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index beaee5e4e2aa..c9109627a741 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -2,8 +2,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import time
+from os import system
 from lib.py import ksft_run, ksft_exit, ksft_pr
-from lib.py import ksft_eq, ksft_ge, ksft_busy_wait
+from lib.py import ksft_eq, ksft_ge, ksft_ne, ksft_busy_wait
 from lib.py import NetdevFamily, NetdevSimDev, ip
 
 
@@ -34,6 +35,39 @@ def napi_list_check(nf) -> None:
                 ksft_eq(len(napis), 100,
                         comment=f"queue count after reset queue {q} mode {i}")
 
+def dev_set_threaded(nf) -> None:
+    """
+    Test that verifies various cases of napi threaded
+    set and unset at device level using sysfs.
+    """
+    with NetdevSimDev(queue_count=2) as nsimdev:
+        nsim = nsimdev.nsims[0]
+
+        ip(f"link set dev {nsim.ifname} up")
+
+        napis = nf.napi_get({'ifindex': nsim.ifindex}, dump=True)
+        ksft_eq(len(napis), 2)
+
+        napi0_id = napis[0]['id']
+        napi1_id = napis[1]['id']
+
+        # set threaded
+        system(f"echo 1 > /sys/class/net/{nsim.ifname}/threaded")
+
+        # check napi threaded is set for both napis
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_ne(napi0.get('pid'), None)
+        napi1 = nf.napi_get({'id': napi1_id})
+        ksft_ne(napi1.get('pid'), None)
+
+        # unset threaded
+        system(f"echo 0 > /sys/class/net/{nsim.ifname}/threaded")
+
+        # check napi threaded is unset for both napis
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0.get('pid'), None)
+        napi1 = nf.napi_get({'id': napi1_id})
+        ksft_eq(napi1.get('pid'), None)
 
 def nsim_rxq_reset_down(nf) -> None:
     """
@@ -122,7 +156,7 @@ def page_pool_check(nf) -> None:
 def main() -> None:
     nf = NetdevFamily()
     ksft_run([empty_check, lo_check, page_pool_check, napi_list_check,
-              nsim_rxq_reset_down],
+              dev_set_threaded, nsim_rxq_reset_down],
              args=(nf, ))
     ksft_exit()
 

base-commit: b65999e7238e6f2a48dc77c8c2109c48318ff41b
-- 
2.49.0.1266.g31b7d2e469-goog


