Return-Path: <netdev+bounces-306871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4uNbAjJfUmrJOwMAu9opvQ
	(envelope-from <netdev+bounces-306871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:20:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EF9741F15
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:20:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=G7HlGQyp;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306871-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306871-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65E103030B12
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4BC385D67;
	Sat, 11 Jul 2026 15:19:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71DB2D7DF1
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 15:19:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783183; cv=none; b=PSlF9fc04nAr8HrXoIu3gV83FxtDYoXFxWP96+aDrNwQVWU0qdN1E06QCVUO9+VYMvNTJwOrK0p2gkHQHUwdIiRSTny8ZAkkjGIIweaip0anCie4NQyD/f+vxopNHlGuyFPN1JGHMbOwgOCMLG8PpQMTlTZt3Fynafq/xcLDz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783183; c=relaxed/simple;
	bh=dlKAj3dMiX9DLGe1f8spk9e/hnyrKnbLT1vU+suSV8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foxhJeGJbj4E+ddRcBJ49EYv17jRPxKVIRrsKsjRj1k2K2zKbWuPC4ybS17N1dY0B3a8aGY69pSkD2FTGnuvqJAms4p0Msp6t6cGBo1tW7v7p8G98f+GqgKgrOqG6ezMJR1iwGLp02EFj7CVsifsrYbaxzwKP40Y8ttFo31yCes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7HlGQyp; arc=none smtp.client-ip=209.85.222.181
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e99ef0902so101004185a.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783783181; x=1784387981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nTbm3Lr0XkPh/S+BCtju0biWGy5LzIEgciPBWhK2qnY=;
        b=G7HlGQypqNGt9F0E3MN9ByHNvJk/iYg+IpgCHHhUzpK8dI8TKHZjF0euqm08ja9eq6
         GjhIQ3FSN8RXmvmHQ/LFFtfUxIlmS/iHdy2U+0XCwkR1mWImhE2PRePnPG701cJSl0Ok
         Kj6nw4H1yknwA/HbaxeMXIIMB/WR5oGkoXfd83kok07b5MB7M1VdrHzI6bDptF1ErPg+
         dfrlBNvb3Uh+6vR7ythvVsSfCoc3pP1+feJ7BYHIZZn+2pia7SOPAJPaYu/emd3Wkkbm
         pnVajr7Ht2uBXacmejY/wetsOKt/MtoZ0RIH4F5EnVrrX35oC6XtkKZdSIsxgowOojBR
         WSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783783181; x=1784387981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nTbm3Lr0XkPh/S+BCtju0biWGy5LzIEgciPBWhK2qnY=;
        b=ISN1b0jQt9F0y8GK6J1pwBQdT6Pyfwg4D/RlMdcf3qeS3ngUe3R3AGj6M7dMDGa6qM
         x6bdKwLASU2Oy8aupILk6no8EY5W+8rolXHyRqKYB4hoV8eULM46eTUft1PAfEbtgyAF
         U4XlUAQ2wxSdj0/IJqyRlh5oFFFYA57RiMl/6hvm1mjt3yshkIZQR0A/KeHg7clN6/MA
         S86q0X/TuEGLI0KPKDKcXwXUN6YxSiPIX0kPh/CI6jmEK3Ecv8ortGo8R4ILsMbP/SNR
         ge63TtbBDHU3q+8MQQ+dUeJz4j1Xy5JUzy5zbGvUsIVbOE8qKL7f2GrHEg6MNI8i3SaF
         XuJQ==
X-Gm-Message-State: AOJu0YzqxIZxVQOw21mRz+ajqaxqJDErIViQEIR82Ye+VU4yB7g9nAet
	3tz5MIytiX0BR0U2uk+yqXXNARWo7/dkFnBCdJ1V1RheNqvs23izuqzalyka/c+xlrA=
X-Gm-Gg: AfdE7cnGTzWiUUmCu/0IFub1vxo2HwhLz6SNcIhCqoH+mrA8lsukY0Jl9EpRL3XWBpA
	5yxT3+Ts5tPSI0pNj5zaUeiF9VNVmdxx/pgNNkcvCDh3YKyep8SuGBmq7eqMJB2h9IkUCzgPEhI
	VCMoVs4eX704aZ8bVbzXTkneyXOpjchBRiHkBKYRwn059vs903U29/IGcu/CKSPg41kO59+Pmso
	LDPz7rb3mish7AA2WoTKu2zJAJW6niXfdbSGU28P2lHMHC0rv36PA56IB6SYZ8QeYD8PqjhF4ne
	Pr27q3BM8tBDgxPo14fk1p1bG/PzbSJ0zZFZ+GwQQlzBiUJ3ehq01OnZMfwQ5i1rxi5HIXFNJbI
	E3GCqv2HW13eX9RWBDRAe20XiKJHfgAhJ5jg+r3OwmGIXqCOfN37KZXo8BKQxk1yUhHohQAdqII
	TcjJC/utUbnrXM6+3tVMHKkvBi+LQGvC5VOt91hfB9zkJuLWNMr7cq1lh5akb+eUfuprESgP/f5
	eCjNRzkDA==
X-Received: by 2002:a05:620a:31a3:b0:92e:bca0:6308 with SMTP id af79cd13be357-92ef2b11b00mr365636285a.20.1783783180759;
        Sat, 11 Jul 2026 08:19:40 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4a082sm467704685a.7.2026.07.11.08.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:19:40 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 1/2] amt: re-read skb header pointers after every pull
Date: Sat, 11 Jul 2026 11:19:33 -0400
Message-ID: <20260711151934.2955226-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260711151934.2955226-1-michael.bommarito@gmail.com>
References: <20260711151934.2955226-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306871-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ap420073@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51EF9741F15

Several AMT receive and transmit paths cache a pointer into the skb head
(ip_hdr(), ipv6_hdr(), eth_hdr() or the AMT message header) and then call
a helper that can reallocate that head before the cached pointer is used
again.  pskb_may_pull(), ip_mc_may_pull(), ipv6_mc_may_pull(),
iptunnel_pull_header(), ip_mc_check_igmp() and ipv6_mc_check_mld() can all
free the old head and move the data, so a pointer taken before the call
dangles afterwards and the later access is a use-after-free of the freed
head.

The affected sites are:

  amt_rcv() caches ip_hdr() before amt_parse_type() pulls, then reads
  iph->saddr.

  amt_dev_xmit() caches ip_hdr()/ipv6_hdr() before ip_mc_check_igmp()/
  ipv6_mc_check_mld() and pskb_may_pull(), then reads the group address.

  amt_multicast_data_handler() caches eth_hdr() before pskb_may_pull(),
  then writes the L2 header.

  amt_membership_query_handler() caches the AMT header, the outer and
  inner eth_hdr() and ip_hdr() before iptunnel_pull_header() and several
  pulls, then reads and writes them.

  amt_igmpv3_report_handler() and amt_mldv2_report_handler() cache
  ip_hdr()/ipv6_hdr() and the current group record and read the record
  count from the report header inside the record loop, across the
  *_mc_may_pull() calls.

  amt_update_handler() caches ip_hdr() and the AMT membership-update
  header before pskb_may_pull(), iptunnel_pull_header(),
  ip_mc_check_igmp() and the report handler, then reads iph->daddr and
  amtmu->nonce / amtmu->response_mac.

Fix each site by either snapshotting the scalar that is used after the
pull before the first pull runs, or re-deriving the header pointer from
the skb after the last pull that can move the head.  Values that are
stable across the pull (source and group address, the response MAC and
nonce, the record count, the outer source MAC) are snapshotted; pointers
that are written through or read repeatedly are re-derived.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/net/amt.c | 79 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 24 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 951dd10e192b7..35e77af76bd9d 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1211,7 +1211,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 			data = true;
 		}
 		v6 = false;
-		group.ip4 = iph->daddr;
+		group.ip4 = ip_hdr(skb)->daddr;
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (iph->version == 6) {
 		ip6h = ipv6_hdr(skb);
@@ -1235,7 +1235,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 			data = true;
 		}
 		v6 = true;
-		group.ip6 = ip6h->daddr;
+		group.ip6 = ipv6_hdr(skb)->daddr;
 #endif
 	} else {
 		dev->stats.tx_errors++;
@@ -1278,12 +1278,12 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 			hlist_for_each_entry_rcu(gnode, &tunnel->groups[hash],
 						 node) {
 				if (!v6) {
-					if (gnode->group_addr.ip4 == iph->daddr)
+					if (gnode->group_addr.ip4 == group.ip4)
 						goto found;
 #if IS_ENABLED(CONFIG_IPV6)
 				} else {
 					if (ipv6_addr_equal(&gnode->group_addr.ip6,
-							    &ip6h->daddr))
+							    &group.ip6))
 						goto found;
 #endif
 				}
@@ -2000,14 +2000,18 @@ static void amt_igmpv3_report_handler(struct amt_dev *amt, struct sk_buff *skb,
 	struct igmpv3_report *ihrv3 = igmpv3_report_hdr(skb);
 	int len = skb_transport_offset(skb) + sizeof(*ihrv3);
 	void *zero_grec = (void *)&igmpv3_zero_grec;
-	struct iphdr *iph = ip_hdr(skb);
 	struct amt_group_node *gnode;
 	union amt_addr group, host;
 	struct igmpv3_grec *grec;
+	__be32 saddr;
 	u16 nsrcs;
+	u16 ngrec;
 	int i;
 
-	for (i = 0; i < ntohs(ihrv3->ngrec); i++) {
+	saddr = ip_hdr(skb)->saddr;
+	ngrec = ntohs(ihrv3->ngrec);
+
+	for (i = 0; i < ngrec; i++) {
 		len += sizeof(*grec);
 		if (!ip_mc_may_pull(skb, len))
 			break;
@@ -2019,10 +2023,13 @@ static void amt_igmpv3_report_handler(struct amt_dev *amt, struct sk_buff *skb,
 		if (!ip_mc_may_pull(skb, len))
 			break;
 
+		grec = (void *)(skb->data + len - sizeof(*grec) -
+				nsrcs * sizeof(__be32));
+
 		memset(&group, 0, sizeof(union amt_addr));
 		group.ip4 = grec->grec_mca;
 		memset(&host, 0, sizeof(union amt_addr));
-		host.ip4 = iph->saddr;
+		host.ip4 = saddr;
 		gnode = amt_lookup_group(tunnel, &group, &host, false);
 		if (!gnode) {
 			gnode = amt_add_group(amt, tunnel, &group, &host,
@@ -2162,14 +2169,18 @@ static void amt_mldv2_report_handler(struct amt_dev *amt, struct sk_buff *skb,
 	struct mld2_report *mld2r = (struct mld2_report *)icmp6_hdr(skb);
 	int len = skb_transport_offset(skb) + sizeof(*mld2r);
 	void *zero_grec = (void *)&mldv2_zero_grec;
-	struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct amt_group_node *gnode;
 	union amt_addr group, host;
 	struct mld2_grec *grec;
+	struct in6_addr saddr;
 	u16 nsrcs;
+	u16 ngrec;
 	int i;
 
-	for (i = 0; i < ntohs(mld2r->mld2r_ngrec); i++) {
+	saddr = ipv6_hdr(skb)->saddr;
+	ngrec = ntohs(mld2r->mld2r_ngrec);
+
+	for (i = 0; i < ngrec; i++) {
 		len += sizeof(*grec);
 		if (!ipv6_mc_may_pull(skb, len))
 			break;
@@ -2181,10 +2192,13 @@ static void amt_mldv2_report_handler(struct amt_dev *amt, struct sk_buff *skb,
 		if (!ipv6_mc_may_pull(skb, len))
 			break;
 
+		grec = (void *)(skb->data + len - sizeof(*grec) -
+				nsrcs * sizeof(struct in6_addr));
+
 		memset(&group, 0, sizeof(union amt_addr));
 		group.ip6 = grec->grec_mca;
 		memset(&host, 0, sizeof(union amt_addr));
-		host.ip6 = ip6h->saddr;
+		host.ip6 = saddr;
 		gnode = amt_lookup_group(tunnel, &group, &host, true);
 		if (!gnode) {
 			gnode = amt_add_group(amt, tunnel, &group, &host,
@@ -2305,7 +2319,6 @@ static bool amt_multicast_data_handler(struct amt_dev *amt, struct sk_buff *skb)
 	skb_push(skb, sizeof(*eth));
 	skb_reset_mac_header(skb);
 	skb_pull(skb, sizeof(*eth));
-	eth = eth_hdr(skb);
 
 	if (!pskb_may_pull(skb, sizeof(*iph)))
 		return true;
@@ -2315,6 +2328,7 @@ static bool amt_multicast_data_handler(struct amt_dev *amt, struct sk_buff *skb)
 		if (!ipv4_is_multicast(iph->daddr))
 			return true;
 		skb->protocol = htons(ETH_P_IP);
+		eth = eth_hdr(skb);
 		eth->h_proto = htons(ETH_P_IP);
 		ip_eth_mc_map(iph->daddr, eth->h_dest);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2328,6 +2342,7 @@ static bool amt_multicast_data_handler(struct amt_dev *amt, struct sk_buff *skb)
 		if (!ipv6_addr_is_multicast(&ip6h->daddr))
 			return true;
 		skb->protocol = htons(ETH_P_IPV6);
+		eth = eth_hdr(skb);
 		eth->h_proto = htons(ETH_P_IPV6);
 		ipv6_eth_mc_map(&ip6h->daddr, eth->h_dest);
 #endif
@@ -2351,10 +2366,12 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 					 struct sk_buff *skb)
 {
 	struct amt_header_membership_query *amtmq;
-	struct igmpv3_query *ihv3;
 	struct ethhdr *eth, *oeth;
+	struct igmpv3_query *ihv3;
+	u8 h_source[ETH_ALEN];
 	struct iphdr *iph;
 	int hdr_size, len;
+	u64 response_mac;
 
 	hdr_size = sizeof(*amtmq) + sizeof(struct udphdr);
 	if (!pskb_may_pull(skb, hdr_size))
@@ -2367,6 +2384,8 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	if (amtmq->nonce != amt->nonce)
 		return true;
 
+	response_mac = amtmq->response_mac;
+
 	hdr_size -= sizeof(*eth);
 	if (iptunnel_pull_header(skb, hdr_size, htons(ETH_P_TEB), false))
 		return true;
@@ -2376,6 +2395,7 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	skb_pull(skb, sizeof(*eth));
 	skb_reset_network_header(skb);
 	eth = eth_hdr(skb);
+	ether_addr_copy(h_source, oeth->h_source);
 	if (!pskb_may_pull(skb, sizeof(*iph)))
 		return true;
 
@@ -2388,6 +2408,7 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 				   sizeof(*ihv3)))
 			return true;
 
+		iph = ip_hdr(skb);
 		if (!ipv4_is_multicast(iph->daddr))
 			return true;
 
@@ -2395,10 +2416,11 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 		skb_reset_transport_header(skb);
 		skb_push(skb, sizeof(*iph) + AMT_IPHDR_OPTS);
 		WRITE_ONCE(amt->ready4, true);
-		amt->mac = amtmq->response_mac;
+		amt->mac = response_mac;
 		amt->req_cnt = 0;
 		amt->qi = ihv3->qqic;
 		skb->protocol = htons(ETH_P_IP);
+		eth = eth_hdr(skb);
 		eth->h_proto = htons(ETH_P_IP);
 		ip_eth_mc_map(iph->daddr, eth->h_dest);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2421,10 +2443,11 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 		skb_reset_transport_header(skb);
 		skb_push(skb, sizeof(*ip6h) + AMT_IP6HDR_OPTS);
 		WRITE_ONCE(amt->ready6, true);
-		amt->mac = amtmq->response_mac;
+		amt->mac = response_mac;
 		amt->req_cnt = 0;
 		amt->qi = mld2q->mld2q_qqic;
 		skb->protocol = htons(ETH_P_IPV6);
+		eth = eth_hdr(skb);
 		eth->h_proto = htons(ETH_P_IPV6);
 		ipv6_eth_mc_map(&ip6h->daddr, eth->h_dest);
 #endif
@@ -2432,7 +2455,7 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 		return true;
 	}
 
-	ether_addr_copy(eth->h_source, oeth->h_source);
+	ether_addr_copy(eth->h_source, h_source);
 	skb->pkt_type = PACKET_MULTICAST;
 	skb->ip_summed = CHECKSUM_NONE;
 	len = skb->len;
@@ -2455,8 +2478,11 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	struct ethhdr *eth;
 	struct iphdr *iph;
 	int len, hdr_size;
+	u64 response_mac;
+	__be32 saddr;
+	__be32 nonce;
 
-	iph = ip_hdr(skb);
+	saddr = ip_hdr(skb)->saddr;
 
 	hdr_size = sizeof(*amtmu) + sizeof(struct udphdr);
 	if (!pskb_may_pull(skb, hdr_size))
@@ -2466,15 +2492,18 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	if (amtmu->reserved || amtmu->version)
 		return true;
 
+	nonce = amtmu->nonce;
+	response_mac = amtmu->response_mac;
+
 	if (iptunnel_pull_header(skb, hdr_size, skb->protocol, false))
 		return true;
 
 	skb_reset_network_header(skb);
 
 	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
-		if (tunnel->ip4 == iph->saddr) {
-			if ((amtmu->nonce == tunnel->nonce &&
-			     amtmu->response_mac == tunnel->mac)) {
+		if (tunnel->ip4 == saddr) {
+			if ((nonce == tunnel->nonce &&
+			     response_mac == tunnel->mac)) {
 				mod_delayed_work(amt_wq, &tunnel->gc_wq,
 						 msecs_to_jiffies(amt_gmi(amt))
 								  * 3);
@@ -2508,6 +2537,7 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 		eth = eth_hdr(skb);
 		skb->protocol = htons(ETH_P_IP);
 		eth->h_proto = htons(ETH_P_IP);
+		iph = ip_hdr(skb);
 		ip_eth_mc_map(iph->daddr, eth->h_dest);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (iph->version == 6) {
@@ -2527,6 +2557,7 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 		eth = eth_hdr(skb);
 		skb->protocol = htons(ETH_P_IPV6);
 		eth->h_proto = htons(ETH_P_IPV6);
+		ip6h = ipv6_hdr(skb);
 		ipv6_eth_mc_map(&ip6h->daddr, eth->h_dest);
 #endif
 	} else {
@@ -2772,7 +2803,7 @@ static void amt_gw_rcv(struct amt_dev *amt, struct sk_buff *skb)
 static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct amt_dev *amt;
-	struct iphdr *iph;
+	__be32 saddr;
 	int type;
 	bool err;
 
@@ -2785,7 +2816,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 
 	skb->dev = amt->dev;
-	iph = ip_hdr(skb);
+	saddr = ip_hdr(skb)->saddr;
 	type = amt_parse_type(skb);
 	if (type == -1) {
 		err = true;
@@ -2795,7 +2826,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 	if (amt->mode == AMT_MODE_GATEWAY) {
 		switch (type) {
 		case AMT_MSG_ADVERTISEMENT:
-			if (iph->saddr != amt->discovery_ip) {
+			if (saddr != amt->discovery_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -2807,7 +2838,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 			goto out;
 		case AMT_MSG_MULTICAST_DATA:
-			if (iph->saddr != amt->remote_ip) {
+			if (saddr != amt->remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -2818,7 +2849,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			else
 				goto out;
 		case AMT_MSG_MEMBERSHIP_QUERY:
-			if (iph->saddr != amt->remote_ip) {
+			if (saddr != amt->remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;

base-commit: 2c7c88a412aa6d09cd04b414211b4ef8553b5309
-- 
2.53.0


