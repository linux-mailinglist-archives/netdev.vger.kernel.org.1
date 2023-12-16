Return-Path: <netdev+bounces-58201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38051815859
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 09:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69531F2551E
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 08:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63A4134D9;
	Sat, 16 Dec 2023 08:01:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F917134C4
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SsdL90fGbzsRjx;
	Sat, 16 Dec 2023 15:40:49 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id B6294140518;
	Sat, 16 Dec 2023 15:41:00 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 16 Dec
 2023 15:40:59 +0800
From: Liu Jian <liujian56@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <vladimir.oltean@nxp.com>,
	<andrew@lunn.ch>, <d-tatianin@yandex-team.ru>, <justin.chen@broadcom.com>,
	<rkannoth@marvell.com>, <idosch@nvidia.com>, <jdamato@fastly.com>,
	<netdev@vger.kernel.org>
CC: <liujian56@huawei.com>
Subject: [PATCH net v3 2/2] selftests: add vlan hw filter tests
Date: Sat, 16 Dec 2023 15:52:19 +0800
Message-ID: <20231216075219.2379123-3-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231216075219.2379123-1-liujian56@huawei.com>
References: <20231216075219.2379123-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)

Add one basic vlan hw filter test.

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 tools/testing/selftests/net/Makefile          |  1 +
 tools/testing/selftests/net/vlan_hw_filter.sh | 29 +++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100755 tools/testing/selftests/net/vlan_hw_filter.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 5b2aca4c5f10..9e5bf59a20bf 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -91,6 +91,7 @@ TEST_PROGS += test_bridge_neigh_suppress.sh
 TEST_PROGS += test_vxlan_nolocalbypass.sh
 TEST_PROGS += test_bridge_backup_port.sh
 TEST_PROGS += fdb_flush.sh
+TEST_PROGS += vlan_hw_filter.sh
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/net/vlan_hw_filter.sh b/tools/testing/selftests/net/vlan_hw_filter.sh
new file mode 100755
index 000000000000..7bc804ffaf7c
--- /dev/null
+++ b/tools/testing/selftests/net/vlan_hw_filter.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+readonly NETNS="ns-$(mktemp -u XXXXXX)"
+
+ret=0
+
+cleanup() {
+	ip netns del $NETNS
+}
+
+trap cleanup EXIT
+
+fail() {
+    echo "ERROR: ${1:-unexpected return code} (ret: $_)" >&2
+    ret=1
+}
+
+ip netns add ${NETNS}
+ip netns exec ${NETNS} ip link add bond0 type bond mode 0
+ip netns exec ${NETNS} ip link add bond_slave_1 type veth peer veth2
+ip netns exec ${NETNS} ip link set bond_slave_1 master bond0
+ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter off
+ip netns exec ${NETNS} ip link add link bond_slave_1 name bond_slave_1.0 type vlan id 0
+ip netns exec ${NETNS} ip link add link bond0 name bond0.0 type vlan id 0
+ip netns exec ${NETNS} ip link set bond_slave_1 nomaster
+ip netns exec ${NETNS} ip link del veth2 || fail "Please check vlan HW filter function"
+
+exit $ret
-- 
2.34.1


