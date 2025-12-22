Return-Path: <netdev+bounces-245762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BC1CD729D
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 21:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39E983017866
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 20:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8523346A1;
	Mon, 22 Dec 2025 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJkdgRPJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF5E33EAF2
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766437135; cv=none; b=Z5iL63ZzPY0hEliIqRahcnZmclSxsDwcQ84FRGIPp1wJ7r5WLRBXi+JQQVxzmChUdyz8JiCWgaMpROYOOA2z+xptvC/HzIq7Qv/5XbN59eYaZlxafD0F9wAB+g/1Wm0kHUwXGQ+n81S50akX9t0hKZvDN+7WRDxXxccNQpO8I/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766437135; c=relaxed/simple;
	bh=ZtltSJWwXcDdsJfn81LTXvwOHm/xtYY5Xlok4qH4FyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVo/VOkAZ/1UhlPoDZKSSO7jGvCOKf81TtJQ/8a0qns4N5B0twLytxvkBEAOoh9vuB04d5cQO33R4miPMZgVFEqqste8JVet6qKq1T74pT+DyNd262X595+jWJ/NeOxOXwem1RETXST9rwTx48qIkA4I6hX6VBWVBHbV+kt0964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJkdgRPJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766437130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enBYVtCRT8ORiRAaaeYQWvEr31bCS/zyRBGv/wcIzPM=;
	b=VJkdgRPJt7LVv112TLAGXQAx+7LnJPVDp3fy/CLNlk9sCpQ9rM809rufIkCTSIIEe60Vdu
	CNNp9emqHFEI/1K+Tf8xM6orT/+PlW66AJg7jiiUtdNQU3E3VRkwQTcnOflwsi7ZhI7kHm
	tba4Gz31GiSnPtWIrRbIBQ2xGMbv/Nc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-t7z8hatwPfOOwBHHrxP3PQ-1; Mon,
 22 Dec 2025 15:58:47 -0500
X-MC-Unique: t7z8hatwPfOOwBHHrxP3PQ-1
X-Mimecast-MFC-AGG-ID: t7z8hatwPfOOwBHHrxP3PQ_1766437125
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69EE9195608E;
	Mon, 22 Dec 2025 20:58:45 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.32.178])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E95D180045B;
	Mon, 22 Dec 2025 20:58:41 +0000 (UTC)
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
Subject: [RFC net 2/6] selftests: hsr: Check duplicates on HSR with VLAN
Date: Mon, 22 Dec 2025 21:57:32 +0100
Message-ID: <997ac33647ece9f112c74fa9034c97b38933b8f3.1766433800.git.fmaurer@redhat.com>
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

Previously the hsr_ping test only checked that all nodes in a VLAN are
reachable (using do_ping). Update the test to also check that there is no
packet loss and no duplicate packets by running the same tests for VLANs as
without VLANs (including using do_ping_long). This also adds tests for IPv6
over VLAN. To unify the test code, the topology without VLANs now uses IP
addresses from dead:beef:0::/64 to align with the 100.64.0.0/24 range for
IPv4. Error messages are updated across the board to make it easier to find
what actually failed.

Also update the VLAN test to only run in VLAN 2, as there is no need to
check if ping really works with VLAN IDs 2, 3, 4, and 5. This lowers the
number of long ping tests on VLANs to keep the overall test runtime in
bounds.

It's still necessary to bump the test timeout a bit, though: a ping long
tests takes 1sec, do_ping_tests performs 12 of them, do_link_problem_tests
6, and the VLAN tests again 12. With some buffer for setup and waiting and
for two protocol versions, 90sec timeout seems reasonable.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 tools/testing/selftests/net/hsr/hsr_ping.sh | 179 +++++++-------------
 tools/testing/selftests/net/hsr/settings    |   2 +-
 2 files changed, 64 insertions(+), 117 deletions(-)

diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh b/tools/testing/selftests/net/hsr/hsr_ping.sh
index 5a65f4f836be..b162ea07b5c1 100755
--- a/tools/testing/selftests/net/hsr/hsr_ping.sh
+++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
@@ -27,31 +27,34 @@ while getopts "$optstring" option;do
 esac
 done

-do_complete_ping_test()
+do_ping_tests()
 {
-	echo "INFO: Initial validation ping."
-	# Each node has to be able each one.
-	do_ping "$ns1" 100.64.0.2
-	do_ping "$ns2" 100.64.0.1
-	do_ping "$ns3" 100.64.0.1
-	stop_if_error "Initial validation failed."
-
-	do_ping "$ns1" 100.64.0.3
-	do_ping "$ns2" 100.64.0.3
-	do_ping "$ns3" 100.64.0.2
+	local netid="$1"

-	do_ping "$ns1" dead:beef:1::2
-	do_ping "$ns1" dead:beef:1::3
-	do_ping "$ns2" dead:beef:1::1
-	do_ping "$ns2" dead:beef:1::2
-	do_ping "$ns3" dead:beef:1::1
-	do_ping "$ns3" dead:beef:1::2
+	echo "INFO: Running ping tests."

-	stop_if_error "Initial validation failed."
+	echo "INFO: Initial validation ping."
+	# Each node has to be able to reach each one.
+	do_ping "$ns1" 100.64.$netid.2
+	do_ping "$ns1" 100.64.$netid.3
+	do_ping "$ns2" 100.64.$netid.1
+	do_ping "$ns2" 100.64.$netid.3
+	do_ping "$ns3" 100.64.$netid.1
+	do_ping "$ns3" 100.64.$netid.2
+	stop_if_error "Initial validation failed on IPv4."
+
+	do_ping "$ns1" dead:beef:$netid::2
+	do_ping "$ns1" dead:beef:$netid::3
+	do_ping "$ns2" dead:beef:$netid::1
+	do_ping "$ns2" dead:beef:$netid::2
+	do_ping "$ns3" dead:beef:$netid::1
+	do_ping "$ns3" dead:beef:$netid::2
+	stop_if_error "Initial validation failed on IPv6."

 # Wait until supervisor all supervision frames have been processed and the node
 # entries have been merged. Otherwise duplicate frames will be observed which is
 # valid at this stage.
+	echo "INFO: Wait for node table entries to be merged."
 	WAIT=5
 	while [ ${WAIT} -gt 0 ]
 	do
@@ -68,24 +71,28 @@ do_complete_ping_test()
 	sleep 1

 	echo "INFO: Longer ping test."
-	do_ping_long "$ns1" 100.64.0.2
-	do_ping_long "$ns1" dead:beef:1::2
-	do_ping_long "$ns1" 100.64.0.3
-	do_ping_long "$ns1" dead:beef:1::3
-
-	stop_if_error "Longer ping test failed."
-
-	do_ping_long "$ns2" 100.64.0.1
-	do_ping_long "$ns2" dead:beef:1::1
-	do_ping_long "$ns2" 100.64.0.3
-	do_ping_long "$ns2" dead:beef:1::2
-	stop_if_error "Longer ping test failed."
+	do_ping_long "$ns1" 100.64.$netid.2
+	do_ping_long "$ns1" dead:beef:$netid::2
+	do_ping_long "$ns1" 100.64.$netid.3
+	do_ping_long "$ns1" dead:beef:$netid::3
+	stop_if_error "Longer ping test failed (ns1)."
+
+	do_ping_long "$ns2" 100.64.$netid.1
+	do_ping_long "$ns2" dead:beef:$netid::1
+	do_ping_long "$ns2" 100.64.$netid.3
+	do_ping_long "$ns2" dead:beef:$netid::3
+	stop_if_error "Longer ping test failed (ns2)."
+
+	do_ping_long "$ns3" 100.64.$netid.1
+	do_ping_long "$ns3" dead:beef:$netid::1
+	do_ping_long "$ns3" 100.64.$netid.2
+	do_ping_long "$ns3" dead:beef:$netid::2
+	stop_if_error "Longer ping test failed (ns3)."
+}

-	do_ping_long "$ns3" 100.64.0.1
-	do_ping_long "$ns3" dead:beef:1::1
-	do_ping_long "$ns3" 100.64.0.2
-	do_ping_long "$ns3" dead:beef:1::2
-	stop_if_error "Longer ping test failed."
+do_link_problem_tests()
+{
+	echo "INFO: Running link problem tests."

 	echo "INFO: Cutting one link."
 	do_ping_long "$ns1" 100.64.0.3 &
@@ -104,26 +111,22 @@ do_complete_ping_test()

 	do_ping_long "$ns1" 100.64.0.2
 	do_ping_long "$ns1" 100.64.0.3
-
-	stop_if_error "Failed with delay and packetloss."
+	stop_if_error "Failed with delay and packetloss (ns1)."

 	do_ping_long "$ns2" 100.64.0.1
 	do_ping_long "$ns2" 100.64.0.3
-
-	stop_if_error "Failed with delay and packetloss."
+	stop_if_error "Failed with delay and packetloss (ns2)."

 	do_ping_long "$ns3" 100.64.0.1
 	do_ping_long "$ns3" 100.64.0.2
-	stop_if_error "Failed with delay and packetloss."
-
-	echo "INFO: All good."
+	stop_if_error "Failed with delay and packetloss (ns3)."
 }

 setup_hsr_interfaces()
 {
 	local HSRv="$1"

-	echo "INFO: preparing interfaces for HSRv${HSRv}."
+	echo "INFO: Preparing interfaces for HSRv${HSRv}."
 # Three HSR nodes. Each node has one link to each of its neighbour, two links in total.
 #
 #    ns1eth1 ----- ns2eth1
@@ -146,11 +149,11 @@ setup_hsr_interfaces()

 	# IP for HSR
 	ip -net "$ns1" addr add 100.64.0.1/24 dev hsr1
-	ip -net "$ns1" addr add dead:beef:1::1/64 dev hsr1 nodad
+	ip -net "$ns1" addr add dead:beef:0::1/64 dev hsr1 nodad
 	ip -net "$ns2" addr add 100.64.0.2/24 dev hsr2
-	ip -net "$ns2" addr add dead:beef:1::2/64 dev hsr2 nodad
+	ip -net "$ns2" addr add dead:beef:0::2/64 dev hsr2 nodad
 	ip -net "$ns3" addr add 100.64.0.3/24 dev hsr3
-	ip -net "$ns3" addr add dead:beef:1::3/64 dev hsr3 nodad
+	ip -net "$ns3" addr add dead:beef:0::3/64 dev hsr3 nodad

 	ip -net "$ns1" link set address 00:11:22:00:01:01 dev ns1eth1
 	ip -net "$ns1" link set address 00:11:22:00:01:02 dev ns1eth2
@@ -177,85 +180,33 @@ setup_hsr_interfaces()

 setup_vlan_interfaces() {
 	ip -net "$ns1" link add link hsr1 name hsr1.2 type vlan id 2
-	ip -net "$ns1" link add link hsr1 name hsr1.3 type vlan id 3
-	ip -net "$ns1" link add link hsr1 name hsr1.4 type vlan id 4
-	ip -net "$ns1" link add link hsr1 name hsr1.5 type vlan id 5
-
 	ip -net "$ns2" link add link hsr2 name hsr2.2 type vlan id 2
-	ip -net "$ns2" link add link hsr2 name hsr2.3 type vlan id 3
-	ip -net "$ns2" link add link hsr2 name hsr2.4 type vlan id 4
-	ip -net "$ns2" link add link hsr2 name hsr2.5 type vlan id 5
-
 	ip -net "$ns3" link add link hsr3 name hsr3.2 type vlan id 2
-	ip -net "$ns3" link add link hsr3 name hsr3.3 type vlan id 3
-	ip -net "$ns3" link add link hsr3 name hsr3.4 type vlan id 4
-	ip -net "$ns3" link add link hsr3 name hsr3.5 type vlan id 5

 	ip -net "$ns1" addr add 100.64.2.1/24 dev hsr1.2
-	ip -net "$ns1" addr add 100.64.3.1/24 dev hsr1.3
-	ip -net "$ns1" addr add 100.64.4.1/24 dev hsr1.4
-	ip -net "$ns1" addr add 100.64.5.1/24 dev hsr1.5
+	ip -net "$ns1" addr add dead:beef:2::1/64 dev hsr1.2 nodad

 	ip -net "$ns2" addr add 100.64.2.2/24 dev hsr2.2
-	ip -net "$ns2" addr add 100.64.3.2/24 dev hsr2.3
-	ip -net "$ns2" addr add 100.64.4.2/24 dev hsr2.4
-	ip -net "$ns2" addr add 100.64.5.2/24 dev hsr2.5
+	ip -net "$ns2" addr add dead:beef:2::2/64 dev hsr2.2 nodad

 	ip -net "$ns3" addr add 100.64.2.3/24 dev hsr3.2
-	ip -net "$ns3" addr add 100.64.3.3/24 dev hsr3.3
-	ip -net "$ns3" addr add 100.64.4.3/24 dev hsr3.4
-	ip -net "$ns3" addr add 100.64.5.3/24 dev hsr3.5
+	ip -net "$ns3" addr add dead:beef:2::3/64 dev hsr3.2 nodad

 	ip -net "$ns1" link set dev hsr1.2 up
-	ip -net "$ns1" link set dev hsr1.3 up
-	ip -net "$ns1" link set dev hsr1.4 up
-	ip -net "$ns1" link set dev hsr1.5 up
-
 	ip -net "$ns2" link set dev hsr2.2 up
-	ip -net "$ns2" link set dev hsr2.3 up
-	ip -net "$ns2" link set dev hsr2.4 up
-	ip -net "$ns2" link set dev hsr2.5 up
-
 	ip -net "$ns3" link set dev hsr3.2 up
-	ip -net "$ns3" link set dev hsr3.3 up
-	ip -net "$ns3" link set dev hsr3.4 up
-	ip -net "$ns3" link set dev hsr3.5 up

 }

-hsr_vlan_ping() {
-	do_ping "$ns1" 100.64.2.2
-	do_ping "$ns1" 100.64.3.2
-	do_ping "$ns1" 100.64.4.2
-	do_ping "$ns1" 100.64.5.2
-
-	do_ping "$ns1" 100.64.2.3
-	do_ping "$ns1" 100.64.3.3
-	do_ping "$ns1" 100.64.4.3
-	do_ping "$ns1" 100.64.5.3
-
-	do_ping "$ns2" 100.64.2.1
-	do_ping "$ns2" 100.64.3.1
-	do_ping "$ns2" 100.64.4.1
-	do_ping "$ns2" 100.64.5.1
-
-	do_ping "$ns2" 100.64.2.3
-	do_ping "$ns2" 100.64.3.3
-	do_ping "$ns2" 100.64.4.3
-	do_ping "$ns2" 100.64.5.3
-
-	do_ping "$ns3" 100.64.2.1
-	do_ping "$ns3" 100.64.3.1
-	do_ping "$ns3" 100.64.4.1
-	do_ping "$ns3" 100.64.5.1
-
-	do_ping "$ns3" 100.64.2.2
-	do_ping "$ns3" 100.64.3.2
-	do_ping "$ns3" 100.64.4.2
-	do_ping "$ns3" 100.64.5.2
+run_complete_ping_tests()
+{
+	echo "INFO: Running complete ping tests."
+	do_ping_tests 0
+	do_link_problem_tests
 }

-run_vlan_tests() {
+run_vlan_tests()
+{
 	vlan_challenged_hsr1=$(ip net exec "$ns1" ethtool -k hsr1 | grep "vlan-challenged" | awk '{print $2}')
 	vlan_challenged_hsr2=$(ip net exec "$ns2" ethtool -k hsr2 | grep "vlan-challenged" | awk '{print $2}')
 	vlan_challenged_hsr3=$(ip net exec "$ns3" ethtool -k hsr3 | grep "vlan-challenged" | awk '{print $2}')
@@ -263,27 +214,23 @@ run_vlan_tests() {
 	if [[ "$vlan_challenged_hsr1" = "off" || "$vlan_challenged_hsr2" = "off" || "$vlan_challenged_hsr3" = "off" ]]; then
 		echo "INFO: Running VLAN tests"
 		setup_vlan_interfaces
-		hsr_vlan_ping
+		do_ping_tests 2
 	else
 		echo "INFO: Not Running VLAN tests as the device does not support VLAN"
 	fi
 }

 check_prerequisites
-setup_ns ns1 ns2 ns3
-
 trap cleanup_all_ns EXIT

+setup_ns ns1 ns2 ns3
 setup_hsr_interfaces 0
-do_complete_ping_test
-
+run_complete_ping_tests
 run_vlan_tests

 setup_ns ns1 ns2 ns3
-
 setup_hsr_interfaces 1
-do_complete_ping_test
-
+run_complete_ping_tests
 run_vlan_tests

 exit $ret
diff --git a/tools/testing/selftests/net/hsr/settings b/tools/testing/selftests/net/hsr/settings
index 0fbc037f2aa8..ba4d85f74cd6 100644
--- a/tools/testing/selftests/net/hsr/settings
+++ b/tools/testing/selftests/net/hsr/settings
@@ -1 +1 @@
-timeout=50
+timeout=90
--
2.52.0


