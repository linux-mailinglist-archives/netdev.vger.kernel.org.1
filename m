Return-Path: <netdev+bounces-126599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02187971F8E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201D31C215A4
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A44016DEB4;
	Mon,  9 Sep 2024 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jgYN/gTB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861441758F
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900687; cv=none; b=qCjBsSljStV4urPHh+plcYgQJibCCQ0BD+OAMQrhBcm/vgj0/ZSRIZNfpyVxNFtgYMU29ZYTC3SkCrLKzAPtDhi3eaXuK+SmyU7Jq/sWt0NOz4/OnvMDkpURDFfEBz0WueDTz/XIXnNsap1sfZ6xvOpDfVICr77KeS67GrGRwDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900687; c=relaxed/simple;
	bh=MC6W/carBRqwB8CRk/0zLmEob04R2hQcTELGW+EoQFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubeOiDwR+WaYb7hWE+fcYGpQqesdwJmYYqelg8vB0qh/q/8AUEFmw5h+PQjSuiNrMjy1JBSxTUxG6MqDNpUoMZ9dmLbPxnosp3ZkZovtMiJTB6gct17IPi79TonQnb5MECSG3fbRajpxpbNoL4XlE9QyFPD3qr2Fw1GWex0rEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jgYN/gTB; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 489Cq5po001415;
	Mon, 9 Sep 2024 09:51:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=m4oJx5NV1YjHTTc6HbZQ6F8LpbCHnMovULqd9AReWRw=; b=
	jgYN/gTBAlNB4iW3JKuTEZ/xsX179FiDUIlX0NOHZXJx0J9oXaY8jUaJDMRoCOCM
	/43/bFbUJgYRaztjWuxfCcQIaW5LnyFcvo42CSW+mihhPQOPrUINJBw9DBCi9GDp
	il1Hhxgr+FlTTpgPVT8y/eX2GH02nvAfseebnad1w9am6YYw3DTaW8pSsEDUde47
	iTqGtvvlUt9KHlyT3EBOaeaDa1nm7zAH5a3F3mkjx4h6DvjmP3rLagqzV5b/AiV6
	wS0D2dzvL+QOMbdGV1M5HzVitiaIsHdFEQWmrcA2C7RlzRm8o0Tnr2Pbmh/7W479
	0B6t56eCWRD/4q6ycuTWuQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41hssfkktf-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 09 Sep 2024 09:51:10 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 9 Sep 2024 16:51:08 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Willem de Bruijn
	<willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Jason Xing
	<kerneljasonxing@gmail.com>,
        Simon Horman <horms@kernel.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v4 3/3] selftests: txtimestamp: add SCM_TS_OPT_ID test
Date: Mon, 9 Sep 2024 09:50:46 -0700
Message-ID: <20240909165046.644417-4-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240909165046.644417-1-vadfed@meta.com>
References: <20240909165046.644417-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: FCLEb7lLQVHRmktnMjfcWw-YAc5_Ft-d
X-Proofpoint-ORIG-GUID: FCLEb7lLQVHRmktnMjfcWw-YAc5_Ft-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_08,2024-09-09_01,2024-09-02_01

Extend txtimestamp test to run with fixed tskey using
SCM_TS_OPT_ID control message for all types of sockets.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 tools/include/uapi/asm-generic/socket.h    |  2 +
 tools/testing/selftests/net/txtimestamp.c  | 48 +++++++++++++++++-----
 tools/testing/selftests/net/txtimestamp.sh | 12 +++---
 3 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
index 54d9c8bf7c55..281df9139d2b 100644
--- a/tools/include/uapi/asm-generic/socket.h
+++ b/tools/include/uapi/asm-generic/socket.h
@@ -124,6 +124,8 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SCM_TS_OPT_ID		78
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
index ec60a16c9307..bdd0eb74326c 100644
--- a/tools/testing/selftests/net/txtimestamp.c
+++ b/tools/testing/selftests/net/txtimestamp.c
@@ -54,6 +54,10 @@
 #define USEC_PER_SEC	1000000L
 #define NSEC_PER_SEC	1000000000LL
 
+#ifndef SCM_TS_OPT_ID
+# define SCM_TS_OPT_ID 78
+#endif
+
 /* command line parameters */
 static int cfg_proto = SOCK_STREAM;
 static int cfg_ipproto = IPPROTO_TCP;
@@ -77,6 +81,8 @@ static bool cfg_epollet;
 static bool cfg_do_listen;
 static uint16_t dest_port = 9000;
 static bool cfg_print_nsec;
+static uint32_t ts_opt_id;
+static bool cfg_use_cmsg_opt_id;
 
 static struct sockaddr_in daddr;
 static struct sockaddr_in6 daddr6;
@@ -136,12 +142,13 @@ static void validate_key(int tskey, int tstype)
 	/* compare key for each subsequent request
 	 * must only test for one type, the first one requested
 	 */
-	if (saved_tskey == -1)
+	if (saved_tskey == -1 || cfg_use_cmsg_opt_id)
 		saved_tskey_type = tstype;
 	else if (saved_tskey_type != tstype)
 		return;
 
 	stepsize = cfg_proto == SOCK_STREAM ? cfg_payload_len : 1;
+	stepsize = cfg_use_cmsg_opt_id ? 0 : stepsize;
 	if (tskey != saved_tskey + stepsize) {
 		fprintf(stderr, "ERROR: key %d, expected %d\n",
 				tskey, saved_tskey + stepsize);
@@ -480,7 +487,7 @@ static void fill_header_udp(void *p, bool is_ipv4)
 
 static void do_test(int family, unsigned int report_opt)
 {
-	char control[CMSG_SPACE(sizeof(uint32_t))];
+	char control[2 * CMSG_SPACE(sizeof(uint32_t))];
 	struct sockaddr_ll laddr;
 	unsigned int sock_opt;
 	struct cmsghdr *cmsg;
@@ -620,18 +627,32 @@ static void do_test(int family, unsigned int report_opt)
 		msg.msg_iov = &iov;
 		msg.msg_iovlen = 1;
 
-		if (cfg_use_cmsg) {
+		if (cfg_use_cmsg || cfg_use_cmsg_opt_id) {
 			memset(control, 0, sizeof(control));
 
 			msg.msg_control = control;
-			msg.msg_controllen = sizeof(control);
+			msg.msg_controllen = cfg_use_cmsg * CMSG_SPACE(sizeof(uint32_t));
+			msg.msg_controllen += cfg_use_cmsg_opt_id * CMSG_SPACE(sizeof(uint32_t));
 
-			cmsg = CMSG_FIRSTHDR(&msg);
-			cmsg->cmsg_level = SOL_SOCKET;
-			cmsg->cmsg_type = SO_TIMESTAMPING;
-			cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
+			cmsg = NULL;
+			if (cfg_use_cmsg) {
+				cmsg = CMSG_FIRSTHDR(&msg);
+				cmsg->cmsg_level = SOL_SOCKET;
+				cmsg->cmsg_type = SO_TIMESTAMPING;
+				cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
+
+				*((uint32_t *)CMSG_DATA(cmsg)) = report_opt;
+			}
+			if (cfg_use_cmsg_opt_id) {
+				cmsg = cmsg ? CMSG_NXTHDR(&msg, cmsg) : CMSG_FIRSTHDR(&msg);
+				cmsg->cmsg_level = SOL_SOCKET;
+				cmsg->cmsg_type = SCM_TS_OPT_ID;
+				cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
+
+				*((uint32_t *)CMSG_DATA(cmsg)) = ts_opt_id;
+				saved_tskey = ts_opt_id;
+			}
 
-			*((uint32_t *) CMSG_DATA(cmsg)) = report_opt;
 		}
 
 		val = sendmsg(fd, &msg, 0);
@@ -681,6 +702,7 @@ static void __attribute__((noreturn)) usage(const char *filepath)
 			"  -L    listen on hostname and port\n"
 			"  -n:   set no-payload option\n"
 			"  -N:   print timestamps and durations in nsec (instead of usec)\n"
+			"  -o N: use SCM_TS_OPT_ID control message to provide N as tskey\n"
 			"  -p N: connect to port N\n"
 			"  -P:   use PF_PACKET\n"
 			"  -r:   use raw\n"
@@ -701,7 +723,7 @@ static void parse_opt(int argc, char **argv)
 	int c;
 
 	while ((c = getopt(argc, argv,
-				"46bc:CeEFhIl:LnNp:PrRS:t:uv:V:x")) != -1) {
+				"46bc:CeEFhIl:LnNo:p:PrRS:t:uv:V:x")) != -1) {
 		switch (c) {
 		case '4':
 			do_ipv6 = 0;
@@ -742,6 +764,10 @@ static void parse_opt(int argc, char **argv)
 		case 'N':
 			cfg_print_nsec = true;
 			break;
+		case 'o':
+			ts_opt_id = strtoul(optarg, NULL, 10);
+			cfg_use_cmsg_opt_id = true;
+			break;
 		case 'p':
 			dest_port = strtoul(optarg, NULL, 10);
 			break;
@@ -799,6 +825,8 @@ static void parse_opt(int argc, char **argv)
 		error(1, 0, "cannot ask for pktinfo over pf_packet");
 	if (cfg_busy_poll && cfg_use_epoll)
 		error(1, 0, "pass epoll or busy_poll, not both");
+	if (cfg_proto == SOCK_STREAM && cfg_use_cmsg_opt_id)
+		error(1, 0, "TCP sockets don't support SCM_TS_OPT_ID");
 
 	if (optind != argc - 1)
 		error(1, 0, "missing required hostname argument");
diff --git a/tools/testing/selftests/net/txtimestamp.sh b/tools/testing/selftests/net/txtimestamp.sh
index 25baca4b148e..fe4649bb8786 100755
--- a/tools/testing/selftests/net/txtimestamp.sh
+++ b/tools/testing/selftests/net/txtimestamp.sh
@@ -37,11 +37,13 @@ run_test_v4v6() {
 run_test_tcpudpraw() {
 	local -r args=$@
 
-	run_test_v4v6 ${args}		# tcp
-	run_test_v4v6 ${args} -u	# udp
-	run_test_v4v6 ${args} -r	# raw
-	run_test_v4v6 ${args} -R	# raw (IPPROTO_RAW)
-	run_test_v4v6 ${args} -P	# pf_packet
+	run_test_v4v6 ${args}		  # tcp
+	run_test_v4v6 ${args} -u	  # udp
+	run_test_v4v6 ${args} -u -o 42	  # udp with fixed tskey
+	run_test_v4v6 ${args} -r	  # raw
+	run_test_v4v6 ${args} -r -o 42	  # raw
+	run_test_v4v6 ${args} -R	  # raw (IPPROTO_RAW)
+	run_test_v4v6 ${args} -P	  # pf_packet
 }
 
 run_test_all() {
-- 
2.43.5


