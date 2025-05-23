Return-Path: <netdev+bounces-193013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C04FCAC227F
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 14:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B23616EB55
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 12:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BDF22A4D5;
	Fri, 23 May 2025 12:17:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC062F3E
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748002660; cv=none; b=DBs3vG5KIL8+XxU9O+1GLE0ZUPeW9cH3jN17l8Bqfg6z8OWfSzxLTPKbVqIzR+6jeTIkBc+fi2wFnLmZb6puFHVpSGGepecF8s1swfxMlc1Ti8b2KizFDngsRF+Ulnlt+2S1DpacVvhpxWEgNXqVgn3tLgrqWdoWEtGHW/lcydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748002660; c=relaxed/simple;
	bh=YYPNg6NvkGkgxFHE4rKfMkLJHdM/5Ev3pBsj4VHok8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sI9czHhh6Kf+vBMGUZfy9PQhQw3ORY2SAXNjGwubar6Pbmiudb+YAuU5EGvJkJ+P4m127Glz3fSEQXgfVaMznM+Jq79Mv10utd28AfW82U4EnqxYhFykLTP+2n8e5rFlCMnNnV/1e/bEAueH8A/7DpuFqJTp3aymoBhG7NLB8bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id DFCA660359; Fri, 23 May 2025 14:17:34 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next v2] selftests: netfilter: nft_queue.sh: include file transfer duration in log message
Date: Fri, 23 May 2025 14:16:57 +0200
Message-ID: <20250523121700.20011-1-fw@strlen.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Paolo Abeni says:
 Recently the nipa CI infra went through some tuning, and the mentioned
 self-test now often fails.

The failing test is the sctp+nfqueue one, where the file transfer takes
too long and hits the timeout (1 minute).

Because SCTP nfqueue tests had timeout related issues before (esp. on debug
kernels) print the file transfer duration in the PASS/FAIL message.
This would aallow us to see if there is/was an unexpected slowdown
(CI keeps logs around) or 'creeping slowdown' where things got slower
over time until 'fail point' was reached.

Output of altered lines looks like this:
  PASS: tcp and nfqueue in forward chan (duration: 2s)
  PASS: tcp via loopback (duration: 2s)
  PASS: sctp and nfqueue in forward chain (duration: 42s)
  PASS: sctp and nfqueue in output chain with GSO (duration: 21s)

Reported-by: Paolo Abeni <pabeni@redhat.com
Closes: https://lore.kernel.org/netdev/584524ef-9fd7-4326-9f1b-693ca62c5692@redhat.com/
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v2: keep timeout as-is, 1m seems to be enough after all and only
     increase verbosity of the PASS/FAIL messages.

 .../selftests/net/netfilter/nft_queue.sh      | 38 +++++++++++++++----
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_queue.sh b/tools/testing/selftests/net/netfilter/nft_queue.sh
index 784d1b46912b..6136ceec45e0 100755
--- a/tools/testing/selftests/net/netfilter/nft_queue.sh
+++ b/tools/testing/selftests/net/netfilter/nft_queue.sh
@@ -10,6 +10,8 @@ source lib.sh
 ret=0
 timeout=5
 
+SCTP_TEST_TIMEOUT=60
+
 cleanup()
 {
 	ip netns pids "$ns1" | xargs kill 2>/dev/null
@@ -40,7 +42,7 @@ TMPFILE3=$(mktemp)
 
 TMPINPUT=$(mktemp)
 COUNT=200
-[ "$KSFT_MACHINE_SLOW" = "yes" ] && COUNT=25
+[ "$KSFT_MACHINE_SLOW" = "yes" ] && COUNT=$((COUNT/8))
 dd conv=sparse status=none if=/dev/zero bs=1M count=$COUNT of="$TMPINPUT"
 
 if ! ip link add veth0 netns "$nsrouter" type veth peer name eth0 netns "$ns1" > /dev/null 2>&1; then
@@ -275,9 +277,11 @@ test_tcp_forward()
 	busywait "$BUSYWAIT_TIMEOUT" listener_ready "$ns2"
 	busywait "$BUSYWAIT_TIMEOUT" nf_queue_wait "$nsrouter" 2
 
+	local tthen=$(date +%s)
+
 	ip netns exec "$ns1" socat -u STDIN TCP:10.0.2.99:12345 <"$TMPINPUT" >/dev/null
 
-	wait "$rpid" && echo "PASS: tcp and nfqueue in forward chain"
+	wait_and_check_retval "$rpid" "tcp and nfqueue in forward chain" "$tthen"
 	kill "$nfqpid"
 }
 
@@ -288,13 +292,14 @@ test_tcp_localhost()
 
 	ip netns exec "$nsrouter" ./nf_queue -q 3 &
 	local nfqpid=$!
+	local tthen=$(date +%s)
 
 	busywait "$BUSYWAIT_TIMEOUT" listener_ready "$nsrouter"
 	busywait "$BUSYWAIT_TIMEOUT" nf_queue_wait "$nsrouter" 3
 
 	ip netns exec "$nsrouter" socat -u STDIN TCP:127.0.0.1:12345 <"$TMPINPUT" >/dev/null
 
-	wait "$rpid" && echo "PASS: tcp via loopback"
+	wait_and_check_retval "$rpid" "tcp via loopback" "$tthen"
 	kill "$nfqpid"
 }
 
@@ -417,6 +422,23 @@ check_output_files()
 	fi
 }
 
+wait_and_check_retval()
+{
+	local rpid="$1"
+	local msg="$2"
+	local tthen="$3"
+	local tnow=$(date +%s)
+
+	if wait "$rpid";then
+		echo -n "PASS: "
+	else
+		echo -n "FAIL: "
+		ret=1
+	fi
+
+	printf "%s (duration: %ds)\n" "$msg" $((tnow-tthen))
+}
+
 test_sctp_forward()
 {
 	ip netns exec "$nsrouter" nft -f /dev/stdin <<EOF
@@ -428,13 +450,14 @@ table inet sctpq {
         }
 }
 EOF
-	timeout 60 ip netns exec "$ns2" socat -u SCTP-LISTEN:12345 STDOUT > "$TMPFILE1" &
+	timeout "$SCTP_TEST_TIMEOUT" ip netns exec "$ns2" socat -u SCTP-LISTEN:12345 STDOUT > "$TMPFILE1" &
 	local rpid=$!
 
 	busywait "$BUSYWAIT_TIMEOUT" sctp_listener_ready "$ns2"
 
 	ip netns exec "$nsrouter" ./nf_queue -q 10 -G &
 	local nfqpid=$!
+	local tthen=$(date +%s)
 
 	ip netns exec "$ns1" socat -u STDIN SCTP:10.0.2.99:12345 <"$TMPINPUT" >/dev/null
 
@@ -443,7 +466,7 @@ EOF
 		exit 1
 	fi
 
-	wait "$rpid" && echo "PASS: sctp and nfqueue in forward chain"
+	wait_and_check_retval "$rpid" "sctp and nfqueue in forward chain" "$tthen"
 	kill "$nfqpid"
 
 	check_output_files "$TMPINPUT" "$TMPFILE1" "sctp forward"
@@ -462,13 +485,14 @@ EOF
 	# reduce test file size, software segmentation causes sk wmem increase.
 	dd conv=sparse status=none if=/dev/zero bs=1M count=$((COUNT/2)) of="$TMPINPUT"
 
-	timeout 60 ip netns exec "$ns2" socat -u SCTP-LISTEN:12345 STDOUT > "$TMPFILE1" &
+	timeout "$SCTP_TEST_TIMEOUT" ip netns exec "$ns2" socat -u SCTP-LISTEN:12345 STDOUT > "$TMPFILE1" &
 	local rpid=$!
 
 	busywait "$BUSYWAIT_TIMEOUT" sctp_listener_ready "$ns2"
 
 	ip netns exec "$ns1" ./nf_queue -q 11 &
 	local nfqpid=$!
+	local tthen=$(date +%s)
 
 	ip netns exec "$ns1" socat -u STDIN SCTP:10.0.2.99:12345 <"$TMPINPUT" >/dev/null
 
@@ -478,7 +502,7 @@ EOF
 	fi
 
 	# must wait before checking completeness of output file.
-	wait "$rpid" && echo "PASS: sctp and nfqueue in output chain with GSO"
+	wait_and_check_retval "$rpid" "sctp and nfqueue in output chain with GSO" "$tthen"
 	kill "$nfqpid"
 
 	check_output_files "$TMPINPUT" "$TMPFILE1" "sctp output"
-- 
2.49.0


