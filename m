Return-Path: <netdev+bounces-223607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CE8B59AE2
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9771BC0A8B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3A735A28D;
	Tue, 16 Sep 2025 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQXF18EA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E16352FD7
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034155; cv=none; b=AA16ql5c9Qb95f5tPyRKv8sQMs+L1SrdV8Nf7lmL/KX5abihI+GOVRR1Tl5n8FyETT2IlSCLI4AqbxOVKqijkxBHMKN+PnUC0xjoP3U60BrZn0BGGC7AboARPJbMN/4P6uvZDCuyEhwBinWV3G+vXnMkd0w8cFBDxCXOvZT/ojQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034155; c=relaxed/simple;
	bh=8UM+az2cWYByr8ObEhssbPumaYByLl4dcAU6DqAxNeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hNoWqBuFqFIdbMX0tNrBtUiB1PfwHkFCPHLdv4B15CQedvJs5NTUZjTg9Xo/FWKqqkdA/bxzTuzrS0uBCuyDAZuAev1PZ0H4JxEsR3aYn/+bYJkrSIGussvLjuvxdqJC+2IjXFQTnKCrjAWW3ExmGGEHrr/3ZNetnuPWlMcEBXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQXF18EA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso40960915e9.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034151; x=1758638951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRVOBg/z8tQ2d5GGqKN0EIKc3OKKueO2kHvL3hZOMP8=;
        b=RQXF18EA6TXxv4Orw5B02C84AxnnKmW5PQpIpZcytiBBIGMIoWl1Zvqo/P+Yy9MEmp
         +Bi0orVEfIvMU0MJW13b1CKteF4+jkvdRBqt8eiu+FpoZKmsicFg1dMKqlnqUpg+NVBO
         FU8QHypjocj8g3nElFTnQmmOeSCMHkbqtQtS5AeWzG27Ln9PE4LEMgv6Tu5oOJfOR5O0
         CaHg54fS66G2ckT5kLD9Vfu/69a5bjvyZL0dwcOOIAaDxkaK45QColi1poAy/g/6luGI
         +Yr3AKz4grljofMHE8lMhNS7p2gT5Dpn/w+g6D21MXYns6R0ju5h0qVZ+Yy623Kxlwa1
         N02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034151; x=1758638951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRVOBg/z8tQ2d5GGqKN0EIKc3OKKueO2kHvL3hZOMP8=;
        b=m51k7Wq+Nbxh1upa89KYxu+TtL5R0xJllP93Wc0p15dZyI/a64oKUxhIBeJ4F1JdGV
         t1ez9YIkGB1OlaMdyJPQaxvk8G406oCKrLwwUMYrHyv+tAwnvsVztJ2sNA2YE+3MXMIi
         bPCjuU3Xs7ogIyKE78PWhY+ypbCqoY2AeKjFLjp6dJ9usIl75odYKa9jo0sqjESYSBF8
         B/fpHzvGZQ/XJpDohQ6lzQ+NTsTYimmWBq6EgYcpb/PiKu7+ikoGxMx72nCw4B5xGyrU
         VzBdbYHbHmswYhUrMoBsB/hZ1PUQ4GNeJi43tt1p8RdYFVo6cFOoUEU2QM5gLyFpjcJW
         VqYg==
X-Gm-Message-State: AOJu0YxQjMCFSAioN83HwHsNGWJfP8NysXCB0lDBKfaz0DAUR6fzqcbP
	62/OThGLuExW6r40bOVNAWsPI2GGBYcP8BOZ5GdTTVx7A/dlhNjLmwsUW/QJZw==
X-Gm-Gg: ASbGncsjuJowj0l++TuL4UbE8+8KKC2wbcjli1FtTO1Cq/iBmv2PzQDcyI9kadFTWnT
	yhoIvKJ6zxMPSeO/TJi3BmCcW91i/LOg6lMJvaV94cEIki2VjeCDuK5Vdpzi382MGH1StjNUr+C
	71ZJDf2YYPDU9xMzJ1xzASGOy+LVsx8RLEr3hhTbMhCKBcfgx/Wh4hNM62GsciOhhmmzmxsxyOF
	HFZnzfTdUEz9v9kvNPj+MQv/pxee69tr/qmaXvoHuuulC3/733eDTkK5B+JDASG85prgskfCHB2
	EKZORASWbUOgMOzqyaJPmGFaobeSzddC56Cez4ikqy+IHBebDzem0clpieXSZE0Md0N4LkWReKd
	kbQkSuhkB1MtzBdbxMWHZ5kIeogD71OLftw==
X-Google-Smtp-Source: AGHT+IEvPgUVs3gO6SGrw/rlpToBP6Gho0I0bJPGGHyN6QEdDrNbDntdwvFRtvms6uHSZb51U4Dwiw==
X-Received: by 2002:a7b:c7da:0:b0:45d:e111:de7e with SMTP id 5b1f17b1804b1-45f21214dc6mr97605835e9.19.1758034150832;
        Tue, 16 Sep 2025 07:49:10 -0700 (PDT)
Received: from localhost ([45.10.155.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f29174de1sm138676095e9.2.2025.09.16.07.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:49:10 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v6 5/5] selftests/net: test ipip packets in gro.sh
Date: Tue, 16 Sep 2025 16:48:41 +0200
Message-Id: <20250916144841.4884-6-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916144841.4884-1-richardbgobert@gmail.com>
References: <20250916144841.4884-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add IPIP test-cases to the GRO selftest.

This selftest already contains IP ID test-cases. They are now
also tested for encapsulated packets.

This commit also fixes ipip packet generation in the test.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/gro.c  | 49 ++++++++++++++++++++++++------
 tools/testing/selftests/net/gro.sh |  2 +-
 2 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 3d4a82a2607c..2b1d9f2b3e9e 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -93,6 +93,7 @@ static bool tx_socket = true;
 static int tcp_offset = -1;
 static int total_hdr_len = -1;
 static int ethhdr_proto = -1;
+static bool ipip;
 static const int num_flush_id_cases = 6;
 
 static void vlog(const char *fmt, ...)
@@ -114,7 +115,9 @@ static void setup_sock_filter(int fd)
 	int ipproto_off, opt_ipproto_off;
 	int next_off;
 
-	if (proto == PF_INET)
+	if (ipip)
+		next_off = sizeof(struct iphdr) + offsetof(struct iphdr, protocol);
+	else if (proto == PF_INET)
 		next_off = offsetof(struct iphdr, protocol);
 	else
 		next_off = offsetof(struct ipv6hdr, nexthdr);
@@ -244,7 +247,7 @@ static void fill_datalinklayer(void *buf)
 	eth->h_proto = ethhdr_proto;
 }
 
-static void fill_networklayer(void *buf, int payload_len)
+static void fill_networklayer(void *buf, int payload_len, int protocol)
 {
 	struct ipv6hdr *ip6h = buf;
 	struct iphdr *iph = buf;
@@ -254,7 +257,7 @@ static void fill_networklayer(void *buf, int payload_len)
 
 		ip6h->version = 6;
 		ip6h->payload_len = htons(sizeof(struct tcphdr) + payload_len);
-		ip6h->nexthdr = IPPROTO_TCP;
+		ip6h->nexthdr = protocol;
 		ip6h->hop_limit = 8;
 		if (inet_pton(AF_INET6, addr6_src, &ip6h->saddr) != 1)
 			error(1, errno, "inet_pton source ip6");
@@ -266,7 +269,7 @@ static void fill_networklayer(void *buf, int payload_len)
 		iph->version = 4;
 		iph->ihl = 5;
 		iph->ttl = 8;
-		iph->protocol	= IPPROTO_TCP;
+		iph->protocol	= protocol;
 		iph->tot_len = htons(sizeof(struct tcphdr) +
 				payload_len + sizeof(struct iphdr));
 		iph->frag_off = htons(0x4000); /* DF = 1, MF = 0 */
@@ -313,9 +316,19 @@ static void create_packet(void *buf, int seq_offset, int ack_offset,
 {
 	memset(buf, 0, total_hdr_len);
 	memset(buf + total_hdr_len, 'a', payload_len);
+
 	fill_transportlayer(buf + tcp_offset, seq_offset, ack_offset,
 			    payload_len, fin);
-	fill_networklayer(buf + ETH_HLEN, payload_len);
+
+	if (ipip) {
+		fill_networklayer(buf + ETH_HLEN, payload_len + sizeof(struct iphdr),
+				  IPPROTO_IPIP);
+		fill_networklayer(buf + ETH_HLEN + sizeof(struct iphdr),
+				  payload_len, IPPROTO_TCP);
+	} else {
+		fill_networklayer(buf + ETH_HLEN, payload_len, IPPROTO_TCP);
+	}
+
 	fill_datalinklayer(buf);
 }
 
@@ -416,6 +429,13 @@ static void recompute_packet(char *buf, char *no_ext, int extlen)
 		iph->tot_len = htons(ntohs(iph->tot_len) + extlen);
 		iph->check = 0;
 		iph->check = checksum_fold(iph, sizeof(struct iphdr), 0);
+
+		if (ipip) {
+			iph += 1;
+			iph->tot_len = htons(ntohs(iph->tot_len) + extlen);
+			iph->check = 0;
+			iph->check = checksum_fold(iph, sizeof(struct iphdr), 0);
+		}
 	} else {
 		ip6h->payload_len = htons(ntohs(ip6h->payload_len) + extlen);
 	}
@@ -777,7 +797,7 @@ static void send_fragment4(int fd, struct sockaddr_ll *daddr)
 	 */
 	memset(buf + total_hdr_len, 'a', PAYLOAD_LEN * 2);
 	fill_transportlayer(buf + tcp_offset, PAYLOAD_LEN, 0, PAYLOAD_LEN * 2, 0);
-	fill_networklayer(buf + ETH_HLEN, PAYLOAD_LEN);
+	fill_networklayer(buf + ETH_HLEN, PAYLOAD_LEN, IPPROTO_TCP);
 	fill_datalinklayer(buf);
 
 	iph->frag_off = htons(0x6000); // DF = 1, MF = 1
@@ -1071,7 +1091,7 @@ static void gro_sender(void)
 		 * and min ipv6hdr size. Like MAX_HDR_SIZE,
 		 * MAX_PAYLOAD is defined with the larger header of the two.
 		 */
-		int offset = proto == PF_INET ? 20 : 0;
+		int offset = (proto == PF_INET && !ipip) ? 20 : 0;
 		int remainder = (MAX_PAYLOAD + offset) % MSS;
 
 		send_large(txfd, &daddr, remainder);
@@ -1221,7 +1241,7 @@ static void gro_receiver(void)
 			check_recv_pkts(rxfd, correct_payload, 2);
 		}
 	} else if (strcmp(testname, "large") == 0) {
-		int offset = proto == PF_INET ? 20 : 0;
+		int offset = (proto == PF_INET && !ipip) ? 20 : 0;
 		int remainder = (MAX_PAYLOAD + offset) % MSS;
 
 		correct_payload[0] = (MAX_PAYLOAD + offset);
@@ -1250,6 +1270,7 @@ static void parse_args(int argc, char **argv)
 		{ "iface", required_argument, NULL, 'i' },
 		{ "ipv4", no_argument, NULL, '4' },
 		{ "ipv6", no_argument, NULL, '6' },
+		{ "ipip", no_argument, NULL, 'e' },
 		{ "rx", no_argument, NULL, 'r' },
 		{ "saddr", required_argument, NULL, 's' },
 		{ "smac", required_argument, NULL, 'S' },
@@ -1259,7 +1280,7 @@ static void parse_args(int argc, char **argv)
 	};
 	int c;
 
-	while ((c = getopt_long(argc, argv, "46d:D:i:rs:S:t:v", opts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "46d:D:ei:rs:S:t:v", opts, NULL)) != -1) {
 		switch (c) {
 		case '4':
 			proto = PF_INET;
@@ -1269,6 +1290,11 @@ static void parse_args(int argc, char **argv)
 			proto = PF_INET6;
 			ethhdr_proto = htons(ETH_P_IPV6);
 			break;
+		case 'e':
+			ipip = true;
+			proto = PF_INET;
+			ethhdr_proto = htons(ETH_P_IP);
+			break;
 		case 'd':
 			addr4_dst = addr6_dst = optarg;
 			break;
@@ -1304,7 +1330,10 @@ int main(int argc, char **argv)
 {
 	parse_args(argc, argv);
 
-	if (proto == PF_INET) {
+	if (ipip) {
+		tcp_offset = ETH_HLEN + sizeof(struct iphdr) * 2;
+		total_hdr_len = tcp_offset + sizeof(struct tcphdr);
+	} else if (proto == PF_INET) {
 		tcp_offset = ETH_HLEN + sizeof(struct iphdr);
 		total_hdr_len = tcp_offset + sizeof(struct tcphdr);
 	} else if (proto == PF_INET6) {
diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
index 9e3f186bc2a1..4c5144c6f652 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/net/gro.sh
@@ -4,7 +4,7 @@
 readonly SERVER_MAC="aa:00:00:00:00:02"
 readonly CLIENT_MAC="aa:00:00:00:00:01"
 readonly TESTS=("data" "ack" "flags" "tcp" "ip" "large")
-readonly PROTOS=("ipv4" "ipv6")
+readonly PROTOS=("ipv4" "ipv6" "ipip")
 dev=""
 test="all"
 proto="ipv4"
-- 
2.36.1


