Return-Path: <netdev+bounces-257196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOVyBXCihGmI3wMAu9opvQ
	(envelope-from <netdev+bounces-257196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:00:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EFEF3AA1
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F6093045E3B
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0C33E9F8E;
	Thu,  5 Feb 2026 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayyhWGMx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC9E3E95B2
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299907; cv=none; b=U230CjES9c8uyKFDYNJxILYMou8Nlj3rKT727CVKBmGrtdkm2SCwbyILfZAJAxh8NCHqwxqJu8bfFljg0JwLBqbt0bc2AjJy+B+nA/oS5xDZrGYq5SXyBiDDqvOUQugtQ1ld2hdcKlDio5kyvt9dO6FV/Tk0XkhSbjRBeACbzyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299907; c=relaxed/simple;
	bh=Sty8jEBr8K+QvKIPkmFuGP9yEh2/cCmT6eW8JO/PwSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AH08bevGi9jUmrUJB33eDi7AAx+Qr+XgOw5q6/SpfqTv9TD3ktBYWDq2QN+bPE5oRdlyVgksajeU/WF/xKsj3Y7OSYRyFKem7YgJG0UcsofN3lwZ2E2PtfocClp0zreCxETIxhmuF6cOW6TDAIY35mpLWVfh49VY/DGDzNpY1qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayyhWGMx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770299905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yiR0KzptTckgFJNRtOKoP0pmkf4KnvM33raZL4ne7Ro=;
	b=ayyhWGMxECE+QKF1bATm0Kb04BwsSB3lrVzr1AxIAxjNmrEjd5Sdy84FGtSh9j1IA9xrDG
	NszI0QOwGmZejujXrkakpVSsriOBk6nQhbwC+S68dq4kMMrOzqNaZS+WJBTO0xzzAJECzp
	zOOSa2xmEkhoU5MR/PduMrYfN0YxBf4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-3zVptzsvMpOfvoQCRgGMdA-1; Thu,
 05 Feb 2026 08:58:20 -0500
X-MC-Unique: 3zVptzsvMpOfvoQCRgGMdA-1
X-Mimecast-MFC-AGG-ID: 3zVptzsvMpOfvoQCRgGMdA_1770299899
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF471195608F;
	Thu,  5 Feb 2026 13:58:18 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.32.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AE1019560B4;
	Thu,  5 Feb 2026 13:58:14 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jkarrenpalo@gmail.com,
	tglx@kernel.org,
	mingo@kernel.org,
	bigeasy@linutronix.de,
	matttbe@kernel.org,
	allison.henderson@oracle.com,
	petrm@nvidia.com,
	antonio@openvpn.net
Subject: [PATCH net-next v4 7/8] selftests: hsr: Add more link fault tests for HSR
Date: Thu,  5 Feb 2026 14:57:34 +0100
Message-ID: <eb6f667d3804ce63d86f0ee3fbc0e0ac9e1a209a.1770299429.git.fmaurer@redhat.com>
In-Reply-To: <cover.1770299429.git.fmaurer@redhat.com>
References: <cover.1770299429.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	TAGGED_FROM(0.00)[bounces-257196-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5EFEF3AA1
X-Rspamd-Action: no action

Run the packet loss and reordering tests also for both HSR versions. Now
they can be removed from the hsr_ping tests completely. The timeout needs
to be increased because there are 15 link fault test cases now, with each
of them taking 5-6sec for the test and at most 5sec for the HSR node tables
to get merged and we also want some room to make the test runs stable.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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


