Return-Path: <netdev+bounces-96165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 995A28C48B7
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B40BB22CEC
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FD882881;
	Mon, 13 May 2024 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HR2nsJQi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA068248B
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715635086; cv=none; b=G7IojAEw7bMboG5sxyJPbc9eRVlnDrPdnvN/C7wcnY0JNT2YZbBv4y3tnXa6Ncm2llNdiTZv3PmzZ3lTRtjb6Gxas1jAk21xrTIU6IJH0NMbv0R4XZOrg3dmrOSuAxl6wLCb9PJKbd47DWtOqjr8TulmKpgQ+LsVBll0BRt5lec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715635086; c=relaxed/simple;
	bh=UNwIgy0eaP1U/PjG+dxmb5r6nXFEuXCnnd8Z+VVWbpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R/cd5ltTVZ0FRGuoEGZvqIgr/+2JM/0LN/O5ruCJyBIyVEjnFFrw5RNHyeZcfAWRZtZu3LD+AGxGcGgl7odBv/zBlGXem4YKDAeej6jSCdEbkzhrI6cNfxAiYmdQPhuEpUclmol3bK4jdIe3/l3nOXi+qzU4j6ZjViVJMN1yrA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HR2nsJQi; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43df23e034cso40998341cf.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 14:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715635083; x=1716239883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pq1qBmFA90YYxxuCBnsZZeZJpNA0DQPz8KGklT3/y7Q=;
        b=HR2nsJQiLtinzf3J3ACiElH+2mY1IcmKO2LyGoyLttmZfJhM2W33vnEHqkwy0xZWbi
         4P37rbSsOKGJuVRcsRxZiGn+5Lgp5kd0pkOPGM+423eqvNz/k83WQpE6VL47Y8i4yvIv
         vAuws7aUd8Ek4WZdSm6tJ/Yg8Z9BMjJvuWsCM1MKboG+yFH1hGedC79f4lEONdmCBgDc
         hfVmBGqmBuq3seQVo3XuhvVc6+bFN+dnGOACVnjJP/0V65x0tbu+qflqVC6diqMy+4ri
         WeEF33EN6E2WdTWSDI2Fnl2SD6E38MQ+tyjVgndsDRLjlXHPEYeD1tl4WumsfTTitqoo
         UhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715635083; x=1716239883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pq1qBmFA90YYxxuCBnsZZeZJpNA0DQPz8KGklT3/y7Q=;
        b=buNSRnJFJ3nSihivazq86PeKL1AZwTScg1ak+szfmxihaMCq2mvv6d8oGjRrQ9dQut
         XIF2TEAaG2UvfpSHXaF3ykqspsE0CkMSkjy3hddaBzJbvS44uKqKx73mo0xKH46+gfW3
         EJpcfal4uafFFYl3GIoxCXLHVJtkaLoQ75gc6RLafmE26zIVhkcTHrSKGTG1w88F3s5s
         P+KwuTQXRoaMk7i5khSx09VED/fOqmmVgu/fHyA3yj8Cb9yvL/Kb6om0GsDDP7s46ZWD
         Gw6R2wh74u7EZu7if28fowqwBvo0/aZicqCpW4iV8iatfHVTj2xhie3oHlKmJJ3CKSRe
         pxrg==
X-Gm-Message-State: AOJu0Yya2pKmAGbmtGjjQv40yNmA2Ud80KzZ6c9Wrub2MtVLeplOs+qL
	mA+J3MAHzDIpuJV0vFrIqltlwYzoHaZMDxR/HQ3MCT0rdWpA66nXZbH8jRptRQP2w0pHTG8BxbA
	V
X-Google-Smtp-Source: AGHT+IEP1He6oNspKxV17oRk3zESfdd4koiSViplxue55eM+8LGMRWiOKIEEFPkAEhuigu85ynf9ng==
X-Received: by 2002:a05:622a:109:b0:43a:3502:8446 with SMTP id d75a77b69052e-43dec39be29mr249913861cf.28.1715635082834;
        Mon, 13 May 2024 14:18:02 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.94])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e184af783sm18340811cf.17.2024.05.13.14.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 14:18:02 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v4 1/3] selftests: fix OOM problem in msg_zerocopy selftest
Date: Mon, 13 May 2024 21:17:53 +0000
Message-Id: <20240513211755.2751955-2-zijianzhang@bytedance.com>
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

In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
on a socket with MSG_ZEROCOPY flag, and it will recv the notifications
until the socket is not writable. Typically, it will start the receiving
process after around 30+ sendmsgs. However, because of the
commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
the sender is always writable and does not get any chance to run recv
notifications. The selftest always exits with OUT_OF_MEMORY because the
memory used by opt_skb exceeds the core.sysctl_optmem_max.

According to our experiments, this problem can be mitigated by open the
DEBUG_LOCKDEP configuration for the kernel. But it will makes the
notifications disordered even in good commits before
commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale").

We introduce "cfg_notification_limit" to force sender to receive
notifications after some number of sendmsgs. And, notifications may not
come in order, because of the reason we present above. We have order
checking code managed by cfg_verbose.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 tools/testing/selftests/net/msg_zerocopy.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index bdc03a2097e8..7ea5fb28c93d 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -85,6 +85,7 @@ static bool cfg_rx;
 static int  cfg_runtime_ms	= 4200;
 static int  cfg_verbose;
 static int  cfg_waittime_ms	= 500;
+static int  cfg_notification_limit = 32;
 static bool cfg_zerocopy;
 
 static socklen_t cfg_alen;
@@ -95,6 +96,7 @@ static char payload[IP_MAXPACKET];
 static long packets, bytes, completions, expected_completions;
 static int  zerocopied = -1;
 static uint32_t next_completion;
+static uint32_t sends_since_notify;
 
 static unsigned long gettimeofday_ms(void)
 {
@@ -208,6 +210,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 		error(1, errno, "send");
 	if (cfg_verbose && ret != len)
 		fprintf(stderr, "send: ret=%u != %u\n", ret, len);
+	sends_since_notify++;
 
 	if (len) {
 		packets++;
@@ -435,7 +438,7 @@ static bool do_recv_completion(int fd, int domain)
 	/* Detect notification gaps. These should not happen often, if at all.
 	 * Gaps can occur due to drops, reordering and retransmissions.
 	 */
-	if (lo != next_completion)
+	if (cfg_verbose && lo != next_completion)
 		fprintf(stderr, "gap: %u..%u does not append to %u\n",
 			lo, hi, next_completion);
 	next_completion = hi + 1;
@@ -460,6 +463,7 @@ static bool do_recv_completion(int fd, int domain)
 static void do_recv_completions(int fd, int domain)
 {
 	while (do_recv_completion(fd, domain)) {}
+	sends_since_notify = 0;
 }
 
 /* Wait for all remaining completions on the errqueue */
@@ -549,6 +553,9 @@ static void do_tx(int domain, int type, int protocol)
 		else
 			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
 
+		if (cfg_zerocopy && sends_since_notify >= cfg_notification_limit)
+			do_recv_completions(fd, domain);
+
 		while (!do_poll(fd, POLLOUT)) {
 			if (cfg_zerocopy)
 				do_recv_completions(fd, domain);
@@ -708,7 +715,7 @@ static void parse_opts(int argc, char **argv)
 
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vz")) != -1) {
+	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -736,6 +743,9 @@ static void parse_opts(int argc, char **argv)
 			if (cfg_ifindex == 0)
 				error(1, errno, "invalid iface: %s", optarg);
 			break;
+		case 'l':
+			cfg_notification_limit = strtoul(optarg, NULL, 0);
+			break;
 		case 'm':
 			cfg_cork_mixed = true;
 			break;
-- 
2.20.1


