Return-Path: <netdev+bounces-51904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CD87FCAB7
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6598AB21650
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4410E5DF24;
	Tue, 28 Nov 2023 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEl0CNiW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157745DF14;
	Tue, 28 Nov 2023 23:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E3CC433C9;
	Tue, 28 Nov 2023 23:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701213566;
	bh=FKvkf5+pDtD+DsTxSqnrKA2ASodT+lEFSVmfhp8r21c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WEl0CNiWtJ3u8HahLH0QNalbFyou1rC48CDsC1i+TDtoANgSxvVoRQ9FvaXiA2URr
	 zZfdaSpJBIleoPDSRE8uxfGm+ENhtarinwPhq+vAc1owPDu9UxFYYSFKGyOSPew8Ak
	 mAweuxcnzCZk5Hhj1HAvBm0EMn1YcgbfUL+2XEslLV2pN0eHDGkWGDOQtW9GmGDIDy
	 b7O11OS/4HOADCDOE8tRryrSzXk/gF6xVA8w0pw0LR1IkaQmP9kmC45EVDpRAhHpa5
	 bhgjRmvxGMHLg+hPEuqDOkySx7aAfosibD6CDeJ9AJXtDpTxAdsTucaOHRNhJw6HtO
	 34wOXW28U2iVw==
From: Mat Martineau <martineau@kernel.org>
Date: Tue, 28 Nov 2023 15:18:57 -0800
Subject: [PATCH net-next v4 13/15] selftests: mptcp: add
 mptcp_lib_make_file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-send-net-next-2023107-v4-13-8d6b94150f6b@kernel.org>
References: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
In-Reply-To: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

To avoid duplicated code in different MPTCP selftests, we can add
and use helpers defined in mptcp_lib.sh.

make_file() helper in mptcp_sockopt.sh and userspace_pm.sh are the same.
Export it into mptcp_lib.sh and rename it as mptcp_lib_kill_wait(). Use
it in both mptcp_connect.sh and mptcp_join.sh.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  3 +--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  3 +--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  9 +++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  3 +--
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 12 +-----------
 5 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index c4f08976c418..d20e278480fb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -592,9 +592,8 @@ make_file()
 	ksize=$((SIZE / 1024))
 	rem=$((SIZE - (ksize * 1024)))
 
-	dd if=/dev/urandom of="$name" bs=1024 count=$ksize 2> /dev/null
+	mptcp_lib_make_file $name 1024 $ksize
 	dd if=/dev/urandom conv=notrunc of="$name" oflag=append bs=1 count=$rem 2> /dev/null
-	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
 
 	echo "Created $name (size $(du -b "$name")) containing data sent by $who"
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a5d66d1bfeb4..37f434cbfa44 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1171,8 +1171,7 @@ make_file()
 	local who=$2
 	local size=$3
 
-	dd if=/dev/urandom of="$name" bs=1024 count=$size 2> /dev/null
-	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
+	mptcp_lib_make_file $name 1024 $size
 
 	print_info "Test file (size $size KB) for $who"
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 718c79dda2b3..61be4f29a69a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -247,3 +247,12 @@ mptcp_lib_get_counter() {
 
 	echo "${count}"
 }
+
+mptcp_lib_make_file() {
+	local name="${1}"
+	local bs="${2}"
+	local size="${3}"
+
+	dd if=/dev/urandom of="${name}" bs="${bs}" count="${size}" 2> /dev/null
+	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "${name}"
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index bfa744e350ef..96dc46eda133 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -251,8 +251,7 @@ make_file()
 	local who=$2
 	local size=$3
 
-	dd if=/dev/urandom of="$name" bs=1024 count=$size 2> /dev/null
-	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
+	mptcp_lib_make_file $name 1024 $size
 
 	echo "Created $name (size $size KB) containing data sent by $who"
 }
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index f136956f6c95..6167837f48e1 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -164,22 +164,12 @@ print_title "Init"
 print_test "Created network namespaces ns1, ns2"
 test_pass
 
-make_file()
-{
-	# Store a chunk of data in a file to transmit over an MPTCP connection
-	local name=$1
-	local ksize=1
-
-	dd if=/dev/urandom of="$name" bs=2 count=$ksize 2> /dev/null
-	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
-}
-
 make_connection()
 {
 	if [ -z "$file" ]; then
 		file=$(mktemp)
 	fi
-	make_file "$file" "client"
+	mptcp_lib_make_file "$file" 2 1
 
 	local is_v6=$1
 	local app_port=$app4_port

-- 
2.43.0


