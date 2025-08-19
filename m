Return-Path: <netdev+bounces-214877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10993B2B97F
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C991268242D
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7192698AF;
	Tue, 19 Aug 2025 06:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H73SxU9d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60D26AA88;
	Tue, 19 Aug 2025 06:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585199; cv=none; b=Lz0Fc8wsMi6EBIkMwqNcsYDvJAoDZ9+DPXxYHi8ANxVrC48tVppdohoiyjBTDk6ZSyeDOgZIAvhXuoIOfX7l80YWV+m5Kp0zS1K+r2r3RzNY0BXn+8vEILDARdiOIdDshUNVIpAFPGsiVjnhWF4AGrklvkPyCRQ15FcyhPE/UZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585199; c=relaxed/simple;
	bh=xvzymDWEGxe/xBACaTmXXspmwx9DLfQ4QvefG6YwyZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fj9AQC6MeU+wYks+xnAz7fNUixT7NjopDGU0L98zNXDgz+txbno3JD9W1HYHbXKyaDhjF09LQeXs9MpIxJlx6IXLRQCKa3k9wEq0kTnnK/EjyB9FPkJ7tdoZ/xqRHgZRSYX34lg8HL29zJLxib9JDF9lOL92J0+/73xi9/ucKmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H73SxU9d; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9dc5c6521so3367579f8f.1;
        Mon, 18 Aug 2025 23:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755585196; x=1756189996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2YkWRHa8ZjnqV/hoZ6DnKm4WSJDYwBX+XFMg2TnUH0=;
        b=H73SxU9dyn9NeQ6V50qrFR2q22xVqGyWw8l+Cx2u4LCshkAf8zp6mUX29CrWkxOv5s
         cHkoeis1muN9i7Vp/+99MH4KNGYq67E3U1nd5IWvg2andFJPmsB+JloMb9eVJofSIjaF
         H5bAAd+9ZtM5aDmGYWX98LxshPeEejHA4g394o3aGHhL8C+J1iW73FLYVRYiY5jYK+iU
         oy2nCRgyBAfD16aN6Ia+6g3iE2J0KzAm3cOR93D4NJUHu6fU9vmMikVkwRGHVfOxmPCI
         BMNUA6HvqDJyB+p/WubNynfuS/2Am+qjhxDXPHemvleQxRKidRjDr1uoRCurnXndXJyy
         42GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585196; x=1756189996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2YkWRHa8ZjnqV/hoZ6DnKm4WSJDYwBX+XFMg2TnUH0=;
        b=p/aaUdjT4Firg8gsDtdloGTHEsqjFSYNxFDwfkktsTjqIVJq9mDuSpQNILXG3XeMev
         FqF32zUhu6ELkHs7LHC2k82WnCCFogVc18d7nzoCZsVgTU16pqVpaVE/kdVZFRVF2VC4
         lv1LEC+wVgygByDiC/sRhuFMyFwClpTIp+MnAbQ4lyy3kEj2SLVEF3lUJ8HzFEfHswPc
         dPBZBsHj1XKMEcRiherIfzF5pFbwDOrBjBpFRnoisvAJFVmaZdwyDoS+4SIzGN6O87oL
         6uZI4ezqxfeo61rFvP5wkW9wE++ye0X533P6pRTCi8cmXphXpXwHSxc8qeYVNh1aUrlS
         4sfw==
X-Forwarded-Encrypted: i=1; AJvYcCWFNwQAvdqDdyhtGNdv3BlDSYknDsX2dIEEb6zDulTWBJmsj9rlsZUy2vIKgWImPiOG4DCe7rhvouPnVxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyzakg+7z7rSLlsbfKpP0vc9Za+pWyvgeBb4LpclKvGMXK/6a/
	1RdURAc37MLX2CQnCFLjy9aHgxAMGiI3tnI+NVJUAmZhY398VDZMK6e5LeGynT0XenI=
X-Gm-Gg: ASbGnct4mjSd3VAQ/jr02dxHUpHZXZuvzzq39e7IFbjh/mR9Dg0OH71/IqCKkcNRwX4
	j9AOhQe+pBbBr15RmjRiX60Xjt1Bv+Tfx6zSPa1FjREALe60NXWGLtZQopxg+7Zn/NPBGbFRz9g
	MxyW2QvpjRILwcqZW68/GyzntHFZQcvU0ZECtS2OoNpwppa/AgG1/iNVyD2LqdvZE8+gzqFXR6M
	tV9NNhUPBvSrz8WKtkpQ/Ry6RPQXFO53kIhOXZE1jRWmI3Q+IxIBHjlXC3B+jq1NbjyfAraFt/S
	MHfCxp4HMLPfkqJAMNaJB+Zb9ltp6+DAROY8GqhnQr33HfTBAS76oHQfOahpM8F4FSMm2l09iFs
	W1j0MOTPgmZBOxpPAFlgu0cfRELr1KYX/eA==
X-Google-Smtp-Source: AGHT+IHI1rQCsl7UDf/eQok1lYe4Qp0HhxA01N6rXziGgDsFHZGQG+c5oUewhNGmzC87GWABEBy0aQ==
X-Received: by 2002:a5d:64e7:0:b0:3b8:ffd2:6745 with SMTP id ffacd0b85a97d-3c0ed0fe599mr959663f8f.44.1755585195502;
        Mon, 18 Aug 2025 23:33:15 -0700 (PDT)
Received: from localhost ([45.10.155.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43ba5sm2331052f8f.22.2025.08.18.23.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:33:15 -0700 (PDT)
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
	florian.fainelli@broadcom.com,
	willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v2 5/5] selftests/net: test ipip packets in gro.sh
Date: Tue, 19 Aug 2025 08:32:23 +0200
Message-Id: <20250819063223.5239-6-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250819063223.5239-1-richardbgobert@gmail.com>
References: <20250819063223.5239-1-richardbgobert@gmail.com>
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
 tools/testing/selftests/net/gro.c  | 49 ++++++++++++++++++++++++------
 tools/testing/selftests/net/gro.sh |  5 +--
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 3d4a82a2607c..aeb4973418a4 100644
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
+	while ((c = getopt_long(argc, argv, "46ed:D:i:rs:S:t:v", opts, NULL)) != -1) {
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


