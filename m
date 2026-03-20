Return-Path: <netdev+bounces-269762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iALsKamvvGkv2AIAu9opvQ
	(envelope-from <netdev+bounces-269762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 03:23:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E770F2D51FE
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 03:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA4A5300B28E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 02:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56242D193F;
	Fri, 20 Mar 2026 02:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DoTXgwV4"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DA127B32C
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 02:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773973412; cv=none; b=WhSIKsWsC2beeNRButJ8v89IGdTboWlin9e7/JsCQJCXl5nONGvxDc+Q2rkz8SfuzfD6On04upRkHgVoNehajbO/n2KqaKfo+aU4+BQ/ivwCf0NV4moSs9cK03COqxdNYfyuf3eU0hgsKY5WNizE3ucQv/DQU2D6ZOSAlhRLofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773973412; c=relaxed/simple;
	bh=KXpL+DPSw0ll3nV0SDPDphWQtLeMyLbBAZ4vbSw2tCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CR7suTd3+AxNxJ/aPDVe9TKgqHdWzDZzsJNwIlR1ys8E6vRNgnY6xaGUkpBU67FVRPLvextomNn38FqXzFbMeqVDHhGuEdy1aDRVHxf9cobHFcRWoYSAuQb7wygj38jAOroZDNup/Es2NehqID2147V0gtl8grVjWYtRdu1BXvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DoTXgwV4; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773973399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mbz1ujW0y/BU6S2LnKy9UrFDQp61sCFnYUpCv21JJIk=;
	b=DoTXgwV4naIgWCCwnhqNXeGMM3h0ZVRY/8vOsrHsuaUbbiQwpL2Owq+raYfQO+94pP9l1r
	V0XhqtGKe9ugWsHjcew7EZtp+63RGgSm6xI0QRVEna9ktS+TkBXbUpv61GJXLmQtRdm8eW
	Skv/oS4weVurQ1zlmxio7OP6SIIOe/I=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4] selftests: bonding: add test for stacked bond header_parse recursion
Date: Fri, 20 Mar 2026 10:22:39 +0800
Message-ID: <20260320022245.392384-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-269762-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.681];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bond_stacked_header_parse.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: E770F2D51FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Add a selftest to reproduce the infinite recursion in bond_header_parse()
when bonds are stacked (bond1 -> bond0 -> gre). When a packet is received
via AF_PACKET SOCK_DGRAM on the topmost bond, dev_parse_header() calls
bond_header_parse() which used skb->dev (always the topmost bond) to get
the bonding struct. This caused it to recurse back into itself
indefinitely, leading to stack overflow.

Before commit b7405dcf7385 ("bonding: prevent potential infinite loop
in bond_header_parse()"), the test triggers:

  ./bond_stacked_header_parse.sh

  [  71.999481] BUG: MAX_LOCK_DEPTH too low!
  [  72.000170] turning off the locking correctness validator.
  [  72.001029] Please attach the output of /proc/lock_stat to the bug report
  [  72.002079] depth: 48  max: 48!
  ...

After the fix, everything works fine:

  ./bond_stacked_header_parse.sh
  TEST: Stacked bond header_parse does not recurse                  [ OK ]

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
Changes in v4:
- Fix shellcheck warnings (Simon Horman)

Changes in v3:
- Fix CONFIG_NET_IPGRE sorting order in config

Changes in v2:
- Use tcpdump + scapy instead of custom Python script
- Remove unnecessary modprobe and skip checks
- Add CONFIG_NET_IPGRE to config dependencies

v1: https://lore.kernel.org/netdev/20260316165946.46e9f8f7@kernel.org/T/#t
https://lore.kernel.org/netdev/CANn89iK2EURqsjtd=OVP4awYTJHGcR-UU-V9WovpWR1Z3f03oQ@mail.gmail.com/
---
 .../selftests/drivers/net/bonding/Makefile    |  1 +
 .../net/bonding/bond_stacked_header_parse.sh  | 72 +++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |  1 +
 3 files changed, 74 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_stacked_header_parse.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 6c5c60adb5e8..9af5f84edd37 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -11,6 +11,7 @@ TEST_PROGS := \
 	bond_macvlan_ipvlan.sh \
 	bond_options.sh \
 	bond_passive_lacp.sh \
+	bond_stacked_header_parse.sh \
 	dev_addr_lists.sh \
 	mode-1-recovery-updelay.sh \
 	mode-2-recovery-updelay.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_stacked_header_parse.sh b/tools/testing/selftests/drivers/net/bonding/bond_stacked_header_parse.sh
new file mode 100755
index 000000000000..36bcdef711b0
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_stacked_header_parse.sh
@@ -0,0 +1,72 @@
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
+# shellcheck disable=SC2034
+ALL_TESTS="
+	bond_test_stacked_header_parse
+"
+REQUIRE_MZ=no
+NUM_NETIFS=0
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/forwarding/lib.sh
+
+# shellcheck disable=SC2329
+bond_test_stacked_header_parse()
+{
+	local devdummy="test-dummy0"
+	local devgre="test-gre0"
+	local devbond0="test-bond0"
+	local devbond1="test-bond1"
+
+	# shellcheck disable=SC2034
+	RET=0
+
+	# Setup: dummy -> gre -> bond0 -> bond1
+	ip link add name "$devdummy" type dummy
+	ip addr add 10.0.0.1/24 dev "$devdummy"
+	ip link set "$devdummy" up
+
+	ip link add name "$devgre" type gre local 10.0.0.1
+
+	ip link add name "$devbond0" type bond mode active-backup
+	ip link add name "$devbond1" type bond mode active-backup
+
+	ip link set "$devgre" master "$devbond0"
+	ip link set "$devbond0" master "$devbond1"
+
+	ip link set "$devgre" up
+	ip link set "$devbond0" up
+	ip link set "$devbond1" up
+
+	# tcpdump on a non-Ethernet bond uses AF_PACKET SOCK_DGRAM (cooked
+	# capture), which triggers dev_parse_header() -> bond_header_parse()
+	# on receive. With the bug, this recurses infinitely.
+	timeout 5 tcpdump -c 1 -i "$devbond1" >/dev/null 2>&1 &
+	local tcpdump_pid=$!
+	sleep 1
+
+	# Send a GRE packet to 10.0.0.1 so it arrives via gre -> bond0 -> bond1
+	python3 -c "from scapy.all import *; send(IP(src='10.0.0.2', dst='10.0.0.1')/GRE()/IP()/UDP(), verbose=0)"
+	check_err $? "failed to send GRE packet (scapy installed?)"
+
+	wait "$tcpdump_pid" 2>/dev/null
+
+	ip link del "$devbond1" 2>/dev/null
+	ip link del "$devbond0" 2>/dev/null
+	ip link del "$devgre" 2>/dev/null
+	ip link del "$devdummy" 2>/dev/null
+
+	log_test "Stacked bond header_parse does not recurse"
+}
+
+tests_run
+
+exit "$EXIT_STATUS"
diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index 991494376223..b62c70715293 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -14,6 +14,7 @@ CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
 CONFIG_NETDEVSIM=m
+CONFIG_NET_IPGRE=y
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NLMON=y
 CONFIG_VETH=y
-- 
2.43.0


