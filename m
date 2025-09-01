Return-Path: <netdev+bounces-218734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01067B3E1D4
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D78D7AB57C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EDE31DDBB;
	Mon,  1 Sep 2025 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFmtM/NK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4520E3218DC;
	Mon,  1 Sep 2025 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726760; cv=none; b=qtJ1SIzeNWTEGKNPYcKl+KZBD1ovOAZTmTlm/TUPNcJVUr5r66VcAFKwnGC9IBzj/kYNmMl/3TnEs1oIqplzwMAMikUXhY89Hxl5kr5104P3pHKtZzEt3aJJ0Lh8MMF3zkW7+l96dD03yW0uiXVW4JDLm+fKXPnEvJeT+Uj/+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726760; c=relaxed/simple;
	bh=Bmup3zTtr8ZOHU7szSWCp6L/22E8IeBocLNjAmRD/tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A0PxSbs32LbJf87lJzzIiaiQB24bpGnK+/k7F4+NpJMvI5C0P2Zi1Rcr+kzMkUaLug1bZDQ9yq1+gdStWVxMBpY+IvX8TTlYsSA3QdGhCmCxYl3vJKPJ1ZaTYtO3wkosgUB5OhbmuXt1WL+Nce/cSbDRVAUNRlsUxXXQpsYOsms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFmtM/NK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so28786055e9.1;
        Mon, 01 Sep 2025 04:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756726757; x=1757331557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3AY6EOb7TA3Vk/44dz1/Kzv3q8Ug/SBekAw+P0yOWU=;
        b=fFmtM/NK4EtOzl/Ur1OoeGS4VKPQLi9QpR4WO63UrZv4XQt/IVAibyIYJbCVEizz7D
         s+tGGqZExQanj4aADn2vp7cJnUzOF+RjXCUUpTbF6roPiNDdbAIpFQQkeJvwjkiCbN3e
         /AJ3GyweKdmNc4Pna8jBpApqbfX0qu9zXvomLLzEYpCNt8JPgSTkP3hh5czGIy/G8IgD
         aYU0VMzaePjfuHLqsElm1F9DpbfnqrzAXVuZUjc59lxrKHUNWGR2Iv2ZUoya/4FSUFSo
         gXDrvuWyJI1Ya87lm2F7faB6z21lrpD8qsYQmhakAOfisFXnRhFBhJNrGEPlVxBSJXoa
         jWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726757; x=1757331557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3AY6EOb7TA3Vk/44dz1/Kzv3q8Ug/SBekAw+P0yOWU=;
        b=UK3+vV2jFPgYJjYltrgieeI6C9KSDlEz8Pl2Jy4F/vexbkWpAxRfKXCcNi6oISxE41
         Z44ly1D5njMjJ0ADznlDz2jdvIxEW7jyMT2fxOwSAseHkW7Vui4f+Rt7PUDzB7H2rCIj
         R3LKYcS0OAX54o9XyxenNJZzExj9w7NSvri0vuYyM/9dPUPRKvqfQFdWZvQ6aROtKPQv
         om4dIhEgKfP5xDKS0T3SZaHmzxgBFhMrkzkeYw+BiuYZmkZOtsZKLtW8mxBxFSS/PdtG
         SA3ImhHSLWepS197uC+y2zUNlcZhSSw/Zjmtj7xhfeay5jaEPfWEtNY2Sp6aqEjli0+a
         qbaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhY15AP235b2nVcFIpXP4p6uY0ppp8J5dhGbNnQMXRyVeMu2hen1KaD7oRw8M+G3brCcO3XtMCoYHuMp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlL34tC58pXibvOI5s1kPBvxcgX8LX4kLGMhLcPjezWwASx5X7
	eW+yVKRGIFFMJtgNl8Niomm4tE4puoa6ePwRWTRYokgovyITxCPCHIsp5ub8oW4sxlo=
X-Gm-Gg: ASbGncuuXPMEK4YtKAscMuAEY2ixhmdzIQKVLYVGRldseyruJgN4VIcih7mEd11nCrB
	1EJFNfIdZxPTDxAx0rF+uyp1+jSwtb1XJwZB1OLUpO84uFbKuP0J10KCb6D5WX1KBf8QizoI814
	GJ1A/Qn9aiRDcnqyyvSWBgmvhZHQPEcorzvDPb2+p5Q2r+GLWyObZA49jtK2WJFR5a9DHFar5kJ
	yDvOFGFMVpTfTknPGea7GBQ4tyOeg6AWP1x193SpixLIuY6dJh2eOIy8OrSheQTGqPXJsKvVTwE
	185oKVVGC94jQ3asQuo5wZKwmoLJdlIIYbcTDK6OeZE6WmElM3sbxznhT1xVw2r8pfyzmzfPtzf
	dTDPBPjbmTpFlgZt0ALU2JtCC+apckjiNA86LJQ==
X-Google-Smtp-Source: AGHT+IFNFy8OfnP+aTXE7Dm63eF75/jXRPRAPzdJrWiA7gGNQ+veQvq+fFuoOhMZVe0TzguZi9H7EA==
X-Received: by 2002:a05:600c:8b22:b0:45b:4a98:91cf with SMTP id 5b1f17b1804b1-45b8554fa14mr74094365e9.15.1756726756493;
        Mon, 01 Sep 2025 04:39:16 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d1319sm163021765e9.5.2025.09.01.04.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 04:39:16 -0700 (PDT)
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
Subject: [PATCH net-next v4 5/5] selftests/net: test ipip packets in gro.sh
Date: Mon,  1 Sep 2025 13:38:26 +0200
Message-Id: <20250901113826.6508-6-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250901113826.6508-1-richardbgobert@gmail.com>
References: <20250901113826.6508-1-richardbgobert@gmail.com>
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


