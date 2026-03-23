Return-Path: <netdev+bounces-270678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMyrDk+RwWnFTwQAu9opvQ
	(envelope-from <netdev+bounces-270678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:15:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BB12FC08C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D8093284DF5
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9909F3D6CC8;
	Mon, 23 Mar 2026 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="xppXZ4ua"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C72FDC28
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291167; cv=none; b=LeaRV27yTXwU9/bVGgVMhsCA0WM8ccDo8PTAmKzdYaq+k3ifYAW0ygdKVEQgExZaU74En5pDwFROhnAsnM1lJRj8pQM3ND+uC2X1tG+iU1CjGGFBQLns0hSFXdMm2Ncr4Q7J0hAbL2M+u1uxDV+CkyvfbntdGwaTn4mt6Z5K7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291167; c=relaxed/simple;
	bh=S62nqp/L7oaBVz+l0EkYVc7w8PWzqc5mHLXWWDxhwe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5utCUVS8wo+3o34wiPoKNWXAb/SFbJ4YWq6CXlQsR+m3rFOfS8VaP0KxlJ2mjbLxdxE8v3kY8QIvYg8eeZYnLvROLj30F+qZKtt7ySQN0fL9v4NuGuAVPxdKH/+5wAgkW57dqJ5QdmQ9o2ByEfPkv555i7qtknav3f4nz6Apto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=xppXZ4ua; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aae146b604so30139935ad.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774291162; x=1774895962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9OKWh4GFeDrs3iW8vGT1OneAtu45dtpNVuW7lfnaEs=;
        b=xppXZ4ua4pxk8tMDyUkC3S54I/nOd1N/VghTIbTBuj01dRaqzm+Ihm84NQviGM7Qul
         MvwIDizEeJnshNWkJ+L2Uo7IQtgrn12dYUdoynJrIiRndZVZZvPppHQY5jCphGpqZxAj
         Txn9fiJjJw3g4sC4u93RaOPOo5o8qH4bG8hGTrtAEaV6OHqRnweoIEkKBk46bKcgdl1j
         thAPEvR3Nih/IId/T7NbIwJnRQ5Vx61LsGxsdZa3bfTa2IxSOf35d5l4gHTG/ESbW1Vm
         Jr6vK3War8+7cXoH8/UbzKGc7FOxHix3lcxCntOwIApG+RCW3UVtGNU8yyA5+n/UFzPW
         OKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291162; x=1774895962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r9OKWh4GFeDrs3iW8vGT1OneAtu45dtpNVuW7lfnaEs=;
        b=JUt1pEAHlvyw9wDJQxmVyN1dtT2tDkjR2vpQrR2e7umPYjH05rkvQkqbGrdcaHfXaG
         cJmOCezTyB3CumozOr6KXj+1c3q7jOa8goDbua/VC547B6yzKzuSeaCLgQfIUvmIc7Dc
         nElwU1NcHdy2+DbbdZGIZ8Kv9s2FqrC+ewc5i4a67r97GsEdkynEwYvqU90liRCPUSTm
         xqPMKRsYTldFArJd8Mjz+24ORwWHZTaoSF2kZaYPnUhsTImiwErYKYc3+r1BDVcFYOVt
         ewWIm0tCbeYMAPMlTKU3GQcyWdBdo9McD6FAuJFQJrvN7cOa6fz5G5GlMNIo9nrOoBpz
         UYhA==
X-Gm-Message-State: AOJu0YxEURZlUdTAJ2ZqA8P4wRnRImGi1rG4TTx5Va3P4FPrHU3DtzyL
	rgcbwfEOKBZyAZPhg4npGM6liCaqQV3Hqwn/sU4SO13llg/FRzYn+41s4cxo7MICLg1nVcjYTDf
	8Ga/DeSw=
X-Gm-Gg: ATEYQzxYeTOFqS3vaIOH0snunHVUlbYjuCWNQ9ZPP2wpp1VXZp4TCmiUXyT8FDWXGXg
	sJdIEEYhnCHxWX7k0iAE/3wMzIbZaIAux4K35EbRXT7yxrGevgznLe8+VNPuF+Ul64LZ539zaC+
	ZbWDQJzYSvgnfZNKUSXT+C+G1KJld2dg1i19jfvBGgCKe7PtW3nIOx5Q4deufnaMorON+JObMP+
	XtmtjAhiP41BlNkbJI1Sfm/yJCq2Qjvx2qX90pu0KG1eInrL/qUDiBEXzX1wA/fx2EtKXQvU0GV
	XjrAf9WAY+tDbO+x4P+eJxxxsHxbUFjY08m7zEopjS+glFWwAYQ22iK98P0lucDqQyC5HLECuJH
	psVUKrvcW+CUHLFw2y8XiPDtvUCuudHpigqkiC7AxJtPVm/JXmCAbcQyoTrMlgB3ar55BgsICMO
	f5gbQ=
X-Received: by 2002:a17:902:f548:b0:2ae:c529:a13f with SMTP id d9443c01a7336-2b0826f5528mr122156715ad.14.1774291162408;
        Mon, 23 Mar 2026 11:39:22 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516908sm149199255ad.1.2026.03.23.11.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:39:22 -0700 (PDT)
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
Subject: [net-next v5 12/12] selftests: drv-net: Add USO test
Date: Mon, 23 Mar 2026 11:38:37 -0700
Message-ID: <20260323183844.3146982-13-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323183844.3146982-1-joe@dama.to>
References: <20260323183844.3146982-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-270678-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim,broadcom.com:email,dama.to:email,dama.to:mid,lib.py:url,uso.py:url]
X-Rspamd-Queue-Id: 96BB12FC08C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a simple test for USO. Can be used with netdevsim or real hardware.
Tests both ipv4 and ipv6 with several full segments and a partial
segment.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v5:
   - Added Pavan's Reviewed-by. No functional changes.

 v4:
   - Fix python linter issues (unused imports, docstring, etc).

 rfcv2:
   - new in rfcv2

 tools/testing/selftests/drivers/net/Makefile |  1 +
 tools/testing/selftests/drivers/net/uso.py   | 96 ++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/uso.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 7c7fa75b80c2..335c2ce4b9ab 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -21,6 +21,7 @@ TEST_PROGS := \
 	ring_reconfig.py \
 	shaper.py \
 	stats.py \
+	uso.py \
 	xdp.py \
 # end of TEST_PROGS
 
diff --git a/tools/testing/selftests/drivers/net/uso.py b/tools/testing/selftests/drivers/net/uso.py
new file mode 100755
index 000000000000..2ddeae99b4d6
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/uso.py
@@ -0,0 +1,96 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Test USO
+
+Sends large UDP datagrams with UDP_SEGMENT and verifies that the peer
+receives the correct number of individual segments with correct sizes.
+"""
+import socket
+import time
+
+from lib.py import ksft_run, ksft_exit, KsftSkipEx
+from lib.py import ksft_ge
+from lib.py import NetDrvEpEnv
+from lib.py import defer, ethtool, ip, rand_port
+
+# python doesn't expose this constant, so we need to hardcode it to enable UDP
+# segmentation for large payloads
+UDP_SEGMENT = 103
+
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
+
+def _get_rx_packets(cfg):
+    stats = ip(f"-s link show dev {cfg.remote_ifname}",
+               json=True, host=cfg.remote)[0]
+    return stats['stats64']['rx']['packets']
+
+
+def _test_uso(cfg, ipver, mss, total_payload):
+    cfg.require_ipver(ipver)
+
+    try:
+        ethtool(f"-K {cfg.ifname} tx-udp-segmentation on")
+    except Exception as exc:
+        raise KsftSkipEx(
+            "Device does not support tx-udp-segmentation") from exc
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
+
+def test_uso_v4(cfg):
+    """USO IPv4: 11 segments (10 full + 1 partial)."""
+    _test_uso(cfg, "4", 1400, 1400 * 10 + 500)
+
+
+def test_uso_v6(cfg):
+    """USO IPv6: 11 segments (10 full + 1 partial)."""
+    _test_uso(cfg, "6", 1400, 1400 * 10 + 500)
+
+
+def test_uso_v4_exact(cfg):
+    """USO IPv4: exact multiple of MSS (5 full segments)."""
+    _test_uso(cfg, "4", 1400, 1400 * 5)
+
+
+def main() -> None:
+    """Run USO tests."""
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run([test_uso_v4,
+                  test_uso_v6,
+                  test_uso_v4_exact],
+                 args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.52.0


