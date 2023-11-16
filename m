Return-Path: <netdev+bounces-48224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 571BA7ED893
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 01:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C06F1F23164
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 00:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D458B64C;
	Thu, 16 Nov 2023 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJH9NdON"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09A9475;
	Thu, 16 Nov 2023 00:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09162C433C8;
	Thu, 16 Nov 2023 00:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700094714;
	bh=95EDq6ZSFa+rEK84AqEZQvo5Jyv3whgAjWXBat6HztU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cJH9NdONrLDI9RHoF8n+qQJmxT2Lv0m2c2VZATVMDNhZ7o3IsyWmIw1DqATO8cK6Y
	 GqTCjYt6W3PmOoS4C3q66CwDBewRhCH3CY5KRPF0DxwIVmejKocLawETdviCa6e2Zu
	 WKp8unKW1mqr3/lBhJGu6pl2CQqYgUEebmZh1ifaezcOkTfhNrTo33vkGGVuVGHyzL
	 1pK4FkpJH5tMSpoDdOVNksiXzhrERDVVXoVvJklq7HYUQi5SdfSW4J0SxWuRmNZzJV
	 DX3vpoqDtvbUWbtHxSg0tPoKAJJwHAN2lg6pT4UEAtlO9nBC2OiInR+9CScOyGna0P
	 v+zbP6jthd18Q==
From: Mat Martineau <martineau@kernel.org>
Date: Wed, 15 Nov 2023 16:31:42 -0800
Subject: [PATCH net-next v3 14/15] selftests: mptcp: add
 mptcp_lib_check_transfer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231115-send-net-next-2023107-v3-14-1ef58145a882@kernel.org>
References: <20231115-send-net-next-2023107-v3-0-1ef58145a882@kernel.org>
In-Reply-To: <20231115-send-net-next-2023107-v3-0-1ef58145a882@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

To avoid duplicated code in different MPTCP selftests, we can add
and use helpers defined in mptcp_lib.sh.

check_transfer() and print_file_err() helpers are defined both in
mptcp_connect.sh and mptcp_sockopt.sh, export them into mptcp_lib.sh
and rename them with mptcp_lib_ prefix. And use them in all scripts.

Note: In mptcp_sockopt.sh it is OK to drop 'ret=1' in check_transfer()
because it will be set in run_tests() anyway.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 29 ++--------------------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 11 ++------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 25 +++++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 28 +--------------------
 4 files changed, 30 insertions(+), 63 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index d20e278480fb..537f180aa51e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -254,31 +254,6 @@ else
 	set_ethtool_flags "$ns4" ns4eth3 "$ethtool_args"
 fi
 
-print_file_err()
-{
-	ls -l "$1" 1>&2
-	echo "Trailing bytes are: "
-	tail -c 27 "$1"
-}
-
-check_transfer()
-{
-	local in=$1
-	local out=$2
-	local what=$3
-
-	cmp "$in" "$out" > /dev/null 2>&1
-	if [ $? -ne 0 ] ;then
-		echo "[ FAIL ] $what does not match (in, out):"
-		print_file_err "$in"
-		print_file_err "$out"
-
-		return 1
-	fi
-
-	return 0
-}
-
 check_mptcp_disabled()
 {
 	local disabled_ns="ns_disabled-$rndh"
@@ -483,9 +458,9 @@ do_transfer()
 		return 1
 	fi
 
-	check_transfer $sin $cout "file received by client"
+	mptcp_lib_check_transfer $sin $cout "file received by client"
 	retc=$?
-	check_transfer $cin $sout "file received by server"
+	mptcp_lib_check_transfer $cin $sout "file received by server"
 	rets=$?
 
 	local stat_synrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7bebeadbc700..cd3412eac8a7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -511,13 +511,6 @@ get_failed_tests_ids()
 	done | sort -n
 }
 
-print_file_err()
-{
-	ls -l "$1" 1>&2
-	echo -n "Trailing bytes are: "
-	tail -c 27 "$1"
-}
-
 check_transfer()
 {
 	local in=$1
@@ -548,8 +541,8 @@ check_transfer()
 		local sum=$((0${a} + 0${b}))
 		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
 			fail_test "$what does not match (in, out):"
-			print_file_err "$in"
-			print_file_err "$out"
+			mptcp_lib_print_file_err "$in"
+			mptcp_lib_print_file_err "$out"
 
 			return 1
 		else
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 61be4f29a69a..9e51b9471d3a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -256,3 +256,28 @@ mptcp_lib_make_file() {
 	dd if=/dev/urandom of="${name}" bs="${bs}" count="${size}" 2> /dev/null
 	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "${name}"
 }
+
+# $1: file
+mptcp_lib_print_file_err()
+{
+	ls -l "${1}" 1>&2
+	echo "Trailing bytes are: "
+	tail -c 27 "${1}"
+}
+
+# $1: input file ; $2: output file ; $3: what kind of file
+mptcp_lib_check_transfer() {
+	local in="${1}"
+	local out="${2}"
+	local what="${3}"
+
+	if ! cmp "$in" "$out" > /dev/null 2>&1; then
+		echo "[ FAIL ] $what does not match (in, out):"
+		mptcp_lib_print_file_err "$in"
+		mptcp_lib_print_file_err "$out"
+
+		return 1
+	fi
+
+	return 0
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 96dc46eda133..c643872ddf47 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -135,32 +135,6 @@ check_mark()
 	return 0
 }
 
-print_file_err()
-{
-	ls -l "$1" 1>&2
-	echo "Trailing bytes are: "
-	tail -c 27 "$1"
-}
-
-check_transfer()
-{
-	local in=$1
-	local out=$2
-	local what=$3
-
-	cmp "$in" "$out" > /dev/null 2>&1
-	if [ $? -ne 0 ] ;then
-		echo "[ FAIL ] $what does not match (in, out):"
-		print_file_err "$in"
-		print_file_err "$out"
-		ret=1
-
-		return 1
-	fi
-
-	return 0
-}
-
 do_transfer()
 {
 	local listener_ns="$1"
@@ -232,7 +206,7 @@ do_transfer()
 		check_mark $connector_ns 4 || retc=1
 	fi
 
-	check_transfer $cin $sout "file received by server"
+	mptcp_lib_check_transfer $cin $sout "file received by server"
 	rets=$?
 
 	mptcp_lib_result_code "${retc}" "mark ${ip}"

-- 
2.41.0


