Return-Path: <netdev+bounces-89749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D338AB69E
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 23:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B31283177
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 21:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE50B13CFBB;
	Fri, 19 Apr 2024 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Dsgh1puK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354D29CE5
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713563309; cv=none; b=oy2DTufhLUo01hJexcEsNryf5UEUvzUjHzTpMJf4Tc6yGtc0iPgywVU3qs/+GLT+DRUs3336i+f6AAfS4ECXotgplI5CuJsw+m6INtUDmMQPYY7b3hsrzufkqQXnrIp23sIeCyrhQWSify8vEFXTXoNIAlVupgZaz/uXlfg7/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713563309; c=relaxed/simple;
	bh=Tsp/2uIiI1mt1pjhsi7BwZApj/a3QDivPNmsTKAr8wE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a2vMjf2sE9XcilqcexXwXHspGQ1IdtGWTtsOu6P38yUJH0YDCDh6e3iAqsTtVKDc8jL/8X79a3/MhlpdCtfAm3UNlW/CYpGQbi4+G4RW8EsrGEJ+2fFEHoM/QeVFxDjWDI9Yo2ZqX1+k94NSkGNDupcFw0mOGveU02/JZs4Wwz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Dsgh1puK; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5aa362cc2ccso1722531eaf.3
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 14:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713563306; x=1714168106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1ABXgzFmtpaGn3PNm5y7bfO143XmsdVxQTUgriYetc=;
        b=Dsgh1puKu1ZAMx6L2x98KbZVPUsY89o2IWeFzNkyamuV16FkUdyx9LU1Etq4wqPc07
         oJhVYOy4suks2UIxuD00R1CmDAGcuos3vDbOXWoQpuX35GFoRXTUz9UVdjVA7TNUUcb2
         p/7cb6TZfq+kJC5Jw/X8RLK/gTCM6DnFXey6D0eAGJ8uK14uToQvONucUeJQjkQBtCfl
         Ux7q+gXfZyH/kKLZs1GrFoxgxhgEWF1/GNW1lSJDSZHWZFNyTD82gMTKzCQFGmWCaR13
         S7ekcjXNKWuelX4GIRlzi6UaD3KT90w0fMSjfMfl19d3Njm/gesWMKJ2pHicTePGqv0B
         bWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713563306; x=1714168106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1ABXgzFmtpaGn3PNm5y7bfO143XmsdVxQTUgriYetc=;
        b=m/9x0wif6PxLSy59dRkSiQt6MGCP/mHwrnqN6qURx6TknWB1g24bbai2GH8eZ1O6Pn
         /nF8fqFcPI5Z3FXJfDauWxE8Gwxa8nR8PFL645IsNDVprfBFxCmds0HDKbogwB4G3XZ9
         SHygBroZyck9KdhVK5cqMuZ+2oRZeJD8Hom9rRNU+fz3iFciVNSDQEQSQdHgBqaC0weE
         cz+uLEGa3q5T5curQPyOFB23s6KJxXSvfgxo3n9zZzEH0i8QX4ye/e03M1km6t+Fom90
         dPS+rxylOww/t5Mv2OWAEnrDjZbc9/U9JQh8g9R9ccMk2KGEVqakqPg5ibNMXUASQoN+
         WojA==
X-Gm-Message-State: AOJu0Yy6+AQX4i4Rm0beHBZdgZ5toRYEtV+/GSvcM+Ja85VXuodFz3XZ
	oHkStUoQSWU/ps1t+vKgHNGvneUSoxlwuRWIDMDIRyQf8mbJ6ZSucXW15GE7/GNlhx4++1c7p2I
	N
X-Google-Smtp-Source: AGHT+IEJKBRBvSduRvLUhY8OdxSG1wNCDcUkptlsVNgfmC2Wsw2pihOr/2/o3Dk7e3c8PRSD2FuMIQ==
X-Received: by 2002:a05:6358:f1c1:b0:186:68f8:3311 with SMTP id kr1-20020a056358f1c100b0018668f83311mr3465228rwb.27.1713563306298;
        Fri, 19 Apr 2024 14:48:26 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.119])
        by smtp.gmail.com with ESMTPSA id n11-20020a0ce48b000000b0069b6c831e86sm1897511qvl.97.2024.04.19.14.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 14:48:26 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v2 1/3] selftests: fix OOM problem in msg_zerocopy selftest
Date: Fri, 19 Apr 2024 21:48:17 +0000
Message-Id: <20240419214819.671536-2-zijianzhang@bytedance.com>
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

In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
on a socket with MSG_ZEROCOPY flag, and it will recv the notifications
until the socket is not writable. Typically, it will start the receiving
process after around 30+ sendmsgs. However, because of the
commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
the sender is always writable and does not get any chance to run recv
notifications. The selftest always exits with OUT_OF_MEMORY because the
memory used by opt_skb exceeds the core.sysctl_optmem_max.

According to our experiments, this problem can be solved by open the
DEBUG_LOCKDEP configuration for the kernel. But it will makes the
notificatoins disordered even in good commits before
commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale").

We introduce "cfg_notification_limit" to force sender to receive
notifications after some number of sendmsgs. And, notifications may not
come in order, because of the reason we present above. We have order
checking code managed by cfg_verbose.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 tools/testing/selftests/net/msg_zerocopy.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index bdc03a2097e8..6c18b07cab30 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Evaluate MSG_ZEROCOPY
  *
  * Send traffic between two processes over one of the supported
@@ -85,6 +86,7 @@ static bool cfg_rx;
 static int  cfg_runtime_ms	= 4200;
 static int  cfg_verbose;
 static int  cfg_waittime_ms	= 500;
+static int  cfg_notification_limit = 32;
 static bool cfg_zerocopy;
 
 static socklen_t cfg_alen;
@@ -95,6 +97,8 @@ static char payload[IP_MAXPACKET];
 static long packets, bytes, completions, expected_completions;
 static int  zerocopied = -1;
 static uint32_t next_completion;
+/* The number of sendmsgs which have not received notified yet */
+static uint32_t sendmsg_counter;
 
 static unsigned long gettimeofday_ms(void)
 {
@@ -208,6 +212,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 		error(1, errno, "send");
 	if (cfg_verbose && ret != len)
 		fprintf(stderr, "send: ret=%u != %u\n", ret, len);
+	sendmsg_counter++;
 
 	if (len) {
 		packets++;
@@ -435,7 +440,7 @@ static bool do_recv_completion(int fd, int domain)
 	/* Detect notification gaps. These should not happen often, if at all.
 	 * Gaps can occur due to drops, reordering and retransmissions.
 	 */
-	if (lo != next_completion)
+	if (cfg_verbose && lo != next_completion)
 		fprintf(stderr, "gap: %u..%u does not append to %u\n",
 			lo, hi, next_completion);
 	next_completion = hi + 1;
@@ -460,6 +465,7 @@ static bool do_recv_completion(int fd, int domain)
 static void do_recv_completions(int fd, int domain)
 {
 	while (do_recv_completion(fd, domain)) {}
+	sendmsg_counter = 0;
 }
 
 /* Wait for all remaining completions on the errqueue */
@@ -549,6 +555,9 @@ static void do_tx(int domain, int type, int protocol)
 		else
 			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
 
+		if (cfg_zerocopy && sendmsg_counter >= cfg_notification_limit)
+			do_recv_completions(fd, domain);
+
 		while (!do_poll(fd, POLLOUT)) {
 			if (cfg_zerocopy)
 				do_recv_completions(fd, domain);
@@ -708,7 +717,7 @@ static void parse_opts(int argc, char **argv)
 
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vz")) != -1) {
+	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vzl:n")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -760,6 +769,9 @@ static void parse_opts(int argc, char **argv)
 		case 'z':
 			cfg_zerocopy = true;
 			break;
+		case 'l':
+			cfg_notification_limit = strtoul(optarg, NULL, 0);
+			break;
 		}
 	}
 
-- 
2.20.1


