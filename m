Return-Path: <netdev+bounces-257673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMP7FUeJhmmOOgQAu9opvQ
	(envelope-from <netdev+bounces-257673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:37:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FD1104573
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C09AF306C501
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 00:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4467F239E7D;
	Sat,  7 Feb 2026 00:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXRh6zjP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D92212F89;
	Sat,  7 Feb 2026 00:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770424523; cv=none; b=F27g5Sviporh8/vpntSLqJLCmfpAJTSZs34LbyN+u/UfZSdp62GDDW85O8/y6QAJKdU5akZ8DbWfoL/lMYvAB9Mx5W3u1soQflhMZL53nIImPDa+/TiFPiwkqoQ3yfzbAuL6wrFrTPfz6RdsGqOWKbKNpYRhm7UgiTNl+GLtvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770424523; c=relaxed/simple;
	bh=32rlDhmCkQ4jOtAgK9feJws4V+wYoAB+fZ/p02O4mpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4eamGDDN75jKbEm8snbDD68pL4JGNaTQDs7rvbad51FOeq0S/gzBOtOlaiBFUIBigfDHf/BOLRNmMGgeG1r1Ikl/CjVDv5u/2m2DGHMjA3rZzLXoS/H1ByateRzbr5t6ktIFsO+hpPSjEUyAwmCTv5OFv3+XeuuKhX7cKoWWB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXRh6zjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65062C116C6;
	Sat,  7 Feb 2026 00:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770424523;
	bh=32rlDhmCkQ4jOtAgK9feJws4V+wYoAB+fZ/p02O4mpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXRh6zjPuTr5Q0KAI2NML7pvlAcHvkjEKktp9VS04z8Qy+Lz9GHjrbROnG6JTth5K
	 pq86yUCfu0EKNcsizEf804PhwRp1BXGvK4zpFm0sjbCPfaO7xC3ue7Y2C0dh1FpDJP
	 PNO7exqEP/ngCaZKl465z8fU0Xd4DDV0avBMYk4FERPDdMy2hbKgiwlkDAsK1VUKau
	 vjvwzqJ/RjaZUWbhX5te43ylJHQV6ouAbmZmG218QBMr3yStg/KxeNw16f7mBPiDVe
	 yrrsgxhnDAsWj4NWws+Jo9X/U5xsqqqLrWh0oX6+RfpmEpbsA+SQoQHRmg1HtGCJFD
	 NazloMU58dxjw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 9/9] selftests: drv-net: gro: add a test for GRO depth
Date: Fri,  6 Feb 2026 16:35:09 -0800
Message-ID: <20260207003509.3927744-10-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260207003509.3927744-1-kuba@kernel.org>
References: <20260207003509.3927744-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-257673-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url]
X-Rspamd-Queue-Id: B3FD1104573
X-Rspamd-Action: no action

Reuse the long sequence test to max out the GRO contexts.
Repeat for a single queue, 8 queues, and default number
of queues but flow steering to just one.

The SW GRO's capacity should be around 64 per queue
(8 buckets, up to 8 skbs in a chain).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - move this "test" to SW, we can check SW GRO capacity too
v1: https://lore.kernel.org/20260205220541.2992807-10-kuba@kernel.org
---
 tools/testing/selftests/drivers/net/gro.py | 201 +++++++++++++++++++--
 1 file changed, 181 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 2da53686354f..795dbcc583a3 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -35,11 +35,18 @@ coalescing behavior.
   - large_rem: Large packet remainder handling
 """
 
+import glob
 import os
+import re
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import NetDrvEpEnv, KsftXfailEx
+from lib.py import NetdevFamily, EthtoolFamily
 from lib.py import bkg, cmd, defer, ethtool, ip
-from lib.py import ksft_variants
+from lib.py import ksft_variants, KsftNamedVariant
+
+
+# gro.c uses hardcoded DPORT=8000
+GRO_DPORT = 8000
 
 
 def _resolve_dmac(cfg, ipver):
@@ -113,6 +120,98 @@ from lib.py import ksft_variants
         ksft_pr(eth_cmd)
 
 
+def _get_queue_stats(cfg, queue_id):
+    """Get stats for a specific Rx queue."""
+    cfg.wait_hw_stats_settle()
+    data = cfg.netnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]},
+                                dump=True)
+    for q in data:
+        if q.get('queue-type') == 'rx' and q.get('queue-id') == queue_id:
+            return q
+    return {}
+
+
+def _setup_isolated_queue(cfg):
+    """Set up an isolated queue for testing using ntuple filter.
+
+    Remove queue 1 from the default RSS context and steer test traffic to it.
+    """
+    test_queue = 1
+
+    qcnt = len(glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*"))
+    if qcnt < 2:
+        raise KsftXfailEx(f"Need at least 2 queues, have {qcnt}")
+
+    # Remove queue 1 from default RSS context by setting its weight to 0
+    weights = ["1"] * qcnt
+    weights[test_queue] = "0"
+    ethtool(f"-X {cfg.ifname} weight " + " ".join(weights))
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    # Set up ntuple filter to steer our test traffic to the isolated queue
+    flow  = f"flow-type tcp{cfg.addr_ipver} "
+    flow += f"dst-ip {cfg.addr} dst-port {GRO_DPORT} action {test_queue}"
+    output = ethtool(f"-N {cfg.ifname} {flow}").stdout
+    ntuple_id = int(output.split()[-1])
+    defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
+
+    return test_queue
+
+
+def _setup_queue_count(cfg, num_queues):
+    """Configure the NIC to use a specific number of queues."""
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    ch_max = channels.get('combined-max', 0)
+    qcnt = channels['combined-count']
+
+    if ch_max < num_queues:
+        raise KsftXfailEx(f"Need at least {num_queues} queues, max={ch_max}")
+
+    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
+    ethtool(f"-L {cfg.ifname} combined {num_queues}")
+
+
+def _run_gro_bin(cfg, test_name, protocol=None, num_flows=None,
+                 order_check=False, verbose=False, fail=False):
+    """Run gro binary with given test and return the process result."""
+    if not hasattr(cfg, "bin_remote"):
+        cfg.bin_local = cfg.net_lib_dir / "gro"
+        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
+
+    if protocol is None:
+        ipver = cfg.addr_ipver
+        protocol = f"ipv{ipver}"
+    else:
+        ipver = "6" if protocol[-1] == "6" else "4"
+
+    dmac = _resolve_dmac(cfg, ipver)
+
+    base_args = [
+        f"--{protocol}",
+        f"--dmac {dmac}",
+        f"--smac {cfg.remote_dev['address']}",
+        f"--daddr {cfg.addr_v[ipver]}",
+        f"--saddr {cfg.remote_addr_v[ipver]}",
+        f"--test {test_name}",
+    ]
+    if num_flows:
+        base_args.append(f"--num-flows {num_flows}")
+    if order_check:
+        base_args.append("--order-check")
+    if verbose:
+        base_args.append("--verbose")
+
+    args = " ".join(base_args)
+
+    rx_cmd = f"{cfg.bin_local} {args} --rx --iface {cfg.ifname}"
+    tx_cmd = f"{cfg.bin_remote} {args} --iface {cfg.remote_ifname}"
+
+    with bkg(rx_cmd, ksft_ready=True, exit_wait=True, fail=fail) as rx_proc:
+        cmd(tx_cmd, host=cfg.remote)
+
+    return rx_proc
+
+
 def _setup(cfg, mode, test_name):
     """ Setup hardware loopback mode for GRO testing. """
 
@@ -233,30 +332,14 @@ from lib.py import ksft_variants
 
     _setup(cfg, mode, test_name)
 
-    base_cmd_args = [
-        f"--{protocol}",
-        f"--dmac {_resolve_dmac(cfg, ipver)}",
-        f"--smac {cfg.remote_dev['address']}",
-        f"--daddr {cfg.addr_v[ipver]}",
-        f"--saddr {cfg.remote_addr_v[ipver]}",
-        f"--test {test_name}",
-        "--verbose"
-    ]
-    base_args = " ".join(base_cmd_args)
-
     # Each test is run 6 times to deflake, because given the receive timing,
     # not all packets that should coalesce will be considered in the same flow
     # on every try.
     max_retries = 6
     for attempt in range(max_retries):
-        rx_cmd = f"{cfg.bin_local} {base_args} --rx --iface {cfg.ifname}"
-        tx_cmd = f"{cfg.bin_remote} {base_args} --iface {cfg.remote_ifname}"
-
         fail_now = attempt >= max_retries - 1
-
-        with bkg(rx_cmd, ksft_ready=True, exit_wait=True,
-                 fail=fail_now) as rx_proc:
-            cmd(tx_cmd, host=cfg.remote)
+        rx_proc = _run_gro_bin(cfg, test_name, protocol=protocol,
+                               verbose=True, fail=fail_now)
 
         if rx_proc.ret == 0:
             return
@@ -270,11 +353,89 @@ from lib.py import ksft_variants
         ksft_pr(f"Attempt {attempt + 1}/{max_retries} failed, retrying...")
 
 
+def _capacity_variants():
+    """Generate variants for capacity test: mode x queue setup."""
+    setups = [
+        ("isolated", _setup_isolated_queue),
+        ("1q", lambda cfg: _setup_queue_count(cfg, 1)),
+        ("8q", lambda cfg: _setup_queue_count(cfg, 8)),
+    ]
+    for mode in ["sw", "hw", "lro"]:
+        for name, func in setups:
+            yield KsftNamedVariant(f"{mode}_{name}", mode, func)
+
+
+@ksft_variants(_capacity_variants())
+def test_gro_capacity(cfg, mode, setup_func):
+    """
+    Probe GRO capacity.
+
+    Start with 8 flows and increase by 2x on each successful run.
+    Retry up to 3 times on failure.
+
+    Variants combine mode (sw, hw, lro) with queue setup:
+      - isolated: Use a single queue isolated from RSS
+      - 1q: Configure NIC to use 1 queue
+      - 8q: Configure NIC to use 8 queues
+    """
+    max_retries = 3
+
+    _setup(cfg, mode, "capacity")
+    queue_id = setup_func(cfg)
+
+    num_flows = 8
+    while True:
+        success = False
+        for attempt in range(max_retries):
+            if queue_id is not None:
+                stats_before = _get_queue_stats(cfg, queue_id)
+
+            rx_proc = _run_gro_bin(cfg, "capacity", num_flows=num_flows)
+            output = rx_proc.stdout
+
+            if queue_id is not None:
+                stats_after = _get_queue_stats(cfg, queue_id)
+                qstat_pkts = (stats_after.get('rx-packets', 0) -
+                              stats_before.get('rx-packets', 0))
+                gro_pkts = (stats_after.get('rx-hw-gro-packets', 0) -
+                            stats_before.get('rx-hw-gro-packets', 0))
+                qstat_str = f" qstat={qstat_pkts} hw-gro={gro_pkts}"
+            else:
+                qstat_str = ""
+
+            # Parse and print STATS line
+            match = re.search(
+                r'STATS: received=(\d+) wire=(\d+) coalesced=(\d+)', output)
+            if match:
+                received = int(match.group(1))
+                wire = int(match.group(2))
+                coalesced = int(match.group(3))
+                status = "PASS" if received == num_flows else "FAIL"
+                ksft_pr(f"flows={num_flows} attempt={attempt + 1} "
+                        f"received={received} wire={wire} "
+                        f"coalesced={coalesced}{qstat_str} [{status}]")
+                if received == num_flows:
+                    success = True
+                    break
+            else:
+                ksft_pr(rx_proc)
+                ksft_pr(f"flows={num_flows} attempt={attempt + 1}"
+                        f"{qstat_str} [FAIL - can't parse stats]")
+
+        if not success:
+            ksft_pr(f"Stopped at {num_flows} flows")
+            break
+
+        num_flows *= 2
+
+
 def main() -> None:
     """ Ksft boiler plate main """
 
     with NetDrvEpEnv(__file__) as cfg:
-        ksft_run(cases=[test], args=(cfg,))
+        cfg.ethnl = EthtoolFamily()
+        cfg.netnl = NetdevFamily()
+        ksft_run(cases=[test, test_gro_capacity], args=(cfg,))
     ksft_exit()
 
 
-- 
2.53.0


