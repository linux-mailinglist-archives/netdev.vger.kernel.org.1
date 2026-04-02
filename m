Return-Path: <netdev+bounces-274699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKkNH2jZzmmGqgYAu9opvQ
	(envelope-from <netdev+bounces-274699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:02:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC43E38E353
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 701E4305EB80
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579C237BE78;
	Thu,  2 Apr 2026 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnUNfvXY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3292137C915;
	Thu,  2 Apr 2026 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163614; cv=none; b=n6I3EzYNqvisuq7E51gZm6/JQecZjKQR28+0opo2yEnc4QekvfWOO7tmvv4oIGrJfM7c/DQardEcsxEIndq20BzJivMvEGx+WCouisXw71iJkRMOsLp+QEOWJhlLDDCZyq0MAUr6Wur1mMDD1m0c9YSl9FGrOpoVM/XNUD22fc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163614; c=relaxed/simple;
	bh=N/d/t6g4kqcpMUYbdxf+ubadBonLqT4h/ep9qLdQSUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQd2HeMF/qgzB7vv6j/ThVGP/RCXttd/wRRcsQqhLDmI6YnSDOO1R3vlj9etGVVw+lRf5Jsh1LAHOzddXjAMjeiIdG5UrSiDjXwljDs2nNssK+zoFsaNQTJu+XtyiXI49osZj8OZ2XVHgzCs0AAJeNWSZW71a3ZzWU/Q5octRCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnUNfvXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A65C19424;
	Thu,  2 Apr 2026 21:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775163614;
	bh=N/d/t6g4kqcpMUYbdxf+ubadBonLqT4h/ep9qLdQSUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jnUNfvXYqYq9HkG/O6HwAO4zE0Yfnsi1YfFGD6tWw62xF7b9FszQWjtHq7UWTiCis
	 2NvxSY+1HNSSqlsJjGkaBeXbivEqOguJ8ktH0RxaGmuxBq9Ar68r4SzEOAVyiInlE2
	 pFTjBauYNYEPhqrljuSOIH8o2HWr1OgS/jTUtlasNcgFF1nRfeRFOvmz4OEfV7NStI
	 zzO5VvnsqZ+EANo6hfxTrYo8OUYcJ48s9qwpEktTIoMBwGVQuN4tKAKxCINqat94NN
	 167HROe0VinXc1Ie8Y8kKPr+4lfjz9JtMUaMcvGAqordAy8DNpzGEk+fja1Vx6CGvm
	 mXaGBGUZspvnQ==
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
Subject: [PATCH net-next v2 6/8] selftests: drv-net: gro: make large packet math more precise
Date: Thu,  2 Apr 2026 13:59:58 -0700
Message-ID: <20260402210000.1512696-7-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402210000.1512696-1-kuba@kernel.org>
References: <20260402210000.1512696-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-274699-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC43E38E353
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When constructing the packets for large_* test cases we use
a static value for packet count and MSS. It works okay for
ipv4 vs ipv6 but the gap between ipv4 and ip6ip6 is going to
be quite significant.

Make the defines calculate the worst case values, those
are only used for sizing stack arrays. Create helpers for
calculating precise values based on the exact test case.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/gro.c | 45 +++++++++++++++++----------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
index 3616ecc42a01..dc8638d5d74d 100644
--- a/tools/testing/selftests/net/lib/gro.c
+++ b/tools/testing/selftests/net/lib/gro.c
@@ -94,10 +94,11 @@
 #define START_SEQ 100
 #define START_ACK 100
 #define ETH_P_NONE 0
-#define MSS (4096 - sizeof(struct tcphdr) - sizeof(struct ipv6hdr))
-#define MAX_PAYLOAD (IP_MAXPACKET - sizeof(struct tcphdr) - sizeof(struct ipv6hdr))
-#define NUM_LARGE_PKT (MAX_PAYLOAD / MSS)
+#define ASSUMED_MTU 4096
+#define MAX_MSS (ASSUMED_MTU - sizeof(struct iphdr) - sizeof(struct tcphdr))
 #define MAX_HDR_LEN (ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct tcphdr))
+#define MAX_LARGE_PKT_CNT ((IP_MAXPACKET - (MAX_HDR_LEN - ETH_HLEN)) /	\
+			   (ASSUMED_MTU - (MAX_HDR_LEN - ETH_HLEN)))
 #define MIN_EXTHDR_SIZE 8
 #define EXT_PAYLOAD_1 "\x00\x00\x00\x00\x00\x00"
 #define EXT_PAYLOAD_2 "\x11\x11\x11\x11\x11\x11"
@@ -146,6 +147,16 @@ static int max_payload(void)
 	return IP_MAXPACKET - (total_hdr_len - ETH_HLEN);
 }
 
+static int calc_mss(void)
+{
+	return ASSUMED_MTU - (total_hdr_len - ETH_HLEN);
+}
+
+static int num_large_pkt(void)
+{
+	return max_payload() / calc_mss();
+}
+
 static void vlog(const char *fmt, ...)
 {
 	va_list args;
@@ -525,18 +536,20 @@ static void send_data_pkts(int fd, struct sockaddr_ll *daddr,
  */
 static void send_large(int fd, struct sockaddr_ll *daddr, int remainder)
 {
-	static char pkts[NUM_LARGE_PKT][MAX_HDR_LEN + MSS];
-	static char last[MAX_HDR_LEN + MSS];
-	static char new_seg[MAX_HDR_LEN + MSS];
+	static char pkts[MAX_LARGE_PKT_CNT][MAX_HDR_LEN + MAX_MSS];
+	static char new_seg[MAX_HDR_LEN + MAX_MSS];
+	static char last[MAX_HDR_LEN + MAX_MSS];
+	const int num_pkt = num_large_pkt();
+	const int mss = calc_mss();
 	int i;
 
-	for (i = 0; i < NUM_LARGE_PKT; i++)
-		create_packet(pkts[i], i * MSS, 0, MSS, 0);
-	create_packet(last, NUM_LARGE_PKT * MSS, 0, remainder, 0);
-	create_packet(new_seg, (NUM_LARGE_PKT + 1) * MSS, 0, remainder, 0);
+	for (i = 0; i < num_pkt; i++)
+		create_packet(pkts[i], i * mss, 0, mss, 0);
+	create_packet(last, num_pkt * mss, 0, remainder, 0);
+	create_packet(new_seg, (num_pkt + 1) * mss, 0, remainder, 0);
 
-	for (i = 0; i < NUM_LARGE_PKT; i++)
-		write_packet(fd, pkts[i], total_hdr_len + MSS, daddr);
+	for (i = 0; i < num_pkt; i++)
+		write_packet(fd, pkts[i], total_hdr_len + mss, daddr);
 	write_packet(fd, last, total_hdr_len + remainder, daddr);
 	write_packet(fd, new_seg, total_hdr_len + remainder, daddr);
 }
@@ -1437,12 +1450,12 @@ static void gro_sender(void)
 
 	/* large sub-tests */
 	} else if (strcmp(testname, "large_max") == 0) {
-		int remainder = max_payload() % MSS;
+		int remainder = max_payload() % calc_mss();
 
 		send_large(txfd, &daddr, remainder);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "large_rem") == 0) {
-		int remainder = max_payload() % MSS;
+		int remainder = max_payload() % calc_mss();
 
 		send_large(txfd, &daddr, remainder + 1);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
@@ -1646,14 +1659,14 @@ static void gro_receiver(void)
 
 	/* large sub-tests */
 	} else if (strcmp(testname, "large_max") == 0) {
-		int remainder = max_payload() % MSS;
+		int remainder = max_payload() % calc_mss();
 
 		correct_payload[0] = max_payload();
 		correct_payload[1] = remainder;
 		printf("Shouldn't coalesce if exceed IP max pkt size: ");
 		check_recv_pkts(rxfd, correct_payload, 2);
 	} else if (strcmp(testname, "large_rem") == 0) {
-		int remainder = max_payload() % MSS;
+		int remainder = max_payload() % calc_mss();
 
 		/* last segment sent individually, doesn't start new segment */
 		correct_payload[0] = max_payload() - remainder;
-- 
2.53.0


