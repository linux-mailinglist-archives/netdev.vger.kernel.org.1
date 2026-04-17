Return-Path: <netdev+bounces-279275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFR/FMT44Wn50AAAu9opvQ
	(envelope-from <netdev+bounces-279275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:09:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E31B2419190
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A67C4317F6ED
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107A53B2FEC;
	Fri, 17 Apr 2026 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Poe1cbja"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580F735F5F2
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416620; cv=none; b=RW9b7IRi4Win2PYjunGYwuNy6kX6+xlb0nOzfKwUlS7gmJQ+BAQvuTKCnBUDD5gpTuGSwFYpcazqg6jCT64FA8/w2R5XActxxVuVJb9jzTl52tVEUa5LMlSyq/8a2DwdkvSInlJRHynCgAznkhKrhfmJN9KLfiHx102le0Py9cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416620; c=relaxed/simple;
	bh=tF0wVeznGEtdPX5LHKqo5E/abif50UfezC9NKzpQYwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3nS4jRgXDZLK+9YSDauhZ5bKTjmLExs7t3+X9C056fb2gePQ91wZzJZjBPeE/FJnCWSrZuPPdfgi0FH10g9LRe9YSdMQJNUXiUigyunNo8j4c7jnKEf5/+sf+nXu2VrG8XVjH2QiRy92zlxW4IDsukiMVOk5hejNr4gz5ktMbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Poe1cbja; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43fe62837baso148378f8f.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 02:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776416615; x=1777021415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn2/mDfcOuTa2iJZHEwREeM7Ls01gKkS3PldVBiaAVo=;
        b=Poe1cbjaoFJzAswN5hf1db+IHnycLRg0/dVI2aWThqYBhcqKR549ezhmYz1Euat6rf
         nO+wvzzqPoRoO8Tsi1DEct7oR6DoBU5Wifh1n//joB7sJtkNvb8IzRvNrBFRtZVFyEqj
         ocVUxdUGdYwtjsdYVoADpLHSsUphwewW8QdlYm7DSKCjbPNDZ8IPIce2WfRUv92PAH90
         TdKVtV+IR5RCGz4cniq1rzoEvO0JE7andrgv0vz2bDMgq1Ph+dainaspj0joXwP1kvuA
         rIPcUN3MWklnf3Btv1dgRVtslLTbqdkY84YlfXtVjycVV6SMGLLplZX3jkJMt9Uo8zqJ
         r+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776416615; x=1777021415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zn2/mDfcOuTa2iJZHEwREeM7Ls01gKkS3PldVBiaAVo=;
        b=lJMRTRobrmu6+t9Uv3TxWdBG4fmtmQFF29RkQG5bhYThhN+asTVGJQZb7AONvFkauY
         OSLy2foveQ4lLAK1h715awlda6lzFGf3Sz1daGcrMf3jwtILhzwuKGMziGtdZX0nbVUJ
         RaO2tDUdl+0uJUPcXdvjniL5e9NfAt/q3/TV5X9E3lYR7Vo3ztYv8C/7LPD+rkBtt94U
         Arl4Bg2ilGETLorRebhUB9GG0PI/hLP2wOTDc5N2yF5LwPtQffKtqWGywNs+6i01Vi58
         xblh1tdpTpjS2NwBzUnTdmLwj82CaHXEM5OF21iDRsctI1COYTI67EPmrrmvoioqT+Z1
         NH+g==
X-Gm-Message-State: AOJu0YwpEJbql+MrcXjZV7iHwy4kqUhN2Hn6OmxE5PIcz497r+vjt/H/
	JK7C1BcCmTeRkwh8Ic4Zleww0lr7hfQjQ3txsVj0F16g4R9emtzhLlQScW9wqTGL1upqJWoJ32U
	3o67hWCcbrY3QCj+yz1g8rnMFKahzSTc0FceX8VvZV+RxhsaGCG9pinicbIG8o/0z
X-Gm-Gg: AeBDies0HoJSoaAeLLeETe2WlFOu3qq28dLcUNw1X1BQ4MPiTJTjxhl36uJqIsaKulx
	kcB1B8V5WWAIR+9QoPHM8eYTQzqU2SQeZ7FIv+EZbKE21RcO3F8FQaiGVr2H7XlgnqqszqO1oaf
	z6SxIxxmjXn5NU/5HoPY++g3pUkb1LE8WxQCwmk68bF4NKkJMA7ECn4okI/Zb2eIueadhkjmfJJ
	6xNl50D8ck6c6s5BY/tkJLJg7sq+U+uBRYhwy5npDHycY16NoMQhOQ7YM4KLJLptKMqrWP6v6cC
	IRpo9Z2CjKwRENguzTRycAdg28CJX8OXh1Y5P8GGzzSJpt1UfOgdpKLEakxTPhUxIpTnZrEZ4xo
	w+gnlfVIKDRl+LBZDe3TNsJrXSNreSEhYv7NfFJE1T+uA11lxZaguIqJm9zKtjr+MlSB7SMVe5J
	OqkjTqzQq/W5Wcbp8OuJUL9CTd+aaWNp1Vg06JarQrVuK1A7I=
X-Received: by 2002:a5d:588f:0:b0:43d:2be:e54 with SMTP id ffacd0b85a97d-43fe3dfd4aemr2677306f8f.39.1776416614945;
        Fri, 17 Apr 2026 02:03:34 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:7524:fc82:dee5:4129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e591cesm4120151f8f.36.2026.04.17.02.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 02:03:34 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	shuah@kernel.org,
	horms@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 5/6] selftests: ovpn: align command flow with TAP
Date: Fri, 17 Apr 2026 11:03:04 +0200
Message-ID: <20260417090305.2775723-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417090305.2775723-1-antonio@openvpn.net>
References: <20260417090305.2775723-1-antonio@openvpn.net>
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
	TAGGED_FROM(0.00)[bounces-279275-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[openvpn.net:s=google];
	GREYLIST(0.00)[pass,meta];
	DMARC_POLICY_ALLOW(0.00)[openvpn.net,none];
	DKIM_TRACE(0.00)[openvpn.net:+];
	NEURAL_SPAM(0.00)[0.998];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mandelbit.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openvpn.net:email,openvpn.net:dkim,openvpn.net:mid]
X-Rspamd-Queue-Id: E31B2419190
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

From: Ralf Lici <ralf@mandelbit.com>

Current tests do not properly adhere to the TAP infrastructure
therefore they do not properly report failures leading to hangs of
the CI machinery.

Restructure ovpn selftests into using the TAP infrastructure: split each
test in stages, execute stage bodies with fail-fast semantics, and emit
KTAP pass/fail for each stage.

Centralize behavior control in common.sh and makes the scripts use
dedicated wrappers for required-success, expected-failure, and non-fatal
commands. Also add the OVPN_VERBOSE mode that exposes captured command
output for debugging.
This way tests won't hang anymore in case of failure when executed
within the CI machinery.

This change also makes default OVPN_CLI and YNL resolution
independent from the caller CWD by anchoring both to COMMON_DIR, so
behavior is stable across direct execution and run_tests-style
execution.

Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/common.sh    | 182 +++++++-
 .../selftests/net/ovpn/test-close-socket.sh   |  90 ++--
 tools/testing/selftests/net/ovpn/test-mark.sh | 236 ++++++----
 tools/testing/selftests/net/ovpn/test.sh      | 441 ++++++++++++------
 4 files changed, 676 insertions(+), 273 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 38f187b9de23..2d844eb3aa6e 100644
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
-OVPN_YNL=${OVPN_YNL:-../../../../net/ynl/pyynl/cli.py}
+OVPN_CLI=${OVPN_CLI:-${OVPN_COMMON_DIR}/ovpn-cli}
+OVPN_YNL=${OVPN_YNL:-${OVPN_COMMON_DIR}/../../../../net/ynl/pyynl/cli.py}
 OVPN_ALG=${OVPN_ALG:-aes}
 OVPN_PROTO=${OVPN_PROTO:-UDP}
 OVPN_FLOAT=${OVPN_FLOAT:-0}
 OVPN_SYMMETRIC_ID=${OVPN_SYMMETRIC_ID:-0}
+OVPN_VERBOSE=${OVPN_VERBOSE:-0}
 
 export OVPN_ID_OFFSET=$(( 9 * (OVPN_SYMMETRIC_ID == 0) ))
 
@@ -22,6 +26,111 @@ OVPN_LAN_IP="11.11.11.11"
 
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
+			printf '%s\n' \
+				"${label}: command failed with rc=${rc}: $*"
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
 	ip netns add "ovpn_peer${1}"
@@ -87,12 +196,16 @@ ovpn_build_capture_filter() {
 }
 
 ovpn_setup_listener() {
-	local peer_ns="ovpn_peer${p}"
+	local peer="$1"
+	local file
+	local peer_ns="ovpn_peer${peer}"
+
 	file=$(mktemp)
 	PYTHONUNBUFFERED=1 ip netns exec "${peer_ns}" "${OVPN_YNL}" --family \
-		ovpn --subscribe peers --output-json --duration 40 > ${file} &
-	OVPN_LISTENER_PIDS[$1]=$!
-	OVPN_TMP_JSONS[$1]="${file}"
+		ovpn --subscribe peers --output-json > "${file}" \
+		2>/dev/null &
+	OVPN_LISTENER_PIDS["${peer}"]=$!
+	OVPN_TMP_JSONS["${peer}"]="${file}"
 }
 
 ovpn_add_peer() {
@@ -173,8 +286,7 @@ ovpn_compare_ntfs() {
 		received="${OVPN_TMP_JSONS[$1]}"
 		diff_file=$(mktemp)
 
-		kill -TERM ${OVPN_LISTENER_PIDS[$1]} || true
-		wait ${OVPN_LISTENER_PIDS[$1]} || true
+		ovpn_stop_listener "${1}" 1
 		printf "Checking notifications for peer ${1}... "
 		if diff <(jq -s "${OVPN_JQ_FILTER}" ${expected}) \
 			<(jq -s "${OVPN_JQ_FILTER}" ${received}) \
@@ -187,30 +299,60 @@ ovpn_compare_ntfs() {
 		fi
 
 		rm -f "${diff_file}" || true
-		rm -f ${received} || true
+		rm -f "${received}" || true
+		unset "OVPN_TMP_JSONS[$1]"
 	fi
 
 	return "${diff_rc}"
 }
 
+ovpn_stop_listener() {
+	local peer="$1"
+	local keep_json="${2:-0}"
+	local pid="${OVPN_LISTENER_PIDS[$peer]:-}"
+	local json="${OVPN_TMP_JSONS[$peer]:-}"
+
+	if [[ -n "${pid}" ]]; then
+		kill -TERM "${pid}" 2>/dev/null || true
+		wait "${pid}" 2>/dev/null || true
+		unset "OVPN_LISTENER_PIDS[$peer]"
+	fi
+
+	if [[ -n "${json}" && "${keep_json}" -eq 0 ]]; then
+		rm -f "${json}" || true
+		unset "OVPN_TMP_JSONS[$peer]"
+	fi
+}
+
+ovpn_cleanup_peer_ns() {
+	local peer="$1"
+	local peer_id="${peer#ovpn_peer}"
+
+	ip -n "${peer}" link set tun${peer_id} down 2>/dev/null || true
+	ip netns exec "${peer}" ${OVPN_CLI} del_iface tun${peer_id} \
+		1>/dev/null 2>&1 || true
+	ip netns del "${peer}" 2>/dev/null || true
+}
+
 ovpn_cleanup() {
-	local peer_ns
+	local peer
+
 	# some ovpn-cli processes sleep in background so they need manual poking
-	killall $(basename ${OVPN_CLI}) 2>/dev/null || true
+	killall "$(basename "${OVPN_CLI}")" 2>/dev/null || true
 
-	# netns peer0 is deleted without erasing ifaces first
-	for p in $(seq 1 10); do
-		peer_ns="ovpn_peer${p}"
-		ip -n "${peer_ns}" link set tun${p} down 2>/dev/null || true
-		ip netns exec "${peer_ns}" ${OVPN_CLI} del_iface tun${p} \
-			2>/dev/null || true
+	for peer in "${!OVPN_LISTENER_PIDS[@]}"; do
+		ovpn_stop_listener "${peer}" 2>/dev/null
 	done
+
 	for p in $(seq 1 10); do
 		ip -n ovpn_peer0 link del veth${p} 2>/dev/null || true
 	done
-	for p in $(seq 0 10); do
-		ip netns del "ovpn_peer${p}" 2>/dev/null || true
-	done
+
+	# remove from ovpn's netns pool
+	while IFS= read -r peer; do
+		[[ -n "${peer}" ]] || continue
+		ovpn_cleanup_peer_ns "${peer}" 2>/dev/null
+	done < <(ip netns list 2>/dev/null | awk '/^ovpn_/ {print $1}')
 }
 
 if [ "${OVPN_PROTO}" == "UDP" ]; then
diff --git a/tools/testing/selftests/net/ovpn/test-close-socket.sh b/tools/testing/selftests/net/ovpn/test-close-socket.sh
index 6bc1b6eab8ac..af1532b4d2da 100755
--- a/tools/testing/selftests/net/ovpn/test-close-socket.sh
+++ b/tools/testing/selftests/net/ovpn/test-close-socket.sh
@@ -5,43 +5,81 @@
 #  Author:	Antonio Quartulli <antonio@openvpn.net>
 
 #set -x
-set -e
+set -eE
 
 source ./common.sh
-server_ns="ovpn_peer0"
 
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
+	local peer_ns
+
+	for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "create namespace peer${p}" ovpn_create_ns "${p}"
+	done
 
-for p in $(seq 0 ${OVPN_NUM_PEERS}); do
-	ovpn_create_ns ${p}
-done
+	for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "configure peer${p} namespace" ovpn_setup_ns \
+			"${p}" 5.5.5.$((p + 1))/24
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
+		peer_ns="ovpn_peer${p}"
+		ovpn_cmd_ok "set peer0 timeout for peer ${p}" \
+			ip netns exec ovpn_peer0 ${OVPN_CLI} set_peer tun0 \
+				${p} 60 120
+		ovpn_cmd_ok "set peer${p} timeout for peer ${p}" \
+			ip netns exec "${peer_ns}" ${OVPN_CLI} set_peer \
+				tun${p} $((p + OVPN_ID_OFFSET)) 60 120
+	done
+}
 
-for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-	ip netns exec "${server_ns}" ${OVPN_CLI} set_peer tun0 ${p} 60 120
-	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} set_peer tun${p} $((${p}+9)) \
-		60 120
-done
+ovpn_run_ping_traffic() {
+	local p
 
-sleep 1
+	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "send ping traffic to peer ${p}" \
+			ip netns exec ovpn_peer0 ping -qfc 500 -w 3 \
+				5.5.5.$((p + 1))
+	done
+}
 
-for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-	ip netns exec "${server_ns}" ping -qfc 500 -w 3 5.5.5.$((${p} + 1))
-done
+ovpn_run_iperf() {
+	local iperf_pid
 
-ip netns exec "${server_ns}" iperf3 -1 -s &
-sleep 1
-ip netns exec ovpn_peer1 iperf3 -Z -t 3 -c 5.5.5.1
+	ovpn_run_bg iperf_pid ip netns exec ovpn_peer0 iperf3 -1 -s
+	sleep 1
+	ovpn_cmd_ok "run iperf throughput flow" \
+		ip netns exec ovpn_peer1 iperf3 -Z -t 3 -c 5.5.5.1
+	wait "${iperf_pid}" || return 1
+}
+
+trap ovpn_test_exit EXIT
+trap ovpn_stage_err ERR
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
index 2ee5dc5fc538..5a8f47554286 100755
--- a/tools/testing/selftests/net/ovpn/test-mark.sh
+++ b/tools/testing/selftests/net/ovpn/test-mark.sh
@@ -6,92 +6,166 @@
 #		Antonio Quartulli <antonio@openvpn.net>
 
 #set -x
-set -e
+set -eE
 
 MARK=1056
+MARK_DROP_COUNTER=0
 
 source ./common.sh
-server_ns="ovpn_peer0"
 
-ovpn_cleanup
-
-modprobe -q ovpn || true
-
-for p in $(seq 0 "${OVPN_NUM_PEERS}"); do
-	ovpn_create_ns "${p}"
-done
-
-for p in $(seq 0 3); do
-	ovpn_setup_ns "${p}" 5.5.5.$((p + 1))/24
-done
-
-# add peer0 with mark
-ip netns exec "${server_ns}" "${OVPN_CLI}" new_multi_peer tun0 1 ASYMM \
-	"${OVPN_UDP_PEERS_FILE}" \
-	${MARK}
-for p in $(seq 1 3); do
-	ip netns exec "${server_ns}" "${OVPN_CLI}" new_key tun0 "${p}" 1 0 \
-		"${OVPN_ALG}" 0 data64.key
-done
-
-for p in $(seq 1 3); do
-	ovpn_add_peer "${p}"
-done
-
-for p in $(seq 1 3); do
-	ip netns exec "${server_ns}" "${OVPN_CLI}" set_peer tun0 "${p}" 60 120
-	ip netns exec "ovpn_peer${p}" "${OVPN_CLI}" set_peer tun"${p}" \
-		$((p + 9)) 60 120
-done
-
-sleep 1
-
-for p in $(seq 1 3); do
-	ip netns exec "${server_ns}" ping -qfc 500 -w 3 5.5.5.$((p + 1))
-done
-
-echo "Adding an nftables drop rule based on mark value ${MARK}"
-ip netns exec "${server_ns}" nft flush ruleset
-ip netns exec "${server_ns}" nft 'add table inet filter'
-ip netns exec "${server_ns}" nft 'add chain inet filter output {
-	type filter hook output priority 0;
-	policy accept;
-}'
-ip netns exec "${server_ns}" nft add rule inet filter output \
-	meta mark == ${MARK} \
-	counter drop
-
-DROP_COUNTER=$(ip netns exec "${server_ns}" nft list chain inet filter output \
-	| sed -n 's/.*packets \([0-9]*\).*/\1/p')
-sleep 1
-
-# ping should fail
-for p in $(seq 1 3); do
-	PING_OUTPUT=$(ip netns exec "${server_ns}" ping \
-		-qfc 500 -w 1 5.5.5.$((p + 1)) 2>&1) && exit 1
-	echo "${PING_OUTPUT}"
-	LOST_PACKETS=$(echo "$PING_OUTPUT" \
-		| awk '/packets transmitted/ { print $1 }')
-	# increment the drop counter by the amount of lost packets
-	DROP_COUNTER=$((DROP_COUNTER + LOST_PACKETS))
-done
-
-# check if the final nft counter matches our counter
-TOTAL_COUNT=$(ip netns exec "${server_ns}" nft list chain inet filter output \
-	| sed -n 's/.*packets \([0-9]*\).*/\1/p')
-if [ "${DROP_COUNTER}" -ne "${TOTAL_COUNT}" ]; then
-	echo "Expected ${TOTAL_COUNT} drops, got ${DROP_COUNTER}"
-	exit 1
-fi
-
-echo "Removing the drop rule"
-ip netns exec "${server_ns}" nft flush ruleset
-sleep 1
-
-for p in $(seq 1 3); do
-	ip netns exec "${server_ns}" ping -qfc 500 -w 3 5.5.5.$((p + 1))
-done
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
+	local peer_ns
+
+	for p in $(seq 0 "${OVPN_NUM_PEERS}"); do
+		ovpn_cmd_ok "create namespace peer${p}" ovpn_create_ns "${p}"
+	done
+
+	for p in $(seq 0 3); do
+		ovpn_cmd_ok "configure peer${p} namespace" ovpn_setup_ns \
+			"${p}" 5.5.5.$((p + 1))/24
+	done
+
+	ovpn_cmd_ok "create server-side multi-peer with fwmark" \
+		ip netns exec ovpn_peer0 "${OVPN_CLI}" new_multi_peer tun0 1 \
+			ASYMM "${OVPN_UDP_PEERS_FILE}" "${MARK}"
+	for p in $(seq 1 3); do
+		ovpn_cmd_ok "install server key for peer ${p}" \
+			ip netns exec ovpn_peer0 "${OVPN_CLI}" new_key tun0 \
+				"${p}" 1 0 "${OVPN_ALG}" 0 data64.key
+	done
+
+	for p in $(seq 1 3); do
+		ovpn_cmd_ok "register peer${p} in overlay" ovpn_add_peer "${p}"
+	done
+
+	for p in $(seq 1 3); do
+		peer_ns="ovpn_peer${p}"
+		ovpn_cmd_ok "set peer0 timeout for peer ${p}" \
+			ip netns exec ovpn_peer0 "${OVPN_CLI}" set_peer tun0 \
+				"${p}" 60 120
+		ovpn_cmd_ok "set peer${p} timeout for peer ${p}" \
+			ip netns exec "${peer_ns}" "${OVPN_CLI}" set_peer \
+				tun"${p}" $((p + OVPN_ID_OFFSET)) 60 120
+	done
+}
+
+ovpn_mark_run_baseline_traffic() {
+	local p
+
+	for p in $(seq 1 3); do
+		ovpn_cmd_ok "send baseline traffic to peer ${p}" \
+			ip netns exec ovpn_peer0 ping -qfc 500 -w 3 \
+				5.5.5.$((p + 1))
+	done
+}
+
+ovpn_mark_add_drop_rule() {
+	ovpn_log "Adding an nftables drop rule based on mark value ${MARK}"
+
+	ovpn_cmd_ok "flush nft ruleset" ip netns exec ovpn_peer0 nft flush \
+		ruleset
+	ovpn_cmd_ok "create nft filter table" ip netns exec ovpn_peer0 nft \
+		"add table inet filter"
+	ovpn_cmd_ok "create nft filter output chain" \
+		ip netns exec ovpn_peer0 nft "add chain inet filter output { \
+			type filter hook output priority 0; policy accept; }"
+	ovpn_cmd_ok "add nft drop rule for mark ${MARK}" \
+		ip netns exec ovpn_peer0 nft add rule inet filter output \
+			meta mark == "${MARK}" \
+			counter drop
+
+	MARK_DROP_COUNTER=$(ip netns exec ovpn_peer0 nft list chain inet \
+		filter output | sed -n 's/.*packets \([0-9]*\).*/\1/p')
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
+		if ping_output=$(ip netns exec ovpn_peer0 ping -qfc 500 -w 1 \
+			5.5.5.$((p + 1)) 2>&1); then
+			printf '%s\n' "expected ping to peer ${p} to fail \
+				after nft drop rule"
+			return 1
+		fi
+		ovpn_log "${ping_output}"
+		lost_packets=$(echo "${ping_output}" | \
+				awk '/packets transmitted/ { print $1 }')
+		if [ -z "${lost_packets}" ]; then
+			printf '%s\n' "unable to parse lost packets for peer \
+				${p}"
+			return 1
+		fi
+		MARK_DROP_COUNTER=$((MARK_DROP_COUNTER + lost_packets))
+	done
+
+	total_count=$(ip netns exec ovpn_peer0 nft list chain inet filter \
+		output | sed -n 's/.*packets \([0-9]*\).*/\1/p')
+	if [ -z "${total_count}" ]; then
+		printf '%s\n' "unable to read final nft drop counter"
+		return 1
+	fi
+	if [ "${MARK_DROP_COUNTER}" -ne "${total_count}" ]; then
+		printf '%s\n' "expected ${MARK_DROP_COUNTER} drops, got \
+			${total_count}"
+		return 1
+	fi
+}
+
+ovpn_mark_remove_drop_rule() {
+	ovpn_log "Removing the drop rule"
+
+	ovpn_cmd_ok "flush nft ruleset" ip netns exec ovpn_peer0 nft flush \
+		ruleset
+}
+
+ovpn_mark_verify_traffic_recovery() {
+	local p
+
+	sleep 1
+	for p in $(seq 1 3); do
+		ovpn_cmd_ok "send recovery traffic to peer ${p}" \
+			ip netns exec ovpn_peer0 ping -qfc 500 -w 3 \
+				5.5.5.$((p + 1))
+	done
+}
+
+trap ovpn_test_exit EXIT
+trap ovpn_stage_err ERR
+
+ktap_print_header
+ktap_set_plan 6
 
 ovpn_cleanup
+modprobe -q ovpn || true
 
-modprobe -r ovpn || true
+ovpn_run_stage "setup marked network topology" ovpn_mark_prepare_network
+ovpn_run_stage "run baseline traffic" ovpn_mark_run_baseline_traffic
+ovpn_run_stage "install nft mark drop rule" ovpn_mark_add_drop_rule
+ovpn_run_stage "drop marked traffic and count packets" \
+	ovpn_mark_verify_drop_traffic
+ovpn_run_stage "remove nft drop rule" ovpn_mark_remove_drop_rule
+ovpn_run_stage "traffic recovers after drop removal" \
+	ovpn_mark_verify_traffic_recovery
+
+ovpn_test_finished=1
+ktap_finished
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index b766f4842940..eca653112aeb 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -5,164 +5,313 @@
 #  Author:	Antonio Quartulli <antonio@openvpn.net>
 
 #set -x
-set -e
+set -eE
 
 source ./common.sh
-server_ns="ovpn_peer0"
 
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
-	ip netns exec "${server_ns}" ${OVPN_CLI} set_peer tun0 ${p} 60 120
-	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} set_peer tun${p} \
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
+	local peer_ns
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
+		ovpn_cmd_ok "configure peer${p} namespace" ovpn_setup_ns \
+			"${p}" 5.5.5.$((p + 1))/24 "${MTU}"
+	done
+
+	for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+		ovpn_cmd_ok "register peer${p} in overlay" ovpn_add_peer "${p}"
+	done
 
-	timeout ${TCPDUMP_TIMEOUT} ip netns exec "ovpn_peer${p}" \
-		tcpdump --immediate-mode -p -ni veth${p} -c 1 \
-		"$(ovpn_build_capture_filter "${HEADER1}" "${RADDR}")" \
-		>/dev/null 2>&1 &
-	TCPDUMP_PID1=$!
-	timeout ${TCPDUMP_TIMEOUT} ip netns exec "ovpn_peer${p}" \
-		tcpdump --immediate-mode -p -ni veth${p} -c 1 \
-		"$(ovpn_build_capture_filter "${HEADER2}" "${RADDR}")" \
-		>/dev/null 2>&1 &
-	TCPDUMP_PID2=$!
-
-	sleep 0.3
-	ip netns exec "${server_ns}" ping -qfc 500 -w 3 5.5.5.$((${p} + 1))
-	ip netns exec "${server_ns}" ping -qfc 500 -s 3000 -w 3 \
-		5.5.5.$((${p} + 1))
-
-	wait ${TCPDUMP_PID1}
-	wait ${TCPDUMP_PID2}
-done
-
-# ping LAN behind client 1
-ip netns exec "${server_ns}" ping -qfc 500 -w 3 ${OVPN_LAN_IP}
-
-if [ "$OVPN_FLOAT" == "1" ]; then
-	# make clients float..
 	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-		ip -n "ovpn_peer${p}" addr del 10.10.${p}.2/24 dev veth${p}
-		ip -n "ovpn_peer${p}" addr add 10.10.${p}.3/24 dev veth${p}
+		peer_ns="ovpn_peer${p}"
+		ovpn_cmd_ok "set peer0 timeout for peer ${p}" \
+			ip netns exec ovpn_peer0 ${OVPN_CLI} set_peer tun0 \
+				${p} 60 120
+		ovpn_cmd_ok "set peer${p} timeout for peer ${p}" \
+			ip netns exec "${peer_ns}" ${OVPN_CLI} set_peer \
+				tun${p} $((p + OVPN_ID_OFFSET)) 60 120
 	done
+}
+
+ovpn_run_basic_traffic() {
+	local p
+	local header1
+	local header2
+	local peer_ns
+	local raddr
+	local tcpdump_pid1
+	local tcpdump_pid2
+	local tcpdump_timeout="1.5s"
+
 	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-		ip netns exec "ovpn_peer${p}" ping -qfc 500 -w 3 5.5.5.1
+		# The first part of the data packet header consists of:
+		# - TCP only: 2 bytes for the packet length
+		# - 5 bits for opcode ("9" for DATA_V2)
+		# - 3 bits for key-id ("0" at this point)
+		# - 12 bytes for peer-id:
+		#     - with asymmetric ID: "${p}" one way and "${p} + 9" the
+		#	other way
+		#     - with symmetric ID: "${p}" both ways
+		header1=$(printf "0x4800000%x" ${p})
+		header2=$(printf "0x4800000%x" $((p + OVPN_ID_OFFSET)))
+		raddr=""
+		if [ "${OVPN_PROTO}" == "UDP" ]; then
+			raddr=$(awk "NR == ${p} {print \$3}" \
+				"${OVPN_UDP_PEERS_FILE}")
+		fi
+		peer_ns="ovpn_peer${p}"
+
+		timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
+			tcpdump --immediate-mode -p -ni veth${p} -c 1 \
+			"$(ovpn_build_capture_filter "${header1}" "${raddr}")" \
+			>/dev/null 2>&1 &
+		tcpdump_pid1=$!
+		timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
+			tcpdump --immediate-mode -p -ni veth${p} -c 1 \
+			"$(ovpn_build_capture_filter "${header2}" "${raddr}")" \
+			>/dev/null 2>&1 &
+		tcpdump_pid2=$!
+
+		sleep 0.3
+		ovpn_cmd_ok "send baseline traffic to peer ${p}" \
+			ip netns exec ovpn_peer0 \
+			ping -qfc 500 -w 3 5.5.5.$((p + 1))
+		ovpn_cmd_ok "send large-payload traffic to peer ${p}" \
+			ip netns exec ovpn_peer0 \
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
+		ip netns exec ovpn_peer0 ping -qfc 500 -w 3 "${OVPN_LAN_IP}"
+}
+
+ovpn_run_float_mode() {
+	local p
+	local peer_ns
+
+	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+		peer_ns="ovpn_peer${p}"
+		ovpn_cmd_ok "float: remove old transport address on peer${p}" \
+			ip -n "${peer_ns}" addr del 10.10.${p}.2/24 dev veth${p}
+		ovpn_cmd_ok "float: add new transport address on peer${p}" \
+			ip -n "${peer_ns}" addr add 10.10.${p}.3/24 dev veth${p}
+	done
+	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+		peer_ns="ovpn_peer${p}"
+		ovpn_cmd_ok "ping tunnel after float peer ${p}" \
+			ip netns exec "${peer_ns}" ping -qfc 500 -w 3 5.5.5.1
+	done
+}
+
+ovpn_run_iperf() {
+	local iperf_pid
+
+	ovpn_run_bg iperf_pid ip netns exec ovpn_peer0 iperf3 -1 -s
+	sleep 1
+
+	ovpn_cmd_ok "run iperf throughput flow" \
+		ip netns exec ovpn_peer1 iperf3 -Z -t 3 -c 5.5.5.1
+	wait "${iperf_pid}" || return 1
+}
+
+ovpn_run_key_rollover() {
+	local p
+	local peer_ns
+
+	ovpn_log "Adding secondary key and then swap:"
+
+	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+		peer_ns="ovpn_peer${p}"
+		ovpn_cmd_ok "add secondary key on peer0 for peer ${p}" \
+			ip netns exec ovpn_peer0 ${OVPN_CLI} new_key tun0 \
+				${p} 2 1 ${OVPN_ALG} 0 data64.key
+		ovpn_cmd_ok "add secondary key on peer${p} for peer ${p}" \
+			ip netns exec "${peer_ns}" ${OVPN_CLI} new_key tun${p} \
+				$((p + OVPN_ID_OFFSET)) 2 1 ${OVPN_ALG} 1 \
+				data64.key
+		ovpn_cmd_ok "swap keys on peer${p}" \
+			ip netns exec "${peer_ns}" ${OVPN_CLI} swap_keys \
+				tun${p} $((p + OVPN_ID_OFFSET))
+	done
+}
+
+ovpn_run_queries() {
+	ovpn_log "Querying all peers:"
+
+	ovpn_cmd_ok "query all peers from peer0" \
+		ip netns exec ovpn_peer0 ${OVPN_CLI} get_peer tun0
+	ovpn_cmd_ok "query all peers from peer1" \
+		ip netns exec ovpn_peer1 ${OVPN_CLI} get_peer tun1
 
-ip netns exec "${server_ns}" iperf3 -1 -s &
-sleep 1
-ip netns exec ovpn_peer1 iperf3 -Z -t 3 -c 5.5.5.1
-
-echo "Adding secondary key and then swap:"
-for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-	ip netns exec "${server_ns}" ${OVPN_CLI} new_key tun0 ${p} 2 1 \
-		${OVPN_ALG} 0 data64.key
-	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} new_key tun${p} \
-		$((${p} + OVPN_ID_OFFSET)) 2 1 ${OVPN_ALG} 1 data64.key
-	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} swap_keys tun${p} \
-		$((${p} + OVPN_ID_OFFSET))
-done
-
-sleep 1
-
-echo "Querying all peers:"
-ip netns exec "${server_ns}" ${OVPN_CLI} get_peer tun0
-ip netns exec ovpn_peer1 ${OVPN_CLI} get_peer tun1
-
-echo "Querying peer 1:"
-ip netns exec "${server_ns}" ${OVPN_CLI} get_peer tun0 1
-
-echo "Querying non-existent peer 20:"
-ip netns exec "${server_ns}" ${OVPN_CLI} get_peer tun0 20 || true
-
-echo "Deleting peer 1:"
-ip netns exec "${server_ns}" ${OVPN_CLI} del_peer tun0 1
-ip netns exec ovpn_peer1 ${OVPN_CLI} del_peer tun1 $((1 + OVPN_ID_OFFSET))
-
-echo "Querying keys:"
-for p in $(seq 2 ${OVPN_NUM_PEERS}); do
-	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} get_key tun${p} \
-		$((${p} + OVPN_ID_OFFSET)) 1
-	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} get_key tun${p} \
-		$((${p} + OVPN_ID_OFFSET)) 2
-done
-
-echo "Deleting peer while sending traffic:"
-(ip netns exec ovpn_peer2 ping -qf -w 4 5.5.5.1)&
-sleep 2
-ip netns exec "${server_ns}" ${OVPN_CLI} del_peer tun0 2
-# following command fails in TCP mode
-# (both ends get conn reset when one peer disconnects)
-ip netns exec ovpn_peer2 ${OVPN_CLI} del_peer tun2 $((2 + OVPN_ID_OFFSET)) || \
-	true
-
-echo "Deleting keys:"
-for p in $(seq 3 ${OVPN_NUM_PEERS}); do
-	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} del_key tun${p} \
-		$((${p} + OVPN_ID_OFFSET)) 1
-	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} del_key tun${p} \
-		$((${p} + OVPN_ID_OFFSET)) 2
-done
-
-echo "Setting timeout to 3s MP:"
-for p in $(seq 3 ${OVPN_NUM_PEERS}); do
-	ip netns exec "${server_ns}" ${OVPN_CLI} set_peer tun0 ${p} 3 3 || true
-	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} set_peer tun${p} \
-		$((${p} + OVPN_ID_OFFSET)) 0 0
-done
-# wait for peers to timeout
-sleep 5
-
-echo "Setting timeout to 3s P2P:"
-for p in $(seq 3 ${OVPN_NUM_PEERS}); do
-	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} set_peer tun${p} \
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
+		ip netns exec ovpn_peer0 ${OVPN_CLI} get_peer tun0 1
+}
+
+ovpn_query_peer_missing() {
+	ovpn_log "Querying non-existent peer 20:"
+
+	ovpn_cmd_fail "query missing peer 20 on peer0" \
+		ip netns exec ovpn_peer0 ${OVPN_CLI} get_peer tun0 20
+}
+
+ovpn_run_peer_cleanup() {
+	local p
+	local peer_ns
+
+	ovpn_log "Deleting peer 1:"
+
+	ovpn_cmd_ok "delete peer1 on peer0" \
+		ip netns exec ovpn_peer0 ${OVPN_CLI} del_peer tun0 1
+	ovpn_cmd_ok "delete peer1 on peer1" \
+		ip netns exec ovpn_peer1 ${OVPN_CLI} del_peer tun1 \
+			$((1 + OVPN_ID_OFFSET))
+
+	ovpn_log "Querying keys:"
+
+	for p in $(seq 2 ${OVPN_NUM_PEERS}); do
+		peer_ns="ovpn_peer${p}"
+		ovpn_cmd_ok "query peer${p} key 1" \
+			ip netns exec "${peer_ns}" ${OVPN_CLI} get_key tun${p} \
+				$((p + OVPN_ID_OFFSET)) 1
+		ovpn_cmd_ok "query peer${p} key 2" \
+			ip netns exec "${peer_ns}" ${OVPN_CLI} get_key tun${p} \
+				$((p + OVPN_ID_OFFSET)) 2
+	done
+}
+
+ovpn_run_traffic_delete_peer() {
+	local ping_pid
+
+	ovpn_log "Deleting peer while sending traffic:"
+
+	ovpn_run_bg ping_pid ip netns exec ovpn_peer2 ping -qf -w 4 5.5.5.1
+	sleep 2
+	ovpn_cmd_ok "delete peer0 peer 2" \
+		ip netns exec ovpn_peer0 ${OVPN_CLI} del_peer tun0 2
+
+	if [ "${OVPN_PROTO}" == "TCP" ]; then
+		# In TCP mode this command is expected to fail for both peers.
+		ovpn_cmd_mayfail "delete peer2 peer 2 (TCP non-fatal)" \
+			ip netns exec ovpn_peer2 ${OVPN_CLI} del_peer tun2 \
+				$((2 + OVPN_ID_OFFSET))
+	else
+		ovpn_cmd_ok "delete peer2 peer 2" ip netns exec ovpn_peer2 \
+			${OVPN_CLI} del_peer tun2 $((2 + OVPN_ID_OFFSET))
+	fi
+
+	wait "${ping_pid}" || true
+}
+
+ovpn_run_key_cleanup() {
+	local p
+	local peer_ns
+
+	ovpn_log "Deleting keys:"
+
+	for p in $(seq 3 ${OVPN_NUM_PEERS}); do
+		peer_ns="ovpn_peer${p}"
+		ovpn_cmd_ok "delete key 1 for peer${p}" \
+			ip netns exec "${peer_ns}" ${OVPN_CLI} del_key tun${p} \
+				$((p + OVPN_ID_OFFSET)) 1
+		ovpn_cmd_ok "delete key 2 for peer${p}" \
+			ip netns exec "${peer_ns}" ${OVPN_CLI} del_key tun${p} \
+				$((p + OVPN_ID_OFFSET)) 2
+	done
+}
+
+ovpn_run_timeouts() {
+	local p
+	local peer_ns
+
+	ovpn_log "Setting timeout to 3s MP:"
+
+	for p in $(seq 3 ${OVPN_NUM_PEERS}); do
+		# Non-fatal: this may fail in some protocol modes.
+		ovpn_cmd_mayfail "set peer0 timeout for peer ${p} (non-fatal)" \
+			ip netns exec ovpn_peer0 ${OVPN_CLI} set_peer tun0 \
+				${p} 3 3
+		peer_ns="ovpn_peer${p}"
+		ovpn_cmd_ok "disable timeout on peer${p} while peer0 adjusts \
+			state" ip netns exec "${peer_ns}" ${OVPN_CLI} set_peer \
+			tun${p} $((p + OVPN_ID_OFFSET)) 0 0
+	done
+	# wait for peers to timeout
+	sleep 5
+
+	ovpn_log "Setting timeout to 3s P2P:"
+
+	for p in $(seq 3 ${OVPN_NUM_PEERS}); do
+		peer_ns="ovpn_peer${p}"
+		ovpn_cmd_ok "set peer${p} P2P timeout" \
+			ip netns exec "${peer_ns}" ${OVPN_CLI} set_peer \
+				tun${p} $((p + OVPN_ID_OFFSET)) 3 3
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
+[ "${OVPN_FLOAT}" == "1" ] && ovpn_run_stage "run floating peer checks" \
+	ovpn_run_float_mode
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


