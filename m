Return-Path: <netdev+bounces-194694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0194CACBEF4
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 05:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6738816FB5A
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 03:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C3A198E9B;
	Tue,  3 Jun 2025 03:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KBV4YCnX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E8218A93C
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748922776; cv=none; b=ivNhNZeQ1MmAuRxd080LmA61I3QGmuS43w1BMO5hrCKzZ2On+SDfsDHm3WJw/469lzAEI9qTbUFrRSTbLnkHyImZdjoDkJFBejjqfaMpCIwdfzMFMnM8dVsohFAHFfZDiOHV/hk19PiCln84ZdWbFQMgmJZy8t5SLeGr5awPo3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748922776; c=relaxed/simple;
	bh=N98nEHjZ0JtSgEEkUk6Ggeq9CDPnxb3e+zUAOGf0ncs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxFKJFU9+CJhrL2ikuHjTv+NgrypeE89DcyeTzwaFwg2303qgkpHP3ui6XfrVNibsQqHyelIERaJK95zDcY1NHv9lWyycX/is8xiiI1piBEYy4HKR4vNDRdcNYvgcE96MZmmo41YY7CzcGj/ezFD5QcrsuAFi9jsTl4QZyqEXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KBV4YCnX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5533qmYC013765
	for <netdev@vger.kernel.org>; Tue, 3 Jun 2025 03:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WyBYvD1s3/GwycTnS
	NIp7zfhKWkv6T+4Nqe3BhcU8uw=; b=KBV4YCnXlVVcdg2l7hNwqT5TEQvMP5EUS
	PDlrbAZq35FPbH8OdbC07/13s+8xMv8aBsAPnI2ze7Z6o0BtZY4q01Sd7F88E0gd
	fnuasQhgRFNNcF69BhtL+NpOr/Y/FEzvrHROwWsTf3n4v2g4tEXo1QU470l6vrP8
	/1zBJO6OTLXuxDzKwi6zPJlcNjrn3MMlgeV5ohICW1epeVrpoFbhII/mp6+0RzSB
	i8IyrI9oJtLAEamx7O159PioZU8zRxZE+APu6h/gLbKEBalVeqMHzq/yFXn2j3Hk
	q7LE7pVuheDqvJgT1xIIMcCkXWS4Evy0OdR+Y1gNggd8sXXL+4Mwg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyj0mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 03:52:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5530JqIX024944
	for <netdev@vger.kernel.org>; Tue, 3 Jun 2025 03:52:52 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkm8ycu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 03:52:52 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5533qq1030016156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Tue, 3 Jun 2025 03:52:52 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3226758059
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:52:52 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8B7D58053
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:52:51 +0000 (GMT)
Received: from localhost (unknown [9.61.177.224])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:52:51 +0000 (GMT)
From: David J Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 3/4] bonding: Selftest for the arp_ip_target parameter.
Date: Mon,  2 Jun 2025 20:51:49 -0700
Message-ID: <20250603035243.402806-4-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250603035243.402806-1-wilder@us.ibm.com>
References: <20250603035243.402806-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D67qOdq6A4cS2ZasFJ3KGIn3GoEFKELi
X-Proofpoint-ORIG-GUID: D67qOdq6A4cS2ZasFJ3KGIn3GoEFKELi
X-Authority-Analysis: v=2.4 cv=X4dSKHTe c=1 sm=1 tr=0 ts=683e7195 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=yK2XMzAzKRrLdIfLQxMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDAzMCBTYWx0ZWRfX9/4Om83sQTC4 aR8hTxQaUMJOkcALqVXMXKTVg9WW/4mnRFARSMNcLwSWz2O3wwv3dV1Idsy92y/FhzQd3hKsW9Z II62Wul+oJQ0ew0QBGBROVWTgbYWajbHucNIlcRIwvSUFHb0UxDcaaccrmqR0lea31S4vRkm+dO
 L2L/dfij7fKs46CFlj+ZMnA84O8vrwLPPZvdPcQyXhx6LUaPymhJU1J2OFLnKXm+AotViV9kn54 264zTLKWGmrnxVlhc0W1bYXUKB+SIv8B4gDjuCeoBFCHygCtWzrVZfX83+W+glNS7WQOGqc5mPo wlGRyL8w/zjm+Jiqq/uLGdK/N04di11xhPz5BaTlnsRnDMjzm15H48HkbV/kFMLm6ZwaWJ0N6fN
 pVlVymxPv0Bsa0iFo4kMR2u95rw99a51/2eiogPDjI4shNUVNYIs4fls4rRWdm2fXGAmYaYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030030

This selftest provided a functional test for the arp_ip_target parameter
both with and without user supplied vlan tags.

Signed-off-by: David J Wilder <wilder@us.ibm.com>
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
index 000000000000..7bd2f3beb1f0
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
+    local tags="10 20 30"
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


