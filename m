Return-Path: <netdev+bounces-98775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516088D26FE
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54B31F26A1A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E7B17BB35;
	Tue, 28 May 2024 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Wx50qeGS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D417BB1B
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716931297; cv=none; b=Pwc3tI/NASDobhS1ouNTThRFyj17LCfKs7ldFfMbN2vWpV61oSkfzEGizbb+7a0svsS5/myF4pzQF98GKQjQ+dBnSoXdiQr2hN0WBZeQDS0u9hVBP5Wt0WnHCQEQBN+Lq3A6Y4Pt2wc26npIRslhTUZQxcdzzKg5jwRbjEjRCWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716931297; c=relaxed/simple;
	bh=4yfs2Nl8yUORfU9xJ0tw5I5G5B1ggqQ/R8KCWZZrVlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSIZKei8terse/S7oTOWEZfvbUREfY/Z9onSLbJoH9Vk0I+hxlIk5Vl3PVuDx1Ev6nDesfEhpscwbJIOJABWF+3M6PWpQOTl7avLQrbd8lfF2oBOQWcomN2N/i9fUS6J1hHGWtiJqaFd9tkqBwtI1UJhLsLhlRI7fgJpOQ2NnTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Wx50qeGS; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-794ac6b5409so92694385a.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1716931294; x=1717536094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSMjgtZl0FFUIBNXq0ZFWaWaR2txjAdQiVKI/+fWLPg=;
        b=Wx50qeGSv+eOcyPj2xfXe98fJzdu1YTFCRodHb3w8V+Aw22P1U45alxc7oHTjTw4Hd
         Yp6vgeYzllRaVG/nGmHktBqEeFTJI0ALd5W3vC0THddh6kvzfW/iUEJ/PxIIrTXDfVyk
         Z/ufJ8bJ4/uhwh1qcFpzRIs1clQ11sx89up953BCZNcw6TktC5AldRCQ9gkn/pEcRwNL
         +rCUVz6MqTrGre0Ul98WY+irbwQZ8vmn0XUYlGk6Gshw1VVXJvLkKMOfmgE4X4mVDX1n
         zu2gty6BrtmPyFDQi/GIg8Ss2QHoGfnmcqBbwGDQQV1WXlB5vlQO562uN3Bzx4IOZp7r
         Xxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716931294; x=1717536094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSMjgtZl0FFUIBNXq0ZFWaWaR2txjAdQiVKI/+fWLPg=;
        b=Cdq6Beoyc2vpWI86MunlaOZoP5Ra1ayPBwUPoKnISSIdctm7tz+Bg7DZgo0v33EIOX
         rBrRFYt7VLwhtKynS1bjVfgUQw4I7uBGJgIs+51B9VaONfA5goqVLSUIiRFHTUzXaPcs
         WG0Mfy8M3dKG7SYZ7j9Q3jbMGNW3PluE3jhpLNdlYfaeJCgjsEP2yPFGkwHt00bf53iL
         /CEF/bb50m8pmy1JydkW4TyGOCsQnsK0DWWVHDdBqedalJaixyXf20Jp/3eTHtLhyUaC
         R1Mx6CpbqjAj8/d5oi7Rtqlxb9e9Bt1UclXzyigKAzZduVxvNd2CQjIoHKXsXKG4U7T2
         jF4A==
X-Gm-Message-State: AOJu0YyTVqfW5DwRlGkqVi1921xNoWhEnLG6/YUj16/WhhqNXGb4DvaF
	7sKyyKQCT0Uij0lZsBY1x8p5HLDZ24ZG465+h4mBSg8K7K0S8dvio/uOLWe6/glojV7YRh3XODO
	x
X-Google-Smtp-Source: AGHT+IGbFoZhlTejNleaf21Bysjq2W7a0ohmqOpKz+oBjEul5otHV078TPRR9bKB6fQuE2Ly5X+ebA==
X-Received: by 2002:a05:620a:470a:b0:793:3bb:322b with SMTP id af79cd13be357-794ab0f4385mr1818320985a.62.1716931294047;
        Tue, 28 May 2024 14:21:34 -0700 (PDT)
Received: from n191-036-066.byted.org ([147.160.184.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca80a7sm412619485a.17.2024.05.28.14.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 14:21:33 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v4 3/3] selftests: add MSG_ZEROCOPY msg_control notification test
Date: Tue, 28 May 2024 21:21:03 +0000
Message-Id: <20240528212103.350767-4-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240528212103.350767-1-zijianzhang@bytedance.com>
References: <20240528212103.350767-1-zijianzhang@bytedance.com>
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
cfg_notification_limit = 1, in this case MSG_ZEROCOPY approximately
aligns with the semantics of MSG_ZEROCOPY_UARG. In this case, the new
flag has around 13% cpu savings in TCP and 18% cpu savings in UDP.
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
 tools/testing/selftests/net/msg_zerocopy.c  | 103 ++++++++++++++++++--
 tools/testing/selftests/net/msg_zerocopy.sh |   1 +
 2 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index ba6c257f689c..48750a7a162c 100644
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
@@ -74,6 +79,13 @@
 #define MSG_ZEROCOPY	0x4000000
 #endif
 
+#define ZC_MSGERR_NOTIFICATION 1
+#define ZC_MSGCTL_NOTIFICATION 2
+
+#define SOCK_ZC_INFO_NUM 8
+
+#define INVALID_ZEROCOPY_VAL 2
+
 static int  cfg_cork;
 static bool cfg_cork_mixed;
 static int  cfg_cpu		= -1;		/* default: pin to last cpu */
@@ -86,13 +98,16 @@ static int  cfg_runtime_ms	= 4200;
 static int  cfg_verbose;
 static int  cfg_waittime_ms	= 500;
 static int  cfg_notification_limit = 32;
-static bool cfg_zerocopy;
+static int  cfg_zerocopy;           /* Either 1 or 2, mode for SO_ZEROCOPY */
 
 static socklen_t cfg_alen;
 static struct sockaddr_storage cfg_dst_addr;
 static struct sockaddr_storage cfg_src_addr;
 
 static char payload[IP_MAXPACKET];
+static struct zc_info_elem zc_info[SOCK_ZC_INFO_NUM];
+static char zc_ckbuf[CMSG_SPACE(sizeof(void *))];
+static struct zc_info_elem *zc_info_ptr = zc_info;
 static long packets, bytes, completions, expected_completions;
 static int  zerocopied = -1;
 static uint32_t next_completion;
@@ -170,6 +185,26 @@ static int do_accept(int fd)
 	return fd;
 }
 
+static void add_zcopy_info(struct msghdr *msg)
+{
+	int i;
+	struct cmsghdr *cm;
+
+	if (!msg->msg_control)
+		error(1, errno, "NULL user arg");
+	cm = (void *)msg->msg_control;
+	/* Although only the address of the array will be written into the
+	 * zc_ckbuf, we assign cmsg_len to CMSG_LEN(sizeof(zc_info)) to specify
+	 * the length of the array.
+	 */
+	cm->cmsg_len = CMSG_LEN(sizeof(zc_info));
+	cm->cmsg_level = SOL_SOCKET;
+	cm->cmsg_type = SCM_ZC_NOTIFICATION;
+	memcpy(CMSG_DATA(cm), &zc_info_ptr, sizeof(zc_info_ptr));
+	for (i = 0; i < SOCK_ZC_INFO_NUM; i++)
+		zc_info[i].zerocopy = INVALID_ZEROCOPY_VAL;
+}
+
 static void add_zcopy_cookie(struct msghdr *msg, uint32_t cookie)
 {
 	struct cmsghdr *cm;
@@ -183,7 +218,7 @@ static void add_zcopy_cookie(struct msghdr *msg, uint32_t cookie)
 	memcpy(CMSG_DATA(cm), &cookie, sizeof(cookie));
 }
 
-static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
+static bool do_sendmsg(int fd, struct msghdr *msg, int do_zerocopy, int domain)
 {
 	int ret, len, i, flags;
 	static uint32_t cookie;
@@ -201,6 +236,15 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 			msg->msg_controllen = CMSG_SPACE(sizeof(cookie));
 			msg->msg_control = (struct cmsghdr *)ckbuf;
 			add_zcopy_cookie(msg, ++cookie);
+		} else if (do_zerocopy == ZC_MSGCTL_NOTIFICATION) {
+			memset(&msg->msg_control, 0, sizeof(msg->msg_control));
+			/* Although only the address of the array will be written into the
+			 * zc_ckbuf, msg_controllen must be larger or equal than any cmsg_len
+			 * in it. Otherwise, we will get -EINVAL.
+			 */
+			msg->msg_controllen = CMSG_SPACE(sizeof(zc_info));
+			msg->msg_control = (struct cmsghdr *)zc_ckbuf;
+			add_zcopy_info(msg);
 		}
 	}
 
@@ -219,7 +263,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 		if (do_zerocopy && ret)
 			expected_completions++;
 	}
-	if (do_zerocopy && domain == PF_RDS) {
+	if (msg->msg_control) {
 		msg->msg_control = NULL;
 		msg->msg_controllen = 0;
 	}
@@ -393,6 +437,42 @@ static bool do_recvmsg_completion(int fd)
 	return ret;
 }
 
+static void do_recv_completions2(void)
+{
+	int i;
+	__u32 hi, lo, range;
+	__u8 zerocopy;
+
+	for (i = 0; zc_info[i].zerocopy != INVALID_ZEROCOPY_VAL; i++) {
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
+	sendmsg_counter -= i;
+}
+
 static bool do_recv_completion(int fd, int domain)
 {
 	struct sock_extended_err *serr;
@@ -554,11 +634,15 @@ static void do_tx(int domain, int type, int protocol)
 		else
 			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
 
-		if (cfg_zerocopy && sendmsg_counter >= cfg_notification_limit)
+		if (cfg_zerocopy == ZC_MSGERR_NOTIFICATION &&
+			sendmsg_counter >= cfg_notification_limit)
 			do_recv_completions(fd, domain);
 
+		if (cfg_zerocopy == ZC_MSGCTL_NOTIFICATION)
+			do_recv_completions2();
+
 		while (!do_poll(fd, POLLOUT)) {
-			if (cfg_zerocopy)
+			if (cfg_zerocopy == ZC_MSGERR_NOTIFICATION)
 				do_recv_completions(fd, domain);
 		}
 
@@ -716,7 +800,7 @@ static void parse_opts(int argc, char **argv)
 
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
+	while ((c = getopt(argc, argv, "46c:C:D:i:l:mnp:rs:S:t:vz")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -750,6 +834,9 @@ static void parse_opts(int argc, char **argv)
 		case 'm':
 			cfg_cork_mixed = true;
 			break;
+		case 'n':
+			cfg_zerocopy = ZC_MSGCTL_NOTIFICATION;
+			break;
 		case 'p':
 			cfg_port = strtoul(optarg, NULL, 0);
 			break;
@@ -769,7 +856,7 @@ static void parse_opts(int argc, char **argv)
 			cfg_verbose++;
 			break;
 		case 'z':
-			cfg_zerocopy = true;
+			cfg_zerocopy = ZC_MSGERR_NOTIFICATION;
 			break;
 		}
 	}
@@ -780,6 +867,8 @@ static void parse_opts(int argc, char **argv)
 			error(1, 0, "-D <server addr> required for PF_RDS\n");
 		if (!cfg_rx && !saddr)
 			error(1, 0, "-S <client addr> required for PF_RDS\n");
+		if (cfg_zerocopy == ZC_MSGCTL_NOTIFICATION)
+			error(1, 0, "PF_RDS does not support ZC_MSGCTL_NOTIFICATION");
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


