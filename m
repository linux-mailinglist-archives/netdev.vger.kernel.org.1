Return-Path: <netdev+bounces-192665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF392AC0BED
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4FC500660
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E921279784;
	Thu, 22 May 2025 12:48:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB98114F70
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747918139; cv=none; b=rWPSfdJIgFEbzBKMbogv0kGoMoRhUnSqHpMuPoyVdysTcIM+ZQ3InvzPqb216XP9OdDIAS1ycYYo9URfMC4KR3M/88TOyaNABQCvjt9IjPloA0UQ28reL3oXQOYRtUpFYM76ZcVKinA2qr40LehGkaKsV80axYmiz66D5ZRB9vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747918139; c=relaxed/simple;
	bh=RMRPqSF5DudTX4u2EQEianfeIPf4h3SPSo0gKXLhQh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdfbXnXYI6Y+LF+lsmsP4g2EsC4UX9NNi1+5atuLHlJq7He9voeXNKofBJhq3ww2UC2A9lHiryiMCeY61ACBMk7fu73GXnMrU/Uoac5GrAo65mZ7tnHkK6GQqT6iZ58F4kFvQ/7mVV7eZ8170dR57Z6+uFf8+5On02S1s0DxHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8784060145; Thu, 22 May 2025 14:48:48 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] selftests: netfilter: nft_queue.sh: double sctp test timeout
Date: Thu, 22 May 2025 16:46:25 +0200
Message-ID: <20250522144647.11961-1-fw@strlen.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <584524ef-9fd7-4326-9f1b-693ca62c5692@redhat.com>
References: <584524ef-9fd7-4326-9f1b-693ca62c5692@redhat.com>
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

 As I could not find any applied or pending relevant change, I have a
 vague suspect that the timeout applied to the server command now
 triggers due to different timing. Could you please have a look?

Double timeouts for sctp even for standard kernel build.
For MACHINE_SLOW, reduce both file transfer size (no change)
but increase the timeout too.

Because SCTP nfqueue tests had timeout related issues before (esp. on debug
kernels) also print the file transfer duration in the PASS/FAIL message.
This would also allow us to see if there is/was an unexpected slowdown
(NIPA keeps logs around).

Output of altered lines now looks like this:
  PASS: tcp and nfqueue in forward chan (duration: 2s)
  PASS: tcp via loopback (duration: 2s)
  PASS: sctp and nfqueue in forward chain (duration: 42s)
  PASS: sctp and nfqueue in output chain with GSO (duration: 21s)

No fixes tag, there were no changes in nfqueue in quite some time.
As the test isn't failing for me even without this change I have no
reason to suspect a breaking change on sctp side either.

Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/netdev/584524ef-9fd7-4326-9f1b-693ca62c5692@redhat.com/
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Also applies to net-next.

 .../selftests/net/netfilter/nft_queue.sh      | 43 ++++++++++++++++---
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_queue.sh b/tools/testing/selftests/net/netfilter/nft_queue.sh
index 784d1b46912b..eceb443f0eb0 100755
--- a/tools/testing/selftests/net/netfilter/nft_queue.sh
+++ b/tools/testing/selftests/net/netfilter/nft_queue.sh
@@ -10,6 +10,8 @@ source lib.sh
 ret=0
 timeout=5
 
+SCTP_TEST_TIMEOUT=120
+
 cleanup()
 {
 	ip netns pids "$ns1" | xargs kill 2>/dev/null
@@ -40,7 +42,12 @@ TMPFILE3=$(mktemp)
 
 TMPINPUT=$(mktemp)
 COUNT=200
-[ "$KSFT_MACHINE_SLOW" = "yes" ] && COUNT=25
+
+if [ "$KSFT_MACHINE_SLOW" = "yes" ];then
+	COUNT=$((COUNT/4))
+	SCTP_TEST_TIMEOUT=$((SCTP_TEST_TIMEOUT*4))
+fi
+
 dd conv=sparse status=none if=/dev/zero bs=1M count=$COUNT of="$TMPINPUT"
 
 if ! ip link add veth0 netns "$nsrouter" type veth peer name eth0 netns "$ns1" > /dev/null 2>&1; then
@@ -275,9 +282,11 @@ test_tcp_forward()
 	busywait "$BUSYWAIT_TIMEOUT" listener_ready "$ns2"
 	busywait "$BUSYWAIT_TIMEOUT" nf_queue_wait "$nsrouter" 2
 
+	local tthen=$(date +%s)
+
 	ip netns exec "$ns1" socat -u STDIN TCP:10.0.2.99:12345 <"$TMPINPUT" >/dev/null
 
-	wait "$rpid" && echo "PASS: tcp and nfqueue in forward chain"
+	wait_and_check_retval "$rpid" "tcp and nfqueue in forward chain" "$tthen"
 	kill "$nfqpid"
 }
 
@@ -288,13 +297,14 @@ test_tcp_localhost()
 
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
 
@@ -417,6 +427,23 @@ check_output_files()
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
@@ -428,13 +455,14 @@ table inet sctpq {
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
 
@@ -443,7 +471,7 @@ EOF
 		exit 1
 	fi
 
-	wait "$rpid" && echo "PASS: sctp and nfqueue in forward chain"
+	wait_and_check_retval "$rpid" "sctp and nfqueue in forward chain" "$tthen"
 	kill "$nfqpid"
 
 	check_output_files "$TMPINPUT" "$TMPFILE1" "sctp forward"
@@ -462,13 +490,14 @@ EOF
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
 
@@ -478,7 +507,7 @@ EOF
 	fi
 
 	# must wait before checking completeness of output file.
-	wait "$rpid" && echo "PASS: sctp and nfqueue in output chain with GSO"
+	wait_and_check_retval "$rpid" "sctp and nfqueue in output chain with GSO" "$tthen"
 	kill "$nfqpid"
 
 	check_output_files "$TMPINPUT" "$TMPFILE1" "sctp output"
-- 
2.49.0


