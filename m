Return-Path: <netdev+bounces-264510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULG6IPzIqWkAFAEAu9opvQ
	(envelope-from <netdev+bounces-264510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:18:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 846D1216E86
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FEBB300BEA6
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 18:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62193CB2CC;
	Thu,  5 Mar 2026 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="otMLtGR7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F81F3DA5DD
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772734707; cv=none; b=agLMXRo5gbCeo6LOKbJFDfj0Mfxavv39pPBB+cC3Slxh27GLJqIMDPnKe2HXFmI8/+PzgCPnDfTmXJfEFvN1cAa0jZC9HRy7C28jvb4PwVPkBLfIX+88XW1Q3+DlwOuaB1a98prqLAobCCnucUvXKXoRVx+ma4hET/ZxXw8uGac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772734707; c=relaxed/simple;
	bh=H1kS2zdqqQG7s6WE5V/jMLaRo63Cc0UV8+Kezmp9/nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Llux04QPTMOPgCq3CX/LPck4VM3VgsfIajOgPErONRUdcIC0ZaSyOzkvvr2Md1ZZDuy1SeI1bPT2zRbgKfkkkpn5KfG2XOW4k297SFmlcbjc8UwsbhLq9rqAvinh+zzEeyztt2S/9mlDkYlXZ/Jw4HuTLfSoDxQ0oRRMxaTyiAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=otMLtGR7; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-463960df4f9so5645769b6e.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 10:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1772734705; x=1773339505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8sLWoUtw5zL5625qxPedhg0rZ4NBw1tkvP7a1gmN6o=;
        b=otMLtGR7Om1qLzEgI/lld3iG6pdsojsuOCIc9X5Azs208FjKbQg+VDG1JJMVs7/Zv0
         8IFcQvUvnyKsqbQxll0YBgSWKstabWtWtRElozNxgLZkz0yhIjSwMqFZeNusSSRKyc+V
         wA3hOBQ+JLTJpI0yacNMdt4f7DMcEVueWmD3o8l246eOW4zyNT/DPQdfbaJAC5jqD3XL
         YWgLbidd/KepyitCE1nfqMJJE/Kdj4Z+gGYx/4hrPgQYc9Iu56MAUzt1T+t6u2CZxGMI
         3ggu7PzHYuDOAK50DrmYEkfePZvYpKP3j9B9AG9QBjsM14yW43e83EDhw6aTjDETTCgy
         K5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772734705; x=1773339505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H8sLWoUtw5zL5625qxPedhg0rZ4NBw1tkvP7a1gmN6o=;
        b=vipj/yfoG03gZSr061Vxr40AEK/btpSGIj3483Ox4C2QZ9Puoh58inHkLTra8TFdYX
         ACwqgNjokSYEIvTK+Bl9QRote62Rtz4Aue10R+m68RVmRJ+/dIHBVlM8zygoENT1zkhx
         yMr+5VC4+qFoyoD15CxIM5eKGphshB2H93X5YeWtN16/bVM1c4oO/VsnIxVB1QdyBHlK
         i8QV+9Hnnh6nYkMReaGEAS9eWaAHQQ8H1xECzKXSjMF75BAF97rw+Fy/lZVAxgFo3KmU
         KryC7m14yIpBoWBFJ4OtySYAVkxfru1bTdPx5dHYMuPqLBdFjsDDEN3W3QIhA61VNdkB
         qojg==
X-Gm-Message-State: AOJu0YwWMIbUPemq64W+2DoA/JZlLvkXaUgB89B1b+6h+Y3ag+ckmKOp
	gf/tOy8FPvKXhu1GvccB5bBVXWncpzpQnrsnZRL6mevYmtd6kYz8DYYFZkmhJ9vs/budfbogLLv
	1Mq4Q
X-Gm-Gg: ATEYQzyomZf+DihACiODrOJk5gCP70NjQEBXwHUzm74b39YG33JPA7mmQQUf7VGcHiG
	IbuehESA8ax0eowtgGtC7kVagHaX7LjbrlwA3txGTe7nmNjQ6nJhd3buTT5LFFyDS+X4Tu+UgvX
	DhkkX1yB/fZvTZIpMJU3ZXPzrl0E57IB/H2rBKhvMeOFz70Bgyz5+qE+0gPtYyJPJPlltH8W5/F
	SJTCJHhtX84ia7f1ooQdV+LBl1w+uSxkcxYseCi9JHbne+PG9gSkt9LEXWkEm/EBmSpHs722nZf
	4Q1Ds5LXwi0z/jy5QGVtJzjeeDtvl4j0mM6QtifwgLp37+duZB3o0AUatOc/IHJ2e7pa58VlqXC
	nxR1U9zubm5VEHk6GjZDugJjRshsfcY4YUTnSqpFJ4t6wMYT8OFq4H7z/8uapoHanQAV1d/z87s
	wszlMHSTPhl+qnD5f4K38x6QihWxuI2HA/6DoZ/AxO3Q==
X-Received: by 2002:a05:6808:344b:b0:45e:e15e:4ab2 with SMTP id 5614622812f47-4651ad1d690mr4053489b6e.45.1772734704819;
        Thu, 05 Mar 2026 10:18:24 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:46::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb3ab3e5sm13831660b6e.6.2026.03.05.10.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:18:23 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>,
	Wei Wang <weibunny@meta.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next v3 3/4] selftests/net: Add env for container based tests
Date: Thu,  5 Mar 2026 10:18:02 -0800
Message-ID: <20260305181803.2912736-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305181803.2912736-1-dw@davidwei.uk>
References: <20260305181803.2912736-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 846D1216E86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[davidwei.uk];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	TAGGED_FROM(0.00)[bounces-264510-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Add an env NetDrvContEnv for container based selftests. This automates
the setup of a netns, netkit pair with one inside the netns, and a BPF
program that forwards skbs from the NETIF host inside the container.

Currently only netkit is used, but other virtual netdevs e.g. veth can
be used too.

Expect netkit container datapath selftests to have a publicly routable
IP prefix to assign to netkit in a container, such that packets will
land on eth0. The BPF skb forward program will then forward such packets
from the host netns to the container netns.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../testing/selftests/drivers/net/README.rst  |  38 ++++
 .../drivers/net/hw/lib/py/__init__.py         |   7 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   7 +-
 .../selftests/drivers/net/lib/py/env.py       | 207 ++++++++++++++++++
 4 files changed, 253 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index dc70a69ee885..c94992acf10b 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -66,6 +66,44 @@ LOCAL_V4, LOCAL_V6, REMOTE_V4, REMOTE_V6
 
 Local and remote endpoint IP addresses.
 
+LOCAL_PREFIX_V6
+~~~~~~~~~~~~~~~
+
+Local IP prefix/subnet which can be used to allocate extra IP addresses (for
+network name spaces behind macvlan, veth, netkit devices). DUT must be
+reachable using these addresses from the endpoint.
+
+LOCAL_PREFIX_V6 must NOT match LOCAL_V6.
+
+Example:
+  NETIF           = "eth0"
+  LOCAL_V6        = "2001:db8:1::1"
+  REMOTE_V6       = "2001:db8:1::2"
+  LOCAL_PREFIX_V6 = "2001:db8:2::0/64"
+
+          +-----------------------------+        +------------------------------+
+  dst     | INIT NS                     |        | TEST NS                      |
+  2001:   | +---------------+           |        |                              |
+  db8:2::2| | NETIF         |           |  bpf   |                              |
+      +---|>| 2001:db8:1::1 |           |redirect| +-------------------------+  |
+      |   | |               |-----------|--------|>| Netkit                  |  |
+      |   | +---------------+           | _peer  | | nk_guest                |  |
+      |   | +-------------+ Netkit pair |        | | fe80::2/64              |  |
+      |   | | Netkit      |.............|........|>| 2001:db8:2::2/64        |  |
+      |   | | nk_host     |             |        | +-------------------------+  |
+      |   | | fe80::1/64  |             |        |                              |
+      |   | +-------------+             |        | route:                       |
+      |   |                             |        |   default                    |
+      |   | route:                      |        |     via fe80::1 dev nk_guest |
+      |   |   2001:db8:2::2/128         |        +------------------------------+
+      |   |     via fe80::2 dev nk_host |
+      |   +-----------------------------+
+      |
+      |   +---------------+
+      |   | REMOTE        |
+      +---| 2001:db8:1::2 |
+          +---------------+
+
 REMOTE_TYPE
 ~~~~~~~~~~~
 
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 1971577d47e9..b8d9ae282390 100644
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
@@ -30,7 +31,7 @@ try:
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
     from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
-    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
+    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
 
     __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
                "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
@@ -45,8 +46,8 @@ try:
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none",
-               "NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote",
-               "Iperf3Runner"]
+               "NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
+               "Remote", "Iperf3Runner"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index e5ef5e949c12..374d4f08dd05 100644
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
@@ -43,12 +44,12 @@ try:
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none"]
 
-    from .env import NetDrvEnv, NetDrvEpEnv
+    from .env import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
     from .load import GenerateTraffic, Iperf3Runner
     from .remote import Remote
 
-    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote",
-                "Iperf3Runner"]
+    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
+                "Remote", "Iperf3Runner"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 41cc248ac848..ccff345fe1c1 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -1,13 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0
 
+import ipaddress
 import os
 import time
+import json
 from pathlib import Path
 from lib.py import KsftSkipEx, KsftXfailEx
 from lib.py import ksft_setup, wait_file
 from lib.py import cmd, ethtool, ip, CmdExitFailure
 from lib.py import NetNS, NetdevSimDev
 from .remote import Remote
+from . import bpftool, RtnlFamily, Netlink
 
 
 class NetDrvEnvBase:
@@ -289,3 +292,207 @@ class NetDrvEpEnv(NetDrvEnvBase):
                 data.get('stats-block-usecs', 0) / 1000 / 1000
 
         time.sleep(self._stats_settle_time)
+
+
+class NetDrvContEnv(NetDrvEpEnv):
+    """
+    Class for an environment with a netkit pair setup for forwarding traffic
+    between the physical interface and a network namespace.
+      NETIF           = "eth0"
+      LOCAL_V6        = "2001:db8:1::1"
+      REMOTE_V6       = "2001:db8:1::2"
+      LOCAL_PREFIX_V6 = "2001:db8:2::0/64"
+
+              +-----------------------------+        +------------------------------+
+      dst     | INIT NS                     |        | TEST NS                      |
+      2001:   | +---------------+           |        |                              |
+      db8:2::2| | NETIF         |           |  bpf   |                              |
+          +---|>| 2001:db8:1::1 |           |redirect| +-------------------------+  |
+          |   | |               |-----------|--------|>| Netkit                  |  |
+          |   | +---------------+           | _peer  | | nk_guest                |  |
+          |   | +-------------+ Netkit pair |        | | fe80::2/64              |  |
+          |   | | Netkit      |.............|........|>| 2001:db8:2::2/64        |  |
+          |   | | nk_host     |             |        | +-------------------------+  |
+          |   | | fe80::1/64  |             |        |                              |
+          |   | +-------------+             |        | route:                       |
+          |   |                             |        |   default                    |
+          |   | route:                      |        |     via fe80::1 dev nk_guest |
+          |   |   2001:db8:2::2/128         |        +------------------------------+
+          |   |     via fe80::2 dev nk_host |
+          |   +-----------------------------+
+          |
+          |   +---------------+
+          |   | REMOTE        |
+          +---| 2001:db8:1::2 |
+              +---------------+
+    """
+
+    def __init__(self, src_path, rxqueues=1, **kwargs):
+        self.netns = None
+        self._nk_host_ifname = None
+        self._nk_guest_ifname = None
+        self._tc_clsact_added = False
+        self._tc_attached = False
+        self._bpf_prog_pref = None
+        self._bpf_prog_id = None
+        self._init_ns_attached = False
+        self._old_fwd = None
+        self._old_accept_ra = None
+
+        super().__init__(src_path, **kwargs)
+
+        self.require_ipver("6")
+        local_prefix = self.env.get("LOCAL_PREFIX_V6")
+        if not local_prefix:
+            raise KsftSkipEx("LOCAL_PREFIX_V6 required")
+
+        net = ipaddress.IPv6Network(local_prefix, strict=False)
+        self.ipv6_prefix = str(net.network_address)
+        self.nk_host_ipv6 = f"{self.ipv6_prefix}2:1"
+        self.nk_guest_ipv6 = f"{self.ipv6_prefix}2:2"
+
+        local_v6 = ipaddress.IPv6Address(self.addr_v["6"])
+        if local_v6 in net:
+            raise KsftSkipEx("LOCAL_V6 must not fall within LOCAL_PREFIX_V6")
+
+        rtnl = RtnlFamily()
+        rtnl.newlink(
+            {
+                "linkinfo": {
+                    "kind": "netkit",
+                    "data": {
+                        "mode": "l2",
+                        "policy": "forward",
+                        "peer-policy": "forward",
+                    },
+                },
+                "num-rx-queues": rxqueues,
+            },
+            flags=[Netlink.NLM_F_CREATE, Netlink.NLM_F_EXCL],
+        )
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
+        self._nk_host_ifname = netkit_links[1]['ifname']
+        self._nk_guest_ifname = netkit_links[0]['ifname']
+        self.nk_host_ifindex = netkit_links[1]['ifindex']
+        self.nk_guest_ifindex = netkit_links[0]['ifindex']
+
+        self._setup_ns()
+        self._attach_bpf()
+
+    def __del__(self):
+        if self._tc_attached:
+            cmd(f"tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}")
+            self._tc_attached = False
+
+        if self._tc_clsact_added:
+            cmd(f"tc qdisc del dev {self.ifname} clsact")
+            self._tc_clsact_added = False
+
+        if self._nk_host_ifname:
+            cmd(f"ip link del dev {self._nk_host_ifname}")
+            self._nk_host_ifname = None
+            self._nk_guest_ifname = None
+
+        if self._init_ns_attached:
+            cmd("ip netns del init", fail=False)
+            self._init_ns_attached = False
+
+        if self.netns:
+            del self.netns
+            self.netns = None
+
+        if self._old_fwd is not None:
+            with open("/proc/sys/net/ipv6/conf/all/forwarding", "w",
+                      encoding="utf-8") as f:
+                f.write(self._old_fwd)
+            self._old_fwd = None
+        if self._old_accept_ra is not None:
+            with open("/proc/sys/net/ipv6/conf/all/accept_ra", "w",
+                      encoding="utf-8") as f:
+                f.write(self._old_accept_ra)
+            self._old_accept_ra = None
+
+        super().__del__()
+
+    def _setup_ns(self):
+        fwd_path = "/proc/sys/net/ipv6/conf/all/forwarding"
+        ra_path = "/proc/sys/net/ipv6/conf/all/accept_ra"
+        with open(fwd_path, encoding="utf-8") as f:
+            self._old_fwd = f.read().strip()
+        with open(ra_path, encoding="utf-8") as f:
+            self._old_accept_ra = f.read().strip()
+        with open(fwd_path, "w", encoding="utf-8") as f:
+            f.write("1")
+        with open(ra_path, "w", encoding="utf-8") as f:
+            f.write("2")
+
+        self.netns = NetNS()
+        cmd("ip netns attach init 1")
+        self._init_ns_attached = True
+        ip("netns set init 0", ns=self.netns)
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
+    def _tc_ensure_clsact(self):
+        qdisc = json.loads(cmd(f"tc -j qdisc show dev {self.ifname}").stdout)
+        for q in qdisc:
+            if q['kind'] == 'clsact':
+                return
+        cmd(f"tc qdisc add dev {self.ifname} clsact")
+        self._tc_clsact_added = True
+
+    def _get_bpf_prog_ids(self):
+        filters = json.loads(cmd(f"tc -j filter show dev {self.ifname} ingress").stdout)
+        for bpf in filters:
+            if 'options' not in bpf:
+                continue
+            if bpf['options']['bpf_name'].startswith('nk_forward.bpf'):
+                return (bpf['pref'], bpf['options']['prog']['id'])
+        raise Exception("Failed to get BPF prog ID")
+
+    def _attach_bpf(self):
+        bpf_obj = self.test_dir / "nk_forward.bpf.o"
+        if not bpf_obj.exists():
+            raise KsftSkipEx("BPF prog not found")
+
+        self._tc_ensure_clsact()
+        cmd(f"tc filter add dev {self.ifname} ingress bpf obj {bpf_obj}"
+            " sec tc/ingress direct-action")
+        self._tc_attached = True
+
+        (self._bpf_prog_pref, self._bpf_prog_id) = self._get_bpf_prog_ids()
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
-- 
2.47.3


