Return-Path: <netdev+bounces-245763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D59CFCD72A3
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 21:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D98223015D32
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 20:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1432C3314AB;
	Mon, 22 Dec 2025 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/0M/W+x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252532FFF89
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766437142; cv=none; b=stZcM000UI8YpV2llA5uu+j9+zsUVZDJB4NpQ4ccnjuaMIoug4s5+MJG4Qj+Vrg0zW8Q8bA7dR2EkqRAZVCqgHewkf6c2M5/VsP2RjVn59yX6mI6ciJDWqTgDtjcsbHX1iaGs3aGtS47Gv0ksOFhoMLWYghV8aiOnXanO0iPBCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766437142; c=relaxed/simple;
	bh=sjwtFz0JjYexV+GhiRr9O9kGsc9QUIKYoV0RyUx96wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3/S0hBVo7CeHF8qtCJV5wCBdSm3EgheysR4xa7Vei4yYFsiTmcZIuHdfHaEUDt7L086aWkOXteEVv1OcLa9XBlUM2ZjPx/YmrvdRy7PETDOT4doI89vEKuYQ7w04x3CP0GelecY7EQe2lXSGqdNovxNISv8bP2gU2dSgptqC/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/0M/W+x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766437136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BivJwQmBfN501WN5Bzy/3ldR/alSM8jjNWDJsEYN3T0=;
	b=G/0M/W+xWZIbSlFVCYSXNk2jap7/fiM3UJLf8QN8xfl3IeamZighLEBQ/aLMOsE2kpE3dn
	6iIVOEuHQyB5R1xfYOgy+brEFqTEmqsuFOIf1FgObfqjxmReN8j8qqtiAWgY1uL8yWWZxv
	hTxt5RdPFNy0XXe8hIboMiAE6xLeL3g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-s2HsnVhUMrmKdHE5GtkTRg-1; Mon,
 22 Dec 2025 15:58:51 -0500
X-MC-Unique: s2HsnVhUMrmKdHE5GtkTRg-1
X-Mimecast-MFC-AGG-ID: s2HsnVhUMrmKdHE5GtkTRg_1766437130
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8781419560B2;
	Mon, 22 Dec 2025 20:58:49 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.32.178])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7FDC180045B;
	Mon, 22 Dec 2025 20:58:45 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jkarrenpalo@gmail.com,
	tglx@linutronix.de,
	mingo@kernel.org,
	allison.henderson@oracle.com,
	matttbe@kernel.org,
	petrm@nvidia.com,
	bigeasy@linutronix.de
Subject: [RFC net 3/6] selftests: hsr: Add tests for faulty links
Date: Mon, 22 Dec 2025 21:57:33 +0100
Message-ID: <2e01b214fcd600efedabc36972e8fa6ed312249c.1766433800.git.fmaurer@redhat.com>
In-Reply-To: <cover.1766433800.git.fmaurer@redhat.com>
References: <cover.1766433800.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add a test case that can support different types of faulty links for all
protocol versions (HSRv0, HSRv1, PRPv1). It starts with a baseline with
fully functional links. The first faulty case is one link being cut during
the ping. This test uses a different function for ping that sends more
packets in shorter intervals to stress the duplicate detection algorithms a
bit more and allow for future tests with other link faults (packet loss,
reordering, etc.).

As the link fault tests now cover the cut link for HSR and PRP, it can be
removed from the hsr_ping test. Note that the removed cut link test did not
really test the fault because do_ping_long takes about 1sec while the link
is only cut after a 3sec sleep.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 tools/testing/selftests/net/hsr/Makefile      |   1 +
 tools/testing/selftests/net/hsr/hsr_ping.sh   |  11 -
 .../testing/selftests/net/hsr/link_faults.sh  | 269 ++++++++++++++++++
 3 files changed, 270 insertions(+), 11 deletions(-)
 create mode 100755 tools/testing/selftests/net/hsr/link_faults.sh

diff --git a/tools/testing/selftests/net/hsr/Makefile b/tools/testing/selftests/net/hsr/Makefile
index 1886f345897a..31fb9326cf53 100644
--- a/tools/testing/selftests/net/hsr/Makefile
+++ b/tools/testing/selftests/net/hsr/Makefile
@@ -5,6 +5,7 @@ top_srcdir = ../../../../..
 TEST_PROGS := \
 	hsr_ping.sh \
 	hsr_redbox.sh \
+	link_faults.sh \
 	prp_ping.sh \
 # end of TEST_PROGS
 
diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh b/tools/testing/selftests/net/hsr/hsr_ping.sh
index b162ea07b5c1..7cb752c25ff2 100755
--- a/tools/testing/selftests/net/hsr/hsr_ping.sh
+++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
@@ -94,17 +94,6 @@ do_link_problem_tests()
 {
 	echo "INFO: Running link problem tests."
 
-	echo "INFO: Cutting one link."
-	do_ping_long "$ns1" 100.64.0.3 &
-
-	sleep 3
-	ip -net "$ns3" link set ns3eth1 down
-	wait
-
-	ip -net "$ns3" link set ns3eth1 up
-
-	stop_if_error "Failed with one link down."
-
 	echo "INFO: Delay the link and drop a few packages."
 	tc -net "$ns3" qdisc add dev ns3eth1 root netem delay 50ms
 	tc -net "$ns2" qdisc add dev ns2eth1 root netem delay 5ms loss 25%
diff --git a/tools/testing/selftests/net/hsr/link_faults.sh b/tools/testing/selftests/net/hsr/link_faults.sh
new file mode 100755
index 000000000000..b00fdba62f17
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/link_faults.sh
@@ -0,0 +1,269 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ../lib.sh
+
+ALL_TESTS="
+	test_clean_hsrv0
+	test_cut_link_hsrv0
+	test_clean_hsrv1
+	test_cut_link_hsrv1
+	test_clean_prp
+	test_cut_link_prp
+"
+
+# The tests are running ping for 5sec with a relatively short interval with a
+# cut link, which should be recoverable by HSR/PRP.
+
+setup_hsr_topo()
+{
+	# Three HSR nodes in a ring, every node has a LAN A interface connected to
+	# the LAN B interface of the next node.
+	#
+	#    node1            node2
+	#
+	#     vethA -------- vethB
+	#   hsr1                 hsr2
+	#     vethB          vethA
+	#         \          /
+	#         vethA  vethB
+	#             hsr3
+	#
+	#            node3
+
+	local ver="$1"
+
+	setup_ns node1 node2 node3
+
+	# veth links
+	ip link add vethA netns "$node1" type veth peer name vethB netns "$node2"
+	ip link add vethA netns "$node2" type veth peer name vethB netns "$node3"
+	ip link add vethA netns "$node3" type veth peer name vethB netns "$node1"
+
+	# MAC addresses (not needed for HSR operation, but helps with debugging)
+	ip -net "$node1" link set address 00:11:22:00:01:01 dev vethA
+	ip -net "$node1" link set address 00:11:22:00:01:02 dev vethB
+
+	ip -net "$node2" link set address 00:11:22:00:02:01 dev vethA
+	ip -net "$node2" link set address 00:11:22:00:02:02 dev vethB
+
+	ip -net "$node3" link set address 00:11:22:00:03:01 dev vethA
+	ip -net "$node3" link set address 00:11:22:00:03:02 dev vethB
+
+	# HSR interfaces
+	ip -net "$node1" link add name hsr1 type hsr proto 0 version $ver slave1 vethA slave2 vethB supervision 45
+	ip -net "$node2" link add name hsr2 type hsr proto 0 version $ver slave1 vethA slave2 vethB supervision 45
+	ip -net "$node3" link add name hsr3 type hsr proto 0 version $ver slave1 vethA slave2 vethB supervision 45
+
+	# IP addresses
+	ip -net "$node1" addr add 100.64.0.1/24 dev hsr1
+	ip -net "$node2" addr add 100.64.0.2/24 dev hsr2
+	ip -net "$node3" addr add 100.64.0.3/24 dev hsr3
+
+	# Set all links up
+	ip -net "$node1" link set vethA up
+	ip -net "$node1" link set vethB up
+	ip -net "$node1" link set hsr1 up
+
+	ip -net "$node2" link set vethA up
+	ip -net "$node2" link set vethB up
+	ip -net "$node2" link set hsr2 up
+
+	ip -net "$node3" link set vethA up
+	ip -net "$node3" link set vethB up
+	ip -net "$node3" link set hsr3 up
+}
+
+setup_prp_topo()
+{
+	# Two PRP nodes, connected by two links (treated as LAN A and LAN B).
+	#
+	#       vethA ----- vethA
+	#     prp1             prp2
+	#       vethB ----- vethB
+	#
+	#     node1           node2
+
+	setup_ns node1 node2
+
+	# veth links
+	ip link add vethA netns "$node1" type veth peer name vethA netns "$node2"
+	ip link add vethB netns "$node1" type veth peer name vethB netns "$node2"
+
+	# MAC addresses will be copied from LAN A interface
+	ip -net "$node1" link set address 00:11:22:00:00:01 dev vethA
+	ip -net "$node2" link set address 00:11:22:00:00:02 dev vethA
+
+	# PRP interfaces
+	ip -net "$node1" link add name prp1 type hsr slave1 vethA slave2 vethB supervision 45 proto 1
+	ip -net "$node2" link add name prp2 type hsr slave1 vethA slave2 vethB supervision 45 proto 1
+
+	# IP addresses
+	ip -net "$node1" addr add 100.64.0.1/24 dev prp1
+	ip -net "$node2" addr add 100.64.0.2/24 dev prp2
+
+	# All links up
+	ip -net "$node1" link set vethA up
+	ip -net "$node1" link set vethB up
+	ip -net "$node1" link set prp1 up
+
+	ip -net "$node2" link set vethA up
+	ip -net "$node2" link set vethB up
+	ip -net "$node2" link set prp2 up
+}
+
+wait_for_hsr_node_table()
+{
+	log_info "Wait for node table entries to be merged."
+	WAIT=5
+	while [ ${WAIT} -gt 0 ]; do
+		nts=$(cat /sys/kernel/debug/hsr/hsr*/node_table)
+
+		# We need entries in the node tables, and they need to be merged
+		if (echo "$nts" | grep -qE "^([0-9a-f]{2}:){5}") && \
+		    !(echo "$nts" | grep -q "00:00:00:00:00:00"); then
+			return
+		fi
+
+		sleep 1
+		((WAIT--))
+	done
+	check_err 1 "Failed to wait for merged node table entries"
+}
+
+setup_topo()
+{
+	local proto="$1"
+
+	if [ "$proto" = "HSRv0" ]; then
+		setup_hsr_topo 0
+		wait_for_hsr_node_table
+	elif [ "$proto" = "HSRv1" ]; then
+		setup_hsr_topo 1
+		wait_for_hsr_node_table
+	elif [ "$proto" = "PRP" ]; then
+		setup_prp_topo
+	else
+		check_err 1 "Unknown protocol (${proto})"
+	fi
+}
+
+check_ping()
+{
+	local node="$1"
+	local dst="$2"
+	local ping_args="-q -i 0.01 -c 400"
+
+	log_info "Running ping $node -> $dst"
+	output=$(LANG=C ip netns exec "$node" ping $ping_args "$dst" | grep "packets transmitted")
+	log_info "$output"
+
+	tx=0
+	rx=0
+	dups=0
+	loss=0
+
+	if [[ "$output" =~ ([0-9]+)" packets transmitted" ]]; then
+		tx="${BASH_REMATCH[1]}"
+	fi
+	if [[ "$output" =~ ([0-9]+)" received" ]]; then
+		rx="${BASH_REMATCH[1]}"
+	fi
+	if [[ "$output" =~ \+([0-9]+)" duplicates" ]]; then
+		dups="${BASH_REMATCH[1]}"
+	fi
+	if [[ "$output" =~ ([0-9\.]+\%)" packet loss" ]]; then
+		loss="${BASH_REMATCH[1]}"
+	fi
+
+	check_err "$dups" "Unexpected duplicate packets (${dups})"
+	if [ "$loss" != "0%" ]; then
+		check_err 1 "Unexpected packet loss (${loss})"
+	fi
+}
+
+test_clean()
+{
+	local proto="$1"
+
+	RET=0
+	tname="${FUNCNAME} - ${proto}"
+
+	setup_topo "$proto"
+	if ((RET != ksft_pass)); then
+		log_test "${tname} setup"
+		return
+	fi
+
+	check_ping "$node1" "100.64.0.2"
+
+	log_test "${tname}"
+}
+
+test_clean_hsrv0()
+{
+	test_clean "HSRv0"
+}
+
+test_clean_hsrv1()
+{
+	test_clean "HSRv1"
+}
+
+test_clean_prp()
+{
+	test_clean "PRP"
+}
+
+test_cut_link()
+{
+	local proto="$1"
+
+	RET=0
+	tname="${FUNCNAME} - ${proto}"
+
+	setup_topo "$proto"
+	if ((RET != ksft_pass)); then
+		log_test "${tname} setup"
+		return
+	fi
+
+	# Cutting link from subshell, so check_ping can run in the normal shell
+	# with access to global variables from the test harness.
+	(
+		sleep 2
+		log_info "Cutting link"
+		ip -net "$node1" link set vethB down
+	) &
+	check_ping "$node1" "100.64.0.2"
+
+	wait
+	log_test "${tname}"
+}
+
+
+test_cut_link_hsrv0()
+{
+	test_cut_link "HSRv0"
+}
+
+test_cut_link_hsrv1()
+{
+	test_cut_link "HSRv1"
+}
+
+test_cut_link_prp()
+{
+	test_cut_link "PRP"
+}
+
+cleanup()
+{
+	cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+tests_run
+
+exit $EXIT_STATUS
-- 
2.52.0


