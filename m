Return-Path: <netdev+bounces-260282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJcLBnHwnGkaMQQAu9opvQ
	(envelope-from <netdev+bounces-260282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:27:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA3D1803A0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BCFD317A644
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132E221A447;
	Tue, 24 Feb 2026 00:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="CMk+Ge5f"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F55F2135D7
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892705; cv=none; b=C6XZmXT3TAC2mLbgXs4gwHJlDhLWMbWIW2WIV2qgdqeQy6U0hmg4CUC56Cw15mG4KJr3tFNnPGf4DGJiM+6PF2JC9TCv46wPObw98WqiewjSQiLXBcm7x7klJwCv4tYap5cx9JfOMpn98ewH4LSkJGBfnos3gU9hF5ey7RyWMMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892705; c=relaxed/simple;
	bh=/eZNsSmMJPWE5GdQJdvcU6igLcMDtkpXqSa2dpkf9dw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkljikJTad2UhHIOkXDTIGGOAZpp4a6fvzLBUDzl0Xjgz4V62VgyrIvgjA0dab0devYvOsiLdTknf3sCp1QcxaubyC02wi6fMzr/PQ0Y4CVubBHZVVqyVMEtkv7kIEeCZS6NUEShSzJqp6uwrab1MSLYTI0o4H0xfKsFWLmKr/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=CMk+Ge5f; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 61NKZle4258584
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:25:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=h6/To61eHALPli0KrNDtwHiMMslSk+KwsTJjQn6Xlt8=; b=CMk+Ge5fTrU7
	7ybntBZXtV+EAm980LDB/1KypV0sBX6ML5x6HjDfHyGAJ1E2wcQto5Lfi19RVamb
	fYNKN0teZh57PHrIM6RFzi+z5DRYSJLt+vSh/zM7E8wuUXXzVUASj8wPSofYbq/A
	VhKwFqIPuzOJlx7cq9REem32aQ0rDzuBpFQIjFHsukUrrAG2hcdqwq6w2s5k0z0a
	QcknpFoM3Ikr23g24im0LW2ByG8Py2cA+AeNu3511GfL2S2J+9/tBUiX2XHC/9UB
	3ga2decXfSuMlMI9tiANMnSYdolysWHDZySW/TiJUPIGumeREhnzQ13CBm92AuEB
	I00MgJ4bwA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4cgx2rj2fh-20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:25:02 -0800 (PST)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Feb 2026 00:24:51 +0000
Received: by devbig1867.frc2.facebook.com (Postfix, from userid 708122)
	id DD02465F7ED7; Mon, 23 Feb 2026 16:24:38 -0800 (PST)
From: Wei Wang <weibunny@fb.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Daniel Zahka
	<daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
CC: Wei Wang <weibunny@fb.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next 3/9] selftests/net: Add env for container based tests
Date: Mon, 23 Feb 2026 16:24:03 -0800
Message-ID: <20260224002410.1553838-4-weibunny@fb.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224002410.1553838-1-weibunny@fb.com>
References: <20260224002410.1553838-1-weibunny@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=MOJtWcZl c=1 sm=1 tr=0 ts=699cefde cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=hWMQpYRtAAAA:8 a=a-6euqE6cJcf-JEEsxYA:9
 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-GUID: mwwJP-4-sZ51-qS_5JeclcF_FeNZxZWc
X-Proofpoint-ORIG-GUID: mwwJP-4-sZ51-qS_5JeclcF_FeNZxZWc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAwMSBTYWx0ZWRfX85UkbeocYDff
 duJyLYK8xhNm/xTtxdZE68OIGs2k3fDNUwZr+k8mT+rO79VVsc/XaGz14rbqO19uaIx2DDwGhUv
 6PqdPF8h60NkrX3VedgxWHgW3zR5BtJOayTZIoD2ZYg/1H21nkahRfioS70uMcyfk+jYXFrp3VM
 tWok0zB1wthxzUoA93Zv25vVJSIVoF+q87UFVSOiES009UlxBm0Ut7pwkJrh9KGihszM+C/Cmp0
 /SdhHGW+5YHlfiL8+veXx9+DT5rsYxrGw0BREb775lx0TeM8S8ahSnKNPBwinAlJnixPYq4cMW4
 c8ThinXV3sHAKstxKOQITDLTuGM1Gt2t84SSRGS3NdS6+/BCifahdqcLMOqw+/OnW6AHjDTklcJ
 pKCWWj9FE3GWg2GQsplCUBPiVzpwFSDpVshmnY9LkaD8xaJ6kNdFP4kymiA4flaurGl2MDM4nFI
 aaiJ9OKXVkdWbvc+iRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fb.com,reject];
	R_DKIM_ALLOW(-0.20)[fb.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-260282-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fb.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@fb.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei.uk:email,lib.py:url,fb.com:mid,fb.com:dkim,netns.name:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6AA3D1803A0
X-Rspamd-Action: no action

From: David Wei <dw@davidwei.uk>

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
 .../testing/selftests/drivers/net/README.rst  |  19 ++
 .../drivers/net/hw/lib/py/__init__.py         |   7 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   7 +-
 .../selftests/drivers/net/lib/py/env.py       | 163 ++++++++++++++++++
 4 files changed, 190 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testi=
ng/selftests/drivers/net/README.rst
index eb838ae94844..39370a83f238 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -62,6 +62,25 @@ LOCAL_V4, LOCAL_V6, REMOTE_V4, REMOTE_V6
=20
 Local and remote endpoint IP addresses.
=20
+LOCAL_PREFIX_V4, LOCAL_PREFIX_V6
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Local IP prefix/subnet which can be used to allocate extra IP addresses =
(for
+network name spaces behind macvlan, veth, netkit devices). DUT must be
+reachable using these addresses from the endpoint.
+
+  +-------------+        +----------------------------+
+  | INIT NS     |        | TEST NS                    |
+  | +---------+ |        | +------------------------+ |
+  | | NETIF   | |  bpf   | | Netkit                 | |
+  | |         |-|--------|>| nk_guest               | |
+  | +---------+ |        | | {LOCAL_PREFIX_V6}::2:2 | |
+  | +---------+ |        | +------------------------+ |
+  | | Netkit  | |        +----------------------------+
+  | | nk_host | |
+  | +---------+ |
+  +-------------+
+
 REMOTE_TYPE
 ~~~~~~~~~~~
=20
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/=
tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index d5d247eca6b7..022008249313 100644
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
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, =
\
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_=
none
     from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
-    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
+    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
=20
     __all__ =3D ["NetNS", "NetNSEnter", "NetdevSimDev",
                "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
@@ -44,8 +45,8 @@ try:
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ks=
ft_gt",
                "ksft_not_none", "ksft_not_none",
-               "NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote",
-               "Iperf3Runner"]
+               "NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTra=
ffic",
+               "Remote", "Iperf3Runner"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/too=
ls/testing/selftests/drivers/net/lib/py/__init__.py
index a18e21069f7a..6b55068d5370 100644
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
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ks=
ft_gt",
                "ksft_not_none", "ksft_not_none"]
=20
-    from .env import NetDrvEnv, NetDrvEpEnv
+    from .env import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
     from .load import GenerateTraffic, Iperf3Runner
     from .remote import Remote
=20
-    __all__ +=3D ["NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote=
",
-                "Iperf3Runner"]
+    __all__ +=3D ["NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "Generate=
Traffic",
+                "Remote", "Iperf3Runner"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/te=
sting/selftests/drivers/net/lib/py/env.py
index 41cc248ac848..857ae0f37516 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -1,13 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0
=20
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
=20
=20
 class NetDrvEnvBase:
@@ -289,3 +292,163 @@ class NetDrvEpEnv(NetDrvEnvBase):
                 data.get('stats-block-usecs', 0) / 1000 / 1000
=20
         time.sleep(self._stats_settle_time)
+
+
+class NetDrvContEnv(NetDrvEpEnv):
+    """
+    Class for an environment with a netkit pair setup for forwarding tra=
ffic
+    between the physical interface and a network namespace.
+    +-------------+        +----------------------------+
+    | INIT NS     |        | TEST NS                    |
+    | +---------+ |        | +------------------------+ |
+    | | NETIF   | |  bpf   | | Netkit                 | |
+    | |         |-|--------|>| nk_guest               | |
+    | +---------+ |        | | {LOCAL_PREFIX_V6}::2:2 | |
+    | +---------+ |        | +------------------------+ |
+    | | Netkit  | |        +----------------------------+
+    | | nk_host | |
+    | +---------+ |
+    +-------------+
+    """
+
+    def __init__(self, src_path, rxqueues=3D1, **kwargs):
+        super().__init__(src_path, **kwargs)
+
+        self.netns =3D None
+        self._nk_host_ifname =3D None
+        self._nk_guest_ifname =3D None
+        self._tc_clsact_added =3D False
+        self._tc_attached =3D False
+        self._bpf_prog_pref =3D None
+        self._bpf_prog_id =3D None
+        self._init_ns_attached =3D False
+
+        self.require_ipver("6")
+        local_prefix =3D self.env.get("LOCAL_PREFIX_V6")
+        if not local_prefix:
+            raise KsftSkipEx("LOCAL_PREFIX_V6 required")
+
+        local_prefix =3D local_prefix.rstrip("/64").rstrip("::").rstrip(=
":")
+        self.ipv6_prefix =3D f"{local_prefix}::"
+        self.nk_host_ipv6 =3D f"{local_prefix}::2:1"
+        self.nk_guest_ipv6 =3D f"{local_prefix}::2:2"
+
+        rtnl =3D RtnlFamily()
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
+            flags=3D[Netlink.NLM_F_CREATE, Netlink.NLM_F_EXCL],
+        )
+
+        all_links =3D ip("-d link show", json=3DTrue)
+        netkit_links =3D [link for link in all_links
+                        if link.get('linkinfo', {}).get('info_kind') =3D=
=3D 'netkit'
+                        and 'UP' not in link.get('flags', [])]
+
+        if len(netkit_links) !=3D 2:
+            raise KsftSkipEx("Failed to create netkit pair")
+
+        netkit_links.sort(key=3Dlambda x: x['ifindex'])
+        self._nk_host_ifname =3D netkit_links[1]['ifname']
+        self._nk_guest_ifname =3D netkit_links[0]['ifname']
+        self.nk_host_ifindex =3D netkit_links[1]['ifindex']
+        self.nk_guest_ifindex =3D netkit_links[0]['ifindex']
+
+        self._setup_ns()
+        self._attach_bpf()
+
+    def __del__(self):
+        if self._tc_attached:
+            cmd(f"tc filter del dev {self.ifname} ingress pref {self._bp=
f_prog_pref}")
+            self._tc_attached =3D False
+
+        if self._tc_clsact_added:
+            cmd(f"tc qdisc del dev {self.ifname} clsact")
+            self._tc_clsact_added =3D False
+
+        if self._nk_host_ifname:
+            cmd(f"ip link del dev {self._nk_host_ifname}")
+            self._nk_host_ifname =3D None
+            self._nk_guest_ifname =3D None
+
+        if self._init_ns_attached:
+            cmd("ip netns del init", fail=3DFalse)
+            self._init_ns_attached =3D False
+
+        if self.netns:
+            del self.netns
+            self.netns =3D None
+
+        super().__del__()
+
+    def _setup_ns(self):
+        self.netns =3D NetNS()
+        cmd("ip netns attach init 1")
+        self._init_ns_attached =3D True
+        ip("netns set init 0", ns=3Dself.netns)
+        ip(f"link set dev {self._nk_guest_ifname} netns {self.netns.name=
}")
+        ip(f"link set dev {self._nk_host_ifname} up")
+        ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
+        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self=
._nk_host_ifname}")
+
+        ip("link set lo up", ns=3Dself.netns)
+        ip(f"link set dev {self._nk_guest_ifname} up", ns=3Dself.netns)
+        ip(f"-6 addr add fe80::2/64 dev {self._nk_guest_ifname}", ns=3Ds=
elf.netns)
+        ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifn=
ame} nodad", ns=3Dself.netns)
+        ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname=
}", ns=3Dself.netns)
+
+    def _tc_ensure_clsact(self):
+        qdisc =3D json.loads(cmd(f"tc -j qdisc show dev {self.ifname}").=
stdout)
+        for q in qdisc:
+            if q['kind'] =3D=3D 'clsact':
+                return
+        cmd(f"tc qdisc add dev {self.ifname} clsact")
+        self._tc_clsact_added =3D True
+
+    def _get_bpf_prog_ids(self):
+        filter =3D json.loads(cmd(f"tc -j filter show dev {self.ifname} =
ingress").stdout)
+        for bpf in filter:
+            if 'options' not in bpf:
+                continue
+            if bpf['options']['bpf_name'].startswith('nk_forward.bpf'):
+                return (bpf['pref'], bpf['options']['prog']['id'])
+        if self._bpf_prog_pref is None:
+            raise Exception("Failed to get BPF prog ID")
+
+    def _attach_bpf(self):
+        bpf_obj =3D self.test_dir / "nk_forward.bpf.o"
+        if not bpf_obj.exists():
+            raise KsftSkipEx("BPF prog not found")
+
+        self._tc_ensure_clsact()
+        cmd(f"tc filter add dev {self.ifname} ingress bpf obj {bpf_obj} =
sec tc/ingress direct-action")
+        self._tc_attached =3D True
+
+        (self._bpf_prog_pref, self._bpf_prog_id) =3D self._get_bpf_prog_=
ids()
+        prog_info =3D bpftool(f"prog show id {self._bpf_prog_id}", json=3D=
True)
+        map_ids =3D prog_info.get("map_ids", [])
+
+        bss_map_id =3D None
+        for map_id in map_ids:
+            map_info =3D bpftool(f"map show id {map_id}", json=3DTrue)
+            if map_info.get("name").endswith("bss"):
+                bss_map_id =3D map_id
+
+        if bss_map_id is None:
+            raise Exception("Failed to find .bss map")
+
+        ipv6_addr =3D ipaddress.IPv6Address(self.ipv6_prefix)
+        ipv6_bytes =3D ipv6_addr.packed
+        ifindex_bytes =3D self.nk_host_ifindex.to_bytes(4, byteorder=3D'=
little')
+        value =3D ipv6_bytes + ifindex_bytes
+        value_hex =3D ' '.join(f'{b:02x}' for b in value)
+        bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value h=
ex {value_hex}")
--=20
2.47.3


