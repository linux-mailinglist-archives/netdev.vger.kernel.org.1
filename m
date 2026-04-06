Return-Path: <netdev+bounces-275508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BGX9Engf02kzewcAu9opvQ
	(envelope-from <netdev+bounces-275508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 04:50:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C9E3A12E7
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 04:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D977630022CE
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 02:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E16F1B4223;
	Mon,  6 Apr 2026 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEAChHBC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93661182D0
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775443829; cv=none; b=htSzKbe+UD1qJZjK3UV2Ha4FHzNHswaTJratw7mSsXoh6SuN2VWjdwfQU4/jBffKyzQ0Yqh/RR9WUGEtpSeWeP4waCK9HSBDju/2aayX/FadA3DIr4yW61pXdd6JJ+epzzgxlOi441sYnpfr6m4JJIeAS/grmX3NpoeuZhqMsY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775443829; c=relaxed/simple;
	bh=Iddagr+aZqLi5P+LLmxld2ftKzn/wONhCagVA9tk/xY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gh6YL/kMBAXanpzV+WYWi6Yubu43DogA771r0C58oKMkA6HNmjnpr5J9XgIe4HkMOd/UZGcOu8glyjXSQS/KF8P16zoAFnzkyNUjhoM6WXJ6mFaq6opC0r7cuGIbmKb2KwJ2BcZkmdprPb5Dii3krHr6WgdQvn0akVz1jDy5Jcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEAChHBC; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6501c0399c4so3082096d50.2
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 19:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775443826; x=1776048626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PP/bSWMPWPEVpq65mmyU9w6OFEj6NnsPykqXCPH4KuU=;
        b=GEAChHBC/jyWvwJFOq/te9NKgJt3SNPpmI0sh3TodwnkmkpaSUPw3txjcbQrtNOYVL
         S4YkfswYTsoapsBz/thvknkYpvwNj1LAY0e+JeeCr/5SCyLXDvgg+DbcCUA74yim5wAb
         /44ThV4Ej24QDuOxecGKwgWmImqnzTddPPwUTp6yWGcRTIFJ8wIU2qb78WRWVAGzKFZf
         TwVj6JO9YqbjIzEQ3Y3SVTvnTvup340T9gPACNVJZaA9mVN5fsVdwL18wId4rRecDGDE
         aZ0+ev/o6vjvb7bcspjIXLj87Tew6U5+umM2/5whxGNI3kNgbTn16/wRKW7EQzzB3/ty
         eaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775443826; x=1776048626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PP/bSWMPWPEVpq65mmyU9w6OFEj6NnsPykqXCPH4KuU=;
        b=C3X30zTPcUO8BV/R+d9sSah2Dy7F9YgvgYJXCwBmDN0oYjPhVS19jgAZ/CB8Bbr9+0
         k/HCcYjq+Mun0Sm/gh5Rup24bbDQkbtnfnzCYjZM43SrPRljLwJZ9TbX4fzKKeG9M3SN
         7rQZgqA1bDZqI3hUn6PJf1oZlJ7y5wRJHVdn4Dsx4RPJVvhAcCtWMmiZS7p33Mnhg6Wt
         C7Rh0EvJriLFEGM8hWRBIrCrspX9m6dp0vfnoOSyx77tkzSqgSTLZXWzgBUuH5OUlu3Y
         l4VpyNRkBq+Mm46P7XF2GXbglrmZgsBDUetA290xHDwNRnvxwoHUpJQoh7xC83iat0OF
         mFqg==
X-Gm-Message-State: AOJu0Yy8LgFLoZVw+tjG0l8yJPtfGPeF2I456lyPntjRP2GzbPsiMq3R
	1wSVvdB4RfeaGNV2b0AVYrC1URjVa9sETS30vEbOs2emZINufdbtE1zeGzx5Fw==
X-Gm-Gg: AeBDievcmVq+Tvk5vIYGCiqPAyky1bal8XkXD53HcK3M58CJkFpL2DWwk0Q7CCsxnM7
	AxrziULtqhHLao5T6pAl1thNirz256cRk4LYcoXl0f1bUCj8HLL8cjKDWVvKClnkQtsgEqWjg6G
	EUyY8wv3hmlAjEvpRbC91b9VWdWIRQG6vmgLOO2HXxzaZxPq8VJztVpWYcR9GvrrXDKVGF7xQOC
	n8fgWC/PNmuzlZE9KU9gvr296Hs0FIk1vipW52fgK7yHVnxnku1R06MsFzpae0bwGT871szHsSG
	jCyBy9Gjf8BM2GIT7/JLq2n8RguUvbw+Nx2J1GLdH4yBUaOXhZfeeVvDFnwGg5G5dFhnDMYPeGd
	Wys0RaorQOVt+J7NLoSiB1LXNofbPTx7NAyWxhsIfpyhy4yaRsfU4Fv0bQJmhJj/kCFQFgON152
	nhkk8B4ExY0lVpSHmbedzIEhDbmAR2xIMrbAA22m22sFSZxfhlBq2LDpB3eMggPv7V9zJB1DTOV
	fdkJSdEfkmXJ479NHteYSFrrZo=
X-Received: by 2002:a53:ac88:0:b0:650:49e:a9e4 with SMTP id 956f58d0204a3-65048755c22mr10409392d50.28.1775443826493;
        Sun, 05 Apr 2026 19:50:26 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a84352asm5384421d50.6.2026.04.05.19.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 19:50:25 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3] selftests/net: convert so_txtime to drv-net
Date: Sun,  5 Apr 2026 22:49:22 -0400
Message-ID: <20260406025020.1636895-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275508-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,so_txtime.sh:url,lib.py:url]
X-Rspamd-Queue-Id: D4C9E3A12E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Willem de Bruijn <willemb@google.com>

In preparation for extending to pacing hardware offload, convert the
so_txtime.sh test to a drv-net test that can be run against netdevsim
and real hardware.

Also update so_txtime.c to not exit on first failure, but run to
completion and report exit code there. This helps with debugging
unexpected results, especially when processing multiple packets,
as in the "reverse_order" testcase.

Signed-off-by: Willem de Bruijn <willemb@google.com>

----

v2 -> v3

- Makefile: move so_txtime from YNL_GEN_FILES to TEST_GEN_FILES

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
 .../selftests/{ => drivers}/net/so_txtime.c   |  24 +++-
 .../selftests/drivers/net/so_txtime.py        |  88 ++++++++++++++
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/Makefile          |   2 -
 tools/testing/selftests/net/so_txtime.sh      | 110 ------------------
 8 files changed, 112 insertions(+), 118 deletions(-)
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
index 7c7fa75b80c2..49a61b506f53 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -7,6 +7,7 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
 
 TEST_GEN_FILES := \
 	napi_id_helper \
+	so_txtime \
 # end of TEST_GEN_FILES
 
 TEST_PROGS := \
@@ -20,6 +21,7 @@ TEST_PROGS := \
 	queues.py \
 	ring_reconfig.py \
 	shaper.py \
+	so_txtime.py \
 	stats.py \
 	xdp.py \
 # end of TEST_PROGS
diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index 77ccf83d87e0..2d39f263e03b 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -7,4 +7,6 @@ CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
 CONFIG_NETDEVSIM=m
+CONFIG_NET_SCH_ETF=m
+CONFIG_NET_SCH_FQ=m
 CONFIG_XDP_SOCKETS=y
diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
similarity index 96%
rename from tools/testing/selftests/net/so_txtime.c
rename to tools/testing/selftests/drivers/net/so_txtime.c
index b76df1efc2ef..7d144001ecf2 100644
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
 
@@ -255,8 +261,11 @@ static void start_time_wait(void)
 		return;
 
 	now = gettime_ns(CLOCK_REALTIME);
-	if (cfg_start_time_ns < now)
+	if (cfg_start_time_ns < now) {
+		fprintf(stderr, "FAIL: start time already passed\n");
+		errors++;
 		return;
+	}
 
 	err = usleep((cfg_start_time_ns - now) / 1000);
 	if (err)
@@ -513,5 +522,10 @@ int main(int argc, char **argv)
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
index 000000000000..31b95a7b5b8b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -0,0 +1,88 @@
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
+from lib.py import NetDrvEpEnv, bkg, cmd
+
+
+def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_fail):
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
+    with bkg(cmd_rx, host=cfg.remote, fail=(not expect_fail), exit_wait=True):
+        cmd(cmd_tx)
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
+            name = f"_v{ipver}_{testcase[0]}"
+            yield KsftNamedVariant(name, ipver, testcase[1], testcase[2])
+
+
+@ksft_variants(_test_variants_mono())
+def test_so_txtime_mono(cfg, ipver, args_tx, args_rx):
+    """Run all variants of monotonic (fq) tests."""
+    cmd(f"tc qdisc replace dev {cfg.ifname} root fq")
+    test_so_txtime(cfg, "mono", ipver, args_tx, args_rx, False)
+
+
+def _test_variants_etf():
+    for ipver in ["4", "6"]:
+        for testcase in [
+            ["no_delay", "a,-1", "a,-1", True],
+            ["zero_delay", "a,0", "a,0", True],
+            ["one_pkt", "a,10", "a,10", False],
+            ["in_order", "a,10,b,20", "a,10,b,20", False],
+            ["reverse_order", "a,20,b,10", "b,10,a,20", False],
+        ]:
+            name = f"_v{ipver}_{testcase[0]}"
+            yield KsftNamedVariant(
+                name, ipver, testcase[1], testcase[2], testcase[3]
+            )
+
+
+@ksft_variants(_test_variants_etf())
+def test_so_txtime_etf(cfg, ipver, args_tx, args_rx, expect_fail):
+    """Run all variants of etf tests."""
+    try:
+        # ETF does not support change, so remove and re-add it instead.
+        cmd_prefix = f"tc qdisc replace dev {cfg.ifname} root"
+        cmd(f"{cmd_prefix} pfifo_fast")
+        cmd(f"{cmd_prefix} etf clockid CLOCK_TAI delta 400000")
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
index 6bced3ed798b..b7f51e8f190f 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -81,7 +81,6 @@ TEST_PROGS := \
 	rxtimestamp.sh \
 	sctp_vrf.sh \
 	skf_net_off.sh \
-	so_txtime.sh \
 	srv6_end_dt46_l3vpn_test.sh \
 	srv6_end_dt4_l3vpn_test.sh \
 	srv6_end_dt6_l3vpn_test.sh \
@@ -154,7 +153,6 @@ TEST_GEN_FILES := \
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
2.53.0.1213.gd9a14994de-goog


