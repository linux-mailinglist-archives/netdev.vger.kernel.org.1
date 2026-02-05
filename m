Return-Path: <netdev+bounces-257194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HHRMjiihGmI3wMAu9opvQ
	(envelope-from <netdev+bounces-257194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:59:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D9CF3A54
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9015F30254D6
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE63F3E958E;
	Thu,  5 Feb 2026 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIVHcegq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C2E33A6EC
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299898; cv=none; b=QOaMI8NkGksYgAH0AahGurCWpcZ5AQQUeDh+zn2kd5M8O+Qxnse/6JkAOJXkjMeHX/d2ejkNjrmkUsdyA+iY/zg8L86t9GxaFpjLZ9/JjxC0/V8BmhdxsmEbWrm4JLIMVtwG3uVkSQ+KAI6/QlpgKXEnHM5qHQZOhbtZOH7954U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299898; c=relaxed/simple;
	bh=a4F6vL+BiIL4+JC0/21SM6ThgvmY359c1aZclim49hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brF9iB08eqJ7DmRs89jXhsPZI4/JWKvOI6mAz8ZaqKLuyb2oDrJ6bmjgQLN9zjt57EUPWcsZLDPRWsONMMcyHSXpzxHLUixoczkVlgoppQLJQAbrt4qMFO6ZrfAv3C3Hr/jkH8yF+NMdEv2g4MCRA6rjWRA27Ugzms9EneE2hyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iIVHcegq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770299897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXR70+NUJ8uP2gNNpzCrPkV/5W0/KFtmLXj4mr5ZwTk=;
	b=iIVHcegq3LYO9g8xe2N7USrpU7cRbmTMcE2Dv+OuecV17AKhQrwpYbrURLdihvbflJlUzV
	AWUX8iCTGb/0LKWa3AuNaWEV4duLHEWg718dUHX7tO5CHkva//yacHq2R+WTSt1vwxOdtx
	bdT/iifTeGx5vby2V0V8KCfB4mRGq74=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-DDz9BJPCPoKT--JQ2GFOeg-1; Thu,
 05 Feb 2026 08:58:12 -0500
X-MC-Unique: DDz9BJPCPoKT--JQ2GFOeg-1
X-Mimecast-MFC-AGG-ID: DDz9BJPCPoKT--JQ2GFOeg_1770299890
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4571D1956089;
	Thu,  5 Feb 2026 13:58:10 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.32.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6AF3919560A7;
	Thu,  5 Feb 2026 13:58:06 +0000 (UTC)
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
Subject: [PATCH net-next v4 5/8] selftests: hsr: Add tests for more link faults with PRP
Date: Thu,  5 Feb 2026 14:57:32 +0100
Message-ID: <7b36506d3a80e53786fe56526cf6046c74dfeee1.1770299429.git.fmaurer@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	TAGGED_FROM(0.00)[bounces-257194-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 66D9CF3A54
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

The duplicates occur because of the 10ms ping interval in the test. As
blocks expire after 400ms based on the timestamp of the first received
sequence number in the block, every approx. 40th will lead to a new, clean
block being used where the sequence number hasn't been seen before. As this
occurs on both nodes in the test (for requests and replies), we observe
around 20 duplicate frames.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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


