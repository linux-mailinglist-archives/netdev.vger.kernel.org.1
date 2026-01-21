Return-Path: <netdev+bounces-251895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKQyKpHbcGnCaQAAu9opvQ
	(envelope-from <netdev+bounces-251895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:58:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1570D58091
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 149BDA29793
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1343B8BAE;
	Wed, 21 Jan 2026 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G587cyEl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C02D5C74
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002684; cv=none; b=I63P946GWb0fqyTkjaOTKoKCUZKI/Hwcl9PeqCr1VUCidNXcBHT6m0QnWrUSsFOp/ShLptlCnmPcan23W6TMQ7h27gu6ySIvWCEXg29OkHTLblDPqVXqXFEhO9EA2IZqhnGfmixajC5Bywwc1z3x+G2RWG+9DAH4HK+BxWa4VcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002684; c=relaxed/simple;
	bh=MuJAPpb1Oc8ptj8mC7zpqpszMtgZIlmKtgIGAExPLYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPFac5uMQ40IZ2s4xl6eCtFqp85RXEFBHdCjo2/Jftb3pXCOXBtUM/51OxhvNW7nBHR43uZeo7wzgSV7TeX0yjnFm4u/11Mc0Tyzi+iwUMRx5yCVrLqsvUpW+fisgKI2F0lxTJdUsiKwtZZSqlb+Dpi3VdC+KsbwMsWNVu2qgU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G587cyEl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769002681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PA3aNbqlhEgRwfeto58/rliWwLesJhTUoebjyIk2+w8=;
	b=G587cyElTpMc520n8gQBuuUuBEXAgCwp2P/ABpXXyjKAJVaXsBUo4b3qxZIoibHQQThpGq
	ufDZBJInDq1793/OxnZYZ5uN3NXqqB1DkpU1kohXy0J46ELqFIwYMCTpq6S79Q7uBsVh8u
	1IlyAWUk9Fx3HOsd23hjhmFKzC5uXTU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-ZVEjbyYLMte6q2MN6ccx1Q-1; Wed,
 21 Jan 2026 08:37:55 -0500
X-MC-Unique: ZVEjbyYLMte6q2MN6ccx1Q-1
X-Mimecast-MFC-AGG-ID: ZVEjbyYLMte6q2MN6ccx1Q_1769002673
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A701E18005B4;
	Wed, 21 Jan 2026 13:37:53 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.33.242])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2AA3E30002D2;
	Wed, 21 Jan 2026 13:37:49 +0000 (UTC)
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
Subject: [PATCH net-next 5/9] selftests: hsr: Add tests for more link faults with PRP
Date: Wed, 21 Jan 2026 14:37:32 +0100
Message-ID: <8d66ee5f25f6638a27ca2ae1264a5c1c718df8b2.1769001553.git.fmaurer@redhat.com>
In-Reply-To: <cover.1769001553.git.fmaurer@redhat.com>
References: <cover.1769001553.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251895-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 1570D58091
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 1d48f1c2fd2e..0c03445a2bdd 100755
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
@@ -158,6 +164,7 @@ check_ping()
 {
 	local node="$1"
 	local dst="$2"
+	local accepted_dups="$3"
 	local ping_args="-q -i 0.01 -c 400"
 
 	log_info "Running ping $node -> $dst"
@@ -176,7 +183,9 @@ check_ping()
 		loss="${BASH_REMATCH[1]}"
 	fi
 
-	check_err "$dups" "Unexpected duplicate packets (${dups})"
+	if [ "$dups" -gt "$accepted_dups" ]; then
+		check_err 1 "Unexpected duplicate packets (${dups})"
+	fi
 	if [ "$loss" != "0%" ]; then
 		check_err 1 "Unexpected packet loss (${loss})"
 	fi
@@ -195,7 +204,7 @@ test_clean()
 		return
 	fi
 
-	check_ping "$node1" "100.64.0.2"
+	check_ping "$node1" "100.64.0.2" 0
 
 	log_test "${tname}"
 }
@@ -235,7 +244,7 @@ test_cut_link()
 		log_info "Cutting link"
 		ip -net "$node1" link set vethB down
 	) &
-	check_ping "$node1" "100.64.0.2"
+	check_ping "$node1" "100.64.0.2" 0
 
 	wait
 	log_test "${tname}"
@@ -257,6 +266,66 @@ test_cut_link_prp()
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


