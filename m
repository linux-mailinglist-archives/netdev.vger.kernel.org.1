Return-Path: <netdev+bounces-44920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16CC7DA3E3
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B682826F3
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E8941AA7;
	Fri, 27 Oct 2023 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O96sV1i3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3AC41AA1;
	Fri, 27 Oct 2023 22:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE76C433CB;
	Fri, 27 Oct 2023 22:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698447443;
	bh=zCPFw32MQoNUIdTL34FO8e2tOrxOjgtQ275K/Av8apw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O96sV1i38k9XfIyhCKM8pD4/UHoFVPBqtcUnxxSloSF5tdCz57V/nn3EkLPal5Ox8
	 x5Ujjc8tSb1rBMgi9zGxuU5H3V5FMna8thtScX61NVEcoWPHKNigJsjGoGck1pTX0r
	 FG2axBcYeunl1dqltjjKmsgCaK1cnMIbDDG46hUUlX2goRJvQENZ1qPwKkNu4uE5C5
	 cqEJnbmDATiRsSvOESe15t0MTkVm5flHsCNHO0d0qN8W9HbpkGCOr/UaMzYmlKsqPs
	 r8K1RrqG+KC0pr7wI91rci3kJc/s9+PnLWd/jccjIu6/lPFPCsM9WmMMNSrZs1eNId
	 5EnC+BCbLJ0iQ==
From: Mat Martineau <martineau@kernel.org>
Date: Fri, 27 Oct 2023 15:57:16 -0700
Subject: [PATCH net-next 15/15] selftests: mptcp: add
 mptcp_lib_wait_local_port_listen
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-send-net-next-2023107-v1-15-03eff9452957@kernel.org>
References: <20231027-send-net-next-2023107-v1-0-03eff9452957@kernel.org>
In-Reply-To: <20231027-send-net-next-2023107-v1-0-03eff9452957@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

To avoid duplicated code in different MPTCP selftests, we can add
and use helpers defined in mptcp_lib.sh.

wait_local_port_listen() helper is defined in diag.sh, mptcp_connect.sh,
mptcp_join.sh and simult_flows.sh, export it into mptcp_lib.sh and
rename it with mptcp_lib_ prefix. Use this new helper in all these
scripts.

Note: We only have IPv4 connections in this helper, not looking at IPv6
(tcp6) but that's OK because we only have IPv4 connections here in diag.sh.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 23 +++-------------------
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 19 +-----------------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 20 +------------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 18 +++++++++++++++++
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 19 +-----------------
 5 files changed, 24 insertions(+), 75 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 85a8ee9395b3..95b498efacd1 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -182,23 +182,6 @@ chk_msk_inuse()
 	__chk_nr get_msk_inuse $expected "$msg" 0
 }
 
-# $1: ns, $2: port
-wait_local_port_listen()
-{
-	local listener_ns="${1}"
-	local port="${2}"
-
-	local port_hex i
-
-	port_hex="$(printf "%04X" "${port}")"
-	for i in $(seq 10); do
-		ip netns exec "${listener_ns}" cat /proc/net/tcp | \
-			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
-			break
-		sleep 0.1
-	done
-}
-
 wait_connected()
 {
 	local listener_ns="${1}"
@@ -222,7 +205,7 @@ echo "a" | \
 		ip netns exec $ns \
 			./mptcp_connect -p 10000 -l -t ${timeout_poll} -w 20 \
 				0.0.0.0 >/dev/null &
-wait_local_port_listen $ns 10000
+mptcp_lib_wait_local_port_listen $ns 10000
 chk_msk_nr 0 "no msk on netns creation"
 chk_msk_listen 10000
 
@@ -245,7 +228,7 @@ echo "a" | \
 		ip netns exec $ns \
 			./mptcp_connect -p 10001 -l -s TCP -t ${timeout_poll} -w 20 \
 				0.0.0.0 >/dev/null &
-wait_local_port_listen $ns 10001
+mptcp_lib_wait_local_port_listen $ns 10001
 echo "b" | \
 	timeout ${timeout_test} \
 		ip netns exec $ns \
@@ -266,7 +249,7 @@ for I in `seq 1 $NR_CLIENTS`; do
 				./mptcp_connect -p $((I+10001)) -l -w 20 \
 					-t ${timeout_poll} 0.0.0.0 >/dev/null &
 done
-wait_local_port_listen $ns $((NR_CLIENTS + 10001))
+mptcp_lib_wait_local_port_listen $ns $((NR_CLIENTS + 10001))
 
 for I in `seq 1 $NR_CLIENTS`; do
 	echo "b" | \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 537f180aa51e..7898d62fce0b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -310,23 +310,6 @@ do_ping()
 	return 0
 }
 
-# $1: ns, $2: port
-wait_local_port_listen()
-{
-	local listener_ns="${1}"
-	local port="${2}"
-
-	local port_hex i
-
-	port_hex="$(printf "%04X" "${port}")"
-	for i in $(seq 10); do
-		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
-			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
-			break
-		sleep 0.1
-	done
-}
-
 do_transfer()
 {
 	local listener_ns="$1"
@@ -408,7 +391,7 @@ do_transfer()
 				$extra_args $local_addr < "$sin" > "$sout" &
 	local spid=$!
 
-	wait_local_port_listen "${listener_ns}" "${port}"
+	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	local start
 	start=$(date +%s%3N)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index cd3412eac8a7..995280882428 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -580,24 +580,6 @@ link_failure()
 	done
 }
 
-# $1: ns, $2: port
-wait_local_port_listen()
-{
-	local listener_ns="${1}"
-	local port="${2}"
-
-	local port_hex
-	port_hex="$(printf "%04X" "${port}")"
-
-	local i
-	for i in $(seq 10); do
-		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
-			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
-			break
-		sleep 0.1
-	done
-}
-
 rm_addr_count()
 {
 	mptcp_lib_get_counter "${1}" "MPTcpExtRmAddr"
@@ -1082,7 +1064,7 @@ do_transfer()
 	fi
 	local spid=$!
 
-	wait_local_port_listen "${listener_ns}" "${port}"
+	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	extra_cl_args="$extra_args $extra_cl_args"
 	if [ "$test_linkfail" -eq 0 ];then
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 9e51b9471d3a..1f8be9dd0e20 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -281,3 +281,21 @@ mptcp_lib_check_transfer() {
 
 	return 0
 }
+
+# $1: ns, $2: port
+mptcp_lib_wait_local_port_listen() {
+	local listener_ns="${1}"
+	local port="${2}"
+
+	local port_hex
+	port_hex="$(printf "%04X" "${port}")"
+
+	local _
+	for _ in $(seq 10); do
+		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
+			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) \
+			     {rc=0; exit}} END {exit rc}" &&
+			break
+		sleep 0.1
+	done
+}
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ce9203b817f8..ae8ad5d6fb9d 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -123,23 +123,6 @@ setup()
 	grep -q ' kmemleak_init$\| lockdep_init$\| kasan_init$\| prove_locking$' /proc/kallsyms && slack=$((slack+550))
 }
 
-# $1: ns, $2: port
-wait_local_port_listen()
-{
-	local listener_ns="${1}"
-	local port="${2}"
-
-	local port_hex i
-
-	port_hex="$(printf "%04X" "${port}")"
-	for i in $(seq 10); do
-		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
-			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
-			break
-		sleep 0.1
-	done
-}
-
 do_transfer()
 {
 	local cin=$1
@@ -179,7 +162,7 @@ do_transfer()
 				0.0.0.0 < "$sin" > "$sout" &
 	local spid=$!
 
-	wait_local_port_listen "${ns3}" "${port}"
+	mptcp_lib_wait_local_port_listen "${ns3}" "${port}"
 
 	timeout ${timeout_test} \
 		ip netns exec ${ns1} \

-- 
2.41.0


