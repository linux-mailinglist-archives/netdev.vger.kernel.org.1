Return-Path: <netdev+bounces-197701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 974E0AD9989
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 03:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1081BC141A
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1236F2F2;
	Sat, 14 Jun 2025 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AMPN9JEs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A32182B7
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 01:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749865770; cv=none; b=CNXT700tMlLLjSLatc9iQBm3ORvUYoVDke7Rfi1lTMrwy0AKSOs2rfyF0lZ3Gjnzbn8Ey5v8Amtq/JGNFzkFST6MdSX1Nb3GdBy+CXmzdt72SqYA/JFYQedOpLMWCFbM5H6Xphcxuk/YTccYvEs+Zuxqd6swK3FJR7DWdmSREC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749865770; c=relaxed/simple;
	bh=qR3ACdTwU9HPjGu9Hq5bW/nsp1kIN7U7HrgCHctc87Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXKBz1ho4SiLlhdyK7/qEM3q/idg0VhYI83ddQVSW8KlS7sa0TCoHfnCdjMpx9bSqaoIyp6hWtUHe43A8okNt12dLzwq/5/bEA01N/jDLKUAceBIKGbksszpnmxLsCOQ2oneXGScKzyPtkWy+AP/AXBHknHVoFfdQu164Frd1do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AMPN9JEs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55E1W5Yj004630;
	Sat, 14 Jun 2025 01:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8ZsrS1CdgT7I/RjXm
	ggax08wv4/gUFR4jjyEwr/iiAg=; b=AMPN9JEs02RKK6YZoWmXauJPjnAB7T1AK
	dSso1kv179wkG3y45vyBKqjJno0bzQlKsnItJ96dU117i0Hj/dRtqOWeEK7FC2Ss
	+UwVzhYAxrCfRRBB1iSu7kxsj2x472cJdCurN3foJA81+oGwQFzzwsS19/nxyMbZ
	Vx++Ao3MoI0IHMhGVcmT0Ra/P/f1efJSQgJGZsqyd0hT8QVjTFfWSmcXDybe+Ms4
	6ga1dG+zWEhNM4/LBvcpW9oABvgoMmiADeu4V1ofAJUXpGHUhaFvJ2jnR+duoUR4
	i4hchm9bZIny0gEMl5m0YFugNl+hxfr1sZV9iH2KXtdfnDlFKOnDA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygmr1ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Jun 2025 01:49:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55DLpkAN015168;
	Sat, 14 Jun 2025 01:49:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtw0m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Jun 2025 01:49:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55E1nIrh21430970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Jun 2025 01:49:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA33D58043;
	Sat, 14 Jun 2025 01:49:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7580858059;
	Sat, 14 Jun 2025 01:49:18 +0000 (GMT)
Received: from localhost (unknown [9.61.34.221])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 14 Jun 2025 01:49:18 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v3 3/4] bonding: Selftest for the arp_ip_target parameter.
Date: Fri, 13 Jun 2025 18:48:29 -0700
Message-ID: <20250614014900.226472-4-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250614014900.226472-1-wilder@us.ibm.com>
References: <20250614014900.226472-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE0MDAxMiBTYWx0ZWRfXzdZgAC4iK8cb HI/kO7BjSDU8zpMA3yy+vXwSpfjt35NtOPlWlYFpjNfYcpcEO1FX5LjY5bIJR7RJida7CGkRLBS XDB4nv+B0jM4uzQsgZlP4uMyN/nRROXNMcc7tmaoUPlXcnxjfjx7BUViv8MyUYUtKtWldIcUyCj
 8brrfedvjUYVvJPWGQJdE4pXylCnxvaMER4LJpxDAKzs0FxC7RiN5yYD0DVC1V7020bORl/s2AD WKMt3MhkGVeFwZPXmtkCTg0CBTmtuQk26lFUzyJ85LcWQbaDDgKJRvii7TLjaTzgkFMHXVs9klZ CyY+xHqnmqfthfNihoRcjH1SeoD4ZYjIxoElkHJP4Jo8e84NrN/2W59pF3BkBeJTRRZW3q0Dih4
 hQ1tpHf7Us+IP6heNYywcqeZUIgF8pNlQNyVaXYjyW/oW6MDTKxXApSeOlUp8cpm2tPT15g0
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=684cd521 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=yK2XMzAzKRrLdIfLQxMA:9
X-Proofpoint-ORIG-GUID: 0TfxIkvekZl1dWTYukXso8EnEVJ4CKtM
X-Proofpoint-GUID: 0TfxIkvekZl1dWTYukXso8EnEVJ4CKtM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-14_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506140012

This selftest provided a functional test for the arp_ip_target parameter
both with and without user supplied vlan tags.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond-arp-ip-target.sh | 194 ++++++++++++++++++
 2 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 2b10854e4b1e..c59bb2912a38 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -10,7 +10,8 @@ TEST_PROGS := \
 	mode-2-recovery-updelay.sh \
 	bond_options.sh \
 	bond-eth-type-change.sh \
-	bond_macvlan_ipvlan.sh
+	bond_macvlan_ipvlan.sh \
+	bond-arp-ip-target.sh
 
 TEST_FILES := \
 	lag_lib.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh b/tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh
new file mode 100755
index 000000000000..89c698d28701
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh
@@ -0,0 +1,194 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test bonding arp_ip_target.
+# Topology for Bond mode 1,5,6 testing
+#
+#  +-------------------------+
+#  |                         | Server
+#  |       bond.10.20.30     | 192.30.2.1/24
+#  |            |            |
+#  |        bond0.10.20      | 192.20.2.1/24
+#  |            |            |
+#  |         bond0.10        | 192.10.2.1/24
+#  |            |            |
+#  |          bond0          | 192.0.2.1/24
+#  |            |            |
+#  |            +            |
+#  |      eth0  |  eth1      |
+#  |        +---+---+        |
+#  |        |       |        |
+#  +-------------------------+
+#           |       |
+#  +-------------------------+
+#  |        |       |        |
+#  |    +---+-------+---+    |  Gateway
+#  |    |      br0      |    |
+#  |    +-------+-------+    |
+#  |            |            |
+#  +-------------------------+
+#               |
+#  +-------------------------+
+#  |            |            |  Client
+#  |          eth0           | 192.0.0.2/24
+#  |            |            |
+#  |         eth0.10         | 192.10.10.2/24
+#  |            |            |
+#  |        eth0.10.20       | 192.20.20.2/24
+#  |            |            |
+#  |      eth0.10.20.30      | 192.30.30.2/24
+#  +-------------------------+
+
+
+lib_dir=$(dirname "$0")
+source ${lib_dir}/bond_topo_2d1c.sh
+
+DEBUG=${DEBUG:-0}
+test ${DEBUG} -ne 0 && set -x
+
+# vlan subnets
+s_ip4v10="192.10.2.1"
+s_ip4v20="192.20.2.1"
+s_ip4v30="192.30.2.1"
+c_ip4v10="192.10.2.10"
+c_ip4v20="192.20.2.10"
+c_ip4v30="192.30.2.10"
+
+ALL_TESTS="
+    no_vlan_hints
+    with_vlan_hints
+"
+
+# load bonding modules and set options.
+load_bonding() {
+    local bond_options="$*"
+
+    lsmod | grep bonding > /dev/null
+    if [ $? == 0 ]; then
+        rmmod bonding
+    fi
+    modprobe bonding ${bond_options}
+}
+
+# Build stacked vlans on top of an interface.
+stack_vlans()
+{
+    RET=0
+    local interface=$1
+    local ns=$2
+    local last=$interface
+    local tags="10 20"
+
+    ip -n ${ns} link show ${interface} > /dev/null
+    if [[ $? -ne 0 ]] && RET=1; then
+        msg="Failed to create ${interface}"
+        return
+    fi
+
+    if [ $ns == ${s_ns} ]; then host=1; else host=10;fi
+
+    for tag in $tags; do
+        ip -n ${ns} link add link $last name $last.$tag type vlan id $tag
+        ip -n ${ns} address add 192.$tag.2.$host/24 dev $last.$tag
+        ip -n ${ns} link set up dev $last.$tag
+        last=$last.$tag
+    done
+}
+
+# Check for link flapping
+check_failure_count()
+{
+    RET=0
+    local ns=$1
+    local proc_file=/proc/net/bonding/$2
+    local  counts
+
+    # Give the bond time to settle.
+    sleep 10
+
+    counts=$(ip netns exec ${ns} grep -F "Link Failure Count" ${proc_file} | awk -F: '{print $2}')
+
+    local i
+    for i in $counts; do
+        [ $i != 0 ] && RET=1
+    done
+}
+
+setup_bond_topo()
+{
+    load_bonding $*
+    setup_prepare
+    setup_wait
+    stack_vlans bond0 ${s_ns}
+    stack_vlans eth0 ${c_ns}
+}
+
+skip_with_vlan_hints()
+{
+    local skip=1
+
+    # check if iproute support prio option
+    ip -n ${s_ns} link add bond2 type bond arp_ip_target 10.0.0.1[10]
+    [[ $? -ne 0 ]] && skip=0
+    ip -n ${s_ns} link del bond2 2> /dev/null
+
+    return $skip
+}
+
+no_vlan_hints()
+{
+        RET=0
+        local targets="${c_ip4} ${c_ip4v10} ${c_ip4v20}"
+        local target
+        msg=""
+
+        for target in $targets; do
+                bond_reset "mode $mode arp_interval 100 arp_ip_target ${target}"
+
+                stack_vlans bond0 ${s_ns}
+                if [ $RET -ne 0 ]; then
+                    log_test "no_vlan_hints" "${msg}"
+                    return
+                fi
+
+                check_failure_count ${s_ns} bond0
+                log_test "arp_ip_target=${target} ${msg}"
+        done
+}
+
+with_vlan_hints()
+{
+        RET=0
+        local targets="${c_ip4}[] ${c_ip4v10}[10] ${c_ip4v20}[10/20]"
+        local target
+        msg=""
+
+        if skip_with_vlan_hints; then
+            log_test_skip "skip_with_vlan_hints" \
+	    "Current iproute doesn't support extended arp_ip_target options."
+            return 0
+        fi
+
+        for target in $targets; do
+                bond_reset "mode $mode arp_interval 100 arp_ip_target ${target}"
+
+                stack_vlans bond0 ${s_ns}
+                if [ $RET -ne 0 ]; then
+                    log_test "no_vlan_hints" "${msg}"
+                    return
+                fi
+
+                check_failure_count ${s_ns} bond0
+                log_test "arp_ip_target=${target} ${msg}"
+        done
+}
+
+
+trap cleanup EXIT
+
+mode=active-backup
+
+setup_bond_topo # dyndbg=+p
+tests_run
+
+exit $EXIT_STATUS
-- 
2.43.5


