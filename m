Return-Path: <netdev+bounces-89752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718FD8AB6A1
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 23:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5261F21B3A
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 21:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3903113D268;
	Fri, 19 Apr 2024 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gaHFz7CW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7E529CE5
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713563313; cv=none; b=kyjuEw2Uty6n2h4+mkiAv/05F5bZmquIlxPlbbrNOnnfL4hfF+yD3BJfD2ESO0KZWcetzPoKVAS+N+vngshD2dJudWPn4Eu1WV8kVD0Lj+y5Lb4J1kG77KZem3tDE+G2Tf60QbpxuOnEml3pINoG0TkReC2o86/MNz9K6VBw0Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713563313; c=relaxed/simple;
	bh=iNB7EvpT5jMjOl9+PhJ8pViFZodRUC4Yt9ETf97iSLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZTrmwVuwpU/JdamNeQnh5fuuRlnsQgJqlnjpUsPUKpv1gGQR9PWSP/cTDdGGgqRqKAlh0vSsRamCC+tfwO6G+XkF3yE1h5BP1KLIpm1UQ2B1H6c23OUtDfeJhCcHTBdj/3xg/okhqErf8sh8rOBXrJoblsvj7gjDI9bZPZw+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gaHFz7CW; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5aa22ebd048so1729583eaf.1
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 14:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713563309; x=1714168109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDJUxA7Q6wYpaDVK4Xmfi/I5kvBQuGvrQepbc4EWlAI=;
        b=gaHFz7CW944mhpq6iCKjqrK82JK3n7wfaSZxhgx6np52/NUf9vcKAc4DUtezmqJl+S
         uDr4pK/p4q1SA/2jvmB6gP8t3RJXKK0J1L2Sc1qGM6lrRGHh21+txgCfwy8L2UIcMGvp
         kz2kxw58L1k+bgkMTUu7EBdM2x/7hZTsPuU62K5yiz8s5UOmFEVEzyXu99ke5OYKg+Sl
         c90m+wwjp1FF3q7llCl1HbsP+eRd3n+VixKsC87V4zxC2rolpaI+xpiIUkWlKF95mr4/
         HhOO/6xlPsZcvgkIBnXNwQffmi/ounai32F5qNZB0nQRtAO17xSKqQFEoyqkbyFmxWi7
         5sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713563309; x=1714168109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDJUxA7Q6wYpaDVK4Xmfi/I5kvBQuGvrQepbc4EWlAI=;
        b=ikib7cc7hbM8rU6dOxB17Rd7kn5n/bsSGfpp4pwVcKsRjaYpgDb963ht6QZ7f8/9HD
         c9AEYz/atTZjSbwW+YEU3Q+f0JdX9Cmad6Jn4FP59BEd3uha4gEmfBhPeivQdqcAt6ba
         LX4zm6UMMztrvZA9Oh5/UE2A9p/SycXkU4MOEysjZUHaVDRAtwwlQM4O8uPs1tsUa3n0
         dU3iq8P/a7iGP+u8DhfdGGlrFqKmLg5u3nvJ0IJPJsa8mZHNIkCfs+oBKM30q+820Wsd
         aowNKdikHohQuUM+PNQNvt7rd8V8gh7OfQrngYem1kzsQtUYLKGoRbic+3BYjk9k9JzU
         jw7g==
X-Gm-Message-State: AOJu0YyhfXb36BOC3keN4XWdg6Gpajc5n/vGDTjO5QTu2WAcmRC7LdnS
	jswiOoepBeLK/4xvMN9hmrBEYO6z9XjvJ35Stuy4PWAsR1+wkl20zoNimCTlJL+a6ZB+dAD0sp8
	C
X-Google-Smtp-Source: AGHT+IE7QjvNCNG6qfB6Zq0pJrliQoyngxdeLWuB9EoE4bsDA8fmybo0+jU33kMdiQIccHaRhgYpnQ==
X-Received: by 2002:a05:6359:1909:b0:181:7b22:d845 with SMTP id mf9-20020a056359190900b001817b22d845mr3375030rwb.16.1713563309520;
        Fri, 19 Apr 2024 14:48:29 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.119])
        by smtp.gmail.com with ESMTPSA id n11-20020a0ce48b000000b0069b6c831e86sm1897511qvl.97.2024.04.19.14.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 14:48:29 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v2 3/3] selftests: add MSG_ZEROCOPY msg_control notification test
Date: Fri, 19 Apr 2024 21:48:19 +0000
Message-Id: <20240419214819.671536-4-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240419214819.671536-1-zijianzhang@bytedance.com>
References: <20240419214819.671536-1-zijianzhang@bytedance.com>
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
 tools/testing/selftests/net/msg_zerocopy.c  | 91 +++++++++++++++++++--
 tools/testing/selftests/net/msg_zerocopy.sh |  1 +
 2 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index 6c18b07cab30..aa60d5c3f0a7 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -67,6 +67,10 @@
 #define SO_ZEROCOPY	60
 #endif
 
+#ifndef SO_ZC_NOTIFICATION
+#define SO_ZC_NOTIFICATION	78
+#endif
+
 #ifndef SO_EE_CODE_ZEROCOPY_COPIED
 #define SO_EE_CODE_ZEROCOPY_COPIED	1
 #endif
@@ -75,6 +79,12 @@
 #define MSG_ZEROCOPY	0x4000000
 #endif
 
+#define ZC_MSGERR_NOTIFICATION 1
+#define ZC_MSGCTL_NOTIFICATION 2
+
+#define SOCK_ZC_INFO_NUM 8
+#define ZC_INFO_SIZE(x) (sizeof(struct zc_info_usr) + x * sizeof(struct zc_info_elem))
+
 static int  cfg_cork;
 static bool cfg_cork_mixed;
 static int  cfg_cpu		= -1;		/* default: pin to last cpu */
@@ -87,13 +97,14 @@ static int  cfg_runtime_ms	= 4200;
 static int  cfg_verbose;
 static int  cfg_waittime_ms	= 500;
 static int  cfg_notification_limit = 32;
-static bool cfg_zerocopy;
+static int  cfg_zerocopy;           /* Either 1 or 2, mode for SO_ZEROCOPY */
 
 static socklen_t cfg_alen;
 static struct sockaddr_storage cfg_dst_addr;
 static struct sockaddr_storage cfg_src_addr;
 
 static char payload[IP_MAXPACKET];
+static char zc_ckbuf[CMSG_SPACE(ZC_INFO_SIZE(SOCK_ZC_INFO_NUM))];
 static long packets, bytes, completions, expected_completions;
 static int  zerocopied = -1;
 static uint32_t next_completion;
@@ -171,6 +182,23 @@ static int do_accept(int fd)
 	return fd;
 }
 
+static void add_zcopy_info(struct msghdr *msg)
+{
+	struct cmsghdr *cm;
+	struct zc_info_usr *zc_info_usr_p;
+
+	if (!msg->msg_control)
+		error(1, errno, "NULL user arg");
+	cm = (void *)msg->msg_control;
+	cm->cmsg_len = CMSG_LEN(ZC_INFO_SIZE(SOCK_ZC_INFO_NUM));
+	cm->cmsg_level = SOL_SOCKET;
+	cm->cmsg_type = SO_ZC_NOTIFICATION;
+
+	zc_info_usr_p = (struct zc_info_usr *)CMSG_DATA(cm);
+	zc_info_usr_p->usr_addr = (__u64)zc_info_usr_p;
+	zc_info_usr_p->length = SOCK_ZC_INFO_NUM;
+}
+
 static void add_zcopy_cookie(struct msghdr *msg, uint32_t cookie)
 {
 	struct cmsghdr *cm;
@@ -184,7 +212,7 @@ static void add_zcopy_cookie(struct msghdr *msg, uint32_t cookie)
 	memcpy(CMSG_DATA(cm), &cookie, sizeof(cookie));
 }
 
-static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
+static bool do_sendmsg(int fd, struct msghdr *msg, int do_zerocopy, int domain)
 {
 	int ret, len, i, flags;
 	static uint32_t cookie;
@@ -202,6 +230,11 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 			msg->msg_controllen = CMSG_SPACE(sizeof(cookie));
 			msg->msg_control = (struct cmsghdr *)ckbuf;
 			add_zcopy_cookie(msg, ++cookie);
+		} else if (do_zerocopy == ZC_MSGCTL_NOTIFICATION) {
+			memset(&msg->msg_control, 0, sizeof(msg->msg_control));
+			msg->msg_controllen = CMSG_SPACE(ZC_INFO_SIZE(SOCK_ZC_INFO_NUM));
+			msg->msg_control = (struct cmsghdr *)zc_ckbuf;
+			add_zcopy_info(msg);
 		}
 	}
 
@@ -220,7 +253,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 		if (do_zerocopy && ret)
 			expected_completions++;
 	}
-	if (do_zerocopy && domain == PF_RDS) {
+	if (msg->msg_control) {
 		msg->msg_control = NULL;
 		msg->msg_controllen = 0;
 	}
@@ -394,6 +427,43 @@ static bool do_recvmsg_completion(int fd)
 	return ret;
 }
 
+static void do_recv_completions2(struct cmsghdr *cmsg)
+{
+	int i;
+	__u32 hi, lo, range;
+	__u8 zerocopy;
+	struct zc_info_usr *zc_info_usr_p = (struct zc_info_usr *)CMSG_DATA(cmsg);
+
+	for (i = 0; i < zc_info_usr_p->length; ++i) {
+		struct zc_info_elem elem = zc_info_usr_p->info[i];
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
+	sendmsg_counter -= zc_info_usr_p->length;
+}
+
 static bool do_recv_completion(int fd, int domain)
 {
 	struct sock_extended_err *serr;
@@ -555,11 +625,15 @@ static void do_tx(int domain, int type, int protocol)
 		else
 			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
 
-		if (cfg_zerocopy && sendmsg_counter >= cfg_notification_limit)
+		if (cfg_zerocopy == ZC_MSGERR_NOTIFICATION &&
+			sendmsg_counter >= cfg_notification_limit)
 			do_recv_completions(fd, domain);
 
+		if (cfg_zerocopy == ZC_MSGCTL_NOTIFICATION)
+			do_recv_completions2((struct cmsghdr *)zc_ckbuf);
+
 		while (!do_poll(fd, POLLOUT)) {
-			if (cfg_zerocopy)
+			if (cfg_zerocopy == ZC_MSGERR_NOTIFICATION)
 				do_recv_completions(fd, domain);
 		}
 
@@ -767,11 +841,14 @@ static void parse_opts(int argc, char **argv)
 			cfg_verbose++;
 			break;
 		case 'z':
-			cfg_zerocopy = true;
+			cfg_zerocopy = ZC_MSGERR_NOTIFICATION;
 			break;
 		case 'l':
 			cfg_notification_limit = strtoul(optarg, NULL, 0);
 			break;
+		case 'n':
+			cfg_zerocopy = ZC_MSGCTL_NOTIFICATION;
+			break;
 		}
 	}
 
@@ -781,6 +858,8 @@ static void parse_opts(int argc, char **argv)
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


