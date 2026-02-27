Return-Path: <netdev+bounces-261934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKFIBYXYoWlcwgQAu9opvQ
	(envelope-from <netdev+bounces-261934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:46:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A28CF1BB999
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F12CC31A1071
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D2844BC9B;
	Fri, 27 Feb 2026 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="E200HiXe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C9C44BCBA
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214143; cv=none; b=BsgtB47ilOsGoNxkdJfT1ChdyRdhlvikw+egVXcBp3Q6VicRAMbI0mma2GUmrXyG+TMKGxYTsQ7M5R7Y/80x2CzdjS6gWpROTrKSko4sONC4WGvQIbqnT0dWxzNo1J2809w6vJ/YtIGbjEliN3IJx7qvTuXaafBIJC+BmX3cz+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214143; c=relaxed/simple;
	bh=30FJcAk/8WuKlkQRuCkXq2KV9EjF1Lipu5qlsYwP6CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRQyJB2Qz9kOqupP9wpplxUG7N1jCJHKvw6LZu2W6ewQpICyCYA1N5ndq/m3Trn9xX6mcgYyPsGvxzcKJC7UhVh192CjcwbuHW+6pl+H4qBxAb4+Cxt9E/OqFGGhUlu9n8/QIxOm+/Iqn4gPkEal05NA38Kj/6nKtz/J8fbRsf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=E200HiXe; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d18d02af68so1876251a34.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772214137; x=1772818937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2LP/h981Cx5hSPbvfgL/ekJbDEiMZZmZVeE4xYWBPc=;
        b=E200HiXebHBTPcq/mJYD+7UYShmWbxp+c/Am3P5dHEz/qRm1DX/RV35Sc86qY0vj2G
         WGp5siAJDkMtJVcVdJm6CRRM8FeC338EFS/HtGOPHdMYg6cB//XYgqxLDcuGX448Bhg2
         Ob9EuE2jxtFWNkMxBRSjloivUuRCjjMhUmBT2usK42oV2PW9IIaoxBUVI8xG7NbZu5OM
         Iwi3GSJFw6zWgyAoUwWhuwuEWAv35C5I2Z5qbP8fh92pcvkTPTXtKBTM3CpZGGnwOfB7
         LQtnflQ3JI4HSHEDsTMGGeRry1c6ciC51h8xM2ZymQOXu8xZ7PsP3ZSIqKdYR9rtjFxM
         VoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772214137; x=1772818937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T2LP/h981Cx5hSPbvfgL/ekJbDEiMZZmZVeE4xYWBPc=;
        b=WoYFt3AbX2LSs2Xb0GzLZjiuTbVfaHhgkx2MD/+HnS6HtN0iHrYunTfmAw+BOUJt31
         oKaJvtAulpCPnuq5XVkamp/G2lR+SC22XG/J/sywJ4PrKmphdTAPGSlBf7UwboBfiKi4
         N5q9q92hoWM3P1A75yIW/xScuenPpU/YGeBodOTjUyu7FVcrowEFcQ36E0WWMRIc/jY2
         2T0eWBi1dX5ef5qjqsDogjF6PIwOKUXYiYkBcOHfTbVxjQuZZvyzFL+43HznGazsI4td
         k3lOWdNqin5yh21OwasMpNbIe1OQL+65tTV62OXp5+wHu16MzGWOLoXm0tUq0N73Q7lC
         NkHA==
X-Forwarded-Encrypted: i=1; AJvYcCUbHm0kMrec+NKK63RgXcJEQoeShB/Ms5CRkbXRqOgoI3CX/HGvyvEWOIHDOKlJXkXpcFNfqWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3L6h3YOylfFfx0RknMlxms360eZ9+wuNlCYg84Bl/gr9v1y3
	lUmBeD+56WwziT+ZtlGNP60JVnZzsGQJ1BG2OaBb8OeJaYo7XLdqzKzRavw5EUIvFpE=
X-Gm-Gg: ATEYQzxgEejOmWYA96u6PrVhisKOUuZY4yDH9fxBl+rMJ8rvbP0f1NchCdnk6YeD8Ks
	SIZhrJEmZdsaXaffH8I5P3gOzAsTIDgFoHjn4XPBF9saDbnlpsxtpdN8EFLZKmJbzsZ1rQL19kV
	SYewHwvW6Dgf62PzXRh2w19KQEArZdEOvWCY37YddO1sYIIuGfbLnEgfkH6l3nY+Zzo9IeZSCco
	9PC/42+uj4XZSNwblPeh2e00odw5dq7ERPwreCjAmlUtaaAJX3zMJXufRnbBdZA4m+yn6w3SXFE
	UdevLBH5lORodspRXH3/6S2yQWKAFCdeQHS1FtP0v+5FFpc3oJsWiHPXn9S6Iu01Zq1Gz5szzv1
	l96ouxSJamvpoRuiVpMjgcp/0eH1uijbM1gJEy7vZ5US2oojPQ5LwNDCPuALSzdc9IJtMoqHJvj
	zVV8h2U7A=
X-Received: by 2002:a05:6830:82bd:b0:7d1:586a:32a2 with SMTP id 46e09a7af769-7d591a0fdddmr1913746a34.0.1772214136876;
        Fri, 27 Feb 2026 09:42:16 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::f:3cb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644edf0sm4723385a34.2.2026.02.27.09.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 09:42:15 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 3/4] selftests: net: move common xdp.py functions into lib
Date: Fri, 27 Feb 2026 11:40:19 -0600
Message-ID: <632dde7417fc23bbcaf48bdc2e947f2695463e53.1772211065.git.carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772211065.git.carges@cloudflare.com>
References: <cover.1772211065.git.carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261934-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.988];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:mid,cloudflare.com:dkim,cloudflare.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url,xdp.py:url]
X-Rspamd-Queue-Id: A28CF1BB999
X-Rspamd-Action: no action

This moves a few functions which can be useful to other python programs
that manipulate XDP programs. This also refactors xdp.py to use the
refactored functions.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 .../selftests/drivers/net/lib/py/__init__.py  |  2 +
 tools/testing/selftests/drivers/net/xdp.py    | 95 +++++--------------
 .../testing/selftests/net/lib/py/__init__.py  |  2 +
 tools/testing/selftests/net/lib/py/bpf.py     | 68 +++++++++++++
 4 files changed, 95 insertions(+), 72 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib/py/bpf.py

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 8b75faa9af6d..29c4913cd434 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -23,6 +23,7 @@ try:
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
         fd_read_timeout, ip, rand_port, wait_port_listen, wait_file
+    from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup, ksft_variants, KsftNamedVariant
@@ -36,6 +37,7 @@ try:
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
                "fd_read_timeout", "ip", "rand_port",
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
index f528b67639de..c1aa9d0f8dcf 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -14,6 +14,7 @@ from .netns import NetNS, NetNSEnter
 from .nsim import NetdevSim, NetdevSimDev
 from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     bpftool, ip, ethtool, bpftrace, rand_port, wait_port_listen, wait_file, tool
+from .bpf import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
 from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily
 
@@ -27,6 +28,7 @@ __all__ = ["KSRC",
            "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
            "bpftool", "ip", "ethtool", "bpftrace", "rand_port",
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


