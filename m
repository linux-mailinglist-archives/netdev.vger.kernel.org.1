Return-Path: <netdev+bounces-282066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LoUAowa8Wm3dQEAu9opvQ
	(envelope-from <netdev+bounces-282066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:37:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF77248BD24
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4423D301E71A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948582EA47C;
	Tue, 28 Apr 2026 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvhYx4+V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B5B25FA05;
	Tue, 28 Apr 2026 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408588; cv=none; b=RidnvfifIVGRDg3jLukCeuRKJoDir4AB8XbXSEEkDVCoyqvnRPuicQxneuVSsfjOzdd3BVOikufT53RPjjSb9eisA3avKM/SDet3UMRISFVIaV94wf+V/ylCs8Dnt1Szw2MzzrLgTSvOmW2ZgP6TXo/EAoDGRvdlVZtQnj6IgkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408588; c=relaxed/simple;
	bh=zVUU3GhjmgTmWxmcSAbHcFtgsY/d5O7hOya1pXw2ndM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5vSGluacgHnxwiFEVZTcUsudKQQBVNongh+b+Ojp+XsqRZvcno0dbBBBjDhjOtyUmWpGmDLNhZwFoiQHSDX5334elgfzXFTXBgpZTpYVlNNI2plid59d4YpOrykSe0Nqmrwxo1Oix6duhTlMMFF4AwBtGlFd5rKET4ZAo+04ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvhYx4+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C5DC2BCAF;
	Tue, 28 Apr 2026 20:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777408588;
	bh=zVUU3GhjmgTmWxmcSAbHcFtgsY/d5O7hOya1pXw2ndM=;
	h=From:To:Cc:Subject:Date:From;
	b=EvhYx4+VixPmZH+Iz5kcQGva4p+Or45iJCvx2KngJGeCUz9bId7HhVtcUhhi5VFCb
	 w0cgRi0GIuYEDCrlejDTEciKtD9K5PMerBaXEJ0vKsDvog04vMepAnXwK7UMOlhZZE
	 8d+QJ5YLyiTtu3InZ+5k8moXNmB7hmWZNW3AIEDZhju82UxjsjqU+83zoSq9GM6bMZ
	 4s/RsBWIkMMn68+xWh0iUSRdbCt6lOSiREgPKDAzoghlP7mt9blcSI2aBJFRoKUrNT
	 Sw0XVRUlcR+STyQZf4AeWuUWBCveMQa0WFliyCaE6iAIGyuNo2J5kJXSB5kmO6dxoH
	 v+m3UBK1takkw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	dimitri.daskalakis1@gmail.com,
	pavan.chebbi@broadcom.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: rss: add case for field config on RSS context
Date: Tue, 28 Apr 2026 13:36:24 -0700
Message-ID: <20260428203624.1224387-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CF77248BD24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,broadcom.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282066-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.967];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email]

We had some issues with a suspected traffic imbalance on an RSS
context. Make sure the tests cover the RXFH field selection
vs additional contexts.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: dimitri.daskalakis1@gmail.com
CC: pavan.chebbi@broadcom.com
CC: linux-kselftest@vger.kernel.org
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 91 ++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 51f4e7bc3e5d..1243fe426d35 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -9,7 +9,7 @@ from lib.py import ksft_disruptive
 from lib.py import ksft_run, ksft_pr, ksft_exit
 from lib.py import ksft_eq, ksft_ne, ksft_ge, ksft_in, ksft_lt, ksft_true, ksft_raises
 from lib.py import NetDrvEpEnv
-from lib.py import EthtoolFamily, NetdevFamily
+from lib.py import EthtoolFamily, NetdevFamily, NlError
 from lib.py import KsftSkipEx, KsftFailEx
 from lib.py import rand_port, rand_ports
 from lib.py import cmd, ethtool, ip, defer, CmdExitFailure, wait_file
@@ -828,6 +828,94 @@ from lib.py import GenerateTraffic
                           'noise' : (0, 1) })
 
 
+def _set_flow_hash(cfg, fl_type, fields, context=0):
+    req = {"header": {"dev-index": cfg.ifindex},
+           "flow-hash": {fl_type: fields}}
+    if context:
+        req["context"] = context
+    cfg.ethnl.rss_set(req)
+
+
+def _get_flow_hash(cfg, fl_type, context=0):
+    req = {"header": {"dev-index": cfg.ifindex}}
+    if context:
+        req["context"] = context
+    rss = cfg.ethnl.rss_get(req)
+    return rss.get("flow-hash", {}).get(fl_type, set())
+
+
+def test_rss_context_flow_hash(cfg):
+    """
+    Validate, with traffic, that an additional RSS context honors the
+    flow-hash field selection. If the driver lacks per-context field
+    configuration ("ops->rxfh_per_ctx_fields") fall back to setting the
+    fields on the main context, which the kernel applies device-wide.
+    """
+
+    require_ntuple(cfg)
+
+    queue_cnt = len(_get_rx_cnts(cfg))
+    if queue_cnt < 6:
+        try:
+            ksft_pr(f"Increasing queue count {queue_cnt} -> 6")
+            ethtool(f"-L {cfg.ifname} combined 6")
+            defer(ethtool, f"-L {cfg.ifname} combined {queue_cnt}")
+        except CmdExitFailure as exc:
+            raise KsftSkipEx("Not enough queues for the test") from exc
+
+    fl_type = f"tcp{cfg.addr_ipver}"
+    if not _get_flow_hash(cfg, fl_type):
+        raise KsftSkipEx(f"Device does not report flow-hash for {fl_type}")
+
+    # Reserve queues 0/1 for main, build a new context spanning 2..5
+    ethtool(f"-X {cfg.ifname} equal 2")
+    defer(ethtool, f"-X {cfg.ifname} default")
+    ctx_id = ethtool_create(cfg, "-X", "context new start 2 equal 4")
+    defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete")
+
+    port = rand_port()
+    flow = f"flow-type {fl_type} dst-ip {cfg.addr} dst-port {port} context {ctx_id}"
+    ntuple = ethtool_create(cfg, "-N", flow)
+    defer(ethtool, f"-N {cfg.ifname} delete {ntuple}")
+
+    ip_only = {"ip-src", "ip-dst"}
+    ip_l4   = ip_only | {"l4-b-0-1", "l4-b-2-3"}
+
+    # Try per-context flow-hash; fall back to main context if unsupported.
+    cfg_ctx = ctx_id
+    try:
+        orig = _get_flow_hash(cfg, fl_type, context=ctx_id)
+        _set_flow_hash(cfg, fl_type, ip_only, context=ctx_id)
+    except NlError:
+        ksft_pr("Per-context flow-hash not supported, using device-wide")
+        cfg_ctx = 0
+        orig = _get_flow_hash(cfg, fl_type)
+        _set_flow_hash(cfg, fl_type, ip_only)
+    defer(_set_flow_hash, cfg, fl_type, orig, context=cfg_ctx)
+
+    def measure():
+        cnts = _get_rx_cnts(cfg)
+        GenerateTraffic(cfg, port=port).wait_pkts_and_stop(20000)
+        cnts = _get_rx_cnts(cfg, prev=cnts)
+        ctx_cnts = cnts[2:6]
+        directed = sum(ctx_cnts)
+        used = sum(1 for c in ctx_cnts if c > directed / 200)
+        return cnts, directed, used
+
+    # IP-only hash: iperf3 streams share src/dst IP, all should land on the
+    # same queue inside the context's range.
+    cnts, directed, used = measure()
+    ksft_ge(directed, 20000, f"traffic on context {ctx_id} (IP-only): {cnts}")
+    ksft_eq(used, 1, f"IP-only hash should use one queue in context {ctx_id}, got: {cnts}")
+
+    # IP+L4 hash: streams have distinct src ports, traffic should spread.
+    _set_flow_hash(cfg, fl_type, ip_l4, context=cfg_ctx)
+
+    cnts, directed, used = measure()
+    ksft_ge(directed, 20000, f"traffic on context {ctx_id} (IP+L4): {cnts}")
+    ksft_ge(used, 2, f"IP+L4 hash should spread across context {ctx_id} queues, got: {cnts}")
+
+
 @ksft_disruptive
 def test_rss_context_persist_ifupdown(cfg, pre_down=False):
     """
@@ -935,6 +1023,7 @@ from lib.py import GenerateTraffic
                   test_flow_add_context_missing,
                   test_delete_rss_context_busy, test_rss_ntuple_addition,
                   test_rss_default_context_rule,
+                  test_rss_context_flow_hash,
                   test_rss_context_persist_create_and_ifdown,
                   test_rss_context_persist_ifdown_and_create],
                  args=(cfg, ))
-- 
2.54.0


