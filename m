Return-Path: <netdev+bounces-202039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005C4AEC0CB
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5608B3BAE72
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B125021ADA3;
	Fri, 27 Jun 2025 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D2GfzUIH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AF42EBB90
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055593; cv=none; b=mHH+oYza0K70B4lnKcBVueqcyHYYdl2E4YK9QKHudcfXcXmAzQevKl0ykAtwKd50pgsHLIJD2nL/0uUIVDxrjebkUlKi7WhydPjk3V/EU1Edz2Aj1umjO2HiMeO42poxs+IXa4Rpq4iHRKEmCczgW0WwT90MMvmXOPOr0dPyTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055593; c=relaxed/simple;
	bh=kmgNf24Yvt3rCJV+y6h/ZgY5kTugffY+g+ut2jK/qSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fN7Zed0/AY3hpkT19K9XIAvwbRjqEFjIH7Abs74+Op18sRXQLRQ2yDdBXs0dSKEoIvwvJTCCbDJh/UkEtQwo0/pF8x78MQ/s37KWJX+vbTl8que006rcXfKvdD3skS3pIlSzDg4AWq5zNJsgDxh8R3WVi6neaUio00KWylnyVrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D2GfzUIH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RJERpK024477;
	Fri, 27 Jun 2025 20:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=k5dDOuGhGzL3iEJrU
	AEZgCxJZfLJXYoxniWLfr5m2tc=; b=D2GfzUIHiOrnsJz0Bgij1EhJN3e/Bvk5G
	lVi4PXr34cr1ICgIEjEMZ26hqbSPgJgI7lqCqdSzFv4CrlzkEiun2v/Q8h6Tjqb8
	/WrtzudKEqp91RNHLpYY2cRxIGPQE1x7Sxyl4HakoyJ0uiBOwSVVxW9RWR2x6NCw
	EQZ0x59WuroN5qKN01ffIennqxgHeqfV553wJ9CbPYnuYxRGoId6HXgOE/dZZucX
	6FXk91TvTMPgu6kr7s76GZDuOUrvr31SVp84dC6+48/rMUbGGKh76l1T0HTMLTwL
	U53YWLU5kGEIG2WaPZ78SkHQvJ6Y5sXbBzRKtTx1PaPZF+9RjXMVw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47h73k91r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 20:19:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55RIEl76014710;
	Fri, 27 Jun 2025 20:19:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s2wmmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 20:19:43 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55RKJfW418547282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 20:19:41 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D43A58067;
	Fri, 27 Jun 2025 20:19:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05F1558052;
	Fri, 27 Jun 2025 20:19:41 +0000 (GMT)
Received: from localhost (unknown [9.61.49.21])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Jun 2025 20:19:40 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v4 7/7] bonding: Selftest and documentation for the arp_ip_target parameter.
Date: Fri, 27 Jun 2025 13:17:20 -0700
Message-ID: <20250627201914.1791186-8-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250627201914.1791186-1-wilder@us.ibm.com>
References: <20250627201914.1791186-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VCI1-OoamkFZiXSJX-Y5YHvE7I5VxH7m
X-Proofpoint-GUID: VCI1-OoamkFZiXSJX-Y5YHvE7I5VxH7m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDE2NCBTYWx0ZWRfXy71NFoKjOAP0 hHUwmGwVbmsfZDEZjAsltYrdIqXOa+XoBemXwyL4Bf6ALGJZ3mw78eVEhwAbIG0buKo07YDGq4b KRR6rc1Yqug4Rq+QoFJwUDgAPuAP6X6jI8jGG/ALaakyxn22OsPCA1Y24YQ99r2Ebc7D+oDnTOZ
 SxJLaIhetFldVhtpTXZ6rRT6LZHAsykKnkSKE/dxtfx3DA/beLpS16VmvGSfEacfrGuu9/tJ6Dl spVHU5BIIqlRnrHGlStH43fLyki7NW1MNQrN84F7scW++aSTG7xhCRsLGztN8qDiUapTvQBrLTd SDNeRl1cCp5+opwFuCEnxFo0dPkvlRePunjVXGzrEWmk8bVHIXiGrrNeF4krI02QQ0oy09MWP5u
 xhmdYSG5+H7URNRr6d114SCbmQPuGNo8MqaCYCLjjwAr75GtZJ53u17YvqiFaheO4RMgQ0QQ
X-Authority-Analysis: v=2.4 cv=Aovu3P9P c=1 sm=1 tr=0 ts=685efce0 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=uE36UIRdXEtdkB2lOOwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270164

This selftest provided a functional test for the arp_ip_target parameter
both with and without user supplied vlan tags.

and

Updates to the bonding documentation.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 Documentation/networking/bonding.rst          |  11 +
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond-arp-ip-target.sh | 194 ++++++++++++++++++
 3 files changed, 207 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index a4c1291d2561..aa76b94b1d88 100644
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


