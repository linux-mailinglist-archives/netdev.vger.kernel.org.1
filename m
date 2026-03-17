Return-Path: <netdev+bounces-268408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAY/LODIuGmcjQEAu9opvQ
	(envelope-from <netdev+bounces-268408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:22:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8DF2A326F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76CE030AA164
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B502D2D781F;
	Tue, 17 Mar 2026 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lInlWLGN"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B12D739D
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717301; cv=none; b=HRgsWNaJHz6yoCQpzRZ9xmgkYUoWkKNPsE0G6+9+cOxTpl9vXlwPD96rv3YK32Qfkf3NgrSNpk/L7+7FHe7ndEILiT4/QIT82zDNZOrQCFTyIukRkXNdfjbR8iKvR58/Rr7mtwTIFzlxKEaZA2Tw9KYlRUEurgMySmHbRCh3rcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717301; c=relaxed/simple;
	bh=u9j4brnSDo8//98Yyz0fnvBYwaPwkcxQZ7mB+zhOi5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQFMIGVkY7sPt4BIIhtcPZlqdsgzKMwBB+Z+nmcev3QnILcnoY/kuoBLLg1ix4KHgqmU3drq2K2wZIAOyVHsf2NSNVct/5ATtlWrBh59yyrLVgRXSubOapiSCYRG3wHbgqzzd89EAM3gyJAlAsnH1gViu8NVQe60PyaWkYPZM0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lInlWLGN; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773717296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5OFIL9jskOttKe4q3KAmy9/OgNPILMLxvL01TmeKtD4=;
	b=lInlWLGNFcRvWWP7ELc7zWQ7QJJe+yhsn8ybEq7J0Lsjqwyw/ppMYaHIhLtYG2+AdeKeVq
	ftUXKlVIQlx5YGsaXfXVd/dDStCYH7akcHW4B0WikEP1gsXXjHFIvm5jqDF+bEL3IuBfek
	49esE9W1pOaj5IDhcFLJQhXi+8r0UIQ=
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
Subject: [PATCH net v2] selftests: bonding: add test for stacked bond header_parse recursion
Date: Tue, 17 Mar 2026 11:14:30 +0800
Message-ID: <20260317031435.364094-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-268408-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bond_stacked_header_parse.sh:url,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 1C8DF2A326F
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
Changes in v2:
- Use tcpdump + scapy instead of custom Python script
- Remove unnecessary modprobe and skip checks
- Add CONFIG_NET_IPGRE to config dependencies

v1: https://lore.kernel.org/netdev/20260316165946.46e9f8f7@kernel.org/T/#t
https://lore.kernel.org/netdev/CANn89iK2EURqsjtd=OVP4awYTJHGcR-UU-V9WovpWR1Z3f03oQ@mail.gmail.com/
---
 .../selftests/drivers/net/bonding/Makefile    |  1 +
 .../net/bonding/bond_stacked_header_parse.sh  | 69 +++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |  1 +
 3 files changed, 71 insertions(+)
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
index 000000000000..4d0ec6e89e75
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_stacked_header_parse.sh
@@ -0,0 +1,69 @@
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
index 991494376223..14f21f0e4d2f 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -13,6 +13,7 @@ CONFIG_NET_CLS_MATCHALL=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
+CONFIG_NET_IPGRE=y
 CONFIG_NETDEVSIM=m
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NLMON=y
-- 
2.43.0


