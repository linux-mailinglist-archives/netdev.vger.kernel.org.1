Return-Path: <netdev+bounces-245761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC6DCD72A9
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 21:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECEC130321CE
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 20:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E3F33EAFC;
	Mon, 22 Dec 2025 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="daqOrlwi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CBB334698
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766437131; cv=none; b=lStn7AEQSpWKKaNrAjUZIdjXps2jdxw9oZ9+2MUklXvMUzjgLcdw3qFuuw6KlxFuFvOze6Cr+VtWI6odgZmY50K9LQM4JSduXc5WxWU/e2mrG1aP8/NLwJ1rg/qj2jNAl7kV59q1XvljTV7EieP4Od0CQsTx8cI55tzxuxOvzco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766437131; c=relaxed/simple;
	bh=fgdJ+DMxtK8V1KOVk6G9XPVXkSlzS/0WR/A+3vzvH4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocrhUcSbIAf3HCvBvbsX6i2T3Sh1AMwwgwZJGZ0EDXaHEqwuAS4w9dimHIE/epPcnv9F5F3LVOwh5oAE2WhZCpGoJafAnS9qXBfMmaSpo7Lhk/Xmp/v4R69/yTyhCz9zH95+++w6rGdvxymLQ9+hnGOB0m5FWDaQElXXQrsJgIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=daqOrlwi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766437126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tfe6Fz5dfkImCwFUNtmUKli461yZ3uUNNO7oRYkFDY=;
	b=daqOrlwiRIarAA1fg3HNh5DmiadqGqGnyKSkvSIVGPDQ+so3pRtXFwi2/HJaO5kmKHfrtO
	g1XMMXkDnvqLaNZ4+1WjhUyQtaL7MS8eRnZzE6txe2Z+bziUri4Ye26xLpkOUqQZ42M9ta
	WXIdFH8ESYaL0DifENajeUUUb2q8Qos=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-hq65SWbHO7KAgmvsAxpd8g-1; Mon,
 22 Dec 2025 15:58:43 -0500
X-MC-Unique: hq65SWbHO7KAgmvsAxpd8g-1
X-Mimecast-MFC-AGG-ID: hq65SWbHO7KAgmvsAxpd8g_1766437121
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37D521956061;
	Mon, 22 Dec 2025 20:58:41 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.32.178])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67D95180045B;
	Mon, 22 Dec 2025 20:58:37 +0000 (UTC)
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
Subject: [RFC net 1/6] selftests: hsr: Add ping test for PRP
Date: Mon, 22 Dec 2025 21:57:31 +0100
Message-ID: <c8fe5ce0559a9597e27a49eeb9b9c5a67ee50a0c.1766433800.git.fmaurer@redhat.com>
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

Add a selftest for PRP that performs a basic ping test on IPv4 and IPv6,
over the plain PRP interface and a VLAN interface, similar to the existing
ping test for HSR. The test first checks reachability of of the other node,
then checks for no loss and no duplicates.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 tools/testing/selftests/net/hsr/Makefile    |   1 +
 tools/testing/selftests/net/hsr/prp_ping.sh | 141 ++++++++++++++++++++
 2 files changed, 142 insertions(+)
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
index 000000000000..e326376b017b
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/prp_ping.sh
@@ -0,0 +1,141 @@
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
+		usage $0
+		exit 0
+		;;
+	"4")
+		ipv6=false
+		;;
+	"?")
+		usage $0
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
+	ip -net "$node1" link add name prp1 type hsr slave1 vethA slave2 vethB supervision 45 proto 1
+	ip -net "$node2" link add name prp2 type hsr slave1 vethA slave2 vethB supervision 45 proto 1
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
+	do_ping "$node1" 100.64.$netid.2
+	do_ping "$node2" 100.64.$netid.1
+	stop_if_error "Initial validation failed on IPv4"
+
+	do_ping "$node1" dead:beef:$netid::2
+	do_ping "$node2" dead:beef:$netid::1
+	stop_if_error "Initial validation failed on IPv6"
+
+	echo "INFO: Longer ping test."
+
+	do_ping_long "$node1" 100.64.$netid.2
+	do_ping_long "$node2" 100.64.$netid.1
+	stop_if_error "Longer ping test failed on IPv4."
+
+	do_ping_long "$node1" dead:beef:$netid::2
+	do_ping_long "$node2" dead:beef:$netid::1
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
+	vlan_challenged_prp1=$(ip net exec "$node1" ethtool -k prp1 | grep "vlan-challenged" | awk '{print $2}')
+	vlan_challenged_prp2=$(ip net exec "$node2" ethtool -k prp2 | grep "vlan-challenged" | awk '{print $2}')
+
+	if [[ "$vlan_challenged_prp1" = "off" || "$vlan_challenged_prp2" = "off" ]]; then
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


