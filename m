Return-Path: <netdev+bounces-252396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEGRB2NAcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:21:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2F5689F0
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EFAC96540D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBD4355815;
	Thu, 22 Jan 2026 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/8R1bG9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931A12FD1B3
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093883; cv=none; b=GiWdWuH4vlV+C008f/V5AU85+KfgYwavwETYp8Zek/m/O+cBklxvy3f+moTGHpP+My1fPtpdpIl4RXlcEzWNDTgzAP6ZceRL7XjKal5q04qvcTd8ggHipfcrCjGYJvy8++0JTqIpjvZQO7M1yK23tSc4aKgtdRa7+NzuclGPJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093883; c=relaxed/simple;
	bh=g8Xon+kVO++D9cwui1Mo+NVj/kewSl+Mubfzf32Fdc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgSGeGscGHnx5i7qWbaJP5EIGjms1N5juAIk2NEjqFLMm1ols8f2BAFjM+PGBDsmGTQPHCo35MSgxXtkeah6RhsKaDZU7xDyzpNOt4WL7kjZGvaWOzKBLk4DVEfBzKUZJshma4v+cmGKKb6tHYzC3I48zlJwo1eqqKpfFnyWb/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/8R1bG9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769093880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsUDGZwGp4WjTSRquF/SuZOOlyPSd7p5ASlRN+carOY=;
	b=R/8R1bG9CiIgMn2F/zvbY4b8WBs8lafXAN7hzqOGh6/KiX5IO546OMFIoXgO6uqrZp3EqX
	IrkxOEFyQTGiRCp/14iJ3SFzAKvEOoWyPpjw4AJwGzUV9h3DfR6hmbvJHdoIUZjYJ5GhRi
	/PlN/mmJJeJ6ynFyRNrBy/mB92eqo7M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-ST_KylsQPSuTzdAj4TqpQg-1; Thu,
 22 Jan 2026 09:57:57 -0500
X-MC-Unique: ST_KylsQPSuTzdAj4TqpQg-1
X-Mimecast-MFC-AGG-ID: ST_KylsQPSuTzdAj4TqpQg_1769093873
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1555B1800371;
	Thu, 22 Jan 2026 14:57:53 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.45.225.113])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD4131800998;
	Thu, 22 Jan 2026 14:57:48 +0000 (UTC)
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
Subject: [PATCH net-next v2 7/9] selftests: hsr: Add more link fault tests for HSR
Date: Thu, 22 Jan 2026 15:57:02 +0100
Message-ID: <fd04ef598f6104e1a6badfa155d56bb85d52533d.1769093335.git.fmaurer@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-252396-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F2F5689F0
X-Rspamd-Action: no action

Run the packet loss and reordering tests also for both HSR versions. Now
they can be removed from the hsr_ping tests completely. Note that the tests
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
index 0ec71b20ab75..f4d685df4345 100755
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
@@ -190,11 +169,10 @@ setup_vlan_interfaces() {
 
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
@@ -204,7 +182,7 @@ run_vlan_tests()
 	vlan_challenged_hsr3=$(ip net exec "$ns3" ethtool -k hsr3 | grep "vlan-challenged" | awk '{print $2}')
 
 	if [[ "$vlan_challenged_hsr1" = "off" || "$vlan_challenged_hsr2" = "off" || "$vlan_challenged_hsr3" = "off" ]]; then
-		echo "INFO: Running VLAN tests"
+		echo "INFO: Running VLAN ping tests"
 		setup_vlan_interfaces
 		do_ping_tests 2
 	else
@@ -217,12 +195,12 @@ trap cleanup_all_ns EXIT
 
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
index 1959bea17147..be526281571c 100755
--- a/tools/testing/selftests/net/hsr/link_faults.sh
+++ b/tools/testing/selftests/net/hsr/link_faults.sh
@@ -7,8 +7,16 @@ source ../lib.sh
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
@@ -292,11 +300,31 @@ test_packet_loss()
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
@@ -323,6 +351,16 @@ test_reordering()
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


