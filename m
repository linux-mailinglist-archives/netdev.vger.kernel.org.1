Return-Path: <netdev+bounces-124570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BC0969FF5
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A454C1F25C1A
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D7D187550;
	Tue,  3 Sep 2024 14:08:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA217B400;
	Tue,  3 Sep 2024 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372504; cv=none; b=Tg5ZbT+HbPskyBa+ltSE9bzJIoKIPzChZQoJF8wWHpsOuXRVvmYNORF+dA34ha4IOfQeR75c8t3kRIoF2RAifVE7HjhoABkOc4GaTMwQp5I2ZCW6PPR37DN134+//wXMSxLvR3qXn/KveLbzcZJjqwo/mKyf/eeGjR54Xq/2EpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372504; c=relaxed/simple;
	bh=EwPyVn/LijRNWgfvUoFawLHlvDU/Q0kM5J0vNfBSGS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swBtFgy7G8pZCnw6dPhT6injqPJTp+3GBwgILy+XKoXPTP31vlMXxdu9ZsUzQcujVGgcgegPTpOs51sqdVNs9ctMqVYGyV4MwmklDISZM+711SNolZklSO1tkrORdNLE0Mgyp6AnmHnEajTj2h3bD+3uF+yWBlYkE05mBLUr9GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c26b5f1ea6so1103881a12.0;
        Tue, 03 Sep 2024 07:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372501; x=1725977301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyGg8aTOO3rjIDlwIW/gKtwMJEaI7ylDHBkQwlwXwLo=;
        b=pFuF61kkUu5adZnmwsA1kgIFWLoBBt2MDEeLaKZAM0A8tU9uYI+W/2/P46Ik7gTYeD
         Hbr/sVZJxzdE283i1cbMkfK9hY2Fd3h4vuvtVh6gRgxFRHuUcriho8v7pOA0v7ZJbQS3
         XL057G+qJYufbKAmqEcXD6BPJSR4fRHlHZ2Pe6O8+CCYzDhJb85WRG333uENuJv4ivyt
         Lxgqul9W3NpnsD3TSwKh7w1n+6oqZdw4278yBxkn0UNyx29YK6rT/qdmyFRjTiq5wih4
         /6uc+rhZNdRKgbhild6mIH1DIdptpSH4lPrcGH5m2C/dHyTUv9uMkzuD3u2XPErEltSv
         hFmw==
X-Forwarded-Encrypted: i=1; AJvYcCU/iN8vlzDjNy/bSufGg/uUvFJ/ytaXAxm7q3bd8gZBCVFEopkRONx8aaGUrvpXMD+3PSHC6dhJXEciQxE=@vger.kernel.org, AJvYcCUd5QVFrnYSkIFbaje9SqSqinORTvcoke1pyCb7SfW47Oje7R5r/PypXHFcjE2J6JCBWwtEDDdF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4DRsfTUAlWbZ2p5G7imdHqoixoBsipRRXUOrpyWyGffElV7Eq
	FAqEawh0+ebCy0ehqVhc4ZIrCEYoEeBi/nG8Xd+PjGcuEKCzokE/
X-Google-Smtp-Source: AGHT+IHRz0DEsKKk3Yu4k5hHRRxtDJ0PwzGZu9VmHxqzv7RkeNsrPN1NeuNPP+ZfeWpMRcyLVxMkwg==
X-Received: by 2002:a17:907:d08:b0:a86:6d39:cbfd with SMTP id a640c23a62f3a-a89fafad393mr579857366b.57.1725372500117;
        Tue, 03 Sep 2024 07:08:20 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891a3ceasm683462766b.115.2024.09.03.07.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:08:19 -0700 (PDT)
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
	thevlad@meta.com,
	max@kutsevol.com
Subject: [PATCH net-next 8/9] net: netconsole: split send_msg_fragmented
Date: Tue,  3 Sep 2024 07:07:51 -0700
Message-ID: <20240903140757.2802765-9-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240903140757.2802765-1-leitao@debian.org>
References: <20240903140757.2802765-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the send_msg_fragmented() function by extracting the logic for
sending the message body into a new function called
send_fragmented_body().

Now, send_msg_fragmented() handles appending the release and header, and
then delegates the task of sending the body to send_fragmented_body().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 85 +++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index be23def330e9..81d7d2b09988 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1066,45 +1066,21 @@ static void append_release(char *buf)
 	scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
 }
 
-static void send_msg_fragmented(struct netconsole_target *nt,
-				const char *msg,
-				const char *userdata,
-				int msg_len,
-				int release_len)
+static void send_fragmented_body(struct netconsole_target *nt, char *buf,
+				 const char *msgbody, int header_len,
+				 int msgbody_len)
 {
-	int header_len, msgbody_len, body_len;
-	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
-	int offset = 0, userdata_len = 0;
-	const char *header, *msgbody;
-
-	if (userdata)
-		userdata_len = nt->userdata_length;
-
-	/* need to insert extra header fields, detect header and msgbody */
-	header = msg;
-	msgbody = memchr(msg, ';', msg_len);
-	if (WARN_ON_ONCE(!msgbody))
-		return;
-
-	header_len = msgbody - header;
-	msgbody_len = msg_len - header_len - 1;
-	msgbody++;
-
-	/*
-	 * Transfer multiple chunks with the following extra header.
-	 * "ncfrag=<byte-offset>/<total-bytes>"
-	 */
-	if (release_len)
-		append_release(buf);
+	int body_len, offset = 0;
+	const char *userdata = NULL;
+	int userdata_len = 0;
 
-	/* Copy the header into the buffer */
-	memcpy(buf + release_len, header, header_len);
-	header_len += release_len;
+#ifdef CONFIG_NETCONSOLE_DYNAMIC
+	userdata = nt->userdata_complete;
+	userdata_len = nt->userdata_length;
+#endif
 
 	body_len = msgbody_len + userdata_len;
-	/* for now on, the header will be persisted, and the msgbody
-	 * will be replaced
-	 */
+
 	while (offset < body_len) {
 		int this_header = header_len;
 		bool msgbody_written = false;
@@ -1112,7 +1088,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 		int this_chunk = 0;
 
 		this_header += scnprintf(buf + this_header,
-					 sizeof(buf) - this_header,
+					 MAX_PRINT_CHUNK - this_header,
 					 ",ncfrag=%d/%d;", offset,
 					 body_len);
 
@@ -1161,6 +1137,41 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	}
 }
 
+static void send_msg_fragmented(struct netconsole_target *nt,
+				const char *msg,
+				int msg_len,
+				int release_len)
+{
+	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
+	int header_len, msgbody_len;
+	const char *msgbody;
+
+	/* need to insert extra header fields, detect header and msgbody */
+	msgbody = memchr(msg, ';', msg_len);
+	if (WARN_ON_ONCE(!msgbody))
+		return;
+
+	header_len = msgbody - msg;
+	msgbody_len = msg_len - header_len - 1;
+	msgbody++;
+
+	/*
+	 * Transfer multiple chunks with the following extra header.
+	 * "ncfrag=<byte-offset>/<total-bytes>"
+	 */
+	if (release_len)
+		append_release(buf);
+
+	/* Copy the header into the buffer */
+	memcpy(buf + release_len, msg, header_len);
+	header_len += release_len;
+
+	/* for now on, the header will be persisted, and the msgbody
+	 * will be replaced
+	 */
+	send_fragmented_body(nt, buf, msgbody, header_len, msgbody_len);
+}
+
 static void send_msg_no_fragmentation(struct netconsole_target *nt,
 				      const char *msg,
 				      const char *userdata,
@@ -1216,7 +1227,7 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 		return send_msg_no_fragmentation(nt, msg, userdata, msg_len,
 						 release_len);
 
-	return send_msg_fragmented(nt, msg, userdata, msg_len, release_len);
+	return send_msg_fragmented(nt, msg, msg_len, release_len);
 }
 
 static void write_ext_msg(struct console *con, const char *msg,
-- 
2.43.5


