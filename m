Return-Path: <netdev+bounces-96167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DA88C48B9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86871C22D72
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 21:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46C583A0A;
	Mon, 13 May 2024 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d7hZ4pXn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B382D94
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715635089; cv=none; b=PtyQKPrHEP5G9TZ5qRLbqzfC9ETLi46bgGILWhv3LO1K3AW5aXYzKfSCENLsdWLZK2BkMpxXWWiWQwwkbGvUVbIa0FnaQAx2TrONCNweZZauQ5xRIaab+6X89FldYXmKqxUQoJttG0j+DrOVVHtSmjYl9qjspWfaMV45RylwVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715635089; c=relaxed/simple;
	bh=GgHXzikhDNfXD8YMRl174qa2Asj3e6hEBjHELFLc7jA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABb5CmKXdjX1d4xgLhpT1lTx9N8zvdB7DmvmaKXtVir4CA7gOVTYkWr53vSL0DWgETR5ihmVG2oNg/vg2gtTckjK1WFY0JrNcwgqBfHEvLSGuCNDy19L27aOYEHUPIGsWB18Pa+rPcIZUrSmwwHQ2RpeudS9kI71wnVRAcklwu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d7hZ4pXn; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-792c7704e09so324558185a.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715635086; x=1716239886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0DZW+CrHnVmpn7+LqCUe4u416/Fr3mRFM0ji+8pX/g=;
        b=d7hZ4pXnuamyvb1jHlMnZFzE/95RwmLb6o/8FZ8ubRp6CPfZWEbM7j9Zwfa6ZuQYnk
         Z3m7mMKZM8ajnJ5dPldDqZC8jNMuCSrjIyyiBvXvVZqI/3fmSc9QKIg7Ry188XbhGqXh
         HoJxDedN5Mb6FBHgQqeRwO5TDhT/jHq5kDRfTuTlhUZZjq19eMjUzQr2nqOP7DfXGvBF
         tYupoTH9nRhKoegccJ0kSrWjoDsrWvFw/IIhcDtfTyTHWswbZkP1VneMY+M3E+WAmZbT
         O6PogUxUtr/x/8/dzAePc0YJ1Lt5JNkp5K+YFfDMA5Pu8olMdfGWkJjI+I8RQ1d7Ie0j
         NfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715635086; x=1716239886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0DZW+CrHnVmpn7+LqCUe4u416/Fr3mRFM0ji+8pX/g=;
        b=CrAg1mtp60d+xXA/3mb4oDAQMPn+ZZLQ9RqJ3xrdGXvze7ZvL2rwtgF6ZzbLNkwDFN
         1d2yH2baAbNU/TU6bjl4nukDM+NpyWWLK58awnAnQnmwmjIHeCMyjHPpkc01dWAvSEot
         htYpbsU+344JoaBN2DT/pkuFIf6Ah19gwvg9+H+Obkd9+om2vugbpzwfjif2Bjq77cAn
         LQLYXPWYSZOG19DwqAW5RLppoZwSAAnHm4stzz5TrwW2Q0bzWOYF8T64MsXvW7ZbsNd8
         AuYlDKeCxJ5/a2ZNLCtz/mtHP86rRxIIzyoMqrEB1a4O4iweZLYETu1uPg8V2wE+kvde
         eGtg==
X-Gm-Message-State: AOJu0Yxs7ixm9FHCd4VLs4oxhg9Zq20yWhRSTggQCi3ERHp31JYsvDk/
	IyGDRL35X8J6xwSBYsmIsTBN8OPNIcbNRWfAY+1BQ+LSBUIsZiYvXbn/7wuLZfGFbOq7LFG9PXJ
	l
X-Google-Smtp-Source: AGHT+IE1U5NnYiDu6EAkp/mQpbyyd4BouJYJQJF6pbjZRG6+pMBHGnXS/hMpWdIUSyGvRAfG4sIpsg==
X-Received: by 2002:a0c:eec6:0:b0:6a0:e8ed:49a6 with SMTP id 6a1803df08f44-6a15cc96cedmr249121086d6.27.1715635085812;
        Mon, 13 May 2024 14:18:05 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.94])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e184af783sm18340811cf.17.2024.05.13.14.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 14:18:05 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v4 3/3] selftests: add MSG_ZEROCOPY msg_control notification test
Date: Mon, 13 May 2024 21:17:55 +0000
Message-Id: <20240513211755.2751955-4-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240513211755.2751955-1-zijianzhang@bytedance.com>
References: <20240513211755.2751955-1-zijianzhang@bytedance.com>
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
 tools/testing/selftests/net/msg_zerocopy.c  | 106 ++++++++++++++++++--
 tools/testing/selftests/net/msg_zerocopy.sh |   1 +
 2 files changed, 100 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index 7ea5fb28c93d..d71477ee4d60 100644
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
+#define SOCK_ZC_INFO_NUM 8
+
+#define INVALID_ZEROCOPY_VAL 2
+
 static int  cfg_cork;
 static bool cfg_cork_mixed;
 static int  cfg_cpu		= -1;		/* default: pin to last cpu */
@@ -86,13 +100,16 @@ static int  cfg_runtime_ms	= 4200;
 static int  cfg_verbose;
 static int  cfg_waittime_ms	= 500;
 static int  cfg_notification_limit = 32;
-static bool cfg_zerocopy;
+static enum notification_type cfg_zerocopy;
 
 static socklen_t cfg_alen;
 static struct sockaddr_storage cfg_dst_addr;
 static struct sockaddr_storage cfg_src_addr;
 
 static char payload[IP_MAXPACKET];
+static char zc_ckbuf[CMSG_SPACE(sizeof(void *))];
+static struct zc_info_elem zc_info[SOCK_ZC_INFO_NUM];
+static struct zc_info_elem *zc_info_ptr = zc_info;
 static long packets, bytes, completions, expected_completions;
 static int  zerocopied = -1;
 static uint32_t next_completion;
@@ -169,6 +186,26 @@ static int do_accept(int fd)
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
@@ -182,7 +219,8 @@ static void add_zcopy_cookie(struct msghdr *msg, uint32_t cookie)
 	memcpy(CMSG_DATA(cm), &cookie, sizeof(cookie));
 }
 
-static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
+static bool do_sendmsg(int fd, struct msghdr *msg,
+			   enum notification_type do_zerocopy, int domain)
 {
 	int ret, len, i, flags;
 	static uint32_t cookie;
@@ -200,6 +238,15 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 			msg->msg_controllen = CMSG_SPACE(sizeof(cookie));
 			msg->msg_control = (struct cmsghdr *)ckbuf;
 			add_zcopy_cookie(msg, ++cookie);
+		} else if (do_zerocopy == MSG_ZEROCOPY_NOTIFY_SENDMSG) {
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
 
@@ -218,7 +265,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 		if (do_zerocopy && ret)
 			expected_completions++;
 	}
-	if (do_zerocopy && domain == PF_RDS) {
+	if (msg->msg_control) {
 		msg->msg_control = NULL;
 		msg->msg_controllen = 0;
 	}
@@ -392,6 +439,42 @@ static bool do_recvmsg_completion(int fd)
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
+	sends_since_notify -= i;
+}
+
 static bool do_recv_completion(int fd, int domain)
 {
 	struct sock_extended_err *serr;
@@ -553,11 +636,15 @@ static void do_tx(int domain, int type, int protocol)
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
 
@@ -715,7 +802,7 @@ static void parse_opts(int argc, char **argv)
 
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
+	while ((c = getopt(argc, argv, "46c:C:D:i:l:mnp:rs:S:t:vz")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -749,6 +836,9 @@ static void parse_opts(int argc, char **argv)
 		case 'm':
 			cfg_cork_mixed = true;
 			break;
+		case 'n':
+			cfg_zerocopy = MSG_ZEROCOPY_NOTIFY_SENDMSG;
+			break;
 		case 'p':
 			cfg_port = strtoul(optarg, NULL, 0);
 			break;
@@ -768,7 +858,7 @@ static void parse_opts(int argc, char **argv)
 			cfg_verbose++;
 			break;
 		case 'z':
-			cfg_zerocopy = true;
+			cfg_zerocopy = MSG_ZEROCOPY_NOTIFY_ERRQUEUE;
 			break;
 		}
 	}
@@ -779,6 +869,8 @@ static void parse_opts(int argc, char **argv)
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


