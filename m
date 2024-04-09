Return-Path: <netdev+bounces-86272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 322EC89E4B4
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADAD283A4C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 20:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D59158844;
	Tue,  9 Apr 2024 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kyo1Yf0y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F87158870
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 20:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712696017; cv=none; b=jseXYsasBKbWSxzuC20yFWYnjeBbm19FDjgpb0TjZhB1UAdc4sdkZMggQyvRLc9YSlGC1qOG888u0yoaN8OO3BletRgYMZuEjUzzwKHbudlHS0sH91xvcmOxFgppdMyPTN+e4dENYwRYR1fnTDcf+/MJx6vbXbWiVp/vzZ+Wbow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712696017; c=relaxed/simple;
	bh=b8j7pEH8WZQ4sFFA/Qh7qhqe/Peh5fmJt4fc3lvu62Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BK7/VRVeow2myEC8X5ISiFxaaWWrZDfyWtuZ6nidRS9fwVjZ4j1shwz66AMcytG5YDPBRoaD05xMelst5Nj/vITa4hadEIpq8hEM/ZEdetdH3/7yquejiaY17m/lzBJjSLjzebDeSBiiK830Lhg77qzvQYN/Q85tlPos00FY5kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kyo1Yf0y; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4346520b081so21015071cf.2
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 13:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712696014; x=1713300814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxtiYh6JmiBN4qiwYT8tdey/mxkw1tAcTBtKYLoJ8IU=;
        b=kyo1Yf0ypOHxX1c/uceMHZrDLvSMKWDEQZWuPvH897C4tFuHJYUgvWvhJ0R3laafXS
         ulp5srkudw2QLPwKsx5rplEBM7fxTXj1H8LbQr/f4otbzmCVS/40O5/ZqgbxDI8MKbZ/
         y9rUmbcdDhn1ZUwBm0uOgbvsYdgQQSZpbXtB8TuBUEf5QaqgnGBSPOC7YcynZ/cojMqK
         /ENLmgsokgVcqc1zQFEUzIIupeGpqjwZBmyDAPlQVUqNqqITgViUMAp+/QNyfjhX9Tr8
         1gv5iyFSq3qsqh/2SO1unW6m+fejSOr9U1OsRVD2A2iBDCv5asXKdOxKvj4YgezCLQZX
         5xpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712696014; x=1713300814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxtiYh6JmiBN4qiwYT8tdey/mxkw1tAcTBtKYLoJ8IU=;
        b=tBO1K3UC7owZPPNERUs9UnlRsZg1uZJ5hOtCfgjw2XrIxbpa6ANL7rLE3b/BYYlh72
         6TPxTRwjtkAKE2ID1P9UpBbc7uJJig743GQwvmzLp3REpSBeASGjDCu4qcRGuZ2R0Zj/
         VxKaexsSf3NQALYEJl78i2FDPGgpUK9ymMbxPcHmvSM0gZtKF70GmMiH82PH8nZTjWcP
         PQ+ufndtOuxjn3WUizWKI4OKtLs9bXf4IBKkB130Uj9FIIgbRmNlo62zJ0JyXyZrIOCO
         kRoEhgMnuPCf+8xib1KSPurzk6v7TtXH3UV9Ld5QZEextVLGOomuWebUAroT2vbz7Uzf
         bsdg==
X-Gm-Message-State: AOJu0Yze4sNBBmy7mGXZj8Ntu49PZxYx5dAdmdbyJmDwjQagUC+QGKww
	NJmh6pmcYWqJ6ghrEMXHga5ZifXRzOdmhOLf6k8rkJcJA6tupi1ntkWY8HK0uAv/YrYaw2vyWEq
	+
X-Google-Smtp-Source: AGHT+IH/CpOYhhm32ZSxycdlQ7o8sTepW5LJ/DT8NyUvk4jDA/ZaEpGUZDiIELSbhA5/Y5yU42b/6Q==
X-Received: by 2002:a05:620a:559a:b0:78d:39f7:1d16 with SMTP id vq26-20020a05620a559a00b0078d39f71d16mr915729qkn.31.1712696014005;
        Tue, 09 Apr 2024 13:53:34 -0700 (PDT)
Received: from n191-036-066.byted.org ([147.160.184.150])
        by smtp.gmail.com with ESMTPSA id vy3-20020a05620a490300b0078d6bcfb580sm1151619qkn.10.2024.04.09.13.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 13:53:33 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next 3/3] selftests: add msg_zerocopy_uarg test
Date: Tue,  9 Apr 2024 20:53:00 +0000
Message-Id: <20240409205300.1346681-4-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240409205300.1346681-1-zijianzhang@bytedance.com>
References: <20240409205300.1346681-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

We update selftests/net/msg_zerocopy.c to accommodate the new flag.
In the original selftest, it tries to retrieve notifications when the
socket is not writable. In order to compare with the new flag, we
introduce a new config, "cfg_notification_limit", which forces the
application to recv notifications when some number of sendmsgs finishes.

Test result from selftests/net/msg_zerocopy.c,
cfg_notification_limit = 1, it's an unrealistic setting for MSG_ZEROCOPY,
and it approximately aligns with the semantics of MSG_ZEROCOPY_UARG.
In this case, the new flag has around 15% cpu savings in TCP and 28% cpu
savings in UDP. The numbers are in the unit of MB.
+---------------------+---------+---------+---------+---------+
| Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
+---------------------+---------+---------+---------+---------+
| Copy                | 5517    | 5345    | 9158    | 8767    |
+---------------------+---------+---------+---------+---------+
| ZCopy               | 5588    | 5439    | 8538    | 8169    |
+---------------------+---------+---------+---------+---------+
| New ZCopy           | 6517    | 6103    | 11000   | 10839   |
+---------------------+---------+---------+---------+---------+
| ZCopy / Copy        | 101.29% | 101.76% | 93.23%  | 93.18%  |
+---------------------+---------+---------+---------+---------+
| New ZCopy / Copy    | 118.13% | 114.18% | 120.11% | 123.63% |
+---------------------+---------+---------+---------+---------+

cfg_notification_limit = 8, it means less poll + recvmsg overhead,
the new flag performs 7% better in TCP and 4% better in UDP.
The numbers are in the unit of MB.
+---------------------+---------+---------+---------+---------+
| Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
+---------------------+---------+---------+---------+---------+
| Copy                | 5328    | 5159    | 8581    | 8457    |
+---------------------+---------+---------+---------+---------+
| ZCopy               | 5877    | 5568    | 10314   | 10091   |
+---------------------+---------+---------+---------+---------+
| New ZCopy           | 6254    | 5901    | 10674   | 10293   |
+---------------------+---------+---------+---------+---------+
| ZCopy / Copy        | 110.30% | 107.93% | 120.20% | 119.32% |
+---------------------+---------+---------+---------+---------+
| New ZCopy / Copy    | 117.38% | 114.38% | 124.39% | 121.71% |
+---------------------+---------+---------+---------+---------+

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 tools/testing/selftests/net/msg_zerocopy.c  | 132 ++++++++++++++++++--
 tools/testing/selftests/net/msg_zerocopy.sh |   1 +
 2 files changed, 122 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index 8e595216a0af..0ca5e8509032 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -1,4 +1,5 @@
-/* Evaluate MSG_ZEROCOPY
+// SPDX-License-Identifier: GPL-2.0
+/* Evaluate MSG_ZEROCOPY && MSG_ZEROCOPY_UARG
  *
  * Send traffic between two processes over one of the supported
  * protocols and modes:
@@ -66,14 +67,29 @@
 #define SO_ZEROCOPY	60
 #endif
 
+#ifndef SO_ZEROCOPY_NOTIFICATION
+#define SO_ZEROCOPY_NOTIFICATION	78
+#endif
+
 #ifndef SO_EE_CODE_ZEROCOPY_COPIED
 #define SO_EE_CODE_ZEROCOPY_COPIED	1
 #endif
 
+#ifndef MSG_ZEROCOPY_UARG
+#define MSG_ZEROCOPY_UARG	0x2000000
+#endif
+
 #ifndef MSG_ZEROCOPY
 #define MSG_ZEROCOPY	0x4000000
 #endif
 
+#ifndef SOCK_USR_ZC_INFO_MAX
+#define SOCK_USR_ZC_INFO_MAX	8
+#endif
+
+#define ZEROCOPY_MSGERR_NOTIFICATION 1
+#define ZEROCOPY_USER_ARG_NOTIFICATION 2
+
 static int  cfg_cork;
 static bool cfg_cork_mixed;
 static int  cfg_cpu		= -1;		/* default: pin to last cpu */
@@ -87,7 +103,7 @@ static int  cfg_verbose;
 static int  cfg_waittime_ms	= 500;
 static bool cfg_notification_order_check;
 static int  cfg_notification_limit = 32;
-static bool cfg_zerocopy;
+static int  cfg_zerocopy;           /* 1 for MSG_ZEROCOPY, 2 for MSG_ZEROCOPY_UARG */
 
 static socklen_t cfg_alen;
 static struct sockaddr_storage cfg_dst_addr;
@@ -169,6 +185,19 @@ static int do_accept(int fd)
 	return fd;
 }
 
+static void add_zcopy_user_arg(struct msghdr *msg, void *usr_addr)
+{
+	struct cmsghdr *cm;
+
+	if (!msg->msg_control)
+		error(1, errno, "NULL user arg");
+	cm = (void *)msg->msg_control;
+	cm->cmsg_len = CMSG_LEN(sizeof(void *));
+	cm->cmsg_level = SOL_SOCKET;
+	cm->cmsg_type = SO_ZEROCOPY_NOTIFICATION;
+	memcpy(CMSG_DATA(cm), &usr_addr, sizeof(usr_addr));
+}
+
 static void add_zcopy_cookie(struct msghdr *msg, uint32_t cookie)
 {
 	struct cmsghdr *cm;
@@ -182,18 +211,55 @@ static void add_zcopy_cookie(struct msghdr *msg, uint32_t cookie)
 	memcpy(CMSG_DATA(cm), &cookie, sizeof(cookie));
 }
 
-static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
+static void do_recv_completion_user_arg(void *p)
+{
+	int i;
+	__u32 hi, lo, range;
+	__u8 zerocopy;
+	struct tx_usr_zcopy_info *zc_info_p = (struct tx_usr_zcopy_info *)p;
+
+	for (i = 0; i < zc_info_p->length; ++i) {
+		struct tx_msg_zcopy_info elem = zc_info_p->info[i];
+
+		hi = elem.hi;
+		lo = elem.lo;
+		zerocopy = elem.zerocopy;
+		range = hi - lo + 1;
+
+		if (cfg_notification_order_check && lo != next_completion)
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
+}
+
+static bool do_sendmsg(int fd, struct msghdr *msg, int do_zerocopy, int domain)
 {
 	int ret, len, i, flags;
 	static uint32_t cookie;
-	char ckbuf[CMSG_SPACE(sizeof(cookie))];
+	/* ckbuf is used to either hold uint32_t cookie or void *pointer */
+	char ckbuf[CMSG_SPACE(sizeof(void *))];
+	struct tx_usr_zcopy_info zc_info;
 
 	len = 0;
 	for (i = 0; i < msg->msg_iovlen; i++)
 		len += msg->msg_iov[i].iov_len;
 
 	flags = MSG_DONTWAIT;
-	if (do_zerocopy) {
+	if (do_zerocopy == ZEROCOPY_MSGERR_NOTIFICATION) {
 		flags |= MSG_ZEROCOPY;
 		if (domain == PF_RDS) {
 			memset(&msg->msg_control, 0, sizeof(msg->msg_control));
@@ -201,6 +267,12 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 			msg->msg_control = (struct cmsghdr *)ckbuf;
 			add_zcopy_cookie(msg, ++cookie);
 		}
+	} else if (do_zerocopy == ZEROCOPY_USER_ARG_NOTIFICATION) {
+		flags |= MSG_ZEROCOPY_UARG;
+		memset(&zc_info, 0, sizeof(zc_info));
+		msg->msg_controllen = CMSG_SPACE(sizeof(void *));
+		msg->msg_control = (struct cmsghdr *)ckbuf;
+		add_zcopy_user_arg(msg, &zc_info);
 	}
 
 	ret = sendmsg(fd, msg, flags);
@@ -211,13 +283,16 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 	if (cfg_verbose && ret != len)
 		fprintf(stderr, "send: ret=%u != %u\n", ret, len);
 
+	if (do_zerocopy == ZEROCOPY_USER_ARG_NOTIFICATION)
+		do_recv_completion_user_arg(&zc_info);
+
 	if (len) {
 		packets++;
 		bytes += ret;
 		if (do_zerocopy && ret)
 			expected_completions++;
 	}
-	if (do_zerocopy && domain == PF_RDS) {
+	if (msg->msg_control) {
 		msg->msg_control = NULL;
 		msg->msg_controllen = 0;
 	}
@@ -480,6 +555,36 @@ static void do_recv_remaining_completions(int fd, int domain)
 			completions, expected_completions);
 }
 
+static void do_new_recv_remaining_completions(int fd, struct msghdr *msg)
+{
+	int ret, flags;
+	struct tx_usr_zcopy_info zc_info;
+	int64_t tstop = gettimeofday_ms() + cfg_waittime_ms;
+	char ckbuf[CMSG_SPACE(sizeof(void *))];
+
+	flags = MSG_DONTWAIT | MSG_ZEROCOPY_UARG;
+	msg->msg_iovlen = 0;
+	msg->msg_controllen = CMSG_SPACE(sizeof(void *));
+	msg->msg_control = (struct cmsghdr *)ckbuf;
+	add_zcopy_user_arg(msg, &zc_info);
+
+	while (completions < expected_completions &&
+			gettimeofday_ms() < tstop) {
+		memset(&zc_info, 0, sizeof(zc_info));
+		ret = sendmsg(fd, msg, flags);
+		if (ret == -1 && errno == EAGAIN)
+			return;
+		if (ret == -1)
+			error(1, errno, "send");
+
+		do_recv_completion_user_arg(&zc_info);
+	}
+
+	if (completions < expected_completions)
+		fprintf(stderr, "missing notifications: %lu < %lu\n",
+			completions, expected_completions);
+}
+
 static void do_tx(int domain, int type, int protocol)
 {
 	struct iovec iov[3] = { {0} };
@@ -552,13 +657,14 @@ static void do_tx(int domain, int type, int protocol)
 			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
 		sendmsg_counter++;
 
-		if (sendmsg_counter == cfg_notification_limit && cfg_zerocopy) {
+		if (sendmsg_counter == cfg_notification_limit &&
+			cfg_zerocopy == ZEROCOPY_MSGERR_NOTIFICATION) {
 			do_recv_completions(fd, domain);
 			sendmsg_counter = 0;
 		}
 
 		while (!do_poll(fd, POLLOUT)) {
-			if (cfg_zerocopy) {
+			if (cfg_zerocopy == ZEROCOPY_MSGERR_NOTIFICATION) {
 				do_recv_completions(fd, domain);
 				sendmsg_counter = 0;
 			}
@@ -566,8 +672,10 @@ static void do_tx(int domain, int type, int protocol)
 
 	} while (gettimeofday_ms() < tstop);
 
-	if (cfg_zerocopy)
+	if (cfg_zerocopy == ZEROCOPY_MSGERR_NOTIFICATION)
 		do_recv_remaining_completions(fd, domain);
+	else if (cfg_zerocopy == ZEROCOPY_USER_ARG_NOTIFICATION)
+		do_new_recv_remaining_completions(fd, &msg);
 
 	if (close(fd))
 		error(1, errno, "close");
@@ -718,7 +826,7 @@ static void parse_opts(int argc, char **argv)
 
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vzol:")) != -1) {
+	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vzol:n")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -768,7 +876,7 @@ static void parse_opts(int argc, char **argv)
 			cfg_verbose++;
 			break;
 		case 'z':
-			cfg_zerocopy = true;
+			cfg_zerocopy = ZEROCOPY_MSGERR_NOTIFICATION;
 			break;
 		case 'o':
 			cfg_notification_order_check = true;
@@ -776,6 +884,9 @@ static void parse_opts(int argc, char **argv)
 		case 'l':
 			cfg_notification_limit = strtoul(optarg, NULL, 0);
 			break;
+		case 'n':
+			cfg_zerocopy = ZEROCOPY_USER_ARG_NOTIFICATION;
+			break;
 		}
 	}
 
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


