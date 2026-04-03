Return-Path: <netdev+bounces-274911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOmfDrBpz2lPwAYAu9opvQ
	(envelope-from <netdev+bounces-274911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:18:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D84E391A89
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78CDE309DB56
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C867E3822A9;
	Fri,  3 Apr 2026 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tqzRKvC1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205B37FF76
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775200479; cv=none; b=h0FpI9FTfttHBx2eKFb6KOMs53RMgVykrnh09huUJZOwM5Vsy4MCqNAmW0pZUjuNQwN6mOu4+9ai/BQDKTZQKOWQC6cjcVyVxUnrCIedOyMIFbwChaj5euMCgWaH+Y5nujrIg06VyozboKtn4QqDfY4NFhf5uRyOEQOPnxjp7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775200479; c=relaxed/simple;
	bh=B1CUHr6cyj7dXHUCHEQXJx2KVZ46yecg3Gc0EUFXTkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uN24JJXqE3SpD+yukT3v1MLhEt0+ycKRYwZqPl80xTZnHdq4r7eHEgzv2Tdp3Yy/emKddjRmPgjRwrrZaMqeRZoOoUhT/Ct9i42CUbukujCeCDARfXt2V70AgtZQnC9xqhWFw244J/Mp194SHieMXavJlpJTae7HxUDkJL1LpzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tqzRKvC1; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1279caef718so2790895c88.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775200477; x=1775805277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dHW/Kj+WoZEi+6uAOeMCAmInrznHjYR3guz1LxHCc1k=;
        b=tqzRKvC1KIhIFCvatxs4ZroZFiqLpXMBqDnEr6EuQPVKG3DWKZpKw0rguFfFE1M8zk
         lh3cWL4ARsb6HGrtXUbY0GWKIsQiHkx68O3HoSInaf0tSyj6THOS4T2Q661XdKSZ6Dv/
         MLnGzYZc8inQuLdPoSRurOrpe5/GxcJf/myr5xCH4s66cQQ7erc8Yc7mVxEO/rROABii
         Jch14tvfSx5zdvIEy4VQ4yFRVooJR+lIbcoKQJF39VlFcHJ8H6oQwZ/Jf5+KWnXgmDGj
         bhC8dwKSMclmX+BzxSVEc9kbD5Pug/YVJpG8Ufqy24eANhe2xbQ/NLVgnLuGMvBfhfLD
         0w8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775200477; x=1775805277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHW/Kj+WoZEi+6uAOeMCAmInrznHjYR3guz1LxHCc1k=;
        b=i97Fb4LQ9AlWXOTgk0hKMP1O8yYcbPfn0D83QOlap/QfxK2hKiBb8VABy3cajhMnMd
         rvt+LuCbIfhCAdn4EeXtLzGqQ0JlimVRJsz6CSNk2M7QHMbheVBHmUoTq3Bv3j2EwfZ7
         M3+wwPkxjihUlfs79DmUH3VE5pqwvoOJnu8IR9VRT1oe7KpXsXFXoenoQmPUJTk6gX9l
         zL0m0qwXRO2WR3u19iq2PpaYmDXv713LxVpWgRYgQJt97FrjsKYpr9190pp3w7R3FDbt
         7EVky8x9QWMG2j2HQA2/QsVBSGfgkr+7pn+9Pd1DkwyEv/nSbO4InHcg+aeblHxYm48e
         yHuQ==
X-Gm-Message-State: AOJu0Yz/0+oxxPP6DPf9652H+50YeA0mlWodrotbZvZYNckVeQDAAreC
	B3pFaPzVAFC5pwf8uMUa0jUkf+Ck2zsbhBzwyp4jFig2UhlJUL/dFDugObTnwrUm6l7lcG9DjWN
	GFqR85kyPTTv1OTvkhkoivw==
X-Received: from dlak22.prod.google.com ([2002:a05:701b:2916:b0:12a:6d14:dfd9])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:929:b0:127:380e:ff5a with SMTP id a92af1059eb24-12bfb73e31emr956624c88.17.1775200477366;
 Fri, 03 Apr 2026 00:14:37 -0700 (PDT)
Date: Fri, 03 Apr 2026 07:14:26 +0000
In-Reply-To: <20260403-teaming-driver-internal-v4-0-d3032f33ca25@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403-teaming-driver-internal-v4-0-d3032f33ca25@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775200467; l=8380;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=B1CUHr6cyj7dXHUCHEQXJx2KVZ46yecg3Gc0EUFXTkI=; b=ozbwprojtwD9UJ4SvW3+EeQNlfHACJyBaWnDTI1Bp4UBwSkOTk+KL+z4Ki3uJB40h9XI36TUQ
 BhBuSjCOeJHDZbVJ0cYT4xQcRHDySEAKLq7LslClR8uvKsWTph8UVx/
X-Mailer: b4 0.14.3
Message-ID: <20260403-teaming-driver-internal-v4-5-d3032f33ca25@google.com>
Subject: [PATCH net-next v4 05/10] selftests: net: Add test for enablement of
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274911-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9D84E391A89
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
Changes in v4:
- None

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
 .../drivers/net/team/teamd_activebackup.sh         | 217 +++++++++++++++++++++
 tools/testing/selftests/net/lib.sh                 |  13 ++
 3 files changed, 231 insertions(+)

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
index 000000000000..aa882e1ee3d8
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/teamd_activebackup.sh
@@ -0,0 +1,217 @@
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
+	if [ -n "${NS1_TEAMD_PID}" ]; then
+		kill -9 "${NS1_TEAMD_PID}" 2>/dev/null
+	fi
+	if [ -n "${NS2_TEAMD_PID}" ]; then
+		kill -9 "${NS2_TEAMD_PID}" 2>/dev/null
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
index e915386daf1b..8efa782dd4fd 100644
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
2.53.0.1185.g05d4b7b318-goog


