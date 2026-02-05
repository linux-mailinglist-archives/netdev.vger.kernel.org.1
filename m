Return-Path: <netdev+bounces-257325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEfoArsUhWkh8QMAu9opvQ
	(envelope-from <netdev+bounces-257325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:07:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCE8F7F43
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BB123008D0D
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA303370FE;
	Thu,  5 Feb 2026 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cf9wVidB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA0335559;
	Thu,  5 Feb 2026 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770329248; cv=none; b=mLcixhlQLDZ8RWpXsj+Bz0yH4xu8cqyeAoVwxmJHCC79VU2ykHOPfvUMhT3FCHJ/QGgo7box8iI70Qwagy7BNvcUDfd6U8eTi3vVK62ir9H6pfyxDMiYhWxXa0tEnDaM6CBZE/DoGaFi9v9oXRIP3a4zVzCtcTAfx3QRw+X8KEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770329248; c=relaxed/simple;
	bh=yqlIMuA1mVgKcz/A/e95QhtE1tffZhB7Y+oRQIasO6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4YoxmV4ZUFdLu4MxqQYSBiiuFgV8sVjmMmcT/a+yRVPax+cpbgkjmLMRTCi53OXfiLIsDykXvJLZzqCu/NrnzHynP6zyXBGwBzcTpJP+AP5vPwCSjSI0ac6eMnYOd55zI+cV8DZkueWde1vnwA9wJWtz7xdGE1nTvYkipyHaag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cf9wVidB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C1DC4CEF7;
	Thu,  5 Feb 2026 22:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770329248;
	bh=yqlIMuA1mVgKcz/A/e95QhtE1tffZhB7Y+oRQIasO6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cf9wVidBG+q5VosskXUy4EJEmNv6dEZczBujexF7QH3/2DLSLbccH3BEMSDdDMB23
	 kvDRUXFtO00lxLlg/cgq73fU+TGU78BGh9yQfjTv6UKqetBaI19I0gbmh+DNGlMwF9
	 IaVqjbbq9Zpj4to6GG6X41n4lAZ9DrZCurSGArr5Y0nVVAvsMUySTkVY5NFU61Ye7S
	 8ErGTYMyrnoJNN5MbnuuM832u6qbF1SfDg9d5beJ96AHYAYuVoChSbDVhT292JIHCJ
	 mJ/20V/fB6lWZvykR4Qivgc/Ol+18CkWmevr6XbFvlvlK6BvK0Ruz+rUFjcnLwihxd
	 ylccBf8/PkOJg==
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
Subject: [PATCH net-next 9/9] selftests: drv-net: gro: add a test for HW-GRO depth
Date: Thu,  5 Feb 2026 14:05:41 -0800
Message-ID: <20260205220541.2992807-10-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260205220541.2992807-1-kuba@kernel.org>
References: <20260205220541.2992807-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-257325-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lib.py:url]
X-Rspamd-Queue-Id: 1BCE8F7F43
X-Rspamd-Action: no action

Reuse the long sequence test to max out the NIC HW-GRO depth.
Repeat for a single queue and RSS context with 8 queues.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/gro_hw.py        | 86 ++++++++++++++++++-
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/gro_hw.py b/tools/testing/selftests/drivers/net/hw/gro_hw.py
index 18a3b1bceefd..7450b8884f44 100755
--- a/tools/testing/selftests/drivers/net/hw/gro_hw.py
+++ b/tools/testing/selftests/drivers/net/hw/gro_hw.py
@@ -10,8 +10,8 @@ import glob
 import re
 
 from lib.py import ksft_run, ksft_exit, ksft_pr
-from lib.py import ksft_eq, ksft_ge, ksft_variants
-from lib.py import NetDrvEpEnv, NetdevFamily
+from lib.py import ksft_eq, ksft_ge, ksft_variants, KsftNamedVariant
+from lib.py import NetDrvEpEnv, NetdevFamily, EthtoolFamily
 from lib.py import KsftSkipEx
 from lib.py import bkg, cmd, defer, ethtool, ip
 
@@ -78,6 +78,19 @@ GRO_DPORT = 8000
     return test_queue
 
 
+def _setup_queue_count(cfg, num_queues):
+    """Configure the NIC to use a specific number of queues."""
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    ch_max = channels.get('combined-max', 0)
+    qcnt = channels['combined-count']
+
+    if ch_max < num_queues:
+        raise KsftSkipEx(f"Need at least {num_queues} queues, max={ch_max}")
+
+    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
+    ethtool(f"-L {cfg.ifname} combined {num_queues}")
+
+
 def _run_gro_test(cfg, test_name, num_flows=None, ignore_fail=False,
                   order_check=False):
     """Run gro binary with given test and return output."""
@@ -279,14 +292,81 @@ def _check_gro_stats(cfg, test_queue, stats_before,
     _run_gro_test(cfg, "capacity", num_flows=num_flows, order_check=True)
 
 
+@ksft_variants([
+    KsftNamedVariant("isolated", _setup_isolated_queue),
+    KsftNamedVariant("1q", lambda cfg: _setup_queue_count(cfg, 1)),
+    KsftNamedVariant("8q", lambda cfg: _setup_queue_count(cfg, 8)),
+])
+def test_gro_capacity(cfg, setup_func):
+    """
+    Probe HW GRO capacity.
+
+    Start with 8 flows and increase by 4x on each successful run.
+    Retry up to 3 times on failure.
+
+    Variants:
+      - isolated: Use a single queue isolated from RSS
+      - 1q: Configure NIC to use 1 queue
+      - 8q: Configure NIC to use 8 queues
+    """
+    max_retries = 3
+
+    _setup_hw_gro(cfg)
+    queue_id = setup_func(cfg)
+
+    num_flows = 8
+    while True:
+        success = False
+        for attempt in range(max_retries):
+            if queue_id is not None:
+                stats_before = _get_queue_stats(cfg, queue_id)
+
+            output = _run_gro_test(cfg, "capacity", num_flows=num_flows,
+                                   ignore_fail=True)
+
+            if queue_id is not None:
+                stats_after = _get_queue_stats(cfg, queue_id)
+                qstat_pkts = (stats_after.get('rx-packets', 0) -
+                              stats_before.get('rx-packets', 0))
+                qstat_str = f" qstat={qstat_pkts}"
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
 
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        cfg.ethnl = EthtoolFamily()
         cfg.netnl = NetdevFamily()
         ksft_run([test_gro_stats_single,
                   test_gro_stats_full,
-                  test_gro_order], args=(cfg,))
+                  test_gro_order,
+                  test_gro_capacity], args=(cfg,))
     ksft_exit()
 
 
-- 
2.53.0


