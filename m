Return-Path: <netdev+bounces-126932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EB3973123
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FEF9B27FED
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FB519A281;
	Tue, 10 Sep 2024 10:04:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696B199FB9;
	Tue, 10 Sep 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962681; cv=none; b=OFeSL1+6BYxYBDlbK4cMYTe9vTMMPLQppaz1JKhWSsYY8y6TKxYxnIHgYpAMiNWyaUkMgaAtTb2cEiIFfcU6Xxs5+64/nFI+vVV38jKCMIIt/diNQeqLi9HrZl2FMYO1ojywSfp4RyN8EhNHeA7ypQj2DCukh3RT9YO2Ikg4dCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962681; c=relaxed/simple;
	bh=Kpg5GVd+w/ApQwWU94/53bFRdhB4gIrFUfrPQnFGMeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUq5o7GK/YvLMYZOi5H0Jh3W0jOoIvnQ2tlcjUCRaGHYiK0yZqD8agoi0K4UZUh8Qa7tQCVeTEFDKYlN6w6L+yRdlihky0aBprCdqf5lN6r/A29Y7aTmyt1jMe0911zBiIQeXwKlZ0pMkOrHtY2Gko9joOPr2+5H4hr3jP3A+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso242565166b.1;
        Tue, 10 Sep 2024 03:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962678; x=1726567478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ci3noUyKl461YZ7Pbmhfbca+9jJFB7ogsWsXgchngQ8=;
        b=aMZar1xeH9RcgMrwrzCKGwiwJ6WvO1FbQTLPHBzlTDvDGtiLDA8GyUDOJt4/rxQz/x
         TzOifNWcYXYlQZLkzjjd6EBA7MLKCy0FKzISJpzvoGdxGB5qxyhO+GsgV+25qtQ9zp4j
         p13icrTE0yZJvAGtb0oIqmGV7aE5xjWYOpgse5jQr1/MWq3tqFzoQ1UzaxzIH7Z/MQXu
         rfndlcZUM6BRszTLW1ewqhKUTpiStDTSMF4fTUisYxPd+xJ3NONcgbnLvOGk8bjTSYHx
         XtvkwB9xOEGryH989iosTCtrxuOPwFiFxEehGK1cDnk0dJv0dG3PPPrJ+eNP/Exbnl++
         giXg==
X-Forwarded-Encrypted: i=1; AJvYcCURD8njfXUQvdQnVcMTKet6UMlveDf1m/PRpLIVhwzmJJvPme8Dz41HGW46rt0GP6cT1pZxjS18pEs3ZZw=@vger.kernel.org, AJvYcCUTS4e6Yr20AbYLPEY0wnVnaCPtRqwhBn6sD/Pq92nlJHvrs0TF5LTr10cie/L21rOqx5xT0zEn@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg/FP0o8LBToFQoZOij/MForo0BKb3x5qx2RxaAHBfN07etj99
	93UWcXKEWmf4F43UesyWQB5gZD2iicmiOo77+D/+U5RSbLeFoxrs
X-Google-Smtp-Source: AGHT+IExsud9nczaylpSf8msA1H4Gpz8br4zdIBuYIBLEurlz0d782AiigGEC/Txq4R3siuqd6+89A==
X-Received: by 2002:a17:907:1c1b:b0:a8d:4e69:4030 with SMTP id a640c23a62f3a-a8ffabc2359mr25685966b.19.1725962678353;
        Tue, 10 Sep 2024 03:04:38 -0700 (PDT)
Received: from localhost (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72eb0sm458917466b.132.2024.09.10.03.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:04:37 -0700 (PDT)
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
Subject: [PATCH net-next v3 09/10] net: netconsole: split send_msg_fragmented
Date: Tue, 10 Sep 2024 03:04:04 -0700
Message-ID: <20240910100410.2690012-10-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240910100410.2690012-1-leitao@debian.org>
References: <20240910100410.2690012-1-leitao@debian.org>
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
index 1de547b1deb7..86473dc2963f 100644
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
-	const char *header, *msgbody, *userdata;
-	int header_len, msgbody_len, body_len;
-	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
-	int offset = 0, userdata_len = 0;
+	const char *userdata = NULL;
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


