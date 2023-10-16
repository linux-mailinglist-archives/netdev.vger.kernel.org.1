Return-Path: <netdev+bounces-41548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4438E7CB478
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F5F1C20C52
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D6034CE3;
	Mon, 16 Oct 2023 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zsu/9uhy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299F381A2
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83950C4339A;
	Mon, 16 Oct 2023 20:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697487424;
	bh=WAiswqF6p+iKyGtDq14sllnX9gEe4NNZu2b6S4eh5RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zsu/9uhy5PbxTgaT74d8krfzXO/NUZUMzLaYtRqtTcxp2orj9l4pq3uGroCl2sMG0
	 uSFTHW7WLnShLmsITJmN3lpudBHqQBzx3EQqtVgTmQ6ibBGh7rqHUgRx1nEduFOmHc
	 f9ySJrmjw64wgjQ5+lz8vvdC6kMmnHmqRKMUDkIj0DtqUx6StZEfbzE5+74t8wAg3v
	 tpkGAhyx7fMz10g0GoxfAHCDFyy2y/l4uwWJ+0cmzY/qkKiMX1T6icb/XBIe4/DtAc
	 u2NV/W6TUVxG03hiQFH5gEinM9gZ8E2p0txbGEr7jeRxn/qUx1yQJzyPO31mWgJcaF
	 EYaN2zjfC4/sA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 5/5] selftests: net: add very basic test for netdev names and namespaces
Date: Mon, 16 Oct 2023 13:16:57 -0700
Message-ID: <20231016201657.1754763-6-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016201657.1754763-1-kuba@kernel.org>
References: <20231016201657.1754763-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftest for fixes around naming netdevs and namespaces.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/Makefile      |  1 +
 tools/testing/selftests/net/netns-name.sh | 91 +++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100755 tools/testing/selftests/net/netns-name.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 8b017070960d..4a2881d43989 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -34,6 +34,7 @@ TEST_PROGS += gro.sh
 TEST_PROGS += gre_gso.sh
 TEST_PROGS += cmsg_so_mark.sh
 TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
+TEST_PROGS += netns-name.sh
 TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
 TEST_PROGS += srv6_end_dt4_l3vpn_test.sh
 TEST_PROGS += srv6_end_dt6_l3vpn_test.sh
diff --git a/tools/testing/selftests/net/netns-name.sh b/tools/testing/selftests/net/netns-name.sh
new file mode 100755
index 000000000000..59e4a498aab4
--- /dev/null
+++ b/tools/testing/selftests/net/netns-name.sh
@@ -0,0 +1,91 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -o pipefail
+
+NS=netns-name-test
+DEV=dummy-dev0
+DEV2=dummy-dev1
+ALT_NAME=some-alt-name
+
+RET_CODE=0
+
+cleanup() {
+    ip netns del $NS
+}
+
+trap cleanup EXIT
+
+fail() {
+    if [ ! -z "$1" ]; then
+	echo "ERROR: $1"
+    else
+	echo "ERROR: unexpected return code"
+    fi
+    RET_CODE=1
+}
+
+ip netns add $NS
+
+#
+# Test basic move without a rename
+#
+ip -netns $NS link add name $DEV type dummy || fail
+ip -netns $NS link set dev $DEV netns 1 || \
+    fail "Can't perform a netns move"
+ip link show dev $DEV >> /dev/null || fail "Device not found after move"
+ip link del $DEV || fail
+
+#
+# Test move with a conflict
+#
+ip link add name $DEV type dummy
+ip -netns $NS link add name $DEV type dummy || fail
+ip -netns $NS link set dev $DEV netns 1 2> /dev/null && \
+    fail "Performed a netns move with a name conflict"
+ip link show dev $DEV >> /dev/null || fail "Device not found after move"
+ip -netns $NS link del $DEV || fail
+ip link del $DEV || fail
+
+#
+# Test move with a conflict and rename
+#
+ip link add name $DEV type dummy
+ip -netns $NS link add name $DEV type dummy || fail
+ip -netns $NS link set dev $DEV netns 1 name $DEV2 || \
+    fail "Can't perform a netns move with rename"
+ip link del $DEV2 || fail
+ip link del $DEV || fail
+
+#
+# Test dup alt-name with netns move
+#
+ip link add name $DEV type dummy || fail
+ip link property add dev $DEV altname $ALT_NAME || fail
+ip -netns $NS link add name $DEV2 type dummy || fail
+ip -netns $NS link property add dev $DEV2 altname $ALT_NAME || fail
+
+ip -netns $NS link set dev $DEV2 netns 1 2> /dev/null && \
+    fail "Moved with alt-name dup"
+
+ip link del $DEV || fail
+ip -netns $NS link del $DEV2 || fail
+
+#
+# Test creating alt-name in one net-ns and using in another
+#
+ip -netns $NS link add name $DEV type dummy || fail
+ip -netns $NS link property add dev $DEV altname $ALT_NAME || fail
+ip -netns $NS link set dev $DEV netns 1 || fail
+ip link show dev $ALT_NAME >> /dev/null || fail "Can't find alt-name after move"
+ip  -netns $NS link show dev $ALT_NAME 2> /dev/null && \
+    fail "Can still find alt-name after move"
+ip link del $DEV || fail
+
+echo -ne "$(basename $0) \t\t\t\t"
+if [ $RET_CODE -eq 0 ]; then
+    echo "[  OK  ]"
+else
+    echo "[ FAIL ]"
+fi
+exit $RET_CODE
-- 
2.41.0


