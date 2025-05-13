Return-Path: <netdev+bounces-189927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90BAAB4861
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367DD1B4109F
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 00:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB6B2E403;
	Tue, 13 May 2025 00:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UEj1+Ibf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ABF1BC2A
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 00:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747095995; cv=none; b=izPqVk4oN9L3K0H3CIDrJ/jshKGYrJcRLY8KoblwHCPm6KB3ZDrC8mXtjYq1Oz7l3RhFCMivdFs+1/soOjqo5aKAqw0OuddFyBZREDs0Wk+9N2o837BE8+y1pvOH6p5H7v3V5zkisCwYmJBA9vebbRtY2wQ7e9QDfM98EoHzRwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747095995; c=relaxed/simple;
	bh=8nMsGmoy9RPcU6ph5olCh6PcmcTmktwSq2rWwWc87X4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VTRsw+W3tdbyAjceG9E7RkKsjYGzy670p4XxxmX781yHJflUPim+vku4j9uMAb687ROcuUv7oLCy7shLAwUzjKKUXeA7T0EyZdTPZPoMy7aYutpPFQoSh5MTa7u4VIcWSINayHGNvgP75r3lEcBz/KW6cMaO1tzm+lhoyUhnAkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UEj1+Ibf; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7401179b06fso4249804b3a.1
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 17:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747095993; x=1747700793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MsL8xwNKyOP5Xay7uOzmVEqMUFjUH2iNItslhjDG+Tc=;
        b=UEj1+IbfN+3gX5JC2ItA7bDRICFs3fEaGNsr7AI/Y+lKaiUt7be7ConZmhGMbNjldR
         2F+KYrtmrDJ/MLLtNXv9wgu0xnk0D6ygKBP2Mvr62RGRrlVRZ1wNdVsBrWlFMuWRZJEA
         FHx7LUbM2nbLC4EZbLmXnJCenS3qlL/9TXwhq+YyHpeasEkboXaveIPNCB9Iedec/m2Z
         ghUvQVF9S+lrBRrTnVfK/OF3i/noubliXri4/S4wVU++W954u/2lSU1rebtS5S+cfAYB
         QsLjMMQvpI6ZhT1giDuiz12CiLkg7MVnVKAgUaD4ZofLsMHMdsmNBq8nliqZ/mWSsHxB
         zEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747095993; x=1747700793;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MsL8xwNKyOP5Xay7uOzmVEqMUFjUH2iNItslhjDG+Tc=;
        b=uq8c35s9BN+5zjJgXmEop/126UBkcPdSEtmWjhseiG+GR4WS3+J+BJOqyOJhRmgSWC
         wGUuh5DnwJYBSRaptQQQOZu/2ZBGehhq8+1o5nPY/+E2IChCA9Tma3qwT4fWoS5MKfE9
         p1tO5NRjHksHqRZezz+AZFGGX20t+D8Hf0xcnaRQj7unQKASCSiSXUAv+nFdXrz/94fI
         sb8buqVNA8dW/LsexmBOcViJzqswKN9KUXjTpm0rgdnjIPp035krDjb5IWikRycMSX/K
         wWgp9QMjFW1InId2qZxn1VF1Xk/vRmKaFbFUEHYBb/za6oh2FhwRi4f9rTDBALU7R7zz
         sBzg==
X-Gm-Message-State: AOJu0Yz46JmXl8EugpMcBr5Ofsb86xykUDe81B/2dFo7FVECmI85Ibh1
	yGiRQ6Fl/PgjCXN6Im+NfCdBr1KHW6PMkvnrKZly85RwQhibOQ2m/ijwVwQQ+rfcCm/GGRRUq76
	OnDUYMzXD5w==
X-Google-Smtp-Source: AGHT+IEuj94niWoJeoglwnFczy3TDgnPZ7YJ5FSFk/PJY8qlLRWJXZ9HP053zROwgxDm9rMuPpWFjq/JfgiWyw==
X-Received: from pgbdo5.prod.google.com ([2002:a05:6a02:e85:b0:af2:4edb:7793])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:411f:b0:215:ce2e:8b1e with SMTP id adf61e73a8af0-215ce2ec8acmr7472333637.26.1747095993052;
 Mon, 12 May 2025 17:26:33 -0700 (PDT)
Date: Tue, 13 May 2025 00:26:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513002631.3155191-1-skhawaja@google.com>
Subject: [PATCH net-next] net: stop napi kthreads when THREADED napi is disabled
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

This was discussed in the following patch:
https://lore.kernel.org/all/20250502191548.559cc416@kernel.org

The napi THREADED state should be unset before stopping the thread. This
makes sure that this napi will not be scheduled again for threaded
polling (SCHED_THREADED). In the napi_thread_wait function we need to
make sure that the SCHED_THREADED is not set before stopping.  Once the
SCHED_THREADED is unset it means that the napi kthread doesn't own this
napi and it is safe to stop it.

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
Reviewed-by: Wei Wang <weiwan@google.com>
---
 net/core/dev.c                           | 30 ++++++++++++++++++-
 tools/testing/selftests/net/nl_netdev.py | 38 ++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d0563ddff6ca..fec2dee9533f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6888,6 +6888,18 @@ static enum hrtimer_restart napi_watchdog(struct hrtimer *timer)
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
@@ -6926,6 +6938,12 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 	list_for_each_entry(napi, &dev->napi_list, dev_list)
 		assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
 
+	/* Calling kthread_stop on napi threads should be safe now as the
+	 * threaded state is disabled.
+	 */
+	if (!threaded)
+		dev_stop_napi_threads(dev);
+
 	return err;
 }
 EXPORT_SYMBOL(dev_set_threaded);
@@ -7451,7 +7469,8 @@ static int napi_thread_wait(struct napi_struct *napi)
 {
 	set_current_state(TASK_INTERRUPTIBLE);
 
-	while (!kthread_should_stop()) {
+	/* Wait until we are scheduled or asked to stop. */
+	while (true) {
 		/* Testing SCHED_THREADED bit here to make sure the current
 		 * kthread owns this napi and could poll on this napi.
 		 * Testing SCHED bit is not enough because SCHED bit might be
@@ -7463,6 +7482,15 @@ static int napi_thread_wait(struct napi_struct *napi)
 			return 0;
 		}
 
+		/* Since the SCHED_THREADED is not set so we do not own this
+		 * napi and it is safe to stop here if we are asked to. Checking
+		 * the SCHED_THREADED before stopping here makes sure that this
+		 * napi was not schedule again while napi threaded was being
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
2.49.0.1045.g170613ef41-goog


