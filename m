Return-Path: <netdev+bounces-260327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id e3sPMdUknWkzNAQAu9opvQ
	(envelope-from <netdev+bounces-260327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:11:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F8F181954
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EB913036768
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2B823EAA0;
	Tue, 24 Feb 2026 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxzOOOpZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441854F881
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771906257; cv=none; b=Q/xOg35nVkTtrwonAsAJFQ2AmT4TZQibQMM6RUXyJC1izYzpwiBgHIl71GcIKWtuksO1lbjXaqo1Rj+igYzXRuL5cr4qp5WdQlcNp5lscDLF/gdJ7TXZEtZPCvbAWfZV5GWxvuS3qfEnwFgkCTxd3CnaTKIFl3n4BbNmFbHYMfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771906257; c=relaxed/simple;
	bh=zr/bcPLe9uouP9PwhEMP3/FpLnN/SDUM8I/Wgd6JTyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JSpeZJc4knwmvzi7wPBizXd61KyT3GB3V2aOB/VYDHHm6x5O32+sKbr5KK408cu6+E+3MkjbxLpXClTtdgguRoPqTfK3/eSOUcZPje2FD7vjh3ywaNwoMbGVvAqpUA8aBiyI+x8NrNw3BRcJVoeF8sJJaQGqiYzUIbIgJAk+6u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxzOOOpZ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82318b640beso2610495b3a.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 20:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771906255; x=1772511055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UqIkKFYUe31rOenAwyRKOQnlZ80WMkRSpxM9YLiUBz4=;
        b=bxzOOOpZz9OV6PHI1npCzI57IpoYZ7tcV+6S4kDcDj//dtb0foO+878lWdzbjYi/BL
         PGtfcJLL2WyeBgpC/eGxA8uPd6uENzQ2hRP9t63FJzwdoq6CkS8eqhTxW6D6xSqJfDEi
         AfNV/SPo33Mg0BpP1Ntrvk/X2bpsTgIRp0BaK9j70CMNH2zoVJZANJXGItobLlqUMh+E
         wQ8dg5B1E6GhgMTwcrF77NQGdIA7haHAPDTINnUIS6+k9tWlAgq2D+v/Ehbj4Sc4NrgM
         Gb4uZNpPr1igE6zEftWMGUK0J9oAiJ3lbwF/4wcv39ghUGKzcGy7UroTIs624yFwaKu2
         S6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771906255; x=1772511055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqIkKFYUe31rOenAwyRKOQnlZ80WMkRSpxM9YLiUBz4=;
        b=qviHM5l2ksXKJqwA0OcaCNHU1ZaDWXiWZnF5R5RdDqYZRvOPBC5rJ19IMrsAGUQd0e
         bWozunw3bNBZhzYRrEnsuCU3lz3lh+jjx2A8xUW0ML49CVZl0sBSy9IBwZf+JgAgwf0Z
         xeMvb2AskEsaq7JqPxMY9Kqbwp857uCLxRf7jHvPcB5Bk7KkdVxKqKug1O51u1yUfGJY
         MttSIdrR3lhhHJ5hsILAkiCY+QzmK10hz/mtAnsI4uLy5XkkmF580WT0bbODGn7u/DXN
         NBz4ZBJ/S3g2AjQ9Qcb1vckuxlqOGTq12xRamnJvfP/G69o0rVeaa6UtpQAMJIe+5mwu
         qdGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmjKWVmi93wUsFmc6dz5TtJMLmzIRVYpSOPPrc7wGAe9HbdmFhtKqk12FmceDZ5c9q2NR/f8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrcGLqDHCksUB6y3wLeB1Pt+tgjfTj9DuvPvEnRwwUdHuEvwo
	jPEyp8Z1oFjH9FwJGgDsx78cMLMzQ/bx+ko7goQrCitd0mrZJH+WgMm9VrkddrD9
X-Gm-Gg: ATEYQzxaHRM2N9FKU/Lq+ReepZNgiFfMvIOLpNZcFBfObStTKhFIeXnZV5/gHNR7I1T
	JCxJut7C55mCLyKyXy8Z7GY4cBvEO4GPBig+oy5Kz+UJmwEE/beWDWSxEKMDQkQ+xHDvJ8BV8V4
	SyporvB48TkO4kYvHPbQga/BtJQ2TmnVyHC1V/UraaQt/7ijC7fVF54Q7fjzi8jQ2JicepqSEKP
	EQPKfR+ElJqbrPOutG/NA7rGGDkyIDRBHnQxH09knShNUU7Gej05ErqGnHAVW8cQN3SeGLIlQWD
	HjnopcKTU5guC0B4kAF3SVmfYpB/IOzYmsqGH/49BaGrkxP9ltOond9DsvM7k4+jtvlyQsrbNws
	Pwtwfiu4BH9665WmpJ3nQaeNzl6G9u9o0oZ7PeVXKlRV+NmDb8h8sMyRgwu5QBiiHkpEl0AV6jv
	1G+pOkmd5h20AsT80YaE+mwy98kfk=
X-Received: by 2002:a05:6a00:1f04:b0:824:a1c9:8a30 with SMTP id d2e1a72fcca58-826da907819mr8290551b3a.23.1771906255350;
        Mon, 23 Feb 2026 20:10:55 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd63f1b3sm8805002b3a.3.2026.02.23.20.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 20:10:54 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	netdev@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2] selftests: Use ktap helpers for runner.sh
Date: Tue, 24 Feb 2026 04:10:48 +0000
Message-ID: <20260224041048.6570-1-liuhangbin@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260327-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,runner.sh:url]
X-Rspamd-Queue-Id: 18F8F181954
X-Rspamd-Action: no action

Instead of manually writing ktap messages, we should use the formal
ktap helpers in runner.sh. Brendan did some work in d9e6269e3303
("selftests/run_kselftest.sh: exit with error if tests fail") to make
run_kselftest.sh exit with the correct return value. However, the output
does not include the total results, such as how many tests passed or
failed.

Let’s convert all manually printed messages in runner.sh to use the
formal ktap helpers. Here are what I changed:

  1. Move TAP header from runner.sh to run_kselftest.sh, since run_kselftest.sh
     is the only caller of run_many().
  2. In run_kselftest.sh, call run_many() in main process to count the
     pass/fail numbers.
  3. In run_kselftest.sh, do not generate kselftest_failures_file. Just
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

v2: Update commit description and comments in code. (Brendan Jackman)

---
 tools/testing/selftests/kselftest/runner.sh | 84 ++++++++++++---------
 tools/testing/selftests/run_kselftest.sh    | 21 ++++--
 2 files changed, 63 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 3a62039fa621..dfd6fedf8911 100644
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
@@ -194,10 +200,20 @@ run_many()
 		fi
 		if [ -n "$RUN_IN_NETNS" ]; then
 			run_in_netns &
+			pids+=($!)
 		else
 			run_one "$DIR" "$TEST" "$test_num"
 		fi
 	done
 
-	wait
+	# These variables are outputs of ktap_helpers.sh but since we've
+	# run the test in a subprocess we need to update them manually
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
index 84d45254675c..3ffd03f1334d 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -121,18 +121,23 @@ if [ -n "$SKIP" ]; then
 	done
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


