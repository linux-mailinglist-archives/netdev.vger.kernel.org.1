Return-Path: <netdev+bounces-271729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ09DixCxGlHxwQAu9opvQ
	(envelope-from <netdev+bounces-271729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:14:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F4D32BB44
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D1C230D2067
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C42936D51E;
	Wed, 25 Mar 2026 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TywyPjGK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB3136828B
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469524; cv=none; b=HLpLMbzenfiB5JoVHVHvQtkDheZmLAxO0EqjAqwaSNHD6OQo2YjcFa5dy6NC9Fq05UMnkUJWiA3trzJGt9Dw1LYhhz7DqswBzJjKxa3QqDZcSG6hGQkA2CNoa/8P6xT0py1FIdWY7q/aAyEaCpsPZNFVNOS/ZSV01atT6iFwlXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469524; c=relaxed/simple;
	bh=utMsfZOZJ1ksHw1TYvbDldQzKk31PLXTA3EAZE+aH80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fW20ELZt+Bso2pvYuwmxXx4la/L7RiddGSU5wyknHahrvuwyKKXyYYHg5qNBxGAoVjwSeNooj7N+G967r0XnrmOrj/EaDo7NK/ifa/pZZ9fBNL4zedUC45rhzYI8rwLDlUmM7s5hpH60SQuiLFNfnI6iZ5LXINSUCKp/4Ksxl5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TywyPjGK; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so179480a34.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1774469521; x=1775074321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xj0FJa7urNwO6Pwe1g44OlVN73NKWJtkJ0e2tlVWaqY=;
        b=TywyPjGKe298ExWXLvB+cXLI/jbAj5gRL4S2MVt6HOJ+VzVCPpXQ5zoiM00Wu9n0OX
         GHA8nuVk+vsOyYGI/Mdws+ycztOk0NloK6EQLRt3dUbw6PNnyCEOlyma+mOR4dgqqxDy
         aiga2pwIbpkp2JSvkJk59ViSHHwJYbwc9B010KlbVxOS/lC6fQZVT8motxIL8simaNdx
         lYXNTwHxMDq3XL3oJGR4TnxclBzT/D/xBneCFpFI9M7JUXfR7/IBGPMZ97KmK6DUIQv9
         rHbbwaZ9P8ei/pHz9bIG6mSFPiVVwTfurhcf9azHd5JuMfnSq1ewb4tUkQSoKrgk7PtP
         G2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469521; x=1775074321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xj0FJa7urNwO6Pwe1g44OlVN73NKWJtkJ0e2tlVWaqY=;
        b=fqQ9YMtPebepqgB/VaQ2I2ZM7zZn03+K/sSdrKHb9P4s/cHthPzqP63ZMnoQGJtFIx
         9bAOeCAM3uOtzf6GeSq6hhQ6n7x2JI2fZm/ZTFj9mN+d6Ldha2FFb6m6MqMgV4AIK2Vy
         YDhl/Sq+tJy7Jt4uTt4ztY5L27UW1RHUP5pAtvT9r9Cyk9iJ+NXIgLn4e7YQKmIDeD4g
         CfkmrTND7Vg9+6rNgM9ZapKacj03cQAWOalxiHV6pC2kgKFSvyEIMth0oKW/wRPuXMPL
         wv0exrQqHC9T0hJVeMelitDOCTzx/u8+K1lZhf0L4NllIUQUKYKZzYaw8XfD5NhZi6Z7
         VF8w==
X-Gm-Message-State: AOJu0YxtYfmQTkgmxr9VX7PlnxQ53zQSecZUPrNT7msEDuRAgHjF/V/n
	z5xDqDrWMnCAonuys29V3z69BZwmRC4jpLjMUSmirwf2BynoHeY4sIyGRm0c8UAFXCNT4qLi26/
	odGH0tpOuAA==
X-Gm-Gg: ATEYQzyGOsc63BecFa9Y2GGT0lZJuSur2Li3NFhCKmOUSfXYJH7qCOqoSUZ9nhmKpv8
	e/c/PGUtgsfwe6Cw10wzEpQm5+VCI1u2hYSbdZvgvZem3sCJDvp/hCQ9IdRXzcQR8CModcUWcvO
	Mm9kB1lnVUyTMhtVhLRO7ILzhQE4DgAcNXnMuBPLI7SHl60EBkXZoC7AeoFXWiDdReCXckVN2ke
	bHz3HIqa3SbjebK3e89DGUeMVsYjEodVscZqk/30uq6/b6X0M9jFxJ1LkhMM+7g3NLyAD69XAPX
	22FAjDjfdEHzxltJEe6N1QPricBYJl1OKdjzMHtwJeX2+wCi2HFr/lpcRMI0AMUap1QDphtR/36
	bIkW78DdvraPOrgBJzAUScfrY4cnPPgmaS+AwZ5g2ZXdPoX7wRNVLMtLO1tpwcwjjPNDDBvUPfv
	e0dJasqdWehUPWShQIlISjzGM=
X-Received: by 2002:a05:6820:985:b0:67b:c7a0:e4ec with SMTP id 006d021491bc7-67dff41e541mr2754119eaf.22.1774469520908;
        Wed, 25 Mar 2026 13:12:00 -0700 (PDT)
Received: from 20HS2G4.aus01.local ([2a09:bac6:bf21:2632::3ce:1a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e0ab274c7sm549764eaf.13.2026.03.25.13.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:12:00 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: netdev@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	davem@davemloft.net,
	joe@dama.to,
	gospo@broadcom.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>
Subject: [PATCH net-next v5 6/6] selftests: drv-net: xdp: Add rss_hash metadata tests
Date: Wed, 25 Mar 2026 15:09:52 -0500
Message-ID: <20260325201139.2501937-7-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325201139.2501937-1-carges@cloudflare.com>
References: <20260325201139.2501937-1-carges@cloudflare.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,cloudflare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271729-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[xdp_metadata.py:url,lib.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid]
X-Rspamd-Queue-Id: D3F4D32BB44
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
v5: no changes
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   2 +
 .../selftests/drivers/net/hw/xdp_metadata.py  | 146 ++++++++++++++++
 .../selftests/net/lib/xdp_metadata.bpf.c      | 163 ++++++++++++++++++
 4 files changed, 312 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/xdp_metadata.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_metadata.bpf.c

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 3c97dac9baaa..884cc77daeaa 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -42,6 +42,7 @@ TEST_PROGS = \
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


