Return-Path: <netdev+bounces-275520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LazDxAj02n1ewcAu9opvQ
	(envelope-from <netdev+bounces-275520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 05:05:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D23043A1398
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 05:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE73930071E1
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 03:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC71330B32;
	Mon,  6 Apr 2026 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MDDQ47yy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEDD338906
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 03:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775444707; cv=none; b=nhdSMQoP3gaiDfEILsvzfU9QCaSCTmLtMR2hM7PukekAVKpVib7QvEwAWxelMf8Axla6dCO7fYC15YHJjHo5MDCzYvccaY/b2rpeMWcQM5jMBTEw9Fu0Bx7HhQrVw/c/jcl3PLYwNO4nta/tfoID1Mod2BcTvx4ry8w4EFzJZK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775444707; c=relaxed/simple;
	bh=q0Yz8udoUPHxbxecO84egcHUQy+H7PiHS+4O0pnwq/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gouTRheVVyxNlCx+aw9zaMJPpWIMAKs3D1hPbmJuzRmrTeRHqguU8aaWzwt1s/gl0y4w5HCs70iXvUGIecTOpqK/8Zy2GQ4C7QTcZ1Ybi7lGJyxVALzXk14ZwW4Qztqs51fINXY1xI+7t0CohsPryH5TBkimGAxw9OUcUnCc+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MDDQ47yy; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12bf9974587so14777495c88.0
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 20:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775444705; x=1776049505; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gvzdOTjzZWe7D/OSDG4aALCF3gZbQJ2r6PdiKnSYruc=;
        b=MDDQ47yy3Y7olIunZMtULStY7sYZ3BW1UU/s9cERvRt2aG6TAFZVmcy2WC2AMPFwYn
         Kn5TalDPpTUDaq6gseYnDNBEqAJ9Hh/NRsfco4IfdWJai8mYENfs3g+21dKbZ2c206sv
         a0mSuhWJyUK9vNzk85aiA7hqIZ4fDBUX+0HY/W4CeA2A4W+ysh6odeKQdKL/GHna6k4E
         F7bFvpVRTlqPsRqWgkKKF3j8NhkWuxmyBwqyB48166rELQ87VjLdcdVTuIgFXBuE1XF2
         wq+cqMI1v0dcqT6K8fb7JuU2TMkXVqW5oRDm/4t0d9JPC/IUt/pNh24f04mqE8Nb7fW5
         nTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775444705; x=1776049505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvzdOTjzZWe7D/OSDG4aALCF3gZbQJ2r6PdiKnSYruc=;
        b=mqoiiahRsmg6PZIQctdnVu2Vgn+fK5cC6Pp0xWABpDood86YB4sKT7jWvHyUsonUNv
         84Dn8ywjEvu39hS3NCWRKFBfUt9S2NfZdUMbwShDHdz44qshFZpd3VQgL8TObSL1dg/R
         MBAkfLnmmP91yWZnIimr6GidYBG+CDIhhatD0rBDrfYDhM8d7/c0jl3huDSmYCE2qId+
         j2lIJoCai3+7VuDicGr5AOuY5IUWfz4GOWCD1WwJMlvf1w34z+Y8mofrfPR84nHvjyyF
         DDv/n9YR1B/c2Mjr0roiEw+rfz3Jmn/LHyiC4W//PXa1qrZ6WH0MGnbi0nA+DLUTwxs0
         X1MA==
X-Gm-Message-State: AOJu0Yzdtkb525p1dq8NRFlj+lOz+26Tx7I2lVfii69R0klS2G0nhYRu
	OnjhWA1fNpXZTXhOoU+cJlGomDvftmViczC1rQdtJqebNqydM1ry8VEbmHOa66kgIKhurvjhwod
	43pbSLVbm3lV02MC/wk7kiQ==
X-Received: from dlbsi13.prod.google.com ([2002:a05:7022:b88d:b0:12a:bf30:d8b6])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:6713:b0:128:ca6f:adf0 with SMTP id a92af1059eb24-12bfb74c93fmr5816754c88.17.1775444704665;
 Sun, 05 Apr 2026 20:05:04 -0700 (PDT)
Date: Mon, 06 Apr 2026 03:03:46 +0000
In-Reply-To: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775444686; l=13058;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=q0Yz8udoUPHxbxecO84egcHUQy+H7PiHS+4O0pnwq/s=; b=QjpY5inSePJ0udwdgjKyKvi20Fl6nk53RIefMk9OCxiB+IZFjDMVzh1BYvr2YtAl6H9+7Dsr1
 QLn7NCt2IMXChQKkgfBq7VW7sdU75dlqq6cuC5OMdf9VGChEs1jevr2
X-Mailer: b4 0.14.3
Message-ID: <20260406-teaming-driver-internal-v5-10-e8a3f348a1c5@google.com>
Subject: [PATCH net-next v5 10/10] selftests: net: Add tests for team driver
 decoupled tx and rx control
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275520-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[decoupled_enablement.sh:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D23043A1398
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use ping and tcpdump to verify that independent rx and tx enablement
of team driver member interfaces works as intended.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v5:
- Minor typo fixes in both test files.
- Link to v4: https://lore.kernel.org/netdev/20260403-teaming-driver-internal-v4-10-d3032f33ca25@google.com/

Changes in v4:
- None

Changes in v3:
- None

Changes in v2:
- Fix shellcheck failures.
- Link to v1: https://lore.kernel.org/all/20260331053353.2504254-8-marcharvey@google.com/
---
 tools/testing/selftests/drivers/net/team/Makefile  |   1 +
 .../drivers/net/team/decoupled_enablement.sh       | 249 +++++++++++++++++++++
 .../testing/selftests/drivers/net/team/options.sh  |  99 +++++++-
 3 files changed, 348 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index dab922d7f83d..7c58cf82121e 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -2,6 +2,7 @@
 # Makefile for net selftests
 
 TEST_PROGS := \
+	decoupled_enablement.sh \
 	dev_addr_lists.sh \
 	non_ether_header_ops.sh \
 	options.sh \
diff --git a/tools/testing/selftests/drivers/net/team/decoupled_enablement.sh b/tools/testing/selftests/drivers/net/team/decoupled_enablement.sh
new file mode 100755
index 000000000000..0d3d9c98e9f5
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/decoupled_enablement.sh
@@ -0,0 +1,249 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# These tests verify the decoupled RX and TX enablement of team driver member
+# interfaces.
+#
+# Topology
+#
+#  +---------------------+  NS1
+#  |      test_team1     |
+#  |          |          |
+#  |        eth0         |
+#  |          |          |
+#  |          |          |
+#  +---------------------+
+#             |
+#  +---------------------+  NS2
+#  |          |          |
+#  |          |          |
+#  |        eth0         |
+#  |          |          |
+#  |      test_team2     |
+#  +---------------------+
+
+export ALL_TESTS="
+	team_test_tx_enablement
+	team_test_rx_enablement
+"
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
+MEMBERS=("eth0")
+PING_COUNT=5
+PING_TIMEOUT_S=1
+PING_INTERVAL=0.1
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
+# This has to be sourced after opts are gathered...
+export REQUIRE_MZ=no
+export NUM_NETIFS=0
+# shellcheck disable=SC1091
+source "${test_dir}/../../../net/forwarding/lib.sh"
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
+	ip -n "${NS1}" link add test_team1 type team
+	ip -n "${NS2}" link add test_team2 type team
+
+	# Set up the receiving network namespace's team interface.
+	setup_team "${NS2}" test_team2 roundrobin "${NS2_IP}" \
+			"${PREFIX_LENGTH}" "${MEMBERS[@]}"
+}
+
+# Set a particular option value for team or team port.
+# Arguments:
+#   namespace - The namespace name that has the team.
+#   option_name - The option name to set.
+#   option_value - The value to set the option to.
+#   team_name - The name of team to set the option for.
+#   member_name - The (optional) optional name of the member port.
+set_option_value()
+{
+	local namespace="$1"
+	local option_name="$2"
+	local option_value="$3"
+	local team_name="$4"
+	local member_name="$5"
+	local port_flag="--port=${member_name}"
+
+	ip netns exec "${namespace}" teamnl "${team_name}" setoption \
+			"${option_name}" "${option_value}" "${port_flag}"
+	return $?
+}
+
+# Send some pings and return the ping command return value.
+try_ping()
+{
+	ip netns exec "${NS1}" ping -i "${PING_INTERVAL}" -c "${PING_COUNT}" \
+			"${NS2_IP}" -W "${PING_TIMEOUT_S}"
+}
+
+# Checks tcpdump output from net/forwarding lib, and checks if there are any
+# ICMP(4 or 6) packets.
+# Arguments:
+#   interface - The interface name to search for.
+#   ip_address - The destination IP address (4 or 6) to search for.
+did_interface_receive_icmp()
+{
+	local interface="$1"
+	local ip_address="$2"
+	local packet_count
+
+	packet_count=$(tcpdump_show "$interface" | grep -c \
+			"> ${ip_address}: ICMP")
+	echo "Packet count for ${interface} was ${packet_count}"
+
+	if [[ "$packet_count" -gt 0 ]]; then
+		true
+	else
+		false
+	fi
+}
+
+# Test JUST tx enablement with a given mode.
+# Globals:
+#   RET - Used by test infra, set by `check_err` functions.
+# Arguments:
+#   mode - The mode to set the team interfaces to.
+team_test_mode_tx_enablement()
+{
+	local mode="$1"
+	export RET=0
+
+	# Set up the sender team with the correct mode.
+	setup_team "${NS1}" test_team1 "${mode}" "${NS1_IP}" \
+			"${PREFIX_LENGTH}" "${MEMBERS[@]}"
+	check_err $? "Failed to set up sender team"
+
+	### Scenario 1: Member interface initially enabled.
+	# Expect ping to pass
+	try_ping
+	check_err $? "Ping failed when TX enabled"
+
+	### Scenario 2: One tx-side interface disabled.
+	# Expect ping to fail.
+	set_option_value "${NS1}" tx_enabled false test_team1 eth0
+	check_err $? "Failed to disable TX"
+	tcpdump_start eth0 "${NS2}"
+	try_ping
+	check_fail $? "Ping succeeded when TX disabled"
+	tcpdump_stop eth0
+	# Expect no packets to be transmitted, since TX is disabled.
+	did_interface_receive_icmp eth0 "${NS2_IP}"
+	check_fail $? "eth0 IS transmitting when TX disabled"
+	tcpdump_cleanup eth0
+
+	### Scenario 3: The interface has tx re-enabled.
+	# Expect ping to pass.
+	set_option_value "${NS1}" tx_enabled true test_team1 eth0
+	check_err $? "Failed to reenable TX"
+	try_ping
+	check_err $? "Ping failed when TX reenabled"
+
+	log_test "TX failover of '${mode}' test"
+}
+
+# Test JUST rx enablement with a given mode.
+# Globals:
+#   RET - Used by test infra, set by `check_err` functions.
+# Arguments:
+#   mode - The mode to set the team interfaces to.
+team_test_mode_rx_enablement()
+{
+	local mode="$1"
+	export RET=0
+
+	# Set up the sender team with the correct mode.
+	setup_team "${NS1}" test_team1 "${mode}" "${NS1_IP}" \
+			"${PREFIX_LENGTH}" "${MEMBERS[@]}"
+	check_err $? "Failed to set up sender team"
+
+	### Scenario 1: Member interface initially enabled.
+	# Expect ping to pass
+	try_ping
+	check_err $? "Ping failed when RX enabled"
+
+	### Scenario 2: One rx-side interface disabled.
+	# Expect ping to fail.
+	set_option_value "${NS1}" rx_enabled false test_team1 eth0
+	check_err $? "Failed to disable RX"
+	tcpdump_start eth0 "${NS2}"
+	try_ping
+	check_fail $? "Ping succeeded when RX disabled"
+	tcpdump_stop eth0
+	# Expect packets to be transmitted, since only RX is disabled.
+	did_interface_receive_icmp eth0 "${NS2_IP}"
+	check_err $? "eth0 not transmitting when RX disabled"
+	tcpdump_cleanup eth0
+
+	### Scenario 3: The interface has rx re-enabled.
+	# Expect ping to pass.
+	set_option_value "${NS1}" rx_enabled true test_team1 eth0
+	check_err $? "Failed to reenable RX"
+	try_ping
+	check_err $? "Ping failed when RX reenabled"
+
+	log_test "RX failover of '${mode}' test"
+}
+
+team_test_tx_enablement()
+{
+	team_test_mode_tx_enablement broadcast
+	team_test_mode_tx_enablement roundrobin
+	team_test_mode_tx_enablement random
+}
+
+team_test_rx_enablement()
+{
+	team_test_mode_rx_enablement broadcast
+	team_test_mode_rx_enablement roundrobin
+	team_test_mode_rx_enablement random
+}
+
+require_command teamnl
+require_command tcpdump
+require_command ping
+environment_create
+tests_run
+exit "${EXIT_STATUS}"
diff --git a/tools/testing/selftests/drivers/net/team/options.sh b/tools/testing/selftests/drivers/net/team/options.sh
index 44888f32b513..66c0cb896dad 100755
--- a/tools/testing/selftests/drivers/net/team/options.sh
+++ b/tools/testing/selftests/drivers/net/team/options.sh
@@ -11,10 +11,14 @@ if [[ $# -eq 0 ]]; then
         exit $?
 fi
 
-ALL_TESTS="
+export ALL_TESTS="
         team_test_options
+        team_test_enabled_implicit_changes
+        team_test_rx_enabled_implicit_changes
+        team_test_tx_enabled_implicit_changes
 "
 
+# shellcheck disable=SC1091
 source "${test_dir}/../../../net/lib.sh"
 
 TEAM_PORT="team0"
@@ -176,12 +180,105 @@ team_test_options()
         team_test_option mcast_rejoin_count 0 5
         team_test_option mcast_rejoin_interval 0 5
         team_test_option enabled true false "${MEMBER_PORT}"
+        team_test_option rx_enabled true false "${MEMBER_PORT}"
+        team_test_option tx_enabled true false "${MEMBER_PORT}"
         team_test_option user_linkup true false "${MEMBER_PORT}"
         team_test_option user_linkup_enabled true false "${MEMBER_PORT}"
         team_test_option priority 10 20 "${MEMBER_PORT}"
         team_test_option queue_id 0 1 "${MEMBER_PORT}"
 }
 
+team_test_enabled_implicit_changes()
+{
+        export RET=0
+
+        attach_port_if_specified "${MEMBER_PORT}"
+        check_err $? "Couldn't attach ${MEMBER_PORT} to master"
+
+        # Set enabled to true.
+        set_and_check_get enabled true "--port=${MEMBER_PORT}"
+        check_err $? "Failed to set 'enabled' to true"
+
+        # Show that both rx enabled and tx enabled are true.
+        get_and_check_value rx_enabled true "--port=${MEMBER_PORT}"
+        check_err $? "'Rx_enabled' wasn't implicitly set to true"
+        get_and_check_value tx_enabled true "--port=${MEMBER_PORT}"
+        check_err $? "'Tx_enabled' wasn't implicitly set to true"
+
+        # Set enabled to false.
+        set_and_check_get enabled false "--port=${MEMBER_PORT}"
+        check_err $? "Failed to set 'enabled' to false"
+
+        # Show that both rx enabled and tx enabled are false.
+        get_and_check_value rx_enabled false "--port=${MEMBER_PORT}"
+        check_err $? "'Rx_enabled' wasn't implicitly set to false"
+        get_and_check_value tx_enabled false "--port=${MEMBER_PORT}"
+        check_err $? "'Tx_enabled' wasn't implicitly set to false"
+
+        log_test "'Enabled' implicit changes"
+}
+
+team_test_rx_enabled_implicit_changes()
+{
+	export RET=0
+
+	attach_port_if_specified "${MEMBER_PORT}"
+	check_err $? "Couldn't attach ${MEMBER_PORT} to master"
+
+	# Set enabled to true.
+	set_and_check_get enabled true "--port=${MEMBER_PORT}"
+	check_err $? "Failed to set 'enabled' to true"
+
+	# Set rx_enabled to false.
+	set_and_check_get rx_enabled false "--port=${MEMBER_PORT}"
+	check_err $? "Failed to set 'rx_enabled' to false"
+
+	# Show that enabled is false.
+	get_and_check_value enabled false "--port=${MEMBER_PORT}"
+	check_err $? "'enabled' wasn't implicitly set to false"
+
+	# Set rx_enabled to true.
+	set_and_check_get rx_enabled true "--port=${MEMBER_PORT}"
+	check_err $? "Failed to set 'rx_enabled' to true"
+
+	# Show that enabled is true.
+	get_and_check_value enabled true "--port=${MEMBER_PORT}"
+	check_err $? "'enabled' wasn't implicitly set to true"
+
+	log_test "'Rx_enabled' implicit changes"
+}
+
+team_test_tx_enabled_implicit_changes()
+{
+	export RET=0
+
+	attach_port_if_specified "${MEMBER_PORT}"
+	check_err $? "Couldn't attach ${MEMBER_PORT} to master"
+
+	# Set enabled to true.
+	set_and_check_get enabled true "--port=${MEMBER_PORT}"
+	check_err $? "Failed to set 'enabled' to true"
+
+	# Set tx_enabled to false.
+	set_and_check_get tx_enabled false "--port=${MEMBER_PORT}"
+	check_err $? "Failed to set 'tx_enabled' to false"
+
+	# Show that enabled is false.
+	get_and_check_value enabled false "--port=${MEMBER_PORT}"
+	check_err $? "'enabled' wasn't implicitly set to false"
+
+	# Set tx_enabled to true.
+	set_and_check_get tx_enabled true "--port=${MEMBER_PORT}"
+	check_err $? "Failed to set 'tx_enabled' to true"
+
+	# Show that enabled is true.
+	get_and_check_value enabled true "--port=${MEMBER_PORT}"
+	check_err $? "'enabled' wasn't implicitly set to true"
+
+	log_test "'Tx_enabled' implicit changes"
+}
+
+
 require_command teamnl
 setup
 tests_run

-- 
2.53.0.1185.g05d4b7b318-goog


