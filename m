Return-Path: <netdev+bounces-126517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF27971A6E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A198D1F249F7
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D651BBBC7;
	Mon,  9 Sep 2024 13:08:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655161BB6A7;
	Mon,  9 Sep 2024 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887308; cv=none; b=buQyj3vJadz7RVMvDKsp+C543Z+nqBNgfU+RNIitIn4MgzCHaOD4tAdaxXgCMZjbfxkHzMLXL4soBBZMk9Yk9u+8cKLm/N8+lE+My3U6hjlquYr1ZOt1FhcdD2S+Y/R12XhF264xRcGALWzeASDiWehFhDhLbuob+L3L1SjkyMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887308; c=relaxed/simple;
	bh=bay1BmvMTEjXyTKOfu/BteSKBHIIgfFaVrxSYvytk9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdmXI7SaWTnnIYSo+90OcDNHivNIrReGVln3481RpQbroWBzK2p4s6y8ot3lPDVzxp8IEWy58zbx26yORK/EG2ND1FcAisUlDU6oOcUJC3gfZ/5l1lXxcGVLlphWNdaSf6cgSdWABm4k+VAFTr+C3rl8DNWh0B51NvGITUeIO3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d3cde1103so256764366b.2;
        Mon, 09 Sep 2024 06:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887305; x=1726492105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUULhhCelhsLy1sGMiRmrDd8EZHd+oqEaR7JydE1Frw=;
        b=LTijXX4ns2uE2cIJ81E1gh0SeD+F6572l18hpX+TrI+0fpG6a31kw3FfriJNZIiK+n
         eVIdSAhuUe7uTksUR8gYPTgNHSauwLshlXHTflT4mW3FCckzuYysyF0BDWmqC9HvUzus
         sk8eH5jb1wMbeUO7gLGtEEuUmcqr0PIqEHLV42b8uVi0cdgXci65A+ruB/NreIM1t3q2
         Lke2RZfHriV/tmvHwCyf+lvIVeEe81R+R5OlgFu1cP9ADTw0VFLd/43in/mIcvSdjLjo
         U5fs6bsHbDhlGkpCFyOdJz0elBsTKVoOHaTzVmdn2oHJjAVyt8fbFuHRHKl8PdSPpy+5
         i7JA==
X-Forwarded-Encrypted: i=1; AJvYcCWl5pyQ0NmEzRbXsxIQTot/CDUqOUR4wUkXAXQkd+0IpXtnxI2VUm9Bahr5d5QN7v3injVx5JUf@vger.kernel.org, AJvYcCXqBCOkYLx5ZzcYSTHHUOAnzM4UWgjlEbWbMTGeIIuCfzp/HPZraQc8sVTGe1kU7uQUCoiKGN5t9bD9T5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Dv58RgGS7/5xwjzaes9zQJp7q01qJNyYDn0BeDOKwOJ3e+SN
	4ItSWkG2hZZrB3DOFvi2dv1psw31Ds8krRYSuS4xgKkR0VhFcIOqym3GdQ==
X-Google-Smtp-Source: AGHT+IEARhdcDI+kAW4TUH7I4Sgu7gaxy6DsWpASYcbuNlMuF7Pk3UOg2IPJKstpgWM8PevyFQENHQ==
X-Received: by 2002:a17:907:94d0:b0:a8a:8cdb:838c with SMTP id a640c23a62f3a-a8d1c72cd08mr887815066b.53.1725887304670;
        Mon, 09 Sep 2024 06:08:24 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d40cebsm337925866b.200.2024.09.09.06.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:08:24 -0700 (PDT)
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
	max@kutsevol.com
Subject: [PATCH net-next v2 09/10] net: netconsole: split send_msg_fragmented
Date: Mon,  9 Sep 2024 06:07:50 -0700
Message-ID: <20240909130756.2722126-10-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240909130756.2722126-1-leitao@debian.org>
References: <20240909130756.2722126-1-leitao@debian.org>
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
 drivers/net/netconsole.c | 82 +++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4044a6307d44..6a778a8690c3 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1096,45 +1096,30 @@ static void append_release(char *buf)
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
+	int body_len, offset = 0;
+	const char *userdata = NULL;
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
+	/* boy_len represents the number of bytes that will be sent. This is
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
@@ -1143,7 +1128,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 		int this_chunk = 0;
 
 		this_header += scnprintf(buf + this_header,
-					 sizeof(buf) - this_header,
+					 MAX_PRINT_CHUNK - this_header,
 					 ",ncfrag=%d/%d;", offset,
 					 body_len);
 
@@ -1193,6 +1178,41 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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


