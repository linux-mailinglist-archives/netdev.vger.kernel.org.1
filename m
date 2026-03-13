Return-Path: <netdev+bounces-267625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCVwAruQtGl0qAAAu9opvQ
	(envelope-from <netdev+bounces-267625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:33:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DB628A732
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F15443070350
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C636E349B02;
	Fri, 13 Mar 2026 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="E7ORItEy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746EE347FED
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 22:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441087; cv=none; b=eV77G/8IBzvVbfhB2I8TFRu0/98F+NhgmOu6VhhFdsWpoPRA0gMW43LTwDY+rAPUNrfkh35pYmoPI9AYT6MUuys12YNtp0PpDdp2CQIC1D/UYxsmSJqfI5ZSbc54QdT/iePuETkMNVTkQNqWPt3CEYIf9ttYgKK6wQPbQLthrBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441087; c=relaxed/simple;
	bh=2lzl/2RT7wIvpJF2a1jM2tWT4AtAyL3brJmMBvXZMg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfXfNxYWYUH+xSa+6L+WjlnFgxDlKFnkCxaNnG9yKNuUsv8Cx4kBYhawBpj2cRYxnYmYDdkF9lrsQPbFFQMQUvUDY4vXSfbX98iLNlqMXzV9fjaw8c8Jgpo437tIZPCbo0GUVOfWN81WsrpGoDfW7C0XrT4+LrPbCOpsy+p6MvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=E7ORItEy; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4648447e29bso1045615b6e.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773441084; x=1774045884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NXcw/JA6oIFNRUPT/PH/GzRu0gFhvGGRdpsNeUi2W4=;
        b=E7ORItEyM52dMdxlnIexAxYhK4JI27mMzd9rrqJWPFStKar8PeLx2xdaZBWIARUu9X
         nhUaFpjPfByje3expdXWR9h8xloGegXmLLoy0dWwpxG9R06QqNc/UYe5Y9V4lf5qDL7D
         rFVAU5N316InffeHLczvveLHzSjadYPfmfRtqFJgKi3n04D1aIgyirNC8MVLMgBRPbDF
         yEvMvJrqaNVcE8Gba3fjCA5O6lfDLgbZrV6ooovMWxFskYk7Uhyw/6fm3c4cyLsLNIio
         1MYSgyeUREGBjmzOlfvJxCvKoHBycEgtcnUK9fObO9OAwIgeciWFJ4lleCQnUHr9dVCL
         xuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773441084; x=1774045884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NXcw/JA6oIFNRUPT/PH/GzRu0gFhvGGRdpsNeUi2W4=;
        b=qlNTb2gr8/bLmdU3BeZGJpf0vFQC0BYOGBYrHuhuxk1bugi4xpkRfQ+AW1wyiQTmRM
         b++KFvhukEjpeWM1nYKLIv9RzRv+jHakEwURsQf2bO1EqEh5x5+G3Ob9/C5ICxJEBqfu
         9/NVFkZG9pY7c+Zt8mCf1jWfUNVTLuYeXIt3/AQllLaxl8PoDQsnSPJAzlUqJQU219DX
         tyF4dlmEwg7PjXnNX4goazmTxuyKO98+CuI0S/5z3hn6Uein5/7JKDqB4UKzFSK7U1Ji
         5fgLN0Ha79QP7QokFvF2Xz8CdXPVjpW85gyXiGyhaL6+CfgajxfcN3/xDoS7HPuANlL+
         VWww==
X-Forwarded-Encrypted: i=1; AJvYcCWCUDHdhU4GkV9ujZxXF0wC4nfkoZZ20bu35ajpjLuYZrbXm9kLL3zzUV5fX/Sg5/HGy47iT5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUzhubLBNcfKxSv/7VNguvgvCBFznJUjwpIRnEy+AMBKUHl94r
	UL5wiDpLvv3sN3moR7nE1meixh1yKEuaVi6kJbU3+ibI2kUnbshkufQLo4XET8q0JVw=
X-Gm-Gg: ATEYQzwDlpmfNSeEgCuVZlqKNpkhNvPOL7NajG4cDGFQHkBveCMd9hMHDJw4A8Ea9Ax
	c/XKyGDHvW7KHYpgJVdleF0BeDggoAO4/GS4lTv+fRuUaV7oV0mOrPbKyAy5qy8G8lTKCQXlETl
	BbPd7s6hyH4lOHRkXWmYQqL1JEo51Ai6vUtAbsZqZ+F6CRIYq1uXbqU5rONlUdiPBG622oW4pmx
	nlOMyVQ0fOz4R81RMbRRmMHQx/nw6VUErzVCye/GrKo52/OBcRDfU03ckZTdkSDjeX0BkEHE7Jt
	xKWLvlfcatgbQktTdOTo5iuSYa0270TI0yJgZB+Cg/WMolH2L86jRYHkefKRO4A5OdII05WWtwO
	lgThWd5E9D6dhzJRX8YC4Pw0aG7O3EaeevHHxAFndE1MK1BrQoLYGMMsaAEb30nBy4aao3y22qf
	lsmfTXwa1KUZITw0r0xiY=
X-Received: by 2002:a05:6808:6f90:b0:45c:9927:3f33 with SMTP id 5614622812f47-467570a58c6mr2487530b6e.19.1773441084371;
        Fri, 13 Mar 2026 15:31:24 -0700 (PDT)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::22f:7d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342fab49sm5408516b6e.16.2026.03.13.15.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:31:23 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	David Wei <dw@davidwei.uk>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Chris J Arges <carges@cloudflare.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Nimrod Oren <noren@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4 5/6] selftests: net: move common xdp.py functions into lib
Date: Fri, 13 Mar 2026 17:27:35 -0500
Message-ID: <20260313223029.454755-6-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313223029.454755-1-carges@cloudflare.com>
References: <20260313223029.454755-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267625-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[dama.to,kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,davidwei.uk,nvidia.com,cloudflare.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,dama.to:email]
X-Rspamd-Queue-Id: 75DB628A732
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This moves a few functions which can be useful to other python programs
that manipulate XDP programs. This also refactors xdp.py to use the
refactored functions.

Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
v4: rebase only
---
 .../selftests/drivers/net/lib/py/__init__.py  |  2 +
 tools/testing/selftests/drivers/net/xdp.py    | 95 +++++--------------
 .../testing/selftests/net/lib/py/__init__.py  |  2 +
 tools/testing/selftests/net/lib/py/bpf.py     | 68 +++++++++++++
 4 files changed, 95 insertions(+), 72 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib/py/bpf.py

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 374d4f08dd05..2b5ec0505672 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -24,6 +24,7 @@ try:
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
         fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, wait_file
+    from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup, ksft_variants, KsftNamedVariant
@@ -37,6 +38,7 @@ try:
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
                "fd_read_timeout", "ip", "rand_port", "rand_ports",
                "wait_port_listen", "wait_file",
+               "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
                "ksft_setup", "ksft_variants", "KsftNamedVariant",
diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index e54df158dfe9..10d821156db1 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -16,7 +16,8 @@ from lib.py import KsftNamedVariant, ksft_variants
 from lib.py import KsftFailEx, NetDrvEpEnv
 from lib.py import EthtoolFamily, NetdevFamily, NlError
 from lib.py import bkg, cmd, rand_port, wait_port_listen
-from lib.py import ip, bpftool, defer
+from lib.py import ip, defer
+from lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
 
 
 class TestConfig(Enum):
@@ -122,47 +123,11 @@ def _load_xdp_prog(cfg, bpf_info):
     xdp_info = ip(f"-d link show dev {cfg.ifname}", json=True)[0]
     prog_info["id"] = xdp_info["xdp"]["prog"]["id"]
     prog_info["name"] = xdp_info["xdp"]["prog"]["name"]
-    prog_id = prog_info["id"]
-
-    map_ids = bpftool(f"prog show id {prog_id}", json=True)["map_ids"]
-    prog_info["maps"] = {}
-    for map_id in map_ids:
-        name = bpftool(f"map show id {map_id}", json=True)["name"]
-        prog_info["maps"][name] = map_id
+    prog_info["maps"] = bpf_prog_map_ids(prog_info["id"])
 
     return prog_info
 
 
-def format_hex_bytes(value):
-    """
-    Helper function that converts an integer into a formatted hexadecimal byte string.
-
-    Args:
-        value: An integer representing the number to be converted.
-
-    Returns:
-        A string representing hexadecimal equivalent of value, with bytes separated by spaces.
-    """
-    hex_str = value.to_bytes(4, byteorder='little', signed=True)
-    return ' '.join(f'{byte:02x}' for byte in hex_str)
-
-
-def _set_xdp_map(map_name, key, value):
-    """
-    Updates an XDP map with a given key-value pair using bpftool.
-
-    Args:
-        map_name: The name of the XDP map to update.
-        key: The key to update in the map, formatted as a hexadecimal string.
-        value: The value to associate with the key, formatted as a hexadecimal string.
-    """
-    key_formatted = format_hex_bytes(key)
-    value_formatted = format_hex_bytes(value)
-    bpftool(
-        f"map update name {map_name} key hex {key_formatted} value hex {value_formatted}"
-    )
-
-
 def _get_stats(xdp_map_id):
     """
     Retrieves and formats statistics from an XDP map.
@@ -177,25 +142,11 @@ def _get_stats(xdp_map_id):
     Raises:
         KsftFailEx: If the stats retrieval fails.
     """
-    stats_dump = bpftool(f"map dump id {xdp_map_id}", json=True)
-    if not stats_dump:
+    stats = bpf_map_dump(xdp_map_id)
+    if not stats:
         raise KsftFailEx(f"Failed to get stats for map {xdp_map_id}")
 
-    stats_formatted = {}
-    for key in range(0, 5):
-        val = stats_dump[key]["formatted"]["value"]
-        if stats_dump[key]["formatted"]["key"] == XDPStats.RX.value:
-            stats_formatted[XDPStats.RX.value] = val
-        elif stats_dump[key]["formatted"]["key"] == XDPStats.PASS.value:
-            stats_formatted[XDPStats.PASS.value] = val
-        elif stats_dump[key]["formatted"]["key"] == XDPStats.DROP.value:
-            stats_formatted[XDPStats.DROP.value] = val
-        elif stats_dump[key]["formatted"]["key"] == XDPStats.TX.value:
-            stats_formatted[XDPStats.TX.value] = val
-        elif stats_dump[key]["formatted"]["key"] == XDPStats.ABORT.value:
-            stats_formatted[XDPStats.ABORT.value] = val
-
-    return stats_formatted
+    return stats
 
 
 def _test_pass(cfg, bpf_info, msg_sz):
@@ -211,8 +162,8 @@ def _test_pass(cfg, bpf_info, msg_sz):
     prog_info = _load_xdp_prog(cfg, bpf_info)
     port = rand_port()
 
-    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.PASS.value)
-    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+    bpf_map_set("map_xdp_setup", TestConfig.MODE.value, XDPAction.PASS.value)
+    bpf_map_set("map_xdp_setup", TestConfig.PORT.value, port)
 
     ksft_eq(_test_udp(cfg, port, msg_sz), True, "UDP packet exchange failed")
     stats = _get_stats(prog_info["maps"]["map_xdp_stats"])
@@ -258,8 +209,8 @@ def _test_drop(cfg, bpf_info, msg_sz):
     prog_info = _load_xdp_prog(cfg, bpf_info)
     port = rand_port()
 
-    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.DROP.value)
-    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+    bpf_map_set("map_xdp_setup", TestConfig.MODE.value, XDPAction.DROP.value)
+    bpf_map_set("map_xdp_setup", TestConfig.PORT.value, port)
 
     ksft_eq(_test_udp(cfg, port, msg_sz), False, "UDP packet exchange should fail")
     stats = _get_stats(prog_info["maps"]["map_xdp_stats"])
@@ -305,8 +256,8 @@ def _test_xdp_native_tx(cfg, bpf_info, payload_lens):
     prog_info = _load_xdp_prog(cfg, bpf_info)
     port = rand_port()
 
-    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.TX.value)
-    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+    bpf_map_set("map_xdp_setup", TestConfig.MODE.value, XDPAction.TX.value)
+    bpf_map_set("map_xdp_setup", TestConfig.PORT.value, port)
 
     expected_pkts = 0
     for payload_len in payload_lens:
@@ -454,15 +405,15 @@ def _test_xdp_native_tail_adjst(cfg, pkt_sz_lst, offset_lst):
     prog_info = _load_xdp_prog(cfg, bpf_info)
 
     # Configure the XDP map for tail adjustment
-    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.TAIL_ADJST.value)
-    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+    bpf_map_set("map_xdp_setup", TestConfig.MODE.value, XDPAction.TAIL_ADJST.value)
+    bpf_map_set("map_xdp_setup", TestConfig.PORT.value, port)
 
     for offset in offset_lst:
         tag = format(random.randint(65, 90), "02x")
 
-        _set_xdp_map("map_xdp_setup", TestConfig.ADJST_OFFSET.value, offset)
+        bpf_map_set("map_xdp_setup", TestConfig.ADJST_OFFSET.value, offset)
         if offset > 0:
-            _set_xdp_map("map_xdp_setup", TestConfig.ADJST_TAG.value, int(tag, 16))
+            bpf_map_set("map_xdp_setup", TestConfig.ADJST_TAG.value, int(tag, 16))
 
         for pkt_sz in pkt_sz_lst:
             test_str = "".join(random.choice(string.ascii_lowercase) for _ in range(pkt_sz))
@@ -574,8 +525,8 @@ def _test_xdp_native_head_adjst(cfg, prog, pkt_sz_lst, offset_lst):
     prog_info = _load_xdp_prog(cfg, BPFProgInfo(prog, "xdp_native.bpf.o", "xdp.frags", 9000))
     port = rand_port()
 
-    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.HEAD_ADJST.value)
-    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+    bpf_map_set("map_xdp_setup", TestConfig.MODE.value, XDPAction.HEAD_ADJST.value)
+    bpf_map_set("map_xdp_setup", TestConfig.PORT.value, port)
 
     hds_thresh = get_hds_thresh(cfg)
     for offset in offset_lst:
@@ -595,11 +546,11 @@ def _test_xdp_native_head_adjst(cfg, prog, pkt_sz_lst, offset_lst):
             test_str = ''.join(random.choice(string.ascii_lowercase) for _ in range(pkt_sz))
             tag = format(random.randint(65, 90), '02x')
 
-            _set_xdp_map("map_xdp_setup",
+            bpf_map_set("map_xdp_setup",
                      TestConfig.ADJST_OFFSET.value,
                      offset)
-            _set_xdp_map("map_xdp_setup", TestConfig.ADJST_TAG.value, int(tag, 16))
-            _set_xdp_map("map_xdp_setup", TestConfig.ADJST_OFFSET.value, offset)
+            bpf_map_set("map_xdp_setup", TestConfig.ADJST_TAG.value, int(tag, 16))
+            bpf_map_set("map_xdp_setup", TestConfig.ADJST_OFFSET.value, offset)
 
             recvd_str = _exchg_udp(cfg, port, test_str)
 
@@ -691,8 +642,8 @@ def test_xdp_native_qstats(cfg, act):
     prog_info = _load_xdp_prog(cfg, bpf_info)
     port = rand_port()
 
-    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, act.value)
-    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+    bpf_map_set("map_xdp_setup", TestConfig.MODE.value, act.value)
+    bpf_map_set("map_xdp_setup", TestConfig.PORT.value, port)
 
     # Discard the input, but we need a listener to avoid ICMP errors
     rx_udp = f"socat -{cfg.addr_ipver} -T 2 -u UDP-RECV:{port},reuseport " + \
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index e0c920041a58..7c81d86a7e97 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -15,6 +15,7 @@ from .nsim import NetdevSim, NetdevSimDev
 from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     bpftool, ip, ethtool, bpftrace, rand_port, rand_ports, wait_port_listen, \
     wait_file, tool
+from .bpf import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
 from .ynl import NlError, NlctrlFamily, YnlFamily, \
     EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
 from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, Netlink
@@ -29,6 +30,7 @@ __all__ = ["KSRC",
            "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
            "bpftool", "ip", "ethtool", "bpftrace", "rand_port", "rand_ports",
            "wait_port_listen", "wait_file", "tool",
+           "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
            "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
diff --git a/tools/testing/selftests/net/lib/py/bpf.py b/tools/testing/selftests/net/lib/py/bpf.py
new file mode 100644
index 000000000000..96b29d41c34b
--- /dev/null
+++ b/tools/testing/selftests/net/lib/py/bpf.py
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+BPF helper utilities for kernel selftests.
+
+Provides common operations for interacting with BPF maps and programs
+via bpftool, used by XDP and other BPF-based test files.
+"""
+
+from .utils import bpftool
+
+def format_hex_bytes(value):
+    """
+    Helper function that converts an integer into a formatted hexadecimal byte string.
+
+    Args:
+        value: An integer representing the number to be converted.
+
+    Returns:
+        A string representing hexadecimal equivalent of value, with bytes separated by spaces.
+    """
+    hex_str = value.to_bytes(4, byteorder='little', signed=True)
+    return ' '.join(f'{byte:02x}' for byte in hex_str)
+
+
+def bpf_map_set(map_name, key, value):
+    """
+    Updates an XDP map with a given key-value pair using bpftool.
+
+    Args:
+        map_name: The name of the XDP map to update.
+        key: The key to update in the map, formatted as a hexadecimal string.
+        value: The value to associate with the key, formatted as a hexadecimal string.
+    """
+    key_formatted = format_hex_bytes(key)
+    value_formatted = format_hex_bytes(value)
+    bpftool(
+        f"map update name {map_name} key hex {key_formatted} value hex {value_formatted}"
+    )
+
+def bpf_map_dump(map_id):
+    """Dump all entries of a BPF array map.
+
+    Args:
+        map_id: Numeric map ID (as returned by bpftool prog show).
+
+    Returns:
+        A dict mapping formatted key (int) to formatted value (int).
+    """
+    raw = bpftool(f"map dump id {map_id}", json=True)
+    return {e["formatted"]["key"]: e["formatted"]["value"] for e in raw}
+
+
+def bpf_prog_map_ids(prog_id):
+    """Get the map name-to-ID mapping for a loaded BPF program.
+
+    Args:
+        prog_id: Numeric program ID.
+
+    Returns:
+        A dict mapping map name (str) to map ID (int).
+    """
+    map_ids = bpftool(f"prog show id {prog_id}", json=True)["map_ids"]
+    maps = {}
+    for mid in map_ids:
+        name = bpftool(f"map show id {mid}", json=True)["name"]
+        maps[name] = mid
+    return maps
-- 
2.43.0


