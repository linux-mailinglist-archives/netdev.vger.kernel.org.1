Return-Path: <netdev+bounces-255243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI1aHpEGfWmpPwIAu9opvQ
	(envelope-from <netdev+bounces-255243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:29:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24326BE24F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 820E9300CE6D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D873876D2;
	Fri, 30 Jan 2026 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcN6dUJO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5863803D1;
	Fri, 30 Jan 2026 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801358; cv=none; b=by4j2VBOKfK+1dAmkTL5d5uBhOgUliWZ1+TvlGtC6gVFZuYG/LsNQ/RpVHAoRRq3CnbXNperm7m8OkIqX9fY3BO/H58jKFIqAtH4tbrkPZJiNUkNM1MLpGoufF6i0Elzl1SBLOy0tN2pKIscP/jUyt2bOVhnt2EmqCWn9KrbUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801358; c=relaxed/simple;
	bh=zq6M2ieGwRe+GhEG3KF4BXzKoi5EDrjXrv88b4TY3lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkHXyxvgHO3j6KB+v4n/OstoLkDSrJjpKqLRaT8Sb6jJahXCR/Ked2ByyG9Bfz2oq3AIXlGJzOqNOmHbpwHHCGkWdsCJjWtZXUrMsRwkbJScCZLI+V9fjQZeMYO0n4S6IMl/ss7uPiYxsHzpleUfnNUv+njO9iCAM+UnQCK2FNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcN6dUJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DEEC4CEF7;
	Fri, 30 Jan 2026 19:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769801358;
	bh=zq6M2ieGwRe+GhEG3KF4BXzKoi5EDrjXrv88b4TY3lk=;
	h=From:To:Cc:Subject:Date:From;
	b=HcN6dUJOJuTHXw/R1apQEHOpKcXjCNi+GNgzFnSImRYxYPi3d2W46FRB+/wZEQnGC
	 1t3LiM0Yzx+Mm6wv4gOsKXruVYbqmE+oogY3bocsL5RXvkvRCSfPvNpYUAeVVZ4qV0
	 XJoRm4FeJYkJwCOjIgvV/mY1PsAHIZhfCVaA781SfMZ6vPI2HrHjkMUAio/fJxuOrm
	 SvukIGv8Sb7SMQ4xVdq1ChJ335DHzHCeQhyurTRiWwX4Oq3D10aDSwUbFDNApWIadS
	 MPpOcgNKnzQljAAnEzQTk093DjjemCu1wFdRhmKNCIgJlDd1B50E5vuol/ARtApF/b
	 Duajkzx1wmKsg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: rss: validate min RSS table size
Date: Fri, 30 Jan 2026 11:29:12 -0800
Message-ID: <20260130192912.826454-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255243-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,rss_drv.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24326BE24F
X-Rspamd-Action: no action

Add a test which checks that the RSS table is at least 4x the max
queue count supported by the device. The original RSS spec from
Microsoft stated that the RSS indirection table should be 2 to 8
times the CPU count, presumably assuming queue per CPU. If the
CPU count is not a power of two, however, a power-of-2 table
2x larger than queue count results in a 33% traffic imbalance.
Validate that the indirection table is at least 4x the queue
count. This lowers the imbalance to 16% which empirically
appears to be more acceptable to memcache-like workloads.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: linux-kselftest@vger.kernel.org
---
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../selftests/drivers/net/hw/rss_drv.py       | 88 +++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_drv.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 9c163ba6feee..a64140333a46 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -35,6 +35,7 @@ TEST_PROGS = \
 	pp_alloc_fail.py \
 	rss_api.py \
 	rss_ctx.py \
+	rss_drv.py \
 	rss_flow_label.py \
 	rss_input_xfrm.py \
 	toeplitz.py \
diff --git a/tools/testing/selftests/drivers/net/hw/rss_drv.py b/tools/testing/selftests/drivers/net/hw/rss_drv.py
new file mode 100755
index 000000000000..2d1a33189076
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/rss_drv.py
@@ -0,0 +1,88 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Driver-related behavior tests for RSS.
+"""
+
+from lib.py import ksft_run, ksft_exit, ksft_ge
+from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx
+from lib.py import defer, ethtool
+from lib.py import EthtoolFamily, NlError
+from lib.py import NetDrvEnv
+
+
+def _is_power_of_two(n):
+    return n > 0 and (n & (n - 1)) == 0
+
+
+def _get_rss(cfg, context=0):
+    return ethtool(f"-x {cfg.ifname} context {context}", json=True)[0]
+
+
+def _test_rss_indir_size(cfg, qcnt, context=0):
+    """Test that indirection table size is at least 4x queue count."""
+    ethtool(f"-L {cfg.ifname} combined {qcnt}")
+
+    rss = _get_rss(cfg, context=context)
+    indir = rss['rss-indirection-table']
+    ksft_ge(len(indir), 4 * qcnt, "Table smaller than 4x")
+    return len(indir)
+
+
+def _maybe_create_context(cfg, create_context):
+    """ Either create a context and return its ID or return 0 for main ctx """
+    if not create_context:
+        return 0
+    try:
+        ctx = cfg.ethnl.rss_create_act({'header': {'dev-index': cfg.ifindex}})
+        ctx_id = ctx['context']
+        defer(cfg.ethnl.rss_delete_act,
+              {'header': {'dev-index': cfg.ifindex}, 'context': ctx_id})
+    except NlError:
+        raise KsftSkipEx("Device does not support additional RSS contexts")
+
+    return ctx_id
+
+
+@ksft_variants([
+    KsftNamedVariant("main", False),
+    KsftNamedVariant("ctx", True),
+])
+def indir_size_4x(cfg, create_context):
+    """
+    Test that the indirection table has at least 4 entries per queue.
+    Empirically network-heavy workloads like memcache suffer with the 33%
+    imbalance of a 2x indirection table size.
+    4x table translates to a 16% imbalance.
+    """
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    ch_max = channels.get('combined-max', 0)
+    qcnt = channels['combined-count']
+
+    if ch_max < 3:
+        raise KsftSkipEx(f"Not enough queues for the test: max={ch_max}")
+
+    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
+    ethtool(f"-L {cfg.ifname} combined 3")
+
+    ctx_id = _maybe_create_context(cfg, create_context)
+
+    indir_sz = _test_rss_indir_size(cfg, 3, context=ctx_id)
+
+    # Test with max queue count (max - 1 if max is a power of two)
+    test_max = ch_max - 1 if _is_power_of_two(ch_max) else ch_max
+    if test_max > 3 and indir_sz < test_max * 4:
+        _test_rss_indir_size(cfg, test_max, context=ctx_id)
+
+
+def main() -> None:
+    """ Ksft boiler plate main """
+    with NetDrvEnv(__file__) as cfg:
+        cfg.ethnl = EthtoolFamily()
+        ksft_run([indir_size_4x], args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.52.0


