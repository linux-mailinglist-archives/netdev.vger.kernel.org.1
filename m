Return-Path: <netdev+bounces-276252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBFYBnPD1Wkx9gcAu9opvQ
	(envelope-from <netdev+bounces-276252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:54:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C15D73B658B
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 222B1305BFF0
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 02:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B49C37701E;
	Wed,  8 Apr 2026 02:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h/undASq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1F36606A
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775616764; cv=none; b=XDlVErmhyyKNEloFwK/D/tWx4QXUrNCqeJYxKGr9G43OqdStYTBJPbZ/Wystw6dGTowYaa0xpNisfXxTN/gGv37+ycPRK9VRu3UEF4lWhhsDo+YHV070knLVXf/MzAeMwxt8qWwTsiCuDDhsFCS6dogo6PNa/CIJIYDcLqS1Yx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775616764; c=relaxed/simple;
	bh=56indIRElDV0usMzMjHatIwKqE+ETHzgNqfEGPbTnfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h4JbRX1yLMTYVt3/15dWjgF9xFdgeoPqV0fw/YlfkFYzPhPAbZt1efVLOmh0ASmgeeKsJ3ZQqegu4otAUOJ4wJ/UH6802svnWom3IneGGNOgAjylLkPbSMBbirnDGKCTlx6S3uyWBYn7VgJipfFTGHtP9QNIg3mE2pPS89MPnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h/undASq; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso8120546eec.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 19:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775616755; x=1776221555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=31MOmavN4EnvwbSfeL7HJH8wgUUfo0sqfPppSBppvUI=;
        b=h/undASqbR9+mTfUR8jceysG7hARSJylnvj3s3Hol2JVkZaO4wt5nDYkdB8PMKs5Lf
         5LjYtXgvmIZ3cTEN4bJZGCpHhL4Vw6tM313EWBSHsHUg12IpZx/twq6mpoExGm1EPV8w
         AmgkKzgoxDkThyWnjufSwrDRYw79BWJJZO1dktaXcPhLYp32K9+Wx608vOkdqEsFjCXL
         SUHluMNSlNly9C7vazrc9CUaGgHeQdmjj+Qn2VRHN9J/Wyh9SaVxYFRc/r28JWg94c4t
         nPy1/UAh90xgbl0v5DZzmP+ZJsY7EZsMQ3yxhJHkT9Z7OmB71yMyFyVwflO5LoVpGsRL
         zATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775616755; x=1776221555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31MOmavN4EnvwbSfeL7HJH8wgUUfo0sqfPppSBppvUI=;
        b=DEH4+xmEjxifKKyzIEYqjpzOOnQIVlXXOjagyC/W/SURSCeRY2IiozjjMDi7LznqGF
         b7Gxu/1ngN9Tuhvf0nCvaUiK5woSram7NQXhfWB8++1s3AIZOHO/AW4KfAtj1+3CclCu
         UaTjQcf+EpeGBYMbyVKO+t1buTvksexCbcngCw8Ei/1BiY1im7oArNzn/BrNotJ1l3hU
         MUWM7kVkwGWsCDXQOBVq9Atcug6zaqsxb4P+l9M+eBCb4H5Bx3WQLH4/vZHH78RKC+cg
         3jz8Cu+a/8hLwyXoWkxscV/C6qy/ldY9iOgtJALG+fQ9n97kfwUulmFkWU+LSXs/tass
         z2AA==
X-Gm-Message-State: AOJu0YxVGFCtAudbYBXjuYfCe+Fht2whVNpIZ6RWPUv9dnPhwHhPByJi
	sPJJWZKBF42KvT0vQPHNV5NDnUU23xC+aDZGvpsnCU04MPzcrdnnv0/jm+Fhcgmupa3zwgRzPIu
	HTa3j4iqm0rt57qJ9uJF1AQ==
X-Received: from dyem10.prod.google.com ([2002:a05:7300:818a:b0:2cc:a1bf:2dd9])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:1493:b0:2cf:28e8:d784 with SMTP id 5a478bee46e88-2cf28e8dcd7mr6298319eec.19.1775616755301;
 Tue, 07 Apr 2026 19:52:35 -0700 (PDT)
Date: Wed, 08 Apr 2026 02:52:23 +0000
In-Reply-To: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775616747; l=13139;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=56indIRElDV0usMzMjHatIwKqE+ETHzgNqfEGPbTnfI=; b=XZi23tdvGPXXvI/Xf+0YjO2IPZZc4qDmUVCjhEK5/lSd0rQJmiwvwz0o+vZComeMI5i01N/qb
 1p22YyjZmloBs8UylW1tRitoEl3vyyDv3aHa0z1TDTdkEGFOfUd5HoI
X-Mailer: b4 0.14.3
Message-ID: <20260408-teaming-driver-internal-v6-4-e5bcdcf72504@google.com>
Subject: [PATCH net-next v6 04/10] selftests: net: Add tests for failover of
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276252-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,transmit_failover.sh:url]
X-Rspamd-Queue-Id: C15D73B658B
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
Changes in v6:
- Use a tcp port with no associated service.
- Make tcpdump helper function not string-replace port numbers with
  associated service names, even on Fedora, which has a tcpdump patch
  that changes the required flag.
- Link to v5: https://lore.kernel.org/netdev/20260406-teaming-driver-internal-v5-4-e8a3f348a1c5@google.com/

Changes in v5:
- Use tcpdump for collecting traffic, rather than reading rx counters.
- Link to v4: https://lore.kernel.org/netdev/20260403-teaming-driver-internal-v4-4-d3032f33ca25@google.com/

Changes in v2:
- Fix shellcheck failures.
- Remove dependency on net forwarding lib and pipe viewer tools.
- Use iperf3 for tcp instead of netcat.
- Link to v1: https://lore.kernel.org/all/20260331053353.2504254-5-marcharvey@google.com/
---
 tools/testing/selftests/drivers/net/team/Makefile  |   2 +
 tools/testing/selftests/drivers/net/team/config    |   4 +
 .../testing/selftests/drivers/net/team/team_lib.sh | 148 +++++++++++++++++++
 .../drivers/net/team/transmit_failover.sh          | 158 +++++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh      |   9 +-
 5 files changed, 319 insertions(+), 2 deletions(-)

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
index 000000000000..2057f5edee79
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/team_lib.sh
@@ -0,0 +1,148 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+test_dir="$(dirname "$0")"
+export REQUIRE_MZ=no
+export NUM_NETIFS=0
+# shellcheck disable=SC1091
+source "${test_dir}/../../../net/forwarding/lib.sh"
+
+TCP_PORT="43434"
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
+	ip netns exec "${NS2}" iperf3 -s -p "${TCP_PORT}" --logfile /dev/null &
+	# Wait for server to become reachable before starting client.
+	slowwait 5 ip netns exec "${NS1}" iperf3 -c "${NS2_IP}" -p \
+			"${TCP_PORT}" -t 1 --logfile /dev/null
+	ip netns exec "${NS1}" iperf3 -c "${NS2_IP}" -p "${TCP_PORT}" -b 1M -l \
+			1K -t 0 --logfile /dev/null &
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
+			"> ${ip_address}.${TCP_PORT}")
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
index d8cc4c64148d..bb2e9b880343 100644
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
 
@@ -1769,7 +1774,7 @@ tcpdump_show()
 {
 	local if_name=$1
 
-	tcpdump -e -n -r ${capfile[$if_name]} 2>&1
+	tcpdump -e -nn -r ${capfile[$if_name]} 2>&1
 }
 
 # return 0 if the packet wasn't seen on host2_if or 1 if it was

-- 
2.53.0.1213.gd9a14994de-goog


