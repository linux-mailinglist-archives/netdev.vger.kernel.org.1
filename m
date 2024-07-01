Return-Path: <netdev+bounces-108276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC4B91E986
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 22:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF9D281470
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3E316F265;
	Mon,  1 Jul 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kAtuiOv7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851392AD0C
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865453; cv=none; b=WvpH0Jw1f8bhl1HVkagbNqzfPXfJCkxANdH6XFP/0tJXz9WhD7q6Tbc5kqnYTWRs2VB7KMks1BlTl38QyhriVfsuctgaWhUGjRNNbqecKIBU50zsC/KD1Ntv1j57xV7vfl3MRFlwWSLPnqJ6WfTYHe2JLrJJ5QgmR2k78t8bZqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865453; c=relaxed/simple;
	bh=o4LY9XVzve7upXm4vCIiLaUZTn/iyI18Z04/Qi8ApiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WpYMrGgty0tSU4Bdj6poLNeMrsQ1nPunX9VlR+dLryaGULp89XCiuym/q7fyaKFtYgBG0uRLdT4otY+uH2lZwDyjmUJ4EO+WXGabv/mpbs5b+fDlNmaagtHVGCoBK+TRbXpvJUkLhB4qTN8klQLiBghv11mva4r9cGRx+ECznSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kAtuiOv7; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-79c06c08149so224933285a.3
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 13:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719865449; x=1720470249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N9Wejji7TjFwP9PceQPtmfCFbVCioSJofpKbf16eBuk=;
        b=kAtuiOv7eGNhnW5P+B97C2jg7Y0A7XsRCY64ZJsLl1FOGb+5vEjQDNZfzv/PLarxRa
         YQDw5thiZa1Ov+G94v9Mw9Rt8W1grF+rLSvl+N/Tq/7tlDWTzfmRww6k9QzVxqH00m3m
         HP8ydrvCrCk/FIEFyf7foPiwPJBwYAGxubGOAcEXT0mhZcrBng6jQzD/EgYZwwj8VOFv
         Kn8/7od0VoWOtgGsI80iX0iHxAYOA28gAotfoaOLKUaxt/nst5QJa0+yUNzLUnbBGLuR
         q5gPF13sh2KfTIh5+ZGgYsrNNZS+IGOao9nudKMlUD6Ibcy4gLWJ/yJwZeDOnURc6LfY
         Q6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719865449; x=1720470249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9Wejji7TjFwP9PceQPtmfCFbVCioSJofpKbf16eBuk=;
        b=Ixj5VFmYSYez5RGzs0TgG+YUIjHzJxh4gXckDqmq2P24fhj5uh9qTT/napomDOjmpx
         BNZX3o/xrk2l3Obps0f/rIyA5/SxkqRknwxVkKnS70NtBJPzfUTroZq1UOvbviqbVJzK
         OOTaCnIf0pGFQFwNPYJnIgn8OgXbiq1nVE0Q9QJL4YtyJgSy5XfxjTlUELA9uXAnyVyT
         viwFfZLGCnnfyPifUcLySeyN6vy9IMlSA+I5j4LVtqzJGAGv/WIsstwC/W5m6gPi2OxL
         S4HFi+10gPE1flG7bDVIY+aF1VPEkT+x4uI4UAatpRBAHOqt1bvllS8tIzXK0s1S2Gbp
         WbMQ==
X-Gm-Message-State: AOJu0YynMLDrqnm+4rvOnn0Qs2AcGPOBKE99anPbJ+6X7Q2JVLHJN1Kt
	Iz6QOuLpnC2IuA+OXhaziVHcXinwAC75j2nlFtCcIIoEJIjV0zQrkshBvB9EGCQ461ykrkmlBGy
	Y
X-Google-Smtp-Source: AGHT+IE9N+8VJYjgyLDjdYtW2rZLMr/Oh4MjNu0R9kiLY8IJ2P+KTj/jxpocxEhgCys2pfZhZs8ilg==
X-Received: by 2002:a05:620a:4008:b0:79d:8ea3:9d1e with SMTP id af79cd13be357-79d8ea3a00amr346360585a.8.1719865449529;
        Mon, 01 Jul 2024 13:24:09 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.215.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69279783sm383800985a.44.2024.07.01.13.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:24:09 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH] selftests: fix OOM problem in msg_zerocopy selftest
Date: Mon,  1 Jul 2024 20:23:38 +0000
Message-Id: <20240701202338.2806388-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
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
process after around 30+ sendmsgs. However, because of the commit
dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale") the sender is
always writable and does not get any chance to run recv notifications.
The selftest always exits with OUT_OF_MEMORY because the memory used by
opt_skb exceeds the core.sysctl_optmem_max.

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


