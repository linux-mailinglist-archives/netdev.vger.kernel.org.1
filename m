Return-Path: <netdev+bounces-251888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOh3ET3acGnCaQAAu9opvQ
	(envelope-from <netdev+bounces-251888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:53:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E26DE57F2E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25B0F700B30
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65052355049;
	Wed, 21 Jan 2026 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWeJ4ZNO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D67410D39
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002500; cv=none; b=FZ/kgLf1b/e7Xqio80Y9ZI6bPFc4PAr8cTqT9eePVfCo72yFaCZX2Z+tkicGQgggjl59gqs49pHcL52nvy48raCMTzZDuTUIVHo59C85oEe3N89VsaXRt5IB4+XwMzgIs4C4w0+CVQu+hUyYyMsKItfoGxpy9g+9rIA2sFpTQs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002500; c=relaxed/simple;
	bh=fCrg/ZRJ8hmiozup4J1AYVqgB98IlDPIXl++9eMruFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4/xfdndBii84k+HqKlJosh28Hmjm6o2mOfI8b4NhACkuvnewhVtSV09JF4M9/qQi4dhQCpFN7cwYXsqFGmL9iLfRqouvVQObi0eqpSKrU2O7AnY8BDY1GssX85t+mCKqSkqcBZUS2YZ44wLXRmr5G8A2nXTkSNxOqNOKVp45cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWeJ4ZNO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769002497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiU0dFYh+XpgJWD0fxT9udmXLukEC1cYnJOUWd1GfQU=;
	b=HWeJ4ZNO2FjCQ54RnA1F0foR71yYg5XBlSQeFOS8ch+/cG3HiTY5XgRapxOB6qDSPA7yhd
	Fz/n2Wpl6z8Y5U6L+Fb/to+jc02FJqrLZfr9GUnLWW3tSpIONcq8iDPI4THwLFIv8LfYz1
	AdeqntEOb6g5IFggmwq3m4Dbuz3PvA8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-8aWJ_DORNvqBwhOAes4jEQ-1; Wed,
 21 Jan 2026 08:34:53 -0500
X-MC-Unique: 8aWJ_DORNvqBwhOAes4jEQ-1
X-Mimecast-MFC-AGG-ID: 8aWJ_DORNvqBwhOAes4jEQ_1769002491
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7B5019560B2;
	Wed, 21 Jan 2026 13:34:51 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.33.242])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E44619560AB;
	Wed, 21 Jan 2026 13:34:47 +0000 (UTC)
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
Subject: [PATCH net-next 1/9] selftests: hsr: Add ping test for PRP
Date: Wed, 21 Jan 2026 14:33:00 +0100
Message-ID: <5062f256874904dab6e07cd0b15ea7b518d90b28.1769001553.git.fmaurer@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-251888-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E26DE57F2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a selftest for PRP that performs a basic ping test on IPv4 and IPv6,
over the plain PRP interface and a VLAN interface, similar to the existing
ping test for HSR. The test first checks reachability of the other node,
then checks for no loss and no duplicates.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 tools/testing/selftests/net/hsr/Makefile    |   1 +
 tools/testing/selftests/net/hsr/prp_ping.sh | 146 ++++++++++++++++++++
 2 files changed, 147 insertions(+)
 create mode 100755 tools/testing/selftests/net/hsr/prp_ping.sh

diff --git a/tools/testing/selftests/net/hsr/Makefile b/tools/testing/selftests/net/hsr/Makefile
index 4b6afc0fe9f8..1886f345897a 100644
--- a/tools/testing/selftests/net/hsr/Makefile
+++ b/tools/testing/selftests/net/hsr/Makefile
@@ -5,6 +5,7 @@ top_srcdir = ../../../../..
 TEST_PROGS := \
 	hsr_ping.sh \
 	hsr_redbox.sh \
+	prp_ping.sh \
 # end of TEST_PROGS
 
 TEST_FILES += hsr_common.sh
diff --git a/tools/testing/selftests/net/hsr/prp_ping.sh b/tools/testing/selftests/net/hsr/prp_ping.sh
new file mode 100755
index 000000000000..503e39502801
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/prp_ping.sh
@@ -0,0 +1,146 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ipv6=true
+
+source ./hsr_common.sh
+
+optstring="h4"
+usage() {
+	echo "Usage: $0 [OPTION]"
+	echo -e "\t-4: IPv4 only: disable IPv6 tests (default: test both IPv4 and IPv6)"
+}
+
+while getopts "$optstring" option;do
+	case "$option" in
+	"h")
+		usage "$0"
+		exit 0
+		;;
+	"4")
+		ipv6=false
+		;;
+	"?")
+		usage "$0"
+		exit 1
+		;;
+esac
+done
+
+setup_prp_interfaces()
+{
+	echo "INFO: Preparing interfaces for PRP"
+# Two PRP nodes, connected by two links (treated as LAN A and LAN B).
+#
+#       vethA ----- vethA
+#     prp1             prp2
+#       vethB ----- vethB
+#
+#     node1           node2
+
+	# Interfaces
+	ip link add vethA netns "$node1" type veth peer name vethA netns "$node2"
+	ip link add vethB netns "$node1" type veth peer name vethB netns "$node2"
+
+	# MAC addresses will be copied from LAN A interface
+	ip -net "$node1" link set address 00:11:22:00:00:01 dev vethA
+	ip -net "$node2" link set address 00:11:22:00:00:02 dev vethA
+
+	# PRP
+	ip -net "$node1" link add name prp1 type hsr \
+		slave1 vethA slave2 vethB supervision 45 proto 1
+	ip -net "$node2" link add name prp2 type hsr \
+		slave1 vethA slave2 vethB supervision 45 proto 1
+
+	# IP addresses
+	ip -net "$node1" addr add 100.64.0.1/24 dev prp1
+	ip -net "$node1" addr add dead:beef:0::1/64 dev prp1 nodad
+	ip -net "$node2" addr add 100.64.0.2/24 dev prp2
+	ip -net "$node2" addr add dead:beef:0::2/64 dev prp2 nodad
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
+setup_vlan_interfaces()
+{
+	# Interfaces
+	ip -net "$node1" link add link prp1 name prp1.2 type vlan id 2
+	ip -net "$node2" link add link prp2 name prp2.2 type vlan id 2
+
+	# IP addresses
+	ip -net "$node1" addr add 100.64.2.1/24 dev prp1.2
+	ip -net "$node1" addr add dead:beef:2::1/64 dev prp1.2 nodad
+
+	ip -net "$node2" addr add 100.64.2.2/24 dev prp2.2
+	ip -net "$node2" addr add dead:beef:2::2/64 dev prp2.2 nodad
+
+	# All links up
+	ip -net "$node1" link set prp1.2 up
+	ip -net "$node2" link set prp2.2 up
+}
+
+do_ping_tests()
+{
+	local netid="$1"
+
+	echo "INFO: Initial validation ping"
+
+	do_ping "$node1" "100.64.$netid.2"
+	do_ping "$node2" "100.64.$netid.1"
+	stop_if_error "Initial validation failed on IPv4"
+
+	do_ping "$node1" "dead:beef:$netid::2"
+	do_ping "$node2" "dead:beef:$netid::1"
+	stop_if_error "Initial validation failed on IPv6"
+
+	echo "INFO: Longer ping test."
+
+	do_ping_long "$node1" "100.64.$netid.2"
+	do_ping_long "$node2" "100.64.$netid.1"
+	stop_if_error "Longer ping test failed on IPv4."
+
+	do_ping_long "$node1" "dead:beef:$netid::2"
+	do_ping_long "$node2" "dead:beef:$netid::1"
+	stop_if_error "Longer ping test failed on IPv6."
+}
+
+run_ping_tests()
+{
+	echo "INFO: Running ping tests"
+	do_ping_tests 0
+}
+
+run_vlan_ping_tests()
+{
+	vlan_challenged_prp1=$(ip net exec "$node1" ethtool -k prp1 | \
+		grep "vlan-challenged" | awk '{print $2}')
+	vlan_challenged_prp2=$(ip net exec "$node2" ethtool -k prp2 | \
+		grep "vlan-challenged" | awk '{print $2}')
+
+	if [[ "$vlan_challenged_prp1" = "off" || \
+	      "$vlan_challenged_prp2" = "off" ]]; then
+		echo "INFO: Running VLAN ping tests"
+		setup_vlan_interfaces
+		do_ping_tests 2
+	else
+		echo "INFO: Not Running VLAN tests as the device does not support VLAN"
+	fi
+}
+
+check_prerequisites
+trap cleanup_all_ns EXIT
+
+setup_ns node1 node2
+setup_prp_interfaces
+
+run_ping_tests
+run_vlan_ping_tests
+
+exit $ret
-- 
2.52.0


