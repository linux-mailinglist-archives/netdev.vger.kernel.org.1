Return-Path: <netdev+bounces-275514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFN+L30j02n1ewcAu9opvQ
	(envelope-from <netdev+bounces-275514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 05:07:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0D73A13DC
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 05:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B1B33032CFE
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 03:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D742532D0D4;
	Mon,  6 Apr 2026 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dxv8xKke"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38613290D2
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775444700; cv=none; b=Tnua9VvxPgGTMCbpbx5SGXGhDNtRFFeTnQnG4irVOzc2KGwNu9CSP+lp9XZ/amSCRIgQIDlwVto7cyXv5nfrPI/qcAHwrsN4kUc49UxNRjVGw3kA/htcn+pf3laU/VwtxvScGGBnB53IByxGwS6mXxwkMWf4S5oOAz2HV35WLS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775444700; c=relaxed/simple;
	bh=Db5ANaDUIt7kmFK02wSpBRgj82OPh/6iZAe/SH+eEtc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BLYw46cuAFymZK7rqeYHCnA6Fr/PVZEACrDhwbXF/Ai1B0LdH4RT5nc+bywl9D21dqHfPF6hS+khXvdVzaHYUrBdG2x7bZ0Z8gnMEWKE8CAXcQQCzcG2+rr5yKwmHsyV4cMQCwhwodVPB0mxunUf6rKeu/KLAaIMAUO5UHgiNHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dxv8xKke; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2cc75e79b97so14434165eec.1
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775444696; x=1776049496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mi929OOnx+TlAsSDxyl9tWxsrY5rZlmtK2iHkRLypQY=;
        b=Dxv8xKkezTdANUE4dEze4DDVXDq6bYs3sJ5q0pJsJb/YcfWWOMp+rTgbWeMyQr5QqU
         muPy4+9bXrvZ/qZoCuszXeW4O7N/EDRF/ePfYC+I4G5dj3kHTu6qrGhm3dyhqJ3otg+k
         Eoyoq+V34eQqL1i5wpOYXe5kwWDcJEWYHWjiLnEnopPaA7tx9m2F+VoJ1xgZtoAw2nRT
         7x+JQWxdHXIdc2DIGmqtzdHTzQPrK/eM4WFKRNoPKMfD9wPG5T3i4Y2rC9I712h3CKgG
         18jmCgZK6G7iCOtFctwa3uWbGzQkdOk4RxFR3jf0vzonFnlEZEJM/Q9m1ooI7ak+YAA9
         U2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775444696; x=1776049496;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mi929OOnx+TlAsSDxyl9tWxsrY5rZlmtK2iHkRLypQY=;
        b=K8aXgm4aAR7txVmOa00enCJFdXSkLICQLVwKEmgVW7DTeE+pI5PC7aPhkVV3m7n+wf
         RzNsSXwOF951UaFosMb1OowxBQTjPXFpp61+AT19UOTABDS8BH3i+cmq0h6S8WmaAcG5
         HqVOMUdCoKNnhG0r/mQ6Ke1pqG9AL4bW+Edg4gC+/h9c6GmYbc75QHuENf6YkzbHViEH
         eFMMwt2nxGYA3yK320I94lXHXguMmO3vrybXLCZs+jhhHK3jtgIDvfniyT5L+QmDZXzu
         YZJBiIia4zoEddS+g0s1WcdLnkFmVgggQWLk/QeJyM7ECFxG38HB4tUKTwam3CBQV4lG
         WHBA==
X-Gm-Message-State: AOJu0YyUZDo6bVxSeqNlRkDd3KLObig/al15x1hK0wu8qbNfAcg437uU
	QXpC06Nj9L69khq7oLGS2GGYDp7e0Yj7Tn9kYzzazS0Q0aU75eDHrfywA27VKRTEOGuwnG7JCnB
	VvkxidbDHFyIo/DtHRQscIQ==
X-Received: from dlbpy13.prod.google.com ([2002:a05:7022:e98d:b0:12a:77b3:9893])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:45a6:b0:124:9dea:188d with SMTP id a92af1059eb24-12bfb7670d0mr5696408c88.30.1775444695455;
 Sun, 05 Apr 2026 20:04:55 -0700 (PDT)
Date: Mon, 06 Apr 2026 03:03:40 +0000
In-Reply-To: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775444686; l=12555;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=Db5ANaDUIt7kmFK02wSpBRgj82OPh/6iZAe/SH+eEtc=; b=r7I60JPEel5Yqw2+l+9Z6yNTl8VoJjj4edmVf89nNOB+T5YY69mHPnesippD/H4kt8H+TjPQF
 UVnX0K7W3nvCK3f3svlcaDhejIsckK0rHIHpsnzQDtXg+tEx+CmAQuO
X-Mailer: b4 0.14.3
Message-ID: <20260406-teaming-driver-internal-v5-4-e8a3f348a1c5@google.com>
Subject: [PATCH net-next v5 04/10] selftests: net: Add tests for failover of
 team-aggregated ports
From: Marc Harvey <marcharvey@google.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Marc Harvey <marcharvey@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275514-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[transmit_failover.sh:url,team_lib.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D0D73A13DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are currently no kernel tests that verify the effect of setting
the enabled team driver option. In a followup patch, there will be
changes to this option, so it will be important to make sure it still
behaves as it does now.

The test verifies that tcp continues to work across two different team
devices in separate network namespaces, even when member links are
manually disabled.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v5:
- Use tcpdump for collecting traffic, rather than reading rx counters.
- Link to v4: https://lore.kernel.org/netdev/20260403-teaming-driver-internal-v4-4-d3032f33ca25@google.com/

Changes in v4:
- None

Changes in v3:
- None

Changes in v2:
- Fix shellcheck failures.
- Remove dependency on net forwarding lib and pipe viewer tools.
- Use iperf3 for tcp instead of netcat.
- Link to v1: https://lore.kernel.org/all/20260331053353.2504254-5-marcharvey@google.com/
---
 tools/testing/selftests/drivers/net/team/Makefile  |   2 +
 tools/testing/selftests/drivers/net/team/config    |   4 +
 .../testing/selftests/drivers/net/team/team_lib.sh | 146 +++++++++++++++++++
 .../drivers/net/team/transmit_failover.sh          | 158 +++++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh      |   7 +-
 5 files changed, 316 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index 02d6f51d5a06..777da2e0429e 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -7,9 +7,11 @@ TEST_PROGS := \
 	options.sh \
 	propagation.sh \
 	refleak.sh \
+	transmit_failover.sh \
 # end of TEST_PROGS
 
 TEST_INCLUDES := \
+	team_lib.sh \
 	../bonding/lag_lib.sh \
 	../../../net/forwarding/lib.sh \
 	../../../net/in_netns.sh \
diff --git a/tools/testing/selftests/drivers/net/team/config b/tools/testing/selftests/drivers/net/team/config
index 5d36a22ef080..8f04ae419c53 100644
--- a/tools/testing/selftests/drivers/net/team/config
+++ b/tools/testing/selftests/drivers/net/team/config
@@ -6,4 +6,8 @@ CONFIG_NETDEVSIM=m
 CONFIG_NET_IPGRE=y
 CONFIG_NET_TEAM=y
 CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=y
+CONFIG_NET_TEAM_MODE_BROADCAST=y
 CONFIG_NET_TEAM_MODE_LOADBALANCE=y
+CONFIG_NET_TEAM_MODE_RANDOM=y
+CONFIG_NET_TEAM_MODE_ROUNDROBIN=y
+CONFIG_VETH=y
diff --git a/tools/testing/selftests/drivers/net/team/team_lib.sh b/tools/testing/selftests/drivers/net/team/team_lib.sh
new file mode 100644
index 000000000000..a3102bdcb99c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/team_lib.sh
@@ -0,0 +1,146 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+test_dir="$(dirname "$0")"
+export REQUIRE_MZ=no
+export NUM_NETIFS=0
+# shellcheck disable=SC1091
+source "${test_dir}/../../../net/forwarding/lib.sh"
+
+# Create a team interface inside of a given network namespace with a given
+# mode, members, and IP address.
+# Arguments:
+#  namespace - Network namespace to put the team interface into.
+#  team - The name of the team interface to setup.
+#  mode - The team mode of the interface.
+#  ip_address - The IP address to assign to the team interface.
+#  prefix_length - The prefix length for the IP address subnet.
+#  $@ - members - The member interfaces of the aggregation.
+setup_team()
+{
+	local namespace=$1
+	local team=$2
+	local mode=$3
+	local ip_address=$4
+	local prefix_length=$5
+	shift 5
+	local members=("$@")
+
+	# Prerequisite: team must have no members
+	for member in "${members[@]}"; do
+		ip -n "${namespace}" link set "${member}" nomaster
+	done
+
+	# Prerequisite: team must have no address in order to set it
+	# shellcheck disable=SC2086
+	ip -n "${namespace}" addr del "${ip_address}/${prefix_length}" \
+			${NODAD} dev "${team}"
+
+	echo "Setting team in ${namespace} to mode ${mode}"
+
+	if ! ip -n "${namespace}" link set "${team}" down; then
+		echo "Failed to bring team device down"
+		return 1
+	fi
+	if ! ip netns exec "${namespace}" teamnl "${team}" setoption mode \
+			"${mode}"; then
+		echo "Failed to set ${team} mode to '${mode}'"
+		return 1
+	fi
+
+	# Aggregate the members into teams.
+	for member in "${members[@]}"; do
+		ip -n "${namespace}" link set "${member}" master "${team}"
+	done
+
+	# Bring team devices up and give them addresses.
+	if ! ip -n "${namespace}" link set "${team}" up; then
+		echo "Failed to set ${team} up"
+		return 1
+	fi
+
+	# shellcheck disable=SC2086
+	if ! ip -n "${namespace}" addr add "${ip_address}/${prefix_length}" \
+			${NODAD} dev "${team}"; then
+		echo "Failed to give ${team} IP address in ${namespace}"
+		return 1
+	fi
+}
+
+# This is global used to keep track of the sender's iperf3 process, so that it
+# can be terminated.
+declare sender_pid
+
+# Start sending and receiving TCP traffic with iperf3.
+# Globals:
+#  sender_pid - The process ID of the iperf3 sender process. Used to kill it
+#  later.
+start_listening_and_sending()
+{
+	ip netns exec "${NS2}" iperf3 -s -p 1234 --logfile /dev/null &
+	# Wait for server to become reachable before starting client.
+	slowwait 5 ip netns exec "${NS1}" iperf3 -c "${NS2_IP}" -p 1234 -t 1 \
+			--logfile /dev/null
+	ip netns exec "${NS1}" iperf3 -c "${NS2_IP}" -p 1234 -b 1M -l 1K -t 0 \
+			--logfile /dev/null &
+	sender_pid=$!
+}
+
+# Stop sending TCP traffic with iperf3.
+# Globals:
+#   sender_pid - The process ID of the iperf3 sender process.
+stop_sending_and_listening()
+{
+	kill "${sender_pid}" && wait "${sender_pid}" 2>/dev/null || true
+}
+
+# Monitor for TCP traffic with Tcpdump, save results to temp files.
+# Arguments:
+#   namespace - The network namespace to run tcpdump inside of.
+#   $@ - interfaces - The interfaces to listen to.
+save_tcpdump_outputs()
+{
+	local namespace=$1
+	shift 1
+	local interfaces=("$@")
+
+	for interface in "${interfaces[@]}"; do
+		tcpdump_start "${interface}" "${namespace}"
+	done
+
+	sleep 1
+
+	for interface in "${interfaces[@]}"; do
+		tcpdump_stop_nosleep "${interface}"
+	done
+}
+
+clear_tcpdump_outputs()
+{
+	local interfaces=("$@")
+
+	for interface in "${interfaces[@]}"; do
+		tcpdump_cleanup "${interface}"
+	done
+}
+
+# Read Tcpdump output, determine packet counts.
+# Arguments:
+#   interface - The name of the interface to count packets for.
+#   ip_address - The destination IP address.
+did_interface_receive()
+{
+	local interface="$1"
+	local ip_address="$2"
+	local packet_count
+
+	packet_count=$(tcpdump_show "$interface" | grep -c \
+			"> ${ip_address}.1234")
+	echo "Packet count for ${interface} was ${packet_count}"
+
+	if [[ "${packet_count}" -gt 0 ]]; then
+		true
+	else
+		false
+	fi
+}
diff --git a/tools/testing/selftests/drivers/net/team/transmit_failover.sh b/tools/testing/selftests/drivers/net/team/transmit_failover.sh
new file mode 100755
index 000000000000..b2bdcd27bc98
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/transmit_failover.sh
@@ -0,0 +1,158 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# These tests verify the basic failover capability of the team driver via the
+# `enabled` team driver option across different team driver modes. This does not
+# rely on teamd, and instead just uses teamnl to set the `enabled` option
+# directly.
+#
+# Topology:
+#
+#  +-------------------------+  NS1
+#  |        test_team1       |
+#  |            +            |
+#  |      eth0  |  eth1      |
+#  |        +---+---+        |
+#  |        |       |        |
+#  +-------------------------+
+#           |       |
+#  +-------------------------+  NS2
+#  |        |       |        |
+#  |        +-------+        |
+#  |      eth0  |  eth1      |
+#  |            +            |
+#  |        test_team2       |
+#  +-------------------------+
+
+export ALL_TESTS="team_test_failover"
+
+test_dir="$(dirname "$0")"
+# shellcheck disable=SC1091
+source "${test_dir}/../../../net/lib.sh"
+# shellcheck disable=SC1091
+source "${test_dir}/team_lib.sh"
+
+NS1=""
+NS2=""
+export NODAD="nodad"
+PREFIX_LENGTH="64"
+NS1_IP="fd00::1"
+NS2_IP="fd00::2"
+NS1_IP4="192.168.0.1"
+NS2_IP4="192.168.0.2"
+MEMBERS=("eth0" "eth1")
+
+while getopts "4" opt; do
+	case $opt in
+		4)
+			echo "IPv4 mode selected."
+			export NODAD=
+			PREFIX_LENGTH="24"
+			NS1_IP="${NS1_IP4}"
+			NS2_IP="${NS2_IP4}"
+			;;
+		\?)
+			echo "Invalid option: -$OPTARG" >&2
+			exit 1
+			;;
+	esac
+done
+
+# Create the network namespaces, veth pair, and team devices in the specified
+# mode.
+# Globals:
+#   RET - Used by test infra, set by `check_err` functions.
+# Arguments:
+#   mode - The team driver mode to use for the team devices.
+environment_create()
+{
+	trap cleanup_all_ns EXIT
+	setup_ns ns1 ns2
+	NS1="${NS_LIST[0]}"
+	NS2="${NS_LIST[1]}"
+
+	# Create the interfaces.
+	ip -n "${NS1}" link add eth0 type veth peer name eth0 netns "${NS2}"
+	ip -n "${NS1}" link add eth1 type veth peer name eth1 netns "${NS2}"
+	ip -n "${NS1}" link add test_team1 type team
+	ip -n "${NS2}" link add test_team2 type team
+
+	# Set up the receiving network namespace's team interface.
+	setup_team "${NS2}" test_team2 roundrobin "${NS2_IP}" \
+			"${PREFIX_LENGTH}" "${MEMBERS[@]}"
+}
+
+
+# Check that failover works for a specific team driver mode.
+# Globals:
+#   RET - Used by test infra, set by `check_err` functions.
+# Arguments:
+#   mode - The mode to set the team interfaces to.
+team_test_mode_failover()
+{
+	local mode="$1"
+	export RET=0
+
+	# Set up the sender team with the correct mode.
+	setup_team "${NS1}" test_team1 "${mode}" "${NS1_IP}" \
+			"${PREFIX_LENGTH}" "${MEMBERS[@]}"
+	check_err $? "Failed to set up sender team"
+
+	start_listening_and_sending
+
+	### Scenario 1: All interfaces initially enabled.
+	save_tcpdump_outputs "${NS2}" "${MEMBERS[@]}"
+	did_interface_receive eth0 "${NS2_IP}"
+	check_err $? "eth0 not transmitting when both links enabled"
+	did_interface_receive eth1 "${NS2_IP}"
+	check_err $? "eth1 not transmitting when both links enabled"
+	clear_tcpdump_outputs "${MEMBERS[@]}"
+
+	### Scenario 2: One tx-side interface disabled.
+	ip netns exec "${NS1}" teamnl test_team1 setoption enabled false \
+			--port=eth1
+	slowwait 2 bash -c "ip netns exec ${NS1} teamnl test_team1 getoption \
+			enabled --port=eth1 | grep -q false"
+
+	save_tcpdump_outputs "${NS2}" "${MEMBERS[@]}"
+	did_interface_receive eth0 "${NS2_IP}"
+	check_err $? "eth0 not transmitting when enabled"
+	did_interface_receive eth1 "${NS2_IP}"
+	check_fail $? "eth1 IS transmitting when disabled"
+	clear_tcpdump_outputs "${MEMBERS[@]}"
+
+	### Scenario 3: The interface is re-enabled.
+	ip netns exec "${NS1}" teamnl test_team1 setoption enabled true \
+			--port=eth1
+	slowwait 2 bash -c "ip netns exec ${NS1} teamnl test_team1 getoption \
+			enabled --port=eth1 | grep -q true"
+
+	save_tcpdump_outputs "${NS2}" "${MEMBERS[@]}"
+	did_interface_receive eth0 "${NS2_IP}"
+	check_err $? "eth0 not transmitting when both links enabled"
+	did_interface_receive eth1 "${NS2_IP}"
+	check_err $? "eth1 not transmitting when both links enabled"
+	clear_tcpdump_outputs "${MEMBERS[@]}"
+
+	log_test "Failover of '${mode}' test"
+
+	# Clean up
+	stop_sending_and_listening
+}
+
+team_test_failover()
+{
+	team_test_mode_failover broadcast
+	team_test_mode_failover roundrobin
+	team_test_mode_failover random
+	# Don't test `activebackup` or `loadbalance` modes, since they are too
+	# complicated for just setting `enabled` to work. They use more than
+	# the `enabled` option for transmit.
+}
+
+require_command teamnl
+require_command iperf3
+require_command tcpdump
+environment_create
+tests_run
+exit "${EXIT_STATUS}"
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index d8cc4c64148d..a1017b11e3ea 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1749,12 +1749,17 @@ tcpdump_start()
 	sleep 1
 }
 
-tcpdump_stop()
+tcpdump_stop_nosleep()
 {
 	local if_name=$1
 	local pid=${cappid[$if_name]}
 
 	$ns_cmd kill "$pid" && wait "$pid"
+}
+
+tcpdump_stop()
+{
+	tcpdump_stop_nosleep "$1"
 	sleep 1
 }
 

-- 
2.53.0.1185.g05d4b7b318-goog


