Return-Path: <netdev+bounces-98773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2DF8D26FC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BD8285F61
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E1817B4ED;
	Tue, 28 May 2024 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NHDseq7U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4C16DED8
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716931294; cv=none; b=omUz92RdaR9ubdT2SbyIrM8Y9bzZ07rmDGfJZCxo7EwIZjaw78D7KddYQBmQTZw9/UgKXCBx+C49ZpYAJOCUEHeIEBfwHohsYJiq+IlgcAMXkyqSRGpWFRlrVA6DT7/JYiyZxZYodIaECNp2kZ+5nJhMu2tRyi5miM4shEwyDbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716931294; c=relaxed/simple;
	bh=dNWcyM476OH0vYBSo/Kk3Jx7KuSnoow7Mr3DNeSolcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PDX6Ld0VJxDBmeloP6sRihpumfB+Q4fD20oHKskNDaTONtFtUZaFhchCqOxMjZWFnmYButuUUinvnBN2pLAz6EqNShnK8m6JYAG7jZCbtHkLxHnudB4kX8Q75q8hdiZbOHgcW6XH3vrAY1+kQmnRzi8OnOpL6y4Q1Zn2iCGAFaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NHDseq7U; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-794977cbcc3so53352185a.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1716931291; x=1717536091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rabWcKhADufYxgChzwdAanqzucOdi69JhATOYQQ8ag4=;
        b=NHDseq7U05uaCp4WiBHYwDynV7bAAF36BmEgaBIxckwMOj6yZJMSiJN34Oz7DFhdo6
         qu3MZYfxvcmsY9cridi6bI6GcQieH2npOrY+P/w1bboFn3rpJayRSiX3nZE3/W+k6+SD
         t2CyMUlr/dCakabwWYKGT8XFP6vvyQpYEEPyufxUJWQ4Gkdn82FvsW22neWOCEtEC0Cr
         nWSCOc0gwjUNB9i4LoUsAEFfXQ+duShtt3SCppPjTShh/7tN/f72e3Mf1cLwGkYwr3Hd
         QNDNcdyi5c8+LSSdN3GkjLeBxZkJ8QqwrfsvpxPu2HSCt/+V1G9QTJo0xffVxPDDk5Lh
         d2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716931291; x=1717536091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rabWcKhADufYxgChzwdAanqzucOdi69JhATOYQQ8ag4=;
        b=j1MtZO6DQ8FUex8ZwYZRbjn+IW3ZQnx2CaBufMMhmZPm61nbS3AjoJRJxtY+U+0JUE
         DHzuMFEwZu6XGGu73GeN2q2Yd36VA27qX5zd3YmKbNA9NjaI7XGIokGDu7zGjpTS6ANk
         loljVweGxITY1NX4UNpgyGm4aDGd49D1Unl5Zr7Vr14jafKLWIR5ey7SBRT7Wu5T8/g4
         m5dwJJ0RytDJy1yWVkwH5IIu51BwQ7ZgxSoL0hReTCGj/tkClgDQDyOesKmvDpzAt3NS
         nM9E2I5ZYcOv1GuSOehqSFj68vEju4Bkv23RC6MLFRUDmZX1Bbfjyu0TaDSSau9gJPjl
         wycg==
X-Gm-Message-State: AOJu0YzYS6ZO4c9J6DGa4egBwLeDsqDv5cvrTEsCtb+wdbSZDHULL+XR
	RqLyRElsLHzersLRfgXz31eE8vyXQpBNuDUSJhB5Nz3wSPPmd1kssn7Y3YibQTHTeBaxblQhCms
	S
X-Google-Smtp-Source: AGHT+IGZ10UOrlZ64cZKVGE3Efbll0NClj2xEk7EWqsAkdOC7w4SJzNfEOzJ/KwTnmmeVxHuLY+7jg==
X-Received: by 2002:a05:620a:222a:b0:794:bbbb:768b with SMTP id af79cd13be357-794bbbb7973mr764822285a.78.1716931291295;
        Tue, 28 May 2024 14:21:31 -0700 (PDT)
Received: from n191-036-066.byted.org ([147.160.184.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca80a7sm412619485a.17.2024.05.28.14.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 14:21:31 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v4 1/3] selftests: fix OOM problem in msg_zerocopy selftest
Date: Tue, 28 May 2024 21:21:01 +0000
Message-Id: <20240528212103.350767-2-zijianzhang@bytedance.com>
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
 tools/testing/selftests/net/msg_zerocopy.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index bdc03a2097e8..ba6c257f689c 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -85,6 +85,7 @@ static bool cfg_rx;
 static int  cfg_runtime_ms	= 4200;
 static int  cfg_verbose;
 static int  cfg_waittime_ms	= 500;
+static int  cfg_notification_limit = 32;
 static bool cfg_zerocopy;
 
 static socklen_t cfg_alen;
@@ -95,6 +96,8 @@ static char payload[IP_MAXPACKET];
 static long packets, bytes, completions, expected_completions;
 static int  zerocopied = -1;
 static uint32_t next_completion;
+/* The number of sendmsgs which have not received notified yet */
+static uint32_t sendmsg_counter;
 
 static unsigned long gettimeofday_ms(void)
 {
@@ -208,6 +211,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 		error(1, errno, "send");
 	if (cfg_verbose && ret != len)
 		fprintf(stderr, "send: ret=%u != %u\n", ret, len);
+	sendmsg_counter++;
 
 	if (len) {
 		packets++;
@@ -435,7 +439,7 @@ static bool do_recv_completion(int fd, int domain)
 	/* Detect notification gaps. These should not happen often, if at all.
 	 * Gaps can occur due to drops, reordering and retransmissions.
 	 */
-	if (lo != next_completion)
+	if (cfg_verbose && lo != next_completion)
 		fprintf(stderr, "gap: %u..%u does not append to %u\n",
 			lo, hi, next_completion);
 	next_completion = hi + 1;
@@ -460,6 +464,7 @@ static bool do_recv_completion(int fd, int domain)
 static void do_recv_completions(int fd, int domain)
 {
 	while (do_recv_completion(fd, domain)) {}
+	sendmsg_counter = 0;
 }
 
 /* Wait for all remaining completions on the errqueue */
@@ -549,6 +554,9 @@ static void do_tx(int domain, int type, int protocol)
 		else
 			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
 
+		if (cfg_zerocopy && sendmsg_counter >= cfg_notification_limit)
+			do_recv_completions(fd, domain);
+
 		while (!do_poll(fd, POLLOUT)) {
 			if (cfg_zerocopy)
 				do_recv_completions(fd, domain);
@@ -708,7 +716,7 @@ static void parse_opts(int argc, char **argv)
 
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vz")) != -1) {
+	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -736,6 +744,9 @@ static void parse_opts(int argc, char **argv)
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


