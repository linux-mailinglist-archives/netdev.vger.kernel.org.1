Return-Path: <netdev+bounces-33266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A11579D39A
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728A6281E61
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCE618B09;
	Tue, 12 Sep 2023 14:29:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E291A18B00
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:29:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6368F110
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694528943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAMLniyIoFqxyY+Ms9Ylf+qhlLkoF0EUNgO1AHHxWow=;
	b=JnZC6+O+ooZjrt/tc6BtqZaSd2H3X5+WPWgD5oWn1hmvRT1bfScYix4nesQKsTZn4kKuW5
	ISgabMPvc37SIIkJ5veCbrghvE1tDxvS8oxiAcyAPHv3lI1lp7vMb2MswPapkiklieqdvH
	OWEVj0mo1Tik3lHeRPCR/GEqPkbZRa0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-QP9ZHPwrNfuAKDYXUxXX_Q-1; Tue, 12 Sep 2023 10:29:00 -0400
X-MC-Unique: QP9ZHPwrNfuAKDYXUxXX_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9692929AB452;
	Tue, 12 Sep 2023 14:28:56 +0000 (UTC)
Received: from dmendes-thinkpadt14sgen2i.remote.csb (unknown [10.22.18.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1D4C47B62;
	Tue, 12 Sep 2023 14:28:54 +0000 (UTC)
From: Daniel Mendes <dmendes@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net
Subject: [PATCH net-next 2/2] kselftest: rtnetlink: add pause and pause on fail flag
Date: Tue, 12 Sep 2023 10:28:36 -0400
Message-ID: <bc57e9f08104ec59122ce97fa514a286981087e2.1694527251.git.dmendes@redhat.com>
In-Reply-To: <cover.1694527251.git.dmendes@redhat.com>
References: <cover.1694527251.git.dmendes@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5

'Pause' prompts the user to press Enter to continue running tests
once one test has finished. Pause on fail on prompts the user to press
enter only when a test fails.

Modifications to kci_test_addrlft() and kci_test_ipsec_offload()
ensure that whenever end_test is called, [$ret -ne 0] indicates
failure. This allows end_test to really easily implement pause on fail
functionality.

Signed-off-by: Daniel Mendes <dmendes@redhat.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 27 ++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index daaf1bcc10ac..ef52d34551cf 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -32,6 +32,8 @@ ALL_TESTS="
 
 devdummy="test-dummy0"
 VERBOSE=0
+PAUSE=no
+PAUSE_ON_FAIL=no
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
@@ -112,6 +114,17 @@ end_test()
 {
 	echo "$*"
 	[ "${VERBOSE}" = "1" ] && echo
+
+	if [[ $ret -ne 0 ]] && [[ "${PAUSE_ON_FAIL}" = "yes" ]]; then
+		echo "Hit enter to continue"
+		read a
+	fi;
+
+	if [ "${PAUSE}" = "yes" ]; then
+		echo "Hit enter to continue"
+		read a
+	fi
+
 }
 
 
@@ -286,8 +299,8 @@ kci_test_addrlft()
 	sleep 5
 	run_cmd_grep "10.23.11." ip addr show dev "$devdummy"
 	if [ $? -eq 0 ]; then
-		end_test "FAIL: preferred_lft addresses remaining"
 		check_err 1
+		end_test "FAIL: preferred_lft addresses remaining"
 		return
 	fi
 
@@ -779,8 +792,8 @@ kci_test_ipsec_offload()
 	# does offload show up in ip output
 	lines=`ip x s list | grep -c "crypto offload parameters: dev $dev dir"`
 	if [ $lines -ne 2 ] ; then
-		end_test "FAIL: ipsec_offload SA offload missing from list output"
 		check_err 1
+		end_test "FAIL: ipsec_offload SA offload missing from list output"
 	fi
 
 	# use ping to exercise the Tx path
@@ -806,8 +819,8 @@ EOF
 	ip x p flush
 	lines=`grep -c "SA count=0" $sysfsf`
 	if [ $lines -ne 1 ] ; then
-		end_test "FAIL: ipsec_offload SA not removed from driver"
 		check_err 1
+		end_test "FAIL: ipsec_offload SA not removed from driver"
 	fi
 
 	# clean up any leftovers
@@ -1254,6 +1267,8 @@ usage: ${0##*/} OPTS
         -t <test>   Test(s) to run (default: all)
                     (options: $(echo $ALL_TESTS))
         -v          Verbose mode (show commands and output)
+        -P          Pause after every test
+        -p          Pause after every failing test before cleanup (for debugging)
 EOF
 }
 
@@ -1271,15 +1286,19 @@ for x in ip tc;do
 	fi
 done
 
-while getopts t:hv o; do
+while getopts t:hvpP o; do
 	case $o in
 		t) TESTS=$OPTARG;;
 		v) VERBOSE=1;;
+		p) PAUSE_ON_FAIL=yes;;
+		P) PAUSE=yes;;
 		h) usage; exit 0;;
 		*) usage; exit 1;;
 	esac
 done
 
+[ $PAUSE = "yes" ] && PAUSE_ON_FAIL="no"
+
 kci_test_rtnl
 
 exit $?
-- 
2.41.0


