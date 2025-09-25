Return-Path: <netdev+bounces-226534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AFCBA1832
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 23:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0C51C821DE
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 21:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDED322A1C;
	Thu, 25 Sep 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQLilS6C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E2322768
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835018; cv=none; b=AAKgFMZA+TigbC8zn+sk0Y6TXA0BOYe01ekkS3a7o+ntBpqwXGgRJMaGchHrMITJ9NtifSbWI9/9GBujhyH/uKC5UZ38FVx9rBJZVVG/5/Ony/1m+a3Bpdl5yILBXM1A3nw7t+qWCgge5r9z2nHhNTlEd9vRabOIslL1vbTMq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835018; c=relaxed/simple;
	bh=ws9l/iUQnq4Qdk2FokqagUnjaYLJdlpIxQS4QqeTTcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBj4Kn0NXiddc01nAMpRxIezPefME/9i/1Jx/665tyvgQo2wH9lNHB+m1uGZ0HqcNmvhL039xr792R9s24urPJW7Kw9X0k92aIeltMEB1Ptgk86/cbqnAvUqMXYpWc0K7SCK9jwvN80LLRVAfWEiExvjvWbLR4ECr2jZZ+Cc1ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQLilS6C; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d60110772so13249247b3.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 14:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758835016; x=1759439816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQ8iOrryw968uEYUZ4XHX3ZtqDXI/POFGbLQK1E3BvQ=;
        b=gQLilS6CGZJLzZvFlxPlW75zuyev8X1r5Sr0uyVOUJd/GmAqqRVcAL6OvX5pL+hJAK
         h7D+Dzz3adV+4lQSSVWZ23crsFKfKhSNOESqXv63Q7eKq8EKYg+iRsRqdoQECv+TsgCr
         U30TANyYI9tYKc8OWBGcd72QiPwy/mxdTNW6u3UMXqq2IPjEvEXvgzdgzBKs3HKQQIZC
         g7thN46fT04+WVjAAJlWrByGcWR+kLtp47HNDORe1jpNtMcZnKudInxUmqamPizUaQ4Y
         ykotfLulaVlKsLYQNc3/znSoC58FPgkawxlUIUrbJbcu2Di94vtzWJJcLwJgRT9ZAdC2
         Oa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835016; x=1759439816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQ8iOrryw968uEYUZ4XHX3ZtqDXI/POFGbLQK1E3BvQ=;
        b=jFvMS4C0cMtzY3h60sFhLTfIP/XTUCwJKRuKAxUywTpI/OCxFvZXlgWON6eKUx03Pf
         ncnm270wALMcJPXLgrA6h0DFEIfDNFBGs44MgSgOYrD8Q9KG6GIdrmkgQdOB7prdrAPs
         m0GuXs9a22RhF9LnVBWburSH1qERjSe1PUmoA91nOIFkJG7/tKciiKbEvCSlkehoHkUj
         vjrxFXvWm/tjkY/1jCexJOikbomEygBWFnlme1h1TU1HPDJWUo3gJ+kGS8KJ4p0QWceL
         pH/v3tLQOFNBTWjprX2BT0SuHCXfwudgMTbMXcjSeRsrzQF5BmuahfQg9Q4rGl+g9J3S
         v5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2cHVWsSdia33/vCxvmwwEcCvbie4hxLZHfzrUVDl0xCeGRl7KJ4+ERFJywx84x/Rb5cVvrJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHH4bbucyu1ccghffSTc4OpeX0jgUNZ9Z4IEea/NI89H863xrP
	Wrz0uLEtFUL+fKl5jNP7NqYl2DLFekBDLSFnd3kfIJvzxQ+V67RkaI0I
X-Gm-Gg: ASbGnctmbSbtkdvgbTKuGSWHRXiY3hcMXquBtF+dFwGEvnR9Uig+e1Xd0hGqVgmkvC1
	FDfyiqs+H1nQ42/tP5Sbfq7scZg6SSUV8kmwFQY0D9AeqXLhkik2h32lZQObEOrllX8CoOyZlvy
	tRAPoFMjwRXS3VmNJpOcWJeo3iJajM9Cv7jnLMgoexBx/Pjfhl3iKAgxg+U/72dDOjozg4TpivA
	wdUVDGzpsPZkA72Yf1BjN7gE4tilewV8MXf3eoKEenaQmq7LBfDI10PcKdJ8TCUxV2M7jx5dhxl
	t5V4+FGj3usOCIfPpoHV7twfvMH2fqtlTD05Fsm+lO8oPuup2gFK0dTODSjas17DBSJGjQNtxCX
	D4NP2tbCQM0p6v5+5hFf0
X-Google-Smtp-Source: AGHT+IE0uqj5uuhUQtY9GrIava96/rc6kDAl5GbSml0wGfvPaF0HUznptsyO71AcvlDonjlSLU4d1g==
X-Received: by 2002:a05:690c:55c5:b0:73b:bc38:267 with SMTP id 00721157ae682-763fa05f419mr49124737b3.10.1758835015755;
        Thu, 25 Sep 2025 14:16:55 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765bb916ac8sm7479627b3.3.2025.09.25.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:16:55 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	Breno Leitao <leitao@debian.org>,
	Petr Machata <petrm@nvidia.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 5/8] selftests: drv-net: psp: add association tests
Date: Thu, 25 Sep 2025 14:16:41 -0700
Message-ID: <20250925211647.3450332-6-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250925211647.3450332-1-daniel.zahka@gmail.com>
References: <20250925211647.3450332-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Add tests for exercising PSP associations for TCP sockets.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 .../drivers/net/hw/lib/py/__init__.py         |   2 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/drivers/net/psp.py    | 147 +++++++++++++++++-
 tools/testing/selftests/net/lib/py/ksft.py    |   5 +
 4 files changed, 152 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 559c572e296a..1c631f3c81f1 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -22,7 +22,7 @@ try:
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
-        ksft_ne, ksft_not_in, ksft_raises, ksft_true
+        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt
     from net.lib.py import NetNSEnter
     from drivers.net.lib.py import GenerateTraffic
     from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 31ecc618050c..8a795eeb5051 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -21,7 +21,7 @@ try:
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
-        ksft_ne, ksft_not_in, ksft_raises, ksft_true
+        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt
 except ModuleNotFoundError as e:
     ksft_pr("Failed importing `net` library from kernel sources")
     ksft_pr(str(e))
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index f81ad6200627..b4d97a9a5fbc 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -10,7 +10,7 @@ import termios
 import time
 
 from lib.py import ksft_run, ksft_exit, ksft_pr
-from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_raises, KsftSkipEx
+from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises, KsftSkipEx
 from lib.py import NetDrvEpEnv, PSPFamily, NlError
 from lib.py import bkg, rand_port, wait_port_listen
 
@@ -33,6 +33,13 @@ def _remote_read_len(cfg):
     return int(cfg.comm_sock.recv(1024)[:-1].decode('utf-8'))
 
 
+def _make_clr_conn(cfg, ipver=None):
+    _send_with_ack(cfg, b'conn clr\0')
+    remote_addr = cfg.remote_addr_v[ipver] if ipver else cfg.remote_addr
+    s = socket.create_connection((remote_addr, cfg.comm_port), )
+    return s
+
+
 def _make_psp_conn(cfg, version=0, ipver=None):
     _send_with_ack(cfg, b'conn psp\0' + struct.pack('BB', version, version))
     remote_addr = cfg.remote_addr_v[ipver] if ipver else cfg.remote_addr
@@ -151,6 +158,140 @@ def dev_rotate_spi(cfg):
     ksft_ne(top_a, top_b)
 
 
+def assoc_basic(cfg):
+    """ Test creating associations """
+    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+        assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                  "dev-id": cfg.psp_dev_id,
+                                  "sock-fd": s.fileno()})
+        ksft_eq(assoc['dev-id'], cfg.psp_dev_id)
+        ksft_gt(assoc['rx-key']['spi'], 0)
+        ksft_eq(len(assoc['rx-key']['key']), 16)
+
+        assoc = cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                                  "version": 0,
+                                  "tx-key": assoc['rx-key'],
+                                  "sock-fd": s.fileno()})
+        ksft_eq(len(assoc), 0)
+        s.close()
+
+
+def assoc_bad_dev(cfg):
+    """ Test creating associations with bad device ID """
+    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+        with ksft_raises(NlError) as cm:
+            cfg.pspnl.rx_assoc({"version": 0,
+                              "dev-id": cfg.psp_dev_id + 1234567,
+                              "sock-fd": s.fileno()})
+        ksft_eq(cm.exception.nl_msg.error, -19)
+
+
+def assoc_sk_only_conn(cfg):
+    """ Test creating associations based on socket """
+    with _make_clr_conn(cfg) as s:
+        assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                  "sock-fd": s.fileno()})
+        ksft_eq(assoc['dev-id'], cfg.psp_dev_id)
+        cfg.pspnl.tx_assoc({"version": 0,
+                          "tx-key": assoc['rx-key'],
+                          "sock-fd": s.fileno()})
+        _close_conn(cfg, s)
+
+
+def assoc_sk_only_mismatch(cfg):
+    """ Test creating associations based on socket (dev mismatch) """
+    with _make_clr_conn(cfg) as s:
+        with ksft_raises(NlError) as cm:
+            cfg.pspnl.rx_assoc({"version": 0,
+                              "dev-id": cfg.psp_dev_id + 1234567,
+                              "sock-fd": s.fileno()})
+        the_exception = cm.exception
+        ksft_eq(the_exception.nl_msg.extack['bad-attr'], ".dev-id")
+        ksft_eq(the_exception.nl_msg.error, -22)
+
+
+def assoc_sk_only_mismatch_tx(cfg):
+    """ Test creating associations based on socket (dev mismatch) """
+    with _make_clr_conn(cfg) as s:
+        with ksft_raises(NlError) as cm:
+            assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                      "sock-fd": s.fileno()})
+            cfg.pspnl.tx_assoc({"version": 0,
+                              "tx-key": assoc['rx-key'],
+                              "dev-id": cfg.psp_dev_id + 1234567,
+                              "sock-fd": s.fileno()})
+        the_exception = cm.exception
+        ksft_eq(the_exception.nl_msg.extack['bad-attr'], ".dev-id")
+        ksft_eq(the_exception.nl_msg.error, -22)
+
+
+def assoc_sk_only_unconn(cfg):
+    """ Test creating associations based on socket (unconnected, should fail) """
+    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+        with ksft_raises(NlError) as cm:
+            cfg.pspnl.rx_assoc({"version": 0,
+                              "sock-fd": s.fileno()})
+        the_exception = cm.exception
+        ksft_eq(the_exception.nl_msg.extack['miss-type'], "dev-id")
+        ksft_eq(the_exception.nl_msg.error, -22)
+
+
+def assoc_version_mismatch(cfg):
+    """ Test creating associations where Rx and Tx PSP versions do not match """
+    versions = list(cfg.psp_supported_versions)
+    if len(versions) < 2:
+        raise KsftSkipEx("Not enough PSP versions supported by the device for the test")
+
+    # Translate versions to integers
+    versions = [cfg.pspnl.consts["version"].entries[v].value for v in versions]
+
+    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+        rx = cfg.pspnl.rx_assoc({"version": versions[0],
+                                 "dev-id": cfg.psp_dev_id,
+                                 "sock-fd": s.fileno()})
+
+        for version in versions[1:]:
+            with ksft_raises(NlError) as cm:
+                cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                                    "version": version,
+                                    "tx-key": rx['rx-key'],
+                                    "sock-fd": s.fileno()})
+            the_exception = cm.exception
+            ksft_eq(the_exception.nl_msg.error, -22)
+
+
+def assoc_twice(cfg):
+    """ Test reusing Tx assoc for two sockets """
+    def rx_assoc_check(s):
+        assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                  "dev-id": cfg.psp_dev_id,
+                                  "sock-fd": s.fileno()})
+        ksft_eq(assoc['dev-id'], cfg.psp_dev_id)
+        ksft_gt(assoc['rx-key']['spi'], 0)
+        ksft_eq(len(assoc['rx-key']['key']), 16)
+
+        return assoc
+
+    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+        assoc = rx_assoc_check(s)
+        tx = cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                               "version": 0,
+                               "tx-key": assoc['rx-key'],
+                               "sock-fd": s.fileno()})
+        ksft_eq(len(tx), 0)
+
+        # Use the same Tx assoc second time
+        with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s2:
+            rx_assoc_check(s2)
+            tx = cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                                   "version": 0,
+                                   "tx-key": assoc['rx-key'],
+                                   "sock-fd": s2.fileno()})
+            ksft_eq(len(tx), 0)
+
+        s.close()
+
+
 def _data_basic_send(cfg, version, ipver):
     """ Test basic data send """
     # Version 0 is required by spec, don't let it skip
@@ -232,7 +373,9 @@ def main() -> None:
                 ]
 
                 if cfg.psp_dev_id is not None:
-                    ksft_run(cases=cases, globs=globals(), case_pfx={"dev_",}, args=(cfg, ))
+                    ksft_run(cases=cases, globs=globals(),
+                             case_pfx={"dev_", "assoc_"},
+                             args=(cfg, ))
                 else:
                     ksft_pr("No PSP device found, skipping all tests")
 
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 8e35ed12ed9e..72cddd6abae8 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -92,6 +92,11 @@ def ksft_ge(a, b, comment=""):
         _fail("Check failed", a, "<", b, comment)
 
 
+def ksft_gt(a, b, comment=""):
+    if a <= b:
+        _fail("Check failed", a, "<=", b, comment)
+
+
 def ksft_lt(a, b, comment=""):
     if a >= b:
         _fail("Check failed", a, ">=", b, comment)
-- 
2.47.3


