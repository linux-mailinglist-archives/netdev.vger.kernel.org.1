Return-Path: <netdev+bounces-276196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INgKOU+A1Wn36wcAu9opvQ
	(envelope-from <netdev+bounces-276196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:08:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A70C3B53A4
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59D2830AC25B
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 22:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD27388376;
	Tue,  7 Apr 2026 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="A8F05xPr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB53876B5
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 22:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599425; cv=none; b=PajW/U39kKGerjw4tq5hsS3tt6hTrIrH7a0p9RyI/y8/GfmJ3O9iwgc1/EGXgbkFoMhc3sKB6ofyoXXNvuROt5kew65noXwm/mppnw3DaremaJ9Wa4l/HnYUSUGP6YnLiB/BuXmboiADobetFFcTrLsDdolRUE4frwWJneE+xxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599425; c=relaxed/simple;
	bh=o/NtSsecFTNFsiPqiNCLzmEF05SSxO9/5XaAXM7arIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3ojiLWrM3pWwZaIXFmOcv0sVl6AXJVLrlFMvfl5URknIaQql4YZPQUaMM0bzaMGqDGmfGHwUAP2dLs1FxubXgALDH802D9E4sDFXvvHLISyK2IvOPva3tqYr1NF3UJgRUdGVlkYbY+NQdiiALTt4a9WObGNOBo2U2x+hv7CSXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=A8F05xPr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35691a231a7so3052233a91.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 15:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775599423; x=1776204223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmD0I3pcx04Mtpj/oo4F+jl+//3G3jRQHwrxWNrdT1Y=;
        b=A8F05xPr23ZAyBRW50hOtfIKI5FaNNvrIL2+XslcNalgNgrdz3GFTSF3zo0Hd7d9ZU
         lHmtk/eYMJIKI52ZVn5Y4282qTNAIuMBr0FDeHgK2Ebg60R9vt4U8qK4f0NIRskcD4bK
         milGHICq9G8hdnR7N+tZovni7XLJkl3YU6RmbKMbcL5mD4OFr1P3LsChDGnM2P6ua/e0
         y6rgI2JPGS1je+uLccTK9OiKljSX6O7cLEJuKjwKHbI67foidwCQWnbS0y5KoVh38IWf
         sVaPiiyPGJzwtFnq8WQYMMwYOoht+LPpNLE1pQ/goG/lStKHPqVQVnozasuEVZuigLD6
         cuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775599423; x=1776204223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kmD0I3pcx04Mtpj/oo4F+jl+//3G3jRQHwrxWNrdT1Y=;
        b=bLbAn5R5TiM5OsFPH0PO6iN1+DII0CTJopEGBfbmNjt9Oo9q0Ms2K/bsx/+YLCX869
         CNP7rxS6t+AP1lGzztxmviH0mIjFtSboKDcjiaMxsleVvGH18Q0mZ3wOA2IX8RY8mpMl
         K9z46BKQKRPFAHxPFtHMXi3jYOmcPz4vkVfmQhR7mIKs4X945nRGroBOa/9UhZ9Wb8ff
         KfVyitQIoGkXwWvRaj2FfMFxxiRyhy+ujBiJVU863r8JRjE/+PQy/+5tZsXY043y8ues
         uFfmxzPBGpJSf/ydvr2c8oHfjU1Hbjs8bUhKPY5hF6RTXM7Tb9p8/aWS01oBWEk+8I6V
         nEMw==
X-Gm-Message-State: AOJu0Yz8OeQ6c0uAfq/j6x3tkDkarJ9vEjR5+IT7B5lVV8tSW7d+JcpY
	dFV6oaVOCZ2fJuhg7Fm1OxorYcYDaQX/dRzVI0SV9sOTH3o643WmMeM7+C9dTe0X8adld9JsrPw
	loNgFlAA=
X-Gm-Gg: AeBDies/KxSc74p2/YmxTeOm7TiBkCO307JAkrHfd+9rZx406WAdNxV7So910O1Srgv
	yJm2Dad8IUoeGXxIBl7S0fxpnWc+msaRq/+ZIp/Yj9P1L3mQqQwG8Igcirb6C8Z/atj6kSKxSsE
	6sAh/44AJfwJe9fs66K4HmFOiD6Z1ijH6R0jTVGo1sjA6TTo7733tga4tMKALsJOMVwQth4IcqZ
	Xw1U9FkoGxoSimaUNxoCMBfT1F16CKtz/6qDl7mEpYXZz3jeExZMCPrhB0Pxy/hUcMYS6FTqGIH
	C7xmI+L19+pI1orwM8gfbgLzBkuhTibr1H4qZwhG1aO5mlJ0IbaJekYMYFWJD1mlyhw9oiSq8hK
	QoN4d90s5Cn9ro5i55zUnpRlAuqNeWQlteoSFNdyX3FsTiIcpsTW7B/5E8yxqlZSWDL9d5VYKbc
	/xVgT3
X-Received: by 2002:a17:90b:2251:b0:35d:b00a:3c54 with SMTP id 98e67ed59e1d1-35de69acf35mr18090837a91.22.1775599422777;
        Tue, 07 Apr 2026 15:03:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f7229sm19645039a91.7.2026.04.07.15.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 15:03:42 -0700 (PDT)
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
Subject: [net-next v9 10/10] selftests: drv-net: Add USO test
Date: Tue,  7 Apr 2026 15:03:06 -0700
Message-ID: <20260407220313.3990909-11-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407220313.3990909-1-joe@dama.to>
References: <20260407220313.3990909-1-joe@dama.to>
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
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-276196-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,uso.py:url,dama.to:email,dama.to:mid,lib.py:url]
X-Rspamd-Queue-Id: 6A70C3B53A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a simple test for USO. Tests both ipv4 and ipv6 with several full
segments and a partial segment.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v9:
   - Use UDP-LISTEN instead of UDP-RECV in socat receiver (suggested by AI).
   - Fixed stale docstring.
   - Removed unused return value.

 v7:
   - Dropped Pavan's Reviewed-by as there were changes.
   - Update to use ksft_variants with a generator and a parameterized test_uso
     function.
   - Save original USO state and restore it at the end of the test.
   - Replace sleep with cfg.wait_hw_stats_settle
   - Use a socat receiver and check tx stats locally instead of rx on the
     remote.

 v5:
   - Added Pavan's Reviewed-by. No functional changes.

 v4:
   - Fix python linter issues (unused imports, docstring, etc).

 rfcv2:
   - new in rfcv2

 tools/testing/selftests/drivers/net/Makefile |   1 +
 tools/testing/selftests/drivers/net/uso.py   | 103 +++++++++++++++++++
 2 files changed, 104 insertions(+)
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
index 000000000000..6d61e56cab3c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/uso.py
@@ -0,0 +1,103 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Test USO
+
+Sends large UDP datagrams with UDP_SEGMENT and verifies that the peer
+receives the expected total payload and that the NIC transmitted at least
+the expected number of segments.
+"""
+import random
+import socket
+import string
+
+from lib.py import ksft_run, ksft_exit, KsftSkipEx
+from lib.py import ksft_eq, ksft_ge, ksft_variants, KsftNamedVariant
+from lib.py import NetDrvEpEnv
+from lib.py import bkg, defer, ethtool, ip, rand_port, wait_port_listen
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
+    payload = ''.join(random.choice(string.ascii_lowercase)
+                      for _ in range(total_payload))
+    sock.sendto(payload.encode(), dst)
+    sock.close()
+
+
+def _get_tx_packets(cfg):
+    stats = ip(f"-s link show dev {cfg.ifname}", json=True)[0]
+    return stats['stats64']['tx']['packets']
+
+
+def _test_uso(cfg, ipver, mss, total_payload):
+    cfg.require_ipver(ipver)
+    cfg.require_cmd("socat", remote=True)
+
+    features = ethtool(f"-k {cfg.ifname}", json=True)
+    uso_was_on = features[0]["tx-udp-segmentation"]["active"]
+
+    try:
+        ethtool(f"-K {cfg.ifname} tx-udp-segmentation on")
+    except Exception as exc:
+        raise KsftSkipEx(
+            "Device does not support tx-udp-segmentation") from exc
+    if not uso_was_on:
+        defer(ethtool, f"-K {cfg.ifname} tx-udp-segmentation off")
+
+    expected_segs = (total_payload + mss - 1) // mss
+
+    port = rand_port(stype=socket.SOCK_DGRAM)
+    rx_cmd = f"socat -{ipver} -T 2 -u UDP-LISTEN:{port},reuseport STDOUT"
+
+    tx_before = _get_tx_packets(cfg)
+
+    with bkg(rx_cmd, host=cfg.remote, exit_wait=True) as rx:
+        wait_port_listen(port, proto="udp", host=cfg.remote)
+        _send_uso(cfg, ipver, mss, total_payload, port)
+
+    ksft_eq(len(rx.stdout), total_payload,
+            comment=f"Received {len(rx.stdout)}B, expected {total_payload}B")
+
+    cfg.wait_hw_stats_settle()
+
+    tx_after = _get_tx_packets(cfg)
+    tx_delta = tx_after - tx_before
+
+    ksft_ge(tx_delta, expected_segs,
+            comment=f"Expected >= {expected_segs} tx packets, got {tx_delta}")
+
+
+def _uso_variants():
+    for ipver in ["4", "6"]:
+        yield KsftNamedVariant(f"v{ipver}_partial", ipver, 1400, 1400 * 10 + 500)
+        yield KsftNamedVariant(f"v{ipver}_exact", ipver, 1400, 1400 * 5)
+
+
+@ksft_variants(_uso_variants())
+def test_uso(cfg, ipver, mss, total_payload):
+    """Send a USO datagram and verify the peer receives the expected segments."""
+    _test_uso(cfg, ipver, mss, total_payload)
+
+
+def main() -> None:
+    """Run USO tests."""
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run([test_uso],
+                 args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.52.0


