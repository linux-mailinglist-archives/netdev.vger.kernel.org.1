Return-Path: <netdev+bounces-274215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INBtBndkzWkHdAYAu9opvQ
	(envelope-from <netdev+bounces-274215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:31:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B698537F4AB
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAE9A303D2DB
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 18:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A5B3DEFE0;
	Wed,  1 Apr 2026 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdNzXNGR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF31A37F8D3;
	Wed,  1 Apr 2026 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067994; cv=none; b=FNhn0V/W7ket+POjr+q4DoQGapNBa1Pcs3TY9rQcUYKk5INA2dnGIhaQYSHnbyPz4qE2F1Eg9A/p3YJX6jtNFLTh6NDulcG7HLV1Fsl61557hxoZShqBvlaaJPEEhCxJ2QSXH6EoAgZ5gHQU7bTK8or5/iCJwiRYUbHnq0NNihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067994; c=relaxed/simple;
	bh=RbcZEbvD5VzE6rysOF8KEkV9Ce67Yl+NLmM/KUllj1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOZeH9krL5IOIJQsrqpRAkNatd21mI+rrHM96Kn1OiHmgr+s3RZuWPRat0C/TFCOFSnX+SGp8D16UI80DB1cIXDQ2GgsLnRrg42oRXIWchxiU1ZOCx4S1MZoU9F3qMLpRTxADT5Vc6jSWUmIc3lFquRHtz4aNjFB9UON+ql2/s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdNzXNGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14A4C19423;
	Wed,  1 Apr 2026 18:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775067994;
	bh=RbcZEbvD5VzE6rysOF8KEkV9Ce67Yl+NLmM/KUllj1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FdNzXNGRHmG9zoTg5u4jCscvjjbI4SazwHRo76MRBGo17wAjz0SN7cqKMbgkFLmJf
	 g3Pmn0fo2f7amB/grmaGBSYuladzsAZG1x3MFSA6HX+zn0PKteBFAZNuRY75HGoCuO
	 IRd0sEH0hVXgq/bJGHRUb+JmoMVHJatD9FQTzWnWOwPd6Qg1J2f8OElxbE+fqCqJd7
	 mD9Kc0oNXgljP+HjqOIccdnSSLW+iYYIdhOpXpOh0/88lpnQmbV4qX6b77JXL7NIlH
	 VV8NKynTDTD6ScFVf21CS3ft+iQg4fIf5C3RGRFubW89YrmZoB3U4VIk4DOUQQDjEO
	 lDbRA+Z7rm5RA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	anubhavsinggh@google.com,
	richardbgobert@gmail.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/6] selftests: drv-net: gro: always wait for FIN in the capacity test
Date: Wed,  1 Apr 2026 11:26:22 -0700
Message-ID: <20260401182625.372605-4-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401182625.372605-1-kuba@kernel.org>
References: <20260401182625.372605-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-274215-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B698537F4AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The new capacity/order test exits as soon as it sees the expected
packet sequence. This may allow the "flushing" FIN packet to spill
over to the next test. Let's always wait for the FIN before exiting.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/gro.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
index 27ccd742615a..f05398c18e0c 100644
--- a/tools/testing/selftests/net/lib/gro.c
+++ b/tools/testing/selftests/net/lib/gro.c
@@ -1154,7 +1154,7 @@ static void check_capacity_pkts(int fd)
 	memset(coalesced, 0, sizeof(coalesced));
 	memset(flow_order, -1, sizeof(flow_order));
 
-	while (total_data < num_flows * CAPACITY_PAYLOAD_LEN * 2) {
+	while (1) {
 		ip_ext_len = 0;
 		pkt_size = recv(fd, buffer, IP_MAXPACKET + ETH_HLEN + 1, 0);
 		if (pkt_size < 0)
@@ -1167,7 +1167,6 @@ static void check_capacity_pkts(int fd)
 
 		tcph = (struct tcphdr *)(buffer + tcp_offset + ip_ext_len);
 
-		/* FIN packet terminates reception */
 		if (tcph->fin)
 			break;
 
@@ -1189,7 +1188,13 @@ static void check_capacity_pkts(int fd)
 			data_len = pkt_size - total_hdr_len - ip_ext_len;
 		}
 
-		flow_order[num_pkt] = flow_id;
+		if (num_pkt < num_flows * 2) {
+			flow_order[num_pkt] = flow_id;
+		} else if (num_pkt == num_flows * 2) {
+			vlog("More packets than expected (%d)\n",
+			     num_flows * 2);
+			fail_reason = fail_reason ?: "too many packets";
+		}
 		coalesced[flow_id] = data_len;
 
 		if (data_len == CAPACITY_PAYLOAD_LEN * 2) {
-- 
2.53.0


