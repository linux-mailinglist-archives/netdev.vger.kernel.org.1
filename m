Return-Path: <netdev+bounces-274216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cACzCYZkzWkHdAYAu9opvQ
	(envelope-from <netdev+bounces-274216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:31:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDA337F4B3
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 909C930465D8
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 18:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B1B3A1695;
	Wed,  1 Apr 2026 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcQ0r3o1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D75639E6E4;
	Wed,  1 Apr 2026 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067995; cv=none; b=h48H6JWBGxausuG26Js8zGLm+ROCwsPMfiV2sIko5BerrzwNUoeSRGtnW+A2cJlJpMtydwPzTrXSilNhsjHMKCtvrvdykLXYM6TZR7HmxZ85uT1Ijk+9s8AbnSAXrtoJPcoMowYv58+txd/xzefGeLWCoAVOz01CMxaTeJ18TLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067995; c=relaxed/simple;
	bh=4yW9gvXzOG/U2TOx5e8UdZLjYLINsc9D08raRJRQCqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meQTsmV8Xa6/Gh2c1q0UryJx83yhPUuQdBoIXfMLZ2jp5TSdc5bBUNOyCuF2TXeDhUpm1XkI+n52ws2qXwvZjjFT52LnrfGWyMLP2rHYWNgSpAr3CeedHhXt5F7JZchJyp4UdoDbZgxx0Bq06NRnvGnCw/cuySqH+arRQ4vSlEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcQ0r3o1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E50C2BCB2;
	Wed,  1 Apr 2026 18:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775067995;
	bh=4yW9gvXzOG/U2TOx5e8UdZLjYLINsc9D08raRJRQCqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XcQ0r3o1G4supwXliKtZgp7OUJYCMF3e7dyE1kv/hYvVkSoopDFOfvZiwaMkJV/aI
	 b1uhQPbpqB7rj4K7K0MNOznypQaXIDUnZe9TJDXW6nEv/G+bP1RV3sdikQ9CfUMMT8
	 iGVY78V+4oOG07gaoz4DiXRJLTYPNKd6YscLzJZTNeLux12ytb8h9BilNpakf5OmVo
	 pT5O9s1htM2STbI1YDTfTnuqbSXhQ+F52/3bXuBWg8u0Hc5Y9rmE80+pUR4Q3Xunxb
	 PAWhWssyFrkxh5jCbm9A1GPoWL/XWu/2YHCtKhsnq+fkXvQm/p9vXIJPxH8idmu2mn
	 ujYacSrqnZerw==
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
Subject: [PATCH net-next 4/6] selftests: drv-net: gro: prepare for ip6ip6 support
Date: Wed,  1 Apr 2026 11:26:23 -0700
Message-ID: <20260401182625.372605-5-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-274216-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BDA337F4B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Try to use already calculated offsets and not depend on the ipip
flag as much. This patch should not change any functionality,
it's just a cleanup to make ip6ip6 support easier.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/gro.c | 73 +++++++++++++++------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
index f05398c18e0c..57080ecc3df8 100644
--- a/tools/testing/selftests/net/lib/gro.c
+++ b/tools/testing/selftests/net/lib/gro.c
@@ -139,6 +139,14 @@ static bool order_check;
 
 #define TXTIME_DELAY_MS 5
 
+/* Max TCP payload that GRO will coalesce. The outer header overhead
+ * varies by encapsulation, reducing the effective max payload.
+ */
+static int max_payload(void)
+{
+	return IP_MAXPACKET - (total_hdr_len - ETH_HLEN);
+}
+
 static void vlog(const char *fmt, ...)
 {
 	va_list args;
@@ -156,15 +164,13 @@ static void setup_sock_filter(int fd)
 	const int ethproto_off = offsetof(struct ethhdr, h_proto);
 	int optlen = 0;
 	int ipproto_off, opt_ipproto_off;
-	int next_off;
 
-	if (ipip)
-		next_off = sizeof(struct iphdr) + offsetof(struct iphdr, protocol);
-	else if (proto == PF_INET)
-		next_off = offsetof(struct iphdr, protocol);
+	if (proto == PF_INET)
+		ipproto_off = tcp_offset - sizeof(struct iphdr) +
+			      offsetof(struct iphdr, protocol);
 	else
-		next_off = offsetof(struct ipv6hdr, nexthdr);
-	ipproto_off = ETH_HLEN + next_off;
+		ipproto_off = tcp_offset - sizeof(struct ipv6hdr) +
+			      offsetof(struct ipv6hdr, nexthdr);
 
 	/* Overridden later if exthdrs are used: */
 	opt_ipproto_off = ipproto_off;
@@ -381,19 +387,23 @@ static void write_packet(int fd, char *buf, int len, struct sockaddr_ll *daddr)
 static void create_packet(void *buf, int seq_offset, int ack_offset,
 			  int payload_len, int fin)
 {
+	int ip_hdr_len = (proto == PF_INET) ?
+			 sizeof(struct iphdr) : sizeof(struct ipv6hdr);
+	int inner_ip_off = tcp_offset - ip_hdr_len;
+
 	memset(buf, 0, total_hdr_len);
 	memset(buf + total_hdr_len, 'a', payload_len);
 
 	fill_transportlayer(buf + tcp_offset, seq_offset, ack_offset,
 			    payload_len, fin);
 
-	if (ipip) {
-		fill_networklayer(buf + ETH_HLEN, payload_len + sizeof(struct iphdr),
-				  IPPROTO_IPIP);
-		fill_networklayer(buf + ETH_HLEN + sizeof(struct iphdr),
-				  payload_len, IPPROTO_TCP);
-	} else {
-		fill_networklayer(buf + ETH_HLEN, payload_len, IPPROTO_TCP);
+	fill_networklayer(buf + inner_ip_off, payload_len, IPPROTO_TCP);
+	if (inner_ip_off > ETH_HLEN) {
+		int encap_proto = (proto == PF_INET) ?
+				  IPPROTO_IPIP : IPPROTO_IPV6;
+
+		fill_networklayer(buf + ETH_HLEN,
+				  payload_len + ip_hdr_len, encap_proto);
 	}
 
 	fill_datalinklayer(buf);
@@ -547,8 +557,7 @@ static void send_ack(int fd, struct sockaddr_ll *daddr)
 static void recompute_packet(char *buf, char *no_ext, int extlen)
 {
 	struct tcphdr *tcphdr = (struct tcphdr *)(buf + tcp_offset);
-	struct ipv6hdr *ip6h = (struct ipv6hdr *)(buf + ETH_HLEN);
-	struct iphdr *iph = (struct iphdr *)(buf + ETH_HLEN);
+	int off;
 
 	memmove(buf, no_ext, total_hdr_len);
 	memmove(buf + total_hdr_len + extlen,
@@ -558,18 +567,22 @@ static void recompute_packet(char *buf, char *no_ext, int extlen)
 	tcphdr->check = 0;
 	tcphdr->check = tcp_checksum(tcphdr, PAYLOAD_LEN + extlen);
 	if (proto == PF_INET) {
-		iph->tot_len = htons(ntohs(iph->tot_len) + extlen);
-		iph->check = 0;
-		iph->check = checksum_fold(iph, sizeof(struct iphdr), 0);
+		for (off = ETH_HLEN; off < tcp_offset;
+		     off += sizeof(struct iphdr)) {
+			struct iphdr *iph = (struct iphdr *)(buf + off);
 
-		if (ipip) {
-			iph += 1;
 			iph->tot_len = htons(ntohs(iph->tot_len) + extlen);
 			iph->check = 0;
 			iph->check = checksum_fold(iph, sizeof(struct iphdr), 0);
 		}
 	} else {
-		ip6h->payload_len = htons(ntohs(ip6h->payload_len) + extlen);
+		for (off = ETH_HLEN; off < tcp_offset;
+		     off += sizeof(struct ipv6hdr)) {
+			struct ipv6hdr *ip6h = (struct ipv6hdr *)(buf + off);
+
+			ip6h->payload_len =
+				htons(ntohs(ip6h->payload_len) + extlen);
+		}
 	}
 }
 
@@ -1425,14 +1438,12 @@ static void gro_sender(void)
 
 	/* large sub-tests */
 	} else if (strcmp(testname, "large_max") == 0) {
-		int offset = (proto == PF_INET && !ipip) ? 20 : 0;
-		int remainder = (MAX_PAYLOAD + offset) % MSS;
+		int remainder = max_payload() % MSS;
 
 		send_large(txfd, &daddr, remainder);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "large_rem") == 0) {
-		int offset = (proto == PF_INET && !ipip) ? 20 : 0;
-		int remainder = (MAX_PAYLOAD + offset) % MSS;
+		int remainder = max_payload() % MSS;
 
 		send_large(txfd, &daddr, remainder + 1);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
@@ -1636,19 +1647,17 @@ static void gro_receiver(void)
 
 	/* large sub-tests */
 	} else if (strcmp(testname, "large_max") == 0) {
-		int offset = (proto == PF_INET && !ipip) ? 20 : 0;
-		int remainder = (MAX_PAYLOAD + offset) % MSS;
+		int remainder = max_payload() % MSS;
 
-		correct_payload[0] = (MAX_PAYLOAD + offset);
+		correct_payload[0] = max_payload();
 		correct_payload[1] = remainder;
 		printf("Shouldn't coalesce if exceed IP max pkt size: ");
 		check_recv_pkts(rxfd, correct_payload, 2);
 	} else if (strcmp(testname, "large_rem") == 0) {
-		int offset = (proto == PF_INET && !ipip) ? 20 : 0;
-		int remainder = (MAX_PAYLOAD + offset) % MSS;
+		int remainder = max_payload() % MSS;
 
 		/* last segment sent individually, doesn't start new segment */
-		correct_payload[0] = (MAX_PAYLOAD + offset) - remainder;
+		correct_payload[0] = max_payload() - remainder;
 		correct_payload[1] = remainder + 1;
 		correct_payload[2] = remainder + 1;
 		printf("last segment sent individually: ");
-- 
2.53.0


