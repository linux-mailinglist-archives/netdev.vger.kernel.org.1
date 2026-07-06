Return-Path: <netdev+bounces-305052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NjJgGrG2S2o+ZAEAu9opvQ
	(envelope-from <netdev+bounces-305052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:07:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9A6711BC6
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:07:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=G9LAu60G;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305052-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305052-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F108630CA1CB
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF52375F9C;
	Mon,  6 Jul 2026 13:34:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E63242D97
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:34:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344886; cv=none; b=EV7ZgFRMUUT83zc27w2TDJ8mZ9TRXMNU/QD3OrKenWl068w5wR9yCpOYylyanOXebRryGA6PmagEYe23X6L0Z0q5SU1B4bsSRTXu+xY7VSO+08t8sbtuwc4f8IouYouo4AtBlh5HaOe6SlslJ8NFGIY6B/367Xi6xOshJIE6PNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344886; c=relaxed/simple;
	bh=wcFi+Lubw9jfztNTpYRw86EQmNiOnIpS7CCXAM21ifg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWOQPWPhzUtGxiJwrNpQ5dCs6YfOhE5eQ2zpVWNXndFDLc7AfOJ65+9qqieVTm0Cs9EAI1JcQ0jr21b7UiflNOP9SPMrJu1Mn8SZ5987RYa4EAw2SdH0PpALYVV5zlYSBIadwroUJFkyJdT8xXxxldWd2UC4yIggXwVv1w5kEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9LAu60G; arc=none smtp.client-ip=209.85.128.178
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-80814edb536so38848217b3.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783344883; x=1783949683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bbfBl0v2N0huYMy69Jtv6j5jT9vMOtqkafLj64iIyhI=;
        b=G9LAu60GrU+CVDaUNEHlKCmu/W5QuVy9XYvydS4IU5U2CWUHXNn0gHPYewpkieO/wf
         3yvsEz73CwQVQkO7pYuSGIVhxW2ScMUnZRBPu3nTnxABRRK3n441IUokEHoaO9bPN7Rl
         rGS0cRwRc+fHxxCARCLa/lMQOcB99HWY2L31iVbeyQfRDp/H3O9psWecinTgJ73sU8yc
         MJlxN27+5kgSg1pVFaOst0Q63vyiiK9PmbuauAgDxe/BsPJ5sMvUZ3wTiMMaw/YRDd7+
         X8/hVhznhwSOcOL749cd8fytCTaC51r/SPW91vs526eFtfhqX/FdeVgG6pZQ9S8NF9DU
         9Teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344883; x=1783949683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bbfBl0v2N0huYMy69Jtv6j5jT9vMOtqkafLj64iIyhI=;
        b=KjNx00YU4hSXquqvpHRkI08pcutn2zkRWkRAb4JRtiyoSFAXVJWKQaow+FuPAEoywQ
         QC8tlFNJTHpxZIiOK5uh01kqaZ/ya58U/EeRNrDDS9E50Rr28MthzaDqDvHcYXWOaNXd
         xsS1+dt73mqYoTuczu8gdpzBsBEgHSeRtJEIPPzhd/85e1siX80EIuuQcykgEJSltwwj
         seODrIzB2sPxpji9bYhMgbRU7G8BU3cgAC26HPSHPCakDQk2fucxxJfcibUBa64q8/g7
         +gTf41FW0M5XYbil2TX/fS54AaoC1f+bidVe1/U1v1KOtLzzaPArTVmErac2aU8OsppD
         VBzQ==
X-Gm-Message-State: AOJu0Yx87EUCLqHuDkgdm4LEwV4lgGTCmFDxwvGTdilbH4pyT8Ubpn5m
	C0jRqzQkKkPIKjz6QsQZaRKWk2hAOTri7pRBZcstBCY1D0VWWMWyPVVjUFMexg==
X-Gm-Gg: AfdE7cmNLZNK3wT5Yq6dbc/rZJ7+1mwIBR0d3dtUh6NFL2UXdfNboR/1YUe2+lZm646
	bTIBCvqH1FBYLdif57DZOG6UDZ2+0uzlDEceudP71Vh0/OvndPx6umgh4yIyYBGvvnFsasc5ff2
	RmL64nGMT+sWZqVQjfG6R9kRFZYrG6Tm+PG+42Pry3cVPmOu2/DCONwht20AUpv+cww2BiAEiQW
	b2J5ArokRslV4RHuQJU0xo9juc3+Rbi2LEXVXkixSczXsKy2M93DIDWDCwqBvBVKqH5Ftm3RscU
	edhwzQAzGb3jxQBERnd6xn3gJoxL+1drzpudXQHNVYKklPO5Y4+01cLLl5PFgCWhjNxuT3u7LXf
	Fwy5zvFtUatA0TVZFPw87Cbu7kjCWiJ6eExiJCRL9iLWYJtIogCqDC2MPuONL1qbtD19/yWcNE2
	35MDISGll+6g9eVi1Ga12aJtBOWYNZQJsdduVAWVItP2F5mX0qTZEXr3ihleDAU/gSxeD4F5XLF
	3G6IznLnqtx5kMXeC5Ng9/kfe8=
X-Received: by 2002:a05:690c:4509:b0:80c:85c6:8987 with SMTP id 00721157ae682-81be42f9eb6mr1790227b3.70.1783344883458;
        Mon, 06 Jul 2026 06:34:43 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144b537e3asm57002827b3.34.2026.07.06.06.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:34:43 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 6/7] selftests: drv-net: extend so_txtime with hw offload
Date: Mon,  6 Jul 2026 09:34:08 -0400
Message-ID: <20260706133433.3142805-7-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260706133433.3142805-1-willemdebruijn.kernel@gmail.com>
References: <20260706133433.3142805-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-305052-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew@lunn.ch,m:willemb@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF9A6711BC6

From: Willem de Bruijn <willemb@google.com>

Add two pacing hardware offload variants

1. one that uses FQ to safely offload when within bounds.
2. one that uses pfifo_fast and thus forwards all packets.

Verify that the packets are paced in hardware with new flag '-h'.

Also move the ip version check to the main test_so_txtime callee,
rather than having to add checks to the new variants.

Also increase test timeout to 2 min. This suite now counts 58 tests,
which each take 2 sec to stabilize when run with KSFT_MACHINE_SLOW.
When increasing the bound, do so with a sizable headroom.

Also increase rcvtimeout significantly to reduce flakiness.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/drivers/net/settings  |  1 +
 .../testing/selftests/drivers/net/so_txtime.c |  2 +-
 .../selftests/drivers/net/so_txtime.py        | 72 +++++++++++++++++--
 3 files changed, 70 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/settings

diff --git a/tools/testing/selftests/drivers/net/settings b/tools/testing/selftests/drivers/net/settings
new file mode 100644
index 000000000000..b478e684846a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/settings
@@ -0,0 +1 @@
+timeout=240
diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
index 5900ca97957c..6e64baa4c60d 100644
--- a/tools/testing/selftests/drivers/net/so_txtime.c
+++ b/tools/testing/selftests/drivers/net/so_txtime.c
@@ -375,7 +375,7 @@ static int setup_tx(struct sockaddr *addr, socklen_t alen)
 
 static int setup_rx(struct sockaddr *addr, socklen_t alen)
 {
-	struct timeval tv = { .tv_usec = 100 * 1000 };
+	struct timeval tv = { .tv_usec = 600 * 1000 };
 	int fd;
 
 	fd = socket(addr->sa_family, SOCK_DGRAM, 0);
diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
index adf6c848d6d8..9dbf6067de27 100755
--- a/tools/testing/selftests/drivers/net/so_txtime.py
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -12,10 +12,13 @@ import time
 from lib.py import ksft_exit, ksft_run, ksft_variants
 from lib.py import KsftNamedVariant, KsftSkipEx
 from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
+from lib.py import EthtoolFamily, NlError
 
 
 def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
     """Main function. Run so_txtime as sender and receiver."""
+    cfg.require_ipver(ipver)
+
     slow_machine = os.environ.get('KSFT_MACHINE_SLOW')
 
     if not hasattr(cfg, "bin_remote"):
@@ -38,6 +41,34 @@ def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
         cmd(cmd_tx)
 
 
+def _dev_setup_pacing_offload(cfg):
+    """Configure pacing-offload-horizon."""
+    ethnl = EthtoolFamily()
+
+    try:
+        rings = ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    except NlError:
+        raise KsftSkipEx('ring-get not supported by device')
+
+    if 'pacing-offload-horizon' not in rings or \
+       'pacing-offload-horizon-max' not in rings:
+        raise KsftSkipEx('pacing offload horizon not supported by device')
+
+    if rings['pacing-offload-horizon-max'] < 50_000:
+        raise KsftSkipEx('pacing offload max horizon too small')
+
+    cur_horizon = rings['pacing-offload-horizon']
+    new_horizon = 50_000
+    ethnl.rings_set({
+        'header': {'dev-index': cfg.ifindex},
+        'pacing-offload-horizon': new_horizon,
+    })
+    defer(ethnl.rings_set, {
+        'header': {'dev-index': cfg.ifindex},
+        'pacing-offload-horizon': cur_horizon
+    })
+
+
 def _qdisc_setup(ifname, qdisc, optargs=""):
     """Replace root qdisc. Restore the original after the test.
 
@@ -56,6 +87,7 @@ def _test_variants_fq():
             ["one_pkt", "a,10", "a,10"],
             ["in_order", "a,10,b,20", "a,10,b,20"],
             ["reverse_order", "a,20,b,10", "b,10,a,20"],
+            ["beyond_hw_horizon", "a,70", "a,70"],
         ]:
             name = f"v{ipver}_{testcase[0]}"
             yield KsftNamedVariant(name, ipver, testcase[1], testcase[2])
@@ -64,15 +96,42 @@ def _test_variants_fq():
 @ksft_variants(_test_variants_fq())
 def test_so_txtime_fq_mono(cfg, ipver, args_tx, args_rx):
     """Run all variants of monotonic (fq) tests."""
-    cfg.require_ipver(ipver)
     _qdisc_setup(cfg.ifname, "fq")
     test_so_txtime(cfg, "mono", ipver, args_tx, args_rx, True)
 
 
+@ksft_variants(_test_variants_fq())
+def test_so_txtime_fq_mono_hw(cfg, ipver, args_tx, args_rx):
+    """Run all variants of monotonic fq tests, with offload horizon."""
+    cfg.require_nsim(nsim_test=False)
+
+    _dev_setup_pacing_offload(cfg)
+    try:
+        _qdisc_setup(cfg.ifname, "fq", "offload_horizon 50ms")
+    except Exception as e:
+        raise KsftSkipEx("netdev does not support offload. skipping") from e
+
+    # Expect all tests to use only hw pacing, except beyond_hw_horizon.
+    hw_only = "-h" if args_tx != "a,70" else ""
+    test_so_txtime(cfg, "mono", ipver, f"{hw_only} {args_tx}", args_rx, True)
+
+
+@ksft_variants(_test_variants_fq())
+def test_so_txtime_pfifofast_mono_hw(cfg, ipver, args_tx, args_rx):
+    """Run all variants of monotonic tests, without fq pacing sw backup."""
+    cfg.require_nsim(nsim_test=False)
+
+    _dev_setup_pacing_offload(cfg)
+    _qdisc_setup(cfg.ifname, "pfifo_fast")
+
+    # Expect all tests to pass, except beyond_hw_horizon without sw fallback.
+    expect_pass = False if args_tx == "a,70" else True
+    test_so_txtime(cfg, "mono", ipver, f"-h {args_tx}", args_rx, expect_pass)
+
+
 @ksft_variants(_test_variants_fq())
 def test_so_txtime_fq_tai(cfg, ipver, args_tx, args_rx):
     """Run all variants of fq tests, but pass CLOCK_TAI to test conversion."""
-    cfg.require_ipver(ipver)
     _qdisc_setup(cfg.ifname, "fq")
     test_so_txtime(cfg, "tai", ipver, args_tx, args_rx, True)
 
@@ -95,7 +154,6 @@ def _test_variants_etf():
 @ksft_variants(_test_variants_etf())
 def test_so_txtime_etf(cfg, ipver, args_tx, args_rx, expect_fail):
     """Run all variants of etf tests."""
-    cfg.require_ipver(ipver)
     try:
         _qdisc_setup(cfg.ifname, "etf", "clockid CLOCK_TAI delta 400000")
     except Exception as e:
@@ -108,7 +166,13 @@ def main() -> None:
     """Boilerplate ksft main."""
     with NetDrvEpEnv(__file__) as cfg:
         ksft_run(
-            [test_so_txtime_fq_mono, test_so_txtime_fq_tai, test_so_txtime_etf],
+            [
+                test_so_txtime_fq_mono,
+                test_so_txtime_fq_mono_hw,
+                test_so_txtime_pfifofast_mono_hw,
+                test_so_txtime_fq_tai,
+                test_so_txtime_etf,
+            ],
             args=(cfg,),
         )
     ksft_exit()
-- 
2.55.0.795.g602f6c329a-goog


