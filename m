Return-Path: <netdev+bounces-124209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF9696887E
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 15:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FF03B20B8F
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438B919C57E;
	Mon,  2 Sep 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IbCZwII/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F493BBC1
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282607; cv=none; b=LL6ZEPvJ+CQod00dNAc0XhZVSHzKUmLB4AMUaiA3dICbjnqLf1Kkh7xZFjuQ1umzf/Jd5JhlEYR5HncIYmC9JCv95M6usLJ8Co78VyNLPTFPobn9nNvjk2SopGC7JtqIljXsQQmuORhU1+AIQrxiMn0iiV6xuk4BRRxLfCZ2XKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282607; c=relaxed/simple;
	bh=HFMSdd86BElmJ1jNg1Bxcn7OU7oz5IQMDOcpsHLH4I0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUW6RUm9LRENBixYIOQUbvC4sxS4jpjEQnhQQvCpF4/wuni3031tGAzyB+YhiZ6mYOD21Mfm8XarLg6FIJkbakc7iDkhzSJBMSKdqLods3LWVCDHFmxzb+bYiJ1vytRn+YLvi4N0bcAbu4seU33fbB51UKzZvP5dS/EFiQe09J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IbCZwII/; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 481MTY6M031381;
	Mon, 2 Sep 2024 06:09:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=gToPklOLtePqEPEN840IrD9IixDyBtn76eylcaWdNEQ=; b=
	IbCZwII/JEtNFK7T5GI82RpKV0suLChIMunAahzoWsPKDqGwZoxtoZQMYxfxie7B
	g21LdWTlw4hN5FFB557UhBFT7Jx5LJ+VKXBU8Tsno3g0xqUo4a5Fslnfv3dVjkSo
	Fds01pq2gdLeKyzpQpvyf9Ihljch5/7oKIlFsOHQwzJ+/bR0GoVIJUliM5eGwSFG
	ymHLj/Lb00GhFparuVFL1fEOeqPe+eyPZuKUSDe7G7vDjdiQR20KNmD20cI0QAyN
	kerleKYKvrUwGluGY9zYrKvRejugWS04FQqGC5QKHn3IEgdHqSEC4LcduvSUC0dM
	Dz5X6ns5l85Chyz332eaCg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41by7j0t7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 02 Sep 2024 06:09:49 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 2 Sep 2024 13:09:47 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Willem de Bruijn
	<willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Jason Xing
	<kerneljasonxing@gmail.com>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v2 2/2] selftests: txtimestamp: add SCM_TS_OPT_ID test
Date: Mon, 2 Sep 2024 06:09:36 -0700
Message-ID: <20240902130937.457115-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240902130937.457115-1-vadfed@meta.com>
References: <20240902130937.457115-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3qvFAN7U61dWOXIdgqWX_tg59cuK8mMk
X-Proofpoint-ORIG-GUID: 3qvFAN7U61dWOXIdgqWX_tg59cuK8mMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_03,2024-09-02_01,2024-09-02_01

Extend txtimestamp udp test to run with fixed tskey using
SCM_TS_OPT_ID control message.

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
index ec60a16c9307..3a8f716e72ae 100644
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
+	if (cfg_proto != SOCK_DGRAM && cfg_use_cmsg_opt_id)
+		error(1, 0, "control message TS_OPT_ID can only be used with udp socket");
 
 	if (optind != argc - 1)
 		error(1, 0, "missing required hostname argument");
diff --git a/tools/testing/selftests/net/txtimestamp.sh b/tools/testing/selftests/net/txtimestamp.sh
index 25baca4b148e..6cc2b1b480e0 100755
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
+	run_test_v4v6 ${args}		 # tcp
+	run_test_v4v6 ${args} -u	 # udp
+	run_test_v4v6 ${args} -u -o 5	 # udp with fixed tskey
+	run_test_v4v6 ${args} -u -o 5 -C # udp with fixed tskey and cmsg control
+	run_test_v4v6 ${args} -r	 # raw
+	run_test_v4v6 ${args} -R	 # raw (IPPROTO_RAW)
+	run_test_v4v6 ${args} -P	 # pf_packet
 }
 
 run_test_all() {
-- 
2.43.5


