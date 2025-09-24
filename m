Return-Path: <netdev+bounces-226085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3CFB9BC5C
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 21:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A9F1896C83
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 19:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E31274B5E;
	Wed, 24 Sep 2025 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv6BQMMN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7DF2727F3
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743414; cv=none; b=D6e0d98vQLYOB6PjVDTaxWrFNmU57BAKNR5ok/sZDqjtrhnAOO+9fAV+gBfPcXfYpye1M/fR6IoNdWprM4sSeLPbpVvITlbEo7ki2mNO15I+0GA8QQZkgr8nMfyU/0enBp/6k1cvCX02ghpvfNqIaS9FD6DpJsD2KWOuJQi36GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743414; c=relaxed/simple;
	bh=S6ymSA79RMwt17MQczFLI1TKdpUBDxzN+89lEXhVBQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOF2w6JYon9NtkyCm0zHkvWhfobWPNqq8IymLa9PFDmTTLFKxyQ++vnMAkeLozu6az5QLn27pigQq+g2JCv8XQ5HelRZfg5nNGsIwTSU06aw+39cKY0zqDeGvK6FRRetKjK0L64REQu3ovhAy9weSx+vXhQze8EnO5rD7798KjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mv6BQMMN; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e96e1c82b01so181932276.1
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758743412; x=1759348212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYLNBDG0NRlmzM4m8gS3v/gKeV3amcycvxjqyJSUjo4=;
        b=Mv6BQMMNMVk0zvVhehtHw1PczbHRSlc8n8eSL2EzacsLcrGWIEu9hrYtPdE9SZ3pC3
         meXQQyhkvzzLnxhSs44j6c+SEgJzrJOwBO/3RDoAHn+SifIiOmamISfUW2QYIjtb8Bbc
         hyzbjG1DJvDEXvQ1ZYWpy+qJ98y3V3B4RKdggub/oKhgmT/PQaXhnUsPWc4+8yVUZXhq
         p9KrJZsQVOfd40Z36spwaSd92aJBZj2GtJ7kJQV5DAV9N4BGnOxtG8tLmgfiqxWNK+j7
         X1yomBSqIImutirqOcCUTQfsBk+6v01BXJEdhoqepI8/87+QGXbmaChyuY8+DR5EzjeS
         fs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758743412; x=1759348212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYLNBDG0NRlmzM4m8gS3v/gKeV3amcycvxjqyJSUjo4=;
        b=hKqsapo99BuHBFl+VXr/8sxFhFPBUurBjeZqoE3/7VoUW1yiOx/ZOQ6kjOdFoB4yAj
         bGo3skYp17wyicAyemWyjIx4SO9zSca0Hye5TQ9VkdLNIq6I4jEBCzxlVZ0MgenWqmZ5
         nsO59Gf+JfxBOI+3ohfwcDJIf0fY0jpajn4wdSxOz836UU43mGTlr1/SrgfHe9esQDrI
         ldW01+/OhBIS4hMIzLlGB1hDXVhLapkKssVAQ+zsptLd907o1KlljJHm72Q8IgQWx20W
         IHu6UelZiB451uLwgo7cmxNxF2BkNQsy8GWNPZValFSLHT75iIA0mPyKGA/fO4GgibSQ
         bBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+e/43J1s65g51/Fa7Nm2P3I0XeBIzz4UVFk1WROCyDCF/yW8L+1x+nPdFshsHTcMdBcqQoD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFumVkkBvCX3G21gKT67BYr0t4OoVR2zymU7/rD6MGKRSvWLCb
	n+ruMj4UHMicuAgt0aDHKGXTW4FZSXctKbmzGAKzB3Qnd8Uo979zkrAB
X-Gm-Gg: ASbGnctCzJkCOUCxtgKXZlIg/8tZ/6NpBhjOqp+SRqLk9RU6aBtuTHThJw67kSBZSeP
	1YPASwBikiYHcAFjX1xHP47C/jXstWTlQOkYC/U1x8obL49lWINY4xdybY1uMFbjAnbtXxgAxFf
	IMYZjKs7i4VYh2JjdFYtqpxpVs0jQFwZSUi0S/HYW4Xn2goN6i/vg8j7LwlfckyxBQX3RL3s89e
	KliNwoHoQVkip3TcrbJQ7uTtcNA1jqSdXp5jY5AROKeZQBDpz+7vOw6cXwulsUngSwoussjRYLs
	W2iheuzer7EeT153xCEFzgGelIBJGYVINcZmJgqfLi9mw6jC2uArMMdIbxBwRBEoe1mY/4p3fXI
	y4A62lzuxkzuZdRVAIOE=
X-Google-Smtp-Source: AGHT+IGwXpljS88SJeGJJI0ul6IMSf2G2cNyQU2qalFmWCdkiuQdoes8B4yeD91INy1yeskEZh5zAg==
X-Received: by 2002:a05:6902:100e:b0:e9d:75c1:7584 with SMTP id 3f1490d57ef6-eb37fc0e113mr1329552276.15.1758743411681;
        Wed, 24 Sep 2025 12:50:11 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-eb37ebdb5b2sm339536276.20.2025.09.24.12.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:50:11 -0700 (PDT)
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
Subject: [PATCH net-next 9/9] selftests: drv-net: psp: add tests for destroying devices
Date: Wed, 24 Sep 2025 12:49:55 -0700
Message-ID: <20250924194959.2845473-10-daniel.zahka@gmail.com>
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

Add tests for making sure device can disappear while associations
exist. This is netdevsim-only since destroying real devices is
more tricky.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 .../drivers/net/hw/lib/py/__init__.py         |  2 +-
 .../selftests/drivers/net/lib/py/__init__.py  |  2 +-
 .../selftests/drivers/net/lib/py/env.py       |  5 ++
 tools/testing/selftests/drivers/net/psp.py    | 59 ++++++++++++++++++-
 tools/testing/selftests/net/lib/py/ksft.py    |  5 ++
 5 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 1c631f3c81f1..0ceb297e7757 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -22,7 +22,7 @@ try:
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
-        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt
+        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
     from net.lib.py import NetNSEnter
     from drivers.net.lib.py import GenerateTraffic
     from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 8a795eeb5051..2a645415c4ca 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -21,7 +21,7 @@ try:
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
-        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt
+        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
 except ModuleNotFoundError as e:
     ksft_pr("Failed importing `net` library from kernel sources")
     ksft_pr(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index c1f3b608c6d8..fc12e20af880 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -7,6 +7,7 @@ from lib.py import KsftSkipEx, KsftXfailEx
 from lib.py import ksft_setup, wait_file
 from lib.py import cmd, ethtool, ip, CmdExitFailure
 from lib.py import NetNS, NetdevSimDev
+from lib.py import KsftXfailEx
 from .remote import Remote
 
 
@@ -245,6 +246,10 @@ class NetDrvEpEnv(NetDrvEnvBase):
         if not self.addr_v[ipver] or not self.remote_addr_v[ipver]:
             raise KsftSkipEx(f"Test requires IPv{ipver} connectivity")
 
+    def require_nsim(self):
+        if self._ns is None:
+            raise KsftXfailEx("Test only works on netdevsim")
+
     def _require_cmd(self, comm, key, host=None):
         cached = self._required_cmd.get(comm, {})
         if cached.get(key) is None:
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index ee103b47568c..6a7f51801703 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -10,7 +10,7 @@ import termios
 import time
 
 from lib.py import ksft_run, ksft_exit, ksft_pr
-from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises, KsftSkipEx
+from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises, ksft_not_none, KsftSkipEx
 from lib.py import NetDrvEpEnv, PSPFamily, NlError
 from lib.py import bkg, rand_port, wait_port_listen
 
@@ -472,6 +472,61 @@ def data_stale_key(cfg):
         _close_psp_conn(cfg, s)
 
 
+def __nsim_psp_rereg(cfg):
+    # The PSP dev ID will change, remember what was there before
+    before = set([x['id'] for x in cfg.pspnl.dev_get({}, dump=True)])
+
+    cfg._ns.nsims[0].dfs_write('psp_rereg', '1')
+
+    after = set([x['id'] for x in cfg.pspnl.dev_get({}, dump=True)])
+
+    new_devs = list(after - before)
+    ksft_eq(len(new_devs), 1)
+    cfg.psp_dev_id = list(after - before)[0]
+
+
+def removal_device_rx(cfg):
+    """ Test removing a netdev / PSD with active Rx assoc """
+
+    # We could technically devlink reload real devices, too
+    # but that kills the control socket. So test this on
+    # netdevsim only for now
+    cfg.require_nsim()
+
+    s = _make_clr_conn(cfg)
+    try:
+        rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                       "dev-id": cfg.psp_dev_id,
+                                       "sock-fd": s.fileno()})
+        ksft_not_none(rx_assoc)
+
+        __nsim_psp_rereg(cfg)
+    finally:
+        _close_conn(cfg, s)
+
+
+def removal_device_bi(cfg):
+    """ Test removing a netdev / PSD with active Rx/Tx assoc """
+
+    # We could technically devlink reload real devices, too
+    # but that kills the control socket. So test this on
+    # netdevsim only for now
+    cfg.require_nsim()
+
+    s = _make_clr_conn(cfg)
+    try:
+        rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                       "dev-id": cfg.psp_dev_id,
+                                       "sock-fd": s.fileno()})
+        cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                            "version": 0,
+                            "tx-key": rx_assoc['rx-key'],
+                            "sock-fd": s.fileno()})
+        __nsim_psp_rereg(cfg)
+    finally:
+        _close_conn(cfg, s)
+
+
 def psp_ip_ver_test_builder(name, test_func, psp_ver, ipver):
     """Build test cases for each combo of PSP version and IP version"""
     def test_case(cfg):
@@ -531,7 +586,7 @@ def main() -> None:
                     ipver_test_builder("data_mss_adjust", _data_mss_adjust, ipver)
                     for ipver in ("4", "6")
                 ]
-                ksft_run(cases = cases, globs=globals(), case_pfx={"dev_", "data_", "assoc_"},
+                ksft_run(cases = cases, globs=globals(), case_pfx={"dev_", "data_", "assoc_", "removal_"},
                          args=(cfg, ), skip_all=(cfg.psp_dev_id is None))
                 cfg.comm_sock.send(b"exit\0")
                 cfg.comm_sock.close()
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index d65dd087c549..43b40a027f5e 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -72,6 +72,11 @@ def ksft_true(a, comment=""):
         _fail("Check failed", a, "does not eval to True", comment)
 
 
+def ksft_not_none(a, comment=""):
+    if a is None:
+        _fail("Check failed", a, "is None", comment)
+
+
 def ksft_in(a, b, comment=""):
     if a not in b:
         _fail("Check failed", a, "not in", b, comment)
-- 
2.47.3


