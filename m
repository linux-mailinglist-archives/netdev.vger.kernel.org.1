Return-Path: <netdev+bounces-227144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5828BA917A
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 13:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B01117AA4D
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 11:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AF33016FB;
	Mon, 29 Sep 2025 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCe9OK88"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5743016F4
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146290; cv=none; b=nAuqzWope2uZNZtPwg4pkJMZFxEscu87FoHsyY0WZprGPWAPiQqYMh4Q/0j3TJv+t/j0sDN7Ywwyr7pNw9fJ33P/JzbcOGP7MOXhc3JowxcVB8qVooUNsmUyQv7ZImboCoVN/OxiWwKBoe6GAMXzO11QauD8yeyq218G1EvSips=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146290; c=relaxed/simple;
	bh=zVeuPbzY0FhptkGJ1a9ugn6FeUWvhdVRR3UeMZVNM5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KI+ztulVGacre+o9zy0y6ulTrqonfm+dBK8sCCMkg54zFDQxtn7vFcUa/jsP/pM2knA+9iqQQCEl8kXTImrwIZiMLPX4JemfX4jTBYYGnU+g3WvqvWCNtK+WklwkECurHmlSgfMIFZci8zDTPlITsuib+oDYmiKL0cvpq2jeCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCe9OK88; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-78127433a32so1635255b3a.1
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 04:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759146288; x=1759751088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UE/feaxoks8wdjZ8La5T0ON+317bxNw12dhG09tCwTc=;
        b=HCe9OK88tWoL7BAupTEpUMqBhuQVbh/3XBDS8FUICkxOY+co66yYrtA1VGldSQHr2a
         UAu2k2QZvVtLin6J5iPXJgIg1qqE3nhbyU0XTO/k6zQx5eUhkei+VNOy2K+O7CnlaekO
         nu1A2vWfo56yn5M4U1tnIOACK3eYbMwkV5pzHNOyy8lgVXX9vLpwB0VIzl4gkTtv4khl
         lfYXBbus+MvxJrT3jRbPWb+cTTY+Hoq6I88HkwMkm1/7jiT5NmFTGfjijQdAOuUmqnGQ
         NA+8zjJPIKgfYwV+FgGTcTjQSzylKoJnnydx/Lqp33VakE7GayLynsFE/A+Ea+LvVzLP
         hdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759146289; x=1759751089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UE/feaxoks8wdjZ8La5T0ON+317bxNw12dhG09tCwTc=;
        b=c1htq5bxBSR1uRiJSpH3Dk5DoXPm/ThyLo98qnM5wS/m9ovwi+wmJZSOrBV+2MQ8c0
         FcHH6jV7oCNTDYT8uT16B6WCcypNScwHmBrkOLS2zNasUWX21gbIDjyXskIZj98efMyl
         wqO3wj13/C09WobhhtHNKC7szCJkXfZyk6vZWfCTQK9EaOq8FY6nNDzBThFM6Wb/As/v
         GYzI3iohZ0rPdzAWKpETSG9Y/Im2dgDh7l41TLq3H9rGKyeh27Fr4h9VAVWeEaNx5f4C
         0PwdlgA7t01Gb6qM6mD6cG7zBngh1g6TdDaOXqyaE65P5dgSXVEIWAzHzBJ5jM3gLYhb
         61og==
X-Gm-Message-State: AOJu0YySbhNPEDqnLs9eLphzRlFakCVAzqmwBUBJdzodgNa8VykxXUw5
	jRsjBIHJq8xZsd8+KejhL8Y/d0UaCPupGVEEvwr8tkvsOOzW8xl95clf
X-Gm-Gg: ASbGnct5JvLmjVcgP3SXkk2V+UOvfXySKnz9D9NpogfB4tNNpehS8pOOTw+n+ddkmhJ
	pltg7DV7VirmDLqg2x5shEW7xrDgFzjlur7yV+T3NgF0ZqR9j8V5hjt1RUWiSQioTmLkFRh/TsK
	mn+O9pSD2OdndNV9c525DA9Gy7IiD+cSVTK+I2IIsZGUYMcNCXjIKTLHIhi92O+9IVkcttBqZIw
	Zffpes2r/C0FjO54DF0YbYho1dU2tf/0nYS34uioPJP4kbBHXzMb4hXPpxFALVnMOUOjhBMueO0
	nCC8pbSdvoAVOR93XrUDPsoBQ3Q33G7EG3vvhwGPiARm5EbndsHUGvWlWn6lcdpZYoJCXMkPPbV
	JCeNasFdkuRLVT5go+nnsZiw5hXJo
X-Google-Smtp-Source: AGHT+IFW39IV8MsCUWVxnyhwFPfmeS+3uE+Tr6I8ZPuadQnx51A6z7az29U8lVTzrBDUQwr69a76wg==
X-Received: by 2002:a17:902:ec89:b0:27e:f06b:ae31 with SMTP id d9443c01a7336-27ef06bb0b8mr124136985ad.61.1759146288506;
        Mon, 29 Sep 2025 04:44:48 -0700 (PDT)
Received: from y740.local ([2401:4900:1f30:25ff:36cb:10ee:ba03:839f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed672a51fsm129475495ad.63.2025.09.29.04.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:44:48 -0700 (PDT)
From: Sidharth Seela <sidharthseela@gmail.com>
To: antonio@openvpn.net,
	sd@queasysnail.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	willemdebruijn.kernel@gmail.com,
	kernelxing@tencent.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Sidharth Seela <sidharthseela@gmail.com>
Subject: [PATCH] selftest:net: Fix uninit pointers and return values
Date: Mon, 29 Sep 2025 17:13:57 +0530
Message-ID: <20250929114356.25261-2-sidharthseela@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix uninitialized character pointers, and functions that return
undefined values. These issues were caught by running clang using LLVM=1
option; and are as follows:
--
ovpn-cli.c:1587:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
 1587 |         if (!sock) {
      |             ^~~~~
ovpn-cli.c:1635:9: note: uninitialized use occurs here
 1635 |         return ret;
      |                ^~~
ovpn-cli.c:1587:2: note: remove the 'if' if its condition is always false
 1587 |         if (!sock) {
      |         ^~~~~~~~~~~~
 1588 |                 fprintf(stderr, "cannot allocate netlink socket\n");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1589 |                 goto err_free;
      |                 ~~~~~~~~~~~~~~
 1590 |         }
      |         ~
ovpn-cli.c:1584:15: note: initialize the variable 'ret' to silence this warning
 1584 |         int mcid, ret;
      |                      ^
      |                       = 0
ovpn-cli.c:2107:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
 2107 |         case CMD_INVALID:
      |              ^~~~~~~~~~~
ovpn-cli.c:2111:9: note: uninitialized use occurs here
 2111 |         return ret;
      |                ^~~
ovpn-cli.c:1939:12: note: initialize the variable 'ret' to silence this warning
 1939 |         int n, ret;
      |                   ^
      |
--
txtimestamp.c:240:2: warning: variable 'tsname' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
  240 |         default:
      |         ^~~~~~~
txtimestamp.c:244:20: note: uninitialized use occurs here
  244 |         __print_timestamp(tsname, &tss->ts[0], tskey, payload_len);
      |                           ^~~~~~
txtimestamp.c:220:20: note: initialize the variable 'tsname' to silence this warning
  220 |         const char *tsname;
      |                           ^
      |                            = NULL
--
so_txtime.c:210:3: warning: variable 'reason' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
  210 |                 default:
      |                 ^~~~~~~
so_txtime.c:219:27: note: uninitialized use occurs here
  219 |                         data[ret - 1], tstamp, reason);
      |                                                ^~~~~~
so_txtime.c:177:21: note: initialize the variable 'reason' to silence this warning
  177 |                 const char *reason;
      |                                   ^
      |
--

Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
---

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 9201f2905f2c..20d00378f34a 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -1581,7 +1581,7 @@ static int ovpn_listen_mcast(void)
 {
 	struct nl_sock *sock;
 	struct nl_cb *cb;
-	int mcid, ret;
+	int mcid, ret = -1;
 
 	sock = nl_socket_alloc();
 	if (!sock) {
@@ -1936,7 +1936,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 {
 	char peer_id[10], vpnip[INET6_ADDRSTRLEN], laddr[128], lport[10];
 	char raddr[128], rport[10];
-	int n, ret;
+	int n, ret = -1;
 	FILE *fp;
 
 	switch (ovpn->cmd) {
diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
index 8457b7ccbc09..b76df1efc2ef 100644
--- a/tools/testing/selftests/net/so_txtime.c
+++ b/tools/testing/selftests/net/so_txtime.c
@@ -174,7 +174,7 @@ static int do_recv_errqueue_timeout(int fdt)
 	msg.msg_controllen = sizeof(control);
 
 	while (1) {
-		const char *reason;
+		const char *reason = NULL;
 
 		ret = recvmsg(fdt, &msg, MSG_ERRQUEUE);
 		if (ret == -1 && errno == EAGAIN)
diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
index dae91eb97d69..bcc14688661d 100644
--- a/tools/testing/selftests/net/txtimestamp.c
+++ b/tools/testing/selftests/net/txtimestamp.c
@@ -217,7 +217,7 @@ static void print_timestamp_usr(void)
 static void print_timestamp(struct scm_timestamping *tss, int tstype,
 			    int tskey, int payload_len)
 {
-	const char *tsname;
+	const char *tsname = NULL;
 
 	validate_key(tskey, tstype);
 
-- 
2.47.3


