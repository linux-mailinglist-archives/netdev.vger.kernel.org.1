Return-Path: <netdev+bounces-207354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACBAB06C61
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 05:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB85B563507
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 03:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAAB22DFB5;
	Wed, 16 Jul 2025 03:40:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF21E1D63C2;
	Wed, 16 Jul 2025 03:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752637201; cv=none; b=K4gslrZkJCo5cj2ehs2xiRoB6iLqDund4DYAkOrVDgrIMzzXGDQcFcfCTf6LoYIrm3XeHmj8iVDTTOQNVgKfdo8udqzdazkspMyIbFJ2vSrgpYNo4/ezfdb+4mlZ5h5jtGAmELooJAsVBqB2LTwkCqOkIImyeduTnLvE/q1dKgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752637201; c=relaxed/simple;
	bh=wFwlRHQBXlbvkr8JtQ9aPLQFmhdSqrS1iHXAl9Wv9+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ac0zenZRR5OHEhSj8W1W0Oer3AqaQ/31Qytdc9guVsLUJ3RuGCjoO0KT1+ow010JG1B/9DDjAH3Hl+lSyodgVwjTzKs51Nf8TtCkYyQzN76Fh2EDoUND91A/wXWf4iy9JWrBBq7J97PmyurV//vGB8Afj6Tc5D8eMoicoqYtlGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bhhXb1kKFz2CfnZ;
	Wed, 16 Jul 2025 11:35:43 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 23FD41400CB;
	Wed, 16 Jul 2025 11:39:50 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Jul 2025 11:39:49 +0800
Received: from localhost.localdomain (10.175.104.82) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Jul 2025 11:39:49 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <idosch@idosch.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<jiri@resnulli.us>, <oscmaes92@gmail.com>, <linux@treblig.org>,
	<pedro.netdev@dondevamos.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangchangzhong@huawei.com>
Subject: [PATCH net v3 2/2] selftests: Add test cases for vlan_filter modification during runtime
Date: Wed, 16 Jul 2025 11:45:04 +0800
Message-ID: <20250716034504.2285203-3-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250716034504.2285203-1-dongchenchen2@huawei.com>
References: <20250716034504.2285203-1-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200002.china.huawei.com (7.202.195.90)

Add test cases for vlan_filter modification during runtime, which
may triger null-ptr-ref or memory leak of vlan0.

Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 tools/testing/selftests/net/vlan_hw_filter.sh | 98 ++++++++++++++++---
 1 file changed, 86 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/vlan_hw_filter.sh b/tools/testing/selftests/net/vlan_hw_filter.sh
index 7bc804ffaf7c..0fb56baf28e4 100755
--- a/tools/testing/selftests/net/vlan_hw_filter.sh
+++ b/tools/testing/selftests/net/vlan_hw_filter.sh
@@ -3,27 +3,101 @@
 
 readonly NETNS="ns-$(mktemp -u XXXXXX)"
 
+ALL_TESTS="
+	test_vlan_filter_check
+	test_vlan0_del_crash_01
+	test_vlan0_del_crash_02
+	test_vlan0_del_crash_03
+	test_vid0_memleak
+"
+
 ret=0
 
+setup() {
+	ip netns add ${NETNS}
+}
+
 cleanup() {
-	ip netns del $NETNS
+	ip netns del $NETNS 2>/dev/null
 }
 
 trap cleanup EXIT
 
 fail() {
-    echo "ERROR: ${1:-unexpected return code} (ret: $_)" >&2
-    ret=1
+	echo "ERROR: ${1:-unexpected return code} (ret: $_)" >&2
+	ret=1
+}
+
+tests_run()
+{
+	local current_test
+	for current_test in ${TESTS:-$ALL_TESTS}; do
+		$current_test
+	done
+}
+
+test_vlan_filter_check() {
+	setup
+	ip netns exec ${NETNS} ip link add bond0 type bond mode 0
+	ip netns exec ${NETNS} ip link add bond_slave_1 type veth peer veth2
+	ip netns exec ${NETNS} ip link set bond_slave_1 master bond0
+	ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter off
+	ip netns exec ${NETNS} ip link add link bond_slave_1 name bond_slave_1.0 type vlan id 0
+	ip netns exec ${NETNS} ip link add link bond0 name bond0.0 type vlan id 0
+	ip netns exec ${NETNS} ip link set bond_slave_1 nomaster
+	ip netns exec ${NETNS} ip link del veth2 || fail "Please check vlan HW filter function"
+	cleanup
 }
 
-ip netns add ${NETNS}
-ip netns exec ${NETNS} ip link add bond0 type bond mode 0
-ip netns exec ${NETNS} ip link add bond_slave_1 type veth peer veth2
-ip netns exec ${NETNS} ip link set bond_slave_1 master bond0
-ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter off
-ip netns exec ${NETNS} ip link add link bond_slave_1 name bond_slave_1.0 type vlan id 0
-ip netns exec ${NETNS} ip link add link bond0 name bond0.0 type vlan id 0
-ip netns exec ${NETNS} ip link set bond_slave_1 nomaster
-ip netns exec ${NETNS} ip link del veth2 || fail "Please check vlan HW filter function"
+#enable vlan_filter feature of real_dev with vlan0 during running time
+test_vlan0_del_crash_01() {
+	setup
+	ip netns exec ${NETNS} ip link add bond0 type bond mode 0
+	ip netns exec ${NETNS} ip link add link bond0 name vlan0 type vlan id 0 protocol 802.1q
+	ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter off
+	ip netns exec ${NETNS} ifconfig bond0 up
+	ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter on
+	ip netns exec ${NETNS} ifconfig bond0 down
+	ip netns exec ${NETNS} ifconfig bond0 up
+	ip netns exec ${NETNS} ip link del vlan0 || fail "Please check vlan HW filter function"
+	cleanup
+}
+
+#enable vlan_filter feature and add vlan0 for real_dev during running time
+test_vlan0_del_crash_02() {
+	setup
+	ip netns exec ${NETNS} ip link add bond0 type bond mode 0
+	ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter off
+	ip netns exec ${NETNS} ifconfig bond0 up
+	ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter on
+	ip netns exec ${NETNS} ip link add link bond0 name vlan0 type vlan id 0 protocol 802.1q
+	ip netns exec ${NETNS} ifconfig bond0 down
+	ip netns exec ${NETNS} ifconfig bond0 up
+	ip netns exec ${NETNS} ip link del vlan0 || fail "Please check vlan HW filter function"
+	cleanup
+}
+
+#enable vlan_filter feature of real_dev during running time
+#test kernel_bug of vlan unregister
+test_vlan0_del_crash_03() {
+	setup
+	ip netns exec ${NETNS} ip link add bond0 type bond mode 0
+	ip netns exec ${NETNS} ip link add link bond0 name vlan0 type vlan id 0 protocol 802.1q
+	ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter off
+	ip netns exec ${NETNS} ifconfig bond0 up
+	ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter on
+	ip netns exec ${NETNS} ifconfig bond0 down
+	ip netns exec ${NETNS} ip link del vlan0 || fail "Please check vlan HW filter function"
+	cleanup
+}
+
+test_vid0_memleak() {
+	setup
+	ip netns exec ${NETNS} ip link add bond0 up type bond mode 0
+	ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter off
+	ip netns exec ${NETNS} ip link del dev bond0 || fail "Please check vlan HW filter function"
+	cleanup
+}
 
+tests_run
 exit $ret
-- 
2.25.1


