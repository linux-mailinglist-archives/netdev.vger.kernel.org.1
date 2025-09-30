Return-Path: <netdev+bounces-227256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28495BAAE3C
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18191C2F4B
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9298B1F4C8E;
	Tue, 30 Sep 2025 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kNaB7P0Y"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC611E5B72
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195774; cv=none; b=Ljb7ut4JE7BMgMxHq33EwZU493c8HOFCUrdQFwQh6fTzmp2Mc0BEQbZSXjLQivwm6ohxP/2i/58tzomcQkF4ecVTwUsC+u7HfFlpFkSKoQPvhAaTq03PLIy+RHxgmJ0gjYeTbPL0AYHYXAw9q3loRMcxCksqU+1p6nnTsIzL9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195774; c=relaxed/simple;
	bh=iYVo72FJk+4knj2S+5uYmX51YgGQovnnhXBLYI9o2MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXnUS4bDxxFiY89ThMpPqX7HtYDFvCo7CRS6Nv9oCxYmJ6Fg7CdnJnnu3NHxpUAqUk9dABpa0gX/vDzoS+gl8jmzpJxqsnQU/S5N/vqR5mzrvQG3Byw5XEJTqskd7QymY4wEq/sv0YNcwPinfShotfSdWErWAQTm6XsuG+9Ck3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kNaB7P0Y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TM9RKL024032;
	Tue, 30 Sep 2025 01:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0WtY5P3DiOpxeqDK7
	1AbJW8O97R6BgWnk3gZ5QVZ4bs=; b=kNaB7P0Y180M3wV/LDMV8pFiC/raUA5Ju
	dbrt53+MxZWKu6Ab1OFmwEPQbWKZJzB/mAKAFW3yViGTJ38QxIKF/QmA7Vl8PHtz
	cmfoN5c23CzWkmlF5GANAbi9XuS9jbf1bY2h2LWEE+RNjKV5SIM7P0DI1BbcDl1s
	HZK2nnSyoOFiTJfesGPXzvZhDVTC9wWLdBnphXH4kmQCbpRXUa9nc2WunQy0cK3u
	/WqNYfpGSXMQ7eZjvAaZwHtc2ygcPMOGILL7JPhGvolrj9LKbgQQVy2hxqsddpiU
	oV5XzQL/MgGCOv7W08e9pXU9qHwiVgkjYzH6au7n8I3AYBuXnbSzQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n7npf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:14 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58U1SJwm032031;
	Tue, 30 Sep 2025 01:29:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n7npf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58U0eV6Q026818;
	Tue, 30 Sep 2025 01:29:12 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eu8mryd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:12 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58U1TA0221037784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 01:29:10 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 007FA5803F;
	Tue, 30 Sep 2025 01:29:10 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73AD358071;
	Tue, 30 Sep 2025 01:29:09 +0000 (GMT)
Received: from localhost (unknown [9.61.4.160])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Sep 2025 01:29:09 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
        edumazet@google.com
Subject: [PATCH net-next v11 7/7] bonding: Selftest and documentation for the arp_ip_target parameter.
Date: Mon, 29 Sep 2025 18:27:13 -0700
Message-ID: <20250930012857.2270721-8-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250930012857.2270721-1-wilder@us.ibm.com>
References: <20250930012857.2270721-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VyFNfoyHWGPY7pvS8xKEiFlGbF5EkJNE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfXxQl99dkRQMGb
 O9SPTOj/z03ToMrY0Z4zyKS4LubEMHMFZDUpr53DebE8FN/4Vsm4xnu7zyn8sjHYDMnAK1ob6JF
 sw+5DJfq9vqa7QjTK5niq1tX4CdIassRaYJa4X5DM5Tp6nmDC63tXODy7sL8nOnN9Awn+ptzuVz
 lkVpWWYoqpzirSQyrlWwLLjNvyjLN8yf3lyJRavsR3q/FpebIaU8ROI5lQHeazCkxTHlK/6nYte
 2xLPQMtRMkRNtkijca3QVQ6q0I/AMi0yS0H4GynXazObuB7H6/qlOeulGhjzCx22JODVL/SEpNv
 Uqe5O4jKSs0VsmBUtvX/6b9zQWE7nvxpOu4uf7uviL8xna6i9ulvF0UIkyNjiUVtjSr/dy2HXNU
 9oBswVzdWz+OGNg+We2g/nSFHdg06A==
X-Proofpoint-GUID: tINUDFU2cWfRHfg6UFwtTXqtaWorO2xT
X-Authority-Analysis: v=2.4 cv=T7qBjvKQ c=1 sm=1 tr=0 ts=68db326a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=HQvk9R55i-blUpxkxuUA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

Selftest provided as a functional test for the arp_ip_target parameter
both with and without user supplied vlan tags. Bonding documentation
has been updated for the arp_ip_target option.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 Documentation/networking/bonding.rst          |  11 +
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond-arp-ip-target.sh | 205 ++++++++++++++++++
 3 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index e700bf1d095c..08a3191a0322 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -330,6 +330,17 @@ arp_ip_target
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
index 3462783ed3ac..44965026fe45 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -12,7 +12,8 @@ TEST_PROGS := \
 	bond-eth-type-change.sh \
 	bond_macvlan_ipvlan.sh \
 	bond_passive_lacp.sh \
-	bond_lacp_prio.sh
+	bond_lacp_prio.sh \
+	bond-arp-ip-target.sh
 
 TEST_FILES := \
 	lag_lib.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh b/tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh
new file mode 100755
index 000000000000..40cbd56c00f9
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh
@@ -0,0 +1,205 @@
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
+        return 1
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
+wait_for_arp_request()
+{
+	local target=$1
+	local ip
+	local interface
+
+	ip=$(echo "${target}" | awk -F "[" '{print $1}')
+	interface="$(ip -n "${c_ns}" -br addr show | grep "${ip}" | awk -F @ '{print $1}')"
+
+	tc -n "${c_ns}" qdisc add dev "${interface}" clsact
+	tc -n "${c_ns}" filter add dev "${interface}" ingress protocol arp \
+                handle 101 flower skip_hw arp_op request arp_tip "${ip}" action pass
+
+	slowwait_for_counter 5 5 tc_rule_handle_stats_get \
+                "dev ${interface} ingress" 101 ".packets" "-n ${c_ns}" &> /dev/null || RET=1
+
+	tc -n "${c_ns}" filter del dev "${interface}" ingress
+	tc -n "${c_ns}" qdisc del dev "${interface}" clsact
+
+	if [ "$RET" -ne 0 ]; then
+		msg="Arp probe not received by ${interface}"
+		return 1
+	fi
+}
+
+# Check for link flapping.
+# First verify the arp requests are being received
+# by the target.  Then verify that the Link Failure
+# Counts are not increasing over time.
+# Arp probes are sent every 100ms, two probes must
+# be missed to trigger a slave failure. A one second
+# wait should be sufficient.
+check_failure_count()
+{
+    local bond=$1
+    local target=$2
+    local proc_file=/proc/net/bonding/${bond}
+
+    wait_for_arp_request "${target}" || return 1
+
+    LinkFailureCount1=$(ip netns exec "${s_ns}" grep -F "Link Failure Count" "${proc_file}" \
+            | awk -F: '{ sum += $2 } END { print sum }')
+    sleep 1
+    LinkFailureCount2=$(ip netns exec "${s_ns}" grep -F "Link Failure Count" "${proc_file}" \
+            | awk -F: '{ sum += $2 } END { print sum }')
+
+    [ "$LinkFailureCount1" != "$LinkFailureCount2" ] && RET=1
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
+		stack_vlans bond0 "${s_ns}"
+                if [ "$RET" -ne 0 ]; then
+                    log_test "no_vlan_hints" "${msg}"
+                    return
+                fi
+                check_failure_count bond0 "${target}"
+		log_test "arp_ip_target=${target} ${msg}"
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
+                stack_vlans bond0 "${s_ns}"
+                if [ "$RET" -ne 0 ]; then
+                    log_test "no_vlan_hints" "${msg}"
+                    return
+                fi
+
+                check_failure_count bond0 "${target}"
+                log_test "arp_ip_target=${target} ${msg}"
+        done
+}
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
2.50.1


