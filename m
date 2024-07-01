Return-Path: <netdev+bounces-108291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB2B91EB30
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 00:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09DD4B21753
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 22:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5371A172791;
	Mon,  1 Jul 2024 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KEy3Jg7E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C09916DC09
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719874439; cv=none; b=OsMHP222g5CDSdRjvEPMAzOvmSZhLiC8DEZn9E/4vi44BM0rp7iVxp44jOsfP8kX/cYKRDZOFU9Ljt0b6YMjfVgh+2rLaMTvsBfQHia/5I1Yucgt5m2CC9DcjX1s+q1HHFTIeVb7672FKidW/V1L96gAxc8j9lQkmftbRIUjf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719874439; c=relaxed/simple;
	bh=ixwDpOmaHYDB1m6ExiTtrSbDMWU2C23t3iqGXTcAASo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ewwoqJIj3IHsJjlEQqRm5cEdlFT6m9UQ9Scm0qxDi46a8qZlSAnlCkq2vX6MhCTke1vv1zptauh+EZhXWm+RuForppUCgmNurkAtVRFlFk5a3tF8tgifAADWrnWRca7OAyrupiYLty56WoxcSqrElC/giwISjGo17H6a38VNRV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KEy3Jg7E; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79c05313ec8so187668785a.3
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 15:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719874435; x=1720479235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eoI38xui1xgULGcdpxHaWYoWkSLh1oKyKiReT5u/ZA=;
        b=KEy3Jg7EbE+1tP7WvjKyrDLo4N8Bne4gBMpm+6It1jH/VDxlr6yZiFl1mM3Y5ToZyW
         wQKPwMIr80Db+Rf105aZxjEi2+71dhnHjWX5ojwQwd2doDjNYxsq115P3f1NA/59HBDF
         0NU/c+vIUESEIIlc+6DVTEwB7hL1Jo1iEdUJG08qyJnJQ/MV5hZiVJFLHyaLE/bhZ8w1
         a6LKFxxtPGD0Of8NUZ4J7Y14PTJMNEgpTn236vvOI4TjteMI/sXuYWWKynWpicC2zAY5
         4ttlEk4D83Pf95VGtsyFoxMy/fPDSkrgwE1Mqdm8dUEdeFQJYGjlYeCJka855IOLL2cT
         83FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719874435; x=1720479235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eoI38xui1xgULGcdpxHaWYoWkSLh1oKyKiReT5u/ZA=;
        b=dJd0I875IOJFXNOOzkw44I3onVeZ804DEjhgmHyB+8TuctrQx1QlTW1hyrv5UmwB7z
         +UgFzh2YqtxonCuVkoIwygl87N6u5aZqc58qZ0OVmPsSeFbVlqlaGRncz+dYLaQ5+3LO
         Q7e76j74Honms9NQcnqP4OspnugeQ0PTyi061yOxuTrq+nzfhcziXAJyKbcCQb8yy99d
         DQskciEjjF1lshQk3Mn5QVeSwqaMnfTJKrJUeZMrlD9MnqLxhAc6nm3V/PtIr+0dS0A2
         LXDeukmj/grDONHgsXZevGoNKWcJ969jBb5unLLrFkBEBpGDPxVvS0PqWVOkFQWrG7gG
         amLg==
X-Gm-Message-State: AOJu0YzV9YeB1raxQFXaCnFGSMEqVDUK0yffKUgsgfHx9kHVt7swPb0d
	0u2fSOpVbrrwr2ZwVvbZ646GeQE+r0qMpazJBTDXZWRtwGs29e9EORhdFi9gXN0SgS3KW7Gg8H2
	a
X-Google-Smtp-Source: AGHT+IFRUy72xdxjWKAmzQruwNenfjPXl7iP/6DK/3BpFhiQ6LUpvZTePmLOi43cpRCF/aCLDHlHlA==
X-Received: by 2002:a05:6214:246c:b0:6b4:fdcd:1604 with SMTP id 6a1803df08f44-6b5b71eba9amr90467216d6.62.1719874435005;
        Mon, 01 Jul 2024 15:53:55 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.111])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f34efsm37706356d6.90.2024.07.01.15.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 15:53:54 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net 1/2] selftests: fix OOM in msg_zerocopy selftest
Date: Mon,  1 Jul 2024 22:53:48 +0000
Message-Id: <20240701225349.3395580-2-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240701225349.3395580-1-zijianzhang@bytedance.com>
References: <20240701225349.3395580-1-zijianzhang@bytedance.com>
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
process after around 30+ sendmsgs. However, as the introduction of commit
dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"), the sender is
always writable and does not get any chance to run recv notifications.
The selftest always exits with OUT_OF_MEMORY because the memory used by
opt_skb exceeds the net.core.optmem_max. Meanwhile, it could be set to a
different value to trigger OOM on older kernels too.

Thus, we introduce "cfg_notification_limit" to force sender to receive
notifications after some number of sendmsgs.

Fixes: 07b65c5b31ce ("test: add msg_zerocopy test")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 tools/testing/selftests/net/msg_zerocopy.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index bdc03a2097e8..926556febc83 100644
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


