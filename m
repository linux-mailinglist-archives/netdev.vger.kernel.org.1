Return-Path: <netdev+bounces-206899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA56B04B19
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984FA1A65713
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933C927FD52;
	Mon, 14 Jul 2025 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z+uNlR8p"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58E227A477
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533761; cv=none; b=Ns1LcyHTBYnB4NxRWw7aIcQeQLN62h7A7gsmpmdVFNHHWH6ATuPKHSwXQrEBHxg9/xCkYGD1p2spX8izt1jtSWFePZPbjHMatX1ffDDYC7QVIwOCh53hRWdqEwh0mhEMLAIeDKBuLDRpPxgmXsMS2vBN1bF9uM0Afc5TPgEPXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533761; c=relaxed/simple;
	bh=oTlMDXKLoHH1cDkOoX6a2PtwzeqE4Ryq/H2VV26tXA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqOxRXDxncDML+8YK//501MIOuzUAkJB8tmaB+6vDXeN0vo6avDfbL93syZjiyAqjcYNKYJcU7uysFKzDwSSBT4Wj9pRUKZCGLVN+i26Q5n7cmLKswfDntzUbJXZ/BrE8QcMFGAsJ7sto/RZzNYJDuJHOyZRAnybdn3rpRzIvfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z+uNlR8p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EIAEEX027529;
	Mon, 14 Jul 2025 22:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iW8+jsHYuqmXr04Si
	swjcnKRKVSJrloMTt+5Ivuc8Hc=; b=Z+uNlR8pPyiThrQ2PbLTExyIUnatxkIAW
	xd99U7KWVHchnsL3zxyL6z6P8SwdknshSBB0Mt5IZyORA8fdJvUSV+QgfNDSIyOK
	/hmhC0Mh4fKq+ntuqnC4yifpNc63KzRALLNa9D/VaapIk8yXyNE9mWCtjT48YKvL
	wceo0xnMLyR2PrJGoQGbGh0qE6kzkc0e+igm0pXtF1W9az0yZUsQZqdr3PMoxmef
	/b8O5HVd8ikpzgVfjhB1JPIEJsbWdn0BBbVF8pp+N97775GpDb/jpmag/RgkWwkA
	RXKQpI0NDty+oUmdJQyHMUyB47ej1udqNvYbnSfSvOl5WBGBA6J8g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vdfmeyn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 22:55:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EI9aVo008988;
	Mon, 14 Jul 2025 22:55:51 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hmfspg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 22:55:51 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56EMtnxL27722340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 22:55:50 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92ABF5804E;
	Mon, 14 Jul 2025 22:55:49 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 525655803F;
	Mon, 14 Jul 2025 22:55:49 +0000 (GMT)
Received: from localhost (unknown [9.61.28.64])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 22:55:49 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v5 7/7] bonding: Selftest and documentation for the arp_ip_target parameter.
Date: Mon, 14 Jul 2025 15:54:52 -0700
Message-ID: <20250714225533.1490032-8-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250714225533.1490032-1-wilder@us.ibm.com>
References: <20250714225533.1490032-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DPoO8M8cH6BzP9O_Q2CMwsgv9zT-U-90
X-Authority-Analysis: v=2.4 cv=JOI7s9Kb c=1 sm=1 tr=0 ts=68758af9 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=uE36UIRdXEtdkB2lOOwA:9
X-Proofpoint-ORIG-GUID: DPoO8M8cH6BzP9O_Q2CMwsgv9zT-U-90
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE1OSBTYWx0ZWRfX8YC0NvvwEWZ7 zR4NlgvGinB92zSberLp1LnLOghPjxBRVu6T+mqVB3v1YHRjOkjfjeXnSAidUNNU3jx1gn9PFWE 6rvpARDHyqHiPvp1Kh8CSiUoHV9tdhzffMb3JaUm6yxUpiiiQeVSTFtFmDIcpbKJW01WdAXHdni
 MbqeA+piE9tZTUsJhu4p7WcviQuv5UpHtAZ80VMG1sbD1UCsanSjpvf+/SoeN/Jg6jFM5dVRu9i z+pQeNUmXlLR/oVmG6r+0zEwEAbWOBS8ipaCTrLkMDBkGMpN1qfGCqflHIJcAhlrSocfrZh7mAn EZLnnJYtnK5XzrxeHKwVjIJ8gdKx2ht+fTvFl1ih8myT9s+yr92aUzm/2dB20URooETnZM0QTqy
 Kjhb9SqAfAaWofa+34+FLE4ouvAIPDNjYmSotzOdbtWxrJhqGCbLjLai2XFuwRGMOqqDoEK/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140159

This selftest provided a functional test for the arp_ip_target parameter
both with and without user supplied vlan tags.

and

Updates to the bonding documentation.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 Documentation/networking/bonding.rst          |  11 ++
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond-arp-ip-target.sh | 179 ++++++++++++++++++
 3 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index f8f5766703d4..4a80da56b784 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -313,6 +313,17 @@ arp_ip_target
 	maximum number of targets that can be specified is 16.  The
 	default value is no IP addresses.
 
+        When an arp_ip_target is configured the bonding driver will
+        attempt to automatically determine what vlans the arp probe will
+        pass through. This process of gathering vlan tags is required
+        for the arp probe to be sent. However, in some configurations
+        this process may fail. In these cases you may manually
+        supply a list of vlan tags. To specify a list of vlan tags
+        append the ipv4 address with [tag1/tag2...]. For example:
+        arp_ip_target=10.0.0.1[10]. If you simply need to disable the
+        vlan discovery process you may provide an empty list, for example:
+        arp_ip_target=10.0.0.1[].
+
 ns_ip6_target
 
 	Specifies the IPv6 addresses to use as IPv6 monitoring peers when
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
index 000000000000..e9af27f17d0f
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh
@@ -0,0 +1,179 @@
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
+lib_dir=$(dirname "$0")
+
+# shellcheck source=./bond_topo_2d1c.sh
+source "${lib_dir}"/bond_topo_2d1c.sh
+
+DEBUG=${DEBUG:-0}
+test "${DEBUG}" -ne 0 && set -x
+
+# vlan subnets
+c_ip4="192.0.2.10"
+c_ip4v10="192.10.2.10"
+c_ip4v20="192.20.2.10"
+
+ALL_TESTS="
+    no_vlan_hints
+    with_vlan_hints
+"
+
+# Build stacked vlans on top of an interface.
+stack_vlans()
+{
+    RET=0
+    local interface="$1"
+    local ns=$2
+    local last="$interface"
+    local tags="10 20"
+
+    if ! ip -n "${ns}" link show "${interface}" > /dev/null; then
+        RET=1
+        msg="Failed to create ${interface}"
+        return
+    fi
+
+    if [ "$ns" == "${s_ns}" ]; then host=1; else host=10;fi
+
+    for tag in $tags; do
+        ip -n "${ns}" link add link "$last" name "$last"."$tag" type vlan id "$tag"
+        ip -n "${ns}" address add 192."$tag".2."$host"/24 dev "$last"."$tag"
+        ip -n "${ns}" link set up dev "$last"."$tag"
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
+    counts=$(ip netns exec "${ns}" grep -F "Link Failure Count" "${proc_file}" \
+	    | awk -F: '{print $2}')
+
+    local i
+    for i in $counts; do
+        [ "$i" != 0 ] && RET=1
+    done
+}
+
+setup_bond_topo()
+{
+    setup_prepare
+    setup_wait
+    stack_vlans bond0 "${s_ns}"
+    stack_vlans eth0 "${c_ns}"
+}
+
+skip_with_vlan_hints()
+{
+    # check if iproute supports arp_ip_target with vlans option.
+    if ! ip -n "${s_ns}" link add bond2 type bond arp_ip_target 10.0.0.1[10]; then
+        ip -n "${s_ns}" link del bond2 2> /dev/null
+        return 0
+    fi
+    return 1
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
+                stack_vlans bond0 "${s_ns}"
+                if [ $RET -ne 0 ]; then
+                    log_test "no_vlan_hints" "${msg}"
+                    return
+                fi
+
+                check_failure_count "${s_ns}" bond0
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
+	          "Installed iproute doesn't support extended arp_ip_target options."
+            return 0
+        fi
+
+        for target in $targets; do
+                bond_reset "mode $mode arp_interval 100 arp_ip_target ${target}"
+
+                stack_vlans bond0 "${s_ns}"
+                if [ $RET -ne 0 ]; then
+                    log_test "no_vlan_hints" "${msg}"
+                    return
+                fi
+
+                check_failure_count "${s_ns}" bond0
+                log_test "arp_ip_target=${target} ${msg}"
+        done
+}
+
+
+trap cleanup EXIT
+
+mode=active-backup
+
+setup_bond_topo
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.43.5


