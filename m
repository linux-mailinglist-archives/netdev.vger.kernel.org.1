Return-Path: <netdev+bounces-251889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEL7MFvZcGmraQAAu9opvQ
	(envelope-from <netdev+bounces-251889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:49:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7720557E8D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CEFE9C79C8
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C949B427A1A;
	Wed, 21 Jan 2026 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+u3H74g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA748125B
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002506; cv=none; b=ZXrwO/u/BNkc0gbNnqjYSMV3O7JTHrSlQMyydrX0dUjxLKIYtylvt2SKp93Zudy8oE1fCZju85ZPKTKJNirAn+iHvaYIZghp+996q6Gb4xKbnnza3e6l27+TzbloJq0WYkFBMzqg6WRFW82BVuKJGhIXZnR8YkPh1a7wiO28K1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002506; c=relaxed/simple;
	bh=hhQoq0gCeUxi2n9yz7sPt/ISKjP+9gkyvyv50ARrmk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdUbq76J8BW9vXxvEE00OL96F3pbAsJsQqDcFsOzF/CE6PR1FiCQAcsdmT2KRWiHfNMjKJyaUgim4XkodgQL7Y0JXATknB/6seN6gWPikA61DpzHOBMn3hKo5WfoYkadtRj9ucuqSs+AlQMhQXSrAF3EEGnTXYHOw8/SxPBrzt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+u3H74g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769002503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHfyLyCxrv9Zdq5O2HBHG/L0AjXECKb27/Osx3sJCGw=;
	b=K+u3H74gUrVVtIFPLuMIxr0/phdd4ROPt/EJhIa+3dQ4WAdFGgq9b7hplFTEQrzmOm3HKm
	f93Immw1sekatBtEjmMKyRDnWU9/imhI3GucboH3FBLCv3Q7CAOL2f/6g20GJP0yBv6u7Q
	Pqy/1PDTfLyc+SxTyimqyyffQuzt2Jw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-YuHodBDRNrmatDkPt021XQ-1; Wed,
 21 Jan 2026 08:35:00 -0500
X-MC-Unique: YuHodBDRNrmatDkPt021XQ-1
X-Mimecast-MFC-AGG-ID: YuHodBDRNrmatDkPt021XQ_1769002498
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FB641956096;
	Wed, 21 Jan 2026 13:34:58 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.33.242])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D403D19560AB;
	Wed, 21 Jan 2026 13:34:54 +0000 (UTC)
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
Subject: [PATCH net-next 2/9] selftests: hsr: Check duplicates on HSR with VLAN
Date: Wed, 21 Jan 2026 14:33:01 +0100
Message-ID: <029cea9e1d28835f97d5b847164a646ce8e1594f.1769001553.git.fmaurer@redhat.com>
In-Reply-To: <cover.1769001553.git.fmaurer@redhat.com>
References: <cover.1769001553.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251889-lists,netdev=lfdr.de];
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
	R_SPF_SOFTFAIL(0.00)[~all];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7720557E8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 tools/testing/selftests/net/hsr/hsr_ping.sh | 188 +++++++-------------
 tools/testing/selftests/net/hsr/settings    |   2 +-
 2 files changed, 70 insertions(+), 120 deletions(-)

diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh b/tools/testing/selftests/net/hsr/hsr_ping.sh
index 5a65f4f836be..ebee4a18fc67 100755
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
+	do_ping "$ns1" "100.64.$netid.2"
+	do_ping "$ns1" "100.64.$netid.3"
+	do_ping "$ns2" "100.64.$netid.1"
+	do_ping "$ns2" "100.64.$netid.3"
+	do_ping "$ns3" "100.64.$netid.1"
+	do_ping "$ns3" "100.64.$netid.2"
+	stop_if_error "Initial validation failed on IPv4."
+
+	do_ping "$ns1" "dead:beef:$netid::2"
+	do_ping "$ns1" "dead:beef:$netid::3"
+	do_ping "$ns2" "dead:beef:$netid::1"
+	do_ping "$ns2" "dead:beef:$netid::2"
+	do_ping "$ns3" "dead:beef:$netid::1"
+	do_ping "$ns3" "dead:beef:$netid::2"
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
+	do_ping_long "$ns1" "100.64.$netid.2"
+	do_ping_long "$ns1" "dead:beef:$netid::2"
+	do_ping_long "$ns1" "100.64.$netid.3"
+	do_ping_long "$ns1" "dead:beef:$netid::3"
+	stop_if_error "Longer ping test failed (ns1)."
+
+	do_ping_long "$ns2" "100.64.$netid.1"
+	do_ping_long "$ns2" "dead:beef:$netid::1"
+	do_ping_long "$ns2" "100.64.$netid.3"
+	do_ping_long "$ns2" "dead:beef:$netid::3"
+	stop_if_error "Longer ping test failed (ns2)."
+
+	do_ping_long "$ns3" "100.64.$netid.1"
+	do_ping_long "$ns3" "dead:beef:$netid::1"
+	do_ping_long "$ns3" "100.64.$netid.2"
+	do_ping_long "$ns3" "dead:beef:$netid::2"
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
@@ -140,17 +143,20 @@ setup_hsr_interfaces()
 	ip link add ns3eth2 netns "$ns3" type veth peer name ns2eth2 netns "$ns2"
 
 	# HSRv0/1
-	ip -net "$ns1" link add name hsr1 type hsr slave1 ns1eth1 slave2 ns1eth2 supervision 45 version $HSRv proto 0
-	ip -net "$ns2" link add name hsr2 type hsr slave1 ns2eth1 slave2 ns2eth2 supervision 45 version $HSRv proto 0
-	ip -net "$ns3" link add name hsr3 type hsr slave1 ns3eth1 slave2 ns3eth2 supervision 45 version $HSRv proto 0
+	ip -net "$ns1" link add name hsr1 type hsr slave1 ns1eth1 \
+		slave2 ns1eth2 supervision 45 version "$HSRv" proto 0
+	ip -net "$ns2" link add name hsr2 type hsr slave1 ns2eth1 \
+		slave2 ns2eth2 supervision 45 version "$HSRv" proto 0
+	ip -net "$ns3" link add name hsr3 type hsr slave1 ns3eth1 \
+		slave2 ns3eth2 supervision 45 version "$HSRv" proto 0
 
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
@@ -177,85 +183,33 @@ setup_hsr_interfaces()
 
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
@@ -263,27 +217,23 @@ run_vlan_tests() {
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


