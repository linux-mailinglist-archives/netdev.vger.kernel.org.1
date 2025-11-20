Return-Path: <netdev+bounces-240263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6608DC71FE4
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 083F434B61A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2646A2FB0BD;
	Thu, 20 Nov 2025 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="r9FxiQ6L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F33F2F12C0
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609425; cv=none; b=NaQBaq+/Qn6VjRSTlYAJD34N7PU4AGp9RE04Ewm12c/QkV08fT4gIPHIxKKf7AT9wIor8iwLSO0FOavc1j/OPftuElOS/4NXiUz55YxiPn4rGfvKc6Jx/Lt/YBt3Lq0e67AdJVhj4geuX1lJLaqG4yByg+Zv8MmLS45I8456HOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609425; c=relaxed/simple;
	bh=tODjvHtLEOFd4l/9hUUDDLNzE/aKJg3yfj0LXelvcOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vClJyL6k7y2c0DsW1ovvJNpI2LraX2gGD2xuQDi0CHA1gi37nktNRs9Xy3QAby9+9Aj8bfGUbI0gRmbQk40Da8iObGPP41YA5MywAEnayx3bqoTn5yxvJIDNEYdmXKih4zPZJKqg8EZktZWoQdtx+ZpEQs3MjhrTs/g6Gjs4/gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=r9FxiQ6L; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c6d699610cso129010a34.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763609422; x=1764214222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XE/kEV8Iv/KPEflTGU8vOfxmufGP4K7iSm172nlOA+c=;
        b=r9FxiQ6LmjnNWdDBhu6AZoP/KGyyHGx78FMxeKS0a6UONXanSPIh4/Vq72/0qmkgot
         FzWJOsYs6GnjBIouCk67TgNlZg0dsBPkCqBpzgwMeURUsKRWLYP5tCIQ7OJlT+t2wYAY
         Oolddh2766EiRaNG++MaFr2fytPYwSUlzOrNB4fnat8kGTcqtKZIFkx/IWo3p6Q9YRKJ
         guJlcIU/LkXAHVugzJI+qugqlYC6pbz6GRpmdD9Dd52CROcevuZ3d9fNTCcHlg6F3Yvw
         pL2V9WYJ3kgyGyJ7YRxGIssknMHDHRPY8lc58yAjRPWAJ61wfDqdzrqtA91nFnbdPmQm
         g//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763609422; x=1764214222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XE/kEV8Iv/KPEflTGU8vOfxmufGP4K7iSm172nlOA+c=;
        b=eaHEtXo8iyk/11flfTiQVCCgQlHPyizSXgfCDoLy9pNVq0Ll9tqmsNh9XKJNN0AGUd
         X2S6g14aCKsqcri2Hob0+bOZatZ53ncrZddeDoqJDU0FQKdJLnzijI2slYBSG2JpDq+W
         nDU11Zg7K/9XoPwSpUwOW3YqnBXARxNj1HoWpxaHTAClxVfnicg/VR7i+IJaDhLZ3otM
         A/0aEScTdj56huEu3dXrvUP/XJE7v46XwtlDWXC3nO7Ze6cQY+9ZEN1HqaUoiz4q3Pt8
         QfyxODG+6TApcRGV0sfOSV4I4QZIALynCT3I2JArrUhjTb0Zd3p7ImE0UHfKehtolPLw
         rBCQ==
X-Gm-Message-State: AOJu0YyuPgEwbJ8DLnVv467RKPfLgZRsTGOmmKqfgVDkQDcdwZNvliLw
	k/bxqCaQ5335lq0/OS5GTiZVceKMmNQ4R1qe/QXACtKOyhuT91DeN4rvP4GoYphcGYVXs1HCq03
	UCUJt
X-Gm-Gg: ASbGncuHWYotKrcEatjeirIRDPsAxr8F5eROMnwy0fih2CbIeLNxpSEbYqABH+40SQk
	jTKp8g6T5XIw4TF7JGDxq1mbBHZz9Td7KNgYgJKhmyBkbX+i2o471Uug716VUZNp/NHWKdE7bMn
	W2fDTdLcrUXYdhv4QC9Ds8a6DDpUtYbE1p3o+kXR6m5vm3GARL1upI42VvQupALV6hoO9KBPyaG
	h7iXAd3rTsDdnfzA9xVBSiY2piPR2wG6oe8Ebtd7CoVJiY/sHwBT6dv/1h0WX/LEQ8tYWvqS4Kq
	gtG3jHUO4nOMP1mA0f9twq0PJysToC7BRXuxy1BlsBmwWb1oM4OVR7fcZ/68Q9GOITS4Dx9NCpt
	2gLQk5Bc9UdYrGtn43b5hAA+5IVgsYY8hkx6uit2C6SSplvychHZ2xXGQdLVcDcsyRC7Sjo5c/R
	bFNHKNz7ZGuhpii3qcAPP2EMQiOd4JL36o5quZFBeJACxg7MCk6Mf7
X-Google-Smtp-Source: AGHT+IFrTUWGU8N/btyZeQTNeKLoG3ysZmBYTj9a7YWKAkzIWLQvlY/95l/9/q5XDFQ3FMwzwb1ORw==
X-Received: by 2002:a05:6830:700c:b0:799:c0c8:e9d1 with SMTP id 46e09a7af769-7c78d2dada0mr1562918a34.24.1763609422027;
        Wed, 19 Nov 2025 19:30:22 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d4282bdsm569799a34.28.2025.11.19.19.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 19:30:21 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v1 3/7] selftests/net: modify iou-zcrx.py to use MemPrvEnv
Date: Wed, 19 Nov 2025 19:30:12 -0800
Message-ID: <20251120033016.3809474-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120033016.3809474-1-dw@davidwei.uk>
References: <20251120033016.3809474-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify iou-zcrx.py to use MemPrvEnv which shortens the test
significantly.

In addition, there's no need to duplicate the test with and without RSS.
Set up two envs to do this. This makes it easier to repeat each test,
with and without RSS.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 .../selftests/drivers/net/hw/iou-zcrx.py      | 131 +++---------------
 1 file changed, 16 insertions(+), 115 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index 712c806508b5..4b99ab090b7c 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -1,143 +1,44 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
-import re
 from os import path
-from lib.py import ksft_run, ksft_exit, KsftSkipEx
-from lib.py import NetDrvEpEnv
-from lib.py import bkg, cmd, defer, ethtool, rand_port, wait_port_listen
-
-
-def _get_current_settings(cfg):
-    output = ethtool(f"-g {cfg.ifname}", json=True)[0]
-    return (output['rx'], output['hds-thresh'])
-
-
-def _get_combined_channels(cfg):
-    output = ethtool(f"-l {cfg.ifname}").stdout
-    values = re.findall(r'Combined:\s+(\d+)', output)
-    return int(values[1])
-
-
-def _create_rss_ctx(cfg, chan):
-    output = ethtool(f"-X {cfg.ifname} context new start {chan} equal 1").stdout
-    values = re.search(r'New RSS context is (\d+)', output).group(1)
-    ctx_id = int(values)
-    return (ctx_id, defer(ethtool, f"-X {cfg.ifname} delete context {ctx_id}"))
-
-
-def _set_flow_rule(cfg, port, chan):
-    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} action {chan}").stdout
-    values = re.search(r'ID (\d+)', output).group(1)
-    return int(values)
-
-
-def _set_flow_rule_rss(cfg, port, ctx_id):
-    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} context {ctx_id}").stdout
-    values = re.search(r'ID (\d+)', output).group(1)
-    return int(values)
+from lib.py import ksft_run, ksft_exit
+from lib.py import MemPrvEnv
+from lib.py import bkg, cmd, wait_port_listen
 
 
 def test_zcrx(cfg) -> None:
     cfg.require_ipver('6')
 
-    combined_chans = _get_combined_channels(cfg)
-    if combined_chans < 2:
-        raise KsftSkipEx('at least 2 combined channels required')
-    (rx_ring, hds_thresh) = _get_current_settings(cfg)
-    port = rand_port()
-
-    ethtool(f"-G {cfg.ifname} tcp-data-split on")
-    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto")
-
-    ethtool(f"-G {cfg.ifname} hds-thresh 0")
-    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}")
-
-    ethtool(f"-G {cfg.ifname} rx 64")
-    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}")
-
-    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}")
-    defer(ethtool, f"-X {cfg.ifname} default")
-
-    flow_rule_id = _set_flow_rule(cfg, port, combined_chans - 1)
-    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
-
-    rx_cmd = f"{cfg.bin_local} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1}"
-    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {port} -l 12840"
+    rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {cfg.target_queue}"
+    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {cfg.port} -l 12840"
     with bkg(rx_cmd, exit_wait=True):
-        wait_port_listen(port, proto="tcp")
+        wait_port_listen(cfg.port, proto="tcp")
         cmd(tx_cmd, host=cfg.remote)
 
 
 def test_zcrx_oneshot(cfg) -> None:
     cfg.require_ipver('6')
 
-    combined_chans = _get_combined_channels(cfg)
-    if combined_chans < 2:
-        raise KsftSkipEx('at least 2 combined channels required')
-    (rx_ring, hds_thresh) = _get_current_settings(cfg)
-    port = rand_port()
-
-    ethtool(f"-G {cfg.ifname} tcp-data-split on")
-    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto")
-
-    ethtool(f"-G {cfg.ifname} hds-thresh 0")
-    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}")
-
-    ethtool(f"-G {cfg.ifname} rx 64")
-    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}")
-
-    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}")
-    defer(ethtool, f"-X {cfg.ifname} default")
-
-    flow_rule_id = _set_flow_rule(cfg, port, combined_chans - 1)
-    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
-
-    rx_cmd = f"{cfg.bin_local} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1} -o 4"
-    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {port} -l 4096 -z 16384"
+    rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {cfg.target_queue} -o 4"
+    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {cfg.port} -l 4096 -z 16384"
     with bkg(rx_cmd, exit_wait=True):
-        wait_port_listen(port, proto="tcp")
+        wait_port_listen(cfg.port, proto="tcp")
         cmd(tx_cmd, host=cfg.remote)
 
 
-def test_zcrx_rss(cfg) -> None:
-    cfg.require_ipver('6')
-
-    combined_chans = _get_combined_channels(cfg)
-    if combined_chans < 2:
-        raise KsftSkipEx('at least 2 combined channels required')
-    (rx_ring, hds_thresh) = _get_current_settings(cfg)
-    port = rand_port()
-
-    ethtool(f"-G {cfg.ifname} tcp-data-split on")
-    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto")
-
-    ethtool(f"-G {cfg.ifname} hds-thresh 0")
-    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}")
-
-    ethtool(f"-G {cfg.ifname} rx 64")
-    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}")
-
-    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}")
-    defer(ethtool, f"-X {cfg.ifname} default")
-
-    (ctx_id, delete_ctx) = _create_rss_ctx(cfg, combined_chans - 1)
-    flow_rule_id = _set_flow_rule_rss(cfg, port, ctx_id)
-    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
-
-    rx_cmd = f"{cfg.bin_local} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1}"
-    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {port} -l 12840"
-    with bkg(rx_cmd, exit_wait=True):
-        wait_port_listen(port, proto="tcp")
-        cmd(tx_cmd, host=cfg.remote)
+def main() -> None:
+    with MemPrvEnv(__file__) as cfg:
+        cfg.bin_local = path.abspath(path.dirname(__file__) + "/../../../drivers/net/hw/iou-zcrx")
+        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
+        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg,))
 
-def main() -> None:
-    with NetDrvEpEnv(__file__) as cfg:
+    with MemPrvEnv(__file__, rss=True) as cfg:
         cfg.bin_local = path.abspath(path.dirname(__file__) + "/../../../drivers/net/hw/iou-zcrx")
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
-        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, ))
+        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg,), case_sfx="_rss")
     ksft_exit()
 
 
-- 
2.47.3


