Return-Path: <netdev+bounces-213688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C33B26480
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2FB37B50A3
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459112F8BE8;
	Thu, 14 Aug 2025 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNFYQXth"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754242F49FA;
	Thu, 14 Aug 2025 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171706; cv=none; b=PTTIuHGhVM2+K/hD0HsLxpX0gTQvTu52owc3d15Y3UtrTQch5M1UCo3QHwkR6pHCR9SaA5bDT3cy53m46Dq0jGX5raAWyRn0C2RvsmUegZtmFZiP30XdtfscAaiyxFHVbo6vKOroguf6ekgVDZSzhgDK85Wv7OMvi0p1ifOCCCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171706; c=relaxed/simple;
	bh=Km6HAM5WPy85lF6G3hIg/9d7nR8208+jUkQ5DnzMyWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N9MK+rt9Ek9ijocqxWizR7Y3K7lmgMnBAbgNQDNn3OSDJz0zg+et8mid0Ibhb4ef40cBAAm7vCj6S81IoDKirHQZsUuaDyHl2ljqLL+uVICyzMUqtyXKSTadnFxjcBzDsEtM4fGZCr2TYTOjJnHPy9SRYVJtocEqd7VsvDg27fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNFYQXth; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9d41cd38dso539141f8f.0;
        Thu, 14 Aug 2025 04:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755171703; x=1755776503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3h8+OjZKOpkiZNZr++0BKN8NT+/LAkfWQsPEcsq8Haw=;
        b=VNFYQXthd8k9+08KRQCC5HMK8dXi5E9R1oowszRSbcu60kE+oq7kdP+o0xxKLykDxq
         4cmqkOGEtWf+zaMkozL09abFUzjUfpDADUNH8GHrZCelZ/zcolAzIWJU9FPnWrD7Pakt
         n3Hd2Lc7sHfnsY9Er6Olcgiip6I98pspYgSyRpSRT6dxCgEmpRnSWcday31eRx2ATONN
         RjmtVyYTebjwZApR80mzeWpdMe55L/Hd9RxQGtfv0Lpm7CDwnPgOzERtglSiX34O7vBn
         Tq19hIkIQowEse+Aos1B4Wr9UFYtTe88xPFYZxWTxoEAHuLj6SRCk+vD2ZyxGGXsA6ya
         dhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755171703; x=1755776503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3h8+OjZKOpkiZNZr++0BKN8NT+/LAkfWQsPEcsq8Haw=;
        b=DODwk5az7SBPFsshW6uK1vmOVEhqxosYJ6OQsiVJY5recBmS/vBAhr/9PecjMnSwOK
         IpW2eBAR19aD80OwVIqt08Yp8vJi40KlxIz3AwN59a55NT+IZxj6+lJR07hWWUEJ+XfW
         z1Hcxzeq9Ut4Fln02QcVLi242JiY9rnGUSgl7/1HZctQdArh735RmTK0r0wNjKRKD8WD
         5VMDFWyrvYTNF049HQri+pIGE42xUbkboBibK/BRRBgufWeAH8/Mp2a+ocLq9Qo4QGSd
         +j1q4delw1iZaMb2d6U+3gacqSiorIXzB5NdNPPLEw1C7l13pOJKQlk6vhmknl4FNJ8l
         qlvg==
X-Forwarded-Encrypted: i=1; AJvYcCVzjjS0s+O4rVPSy3YpL6gh/MjJL2XB0/OPNYb2l61UazhmKyHRnVYMbNsaNAHJN5U44R24EcYnmxiWJaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRMLPzU/M6UVOFBil1lFwy4qz+1+m2auTr0XF862F5CjKf8NFh
	umesGYU9EEl9YCtT7NOJN34C2z1Gda0Mi9TkW7lPYKW7er99lHEDkGLTyJoahXO95JA=
X-Gm-Gg: ASbGncvx7aDFsfkGL2VErvH+r+f1hZXuyX1qnmQSdI+xjZs9nfB+ss52magC+yVN43F
	7ef+djZvkFXVPv3iRroW2ops1LfAGFEN150l63CCjJOuBFUmyP/zlIchjHPXoLoETsJSnLdereT
	TbmZl4tHkBH955V3uBoGp81WEthh/6MxT858Y9DQ96sq9Jm2+6J7nq6k+ItjPIPtwVViYQBQH5q
	aIAex1ewXuESAwVsotUxeCCY400vv8+i9UgqIJrr3PZ0wBbnJi0LPEY9p3t7aJmZvCWY4dmCWmx
	M8fersvtVrLJ+yeUi97fOJmfVXmub6VNKtm1XIpy0lpw8G82rNfLsuFcvb6hjlqXWov3//h0j22
	1QLOuBzCG8oeEQ1wTgBVjy6UDpmPkfOBFOg==
X-Google-Smtp-Source: AGHT+IEScL1eql0ZMV/N3qkw3RbTyRwTGE8yEEAe2Y2luSwWvhuJhbXe9zC/yYLWDbi3tueJj9Dh3w==
X-Received: by 2002:a05:6000:2dc6:b0:3b8:12a6:36b8 with SMTP id ffacd0b85a97d-3b9edf5f1e8mr2495461f8f.46.1755171702695;
        Thu, 14 Aug 2025 04:41:42 -0700 (PDT)
Received: from localhost ([45.10.155.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469319sm49568378f8f.54.2025.08.14.04.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:41:42 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	andrew+netdev@lunn.ch,
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
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next 5/5] selftests/net: test ipip packets in gro.sh
Date: Thu, 14 Aug 2025 13:40:30 +0200
Message-Id: <20250814114030.7683-6-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814114030.7683-1-richardbgobert@gmail.com>
References: <20250814114030.7683-1-richardbgobert@gmail.com>
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

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 tools/testing/selftests/net/gro.c  | 38 +++++++++++++++++++++++-------
 tools/testing/selftests/net/gro.sh |  5 ++--
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 3d4a82a2607c..a129c7965fb8 100644
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
 
@@ -777,7 +790,7 @@ static void send_fragment4(int fd, struct sockaddr_ll *daddr)
 	 */
 	memset(buf + total_hdr_len, 'a', PAYLOAD_LEN * 2);
 	fill_transportlayer(buf + tcp_offset, PAYLOAD_LEN, 0, PAYLOAD_LEN * 2, 0);
-	fill_networklayer(buf + ETH_HLEN, PAYLOAD_LEN);
+	fill_networklayer(buf + ETH_HLEN, PAYLOAD_LEN, IPPROTO_TCP);
 	fill_datalinklayer(buf);
 
 	iph->frag_off = htons(0x6000); // DF = 1, MF = 1
@@ -1250,6 +1263,7 @@ static void parse_args(int argc, char **argv)
 		{ "iface", required_argument, NULL, 'i' },
 		{ "ipv4", no_argument, NULL, '4' },
 		{ "ipv6", no_argument, NULL, '6' },
+		{ "ipip", no_argument, NULL, 'e' },
 		{ "rx", no_argument, NULL, 'r' },
 		{ "saddr", required_argument, NULL, 's' },
 		{ "smac", required_argument, NULL, 'S' },
@@ -1259,7 +1273,7 @@ static void parse_args(int argc, char **argv)
 	};
 	int c;
 
-	while ((c = getopt_long(argc, argv, "46d:D:i:rs:S:t:v", opts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "46ed:D:i:rs:S:t:v", opts, NULL)) != -1) {
 		switch (c) {
 		case '4':
 			proto = PF_INET;
@@ -1269,6 +1283,11 @@ static void parse_args(int argc, char **argv)
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
@@ -1304,7 +1323,10 @@ int main(int argc, char **argv)
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


