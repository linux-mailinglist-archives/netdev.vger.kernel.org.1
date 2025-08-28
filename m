Return-Path: <netdev+bounces-218023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3050B3AD6B
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3463B3CB2
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D81E29B20D;
	Thu, 28 Aug 2025 22:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bfij0HsI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE425DB1A
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419579; cv=none; b=NNo5T7hbY6QqhXHjIolT0TzgpH+clnx3/+X5Dp8hauggvxONtnYIumJkH3skEYsJg1avKLx/392AePsgd+X2vQY42ExljorUzIA7iHbhV7/mnjGAH/G1EcBHVcb81GibkkZeWsvUgSoLmUs6VIIiyKDNzkNL3+KVA9Nb/1oX3mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419579; c=relaxed/simple;
	bh=XAIRf6DZj9USrWexHVaEhPXwh8tQXIwumgljXpI33yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuT84AXl/KPh3USH6ziSk+xTEzMdZkTZWpqb6v0uirMWFKO68vUmnzVc/npZ5fArkLED0GyYMrveMstrxQj8FklI2Hob4XrkjRmTJRSscv5+Pf/AtU3YzvSdKGizn13JvI7uDWGx78LyfGMZxuT2ywmuK8r73WoVUvCIA8zs3cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bfij0HsI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SHDJMA002065;
	Thu, 28 Aug 2025 22:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=n7j8yhLPNkkElHs05
	HDuQeDlmPvOtS1A21/oR0P1c7Y=; b=Bfij0HsIqySLa6xqdaGm5gI8mPAUHmuie
	cIcyHJFbzw3vLQITIslNTunzWWdUz3fhDY93DVfYMhvxho2P59uUjtDjEvX/Fa7t
	RnACmKFDV+svXewv8WB0gsjiU3MLFjCdkynrIhGuCvxw9gtr9NZZNW7TBdP32lxr
	J/JVi/NkfC9WHYR+az267rc8LXE0zOdUVgxB5a9o72Id77tLaUFgKKLprWmKxOry
	EJlCnLo5PGt3gmgxsKTM8jw4F0OM0dqXfdC4eMWAB82zAxXt+ZYvXNGpuHFbAopw
	WKHZ49pjk8Wbl8vzFpsP4sdTUoeqrOMt0UgNj2XNPqdQucKZgbvnA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48tuaj175r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 22:19:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57SKoYHI020832;
	Thu, 28 Aug 2025 22:19:28 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qrc0y6pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 22:19:28 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57SMJQHV5047446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 22:19:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49CFB58043;
	Thu, 28 Aug 2025 22:19:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D287A58059;
	Thu, 28 Aug 2025 22:19:25 +0000 (GMT)
Received: from localhost (unknown [9.61.155.164])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Aug 2025 22:19:25 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v8 7/7] bonding: Selftest and documentation for the arp_ip_target parameter.
Date: Thu, 28 Aug 2025 15:18:09 -0700
Message-ID: <20250828221859.2712197-8-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250828221859.2712197-1-wilder@us.ibm.com>
References: <20250828221859.2712197-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TPrkuw0l1ceihbb6ELClwWk1WiJHtKcE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDE0MCBTYWx0ZWRfX0bs/6p0Xc82s
 GYRcf6wcDzT5tnG0+w+LPUHpmQ4pVLyQcZIOO10L0aFKPJtnREIKcS9k/XVwnDrrcHtW9D2GlPT
 90zUbt+qyZ8vrW/ucuCsMu5fiJGBz3qEbCYTOi/3sm0fEZG8RVCd06vGca25c8GVyCFr/NOrUOa
 zjOHXCOOetAJS4GQslD5DuhQGZfG+BP6MPBn9L+k1stT1H2ieXP5xiWbOukp1ZVt87hU551P0BE
 uYTp8vljg+JIay9BfRoeCRtfsiQXxmJ05zOHinv0DWqGayGnFUAjQuj40SONT0/N95j631d5PTr
 Vdm/+NzB6IEo+yAH04qSgatZJMgdSchRQqy9GJRFFTlXvmSlGwWXlatUF/YaSIEFKMfyJ4c1hpm
 UzlLEH20
X-Authority-Analysis: v=2.4 cv=YfW95xRf c=1 sm=1 tr=0 ts=68b0d5f1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=uE36UIRdXEtdkB2lOOwA:9
X-Proofpoint-ORIG-GUID: TPrkuw0l1ceihbb6ELClwWk1WiJHtKcE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508280140

This selftest provided a functional test for the arp_ip_target parameter
both with and without user supplied vlan tags.

and

Updates to the bonding documentation.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 Documentation/networking/bonding.rst          |  11 ++
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond-arp-ip-target.sh | 180 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |   1 +
 4 files changed, 194 insertions(+), 1 deletion(-)
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
index 44b98f17f8ff..b7d5e11fc9d3 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -11,7 +11,8 @@ TEST_PROGS := \
 	bond_options.sh \
 	bond-eth-type-change.sh \
 	bond_macvlan_ipvlan.sh \
-	bond_passive_lacp.sh
+	bond_passive_lacp.sh \
+	bond-arp-ip-target.sh
 
 TEST_FILES := \
 	lag_lib.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh b/tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh
new file mode 100755
index 000000000000..124bfb6a2f02
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh
@@ -0,0 +1,180 @@
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
+# shellcheck disable=SC2317
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
+                if [ "$RET" -ne 0 ]; then
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
+                if [ "$RET" -ne 0 ]; then
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
diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index 4d16a69ffc65..90e9d7b19d98 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -10,3 +10,4 @@ CONFIG_NET_CLS_MATCHALL=m
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NLMON=y
 CONFIG_VETH=y
+CONFIG_VLAN_8021Q=y
-- 
2.50.1


