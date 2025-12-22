Return-Path: <netdev+bounces-245764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F848CD72B2
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 21:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A1C5301FC1A
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 20:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1DC3346A1;
	Mon, 22 Dec 2025 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcd4ncRa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AACC3101B4
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766437142; cv=none; b=CzwfNk0ovPgcyGRbSPr+4mGmlCF42hwt05PPzPgNNIkTiB9OZbzykO1q+rGbu6dpUSO0G2Z7J6wOR07FPcvRiAUaqqLD34XkDKHiqRhmMvu1s9dZrTRhFboTzVAN3BwpSCD5eNPvhBuQenIqGHXKTL2O78u2466lz9rFkTfax8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766437142; c=relaxed/simple;
	bh=0bFCeC5gl3lw07ZQF5OJsrCddI/0283ESFg8Dj4kt6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flRO94OvcOZH5mSYqSCaAUMwDAp2t3AourQu6ju2mIEl+nDUFDBSOASSF3ti60RctxwmhCTi9ggPh7XlVbRLJTKC9JR8UhFa2jLm+TsI+FMU9hDcXOK8L6OmQLNvshjfyNz9vPru5vNQKIdAUHBaobwRjWq/0aR/WArv8mbszPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcd4ncRa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766437138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWu6rCFRqC1vXZ2O2kll67cFmWfqf/irN9GX6eHldLk=;
	b=dcd4ncRaA0sAj/u0yAQ7pZObJ5WqHSfItTooccpvP/AfM0Rfzm02YVrMx7N88DJ64cmy89
	cRIuZdCsyFLlvClrgIDPB9vbVu/jdDZzsTiu6lbR8fD7mI53Hnsg9JXA+5pqggOqRJ0MDo
	GolQAqAtjGvyd43yiRKbhLv+4ZYs4WA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-vSealaKGOG6X2t0_vctrIQ-1; Mon,
 22 Dec 2025 15:58:55 -0500
X-MC-Unique: vSealaKGOG6X2t0_vctrIQ-1
X-Mimecast-MFC-AGG-ID: vSealaKGOG6X2t0_vctrIQ_1766437133
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BE001800365;
	Mon, 22 Dec 2025 20:58:53 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.32.178])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DFAA11800352;
	Mon, 22 Dec 2025 20:58:49 +0000 (UTC)
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
Subject: [RFC net 4/6] selftests: hsr: Add tests for more link faults with PRP
Date: Mon, 22 Dec 2025 21:57:34 +0100
Message-ID: <0d442f373edefc1481275154a0291ba9325fbe41.1766433800.git.fmaurer@redhat.com>
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
index b00fdba62f17..11a55ba5cd7d 100755
--- a/tools/testing/selftests/net/hsr/link_faults.sh
+++ b/tools/testing/selftests/net/hsr/link_faults.sh
@@ -10,10 +10,16 @@ ALL_TESTS="
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
@@ -152,6 +158,7 @@ check_ping()
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
+	tname="${FUNCNAME} - ${proto}, ${loss}"
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
+	tname="${FUNCNAME} - ${proto}"
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


