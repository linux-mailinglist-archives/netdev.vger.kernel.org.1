Return-Path: <netdev+bounces-208252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 314B4B0AB69
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E570BAA437C
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 21:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAA8221720;
	Fri, 18 Jul 2025 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cGtqMF04"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9948A221277
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873901; cv=none; b=sQ4qmbgFCW/cy9FkMIVjHZNn29rYkiqCpDz2y/qhGgX/Xyunj+3YuVBiwvwzricQNy9l+qapWkvnRxaEnvjtKnoNoWhaTmlsdLYEi9tHUrCCblXXb17VijhzbFBwPws2hTU91hKqDIMgBFEQPv3Xjw9SJofgYi4ALkFLD991q/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873901; c=relaxed/simple;
	bh=t+JwbkY5uCJ/6a3PfvAPMe5/2hEYQ2IsoUymO5CwmMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtUsaKwfnw4N6UZgyrzfC6nVo0oEnr6u/jPAyWt0AN73624ojouf9p5XuT7Choz/QgWGzr7lUW+OdVL/wow89gjhE7SZt1KvHIOss8NZGAk8j7UUbnlrnfG4Y0+tWjDaPzNs9nG/YIxP9me00Bja0QGjl9mhPYWLP0zpRQk7Bpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cGtqMF04; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IKwZCo002668;
	Fri, 18 Jul 2025 21:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J4vxDLOWvyc5famcL
	bjeHetXRs+VVl3IcvBMtPXhi5M=; b=cGtqMF04fbmCjso42OYEvpjozwxhcpjmj
	dYnle55J0SP8RTPdlnAsfviVdrzVW5BTRMsLlaiYlHGNbmFOmuRU2WavlVNF0c3V
	RhY8P33+IiY7r6jyZnpz9Yg0H9mVAeH+lhsZbdpK+WLn3fau/1QTkK2b3012etrp
	jMzOlif4OtWqXbQPE4QsBoE0/cVQRvl1fc/x/X1fZT4A6KoreDtvrPNPL5Xu1rSS
	SxZkmmeYqirpggkrQ+tbS+REjdyHn7v7RmzCkPFkolzzOWIEMVUBm3NH4Xj9iNRm
	OmpblZVRh5LZSd+ILvPBMLlan7/Rm1CjI/kmDkRyTZsWuVzfvmE0A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4uk92f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:24:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56IK21t4021877;
	Fri, 18 Jul 2025 21:24:51 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v4r3jseq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:24:51 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56ILOmrt20841154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 21:24:48 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4613C58052;
	Fri, 18 Jul 2025 21:24:48 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0645F58045;
	Fri, 18 Jul 2025 21:24:48 +0000 (GMT)
Received: from localhost (unknown [9.61.165.151])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Jul 2025 21:24:47 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v6 7/7] bonding: Selftest and documentation for the arp_ip_target parameter.
Date: Fri, 18 Jul 2025 14:23:43 -0700
Message-ID: <20250718212430.1968853-8-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250718212430.1968853-1-wilder@us.ibm.com>
References: <20250718212430.1968853-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=687abba4 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=uE36UIRdXEtdkB2lOOwA:9
X-Proofpoint-GUID: enEzgT25u3_W0tbhDD_2kXnxrbrcthOP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE3MyBTYWx0ZWRfX/FaqMF3/lLbv jO/x7/reHXz0fKJxDr9v9DzKDfmy9R/gz7RPMQpySR4BRsCmukOQzyxFGQ5nYQwtm91YbfsLq24 uK/h0LRSX56d4I0nHSkS5693W/AwTTMDCeG+uXuTdi9zW5+Z8fciaEqF4I7asgFWoOv30NbJqQE
 5PQgBG3KTO2JULNWN6WbbIzuXCl1iRhxlxF8aS9D0b8XMg/B0JKLZLcExMAUYEXOoXkx7VszJsC jorOhxLyKxzkt33v1SwAdevCUsR71pnvVtvH8CSC9js6GM6Y2J9924p1J9Ucfef70Ev9ngF3C1E QX9GwzHrt28qDRtw77Lrb4YCjBzdwq7Tae0Z+2Uwn6qnjTzYEUU9cDVufQonqQj4Zs6tpFrTNhn
 ffFKwS9CXwFMcY4r6BadepojAtVXrWtYvQLyJPGz1VAwat8aJW5Oc0ETFU1dNkAYd/VgeVlI
X-Proofpoint-ORIG-GUID: enEzgT25u3_W0tbhDD_2kXnxrbrcthOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_05,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180173

This selftest provided a functional test for the arp_ip_target parameter
both with and without user supplied vlan tags.

and

Updates to the bonding documentation.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 Documentation/networking/bonding.rst          |  11 ++
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond-arp-ip-target.sh | 178 ++++++++++++++++++
 3 files changed, 191 insertions(+), 1 deletion(-)
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
index 000000000000..aea6b282cea6
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh
@@ -0,0 +1,178 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test bonding arp_ip_target.
+# Topology for Bond mode 1,5,6 testing
+#
+#  +-------------------------+
+#  |                         | Server
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
+#  +-------------------------+
+
+lib_dir=$(dirname "$0")
+
+# shellcheck source=/dev/null # Ignore source warning.
+source "${lib_dir}"/bond_topo_2d1c.sh
+
+# shellcheck disable=SC2154 # Ignore unassigned referenced warning.
+echo "${c_ns}" "${s_ns}" > /dev/null
+
+DEBUG=${DEBUG:-0}
+test "${DEBUG}" -ne 0 && set -x
+
+# vlan subnets
+c_ip4="192.0.2.10"
+c_ip4v10="192.10.2.10"
+c_ip4v20="192.20.2.10"
+
+export ALL_TESTS="
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


