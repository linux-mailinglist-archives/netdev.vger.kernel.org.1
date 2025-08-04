Return-Path: <netdev+bounces-211618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A84AB1A81E
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 18:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127FD625261
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B796B2192F4;
	Mon,  4 Aug 2025 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTBFEc13"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6F023FC54
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325901; cv=none; b=oCdOslcPZZdmoYCbxNrD+sidBDdR5oZT4jybE5VlHa/+1+HAi4KEVGcjc1H209qbUWf5NmS2ZNDf4bkDMomdq5WJjrhusJXir6dDXdNR0/rq83xrg8JqO4Pb3QRk3S7o1FcBnVbHLs9fXS27GEcfmLnaXT9FDIQ4yoxh7PXZpQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325901; c=relaxed/simple;
	bh=FCKRL0J8q6fR4AfX9xFFfCwxoesGgoijp3u4Qw/j+9I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Pc1Nfcp0qpKeiYtz/dmtOrFbVXa4cisU5DndGs3naL0o9wFmi8G3f0mPjnhjeW6WRCWKvlY//3SrocldJVGRfTWXrz4U2MKiUquuiOF82NXgDd0t+4QbOx5EKBnIRJj+URCqDrPBdRuEZc1gyM+9wkhhNJGly3CAsNXoEa4eqJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aTBFEc13; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3141f9ce4e2so6101880a91.1
        for <netdev@vger.kernel.org>; Mon, 04 Aug 2025 09:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754325899; x=1754930699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KscKjX2rgXp6Fn+4pO9ARtz/fnPO5iyHeDB8jVVjOLA=;
        b=aTBFEc13SDJQQ77OMD8HyHSna+oOCQzFE4CiMj9bQbt69fhXM6MZPCs25E59SgkHSZ
         lzIqtrzGU30KQBP6x/5iZWjrSTR+2VD5pE8D1o34XA73XS0x73JEvZ1Z08JHufUKeGPi
         COUyl/LWKcD9rs8cg3R4mNJedpe/Gc6K07VkUY0+9JOe97scgeH/P5n42gOm39af8uqt
         UKlUsNJbUBQQTb/dkHTTNSNHs6w8J2NN8FKKtsfMccazeVMsRWw4n0e139K9r0xwaXYb
         AVjZQp6y8ED8sPIdNT467cM5DKLC6zlhTf34PFNLl29dSblWrY63wR3V1/MknBzrGKJj
         Du5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754325899; x=1754930699;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KscKjX2rgXp6Fn+4pO9ARtz/fnPO5iyHeDB8jVVjOLA=;
        b=PPEjWVJfLFZDkjOYYKNk5vBNX7xJkAXzMMAMHwL0825ju74q47B53SMzoyFonTudb4
         Y8kG84UTiiU9ocPVe+4QDHCAFD0/Mvg4L6DqmQb1aBg1D7lwp2U1WzrumEU9Shb6b4Dp
         VwN80gbbiqhGTDfu5nYgtpL/9l1cBiuI584BvYMWqsEQSeAWnOZIhvkWZKW0Sq3qQ7Fl
         QldZmmdhhHfemfwRzBtohDuHfo+nh6YDbb7+nMAJxJI+LeY6F148SKcYzGRdR8zLF3Qm
         HXvNzzWUIHdrlgQmkCOVoUTWf+fnPZo5er4eJ65Asf9MYqVL3WRxi3q3hVaHRWw1cddo
         dGtA==
X-Forwarded-Encrypted: i=1; AJvYcCXc9Kfls73+h7SpZ9COyStKXQ30cSu6QdqMWZmiFJuh4hjmYiMF26koEd5/Lb6QMmXfcUb11kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmzGrjIYgx4okpDy5YJD1fGUwqDTSZ5sBXAl/SFvhfjuktOArh
	AgeRKNgSUrGTEP2MIGVpVYpNPNC6pEFUMFj8f57ZQ1JJH26C7qup//IN/zEt5Zc08l3ujOvYhnm
	s+CbRiluWHGMpQg==
X-Google-Smtp-Source: AGHT+IGe8oGkz1tUxcyqmpoN6cCMPZPbkQPNvSI5e4KCBG1GaIYUQQJgCTtwsbxUwbDXznigvAcfmlawGo0Nag==
X-Received: from pjvv13.prod.google.com ([2002:a17:90b:588d:b0:31e:cee1:4d04])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5804:b0:31f:eae:a7e8 with SMTP id 98e67ed59e1d1-32116203b03mr16539706a91.11.1754325899329;
 Mon, 04 Aug 2025 09:44:59 -0700 (PDT)
Date: Mon,  4 Aug 2025 16:44:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804164457.2494390-1-skhawaja@google.com>
Subject: [PATCH net-next v3] net: Update threaded state in napi config in netif_set_threaded
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, willemb@google.com
Cc: almasrymina@google.com, netdev@vger.kernel.org, skhawaja@google.com, 
	Joe Damato <joe@dama.to>
Content-Type: text/plain; charset="UTF-8"

Commit 2677010e7793 ("Add support to set NAPI threaded for individual
NAPI") added support to enable/disable threaded napi using netlink. This
also extended the napi config save/restore functionality to set the napi
threaded state. This breaks netdev reset for drivers that use napi
threaded at device level and also use napi config save/restore on
napi_disable/napi_enable. Basically on netdev with napi threaded enabled
at device level, a napi_enable call will get stuck trying to stop the
napi kthread. This is because the napi->config->threaded is set to
disabled when threaded is enabled at device level.

The issue can be reproduced on virtio-net device using qemu. To
reproduce the issue run following,

  echo 1 > /sys/class/net/threaded
  ethtool -L eth0 combined 1

Update the threaded state in napi config in netif_set_threaded and add a
new test that verifies this scenario.

Tested on qemu with virtio-net:
 NETIF=eth0 ./tools/testing/selftests/drivers/net/napi_threaded.py
 TAP version 13
 1..2
 ok 1 napi_threaded.change_num_queues
 ok 2 napi_threaded.enable_dev_threaded_disable_napi_threaded
 # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0

Fixes: 2677010e7793 ("Add support to set NAPI threaded for individual NAPI")
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

---

v3:
 - Use napi_set_threaded in netif_set_threaded instead of repeated code.
 - Remove the link up from the test.
 - Change queues count check to ksft_ge in the test.
 - Added deferred cleanup function to restore threaded state and netdev size.

v2:
 - Setting napi threaded state in napi config when enabled at device
   level instead of skipping napi_set_threaded in napi_restore_config.
 - Added a new test in tools/testing/selftest/drivers/net.
---
 net/core/dev.c                                |  26 ++--
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 .../selftests/drivers/net/napi_threaded.py    | 111 ++++++++++++++++++
 3 files changed, 121 insertions(+), 17 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/napi_threaded.py

diff --git a/net/core/dev.c b/net/core/dev.c
index 1c6e755841ce..2e4e9064fdce 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6978,6 +6978,12 @@ int napi_set_threaded(struct napi_struct *napi,
 	if (napi->config)
 		napi->config->threaded = threaded;
 
+	/* Setting/unsetting threaded mode on a napi might not immediately
+	 * take effect, if the current napi instance is actively being
+	 * polled. In this case, the switch between threaded mode and
+	 * softirq mode will happen in the next round of napi_schedule().
+	 * This should not cause hiccups/stalls to the live traffic.
+	 */
 	if (!threaded && napi->thread) {
 		napi_stop_kthread(napi);
 	} else {
@@ -7011,23 +7017,9 @@ int netif_set_threaded(struct net_device *dev,
 
 	WRITE_ONCE(dev->threaded, threaded);
 
-	/* Make sure kthread is created before THREADED bit
-	 * is set.
-	 */
-	smp_mb__before_atomic();
-
-	/* Setting/unsetting threaded mode on a napi might not immediately
-	 * take effect, if the current napi instance is actively being
-	 * polled. In this case, the switch between threaded mode and
-	 * softirq mode will happen in the next round of napi_schedule().
-	 * This should not cause hiccups/stalls to the live traffic.
-	 */
-	list_for_each_entry(napi, &dev->napi_list, dev_list) {
-		if (!threaded && napi->thread)
-			napi_stop_kthread(napi);
-		else
-			assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
-	}
+	/* The error should not occur as the kthreads are already created. */
+	list_for_each_entry(napi, &dev->napi_list, dev_list)
+		WARN_ON_ONCE(napi_set_threaded(napi, threaded));
 
 	return err;
 }
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 3556f3563e08..984ece05f7f9 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -11,6 +11,7 @@ TEST_GEN_FILES := \
 
 TEST_PROGS := \
 	napi_id.py \
+	napi_threaded.py \
 	netcons_basic.sh \
 	netcons_cmdline.sh \
 	netcons_fragmented_msg.sh \
diff --git a/tools/testing/selftests/drivers/net/napi_threaded.py b/tools/testing/selftests/drivers/net/napi_threaded.py
new file mode 100755
index 000000000000..b2698db39817
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/napi_threaded.py
@@ -0,0 +1,111 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Test napi threaded states.
+"""
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_eq, ksft_ne, ksft_ge
+from lib.py import NetDrvEnv, NetdevFamily
+from lib.py import cmd, defer, ethtool
+
+
+def _assert_napi_threaded_enabled(nl, napi_id) -> None:
+    napi = nl.napi_get({'id': napi_id})
+    ksft_eq(napi['threaded'], 'enabled')
+    ksft_ne(napi.get('pid'), None)
+
+
+def _assert_napi_threaded_disabled(nl, napi_id) -> None:
+    napi = nl.napi_get({'id': napi_id})
+    ksft_eq(napi['threaded'], 'disabled')
+    ksft_eq(napi.get('pid'), None)
+
+
+def _set_threaded_state(cfg, threaded) -> None:
+    cmd(f"echo {threaded} > /sys/class/net/{cfg.ifname}/threaded")
+
+
+def _setup_deferred_cleanup(cfg) -> None:
+    combined = ethtool(f"-l {cfg.ifname}", json=True)[0].get("combined", 0)
+    ksft_ge(combined, 2)
+    defer(ethtool, f"-L {cfg.ifname} combined {combined}")
+
+    threaded = cmd(f"cat /sys/class/net/{cfg.ifname}/threaded").stdout
+    defer(_set_threaded_state, cfg, threaded)
+
+
+def enable_dev_threaded_disable_napi_threaded(cfg, nl) -> None:
+    """
+    Test that when napi threaded is enabled at device level and
+    then disabled at napi level for one napi, the threaded state
+    of all napis is preserved after a change in number of queues.
+    """
+
+    napis = nl.napi_get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_ge(len(napis), 2)
+
+    napi0_id = napis[0]['id']
+    napi1_id = napis[1]['id']
+
+    _setup_deferred_cleanup(cfg)
+
+    # set threaded
+    _set_threaded_state(cfg, 1)
+
+    # check napi threaded is set for both napis
+    _assert_napi_threaded_enabled(nl, napi0_id)
+    _assert_napi_threaded_enabled(nl, napi1_id)
+
+    # disable threaded for napi1
+    nl.napi_set({'id': napi1_id, 'threaded': 'disabled'})
+
+    cmd(f"ethtool -L {cfg.ifname} combined 1")
+    cmd(f"ethtool -L {cfg.ifname} combined 2")
+    _assert_napi_threaded_enabled(nl, napi0_id)
+    _assert_napi_threaded_disabled(nl, napi1_id)
+
+
+def change_num_queues(cfg, nl) -> None:
+    """
+    Test that when napi threaded is enabled at device level,
+    the napi threaded state is preserved after a change in
+    number of queues.
+    """
+
+    napis = nl.napi_get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_ge(len(napis), 2)
+
+    napi0_id = napis[0]['id']
+    napi1_id = napis[1]['id']
+
+    _setup_deferred_cleanup(cfg)
+
+    # set threaded
+    _set_threaded_state(cfg, 1)
+
+    # check napi threaded is set for both napis
+    _assert_napi_threaded_enabled(nl, napi0_id)
+    _assert_napi_threaded_enabled(nl, napi1_id)
+
+    cmd(f"ethtool -L {cfg.ifname} combined 1")
+    cmd(f"ethtool -L {cfg.ifname} combined 2")
+
+    # check napi threaded is set for both napis
+    _assert_napi_threaded_enabled(nl, napi0_id)
+    _assert_napi_threaded_enabled(nl, napi1_id)
+
+
+def main() -> None:
+    """ Ksft boiler plate main """
+
+    with NetDrvEnv(__file__, queue_count=2) as cfg:
+        ksft_run([change_num_queues,
+                  enable_dev_threaded_disable_napi_threaded],
+                 args=(cfg, NetdevFamily()))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()

base-commit: fa582ca7e187a15e772e6a72fe035f649b387a60
-- 
2.50.1.565.gc32cd1483b-goog


