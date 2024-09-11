Return-Path: <netdev+bounces-127292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E10A974E43
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26111F25A9C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B014717C7CA;
	Wed, 11 Sep 2024 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Bwm6rY/x"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0517E8EA
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046042; cv=none; b=XuiKh0CvXAvkrAEvFEOMIbZFPEwF43nqfsxaCQxCzbB5k0x3IL6CV0xQH1wWPnhdqFLjVqt30aupNXX/ky2Skl5SCFdiAic8U42H4L73OMfCWar3sauhU6AV9N7lsZO9ubHfZw5etkWnzN18JFuCdXhlsx6MoTm8FW50etm8/gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046042; c=relaxed/simple;
	bh=YDwaWUAbkmap2GF4/sQXZDU1oxmzAxgjzqggD9Yyw3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHB3J+El8P9A7SKSahlmHRGF3b+q4kNXGEzrxpx9LXRLtGPYiOIYxft7FRoTTVTvLHjCWGHraGCtNX9RtP2s29vFOvdCx/aTWGs4y7CSf/LCEGbOf71w2ydLa8jIdU1EeviBymbI5MxyJUv5zoUt7hqvdc4rJwmqnoSEXDOI+M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Bwm6rY/x; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 48B6PgL6011391;
	Wed, 11 Sep 2024 02:13:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=3EkngEYNZGZAOssLAttCy2MgOyfhoZFiMl/mDaX4HGQ=; b=
	Bwm6rY/xOeGPMNXYZkr3/jx/+Gx+Wgeq81AjB1yy99ET3Ni5BL6beKgA0c9PUsOn
	Y/fXv8bzggH9TeuBSEBtQkyk5qfhdYoem0VB7s0kDNuPmtNAyymr4llPR+gtFKve
	5kcWKqF4gcZ5jmoStFlVpTmAUFQKzEOZ2F1WU34QuJdsSaIhj992zn0bTor0GMVU
	RzY+Nbvauyi6RHk3+XeifLoDhZwINugJ28lHqoGke+2s1azNUzBFx/Q8XdAdnYe9
	JyL/DjAz77qUFxulxDywwvU0ua3YJuKOZj+wSCFt6ojXPv9ppXoniNGbhCpKLBEr
	3gbRDrliJuSlPUX0GfrfKA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41k44nh3cb-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 11 Sep 2024 02:13:51 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Wed, 11 Sep 2024 09:13:48 +0000
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
Subject: [PATCH net-next v5 3/3] selftests: txtimestamp: add SCM_TS_OPT_ID test
Date: Wed, 11 Sep 2024 02:13:33 -0700
Message-ID: <20240911091333.1870071-4-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240911091333.1870071-1-vadfed@meta.com>
References: <20240911091333.1870071-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KA6QgL8JOKDVaOUi_iuPF2fpFttUzVdK
X-Proofpoint-GUID: KA6QgL8JOKDVaOUi_iuPF2fpFttUzVdK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01

Extend txtimestamp test to run with fixed tskey using
SCM_TS_OPT_ID control message for all types of sockets.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 tools/include/uapi/asm-generic/socket.h    |  2 +
 tools/testing/selftests/net/txtimestamp.c  | 44 +++++++++++++++++-----
 tools/testing/selftests/net/txtimestamp.sh | 12 +++---
 3 files changed, 43 insertions(+), 15 deletions(-)

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
index d626f22f9550..dae91eb97d69 100644
--- a/tools/testing/selftests/net/txtimestamp.c
+++ b/tools/testing/selftests/net/txtimestamp.c
@@ -77,6 +77,8 @@ static bool cfg_epollet;
 static bool cfg_do_listen;
 static uint16_t dest_port = 9000;
 static bool cfg_print_nsec;
+static uint32_t ts_opt_id;
+static bool cfg_use_cmsg_opt_id;
 
 static struct sockaddr_in daddr;
 static struct sockaddr_in6 daddr6;
@@ -136,12 +138,13 @@ static void validate_key(int tskey, int tstype)
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
@@ -484,7 +487,7 @@ static void fill_header_udp(void *p, bool is_ipv4)
 
 static void do_test(int family, unsigned int report_opt)
 {
-	char control[CMSG_SPACE(sizeof(uint32_t))];
+	char control[2 * CMSG_SPACE(sizeof(uint32_t))];
 	struct sockaddr_ll laddr;
 	unsigned int sock_opt;
 	struct cmsghdr *cmsg;
@@ -624,18 +627,32 @@ static void do_test(int family, unsigned int report_opt)
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
@@ -685,6 +702,7 @@ static void __attribute__((noreturn)) usage(const char *filepath)
 			"  -L    listen on hostname and port\n"
 			"  -n:   set no-payload option\n"
 			"  -N:   print timestamps and durations in nsec (instead of usec)\n"
+			"  -o N: use SCM_TS_OPT_ID control message to provide N as tskey\n"
 			"  -p N: connect to port N\n"
 			"  -P:   use PF_PACKET\n"
 			"  -r:   use raw\n"
@@ -705,7 +723,7 @@ static void parse_opt(int argc, char **argv)
 	int c;
 
 	while ((c = getopt(argc, argv,
-				"46bc:CeEFhIl:LnNp:PrRS:t:uv:V:x")) != -1) {
+				"46bc:CeEFhIl:LnNo:p:PrRS:t:uv:V:x")) != -1) {
 		switch (c) {
 		case '4':
 			do_ipv6 = 0;
@@ -746,6 +764,10 @@ static void parse_opt(int argc, char **argv)
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
@@ -803,6 +825,8 @@ static void parse_opt(int argc, char **argv)
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


