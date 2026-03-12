Return-Path: <netdev+bounces-267229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FHDLB9Bs2l6TgAAu9opvQ
	(envelope-from <netdev+bounces-267229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:41:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBE327B03F
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5879B327695A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 22:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE043BC682;
	Thu, 12 Mar 2026 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="p3D9+s+/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731ED3C13F4
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354936; cv=none; b=osrEiDqaHRAbD/a3k8gsVSiEGxW1a4dnRRbnqCaJM/z+9GZyo+LNNJsaj+lVhdEEB/H1iyVBek39op+HVYqM9eCcbPgCdNxDi+ePqMCC4v3d8LDhPs2cqdNETbjWnXV0fnjOE06sn78L6gq5rqqKU22uY28K7ghyoB7QNzYW874=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354936; c=relaxed/simple;
	bh=bOIv1idMYclJig7dHHf8ZB5kdbI0WSQDOttniO+KCbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeHnhg9cVdf/a6dPQy7fuVe9aiT5mqSYOwwwudVzeHM9Yys9fKVy07MDGeEUjKfTwWFcY65cBaHQchShAwpJyz1spcEaG2qRQbqMOME+R174hd9xOattXruCIYDeHFyuTqEOmXb2G5gijArylxwgJLCF30lUbY9ggC9HyMqkP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=p3D9+s+/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35a1f549e7eso549217a91.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773354928; x=1773959728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDgUXurlnboqnR9kUYXcG83BLVmHtjY+C3jwCrk3SN8=;
        b=p3D9+s+/2+ucOmzmglVyBs1yEFXGrh6FarkmvyuB6BZtQxW9J0Zn7up12rbiGXGl8/
         mpG/QBiuvBstyFF1MQ9H1ZI3kklsuO5tRVtFyXnTH+hFUHa1oDd+x9KlMmiYhcKy3MHB
         qrHtVhnp+asDFcwFxmDubToeSMQg82U7g6paTERDTWZAKf2U8+6oVupWvp1Xf/XjkLNk
         Vb1u4dAigjd3mhV/L3Dfw0c8tcyR3XixYj9CZMNujrep5pYZFtprfJUQki4CckbVb/P1
         9jVpKSRFUQet3WUKBbiE8UscUSBvvcUquDHoxHVrf6v9+MUK2sK53zptQN6TkhdPNVOY
         8wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354928; x=1773959728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zDgUXurlnboqnR9kUYXcG83BLVmHtjY+C3jwCrk3SN8=;
        b=GUlx7R9ZmsHb/76bC7CuDBJT7eKjzzzqlf1oD8RIJZK0w1Xbm9EJVSQK5/Wx+VY9db
         PdtBXMZEcm7G6bmt8kKSw4M4ZPxLmMG0h6pMw3LatPvsKfjodoXmZ7BouBTXJTDkJALJ
         0qZEMO9jQwqm0zbMQEL8A9OABvApmPpOEUb/cGHIks6WITY6TOB2kKsQ1O53m8O5XHep
         x4N50Bb4USZqZASUE6HMa86VyptqFggSc6q+nBl6Jsf2ndfKOJ1KYQCO+0dTPZQcQkpp
         ZTQ8H/i7xC4YiWtTx1yCgvsV3RbfgOre/IBnYQzVGug/z0J2px65srahovUoA9FXN4hK
         jHvQ==
X-Gm-Message-State: AOJu0YzGr5mKuk01yMD83IRwb2Z09Hju/m+D3xF1DcXJTSYnbg5nX+ss
	lUyda11rZU8E/R6Ed48Vt6v5zKrIHUzFnTjpI6F07SSNi/ejaGx2Noad0SsWxM+GQSHJu+ehH8B
	4klwdDME=
X-Gm-Gg: ATEYQzxkqPQsnPdESQCoslG3mdE9B3DJharWqOy0BzthyJZZ3kpoXDrbeu2gq2rBhFV
	Gv3jmipVMw9Vj+AQOXeSpX828TZGq0L9+BPbMnN6n6YgN8SentgtPkM2Qcu9ehP8neW+9XHs7+8
	VZhDeV2iYBxfO1UaIk8EH82lytcChApW1VbBzsX5QXRiNE06dlXLhk8VyXI73SEv2tBlx9NoVWM
	lce7ev8d2GWIGYyqAvKX12ml+9yv3ldFjNEuSpbFYsX1Bl6YforbfLs4ON1SeAkgYbMG0Hasjsa
	aN27FumIJV0Don6YQCm8qn29AYAt4Gi4i04EPVY6k/P6sMf24C48FIySDLAWgWAn9EgGhXRA5t6
	FZ3cJXz2AYEPfxHc1dNlFP+YKHUaDd7Ly0WFYANWGIY9EKb6fv6Tem6cnMWLosb53ELP5BuHb4U
	q4Fms=
X-Received: by 2002:a17:90b:2783:b0:35a:329:73c1 with SMTP id 98e67ed59e1d1-35a21e1b7b2mr1078051a91.7.1773354928480;
        Thu, 12 Mar 2026 15:35:28 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a24acecadsm142489a91.2.2026.03.12.15.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:35:28 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	linux-kselftest@vger.kernel.org
Subject: [RFC net-next v2 12/12] selftests: drv-net: Add USO test
Date: Thu, 12 Mar 2026 15:34:49 -0700
Message-ID: <20260312223457.1999489-13-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312223457.1999489-1-joe@dama.to>
References: <20260312223457.1999489-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-267229-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,uso.py:url,dama-to.20230601.gappssmtp.com:dkim,dama.to:email,dama.to:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BBE327B03F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a simple test for USO. Can be used with netdevsim or real hardware.
Tests both ipv4 and ipv6 with several full segments and a partial
segment.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 rfcv2:
   - new in rfcv2

 tools/testing/selftests/drivers/net/Makefile |  1 +
 tools/testing/selftests/drivers/net/uso.py   | 87 ++++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/uso.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 8154d6d429d3..800065fe443f 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -22,6 +22,7 @@ TEST_PROGS := \
 	ring_reconfig.py \
 	shaper.py \
 	stats.py \
+	uso.py \
 	xdp.py \
 # end of TEST_PROGS
 
diff --git a/tools/testing/selftests/drivers/net/uso.py b/tools/testing/selftests/drivers/net/uso.py
new file mode 100755
index 000000000000..da7a68b15734
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/uso.py
@@ -0,0 +1,87 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Test USO
+
+Sends large UDP datagrams with UDP_SEGMENT and verifies that the peer
+receives the correct number of individual segments with correct sizes.
+"""
+import socket
+import struct
+import time
+
+from lib.py import ksft_pr, ksft_run, ksft_exit, KsftSkipEx
+from lib.py import ksft_eq, ksft_ge
+from lib.py import NetDrvEpEnv
+from lib.py import bkg, cmd, defer, ethtool, ip, rand_port, wait_port_listen
+
+# python doesn't expose this constant, so we need to hardcode it to enable UDP
+# segmentation for large payloads
+UDP_SEGMENT = 103
+
+def _send_uso(cfg, ipver, mss, total_payload, port):
+    if ipver == "4":
+        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+        dst = (cfg.remote_addr_v["4"], port)
+    else:
+        sock = socket.socket(socket.AF_INET6, socket.SOCK_DGRAM)
+        dst = (cfg.remote_addr_v["6"], port)
+
+    sock.setsockopt(socket.IPPROTO_UDP, UDP_SEGMENT, mss)
+    payload = bytes(range(256)) * ((total_payload // 256) + 1)
+    payload = payload[:total_payload]
+    sock.sendto(payload, dst)
+    sock.close()
+    return payload
+
+def _get_rx_packets(cfg):
+    stats = ip(f"-s link show dev {cfg.remote_ifname}",
+               json=True, host=cfg.remote)[0]
+    return stats['stats64']['rx']['packets']
+
+def _test_uso(cfg, ipver, mss, total_payload):
+    cfg.require_ipver(ipver)
+
+    try:
+        ethtool(f"-K {cfg.ifname} tx-udp-segmentation on")
+    except Exception:
+        raise KsftSkipEx("Device does not support tx-udp-segmentation")
+    defer(ethtool, f"-K {cfg.ifname} tx-udp-segmentation off")
+
+    expected_segs = (total_payload + mss - 1) // mss
+
+    rx_before = _get_rx_packets(cfg)
+
+    port = rand_port(stype=socket.SOCK_DGRAM)
+    _send_uso(cfg, ipver, mss, total_payload, port)
+
+    time.sleep(0.5)
+
+    rx_after = _get_rx_packets(cfg)
+    rx_delta = rx_after - rx_before
+
+    ksft_ge(rx_delta, expected_segs,
+            comment=f"Expected >= {expected_segs} rx packets, got {rx_delta}")
+
+def test_uso_v4(cfg):
+    """USO IPv4: 11 segments (10 full + 1 partial)."""
+    _test_uso(cfg, "4", 1400, 1400 * 10 + 500)
+
+def test_uso_v6(cfg):
+    """USO IPv6: 11 segments (10 full + 1 partial)."""
+    _test_uso(cfg, "6", 1400, 1400 * 10 + 500)
+
+def test_uso_v4_exact(cfg):
+    """USO IPv4: exact multiple of MSS (5 full segments)."""
+    _test_uso(cfg, "4", 1400, 1400 * 5)
+
+def main() -> None:
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run([test_uso_v4,
+                  test_uso_v6,
+                  test_uso_v4_exact],
+                 args=(cfg, ))
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
-- 
2.52.0


