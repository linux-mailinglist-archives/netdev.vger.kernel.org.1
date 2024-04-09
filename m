Return-Path: <netdev+bounces-86271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177E589E4B3
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C968D284155
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 20:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEFC158874;
	Tue,  9 Apr 2024 20:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hF6RlQMO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D455370
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712696015; cv=none; b=IybpjSFlSFw27J3NdsDhiHdCdAviH7Wcjsm7cvoBAJ3wFgFDxqA/x52MRwOGE79vWtPgP9ZLw0CCzyR7/TfLkpKy4fkogIfB9/ssteoyqt+iIGhGAhdMGPUraBXPysD/Fu1S3c9p3epNM78XHstIdW785UKeuw7Btq3vyeEhFCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712696015; c=relaxed/simple;
	bh=xqVQkoH6aBoUsPV/E4Zy5PqbwS0X6hGlKu2AoDH7kGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHuEAl8GykA1woH/w2QQeZJDcVHG1lxU8VzrhU1ZJOOd/1fZQAy1IHjNLlYOZ2ahaPi7PGmPfNrGFrKTmEq5iReW4qQ/PZHYooKwpktw4IaOtdTHkeSJMD8gpLFjQx6w6c5gD67+fYBHbJiOD9cJwD6EWMNdh9hTR9zkn2N9kro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hF6RlQMO; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78d5f0440d3so231832785a.2
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 13:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712696012; x=1713300812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRFZMizCWKZhpAerS+9gpeIjSBBecARmZERg5gpoJd0=;
        b=hF6RlQMOHvDrJjlKEWEw0hYJsHfwty6mw0QTMZmKDM73FEZ7yMl0+gthLt8GPxHTil
         Ob8b0Jhb8hddd897GALSbQeagVcb5gwgoCYl4weEm1RPO9/1eBLwqlHCzzXKndMbUTHT
         N8zxqDOuJsCD4iae1UMbv3mp1oSmzuJkpg5BJa2WtleHDqyTPWoqFu8uUEL+1yfoY5xb
         bPPLSxxQXZXHm9N75ryqQQhepZ9C6+G4o2WZrxMvpQnfaOg/5638g524jmsRQdrd8d06
         vMc5vnjHMMor6m35XppOujqMX0obvk/hhni4L4zPdQgnQmRTrbYRTBrOdunmEEUT6Hcw
         WUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712696012; x=1713300812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRFZMizCWKZhpAerS+9gpeIjSBBecARmZERg5gpoJd0=;
        b=BHgxmiKs18ZBwF7BtrOArd1rPfX5zVr6kycqacJ/uw0WtROXW5CVKfhLVySHF0tGeC
         JDL4BY/5c5xVbIvD0Kxu9T6e4EMVceHIpk6bttzo/tZtUwVmsf7LNdkPk+PADaJy45QU
         sICIVfK0Lo9w5pHw7dsbEp4BQlRJs4cZM3xeqxke4l7NswRrvbf6wYMchY0jrMxHIwjW
         oQr9MLbwl2origsVjJzZg4Lq8DfSaE3Lwpl1vW9Qdnk8HgPEEbwnbzZkUlqflAD/0J/S
         PJYe7otcs12f7ykm0h6Xv+RvYrkUaV3GawSZaVv4lernOm/C/u5o/oTmsTmGw2zahZQ8
         /+FQ==
X-Gm-Message-State: AOJu0YxHzPjIFto7ZNcKhWiiDKbSB8aXOGyDkAlI5laRkqYFfZZSgwDR
	Qu/hP7wb71j3zyK35crLn3ljjCtKYIzahktOuKwK4Rx9d6spY8ROlVNYU2z0Kcm2gnZ846dOeZc
	5
X-Google-Smtp-Source: AGHT+IHdXWES4da2H3LXPPzNOlsJSM+679wEQBCQKwlSlqEs1fMV3LVvCTwWzP/FoGBmvGr/mnwcSg==
X-Received: by 2002:a05:620a:22e3:b0:78d:5f2c:9a19 with SMTP id p3-20020a05620a22e300b0078d5f2c9a19mr728720qki.40.1712696012255;
        Tue, 09 Apr 2024 13:53:32 -0700 (PDT)
Received: from n191-036-066.byted.org ([147.160.184.150])
        by smtp.gmail.com with ESMTPSA id vy3-20020a05620a490300b0078d6bcfb580sm1151619qkn.10.2024.04.09.13.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 13:53:31 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next 2/3] selftests: fix OOM problem in msg_zerocopy selftest
Date: Tue,  9 Apr 2024 20:52:59 +0000
Message-Id: <20240409205300.1346681-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240409205300.1346681-1-zijianzhang@bytedance.com>
References: <20240409205300.1346681-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
on a socket, and it will recv the completion notifications when the socket
is not writable. Typically, it will start the receiving process after
around 30+ sendmsgs.

However, because of the commit dfa2f0483360
("tcp: get rid of sysctl_tcp_adv_win_scale"), the sender is always writable
and does not get any chance to run recv notifications. The selftest always
exits with OUT_OF_MEMORY because the memory used by opt_skb exceeds
the core.sysctl_optmem_max. We introduce "cfg_notification_limit" to
force sender to receive notifications after some number of sendmsgs. Plus,
in the selftest, we need to update skb_orphan_frags_rx to be the same as
skb_orphan_frags. In this case, for some reason, notifications do not
come in order now. We introduce "cfg_notification_order_check" to
possibly ignore the checking for order.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 tools/testing/selftests/net/msg_zerocopy.c | 24 ++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index bdc03a2097e8..8e595216a0af 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -85,6 +85,8 @@ static bool cfg_rx;
 static int  cfg_runtime_ms	= 4200;
 static int  cfg_verbose;
 static int  cfg_waittime_ms	= 500;
+static bool cfg_notification_order_check;
+static int  cfg_notification_limit = 32;
 static bool cfg_zerocopy;
 
 static socklen_t cfg_alen;
@@ -435,7 +437,7 @@ static bool do_recv_completion(int fd, int domain)
 	/* Detect notification gaps. These should not happen often, if at all.
 	 * Gaps can occur due to drops, reordering and retransmissions.
 	 */
-	if (lo != next_completion)
+	if (cfg_notification_order_check && lo != next_completion)
 		fprintf(stderr, "gap: %u..%u does not append to %u\n",
 			lo, hi, next_completion);
 	next_completion = hi + 1;
@@ -489,7 +491,7 @@ static void do_tx(int domain, int type, int protocol)
 		struct iphdr iph;
 	} nh;
 	uint64_t tstop;
-	int fd;
+	int fd, sendmsg_counter = 0;
 
 	fd = do_setup_tx(domain, type, protocol);
 
@@ -548,10 +550,18 @@ static void do_tx(int domain, int type, int protocol)
 			do_sendmsg_corked(fd, &msg);
 		else
 			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
+		sendmsg_counter++;
+
+		if (sendmsg_counter == cfg_notification_limit && cfg_zerocopy) {
+			do_recv_completions(fd, domain);
+			sendmsg_counter = 0;
+		}
 
 		while (!do_poll(fd, POLLOUT)) {
-			if (cfg_zerocopy)
+			if (cfg_zerocopy) {
 				do_recv_completions(fd, domain);
+				sendmsg_counter = 0;
+			}
 		}
 
 	} while (gettimeofday_ms() < tstop);
@@ -708,7 +718,7 @@ static void parse_opts(int argc, char **argv)
 
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vz")) != -1) {
+	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vzol:")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -760,6 +770,12 @@ static void parse_opts(int argc, char **argv)
 		case 'z':
 			cfg_zerocopy = true;
 			break;
+		case 'o':
+			cfg_notification_order_check = true;
+			break;
+		case 'l':
+			cfg_notification_limit = strtoul(optarg, NULL, 0);
+			break;
 		}
 	}
 
-- 
2.20.1


