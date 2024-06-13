Return-Path: <netdev+bounces-103423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 683B8907F6D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 01:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01992820C8
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 23:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1F4156F27;
	Thu, 13 Jun 2024 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Nbxk1FHj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234E1156668
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 23:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321507; cv=none; b=uMdKQwFjo5/VfI2RDcYmyiWnl2IIepp1cYx+GbzYyFCz6pFAYyZ3tKA+BPnSoz7XZDSdNMLaLkDN2acYMSi3zUxNKNBJ45byE/MkNXC8R0yrRCoEVTZ2pvm5ECv6oGfILr/odIaN3htbXeefG5w9Y3pNF6r6ihCGRQdD6QDrfjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321507; c=relaxed/simple;
	bh=l759AUoZn+Lkd8NE19BHlW8jwuV/0b0Hmv2kt2g0v6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AuEDQ4jMgCQMPtVvb1mMvX6DL1cSttdzdwPoWUIMF19eCGaHr8RAnhWZ56OtN+3UFYSPYTL40kXmb9mgJ9/X+184yGSv2i3k1i4ztpTdimrJjr//pZesJ9nE85Zl2udgInS3HutnTlh7uqL8hgVe5dvwsT31hXm8KZuIaMFO+/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Nbxk1FHj; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c9cc681e4fso742630b6e.0
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 16:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718321503; x=1718926303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xJmOuJxFnxzNhLDPuw3aSaK2S5jGXnhr5CJos9rvB4=;
        b=Nbxk1FHjX83xK3y9hBcq6UjzpuBUDFglMwBlkDdRiOYP1SDaKMDgGM1NA8suzIkzro
         gO0EFPPgHXRaXSKUWBtewCAmTrht1Oym2ybR8ImlqjoVoxfA3b0aqaeOkwRjQHx5zf9o
         ci9Nzr/OlaV86H0mzP4+eBIK/FWOYkF7THexZQZ6Krg0x6vBU/UKTiN6N+3Q/U56FIbI
         2srczLZZTdH5Y3yYiyTjnOztlKKRUNa2kfK0GXepkXaEaxNVn4jZ4/1RftvNrLzZezS4
         eFXn3l2e9ZBfhPAtdMXXrS3dUSPJ8IK19x4W5+ExgPGpQ8ZRkEs48n3Rosts7ckuWSLp
         PPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321503; x=1718926303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xJmOuJxFnxzNhLDPuw3aSaK2S5jGXnhr5CJos9rvB4=;
        b=LQGkm65G7E7uyBstCxlQ9ioB0GIJRqMFRX4jUeWTQwINSRgLMtcJG3oLJ2H4AcvnNV
         9T/b9NpELKJPJ7yyrGx1+LB5NqtkLlLW8mFxDdyixjHV69HBp8UhhvDFdZxIlGzQS/ac
         s9Ch8vbvgwLaR+QEmO80T3i7v5EkpesdXB6WXz6gId1LYWMZS5Elh09g8pL1nvCUV5nF
         iCGKF8JJ1dXlrVQmzI28u45oEbvMSUYQ7k8PNSXaYcF8hEgv9usW2gK6N8NPwU9oM6Tv
         H7vHHcbvHxPbl6QEA5PPPQNpauxALuxTtqjgAROjgBRH0FFrS7nRoNJ8ItJ0R8EZYRyt
         zZyQ==
X-Gm-Message-State: AOJu0YzDt9ogSd004DwrXMrArUCyFAvcbUgoCVJpqK5yshupt6lEnWRI
	OM8ufIMzd8fIt3bdr9FZYwF+Nj6A++6r8Ovtlmzjwm2NwSEw/8CFSeaLAm816f66/LxvcKQKxLY
	47Ms=
X-Google-Smtp-Source: AGHT+IETgikJHQVfvmW3cFSO8NWheg/2pj6QojSAq7ARV/z9a3BESLBWb9SHAYdIKxCJYnno1RavJg==
X-Received: by 2002:a05:6808:1884:b0:3d2:1b8a:be4b with SMTP id 5614622812f47-3d24e980c71mr1275046b6e.46.1718321503274;
        Thu, 13 Jun 2024 16:31:43 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef3d8b62sm10586731cf.11.2024.06.13.16.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 16:31:42 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v5 4/4] selftests: add MSG_ZEROCOPY msg_control notification test
Date: Thu, 13 Jun 2024 23:31:33 +0000
Message-Id: <20240613233133.2463193-5-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240613233133.2463193-1-zijianzhang@bytedance.com>
References: <20240613233133.2463193-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

We update selftests/net/msg_zerocopy.c to accommodate the new mechanism.

Test result from selftests/net/msg_zerocopy.c,
cfg_notification_limit = 1, in this case the original method approximately
aligns with the semantics of new one. In this case, the new flag has
around 13% cpu savings in TCP and 18% cpu savings in UDP.
+---------------------+---------+---------+---------+---------+
| Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
+---------------------+---------+---------+---------+---------+
| ZCopy (MB)          | 5147    | 4885    | 7489    | 7854    |
+---------------------+---------+---------+---------+---------+
| New ZCopy (MB)      | 5859    | 5505    | 9053    | 9236    |
+---------------------+---------+---------+---------+---------+
| New ZCopy / ZCopy   | 113.83% | 112.69% | 120.88% | 117.59% |
+---------------------+---------+---------+---------+---------+

cfg_notification_limit = 32, it means less poll + recvmsg overhead,
the new mechanism performs 8% better in TCP. For UDP, no obvious
performance gain is observed and sometimes may lead to degradation.
Thus, if users don't need to retrieve the notification ASAP in UDP,
the original mechanism is preferred.
+---------------------+---------+---------+---------+---------+
| Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
+---------------------+---------+---------+---------+---------+
| ZCopy (MB)          | 6272    | 6138    | 12138   | 10055   |
+---------------------+---------+---------+---------+---------+
| New ZCopy (MB)      | 6774    | 6620    | 11504   | 10355   |
+---------------------+---------+---------+---------+---------+
| New ZCopy / ZCopy   | 108.00% | 107.85% | 94.78%  | 102.98% |
+---------------------+---------+---------+---------+---------+

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 tools/testing/selftests/net/msg_zerocopy.c  | 109 ++++++++++++++++++--
 tools/testing/selftests/net/msg_zerocopy.sh |   1 +
 2 files changed, 102 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index 7ea5fb28c93d..b8a1002aa6ae 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Evaluate MSG_ZEROCOPY
  *
  * Send traffic between two processes over one of the supported
@@ -66,6 +67,10 @@
 #define SO_ZEROCOPY	60
 #endif
 
+#ifndef SCM_ZC_NOTIFICATION
+#define SCM_ZC_NOTIFICATION	78
+#endif
+
 #ifndef SO_EE_CODE_ZEROCOPY_COPIED
 #define SO_EE_CODE_ZEROCOPY_COPIED	1
 #endif
@@ -74,6 +79,15 @@
 #define MSG_ZEROCOPY	0x4000000
 #endif
 
+enum notification_type {
+	MSG_ZEROCOPY_NOTIFY_ERRQUEUE = 1,
+	MSG_ZEROCOPY_NOTIFY_SENDMSG = 2,
+};
+
+#define INVALID_ZEROCOPY_VAL 2
+
+#define ZC_NOTIF_ARR_SZ (sizeof(struct zc_info_elem) * SOCK_ZC_INFO_MAX)
+
 static int  cfg_cork;
 static bool cfg_cork_mixed;
 static int  cfg_cpu		= -1;		/* default: pin to last cpu */
@@ -85,14 +99,16 @@ static bool cfg_rx;
 static int  cfg_runtime_ms	= 4200;
 static int  cfg_verbose;
 static int  cfg_waittime_ms	= 500;
-static int  cfg_notification_limit = 32;
-static bool cfg_zerocopy;
+static int  cfg_notification_limit = 16;
+static enum notification_type cfg_zerocopy;
 
 static socklen_t cfg_alen;
 static struct sockaddr_storage cfg_dst_addr;
 static struct sockaddr_storage cfg_src_addr;
 
 static char payload[IP_MAXPACKET];
+static char zc_ckbuf[CMSG_SPACE(ZC_NOTIF_ARR_SZ)];
+static bool added_zcopy_info;
 static long packets, bytes, completions, expected_completions;
 static int  zerocopied = -1;
 static uint32_t next_completion;
@@ -169,6 +185,25 @@ static int do_accept(int fd)
 	return fd;
 }
 
+static void add_zcopy_info(struct msghdr *msg)
+{
+	int i;
+	struct cmsghdr *cm;
+	struct zc_info_elem *zc_info;
+
+	if (!msg->msg_control)
+		error(1, errno, "NULL user arg");
+	cm = (struct cmsghdr *)msg->msg_control;
+	zc_info = (struct zc_info_elem *)CMSG_DATA(cm);
+
+	cm->cmsg_len = CMSG_LEN(ZC_NOTIF_ARR_SZ);
+	cm->cmsg_level = SOL_SOCKET;
+	cm->cmsg_type = SCM_ZC_NOTIFICATION;
+	for (i = 0; i < SOCK_ZC_INFO_MAX; i++)
+		zc_info[i].zerocopy = INVALID_ZEROCOPY_VAL;
+	added_zcopy_info = true;
+}
+
 static void add_zcopy_cookie(struct msghdr *msg, uint32_t cookie)
 {
 	struct cmsghdr *cm;
@@ -182,7 +217,8 @@ static void add_zcopy_cookie(struct msghdr *msg, uint32_t cookie)
 	memcpy(CMSG_DATA(cm), &cookie, sizeof(cookie));
 }
 
-static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
+static bool do_sendmsg(int fd, struct msghdr *msg,
+			   enum notification_type do_zerocopy, int domain)
 {
 	int ret, len, i, flags;
 	static uint32_t cookie;
@@ -200,6 +236,12 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 			msg->msg_controllen = CMSG_SPACE(sizeof(cookie));
 			msg->msg_control = (struct cmsghdr *)ckbuf;
 			add_zcopy_cookie(msg, ++cookie);
+		} else if (do_zerocopy == MSG_ZEROCOPY_NOTIFY_SENDMSG &&
+			   sends_since_notify >= cfg_notification_limit) {
+			memset(&msg->msg_control, 0, sizeof(msg->msg_control));
+			msg->msg_controllen = sizeof(zc_ckbuf);
+			msg->msg_control = (struct cmsghdr *)zc_ckbuf;
+			add_zcopy_info(msg);
 		}
 	}
 
@@ -218,7 +260,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 		if (do_zerocopy && ret)
 			expected_completions++;
 	}
-	if (do_zerocopy && domain == PF_RDS) {
+	if (msg->msg_control) {
 		msg->msg_control = NULL;
 		msg->msg_controllen = 0;
 	}
@@ -392,6 +434,48 @@ static bool do_recvmsg_completion(int fd)
 	return ret;
 }
 
+static void do_recv_completions2(void)
+{
+	int i;
+	__u32 hi, lo, range;
+	__u8 zerocopy;
+	struct cmsghdr *cm = (struct cmsghdr *)zc_ckbuf;
+	struct zc_info_elem *zc_info = (struct zc_info_elem *)CMSG_DATA(cm);
+
+	if (!added_zcopy_info)
+		return;
+
+	added_zcopy_info = false;
+	for (i = 0; i < SOCK_ZC_INFO_MAX && zc_info[i].zerocopy != INVALID_ZEROCOPY_VAL; i++) {
+		struct zc_info_elem elem = zc_info[i];
+
+		hi = elem.hi;
+		lo = elem.lo;
+		zerocopy = elem.zerocopy;
+		range = hi - lo + 1;
+
+		if (cfg_verbose && lo != next_completion)
+			fprintf(stderr, "gap: %u..%u does not append to %u\n",
+				lo, hi, next_completion);
+		next_completion = hi + 1;
+
+		if (zerocopied == -1)
+			zerocopied = zerocopy;
+		else if (zerocopied != zerocopy) {
+			fprintf(stderr, "serr: inconsistent\n");
+			zerocopied = zerocopy;
+		}
+
+		completions += range;
+
+		if (cfg_verbose >= 2)
+			fprintf(stderr, "completed: %u (h=%u l=%u)\n",
+				range, hi, lo);
+	}
+
+	sends_since_notify -= i;
+}
+
 static bool do_recv_completion(int fd, int domain)
 {
 	struct sock_extended_err *serr;
@@ -553,11 +637,15 @@ static void do_tx(int domain, int type, int protocol)
 		else
 			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
 
-		if (cfg_zerocopy && sends_since_notify >= cfg_notification_limit)
+		if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_ERRQUEUE &&
+			sends_since_notify >= cfg_notification_limit)
 			do_recv_completions(fd, domain);
 
+		if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_SENDMSG)
+			do_recv_completions2();
+
 		while (!do_poll(fd, POLLOUT)) {
-			if (cfg_zerocopy)
+			if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_ERRQUEUE)
 				do_recv_completions(fd, domain);
 		}
 
@@ -715,7 +803,7 @@ static void parse_opts(int argc, char **argv)
 
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
+	while ((c = getopt(argc, argv, "46c:C:D:i:l:mnp:rs:S:t:vz")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -749,6 +837,9 @@ static void parse_opts(int argc, char **argv)
 		case 'm':
 			cfg_cork_mixed = true;
 			break;
+		case 'n':
+			cfg_zerocopy = MSG_ZEROCOPY_NOTIFY_SENDMSG;
+			break;
 		case 'p':
 			cfg_port = strtoul(optarg, NULL, 0);
 			break;
@@ -768,7 +859,7 @@ static void parse_opts(int argc, char **argv)
 			cfg_verbose++;
 			break;
 		case 'z':
-			cfg_zerocopy = true;
+			cfg_zerocopy = MSG_ZEROCOPY_NOTIFY_ERRQUEUE;
 			break;
 		}
 	}
@@ -779,6 +870,8 @@ static void parse_opts(int argc, char **argv)
 			error(1, 0, "-D <server addr> required for PF_RDS\n");
 		if (!cfg_rx && !saddr)
 			error(1, 0, "-S <client addr> required for PF_RDS\n");
+		if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_SENDMSG)
+			error(1, 0, "PF_RDS does not support MSG_ZEROCOPY_NOTIFY_SENDMSG");
 	}
 	setup_sockaddr(cfg_family, daddr, &cfg_dst_addr);
 	setup_sockaddr(cfg_family, saddr, &cfg_src_addr);
diff --git a/tools/testing/selftests/net/msg_zerocopy.sh b/tools/testing/selftests/net/msg_zerocopy.sh
index 89c22f5320e0..022a6936d86f 100755
--- a/tools/testing/selftests/net/msg_zerocopy.sh
+++ b/tools/testing/selftests/net/msg_zerocopy.sh
@@ -118,4 +118,5 @@ do_test() {
 
 do_test "${EXTRA_ARGS}"
 do_test "-z ${EXTRA_ARGS}"
+do_test "-n ${EXTRA_ARGS}"
 echo ok
-- 
2.20.1


