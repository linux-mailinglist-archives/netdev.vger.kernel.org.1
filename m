Return-Path: <netdev+bounces-264954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGOEG+Jeq2mmcQEAu9opvQ
	(envelope-from <netdev+bounces-264954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:10:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E95228884
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68F123115AF3
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 23:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6938536BCDF;
	Fri,  6 Mar 2026 23:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SqLdFgPx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0397036AB76
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838405; cv=none; b=fhdaA8e2top/BlubfYkrIOe2ypBchEwGY/HiO/x93RcrG/lBENR8Qg5hJ+aiHQc08dHHUU/p/Ce6rUxcJ6SFfrsmz5HCoB8pKZyT7EFlOBc2dYrlCG8wWlElh9wj4MsSwWEmKiqtym+1lL8zMrdbb8zjzRg2DXKCDdzrX8qPJRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838405; c=relaxed/simple;
	bh=dHF3KSB1sbsp73+zPDWjiD02+CUMEjJMUasDN5aNl18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGaYpGizj+TtnvL7PKQyHIuHArhns8+jIhx6sOMoaw/1fziIG2bhSlKe0cWRseaCJtV13+2XHboSsBngZjELPhChQJ3JHG8saRxNDkO/kJH+5XMTwhABG6czIiLZqWZPrCvRjmyXkxtKmNv8WcDHPL22OL2RX2DENIH+MIIHleU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SqLdFgPx; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-46391e91e16so6735559b6e.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 15:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772838402; x=1773443202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZcoqF52XejvSkZeB79WNNfha0/GAF3LwXAyaRfyLi0=;
        b=SqLdFgPxBOok+KHy5E0jqb1jXGt9WdX50xsa5haoIZX44D5xDUK7xT7JeqfTmtLYIx
         HsiSoAGI218uyIAn3+N7JEeIvCOWGkvSusNhrosXSELTTfLDPzQDTnD7l7UNKXJXFgag
         xUI/lFWUQXvsrh63aPzX5ACUc5O/fRPkTuMCKXV9fQjKB1pzCEx3B9/vcUCxsSDx4x2N
         pYN/F5+eqKEPbniFzlX3k4bwvPRLMy5I3c8vUK59+gSi5LQsp1MKQmmdGCRfXVY0cz2F
         mtIj1lTCoLQQQXXXgOrAdcvV1vn2DcuiwTlexu/hOWskOcS39/7BVuKwD9xux4BHx7Ds
         3YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772838402; x=1773443202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xZcoqF52XejvSkZeB79WNNfha0/GAF3LwXAyaRfyLi0=;
        b=s1iRtbxB3f3QBz4x2ytQrcMWEVHUqIXiRZ773dy2yuRbWs/wMCHPPapIY34kubC8Ud
         ULBNgkoKI/bRVjDpGAW+nmug8WFb3ouE/UcbpN7xOY66mxR7KoKDsGMl9JiVG5RY09B9
         52utk+af9vMW1+8mkYI+WVMoKniH7TPZ0VJvcs9qA13FZCHWYAfjFTStE/ni0Rnkkfti
         iXPC9jM+NmPsa5Yvf+a1hul1bq/jYKg838k8H1+xMMfz6DPwPl1V79Gvw87F/lNtcSV6
         1Fo/A2ueWjwZZPhrG8FZOAJr11i3EvgRGTf6v6XVZs9WV/lU5mdD2W7xdQym9VKoBTx9
         dvDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS2EATZdUOEl9imYV23CzySUNrzDoMjnTMIhDOju6Bp4f1h80cwbbCNFoaBCdE7oybpva93UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySht4sZN4jtJ6Z9aOSPDC5sKbfdOTDcxWBwnmSKsih26qaFwdq
	18wIrBBvB45IVVPAViSfKID3RpvLzbEz/ImtowarAOlPEJAOk6kth0pYhBHpzHyxnVI=
X-Gm-Gg: ATEYQzxdCNdsDU5JaPO3bBDDUvsCvZ9I5SQ+jA+nkTKOG48Ix/Zl8SULvmh7n5DiZvA
	wpWcLg0EYqMI8eXhmoJubhm1p0wH4HJMEX43dw8sab1nMCLDTFZUeMj5waV1nv9ABRf7IICukWW
	AvVKpK0ezsBwbEQugCap5qt1ayxdqCWj1/I/V7JEqOBHmi4/dBgwfe7rn5N0PtEpg2YLAbyWEFC
	6FGcRv0GqFJ9hRxEOrg+IUOM+hnw7Uo/p1D+BObvn1YfoISvsTjtA/Nk1vmQjLPhnoTrBSOXFGA
	HuteBXnuNzNkDUptftAR/oZ0v4e59R5jF4rWCKhEPx1ZYRw9NPHK48uvVVMW59NQhzr0eXLq/0K
	WRuHFd8qnLNVmQHMKWcEks5CdwUq6rK4zT6o3gl+HX/YIjp8+5L7FZprnPGxjfi4P+tyRGMLf4p
	yXS/5+ZUe2
X-Received: by 2002:a05:6808:15a2:b0:463:94f6:681b with SMTP id 5614622812f47-466dcb1888cmr2311626b6e.34.1772838401978;
        Fri, 06 Mar 2026 15:06:41 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::3ce:23])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfac17b3sm1532769b6e.14.2026.03.06.15.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:06:41 -0800 (PST)
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
Subject: [PATCH net-next v3 5/5] selftests: drv-net: xdp: Add rss_hash metadata tests
Date: Fri,  6 Mar 2026 17:00:20 -0600
Message-ID: <20260306230600.1628196-6-carges@cloudflare.com>
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
X-Rspamd-Queue-Id: 15E95228884
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
	TAGGED_FROM(0.00)[bounces-264954-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid]
X-Rspamd-Action: no action

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
index a64140333a46..9db5b8a62286 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -40,6 +40,7 @@ TEST_PROGS = \
 	rss_input_xfrm.py \
 	toeplitz.py \
 	tso.py \
+	xdp_metadata.py \
 	xsk_reconfig.py \
 	#
 
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 1971577d47e9..ac4a0a9cf0f2 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -24,6 +24,7 @@ try:
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
         fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, \
         wait_file, tool
+    from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup, ksft_variants, KsftNamedVariant
@@ -39,6 +40,7 @@ try:
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


