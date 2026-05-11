Return-Path: <netdev+bounces-286842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGnBB4lZAmosrgEAu9opvQ
	(envelope-from <netdev+bounces-286842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 00:34:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7EB516F76
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 00:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42CF93059E0F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3376535674B;
	Mon, 11 May 2026 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av8wErJC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F245B356741
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538107; cv=none; b=r+MVkYWSNX9X6Z6vm7CBrriHbldwnbiz8ZS2LZz00tQclfXOwCmObsI4HHRL2qzmzIITyv+5eH4QsUT6hwytAF0Eg/vlhkvSyMQ9l4JVZm0sWPxBGKTxWs5yIQCs064Te/lHp3ZwR+KSbfHm/7WWkSGA9rDhi27qza0ADSfKW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538107; c=relaxed/simple;
	bh=jjmM2GGitlEzN5iSzma8jtAOF8FHZhqXKOugnFy/DkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iuuvcJ2sYkR7od/REep7NAIeYkeHM279IF9gsJUqiEZElsoDe9yFSzRjNBzQpG9Bpkn6yHO3rbyYk/BNjagLDdWm7xx3EcU4vN6LnH3X5k2RbAQ4amRrMPoPKTQMmO5swJRFSqlCpQUB09itVKd0nNAi1mGrQXLzzZ1v0czZVQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av8wErJC; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64d5a7926cfso4502199d50.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778538104; x=1779142904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rktqOhL/WC+LFcBNVBl8EKTq1ERQ0ZB3bcN1+M0y/0E=;
        b=Av8wErJCJAFJEvr7zbANilFauaHEd0ZHnRiRJ0IzHqLHC4xF9y9e2yfBPsLKtmjZJ+
         56m9iVoleH2FTxyDI+I8os1L1pn2TOOf8oQse/L+mhlMMtbC32WbzDoebzhFbAabdNCO
         0U3p8WaZOxdEk7Nza/+WXICNaImj9+H5AO6KKtS3KlP6NextYh0jvgUN+KIzjF/ZxnNU
         8q3RDT2jdCta1b2AdiN7P97Q8O7q3nbaDOO1omwe0/w+f1zgY3owbWj++lMy4yt7USrB
         wgaeqLyevl6VYmEcleQvDEWxlzG9nqMmoMH/oVhtUa1mor7pVp9v/3XhECqZ8ExWb/cp
         bJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778538104; x=1779142904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rktqOhL/WC+LFcBNVBl8EKTq1ERQ0ZB3bcN1+M0y/0E=;
        b=HTA1Bo3v8tNNciSqsRSw7VvCkYY4C73tyBey540Mr7LnKy3/LMmkQKTgbvj3ov1aFH
         YU/3T/tSZe+duc5kLu2p2X6Mb549qiezPqDN0rig8GOiL+qknbUJpEkFSaV+s6K7s0mh
         JL9IaCU+djVawXvE9IcAZ9JOadKjfndmU5IFJQXSPYejDA/d+fRTbUZ+tnqOpaQnOQJ7
         jG3icMwCzXKeEaG9+QfHsM8lfYcfU1lsi1dFreioZ3J7fDJHp8lR1SIHqCyyvUYiHDLl
         6RHX1jCFY+ALaCkftjF9RTfomOVcpVWDKxuhxXA8nT71iYqB3cy6Hbx88IES4hj2uW+y
         5a3g==
X-Gm-Message-State: AOJu0YxCxEnRXw0Ohr3MFYUl0xrVoAeCLsOauVPqPUeuyWXLNPrqTGQp
	nEHhSkMENVvNhEYumOwRvclcI2zNp2WZuWdbApgXtJdN66H3G0OXwzbJIOXNuQ==
X-Gm-Gg: Acq92OEcmHJk+n/Ju5bO4hUiCF4NPENSWIMTYJZbuiNMZZF2Fxef0H8xRmQbzKRNIQ/
	W1ibdxcu+EbmiBQCCRXTtYqmVOdc1urdsDmNj5dmB2hLrdFhvonLQSsYMpIdaE+7tkr7JkK0Q+Z
	3elpMcmnWUPdBpBWssvjxEj8mIeOeJ1ZyIHc3xlg++GlUUcqxQWKYYJK7ovjDcceeEtclbsEZOe
	0kbO/FJSksm9jNNIlcTTn3CJP5eCHHLwiHNhpS5R8pK4XbAXakwhVTwmFQpLPlyCGWSJWDJlBJ8
	hWRaiKApUOHBIjE9Uq3EQtvkDwa9Mb1zsGVpzuvGwek29vrsdprYtpKY9GIpoeurdS7pl9cGEdi
	dsDffnXxrSweLN+vjPROd3aZGwVumFQCveMr9cLiuNXwetokdKaYc4qpO+oNr6nLzq3TJniRGIQ
	P+PJKqZXKDUMJJSXHjO42Xo0vDyJf7bnlLas5kgS97NyqnyraGNCAm5X8/QlDkH1Uy7BRVEc5Bu
	3keVqldioLGzDj6swsuQztzOakJTAiErUGUKw==
X-Received: by 2002:a05:690e:15cf:b0:651:be50:af09 with SMTP id 956f58d0204a3-65c79ad6df1mr18811474d50.3.1778538103818;
        Mon, 11 May 2026 15:21:43 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d969fb3b3sm6203476d50.1.2026.05.11.15.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:21:42 -0700 (PDT)
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
Subject: [PATCH net-next] selftests: drv-net: cope with slow env in so_txtime.py test
Date: Mon, 11 May 2026 18:19:20 -0400
Message-ID: <20260511222138.2045551-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7B7EB516F76
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-286842-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,so_txtime.sh:url,lib.py:url]
X-Rspamd-Action: no action

From: Willem de Bruijn <willemb@google.com>

This test was converted from shell script to drv-net test.

The new version is flaky in dbg builds on the netdev.bots dashboard.
The previous shell script had more protections to avoid these. Added
in commit a7ee79b9c455 ("selftests: net: cope with slow env in
so_txtime.sh test").

Add the same overall protection:

- Suppress so_txtime process failure if KSFT_MACHINE_SLOW

Also relax two timeouts to reduce the number of process failures
themselves

- Increase SO_RCVTIMEO to 2 seconds
- Increase process start-up stabilization to 2 seconds

Delays were experimentally arrived at while running with vng
built with kernel/configs/debug.config

Fixes: 5c6baef3885c ("selftests: drv-net: convert so_txtime to drv-net")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20260510174219.74aeee6d@kernel.org/
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/drivers/net/so_txtime.c  | 10 ++++++++--
 tools/testing/selftests/drivers/net/so_txtime.py | 11 +++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
index b6930883569b..75f3beef13d9 100644
--- a/tools/testing/selftests/drivers/net/so_txtime.c
+++ b/tools/testing/selftests/drivers/net/so_txtime.c
@@ -38,6 +38,7 @@
 static int	cfg_clockid	= CLOCK_TAI;
 static uint16_t	cfg_port	= 8000;
 static int	cfg_variance_us	= 4000;
+static bool	cfg_machine_slow;
 static uint64_t	cfg_start_time_ns;
 static int	cfg_mark;
 static bool	cfg_rx;
@@ -142,7 +143,7 @@ static void do_recv_one(int fdr, struct timed_send *ts)
 
 	if (llabs(tstop - texpect) > cfg_variance_us) {
 		fprintf(stderr, "exceeds variance (%d us)\n", cfg_variance_us);
-		if (!getenv("KSFT_MACHINE_SLOW"))
+		if (!cfg_machine_slow)
 			errors++;
 	}
 }
@@ -263,7 +264,7 @@ static void start_time_wait(void)
 	now = gettime_ns(CLOCK_REALTIME);
 	if (cfg_start_time_ns < now) {
 		fprintf(stderr, "FAIL: start time already passed\n");
-		if (!getenv("KSFT_MACHINE_SLOW"))
+		if (!cfg_machine_slow)
 			errors++;
 		return;
 	}
@@ -326,6 +327,9 @@ static int setup_rx(struct sockaddr *addr, socklen_t alen)
 	if (bind(fd, addr, alen))
 		error(1, errno, "bind");
 
+	if (cfg_machine_slow)
+		tv.tv_sec = 2;
+
 	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)))
 		error(1, errno, "setsockopt rcv timeout");
 
@@ -512,6 +516,8 @@ static void parse_opts(int argc, char **argv)
 	setup_sockaddr(domain, saddr, &cfg_src_addr);
 
 	cfg_num_pkt = parse_io(argv[optind], cfg_buf);
+
+	cfg_machine_slow = getenv("KSFT_MACHINE_SLOW");
 }
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
index 5b54ce76dff4..e7de8fe22c1e 100755
--- a/tools/testing/selftests/drivers/net/so_txtime.py
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -6,6 +6,7 @@
 Test delivery time in FQ and ETF qdiscs.
 """
 
+import os
 import time
 
 from lib.py import ksft_exit, ksft_run, ksft_variants
@@ -15,17 +16,23 @@ from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
 
 def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
     """Main function. Run so_txtime as sender and receiver."""
+    slow_machine = os.environ.get('KSFT_MACHINE_SLOW')
+
     bin_path = cfg.test_dir / "so_txtime"
 
-    tstart = time.time_ns() + 200_000_000
+    tstart = time.time_ns() + (2000_000_000 if slow_machine else 200_000_000)
 
     cmd_addr = f"-S {cfg.addr_v[ipver]} -D {cfg.remote_addr_v[ipver]}"
     cmd_base = f"{bin_path} -{ipver} -c {clockid} -t {tstart} {cmd_addr}"
     cmd_rx = f"{cmd_base} {args_rx} -r"
     cmd_tx = f"{cmd_base} {args_tx}"
 
+    expect_fail = not expect_success
+    if slow_machine:
+        expect_success = False
+
     with bkg(cmd_rx, host=cfg.remote, fail=expect_success,
-             expect_fail=(not expect_success), exit_wait=True):
+             expect_fail=expect_fail, exit_wait=True):
         cmd(cmd_tx)
 
 
-- 
2.54.0.563.g4f69b47b94-goog


