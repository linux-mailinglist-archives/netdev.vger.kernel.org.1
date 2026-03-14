Return-Path: <netdev+bounces-267733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHcYI8ZltWl90AAAu9opvQ
	(envelope-from <netdev+bounces-267733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 14:42:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D4128D56F
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 14:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FF283022557
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 13:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA37378813;
	Sat, 14 Mar 2026 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A7BirgDy"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DE0352C52
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773495745; cv=none; b=R3iXfeelBIPQRCIk1IdcSYfbYlGwcKwoiW6KjQ4E7EpVq1RWmpIePread93/aKcpaVNLAyV7wCJjTQLeUlNmPFZGc/qhB0qk2fjviLtYuRjGUIeEodfvVietqDcQni9orS+Oj4zs3D4qvBMk/UABlw/Pj+ze8owMGXH26T7x3n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773495745; c=relaxed/simple;
	bh=vD0lWqO8uPTniXCR2wzvzqwCRNCqPfEZxRMIzwdc90o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F50F9HxFPNT33Iq4CvbDHYoII+DuXiB1Mopg5urwETlUqg0pmn6vEbpa9DW7P3/17QEsDDbhRcIMD0jaIeR0HymKDnC/QbDsAXdhPeppbd8S7i7KXk+9Uee3jI/MyGbUuAnl344KnwXjU7RcWWutwffAFAMkeHCBsx4cDQFAh/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A7BirgDy; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773495741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OitJ18LbV3U8rIZ7uUZRphAgZiJyxDjT4DUpok4Nlpw=;
	b=A7BirgDycIkrKxpduErh6TtnO3g1rvWxWRAz4oB4AOJ4lU3EPtc8Z3jCl4qvieXD6L/HgS
	TXp5YLGteQV+l+Fq9IqnYkzimJohlcxQVv/um1xYZXinKhWX2SnOFVhoaJmoR4Tah+nYzR
	CM9FEO49PV8d89/TSEqHkQfgs8t6vUI=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org,
	edumazet@google.com
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v1] selftests: bonding: add test for stacked bond header_parse recursion
Date: Sat, 14 Mar 2026 21:42:05 +0800
Message-ID: <20260314134211.33405-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-267733-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bond-lladdr-target.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bond-eth-type-change.sh:url,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 04D4128D56F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Add a selftest to reproduce the infinite recursion in bond_header_parse()
when bonds are stacked (bond1 -> bond0 -> gre). When a packet is received
via AF_PACKET SOCK_DGRAM on the topmost bond, dev_parse_header() calls
bond_header_parse() which used skb->dev (always the topmost bond) to get
the bonding struct. This caused it to recurse back into itself
indefinitely, leading to stack overflow.

Before Eric's fix [2], the test triggers:

  ./bond-stacked-header-parse.sh

  [  71.999481] BUG: MAX_LOCK_DEPTH too low!
  [  72.000170] turning off the locking correctness validator.
  [  72.001029] Please attach the output of /proc/lock_stat to the bug report
  [  72.002079] depth: 48  max: 48!
  ...

After Eric's fix [2], everything works fine:

  ./bond-stacked-header-parse.sh
  TEST: Stacked bond header_parse does not recurse                  [ OK ]

Also verified via make run_tests -C drivers/net/bonding:

  ...
  ok 3 selftests: drivers/net/bonding: bond-eth-type-change.sh
  # timeout set to 1200
  # selftests: drivers/net/bonding: bond-stacked-header-parse.sh
  # TEST: Stacked bond header_parse does not recurse                [ OK ]
  ok 4 selftests: drivers/net/bonding: bond-stacked-header-parse.sh
  # timeout set to 1200
  # selftests: drivers/net/bonding: bond-lladdr-target.sh
  # PASS
  ...

[1] https://lore.kernel.org/netdev/CANn89iK2EURqsjtd=OVP4awYTJHGcR-UU-V9WovpWR1Z3f03oQ@mail.gmail.com/
[2] https://lore.kernel.org/netdev/20260314115650.3646361-1-edumazet@google.com/

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 .../selftests/drivers/net/bonding/Makefile    |   1 +
 .../net/bonding/bond-stacked-header-parse.sh  | 142 ++++++++++++++++++
 2 files changed, 143 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-stacked-header-parse.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 6c5c60adb5e8..055f6af03b5d 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -5,6 +5,7 @@ TEST_PROGS := \
 	bond-arp-interval-causes-panic.sh \
 	bond-break-lacpdu-tx.sh \
 	bond-eth-type-change.sh \
+	bond-stacked-header-parse.sh \
 	bond-lladdr-target.sh \
 	bond_ipsec_offload.sh \
 	bond_lacp_prio.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond-stacked-header-parse.sh b/tools/testing/selftests/drivers/net/bonding/bond-stacked-header-parse.sh
new file mode 100755
index 000000000000..d377bedaef63
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond-stacked-header-parse.sh
@@ -0,0 +1,142 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test that bond_header_parse() does not infinitely recurse with stacked bonds.
+#
+# When a non-Ethernet device (e.g. GRE) is enslaved to a bond that is itself
+# enslaved to another bond (bond1 -> bond0 -> gre), receiving a packet via
+# AF_PACKET SOCK_DGRAM triggers dev_parse_header() -> bond_header_parse().
+# Since parse() used skb->dev (always the topmost bond) instead of a passed-in
+# dev pointer, it would recurse back into itself indefinitely.
+
+ALL_TESTS="
+	bond_test_stacked_header_parse
+"
+REQUIRE_MZ=no
+NUM_NETIFS=0
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/forwarding/lib.sh
+
+require_command()
+{
+	if ! command -v "$1" &>/dev/null; then
+		echo "SKIP: $1 is not installed"
+		exit "$ksft_skip"
+	fi
+}
+
+bond_test_stacked_header_parse()
+{
+	local devdummy="test-dummy0"
+	local devgre="test-gre0"
+	local devbond0="test-bond0"
+	local devbond1="test-bond1"
+
+	RET=0
+
+	# Setup: dummy -> gre -> bond0 -> bond1
+	modprobe dummy 2>/dev/null
+	modprobe ip_gre 2>/dev/null
+	modprobe bonding 2>/dev/null
+
+	ip link add name "$devdummy" type dummy
+	if [ $? -ne 0 ]; then
+		log_test_skip "could not create dummy device (CONFIG_DUMMY)"
+		return
+	fi
+	ip addr add 10.0.0.1/24 dev "$devdummy"
+	ip link set "$devdummy" up
+
+	ip link add name "$devgre" type gre local 10.0.0.1
+	if [ $? -ne 0 ]; then
+		log_test_skip "could not create GRE device (CONFIG_NET_IPGRE)"
+		ip link del "$devdummy" 2>/dev/null
+		return
+	fi
+
+	ip link add name "$devbond0" type bond mode active-backup
+	check_err $? "could not create bond0"
+	ip link add name "$devbond1" type bond mode active-backup
+	check_err $? "could not create bond1"
+
+	ip link set "$devgre" master "$devbond0"
+	check_err $? "could not enslave $devgre to $devbond0"
+	ip link set "$devbond0" master "$devbond1"
+	check_err $? "could not enslave $devbond0 to $devbond1"
+
+	ip link set "$devgre" up
+	ip link set "$devbond0" up
+	ip link set "$devbond1" up
+
+	# Send a GRE-encapsulated packet to 10.0.0.1 while an AF_PACKET
+	# SOCK_DGRAM socket is listening on bond1. The receive path calls
+	# dev_parse_header() which invokes bond_header_parse(). With the
+	# bug, this recurses infinitely and causes a stack overflow.
+	#
+	# Use Python to:
+	# 1. Open AF_PACKET SOCK_DGRAM on bond1
+	# 2. Send a GRE packet to 10.0.0.1 via raw socket
+	# 3. Try to receive (triggers parse path)
+	python3 -c "
+import socket, struct, time
+
+# AF_PACKET SOCK_DGRAM on bond1
+ETH_P_ALL = 0x0003
+pkt_fd = socket.socket(socket.AF_PACKET, socket.SOCK_DGRAM,
+                       socket.htons(ETH_P_ALL))
+pkt_fd.settimeout(2)
+pkt_fd.bind(('$devbond1', ETH_P_ALL))
+
+# Build GRE-encapsulated IP packet
+def build_ip_hdr(proto, saddr, daddr, payload_len):
+    ihl_ver = 0x45
+    total_len = 20 + payload_len
+    hdr = struct.pack('!BBHHHBBH4s4s',
+        ihl_ver, 0, total_len, 0, 0, 64, proto, 0,
+        socket.inet_aton(saddr), socket.inet_aton(daddr))
+    # compute checksum
+    words = struct.unpack('!10H', hdr)
+    s = sum(words)
+    while s >> 16:
+        s = (s & 0xffff) + (s >> 16)
+    chksum = ~s & 0xffff
+    hdr = hdr[:10] + struct.pack('!H', chksum) + hdr[12:]
+    return hdr
+
+inner = build_ip_hdr(17, '192.168.1.1', '192.168.1.2', 8) + b'\x00' * 8
+gre_hdr = struct.pack('!HH', 0, 0x0800)  # flags=0, proto=IP
+outer = build_ip_hdr(47, '10.0.0.2', '10.0.0.1', len(gre_hdr) + len(inner))
+pkt = outer + gre_hdr + inner
+
+raw_fd = socket.socket(socket.AF_INET, socket.SOCK_RAW, socket.IPPROTO_RAW)
+raw_fd.setsockopt(socket.IPPROTO_IP, socket.IP_HDRINCL, 1)
+raw_fd.sendto(pkt, ('10.0.0.1', 0))
+raw_fd.close()
+
+try:
+    pkt_fd.recv(2048)
+except socket.timeout:
+    pass
+pkt_fd.close()
+" 2>/dev/null
+
+	# If we get here without a kernel crash/hang, the test passed.
+	# Also check dmesg for signs of the recursion bug.
+	if dmesg | tail -20 | grep -q "BUG: MAX_LOCK_DEPTH\|stack-overflow\|stack overflow"; then
+		check_err 1 "kernel detected recursion in bond_header_parse"
+	fi
+
+	# Cleanup
+	ip link del "$devbond1" 2>/dev/null
+	ip link del "$devbond0" 2>/dev/null
+	ip link del "$devgre" 2>/dev/null
+	ip link del "$devdummy" 2>/dev/null
+
+	log_test "Stacked bond header_parse does not recurse"
+}
+
+require_command python3
+
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.43.0


