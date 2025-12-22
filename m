Return-Path: <netdev+bounces-245766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF55CD72AC
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 21:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC67D3018301
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 20:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC3833B6E9;
	Mon, 22 Dec 2025 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUqebg/p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45E3346A1
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766437153; cv=none; b=GjwSHQ/EDZEpSAXOQVgNdJJZfB6wzDJCmcwv1DVKCYmRIR4aN830YzkF0FF+cdFBPwtetc5CwntB4HP1L/kQzBlefRgwnBxxLz/xctvfqJXVR5dbKbViK4hpcGROl6sq2ARNVW3deyr9QdrSECQj74spfNUOHEJkWjCFLJ9H7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766437153; c=relaxed/simple;
	bh=8hKC9YGfhL4MRAcw/dhkZDa+uzoxqh7YN+/UgVGtICg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtZxFi7qLPHPwKERGuU9HYPPJbloljF1UX6nVpVGFF3SFfYOLPgI8UhfVoNReZetYXSNxoRtTEJQGsBwLmP0BRzpovb3S2G+KZqIVL4Zm4KY+Ye22uIwJmcoR7ud1I4p+VxJfNml2CdFuGVZx/ALm8Zk0IQXxK9SaLh75lSqdsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RUqebg/p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766437147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlA6U9YCOue9Zq4ZIOjb0uaIXIXNuOQnLJ08V3zdjh8=;
	b=RUqebg/pHlnp82R/Fiq218p9pPoG79sZA3HrMyvluc335tUtpLcuA7adfEMdN239ODvmU2
	BHhptb9JeXfLHFEufGBaKUvzAEs059kZYIejysXgtZiPvlvlmMiKELi4rWDIXpbZ+cW1Rm
	V4sDlXphZnacyIvYqHtDUqhyup0FjY4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-KRngBhCwMzO-g43hn2QcGg-1; Mon,
 22 Dec 2025 15:59:03 -0500
X-MC-Unique: KRngBhCwMzO-g43hn2QcGg-1
X-Mimecast-MFC-AGG-ID: KRngBhCwMzO-g43hn2QcGg_1766437141
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA3EA1956094;
	Mon, 22 Dec 2025 20:59:01 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.32.178])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 390361800352;
	Mon, 22 Dec 2025 20:58:57 +0000 (UTC)
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
Subject: [RFC net 6/6] selftests: hsr: Add more link fault tests for HSR
Date: Mon, 22 Dec 2025 21:57:36 +0100
Message-ID: <6d1fab1aa78d643141e070228937ed53d0c191f7.1766433800.git.fmaurer@redhat.com>
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

Run the packet loss and reordering tests also for both HSR versions. Now
they can be removed from the hsr_ping tests completly. Note that the tests
currently fail because the HSR duplicate discard algorithm does not
sufficiently take faulty links into account.

The timeout needs to be increased because there are 15 link fault test
cases now, with each of them taking 5-6sec for the test and at most 5sec
for the HSR node tables to get merged and we also want some room to make
the test runs stable.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 tools/testing/selftests/net/hsr/hsr_ping.sh   | 32 +++-------------
 .../testing/selftests/net/hsr/link_faults.sh  | 38 +++++++++++++++++++
 tools/testing/selftests/net/hsr/settings      |  2 +-
 3 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh b/tools/testing/selftests/net/hsr/hsr_ping.sh
index 7cb752c25ff2..1ff074dcf93e 100755
--- a/tools/testing/selftests/net/hsr/hsr_ping.sh
+++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
@@ -90,27 +90,6 @@ do_ping_tests()
 	stop_if_error "Longer ping test failed (ns3)."
 }
 
-do_link_problem_tests()
-{
-	echo "INFO: Running link problem tests."
-
-	echo "INFO: Delay the link and drop a few packages."
-	tc -net "$ns3" qdisc add dev ns3eth1 root netem delay 50ms
-	tc -net "$ns2" qdisc add dev ns2eth1 root netem delay 5ms loss 25%
-
-	do_ping_long "$ns1" 100.64.0.2
-	do_ping_long "$ns1" 100.64.0.3
-	stop_if_error "Failed with delay and packetloss (ns1)."
-
-	do_ping_long "$ns2" 100.64.0.1
-	do_ping_long "$ns2" 100.64.0.3
-	stop_if_error "Failed with delay and packetloss (ns2)."
-
-	do_ping_long "$ns3" 100.64.0.1
-	do_ping_long "$ns3" 100.64.0.2
-	stop_if_error "Failed with delay and packetloss (ns3)."
-}
-
 setup_hsr_interfaces()
 {
 	local HSRv="$1"
@@ -187,11 +166,10 @@ setup_vlan_interfaces() {
 
 }
 
-run_complete_ping_tests()
+run_ping_tests()
 {
-	echo "INFO: Running complete ping tests."
+	echo "INFO: Running ping tests."
 	do_ping_tests 0
-	do_link_problem_tests
 }
 
 run_vlan_tests()
@@ -201,7 +179,7 @@ run_vlan_tests()
 	vlan_challenged_hsr3=$(ip net exec "$ns3" ethtool -k hsr3 | grep "vlan-challenged" | awk '{print $2}')
 
 	if [[ "$vlan_challenged_hsr1" = "off" || "$vlan_challenged_hsr2" = "off" || "$vlan_challenged_hsr3" = "off" ]]; then
-		echo "INFO: Running VLAN tests"
+		echo "INFO: Running VLAN ping tests"
 		setup_vlan_interfaces
 		do_ping_tests 2
 	else
@@ -214,12 +192,12 @@ trap cleanup_all_ns EXIT
 
 setup_ns ns1 ns2 ns3
 setup_hsr_interfaces 0
-run_complete_ping_tests
+run_ping_tests
 run_vlan_tests
 
 setup_ns ns1 ns2 ns3
 setup_hsr_interfaces 1
-run_complete_ping_tests
+run_ping_tests
 run_vlan_tests
 
 exit $ret
diff --git a/tools/testing/selftests/net/hsr/link_faults.sh b/tools/testing/selftests/net/hsr/link_faults.sh
index 11a55ba5cd7d..e246a38abb7c 100755
--- a/tools/testing/selftests/net/hsr/link_faults.sh
+++ b/tools/testing/selftests/net/hsr/link_faults.sh
@@ -6,8 +6,16 @@ source ../lib.sh
 ALL_TESTS="
 	test_clean_hsrv0
 	test_cut_link_hsrv0
+	test_packet_loss_hsrv0
+	test_high_packet_loss_hsrv0
+	test_reordering_hsrv0
+
 	test_clean_hsrv1
 	test_cut_link_hsrv1
+	test_packet_loss_hsrv1
+	test_high_packet_loss_hsrv1
+	test_reordering_hsrv1
+
 	test_clean_prp
 	test_cut_link_prp
 	test_packet_loss_prp
@@ -290,11 +298,31 @@ test_packet_loss()
 	log_test "${tname}"
 }
 
+test_packet_loss_hsrv0()
+{
+	test_packet_loss "HSRv0" "20%"
+}
+
+test_packet_loss_hsrv1()
+{
+	test_packet_loss "HSRv1" "20%"
+}
+
 test_packet_loss_prp()
 {
 	test_packet_loss "PRP" "20%"
 }
 
+test_high_packet_loss_hsrv0()
+{
+	test_packet_loss "HSRv0" "80%"
+}
+
+test_high_packet_loss_hsrv1()
+{
+	test_packet_loss "HSRv1" "80%"
+}
+
 test_high_packet_loss_prp()
 {
 	test_packet_loss "PRP" "80%"
@@ -321,6 +349,16 @@ test_reordering()
 	log_test "${tname}"
 }
 
+test_reordering_hsrv0()
+{
+	test_reordering "HSRv0"
+}
+
+test_reordering_hsrv1()
+{
+	test_reordering "HSRv1"
+}
+
 test_reordering_prp()
 {
 	test_reordering "PRP"
diff --git a/tools/testing/selftests/net/hsr/settings b/tools/testing/selftests/net/hsr/settings
index ba4d85f74cd6..a953c96aa16e 100644
--- a/tools/testing/selftests/net/hsr/settings
+++ b/tools/testing/selftests/net/hsr/settings
@@ -1 +1 @@
-timeout=90
+timeout=180
-- 
2.52.0


