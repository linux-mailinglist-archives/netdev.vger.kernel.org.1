Return-Path: <netdev+bounces-252391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKspClJAcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:20:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 882D5689D9
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7996B8E9F4E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF48B35C1B7;
	Thu, 22 Jan 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+dFYaH7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B823C27A461
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093865; cv=none; b=nlx3g1N1dWkp/HnzjKwVAPV+cRatqLsc0U2PT/sv4/ROkRyWTW+3wpj1rUhvjeiNQUlfSZFTAunsqcakl7JkoVKn2GqzKMNSU0PCBwlHN0Usi9909qsul0yo71Y4zlMqetmGFVdiJV+5IIsTJtwNS4XRzVDIQHTt4XNUAYEGxFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093865; c=relaxed/simple;
	bh=V7giiS5OxhLf/SD6IDKXWmO118YRjfo087SFHraEor4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBEnrpKsAKcgg1rEqhNW9Cy7nnv8vRF1Zyx+0VudTap1DPm2aaNp7KDRfrchszIJKk6POH+lVwZO5iluEnr+aIjCRjRrgEg5vFM7xgatObrMfAO8cgXF7QRq4dGhvPnHgoqmXTVoBBmd9IXDvst0kqc+wHaTSbwy0IiRkMxVuB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+dFYaH7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769093862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05XunFX+e1T2GX/7kq3uq/dY0zL0hT8+VctqiQ+u3gc=;
	b=B+dFYaH7kDBlFqeVaXKqBcPVBHUY9oyxI9UpsUBqJK/g1X7p8VKleu+onpziu4XabCmRwk
	6LgkDc8c8gm/8G1jiWaz/rI87KoSAMi+xC2ndR9xfTufut/i7NF5R/jxuC/T8yufXUNbZy
	Gi0eK5f3hb5qafetQ062KBS1TpGFBe4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-XkBnf0rMPgSggnVQmsV3rQ-1; Thu,
 22 Jan 2026 09:57:36 -0500
X-MC-Unique: XkBnf0rMPgSggnVQmsV3rQ-1
X-Mimecast-MFC-AGG-ID: XkBnf0rMPgSggnVQmsV3rQ_1769093853
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66E1D1956054;
	Thu, 22 Jan 2026 14:57:33 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.45.225.113])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B85D1800665;
	Thu, 22 Jan 2026 14:57:28 +0000 (UTC)
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
	petrm@nvidia.com,
	antonio@openvpn.net,
	bigeasy@linutronix.de
Subject: [PATCH net-next v2 3/9] selftests: hsr: Add tests for faulty links
Date: Thu, 22 Jan 2026 15:56:58 +0100
Message-ID: <8f27f385afd3bfa0ce8e7d8254457c49e11214e0.1769093335.git.fmaurer@redhat.com>
In-Reply-To: <cover.1769093335.git.fmaurer@redhat.com>
References: <cover.1769093335.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252391-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 882D5689D9
X-Rspamd-Action: no action

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
 .../testing/selftests/net/hsr/link_faults.sh  | 271 ++++++++++++++++++
 3 files changed, 272 insertions(+), 11 deletions(-)
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
index ebee4a18fc67..0ec71b20ab75 100755
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
index 000000000000..7ff14dcd32e7
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/link_faults.sh
@@ -0,0 +1,271 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# shellcheck disable=SC2329
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
+	# Three HSR nodes in a ring, every node has a LAN A interface connected
+	# to the LAN B interface of the next node.
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
+	# shellcheck disable=SC2154 # variables assigned by setup_ns
+	ip link add vethA netns "$node1" type veth peer name vethB netns "$node2"
+	# shellcheck disable=SC2154 # variables assigned by setup_ns
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
+	ip -net "$node1" link add name hsr1 type hsr proto 0 version "$ver" \
+		slave1 vethA slave2 vethB supervision 45
+	ip -net "$node2" link add name hsr2 type hsr proto 0 version "$ver" \
+		slave1 vethA slave2 vethB supervision 45
+	ip -net "$node3" link add name hsr3 type hsr proto 0 version "$ver" \
+		slave1 vethA slave2 vethB supervision 45
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
+	ip -net "$node1" link add name prp1 type hsr \
+		slave1 vethA slave2 vethB supervision 45 proto 1
+	ip -net "$node2" link add name prp2 type hsr \
+		slave1 vethA slave2 vethB supervision 45 proto 1
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
+	while [ "${WAIT}" -gt 0 ]; do
+		nts=$(cat /sys/kernel/debug/hsr/hsr*/node_table)
+
+		# We need entries in the node tables, and they need to be merged
+		if (echo "$nts" | grep -qE "^([0-9a-f]{2}:){5}") && \
+		    ! (echo "$nts" | grep -q "00:00:00:00:00:00"); then
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
+	# shellcheck disable=SC2086
+	output=$(ip netns exec "$node" ping $ping_args "$dst" | \
+		grep "packets transmitted")
+	log_info "$output"
+
+	dups=0
+	loss=0
+
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
+	tname="${FUNCNAME[0]} - ${proto}"
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
+	tname="${FUNCNAME[0]} - ${proto}"
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


