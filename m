Return-Path: <netdev+bounces-294976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9ZKnFEzBIGpR7gAAu9opvQ
	(envelope-from <netdev+bounces-294976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:05:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A168963BF8D
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:05:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Bs0bPe/D";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294976-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294976-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D694930BA833
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 23:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA204DD6CD;
	Wed,  3 Jun 2026 23:59:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2324DD6CE
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 23:59:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531199; cv=none; b=HIG8PPG4mcKDwc3RUaXXfdfVJ4AaGeR/zoNpUvqGqwG+QtMwIyxlDU/Vby93ISGYw36y745gX/kCxRyVjxKBpKXybMPtXh6OLvrPteCFAlXLBZwQoZT5eKqR6DfR3odqnsB2tqNmBSjkg4Onq687ay4GOREgISlhwaBETAgmdyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531199; c=relaxed/simple;
	bh=PeELbLb1xCP0BGf+hiuMxRD8R523PQOFQeRljqXbYDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KniPzD27AofYsP0ibGjc7+BIeX9T8GCW2W5u5NDYeN+SKd0nvoC7hJzYeKYi48pBUOgtVl3aoSSfm6QtJnTKrghQe6WmTIryjn9lrbFaNokGjtCgVAqrbztX19xAFX+qAJgE9lguW2ucV9wzigAdUI849hkNK1ndc8IChQvZ6eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bs0bPe/D; arc=none smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7e2cf9bf458so53967b3.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 16:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780531197; x=1781135997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG/d9SJNc8hUXGJwOA61mWz7X78sXE+MB08JZN5IGlc=;
        b=Bs0bPe/DI98o9eDcQKdQ0OFli0atfeFQGh6vDaXhEhdaFZW4UjgHeY6AM8EvI5GCGv
         M/VkY0GGSOowRRdcSkEgOcQBebvhsRyYLd8OXnbcoeRGet2xcqF9OIluI4Aq64jxsG/5
         wXi10X5airR1X2LUkWiIDa1OgCCCDNyPkJZ87Uhv/KDtTy1l3t9QePKP0JgDSQRKl1uN
         o+eOoFkG3H4iTsJHwIKXxlVtuJ3yf1RE/tK2+axnLfv9p+Ryy2Jh+LHNskTAygS4WFbn
         KBdYLDAP2V4mUHGxqLbojgjMXN+Q6ouElL2CLRIBLz91BLn9A1W966GGQhpZh+Qvin06
         0e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531197; x=1781135997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nG/d9SJNc8hUXGJwOA61mWz7X78sXE+MB08JZN5IGlc=;
        b=pt+NHAvyr1d/dWqycPxwXgbS7uln8nMDTLctLCwtcGv1JX8rvze/L7JX/yQDZoW1pG
         YFCbeEWo8DzXb0nUa3md+elf5rsGm89IrSqtXlIq9Sp87m3Ctel80ewOHZfcWtqcfPGF
         OGXtXluPGpeBYaJaEg/Ac9jR7z5FV6Ads1QP2RU3PWg78bawB7QtMMGTYDYKTgl5b0Fc
         sML7twvjIOmVeRol6wUQdPabTRHcaVp3+42h/IO/tm/XF4ND9nFPlQff5yWLXRqFyxZD
         GgCF/lvvoNUDA2IgV8ELqZeQx7duu60JRS/R+W51xBS9WtXkPHW1FK1DM7tAN4LP80/F
         Nv+Q==
X-Gm-Message-State: AOJu0YzeHLsdWC2jH6Zim7TdsoXu0SuheLVNFtkrueIOvkNALgloAemR
	7HjDD1nYsjvifSdMV0DY/glz/KCAHj5Ie6I1lVl10es5a79DKshPoKPR9qTfFg==
X-Gm-Gg: Acq92OG4ocdjBBl46kJURk18Q761ZAbFLewcJFwyWNdTo9jUaxgHbkDwb3hYDaVCpkv
	kpDTMh9LJgRBCcO/WOGYcb1HENdlJXWntE3SSKtLZ1I8vPXa6JUq2NnZodm8yYudKSolF3r5k4+
	q+t7QW0Sf/MLUam8i1P6MeT93xvSQseboaQH1IoC/ZPp5/fQw5Y+Fdxno+JCvsZEOvpwEIsqQW0
	VmGAQcta7NEpcDHqM/HP30fvv5FbBzn4zQU4GI2NneHGf8gzvQKepqmeqhWVVttyRbUPN5k74uo
	dOYtPU/qK8sHvcTLwNZ0m7mKioGuFyYXJv5wXzf3tQUA+p9dTNzRnOrTVpS92PfgwmzMjCfNlak
	l2xMyNOeZPHrwBk7ul/rNXTKmWZloStBkmxktMq9Ba1dGyt9rBzz8ZunE1YMR8xBuCvD7qOh0fL
	VmZ+LE3ei4drk9e4jZOXyMQ2gwvH3fs/RR2j4ciEccWl51
X-Received: by 2002:a05:690c:81:b0:7ba:ee87:87e0 with SMTP id 00721157ae682-7ea2fac76b4mr36081007b3.3.1780531196971;
        Wed, 03 Jun 2026 16:59:56 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23b91689sm24966767b3.40.2026.06.03.16.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:59:56 -0700 (PDT)
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
Subject: [PATCH v15 net-next 07/10] selftests/net: psp: support PSP in NetDrvContEnv infrastructure
Date: Wed,  3 Jun 2026 16:59:36 -0700
Message-ID: <20260603235947.2986110-8-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260603235947.2986110-1-weibunny.kernel@gmail.com>
References: <20260603235947.2986110-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294976-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:daniel.zahka@gmail.com,m:willemdebruijn.kernel@gmail.com,m:dw@davidwei.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:weibunny@fb.com,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,vger.kernel.org:from_smtp,fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netns.name:url,cfg.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A168963BF8D

From: Wei Wang <weibunny@fb.com>

Add infrastructure to support PSP tests across network namespaces
using NetDrvContEnv with netkit pairs. This enables testing PSP device
association, where a non-PSP-capable device (e.g. netkit) in a guest
namespace is associated with a real PSP device in the host namespace,
allowing the guest to perform PSP encryption/decryption through the
host's PSP hardware.

The topology is:
  Host NS:  psp_dev_local <---> nk_host
                |                  |
                |                  | (netkit pair)
                |                  |
  Remote NS: psp_dev_peer      Guest NS: nk_guest
             (responder)             (PSP tests)

env.py:
- nk_guest_ifindex is queried after moving the device into the guest
  namespace, so tests can use it directly for dev-assoc

psp.py:
- PSP device lookup supports container environments where the PSP
  device is on the physical interface, not the test interface
- Association helpers handle dev-assoc/dev-disassoc with defer-based
  cleanup to prevent state leaks on test assertion failures
- main() tries NetDrvContEnv with primary_rx_redirect and falls back
  to NetDrvEpEnv, so existing tests continue to work without the
  container environment

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 tools/testing/selftests/drivers/net/config    |   1 +
 .../selftests/drivers/net/lib/py/env.py       |   7 +-
 tools/testing/selftests/drivers/net/psp.py    | 102 +++++++++++++++++-
 3 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index 617de8aaf551..91d4fd410914 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -8,6 +8,7 @@ CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
 CONFIG_NETDEVSIM=m
+CONFIG_NETKIT=y
 CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_FQ=m
 CONFIG_PPP=y
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 1d8964538abb..89a39c8b2cb1 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -337,7 +337,8 @@ class NetDrvContEnv(NetDrvEpEnv):
               +---------------+
     """
 
-    def __init__(self, src_path, rxqueues=1, primary_rx_redirect=False, **kwargs):
+    def __init__(self, src_path, rxqueues=1,
+                 primary_rx_redirect=False, **kwargs):
         self.netns = None
         self.nk_host_ifname = None
         self.nk_guest_ifname = None
@@ -351,7 +352,6 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._remote_route_added = False
         self._old_fwd = None
         self._old_accept_ra = None
-
         super().__init__(src_path, **kwargs)
 
         self.require_ipver("6")
@@ -468,6 +468,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._init_ns_attached = True
         ip("netns set init 0", ns=self.netns)
         ip(f"link set dev {self.nk_guest_ifname} netns {self.netns.name}")
+        nk_guest_dev = ip(f"link show dev {self.nk_guest_ifname}",
+                          json=True, ns=self.netns)[0]
+        self.nk_guest_ifindex = nk_guest_dev['ifindex']
         ip(f"link set dev {self.nk_host_ifname} up")
         ip(f"-6 addr add fe80::1/64 dev {self.nk_host_ifname} nodad")
         ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self.nk_host_ifname}")
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 6d5114be4c88..015af92c8d7b 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -5,6 +5,7 @@
 
 import errno
 import fcntl
+import os
 import socket
 import struct
 import termios
@@ -16,8 +17,10 @@ from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises
 from lib.py import ksft_not_none
 from lib.py import ksft_variants, KsftNamedVariant
 from lib.py import KsftSkipEx
-from lib.py import NetDrvEpEnv, PSPFamily, NlError
+from lib.py import NetDrvEpEnv, NetDrvContEnv
+from lib.py import NlError, PSPFamily
 from lib.py import bkg, rand_port, wait_port_listen
+from lib.py import ip
 
 
 def _get_outq(s):
@@ -118,11 +121,13 @@ def _get_stat(cfg, key):
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
@@ -597,13 +602,102 @@ def data_mss_adjust(cfg, ipver):
     _data_mss_adjust(cfg, ipver)
 
 
+def _try_disassoc(cfg, psp_dev_id, ifindex, nsid=None):
+    """Best-effort disassociate, ignoring errors if already removed."""
+    try:
+        params = {'id': psp_dev_id, 'ifindex': ifindex}
+        if nsid is not None:
+            params['nsid'] = nsid
+        cfg.pspnl.dev_disassoc(params)
+    except NlError:
+        pass
+
+
+def _assoc_nk_guest(cfg):
+    """Associate nk_guest with PSP device and register cleanup via defer()."""
+    _init_psp_dev(cfg, True)
+
+    cfg.pspnl.dev_assoc({'id': cfg.psp_dev_id,
+                         'ifindex': cfg.nk_guest_ifindex,
+                         'nsid': cfg.psp_dev_peer_nsid})
+    defer(_disassoc_nk_guest, cfg,
+          cfg.psp_dev_id, cfg.nk_guest_ifindex)
+
+
+def _disassoc_nk_guest(cfg, psp_dev_id, nk_guest_ifindex):
+    """Disassociate nk_guest and reset cfg PSP state."""
+    pspnl = PSPFamily()
+    pspnl.dev_disassoc({'id': psp_dev_id, 'ifindex': nk_guest_ifindex,
+                        'nsid': cfg.psp_dev_peer_nsid})
+    cfg.pspnl = pspnl
+    del cfg.psp_dev_id
+    del cfg.psp_info
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
+    # pylint: disable=protected-access
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
+
 def main() -> None:
     """ Ksft boiler plate main """
 
-    with NetDrvEpEnv(__file__) as cfg:
+    # Make sure LOCAL_PREFIX_V6 is set
+    if "LOCAL_PREFIX_V6" not in os.environ:
+        os.environ["LOCAL_PREFIX_V6"] = "2001:db8:2::"
+
+    try:
+        env = NetDrvContEnv(__file__, primary_rx_redirect=True)
+        has_cont = True
+    except KsftSkipEx:
+        env = NetDrvEpEnv(__file__)
+        has_cont = False
+
+    with env as cfg:
         cfg.pspnl = PSPFamily()
 
+        if has_cont:
+            _setup_psp_attributes(cfg)
+
         # Set up responder and communication sock
+        # psp_responder runs in _netns (remote namespace with psp_dev_peer)
         responder = cfg.remote.deploy("psp_responder")
 
         cfg.comm_port = rand_port()
-- 
2.52.0


