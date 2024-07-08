Return-Path: <netdev+bounces-110016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3FB92AAE4
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828501C21732
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC4814F105;
	Mon,  8 Jul 2024 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="amU8m8UM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A5514EC5E
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472780; cv=none; b=Ma+2W5M4U9S+DGxaf3nztglEIoi7XYiXeqRP2n24HQrKn9pVsHzo/DOt1c0bJWfnnBWEVUtoK7W+PM/ssKw1XL/UTS6YzWLvU1ygnqBNQuOHs1GxKKzOQmYv+4GYAl3qyXnIsuZl5sYuTeC5x+uhIlmtCgfK4U82RUaclg6uYnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472780; c=relaxed/simple;
	bh=XjDtgy90FMpVOjjO4ziOcDuAIwqT36CpllMg9ThGv6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1XXkLL6Nfo4sbT/kKRYIMnsAiw5E09mLReFwg63gALQ9nTmg2EWmnGo1Om0153RdCPIUQKkOkXxT0dF8Jd4kp8Op4K1iiaHGO91BKN+qYoN62LfQQ16w/wLsEinBuEh70Jnv7Pjo+y08PDOzjgPGGW9KUSeEVuHHlNIGOdPom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=amU8m8UM; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-79f083f5cb6so133442485a.3
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1720472776; x=1721077576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THjKmeHNnZ5uNtrRboBkzythALmpfKB7bgjjdmq0wQU=;
        b=amU8m8UMO1kRJjrXopl1PStzxeFUev8/MGWXszAxKoHUrO07hFeElrD10GmE0uHhBs
         be5JNTSyWoL2YnFI9/3srmndigjRu2fQcUqxIPran/lAlZZVdxZd+k/svFQdjOBKJ3IT
         zcJOwecbn3qyvj/GpobH0UeY8Nxwiar6xRYYoAG95kyT5eRPV0LIWK65VFawal8vRMUR
         sAQOJOrgZzlxcKnblMRpMbHoNK/+B1th9eXPtY1LMQ2cYJG3MgqUWM8DPC3vD1bdYPTR
         hVoSZK/WwEzi8BQu3LDyDTjNI0jsfq6PFndj1WQ/pNTpRZw5cImTpM9yaW6oW0esnY4N
         GMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720472776; x=1721077576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THjKmeHNnZ5uNtrRboBkzythALmpfKB7bgjjdmq0wQU=;
        b=k9xo9T4FQzRQjD2PYlG8H5GuVqkBAIz7K2sfeJM2x2kkroC/6aAWj6F0t1JBFuS2EH
         FvrfP9R1/kQaC90s3w4fCbqvnzfmDnMlpWI35zEDOPHkVr/cYoDxiwSvolF4aEJKnhen
         PGWgd4VVpprWQgE8jhH6VX1J9xYMJrRywrOjP7H3R0SGZMygjDEaHLquA9/zrEtnFzZI
         qogXA0+WvJChWiLJJkCTYgECO/6XoJNJTpCsSD+Dr4rkgAUImnWPaF9gI4fBcOJ1mzpf
         NIr7eEwQMIJLWb1iShkT4eGMMyJlWWGvIzCG4rIW7P9+rHmQEvQ2IdlAJBzjVLrI8fe1
         6Q2g==
X-Gm-Message-State: AOJu0YztSDHmKTn9JILOLFhRpZHfCzO4yAWAv+Lg2HphmGR8frpMeOqm
	K+KQ+eUEkIwRZFkQixn+T2He0HYeaXIn3NSzYFjdSL6p8GWwm86iL04I5VYncnCes0LsEFKqhIN
	p
X-Google-Smtp-Source: AGHT+IFFqcxr0E3K4M/RtcPNFhgYtRNQp5xfKrpwjDHnWCWrWWnnsIaArG0Ed1iuhYBZvaOsuYVYLw==
X-Received: by 2002:a05:620a:2952:b0:79e:fca9:27c6 with SMTP id af79cd13be357-79f19ae357emr88059085a.55.1720472776567;
        Mon, 08 Jul 2024 14:06:16 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff82a7sm28212185a.9.2024.07.08.14.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 14:06:16 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v7 3/3] selftests: add MSG_ZEROCOPY msg_control notification test
Date: Mon,  8 Jul 2024 21:04:05 +0000
Message-Id: <20240708210405.870930-4-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240708210405.870930-1-zijianzhang@bytedance.com>
References: <20240708210405.870930-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

We update selftests/net/msg_zerocopy.c to accommodate the new mechanism,
cfg_notification_limit has the same semantics for both methods. Test
results are as follows, we update skb_orphan_frags_rx to the same as
skb_orphan_frags to support zerocopy in the localhost test.

cfg_notification_limit = 1, both method get notifications after 1 calling
of sendmsg. In this case, the new method has around 17% cpu savings in TCP
and 23% cpu savings in UDP.
+---------------------+---------+---------+---------+---------+
| Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
+---------------------+---------+---------+---------+---------+
| ZCopy (MB)          | 7523    | 7706    | 7489    | 7304    |
+---------------------+---------+---------+---------+---------+
| New ZCopy (MB)      | 8834    | 8993    | 9053    | 9228    |
+---------------------+---------+---------+---------+---------+
| New ZCopy / ZCopy   | 117.42% | 116.70% | 120.88% | 126.34% |
+---------------------+---------+---------+---------+---------+

cfg_notification_limit = 32, both get notifications after 32 calling of
sendmsg, which means more chances to coalesce notifications, and less
overhead of poll + recvmsg for the original method. In this case, the new
method has around 7% cpu savings in TCP and slightly better cpu usage in
UDP. In the context of selftest, notifications of TCP are more likely to
out of order than UDP, it's easier to coalesce more notifications in UDP.
The original method can get one notification with range of 32 in a recvmsg
most of the time. In TCP, most notifications' range is around 2, so the
original method needs around 16 recvmsgs to get notified in one round.
That's the reason for the "New ZCopy / ZCopy" diff in TCP and UDP here.
+---------------------+---------+---------+---------+---------+
| Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
+---------------------+---------+---------+---------+---------+
| ZCopy (MB)          | 8842    | 8735    | 10072   | 9380    |
+---------------------+---------+---------+---------+---------+
| New ZCopy (MB)      | 9366    | 9477    | 10108   | 9385    |
+---------------------+---------+---------+---------+---------+
| New ZCopy / ZCopy   | 106.00% | 108.28% | 100.31% | 100.01% |
+---------------------+---------+---------+---------+---------+

In conclusion, when notification interval is small or notifications are
hard to be coalesced, the new mechanism is highly recommended. Otherwise,
the performance gain from the new mechanism is very limited.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 tools/testing/selftests/net/msg_zerocopy.c  | 111 ++++++++++++++++++--
 tools/testing/selftests/net/msg_zerocopy.sh |   1 +
 2 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index 7ea5fb28c93d..064d2aaf7a2c 100644
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
@@ -74,6 +79,11 @@
 #define MSG_ZEROCOPY	0x4000000
 #endif
 
+enum notification_type {
+	MSG_ZEROCOPY_NOTIFY_ERRQUEUE = 1,
+	MSG_ZEROCOPY_NOTIFY_SENDMSG = 2,
+};
+
 static int  cfg_cork;
 static bool cfg_cork_mixed;
 static int  cfg_cpu		= -1;		/* default: pin to last cpu */
@@ -86,7 +96,7 @@ static int  cfg_runtime_ms	= 4200;
 static int  cfg_verbose;
 static int  cfg_waittime_ms	= 500;
 static int  cfg_notification_limit = 32;
-static bool cfg_zerocopy;
+static enum notification_type cfg_zerocopy;
 
 static socklen_t cfg_alen;
 static struct sockaddr_storage cfg_dst_addr;
@@ -97,6 +107,9 @@ static long packets, bytes, completions, expected_completions;
 static int  zerocopied = -1;
 static uint32_t next_completion;
 static uint32_t sends_since_notify;
+static char	*zc_ckbuf;
+static int	zc_info_size;
+static bool	added_zcopy_info;
 
 static unsigned long gettimeofday_ms(void)
 {
@@ -182,7 +195,26 @@ static void add_zcopy_cookie(struct msghdr *msg, uint32_t cookie)
 	memcpy(CMSG_DATA(cm), &cookie, sizeof(cookie));
 }
 
-static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
+static void add_zcopy_info(struct msghdr *msg)
+{
+	struct zc_info *zc_info;
+	struct cmsghdr *cm;
+
+	if (!msg->msg_control)
+		error(1, errno, "NULL user arg");
+	cm = (struct cmsghdr *)msg->msg_control;
+	cm->cmsg_len = CMSG_LEN(zc_info_size);
+	cm->cmsg_level = SOL_SOCKET;
+	cm->cmsg_type = SCM_ZC_NOTIFICATION;
+
+	zc_info = (struct zc_info *)CMSG_DATA(cm);
+	zc_info->size = cfg_notification_limit;
+
+	added_zcopy_info = true;
+}
+
+static bool do_sendmsg(int fd, struct msghdr *msg,
+		       enum notification_type do_zerocopy, int domain)
 {
 	int ret, len, i, flags;
 	static uint32_t cookie;
@@ -200,6 +232,12 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 			msg->msg_controllen = CMSG_SPACE(sizeof(cookie));
 			msg->msg_control = (struct cmsghdr *)ckbuf;
 			add_zcopy_cookie(msg, ++cookie);
+		} else if (do_zerocopy == MSG_ZEROCOPY_NOTIFY_SENDMSG &&
+			   sends_since_notify + 1 >= cfg_notification_limit) {
+			memset(&msg->msg_control, 0, sizeof(msg->msg_control));
+			msg->msg_controllen = CMSG_SPACE(zc_info_size);
+			msg->msg_control = (struct cmsghdr *)zc_ckbuf;
+			add_zcopy_info(msg);
 		}
 	}
 
@@ -218,7 +256,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 		if (do_zerocopy && ret)
 			expected_completions++;
 	}
-	if (do_zerocopy && domain == PF_RDS) {
+	if (msg->msg_control) {
 		msg->msg_control = NULL;
 		msg->msg_controllen = 0;
 	}
@@ -466,6 +504,44 @@ static void do_recv_completions(int fd, int domain)
 	sends_since_notify = 0;
 }
 
+static void do_recv_completions2(void)
+{
+	struct cmsghdr *cm = (struct cmsghdr *)zc_ckbuf;
+	struct zc_info *zc_info;
+	__u32 hi, lo, range;
+	__u8 zerocopy;
+	int i;
+
+	zc_info = (struct zc_info *)CMSG_DATA(cm);
+	for (i = 0; i < zc_info->size; i++) {
+		hi = zc_info->arr[i].hi;
+		lo = zc_info->arr[i].lo;
+		zerocopy = zc_info->arr[i].zerocopy;
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
+	sends_since_notify = 0;
+	added_zcopy_info = false;
+}
+
 /* Wait for all remaining completions on the errqueue */
 static void do_recv_remaining_completions(int fd, int domain)
 {
@@ -541,6 +617,14 @@ static void do_tx(int domain, int type, int protocol)
 				    sizeof(struct sockaddr_in6));
 	}
 
+	if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_SENDMSG) {
+		zc_info_size = sizeof(struct zc_info) +
+			       sizeof(struct zc_info_elem) * cfg_notification_limit;
+		zc_ckbuf = (char *)malloc(CMSG_SPACE(zc_info_size));
+		if (!zc_ckbuf)
+			error(1, errno, "zc_ckbuf malloc failed");
+	}
+
 	iov[2].iov_base = payload;
 	iov[2].iov_len = cfg_payload_len;
 	msg.msg_iovlen++;
@@ -553,11 +637,16 @@ static void do_tx(int domain, int type, int protocol)
 		else
 			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
 
-		if (cfg_zerocopy && sends_since_notify >= cfg_notification_limit)
+		if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_ERRQUEUE &&
+		    sends_since_notify >= cfg_notification_limit)
 			do_recv_completions(fd, domain);
 
+		if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_SENDMSG &&
+		    added_zcopy_info)
+			do_recv_completions2();
+
 		while (!do_poll(fd, POLLOUT)) {
-			if (cfg_zerocopy)
+			if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_ERRQUEUE)
 				do_recv_completions(fd, domain);
 		}
 
@@ -566,6 +655,9 @@ static void do_tx(int domain, int type, int protocol)
 	if (cfg_zerocopy)
 		do_recv_remaining_completions(fd, domain);
 
+	if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_SENDMSG)
+		free(zc_ckbuf);
+
 	if (close(fd))
 		error(1, errno, "close");
 
@@ -715,7 +807,7 @@ static void parse_opts(int argc, char **argv)
 
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
+	while ((c = getopt(argc, argv, "46c:C:D:i:l:mnp:rs:S:t:vz")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -749,6 +841,9 @@ static void parse_opts(int argc, char **argv)
 		case 'm':
 			cfg_cork_mixed = true;
 			break;
+		case 'n':
+			cfg_zerocopy = MSG_ZEROCOPY_NOTIFY_SENDMSG;
+			break;
 		case 'p':
 			cfg_port = strtoul(optarg, NULL, 0);
 			break;
@@ -768,7 +863,7 @@ static void parse_opts(int argc, char **argv)
 			cfg_verbose++;
 			break;
 		case 'z':
-			cfg_zerocopy = true;
+			cfg_zerocopy = MSG_ZEROCOPY_NOTIFY_ERRQUEUE;
 			break;
 		}
 	}
@@ -779,6 +874,8 @@ static void parse_opts(int argc, char **argv)
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


