Return-Path: <netdev+bounces-269169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J0ZGOr5umlwdwIAu9opvQ
	(envelope-from <netdev+bounces-269169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:15:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F11AF2C1E68
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 043F2304A8B5
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AC33F99EF;
	Wed, 18 Mar 2026 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Sgpm/1Fe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50D3F7E79
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861242; cv=none; b=vEyRA9VMXLthLXj/Sq3ibACGoEFd9CU4FttZJzi+4kVnZitxlxPnXgIjk7PBipTpu0Nb8NVSQa5KZCG2gLm6bSvYCn6jVpZIM92qbz67+RV4TmuomRpF9/gBRIx5/CwCtJ/jHfWfpsZDC+EjaNnxYWRArAPosxHdiRMd8qdvSGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861242; c=relaxed/simple;
	bh=bOIv1idMYclJig7dHHf8ZB5kdbI0WSQDOttniO+KCbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYgKogm/e1oETPvHh3gcugN59zmSx3sXfbsJNTyQXDS0hgp91fx0nhrTOhyPmdwEPY89+xo11i9uUoYj/ZZCcKwWeSLH2tPoIHZqHmH8NFz6UoHEnxDEmh+06/b1Ix+HCD97DSxWnFk/Tjo5UHPZqKxOVdVUO9tRrJ6ahUXXFXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Sgpm/1Fe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a9296b3926so1542005ad.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773861237; x=1774466037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDgUXurlnboqnR9kUYXcG83BLVmHtjY+C3jwCrk3SN8=;
        b=Sgpm/1FemW4HE9FTESN1VKa0U/dX6wBSVM5HUsfiIG47WQC20EEqnxPb1t+oTS/d3e
         jFRrMFtgf+hDSf+1ydPyeV1lDFibFJbMaS7RXU4AqItu3W/NV5IyW1lTcCip84phvBEl
         E/k7MzwS9iFsAi/cRiBr8yhB7cAKPohxUQp/tFsmE5VE9AA9MkbN2KhG4z+9mQa9kiSQ
         Y3xRtgKXqVaLuFrSxUm/MUCR9bpWNuZkCqsEA3cMZnjrBFdD5gAUcJq1WmdLPXFY6Qzb
         XfUDzoAci9plLTe+bN6KY+Hers7Q0wWCTu2FwzaBTgUV2U2oyPY8NX9oHvO3cfpayZNh
         V24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861237; x=1774466037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zDgUXurlnboqnR9kUYXcG83BLVmHtjY+C3jwCrk3SN8=;
        b=Me7BBvL6Wn5duEGBRryGC/xe2rZN9vN0Srse3uN5XC8/d/BVLnFQ+rkH3mbjTzDsRz
         g15/qsmULHT6gBMO8Y+l+FG2aPwVuUVlUvusUa2VhQsEG76icvF2Z8LZ7jdfUOIR850f
         NBbtq362mo54RP5mkX8+kAjfbXlJVJHvPgAupYqSAoluA+ABIq2Z9IdYiVf+J6Vt+doj
         sPD+lxSUifO+tXHiJ644ovpqNuTg0mn4wvnNWjcNd9n9Wlq1auP3bkxwSy0jc74tkw5T
         rwmXu/WNuJgK8i4E3tKn194OFvo2ElVE02d/0ovm3RP/bTCateQEcMpWy8EB6eF8cCzH
         2bOQ==
X-Gm-Message-State: AOJu0Yzt7NTZpJ3dtZZksB/h3LoqiWJvASAL1mX0hy7++8RlYIKGmTEp
	KD2iTtT8jQmLdQ9ms45KhQEp8MyGn0AvkhSTyLF8UhkL8yGnFqg9I+MruMrNcTxIxCG9NNUcvA9
	DuswrjbY=
X-Gm-Gg: ATEYQzym6iUnkq7fmX5I3uJuGBZUqzA7uYJYFp+RvDUJapAcp2PyG5CvctTbLsuTGEw
	yluSm2L/jXuu9lmV4wB9fIdcP8gff1V8LjAYrj22weSAA6TWspd39RhspWdBDQsRtOyA3qL5Zsy
	NhDkKoxmHQkHHIIUdgOtU7WlL23dNz9kHyLjjTVODHwMhNnD4Lv5eEZIp/bd2rkBszI76Uj9ayk
	ifmrwldrkNW17qHgpUKYhvautCLKPuZPc8nJL/N5R7ITugut2ULJeZhObEw33lf8egAH0F2JVRg
	7Qzue6vAhpfMiiA22XpwRgvXT5ezNIJZRd9iuq3hwUoqIavtIndTgZschdLCo8mYZDY7lu/d5oI
	vwKIkYBAQrHSddS1KTSagO9JmcsiGTXIOtUhNAds5kt+SA4M4fF/gocoJqNwZ0VTg6j0DXyc/Ej
	yHleYm
X-Received: by 2002:a17:903:2a90:b0:2b0:4158:c9d1 with SMTP id d9443c01a7336-2b06e3e5bacmr53777575ad.36.1773861237621;
        Wed, 18 Mar 2026 12:13:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e627132sm36037645ad.74.2026.03.18.12.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:13:57 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>,
	linux-kselftest@vger.kernel.org
Subject: [net-next v3 12/12] selftests: drv-net: Add USO test
Date: Wed, 18 Mar 2026 12:13:17 -0700
Message-ID: <20260318191325.1819881-13-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318191325.1819881-1-joe@dama.to>
References: <20260318191325.1819881-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269169-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.982];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F11AF2C1E68
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


