Return-Path: <netdev+bounces-264953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOYnGMdeq2mmcQEAu9opvQ
	(envelope-from <netdev+bounces-264953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:09:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA89C228868
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59DF530FF2BC
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 23:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84A236996C;
	Fri,  6 Mar 2026 23:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Sbm+mlZz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12998361DC3
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 23:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838403; cv=none; b=EhGKp4aisvx+bwzrip+zNOpXHQUc4j05qP6eK64Hg9QrzvT7rkW3yPzhQUoZXlkABchtSlNWuZoiUhgWTNICSCda23y9ILNkT7nSFfKd0w/cij4BthaRMRT/xqisZ90FIb0o/ga2d/i03B2fa948eSNrT54luErR+7R1rkE+DD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838403; c=relaxed/simple;
	bh=8czuKxIXstw0JG+VhrpdbQpiwcgQIXQoU+tZtK84puo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGd/KNJ9DYUgNpl3vaFqs8Qp3JW6kUU45YiwCD5eLmZhmvFib+miw0nIXg0XH9bQfh0BVJgAgBAZXnMT6IFGy6yn18eHkf9X0s26CTnDrM65vCkqnXQZJy4yJc8jOeP8iqBXRjreHalLC1yEDRB45+esmwrAmKQ4cDdQ0iP+0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Sbm+mlZz; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-463a0e14b4dso3232443b6e.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 15:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772838399; x=1773443199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4PoAMNeLEmpnpNk8ugY9fn6SRetloOwm3+eWZzi2Xs=;
        b=Sbm+mlZzhXffSlGETBKm5TnRa5b4rHoSPbxODn5y3eUgzMjxzpuEPRIAhhcRR2Q15W
         EnWjJpMR9IF3tYNrWQxPs9tOjULaNqs/q7lHy7x0GqHO834Im3P4YbFDqd7OpZEUw9fQ
         X6tTkr7puYK5LwSCwJuzez6alJHGgFs2wrd8rPMHV6stV2af8WAdId2rqg8bBGIolWpH
         qlAM6BrBakYWn2vvDlRsRCtFKzjZYo+qcjRFvxG/tacT/B3v8cpRunyG2Blc1hvnJ34t
         wtd5xdFWyLNly7sGl3lx6oztZOqiGdA938f/AXhbcxVayZY9wbjpkV+EbXqpVbMcRnvR
         y5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772838399; x=1773443199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l4PoAMNeLEmpnpNk8ugY9fn6SRetloOwm3+eWZzi2Xs=;
        b=ZBARrOSS3g25MAPp1NNUreNl2Ztt3s/0FMIS1GnhIrNH78GR42NjBZFIOTWWEx+PCo
         KvBrnEtisyx044a5TQg56eXK1ga8NVAKDRzzvJA0cz5LdXb3RxqmWocoiadW1tDFHxnH
         auJKW5xSB1ua6tAeq13m0EBQX6UzqkP/KYX8x2MM5zkzRV4pJkPQVhmUf6KshgVp0vlt
         BAgEphpYoowBloMmap1O2t+LEYANaYAKG+OD+YBqbBAObYcoQIm0sECgU2ndmhFvIzN7
         pVQ8v93KpRMI8m6GKMhRzFkVn5qgj0mUH2rIMNhlzvyUap1Uf8Xy4R/jAv0jOzTIln6V
         /oEw==
X-Forwarded-Encrypted: i=1; AJvYcCWAMz623Tme2LoxpwJUOS0/iyzb/7/DEgrIaEKEe8SvMN6UguWDidB46KynL2v3qtW6TR4sNAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgeK6stxweNc0lV5YaHJWaRKY2DfCKn65+9DzpNY4yq4bFb3hn
	xc+GZfT+cN5B3s7G1hAvQCLJh0HtpVIGMNtLHSBvSnOu6vRM9HBHwWGKnRaYjXV+dl4=
X-Gm-Gg: ATEYQzx1d1mzKYmUQauqGJ9HHsTM6vIDrwc8cBoegf+oSwPtgJiwpOyVWtezmi/eCU7
	xbALxIwPbledoLFiOB9kJDhw62cFzRHvYj5LGva+FsUMGLdNLMvW2NKRadd7x39e6XBNLoRlTh4
	g1yVXCHzTLFAA3q9lgW7B/aO4k6fPqmb411xbaeok2W6HAMHNmLsLvyEeFmSgLnf91IS8wqMAPL
	o6jng7wQMZB3sn3IWnPMhg7LmBO/RCKgqalqNCA3+IaA2SGbyv4+/0vyWokcYdfi9BfD3ir56bv
	pkQr3lOehepbeaZZe/LX4ezH8g7MoxfNNQaGVrq1fWM39fJbaJuuSKNZMnXAoCsNzfw/RVdyPBZ
	waFQ5jCSzF3KKdxVpI70Ft0zdJwe7R7M1gC79rMX72u7xwUxmYnG7J6g8M7o5kkvc9+JlFsBBWZ
	0oqUMO6HJc
X-Received: by 2002:a05:6808:c1e7:b0:464:2570:8805 with SMTP id 5614622812f47-466dc9d6965mr2403674b6e.3.1772838398845;
        Fri, 06 Mar 2026 15:06:38 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::3ce:23])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfac17b3sm1532769b6e.14.2026.03.06.15.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:06:37 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	joe@dama.to,
	kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net-next v3 4/5] selftests: net: move common xdp.py functions into lib
Date: Fri,  6 Mar 2026 17:00:19 -0600
Message-ID: <20260306230600.1628196-5-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306230600.1628196-1-carges@cloudflare.com>
References: <20260306230600.1628196-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA89C228868
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264953-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,dama.to,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,xdp.py:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid]
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
index 5872d114f142..f64e84b90574 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -23,6 +23,7 @@ try:
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
         fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, wait_file
+    from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup, ksft_variants, KsftNamedVariant
@@ -36,6 +37,7 @@ try:
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
index a584e7f806a4..ff9b83890773 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -15,6 +15,7 @@ from .nsim import NetdevSim, NetdevSimDev
 from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     bpftool, ip, ethtool, bpftrace, rand_port, rand_ports, wait_port_listen, \
     wait_file, tool
+from .bpf import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
 from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily
 
@@ -28,6 +29,7 @@ __all__ = ["KSRC",
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


