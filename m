Return-Path: <netdev+bounces-103420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5D7907F63
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 01:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D086E282B55
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 23:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE37152533;
	Thu, 13 Jun 2024 23:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="h+HUEF3d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A7814BF91
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 23:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321502; cv=none; b=pZVKvpLSK3+b5V162HwYnEHayBjjcGSjbcJrDpqe/GVjyzXmAaDtqIqnNUHVNtPcbZ+hOO1pJmzx3Cxfg3kE0N4QHILFS5i9o301yw3BMse1w2adXCbdMfnn9sGRhmN5c2dkKZfB8dB2YkP8f9V4DIXv391FlkA8ZfXlClHZiBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321502; c=relaxed/simple;
	bh=UNwIgy0eaP1U/PjG+dxmb5r6nXFEuXCnnd8Z+VVWbpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kimDbv3L3cfZeNMPkNsGFTMwXV+oyB6mGS5bFjHfV3vkYtAi6uZanIZX15yzTvj9HEj4zChitzADrgLRed8kzsOybcLZVRr0afwFsuyLZMP3gXyJQ20e1KwHb+T7IGz9xWBrETIYeUu3eTF7QuvVMtRUL1M7c23/wRVbE6s1aVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=h+HUEF3d; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7955f3d4516so243421185a.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718321499; x=1718926299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pq1qBmFA90YYxxuCBnsZZeZJpNA0DQPz8KGklT3/y7Q=;
        b=h+HUEF3d2Ou0ZHwffYUgUGDaWPFRy059EymS74uU1dgVpSr8Vs+xE0VyaxytUtAm80
         ske8tL5JSMfmAXw8Uts66nHgkwiob3MgCqyo/gp7aXQvdbsQDj0ujpWSp9skqBEolh9r
         RP1aHwZWX/xj5EiHTjcPc8MJClU3HYxvkfhVQi6f/adDxPKJ2pgKIefiZjO8P//7m93S
         QiVmSv1VAaeDaor8qWxXzPMwHL+glcwO9wC/OXgXl8LBebEFqeru47nuKmSNChtP64t+
         ICCSjQ1GOFy5rHFakYFIsMGwrMK1/a0qCdBuh8+bdyAVGNxN2J3OCxBsI1FL9HKETQpi
         rtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321499; x=1718926299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pq1qBmFA90YYxxuCBnsZZeZJpNA0DQPz8KGklT3/y7Q=;
        b=h8YORaPHE9/20R7hEC/M0DoRGMXMUND/g7QXyJpcV1ces42A3qe6Gd7v6l4Uk/chZD
         H66G8RXzn8O2FLm6TATtg558kWb6T2hbRwfuSLC80FVcy8jIDNoyE+hAXsBEInCzBbA7
         LxiB7FUApX7R4iNOfk2PZUm+n9xo51NQ0qYD9MTz03FdVZh56fI1VpGZKlpY5woEnDHB
         y1FFYIv77M6VlZ6fwnB1fZjpoJorjNey8EL0J53H1NjWEnWOz0km/pE1BDbKgqkaKnnc
         237fWY3Sn3jnywvlfR3l/PewHUwUJGuc/Xg+j1Jsp7jXSZ9lqculy1LgjHpEZ+luRTeN
         GB9w==
X-Gm-Message-State: AOJu0Yyk99DNJWnnCA8ZPn3gPONQz6AM7u52gf3/sYTi5rCoV5HqP+SM
	D81UAEIyP7jJWGebN0xeMwYzGZkH2Yu3tEE8UR23zV3aAaJDmq95X4+8leTJnbQAMeTg2phdWcZ
	HrdU=
X-Google-Smtp-Source: AGHT+IF2Z9qJ5IKUBtGIpcZWjdqOzhvmlSlgpDZMLHuDH+UyyedWvo8Nt+dekh1GlCitqxhvaPS6Qg==
X-Received: by 2002:a05:620a:468b:b0:795:532f:3a82 with SMTP id af79cd13be357-798101b4089mr682823985a.32.1718321498715;
        Thu, 13 Jun 2024 16:31:38 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef3d8b62sm10586731cf.11.2024.06.13.16.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 16:31:38 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v5 1/4] selftests: fix OOM problem in msg_zerocopy selftest
Date: Thu, 13 Jun 2024 23:31:30 +0000
Message-Id: <20240613233133.2463193-2-zijianzhang@bytedance.com>
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


