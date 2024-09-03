Return-Path: <netdev+bounces-124566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA64969FE5
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B921C1C233FE
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED9F84E14;
	Tue,  3 Sep 2024 14:08:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB980C02;
	Tue,  3 Sep 2024 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372495; cv=none; b=JH6tMgwVlAdM29pLC5CcBT54Mcr3t3OVqii4M16Eot9L2nY11IFazzyD9p4e23b25+i/q3V/GFRMO1kK3CD1R14P6GYZaQB0SIN0WZHIkPS6VJOaiUfSeg7sZsll8nuFNJw3bU7dLPv/u3UbwZFcJvk4WXxEN8pRwg3fvwl9/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372495; c=relaxed/simple;
	bh=3ovEhmMlvcYRcWnnDEuDTXJGthcPintxc8nzp8yHidY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzIwqNp5Pr/RqrSzAU04xhWZWL0pL7ZlKLeaRrc7YJOs31ImTeJGIeTPcbqp0bs+3EVEI/lbghBYd4ZM35rxzvahTQqyvkIAZSVik2+Xpg+GRvtMZQiP1Ri1fwDFFiIxyRqbIAYM01Iqp4I8ueG1nwfdZ4u4MiOzLAdMhP3sv54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso6043650a12.0;
        Tue, 03 Sep 2024 07:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372492; x=1725977292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+1Bdy2XyVHRe091GnGCx4ZHzpI5u7L1trE9x+a694M=;
        b=BYon7jHX6bxRF7SY9BPwA+bMMPAgDceCYnY7zYhfXgvnMl6XhQtcFQb1KfEmgTKPDT
         +VIkWN2HURUpi3MnNunyWRCVzSwZbH1Z+2K5c7f63bM9AQfha0ngfPPIgipiGNPKeNm+
         /mU0ITAqqjPt6HHa45rNUikYv8K4ajOMkM6j3Re/zWLjWQ3OnPbN2aD3/oFzBGfU/GlY
         r0/Bq1J2PV+m5fxr03BFjK5re9hGTvYakvepgtjJ+ELjPlKd6aQg6AIdTwbafTVodSv5
         e50yGBlGeelBnMpvjVR66Y+c0LxeyGsrP2s1o9nMnDydN1ot3kp3NSD/B70DMlW8at3e
         0X6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9R8fm6MTh2yZEW3oBZZVKQ574t/pdB/UbLFF9yDh0655YtX+4ACKP811ZvCqDuqUbZQZqlty9@vger.kernel.org, AJvYcCX/t2WoiOC43p+pra+0HCYeSzuCeaePybt8apbMk+xnVc7RxHz9qceyq/iV01KFLMXgwejtu2SbNaVZ3r4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5MOtPAPB+XVcH6mlftPsFe4eld2MWA4GeTmIlP0Z9NKP3QBwD
	wMz1+pPaSEmek/audhwcSKQNcPPwgBAg+4DjWFSexbt1Ot1Pq69s
X-Google-Smtp-Source: AGHT+IEKzEsyiRq6MPjsVF2z+mM1EQRTWtf+z8G5UEwPWdAZQtSkqAZ79eHK0cXFhHvgYZ+zP/b6Zw==
X-Received: by 2002:a05:6402:5110:b0:5c2:467a:185d with SMTP id 4fb4d7f45d1cf-5c2467a1d6bmr10454135a12.0.1725372491688;
        Tue, 03 Sep 2024 07:08:11 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ccf406sm6570395a12.59.2024.09.03.07.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:08:10 -0700 (PDT)
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
Subject: [PATCH net-next 4/9] net: netconsole: rename body to msg_body
Date: Tue,  3 Sep 2024 07:07:47 -0700
Message-ID: <20240903140757.2802765-5-leitao@debian.org>
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
---
 drivers/net/netconsole.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 176ce6c616cb..0d924fba5814 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1066,22 +1066,22 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 {
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
 	int offset = 0, userdata_len = 0;
-	const char *header, *body;
-	int header_len, body_len;
+	const char *header, *msgbody;
+	int header_len, msgbody_len;
 	const char *release;
 
 	if (userdata)
 		userdata_len = nt->userdata_length;
 
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
@@ -1096,10 +1096,10 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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
@@ -1107,23 +1107,23 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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
+		/* Msg body is fully written and there is pending userdata to write,
 		 * append userdata in this chunk
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


