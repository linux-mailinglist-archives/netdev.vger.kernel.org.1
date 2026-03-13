Return-Path: <netdev+bounces-267626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPEILmeQtGl0qAAAu9opvQ
	(envelope-from <netdev+bounces-267626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:32:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0854628A6BF
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23C023142095
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558FF375AA8;
	Fri, 13 Mar 2026 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BXRULFNf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F65231E830
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441122; cv=none; b=dvYnZtPHKnXhwU26Ok5aMmW8AGAYdQ+paBoGwPn9/3hhKC40PGb02nqNU/6SBQquZR4VXn/kyNp/uTA76IBX2v1LoyiLa9lGUG9U3MRzeF2I1L9EtLIRNC/e7zVnwnY/W5gMMqnikpXlsVm5Ku/7w8uC7seKMDU83XqQ7fZhLPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441122; c=relaxed/simple;
	bh=wjojKKaX79Oylk4nRbk2Afn0b74BPVXORwp7GkLlWJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q78PpfobsSkS8c/ExjqwzYF0MznEoLFZnHDnaTObIf7KJE2p6ki9bYB7KtQ3slD+OSJPWrW0Z00aL1ioi7tLEcnUxAH8mR0hIRd4lM+oTHHcVqLfWYKep3RJ0lIm1u9oovSQWOQUCuJk3r3nh4ft3IdnQh37xZcJzLDIoo4zYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BXRULFNf; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-467166cb638so1111077b6e.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773441119; x=1774045919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2y5EWQGYuEN/ZCflQeFgRrVsCOx6mBcfWBilIa1oha8=;
        b=BXRULFNf5tftUe/TelKc+3Ff5dkLAcFvEC55K2Kc4/xs/dSSt1l5EVvqMLbl0530OY
         WaWWqJ7lMkXaZ4Rhqo9NPlRTKGwZwryjvZ2WfEUfpPsvIFfrTUXBahRyTa28irPtNQOj
         +GR+eZZJLR6EuJ7MXF6gE7b4v4CKyZnxeOa7CrkDTO5S1JfQiYl8Uh8JPOMZFaYUng9z
         s7sod3U9+QtWrOsN339jfwlW7YF5kCOfbvAdG6LRRhqiNS+kkU54AW3uxXfGfVXMMnh9
         lRuzgXLrBw+qc0eEDYvt5gdVKI4f9THEd78Vy0kLLutQPoNfO4KDZWzzcb44ZyvKkFmO
         jX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773441119; x=1774045919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2y5EWQGYuEN/ZCflQeFgRrVsCOx6mBcfWBilIa1oha8=;
        b=bMC9UshnaCghCFnZiLjL7MI9cuRZu9OZdr3Rpl8oSrtFezK14MwM4nmlwo3KtKrQOS
         FEzsNN6gzbisRN5BZyj7yX8qYMhFr/4so4pPoPTK29dPgm9Y0meimw8EgBf1ONxOFFaj
         HPZyV4J5xjyLgG9QbsP1R1tb1Z222zsY0hItnhyUWaY2T1alcYTQL+hW53box4pUa4nq
         WtPOEtvr+lZ6CtXwFblZLqp9cpyNu4Ga15naQRnlcd2nSUzyH30Qq1XcZBj+0fhmCMcC
         vZBvB8Rf8L4bIunYrBpPcWCvWcwlcXw/XxChGA2hujU7mKTwxsDqJdKNg8BmI8r2jmJe
         VgJw==
X-Forwarded-Encrypted: i=1; AJvYcCXAR/Yg8bL8Q5O7QRdeskXVf8p254QsGQGlfnaO4bwG32Evb7BNMdk6f04de6r0GNXWGKO7ROI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrFlpmpnsd16ilaifi7cqmhif6mRu9Dvb+yjvnEUmpq4gMHjHq
	U/S5k1quXHop6JrWmqQyZlsyNR8NucfS2LbQkdrmJb3DPHJcsY3vAAQjpyhNFBYbXqE=
X-Gm-Gg: ATEYQzwODmZCrTpXcylOraRz0vJAD60QZ0Vp7nUeBiETzllcPSAkqpXNNKlKGdRTTjP
	2UNJbZo4o2Xs1bBJK2xfdqtqydH6ZoVAtRsdCVtB+hmgIsM5y5FddSHIbIxP/O/HoB4YiWEHkPa
	fhQK8TGMbCxNuDpjkeYqJMu13J05oF0UFAC4s7UzMT6PmunNGGI5g6+IK1X42QVDTVahaWuGpOD
	DcPmLrTf87elofvt8RrV8dPOoyGYH/jtRQ8bMs5K05J+4W5kCkidtEuLroiU5vw3GvwpMJKg4m5
	HSUGOcoFaWWz/KybV/Voeoswe3rg7py0DDvxynv9S7Io9C7UrStSEJPFFoO4Dpv9SWIyh1wfTC2
	k1wj90uJQGR+WFq8W/jOsdNCMMDXADajC1/sJtkxKAyikUqyMR4++6UrzP76K2lg5zMrNZ6nPda
	yXdtfvK2K4
X-Received: by 2002:a05:6808:5241:b0:466:f57b:2ad2 with SMTP id 5614622812f47-467572f2c66mr2275298b6e.31.1773441119188;
        Fri, 13 Mar 2026 15:31:59 -0700 (PDT)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::22f:7d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342fab49sm5408516b6e.16.2026.03.13.15.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:31:57 -0700 (PDT)
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
	Petr Machata <petrm@nvidia.com>,
	David Wei <dw@davidwei.uk>,
	Chris J Arges <carges@cloudflare.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Carolina Jubran <cjubran@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4 6/6] selftests: drv-net: xdp: Add rss_hash metadata tests
Date: Fri, 13 Mar 2026 17:27:36 -0500
Message-ID: <20260313223029.454755-7-carges@cloudflare.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267626-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[dama.to,kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,nvidia.com,davidwei.uk,cloudflare.com,linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,lib.py:url,xdp_metadata.py:url]
X-Rspamd-Queue-Id: 0854628A6BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This test loads xdp_metadata.bpf which calls bpf_xdp_metadata_rx_hash() on
incoming packets. The metadata from that packet is then sent to a BPF
map for validation. It borrows structure from xdp.py, reusing common
functions.

The test checks the device's xdp-rx-metadata-features via netlink
before running and skips on devices that do not advertise hash support.
This can be run on veth devices as well as real hardware.

The test is fairly simple and just verifies that a TCP or UDP packet can be
identified as an L4 flow. This minimal test also passes if run on a veth
device.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   2 +
 .../selftests/drivers/net/hw/xdp_metadata.py  | 146 ++++++++++++++++
 .../selftests/net/lib/xdp_metadata.bpf.c      | 163 ++++++++++++++++++
 4 files changed, 312 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/xdp_metadata.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_metadata.bpf.c

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 91df028abfc0..fa933ce94400 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -41,6 +41,7 @@ TEST_PROGS = \
 	rss_input_xfrm.py \
 	toeplitz.py \
 	tso.py \
+	xdp_metadata.py \
 	xsk_reconfig.py \
 	#
 
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index b8d9ae282390..df4da5078c48 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -25,6 +25,7 @@ try:
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
         fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, \
         wait_file, tool
+    from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup, ksft_variants, KsftNamedVariant
@@ -40,6 +41,7 @@ try:
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
                "fd_read_timeout", "ip", "rand_port", "rand_ports",
                "wait_port_listen", "wait_file", "tool",
+               "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
                "ksft_setup", "ksft_variants", "KsftNamedVariant",
diff --git a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py b/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
new file mode 100644
index 000000000000..33a1985356d9
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
@@ -0,0 +1,146 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Tests for XDP metadata kfuncs (e.g. bpf_xdp_metadata_rx_hash).
+
+These tests load device-bound XDP programs from xdp_metadata.bpf.o
+that call metadata kfuncs, send traffic, and verify the extracted
+metadata via BPF maps.
+"""
+from lib.py import ksft_run, ksft_eq, ksft_exit, ksft_ge, ksft_ne, ksft_pr
+from lib.py import KsftNamedVariant, ksft_variants
+from lib.py import CmdExitFailure, KsftSkipEx, NetDrvEpEnv
+from lib.py import NetdevFamily
+from lib.py import bkg, cmd, rand_port, wait_port_listen
+from lib.py import ip, bpftool, defer
+from lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
+
+
+def _load_xdp_metadata_prog(cfg, prog_name, bpf_file="xdp_metadata.bpf.o"):
+    """Load a device-bound XDP metadata program and return prog/map info.
+
+    Returns:
+        dict with 'id', 'name', and 'maps' (name -> map_id).
+    """
+    abs_path = cfg.net_lib_dir / bpf_file
+    pin_dir = "/sys/fs/bpf/xdp_metadata_test"
+
+    cmd(f"rm -rf {pin_dir}", shell=True, fail=False)
+    cmd(f"mkdir -p {pin_dir}", shell=True)
+
+    try:
+        bpftool(f"prog loadall {abs_path} {pin_dir} type xdp "
+                f"xdpmeta_dev {cfg.ifname}")
+    except CmdExitFailure as e:
+        cmd(f"rm -rf {pin_dir}", shell=True, fail=False)
+        raise KsftSkipEx(
+            f"Failed to load device-bound XDP program '{prog_name}'"
+        ) from e
+    defer(cmd, f"rm -rf {pin_dir}", shell=True, fail=False)
+
+    pin_path = f"{pin_dir}/{prog_name}"
+    ip(f"link set dev {cfg.ifname} xdpdrv pinned {pin_path}")
+    defer(ip, f"link set dev {cfg.ifname} xdpdrv off")
+
+    xdp_info = ip(f"-d link show dev {cfg.ifname}", json=True)[0]
+    prog_id = xdp_info["xdp"]["prog"]["id"]
+
+    return {"id": prog_id,
+            "name": xdp_info["xdp"]["prog"]["name"],
+            "maps": bpf_prog_map_ids(prog_id)}
+
+
+def _send_probe(cfg, port, proto="tcp"):
+    """Send a single payload from the remote end using socat.
+
+    Args:
+        cfg: Configuration object containing network settings.
+        port: Port number for the exchange.
+        proto: Protocol to use, either "tcp" or "udp".
+    """
+    cfg.require_cmd("socat", remote=True)
+
+    if proto == "tcp":
+        rx_cmd = f"socat -{cfg.addr_ipver} -T 2 TCP-LISTEN:{port},reuseport STDOUT"
+        tx_cmd = f"echo -n rss_hash_test | socat -t 2 -u STDIN TCP:{cfg.baddr}:{port}"
+    else:
+        rx_cmd = f"socat -{cfg.addr_ipver} -T 2 -u UDP-RECV:{port},reuseport STDOUT"
+        tx_cmd = f"echo -n rss_hash_test | socat -t 2 -u STDIN UDP:{cfg.baddr}:{port}"
+
+    with bkg(rx_cmd, exit_wait=True):
+        wait_port_listen(port, proto=proto)
+        cmd(tx_cmd, host=cfg.remote, shell=True)
+
+
+# BPF map keys matching the enums in xdp_metadata.bpf.c
+_SETUP_KEY_PORT = 1
+
+_RSS_KEY_HASH = 0
+_RSS_KEY_TYPE = 1
+_RSS_KEY_PKT_CNT = 2
+_RSS_KEY_ERR_CNT = 3
+
+XDP_RSS_L4 = 0x8  # BIT(3) from enum xdp_rss_hash_type
+
+
+@ksft_variants([
+    KsftNamedVariant("tcp", "tcp"),
+    KsftNamedVariant("udp", "udp"),
+])
+def test_xdp_rss_hash(cfg, proto):
+    """Test RSS hash metadata extraction via bpf_xdp_metadata_rx_hash().
+
+    This test will only run on devices that support xdp-rx-metadata-features.
+
+    Loads the xdp_rss_hash program from xdp_metadata, sends a packet using
+    the specified protocol, and verifies that the program extracted a non-zero
+    hash with an L4 hash type.
+    """
+    dev_info = cfg.netnl.dev_get({"ifindex": cfg.ifindex})
+    rx_meta = dev_info.get("xdp-rx-metadata-features", [])
+    if "hash" not in rx_meta:
+        raise KsftSkipEx("device does not support XDP rx hash metadata")
+
+    prog_info = _load_xdp_metadata_prog(cfg, "xdp_rss_hash")
+
+    port = rand_port()
+    bpf_map_set("map_xdp_setup", _SETUP_KEY_PORT, port)
+
+    rss_map_id = prog_info["maps"]["map_rss"]
+
+    _send_probe(cfg, port, proto=proto)
+
+    rss = bpf_map_dump(rss_map_id)
+
+    pkt_cnt = rss.get(_RSS_KEY_PKT_CNT, 0)
+    err_cnt = rss.get(_RSS_KEY_ERR_CNT, 0)
+    hash_val = rss.get(_RSS_KEY_HASH, 0)
+    hash_type = rss.get(_RSS_KEY_TYPE, 0)
+
+    ksft_ge(pkt_cnt, 1, comment="should have received at least one packet")
+    ksft_eq(err_cnt, 0, comment=f"RSS hash error count: {err_cnt}")
+
+    ksft_ne(hash_val, 0,
+            f"RSS hash should be non-zero for {proto.upper()} traffic")
+    ksft_pr(f"  RSS hash: {hash_val:#010x}")
+
+    ksft_pr(f"  RSS hash type: {hash_type:#06x}")
+    ksft_ne(hash_type & XDP_RSS_L4, 0,
+            f"RSS hash type should include L4 for {proto.upper()} traffic")
+
+
+def main():
+    """Run XDP metadata kfunc tests against a real device."""
+    with NetDrvEpEnv(__file__) as cfg:
+        cfg.netnl = NetdevFamily()
+        ksft_run(
+            [
+                test_xdp_rss_hash,
+            ],
+            args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/lib/xdp_metadata.bpf.c b/tools/testing/selftests/net/lib/xdp_metadata.bpf.c
new file mode 100644
index 000000000000..f71f59215239
--- /dev/null
+++ b/tools/testing/selftests/net/lib/xdp_metadata.bpf.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <linux/in.h>
+#include <linux/if_ether.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/udp.h>
+#include <linux/tcp.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+
+enum {
+	XDP_PORT = 1,
+	XDP_PROTO = 4,
+} xdp_map_setup_keys;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 5);
+	__type(key, __u32);
+	__type(value, __s32);
+} map_xdp_setup SEC(".maps");
+
+/* RSS hash results: key 0 = hash, key 1 = hash type,
+ * key 2 = packet count, key 3 = error count.
+ */
+enum {
+	RSS_KEY_HASH = 0,
+	RSS_KEY_TYPE = 1,
+	RSS_KEY_PKT_CNT = 2,
+	RSS_KEY_ERR_CNT = 3,
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 4);
+} map_rss SEC(".maps");
+
+/* Mirror of enum xdp_rss_hash_type from include/net/xdp.h.
+ * Needed because the enum is not part of UAPI headers.
+ */
+enum xdp_rss_hash_type {
+	XDP_RSS_L3_IPV4 = 1U << 0,
+	XDP_RSS_L3_IPV6 = 1U << 1,
+	XDP_RSS_L3_DYNHDR = 1U << 2,
+	XDP_RSS_L4 = 1U << 3,
+	XDP_RSS_L4_TCP = 1U << 4,
+	XDP_RSS_L4_UDP = 1U << 5,
+	XDP_RSS_L4_SCTP = 1U << 6,
+	XDP_RSS_L4_IPSEC = 1U << 7,
+	XDP_RSS_L4_ICMP = 1U << 8,
+};
+
+extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
+				    enum xdp_rss_hash_type *rss_type) __ksym;
+
+static __always_inline __u16 get_dest_port(void *l4, void *data_end,
+					   __u8 protocol)
+{
+	if (protocol == IPPROTO_UDP) {
+		struct udphdr *udp = l4;
+
+		if ((void *)(udp + 1) > data_end)
+			return 0;
+		return udp->dest;
+	} else if (protocol == IPPROTO_TCP) {
+		struct tcphdr *tcp = l4;
+
+		if ((void *)(tcp + 1) > data_end)
+			return 0;
+		return tcp->dest;
+	}
+
+	return 0;
+}
+
+SEC("xdp")
+int xdp_rss_hash(struct xdp_md *ctx)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	enum xdp_rss_hash_type rss_type = 0;
+	struct ethhdr *eth = data;
+	__u8 l4_proto = 0;
+	__u32 hash = 0;
+	__u32 key, val;
+	void *l4 = NULL;
+	__u32 *cnt;
+	int ret;
+
+	if ((void *)(eth + 1) > data_end)
+		return XDP_PASS;
+
+	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+		struct iphdr *iph = (void *)(eth + 1);
+
+		if ((void *)(iph + 1) > data_end)
+			return XDP_PASS;
+		l4_proto = iph->protocol;
+		l4 = (void *)(iph + 1);
+	} else if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
+		struct ipv6hdr *ip6h = (void *)(eth + 1);
+
+		if ((void *)(ip6h + 1) > data_end)
+			return XDP_PASS;
+		l4_proto = ip6h->nexthdr;
+		l4 = (void *)(ip6h + 1);
+	}
+
+	if (!l4)
+		return XDP_PASS;
+
+	/* Filter on the configured protocol (map_xdp_setup key XDP_PROTO).
+	 * When set, only process packets matching the requested L4 protocol.
+	 */
+	key = XDP_PROTO;
+	__s32 *proto_cfg = bpf_map_lookup_elem(&map_xdp_setup, &key);
+
+	if (proto_cfg && *proto_cfg != 0 && l4_proto != (__u8)*proto_cfg)
+		return XDP_PASS;
+
+	/* Filter on the configured port (map_xdp_setup key XDP_PORT).
+	 * Only applies to protocols with ports (UDP, TCP).
+	 */
+	key = XDP_PORT;
+	__s32 *port_cfg = bpf_map_lookup_elem(&map_xdp_setup, &key);
+
+	if (port_cfg && *port_cfg != 0) {
+		__u16 dest = get_dest_port(l4, data_end, l4_proto);
+
+		if (!dest || bpf_ntohs(dest) != (__u16)*port_cfg)
+			return XDP_PASS;
+	}
+
+	ret = bpf_xdp_metadata_rx_hash(ctx, &hash, &rss_type);
+	if (ret < 0) {
+		key = RSS_KEY_ERR_CNT;
+		cnt = bpf_map_lookup_elem(&map_rss, &key);
+		if (cnt)
+			__sync_fetch_and_add(cnt, 1);
+		return XDP_PASS;
+	}
+
+	key = RSS_KEY_HASH;
+	bpf_map_update_elem(&map_rss, &key, &hash, BPF_ANY);
+
+	key = RSS_KEY_TYPE;
+	val = (__u32)rss_type;
+	bpf_map_update_elem(&map_rss, &key, &val, BPF_ANY);
+
+	key = RSS_KEY_PKT_CNT;
+	cnt = bpf_map_lookup_elem(&map_rss, &key);
+	if (cnt)
+		__sync_fetch_and_add(cnt, 1);
+
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


