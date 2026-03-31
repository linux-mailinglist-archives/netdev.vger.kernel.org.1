Return-Path: <netdev+bounces-273469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPDINPldy2lJGwYAu9opvQ
	(envelope-from <netdev+bounces-273469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:39:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8039036430B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BF6B3076378
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6519F370D4C;
	Tue, 31 Mar 2026 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3Nxfywk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981136D517
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774935314; cv=none; b=PGhWj7y4P3TZbqU+TpOLlKWQB2qSxD+U5S8VX5SasikWRCbXh+15CjmXovmSMovjvKpbdEmUA+S3acWC7EoPMgeYUxSiwFeofKExq2gxWYuLWZhgsxXoBRSOGSyb/ihq8pgCqPr6o2nguGH/yUQU/C7kYSXDZ18QMW+aPU7tMRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774935314; c=relaxed/simple;
	bh=chdFTHKEEe/9F4/B8MGB3L/HILSYzORxwlzzmVDZxKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dEEi3f0KAwJLtvW2SCkQiMoSWNwy/xe9dV61Z8RMuYZobwHZOzIK8jziy/2xlhjOMBRNs1WqJC2IRaUvg1+P1D3dz1OTU7QjnRW4lNaorQZ0AuiP3JpkMBliTq6audmcB6EEP3Eyb5WIJlJ77xsllOvDvk/wK9kGomH8P+Z0ChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H3Nxfywk; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c7f2b72c91so3552988eec.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774935312; x=1775540112; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5K3D1TSwbxWRr5iGihbbJ5mwJr2DA+XfuVE8T4+Ht5c=;
        b=H3NxfywkQdfpUPZNvU9p6tePfTn+4FpCOTJYS3Zrd8T5Jr7OBauYgL6JrndbJi5Pnv
         yHSiyIspPUAEPvLCc9IGEmwKaxdEMQ8qokd0UJawLvWGJ9ffMgE3T804Y1cshDniWVAB
         1jl7xitFsbbQOhEpwP6tCr+iie9CQDAkaVoOYh+A8CK6irfMA4JTodlRYRnZ0lH5F0zE
         TmDUcOblv1G8xIkMXFwkhpVVzQyr4DNICX783rhJmh6NFzuG/L+gFOUpSqDlauXcucXg
         LNFwux/wXyoxzA3DS6BcPl0ZAlR65P/kigngQIR4uWfvkoCTv4NdEoxDNKVP2iII2m7V
         a8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774935312; x=1775540112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5K3D1TSwbxWRr5iGihbbJ5mwJr2DA+XfuVE8T4+Ht5c=;
        b=ZYhm2QsxQ8vffvwzGIFZ+JjOH9Kve6EslMOUFKadhhmxuRNkPgtA44SdG6khhZsMWZ
         rpQj5QbREDwopE6n170ODQSPE4SKJ9q3NbZRl6GrHsvGnNuEue7JkNlzMNauiebrfdgi
         TUKouumPMtvL5lhSJsVxFZ+WHesnem6ITO0X047malBaYpXdW75X24XaNxfUNXdAJGOt
         dYFxJFdrAQka+1q/py2BpaQq17J5l+FegRbq+/NI37ZsIuNCGV++EXJNhinpGAKYsKZq
         PreqYSvx33+vOoDug4E+m8OqjXJFMbr5R7VCL5WnkoOceNHR0yrAq3yLgskhy1TEWumG
         7X9A==
X-Forwarded-Encrypted: i=1; AJvYcCVI6aGEVq3OEWDAc8a2FMXFOVb9+wL9RnlpqDsX7e3oMiN3Y5yJwIDk0zMaIAeIYyvHSN3QW/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0YDCr2aqC5hExgiXRBBhT4iDjrCDQowiRYSh8e8pGnt6By+rB
	g9Voylpgn/S+EK7claCZcIUctMU1Ooki7q01v6rnEJC1X97vqsdtxqLOHS5yQl76PI9ZYG0P5k5
	4Va/AegNqFSfpOXC6+J9/qg==
X-Received: from dycnh15.prod.google.com ([2002:a05:7300:ce8f:b0:2c6:89f3:efa9])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:248c:b0:2c4:8d51:f983 with SMTP id 5a478bee46e88-2c48d5205e3mr4167947eec.11.1774935311608;
 Mon, 30 Mar 2026 22:35:11 -0700 (PDT)
Date: Tue, 31 Mar 2026 05:33:50 +0000
In-Reply-To: <20260331053353.2504254-1-marcharvey@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331053353.2504254-1-marcharvey@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260331053353.2504254-5-marcharvey@google.com>
Subject: [PATCH net-next 4/7] selftests: net: Add tests for failover of
 team-aggregated ports
From: Marc Harvey <marcharvey@google.com>
To: jiri@resnulli.us, andrew+netdev@lunn.ch
Cc: willemb@google.com, maheshb@google.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Marc Harvey <marcharvey@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273469-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8039036430B
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
 .../selftests/drivers/net/team/Makefile       |   1 +
 .../testing/selftests/drivers/net/team/config |   4 +
 .../selftests/drivers/net/team/team_lib.sh    | 129 +++++++++++++++
 .../drivers/net/team/transmit_failover.sh     | 155 ++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |  13 +-
 5 files changed, 300 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/team/team_lib.sh
 create mode 100755 tools/testing/selftests/drivers/net/team/transmit_failover.sh

diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index 02d6f51d5a06..ed11edf07655 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -7,6 +7,7 @@ TEST_PROGS := \
 	options.sh \
 	propagation.sh \
 	refleak.sh \
+	transmit_failover.sh \
 # end of TEST_PROGS
 
 TEST_INCLUDES := \
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
index 000000000000..94fdb07edc30
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/team_lib.sh
@@ -0,0 +1,129 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+REQUIRE_MZ=no
+NUM_NETIFS=0
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
+		ip -n "${namespace}" link set ${member} master "${team}"
+	done
+
+	# Bring team devices up and give them addresses.
+	if ! ip -n "${namespace}" link set "${team}" up; then
+		echo "Failed to set ${team} up"
+		return 1
+	fi
+
+	if ! ip -n ${namespace} addr add "${ip_address}/${prefix_length}" \
+			${NODAD} dev "${team}"; then
+		echo "Failed to give ${team} IP address in ${namespace}"
+		return 1
+	fi
+}
+
+# This is global used to keep track of the sender's netcat process, so that it
+# can be terminated.
+declare sender_pid
+
+# Start sending and receiving TCP traffic with netcat.
+# Globals:
+#  sender_pid - The process ID of the netcat sender process. Used to kill it
+#  later.
+start_listening_and_sending()
+{
+	ip netns exec "${NS2}" nc -l "${NS2_IP}" 1234 > /dev/null &
+	ip netns exec "${NS1}" /bin/bash -c "cat /dev/urandom | pv -q -L 1m | \
+			nc ${NS2_IP} 1234 &"
+	sender_pid=$!
+}
+
+# Stop sending TCP traffic with netcat.
+# Globals:
+#   sender_pid - The process IF of the netcat sender process.
+stop_sending_and_listening()
+{
+	kill "${sender_pid}" && wait "${sender_pid}"
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
+		tcpdump_start_nosleep "${interface}" "${namespace}"
+	done
+
+	sleep 1
+
+	for interface in "${interfaces[@]}"; do
+		tcpdump_stop_nosleep "${interface}"
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
+
+	local packet_count=$(tcpdump_show "$interface" | grep \
+			"> ${ip_address}.1234" | wc -l)
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
index 000000000000..c53743e26c24
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/transmit_failover.sh
@@ -0,0 +1,155 @@
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
+ALL_TESTS="team_test_failover"
+
+test_dir="$(dirname "$0")"
+source "${test_dir}/../../../net/lib.sh"
+
+NS1=""
+NS2=""
+NODAD="nodad"
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
+			NODAD=
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
+# This has to be sourced after opts are gathered... (because of the forwarding
+# lib)
+source "${test_dir}/team_lib.sh"
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
+	RET=0
+
+	# Set up the sender team with the correct mode.
+	echo "Members: ${MEMBERS[@]}"
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
+
+	### Scenario 2: One tx-side interface disabled.
+	ip netns exec "${NS1}" teamnl test_team1 setoption enabled false \
+			--port=eth0
+	slowwait 2 bash -c "ip netns exec ${NS1} teamnl test_team1 getoption \
+			enabled --port=eth0 | grep -q false"
+	save_tcpdump_outputs "${NS2}" "${MEMBERS[@]}"
+
+	did_interface_receive eth0 "${NS2_IP}"
+	check_fail $? "eth0 IS transmitting when disabled"
+	did_interface_receive eth1 "${NS2_IP}"
+	check_err $? "eth1 not transmitting when enabled"
+
+	### Scenario 3: The interface is re-enabled.
+	ip netns exec "${NS1}" teamnl test_team1 setoption enabled true \
+			--port=eth0
+	slowwait 2 bash -c "ip netns exec ${NS1} teamnl test_team1 getoption \
+			enabled --port=eth0 | grep -q true"
+	save_tcpdump_outputs "${NS2}" "${MEMBERS[@]}"
+
+	did_interface_receive eth0 "${NS2_IP}"
+	check_err $? "eth0 not transmitting when both links enabled"
+	did_interface_receive eth1 "${NS2_IP}"
+	check_err $? "eth1 not transmitting when both links enabled"
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
+require_command teamnl nc pv
+environment_create
+tests_run
+exit "${EXIT_STATUS}"
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index a9034f0bb58b..5733f9437521 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1582,7 +1582,7 @@ declare -A cappid
 declare -A capfile
 declare -A capout
 
-tcpdump_start()
+tcpdump_start_nosleep()
 {
 	local if_name=$1; shift
 	local ns=$1; shift
@@ -1606,16 +1606,25 @@ tcpdump_start()
 		-s 65535 -B 32768 $capuser -w ${capfile[$if_name]} \
 		> "${capout[$if_name]}" 2>&1 &
 	cappid[$if_name]=$!
+}
 
+tcpdump_start()
+{
+	tcpdump_start_nosleep $1 $2
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
+	tcpdump_stop_nosleep $1
 	sleep 1
 }
 
-- 
2.53.0.1018.g2bb0e51243-goog


