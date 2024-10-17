Return-Path: <netdev+bounces-136505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC48C9A1F0E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5BD28A0E7
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3B21DDC32;
	Thu, 17 Oct 2024 09:51:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20091DDC17;
	Thu, 17 Oct 2024 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158670; cv=none; b=ahYiU2/e5+aCqZMWO7RU1Y3S9m2L8J2p3b8oaCHUyTaBm8AicKsT7MGCfZdfh493FbTtFIgSoNQ7HrQKspXwsz1YW7mUOq7E4E3ttTW1lcGTVmAEBmNK2MO4d3B8z9Y2n5xtDwE9/vlxu7GN7LVII1dZ9LpbYQhp2F/ctcHnpKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158670; c=relaxed/simple;
	bh=699IaAmYxIBG1woipqR1z8uM7YOd2b7Yuffv+L/zraM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJCOdGI9K+L4apyBgI+4L5FuuKIeN+S1+9kAECMRxvhU4D9RMmqAs3gXoBQP3TwxZVmmmvGVFlOvNbWAaXOVVv3/zENnjVR3IDDw9uP9oGZXshjjvcpQ0dgwYUsZCzzFuxVNnjfi5S1fcC5YbaYl7uGVY+ewBf6a62NwxaO3P9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c97c7852e8so1084217a12.1;
        Thu, 17 Oct 2024 02:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158667; x=1729763467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/6ZZ3fgX1aNbuNd43s/ViNH42DOc1z9jRYfEzzfadM=;
        b=Xf3zZqqUKinGVB7n3d0ZPBxPrm80k84RyU17h+lMnnzpDsxIJqlgtPqiGI5LaX32bP
         QIS3rydZgiHKmBA1DKGA6HF6/whje/NI1lsFHeCrMkGZOhqpr55/S/VzroOK2LK5yxYH
         sl4v49q1UiFTuuFIikXOBnsC8Z5MPOqcgHbG+jweWOyc9IOjkU1NtVgEZ/amDk+6bW0q
         gp3mrUXn73YEmegpGnfnjGImrkGB0k1RBk7lIgCPHnAEEbmytWla5nBBabWOQ4VHqXlR
         MD800NOaCtEzRaUwz+kyjstMuOctbMsMCjc+rLhUWHo4udlbbfxOubbGVRgWSYkbYlKV
         MqWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9xGPgWcHDeBR1sxQlHGQRjRDw0YUcQPNUePIeVZdw0oK23vFK/K/E4b7GCifcABSf6s9Tn6nE@vger.kernel.org, AJvYcCX6+sHbNWBvvkWAbj86+jxgd/wlYFdp1GUUR9+WePv5fjbT4otTZGjaFLYbpoG5LLAogTmRNWoGDxPgr/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWY8F95lDSU/qtoZVav2yvDS7ev36x3axCAwEh3Tudk64N7pBJ
	T92JsuHcJZ0u3mPAJWi3ploQYnuDDfx4WDX+i0+f7MRgGQwwT05d
X-Google-Smtp-Source: AGHT+IGVmZJFxUCl5y/vCznK/RrczOuJRB6CfDSZ3aazuktdwRwJeLo9ncUAyLmFtaMQ+miUOTxvAQ==
X-Received: by 2002:a17:907:3f1a:b0:a9a:19c8:740c with SMTP id a640c23a62f3a-a9a19c876a7mr1102779066b.47.1729158667133;
        Thu, 17 Oct 2024 02:51:07 -0700 (PDT)
Received: from localhost (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29844899sm277175566b.178.2024.10.17.02.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:51:06 -0700 (PDT)
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
Subject: [PATCH net-next v5 9/9] net: netconsole: split send_msg_fragmented
Date: Thu, 17 Oct 2024 02:50:24 -0700
Message-ID: <20241017095028.3131508-10-leitao@debian.org>
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
index b04d86fcea8f..4ea44a2f48f7 100644
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
 
@@ -1199,6 +1183,41 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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


