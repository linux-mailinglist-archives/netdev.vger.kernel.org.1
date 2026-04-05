Return-Path: <netdev+bounces-275422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Hj25E6i+0WkHNAcAu9opvQ
	(envelope-from <netdev+bounces-275422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 03:45:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C2F39D0AC
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 03:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D44B03004DCF
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 01:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C666311C11;
	Sun,  5 Apr 2026 01:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omFeEn+/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C699282F18
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 01:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775353508; cv=none; b=BQga4khOi31sIcjMEMHzs6c/gTgq09CFdjfPl8JbWBc686A7G1qzxALYGRa92PCUTaJMdq2F7vWNEe4xLftkn+CFnfY5GeH3NOXaOiF1NE0T4o5V3uwjxjx+IkA2210iglXsOwhNMY8LZP0e/3R+pRj5S78WIiw7J+Xag/GaPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775353508; c=relaxed/simple;
	bh=OQSFmT9ofCYNiHH02bo8zz7A6l4ReSl4DnzEs7+mehs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cd74B6C2ibNfq7VYwEUOl2qBAJJVrETP79alTJHcTPNigTam8oZ6zvRbmuJOi/7jlvnr7TksIQD59OgjUNjAlvhJbZAwrkXjeVREYkBzRe8tbokeAZtmqugBCbf3z7PeQMv+W2yzYyE0pPqdUzZHu5jjcr5lqjKHIUU4MPiKTU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omFeEn+/; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79ea87af213so57901287b3.0
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 18:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775353505; x=1775958305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkLE+abpxmYTMWgX5YNLGGNLLd7RINT4kEa95W5sGx8=;
        b=omFeEn+/std8tkTzPknHeZcWi4DbHM508Sm+EjCxPf+ROK21xFR2JhfujolDszWEFI
         myapD0lu6WoVz7q3HaQ64Dn3BHzTG1zPljwJR+fiWfTflPnrpHuVW/iGeBBTM/HD7Ox9
         eLGLdkfQ2icb/qjQ7uuSwSfN4ezdGU9MUV2CvYe28t3MkKfCpIfD/SFdO9rxo8EQ9FzF
         mn6AIwyp4X8MBJOAX5tRmGMCqK7icd0jP3ppUXTxNam/9wrKIRjbwCfyp/mGs+0n7xMg
         OTveeOymgnclLrxTImGxRLKjf7QUHV5ael77cXvr2lzD9huR948R+A48JNKsgdB1m9PF
         7dtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775353505; x=1775958305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkLE+abpxmYTMWgX5YNLGGNLLd7RINT4kEa95W5sGx8=;
        b=R4qTZodquj/h38EDq14rhs2Dk0E7pA6Fy2XWB+hgSLgVcPTabrLINMrgrY/33L1BJJ
         mZcN3EmjFfJ4O9mvpO29KxirR36loN6+iFnGVIogfK+taZRoqg63hgKQ6eUAAfJtytFG
         UNviIBCsRw5TzTjJ0t1aCOXlFv4aMJOeTeHm/P/8NwYUCfV0ENSewQSAGIsKXZY65OVD
         l0sXTGaYuTsFL1J+H2DfirbjDFRnDTlr2j2slvgxjUgnv/Z9zxqsy//C28LXoiHkW64k
         cIG/11e9WyfCQr5wwtY8foOw6NV+JZhZOQYfbfi22HRCCTICG6h2BeCs678KLdfd9Bea
         IPgg==
X-Gm-Message-State: AOJu0YxanBLlKAcERC5pmUIiXcPEibWhU6eiG0jtI8sK99mwEQOCKXR5
	E6O6PruV/8VRxb5d0KmE6/bKNC22wWTvCuzJfxWDwkvZOMk8MBfF/i7sgc17Pg==
X-Gm-Gg: AeBDies4jV0ZtX9zs209TZbxGdJqicumxSafoF6t+/LJcIi/14SjoMF89TvzzVT+Y8A
	V/Q4NnP7EY+Sa2ye1wibRjYJHR8+OJMbBiOclK9qifFtWMeRt+Yp1YLZk9TWRQsc1EHDBdzeAbh
	IMTFePT+5kj0RtSGRwnXQipYTC/wb28z2qyNzJtYFki7NXLR7lfDpPohf47v8M1CkKCU2ACdIsT
	EiadLqdXaEp936tOJfa/8zdPfL2awJoFO1kl3fxHQJamZvSRR8PfsBZFcinxjgZi/FyjEsN7IkP
	29WHE/PFcih+5kFdNX2iMyIQkNVuhsJb2QMWnm66+OXj7sPz0QH4QeGXwoLUOcQ73dJE9NFD1jT
	wUipI3EpSd10deLbNxsaWa6MmOOgpUG94qJ/iESegXxVc6AA0ZCfUL8MEBthafiQ70+H0L8lfJ/
	KuTxP+cetiM1sDn3QXdCF5I64kbmnDLSrttymy0x0OTq7EQHkBLNNE5iW16jx9Xs1kQn8zAE/V4
	GmjGaUQWk2xH5GQZBQxwODi6Qk=
X-Received: by 2002:a05:690c:dd3:b0:79c:142b:29a8 with SMTP id 00721157ae682-7a3bcaeb9f6mr94641067b3.15.1775353505073;
        Sat, 04 Apr 2026 18:45:05 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370df19f3sm38226497b3.39.2026.04.04.18.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 18:45:04 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2] selftests/net: convert so_txtime to drv-net
Date: Sat,  4 Apr 2026 21:44:22 -0400
Message-ID: <20260405014458.1038165-1-willemdebruijn.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275422-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lib.py:url,so_txtime.sh:url]
X-Rspamd-Queue-Id: D8C2F39D0AC
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
 tools/testing/selftests/drivers/net/Makefile  |   5 +-
 tools/testing/selftests/drivers/net/config    |   2 +
 .../selftests/{ => drivers}/net/so_txtime.c   |  24 +++-
 .../selftests/drivers/net/so_txtime.py        |  88 ++++++++++++++
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/Makefile          |   2 -
 tools/testing/selftests/net/so_txtime.sh      | 110 ------------------
 8 files changed, 114 insertions(+), 119 deletions(-)
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
index 7c7fa75b80c2..85d6a7e26627 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -20,12 +20,15 @@ TEST_PROGS := \
 	queues.py \
 	ring_reconfig.py \
 	shaper.py \
+	so_txtime.py \
 	stats.py \
 	xdp.py \
 # end of TEST_PROGS
 
 # YNL files, must be before "include ..lib.mk"
-YNL_GEN_FILES := psp_responder
+YNL_GEN_FILES := \
+	psp_responder \
+	so_txtime
 TEST_GEN_FILES += $(YNL_GEN_FILES)
 
 include ../../lib.mk
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


