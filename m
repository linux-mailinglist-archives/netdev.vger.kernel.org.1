Return-Path: <netdev+bounces-215528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88700B2EFC6
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989F7681302
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 07:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAC92EA16B;
	Thu, 21 Aug 2025 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH4ZeaPa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292432E8DFA;
	Thu, 21 Aug 2025 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761491; cv=none; b=hZpAVtIYITS58VrGEP5O7Dc7pU77Gntq7kN0JF384u3PTHV1POpRqzdJFLsbEW2ycou7W6eCPMSR4ffZdiewWZjkUtFYZz5Lq9EEw6eKU6++LOialESA4q1XuShevvpOyLj/Mr/7g2KZJc9nMSEFKgf2g6eyPxicXkf3Esi46a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761491; c=relaxed/simple;
	bh=Bmup3zTtr8ZOHU7szSWCp6L/22E8IeBocLNjAmRD/tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ih/a5Y20MxZv+8mC3UdQfHRqu2y8X2rRwM3MEIOM3LQs2kCOuEfS9XMB38oxeZ9atDIUIp04FoYrqsLVyH3ibKt8xbUeXxplur3aeEdFihYorsmlQ8pYSnKxFnrl8Wua9oTVMxdu3LoY7FR/bf4VwVVn+0mFUi2OiU0RbkxI6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH4ZeaPa; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so4822415e9.3;
        Thu, 21 Aug 2025 00:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755761487; x=1756366287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3AY6EOb7TA3Vk/44dz1/Kzv3q8Ug/SBekAw+P0yOWU=;
        b=iH4ZeaPal/apcRiOz3M4FeXysB3FfkQ4QQYSQvJH5wiDg1YTNPxBEd3J5VaI8qm/ds
         3+eeeLNoHEP9VVVv7dszkARkuptNHPH10199VKnzEDs9iX2mAgqx2f2LnfXRiwXxoYwW
         mOIIfluahS2qm04/z6CgbyX0T7x9Yqfly6kl+r1Ol1NIuktA4xBykzaN8JHWmVABByQ7
         wovymeRf6oBDQq/h+PkDU2aOmzodv9K1pybwvbxs+XCy4gone0/S1CzN+ueWk+ZcGZpD
         kMx4vS0byVQMquDGbbuxpK5dgSm5/1bIV/vRRLIgikDVpAb1MeEANc1DU3bdFAo8I9NB
         Ud9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755761487; x=1756366287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3AY6EOb7TA3Vk/44dz1/Kzv3q8Ug/SBekAw+P0yOWU=;
        b=idtiLhb9H2TBe7drU3IP+qEFlYXpB5ZL0GjyrA2M2fKrRsmEMDwZgORXJW0RG7Xji3
         XPGJhfvRgNtmJEAv1Mjr0U5kq8G6va3uMt6Fo2ZSee+F2w1aSqfKpwtAkW/Kc8/RJz/t
         +RdUY64Hs/DoELbsMCrHD7JiIJ06g/essYibOv6d6J2nOKYPDRpE64P2EOB1/oqBgb40
         5a+BTI4vOp41j9qsLvPRbiZC9HfnUIkqAtrAncqn9mzTxLeWKsVB8DqvjK4lCLpsW23V
         W+eSHbt3seMdo43Zq5uQkY9VdGkrFUztresrbRP7DuV45fWQd2xyurZhbgHCSDGDwwQT
         0kQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2kOhuoDdPzjleGZKRWDTnic6AydAcsAyVscwoP0TIZcuVvHFhcbyCSZoDRa2nXzhf4zfnhMXj0vSQfA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwylNpbbxARLow+Y8RXc1KjUn5JvW9s6dSwTcuM6zUgy6HJLGwj
	fRlKEcIvh8Nu5Rj4FO/6lubvsG2ZaAsA94WgE6rztNknC9mvYSi8RkD1njjaAQ==
X-Gm-Gg: ASbGnctjRR+G3aIMGgY2h39x1NylIUPR+RUYtrcil5zUWkCl9vXBS50O3u24vDajKnV
	CxdtZ+kK+PvbXCepq2TmlOJQ2JMCSTr0sYq/qVFqXIFU9oenkOSOS4/sqoBn6d8ev+fhtcBMQK3
	MmcvjS9y4PiXIxmCcpjahkl/fScX+LgucCjXj6CuMeZ4GBd/OICT+03/h4X24APdC3k3NdAc6GY
	MdySzqr1RvLDXt/IOvfpi52MhWVFCbNjbMhSBuNbClnKNfWsCXEyz6XPO5ALEMb8I9URStYZZpp
	nWXHBiz0Z9nl8MJQMu5xT6zmytafFNy+p3TI0A6mmXPOt3VCh1PS6Q0NPTgP3vC61h1zbah+ssz
	V2OjI0ksuKnUyCw==
X-Google-Smtp-Source: AGHT+IEA6K2pX3lP5oONFfM9qMeCQu6OcRiAOhoIM3+7Z7qv/kdyGKHh723MIEBCgLKJPj8uK5Xl9Q==
X-Received: by 2002:a05:600c:4f03:b0:458:c059:7d9c with SMTP id 5b1f17b1804b1-45b4d7d5e3emr9027515e9.6.1755761487275;
        Thu, 21 Aug 2025 00:31:27 -0700 (PDT)
Received: from localhost ([45.84.137.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db1be26sm16421495e9.5.2025.08.21.00.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 00:31:26 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	ecree.xilinx@gmail.com,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	willemdebruijn.kernel@gmail.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v3 5/5] selftests/net: test ipip packets in gro.sh
Date: Thu, 21 Aug 2025 09:30:47 +0200
Message-Id: <20250821073047.2091-6-richardbgobert@gmail.com>
In-Reply-To: <20250821073047.2091-1-richardbgobert@gmail.com>
References: <20250821073047.2091-1-richardbgobert@gmail.com>
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
---
 tools/testing/selftests/net/gro.c  | 49 ++++++++++++++++++++++++------
 tools/testing/selftests/net/gro.sh |  5 +--
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 3d4a82a2607c..451dc1c1eac5 100644
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
+		fill_networklayer(buf + ETH_HLEN + sizeof(struct iphdr),
+				  payload_len, IPPROTO_TCP);
+		fill_networklayer(buf + ETH_HLEN, payload_len + sizeof(struct iphdr),
+				  IPPROTO_IPIP);
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
index 9e3f186bc2a1..d16ec365b3cf 100755
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
@@ -31,7 +31,8 @@ run_test() {
       1>>log.txt
     wait "${server_pid}"
     exit_code=$?
-    if [[ ${test} == "large" && -n "${KSFT_MACHINE_SLOW}" && \
+    if [[ ( ${test} == "large" || ${protocol} == "ipip" ) && \
+          -n "${KSFT_MACHINE_SLOW}" && \
           ${exit_code} -ne 0 ]]; then
         echo "Ignoring errors due to slow environment" 1>&2
         exit_code=0
-- 
2.36.1


