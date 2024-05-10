Return-Path: <netdev+bounces-95531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE28C285D
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 18:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400C8B251E2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EA2172760;
	Fri, 10 May 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="A4v0glSv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779017277F
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715356771; cv=none; b=p+C/+DQrEgC6dn1gOHC86CSGC3KKIOT9wGYU68cu2WjkX1vEriboILmPWx8vJ2XrgBOxf9jDFBrg5A5/lTBgIQL1+PtxTP5KwGXDMigF6y3XkptgwL+W8Vv4DHwuzm7JQkKPjOwt55SYdTDG+zTgFP7tTKk9aGnKNztYi8uBb14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715356771; c=relaxed/simple;
	bh=dNWcyM476OH0vYBSo/Kk3Jx7KuSnoow7Mr3DNeSolcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SNt/UQ/7CWxA5I0ThcLy8Fr937oPEKvN6ynJnyy8Y0o+u3BA0nhRcyFpggJpl4boTZYIJp3OaqiMJpi+9z8gDXle5IxqIHieGnXjwoWhUy5A6MgL56xDrXx31l7RSXB4eEcclDd5nVODbgpJ1Ob7l+kys2INkKA/pu6/DnrIVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=A4v0glSv; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-792b8c9046bso169958585a.3
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715356767; x=1715961567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rabWcKhADufYxgChzwdAanqzucOdi69JhATOYQQ8ag4=;
        b=A4v0glSv+Y96SQr9tjMAE0MouzSX3kabegNOCaXxdizWb+mGzWIUiA+26vkZVHoggs
         wETtHgZlZzOA+S7rvT3YUMvO0eH+5IH/tHqAD0jTiWCABqk1KKJbqRJb4gsdyB3UXnU8
         J3Y4uW5EHy4nZ47AB1eaXPjbJbMJBeArUcwdeBzM3/1h79/cgFI3ZWE+a/nwUT/J5m+O
         48gX2jmVEjWqxqpXhPU94P9o4B1M7uAGbWWon/1zhZe9oZ6qiJpEO+eoQD+FtSot6lgW
         zieuHsYReLdVT8XfZGdEFlgeBx0ijTkex3Yl+NsHm9MKIIWf4CMmQ3UTY03Ps9t9Bm9G
         6ZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715356767; x=1715961567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rabWcKhADufYxgChzwdAanqzucOdi69JhATOYQQ8ag4=;
        b=p276zYYVEUoozJOCXwZKaGhsLQin1Gh9B6a0lI5j7iHqKhFZTIUr7riXmEA4HJdSvG
         sZCORv5wp7QfXa4H3/oZCyDwdyYGwlgYaLu/44GsQUTvQYfWg0qTEisVkAUxPIlVFJs7
         GrCjqJbxaeWjn0d/+TbTQQDnFl/H86115UAZBf+huIGvc3rNln2CrIGtDkxpErCIqQ/9
         Amjkm+/zS9AQVCIG9fRke3d4V8bK39yb7e5LIYjsZevCxkkUR3lWI89e3IofR55Bm7+u
         s4LDreSlTPEiLG+kc2uT1FJAQuHSjz2rPXVflpMTMrnhddc2qnKFDy/EPGYlhKTVV4h4
         uYVw==
X-Gm-Message-State: AOJu0YzTWIz3aOKuVPjf+Cqvfl2d2nxKEduku4/cJF22iUtwZwlyjCEO
	lHb/mjHWRJcoX2anMv2ASrCYbKvZpmvwQ+jWznuumoqGIdRA3WOar2WKqEndsSpzzTK38HUsqS6
	Y
X-Google-Smtp-Source: AGHT+IGfoqc2OLCOIDV0TbHDnHqiMYv1lxqvI74HmMvM1QTYu3gtS82MWT1dk7qUI29Vna3Upw9rcg==
X-Received: by 2002:a05:620a:4607:b0:790:a304:f420 with SMTP id af79cd13be357-792c7577211mr390267685a.12.1715356767448;
        Fri, 10 May 2024 08:59:27 -0700 (PDT)
Received: from n191-036-066.byted.org ([147.160.184.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf32e705sm191553285a.124.2024.05.10.08.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:59:27 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v3 1/3] selftests: fix OOM problem in msg_zerocopy selftest
Date: Fri, 10 May 2024 15:58:58 +0000
Message-Id: <20240510155900.1825946-2-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510155900.1825946-1-zijianzhang@bytedance.com>
References: <20240510155900.1825946-1-zijianzhang@bytedance.com>
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


