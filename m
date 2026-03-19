Return-Path: <netdev+bounces-269497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCViN3cVvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:25:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FCC2CDB16
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 333DB302BEB6
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0623D5675;
	Thu, 19 Mar 2026 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="nr18a5m0"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AFC3DC4B1;
	Thu, 19 Mar 2026 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933588; cv=none; b=PP8aO6shN7F4IQYldClRtSx5OnzaOjpeDQyFJQmuLIdsll9ZuB4uIni4boGAVhuyC575VGzDVp3tqX5JecytMPyk2c/aPfvHOnkGSuL8Eqqes5xPphWbYZEsiPS2Dmvl9fkbyWrC6H0p8S7X3pS7CAPBmvShhbi4ueTQw++oOWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933588; c=relaxed/simple;
	bh=MsKo4Zoo02SIR8owpdwiyrumQgy7wYQYv3uePrWS/tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DukSQvCHD7+Kl5jPsxHxvZJYUE+D1I6xxHk/lVuoCnLchVB+yNL3hbnWa5xMBYufR7LfRp80q6EFgbs1skqh+Tv+/UAKOKhbcyibyiQDYqjNJE49d01TzPhNeQc8UDnHisAOO1dJ/HXJnAVlpWK5MYKpWfN7yKnaZBNQeayeme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=nr18a5m0; arc=none smtp.client-ip=195.10.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4fc8Nr1fGFz9xrR;
	Thu, 19 Mar 2026 16:14:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1773933244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxqOcZZ5MjGkDOCx3+Lq7zc+VMke3dRIIT4JhJAl1YI=;
	b=nr18a5m0SewJuROb8YETETTBY8sg4B482rIvyaEHXt5gw+hFc4pbIAyjzB86yCKrjQBpDe
	TiN5WDn8eXvG635ub3dUZ/RJ+A36tszTYfvx/FG0X+3Z7U0CiVefN2aAN0Dy009KFiJRh6
	cwB0t0XJpUkYw1EcXPpuyyCUgTlKWHu2QMqcfQ+8lcgtfPwHQFHABkH/lX4Vkc57FvnHmw
	b16VwlcQTslfbZZqWHu1V231xymHbIhHSsrB+cOHl20kMsvZQK0wug5eLnyvRqxue+c8Gz
	2PM60kxNy04u6fIJuHhPtrc0VPB5msE47HDgJ4NJJLpo2mTavcP40qgEGXLtEw==
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@mandelbit.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC net-next 14/15] selftests: net: add ipxlat coverage
Date: Thu, 19 Mar 2026 16:12:23 +0100
Message-ID: <20260319151230.655687-15-ralf@mandelbit.com>
In-Reply-To: <20260319151230.655687-1-ralf@mandelbit.com>
References: <20260319151230.655687-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mandelbit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269497-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[darkboxed.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ipxlat_frag.sh:url,ipxlat_icmp_err.sh:url,ipxlat_lib.sh:url,mandelbit.com:dkim,mandelbit.com:email,mandelbit.com:mid,ipxlat_data.sh:url]
X-Rspamd-Queue-Id: 43FCC2CDB16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add selftests for ipxlat data plane behavior and control-plane setup.

The tests build an isolated netns topology, configure ipxlat through
YNL, and exercise core traffic classes (TCP, UDP, ICMP info/error, and
fragment-related paths). This provides reproducible end-to-end coverage
for the translation pipeline and basic regression protection for future
changes.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 tools/testing/selftests/net/ipxlat/.gitignore |   1 +
 tools/testing/selftests/net/ipxlat/Makefile   |  25 ++
 .../selftests/net/ipxlat/ipxlat_data.sh       |  70 +++++
 .../selftests/net/ipxlat/ipxlat_frag.sh       |  70 +++++
 .../selftests/net/ipxlat/ipxlat_icmp_err.sh   |  54 ++++
 .../selftests/net/ipxlat/ipxlat_lib.sh        | 273 ++++++++++++++++++
 .../net/ipxlat/ipxlat_udp4_zero_csum_send.c   | 119 ++++++++
 7 files changed, 612 insertions(+)
 create mode 100644 tools/testing/selftests/net/ipxlat/.gitignore
 create mode 100644 tools/testing/selftests/net/ipxlat/Makefile
 create mode 100755 tools/testing/selftests/net/ipxlat/ipxlat_data.sh
 create mode 100755 tools/testing/selftests/net/ipxlat/ipxlat_frag.sh
 create mode 100755 tools/testing/selftests/net/ipxlat/ipxlat_icmp_err.sh
 create mode 100644 tools/testing/selftests/net/ipxlat/ipxlat_lib.sh
 create mode 100644 tools/testing/selftests/net/ipxlat/ipxlat_udp4_zero_csum_send.c

diff --git a/tools/testing/selftests/net/ipxlat/.gitignore b/tools/testing/selftests/net/ipxlat/.gitignore
new file mode 100644
index 000000000000..43bd01d8a84b
--- /dev/null
+++ b/tools/testing/selftests/net/ipxlat/.gitignore
@@ -0,0 +1 @@
+ipxlat_udp4_zero_csum_send
diff --git a/tools/testing/selftests/net/ipxlat/Makefile b/tools/testing/selftests/net/ipxlat/Makefile
new file mode 100644
index 000000000000..cca588945e48
--- /dev/null
+++ b/tools/testing/selftests/net/ipxlat/Makefile
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+# IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+#
+# Copyright (C) 2026- Mandelbit SRL
+# Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+#
+#  Author:	Antonio Quartulli <antonio@mandelbit.com>
+#		Daniel Gröber <dxld@darkboxed.org>
+#		Ralf Lici <ralf@mandelbit.com>
+
+TEST_PROGS := \
+	ipxlat_data.sh \
+	ipxlat_frag.sh \
+	ipxlat_icmp_err.sh \
+# end of TEST_PROGS
+
+TEST_FILES := \
+	ipxlat_lib.sh \
+# end of TEST_FILES
+
+TEST_GEN_FILES := \
+	ipxlat_udp4_zero_csum_send \
+# end of TEST_GEN_FILES
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/ipxlat/ipxlat_data.sh b/tools/testing/selftests/net/ipxlat/ipxlat_data.sh
new file mode 100755
index 000000000000..101e0a65f0a9
--- /dev/null
+++ b/tools/testing/selftests/net/ipxlat/ipxlat_data.sh
@@ -0,0 +1,70 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+#
+# Copyright (C) 2026- Mandelbit SRL
+# Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+#
+#  Author:	Antonio Quartulli <antonio@mandelbit.com>
+#		Daniel Gröber <dxld@darkboxed.org>
+#		Ralf Lici <ralf@mandelbit.com>
+
+set -o pipefail
+
+SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
+source "$SCRIPT_DIR/ipxlat_lib.sh"
+
+trap ipxlat_cleanup EXIT
+
+ipxlat_setup_env
+
+# Send ICMP Echo and verify we receive a reply back
+
+RET=0
+ip netns exec "$NS4" ping -c 2 -W 2 "$IPXLAT_V4_REMOTE" >/dev/null 2>&1
+check_err $? "ping 4->6 failed"
+log_test "icmp-info 4->6"
+
+RET=0
+ip netns exec "$NS6" ping -6 -c 2 -W 2 -I "$IPXLAT_V6_NS6_SRC" \
+	"$IPXLAT_V6_NS4" >/dev/null 2>&1
+check_err $? "ping 6->4 failed"
+log_test "icmp-info 6->4"
+
+# Run a TCP data transfer over the translator path
+
+RET=0
+ipxlat_run_iperf "$NS6" "$NS4" "$IPXLAT_V4_REMOTE" 5201 -n 256K
+check_err $? "tcp 4->6 failed"
+log_test "tcp 4->6"
+
+RET=0
+ipxlat_run_iperf "$NS4" "$NS6" "$IPXLAT_V6_NS4" 5201 \
+	-B "$IPXLAT_V6_NS6_SRC" -n 256K
+check_err $? "tcp 6->4 failed"
+log_test "tcp 6->4"
+
+# Run UDP traffic to verify UDP translation and delivery
+
+RET=0
+ipxlat_run_iperf "$NS6" "$NS4" "$IPXLAT_V4_REMOTE" 5202 -u -b 5M -t 1
+check_err $? "udp 4->6 failed"
+log_test "udp 4->6"
+
+RET=0
+ipxlat_run_iperf "$NS4" "$NS6" "$IPXLAT_V6_NS4" 5202 \
+	-B "$IPXLAT_V6_NS6_SRC" -u -b 5M -t 1
+check_err $? "udp 6->4 failed"
+log_test "udp 6->4"
+
+# Send one IPv4 UDP packet with checksum=0 and verify 4->6 translation.
+
+RET=0
+ipxlat_capture_pkts "$NS6" \
+	"ip6 and udp and dst host $IPXLAT_V6_REMOTE and dst port 5555" 1 3 \
+	ip netns exec "$NS4" "$SCRIPT_DIR/ipxlat_udp4_zero_csum_send" \
+	"$IPXLAT_NS4_ADDR" "$IPXLAT_V4_REMOTE" 5555
+check_err $? "udp checksum-zero 4->6 failed"
+log_test "udp checksum-zero 4->6"
+
+exit "$EXIT_STATUS"
diff --git a/tools/testing/selftests/net/ipxlat/ipxlat_frag.sh b/tools/testing/selftests/net/ipxlat/ipxlat_frag.sh
new file mode 100755
index 000000000000..26ed351cd263
--- /dev/null
+++ b/tools/testing/selftests/net/ipxlat/ipxlat_frag.sh
@@ -0,0 +1,70 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+#
+# Copyright (C) 2026- Mandelbit SRL
+# Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+#
+#  Author:	Antonio Quartulli <antonio@mandelbit.com>
+#		Daniel Gröber <dxld@darkboxed.org>
+#		Ralf Lici <ralf@mandelbit.com>
+
+set -o pipefail
+
+SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
+source "$SCRIPT_DIR/ipxlat_lib.sh"
+
+trap ipxlat_cleanup EXIT
+
+ipxlat_setup_env
+
+# Exercise large TCP flow on 4->6 path to cover pre-fragmentation behavior
+RET=0
+ipxlat_run_iperf "$NS6" "$NS4" "$IPXLAT_V4_REMOTE" 5301 -n 8M
+check_err $? "large tcp 4->6 failed"
+log_test "large tcp 4->6"
+
+# Exercise large UDP flow on 4->6 path to cover pre-fragmentation behavior
+RET=0
+ipxlat_run_iperf "$NS6" "$NS4" "$IPXLAT_V4_REMOTE" 5302 -u -b 20M -t 2 -l 1400
+check_err $? "large udp 4->6 failed"
+log_test "large udp 4->6"
+
+# Exercise large TCP flow on 6->4 path to cover
+# fragmentation-sensitive translation
+RET=0
+ipxlat_run_iperf "$NS4" "$NS6" "$IPXLAT_V6_NS4" 5303 \
+	-B "$IPXLAT_V6_NS6_SRC" -n 8M
+check_err $? "large tcp 6->4 failed"
+log_test "large tcp 6->4"
+
+# Exercise large UDP flow on 6->4 path to cover
+# fragmentation-sensitive translation
+RET=0
+ipxlat_run_iperf "$NS4" "$NS6" "$IPXLAT_V6_NS4" 5304 \
+	-B "$IPXLAT_V6_NS6_SRC" -u -b 20M -t 2 -l 1400
+check_err $? "large udp 6->4 failed"
+log_test "large udp 6->4"
+
+# Send oversized IPv4 ICMP Echo with DF disabled (source fragmentation allowed)
+# and verify translator drops fragmented ICMPv4 input (no translated ICMPv6
+# Echo seen in NS6)
+RET=0
+ipxlat_capture_pkts "$NS6" "icmp6 and ip6[40] == 128" 0 5 \
+	ip netns exec "$NS4" bash -c \
+	"ping -M \"dont\" -s 2000 -c 1 -W 1 \"$IPXLAT_V4_REMOTE\" \
+	>/dev/null 2>&1 || test \$? -eq 1"
+check_err $? "fragmented icmp 4->6 should be dropped"
+log_test "drop fragmented icmp 4->6"
+
+# Send oversized IPv6 ICMP echo request and verify translator drops fragmented
+# ICMPv6 input (no translated ICMPv4 Echo seen in NS4)
+RET=0
+ipxlat_capture_pkts "$NS4" "icmp and icmp[0] == 8" 0 5 \
+	ip netns exec "$NS6" bash -c \
+	"ping -6 -s 2000 -c 1 -W 1 -I \"$IPXLAT_V6_NS6_SRC\" \
+	\"$IPXLAT_V6_NS4\" >/dev/null 2>&1 || test \$? -eq 1"
+check_err $? "fragmented icmp 6->4 should be dropped"
+log_test "drop fragmented icmp 6->4"
+
+exit "$EXIT_STATUS"
diff --git a/tools/testing/selftests/net/ipxlat/ipxlat_icmp_err.sh b/tools/testing/selftests/net/ipxlat/ipxlat_icmp_err.sh
new file mode 100755
index 000000000000..946584b55895
--- /dev/null
+++ b/tools/testing/selftests/net/ipxlat/ipxlat_icmp_err.sh
@@ -0,0 +1,54 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+#
+# Copyright (C) 2026- Mandelbit SRL
+# Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+#
+#  Author:	Antonio Quartulli <antonio@mandelbit.com>
+#		Daniel Gröber <dxld@darkboxed.org>
+#		Ralf Lici <ralf@mandelbit.com>
+
+set -o pipefail
+
+SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
+source "$SCRIPT_DIR/ipxlat_lib.sh"
+
+trap ipxlat_cleanup EXIT
+
+ipxlat_setup_env
+
+# Trigger UDP to a closed port from NS4 and capture translated
+# ICMPv4 Port Unreachable
+RET=0
+ipxlat_capture_pkts "$NS4" "icmp and icmp[0] == 3 and icmp[1] == 3" 1 3 \
+	ip netns exec "$NS4" bash -c \
+	"echo x > /dev/udp/$IPXLAT_V4_REMOTE/9 || true"
+check_err $? "icmp-error 4->6 not observed"
+log_test "icmp-error xlate 4->6"
+
+# Trigger UDP to a closed port from NS6 and capture translated
+# ICMPv6 Port Unreachable
+RET=0
+ipxlat_capture_pkts "$NS6" "icmp6 and ip6[40] == 1 and ip6[41] == 4" 1 3 \
+	ip netns exec "$NS6" bash -c \
+	"echo x > /dev/udp/$IPXLAT_V6_NS4/9 || true"
+check_err $? "icmp-error 6->4 not observed"
+log_test "icmp-error xlate 6->4"
+
+# Send oversized DF IPv4 packet and verify local ICMPv4
+# Fragmentation Needed emission
+sysctl -qw net.ipv4.conf.ipxl0.accept_local=1
+sysctl -qw net.ipv4.conf.all.rp_filter=0
+sysctl -qw net.ipv4.conf.default.rp_filter=0
+sysctl -qw net.ipv4.conf.ipxl0.rp_filter=0
+sleep 2
+RET=0
+ipxlat_capture_pkts "$NS4" "icmp and icmp[0] == 3 and icmp[1] == 4" 1 3 \
+	ip netns exec "$NS4" bash -c \
+	"ping -M \"do\" -s 1300 -c 1 -W 1 \"$IPXLAT_V4_REMOTE\" \
+	>/dev/null 2>&1 || test \$? -eq 1"
+check_err $? "icmpv4 frag-needed emission not observed"
+log_test "icmpv4 frag-needed emission"
+
+exit "$EXIT_STATUS"
diff --git a/tools/testing/selftests/net/ipxlat/ipxlat_lib.sh b/tools/testing/selftests/net/ipxlat/ipxlat_lib.sh
new file mode 100644
index 000000000000..e27683f280d4
--- /dev/null
+++ b/tools/testing/selftests/net/ipxlat/ipxlat_lib.sh
@@ -0,0 +1,273 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+#
+# Copyright (C) 2026- Mandelbit SRL
+# Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+#
+#  Author:	Antonio Quartulli <antonio@mandelbit.com>
+#		Daniel Gröber <dxld@darkboxed.org>
+#		Ralf Lici <ralf@mandelbit.com>
+
+set -o pipefail
+
+IPXLAT_TEST_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
+source "$IPXLAT_TEST_DIR/../lib.sh"
+
+KDIR=${KDIR:-$(readlink -f "$IPXLAT_TEST_DIR/../../../../../")}
+YNL_CLI="$KDIR/tools/net/ynl/pyynl/cli.py"
+YNL_SPEC="$KDIR/Documentation/netlink/specs/ipxlat.yaml"
+IPXLAT_IPERF_TIMEOUT=${IPXLAT_IPERF_TIMEOUT:-10}
+
+IPXLAT_TRANSLATOR_DEV=ipxl0
+IPXLAT_VETH4_HOST=veth4r
+IPXLAT_VETH4_NS=veth4n
+IPXLAT_VETH6_HOST=veth6r
+IPXLAT_VETH6_NS=veth6n
+
+IPXLAT_XLAT_PREFIX6=2001:db8:100::
+IPXLAT_XLAT_PREFIX6_LEN=40
+IPXLAT_XLAT_PREFIX6_HEX=20010db8010000000000000000000000
+IPXLAT_LOWEST_IPV6_MTU=1280
+
+IPXLAT_HOST4_ADDR=198.51.100.1
+IPXLAT_HOST6_ADDR=2001:db8:1::1
+
+IPXLAT_NS4_ADDR=198.51.100.2
+IPXLAT_NS6_ADDR=2001:db8:1::2
+export IPXLAT_V4_REMOTE=192.0.2.33
+
+IPXLAT_V6_REMOTE=2001:db8:1c0:2:21::
+IPXLAT_V6_NS4=2001:db8:1c6:3364:2::
+IPXLAT_V6_NS6_SRC=2001:db8:1c0:2:2::
+
+NS4=""
+NS6=""
+
+ipxlat_ynl()
+{
+	python3 "$YNL_CLI" --spec "$YNL_SPEC" "$@"
+}
+
+ipxlat_build_dev_set_json()
+{
+	local ifindex="$1"
+
+	jq -cn \
+		--argjson ifindex "$ifindex" \
+		--arg prefix "$IPXLAT_XLAT_PREFIX6_HEX" \
+		--argjson prefix_len "$IPXLAT_XLAT_PREFIX6_LEN" \
+		--argjson lowest_ipv6_mtu "$IPXLAT_LOWEST_IPV6_MTU" \
+			'{
+				ifindex: $ifindex,
+				config: {
+					"xlat-prefix6": {
+						prefix: $prefix,
+						"prefix-len": $prefix_len
+					},
+					"lowest-ipv6-mtu": $lowest_ipv6_mtu
+				}
+			}'
+}
+
+ipxlat_require_root()
+{
+	if [[ $(id -u) -ne 0 ]]; then
+		echo "ipxlat selftests need root; skipping"
+		exit "$ksft_skip"
+	fi
+}
+
+ipxlat_require_tools()
+{
+	if [[ ! -f "$YNL_CLI" || ! -f "$YNL_SPEC" ]]; then
+		log_test_skip "ipxlat netlink spec/ynl not found"
+		exit "$ksft_skip"
+	fi
+
+	for tool in ip python3 ping iperf3 tcpdump timeout jq; do
+		require_command "$tool"
+	done
+}
+
+ipxlat_cleanup()
+{
+	cleanup_ns "${NS4:-}" "${NS6:-}" || true
+	ip link del "$IPXLAT_TRANSLATOR_DEV" 2>/dev/null || true
+	ip link del "$IPXLAT_VETH4_HOST" 2>/dev/null || true
+	ip link del "$IPXLAT_VETH6_HOST" 2>/dev/null || true
+}
+
+# Test topology:
+#
+# host namespace:
+#   - owns ipxlat dev `ipxl0`
+#   - has veth peers `veth4r` and `veth6r`
+#   - routes IPv4 test prefix (192.0.2.0/24) to ipxl0 (v4 network steering rule)
+#   - routes xlat-prefix6 prefix (2001:db8:100::/40) out to NS6 side
+#   - routes mapped NS4 IPv6 identity (2001:db8:1c6:3364:2::/128) to ipxl0
+#     so NS6->NS4 traffic enters 6->4 translation
+#
+# NS4:
+#   - IPv4-only endpoint: 198.51.100.2/24 on veth4n
+#   - default route via host 198.51.100.1 (veth4r)
+#   - sends traffic to 192.0.2.33 (translated by ipxl0 to IPv6)
+#
+# NS6:
+#   - IPv6 endpoint: 2001:db8:1::2/64 on veth6n
+#   - also owns mapped addresses used by tests:
+#       2001:db8:1c0:2:21::  (maps to 192.0.2.33)
+#       2001:db8:1c0:2:2::   (maps to 192.0.2.2, used as explicit src
+#                             since we have multiple v6 addresses)
+#   - route to mapped NS4 IPv6 address is pinned via host:
+#       2001:db8:1c6:3364:2::/128
+#     This keeps the 6->4 test path deterministic.
+#
+# ipxlat config under test:
+#   - xlat-prefix6 = 2001:db8:100::/40
+#   - lowest-ipv6-mtu = 1280
+ipxlat_configure_topology()
+{
+	local ifindex
+	local dev_set_json
+
+	if ! ip link add "$IPXLAT_TRANSLATOR_DEV" type ipxlat; then
+		echo "ipxlat link kind unavailable; skipping"
+		exit "$ksft_skip"
+	fi
+	ip link set "$IPXLAT_TRANSLATOR_DEV" up
+	ifindex=$(cat /sys/class/net/"$IPXLAT_TRANSLATOR_DEV"/ifindex)
+	dev_set_json=$(ipxlat_build_dev_set_json "$ifindex")
+
+	if ! ipxlat_ynl --do dev-set --json "$dev_set_json" >/dev/null; then
+		echo "ipxlat dev-set failed"
+		exit "$ksft_fail"
+	fi
+
+	setup_ns NS4 NS6 || exit "$ksft_skip"
+
+	ip link add "$IPXLAT_VETH4_HOST" type veth peer name "$IPXLAT_VETH4_NS"
+	ip link add "$IPXLAT_VETH6_HOST" type veth peer name "$IPXLAT_VETH6_NS"
+	ip link set "$IPXLAT_VETH4_NS" netns "$NS4"
+	ip link set "$IPXLAT_VETH6_NS" netns "$NS6"
+
+	ip addr add "$IPXLAT_HOST4_ADDR/24" dev "$IPXLAT_VETH4_HOST"
+	ip -6 addr add "$IPXLAT_HOST6_ADDR/64" dev "$IPXLAT_VETH6_HOST"
+	ip link set "$IPXLAT_VETH4_HOST" up
+	ip link set "$IPXLAT_VETH6_HOST" up
+
+	ip netns exec "$NS4" ip addr add "$IPXLAT_NS4_ADDR/24" \
+		dev "$IPXLAT_VETH4_NS"
+	ip netns exec "$NS4" ip link set "$IPXLAT_VETH4_NS" up
+	ip netns exec "$NS4" ip route add default via "$IPXLAT_HOST4_ADDR"
+
+	ip netns exec "$NS6" ip -6 addr add "$IPXLAT_NS6_ADDR/64" \
+		dev "$IPXLAT_VETH6_NS"
+	ip netns exec "$NS6" ip -6 addr add "$IPXLAT_V6_REMOTE/128" \
+		dev "$IPXLAT_VETH6_NS"
+	ip netns exec "$NS6" ip -6 addr add "$IPXLAT_V6_NS6_SRC/128" \
+		dev "$IPXLAT_VETH6_NS"
+	ip netns exec "$NS6" ip link set "$IPXLAT_VETH6_NS" up
+	ip netns exec "$NS6" ip -6 route add default via "$IPXLAT_HOST6_ADDR"
+	ip netns exec "$NS6" ip -6 route replace "$IPXLAT_V6_NS4/128" \
+		via "$IPXLAT_HOST6_ADDR"
+	sleep 2
+
+	sysctl -qw net.ipv4.ip_forward=1
+	sysctl -qw net.ipv6.conf.all.forwarding=1
+
+	# 4->6 steering rule
+	ip route replace 192.0.2.0/24 dev "$IPXLAT_TRANSLATOR_DEV"
+	# Post-translation egress:
+	# IPv6 destinations in xlat-prefix6 leave toward NS6.
+	ip -6 route replace "$IPXLAT_XLAT_PREFIX6/$IPXLAT_XLAT_PREFIX6_LEN" \
+		dev "$IPXLAT_VETH6_HOST"
+	# 6->4 steering rule
+	ip -6 route replace "$IPXLAT_V6_NS4/128" dev "$IPXLAT_TRANSLATOR_DEV"
+
+	ip link set "$IPXLAT_VETH6_HOST" mtu 1280
+	ip netns exec "$NS6" ip link set "$IPXLAT_VETH6_NS" mtu 1280
+}
+
+ipxlat_setup_env()
+{
+	ipxlat_require_root
+	ipxlat_require_tools
+	ipxlat_cleanup
+
+	ipxlat_configure_topology
+}
+
+ipxlat_run_iperf()
+{
+	local srv_ns="$1"
+	local cli_ns="$2"
+	local dst="$3"
+	local port="$4"
+	local -a args=()
+	local client_rc
+	local server_rc
+	local spid
+	local idx
+
+	for ((idx = 5; idx <= $#; idx++)); do
+		args+=("${!idx}")
+	done
+
+	ip netns exec "$srv_ns" timeout "$IPXLAT_IPERF_TIMEOUT" \
+		iperf3 -s -1 -p "$port" >/dev/null 2>&1 &
+	spid=$!
+	sleep 0.2
+
+	ip netns exec "$cli_ns" timeout "$IPXLAT_IPERF_TIMEOUT" \
+		iperf3 -c "$dst" -p "$port" "${args[@]}" >/dev/null 2>&1
+
+	client_rc=$?
+	if [[ $client_rc -ne 0 ]]; then
+		kill "$spid" >/dev/null 2>&1 || true
+	fi
+
+	wait "$spid" >/dev/null 2>&1
+	server_rc=$?
+
+	((client_rc != 0)) && return "$client_rc"
+	return "$server_rc"
+}
+
+ipxlat_capture_pkts()
+{
+	local ns="$1"
+	local filter="$2"
+	local expect_pkts="$3"
+	local timeout_s="$4"
+	local cap_goal
+	local cap_pid
+	local rc
+	local trigger_rc
+
+	shift 4
+
+	cap_goal=1
+	[[ $expect_pkts -gt 0 ]] && cap_goal=$expect_pkts
+
+	ip netns exec "$ns" timeout "$timeout_s" \
+		tcpdump -nni any -c "$cap_goal" \
+		"$filter" >/dev/null 2>&1 &
+	cap_pid=$!
+	sleep 0.2
+
+	"$@"
+	trigger_rc=$?
+	wait "$cap_pid" >/dev/null 2>&1
+	rc=$?
+
+	if [[ $trigger_rc -ne 0 ]]; then
+		return "$trigger_rc"
+	fi
+
+	if [[ $expect_pkts -eq 0 ]]; then
+		[[ $rc -eq 124 ]]
+	else
+		[[ $rc -eq 0 ]]
+	fi
+}
diff --git a/tools/testing/selftests/net/ipxlat/ipxlat_udp4_zero_csum_send.c b/tools/testing/selftests/net/ipxlat/ipxlat_udp4_zero_csum_send.c
new file mode 100644
index 000000000000..ef9f07f8d699
--- /dev/null
+++ b/tools/testing/selftests/net/ipxlat/ipxlat_udp4_zero_csum_send.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+ *
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#include <arpa/inet.h>
+#include <errno.h>
+#include <linux/ip.h>
+#include <linux/udp.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <unistd.h>
+
+static uint16_t iphdr_csum(const void *buf, size_t len)
+{
+	const uint16_t *p = buf;
+	uint32_t sum = 0;
+
+	while (len > 1) {
+		sum += *p++;
+		len -= 2;
+	}
+	if (len)
+		sum += *(const uint8_t *)p;
+
+	while (sum >> 16)
+		sum = (sum & 0xffff) + (sum >> 16);
+
+	return (uint16_t)~sum;
+}
+
+int main(int argc, char **argv)
+{
+	static const char payload[] = "ipxlat-zero-udp-csum";
+	struct sockaddr_in dst = {};
+	struct {
+		struct iphdr ip;
+		struct udphdr udp;
+		char payload[sizeof(payload)];
+	} pkt = {};
+	in_addr_t saddr, daddr;
+	unsigned long dport_ul;
+	socklen_t dst_len;
+	ssize_t n;
+	int one = 1;
+	int fd;
+
+	if (argc != 4) {
+		fprintf(stderr, "usage: %s <src4> <dst4> <dport>\n", argv[0]);
+		return 2;
+	}
+
+	if (!inet_pton(AF_INET, argv[1], &saddr) ||
+	    !inet_pton(AF_INET, argv[2], &daddr)) {
+		fprintf(stderr, "invalid IPv4 address\n");
+		return 2;
+	}
+
+	errno = 0;
+	dport_ul = strtoul(argv[3], NULL, 10);
+	if (errno || dport_ul > 65535) {
+		fprintf(stderr, "invalid UDP port\n");
+		return 2;
+	}
+
+	fd = socket(AF_INET, SOCK_RAW, IPPROTO_RAW);
+	if (fd < 0) {
+		perror("socket");
+		return 1;
+	}
+
+	if (setsockopt(fd, IPPROTO_IP, IP_HDRINCL, &one, sizeof(one)) < 0) {
+		perror("setsockopt(IP_HDRINCL)");
+		close(fd);
+		return 1;
+	}
+
+	pkt.ip.version = 4;
+	pkt.ip.ihl = 5;
+	pkt.ip.ttl = 64;
+	pkt.ip.protocol = IPPROTO_UDP;
+	pkt.ip.tot_len = htons(sizeof(pkt));
+	pkt.ip.id = htons(1);
+	pkt.ip.frag_off = 0;
+	pkt.ip.saddr = saddr;
+	pkt.ip.daddr = daddr;
+	pkt.ip.check = iphdr_csum(&pkt.ip, sizeof(pkt.ip));
+
+	pkt.udp.source = htons(4242);
+	pkt.udp.dest = htons((uint16_t)dport_ul);
+	pkt.udp.len = htons(sizeof(pkt.udp) + sizeof(payload));
+	pkt.udp.check = 0;
+
+	memcpy(pkt.payload, payload, sizeof(payload));
+
+	dst.sin_family = AF_INET;
+	dst.sin_port = pkt.udp.dest;
+	dst.sin_addr.s_addr = daddr;
+	dst_len = sizeof(dst);
+
+	n = sendto(fd, &pkt, sizeof(pkt), 0, (struct sockaddr *)&dst, dst_len);
+	if (n != (ssize_t)sizeof(pkt)) {
+		perror("sendto");
+		close(fd);
+		return 1;
+	}
+
+	close(fd);
+	return 0;
+}
-- 
2.53.0


