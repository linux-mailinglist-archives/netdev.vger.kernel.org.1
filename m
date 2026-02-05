Return-Path: <netdev+bounces-257191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKO6AnqjhGmo4AMAu9opvQ
	(envelope-from <netdev+bounces-257191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:04:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD27F3BDC
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 319E6306B7AF
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56FB3E958E;
	Thu,  5 Feb 2026 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPxNqghn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518C33A6EC
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299884; cv=none; b=umAXx5RJEgDBjkOhRb1gagRD4dJJiCivDYu5/wHQHfE3aD73XJ802v6p14763RAZP3PUlUNzcVt4Omc/IMAW1NTfARBpVtbsG5Tln4BvOoLZqJ/G8dUIY0yrWIUjxAtnnGQil1m8WpBBUMXVQJdZ7stTjwrJpd1gT8GSzrUXy80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299884; c=relaxed/simple;
	bh=y1ZPezFGHw3pf3+dxSwyxJquZitNndnFZmoCPF/1cBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHSLl+wRqb3z4mxWpYJgwTGEB5Y0PAkxh/85Z5Jy3C9eva0oTNod7a4kBKAt3+9lMsgkVwb2qd0VieBD8xFiWFc/C1RqiQQG5/jSeIxXdGS6pV7Rl008wNIUIdWqRYF4m8i3IIp+U2O7XMTaM4E0umydeXJslynbyTFk7EMwnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FPxNqghn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770299883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84MFgO3T/Lw30MsaN1WLdqXe3C1mMIB8pq/P4SjaMxw=;
	b=FPxNqghnymvZt9JnWLBV91Gi9nakT3Pr9c6i2Got707193DTZErfk8yf8m7lv6WsKRjoo1
	Qb1ePpjKn1XpKuEbkutoeGk1rB1isfRGLic9uSxzKwLfAcrUt9QScR5zQNNYaI51nLEGf2
	Wpt/pko4svDiHEQGxpZKsHrA1fGLjlc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-yGuKTolBM5i7fTS6qavx9Q-1; Thu,
 05 Feb 2026 08:57:59 -0500
X-MC-Unique: yGuKTolBM5i7fTS6qavx9Q-1
X-Mimecast-MFC-AGG-ID: yGuKTolBM5i7fTS6qavx9Q_1770299877
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B36A18004BB;
	Thu,  5 Feb 2026 13:57:57 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.32.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 39BF719560A7;
	Thu,  5 Feb 2026 13:57:53 +0000 (UTC)
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
Subject: [PATCH net-next v4 2/8] selftests: hsr: Check duplicates on HSR with VLAN
Date: Thu,  5 Feb 2026 14:57:29 +0100
Message-ID: <e3ded0e2547b5f720524b62fabeb96debc579697.1770299429.git.fmaurer@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	TAGGED_FROM(0.00)[bounces-257191-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FD27F3BDC
X-Rspamd-Action: no action

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
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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


