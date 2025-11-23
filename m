Return-Path: <netdev+bounces-241020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D343AC7DA54
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 01:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACB56352285
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 00:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA642066F7;
	Sun, 23 Nov 2025 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="kdXPwxm7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533B1FC0EA
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763859078; cv=none; b=CJRm/zb6mTXWcngwKKjp+3mPr69+TtBy5pvikng6VQs64J2RL5WWNsitxXbJyN4ICvFYD/Djglrdq/HN23D8JAGL2mpbMAbzVhKSX56ZVM8MEwMkIML0u/pHXCW5V6yk9T5LkGz1UPjBglI1fM6hoh3VtTyzgTyZGj6I9Fb9VLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763859078; c=relaxed/simple;
	bh=BJWw79SNQTpEwJchw0lDv3P6kU2j0w6Sbd4qYKL+UEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AD5zMQpHZ7Mn0y/brZKPjzhYT6iEz3x5ZfnrIaP637nZmyXGAbL0zuX6IYqsUAw2SQXGKmB8EBmGQdDOsnWGVFra31SAx8H5GdmvYBr89IcakI7dfMFU3w88Bp0sz+pAkz4D5o51OIwcuRMvOXfOyDRpjAWIy6g89y4Nh2jBAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=kdXPwxm7; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c6da5e3353so2299924a34.3
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 16:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763859075; x=1764463875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIxUklYyyxeOGaDCr4JD24898UYhaEcYPabUk0ilclE=;
        b=kdXPwxm7gUOFumUIWqijJRazQrrNvaWm7H8zqf2KD2B0d6M4BlXej7faM5f4cpKWNO
         LyYRybc1pLdXdqU4z7q3Xiik+RIDwGI4eSWC8EefyMhvJ/Vm8AkdSu8LrIpq1ytUmlam
         UrNsa2V+AGlucJsDlG79Wu9kzRyzZfQiGGuTCso1JIptWbLB0HddJ/5NRsdiQCBjxshl
         Oab2zfjv5IULl5XNOs+5GNeKnRCh/7yI0mfxw//gkltGldXY3yWz9Rj8Iunqaez52WTw
         lPkDirYgCWk6797178bGSbziKlY2hgC4U+OawNdYxTvfdfUV48ugjf71KDCvE36rWXR0
         kNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763859075; x=1764463875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xIxUklYyyxeOGaDCr4JD24898UYhaEcYPabUk0ilclE=;
        b=MIpt5bAfEoTQXB+LMSVIHnq2TrcUc61F//bZwm2Ruvg89IQhmq1pFSTKU1PKiq1YF6
         WqiEsoNjGBHHnAkGS7a75qjmgjsVJdEYfrdPC6inGhKuuAYiU30c94WgZmBDUPDzEGLa
         gQh+Kua4AP+Az5AOqTwb+2/C4OzE6hSNZi8FVVeF0FOCug1eADPtqGbrWNmly6WnVceQ
         DxdeKXc2m5RATqLbYeX/Wl4JOrbc+RikWsu8+RxHEKv6XAbQS/DOsu7/TlmNRyRiAIIm
         PqnitpOCnHsuujQBZqhQTgPcJ84Lc8y8FAemBRk0kumKWJibxFJq6K68wbsDYidEutMk
         RBhA==
X-Gm-Message-State: AOJu0YxRTP0AFKtMJlh76wDOLnjWVC0l6z7NwDx/RtxnbFLkfQEDAB9Q
	k3oVHFySIvKOalHxwpDX+GoHl8HQQwVLkIgjOyURP3AvUPP6ugWqO1ieX3QIXT/LYR+T12kBnfv
	qJKp4
X-Gm-Gg: ASbGncv+pyDiVjnCNjA2yPBAwW2QXOHpv7JzP318PBz2oP0H0VhqGBhUGW/DNOd0DpM
	ZpO7eqZUeqIOs0qU0z1bSXgYDiyZGuj2HIkfkjCQXvcMweMga3ah03dDp3EubKK3+kOrMwyKnD/
	GtmUTy+8iSLehwZnUX1SsQQbobPOjMi1N014JcToz8kqLMeJPrkhAJ66PYQVq3plG8XRCMxqsoF
	X2sSJgCtVmfYlcQ+igMlparpVvImt1tJDYN3bsPUBPze/mGgzm//FHh9ZYfAPbYvkcEueX8q8C5
	ynY5JUTSzyB7mi9ItMLrwMC5TAPNEckDAqHwiUmcTQrQze7TeR3YaCCJEP1KVjNTGReEGeD/m1+
	c7usJJbmw/YZis4N5vrXNmN5id5SmHXkCw+yQKsYGRkYAmA1iKjrNPzK6n9T3p1lUddeE0EDI5U
	C3OhIJJcCDA7YJ8cn7jXVhHm0YZRP+519DpXBE0BAb
X-Google-Smtp-Source: AGHT+IGyi1KG9gShu7/CmA1R90Jy2saO8lHssywVP5AiADYVYqTSlcpLgOm2V64YVnx6fDRlqysDug==
X-Received: by 2002:a05:6830:4117:b0:7c7:8a3c:77a7 with SMTP id 46e09a7af769-7c798cbc254mr2958577a34.18.1763859075515;
        Sat, 22 Nov 2025 16:51:15 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:9::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d3ff21fsm3815252a34.20.2025.11.22.16.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 16:51:15 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v2 4/5] selftests/net: add env for container based tests
Date: Sat, 22 Nov 2025 16:51:07 -0800
Message-ID: <20251123005108.3694230-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251123005108.3694230-1-dw@davidwei.uk>
References: <20251123005108.3694230-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an env NetDrvContEnv for container based selftests. This automates
the setup of a netns, netkit pair with one inside the netns, and a bpf
prog that forwards skbs from the NETIF host inside the container.

Currently only netkit is used, but other virtual netdevs e.g. veth can
be used too.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 .../drivers/net/hw/lib/py/__init__.py         |   5 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   5 +-
 .../selftests/drivers/net/lib/py/env.py       | 105 +++++++++++++++++-
 3 files changed, 110 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 0c61debf86fb..faa15710076a 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -3,6 +3,7 @@
 """
 Driver test environment (hardware-only tests).
 NetDrvEnv and NetDrvEpEnv are the main environment classes.
+NetDrvContEnv extends NetDrvEpEnv with netkit container support.
 Former is for local host only tests, latter creates / connects
 to a remote endpoint. See NIPA wiki for more information about
 running and writing driver tests.
@@ -29,7 +30,7 @@ try:
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
     from drivers.net.lib.py import GenerateTraffic, Remote
-    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
+    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
 
     __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
                "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
@@ -44,7 +45,7 @@ try:
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none",
-               "NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote"]
+               "NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic", "Remote"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index d9d035634a31..c8075e5dc4ab 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -3,6 +3,7 @@
 """
 Driver test environment.
 NetDrvEnv and NetDrvEpEnv are the main environment classes.
+NetDrvContEnv extends NetDrvEpEnv with netkit container support.
 Former is for local host only tests, latter creates / connects
 to a remote endpoint. See NIPA wiki for more information about
 running and writing driver tests.
@@ -43,11 +44,11 @@ try:
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none"]
 
-    from .env import NetDrvEnv, NetDrvEpEnv
+    from .env import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
     from .load import GenerateTraffic
     from .remote import Remote
 
-    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote"]
+    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic", "Remote"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 4004d1a3c82e..a96b36ceba36 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -1,11 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 
+import ipaddress
 import os
+import re
 import time
 from pathlib import Path
 from lib.py import KsftSkipEx, KsftXfailEx
 from lib.py import ksft_setup, wait_file
-from lib.py import cmd, ethtool, ip, CmdExitFailure
+from lib.py import cmd, ethtool, ip, CmdExitFailure, bpftool
 from lib.py import NetNS, NetdevSimDev
 from .remote import Remote
 
@@ -286,3 +288,104 @@ class NetDrvEpEnv(NetDrvEnvBase):
                 data.get('stats-block-usecs', 0) / 1000 / 1000
 
         time.sleep(self._stats_settle_time)
+
+
+class NetDrvContEnv(NetDrvEpEnv):
+    """
+    Class for an environment with a netkit pair setup for forwarding traffic
+    between the physical interface and a network namespace.
+    """
+
+    def __init__(self, src_path, nk_rxqueues=1, **kwargs):
+        super().__init__(src_path, **kwargs)
+
+        self.require_ipver("6")
+        local_prefix = self.env.get("LOCAL_PREFIX_V6")
+        if not local_prefix:
+            raise KsftSkipEx("LOCAL_PREFIX_V6 required")
+
+        local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
+        self.ipv6_prefix = f"{local_prefix}::"
+        self.nk_host_ipv6 = f"{local_prefix}::2:1"
+        self.nk_guest_ipv6 = f"{local_prefix}::2:2"
+
+        self.netns = None
+        self._nk_host_ifname = None
+        self._nk_guest_ifname = None
+        self._tc_attached = False
+        self._bpf_prog_id = None
+
+        ip(f"link add type netkit mode l2 forward peer forward numrxqueues {nk_rxqueues}")
+
+        all_links = ip("-d link show", json=True)
+        netkit_links = [link for link in all_links
+                        if link.get('linkinfo', {}).get('info_kind') == 'netkit'
+                        and 'UP' not in link.get('flags', [])]
+
+        if len(netkit_links) != 2:
+            raise KsftSkipEx("Failed to create netkit pair")
+
+        netkit_links.sort(key=lambda x: x['ifindex'])
+        self._nk_host_ifname = netkit_links[0]['ifname']
+        self._nk_guest_ifname = netkit_links[1]['ifname']
+        self.nk_host_ifindex = netkit_links[0]['ifindex']
+
+        self.netns = NetNS()
+        ip(f"link set dev {self._nk_guest_ifname} netns {self.netns.name}")
+        ip(f"link set dev {self._nk_host_ifname} up")
+        ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
+        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self._nk_host_ifname}")
+
+        ip("link set lo up", ns=self.netns)
+        ip(f"link set dev {self._nk_guest_ifname} up", ns=self.netns)
+        ip(f"-6 addr add fe80::2/64 dev {self._nk_guest_ifname}", ns=self.netns)
+        ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifname} nodad", ns=self.netns)
+        ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname}", ns=self.netns)
+
+        bpf_obj = self.test_dir / "nk_forward.bpf.o"
+        if not bpf_obj.exists():
+            raise KsftSkipEx("BPF prog not found")
+
+        cmd(f"tc filter add dev {self.ifname} ingress bpf obj {bpf_obj} sec tc/ingress direct-action")
+        self._tc_attached = True
+
+        tc_info = cmd(f"tc filter show dev {self.ifname} ingress").stdout
+        match = re.search(r'id (\d+)', tc_info)
+        if not match:
+            raise Exception("Failed to get BPF prog ID")
+        self._bpf_prog_id = int(match.group(1))
+
+        prog_info = bpftool(f"prog show id {self._bpf_prog_id}", json=True)
+        map_ids = prog_info.get("map_ids", [])
+
+        bss_map_id = None
+        for map_id in map_ids:
+            map_info = bpftool(f"map show id {map_id}", json=True)
+            if map_info.get("name").endswith("bss"):
+                bss_map_id = map_id
+
+        if bss_map_id is None:
+            raise Exception("Failed to find .bss map")
+
+        ipv6_addr = ipaddress.IPv6Address(self.ipv6_prefix)
+        ipv6_bytes = ipv6_addr.packed
+        ifindex_bytes = self.nk_host_ifindex.to_bytes(4, byteorder='little')
+        value = ipv6_bytes + ifindex_bytes
+        value_hex = ' '.join(f'{b:02x}' for b in value)
+        bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value hex {value_hex}")
+
+    def __del__(self):
+        if self._tc_attached:
+            cmd(f"tc filter del dev {self.ifname} ingress").stdout
+            self._tc_attached = False
+
+        if self._nk_host_ifname:
+            cmd(f"ip link del dev {self._nk_host_ifname}")
+            self._nk_host_ifname = None
+            self._nk_guest_ifname = None
+
+        if self.netns:
+            del self.netns
+            self.netns = None
+
+        super().__del__()
-- 
2.47.3


