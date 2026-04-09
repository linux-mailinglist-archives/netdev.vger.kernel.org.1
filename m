Return-Path: <netdev+bounces-276819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKg/AVkW12k1KwgAu9opvQ
	(envelope-from <netdev+bounces-276819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:00:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C3C3C5D4F
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3431A3016482
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 03:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA39371896;
	Thu,  9 Apr 2026 02:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I1rUN3XC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6A7364E9E
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703597; cv=none; b=DNl5mj5M4D6xQVnbAhtpRQRA3Suw45/PBHY0udG121sMTY/F6IuX7Rd1F/IlM4ynHOCP9lyrQIthK8jJGqxKSirI2H+3sQEjJsMdU/8Nx/K7/PPeIuxxRwQN9F6dgkuLCfwx+emByCRDuAfw81YtdcTa+Eee2w8Kr07ExkPpy0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703597; c=relaxed/simple;
	bh=e+kl8f3hOCKVxYQXu2rewoIhzQxtIQk0KdvifJyaqso=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m/fR35P2jHi7PzV7fP5wOXPzNSRYfFIZw9AxgRzkp1Iukrd0Pd2Pwqt1r0PTSrdpc59cNtyKTqmJL/dOb2GcuVLYAQETaarWYb0oegJLAkaUCVXkYlEZS6Qfga4eAi29O+czC71BT0T2ERjEMb4mPxMgI97ikIjbLzN3U9i3IQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I1rUN3XC; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda35eab74so220082eec.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 19:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775703589; x=1776308389; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a6EoE0a++AdD+SY7PVeeeDt4kL/3NznI10Or1Yv9/L8=;
        b=I1rUN3XCH6/yCSPdFqVQPZlCnCHevU0bLCxc0eP5/blR+nJF/ExaIF4KscStCKFrGS
         lvjdrDSe7y6sD3Po5wCCNoEkXEUhV4Eb2j1RqSd//g3M36j+tzPxAmcRxzvotmnRaPAH
         FX/3m1QKsuSeFfmT6wt7oEObAMBIKRCpaJpLQWyG4eKe+vQJfUG0GXxdUc5c9NzHwd90
         kVxNUpO/2uf1RumBzeZ3vmnrhW5zhGTf1zuLf+tX/EN/H2cLJV2EkUtJ8dI1FjFp2f6P
         EiwRJBN2Ca/mM0VqnD5qbHv139Bh01GLLDEmFxldlzvR6e3dRG0GV13kwiTHV2Rm/yWu
         YW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775703589; x=1776308389;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6EoE0a++AdD+SY7PVeeeDt4kL/3NznI10Or1Yv9/L8=;
        b=axnVHOSN6+4mzxli/MvWDMwvk1x07vK7Ukk40J+JNjGFzG9ZggyIpHHk/fQNHWWITZ
         dCgU1PF/NefXHMKLFQxRUib8qRi/yoyMaoiVD5ObnC+vMWFSvAeOhdtPmULo4A5GXDKL
         V01/bzvjJh5nQvdkvm4DKJW1rz0TRm46LZSi3kxFRvjXpQp44BSNWDYUiJq8AE0LonmY
         WgMtJL5SG434oyXVJi0YdsN0lCpg0Nm0LROkC8oAw064ZHsDnUFl+EyYM2X0/kn6HOBT
         GtPBSbdbdDj9lGAma73RAk7S6ZL+dNsWJdzFPoWPGsFU7Qd5ixzJcPKEobDi181S2vKY
         o+0Q==
X-Gm-Message-State: AOJu0YxrOQKMb+Fr6Pbik1hmG7nC93WY7y3XjTqie646MKcSjiVJJ0EP
	2RTqRiiQiOrZrAwYdr5uF74u4f+qBbcXytg+J1LkSxRbcK7EgaMU9iUAeOBin8jDCPAsu6CSWy3
	e7+DE2fngovy/Xe2h83Cisw==
X-Received: from dydb8.prod.google.com ([2002:a05:7300:80c8:b0:2cb:b540:9519])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:7253:b0:2c5:704f:7142 with SMTP id 5a478bee46e88-2d40da0b901mr1000374eec.2.1775703588571;
 Wed, 08 Apr 2026 19:59:48 -0700 (PDT)
Date: Thu, 09 Apr 2026 02:59:27 +0000
In-Reply-To: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775703578; l=11946;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=e+kl8f3hOCKVxYQXu2rewoIhzQxtIQk0KdvifJyaqso=; b=fHtc82GTPRTk+oy3VJDMqcKN5OGQ4G60B9v8eNoBrLfr8S0pKk5UBSwuGyBmw/fs5Wp20+c4f
 tdGY439RKyoAf6cVRVQZIiku4JNvx1lG4FsfpLtIkUfrr1SrR7cTMFw
X-Mailer: b4 0.14.3
Message-ID: <20260409-teaming-driver-internal-v7-5-f47e7589685d@google.com>
Subject: [PATCH net-next v7 05/10] selftests: net: Add test for enablement of
 ports with teamd
From: Marc Harvey <marcharvey@google.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, 
	Marc Harvey <marcharvey@google.com>
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
	TAGGED_FROM(0.00)[bounces-276819-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,teamd_activebackup.sh:url]
X-Rspamd-Queue-Id: 74C3C3C5D4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are no tests that verify enablement and disablement of team driver
ports with teamd. This should work even with changes to the enablement
option, so it is important to test.

This test sets up an active-backup network configuration across two
network namespaces, and tries to send traffic while changing which
link is the active one.

Also increase the team test timeout to 300 seconds, because gracefully
killing teamd can take 30 seconds for each instance.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v7:
- Increase test timeout to 300 seconds, since terminating teamd can
  take 30 seconds during test cleanup.
- Link to v6: https://lore.kernel.org/netdev/20260408-teaming-driver-internal-v6-5-e5bcdcf72504@google.com/

Changes in v6:
- Remove manual changing of member port states to UP, not needed.
- Link to v5: https://lore.kernel.org/netdev/20260406-teaming-driver-internal-v5-5-e8a3f348a1c5@google.com/

Changes in v5:
- Make test wait for inactive link to stop receiving traffic after
  setting it to inactive, since there was a race condition.
- Change test teardown to try graceful shutdown first, then use
  sigkill if needed.
- Manually delete leftover teamd files during teardown.
- Use tcpdump instead of checking rx counters.
- Link to v4: https://lore.kernel.org/netdev/20260403-teaming-driver-internal-v4-5-d3032f33ca25@google.com/

Changed in v3:
- Make test cleanup kill teamd instead of terminate.
- Link to v2: https://lore.kernel.org/netdev/20260401-teaming-driver-internal-v2-5-f80c1291727b@google.com/

Changes in v2:
- Fix shellcheck failures.
- Remove dependency on net forwarding lib and pipe viewer tools.
- Use iperf3 for tcp instead of netcat.
- Link to v1: https://lore.kernel.org/all/20260331053353.2504254-6-marcharvey@google.com/
---
 tools/testing/selftests/drivers/net/team/Makefile  |   1 +
 tools/testing/selftests/drivers/net/team/settings  |   1 +
 .../testing/selftests/drivers/net/team/team_lib.sh |  26 +++
 .../drivers/net/team/teamd_activebackup.sh         | 246 +++++++++++++++++++++
 tools/testing/selftests/net/lib.sh                 |  13 ++
 5 files changed, 287 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index 777da2e0429e..dab922d7f83d 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -7,6 +7,7 @@ TEST_PROGS := \
 	options.sh \
 	propagation.sh \
 	refleak.sh \
+	teamd_activebackup.sh \
 	transmit_failover.sh \
 # end of TEST_PROGS
 
diff --git a/tools/testing/selftests/drivers/net/team/settings b/tools/testing/selftests/drivers/net/team/settings
new file mode 100644
index 000000000000..694d70710ff0
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/settings
@@ -0,0 +1 @@
+timeout=300
diff --git a/tools/testing/selftests/drivers/net/team/team_lib.sh b/tools/testing/selftests/drivers/net/team/team_lib.sh
index 2057f5edee79..02ef0ee02d6a 100644
--- a/tools/testing/selftests/drivers/net/team/team_lib.sh
+++ b/tools/testing/selftests/drivers/net/team/team_lib.sh
@@ -146,3 +146,29 @@ did_interface_receive()
 		false
 	fi
 }
+
+# Return true if the given interface in the given namespace does NOT receive
+# traffic over a 1 second period.
+# Arguments:
+#   interface - The name of the interface.
+#   ip_address - The destination IP address.
+#   namespace - The name of the namespace that the interface is in.
+check_no_traffic()
+{
+	local interface="$1"
+	local ip_address="$2"
+	local namespace="$3"
+	local rc
+
+	save_tcpdump_outputs "${namespace}" "${interface}"
+	did_interface_receive "${interface}" "${ip_address}"
+	rc=$?
+
+	clear_tcpdump_outputs "${interface}"
+
+	if [[ "${rc}" -eq 0 ]]; then
+		return 1
+	else
+		return 0
+	fi
+}
diff --git a/tools/testing/selftests/drivers/net/team/teamd_activebackup.sh b/tools/testing/selftests/drivers/net/team/teamd_activebackup.sh
new file mode 100755
index 000000000000..2b26a697e179
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/teamd_activebackup.sh
@@ -0,0 +1,246 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# These tests verify that teamd is able to enable and disable ports via the
+# active backup runner.
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
+export ALL_TESTS="teamd_test_active_backup"
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
+NS1_TEAMD_CONF=""
+NS2_TEAMD_CONF=""
+NS1_TEAMD_PID=""
+NS2_TEAMD_PID=""
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
+			echo "Invalid option: -${OPTARG}" >&2
+			exit 1
+			;;
+	esac
+done
+
+teamd_config_create()
+{
+	local runner=$1
+	local dev=$2
+	local conf
+
+	conf=$(mktemp)
+
+	cat > "${conf}" <<-EOF
+	{
+		"device": "${dev}",
+		"runner": {"name": "${runner}"},
+		"ports": {
+			"eth0": {},
+			"eth1": {}
+		}
+	}
+	EOF
+	echo "${conf}"
+}
+
+# Create the network namespaces, veth pair, and team devices in the specified
+# runner.
+# Globals:
+#   RET - Used by test infra, set by `check_err` functions.
+# Arguments:
+#   runner - The Teamd runner to use for the Team devices.
+environment_create()
+{
+	local runner=$1
+
+	echo "Setting up two-link aggregation for runner ${runner}"
+	echo "Teamd version is: $(teamd --version)"
+	trap environment_destroy EXIT
+
+	setup_ns ns1 ns2
+	NS1="${NS_LIST[0]}"
+	NS2="${NS_LIST[1]}"
+
+	for link in $(seq 0 1); do
+		ip -n "${NS1}" link add "eth${link}" type veth peer name \
+				"eth${link}" netns "${NS2}"
+		check_err $? "Failed to create veth pair"
+	done
+
+	NS1_TEAMD_CONF=$(teamd_config_create "${runner}" "test_team1")
+	NS2_TEAMD_CONF=$(teamd_config_create "${runner}" "test_team2")
+	echo "Conf files are ${NS1_TEAMD_CONF} and ${NS2_TEAMD_CONF}"
+
+	ip netns exec "${NS1}" teamd -d -f "${NS1_TEAMD_CONF}"
+	check_err $? "Failed to create team device in ${NS1}"
+	NS1_TEAMD_PID=$(pgrep -f "teamd -d -f ${NS1_TEAMD_CONF}")
+
+	ip netns exec "${NS2}" teamd -d -f "${NS2_TEAMD_CONF}"
+	check_err $? "Failed to create team device in ${NS2}"
+	NS2_TEAMD_PID=$(pgrep -f "teamd -d -f ${NS2_TEAMD_CONF}")
+
+	echo "Created team devices"
+	echo "Teamd PIDs are ${NS1_TEAMD_PID} and ${NS2_TEAMD_PID}"
+
+	ip -n "${NS1}" link set test_team1 up
+	check_err $? "Failed to set test_team1 up in ${NS1}"
+	ip -n "${NS2}" link set test_team2 up
+	check_err $? "Failed to set test_team2 up in ${NS2}"
+
+	ip -n "${NS1}" addr add "${NS1_IP}/${PREFIX_LENGTH}" "${NODAD}" dev \
+			test_team1
+	check_err $? "Failed to add address to team device in ${NS1}"
+	ip -n "${NS2}" addr add "${NS2_IP}/${PREFIX_LENGTH}" "${NODAD}" dev \
+			test_team2
+	check_err $? "Failed to add address to team device in ${NS2}"
+
+	slowwait 2 timeout 0.5 ip netns exec "${NS1}" ping -W 1 -c 1 "${NS2_IP}"
+}
+
+# Tear down the environment: kill teamd and delete network namespaces.
+environment_destroy()
+{
+	echo "Tearing down two-link aggregation"
+
+	rm "${NS1_TEAMD_CONF}"
+	rm "${NS2_TEAMD_CONF}"
+
+	# First, try graceful teamd teardown.
+	ip netns exec "${NS1}" teamd -k -t test_team1
+	ip netns exec "${NS2}" teamd -k -t test_team2
+
+	# If teamd can't be killed gracefully, then sigkill.
+	if kill -0 "${NS1_TEAMD_PID}" 2>/dev/null; then
+		echo "Sending sigkill to teamd for test_team1"
+		kill -9 "${NS1_TEAMD_PID}"
+		rm -f /var/run/teamd/test_team1.{pid,sock}
+	fi
+	if kill -0 "${NS2_TEAMD_PID}" 2>/dev/null; then
+		echo "Sending sigkill to teamd for test_team2"
+		kill -9 "${NS2_TEAMD_PID}"
+		rm -f /var/run/teamd/test_team2.{pid,sock}
+	fi
+	cleanup_all_ns
+}
+
+# Change the active port for an active-backup mode team.
+# Arguments:
+#   namespace - The network namespace that the team is in.
+#   team - The name of the team.
+#   active_port - The port to make active.
+set_active_port()
+{
+	local namespace=$1
+	local team=$2
+	local active_port=$3
+
+	ip netns exec "${namespace}" teamdctl "${team}" state item set \
+			runner.active_port "${active_port}"
+	slowwait 2 bash -c "ip netns exec ${namespace} teamdctl ${team} state \
+			item get runner.active_port | grep -q ${active_port}"
+}
+
+# Wait for an interface to stop receiving traffic. If it keeps receiving traffic
+# for the duration of the timeout, then return an error.
+# Arguments:
+#   - namespace - The network namespace that the interface is in.
+#   - interface - The name of the interface.
+wait_to_stop_receiving()
+{
+	local namespace=$1
+	local interface=$2
+
+	echo "Waiting for ${interface} in ${namespace} to stop receiving"
+	slowwait 10 check_no_traffic "${interface}" "${NS2_IP}" \
+			"${namespace}"
+}
+
+# Test that active backup runner can change active ports.
+# Globals:
+#   RET - Used by test infra, set by `check_err` functions.
+teamd_test_active_backup()
+{
+	export RET=0
+
+	start_listening_and_sending
+
+	### Scenario 1: Don't manually set active port, just make sure team
+	# works.
+	save_tcpdump_outputs "${NS2}" test_team2
+	did_interface_receive test_team2 "${NS2_IP}"
+	check_err $? "Traffic did not reach team interface in NS2."
+	clear_tcpdump_outputs test_team2
+
+	### Scenario 2: Choose active port.
+	set_active_port "${NS1}" test_team1 eth1
+	set_active_port "${NS2}" test_team2 eth1
+
+	wait_to_stop_receiving "${NS2}" eth0
+	save_tcpdump_outputs "${NS2}" eth0 eth1
+	did_interface_receive eth0 "${NS2_IP}"
+	check_fail $? "eth0 IS transmitting when inactive"
+	did_interface_receive eth1 "${NS2_IP}"
+	check_err $? "eth1 not transmitting when active"
+	clear_tcpdump_outputs eth0 eth1
+
+	### Scenario 3: Change active port.
+	set_active_port "${NS1}" test_team1 eth0
+	set_active_port "${NS2}" test_team2 eth0
+
+	wait_to_stop_receiving "${NS2}" eth1
+	save_tcpdump_outputs "${NS2}" eth0 eth1
+	did_interface_receive eth0 "${NS2_IP}"
+	check_err $? "eth0 not transmitting when active"
+	did_interface_receive eth1 "${NS2_IP}"
+	check_fail $? "eth1 IS transmitting when inactive"
+	clear_tcpdump_outputs eth0 eth1
+
+	log_test "teamd active backup runner test"
+
+	stop_sending_and_listening
+}
+
+require_command teamd
+require_command teamdctl
+require_command iperf3
+require_command tcpdump
+environment_create activebackup
+tests_run
+exit "${EXIT_STATUS}"
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index e915386daf1b..b3827b43782b 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -224,6 +224,19 @@ setup_ns()
 	NS_LIST+=("${ns_list[@]}")
 }
 
+in_all_ns()
+{
+	local ret=0
+	local ns_list=("${NS_LIST[@]}")
+
+	for ns in "${ns_list[@]}"; do
+		ip netns exec "${ns}" "$@"
+		(( ret = ret || $? ))
+	done
+
+	return "${ret}"
+}
+
 # Create netdevsim with given id and net namespace.
 create_netdevsim() {
     local id="$1"

-- 
2.53.0.1213.gd9a14994de-goog


