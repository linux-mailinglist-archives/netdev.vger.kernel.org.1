Return-Path: <netdev+bounces-281479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCDIAkPE72lsFwEAu9opvQ
	(envelope-from <netdev+bounces-281479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:17:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2F9479DAD
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BACAE300F4D4
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54E7332EDE;
	Mon, 27 Apr 2026 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvFSBt9s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF8031F9BC
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321013; cv=none; b=hx3CCnpdEJYn8zLUUVUzLC/JTD1+E63k4na3U7o1gSKZesmLLtYWnq7L40eykF5AdUPG7/IlqRsAT/kVQFjybKc5JKEDYvcj3YPmTnBPegpNNNjS9bl6I/gjHh4KJsLO/ZAB59bxXUaLyooocvjyyJXaCsDjR9oDRVzN6gI461E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321013; c=relaxed/simple;
	bh=MBXJRtoarCsj2Tzo52CPKXo0ZRK32A2ZGOFgO+7M6EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HR5VodbpaEVPeMAcYyal6JvXRoDzwf8QBIhVO0sV9jxNMfK1D1qI68M73o+E7y5V6gKKUHYp7GbYWQzqKzieMnsyaVq7C1VXxXTdZ6TNFBSfQpkyFc5w873L9k7Kg+xdx702wrUbIPCIeEURamFbqddszwCHCJdrH89/gRcA37w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvFSBt9s; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7986e0553bdso100210747b3.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777321011; x=1777925811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2GdkRCP+R+/XzTmQkAhP2FcOKDnesDTS1y0s3Pf+M8=;
        b=MvFSBt9sYcH0uwknCeoHZ9LajGlV5i8A/sn7xmLi7XDsNugtik9dHAf3VKXxyuPCgu
         19rTvZtb3thB4fQ68J7jd3xyNnA7sX6uRIsJWLUBEnd+rmetihnAA3p5olq0cC5gV6Pc
         kLSzZzZNQNNPIJ1FGml9VFDMFT1GmOQfby88uX8P06+zesWg0bJ63bpOEL0DlSrcbQCq
         keCHDqeoorl/78+fqvJkaMzIZvrVqFzp5pe92eurZCUDCEYynMWGFY236XS2nmF4zhKn
         6zXrg74XHyBgOLvcJru4pFcdbgGUfOcpxct1My1i6F9gXccczEgfEMrM7RHQGPtVtttS
         1Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777321011; x=1777925811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2GdkRCP+R+/XzTmQkAhP2FcOKDnesDTS1y0s3Pf+M8=;
        b=Ujxu3pGsuqc/hXO41lj+9ZeQ336Mbrka93aO/DO6uZGs30hQSZrrZjt2YWYCc3pe/j
         Zr8ZVKtIZ/lFukEJ4onTmpuIFNLA9IRgsiqFhdiLrEsoMN5SOPGchKRDlAQykEyVMFZg
         CU/xvxtfR4aBcwmaoWCAzzvH4SDnL9gEIpyJEiFF1YHx0ixb1OKsL75FrK8zMc9eGovR
         2pR9Bax4cq01GMsjNR9Oa6dMI7Mk1/IJfasQjIJm0uIN9yvYYLQPDbfGF5QKLGX2QwKO
         8DSgS4g9JZ6d+Su81YigJmZqQaJFZxpkHuuRsXIfQIZTia6I5pkjN44CJLc+jINmhr7M
         FTzQ==
X-Gm-Message-State: AOJu0YxBnlPrEuubcuYSgdmVnuByR5IDcm8RgOvUV3JzesTiF1oNjZFt
	glprTO+VWEb7Vuyl2S9ivDqXVA902X1esMRWz2A0elgHlgO8neK+ZWl0QWx/OQq4
X-Gm-Gg: AeBDiescrlfUr3i2lWYequlR4Cu2Mveg6MM0LQBujghYvK2uxUfxUOh/oEHqLNtScpd
	Hwr33CpqUiTaHrgSa2vuHNGvQluK/NBN2PTdHJf1uxxdGP7poK7QiSVLkjDG6N6+tiWoRBcyP6y
	NWV8oWWjuhMOomHOVuvbQRVjZyaEqXUmROTjZX6t0K1X4Kment5RHGhEuS7qwFbL0sKV5SVHlOH
	yKey2JpxN1u0RoUcZB2VzIR9Fr18jrLycygay8DQgXmztrgbKkL8FLAmzVrbnfWTUkd7t1BjRaP
	1wEAvvOlx35T3t8XNzTylRvumuWhrYOcR5xyy4XZ/GFfliIroK68ibnaltlfCP9wootQEUcDV61
	HByTPol4993hgzG4E8rfM7+YeLDlM83In7sx1I+ZgtLM0WaQguhQjerNXhj7o6lIIyldqPZhxsT
	r6GqT1sDtf7R5ZgAJvphMdKYifoW4708FCcpc0JxpXdZ8UWRGfwkRaMUvcUgaOY/ampFA6sxlBH
	ieGn7HfGh3j5tPiJkgtTodCaVfNbnB72sf9hQ==
X-Received: by 2002:a05:690c:368d:b0:7b7:de6:336f with SMTP id 00721157ae682-7bcf579f04cmr251817b3.40.1777321010717;
        Mon, 27 Apr 2026 13:16:50 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bcf05e6149sm1753387b3.11.2026.04.27.13.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 13:16:50 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v5 3/3] selftests: drv-net: convert so_txtime to drv-net
Date: Mon, 27 Apr 2026 16:14:35 -0400
Message-ID: <20260427201640.294694-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260427201640.294694-1-willemdebruijn.kernel@gmail.com>
References: <20260427201640.294694-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD2F9479DAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-281479-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lib.py:url]

From: Willem de Bruijn <willemb@google.com>

In preparation for extending to pacing hardware offload, convert the
so_txtime.sh test to a drv-net test that can be run against netdevsim
and real hardware.

Also update so_txtime.c to not exit on first failure, but run to
completion and report exit code there. This helps with debugging
unexpected results, especially when processing multiple packets,
as happens in the "reverse_order" testcase.

Signed-off-by: Willem de Bruijn <willemb@google.com>

----

v4 -> v5

- move qdisc setup/restore into each test
- add tc to utils.py (separate patch)
- test expected failure (separate patch)
- fix pylint
- convert fail to pass for timing errors if KSFT_MACHINE_SLOW
  (cmd does not special case KSFT_SKIP process returncode yet)

Responses to sashiko review

- The test converts per packet failure to errors, to continue
  testing other packets, but other error() cases are not in scope.
- The test starts sender and receiver at an absolute future time,
  like the original test. This assumes ~msec scale sync'ed clocks.
- The tc qdisc replace command works fine with noqueue. Tested
  manually.

v4: https://lore.kernel.org/netdev/20260409164238.661091-1-willemdebruijn.kernel@gmail.com/

v3 -> v4

- restore original qdisc after test
- drop unnecessary underscore in tap test names

v3: https://lore.kernel.org/netdev/20260406025020.1636895-1-willemdebruijn.kernel@gmail.com/

v2 -> v3

- Makefile: so_txtime from YNL_GEN_FILES to TEST_GEN_FILES (Sashiko, NIPA)

v2: https://lore.kernel.org/netdev/20260405014458.1038165-1-willemdebruijn.kernel@gmail.com/

v1 -> v2
- move so_txtime.c for net/lib to drivers/net (Jakub)
- fix drivers/net/config order (Jakub)
- detect passing when failure is expected (Jakub, Sashiko)
- pass pylint --disable=R (Jakub)
- only call ksft_run once (Jakub)
- do not sleep if waiting time is negative (Sashiko)
- add \n when converting error() to fprintf() (Sashiko)
- 4 space indentation, instead of 2 space
- increase sync delay from 100 to 200ms, to fix rare vng flakes

v1: https://lore.kernel.org/netdev/20260403175047.152646-1-willemdebruijn.kernel@gmail.com/
---
 .../testing/selftests/drivers/net/.gitignore  |   1 +
 tools/testing/selftests/drivers/net/Makefile  |   2 +
 tools/testing/selftests/drivers/net/config    |   2 +
 .../selftests/{ => drivers}/net/so_txtime.c   |  25 +++-
 .../selftests/drivers/net/so_txtime.py        |  95 +++++++++++++++
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/Makefile          |   2 -
 tools/testing/selftests/net/so_txtime.sh      | 110 ------------------
 8 files changed, 120 insertions(+), 118 deletions(-)
 rename tools/testing/selftests/{ => drivers}/net/so_txtime.c (96%)
 create mode 100755 tools/testing/selftests/drivers/net/so_txtime.py
 delete mode 100755 tools/testing/selftests/net/so_txtime.sh

diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
index 585ecb4d5dc4..e5314ce4bb2d 100644
--- a/tools/testing/selftests/drivers/net/.gitignore
+++ b/tools/testing/selftests/drivers/net/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 napi_id_helper
 psp_responder
+so_txtime
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index b72080c6d06b..d5bf4cb638a8 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -7,6 +7,7 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
 
 TEST_GEN_FILES := \
 	napi_id_helper \
+	so_txtime \
 # end of TEST_GEN_FILES
 
 TEST_PROGS := \
@@ -21,6 +22,7 @@ TEST_PROGS := \
 	queues.py \
 	ring_reconfig.py \
 	shaper.py \
+	so_txtime.py \
 	stats.py \
 	xdp.py \
 # end of TEST_PROGS
diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index fd16994366f4..92907be9c31e 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -9,4 +9,6 @@ CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
 CONFIG_NETDEVSIM=m
 CONFIG_VLAN_8021Q=m
+CONFIG_NET_SCH_ETF=m
+CONFIG_NET_SCH_FQ=m
 CONFIG_XDP_SOCKETS=y
diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
similarity index 96%
rename from tools/testing/selftests/net/so_txtime.c
rename to tools/testing/selftests/drivers/net/so_txtime.c
index b76df1efc2ef..b6930883569b 100644
--- a/tools/testing/selftests/net/so_txtime.c
+++ b/tools/testing/selftests/drivers/net/so_txtime.c
@@ -33,6 +33,8 @@
 #include <unistd.h>
 #include <poll.h>
 
+#include "kselftest.h"
+
 static int	cfg_clockid	= CLOCK_TAI;
 static uint16_t	cfg_port	= 8000;
 static int	cfg_variance_us	= 4000;
@@ -43,6 +45,8 @@ static bool	cfg_rx;
 static uint64_t glob_tstart;
 static uint64_t tdeliver_max;
 
+static int errors;
+
 /* encode one timed transmission (of a 1B payload) */
 struct timed_send {
 	char	data;
@@ -131,13 +135,15 @@ static void do_recv_one(int fdr, struct timed_send *ts)
 	fprintf(stderr, "payload:%c delay:%lld expected:%lld (us)\n",
 			rbuf[0], (long long)tstop, (long long)texpect);
 
-	if (rbuf[0] != ts->data)
-		error(1, 0, "payload mismatch. expected %c", ts->data);
+	if (rbuf[0] != ts->data) {
+		fprintf(stderr, "payload mismatch. expected %c\n", ts->data);
+		errors++;
+	}
 
 	if (llabs(tstop - texpect) > cfg_variance_us) {
 		fprintf(stderr, "exceeds variance (%d us)\n", cfg_variance_us);
 		if (!getenv("KSFT_MACHINE_SLOW"))
-			exit(1);
+			errors++;
 	}
 }
 
@@ -255,8 +261,12 @@ static void start_time_wait(void)
 		return;
 
 	now = gettime_ns(CLOCK_REALTIME);
-	if (cfg_start_time_ns < now)
+	if (cfg_start_time_ns < now) {
+		fprintf(stderr, "FAIL: start time already passed\n");
+		if (!getenv("KSFT_MACHINE_SLOW"))
+			errors++;
 		return;
+	}
 
 	err = usleep((cfg_start_time_ns - now) / 1000);
 	if (err)
@@ -513,5 +523,10 @@ int main(int argc, char **argv)
 	else
 		do_test_tx((void *)&cfg_src_addr, cfg_alen);
 
-	return 0;
+	if (errors) {
+		fprintf(stderr, "FAIL: %d errors\n", errors);
+		return KSFT_FAIL;
+	}
+
+	return KSFT_PASS;
 }
diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
new file mode 100755
index 000000000000..c2bbeea45a61
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -0,0 +1,95 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Regression tests for the SO_TXTIME interface.
+
+Test delivery time in FQ and ETF qdiscs.
+"""
+
+import time
+
+from lib.py import ksft_exit, ksft_run, ksft_variants
+from lib.py import KsftNamedVariant, KsftSkipEx
+from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
+
+
+def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, test_failure):
+    """Main function. Run so_txtime as sender and receiver."""
+    bin_path = cfg.test_dir / "so_txtime"
+
+    tstart = time.time_ns() + 200_000_000
+
+    cmd_addr = f"-S {cfg.addr_v[ipver]} -D {cfg.remote_addr_v[ipver]}"
+    cmd_base = f"{bin_path} -{ipver} -c {clockid} -t {tstart} {cmd_addr}"
+    cmd_rx = f"{cmd_base} {args_rx} -r"
+    cmd_tx = f"{cmd_base} {args_tx}"
+
+    with bkg(cmd_rx, host=cfg.remote, fail=test_failure, exit_wait=True):
+        cmd(cmd_tx)
+
+
+def _qdisc_setup(ifname, qdisc, optargs=""):
+    """Replace root qdisc. Restore the original after the test.
+
+    If the original is mq, children will be of type default_qdisc.
+    """
+    orig = tc(f"qdisc show dev {ifname} root", json=True)[0].get("kind", None)
+    defer(tc, f"qdisc replace dev {ifname} root {orig}")
+    tc(f"qdisc replace dev {ifname} root {qdisc} {optargs}")
+
+
+def _test_variants_mono():
+    for ipver in ["4", "6"]:
+        for testcase in [
+            ["no_delay", "a,-1", "a,-1"],
+            ["zero_delay", "a,0", "a,0"],
+            ["one_pkt", "a,10", "a,10"],
+            ["in_order", "a,10,b,20", "a,10,b,20"],
+            ["reverse_order", "a,20,b,10", "b,20,a,20"],
+        ]:
+            name = f"v{ipver}_{testcase[0]}"
+            yield KsftNamedVariant(name, ipver, testcase[1], testcase[2])
+
+
+@ksft_variants(_test_variants_mono())
+def test_so_txtime_mono(cfg, ipver, args_tx, args_rx):
+    """Run all variants of monotonic (fq) tests."""
+    _qdisc_setup(cfg.ifname, "fq")
+    test_so_txtime(cfg, "mono", ipver, args_tx, args_rx, True)
+
+
+def _test_variants_etf():
+    for ipver in ["4", "6"]:
+        for testcase in [
+            ["no_delay", "a,-1", "a,-1", 'verify_failed'],
+            ["zero_delay", "a,0", "a,0", 'verify_failed'],
+            ["one_pkt", "a,10", "a,10", True],
+            ["in_order", "a,10,b,20", "a,10,b,20", True],
+            ["reverse_order", "a,20,b,10", "b,10,a,20", True],
+        ]:
+            name = f"v{ipver}_{testcase[0]}"
+            yield KsftNamedVariant(
+                name, ipver, testcase[1], testcase[2], testcase[3]
+            )
+
+
+@ksft_variants(_test_variants_etf())
+def test_so_txtime_etf(cfg, ipver, args_tx, args_rx, expect_fail):
+    """Run all variants of etf tests."""
+    try:
+        _qdisc_setup(cfg.ifname, "etf", "clockid CLOCK_TAI delta 400000")
+    except Exception as e:
+        raise KsftSkipEx("tc does not support qdisc etf. skipping") from e
+
+    test_so_txtime(cfg, "tai", ipver, args_tx, args_rx, expect_fail)
+
+
+def main() -> None:
+    """Boilerplate ksft main."""
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run([test_so_txtime_mono, test_so_txtime_etf], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 97ad4d551d44..02ad4c99a2b4 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -40,7 +40,6 @@ skf_net_off
 socket
 so_incoming_cpu
 so_netns_cookie
-so_txtime
 so_rcv_listener
 stress_reuseport_listen
 tap
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index a275ed584026..d53670c0d7a2 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -83,7 +83,6 @@ TEST_PROGS := \
 	rxtimestamp.sh \
 	sctp_vrf.sh \
 	skf_net_off.sh \
-	so_txtime.sh \
 	srv6_end_dt46_l3vpn_test.sh \
 	srv6_end_dt4_l3vpn_test.sh \
 	srv6_end_dt6_l3vpn_test.sh \
@@ -157,7 +156,6 @@ TEST_GEN_FILES := \
 	skf_net_off \
 	so_netns_cookie \
 	so_rcv_listener \
-	so_txtime \
 	socket \
 	stress_reuseport_listen \
 	tcp_fastopen_backup_key \
diff --git a/tools/testing/selftests/net/so_txtime.sh b/tools/testing/selftests/net/so_txtime.sh
deleted file mode 100755
index 5e861ad32a42..000000000000
--- a/tools/testing/selftests/net/so_txtime.sh
+++ /dev/null
@@ -1,110 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# Regression tests for the SO_TXTIME interface
-
-set -e
-
-readonly ksft_skip=4
-readonly DEV="veth0"
-readonly BIN="./so_txtime"
-
-readonly RAND="$(mktemp -u XXXXXX)"
-readonly NSPREFIX="ns-${RAND}"
-readonly NS1="${NSPREFIX}1"
-readonly NS2="${NSPREFIX}2"
-
-readonly SADDR4='192.168.1.1'
-readonly DADDR4='192.168.1.2'
-readonly SADDR6='fd::1'
-readonly DADDR6='fd::2'
-
-cleanup() {
-	ip netns del "${NS2}"
-	ip netns del "${NS1}"
-}
-
-trap cleanup EXIT
-
-# Create virtual ethernet pair between network namespaces
-ip netns add "${NS1}"
-ip netns add "${NS2}"
-
-ip link add "${DEV}" netns "${NS1}" type veth \
-  peer name "${DEV}" netns "${NS2}"
-
-# Bring the devices up
-ip -netns "${NS1}" link set "${DEV}" up
-ip -netns "${NS2}" link set "${DEV}" up
-
-# Set fixed MAC addresses on the devices
-ip -netns "${NS1}" link set dev "${DEV}" address 02:02:02:02:02:02
-ip -netns "${NS2}" link set dev "${DEV}" address 06:06:06:06:06:06
-
-# Add fixed IP addresses to the devices
-ip -netns "${NS1}" addr add 192.168.1.1/24 dev "${DEV}"
-ip -netns "${NS2}" addr add 192.168.1.2/24 dev "${DEV}"
-ip -netns "${NS1}" addr add       fd::1/64 dev "${DEV}" nodad
-ip -netns "${NS2}" addr add       fd::2/64 dev "${DEV}" nodad
-
-run_test() {
-	local readonly IP="$1"
-	local readonly CLOCK="$2"
-	local readonly TXARGS="$3"
-	local readonly RXARGS="$4"
-
-	if [[ "${IP}" == "4" ]]; then
-		local readonly SADDR="${SADDR4}"
-		local readonly DADDR="${DADDR4}"
-	elif [[ "${IP}" == "6" ]]; then
-		local readonly SADDR="${SADDR6}"
-		local readonly DADDR="${DADDR6}"
-	else
-		echo "Invalid IP version ${IP}"
-		exit 1
-	fi
-
-	local readonly START="$(date +%s%N --date="+ 0.1 seconds")"
-
-	ip netns exec "${NS2}" "${BIN}" -"${IP}" -c "${CLOCK}" -t "${START}" -S "${SADDR}" -D "${DADDR}" "${RXARGS}" -r &
-	ip netns exec "${NS1}" "${BIN}" -"${IP}" -c "${CLOCK}" -t "${START}" -S "${SADDR}" -D "${DADDR}" "${TXARGS}"
-	wait "$!"
-}
-
-do_test() {
-	run_test $@
-	[ $? -ne 0 ] && ret=1
-}
-
-do_fail_test() {
-	run_test $@
-	[ $? -eq 0 ] && ret=1
-}
-
-ip netns exec "${NS1}" tc qdisc add dev "${DEV}" root fq
-set +e
-ret=0
-do_test 4 mono a,-1 a,-1
-do_test 6 mono a,0 a,0
-do_test 6 mono a,10 a,10
-do_test 4 mono a,10,b,20 a,10,b,20
-do_test 6 mono a,20,b,10 b,20,a,20
-
-if ip netns exec "${NS1}" tc qdisc replace dev "${DEV}" root etf clockid CLOCK_TAI delta 400000; then
-	do_fail_test 4 tai a,-1 a,-1
-	do_fail_test 6 tai a,0 a,0
-	do_test 6 tai a,10 a,10
-	do_test 4 tai a,10,b,20 a,10,b,20
-	do_test 6 tai a,20,b,10 b,10,a,20
-else
-	echo "tc ($(tc -V)) does not support qdisc etf. skipping"
-	[ $ret -eq 0 ] && ret=$ksft_skip
-fi
-
-if [ $ret -eq 0 ]; then
-	echo OK. All tests passed
-elif [[ $ret -ne $ksft_skip && -n "$KSFT_MACHINE_SLOW" ]]; then
-	echo "Ignoring errors due to slow environment" 1>&2
-	ret=0
-fi
-exit $ret
-- 
2.54.0.545.g6539524ca2-goog


