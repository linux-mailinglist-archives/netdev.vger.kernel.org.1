Return-Path: <netdev+bounces-283265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8McUODfp9GnpFgIAu9opvQ
	(envelope-from <netdev+bounces-283265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:56:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB09B4AEA89
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DBC3E3007B22
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8E0309EEB;
	Fri,  1 May 2026 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lji/XPT6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88B63242CF
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777658156; cv=none; b=bkVY4SCelA90Pu6GM3cDXCMfWJMDLa8srDGgU+o8DVGoo09RCO7EoxWICtrxQfUFWmffJzY+Q2+CEnjQ4lzpMk27u8gsjcskwtAL9DVzfPc+tt+eyhJPRnPelykz2fvsR930B0poFNVInwmVLpezzYRCqzZTU2CWJ97zyJdy/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777658156; c=relaxed/simple;
	bh=x1ftgUbke9NMC4/8T0KOOYRkgFdmAAIg+SVlPuQ0Kk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDxU6a5wa8xNMJ4cHmASrvCox2JyanL1gakqFenbGhkr1t9Jd3AnT0s3LaRIhiwzrUGiVukv6S9hHkdDrxBZEGDl+s6pPFrIG7Vx8mPGngHUTOIE01/k0knEgm69EczLlbk4yhN6tH5mblOYiHtBaH66cnOIS+6ucHQN/btdph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lji/XPT6; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-651bc5494b4so227237d50.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777658153; x=1778262953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4DfNhqozqpnb8gK6thZv2G441C1wW/mN6uXcNTsTDQ=;
        b=Lji/XPT62rQVn8BBGySCIBBaIzLDU0zC1dWphTleswCBfsm0shy2MjHJabsXVTkWCc
         goqEInuPVfo3Oz1bE71844Bgtq8f4dX42avGu7oiiri5OLI0V1ddZ2VcUhnrVr0+lkvm
         Q7jOIQCbTZOwRPBZw7O2ODkMObWntBkR6wuhcpJXaOoOMxq+dzG3Wz3q0/mugSIMd5oI
         rSFE89KVVWp88mm4Qnfusyt6RNfoFZAMxOPGotgsGtpD3cV9ZWe7LM2qECTdRrDS7PI7
         RPzad+qqqRQzR0dfIZyJPgXclq6/CwC7mZ6r39HvpmT/KghkCyXg2oCvP5rXgzHW7Bsl
         DLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777658153; x=1778262953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q4DfNhqozqpnb8gK6thZv2G441C1wW/mN6uXcNTsTDQ=;
        b=edWHjik0nrDlLG3bhi6XQ7DF4QIlmZjoJ15sC6DwhRu7DX/EF1wLPzmftvwa/ATkFf
         SF/WU25AeE0JeYtVouA2mJ9TWE/7WTkc8O9loAbrkujzzKWzKA1QrFrtg1BXAXXLW3x4
         BIXh18PYKrnMMiCgmRTqXFX1rEwpTDeP66I++R8F6OxwYo5pgrbeh59etcTM7F0x0Mvs
         uoYf2jOOn1EvS+zyNDmhNG7focqq21eh2bUx8+1VsvP/zmbr7Cqs5Gac3kNIBnJcnEp7
         hmXhaO+N4Rjbqczy51j0tkCFQKJtMXRXnTIabQxTwi0eDr6bNnCCJOqXqOU4HVM1Ckin
         xfBQ==
X-Gm-Message-State: AOJu0YxOkL0tfmEBqP6QWAaopUKF/Gw/jzuF1cXTdaXbm27QZ25pKBap
	cmyyLJJgAXwBtWJIGloaOSU3bDtDOYr2LkY4VqkQLN5nblFcvnCY5OQc3tDFxw==
X-Gm-Gg: AeBDietwnWCRx4ykF+zALHZq67RZq6hiIz0J4Jc3nxPwvJATxops8aYzpieDpvPV6td
	vSYm0mJMVeektziifXSMbGiaryBVDhgwszlfONtLSSvlt+3fK8vqavWPS5GVpDLykBBXjohlvwG
	CMWdrzUz1mixRS+1ccCGQJj6k/j92THFJOepQPR99GYDlMMwzaRJl7IojyZcmI9Vx4zI/cdoBOQ
	CctOWBhD0lmosrxqR0RM/VRJcG8eXSCY1AYknBGxrzxse3Qb6TAvOiwXtOhBSi/X+TgRUvy1PgL
	3hZ0KCs06rchKiF7Iwk4SHNXMUt8uPN/2AOL+SdGOctyUDaCbeJV9FmsOO9dzdz4pfecG7UgWjP
	DGFKsykarmLBNHocIIF2TcKIU49TwskAQsXW5YGn3PH043UNNR3yQQlHGJYe8Q4yvVH/ekC4mL3
	981oWxA38dJI6GwRF3N0X7fDK+15zZE58fBQ==
X-Received: by 2002:a05:690c:6ac6:b0:7b6:40ef:6fb6 with SMTP id 00721157ae682-7bd770f5591mr2838787b3.6.1777658152472;
        Fri, 01 May 2026 10:55:52 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6686ead7sm14336677b3.39.2026.05.01.10.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:55:52 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v12 net-next 5/5] selftest/net: psp: Add test for dev-assoc/disassoc
Date: Fri,  1 May 2026 10:55:27 -0700
Message-ID: <20260501175528.2130551-6-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501175528.2130551-1-weibunny.kernel@gmail.com>
References: <20260501175528.2130551-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DB09B4AEA89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283265-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,netns.name:url,cfg.dev:url]

From: Wei Wang <weibunny@fb.com>

Add a new param to NetDrvContEnv to add an additional bpf redirect
program on nk_host to redirect traffic to the psp_dev_local.
The topology looks like this:
  Host NS:  psp_dev_local <---> nk_host
                |                |
                |                | (netkit pair)
                |                |
  Remote NS: psp_dev_peer      Guest NS: nk_guest
             (responder)             (PSP tests)

Add following tests for dev-assoc/dev-disassoc functionality:
1. Test the output of `./tools/net/ynl/pyynl/cli.py --spec
Documentation/netlink/specs/psp.yaml --dump dev-get` in both default and
the guest netns.
2. Test the case where we associate netkit with psp_dev_local, and
send PSP traffic from nk_guest to psp_dev_peer in 2 different netns.
3. Test to make sure the key rotation notification is sent to the netns
for associated dev as well
4. Test to make sure the dev change notification is sent to the netns
for associated dev as well
5. Test for dev-assoc/dev-disassoc without nsid parameter.
6. Test the deletion of nk_guest in client netns, and proper cleanup in
the assoc-list for psp dev.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 tools/testing/selftests/drivers/net/config    |   1 +
 .../selftests/drivers/net/lib/py/env.py       |  54 ++-
 tools/testing/selftests/drivers/net/psp.py    | 457 ++++++++++++++++--
 3 files changed, 478 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index fd16994366f4..b8a559b360e4 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -8,5 +8,6 @@ CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
 CONFIG_NETDEVSIM=m
+CONFIG_NETKIT=y
 CONFIG_VLAN_8021Q=m
 CONFIG_XDP_SOCKETS=y
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 24ce122abd9c..cd3a08cbe968 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -2,6 +2,7 @@
 
 import ipaddress
 import os
+import re
 import time
 import json
 from pathlib import Path
@@ -336,7 +337,7 @@ class NetDrvContEnv(NetDrvEpEnv):
               +---------------+
     """
 
-    def __init__(self, src_path, rxqueues=1, **kwargs):
+    def __init__(self, src_path, rxqueues=1, install_tx_redirect_bpf=False, **kwargs):
         self.netns = None
         self._nk_host_ifname = None
         self._nk_guest_ifname = None
@@ -347,6 +348,8 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._init_ns_attached = False
         self._old_fwd = None
         self._old_accept_ra = None
+        self._nk_host_tc_attached = False
+        self._nk_host_bpf_prog_pref = None
 
         super().__init__(src_path, **kwargs)
 
@@ -397,7 +400,13 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._setup_ns()
         self._attach_bpf()
 
+        if install_tx_redirect_bpf:
+            self._attach_tx_redirect_bpf()
+
     def __del__(self):
+        if self._nk_host_tc_attached:
+            cmd(f"tc filter del dev {self._nk_host_ifname} ingress pref {self._nk_host_bpf_prog_pref}", fail=False)
+            self._nk_host_tc_attached = False
         if self._tc_attached:
             cmd(f"tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}")
             self._tc_attached = False
@@ -505,3 +514,46 @@ class NetDrvContEnv(NetDrvEpEnv):
         value = ipv6_bytes + ifindex_bytes
         value_hex = ' '.join(f'{b:02x}' for b in value)
         bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value hex {value_hex}")
+
+    def _attach_tx_redirect_bpf(self):
+        """
+        Attach BPF program on nk_host ingress to redirect TX traffic.
+
+        Packets from nk_guest destined for the nsim network arrive at nk_host
+        via the netkit pair. This BPF program redirects them to the physical
+        interface so they can reach the remote peer.
+        """
+        bpf_obj = self.test_dir / "nk_redirect.bpf.o"
+        if not bpf_obj.exists():
+            raise KsftSkipEx("BPF prog nk_redirect.bpf.o not found")
+
+        cmd(f"tc qdisc add dev {self._nk_host_ifname} clsact")
+
+        cmd(f"tc filter add dev {self._nk_host_ifname} ingress bpf obj {bpf_obj} sec tc/ingress direct-action")
+        self._nk_host_tc_attached = True
+
+        tc_info = cmd(f"tc filter show dev {self._nk_host_ifname} ingress").stdout
+        match = re.search(r'pref (\d+).*nk_redirect\.bpf.*id (\d+)', tc_info)
+        if not match:
+            raise Exception("Failed to get TX redirect BPF prog ID")
+        self._nk_host_bpf_prog_pref = int(match.group(1))
+        nk_host_bpf_prog_id = int(match.group(2))
+
+        prog_info = bpftool(f"prog show id {nk_host_bpf_prog_id}", json=True)
+        map_ids = prog_info.get("map_ids", [])
+
+        bss_map_id = None
+        for map_id in map_ids:
+            map_info = bpftool(f"map show id {map_id}", json=True)
+            if map_info.get("name").endswith("bss"):
+                bss_map_id = map_id
+
+        if bss_map_id is None:
+            raise Exception("Failed to find TX redirect BPF .bss map")
+
+        ipv6_addr = ipaddress.IPv6Address(self.nsim_v6_pfx)
+        ipv6_bytes = ipv6_addr.packed
+        ifindex_bytes = self.ifindex.to_bytes(4, byteorder='little')
+        value = ipv6_bytes + ifindex_bytes
+        value_hex = ' '.join(f'{b:02x}' for b in value)
+        bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value hex {value_hex}")
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 864d9fce1094..79da4d425c50 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -5,6 +5,7 @@
 
 import errno
 import fcntl
+import os
 import socket
 import struct
 import termios
@@ -14,9 +15,12 @@ from lib.py import defer
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises
 from lib.py import ksft_not_none
-from lib.py import KsftSkipEx
-from lib.py import NetDrvEpEnv, PSPFamily, NlError
+from lib.py import ksft_variants, KsftNamedVariant
+from lib.py import KsftSkipEx, KsftFailEx
+from lib.py import NetDrvEpEnv, NetDrvContEnv, PSPFamily, NlError
+from lib.py import NetNSEnter
 from lib.py import bkg, rand_port, wait_port_listen
+from lib.py import ip
 
 
 def _get_outq(s):
@@ -117,11 +121,13 @@ def _get_stat(cfg, key):
 # Test case boiler plate
 #
 
-def _init_psp_dev(cfg):
+def _init_psp_dev(cfg, use_psp_ifindex=False):
     if not hasattr(cfg, 'psp_dev_id'):
         # Figure out which local device we are testing against
+        # For NetDrvContEnv: use psp_ifindex instead of ifindex
+        target_ifindex = cfg.psp_ifindex if use_psp_ifindex else cfg.ifindex
         for dev in cfg.pspnl.dev_get({}, dump=True):
-            if dev['ifindex'] == cfg.ifindex:
+            if dev['ifindex'] == target_ifindex:
                 cfg.psp_info = dev
                 cfg.psp_dev_id = cfg.psp_info['id']
                 break
@@ -394,6 +400,297 @@ def _data_basic_send(cfg, version, ipver):
     _close_psp_conn(cfg, s)
 
 
+def _data_basic_send_netkit_psp_assoc(cfg, version, ipver):
+    """
+    Test basic data send with netkit interface associated with PSP dev.
+    """
+
+    _init_psp_dev(cfg, True)
+    psp_dev_id_for_assoc = cfg.psp_dev_id
+
+    # Associate PSP device with nk_guest interface (in guest namespace)
+    nk_guest_dev = ip(f"link show dev {cfg._nk_guest_ifname}", json=True, ns=cfg.netns)[0]
+    nk_guest_ifindex = nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    # Check if assoc-list contains nk_guest
+    dev_info = cfg.pspnl.dev_get({'id': psp_dev_id_for_assoc})
+
+    if 'assoc-list' in dev_info:
+        found = False
+        for assoc in dev_info['assoc-list']:
+            if assoc['ifindex'] == nk_guest_ifindex and assoc['nsid'] == cfg.psp_dev_peer_nsid:
+                found = True
+                break
+        ksft_true(found, "Associated device not found in dev_get() response")
+    else:
+        raise RuntimeError("No assoc-list in dev_get() response after association")
+
+    # Enter guest namespace (netns) to run PSP test
+    with NetNSEnter(cfg.netns.name):
+        cfg.pspnl = PSPFamily()
+
+        s = _make_psp_conn(cfg, version, ipver)
+
+        rx_assoc = cfg.pspnl.rx_assoc({"version": version,
+                                       "dev-id": cfg.psp_dev_id,
+                                       "sock-fd": s.fileno()})
+        rx = rx_assoc['rx-key']
+        tx = _spi_xchg(s, rx)
+
+        cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                            "version": version,
+                            "tx-key": tx,
+                            "sock-fd": s.fileno()})
+
+        data_len = _send_careful(cfg, s, 100)
+        _check_data_rx(cfg, data_len)
+        _close_psp_conn(cfg, s)
+
+    # Clean up - back in host namespace
+    cfg.pspnl = PSPFamily()
+    cfg.pspnl.dev_disassoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
+def _key_rotation_notify_multi_ns_netkit(cfg):
+    """ Test key rotation notifications across multiple namespaces using netkit """
+    _init_psp_dev(cfg, True)
+    psp_dev_id_for_assoc = cfg.psp_dev_id
+
+    # Associate PSP device with nk_guest interface (in guest namespace)
+    nk_guest_dev = ip(f"link show dev {cfg._nk_guest_ifname}", json=True, ns=cfg.netns)[0]
+    nk_guest_ifindex = nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    # Create listener in guest namespace; socket stays bound to that ns
+    with NetNSEnter(cfg.netns.name):
+        peer_pspnl = PSPFamily()
+        peer_pspnl.ntf_subscribe('use')
+
+    # Create listener in main namespace
+    main_pspnl = PSPFamily()
+    main_pspnl.ntf_subscribe('use')
+
+    # Trigger key rotation on the PSP device
+    cfg.pspnl.key_rotate({"id": psp_dev_id_for_assoc})
+
+    # Poll both sockets from main thread
+    for pspnl, label in [(main_pspnl, "main"), (peer_pspnl, "guest")]:
+        for i in range(100):
+            pspnl.check_ntf()
+
+            try:
+                msg = pspnl.async_msg_queue.get_nowait()
+                break
+            except Exception:
+                pass
+
+            time.sleep(0.1)
+        else:
+            raise KsftFailEx(f"No key rotation notification received in {label} namespace")
+
+        ksft_true(msg['msg'].get('id') == psp_dev_id_for_assoc,
+                  f"Key rotation notification for correct device not found in {label} namespace")
+
+    # Clean up
+    cfg.pspnl.dev_disassoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
+def _dev_change_notify_multi_ns_netkit(cfg):
+    """ Test dev_change notifications across multiple namespaces using netkit """
+    _init_psp_dev(cfg, True)
+    psp_dev_id_for_assoc = cfg.psp_dev_id
+
+    # Associate PSP device with nk_guest interface (in guest namespace)
+    nk_guest_dev = ip(f"link show dev {cfg._nk_guest_ifname}", json=True, ns=cfg.netns)[0]
+    nk_guest_ifindex = nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    # Create listener in guest namespace; socket stays bound to that ns
+    with NetNSEnter(cfg.netns.name):
+        peer_pspnl = PSPFamily()
+        peer_pspnl.ntf_subscribe('mgmt')
+
+    # Create listener in main namespace
+    main_pspnl = PSPFamily()
+    main_pspnl.ntf_subscribe('mgmt')
+
+    # Trigger dev_change by calling dev_set (notification is always sent)
+    cfg.pspnl.dev_set({'id': psp_dev_id_for_assoc, 'psp-versions-ena': cfg.psp_info['psp-versions-cap']})
+
+    # Poll both sockets from main thread
+    for pspnl, label in [(main_pspnl, "main"), (peer_pspnl, "guest")]:
+        for i in range(100):
+            pspnl.check_ntf()
+
+            try:
+                msg = pspnl.async_msg_queue.get_nowait()
+                break
+            except Exception:
+                pass
+
+            time.sleep(0.1)
+        else:
+            raise KsftFailEx(f"No dev_change notification received in {label} namespace")
+
+        ksft_true(msg['msg'].get('id') == psp_dev_id_for_assoc,
+                  f"Dev_change notification for correct device not found in {label} namespace")
+
+    # Clean up
+    cfg.pspnl.dev_disassoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
+def _psp_dev_get_check_netkit_psp_assoc(cfg):
+    """ Check psp dev-get output with netkit interface associated with PSP dev """
+
+    _init_psp_dev(cfg, True)
+    psp_dev_id_for_assoc = cfg.psp_dev_id
+
+    # Associate PSP device with nk_guest interface (in guest namespace)
+    nk_guest_dev = ip(f"link show dev {cfg._nk_guest_ifname}", json=True, ns=cfg.netns)[0]
+    nk_guest_ifindex = nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    # Check 1: In default netns, verify dev-get has correct ifindex and assoc-list
+    dev_info = cfg.pspnl.dev_get({'id': psp_dev_id_for_assoc})
+
+    # Verify the PSP device has the correct ifindex
+    ksft_eq(dev_info['ifindex'], cfg.psp_ifindex)
+
+    # Verify assoc-list exists and contains the associated nk_guest with correct ifindex and nsid
+    ksft_true('assoc-list' in dev_info, "No assoc-list in dev_get() response after association")
+    found = False
+    for assoc in dev_info['assoc-list']:
+        if assoc['ifindex'] == nk_guest_ifindex and assoc['nsid'] == cfg.psp_dev_peer_nsid:
+            found = True
+            break
+    ksft_true(found, "Associated device not found in assoc-list with correct ifindex and nsid")
+
+    # Check 2: In guest netns, verify dev-get has assoc-list with nk_guest device
+    with NetNSEnter(cfg.netns.name):
+        peer_pspnl = PSPFamily()
+
+        # Dump all devices in the guest namespace
+        peer_devices = peer_pspnl.dev_get({}, dump=True)
+
+        # Find the device with by-association flag
+        peer_dev = None
+        for dev in peer_devices:
+            if dev.get('by-association'):
+                peer_dev = dev
+                break
+
+        ksft_not_none(peer_dev, "No PSP device found with by-association flag in guest netns")
+
+        # Verify assoc-list contains the nk_guest device
+        ksft_true('assoc-list' in peer_dev and len(peer_dev['assoc-list']) > 0,
+                  "Guest device should have assoc-list with local devices")
+
+        # Verify the assoc-list contains nk_guest ifindex with nsid=-1 (same namespace)
+        found = False
+        for assoc in peer_dev['assoc-list']:
+            if assoc['ifindex'] == nk_guest_ifindex:
+                ksft_eq(assoc['nsid'], -1,
+                        "nsid should be -1 (NETNSA_NSID_NOT_ASSIGNED) for same-namespace device")
+                found = True
+                break
+        ksft_true(found, "nk_guest ifindex not found in assoc-list")
+
+    # Clean up
+    cfg.pspnl.dev_disassoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
+def _dev_assoc_no_nsid(cfg):
+    """ Test dev-assoc and dev-disassoc without nsid attribute """
+    _init_psp_dev(cfg, True)
+    psp_dev_id = cfg.psp_dev_id
+
+    # Get nk_host's ifindex (in host namespace, same as caller)
+    nk_host_dev = ip(f"link show dev {cfg._nk_host_ifname}", json=True)[0]
+    nk_host_ifindex = nk_host_dev['ifindex']
+
+    # Associate without nsid - should look up ifindex in caller's netns
+    cfg.pspnl.dev_assoc({'id': psp_dev_id, 'ifindex': nk_host_ifindex})
+
+    # Verify assoc-list contains the device
+    dev_info = cfg.pspnl.dev_get({'id': psp_dev_id})
+    ksft_true('assoc-list' in dev_info, "No assoc-list after association")
+    found = False
+    for assoc in dev_info['assoc-list']:
+        if assoc['ifindex'] == nk_host_ifindex:
+            found = True
+            break
+    ksft_true(found, "Associated device not found in assoc-list")
+
+    # Disassociate without nsid - should also use caller's netns
+    cfg.pspnl.dev_disassoc({'id': psp_dev_id, 'ifindex': nk_host_ifindex})
+
+    # Verify assoc-list no longer contains the device
+    dev_info = cfg.pspnl.dev_get({'id': psp_dev_id})
+    found = False
+    if 'assoc-list' in dev_info:
+        for assoc in dev_info['assoc-list']:
+            if assoc['ifindex'] == nk_host_ifindex:
+                found = True
+                break
+    ksft_true(not found, "Device should not be in assoc-list after disassociation")
+
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
+def _psp_dev_assoc_cleanup_on_netkit_del(cfg):
+    """ Test that assoc-list is cleared when associated netkit interface is deleted """
+    _init_psp_dev(cfg, True)
+    psp_dev_id_for_assoc = cfg.psp_dev_id
+
+    # Associate PSP device with nk_guest interface (in guest namespace)
+    nk_guest_dev = ip(f"link show dev {cfg._nk_guest_ifname}", json=True, ns=cfg.netns)[0]
+    nk_guest_ifindex = nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    # Verify assoc-list exists in default netns
+    dev_info = cfg.pspnl.dev_get({'id': psp_dev_id_for_assoc})
+    ksft_true('assoc-list' in dev_info, "No assoc-list after association")
+    found = False
+    for assoc in dev_info['assoc-list']:
+        if assoc['ifindex'] == nk_guest_ifindex and assoc['nsid'] == cfg.psp_dev_peer_nsid:
+            found = True
+            break
+    ksft_true(found, "Associated device not found in assoc-list")
+
+    # Delete the netkit interface in the guest namespace
+    ip(f"link del {cfg._nk_guest_ifname}", ns=cfg.netns)
+
+    # Mark netkit as already deleted so cleanup won't try to delete it again
+    # (deleting nk_guest also removes nk_host since they're a pair)
+    cfg._nk_host_ifname = None
+    cfg._nk_guest_ifname = None
+
+    # Verify assoc-list is gone in default netns after netkit deletion
+    dev_info = cfg.pspnl.dev_get({'id': psp_dev_id_for_assoc})
+    ksft_true('assoc-list' not in dev_info or len(dev_info['assoc-list']) == 0,
+              "assoc-list should be empty after netkit deletion")
+
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
 def __bad_xfer_do(cfg, s, tx, version='hdr0-aes-gcm-128'):
     # Make sure we accept the ACK for the SPI before we seal with the bad assoc
     _check_data_outq(s, 0)
@@ -571,33 +868,127 @@ def removal_device_bi(cfg):
         _close_conn(cfg, s)
 
 
-def psp_ip_ver_test_builder(name, test_func, psp_ver, ipver):
-    """Build test cases for each combo of PSP version and IP version"""
-    def test_case(cfg):
-        cfg.require_ipver(ipver)
-        test_func(cfg, psp_ver, ipver)
-
-    test_case.__name__ = f"{name}_v{psp_ver}_ip{ipver}"
-    return test_case
+@ksft_variants([
+    KsftNamedVariant(f"v{v}_ip{ip}", v, ip)
+    for v in range(4) for ip in ("4", "6")
+])
+def data_basic_send(cfg, version, ipver):
+    cfg.require_ipver(ipver)
+    _data_basic_send(cfg, version, ipver)
+
+
+@ksft_variants([
+    KsftNamedVariant(f"ip{ip}", ip)
+    for ip in ("4", "6")
+])
+def data_mss_adjust(cfg, ipver):
+    cfg.require_ipver(ipver)
+    _data_mss_adjust(cfg, ipver)
+
+
+@ksft_variants([
+    KsftNamedVariant(f"v{v}_ip6", v, "6")
+    for v in range(4)
+])
+def data_basic_send_netkit_psp_assoc(cfg, version, ipver):
+    cfg.require_ipver(ipver)
+    _data_basic_send_netkit_psp_assoc(cfg, version, ipver)
+
+
+
+def _get_nsid(ns_name):
+    """Get the nsid for a namespace."""
+    for entry in ip("netns list-id", json=True):
+        if entry.get("name") == str(ns_name):
+            return entry["nsid"]
+    raise KsftSkipEx(f"nsid not found for namespace {ns_name}")
+
+
+def _setup_psp_attributes(cfg):
+    """
+    Set up PSP-specific attributes on the environment.
+
+    This sets attributes needed for PSP tests based on whether we're using
+    netdevsim or a real NIC.
+    """
+    if cfg._ns is not None:
+        # netdevsim case: PSP device is the local dev (in host namespace)
+        cfg.psp_dev = cfg._ns.nsims[0].dev
+        cfg.psp_ifname = cfg.psp_dev['ifname']
+        cfg.psp_ifindex = cfg.psp_dev['ifindex']
+
+        # PSP peer device is the remote dev (in _netns, where psp_responder runs)
+        cfg.psp_dev_peer = cfg._ns_peer.nsims[0].dev
+        cfg.psp_dev_peer_ifname = cfg.psp_dev_peer['ifname']
+        cfg.psp_dev_peer_ifindex = cfg.psp_dev_peer['ifindex']
+    else:
+        # Real NIC case: PSP device is the local interface
+        cfg.psp_dev = cfg.dev
+        cfg.psp_ifname = cfg.ifname
+        cfg.psp_ifindex = cfg.ifindex
+
+        # PSP peer device is the remote interface
+        cfg.psp_dev_peer = cfg.remote_dev
+        cfg.psp_dev_peer_ifname = cfg.remote_ifname
+        cfg.psp_dev_peer_ifindex = cfg.remote_ifindex
+
+    # Get nsid for the guest namespace (netns) where nk_guest is
+    cfg.psp_dev_peer_nsid = _get_nsid(cfg.netns.name)
+
+
+def _setup_psp_routes(cfg):
+    """
+    Set up routes for cross-namespace connectivity.
+
+    Traffic flows:
+    1. remote (_netns) -> nk_guest (netns):
+       psp_dev_peer -> psp_dev_local -> BPF redirect -> nk_host -> nk_guest
+       Needs: route in _netns to nk_v6_pfx/64 via psp_dev_local
+
+    2. nk_guest (netns) -> remote (_netns):
+       nk_guest -> nk_host -> psp_dev_local -> psp_dev_peer
+       Needs: route in netns to dev_v6_pfx/64 via nk_host
+    """
+    # In _netns (remote namespace): add route to nk_guest prefix via psp_dev_local
+    # psp_dev_peer can reach psp_dev_local via the link, then traffic goes through BPF
+    ip(f"-6 route add {cfg.nk_v6_pfx}/64 via {cfg.nsim_v6_pfx}1 dev {cfg.psp_dev_peer_ifname}",
+       ns=cfg._netns)
+
+    # In netns (guest namespace): add route to remote peer prefix
+    # nk_guest default route goes to nk_host, but we need explicit route to dev_v6_pfx/64
+    ip(f"-6 route add {cfg.nsim_v6_pfx}/64 via fe80::1 dev {cfg._nk_guest_ifname}",
+       ns=cfg.netns)
 
 
-def ipver_test_builder(name, test_func, ipver):
-    """Build test cases for each IP version"""
-    def test_case(cfg):
-        cfg.require_ipver(ipver)
-        test_func(cfg, ipver)
+def main() -> None:
+    """ Ksft boiler plate main """
 
-    test_case.__name__ = f"{name}_ip{ipver}"
-    return test_case
+    # Use a different prefix for netkit guest to avoid conflict with dev prefix
+    nk_v6_pfx = "2001:db9::"
 
+    # Set LOCAL_PREFIX_V6 to a DIFFERENT prefix than the dev prefix to avoid BPF
+    # redirecting psp_responder traffic. The BPF only redirects traffic
+    # matching LOCAL_PREFIX_V6, so dev traffic (2001:db8::) won't be affected.
+    if "LOCAL_PREFIX_V6" not in os.environ:
+        os.environ["LOCAL_PREFIX_V6"] = nk_v6_pfx
 
-def main() -> None:
-    """ Ksft boiler plate main """
+    try:
+        env = NetDrvContEnv(__file__, install_tx_redirect_bpf=True)
+        has_cont = True
+    except KsftSkipEx:
+        env = NetDrvEpEnv(__file__)
+        has_cont = False
 
-    with NetDrvEpEnv(__file__) as cfg:
+    with env as cfg:
         cfg.pspnl = PSPFamily()
 
+        if has_cont:
+            cfg.nk_v6_pfx = nk_v6_pfx
+            _setup_psp_attributes(cfg)
+            _setup_psp_routes(cfg)
+
         # Set up responder and communication sock
+        # psp_responder runs in _netns (remote namespace with psp_dev_peer)
         responder = cfg.remote.deploy("psp_responder")
 
         cfg.comm_port = rand_port()
@@ -611,17 +1002,17 @@ def main() -> None:
                                                           cfg.comm_port),
                                                          timeout=1)
 
-                cases = [
-                    psp_ip_ver_test_builder(
-                        "data_basic_send", _data_basic_send, version, ipver
-                    )
-                    for version in range(0, 4)
-                    for ipver in ("4", "6")
-                ]
-                cases += [
-                    ipver_test_builder("data_mss_adjust", _data_mss_adjust, ipver)
-                    for ipver in ("4", "6")
-                ]
+                cases = [data_basic_send, data_mss_adjust]
+
+                if has_cont:
+                    cases += [
+                        data_basic_send_netkit_psp_assoc,
+                        _key_rotation_notify_multi_ns_netkit,
+                        _dev_change_notify_multi_ns_netkit,
+                        _psp_dev_get_check_netkit_psp_assoc,
+                        _dev_assoc_no_nsid,
+                        _psp_dev_assoc_cleanup_on_netkit_del,
+                    ]
 
                 ksft_run(cases=cases, globs=globals(),
                          case_pfx={"dev_", "data_", "assoc_", "removal_"},
-- 
2.52.0


