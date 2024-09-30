Return-Path: <netdev+bounces-130377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAE998A475
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB115B27DF5
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA371922DE;
	Mon, 30 Sep 2024 13:12:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B05C191F89;
	Mon, 30 Sep 2024 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701950; cv=none; b=N93DmVqNPPJ8EIbdQm1TfJXXCjlmM4AITHTx8I6D81gAxmP6PIi+rnWlIktvrpexTGfisoRY5PyhAt06YMRWMhLZ5nl6c5MpIPaI5YlqKdWb2UxfOpsY15spY/NQS8iRrB6+5pErrr05JQ5njVEfES5xn+mOLvnHxZZm6vURhQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701950; c=relaxed/simple;
	bh=SRuTFsQm1/t/gwh3wg+P5pj2mOTPr/yZIbz8OLYwnQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mea4BCabRoPvkzcQrSPqVJ+OEC7VZoJ1vaHtXx/76xAM/kD+3Mhna+A1UVaCS07FA4GU1Ghj/lU6CPA7XjoxdI0r6fWi9b+rH3TrSjoxy7mzkv3xXVLWScBocvXpduznwsLk59CDB9KApX0RJOZuax114Hv9gcuECE9GOtdVT3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso10666681fa.3;
        Mon, 30 Sep 2024 06:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701946; x=1728306746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feXGILhytIeS4QpNPlfPx+rOZRUaL2lrSGKXoIjtvVU=;
        b=A4YPqEbkp1xNaZSV6X2GvOjyaC5Qrn2HSe73zEDFB/qYfrSor+R/7vTI7NR/yRIVV7
         7wH/xkuSN7tFhHq17V+MSxjXeln9R+F65kVq/NyS3ZEZt376EUc/tVhYW0bPKa73NGWh
         f0fEqc4M1W7p/+mzpMjrEIGaDnJVf+F5+nbEe/Q1+CfnGGKgEv9cHSHTC6kN6Eeanasj
         +ti0eSPNaCLES9lzW6+uZltdMn/v8RW5Dd7fKbedm86OmGBAgJUEUiikrOTvwImafivi
         RSlXuwsKZLr7i5+TkE6B/DBiYfJi2M8tdLFdqDosB4ljdM90GqfFHHmGB/vU7jGAo7lO
         gjtw==
X-Forwarded-Encrypted: i=1; AJvYcCVcPlyr7CKj9QcE1tZpTpu/NdB7C6jv5O9Nrsj9iFDAvfvBuK1vaZSwpWEH0D4VUNSTQBP3mNl1/QweBX8=@vger.kernel.org, AJvYcCWrmFEKGj2BhbkctMTfr46ujxrQyAyFSnAwddAKyvB5NXdeyv8HsyfZ3s2RUn2QVWW9ySxrXzm7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj/ELiyg48iZ8bD9KHOZJDftMps94bNSr3GDV6WW0hAIFWPSmA
	qB0low1A10rdhrlCdvuPWJMYMhqI2t88aQI2GSnvgzMUM9VfZlpd
X-Google-Smtp-Source: AGHT+IH4v/VnlWFRX8tIxgYmqYQC9Fi+hgqJQkFV9RM6GnCmDjwMnlGdM0ik3Kjld3TYvUl12J8xGw==
X-Received: by 2002:a05:651c:54d:b0:2ef:2905:f36d with SMTP id 38308e7fff4ca-2f9d3e4966dmr84919091fa.16.1727701946064;
        Mon, 30 Sep 2024 06:12:26 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27ecf90sm530077566b.97.2024.09.30.06.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:12:25 -0700 (PDT)
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
Subject: [PATCH net-next v4 04/10] net: netconsole: rename body to msg_body
Date: Mon, 30 Sep 2024 06:12:03 -0700
Message-ID: <20240930131214.3771313-5-leitao@debian.org>
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

With the introduction of the userdata concept, the term body has become
ambiguous and less intuitive.

To improve clarity, body is renamed to msg_body, making it clear that
the body is not the only content following the header.

In an upcoming patch, the term body_len will also be revised for further
clarity.

The current packet structure is as follows:

	release, header, body, [msg_body + userdata]

Here, [msg_body + userdata] collectively forms what is currently
referred to as "body." This renaming helps to distinguish and better
understand each component of the packet.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 41 ++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 6cd0a9f25db3..da42dffa6296 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1092,8 +1092,8 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 {
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
 	int offset = 0, userdata_len = 0;
-	const char *header, *body;
-	int header_len, body_len;
+	const char *header, *msgbody;
+	int header_len, msgbody_len;
 	const char *release;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
@@ -1101,15 +1101,15 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 		userdata_len = nt->userdata_length;
 #endif
 
-	/* need to insert extra header fields, detect header and body */
+	/* need to insert extra header fields, detect header and msgbody */
 	header = msg;
-	body = memchr(msg, ';', msg_len);
-	if (WARN_ON_ONCE(!body))
+	msgbody = memchr(msg, ';', msg_len);
+	if (WARN_ON_ONCE(!msgbody))
 		return;
 
-	header_len = body - header;
-	body_len = msg_len - header_len - 1;
-	body++;
+	header_len = msgbody - header;
+	msgbody_len = msg_len - header_len - 1;
+	msgbody++;
 
 	/*
 	 * Transfer multiple chunks with the following extra header.
@@ -1124,10 +1124,10 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	memcpy(buf + release_len, header, header_len);
 	header_len += release_len;
 
-	/* for now on, the header will be persisted, and the body
+	/* for now on, the header will be persisted, and the msgbody
 	 * will be replaced
 	 */
-	while (offset < body_len + userdata_len) {
+	while (offset < msgbody_len + userdata_len) {
 		int this_header = header_len;
 		int this_offset = 0;
 		int this_chunk = 0;
@@ -1135,23 +1135,24 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 		this_header += scnprintf(buf + this_header,
 					 sizeof(buf) - this_header,
 					 ",ncfrag=%d/%d;", offset,
-					 body_len + userdata_len);
+					 msgbody_len + userdata_len);
 
-		/* Not all body data has been written yet */
-		if (offset < body_len) {
-			this_chunk = min(body_len - offset,
+		/* Not all msgbody data has been written yet */
+		if (offset < msgbody_len) {
+			this_chunk = min(msgbody_len - offset,
 					 MAX_PRINT_CHUNK - this_header);
 			if (WARN_ON_ONCE(this_chunk <= 0))
 				return;
-			memcpy(buf + this_header, body + offset, this_chunk);
+			memcpy(buf + this_header, msgbody + offset, this_chunk);
 			this_offset += this_chunk;
 		}
-		/* Body is fully written and there is pending userdata to write,
-		 * append userdata in this chunk
+
+		/* Msg body is fully written and there is pending userdata to
+		 * write, append userdata in this chunk
 		 */
-		if (offset + this_offset >= body_len &&
-		    offset + this_offset < userdata_len + body_len) {
-			int sent_userdata = (offset + this_offset) - body_len;
+		if (offset + this_offset >= msgbody_len &&
+		    offset + this_offset < userdata_len + msgbody_len) {
+			int sent_userdata = (offset + this_offset) - msgbody_len;
 			int preceding_bytes = this_chunk + this_header;
 
 			if (WARN_ON_ONCE(sent_userdata < 0))
-- 
2.43.5


