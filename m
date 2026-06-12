Return-Path: <netdev+bounces-298411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id toyEFzxQK2oc6gMAu9opvQ
	(envelope-from <netdev+bounces-298411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 02:18:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B65675E5D
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 02:18:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rvkaFB4+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298411-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298411-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F2913176249
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47280261388;
	Fri, 12 Jun 2026 00:18:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1961A6808
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 00:17:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781223482; cv=none; b=CzTwI1tzeirKdJQ9ERVwN63RWSStswKSZuSFBA0Fd0q03HX4dikmguozVOzexcXzWCDUXJ4eSBGnJvCJTyZiHilrLzq4vD9rRGR8wuMD7J6yTyc9URo9VudBp6RhozhsC3kSXsNmazj1anqihQU0IjiTMsEIMUa8w8ZwIRzltD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781223482; c=relaxed/simple;
	bh=j7uOBGOWOUHxEgVJqerTtY0Pst0XirntyuZpZ3i9KH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qHwsFK8VV18st46CV2PZg2e8F5r2EsaTBI+58cp2RaUbyKDY8SR6apVq2zuUm7QVNlIyTlIknvajqN4S2cleJRmWK56V74e6bPzm+hgpvCVq3p3lAU1VVRL6pLIxsJCBYOnHPX0QpGenclqmnt9fhrjqKRAqdpV7VFkHi+WUDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rvkaFB4+; arc=none smtp.client-ip=209.85.160.51
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-43d08bc82deso426270fac.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 17:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781223479; x=1781828279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fbOR7faLhl6QNiMFhxyuN3Xj5ppMarngi323ERxJp8E=;
        b=rvkaFB4+1Ka9dVwLI3YyVHpjmyrpiuGYsMybO2gic+aTkG3h/17gpKAcYqqGWn5BqD
         7tLnWAWIDKCBNW5cy3iGdD6Wr6CRV7oESaHYZuoQwEXuRcInOJZrV1GaBMMvcG7u18SH
         6F8zrOUWxqI3aMJQybALKUq0hA8xVfma3oNrhVS5EjyEn8YuWRypXlt74Cb6FA46dz9d
         xmRTgFAI6qFCkrEJCYMjUhNYg8DmO7qjm6hkNiYduhRSphRNYjVXV92QSNE5Pp2zvSr9
         ZE1a1ep1cBhq7GjcAPcnEeb2QmGkD/LAqO4WtRvPaaHR2bOrGRu3KqFIpTLk5j0lBpQK
         brBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781223479; x=1781828279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbOR7faLhl6QNiMFhxyuN3Xj5ppMarngi323ERxJp8E=;
        b=Zc0QxsAx0yXYM4e3kkEO9lFVrAVS3phcRrxKLGgIa8HnF1uSAve13cKB+TehlnhUUv
         MtPnxYxcP1CjdTvUvY+Z3RTxeKqOa+QtOAxQ8TdtB655WBe5JjXxw81n2LoiUUR+X6w/
         Tw9Z25fgjDXpnqiK5soSkKVgzxpYqwk7RvlLmTIH9gUyGVP+2XJCQ+lYtJWk2N3Tuwf/
         gITWpIC58LPYjPbW12/aHieFMRPjMmHVNXWSpE1a6G3f/dIS0NpW9O5kL5JyVXUCD6iy
         jL3b2dQw6dMRyWJdfiZ7y1AhCFNki0ey6fQFLu2R9koPkHImxmmN6MBHijeVCepGjHLX
         Ypvw==
X-Gm-Message-State: AOJu0YzZ+QC3iv6P9zQ310IGn0sidKc7HJZoCoLEeVeWSNm+eEiBt4dC
	f9yIXGcY4YHJ+PInJpMfplR/EQ6qZgNNdQ9z+x8au4kfY16VriAR43FcSetHd0Oj
X-Gm-Gg: Acq92OGI4zjYlYMlIbUJq0foottC3H8wGPo7mohdfuOH+LODGnLWtTOntFSQSj7FbRz
	PNMxGuyihWxafiooW6eA+5Du4yjD3jKWU5eSgtqx535fNVxDoGppyIAou3wamooHVylsr2lTmzw
	b158wnG673skfc3s4K3mgx9xUkIYajkcEAZ+l3XrzaU+Fqo7GMzW4iaCiKosMPYwzcmXz0KBSsz
	oTtwj9KQL/i9A0KydArzvYOl9qxip3SshvI0PkUHC/8RJ5+IcFsp7mtDH5jt+zR3hHpdKZ0LD8U
	ZnEXhFKV3wne+yHT/b5rKGsNPMs/8lcvzDS5BohhY+p6G2Vs7kBIvW8p/4yk8QwIcOenUaRvj5Q
	2/CVJoyR08DxWJbQ8bu2XdV9pHojE6lVY+P62EI7JYk1ViLGkedYOH2hsxxQOdjW/k/JbGD7kfy
	JP4nRvkkCq0El2sU+IMQo=
X-Received: by 2002:a05:6870:179d:b0:43d:a174:b8d0 with SMTP id 586e51a60fabf-4426dd8a63bmr298590fac.14.1781223478791;
        Thu, 11 Jun 2026 17:17:58 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4426ab10c46sm442562fac.1.2026.06.11.17.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 17:17:57 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: Test queue stall upon reconfig
Date: Thu, 11 Jun 2026 17:17:53 -0700
Message-ID: <20260612001754.2489868-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298411-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4B65675E5D

From: Mohsin Bashir <hmohsin@meta.com>

Add a reconfig_tx_stall test that detects the possibility of a TX stall
after ring reconfiguration. The key observation is that drivers using
netif_tx_start_all_queues() are prone to experiencing a stall when
reconfiguration completes compared to drivers using
netif_tx_wake_all_queues(). start_all_queues only clears DRV_XOFF, while
wake_all_queues also calls __netif_schedule() to kick the qdisc. Without
the kick, qdisc backlog present at reconfig time can stay stuck until a
new trigger is issued.

The test caps the TX ring at 64 entries so it fills quickly, then
installs FQ on a target TX queue and sends UDP packets with SO_TXTIME
scheduled in the future. With napi_defer_hard_irqs slowing completions,
the small ring can fill when FQ releases the burst, leaving requeued
qdisc backlog with no FQ timer to rescue it. A subsequent ring reconfig
must wake the queues to drain the backlog. Simply starting the queues can
leave it stuck.

On host with problematic driver:
 Sent 128 SO_TXTIME packets (+100ms)
 Sent 128 SO_TXTIME packets (+200ms)
 Backlog before reconfig: 52632 bytes
 Check| At /root/ksft-net-drv/./drivers/net/ring_reconfig.py, ...
 Check|     ksft_eq(0, backlog,
 Check failed 0 != 52632 qdisc backlog stuck on queue 1 after ring reconfig
not ok 3 ring_reconfig.reconfig_tx_stall

On host with fixed driver:
 Sent 128 SO_TXTIME packets (+100ms)
 Sent 128 SO_TXTIME packets (+200ms)
 Backlog before reconfig: 76024 bytes
ok 3 ring_reconfig.reconfig_tx_stall

Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/config    |   4 +
 .../selftests/drivers/net/ring_reconfig.py    | 175 +++++++++++++++++-
 2 files changed, 177 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index 617de8aaf551..d5787ccdd16f 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -7,6 +7,10 @@ CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
+CONFIG_NET_ACT_SKBEDIT=m
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_CLS_FLOWER=m
+CONFIG_NET_CLS_MATCHALL=m
 CONFIG_NETDEVSIM=m
 CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_FQ=m
diff --git a/tools/testing/selftests/drivers/net/ring_reconfig.py b/tools/testing/selftests/drivers/net/ring_reconfig.py
index f9530a8b0856..17831e2f0f65 100755
--- a/tools/testing/selftests/drivers/net/ring_reconfig.py
+++ b/tools/testing/selftests/drivers/net/ring_reconfig.py
@@ -5,10 +5,17 @@
 Test channel and ring size configuration via ethtool (-L / -G).
 """
 
+import socket
+import struct
+import time
+
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_eq
+from lib.py import KsftSkipEx
 from lib.py import NetDrvEpEnv, EthtoolFamily, GenerateTraffic
-from lib.py import defer, NlError
+from lib.py import cmd, defer, rand_port, tc, NlError
+
+SO_TXTIME = 61
 
 
 def channels(cfg) -> None:
@@ -151,6 +158,169 @@ def ringparam(cfg) -> None:
         GenerateTraffic(cfg).wait_pkts_and_stop(10000)
 
 
+def _write_sysfs(cfg, path, val):
+    with open(path, "r", encoding="utf-8") as fp:
+        orig_val = fp.read().strip()
+    if str(val) == orig_val:
+        return
+    with open(path, "w", encoding="utf-8") as fp:
+        fp.write(str(val))
+    defer(lambda p=path, v=orig_val: open(p, "w").write(v))
+
+
+def _get_mq_handle(cfg):
+    qdiscs = tc(f"qdisc show dev {cfg.ifname}", json=True)
+    for q in qdiscs:
+        if q.get("kind") == "mq":
+            return q["handle"]
+    raise KsftSkipEx(f"no mq qdisc found on {cfg.ifname}")
+
+
+def _get_qdisc_backlog(cfg, queue, mq_handle):
+    qdiscs = tc(f"-s qdisc show dev {cfg.ifname}", json=True)
+    target_parent = f"{mq_handle}{queue + 1:x}"
+    for q in qdiscs:
+        if q.get("parent", "") == target_parent:
+            return q.get("backlog")
+    return None
+
+
+def _setup_fq_qdisc(cfg, mq_handle, port, target_queue, other_queue):
+    mq_child_parent = f"{mq_handle}{target_queue + 1:x}"
+
+    # Save the original child qdisc to restore after test
+    qdiscs = tc(f"qdisc show dev {cfg.ifname}", json=True)
+    default_qdisc = cmd("sysctl -n net.core.default_qdisc").stdout.strip()
+    orig_kind = default_qdisc
+    for q in qdiscs:
+        if q.get("parent", "") == mq_child_parent:
+            orig_kind = q.get("kind", default_qdisc)
+            break
+    try:
+        tc(f"qdisc replace dev {cfg.ifname} parent {mq_child_parent} fq")
+    except Exception as exc:
+        raise KsftSkipEx("fq not available (CONFIG_NET_SCH_FQ)") from exc
+    defer(tc,
+          f"qdisc replace dev {cfg.ifname} parent {mq_child_parent} {orig_kind}")
+
+    qdisc_j = tc(f"qdisc show dev {cfg.ifname}", json=True)
+    has_clsact = any(q['kind'] == 'clsact' for q in qdisc_j)
+    if not has_clsact:
+        tc(f"qdisc add dev {cfg.ifname} clsact")
+        defer(tc, f"qdisc del dev {cfg.ifname} clsact")
+
+    proto = "ipv6" if int(cfg.addr_ipver) == 6 else "ip"
+    try:
+        tc(f"filter add dev {cfg.ifname} egress protocol {proto} "
+           f"pref 1 flower ip_proto udp dst_port {port} "
+           f"action skbedit queue_mapping {target_queue}")
+    except Exception as exc:
+        raise KsftSkipEx("tc flower/act_skbedit not available") from exc
+    defer(tc, f"filter del dev {cfg.ifname} egress pref 1")
+
+    tc(f"filter add dev {cfg.ifname} egress pref 100 "
+       f"matchall action skbedit queue_mapping {other_queue}")
+    defer(tc, f"filter del dev {cfg.ifname} egress pref 100")
+
+
+def _create_sotxtime_socket(cfg):
+    sock = socket.socket(socket.AF_INET6 if cfg.addr_ipver == "6"
+                         else socket.AF_INET, socket.SOCK_DGRAM)
+    try:
+        sock.setsockopt(socket.SOL_SOCKET, SO_TXTIME, struct.pack("Ii", 1, 0))
+    except OSError:
+        sock.close()
+        raise KsftSkipEx("SO_TXTIME not supported")
+    sock.setsockopt(socket.SOL_SOCKET, socket.SO_BINDTODEVICE,
+                    cfg.ifname.encode())
+    return sock
+
+
+def _send_sotxtime_burst(sock, addr, port, count, delay_ns, ipver):
+    payload = b'\x00' * 1400
+    txtime_ns = time.clock_gettime_ns(time.CLOCK_MONOTONIC) + delay_ns
+
+    ancdata = [(socket.SOL_SOCKET, SO_TXTIME, struct.pack("Q", txtime_ns))]
+    if int(ipver) == 6:
+        dest = (addr, port, 0, 0)
+    else:
+        dest = (addr, port)
+    for _ in range(count):
+        sock.sendmsg([payload], ancdata, 0, dest)
+
+
+def reconfig_tx_stall(cfg) -> None:
+    target_queue = 1
+    other_queue = 0
+
+    ehdr = {'header': {'dev-index': cfg.ifindex}}
+    chans = cfg.eth.channels_get(ehdr)
+
+    if 'combined-max' not in chans:
+        raise KsftSkipEx("device does not support combined channels")
+    if chans['combined-count'] < 2:
+        raise KsftSkipEx("need at least 2 combined channels")
+
+    rings = cfg.eth.rings_get(ehdr)
+    if 'rx' not in rings or 'tx' not in rings:
+        raise KsftSkipEx("device does not expose rx/tx ring params")
+    tx_cur = rings['tx']
+    if tx_cur <= 64:
+        raise KsftSkipEx("tx ring size already at minimum")
+    defer(cfg.eth.rings_set, ehdr | {'tx': tx_cur})
+
+    tx_min = 64
+    cfg.eth.rings_set(ehdr | {'tx': tx_min})
+
+    # Slow completions so the ring stays full after FQ releases packets
+    napi_defer = f"/sys/class/net/{cfg.ifname}/napi_defer_hard_irqs"
+    gro_timeout = f"/sys/class/net/{cfg.ifname}/gro_flush_timeout"
+    _write_sysfs(cfg, napi_defer, 100)
+    _write_sysfs(cfg, gro_timeout, 1000000000)
+
+    mq_handle = _get_mq_handle(cfg)
+    port = rand_port()
+    _setup_fq_qdisc(cfg, mq_handle, port, target_queue, other_queue)
+
+    sock = _create_sotxtime_socket(cfg)
+    defer(sock.close)
+
+    pkt_count = tx_min * 2
+
+    for delay_ms in [100, 200, 500]:
+        delay_ns = delay_ms * 1_000_000
+        _send_sotxtime_burst(sock, cfg.remote_addr, port, pkt_count,
+                             delay_ns, cfg.addr_ipver)
+        ksft_pr(f"Sent {pkt_count} SO_TXTIME packets (+{delay_ms}ms)")
+        time.sleep(delay_ms / 1000 + 0.3)
+
+        backlog = _get_qdisc_backlog(cfg, target_queue, mq_handle)
+        if backlog:
+            break
+    else:
+        raise KsftSkipEx("failed to build qdisc backlog")
+
+    ksft_pr(f"Backlog before reconfig: {backlog} bytes")
+
+    # Trigger ring reconfig — driver should call wake, not just start
+    cfg.eth.rings_set(ehdr | {'tx': tx_cur})
+
+    # Let completions proceed normally
+    _write_sysfs(cfg, napi_defer, 0)
+    _write_sysfs(cfg, gro_timeout, 0)
+
+    # Poll for backlog to drain
+    for _ in range(100):
+        backlog = _get_qdisc_backlog(cfg, target_queue, mq_handle)
+        if not backlog:
+            break
+        time.sleep(0.1)
+
+    ksft_eq(0, backlog,
+            comment=f"qdisc backlog stuck on queue {target_queue} "
+                    f"after ring reconfig")
+
+
 def main() -> None:
     """ Ksft boiler plate main """
 
@@ -158,7 +328,8 @@ def main() -> None:
         cfg.eth = EthtoolFamily()
 
         ksft_run([channels,
-                  ringparam],
+                  ringparam,
+                  reconfig_tx_stall],
                  args=(cfg, ))
     ksft_exit()
 
-- 
2.53.0-Meta


