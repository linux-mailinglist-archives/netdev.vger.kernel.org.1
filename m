Return-Path: <netdev+bounces-285622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNzxAkNn/WlhdQAAu9opvQ
	(envelope-from <netdev+bounces-285622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 06:32:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF5C4F18B0
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 06:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 267AE3054C24
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 04:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0D332AAD6;
	Fri,  8 May 2026 04:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2/kYR9z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3901250BF2
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 04:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214385; cv=none; b=c/ccwlXR/WxGRncDYabbZsF7FXx30uWl6BK47m6Q4uGDZC7EEla8HdRCyGpCpOkgQM3AIIzT0r2n4o8pfHUPmwdz3ufU4aSSJjf9grs80V+ndx8tPRGtHAMmDoA1aBWalPfPoF3rMrwhX2fnpKg0Gu3gGx6v5K+u95eUYyqGCM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214385; c=relaxed/simple;
	bh=IVGl7m9fiCQZn/3ieOtZfoVT17Rqx+bmXBLBlaZYtNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAhuMhy8jbO+af9XtqTCSpiuB/UvfMhU4Wd/DH4X9LJUojEqcY008VWJE5mHpxjge8M5eYFq9k0iSnak4lprWoHGl7XS3YUhPV3t7zJAf/oPAHe0JWfDBq0wQwIoUuGNs4khdKJQFYHKWOixE5RQJSBQJtKBKHBq4MLiAKl6M6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2/kYR9z; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7bd89999b0bso740407b3.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 21:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778214382; x=1778819182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gw0KDtGcanEkrz57ug8eAHTB2lSFzB3FGPMtubiSKLQ=;
        b=X2/kYR9zL5wMRpzxV4dTvrxjvf24u8rgOPDi+qv0sObxBWx8gY1dyoz68V0labL3nC
         uA+kTI+wDTAv0CKweSXkcdjD+z6L9EKseaBU6cvQFctniS5cVSFmzj3ebN5JpSmo1m+y
         NJq36Ggb1GME+VVzj3Ga77ADBjkcnNMEYMUCwQiAHmytg8N8J3mfgtkOBDHPJnEbbWy0
         mOiDxkD1dcnv/1JXWeERMP4OjSEw49HRH0E+SD+n5FVKZULTDAaEf7hThKCTsBddbcP6
         QH+QI6gFuuDQG4Z/hZzvMi7Nov9T/wMjcLzCgqD0wzGlSes97WYpkM9DsMCD5iaNawa1
         6+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778214382; x=1778819182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gw0KDtGcanEkrz57ug8eAHTB2lSFzB3FGPMtubiSKLQ=;
        b=cpOIsU7MOJzzraldbMr085OTctEwb8BvdBDH+op2Vp2U5OMwW0qjV36CiLERH9UHgA
         KNRQPof1rwumv17OQtGAPWbp109gGIfRalYBIeFdVrJnyS+M1LPP5zeBTti3xM6PIEE2
         T5RTYfAp9hko4cjGuIPdO7k5smJweduxjFpQoyuY7pOTmWxrMdVdg0kEHwIazuYhZhMX
         qBor7qMtzCnwn6Fp3V6bwmaZIIKZSviKjl459QewxB+g9GUZdp6JF0SZmzJLiaJf+nb3
         TdcorJuxdpDS12tiGF/xx3zAc7R24U3HpNQVd4vqERSyJ8tRZMq1c/qqZ4AxQEHMQy6Q
         XAPQ==
X-Gm-Message-State: AOJu0YznSfcSIV6n4Y3chKbB9Dj0eWBK8hWccPhXF90k4WppnqbrySmb
	Ud4rNCJe9/NYu1WH9S9jc9KZQGhz4g8mbqYPBwkwARN0mnJHakSwDG2ZvlhEgg==
X-Gm-Gg: Acq92OGw7rm6RQe1wu/FE89ppKPptz38H/QNjafzGzMhxfAXnlBEEICqezpXtesJ73J
	S36Q3Jlh8DGaNEthtSftCc/ztidbUHeI0P1FNP7WOJr1iLt+VIuLK9aUe46FJETBr1loLs5mZNT
	rqSSz8XvNNQCBZ7m9Z7ao/Jf0lpAOj+B1M3EFPLKbEarxjj0DDw446ml6UTAL1mOeYCRfNibY3E
	jFYX2hcuO8Nl6iHYk0W9YAiCHlFcY4ZhcoEWEKyUsKIFuDOJKyjKVpbfAUyJKQDQeQnetFFYcDs
	4W5qehSsWyv06LkcSFn6rbYOOu+wwKchGv6c0J37yueEsJEh8hWOMhxjhaJDWU/VEz2brmfeXmW
	qVgXy1oQEeP5ekGZUdPUhlhcXsFiKfV4mA04VD772pG8o/lAw07/542zh9zkHr7n2JiU3PUPc7i
	OfALZpnovu5oI6J8v56E6F3Kc=
X-Received: by 2002:a05:690c:9c0a:b0:7b7:4f5e:6f6a with SMTP id 00721157ae682-7bdf5ee5c11mr70041127b3.6.1778214381841;
        Thu, 07 May 2026 21:26:21 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6652744asm105507167b3.1.2026.05.07.21.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 21:26:21 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v14 net-next 5/5] selftests/net: psp: Add test for dev-assoc/disassoc
Date: Thu,  7 May 2026 21:26:10 -0700
Message-ID: <20260508042611.130945-6-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508042611.130945-1-weibunny.kernel@gmail.com>
References: <20260508042611.130945-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5DF5C4F18B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285622-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fb.com:email,netns.name:url]
X-Rspamd-Action: no action

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
 .../selftests/drivers/net/lib/py/env.py       |  69 ++-
 tools/testing/selftests/drivers/net/psp.py    | 435 ++++++++++++++++--
 3 files changed, 468 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index 2309109a94ec..d8a755e01166 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -10,5 +10,6 @@ CONFIG_NETCONSOLE_EXTENDED_LOG=y
 CONFIG_NETDEVSIM=m
 CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_FQ=m
+CONFIG_NETKIT=y
 CONFIG_VLAN_8021Q=m
 CONFIG_XDP_SOCKETS=y
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 24ce122abd9c..c8045e1ee00d 100644
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
@@ -476,10 +485,19 @@ class NetDrvContEnv(NetDrvEpEnv):
                 return (bpf['pref'], bpf['options']['prog']['id'])
         raise Exception("Failed to get BPF prog ID")
 
+    def _find_bpf_obj(self, name):
+        bpf_obj = self.test_dir / name
+        if bpf_obj.exists():
+            return bpf_obj
+        bpf_obj = self.test_dir / "hw" / name
+        if bpf_obj.exists():
+            return bpf_obj
+        return None
+
     def _attach_bpf(self):
-        bpf_obj = self.test_dir / "nk_forward.bpf.o"
-        if not bpf_obj.exists():
-            raise KsftSkipEx("BPF prog not found")
+        bpf_obj = self._find_bpf_obj("nk_forward.bpf.o")
+        if not bpf_obj:
+            raise KsftSkipEx("BPF prog nk_forward.bpf.o not found")
 
         self._tc_ensure_clsact()
         cmd(f"tc filter add dev {self.ifname} ingress bpf obj {bpf_obj}"
@@ -505,3 +523,46 @@ class NetDrvContEnv(NetDrvEpEnv):
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
+        bpf_obj = self._find_bpf_obj("nk_redirect.bpf.o")
+        if not bpf_obj:
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
index 864d9fce1094..bafdc48ee7e3 100755
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
@@ -394,6 +400,270 @@ def _data_basic_send(cfg, version, ipver):
     _close_psp_conn(cfg, s)
 
 
+def _assoc_nk_guest(cfg):
+    """Associate nk_guest with PSP device and register cleanup via defer()."""
+    _init_psp_dev(cfg, True)
+    psp_dev_id = cfg.psp_dev_id
+
+    nk_guest_dev = ip(f"link show dev {cfg._nk_guest_ifname}", json=True, ns=cfg.netns)[0]
+    nk_guest_ifindex = nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+    defer(_disassoc_nk_guest, cfg, psp_dev_id, nk_guest_ifindex)
+
+    return psp_dev_id, nk_guest_ifindex
+
+
+def _disassoc_nk_guest(cfg, psp_dev_id, nk_guest_ifindex):
+    """Disassociate nk_guest and reset cfg PSP state."""
+    pspnl = PSPFamily()
+    pspnl.dev_disassoc({'id': psp_dev_id, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+    cfg.pspnl = pspnl
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
+def _data_basic_send_netkit_psp_assoc(cfg, version, ipver):
+    """
+    Test basic data send with netkit interface associated with PSP dev.
+    """
+    psp_dev_id, nk_guest_ifindex = _assoc_nk_guest(cfg)
+
+    # Check if assoc-list contains nk_guest
+    dev_info = cfg.pspnl.dev_get({'id': psp_dev_id})
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
+
+def _key_rotation_notify_multi_ns_netkit(cfg):
+    """ Test key rotation notifications across multiple namespaces using netkit """
+    psp_dev_id, _ = _assoc_nk_guest(cfg)
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
+    cfg.pspnl.key_rotate({"id": psp_dev_id})
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
+        ksft_true(msg['msg'].get('id') == psp_dev_id,
+                  f"Key rotation notification for correct device not found in {label} namespace")
+
+
+def _dev_change_notify_multi_ns_netkit(cfg):
+    """ Test dev_change notifications across multiple namespaces using netkit """
+    psp_dev_id, _ = _assoc_nk_guest(cfg)
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
+    cfg.pspnl.dev_set({'id': psp_dev_id, 'psp-versions-ena': cfg.psp_info['psp-versions-cap']})
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
+        ksft_true(msg['msg'].get('id') == psp_dev_id,
+                  f"Dev_change notification for correct device not found in {label} namespace")
+
+
+def _psp_dev_get_check_netkit_psp_assoc(cfg):
+    """ Check psp dev-get output with netkit interface associated with PSP dev """
+    psp_dev_id, nk_guest_ifindex = _assoc_nk_guest(cfg)
+
+    # Check 1: In default netns, verify dev-get has correct ifindex and assoc-list
+    dev_info = cfg.pspnl.dev_get({'id': psp_dev_id})
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
+    defer(delattr, cfg, 'psp_dev_id')
+    defer(delattr, cfg, 'psp_info')
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
+
+def _psp_dev_assoc_cleanup_on_netkit_del(cfg):
+    """ Test that assoc-list is cleared when associated netkit interface is deleted.
+    WARNING: This test destroys the netkit pair. It must be the last
+    container-dependent test in the cases list.
+    """
+    _init_psp_dev(cfg, True)
+    psp_dev_id = cfg.psp_dev_id
+    defer(delattr, cfg, 'psp_dev_id')
+    defer(delattr, cfg, 'psp_info')
+
+    # Associate PSP device with nk_guest interface (in guest namespace)
+    nk_guest_dev = ip(f"link show dev {cfg._nk_guest_ifname}", json=True, ns=cfg.netns)[0]
+    nk_guest_ifindex = nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    # Verify assoc-list exists in default netns
+    dev_info = cfg.pspnl.dev_get({'id': psp_dev_id})
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
+    cfg._nk_host_tc_attached = False
+    cfg._tc_attached = False
+
+    # Verify assoc-list is gone in default netns after netkit deletion
+    dev_info = cfg.pspnl.dev_get({'id': psp_dev_id})
+    ksft_true('assoc-list' not in dev_info or len(dev_info['assoc-list']) == 0,
+              "assoc-list should be empty after netkit deletion")
+
+
 def __bad_xfer_do(cfg, s, tx, version='hdr0-aes-gcm-128'):
     # Make sure we accept the ACK for the SPI before we seal with the bad assoc
     _check_data_outq(s, 0)
@@ -571,33 +841,131 @@ def removal_device_bi(cfg):
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
+    local_v6 = cfg.addr_v["6"]
+    remote_v6 = cfg.remote_addr_v["6"]
+
+    # In remote (netns or host): add route to nk_guest prefix via psp_dev_local
+    # psp_dev_peer can reach psp_dev_local via the link, then traffic goes through BPF
+    ip(f"-6 route add {cfg.nk_v6_pfx}/64 via {local_v6} dev {cfg.psp_dev_peer_ifname}",
+       ns=cfg._netns, host=cfg.remote if cfg._ns is None else None)
+
+    # In netns (guest namespace): add route to remote peer address
+    # nk_guest default route goes to nk_host, but we need explicit route to
+    # reach the remote peer where psp_responder runs
+    ip(f"-6 route add {remote_v6}/128 via fe80::1 dev {cfg._nk_guest_ifname}",
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
@@ -611,17 +979,18 @@ def main() -> None:
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
+                        # Must be last - destroys the netkit pair
+                        _psp_dev_assoc_cleanup_on_netkit_del,
+                    ]
 
                 ksft_run(cases=cases, globs=globals(),
                          case_pfx={"dev_", "data_", "assoc_", "removal_"},
-- 
2.52.0


