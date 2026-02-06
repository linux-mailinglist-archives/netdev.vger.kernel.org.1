Return-Path: <netdev+bounces-257489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOiqNZGjhWmSEQQAu9opvQ
	(envelope-from <netdev+bounces-257489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 09:17:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB0FFB5AB
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 09:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A4543020EB2
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 08:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EC433F395;
	Fri,  6 Feb 2026 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIJpk2s3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEA230ACEE
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770365837; cv=none; b=CjFL0fru17feJjpUEp6qhAmb2g3f+lnJAMkz+sjYU89lhzX2QtSNYBd/q2HGUbI5s1CnMubvi3gmwdkQG6iAcFfp2EeYhks7IbMSKhCKuIWUE1y4To90CMERGNEezIq88q1Mpt6E6NC2I9DZUYTHWUP0hFT7ZyV8GwJ/RmGkUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770365837; c=relaxed/simple;
	bh=c7PQOE0iMHjHxkRzpLy5wyWcpXy4hEdVWeuqSuOUeEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ODahTZiZFbpqM/dQyJmwfDQY2EpsIEzBU9Z2W3s/GyW7CqqlMZKnnaP7/TnPIQMDDa9J2M8+4aYVIjdYqb/pAEy0JPHgY4FgNCW09SyTuIIIGtolSRymetMmMMMxJC4o29jeABPI9h96OyS1V04UFQXnjiDEYbHi36uYC4jb8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIJpk2s3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35456fcb79cso1048537a91.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 00:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770365837; x=1770970637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JCT2HUHLs8OeyVWtYlHn7qjboQomP4IpKbaE1KAoCHE=;
        b=NIJpk2s3BuWEugfJ3uNVac7Z1peetzh4UaiRtalaUgYRqOehJX2+WQfNZ6HNVict5X
         ZoBktA9aDwE0Suoz7OMFX3uqdEQp+ackhi4SRNveEKICqOqwOsPe8JYoTVXE5eLE90BX
         HABzf47ZuR4+tB0k9TaWSb+sm1tHz3Qnc8plEt56fQoWNe3USqMVc7mq7GFHjURM9rwW
         91uvLj8LAn4GmAaZcpcp/D4624E8JyS4SkYLnvN9abRjHSACVSP9NpB/fyVqa4FotZf7
         u71Heus0UUw3YT3W9l3z4ppRvc1LoRYFB09OSfNPXjlEZl4dHcxvrF5QAVMilTQBcibP
         EYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770365837; x=1770970637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCT2HUHLs8OeyVWtYlHn7qjboQomP4IpKbaE1KAoCHE=;
        b=YhpYolX7PvQ+svlCjUpLi+jB84z0aW3gexwy9gBSvwUdpzfmppo2hMUni7YQOMDyhZ
         SjFiCRhTXqcZN136/75Chc7kf1Nu00lyuHm7cQn6h6vD9dk7XoFbOmaWOra9+4y3JP/I
         5zn5gnnJfnFnAxUaCWEcdeU5QRO9rAwkHvQl24ulsTvwXux9WBHJWMEynnAmDIEtD1xI
         PS0JKAACnuS2O9VPNFwuTdgcDKpDBwc828zDsQ9YPqYynG7LpwJDSg+/fFx6/+RAJ4qD
         2PWYGjYf7N9M/3O3fBmTr/B9QrpOzXoDM9Ej2lDjm5GHc+nNDtcwxMy05ShqY8l6Shdl
         Q9VA==
X-Forwarded-Encrypted: i=1; AJvYcCXBlG0zATfxhPyMnD4kv3C8exYBFyHSzKQI+Tm57CiBbsdIOJNM220HsRd4JffQ67HVH4zHBCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgIvqi4Q/NQCoAVe4f5L6RR66pXX2ljQynyWGevvRjSsNtCrwK
	DqZpHj5sH8YTct2BglDtgfx81KIb2WNhZIEODMbVuLQ0QZd+zF3MhAJs
X-Gm-Gg: AZuq6aLc8F5S1VL13WJOq3InRo4wgr3YUtih5bLvZ83o+uOsanxLFDPkSGW8dI3okBb
	GhfoDmF3Df6zOAvyLO5T8mzq2b89KrdzWvJO5JqlHhvP6PQ2fGE4bdjfOc/LK2mo8pgQX8vNO5X
	ut5oLPoNODQc7XPGfVMb570IyPWucOLSgbF5yAX6PM17Rms4SfXZeDVceDkd6/WRqlR8zoT6q1x
	HnBoD/WobPn3dSP9yWMZeMxElQR/6aNTZDtfBbCFisYNKXEeBq5ELWzk2oxPBG2jIJh7gDNGRJS
	QVD6+Twg08KFnTmFVcpAC/CBfL/D8FgZo58lWk3Bs9RXlDoKJDUPcdKhH6AH7lmdqit/WQ2zhed
	wtO5e3XGUE6v/oAeVBaZon7n7tmgJn93gQCL4ksYdfgVTxUn0nTFSm99OYHq6MRq8phOX1bS9f4
	ZlLWD3fDcysvm3r08=
X-Received: by 2002:a17:90b:2fc3:b0:354:a1bc:f99b with SMTP id 98e67ed59e1d1-354b3e15243mr1655063a91.37.1770365836747;
        Fri, 06 Feb 2026 00:17:16 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b4686dfesm755671a91.11.2026.02.06.00.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 00:17:15 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	netdev@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH selftests] selftests: Use ktap helpers for runner.sh
Date: Fri,  6 Feb 2026 08:17:04 +0000
Message-ID: <20260206081704.53215-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257489-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[runner.sh:url,run_kselftest.sh:url]
X-Rspamd-Queue-Id: 4EB0FFB5AB
X-Rspamd-Action: no action

This has been on my todo list for a long time. We should use ktap
helpers in runner.sh. I saw Brendan did some work in d9e6269e3303
("selftests/run_kselftest.sh: exit with error if tests fail") to make
run_kselftest.sh exit with the correct return value. But we still use a
custom solution in runner.sh. Let's convert all the print messages to use
formal ktap helpers. Here’s what I changed:

  1. Move TAP header from runner.sh to run_kselftest.sh, since run_kselftest.sh
     is the only caller of run_many().
  2. In run_kselftest.sh, call run_many() in main process to count the
     pass/fail numbers.
  3. In run_kselftest.sh, do not generate kselftest_failures_file; just
     use ktap_print_totals to report the result.
  4. In runner.sh run_one(), get the return value and use ktap helpers for
     all pass/fail reporting. This allows counting pass/fail numbers in the
     main process.
  5. In runner.sh run_in_netns(), also return the correct rc, so we can
     count results during wait.

After the change, the printed result looks like:

  not ok 4 4 selftests: clone3: clone3_cap_checkpoint_restore # exit=1
  # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0

  ]# echo $?
  1

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/kselftest/runner.sh | 83 ++++++++++++---------
 tools/testing/selftests/run_kselftest.sh    | 21 ++++--
 2 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 3a62039fa621..f3307f2d1f48 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -1,8 +1,8 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 #
 # Runs a set of tests in a given subdirectory.
-export skip_rc=4
+. $(dirname "$(readlink -e "${BASH_SOURCE[0]}")")/ktap_helpers.sh
 export timeout_rc=124
 export logfile=/dev/stdout
 export per_test_logging=
@@ -44,17 +44,11 @@ tap_timeout()
 	fi
 }
 
-report_failure()
-{
-	echo "not ok $*"
-	echo "$*" >> "$kselftest_failures_file"
-}
-
 run_one()
 {
 	DIR="$1"
 	TEST="$2"
-	local test_num="$3"
+	local rc test_num="$3"
 
 	BASENAME_TEST=$(basename $TEST)
 
@@ -102,16 +96,17 @@ run_one()
 	# Command line timeout overrides the settings file
 	if [ -n "$kselftest_override_timeout" ]; then
 		kselftest_timeout="$kselftest_override_timeout"
-		echo "# overriding timeout to $kselftest_timeout" >> "$logfile"
+		ktap_print_msg "overriding timeout to $kselftest_timeout" >> "$logfile"
 	else
-		echo "# timeout set to $kselftest_timeout" >> "$logfile"
+		ktap_print_msg "timeout set to $kselftest_timeout" >> "$logfile"
 	fi
 
 	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
 	echo "# $TEST_HDR_MSG"
 	if [ ! -e "$TEST" ]; then
-		echo "# Warning: file $TEST is missing!"
-		report_failure "$test_num $TEST_HDR_MSG"
+		ktap_print_msg "Warning: file $TEST is missing!"
+		ktap_test_fail "$test_num $TEST_HDR_MSG"
+		rc=$KSFT_FAIL
 	else
 		if [ -x /usr/bin/stdbuf ]; then
 			stdbuf="/usr/bin/stdbuf --output=L "
@@ -122,33 +117,37 @@ run_one()
 		elif [ -x "./ksft_runner.sh" ]; then
 			cmd="$stdbuf ./ksft_runner.sh ./$BASENAME_TEST"
 		else
-			echo "# Warning: file $TEST is not executable"
+			ktap_print_msg "Warning: file $TEST is not executable"
 
 			if [ $(head -n 1 "$TEST" | cut -c -2) = "#!" ]
 			then
 				interpreter=$(head -n 1 "$TEST" | cut -c 3-)
 				cmd="$stdbuf $interpreter ./$BASENAME_TEST"
 			else
-				report_failure "$test_num $TEST_HDR_MSG"
-				return
+				ktap_test_fail "$test_num $TEST_HDR_MSG"
+				return $KSFT_FAIL
 			fi
 		fi
 		cd `dirname $TEST` > /dev/null
-		((((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
+		(((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
 			tap_prefix >&4) 3>&1) |
-			(read xs; exit $xs)) 4>>"$logfile" &&
-		echo "ok $test_num $TEST_HDR_MSG") ||
-		(rc=$?;	\
-		if [ $rc -eq $skip_rc ]; then	\
-			echo "ok $test_num $TEST_HDR_MSG # SKIP"
-		elif [ $rc -eq $timeout_rc ]; then \
-			echo "#"
-			report_failure "$test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout seconds"
+			(read xs; exit $xs)) 4>>"$logfile"
+		rc=$?
+		if [ "$rc" -eq "$KSFT_PASS" ]; then
+			ktap_test_pass "$test_num $TEST_HDR_MSG"
+		elif [ "$rc" -eq "$KSFT_SKIP" ]; then
+			ktap_test_skip "$test_num $TEST_HDR_MSG"
+		elif [ "$rc" -eq "$KSFT_XFAIL" ]; then
+			ktap_test_xfail "$test_num $TEST_HDR_MSG"
+		elif [ "$rc" -eq "$timeout_rc" ]; then
+			ktap_test_fail "$test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout seconds"
 		else
-			report_failure "$test_num $TEST_HDR_MSG # exit=$rc"
-		fi)
+			ktap_test_fail "$test_num $TEST_HDR_MSG # exit=$rc"
+		fi
 		cd - >/dev/null
 	fi
+
+	return $rc
 }
 
 in_netns()
@@ -164,27 +163,34 @@ in_netns()
 
 run_in_netns()
 {
-	local netns=$(mktemp -u ${BASENAME_TEST}-XXXXXX)
 	local tmplog="/tmp/$(mktemp -u ${BASENAME_TEST}-XXXXXX)"
+	local netns=$(mktemp -u ${BASENAME_TEST}-XXXXXX)
+	local rc
+
 	ip netns add $netns
 	if [ $? -ne 0 ]; then
-		echo "# Warning: Create namespace failed for $BASENAME_TEST"
-		echo "not ok $test_num selftests: $DIR: $BASENAME_TEST # Create NS failed"
+		ktap_print_msg "Warning: Create namespace failed for $BASENAME_TEST"
+		ktap_test_fail "$test_num selftests: $DIR: $BASENAME_TEST # Create NS failed"
 	fi
 	ip -n $netns link set lo up
+
 	in_netns $netns &> $tmplog
+	rc=$?
+
 	ip netns del $netns &> /dev/null
+	# Cat the log at once to avoid parallel netns logs.
 	cat $tmplog
 	rm -f $tmplog
+	return $rc
 }
 
 run_many()
 {
-	echo "TAP version 13"
 	DIR="${PWD#${BASE_DIR}/}"
 	test_num=0
-	total=$(echo "$@" | wc -w)
-	echo "1..$total"
+	local rc
+	pids=()
+
 	for TEST in "$@"; do
 		BASENAME_TEST=$(basename $TEST)
 		test_num=$(( test_num + 1 ))
@@ -194,10 +200,19 @@ run_many()
 		fi
 		if [ -n "$RUN_IN_NETNS" ]; then
 			run_in_netns &
+			pids+=($!)
 		else
 			run_one "$DIR" "$TEST" "$test_num"
 		fi
 	done
 
-	wait
+	# Handle the return values when running in netns.
+	for pid in "${pids[@]}"; do
+		wait "$pid"
+		rc=$?
+		[ "$rc" -eq "$KSFT_PASS" ] && KTAP_CNT_PASS=$((KTAP_CNT_PASS+1))
+		[ "$rc" -eq "$KSFT_FAIL" ] && KTAP_CNT_FAIL=$((KTAP_CNT_FAIL+1))
+		[ "$rc" -eq "$KSFT_SKIP" ] && KTAP_CNT_SKIP=$((KTAP_CNT_SKIP+1))
+		[ "$rc" -eq "$KSFT_XFAIL" ] && KTAP_CNT_XFAIL=$((KTAP_CNT_XFAIL+1))
+	done
 }
diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
index d4be97498b32..10930d09f2a5 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -110,18 +110,23 @@ if [ -n "$TESTS" ]; then
 	available="$(echo "$valid" | sed -e 's/ /\n/g')"
 fi
 
-kselftest_failures_file="$(mktemp --tmpdir kselftest-failures-XXXXXX)"
-export kselftest_failures_file
-
+curdir=$(pwd)
+total=$(echo "$available" | wc -w)
 collections=$(echo "$available" | cut -d: -f1 | sort | uniq)
+
+ktap_print_header
+ktap_set_plan "$total"
+
 for collection in $collections ; do
 	[ -w /dev/kmsg ] && echo "kselftest: Running tests in $collection" >> /dev/kmsg
 	tests=$(echo "$available" | grep "^$collection:" | cut -d: -f2)
-	($dryrun cd "$collection" && $dryrun run_many $tests)
+	$dryrun cd "$collection" && $dryrun run_many $tests
+	$dryrun cd "$curdir"
 done
 
-failures="$(cat "$kselftest_failures_file")"
-rm "$kselftest_failures_file"
-if "$ERROR_ON_FAIL" && [ "$failures" ]; then
-	exit 1
+ktap_print_totals
+if "$ERROR_ON_FAIL" && [ "$KTAP_CNT_FAIL" -ne 0 ]; then
+	exit "$KSFT_FAIL"
+else
+	exit "$KSFT_PASS"
 fi
-- 
2.50.1


