Return-Path: <netdev+bounces-240262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74678C71FDB
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B08552B462
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3C02F12AD;
	Thu, 20 Nov 2025 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="UmXKitDC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3CF288C3F
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609423; cv=none; b=HNssirVqpQ/sLzEWA43Oz6FGcZUSb/WOz/GuqLRFEAaUz+FYiaTTNn/aUoLY43AqWHrYDXVj2Ra1sFq0XRBxnoQwSqDqaL+ZoTc6Scno0YprEo9EvftfmowACVzk77fvSgSTfHvH9+8T0J0ouuI6GKpphXweeQ7h5Tsru4/aEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609423; c=relaxed/simple;
	bh=ySawGTvxs/UaFewtHhec2+vSL1O+/OIWnM/pbD6VjzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfnKRwrATC3V9takObqY2CPqoOg0hr/kWkdyOnW9G31CrrW16UU+OGbh+JJVc05UAsljWxHT0NwshDbnbt6aI3VCu2KpldDsy9WBTVAZOmSZtpYvkGCqOcrSFzXux9h7i/WGWGGBD/BrQBQhY+6EkDqioUNNpKRWgWH5m2uwh10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=UmXKitDC; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-656d9230cf2so199793eaf.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763609421; x=1764214221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq0p8NYoV2syzmIGUeemn/h6f3PRyLkgd0xNcMeR4N0=;
        b=UmXKitDC9PzH+LQDCFbRxMLPRnDnJj5Ye1t+P0dlGGtaPja3z3N8dcaBs+VR4RmvVb
         D9Nhyt4H70mz0qoOjmCDRhLd+E+DXWJ3sW7Pvx7R2E1mkxUtW6XeGrc+XSRlfQgjWHrG
         RhVHp3F6kBngDvUbcMqd6v48bg7oG7KQ1td8KGx89kbgqeUglaU1wb/xsw5QBviTlEOJ
         td4IsBDFzW6rLDUxf4tdJl5cAdgV5kcF+SyojQuqrjSFRZbTNhrY/MiLudUVVBN/oclU
         LiBzkrpyeJCCvYOdOJ0j9HPvT4Y9LeiN5f3iY7VHDRtj0pdSb46jTg8PGR1/un6uM3SK
         i5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763609421; x=1764214221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aq0p8NYoV2syzmIGUeemn/h6f3PRyLkgd0xNcMeR4N0=;
        b=CqT2YhowjBgDT2X8skKagjhH8bU2hkgg6Ch0dJUAGZVzYRoTnhnl5GOVVbxF6xR+O+
         09Mz59iSLTAQCD7c09wMX37Pc2h7kD2zubdj9QxZ3fEK524uO2A+SznD+ztbOVnNBJt3
         O470YwSGRzxQT3WpNs4bLufc6PU7IKsUXe2mVVJdNNO6802yksh5QbePRY0738d/tv85
         ZTjIC2yw9ri7SxCkSkVYFODG0cM77CnFyg6lWSrfidYRvmP7T0J7apzTZ0U5cqzIvBrH
         42FNjgonYyz6tA8wEA4do62r/Cu+IuzFGTWtUlGzOB/J+fXmcoF5e82KO5WmAU4WoNky
         u73A==
X-Gm-Message-State: AOJu0YxzgchchrzstV9b4YhTR5BKyiDgWrjzfDsd1oraG7lC7NjV6XAt
	rDwKx3J3JshGv7lJxifuXFZk1dphn9t7AJ4iVr/S7vIBm2I4raS7k2ka/F7Fr6lNiNTg/358heH
	egHuK
X-Gm-Gg: ASbGncubaQemiHQu3MMvAHux56/GQgctrXO2CskY0aziIIPsr2yWDWm72Utt8gmSnX8
	huJXrv3iMYfOBX59arOP4kIbCDkzxMEg2Q53PIZ2YomUB8dct0ud9BypBph2EXkQIc0/eUOkfhZ
	qjIWRxeuDI9GcveZhmbRcXNYIyYHYqVqTyY3rcdPCG3ByOO6/lf9p75OeKb6nK7R3PgVdjU1fzI
	YXfVvxfZWmv3zm6j0GAmsOzyLpSI+cEBP4Rf8SisTLP4RdDrVUPUywdA6F2nS/e9FmZe7DT4GBj
	bZpgmFBZfsYXppmLgGAopFX1u4G6QItg5W1WZd0DHigMgVs649Q3tAnBMaaOWmTmxxp+e6PxKO+
	Zlr3U8qqszuFLPUAddrYNPYNV+h9ibEuyDjunIuT1Ca0NWXIvshfaPEMAPN03Z5btYd9B/p6jOo
	edqGgQw26+Ig5kAwdcdyE1+viF7g3EtNn7MEnzNOgW
X-Google-Smtp-Source: AGHT+IFNXrDDaJ4ciiMQtIyJNXXhWcZ8Z/mtqEjY6nd+dOPARIu+h9NV3cNYIbIgJvksS6Aw0DG11w==
X-Received: by 2002:a05:6808:3093:b0:450:d0d8:aed0 with SMTP id 5614622812f47-450ff34a946mr852820b6e.40.1763609420701;
        Wed, 19 Nov 2025 19:30:20 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:5::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450fffed315sm377762b6e.21.2025.11.19.19.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 19:30:20 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v1 2/7] selftests/net: add MemPrvEnv env
Date: Wed, 19 Nov 2025 19:30:11 -0800
Message-ID: <20251120033016.3809474-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120033016.3809474-1-dw@davidwei.uk>
References: <20251120033016.3809474-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory provider HW selftests (i.e. zcrx, devmem) require setting up a
netdev with e.g. flow steering rules. Add a new MemPrvEnv that sets up
the test env, restoring it to the original state prior to the test. This
also speeds up tests since each individual test case don't need to
repeat the setup/teardown.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 .../drivers/net/hw/lib/py/__init__.py         |  5 +-
 .../selftests/drivers/net/lib/py/__init__.py  |  4 +-
 .../selftests/drivers/net/lib/py/env.py       | 71 ++++++++++++++++++-
 3 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index fb010a48a5a1..09f120be9075 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -29,7 +29,7 @@ try:
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
     from drivers.net.lib.py import GenerateTraffic, Remote
-    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
+    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, MemPrvEnv
 
     __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
                "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
@@ -44,7 +44,8 @@ try:
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none",
-               "NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote"]
+               "GenerateTraffic", "Remote",
+               "NetDrvEnv", "NetDrvEpEnv", "MemPrvEnv"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index b0c6300150fb..dde4e80811c7 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -43,11 +43,11 @@ try:
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none"]
 
-    from .env import NetDrvEnv, NetDrvEpEnv
+    from .env import NetDrvEnv, NetDrvEpEnv, MemPrvEnv
     from .load import GenerateTraffic
     from .remote import Remote
 
-    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote"]
+    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "MemPrvEnv", "GenerateTraffic", "Remote"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 01be3d9b9720..3e19b57ef5e0 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -1,12 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import os
+import re
 import time
 from pathlib import Path
 from lib.py import KsftSkipEx, KsftXfailEx
 from lib.py import ksft_setup, wait_file
-from lib.py import cmd, ethtool, ip, CmdExitFailure
+from lib.py import cmd, ethtool, ip, rand_port, CmdExitFailure
 from lib.py import NetNS, NetdevSimDev
+from lib.py import EthtoolFamily
 from .remote import Remote
 
 
@@ -283,3 +285,70 @@ class NetDrvEpEnv(NetDrvEnvBase):
                 data.get('stats-block-usecs', 0) / 1000 / 1000
 
         time.sleep(self._stats_settle_time)
+
+
+class MemPrvEnv(NetDrvEpEnv):
+    def __init__(self, src_path, rss=False, rss_num=1, **kwargs):
+        super().__init__(src_path, False, **kwargs)
+
+        self.ethnl = EthtoolFamily()
+        self.cleaned_up = False
+
+        channels = self.ethnl.channels_get({'header': {'dev-index': self.ifindex}})
+        self.channels = channels['combined-count']
+        if self.channels < 2:
+            raise KsftSkipEx('Test requires NETIF with at least 2 combined channels')
+
+        if rss and rss_num > self.channels - 1:
+            raise KsftSkipEx(f"Test with {rss_num} queues in RSS context requires NETIF with at least {rss_num + 1} combined channels")
+
+        self.port = rand_port()
+        rings = self.ethnl.rings_get({'header': {'dev-index': self.ifindex}})
+        self.rx_rings = rings['rx']
+        self.hds_thresh = rings.get('hds-thresh', 0)
+        self.ethnl.rings_set({'header': {'dev-index': self.ifindex},
+                              'tcp-data-split': 'enabled',
+                              'hds-thresh': 0,
+                              'rx': 64})
+
+        if rss:
+            self.target_queue = self.channels - rss_num
+            ethtool(f"-X {self.ifname} equal {self.target_queue}")
+            self.rss_ctx_id = self._create_rss_ctx(rss_num)
+            self.rule_id = self._set_rss_flow_rule()
+        else:
+            self.target_queue = self.channels - 1
+            ethtool(f"-X {self.ifname} equal {self.target_queue}")
+            self.rss_ctx_id = None
+            self.rule_id = self._set_flow_rule()
+
+    def __del__(self):
+        if self.cleaned_up:
+            return
+
+        ethtool(f"-N {self.ifname} delete {self.rule_id}")
+        if self.rss_ctx_id:
+            self.ethnl.rss_delete_act({'header': {'dev-index': self.ifindex},
+                                       'context': self.rss_ctx_id})
+
+        ethtool(f"-X {self.ifname} default")
+        self.ethnl.rings_set({'header': {'dev-index': self.ifindex},
+                              'tcp-data-split': 'unknown',
+                              'hds-thresh': self.hds_thresh,
+                              'rx': self.rx_rings})
+        self.cleaned_up = True
+
+    def _set_flow_rule(self):
+        output = ethtool(f"-N {self.ifname} flow-type tcp6 dst-port {self.port} action {self.target_queue}").stdout
+        values = re.search(r'ID (\d+)', output).group(1)
+        return int(values)
+
+    def _set_rss_flow_rule(self):
+        output = ethtool(f"-N {self.ifname} flow-type tcp6 dst-port {self.port} context {self.rss_ctx_id}").stdout
+        values = re.search(r'ID (\d+)', output).group(1)
+        return int(values)
+
+    def _create_rss_ctx(self, num):
+        output = ethtool(f"-X {self.ifname} context new start {self.target_queue} equal {num}").stdout
+        values = re.search(r'New RSS context is (\d+)', output).group(1)
+        return int(values)
-- 
2.47.3


