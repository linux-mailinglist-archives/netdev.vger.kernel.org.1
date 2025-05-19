Return-Path: <netdev+bounces-191674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBEEABCB12
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 00:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2974A1F24
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 22:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE1C21CA12;
	Mon, 19 May 2025 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xpyVmhem"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC48C148
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 22:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747694608; cv=none; b=mLkuYYQ1qlrXRRaH05N+9hVXOXj5dagndJtTBTRtqGgpacvOUuWThlmeJ2mXWLVbFagKPYbtD2yodNRtBVSihrtHguFjyMB5THpaN4/LDrt1IoUw5DfvF9XoZqlb9AAKHBDJWMEt2rWDLZF36AbdldbUa5f0kIqKfu67vBq2+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747694608; c=relaxed/simple;
	bh=DeNtFkMLpoTZR0KeAhh16JWO15nTjv5IrsAuBKAbaz4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CjB7G8+9fw/Z2MtYz+NBki+VXf0NuTVtemQLanualvHEfNNQrUyIJmb4gLEwWOu0v0d0e5eoFVU8mjpJJhaTug6hqTJSRnnezR0b2USwcdmpxQaTcjnkS6Z4U8vzlRb+Xx+U8c05olqBfwBhV8aGtsEmEFqZsyI1+MRQAcIk7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xpyVmhem; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742d077bdfaso1941998b3a.2
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 15:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747694606; x=1748299406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pxXPhn3v0m/Pz/mXaeIBoyrb/zVbqQ5ITpyAnNtoVxE=;
        b=xpyVmhemBhzkK5Ld5OIOCjEb5REtqBdtLHuXOEjxPIBWGDpVwS7z2SSRwmBrMLcOVB
         T057UQ117BiLaFFEkrAmxDAsx6sO5E+x4j7HUtNJWdJKZKUo1nnx8VRdPlBnxmdvm11I
         tcF3ZMv1/UEqSHBx3Wn0hoyEgxpNsyLXBRZ6UwsH/bMhRkoN9cKbizd0NZaMEJDA2JKN
         VWEuUunWsJ050gm6IN0l3O9TTLy5LA4/JcQmT12I16YyogGZamoOam4j7weBF0KhGZ48
         22BOzuCYGYXN0T34p9zqKsoAYLMa5cG0YKrg0MjQVSoP+XD3WOu2ea7PRLX9bNkFZGM9
         DzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747694606; x=1748299406;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxXPhn3v0m/Pz/mXaeIBoyrb/zVbqQ5ITpyAnNtoVxE=;
        b=nY+DCv9DloIaQBKuDdn9VZFViLBuJ/DVZV40dGntQ6Qa3fBx24w6zHeeI2ITadxhaR
         sv62SgCXWHJ1TTqBBpmnjFs0p+S5l9YK2CNGjpF5AcTgCS5ho0rSwqR8KqJfxeWtJcXW
         HZPs3oG7rHId8RXnINbS4p7taF4hLlrgkRwSsv9l0jHAOtIYkbIJM3ynpdn+M+MxVij4
         493ipy13QQZnR/VOWNhRyxIwQt7js80IlBRgBzxd1Xyhmrekp+2ZGo+m3Z6HXq5tZytv
         s7welAAvt7JvvVsFo6BP8xHjuaGh6sVz0vVnPjQybuPmhK7BGEV6XllgDRIHKm7U60/5
         3STA==
X-Gm-Message-State: AOJu0YyFe8argn8CNb0gBb4zu3en5s0UtL0FT0NyJtvPc76RRBpv8Znv
	kMsV0AJ42K6lxPnXhJ7nZNJlO0jSTkQ0zBekLrqaUiwSGlZzmbExzl6oMSgGTh+KeaiLG4ccxOC
	vDMPa6WDXAiUnlg==
X-Google-Smtp-Source: AGHT+IE2b33zcp3Wu3bZg2/vpiiEv7aoPBe0xQQrLvHk3eoUXSpUpeYNGASRuhfGMf6zUI7JkjsQdJFkBbSL0A==
X-Received: from pgc18.prod.google.com ([2002:a05:6a02:2f92:b0:b26:f37a:9995])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3711:b0:216:5f66:e382 with SMTP id adf61e73a8af0-2165f66e394mr17383224637.35.1747694606327;
 Mon, 19 May 2025 15:43:26 -0700 (PDT)
Date: Mon, 19 May 2025 22:43:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519224325.3117279-1-skhawaja@google.com>
Subject: [PATCH net-next v2] net: stop napi kthreads when THREADED napi is disabled
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

The napi THREADED state should be unset before stopping the thread. This
makes sure that this napi will not be scheduled again for threaded
polling (SCHED_THREADED). In the napi_thread_wait function we need to
make sure that the SCHED_THREADED is not set before stopping. Once the
SCHED_THREADED is unset it means that the napi kthread doesn't own this
napi and it is safe to stop it.

____napi_schedule for threaded napi is also modified to make sure that
the STATE_THREADED is not unset while we are setting SCHED_THREADED and
waking up the napi kthread. If STATE_THREADED is unset while the
threaded napi is being scheduled, the schedule code will recheck the
STATE_THREADED to prevent wakeup of a stopped thread. Use try_cmpxchg to
make sure the value of napi->state is not changed.

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

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---

v2:
- Handle the race where the STATE_THREADED is disabled and kthread is
  stopped while the ____napi_schedule code has already checked the
  STATE_THREADED and tries to wakeup napi kthread that is stopped.

 net/core/dev.c                           | 77 +++++++++++++++++++-----
 tools/testing/selftests/net/nl_netdev.py | 38 +++++++++++-
 2 files changed, 98 insertions(+), 17 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d0563ddff6ca..52d173f5206c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4754,15 +4754,18 @@ int weight_p __read_mostly = 64;           /* old backlog weight */
 int dev_weight_rx_bias __read_mostly = 1;  /* bias for backlog weight */
 int dev_weight_tx_bias __read_mostly = 1;  /* bias for output_queue quota */
 
-/* Called with irq disabled */
-static inline void ____napi_schedule(struct softnet_data *sd,
-				     struct napi_struct *napi)
+static inline bool ____try_napi_schedule_threaded(struct softnet_data *sd,
+						  struct napi_struct *napi)
 {
 	struct task_struct *thread;
+	unsigned long new, val;
 
-	lockdep_assert_irqs_disabled();
+	do {
+		val = READ_ONCE(napi->state);
+
+		if (!(val & NAPIF_STATE_THREADED))
+			return false;
 
-	if (test_bit(NAPI_STATE_THREADED, &napi->state)) {
 		/* Paired with smp_mb__before_atomic() in
 		 * napi_enable()/dev_set_threaded().
 		 * Use READ_ONCE() to guarantee a complete
@@ -4770,17 +4773,30 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 		 * wake_up_process() when it's not NULL.
 		 */
 		thread = READ_ONCE(napi->thread);
-		if (thread) {
-			if (use_backlog_threads() && thread == raw_cpu_read(backlog_napi))
-				goto use_local_napi;
+		if (!thread)
+			return false;
 
-			set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
-			wake_up_process(thread);
-			return;
-		}
-	}
+		if (use_backlog_threads() &&
+		    thread == raw_cpu_read(backlog_napi))
+			return false;
+
+		new = val | NAPIF_STATE_SCHED_THREADED;
+	} while (!try_cmpxchg(&napi->state, &val, new));
+
+	wake_up_process(thread);
+	return true;
+}
+
+/* Called with irq disabled */
+static inline void ____napi_schedule(struct softnet_data *sd,
+				     struct napi_struct *napi)
+{
+	lockdep_assert_irqs_disabled();
+
+	/* try to schedule threaded napi if enabled */
+	if (____try_napi_schedule_threaded(sd, napi))
+		return;
 
-use_local_napi:
 	list_add_tail(&napi->poll_list, &sd->poll_list);
 	WRITE_ONCE(napi->list_owner, smp_processor_id());
 	/* If not called from net_rx_action()
@@ -6888,6 +6904,18 @@ static enum hrtimer_restart napi_watchdog(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+static void dev_stop_napi_threads(struct net_device *dev)
+{
+	struct napi_struct *napi;
+
+	list_for_each_entry(napi, &dev->napi_list, dev_list) {
+		if (napi->thread) {
+			kthread_stop(napi->thread);
+			napi->thread = NULL;
+		}
+	}
+}
+
 int dev_set_threaded(struct net_device *dev, bool threaded)
 {
 	struct napi_struct *napi;
@@ -6926,6 +6954,15 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 	list_for_each_entry(napi, &dev->napi_list, dev_list)
 		assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
 
+	/* Calling kthread_stop on napi threads should be safe now as the
+	 * threaded state is disabled.
+	 */
+	if (!threaded) {
+		/* Make sure the state is set before stopping threads.*/
+		smp_mb__before_atomic();
+		dev_stop_napi_threads(dev);
+	}
+
 	return err;
 }
 EXPORT_SYMBOL(dev_set_threaded);
@@ -7451,7 +7488,8 @@ static int napi_thread_wait(struct napi_struct *napi)
 {
 	set_current_state(TASK_INTERRUPTIBLE);
 
-	while (!kthread_should_stop()) {
+	/* Wait until we are scheduled or asked to stop. */
+	while (true) {
 		/* Testing SCHED_THREADED bit here to make sure the current
 		 * kthread owns this napi and could poll on this napi.
 		 * Testing SCHED bit is not enough because SCHED bit might be
@@ -7463,6 +7501,15 @@ static int napi_thread_wait(struct napi_struct *napi)
 			return 0;
 		}
 
+		/* Since the SCHED_THREADED is not set so this napi kthread does
+		 * not own this napi and it is safe to stop here. Checking the
+		 * SCHED_THREADED before stopping here makes sure that this napi
+		 * was not scheduled again while napi threaded was being
+		 * disabled.
+		 */
+		if (kthread_should_stop())
+			break;
+
 		schedule();
 		set_current_state(TASK_INTERRUPTIBLE);
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
2.49.0.1101.gccaa498523-goog


