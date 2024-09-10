Return-Path: <netdev+bounces-126927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABDF973113
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC62A1F23851
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBC01946A1;
	Tue, 10 Sep 2024 10:04:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C3F194145;
	Tue, 10 Sep 2024 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962671; cv=none; b=kCEne9++9XNVFCwdKDfIc612yFIDBN3YZQjzYghK4kTXmS9woGh4eBZ3rbJQaJvp8tE7Fh5ElRh5uwgKyJvapqbrbXzyNnkAbapoPZLfoKB+BNrHRZdyEtTKGBc4x+zMwmo1q7joXOeaElbiztOqpIWovpKhSEscAgFr5l2RZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962671; c=relaxed/simple;
	bh=ZLXFzw8cggmveoMCih29nomf9TtufEacKFySgKw1xl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSQ+/LfcT0QUpiybclDdOdOzq0hDXRti2y56Bw0srBEkaldMKOo8t6tH8O85pr/459d8awKKzwrPVhXd084CAxNiUBvRdf3K0ryC4oxxx+MF3vbinXNP1DnsiU58Z3JOuy5hEAjZLrN9KF62JTM3WgQW1hkOxEJ0Yq+ML/MURQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75129b3a3so51366531fa.2;
        Tue, 10 Sep 2024 03:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962668; x=1726567468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svZ2oM7n93rJLFOl8KUffAWkoqKVUGNhykuSyHUkUd0=;
        b=nohxTiwfxbuAn4ZJrd+g4V3LuRWs/lN4Bgt2S8Tam7DSdPQ2dDSLiE1QWN/m+e20pk
         m7LWP8R0yMzGuGOzqd2PnkHLWVHh9L9z6oFJHD+sAoezQmMtE6nwb3x1DN1xmRLTHjUH
         4m+U41xnQM9NMiJ5LtE+7g/nbYoAT04wcxusEJ2G/2aDTdbGLHTU0pogGJmq2Eueg+Uz
         Da4R/cDQ0Z2+m5Jaq84OvxD1o/7Lc2ptJ8IwSrtm1k6Zpg48HgLKIqs3PfgJkIVZVQXN
         7An8v4eo99KXmVdLwgFjGlOGqTOyORhLz24fg4uHQc8peZtpNEUjhIgwQfHF5ald8QJi
         kqhA==
X-Forwarded-Encrypted: i=1; AJvYcCUPXYy/a/r6c6D9DTkxSRt5Ux0VlRcpi8bw+u1Ak5+gWnifhrUQOm/3XEySNx4IUV64aSTRTjFW@vger.kernel.org, AJvYcCV52O6U0NvMZxNylEgO2gh178nmSm1rkvdY0TkHwd8Ry/rHcVm8VJaDfJXDX4ymqn0rNjGCr3ie6qkv/6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFLMvJ+f4hy9bZEol8YTK9qlrAHzc29iXC1hXXc+MhcQfqJsG
	z7wT3TVYzHbseUF2AmfXlO4+Vup6JP9PGODNnDuWdvMIju3AZhvD
X-Google-Smtp-Source: AGHT+IHxtI77mg54kWmkuczRnstyirIGeviLa3IyAo/SEhr5INIXO6R++KJuWSo9A8M3RTdMKZFScA==
X-Received: by 2002:a05:651c:542:b0:2f6:6202:bfd5 with SMTP id 38308e7fff4ca-2f751f6a2c7mr85627431fa.34.1725962667740;
        Tue, 10 Sep 2024 03:04:27 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8cdf7sm4064280a12.92.2024.09.10.03.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:04:27 -0700 (PDT)
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
Subject: [PATCH net-next v3 04/10] net: netconsole: rename body to msg_body
Date: Tue, 10 Sep 2024 03:03:59 -0700
Message-ID: <20240910100410.2690012-5-leitao@debian.org>
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
index 8faea9422ea1..ca56c0ff57d0 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1092,22 +1092,22 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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
@@ -1122,10 +1122,10 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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
@@ -1133,23 +1133,24 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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


