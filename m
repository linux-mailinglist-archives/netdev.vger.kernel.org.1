Return-Path: <netdev+bounces-130381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B209E98A479
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB1B1F24472
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB10319308C;
	Mon, 30 Sep 2024 13:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2002C192D78;
	Mon, 30 Sep 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701956; cv=none; b=YgylIqVmaa49Log0DoNdyHo1KqWRxvdU5t6kU6Ncq7axVtACPnFCVpEIAX6JTHhsXday2Hm1HVAFyPF5T2RmHMH7sG/ZJFPAfVUrsvL3c9zfHR6Cg/Q+Uit7YUEl/Rm01jaSy2MKUIQzE0/NilBwYRbotZR2zrK9RbepYknzF0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701956; c=relaxed/simple;
	bh=zTNAMyL/JzNpPNPijEGwC0EtChrujzdvS8Qk2cIGDy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jb9ETFtRnqfcg3iyGCnzVnwXEuq+9rv39TH1ejXDhrQ/ySW3AdJTmCWDmS+Yt/I+C003zOpKrGa/23mtYDPd8b5vjAiXkT+KO2zByyGI5hqjLN5l+VH6mTX9TfjlxnqU2tl8jvI8dp8DdW8JCu/zKSOfAwe8Dh88osHfcZE7QIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d2daa2262so502034766b.1;
        Mon, 30 Sep 2024 06:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701953; x=1728306753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dte1BRYAJLLwHh4pCmZC5hBkzqPqK7pt5D4K6M9ka5Q=;
        b=vrFiQKadhvQiqsACDK2fZvCsA36CRYG2U/Q2ztfzSRah9iSkptIUOJLQATvf51YjHd
         iPiQO7UpfGZ50KJ2Mf8QdO8OnnZiNCq75nt2zA5ZTJzdPOcD+mwsBVnDywUUbgf2Bkhh
         afFvj+6U1ODjQX8ni+txoFlqXISTy7NSkVTUJB3gy/Y2jKJR5tOfyEqiD/0g/b6WKCwB
         eaAsnic+/PqLxTgG4tdcQ8es86bNrmtJPDhvodVcBUNoeS6O2hCCR0p4oSn7MOlZ5rJ1
         jbamLnr4pCyHibPKhg1BrEENNWv6QKtQ/v0ZVHC/SDGcP+IoTwospUzrifMQVJ/jx7bN
         tgSw==
X-Forwarded-Encrypted: i=1; AJvYcCVhvOHgvYeaDQbnWbQj/6mRs7WDkg14LULznQD4J1VtkH62gHsCiYqrW0a6l87ZVYUPn6e6XwE8@vger.kernel.org, AJvYcCWfqhbsAD/vgmtRoQLbI3iaMmZGQyUm5163UfNHu9vbUnuzOQlqQ3HjgEXvAH6l9BxTQpZ2LPFb0gMB2uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPG8HsMuNRdBqAoLf9YBfR4CJ0Xijarg0DQ56ibxyIO+IEdzS
	4uRQgYdKZjzpbWYEAO/6SsFWmWHnv3JwlOeNJzG847mIQNDyI2xd
X-Google-Smtp-Source: AGHT+IEq864tMU2SjR00rmH1keO1clY+YuKZKzgBFgINNUYt69nIF1XuF2EdW6Dk7iR25RMGfgqr7Q==
X-Received: by 2002:a17:907:eac:b0:a86:7199:af37 with SMTP id a640c23a62f3a-a93c4aca8d9mr1494540166b.58.1727701953384;
        Mon, 30 Sep 2024 06:12:33 -0700 (PDT)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c299e5desm531297566b.223.2024.09.30.06.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:12:32 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	max@kutsevol.com
Subject: [PATCH net-next v4 08/10] net: netconsole: do not pass userdata up to the tail
Date: Mon, 30 Sep 2024 06:12:07 -0700
Message-ID: <20240930131214.3771313-9-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240930131214.3771313-1-leitao@debian.org>
References: <20240930131214.3771313-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not pass userdata to send_msg_fragmented, since we can get it later.

This will be more useful in the next patch, where send_msg_fragmented()
will be split even more, and userdata is only necessary in the last
function.

Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4a20bcab0b02..7266d4232d5d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1060,13 +1060,17 @@ static struct notifier_block netconsole_netdev_notifier = {
 
 static void send_msg_no_fragmentation(struct netconsole_target *nt,
 				      const char *msg,
-				      const char *userdata,
 				      int msg_len,
 				      int release_len)
 {
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
+	const char *userdata = NULL;
 	const char *release;
 
+#ifdef CONFIG_NETCONSOLE_DYNAMIC
+	userdata = nt->userdata_complete;
+#endif
+
 	if (release_len) {
 		release = init_utsname()->release;
 
@@ -1094,7 +1098,6 @@ static void append_release(char *buf)
 
 static void send_msg_fragmented(struct netconsole_target *nt,
 				const char *msg,
-				const char *userdata,
 				int msg_len,
 				int release_len)
 {
@@ -1102,10 +1105,11 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
 	int offset = 0, userdata_len = 0;
 	const char *header, *msgbody;
+	const char *userdata = NULL;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	if (userdata)
-		userdata_len = nt->userdata_length;
+	userdata = nt->userdata_complete;
+	userdata_len = nt->userdata_length;
 #endif
 
 	/* need to insert extra header fields, detect header and msgbody */
@@ -1202,12 +1206,10 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 			     int msg_len)
 {
-	char *userdata = NULL;
 	int userdata_len = 0;
 	int release_len = 0;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	userdata = nt->userdata_complete;
 	userdata_len = nt->userdata_length;
 #endif
 
@@ -1215,10 +1217,9 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 		release_len = strlen(init_utsname()->release) + 1;
 
 	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK)
-		return send_msg_no_fragmentation(nt, msg, userdata, msg_len,
-						 release_len);
+		return send_msg_no_fragmentation(nt, msg, msg_len, release_len);
 
-	return send_msg_fragmented(nt, msg, userdata, msg_len, release_len);
+	return send_msg_fragmented(nt, msg, msg_len, release_len);
 }
 
 static void write_ext_msg(struct console *con, const char *msg,
-- 
2.43.5


