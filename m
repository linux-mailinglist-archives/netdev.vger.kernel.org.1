Return-Path: <netdev+bounces-276741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPUvKqDf1mmsJQgAu9opvQ
	(envelope-from <netdev+bounces-276741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:07:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 573623C4A63
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E706302F4A6
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9495B3A3838;
	Wed,  8 Apr 2026 23:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="lxP6H9ib"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEDB3A383F
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 23:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689601; cv=none; b=ERO3tkN5vfjnje4TBuzF6Tn+ONSUQi23Yrah8kVionys9aEMj6Uvz6s7OezWD/JVd6I/gGtr5r7gskrtXpUM6yVlVqH5YGfaGnoZKy/oTTV8uSg2/EMap108Ai1zHNA56sCglJ8DeWLXk8N1tKlgzvoVcP+9WpL8QkhvKSkIq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689601; c=relaxed/simple;
	bh=eavrLBchN8fm9XIu1vqukYxkvy5howdAitN/UagQmIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=La8FOiRimhbNXeYi3WJB5a8K2mqsQoRCAEh7waaDZPgBFMiQQNn1IopaqI9vON687OSsV8qYPIDD0kApIw/U/+j/3og9KO0LU/9H+4DzcjX7EfHIrL0QL13G8UbQV0ObUG4vA6Dl2M6i5ibQgUYEKAbgSWTiCYB/dsz3TAyZorM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=lxP6H9ib; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c76b87931b8so178802a12.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775689592; x=1776294392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaI/8wTi1iXn0q/44Vh7ATr+prNCrN7zaPdtxJM69Ko=;
        b=lxP6H9ib/yxziiVSV5eUcStMTXg6xPl7bTt/AwD1Ib5uGElTb3dfZ7gFwz68PtJjhR
         K1BPBNN7ixBemH6aFegfukdaDLMPgb77P8qQM75sA7ZAKWhBUbq78/5BkiuyYZ0HXgRp
         Nk92WEpuZ+bVZK9CnBS8NbOKKMMH9KU8b/882XhvJ8jW1IBy9PPArBKGqxG9/ZducAzh
         M81eVMdEE7k1NqR8hTSiTk+sc4IKfm3RWUy4aR2MxJ4Lf9IbyqerEDJ560PZp9ZpvPdN
         osL0VrnPWkkh4sWnknvP+zC1457GX+qbqqo7YY2RSEG5hgCTfOreo3pl+PlPSQM7VtMT
         O9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775689592; x=1776294392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RaI/8wTi1iXn0q/44Vh7ATr+prNCrN7zaPdtxJM69Ko=;
        b=At0N3hLGyOpvjTq1Yt3RJwjrlYAiPo1oZsCukwzkR8QrzFXROar0vBsCYbd7tLngYY
         yMr1vT1ohgP6ODkKHM8/LUxajGUgyQ7nuEGlrq7YpLW8mqgdx/KZbHkELaiB3GPdrXQB
         3AQu2NTdjUAI68sumrRjHLqW/JJILUFEaM6rc7NjcCqBPW1pEglq0l/3ninjoppDaDIx
         ucV0cZKnEuKJkkPR8uDa7EY8xLt4N/oLZVo5cNyXvuKF/Yo9O5fTVikjM5zywGBsTn+7
         Szn2y8qHJk8CF/CS95XVgvSlCQ5ejJ8GLpNUonvz+9lah+iTg9i7NmhMCx1+eZ4nFbOV
         oSfw==
X-Gm-Message-State: AOJu0YzYtPIXsy3WMos+c9ibkV/JpagTZliL42GTdtlRG/dz7P0peotx
	GzPyirqY8tKPZrEeonqfMWrMq3lXUrpB9ub/0mfVB21siOV5PkjXzJIInrRQUSnJl+rzVsfzWUy
	81rvvwCU=
X-Gm-Gg: AeBDievbTh4U7v39AObNH6WLU90oWs9GchLF0XDxGezEc1oqJZt+kJUNrqd2+oTr5C4
	6JHR3BAdFezqBobmOEI8fnTkqlSjHoFKYCQBfBzmGi8XT1hSkv5fagKbqc8iPMKYN9pR1iiuw6W
	ouk9VwHLfwLUyD+jY4uGaHQGikreYc8d5a0mYs9Ns8qwhphoRJMOjYsSjv+Flh+72uLadCxclvX
	SyFsivoMcrKvqXKdmX17f1D8OXdbwaje3+NS1gm/9B8yTZIjh4T0vrTPhznhPf2ZDyLe1QqaTM7
	a/GFNEDrT8/vTdhJgXhcpTZ3WgP5TZqD7Hoy3z5gap4vUYEG0hkDUF3G/dZ6cqPSmWSwkHCzK+w
	Zo5scYyGwG3ZhCfK2m10sT5WOu5q8UuBuVmWPWWLWHAw4atCdD4uxB+WAciZU17VsRtVPiGWcrm
	crA60=
X-Received: by 2002:a05:6a20:94c8:b0:398:7998:8300 with SMTP id adf61e73a8af0-39f2f179df6mr22822579637.58.1775689592275;
        Wed, 08 Apr 2026 16:06:32 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6ad8asm22239635b3a.40.2026.04.08.16.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:06:31 -0700 (PDT)
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
Subject: [net-next v10 10/10] selftests: drv-net: Add USO test
Date: Wed,  8 Apr 2026 16:05:59 -0700
Message-ID: <20260408230607.2019402-11-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408230607.2019402-1-joe@dama.to>
References: <20260408230607.2019402-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276741-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dama-to.20251104.gappssmtp.com:dkim,dama.to:email,dama.to:mid,uso.py:url,lib.py:url]
X-Rspamd-Queue-Id: 573623C4A63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a simple test for USO. Tests both ipv4 and ipv6 with several full
segments and a partial segment.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v10:
   - Moved test from drivers/net/ to drivers/net/hw/ since it requires real
     hardware. No functional changes.

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

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/uso.py | 103 ++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/uso.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index deeca3f8d080..5c348c8d72ae 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -43,6 +43,7 @@ TEST_PROGS = \
 	rss_input_xfrm.py \
 	toeplitz.py \
 	tso.py \
+	uso.py \
 	xdp_metadata.py \
 	xsk_reconfig.py \
 	#
diff --git a/tools/testing/selftests/drivers/net/hw/uso.py b/tools/testing/selftests/drivers/net/hw/uso.py
new file mode 100755
index 000000000000..6d61e56cab3c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/uso.py
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


