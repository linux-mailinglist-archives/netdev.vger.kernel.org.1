Return-Path: <netdev+bounces-225155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6C5B8F9B5
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC762A0E23
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C6F285079;
	Mon, 22 Sep 2025 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkJGiM+Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157A2279794
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530501; cv=none; b=Uwgj2mRLSFAJ8M0NGC04hoYtGir6o6399Ea2UJRXXhEHKIKfSuZntwni39ymS2JJRisTGfHOYo1ARxj7ZkmiOIbzKq0UYH1ma3pa/AW5raeN8/ATQ+AqUQ3Kbq+UoVkN5j1J4qw5HWNytxowIOZJ0lLiICR+5Ur9mdOLJPifMV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530501; c=relaxed/simple;
	bh=8UM+az2cWYByr8ObEhssbPumaYByLl4dcAU6DqAxNeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oJKCTqp/VN+FmrltWRCX6pPngQ6rHradmMOdLt4l9iBaj7IA7shfWYvCoNJcKjTWpw9Ka/WmwaZCyslu93W3poTLbe0lOD4UebIYWvHemuCxOC6v+yzyqqeBqzqvqZUXz6dcpaotYrutlgq7yfhFm95cuTQEbJ2h9vhPk1+Huwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkJGiM+Z; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee1317b1f7so2028761f8f.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 01:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758530498; x=1759135298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRVOBg/z8tQ2d5GGqKN0EIKc3OKKueO2kHvL3hZOMP8=;
        b=UkJGiM+Z9RrsH3LVZr0yUeARVaP3l5eSHsNIga15/i9cRAyebKbalixgsSUxmE04no
         i4zvgLaKF1EctKv7BMiokxdIc6UJeJMoXv34FDELDKuKsu2CJsFpAmh2i8uqTwjacKrh
         lM/yWRltPMbo7EnV6QLEecDdK4m4BikVEsCSQ3l+Grmrpcp1SfguVOAPqNXS1R8PukEo
         XmQJJAcr/xQLDXJpaUTAam04f4glFQN3Cm62eJIEoE+1jHmWmfuy1dXTkLVnDW7wBgrN
         fi4/jgHgsqBkXhQSPnzDIW9mgw+rotzbDDEtCcwpdPxl3onmql8TQUjhLe1usKHySsEx
         A3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530498; x=1759135298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRVOBg/z8tQ2d5GGqKN0EIKc3OKKueO2kHvL3hZOMP8=;
        b=EHE6zM3kiiuz+xzQo2wFGvZQL3TjeMBGpUOr5CMq6NJYVh9SrLSvGSYY4atq01jLaF
         BR7EN8yF3wlbmEiE+XzJS1EPCrg1NmVstpYlvpxR3U97sxUzeSU4zhF36wKkJuZXByDX
         9KxiblOBC0MOBoCfOfgXkBHIEfXEDG7/myzQPmZZi1+a+dw+8fOJP7H7Ws46Qz45YT/x
         /Wbp0PZmrGXLrUg80Zab6shwLRqRXMzU5Bfoie0SdIF4K1+nX1uC84IdbUlQiOZ0Skjl
         8p2N6PPDVmtbhOGNVCz1VlnnJc/OwuP3upv28j0WU8Y5B9kvgP7cugkH3+8Aghtboxpq
         /YNw==
X-Gm-Message-State: AOJu0YzfXhqUTKC6AnLJFtsQyO2g8uVCHbW+71slBHYRApK2+6ymc2On
	rgl9j1t1+2qw3JV69EaAj11pvGSdNM96cjUin9tWY3h0jtGDW7csb68WTHaVAQ==
X-Gm-Gg: ASbGnctP75omPTYX45id95Ip9rB9Jfv+mPyrx7y3KYGyQeBFOUfe273QF8u0dYs9J8C
	CDgjiK7hSdcohDP+ng+kDt5zlpcfojIisS3ZA5Ii2v5vdgmyWaK2dIfu8BZ4R65HnmYQWFtCYEF
	Bzq/DqkSiQbdWAq7lBgAq0KfZqvvBMS7QKFD6chkL2X+DQFPSnbOZy4SzI3F5qaS4Pfoz1uaPLT
	SPh7aFO0b3SjJMj53SwO4p2+fOceu6Wlstb0F7PpbwcbB/nb/3nskzY7gUBcnwsR4v6Z2P5qtDp
	ghfrGRGCqf/4MXaWsN8DpaVFRTE9hn+D3qG0Plvgx2uruH9q/h4ktKjrSG+SgfIcZFw7PYwiR5z
	JgEAENizDcSq3CuIZTfkGXFw=
X-Google-Smtp-Source: AGHT+IEk0DIh01FwEv6QM15ji5iadLVfWC4r/azkltSnCFsc+FP7t0z1FPNur2+AnxX8pHd4+Yc2Jg==
X-Received: by 2002:a05:6000:2c01:b0:3fa:2316:c20 with SMTP id ffacd0b85a97d-3fa231616fbmr3466546f8f.5.1758530498265;
        Mon, 22 Sep 2025 01:41:38 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07408258sm19085132f8f.19.2025.09.22.01.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:41:37 -0700 (PDT)
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
Subject: [PATCH net-next v7 5/5] selftests/net: test ipip packets in gro.sh
Date: Mon, 22 Sep 2025 10:41:03 +0200
Message-Id: <20250922084103.4764-6-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922084103.4764-1-richardbgobert@gmail.com>
References: <20250922084103.4764-1-richardbgobert@gmail.com>
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


