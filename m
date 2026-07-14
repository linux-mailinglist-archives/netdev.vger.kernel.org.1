Return-Path: <netdev+bounces-307426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V0btAiwVVmqvywAAu9opvQ
	(envelope-from <netdev+bounces-307426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 12:53:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0495A7539AC
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 12:53:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=G6YrpQgt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307426-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307426-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BCF23007B3B
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27965363C6F;
	Tue, 14 Jul 2026 10:53:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AEC362157
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 10:53:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026406; cv=none; b=A6KFHWD0l72rHOGNYQ3/i9LljgDtPcogC0PZi5uoAjGiTrGBuCNBvyn4OXOK7u04ol2Fj2XbgxwNSXoph8BbLjB+JEgT+lR8B8b1g6+APqhI1yerK0atx/xOcTcXJje630q24RKV5j1TXLRMfIqSKmTIM1x/MHc07jqelu0u7k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026406; c=relaxed/simple;
	bh=DLqVIk9s144LghbDuxoah/zkcKBIHMr50hjmoMidewU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2oHlpYfCa0Ui2uzkWvLSnen+m49uWw2Iv4rZEdyOmXdD0sQmKdnZ0eJWzrOWJfuVluLh3TXpLbv7HRiLazMQ1q0OxUPVv1vqW9Ett6LKVpC+fqIFTzOnZokw719BeRcZuOJdfNmk6R2iFlGtNv7MTIvlPiq8QWFIUFJddF2MOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G6YrpQgt; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784026403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMmstJUw+AZa+5lGHQLVu4oyX8qYYSnlQA02WQKz+4Q=;
	b=G6YrpQgtAYyX9XnSrMWrPTa+vr67RrZjVaUj7EbIFtp2tYIaaptWIjFndKzJ35QW8DifUw
	438Ngh+w4u6AWiArg2Rk9JBsZS2hI9j3DBX9u3XOvTBHhCaBFOOrIdrVt/eSnUaV+eUlrn
	P2BviBgYuV+94Sx3fDAkUb42LDzxVBI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-jr9DSzHrP7yQf78Y7aShLg-1; Tue,
 14 Jul 2026 06:53:20 -0400
X-MC-Unique: jr9DSzHrP7yQf78Y7aShLg-1
X-Mimecast-MFC-AGG-ID: jr9DSzHrP7yQf78Y7aShLg_1784026398
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 055C91800350;
	Tue, 14 Jul 2026 10:53:17 +0000 (UTC)
Received: from thinkpad.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E10A1956087;
	Tue, 14 Jul 2026 10:53:12 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: bigeasy@linutronix.de,
	fmancera@suse.de,
	liuhangbin@gmail.com,
	luka.gejak@linux.dev,
	xiaoliang.yang_1@nxp.com,
	kexinsun@smail.nju.edu.cn,
	ssrane_b23@ee.vjti.ac.in,
	michael.bommarito@gmail.com,
	2022090917019@std.uestc.edu.cn,
	yury.norov@gmail.com,
	jvaclav@redhat.com,
	maoyixie.tju@gmail.com
Subject: [RFC net-next 1/2] hsr: Set equal MAC addresses on port A and B for HSR
Date: Tue, 14 Jul 2026 12:52:42 +0200
Message-ID: <5d94e30c8b3516ec41bec0425bbba427631254bf.1784024900.git.fmaurer@redhat.com>
In-Reply-To: <cover.1784024900.git.fmaurer@redhat.com>
References: <cover.1784024900.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linutronix.de,suse.de,gmail.com,linux.dev,nxp.com,smail.nju.edu.cn,ee.vjti.ac.in,std.uestc.edu.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-307426-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bigeasy@linutronix.de,m:fmancera@suse.de,m:liuhangbin@gmail.com,m:luka.gejak@linux.dev,m:xiaoliang.yang_1@nxp.com,m:kexinsun@smail.nju.edu.cn,m:ssrane_b23@ee.vjti.ac.in,m:michael.bommarito@gmail.com,m:2022090917019@std.uestc.edu.cn,m:yury.norov@gmail.com,m:jvaclav@redhat.com,m:maoyixie.tju@gmail.com,m:michaelbommarito@gmail.com,m:yurynorov@gmail.com,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0495A7539AC

All hsr interfaces are created with their MAC address set to the MAC
address of port A. Since commit b65999e7238e ("net: hsr: sync hw addr of
slave2 according to slave1 hw addr on PRP"), we are copying the MAC address
of port A to port B as well for PRP interfaces because for correct
operation, a node in a PRP network must use the same MAC address on both
ports. IOW, the frames sent over port A and port B must only differ in the
LAN ID in their PRP redundancy control trailer, i.e., must not differ in
their source MAC address.

The same applies to HSR: for correct operation of the ring, the frames sent
from port A and port B must not differ in their source MAC address.
Therefore, extend the address copying behavior from PRP to HSR interfaces.

In the selftests, we now set only the addresses of port A which is how HSR
is intended to be used. The address is copied over to port B anyways. With
only a single address per node, there is also no reason anymore to wait for
nodes in the table to get merged. While touching the MAC addresses in the
hsr_redbox test, I noticed that the bridge in ns3 and its ports have the
same addresses; fixing that as well.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 net/hsr/hsr_device.c                          |  6 ++--
 net/hsr/hsr_main.c                            | 12 +++----
 tools/testing/selftests/net/hsr/hsr_ping.sh   | 33 +++----------------
 tools/testing/selftests/net/hsr/hsr_redbox.sh | 13 +++-----
 .../testing/selftests/net/hsr/link_faults.sh  | 26 ---------------
 5 files changed, 16 insertions(+), 74 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5555b71ab19b..a52079eb2adb 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -795,10 +795,8 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	if (res)
 		goto err_unregister;
 
-	if (protocol_version == PRP_V1) {
-		eth_hw_addr_set(slave[1], slave[0]->dev_addr);
-		call_netdevice_notifiers(NETDEV_CHANGEADDR, slave[1]);
-	}
+	eth_hw_addr_set(slave[1], slave[0]->dev_addr);
+	call_netdevice_notifiers(NETDEV_CHANGEADDR, slave[1]);
 
 	if (interlink) {
 		res = hsr_add_port(hsr, interlink, HSR_PT_INTERLINK, extack);
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index 33951d9bd3c5..202cf2a3625f 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -79,13 +79,11 @@ static int hsr_netdev_notify(struct notifier_block *nb, unsigned long event,
 			call_netdevice_notifiers(NETDEV_CHANGEADDR,
 						 master->dev);
 
-			if (hsr->prot_version == PRP_V1) {
-				port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
-				if (port) {
-					eth_hw_addr_set(port->dev, dev->dev_addr);
-					call_netdevice_notifiers(NETDEV_CHANGEADDR,
-								 port->dev);
-				}
+			port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
+			if (port) {
+				eth_hw_addr_set(port->dev, dev->dev_addr);
+				call_netdevice_notifiers(NETDEV_CHANGEADDR,
+							 port->dev);
 			}
 		}
 
diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh b/tools/testing/selftests/net/hsr/hsr_ping.sh
index f4d685df4345..454c6fdfd834 100755
--- a/tools/testing/selftests/net/hsr/hsr_ping.sh
+++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
@@ -51,25 +51,6 @@ do_ping_tests()
 	do_ping "$ns3" "dead:beef:$netid::2"
 	stop_if_error "Initial validation failed on IPv6."
 
-# Wait until supervisor all supervision frames have been processed and the node
-# entries have been merged. Otherwise duplicate frames will be observed which is
-# valid at this stage.
-	echo "INFO: Wait for node table entries to be merged."
-	WAIT=5
-	while [ ${WAIT} -gt 0 ]
-	do
-		grep 00:00:00:00:00:00 /sys/kernel/debug/hsr/hsr*/node_table
-		if [ $? -ne 0 ]
-		then
-			break
-		fi
-		sleep 1
-		let "WAIT = WAIT - 1"
-	done
-
-# Just a safety delay in case the above check didn't handle it.
-	sleep 1
-
 	echo "INFO: Longer ping test."
 	do_ping_long "$ns1" "100.64.$netid.2"
 	do_ping_long "$ns1" "dead:beef:$netid::2"
@@ -110,6 +91,11 @@ setup_hsr_interfaces()
 	ip link add ns1eth2 netns "$ns1" type veth peer name ns3eth1 netns "$ns3"
 	ip link add ns3eth2 netns "$ns3" type veth peer name ns2eth2 netns "$ns2"
 
+	# MAC addresses will be copied from LAN A interfaces
+	ip -net "$ns1" link set address 00:11:22:00:01:01 dev ns1eth1
+	ip -net "$ns2" link set address 00:11:22:00:02:01 dev ns2eth1
+	ip -net "$ns3" link set address 00:11:22:00:03:01 dev ns3eth1
+
 	# HSRv0/1
 	ip -net "$ns1" link add name hsr1 type hsr slave1 ns1eth1 \
 		slave2 ns1eth2 supervision 45 version "$HSRv" proto 0
@@ -126,15 +112,6 @@ setup_hsr_interfaces()
 	ip -net "$ns3" addr add 100.64.0.3/24 dev hsr3
 	ip -net "$ns3" addr add dead:beef:0::3/64 dev hsr3 nodad
 
-	ip -net "$ns1" link set address 00:11:22:00:01:01 dev ns1eth1
-	ip -net "$ns1" link set address 00:11:22:00:01:02 dev ns1eth2
-
-	ip -net "$ns2" link set address 00:11:22:00:02:01 dev ns2eth1
-	ip -net "$ns2" link set address 00:11:22:00:02:02 dev ns2eth2
-
-	ip -net "$ns3" link set address 00:11:22:00:03:01 dev ns3eth1
-	ip -net "$ns3" link set address 00:11:22:00:03:02 dev ns3eth2
-
 	# All Links up
 	ip -net "$ns1" link set ns1eth1 up
 	ip -net "$ns1" link set ns1eth2 up
diff --git a/tools/testing/selftests/net/hsr/hsr_redbox.sh b/tools/testing/selftests/net/hsr/hsr_redbox.sh
index 998103502d5d..f945d7d82fa1 100755
--- a/tools/testing/selftests/net/hsr/hsr_redbox.sh
+++ b/tools/testing/selftests/net/hsr/hsr_redbox.sh
@@ -23,10 +23,6 @@ do_complete_ping_test()
 	do_ping "${ns5}" 100.64.0.1
 	stop_if_error "Initial validation failed."
 
-	# Wait for MGNT HSR frames being received and nodes being
-	# merged.
-	sleep 5
-
 	echo "INFO: Longer ping test (HSR-SAN/RedBox)."
 	# Ping from SAN to hsr1 (via hsr2)
 	do_ping_long "${ns3}" 100.64.0.1
@@ -96,16 +92,15 @@ setup_hsr_interfaces()
 	ip -n "${ns4}" link set ns4eth1 up
 	ip -n "${ns5}" link set ns5eth1 up
 
+	# Setting MAC addresses to help with debugging
 	ip -net "$ns1" link set address 00:11:22:00:01:01 dev ns1eth1
-	ip -net "$ns1" link set address 00:11:22:00:01:02 dev ns1eth2
 
 	ip -net "$ns2" link set address 00:11:22:00:02:01 dev ns2eth1
-	ip -net "$ns2" link set address 00:11:22:00:02:02 dev ns2eth2
 	ip -net "$ns2" link set address 00:11:22:00:02:03 dev ns2eth3
 
-	ip -net "$ns3" link set address 00:11:22:00:03:11 dev ns3eth1
-	ip -net "$ns3" link set address 00:11:22:00:03:11 dev ns3eth2
-	ip -net "$ns3" link set address 00:11:22:00:03:11 dev ns3eth3
+	ip -net "$ns3" link set address 00:11:22:00:03:01 dev ns3eth1
+	ip -net "$ns3" link set address 00:11:22:00:03:02 dev ns3eth2
+	ip -net "$ns3" link set address 00:11:22:00:03:03 dev ns3eth3
 	ip -net "$ns3" link set address 00:11:22:00:03:11 dev ns3br1
 
 	ip -net "$ns4" link set address 00:11:22:00:04:01 dev ns4eth1
diff --git a/tools/testing/selftests/net/hsr/link_faults.sh b/tools/testing/selftests/net/hsr/link_faults.sh
index be526281571c..c002390acc07 100755
--- a/tools/testing/selftests/net/hsr/link_faults.sh
+++ b/tools/testing/selftests/net/hsr/link_faults.sh
@@ -59,13 +59,8 @@ setup_hsr_topo()
 
 	# MAC addresses (not needed for HSR operation, but helps with debugging)
 	ip -net "$node1" link set address 00:11:22:00:01:01 dev vethA
-	ip -net "$node1" link set address 00:11:22:00:01:02 dev vethB
-
 	ip -net "$node2" link set address 00:11:22:00:02:01 dev vethA
-	ip -net "$node2" link set address 00:11:22:00:02:02 dev vethB
-
 	ip -net "$node3" link set address 00:11:22:00:03:01 dev vethA
-	ip -net "$node3" link set address 00:11:22:00:03:02 dev vethB
 
 	# HSR interfaces
 	ip -net "$node1" link add name hsr1 type hsr proto 0 version "$ver" \
@@ -134,35 +129,14 @@ setup_prp_topo()
 	ip -net "$node2" link set prp2 up
 }
 
-wait_for_hsr_node_table()
-{
-	log_info "Wait for node table entries to be merged."
-	WAIT=5
-	while [ "${WAIT}" -gt 0 ]; do
-		nts=$(cat /sys/kernel/debug/hsr/hsr*/node_table)
-
-		# We need entries in the node tables, and they need to be merged
-		if (echo "$nts" | grep -qE "^([0-9a-f]{2}:){5}") && \
-		    ! (echo "$nts" | grep -q "00:00:00:00:00:00"); then
-			return
-		fi
-
-		sleep 1
-		((WAIT--))
-	done
-	check_err 1 "Failed to wait for merged node table entries"
-}
-
 setup_topo()
 {
 	local proto="$1"
 
 	if [ "$proto" = "HSRv0" ]; then
 		setup_hsr_topo 0
-		wait_for_hsr_node_table
 	elif [ "$proto" = "HSRv1" ]; then
 		setup_hsr_topo 1
-		wait_for_hsr_node_table
 	elif [ "$proto" = "PRP" ]; then
 		setup_prp_topo
 	else
-- 
2.55.0


