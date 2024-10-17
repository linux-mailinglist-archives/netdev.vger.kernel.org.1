Return-Path: <netdev+bounces-136499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B448E9A1F00
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA0DB22D3F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA8A1DC748;
	Thu, 17 Oct 2024 09:50:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775561DA631;
	Thu, 17 Oct 2024 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158658; cv=none; b=roF4G6BoOmI6NRMHn6hkylDS57a7kd9I0Ts+Q+AlAIIPvyLYuYY1feFNPYYLTH1/OHw5MsYxqBFzlPnG3BI97ESi69Z3CehM2E2Tz4c6qhXb+hMNJF2V85u9VV/SouJG1h+nBZnvDNxbevVfGD5MIhqwq4aGSo/eoLc/tnN+GUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158658; c=relaxed/simple;
	bh=BnHwYa0SbUbnfkSuy88Y3YclLvpfhExheFHDqAN8daE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuBPhhciSVbXlL8xQ1nbvn5RU25xszCrFhL60NwukbPMIKjF4IKIfVR9Ja1GtKbIVQAWZ2jaMRg+IhtOYbiert4BuuPvpVKPgjRz5h5vT4yKGWcmf2nPIg4eE5zIhFfQEvJvlw63Cejr4b9DqXM1i1/2Nz/BqDy+Tw8UIKGfyDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99650da839so107726966b.2;
        Thu, 17 Oct 2024 02:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158655; x=1729763455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Xvntjz3o+9G+2hN8EN93OP8C9G3Azh/Hv61LlOVr0Q=;
        b=HMTzf8dDIUeAgPX15xzABIt/2RfB6S87YwLjEORhxWOX91lNndlSmjdo/69ksQpYE4
         fD9L7W2vddTT09e8OrOGZPZ3dH/ccrZh72h57pwBvaGg8mMz3JK8Ib55Gh2LnbvjAkj7
         u47QXeDIVXtf3FbO2vIDjwwKXD61Sc4Q/0HXLm6D5KwZ+liwJnjAfrLLHd57kwqpHIHk
         atPTmLTXVSeYlOXdxR/KdsKd+gfftaOp/frn+grZS65PR+iGzTV/YTXI1rUjjDvm3RXk
         IsMamnbzRsA+xFBikCL2wyZAxfmP6/qMIisTynRQkqlCaJ5G18YHOhn8zwMyxlb98WJZ
         hdow==
X-Forwarded-Encrypted: i=1; AJvYcCUJL3lKmH++pikbweF9A3pk+1+UlOtR+pKzzVKhv0Doh37a/zpVqE9ZkV5uEjOZi9EIPwM2o5XsBfXRsi8=@vger.kernel.org, AJvYcCX7hcJjiusixD1ztcylGpcUMTA99u+ncJ3BRHS78T5lvi5CfIR6aCrlsvN2xwecW6y9qYcApJuV@vger.kernel.org
X-Gm-Message-State: AOJu0YxR7vTeO4FL/Ba3SrqkfYCLzQIFhCQODNKPHmsLyAeqVQCKdADP
	vnyy2EjXfIcxiDXaQJ8hDEy9EjVJ0Yv0ukuif5IFdsH3hivsrKN7
X-Google-Smtp-Source: AGHT+IErJtJxtn3qtUhd/tpPdbIH6rcN3bPvAL2fNX3mVTpza7W+Z7FpJWRaI+hYMNBKJyJFiWD76w==
X-Received: by 2002:a17:907:9287:b0:a8a:8cdb:83a7 with SMTP id a640c23a62f3a-a99e3e96f26mr1726024266b.54.1729158654676;
        Thu, 17 Oct 2024 02:50:54 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29850aa5sm274011966b.152.2024.10.17.02.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:50:54 -0700 (PDT)
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
	vlad.wing@gmail.com,
	max@kutsevol.com,
	kernel-team@meta.com
Subject: [PATCH net-next v5 3/9] net: netconsole: separate fragmented message handling in send_ext_msg
Date: Thu, 17 Oct 2024 02:50:18 -0700
Message-ID: <20241017095028.3131508-4-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017095028.3131508-1-leitao@debian.org>
References: <20241017095028.3131508-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the previous change, where the non-fragmented case was moved
to its own function, this update introduces a new function called
send_msg_fragmented to specifically manage scenarios where message
fragmentation is required.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 76 +++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 23fe9edff26e..6e916131c061 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1084,42 +1084,23 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 	netpoll_send_udp(&nt->np, buf, msg_len);
 }
 
-/**
- * send_ext_msg_udp - send extended log message to target
- * @nt: target to send message to
- * @msg: extended log message to send
- * @msg_len: length of message
- *
- * Transfer extended log @msg to @nt.  If @msg is longer than
- * MAX_PRINT_CHUNK, it'll be split and transmitted in multiple chunks with
- * ncfrag header field added to identify them.
- */
-static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
-			     int msg_len)
+static void send_msg_fragmented(struct netconsole_target *nt,
+				const char *msg,
+				const char *userdata,
+				int msg_len,
+				int release_len)
 {
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
+	int offset = 0, userdata_len = 0;
 	const char *header, *body;
-	int offset = 0;
 	int header_len, body_len;
 	const char *release;
-	int release_len = 0;
-	int userdata_len = 0;
-	char *userdata = NULL;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	userdata = nt->userdata_complete;
-	userdata_len = nt->userdata_length;
+	if (userdata)
+		userdata_len = nt->userdata_length;
 #endif
 
-	if (nt->release) {
-		release = init_utsname()->release;
-		release_len = strlen(release) + 1;
-	}
-
-	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK)
-		return send_msg_no_fragmentation(nt, msg, userdata, msg_len,
-						 release_len);
-
 	/* need to insert extra header fields, detect header and body */
 	header = msg;
 	body = memchr(msg, ';', msg_len);
@@ -1134,11 +1115,18 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	 * Transfer multiple chunks with the following extra header.
 	 * "ncfrag=<byte-offset>/<total-bytes>"
 	 */
-	if (nt->release)
+	if (release_len) {
+		release = init_utsname()->release;
 		scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
+	}
+
+	/* Copy the header into the buffer */
 	memcpy(buf + release_len, header, header_len);
 	header_len += release_len;
 
+	/* for now on, the header will be persisted, and the body
+	 * will be replaced
+	 */
 	while (offset < body_len + userdata_len) {
 		int this_header = header_len;
 		int this_offset = 0;
@@ -1190,6 +1178,38 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	}
 }
 
+/**
+ * send_ext_msg_udp - send extended log message to target
+ * @nt: target to send message to
+ * @msg: extended log message to send
+ * @msg_len: length of message
+ *
+ * Transfer extended log @msg to @nt.  If @msg is longer than
+ * MAX_PRINT_CHUNK, it'll be split and transmitted in multiple chunks with
+ * ncfrag header field added to identify them.
+ */
+static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
+			     int msg_len)
+{
+	char *userdata = NULL;
+	int userdata_len = 0;
+	int release_len = 0;
+
+#ifdef CONFIG_NETCONSOLE_DYNAMIC
+	userdata = nt->userdata_complete;
+	userdata_len = nt->userdata_length;
+#endif
+
+	if (nt->release)
+		release_len = strlen(init_utsname()->release) + 1;
+
+	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK)
+		return send_msg_no_fragmentation(nt, msg, userdata, msg_len,
+						 release_len);
+
+	return send_msg_fragmented(nt, msg, userdata, msg_len, release_len);
+}
+
 static void write_ext_msg(struct console *con, const char *msg,
 			  unsigned int len)
 {
-- 
2.43.5


