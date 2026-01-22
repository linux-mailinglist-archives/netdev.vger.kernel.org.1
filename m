Return-Path: <netdev+bounces-252394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA/KEp1FcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:43:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE6269196
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E550C9A7BA1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF6D3559ED;
	Thu, 22 Jan 2026 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkVAvnM4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEE030F53F
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093873; cv=none; b=uRoBfWxCYgB0zhIjwxUEYn4Mlrwts2gEzTofLBnEdhSbRZZE24KgwWtLC/gFcIpoM4TF+M4ztZb5FIX15yh0nSks23IDVpNNIgp4vcA9Sz+VlEUldNQc01fmDftX2Zvq2LzYQAJNEsUuxP3nW2CZx0Hxxk8b/kzkmG8y2HwrgqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093873; c=relaxed/simple;
	bh=Zp0xDIry+xWOagLYzhJnxjNnnYBXUDNXYkQ6YaC2lAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTyqJNOOBD7c8sh5A0l3ccT54z7VJUpppRmc2ZUiO4xx2b4G0aBy3iP5YoXuUbgaOV4+T/qG7ckj6Dsoau6qGnwIMgUlb4CeRzDZcNBBDJd4TeQ+67UhQxEUd+cxEBoBjJ6kraqwP9mHrJjBGr3fYLhpkuXsrtEFJpCsiLz1nbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XkVAvnM4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769093870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyWvUwtxpVaKU71jmDP1MK8awYA43ge3b0VGXSY2SYI=;
	b=XkVAvnM4wCDEFR+rESR3Qa7OWnot5/tD/0aGUI4fYxQWxergJRjLP7KR73LnA41L/n/Nuj
	5AnftWBGh/+k3ey4Xd8uQL42Ds3COMn3X40FmwDZdNmRq/zpJfHxmEBSKeCT9825iNCfWv
	3fF3ObY2z2CELBcppsknxdU3sLfCIk0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-nNJR3YaNNyWkU7NavDJU7g-1; Thu,
 22 Jan 2026 09:57:47 -0500
X-MC-Unique: nNJR3YaNNyWkU7NavDJU7g-1
X-Mimecast-MFC-AGG-ID: nNJR3YaNNyWkU7NavDJU7g_1769093863
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE7381944B10;
	Thu, 22 Jan 2026 14:57:43 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.45.225.113])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 582AA1800665;
	Thu, 22 Jan 2026 14:57:39 +0000 (UTC)
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
Subject: [PATCH net-next v2 5/9] selftests: hsr: Add tests for more link faults with PRP
Date: Thu, 22 Jan 2026 15:57:00 +0100
Message-ID: <774d7a2327d1c05b78ee30ac21297794bfcb0245.1769093335.git.fmaurer@redhat.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252394-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	URIBL_MULTI_FAIL(0.00)[dfw.mirrors.kernel.org:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: DAE6269196
X-Rspamd-Action: no action

Add tests where one link has different rates of packet loss or reorders
packets. PRP should still be able to recover from these link faults and
show no packet loss.  However, it is acceptable to receive some level of
duplicate packets. This matches the current specification (IEC
62439-3:2021) of the duplicate discard algorithm that requires it to be
"designed such that it never rejects a legitimate frame, while occasional
acceptance of a duplicate can be tolerated." The rate of acceptable
duplicates in this test is intentionally high (10%) to make the test
stable, the values I observed in the worst test cases (20% loss) are around
5% duplicates.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 .../testing/selftests/net/hsr/link_faults.sh  | 79 +++++++++++++++++--
 1 file changed, 74 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/hsr/link_faults.sh b/tools/testing/selftests/net/hsr/link_faults.sh
index 7ff14dcd32e7..1959bea17147 100755
--- a/tools/testing/selftests/net/hsr/link_faults.sh
+++ b/tools/testing/selftests/net/hsr/link_faults.sh
@@ -11,10 +11,16 @@ ALL_TESTS="
 	test_cut_link_hsrv1
 	test_clean_prp
 	test_cut_link_prp
+	test_packet_loss_prp
+	test_high_packet_loss_prp
+	test_reordering_prp
 "
 
-# The tests are running ping for 5sec with a relatively short interval with a
-# cut link, which should be recoverable by HSR/PRP.
+# The tests are running ping for 5sec with a relatively short interval in
+# different scenarios with faulty links (cut links, packet loss, delay,
+# reordering) that should be recoverable by HSR/PRP. The ping interval (10ms)
+# is short enough that the base delay (50ms) leads to a queue in the netem
+# qdiscs which is needed for reordering.
 
 setup_hsr_topo()
 {
@@ -160,6 +166,7 @@ check_ping()
 {
 	local node="$1"
 	local dst="$2"
+	local accepted_dups="$3"
 	local ping_args="-q -i 0.01 -c 400"
 
 	log_info "Running ping $node -> $dst"
@@ -178,7 +185,9 @@ check_ping()
 		loss="${BASH_REMATCH[1]}"
 	fi
 
-	check_err "$dups" "Unexpected duplicate packets (${dups})"
+	if [ "$dups" -gt "$accepted_dups" ]; then
+		check_err 1 "Unexpected duplicate packets (${dups})"
+	fi
 	if [ "$loss" != "0%" ]; then
 		check_err 1 "Unexpected packet loss (${loss})"
 	fi
@@ -197,7 +206,7 @@ test_clean()
 		return
 	fi
 
-	check_ping "$node1" "100.64.0.2"
+	check_ping "$node1" "100.64.0.2" 0
 
 	log_test "${tname}"
 }
@@ -237,7 +246,7 @@ test_cut_link()
 		log_info "Cutting link"
 		ip -net "$node1" link set vethB down
 	) &
-	check_ping "$node1" "100.64.0.2"
+	check_ping "$node1" "100.64.0.2" 0
 
 	wait
 	log_test "${tname}"
@@ -259,6 +268,66 @@ test_cut_link_prp()
 	test_cut_link "PRP"
 }
 
+test_packet_loss()
+{
+	local proto="$1"
+	local loss="$2"
+
+	RET=0
+	tname="${FUNCNAME[0]} - ${proto}, ${loss}"
+
+	setup_topo "$proto"
+	if ((RET != ksft_pass)); then
+		log_test "${tname} setup"
+		return
+	fi
+
+	# Packet loss with lower delay makes sure the packets on the lossy link
+	# arrive first.
+	tc -net "$node1" qdisc add dev vethA root netem delay 50ms
+	tc -net "$node1" qdisc add dev vethB root netem delay 20ms loss "$loss"
+
+	check_ping "$node1" "100.64.0.2" 40
+
+	log_test "${tname}"
+}
+
+test_packet_loss_prp()
+{
+	test_packet_loss "PRP" "20%"
+}
+
+test_high_packet_loss_prp()
+{
+	test_packet_loss "PRP" "80%"
+}
+
+test_reordering()
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
+	tc -net "$node1" qdisc add dev vethA root netem delay 50ms
+	tc -net "$node1" qdisc add dev vethB root netem delay 50ms reorder 20%
+
+	check_ping "$node1" "100.64.0.2" 40
+
+	log_test "${tname}"
+}
+
+test_reordering_prp()
+{
+	test_reordering "PRP"
+}
+
 cleanup()
 {
 	cleanup_all_ns
-- 
2.52.0


