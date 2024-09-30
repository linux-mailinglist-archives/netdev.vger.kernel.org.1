Return-Path: <netdev+bounces-130382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDEA98A481
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27061C22BAB
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183A3194138;
	Mon, 30 Sep 2024 13:12:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF80193415;
	Mon, 30 Sep 2024 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701959; cv=none; b=e9GbtfxEeczAFEX+F0Y+PmYUPbpbn2qIaFOuspl7bjCKAvSnJXYpsj2M8AXIFHFtZpRpXtqzaWb/HJjqlivvKVTPF2UbKMXwv1x07SDmaLTUiN1sudQhkUeBMAJF0g1navlUWZEKJSJjRmsQnFivJGufVwOOHaN9cR1X/AMnmqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701959; c=relaxed/simple;
	bh=jbXgxSeiaA31t+HzqYsoEUa1OWK7xqFLCYY516n42ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSbFVoLg9NoFSyscew+/2Rcx8EPZKyiawY6PCiE26QawF4Uzg0Jig0++Jws3eWWUehDTEyyPawy6uO33RJSDmMmN6WS7nkhPgu9C15QuKdXUEKFsy7lCYAasHqNFo3Tw3F1XSPsY/TEmSH8UhhuTG9kvWgQVJe2nAf38wDiy6Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so763477966b.1;
        Mon, 30 Sep 2024 06:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701956; x=1728306756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mi0FXoMOYCAp5UnsROnjsc3YYE1l36rxsWdxJwhJ5X0=;
        b=TSTwBEE4CrHmx4CMtewlAO5AGnTiAv2aAoevfztdUz8kKoJPN/QVpDSIZEVeKGUQ9c
         JcuAWKXSI46+SG4/J4V9FG+E3iNY5QSWtLzgndKTRxUG0/U31oo9Zz0s9ILFCDdB5VM8
         6AWa+N9Wv7wNE6vhsi3SFN2pkw6L2zapaLWO8CaFYwtVjFTNB0/P2hCnGgStoDTchD3Y
         Zf1jYr2fNy1EC8TyQ3/rX3apUqsNGhpKZXLlDz6yO6d5T3Wn9x9JwPeWGddCztxRXhR4
         //BYbmgeDdZ3xlIh1hbIsgqK3z+0P6pPpxMY5YyYOWWiMXgyEVPDrnjv+8ofCVNhQ9DO
         O7yA==
X-Forwarded-Encrypted: i=1; AJvYcCVZyBciB6N/XQPd7pSlfzJKMuAJKq2RhKb0iMuKqEc5CHlueWJgIojyfUhcs5iszWtlKSkFIVbpGp2+Pww=@vger.kernel.org, AJvYcCXuEF94gwNPOBGqtYOFDNSLKdvJf+9UdA3xqqPo3FU4A1hY1HZaHN2/Yn9pvu1RPDgPDCD5MAz+@vger.kernel.org
X-Gm-Message-State: AOJu0YwgeaudnEfRyA27C3zy3+yjKWAW2dXew4lGKlTbv0qx04tFbVMu
	Hn5SXwWR9WWVPmH3d0MrnRLhs1pvDPyVM5JqDei+Rg7kHk6g30f/
X-Google-Smtp-Source: AGHT+IHK3AMN4wRZONbv80xChi69/rVklmLtWbo0vCKAQ3kF8NBfgppTRucy2+7fKGlbCLN5zsxnbA==
X-Received: by 2002:a17:906:dac3:b0:a8b:c9d4:5cef with SMTP id a640c23a62f3a-a93c4946a7cmr1267429366b.29.1727701955374;
        Mon, 30 Sep 2024 06:12:35 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2978c18sm538949866b.148.2024.09.30.06.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:12:34 -0700 (PDT)
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
Subject: [PATCH net-next v4 09/10] net: netconsole: split send_msg_fragmented
Date: Mon, 30 Sep 2024 06:12:08 -0700
Message-ID: <20240930131214.3771313-10-leitao@debian.org>
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

Refactor the send_msg_fragmented() function by extracting the logic for
sending the message body into a new function called
send_fragmented_body().

Now, send_msg_fragmented() handles appending the release and header, and
then delegates the task of breaking up the body and sending the
fragments to send_fragmented_body().

This is the final flow now:

When send_ext_msg_udp() is called to send a message, it will:
  - call send_msg_no_fragmentation() if no fragmentation is needed
  or
  - call send_msg_fragmented() if fragmentation is needed
    * send_msg_fragmented() appends the header to the buffer, which is
      be persisted until the function returns
      * call send_fragmented_body() to iterate and populate the body of
	the message. It will not touch the header, and it will only
	replace the body, writing the msgbody and/or userdata.

Also add some comment to make the code easier to review.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 81 +++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7266d4232d5d..f724511cf567 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1096,46 +1096,30 @@ static void append_release(char *buf)
 	scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
 }
 
-static void send_msg_fragmented(struct netconsole_target *nt,
-				const char *msg,
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
 	const char *userdata = NULL;
+	int body_len, offset = 0;
+	int userdata_len = 0;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
 	userdata = nt->userdata_complete;
 	userdata_len = nt->userdata_length;
 #endif
 
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
+	/* body_len represents the number of bytes that will be sent. This is
+	 * bigger than MAX_PRINT_CHUNK, thus, it will be split in multiple
+	 * packets
 	 */
-	if (release_len)
-		append_release(buf);
-
-	/* Copy the header into the buffer */
-	memcpy(buf + release_len, header, header_len);
-	header_len += release_len;
-
 	body_len = msgbody_len + userdata_len;
-	/* for now on, the header will be persisted, and the msgbody
-	 * will be replaced
+
+	/* In each iteration of the while loop below, we send a packet
+	 * containing the header and a portion of the body. The body is
+	 * composed of two parts: msgbody and userdata. We keep track of how
+	 * many bytes have been sent so far using the offset variable, which
+	 * ranges from 0 to the total length of the body.
 	 */
 	while (offset < body_len) {
 		int this_header = header_len;
@@ -1144,7 +1128,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 		int this_chunk = 0;
 
 		this_header += scnprintf(buf + this_header,
-					 sizeof(buf) - this_header,
+					 MAX_PRINT_CHUNK - this_header,
 					 ",ncfrag=%d/%d;", offset,
 					 body_len);
 
@@ -1193,6 +1177,41 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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
 /**
  * send_ext_msg_udp - send extended log message to target
  * @nt: target to send message to
-- 
2.43.5


