Return-Path: <netdev+bounces-226082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF1DB9BC4D
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 21:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A3F1BC2898
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425EE273D75;
	Wed, 24 Sep 2025 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYF70C+u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569DC2727F3
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743411; cv=none; b=bN2YM9vzdh28MGw8NjCqij2dsoBwUiUcmAxN0SV4kPl8nK/jprgEteYnxKe2n5qqyWEMftwMye0xCUDwqU7Kwd9wT+B/nFFtWAZt9ZTWEJywuxe70EfIGOx/09iV0bmhc/oPQH74y9u/bhxQJUwsL3wSIJUQ5DeYFRroT74UDto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743411; c=relaxed/simple;
	bh=hBG7n4J6M7LZu9HF1nfql3CnNtgdo2g9Gwx9FZ9weuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSvZdN/NFFqkXKek8mjavXnoAspJBng1PXgutj76rXPi4+UGrfOrmLndCzqjnF6Oz4Pyryr1IZYre+E2FSAewKAUodDEVNizh4Y8oVpWO2ggv9uL0UHeRfVM8Z8u1RjbaESUA8Oeu6a2MaJF5p/utJwMerypo39w7k4/g7EQK7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYF70C+u; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-749399349ddso2718977b3.3
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758743408; x=1759348208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFFEYDcEyI2leiiDXvVsUHKXiEXYYXz1ExuhhGqLCtI=;
        b=fYF70C+uMz+/XFcYiWHZSWT+7Kfm6SQpaOr4SeR79mZ4w0MWnCflTcckH9ulNlmL5Y
         lDzvjdPtgvBPf/LVZT3p4U0hpS/wUrZ2T1QoeEB4673pnze5klJWDO0JM8155yWe5Dgt
         l52cxYP6uE+nozO9Pq7ttqC6o+ZhhbMZ86yd/iFeIiJ5WnF3WJP5N+N9DoXkR99AhBRt
         k+se3u5DmUYGbLrWd3UWFXaIdM52hlkNBB7lxALed+55iNj5ih5d7xtS+mdYBYuYbLvI
         sYCNRgouosbTOUrpvkvtt2FUhzKO1SB+h+JdqaQclMTFs1N2OnPZcgMT1rUjLS/sEfpQ
         F77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758743408; x=1759348208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFFEYDcEyI2leiiDXvVsUHKXiEXYYXz1ExuhhGqLCtI=;
        b=e9Z4g0lYN6jqUIr7FGAXvRkw2nNrRgY0dSbkdSaDwSIiyJh8NilOMQq4++daeOd3fJ
         bHGUT6N3k1Vyd4E751F5Rj0WyOzL0yuQ2i4GslgcSgpb8/5fUzYjc94hxdElWezFpzj8
         5IODpBlcW3FXiandOEsfFpEKpLsDnuyfk/xvt355NAndYwXZVRXEeJTE/3ipNsXY8vjr
         QPVCzXdy1zspXb2ffSEmNKhTmwidnZ4yrzApfEWGCER394/jzyEyZn8lwyAllBK1o38U
         vVU9Kbpw7Bx402E1mKMqoKpZmOyrzFuGzU723rbveoBU3FUz2krjB3ZLVDzsilXgEKKs
         g2Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWQgCGvzJo1QCjWpKC9EV1Hi37XLb/5AKPQuyPHFK4Jt8mv8pZ16yC54ed/mtgV+ywslwj2QFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUjC+/vtDKS0w/l5CeMPHo4Zqx/MZSVcQiLGJrmHU4UrBgolP5
	vPLBXhLsfflHI9rsDqULPQ7x2Xn5iehcYjH0CyFJZDbJZj81bhaN1q40
X-Gm-Gg: ASbGncuWNilCJuBrl9ZJQgz5lQfaSmaADHPxE8iIsdPkTQOuOFj8KjRl0ujYJHytVkt
	LbD/MSdcEPW/1oEsktJfo/MVc7L5L9+wZX0UBlZlWsBykJ197p62WYuW4bdBLSssJFXIgpJ76Z4
	f3/yfrDx1eZlWQ+gyP9WC1AKQsOXEBG1b/IKIKJAeAT602+UBslBUjcd8fCHbJ+2Fw5unlJADGe
	rYt8tv6IJzIu8kDeu0BzyR2wrPaE+OmAIrp2c1SNGfXFav212EAoPKcRBaXETC+wzcjltMtHmum
	th4/BZKYYl0OSuaZ+iIizhM8VsdEAazcTeqe4Yjt7rDnlocVtbLelbyvN4g/ahTbo+nQa8rMERa
	/L60jsT7vMHqCil1KflVF
X-Google-Smtp-Source: AGHT+IEgSnjhccUb/qqaKCgTF/vTJb1tPNAnij/ZaPH4rExJiP7FP6dAUWLGY3zw/qJd7eG4tsHaig==
X-Received: by 2002:a05:690c:868f:10b0:73e:6140:684 with SMTP id 00721157ae682-76402e64d0cmr8865077b3.38.1758743408005;
        Wed, 24 Sep 2025 12:50:08 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:43::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-75210e5afa0sm21896787b3.3.2025.09.24.12.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:50:07 -0700 (PDT)
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
	netdev@vger.kernel.org
Subject: [PATCH net-next 6/9] selftests: drv-net: psp: add association tests
Date: Wed, 24 Sep 2025 12:49:52 -0700
Message-ID: <20250924194959.2845473-7-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924194959.2845473-1-daniel.zahka@gmail.com>
References: <20250924194959.2845473-1-daniel.zahka@gmail.com>
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
 tools/testing/selftests/drivers/net/psp.py    | 145 +++++++++++++++++-
 tools/testing/selftests/net/lib/py/ksft.py    |   5 +
 4 files changed, 150 insertions(+), 4 deletions(-)

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
index b4f8a32ccbbb..1c504975b07d 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -10,7 +10,7 @@ import termios
 import time
 
 from lib.py import ksft_run, ksft_exit, ksft_pr
-from lib.py import ksft_true, ksft_eq, ksft_ne, KsftSkipEx
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
@@ -229,7 +370,7 @@ def main() -> None:
                     for version in range(0, 4)
                     for ipver in ("4", "6")
                 ]
-                ksft_run(cases = cases, globs=globals(), case_pfx={"dev_", "data_"},
+                ksft_run(cases = cases, globs=globals(), case_pfx={"dev_", "data_", "assoc_"},
                          args=(cfg, ), skip_all=(cfg.psp_dev_id is None))
                 cfg.comm_sock.send(b"exit\0")
                 cfg.comm_sock.close()
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 375020d3edf2..d65dd087c549 100644
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


