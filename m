Return-Path: <netdev+bounces-211060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DE6B16631
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 20:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7018D7A62F4
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 18:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1D82D8DBB;
	Wed, 30 Jul 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yPZo6tvZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778812DFF18
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753899915; cv=none; b=BReeDfVoewP8cWvx5Magd5fQRj4PQd6Z47byCdn8hQO3iPTUKX/K+3upqVLsWAAtAAFUP6bLzusRBwCNP7KS0WSIlDgB0+ep0VH4f0gF3DVDPhR+2pUxWyc6CYLVMJ++OV2ED8FBNKISdBxBrNciC5apyhbTdvL7BKcHcAdzeFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753899915; c=relaxed/simple;
	bh=xcM07qqQG1QkaQR3uER1UumqgobnRGmBV15fWmy0vLw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=axGByKGhwu3O141A4NI2T7jnHTdxXTTFhb9Gk6spemy95GTYy1H9L7567Y2u8xSEOcRobQudHfvVAlbBirVMGYDhIaAgYbf63s+yvoE26s21vR+mkwq4mU319G99OBBZ0R7g1DKdmOvN8tOZVSc68saBzH/NGKx47MCXgYLDgC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yPZo6tvZ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bb326ad0bso102432b3a.0
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753899913; x=1754504713; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kyqA2AGC5gxI8a7nMyJB1BOgUw36FQUHf95EQRzfeeY=;
        b=yPZo6tvZVXD13BFXGrD4nfssSDwNKKysvhxXPasz2laYSqOQmg9lQ5idknSwpdU7u0
         VG6gyS0IeMaljT1u4DHDR6EdlgOGXgoyTAS7C3j8KrecCBxbIEJ3lltRkp5HSbTwQ8vw
         WBfF4z1hzZ7Lxzv4MEx9b2o+erpo1fM9Jt3tubGRadk3kDxI4NeCg04LeJlbia936JMI
         D5ZWQaHLEZuCE4iW6bO+U4lUCTN7GYCNedK3AVCOKcdKxx+rx5aOI5LEBEpW3d8UCxLP
         lxv9nLSNiEzGHauqQgMOg3ZZNRKREFjs1UnxPCZgnTkhHoo/rvbTjH2PgR5ZVL4KAKU2
         Am+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753899913; x=1754504713;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kyqA2AGC5gxI8a7nMyJB1BOgUw36FQUHf95EQRzfeeY=;
        b=G5x5ts8wkKGee8PmoH2LUNXVlXrBZk1Y+zjjg5YQ8hN74Vu8cxq93DXkA5sLOPc3Ps
         48Fy2p+TvmQdZXmUTUKT4zxdz8ErZ3FojrcBX8iN56+XPkTUPggiQDiDfHcLgLtWdRr7
         mfT6bnr6cgKUdfZ9/hXR/1ONq2yakZEK1EJP4MkaqrsWlm2UA1ubpQJZv55Mdt6eaOlR
         poy5BLITZ8umrsYoONT3tG9Yu+psA4/uV75r0N2SvkZNtxRpLzYh72X2aCzL0tDKinGQ
         yLUJ3jqFZ+5z9iHz2CLO8VZUQtHG1eGPwbgUkgo8M02HQE/Fwdg+1FvTlvEN6LZgrv+q
         Xe2g==
X-Forwarded-Encrypted: i=1; AJvYcCWRH+ZKEBXPKE3pk0y8a9rWAPWGhfM0iH/tLV+NM5agGqYhKqCuCHfgZ8M82lWXaAsOXdHjEAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQtaC7f2sbv995XnC6lonQPmHOragWie3Y+WniQDcnEFc38CEx
	TL391ZaRmDwqkNfK6CXu+8EFUELF5Wms2VdQ4gm3eHq/H5oqZ70/LhgzZo0OR+2WUtxKScIPgpx
	pzW3Ks7clWH5UzA==
X-Google-Smtp-Source: AGHT+IE/IUxgbD6Nv856GftLdf7rE1dVpJKra7qsVCFjrhxnIZ7rqquJTWAnpl1uuqhqYahf64MhXNav43QuWQ==
X-Received: from pfgt1.prod.google.com ([2002:a05:6a00:1381:b0:747:a8ac:ca05])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:acc:b0:769:d4b3:74ef with SMTP id d2e1a72fcca58-76ab101926fmr6012117b3a.5.1753899912575;
 Wed, 30 Jul 2025 11:25:12 -0700 (PDT)
Date: Wed, 30 Jul 2025 18:25:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730182511.4059693-1-skhawaja@google.com>
Subject: [PATCH net-next v2] net: Update threaded state in napi config in netif_set_threaded
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

v2:
 - Setting napi threaded state in napi config when enabled at device
   level instead of skipping napi_set_threaded in napi_restore_config.
 - Added a new test in tools/testing/selftest/drivers/net.
---
 net/core/dev.c                                |   3 +
 .../selftests/drivers/net/napi_threaded.py    | 108 ++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/napi_threaded.py

diff --git a/net/core/dev.c b/net/core/dev.c
index 1c6e755841ce..1abba4fc1eec 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7023,6 +7023,9 @@ int netif_set_threaded(struct net_device *dev,
 	 * This should not cause hiccups/stalls to the live traffic.
 	 */
 	list_for_each_entry(napi, &dev->napi_list, dev_list) {
+		if (napi->config)
+			napi->config->threaded = threaded;
+
 		if (!threaded && napi->thread)
 			napi_stop_kthread(napi);
 		else
diff --git a/tools/testing/selftests/drivers/net/napi_threaded.py b/tools/testing/selftests/drivers/net/napi_threaded.py
new file mode 100755
index 000000000000..f2168864568e
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/napi_threaded.py
@@ -0,0 +1,108 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Test napi threaded states.
+"""
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_eq, ksft_ne
+from lib.py import NetDrvEnv, NetdevFamily
+from lib.py import cmd, defer, ip
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
+def enable_dev_threaded_disable_napi_threaded(cfg, nl) -> None:
+    """
+    Test that when napi threaded is enabled at device level and
+    then disabled at napi level for one napi, the threaded state
+    of all napis is preserved after a change in number of queues.
+    """
+
+    ip(f"link set dev {cfg.ifname} up")
+
+    napis = nl.napi_get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(napis), 2)
+
+    napi0_id = napis[0]['id']
+    napi1_id = napis[1]['id']
+
+    threaded = cmd(f"cat /sys/class/net/{cfg.ifname}/threaded").stdout
+    defer(_set_threaded_state, cfg, threaded)
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
+    ip(f"link set dev {cfg.ifname} up")
+
+    napis = nl.napi_get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(napis), 2)
+
+    napi0_id = napis[0]['id']
+    napi1_id = napis[1]['id']
+
+    threaded = cmd(f"cat /sys/class/net/{cfg.ifname}/threaded").stdout
+    defer(_set_threaded_state, cfg, threaded)
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
2.50.1.552.g942d659e1b-goog


