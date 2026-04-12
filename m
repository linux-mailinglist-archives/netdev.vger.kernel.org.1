Return-Path: <netdev+bounces-277925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FSorH2Ia3GkCMwkAu9opvQ
	(envelope-from <netdev+bounces-277925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:19:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CE03E6435
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF9AA3015D01
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE28031F9B8;
	Sun, 12 Apr 2026 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="g0hkolKi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEA7322C67
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 22:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776031896; cv=none; b=ux0zswSuDcIR0Wq/0BSmKARs9Czr2v41EBsANDyyYKnImWbqzn9ar6DUpBeSGf6KnI5qSjYNstYEasC3LknHSONEkDzuKgiaJ9+4Uvdtbu7wVYgwztm2n//S2qXftea0mInsPw+hfcEO6JBZVH2hXAO3qn5Z5Zl4JJmhG5ZicX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776031896; c=relaxed/simple;
	bh=/Lix1GFScXwznXjLS7mBs69E5IUqkqLug8d6r1W92pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayJJt75vZIaBlBbQJtazpL+cimjUYiBsAfrrOno1MOO66miivBBpgbK05TPmdqasrPh9kF7EHQzb8anJCePNk0ys6UFp571FgNMpK47YfW/fmuHp7bQ/cqWpZSpppZFjC2WDQmoXgwkyANSkAaps2DTtQbLbl8p8Z97XF/1L9mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=g0hkolKi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so61195435e9.2
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776031892; x=1776636692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhNQT6Dsr1LUaUqeKz8mpRPxderRssnhuFWM0eUbBy0=;
        b=g0hkolKi1XDDDiFDYtDSPfdT+Os562oTX5+GBSil6zhmO78if+TAOsR/tXXUOCbpkp
         9PUqn3BcAGOppp5YkOtBlmZ6JPDuEDLPqH2sGAwBYwpk2VbNCGzVz1zRvW6cOAh4x2Vp
         s8Qq/efMGov5VS2TEPiyErJA9hlJe58FXQpZ+UARgfeBWf9PB3XCLcX183t8XZaBq4Jz
         snfZTScIg+5yPb4iTGHOqlXJuHNtPFcshYZtb8M1nflq8BGJjELF0xDtDRIfS9nK9vtX
         RWDsUTjl8Kn2CyUCukkWwyawlXpM0sfwQquHWP9dnx/IS3IMCaPZzahsfEBG35qG1QLl
         1IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776031892; x=1776636692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LhNQT6Dsr1LUaUqeKz8mpRPxderRssnhuFWM0eUbBy0=;
        b=LmXs8yCRdEgjvCSDxD/WA5HcHb6bzGWsTNhjNnTkil33K2FBdFmSOHjtaQHH1uZoDO
         QwY9KssFDOmFATzyKIbGupYAvDlmUmxfIgSp/LaM+Qjoy3XIB151CzU/C32/VuxHAFdE
         ibON21DxK57H3afX9WRcoFnvkHbjVfTfoTeSgtg24jztfAMdgFVHd09QuTjWqXO68TNg
         BCi2Etu7t8lg131LJFfeIAGF+8UhonbqtBxN01w/s0s3lOprc5xGXshHuJkmGNp+lcPw
         K+f+rKsJtjpQn8Se8tvuOSyA9RHfffc2xwwsUiqNWZZcTQ4BzncNBXkORqb5hqBKr+GH
         yuYQ==
X-Gm-Message-State: AOJu0Yx/YCCa7+yTdJU0RLQ77yzw8OeImZLP0HGIwh0wUME48oVu6vby
	/l3nMw7kUEH4+cPGMd6qC4fN5LpuT1IFyUMXzCZMx9gpZUxdTCHndjha/sxCzKtPBlpKZ9eRcQK
	IepaAddEj858AkdeftIkCBt98NusIKt3nOpiwufTqlqhzJZ73L99Qz2Z8RKyb1duY
X-Gm-Gg: AeBDiesOR7kYqDdmi3NiDDjRA8ZudZ9ac423BYace8A63iEkLsQz8/yS8I72EDZ+aOK
	HnPEImLhjgKQxOJ4u0A00SuisLYY1/vfBjDBTVxzCUDw8LZq+jfS4HMmagwj62bsg43SZWFThZL
	5bpVxyrVe1cnyqMcVJDj1um+8pZzbIWUOGhW87v6kWdgUHZ7dxjEYclB+FtJkT+r38rWeP6nJhG
	SoLq0ZwUEQQXa9kOkvG/2l7m0fMpSwXU2Dvww2Rqk1E54m2VdABCAyDxWwFyqs4xMxpQVuVzxvv
	vstvTiuSPs//CZnmw/otkjJ5GslekFP/31eXTrRrOJsjnqw18f3Nz5965mhWaECLGdJCzJmxteY
	kIJbhgPeWSynKSnEPyaXIOkG/Xvum9tweifPpUaHxF6QFQ6WMGPf9FvkiV5LqZbw93PDl/6i6ab
	j5WJ9CDSkH02yRfIMHTFd0g8dLVW1xK6QrxOQm2BOe0vQwp5M=
X-Received: by 2002:a05:600c:45ce:b0:485:3e19:9e01 with SMTP id 5b1f17b1804b1-488d6890c9dmr155005115e9.28.1776031891905;
        Sun, 12 Apr 2026 15:11:31 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:e36b:fb32:ad41:43a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d70891sm84910805e9.2.2026.04.12.15.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 15:11:31 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 5/5] selftests: ovpn: align command flow with TAP
Date: Mon, 13 Apr 2026 00:11:21 +0200
Message-ID: <20260412221121.410365-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260412221121.410365-1-antonio@openvpn.net>
References: <20260412221121.410365-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [10.34 / 15.00];
	URIBL_BLACK(7.50)[common.sh:url];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277925-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[openvpn.net:s=google];
	GREYLIST(0.00)[pass,body];
	DMARC_POLICY_ALLOW(0.00)[openvpn.net,none];
	DKIM_TRACE(0.00)[openvpn.net:+];
	NEURAL_SPAM(0.00)[0.049];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mandelbit.com:email,common.sh:url,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid]
X-Rspamd-Queue-Id: A0CE03E6435
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

From: Ralf Lici <ralf@mandelbit.com>

Restructure ovpn selftests into using the TAP infrastructure: split each
test in stages, execute stage bodies with fail-fast semantics, and emit
KTAP pass/fail for each stage.

Centralize behavior control in common.sh and makes the scripts use
dedicated wrappers for required-success, expected-failure, and non-fatal
commands. Also add the OVPN_VERBOSE mode that exposes captured command
output for debugging.
This way tests won't hang anymore in case of failure when executed
within the CI machinery.

This change also makes default OVPN_CLI and YNL_CLI resolution
independent from the caller CWD by anchoring both to COMMON_DIR, so
behavior is stable across direct execution and run_tests-style
execution.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/common.sh    | 168 ++++++-
 .../selftests/net/ovpn/test-close-socket.sh   |  81 +++-
 tools/testing/selftests/net/ovpn/test-mark.sh | 219 +++++----
 tools/testing/selftests/net/ovpn/test.sh      | 415 ++++++++++++------
 4 files changed, 624 insertions(+), 259 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2b3f2e5c8cc9..ec6fea37ceb3 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -4,14 +4,18 @@
 #
 #  Author:	Antonio Quartulli <antonio@openvpn.net>
 
+OVPN_COMMON_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
+source "$OVPN_COMMON_DIR/../../kselftest/ktap_helpers.sh"
+
 OVPN_UDP_PEERS_FILE=${OVPN_UDP_PEERS_FILE:-udp_peers.txt}
 OVPN_TCP_PEERS_FILE=${OVPN_TCP_PEERS_FILE:-tcp_peers.txt}
-OVPN_CLI=${OVPN_CLI:-./ovpn-cli}
-OVPN_YNL_CLI=${OVPN_YNL_CLI:-../../../../net/ynl/pyynl/cli.py}
+OVPN_CLI=${OVPN_CLI:-${OVPN_COMMON_DIR}/ovpn-cli}
+OVPN_YNL_CLI=${OVPN_YNL_CLI:-${OVPN_COMMON_DIR}/../../../../net/ynl/pyynl/cli.py}
 OVPN_ALG=${OVPN_ALG:-aes}
 OVPN_PROTO=${OVPN_PROTO:-UDP}
 OVPN_FLOAT=${OVPN_FLOAT:-0}
 OVPN_SYMMETRIC_ID=${OVPN_SYMMETRIC_ID:-0}
+OVPN_VERBOSE=${OVPN_VERBOSE:-0}
 
 export OVPN_ID_OFFSET=$(( 9 * (OVPN_SYMMETRIC_ID == 0) ))
 
@@ -22,6 +26,110 @@ OVPN_LAN_IP="11.11.11.11"
 
 declare -A OVPN_TMP_JSONS=()
 declare -A OVPN_LISTENER_PIDS=()
+OVPN_CURRENT_STAGE=""
+
+ovpn_is_verbose() {
+	[[ "${OVPN_VERBOSE}" == "1" ]]
+}
+
+ovpn_log() {
+	ovpn_is_verbose || return 0
+	printf '%s\n' "$*"
+}
+
+ovpn_print_cmd_output() {
+	local output_file="$1"
+	local line
+
+	[[ -s "${output_file}" ]] || return 0
+
+	while IFS= read -r line; do
+		ovpn_log "${line}"
+	done < "${output_file}"
+}
+
+ovpn_cmd_run() {
+	local mode="$1"
+	local label="$2"
+	local output_file
+	local rc
+	local ret=0
+
+	shift 2
+
+	output_file=$(mktemp)
+	if "$@" >"${output_file}" 2>&1; then
+		rc=0
+	else
+		rc=$?
+	fi
+
+	case "${mode}" in
+	ok)
+		if [[ "${rc}" -ne 0 ]]; then
+			cat "${output_file}"
+			printf '%s\n' "${label}: command failed with rc=${rc}: $*"
+			ret="${rc}"
+		fi
+		;;
+	mayfail)
+		;;
+	fail)
+		[[ "${rc}" -eq 0 ]] && ret=1
+		;;
+	esac
+
+	if ovpn_is_verbose && [[ "${rc}" -eq 0 || "${mode}" != "ok" ]]; then
+		ovpn_print_cmd_output "${output_file}"
+	fi
+
+	rm -f "${output_file}"
+	return "${ret}"
+}
+
+ovpn_cmd_ok() {
+	ovpn_cmd_run ok "$@"
+}
+
+ovpn_cmd_mayfail() {
+	ovpn_cmd_run mayfail "$@"
+}
+
+ovpn_cmd_fail() {
+	ovpn_cmd_run fail "$@"
+}
+
+ovpn_run_bg() {
+	local pid_var="$1"
+
+	shift
+	if ovpn_is_verbose; then
+		"$@" &
+	else
+		"$@" >/dev/null 2>&1 &
+	fi
+
+	printf -v "${pid_var}" '%s' "$!"
+}
+
+ovpn_run_stage() {
+	local label="$1"
+
+	shift
+	OVPN_CURRENT_STAGE="${label}"
+	"$@"
+	OVPN_CURRENT_STAGE=""
+	ktap_test_pass "${label}"
+}
+
+ovpn_stage_err() {
+	# ERR trap is global under set -eE: only report failures that happen
+	# while ovpn_run_stage() is actively executing a stage body.
+	if [[ -n "${OVPN_CURRENT_STAGE}" ]]; then
+		ktap_test_fail "${OVPN_CURRENT_STAGE}"
+		OVPN_CURRENT_STAGE=""
+	fi
+}
 
 ovpn_create_ns() {
 	ip netns add peer${1}
@@ -78,11 +186,14 @@ ovpn_build_capture_filter() {
 }
 
 ovpn_setup_listener() {
+	local peer="$1"
+	local file
+
 	file=$(mktemp)
-	PYTHONUNBUFFERED=1 ip netns exec peer${p} ${OVPN_YNL_CLI} --family ovpn \
-		--subscribe peers --output-json --duration 40 > ${file} &
-	OVPN_LISTENER_PIDS[$1]=$!
-	OVPN_TMP_JSONS[$1]="${file}"
+	PYTHONUNBUFFERED=1 ip netns exec "peer${peer}" "${OVPN_YNL_CLI}" --family ovpn \
+		--subscribe peers --output-json --duration 40 > "${file}" 2>/dev/null &
+	OVPN_LISTENER_PIDS["${peer}"]=$!
+	OVPN_TMP_JSONS["${peer}"]="${file}"
 }
 
 ovpn_add_peer() {
@@ -152,8 +263,8 @@ ovpn_compare_ntfs() {
 		received="${OVPN_TMP_JSONS[$1]}"
 		diff_file=$(mktemp)
 
-		kill -TERM ${OVPN_LISTENER_PIDS[$1]} || true
-		wait ${OVPN_LISTENER_PIDS[$1]} || true
+		kill -TERM ${OVPN_LISTENER_PIDS[$1]} 2>/dev/null || true
+		wait ${OVPN_LISTENER_PIDS[$1]} 2>/dev/null || true
 		printf "Checking notifications for peer ${1}... "
 		if diff <(jq -s "${OVPN_JQ_FILTER}" ${expected}) \
 			<(jq -s "${OVPN_JQ_FILTER}" ${received}) >"${diff_file}" 2>&1; then
@@ -171,20 +282,49 @@ ovpn_compare_ntfs() {
 	return "${diff_rc}"
 }
 
+ovpn_stop_listener() {
+	local peer="$1"
+	local pid="${OVPN_LISTENER_PIDS[$peer]:-}"
+	local json="${OVPN_TMP_JSONS[$peer]:-}"
+
+	if [[ -n "${pid}" ]]; then
+		kill -TERM "${pid}" 2>/dev/null || true
+		wait "${pid}" 2>/dev/null || true
+		unset "OVPN_LISTENER_PIDS[$peer]"
+	fi
+
+	if [[ -n "${json}" ]]; then
+		rm -f "${json}" || true
+		unset "OVPN_TMP_JSONS[$peer]"
+	fi
+}
+
+ovpn_cleanup_peer_ns() {
+	local peer="$1"
+
+	if ! ip netns list | grep -qx "${peer}"; then
+		return 0
+	fi
+
+	ip -n "${peer}" link set tun${peer#peer} down 2>/dev/null || true
+	ip netns exec "${peer}" ${OVPN_CLI} del_iface tun${peer#peer} \
+		1>/dev/null 2>&1 || true
+	ip netns del "${peer}" 2>/dev/null || true
+}
+
 ovpn_cleanup() {
 	# some ovpn-cli processes sleep in background so they need manual poking
-	killall $(basename ${OVPN_CLI}) 2>/dev/null || true
+	killall "$(basename "${OVPN_CLI}")" 2>/dev/null || true
 
-	# netns peer0 is deleted without erasing ifaces first
-	for p in $(seq 1 10); do
-		ip -n peer${p} link set tun${p} down 2>/dev/null || true
-		ip netns exec peer${p} ${OVPN_CLI} del_iface tun${p} 2>/dev/null || true
+	for peer in "${!OVPN_LISTENER_PIDS[@]}"; do
+		ovpn_stop_listener "${peer}" 2>/dev/null
 	done
+
 	for p in $(seq 1 10); do
 		ip -n peer0 link del veth${p} 2>/dev/null || true
 	done
 	for p in $(seq 0 10); do
-		ip netns del peer${p} 2>/dev/null || true
+		ovpn_cleanup_peer_ns "peer${p}" 2>/dev/null
 	done
 }
 
diff --git a/tools/testing/selftests/net/ovpn/test-close-socket.sh b/tools/testing/selftests/net/ovpn/test-close-socket.sh
index 4f0367c60fda..e97affe72738 100755
--- a/tools/testing/selftests/net/ovpn/test-close-socket.sh
+++ b/tools/testing/selftests/net/ovpn/test-close-socket.sh
@@ -9,37 +9,72 @@ set -e
 
 source ./common.sh
 
-ovpn_cleanup
+ovpn_test_finished=0
 
-modprobe -q ovpn || true
+ovpn_test_exit() {
+	ovpn_cleanup
+	modprobe -r ovpn || true
+
+	if [ "${ovpn_test_finished}" -eq 0 ]; then
+		ktap_print_totals
+	fi
+}
+
+ovpn_prepare_network() {
+	local p
+
+	for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "create namespace peer${p}" ovpn_create_ns "${p}"
+	done
 
-for p in $(seq 0 ${OVPN_NUM_PEERS}); do
-	ovpn_create_ns ${p}
-done
+	for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "configure peer${p} namespace" ovpn_setup_ns "${p}" \
+			5.5.5.$((p + 1))/24
+	done
 
-for p in $(seq 0 ${OVPN_NUM_PEERS}); do
-	ovpn_setup_ns ${p} 5.5.5.$((${p} + 1))/24
-done
+	for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "register peer${p} in overlay" ovpn_add_peer "${p}"
+	done
 
-for p in $(seq 0 ${OVPN_NUM_PEERS}); do
-	ovpn_add_peer ${p}
-done
+	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "set peer0 timeout for peer ${p}" \
+			ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
+		ovpn_cmd_ok "set peer${p} timeout for peer ${p}" \
+			ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} \
+				$((p + OVPN_ID_OFFSET)) 60 120
+	done
+}
 
-for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
-	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} $((${p}+9)) 60 120
-done
+ovpn_run_ping_traffic() {
+	local p
 
-sleep 1
+	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "send ping traffic to peer ${p}" \
+			ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((p + 1))
+	done
+}
 
-for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-	ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((${p} + 1))
-done
+ovpn_run_iperf() {
+	local iperf_pid
 
-ip netns exec peer0 iperf3 -1 -s &
-sleep 1
-ip netns exec peer1 iperf3 -Z -t 3 -c 5.5.5.1
+	ovpn_run_bg iperf_pid ip netns exec peer0 iperf3 -1 -s
+	sleep 1
+	ovpn_cmd_ok "run iperf throughput flow" \
+		ip netns exec peer1 iperf3 -Z -t 3 -c 5.5.5.1
+	wait "${iperf_pid}" || return 1
+}
+
+trap ovpn_test_exit EXIT
+
+ktap_print_header
+ktap_set_plan 3
 
 ovpn_cleanup
+modprobe -q ovpn || true
+
+ovpn_run_stage "setup network topology" ovpn_prepare_network
+ovpn_run_stage "run ping traffic" ovpn_run_ping_traffic
+ovpn_run_stage "run iperf throughput" ovpn_run_iperf
 
-modprobe -r ovpn || true
+ovpn_test_finished=1
+ktap_finished
diff --git a/tools/testing/selftests/net/ovpn/test-mark.sh b/tools/testing/selftests/net/ovpn/test-mark.sh
index 951baf2ad736..ba2443fbd49f 100755
--- a/tools/testing/selftests/net/ovpn/test-mark.sh
+++ b/tools/testing/selftests/net/ovpn/test-mark.sh
@@ -6,91 +6,152 @@
 #		Antonio Quartulli <antonio@openvpn.net>
 
 #set -x
-set -e
+set -eE
 
 MARK=1056
+MARK_DROP_COUNTER=0
 
 source ./common.sh
 
-ovpn_cleanup
+ovpn_test_finished=0
+
+ovpn_test_exit() {
+	ovpn_cleanup
+	modprobe -r ovpn || true
+
+	if [ "${ovpn_test_finished}" -eq 0 ]; then
+		ktap_print_totals
+	fi
+}
+
+ovpn_mark_prepare_network() {
+	local p
+
+	for p in $(seq 0 "${OVPN_NUM_PEERS}"); do
+		ovpn_cmd_ok "create namespace peer${p}" ovpn_create_ns "${p}"
+	done
+
+	for p in $(seq 0 3); do
+		ovpn_cmd_ok "configure peer${p} namespace" ovpn_setup_ns "${p}" \
+			5.5.5.$((p + 1))/24
+	done
+
+	ovpn_cmd_ok "create server-side multi-peer with fwmark" \
+		ip netns exec peer0 "${OVPN_CLI}" new_multi_peer tun0 1 ASYMM \
+			"${OVPN_UDP_PEERS_FILE}" "${MARK}"
+	for p in $(seq 1 3); do
+		ovpn_cmd_ok "install server key for peer ${p}" \
+			ip netns exec peer0 "${OVPN_CLI}" new_key tun0 "${p}" \
+				1 0 "${OVPN_ALG}" 0 data64.key
+	done
+
+	for p in $(seq 1 3); do
+		ovpn_cmd_ok "register peer${p} in overlay" ovpn_add_peer "${p}"
+	done
+
+	for p in $(seq 1 3); do
+		ovpn_cmd_ok "set peer0 timeout for peer ${p}" \
+			ip netns exec peer0 "${OVPN_CLI}" set_peer tun0 "${p}" 60 120
+		ovpn_cmd_ok "set peer${p} timeout for peer ${p}" \
+			ip netns exec peer"${p}" "${OVPN_CLI}" set_peer tun"${p}" \
+				$((p + OVPN_ID_OFFSET)) 60 120
+	done
+}
+
+ovpn_mark_run_baseline_traffic() {
+	local p
+
+	for p in $(seq 1 3); do
+		ovpn_cmd_ok "send baseline traffic to peer ${p}" \
+			ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((p + 1))
+	done
+}
+
+ovpn_mark_add_drop_rule() {
+	ovpn_log "Adding an nftables drop rule based on mark value ${MARK}"
+
+	ovpn_cmd_ok "flush nft ruleset" ip netns exec peer0 nft flush ruleset
+	ovpn_cmd_ok "create nft filter table" ip netns exec peer0 nft "add table inet filter"
+	ovpn_cmd_ok "create nft filter output chain" \
+		ip netns exec peer0 nft "add chain inet filter output { type filter hook output \
+			priority 0; policy accept; }"
+	ovpn_cmd_ok "add nft drop rule for mark ${MARK}" \
+		ip netns exec peer0 nft add rule inet filter output \
+			meta mark == "${MARK}" \
+			counter drop
+
+	MARK_DROP_COUNTER=$(ip netns exec peer0 nft list chain inet filter output \
+		| sed -n 's/.*packets \([0-9]*\).*/\1/p')
+	if [ -z "${MARK_DROP_COUNTER}" ]; then
+		printf '%s\n' "unable to read nft drop counter"
+		return 1
+	fi
+}
+
+ovpn_mark_verify_drop_traffic() {
+	local p
+	local ping_output
+	local lost_packets
+	local total_count
+
+	for p in $(seq 1 3); do
+		if ping_output=$(ip netns exec peer0 ping -qfc 500 -w 1 \
+			5.5.5.$((p + 1)) 2>&1); then
+			printf '%s\n' "expected ping to peer ${p} to fail after nft drop rule"
+			return 1
+		fi
+		ovpn_log "${ping_output}"
+		lost_packets=$(echo "${ping_output}" | awk '/packets transmitted/ { print $1 }')
+		if [ -z "${lost_packets}" ]; then
+			printf '%s\n' "unable to parse lost packets for peer ${p}"
+			return 1
+		fi
+		MARK_DROP_COUNTER=$((MARK_DROP_COUNTER + lost_packets))
+	done
+
+	total_count=$(ip netns exec peer0 nft list chain inet filter output \
+		| sed -n 's/.*packets \([0-9]*\).*/\1/p')
+	if [ -z "${total_count}" ]; then
+		printf '%s\n' "unable to read final nft drop counter"
+		return 1
+	fi
+	if [ "${MARK_DROP_COUNTER}" -ne "${total_count}" ]; then
+		printf '%s\n' "expected ${MARK_DROP_COUNTER} drops, got ${total_count}"
+		return 1
+	fi
+}
+
+ovpn_mark_remove_drop_rule() {
+	ovpn_log "Removing the drop rule"
+
+	ovpn_cmd_ok "flush nft ruleset" ip netns exec peer0 nft flush ruleset
+}
+
+ovpn_mark_verify_traffic_recovery() {
+	local p
+
+	sleep 1
+	for p in $(seq 1 3); do
+		ovpn_cmd_ok "send recovery traffic to peer ${p}" \
+			ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((p + 1))
+	done
+}
+
+trap ovpn_test_exit EXIT
+trap ovpn_stage_err ERR
+
+ktap_print_header
+ktap_set_plan 6
 
+ovpn_cleanup
 modprobe -q ovpn || true
 
-for p in $(seq 0 "${OVPN_NUM_PEERS}"); do
-	ovpn_create_ns "${p}"
-done
-
-for p in $(seq 0 3); do
-	ovpn_setup_ns "${p}" 5.5.5.$((p + 1))/24
-done
-
-# add peer0 with mark
-ip netns exec peer0 "${OVPN_CLI}" new_multi_peer tun0 1 ASYMM \
-	"${OVPN_UDP_PEERS_FILE}" \
-	${MARK}
-for p in $(seq 1 3); do
-	ip netns exec peer0 "${OVPN_CLI}" new_key tun0 "${p}" 1 0 "${OVPN_ALG}" 0 \
-		data64.key
-done
-
-for p in $(seq 1 3); do
-	ovpn_add_peer "${p}"
-done
-
-for p in $(seq 1 3); do
-	ip netns exec peer0 "${OVPN_CLI}" set_peer tun0 "${p}" 60 120
-	ip netns exec peer"${p}" "${OVPN_CLI}" set_peer tun"${p}" \
-		$((p + 9)) 60 120
-done
-
-sleep 1
-
-for p in $(seq 1 3); do
-	ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((p + 1))
-done
-
-echo "Adding an nftables drop rule based on mark value ${MARK}"
-ip netns exec peer0 nft flush ruleset
-ip netns exec peer0 nft 'add table inet filter'
-ip netns exec peer0 nft 'add chain inet filter output {
-	type filter hook output priority 0;
-	policy accept;
-}'
-ip netns exec peer0 nft add rule inet filter output \
-	meta mark == ${MARK} \
-	counter drop
-
-DROP_COUNTER=$(ip netns exec peer0 nft list chain inet filter output \
-	| sed -n 's/.*packets \([0-9]*\).*/\1/p')
-sleep 1
-
-# ping should fail
-for p in $(seq 1 3); do
-	PING_OUTPUT=$(ip netns exec peer0 ping \
-		-qfc 500 -w 1 5.5.5.$((p + 1)) 2>&1) && exit 1
-	echo "${PING_OUTPUT}"
-	LOST_PACKETS=$(echo "$PING_OUTPUT" \
-		| awk '/packets transmitted/ { print $1 }')
-	# increment the drop counter by the amount of lost packets
-	DROP_COUNTER=$((DROP_COUNTER + LOST_PACKETS))
-done
-
-# check if the final nft counter matches our counter
-TOTAL_COUNT=$(ip netns exec peer0 nft list chain inet filter output \
-	| sed -n 's/.*packets \([0-9]*\).*/\1/p')
-if [ "${DROP_COUNTER}" -ne "${TOTAL_COUNT}" ]; then
-	echo "Expected ${TOTAL_COUNT} drops, got ${DROP_COUNTER}"
-	exit 1
-fi
-
-echo "Removing the drop rule"
-ip netns exec peer0 nft flush ruleset
-sleep 1
-
-for p in $(seq 1 3); do
-	ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((p + 1))
-done
-
-ovpn_cleanup
+ovpn_run_stage "setup marked network topology" ovpn_mark_prepare_network
+ovpn_run_stage "run baseline traffic" ovpn_mark_run_baseline_traffic
+ovpn_run_stage "install nft mark drop rule" ovpn_mark_add_drop_rule
+ovpn_run_stage "drop marked traffic and count packets" ovpn_mark_verify_drop_traffic
+ovpn_run_stage "remove nft drop rule" ovpn_mark_remove_drop_rule
+ovpn_run_stage "traffic recovers after drop removal" ovpn_mark_verify_traffic_recovery
 
-modprobe -r ovpn || true
+ovpn_test_finished=1
+ktap_finished
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 3a826d070742..4e5e874fdcee 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -5,161 +5,290 @@
 #  Author:	Antonio Quartulli <antonio@openvpn.net>
 
 #set -x
-set -e
+set -eE
 
 source ./common.sh
 
-ovpn_cleanup
+ovpn_test_finished=0
 
-modprobe -q ovpn || true
+ovpn_test_exit() {
+	ovpn_cleanup
+	modprobe -r ovpn || true
 
-for p in $(seq 0 ${OVPN_NUM_PEERS}); do
-	ovpn_create_ns ${p}
-done
-
-for p in $(seq 0 ${OVPN_NUM_PEERS}); do
-	ovpn_setup_listener ${p}
-done
-
-for p in $(seq 0 ${OVPN_NUM_PEERS}); do
-	ovpn_setup_ns ${p} 5.5.5.$((${p} + 1))/24 ${MTU}
-done
-
-for p in $(seq 0 ${OVPN_NUM_PEERS}); do
-	ovpn_add_peer ${p}
-done
-
-for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
-	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} \
-		$((${p}+OVPN_ID_OFFSET)) 60 120
-done
-
-sleep 1
-
-TCPDUMP_TIMEOUT="1.5s"
-for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-	# The first part of the data packet header consists of:
-	# - TCP only: 2 bytes for the packet length
-	# - 5 bits for opcode ("9" for DATA_V2)
-	# - 3 bits for key-id ("0" at this point)
-	# - 12 bytes for peer-id:
-	#     - with asymmetric ID: "${p}" one way and "${p} + 9" the other way
-	#     - with symmetric ID: "${p}" both ways
-	HEADER1=$(printf "0x4800000%x" ${p})
-	HEADER2=$(printf "0x4800000%x" $((${p} + OVPN_ID_OFFSET)))
-	RADDR=""
-	if [ "${OVPN_PROTO}" == "UDP" ]; then
-		RADDR=$(awk "NR == ${p} {print \$3}" ${OVPN_UDP_PEERS_FILE})
+	if [ "${ovpn_test_finished}" -eq 0 ]; then
+		ktap_print_totals
 	fi
+}
+
+ovpn_prepare_network() {
+	local p
+
+	for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "create namespace peer${p}" ovpn_create_ns "${p}"
+	done
+
+	for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "start notification listener peer${p}" \
+			ovpn_setup_listener "${p}"
+	done
+
+	for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "configure peer${p} namespace" ovpn_setup_ns "${p}" \
+			5.5.5.$((p + 1))/24 "${MTU}"
+	done
+
+	for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "register peer${p} in overlay" ovpn_add_peer "${p}"
+	done
 
-	timeout ${TCPDUMP_TIMEOUT} ip netns exec peer${p} \
-		tcpdump --immediate-mode -p -ni veth${p} -c 1 \
-		"$(ovpn_build_capture_filter "${HEADER1}" "${RADDR}")" \
-		>/dev/null 2>&1 &
-	TCPDUMP_PID1=$!
-	timeout ${TCPDUMP_TIMEOUT} ip netns exec peer${p} \
-		tcpdump --immediate-mode -p -ni veth${p} -c 1 \
-		"$(ovpn_build_capture_filter "${HEADER2}" "${RADDR}")" \
-		>/dev/null 2>&1 &
-	TCPDUMP_PID2=$!
-
-	sleep 0.3
-	ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((${p} + 1))
-	ip netns exec peer0 ping -qfc 500 -s 3000 -w 3 5.5.5.$((${p} + 1))
-
-	wait ${TCPDUMP_PID1}
-	wait ${TCPDUMP_PID2}
-done
-
-# ping LAN behind client 1
-ip netns exec peer0 ping -qfc 500 -w 3 ${OVPN_LAN_IP}
-
-if [ "$OVPN_FLOAT" == "1" ]; then
-	# make clients float..
 	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-		ip -n peer${p} addr del 10.10.${p}.2/24 dev veth${p}
-		ip -n peer${p} addr add 10.10.${p}.3/24 dev veth${p}
+		ovpn_cmd_ok "set peer0 timeout for peer ${p}" \
+			ip netns exec peer0 ${OVPN_CLI} set_peer tun0 \
+				${p} 60 120
+		ovpn_cmd_ok "set peer${p} timeout for peer ${p}" \
+			ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} \
+				$((p + OVPN_ID_OFFSET)) 60 120
 	done
+}
+
+ovpn_run_basic_traffic() {
+	local p
+	local header1
+	local header2
+	local raddr
+	local tcpdump_pid1
+	local tcpdump_pid2
+	local tcpdump_timeout="1.5s"
+
 	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-		ip netns exec peer${p} ping -qfc 500 -w 3 5.5.5.1
+		# The first part of the data packet header consists of:
+		# - TCP only: 2 bytes for the packet length
+		# - 5 bits for opcode ("9" for DATA_V2)
+		# - 3 bits for key-id ("0" at this point)
+		# - 12 bytes for peer-id:
+		#     - with asymmetric ID: "${p}" one way and "${p} + 9" the other way
+		#     - with symmetric ID: "${p}" both ways
+		header1=$(printf "0x4800000%x" ${p})
+		header2=$(printf "0x4800000%x" $((p + OVPN_ID_OFFSET)))
+		raddr=""
+		if [ "${OVPN_PROTO}" == "UDP" ]; then
+			raddr=$(awk "NR == ${p} {print \$3}" "${OVPN_UDP_PEERS_FILE}")
+		fi
+
+		timeout ${tcpdump_timeout} ip netns exec peer${p} \
+			tcpdump --immediate-mode -p -ni veth${p} -c 1 \
+			"$(ovpn_build_capture_filter "${header1}" "${raddr}")" \
+			>/dev/null 2>&1 &
+		tcpdump_pid1=$!
+		timeout ${tcpdump_timeout} ip netns exec peer${p} \
+			tcpdump --immediate-mode -p -ni veth${p} -c 1 \
+			"$(ovpn_build_capture_filter "${header2}" "${raddr}")" \
+			>/dev/null 2>&1 &
+		tcpdump_pid2=$!
+
+		sleep 0.3
+		ovpn_cmd_ok "send baseline traffic to peer ${p}" \
+			ip netns exec peer0 \
+			ping -qfc 500 -w 3 5.5.5.$((p + 1))
+		ovpn_cmd_ok "send large-payload traffic to peer ${p}" \
+			ip netns exec peer0 \
+			ping -qfc 500 -s 3000 -w 3 5.5.5.$((p + 1))
+
+		wait "${tcpdump_pid1}" || return 1
+		wait "${tcpdump_pid2}" || return 1
 	done
-fi
+}
+
+ovpn_run_lan_traffic() {
+	ovpn_cmd_ok "ping LAN behind peer1" \
+		ip netns exec peer0 ping -qfc 500 -w 3 "${OVPN_LAN_IP}"
+}
+
+ovpn_run_float_mode() {
+	local p
+
+	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "float: remove old transport address on peer${p}" \
+			ip -n peer${p} addr del 10.10.${p}.2/24 dev veth${p}
+		ovpn_cmd_ok "float: add new transport address on peer${p}" \
+			ip -n peer${p} addr add 10.10.${p}.3/24 dev veth${p}
+	done
+	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "ping tunnel after float peer ${p}" \
+			ip netns exec peer${p} ping -qfc 500 -w 3 5.5.5.1
+	done
+}
+
+ovpn_run_iperf() {
+	local iperf_pid
+
+	ovpn_run_bg iperf_pid ip netns exec peer0 iperf3 -1 -s
+	sleep 1
+
+	ovpn_cmd_ok "run iperf throughput flow" \
+		ip netns exec peer1 iperf3 -Z -t 3 -c 5.5.5.1
+	wait "${iperf_pid}" || return 1
+}
+
+ovpn_run_key_rollover() {
+	local p
+
+	ovpn_log "Adding secondary key and then swap:"
+
+	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "add secondary key on peer0 for peer ${p}" \
+			ip netns exec peer0 ${OVPN_CLI} new_key tun0 \
+				${p} 2 1 ${OVPN_ALG} 0 data64.key
+		ovpn_cmd_ok "add secondary key on peer${p} for peer ${p}" \
+			ip netns exec peer${p} ${OVPN_CLI} new_key tun${p} \
+				$((p + OVPN_ID_OFFSET)) 2 1 ${OVPN_ALG} 1 data64.key
+		ovpn_cmd_ok "swap keys on peer${p}" \
+			ip netns exec peer${p} ${OVPN_CLI} swap_keys tun${p} \
+				$((p + OVPN_ID_OFFSET))
+	done
+}
+
+ovpn_run_queries() {
+	ovpn_log "Querying all peers:"
+
+	ovpn_cmd_ok "query all peers from peer0" \
+		ip netns exec peer0 ${OVPN_CLI} get_peer tun0
+	ovpn_cmd_ok "query all peers from peer1" \
+		ip netns exec peer1 ${OVPN_CLI} get_peer tun1
 
-ip netns exec peer0 iperf3 -1 -s &
-sleep 1
-ip netns exec peer1 iperf3 -Z -t 3 -c 5.5.5.1
-
-echo "Adding secondary key and then swap:"
-for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-	ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 2 1 ${OVPN_ALG} 0 \
-		data64.key
-	ip netns exec peer${p} ${OVPN_CLI} new_key tun${p} \
-		$((${p} + OVPN_ID_OFFSET)) 2 1 ${OVPN_ALG} 1 data64.key
-	ip netns exec peer${p} ${OVPN_CLI} swap_keys tun${p} \
-		$((${p} + OVPN_ID_OFFSET))
-done
-
-sleep 1
-
-echo "Querying all peers:"
-ip netns exec peer0 ${OVPN_CLI} get_peer tun0
-ip netns exec peer1 ${OVPN_CLI} get_peer tun1
-
-echo "Querying peer 1:"
-ip netns exec peer0 ${OVPN_CLI} get_peer tun0 1
-
-echo "Querying non-existent peer 20:"
-ip netns exec peer0 ${OVPN_CLI} get_peer tun0 20 || true
-
-echo "Deleting peer 1:"
-ip netns exec peer0 ${OVPN_CLI} del_peer tun0 1
-ip netns exec peer1 ${OVPN_CLI} del_peer tun1 $((1 + OVPN_ID_OFFSET))
-
-echo "Querying keys:"
-for p in $(seq 2 ${OVPN_NUM_PEERS}); do
-	ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} \
-		$((${p} + OVPN_ID_OFFSET)) 1
-	ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} \
-		$((${p} + OVPN_ID_OFFSET)) 2
-done
-
-echo "Deleting peer while sending traffic:"
-(ip netns exec peer2 ping -qf -w 4 5.5.5.1)&
-sleep 2
-ip netns exec peer0 ${OVPN_CLI} del_peer tun0 2
-# following command fails in TCP mode
-# (both ends get conn reset when one peer disconnects)
-ip netns exec peer2 ${OVPN_CLI} del_peer tun2 $((2 + OVPN_ID_OFFSET)) || true
-
-echo "Deleting keys:"
-for p in $(seq 3 ${OVPN_NUM_PEERS}); do
-	ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} \
-		$((${p} + OVPN_ID_OFFSET)) 1
-	ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} \
-		$((${p} + OVPN_ID_OFFSET)) 2
-done
-
-echo "Setting timeout to 3s MP:"
-for p in $(seq 3 ${OVPN_NUM_PEERS}); do
-	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 3 3 || true
-	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} \
-		$((${p} + OVPN_ID_OFFSET)) 0 0
-done
-# wait for peers to timeout
-sleep 5
-
-echo "Setting timeout to 3s P2P:"
-for p in $(seq 3 ${OVPN_NUM_PEERS}); do
-	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} \
-		$((${p} + OVPN_ID_OFFSET)) 3 3
-done
-sleep 5
-
-for p in $(seq 0 ${OVPN_NUM_PEERS}); do
-	ovpn_compare_ntfs ${p}
-done
+	ovpn_log "Querying peer 1:"
+
+	ovpn_cmd_ok "query peer 1 from peer0" \
+		ip netns exec peer0 ${OVPN_CLI} get_peer tun0 1
+}
+
+ovpn_query_peer_missing() {
+	ovpn_log "Querying non-existent peer 20:"
+
+	ovpn_cmd_fail "query missing peer 20 on peer0" \
+		ip netns exec peer0 ${OVPN_CLI} get_peer tun0 20
+}
+
+ovpn_run_peer_cleanup() {
+	local p
+
+	ovpn_log "Deleting peer 1:"
+
+	ovpn_cmd_ok "delete peer1 on peer0" \
+		ip netns exec peer0 ${OVPN_CLI} del_peer tun0 1
+	ovpn_cmd_ok "delete peer1 on peer1" \
+		ip netns exec peer1 ${OVPN_CLI} del_peer tun1 $((1 + OVPN_ID_OFFSET))
+
+	ovpn_log "Querying keys:"
+
+	for p in $(seq 2 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "query peer${p} key 1" \
+			ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} \
+				$((p + OVPN_ID_OFFSET)) 1
+		ovpn_cmd_ok "query peer${p} key 2" \
+			ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} \
+				$((p + OVPN_ID_OFFSET)) 2
+	done
+}
+
+ovpn_run_traffic_delete_peer() {
+	local ping_pid
+
+	ovpn_log "Deleting peer while sending traffic:"
+
+	ovpn_run_bg ping_pid ip netns exec peer2 ping -qf -w 4 5.5.5.1
+	sleep 2
+	ovpn_cmd_ok "delete peer0 peer 2" \
+		ip netns exec peer0 ${OVPN_CLI} del_peer tun0 2
+
+	if [ "${OVPN_PROTO}" == "TCP" ]; then
+		# In TCP mode this command is expected to fail for both peers.
+		ovpn_cmd_mayfail "delete peer2 peer 2 (TCP non-fatal)" \
+			ip netns exec peer2 ${OVPN_CLI} del_peer tun2 $((2 + OVPN_ID_OFFSET))
+	else
+		ovpn_cmd_ok "delete peer2 peer 2" ip netns exec peer2 \
+			${OVPN_CLI} del_peer tun2 $((2 + OVPN_ID_OFFSET))
+	fi
+
+	wait "${ping_pid}" || true
+}
+
+ovpn_run_key_cleanup() {
+	local p
+
+	ovpn_log "Deleting keys:"
+
+	for p in $(seq 3 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "delete key 1 for peer${p}" \
+			ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} \
+				$((p + OVPN_ID_OFFSET)) 1
+		ovpn_cmd_ok "delete key 2 for peer${p}" \
+			ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} \
+				$((p + OVPN_ID_OFFSET)) 2
+	done
+}
+
+ovpn_run_timeouts() {
+	local p
+
+	ovpn_log "Setting timeout to 3s MP:"
+
+	for p in $(seq 3 ${OVPN_NUM_PEERS}); do
+		# Non-fatal: this may fail in some protocol modes.
+		ovpn_cmd_mayfail "set peer0 timeout for peer ${p} (non-fatal)" \
+			ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 3 3
+		ovpn_cmd_ok "disable timeout on peer${p} while peer0 adjusts state" \
+			ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} \
+				$((p + OVPN_ID_OFFSET)) 0 0
+	done
+	# wait for peers to timeout
+	sleep 5
+
+	ovpn_log "Setting timeout to 3s P2P:"
+
+	for p in $(seq 3 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "set peer${p} P2P timeout" \
+			ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} \
+				$((p + OVPN_ID_OFFSET)) 3 3
+	done
+	sleep 5
+}
+
+ovpn_run_notifications() {
+	local p
+
+	for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "validate listener output for peer ${p}" \
+			ovpn_compare_ntfs "${p}"
+	done
+}
+
+trap ovpn_test_exit EXIT
+trap ovpn_stage_err ERR
+
+ktap_print_header
+if [ "${OVPN_FLOAT}" == "1" ]; then
+	ktap_set_plan 13
+else
+	ktap_set_plan 12
+fi
 
 ovpn_cleanup
+modprobe -q ovpn || true
+
+ovpn_run_stage "setup network topology" ovpn_prepare_network
+ovpn_run_stage "run baseline data traffic" ovpn_run_basic_traffic
+ovpn_run_stage "run LAN traffic behind peer1" ovpn_run_lan_traffic
+[ "${OVPN_FLOAT}" == "1" ] && ovpn_run_stage "run floating peer checks" ovpn_run_float_mode
+ovpn_run_stage "run iperf throughput" ovpn_run_iperf
+ovpn_run_stage "run key rollout" ovpn_run_key_rollover
+ovpn_run_stage "query peers" ovpn_run_queries
+ovpn_run_stage "query missing peer fails" ovpn_query_peer_missing
+ovpn_run_stage "peer lifecycle and key queries" ovpn_run_peer_cleanup
+ovpn_run_stage "delete peer while traffic" ovpn_run_traffic_delete_peer
+ovpn_run_stage "delete stale keys" ovpn_run_key_cleanup
+ovpn_run_stage "check timeout behavior" ovpn_run_timeouts
+ovpn_run_stage "validate notification output" ovpn_run_notifications
 
-modprobe -r ovpn || true
+ovpn_test_finished=1
+ktap_finished
-- 
2.52.0


