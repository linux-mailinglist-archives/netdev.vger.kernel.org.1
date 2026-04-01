Return-Path: <netdev+bounces-273901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCztDPa2zGnMVwYAu9opvQ
	(envelope-from <netdev+bounces-273901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 08:11:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EB3375129
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 08:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A039630E4000
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 06:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239FC32F757;
	Wed,  1 Apr 2026 06:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8WVh4lc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AE233AD91
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 06:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775023551; cv=none; b=fqH3IvY7sJ6+pd44WbJ/RYU0LrajkBhpjjCTLioNdnizDlDONHwd9JFz9z2gI88GWM2dIquPUiBKyG3N1yjOCxiZV8qEzP3DNiEEiKexVLuk5xp3fOOzNcQ/YP8kuSmK2Yq3eI/Q8uCCelFp+A6jFzESAXSsbLmqhlU0sWe7gzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775023551; c=relaxed/simple;
	bh=64Oai3ivdgSUBHEtLHjbPwgulNCJ4ZUE1a6YJU3wXrQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ucb6mHuavN923RDUPo6EJY9z61YeW0XVWmHoUi8G1mhNqBTh8F7o9LJv+XghZV5O9neTgm6ffvljQGxTW7Kv12nqDCmC/7POKuez+BBFjLVYXHEm6IgdeOAadakZSeov4XcMzpu0Zv/qklzGqqePp1jv1sPBCZgkwRXUHz5Hwhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8WVh4lc; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-128d0b690feso15634636c88.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775023549; x=1775628349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5HZ86mxT7F0eSXefFjWdsBrIU0A3WEekP24/qyqSzIk=;
        b=u8WVh4lcnWfiXmlwR7Dq8z1EREBsWEG1SLPfXu+KDc2Ni0WOz1I5Eovk6DTe/xO+z4
         PbsF1Fw/W+1Pm77A8VjChpSsHso7tChb/8GaSB/9sSZVfJGU8YXWjjE9Eo7PTJlr7He3
         b4JP5RSBLLRj/kNYPf5n5B9D1w1qpRfhYNBarcoJOBAHbsezMgdj6MkYk+X5pkL6srz1
         bML7SI9NhSmTwm7Keqc2uzslPmoZjPx0a97bWhdCqML6+whOs1q3tmZ5ml+kXif6s42j
         wRI4tjwoeKigh6QYrnibSx3Qega5qR/bPkDGKl+zP74bnUzQRsSCvCZnfsp8GJC9Hui3
         +JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775023549; x=1775628349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5HZ86mxT7F0eSXefFjWdsBrIU0A3WEekP24/qyqSzIk=;
        b=TrFVkDxzMiBleo+b5TbL2xxwOf2yBN4OteuDLH0KUdk6vWmFWx0KhEjAPNcCwfvEPZ
         JBynIRxKfG5gBbjyVsl0Ja4oCZ6/im2yodg9CIqQ+/6Vl1OVFt5AIha7KzFFTwpOW2qY
         FoeZrBteVSVRGDwtL2ge9cQ+SXGT4kjge/w9XzURKOQAcG2+TEJicO0TTJSqYy7QA9a8
         50VWWOr1wBq01iBKTmIHm5QF59OFrZMkxJYUU/+zFGC7GblHRJ60ODCdfgZH5YXxej3K
         BrOwGEpasEDje4vYNTJ6PbjoXubl0tVjLWK6QaCbxkGa+f7wpgK/yieQSVWRrRCFhNbJ
         83+Q==
X-Gm-Message-State: AOJu0Yw8WvclJ8Ylk0zBdFj1O2byvwYZs8nbLVcDZo0YOmRl3AOb3Pmq
	y1Lf8AIubdPHtJKLdrWmygiIwyxY2HySfxB6vipjxruz5nn3YQYDnb4iIMIuqZY2BG+whHpkvUw
	Vy7NpS4g28kCPDHyyeKPihQ==
X-Received: from dyctb12.prod.google.com ([2002:a05:693c:39cc:b0:2c9:8fa0:f7a0])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:d51b:b0:2c7:2cac:8153 with SMTP id 5a478bee46e88-2c9333adfadmr1423000eec.31.1775023547743;
 Tue, 31 Mar 2026 23:05:47 -0700 (PDT)
Date: Wed, 01 Apr 2026 06:05:29 +0000
In-Reply-To: <20260401-teaming-driver-internal-v2-0-f80c1291727b@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401-teaming-driver-internal-v2-0-f80c1291727b@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775023538; l=7939;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=64Oai3ivdgSUBHEtLHjbPwgulNCJ4ZUE1a6YJU3wXrQ=; b=mgR9e8qpLc2fZ93b9n5MCf6dELD1RiN2NdukZ/M8yM9N3gprwHBoV7yjEtJyz1O57IM4E9bd3
 Ix+NXBJejbWC/d9AobhQ+KBBjIzlYviIEiLUoIRkgJ2JrovtWegEIaQ
X-Mailer: b4 0.14.3
Message-ID: <20260401-teaming-driver-internal-v2-5-f80c1291727b@google.com>
Subject: [PATCH net-next v2 5/7] selftests: net: Add test for enablement of
 ports with teamd
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273901-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,teamd_activebackup.sh:url]
X-Rspamd-Queue-Id: A7EB3375129
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are no tests that verify enablement and disablement of team driver
ports with teamd. This should work even with changes to the enablement
option, so it is important to test.

This test sets up an active-backup network configuration across two
network namespaces, and tries to send traffic while changing which
link is the active one.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v2:
  - Fix shellcheck failures.
  - Remove dependency on net forwarding lib and pipe viewer tools.
  - Use iperf3 for tcp instead of netcat.
  - Link to v1: https://lore.kernel.org/all/20260331053353.2504254-6-marcharvey@google.com/
---
 tools/testing/selftests/drivers/net/team/Makefile  |   1 +
 .../drivers/net/team/teamd_activebackup.sh         | 207 +++++++++++++++++++++
 tools/testing/selftests/net/lib.sh                 |  13 ++
 3 files changed, 221 insertions(+)

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
 
diff --git a/tools/testing/selftests/drivers/net/team/teamd_activebackup.sh b/tools/testing/selftests/drivers/net/team/teamd_activebackup.sh
new file mode 100755
index 000000000000..cf576a57b2c4
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/teamd_activebackup.sh
@@ -0,0 +1,207 @@
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
+	ip netns exec "${NS2}" teamd -d -f "${NS2_TEAMD_CONF}"
+	check_err $? "Failed to create team device in ${NS2}"
+	echo "Created team devices"
+
+	rm "${NS1_TEAMD_CONF}"
+	rm "${NS2_TEAMD_CONF}"
+	NS1_TEAMD_CONF=""
+	NS2_TEAMD_CONF=""
+
+	for link in $(seq 0 1); do
+		in_all_ns "ip link set eth${link} up"
+		check_err $? "Failed to set eth${link} up"
+	done
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
+	ip netns exec "${NS1}" teamd -k -t test_team1
+	ip netns exec "${NS2}" teamd -k -t test_team2
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
+	did_interface_receive test_team2 "${NS2}"
+	check_err $? "Traffic did not reach team interface in NS2."
+
+	### Scenario 2: Choose active port.
+	set_active_port "${NS1}" test_team1 eth1
+	set_active_port "${NS2}" test_team2 eth1
+
+	did_interface_receive eth0 "${NS2}"
+	check_fail $? "eth0 IS transmitting when disabled"
+	did_interface_receive eth1 "${NS2}"
+	check_err $? "eth1 not transmitting when enabled"
+
+	### Scenario 3: Change active port.
+	set_active_port "${NS1}" test_team1 eth0
+	set_active_port "${NS2}" test_team2 eth0
+
+	did_interface_receive eth0 "${NS2}"
+	check_err $? "eth0 not transmitting when enabled"
+	did_interface_receive eth1 "${NS2}"
+	check_fail $? "eth1 IS transmitting when disabled"
+
+	log_test "teamd active backup runner test"
+
+	stop_sending_and_listening
+}
+
+require_command teamd
+require_command teamdctl
+require_command iperf3
+environment_create activebackup
+tests_run
+exit "${EXIT_STATUS}"
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index b40694573f4c..992342b1dd7c 100644
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
+		ip netns exec "${ns}" bash -c "$@"
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
2.53.0.1118.gaef5881109-goog


