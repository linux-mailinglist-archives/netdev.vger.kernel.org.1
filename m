Return-Path: <netdev+bounces-275159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMd8Opj+z2kr2QYAu9opvQ
	(envelope-from <netdev+bounces-275159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 19:53:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7E83972D4
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 19:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAA69302AC05
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 17:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1539E3A9DB6;
	Fri,  3 Apr 2026 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBMY5uUZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DDC299AAB
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238656; cv=none; b=MhzRamLn/1FuIIXfjVAam/W1ZG99gKeGAKiAiAuugA6w0nY2sWqYsvBOHP0ApAE/BAarGE/w11pxkEF893OmqsnQVqKCUcYromFHgIumU0H29FuCr7ksGeCOYTV3vZ49QTOY0IP8W5FPVDccxqZbLBG71YAZ4OhxBehylRfzCXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238656; c=relaxed/simple;
	bh=V5XAtYoLjsrkjc+NdJyXkVY3dSJ6uiJw4jzwBXKtMWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DuObayEMxhfqWmZdUw+nHH3CL1EKCXi+r2M6wwklT/BTWH4y7uucMnTElN598SssuSgu3nX9bn82g9fDqQ0wMOo0Crvb/jSUQ1jzzvfNp9xalP583vvZqA80NfiCMw1D2Kz63tR9F0LhKWDxWHQnHIuuLAFNBX30lkjjSBqY05s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBMY5uUZ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7986e0553bdso20801677b3.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775238653; x=1775843453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8dl282UetUJKs0VqGe0awWZoW2QjXQSCj7EsovShSJ0=;
        b=hBMY5uUZ+pyRq/k19mZ+op5luUoOyEzKuRPDTQghim4xftTgxdXjFT7pJYE/UmIKgh
         tCxCcOWnzoaGKSn0RnGlMuVQ/uMi65KOQPYoWKKZC14o+BAc03Rzh7vMCjO10WyKdNsX
         OB2wzOkbGS5fRaLrf2ZSzvnTpl4RgBLYwWHiuJtxVvi1nb6N1G+OIhhyRhFCrQR7IpLF
         GZqTaIZTvA9ktV/kly2BNSEjVvcxdMtK8WDIwXQjBWXDnWIAgsAlEQHTPwVkW+Nv6rsp
         Wu/w0+xA2IhNoy9uv01InKwWo02BWFBh2XE5wBeCdFkINwwn12W9hi8win5UU+BsNPbr
         PqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775238653; x=1775843453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dl282UetUJKs0VqGe0awWZoW2QjXQSCj7EsovShSJ0=;
        b=TEtd8CIlOJqxJQm0vbyLJXluwGL38/t/1qSKVylFhN7YWF0eTzB4EWS1+TZzUaSy8L
         aRcj5xf4WvQSCqqNquFTJx4GZ9rZg6gUMyGY/onZ8zlqPNckqSlYs8C/eEbeCtHpvcXQ
         +mGx/zeZOv6fcTaFQjA7/aLdoYdTHAHnhJe77CkZ4k7EcPyxoyX4OVLXiThvO5Lj1jFJ
         0LkyrctZACCtuoz5OFOTdnUf9NY6/P3pf/WZ7CVFYaQSIhWdcU9rXaWYOTTkaEaNv1vg
         u7nuE2z/jg7T/jxYj/VrE6jR7E6SpH6kjlb2391EUELkSdXMMlCWKiTxnvyKzvw6N+Yh
         puRQ==
X-Gm-Message-State: AOJu0Yw17Dt3MhTbz1itqTj3O2pdRzjzkAa3CyMfxFP2YUAPxkH0bMxB
	sZ1tHu9axzNhkpEw5db/0vI85KpntFQAjXNqfonqD5Iw95bh14r863YhJ6QQOw==
X-Gm-Gg: AeBDievD+Opvg+CZ2ZfFk98vcUNqoIgIGS/Xrh5BJAh+Ssiyg1XfGkmI/mqHYG0xt0x
	XcoBJuoBa1zt017s7+jGqpj+Fah07dNLNe2TwO6YyKBG6hOX7o4K2AlQlHNos4Ar834bbB97QNu
	jBhv6PdTg+0FQb4elZBkibjE2fslxjrBwNgnAJ10LzoAdj48PiWxd4OwyfL9lQezDV4ftKWybua
	gbIO7AlfYMHCQDbRnnO69fj/oLkcd+sF96UK1EzEmd6uzJrQJmQXmTV+zoNEI6hozK3Jew3DJ6g
	gvvKywYHYX0Z+eeJlgWaILF9ejn/rip/nlSAj0XalKS2NXlzLtmuM50HzjZPhHoEOHQK4BadNo2
	ZyqRbkCXbaFm1HvmtRtSv2742be7woXNt5CUJ86fQrT4yKzWTTRbz7W6E6YJuQ1xACQMzuu3pBX
	5bDu7RC6dWpnR9fkvZLz8Oo8VnXpgnQY0e29ZF7s5PWhoVaUEuqCq9VTLPDsQo4ZZgL+cF50xbf
	OKcD0e/FdIqj4vfBemu5OA9xfQ=
X-Received: by 2002:a05:690c:25c1:b0:7a1:523e:93f6 with SMTP id 00721157ae682-7a4d5d5d817mr39205577b3.46.1775238653253;
        Fri, 03 Apr 2026 10:50:53 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e8343d3sm23826967b3.16.2026.04.03.10.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 10:50:52 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] selftests/net: convert so_txtime to drv-net
Date: Fri,  3 Apr 2026 13:50:12 -0400
Message-ID: <20260403175047.152646-1-willemdebruijn.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275159-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,so_txtime.py:url]
X-Rspamd-Queue-Id: 4B7E83972D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Willem de Bruijn <willemb@google.com>

In preparation for extending to pacing hardware offload, convert the
so_txtime.sh test to a drv-net test that can be run against netdevsim
and real hardware.

Also move so_txtime.c to lib so that it is easily accessible for the
new drv-net test, similar to gro.c in commit 8888bf4fb980 ("selftests:
net: move gro to lib for HW vs SW reuse").

Also update so_txtime.c to not exit on first failure, but run to
completion and report exit code there. This helps with debugging
unexpected results, especially when processing multiple packets,
as in the "reverse_order" testcase.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/config    |   2 +
 .../selftests/drivers/net/so_txtime.py        |  87 ++++++++++++++
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/Makefile          |   2 -
 tools/testing/selftests/net/lib/.gitignore    |   1 +
 tools/testing/selftests/net/lib/Makefile      |   1 +
 .../selftests/net/{ => lib}/so_txtime.c       |  25 +++-
 tools/testing/selftests/net/so_txtime.sh      | 110 ------------------
 9 files changed, 111 insertions(+), 119 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/so_txtime.py
 rename tools/testing/selftests/net/{ => lib}/so_txtime.c (97%)
 delete mode 100755 tools/testing/selftests/net/so_txtime.sh

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 7c7fa75b80c2..bfa72e07ca89 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -20,6 +20,7 @@ TEST_PROGS := \
 	queues.py \
 	ring_reconfig.py \
 	shaper.py \
+	so_txtime.py \
 	stats.py \
 	xdp.py \
 # end of TEST_PROGS
diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index 77ccf83d87e0..a3301d4da540 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -3,6 +3,8 @@ CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_BTF_MODULES=n
 CONFIG_INET_PSP=y
 CONFIG_IPV6=y
+CONFIG_NET_SCH_ETF=m
+CONFIG_NET_SCH_FQ=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
new file mode 100755
index 000000000000..565cecf307dd
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -0,0 +1,87 @@
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
+from lib.py import ksft_exit, ksft_run
+from lib.py import KsftNamedVariant, KsftSkipEx, ksft_variants
+from lib.py import NetDrvEpEnv, bkg, cmd
+
+
+def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_fail):
+  bin_path = cfg.net_lib_dir / "so_txtime"
+
+  tstart = time.time_ns() + 100_000_000
+
+  cmd_addr = f"-S {cfg.addr_v[ipver]} -D {cfg.remote_addr_v[ipver]}"
+  cmd_base = f"{bin_path} -{ipver} -c {clockid} -t {tstart} {cmd_addr}"
+  cmd_rx = f"{cmd_base} {args_rx} -r"
+  cmd_tx = f"{cmd_base} {args_tx}"
+
+  try:
+    with bkg(cmd_rx, host=cfg.remote, exit_wait=True):
+      cmd(cmd_tx)
+  except:
+    if not expect_fail:
+      raise
+
+
+def _test_variants_mono():
+  for ipver in ["4", "6"]:
+    for testcase in [
+        ["no_delay", "a,-1", "a,-1"],
+        ["zero_delay", "a,0", "a,0"],
+        ["one_pkt", "a,10", "a,10"],
+        ["in_order", "a,10,b,20", "a,10,b,20"],
+        ["reverse_order", "a,20,b,10", "b,20,a,20"],
+    ]:
+      name = f"_v{ipver}_{testcase[0]}"
+      yield KsftNamedVariant(name, ipver, testcase[1], testcase[2])
+
+
+@ksft_variants(_test_variants_mono())
+def test_so_txtime_mono(cfg, ipver, args_tx, args_rx):
+  cmd(f"tc qdisc replace dev {cfg.ifname} root fq")
+  test_so_txtime(cfg, "mono", ipver, args_tx, args_rx, False)
+
+
+def _test_variants_etf():
+  for ipver in ["4", "6"]:
+    for testcase in [
+        ["no_delay", "a,-1", "a,-1", True],
+        ["zero_delay", "a,0", "a,0", True],
+        ["one_pkt", "a,10", "a,10", False],
+        ["in_order", "a,10,b,20", "a,10,b,20", False],
+        ["reverse_order", "a,20,b,10", "b,10,a,20", False],
+    ]:
+      name = f"_v{ipver}_{testcase[0]}"
+      yield KsftNamedVariant(name, ipver, testcase[1], testcase[2], testcase[3])
+
+
+@ksft_variants(_test_variants_etf())
+def test_so_txtime_etf(cfg, ipver, args_tx, args_rx, expect_fail):
+  try:
+    # ETF does not support change, so remove and re-add it instead.
+    cmd(f"tc qdisc replace dev {cfg.ifname} root pfifo_fast")
+    etf_args = "clockid CLOCK_TAI delta 400000"
+    cmd(f"tc qdisc replace dev {cfg.ifname} root etf {etf_args}")
+  except Exception as e:
+    raise KsftSkipEx("tc does not support qdisc etf. skipping") from e
+
+  test_so_txtime(cfg, "tai", ipver, args_tx, args_rx, expect_fail)
+
+
+def main() -> None:
+  with NetDrvEpEnv(__file__) as cfg:
+    ksft_run([test_so_txtime_mono], args=(cfg,))
+    ksft_run([test_so_txtime_etf], args=(cfg,))
+  ksft_exit()
+
+
+if __name__ == "__main__":
+  main()
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
diff --git a/tools/testing/selftests/net/lib/.gitignore b/tools/testing/selftests/net/lib/.gitignore
index 6cd2b762af5d..c57d22e72c75 100644
--- a/tools/testing/selftests/net/lib/.gitignore
+++ b/tools/testing/selftests/net/lib/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 csum
 gro
+so_txtime
 xdp_helper
diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index ff83603397d0..8c50b6631524 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -15,6 +15,7 @@ TEST_GEN_FILES := \
 	$(patsubst %.c,%.o,$(wildcard *.bpf.c)) \
 	csum \
 	gro \
+	so_txtime \
 	xdp_helper \
 # end of TEST_GEN_FILES
 
diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/lib/so_txtime.c
similarity index 97%
rename from tools/testing/selftests/net/so_txtime.c
rename to tools/testing/selftests/net/lib/so_txtime.c
index b76df1efc2ef..6583e1a83758 100644
--- a/tools/testing/selftests/net/so_txtime.c
+++ b/tools/testing/selftests/net/lib/so_txtime.c
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
+		fprintf(stderr, "payload mismatch. expected %c", ts->data);
+		errors++;
+	}
 
 	if (llabs(tstop - texpect) > cfg_variance_us) {
 		fprintf(stderr, "exceeds variance (%d us)\n", cfg_variance_us);
 		if (!getenv("KSFT_MACHINE_SLOW"))
-			exit(1);
+			errors++;
 	}
 }
 
@@ -255,8 +261,10 @@ static void start_time_wait(void)
 		return;
 
 	now = gettime_ns(CLOCK_REALTIME);
-	if (cfg_start_time_ns < now)
-		return;
+	if (cfg_start_time_ns < now) {
+		fprintf(stderr, "FAIL: start time already passed\n");
+		errors++;
+	}
 
 	err = usleep((cfg_start_time_ns - now) / 1000);
 	if (err)
@@ -513,5 +521,10 @@ int main(int argc, char **argv)
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


