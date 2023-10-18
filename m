Return-Path: <netdev+bounces-42103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4377CD1E2
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABFCA1C20CDA
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4225229;
	Wed, 18 Oct 2023 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ausSp2LO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E347446AE
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4C4C4339A;
	Wed, 18 Oct 2023 01:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697593101;
	bh=f0zNhqDQDlIMjey8sKlMmnhZLPqiYQN5DPfy8ZtSSZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ausSp2LOsoSWKsRg3eI1nyKJcJsnAltL6B7nCg62iSjLAfpg0ynlW7gMHqbFZU61E
	 QIGHkUJ1MF+97FDCOE+HJ3j7vnIQSjh8NOTvDwQPpviN0Qxo4JtMHOeFiidMoE6V8A
	 8rwPFEBfPfBYMzavcNL0rAUpSe6PpnOBmn1cBKF5Ij7iiVRkUMC5GOPqqauayScWQ8
	 iteoXh27/APpIxkQj/uKGgEMDav1AQItc/0lnCxAnNpzKfI5u2GvLAiaIpHApJwoDh
	 WYu6Gsng7UCD9yYuDYkg/ixZLtZSacZ8sqSt6lfpDfndKjfs9aaN5L+GN6E4A1Ex5D
	 J3kC6Uit+HE7g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	przemyslaw.kitszel@intel.com,
	daniel@iogearbox.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 5/5] selftests: net: add very basic test for netdev names and namespaces
Date: Tue, 17 Oct 2023 18:38:17 -0700
Message-ID: <20231018013817.2391509-6-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018013817.2391509-1-kuba@kernel.org>
References: <20231018013817.2391509-1-kuba@kernel.org>
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
v2:
 - drop the \ from line ends
 - use Przemek's magic for the error message
 - redirect errors to stderr
---
 tools/testing/selftests/net/Makefile      |  1 +
 tools/testing/selftests/net/netns-name.sh | 87 +++++++++++++++++++++++
 2 files changed, 88 insertions(+)
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
index 000000000000..7d3d3fc99461
--- /dev/null
+++ b/tools/testing/selftests/net/netns-name.sh
@@ -0,0 +1,87 @@
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
+    echo "ERROR: ${1:-unexpected return code} (ret: $_)" >&2
+    RET_CODE=1
+}
+
+ip netns add $NS
+
+#
+# Test basic move without a rename
+#
+ip -netns $NS link add name $DEV type dummy || fail
+ip -netns $NS link set dev $DEV netns 1 ||
+    fail "Can't perform a netns move"
+ip link show dev $DEV >> /dev/null || fail "Device not found after move"
+ip link del $DEV || fail
+
+#
+# Test move with a conflict
+#
+ip link add name $DEV type dummy
+ip -netns $NS link add name $DEV type dummy || fail
+ip -netns $NS link set dev $DEV netns 1 2> /dev/null &&
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
+ip -netns $NS link set dev $DEV netns 1 name $DEV2 ||
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
+ip -netns $NS link set dev $DEV2 netns 1 2> /dev/null &&
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
+ip  -netns $NS link show dev $ALT_NAME 2> /dev/null &&
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


