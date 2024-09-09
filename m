Return-Path: <netdev+bounces-126512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4762C971A63
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EFAFB23FB1
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA3E1BA28E;
	Mon,  9 Sep 2024 13:08:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385251BA29C;
	Mon,  9 Sep 2024 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887298; cv=none; b=eqpkOp1p9Msm0ZduXC9QfVQCxaomBISEVZn5n2zVu2PdZOkSGEfaQ2MZFbxarWSNKLzYf1+NW3S6DCS396H0LUnPKi/j7Mqs4ferlRINIyrFtFkbKvJ6pfJHSKX+L+E5v3d2hiEEjTZR4O0ebxG/AKDwO1/nfczFPhbfhv2km40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887298; c=relaxed/simple;
	bh=/F8PsJuwplf303ZjtrzQo6u5uEVDxw1PCl7xxY2uGnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZ47FLBGXc2SVixfVoMaA/NOPSLgkirLjnn8WMs9RHbfguXpbmBJDnSpBmtn9GpQ+lZVuiwKVmgAHAK7s2tD61lABAiM7zsB2SmOCtX5fW7WeV/0HUAQdAeAnTO/8ATWV32ZzonJxO6rssIMu/zINUGjJPibJFkqT5gGleb3G6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso46349166b.1;
        Mon, 09 Sep 2024 06:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887294; x=1726492094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaIbZREnxE/xiP/kuQHnVNQd4fNh6D0OvTTm6CKCav4=;
        b=SRUozXUhBFLzHRJT6TjBWe0sIbslKrbZvO9LOZPhe7eSg4XBo1hwGtx4WF2qcTc/Oi
         W3HVPsXkdfQR03rt8pi982XaBmHamWV9G+yp79Aa0TE3JLeNzBbMhV23xYW1EdZNQf1N
         iHE/oSd+Q2qBgNZO3Es8Ibi8KPvnam9mfyNwfs7Jy/z3K4P8F2P88JxUwdO/cE5e0dl9
         HWieEdthpYmtTW/u416V4foaejNzlpiOpsz1RVtmCavUtkLHUrrgO8mSDJBu5t/W9NX7
         ZYdRLG2qgTsmS+PgeujOBX2AXBm9qTeRrn8FDYJBDHW3il2vwBE4I8+u+IWQXTgcyDgH
         56Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUmvDK9T9x6012Te5rGrQIavE38vuXZftFxZLF5LTReZ+M4I0bNd3TbQXOAoSNv8R3q29ALXWIBK0IO5dE=@vger.kernel.org, AJvYcCXRkuHTps69djaTgZ9Is/0nc/PuCYGmYf6aNq/0qTxjho4Bxu7Os8fR6qXYRJxmG8p/ZW/kE0Y6@vger.kernel.org
X-Gm-Message-State: AOJu0YzPV67/slAYmAPBjXcjZq2eeubr7QvtRxtnxj123veDc6i0xK5d
	1lxeTF7YEkHEVK5Yujw4n1SA2Xx61mNQtaSY4xpRT7TseUQg3DnP8qDUpA==
X-Google-Smtp-Source: AGHT+IFMpQk7JguY+YDYJGe0z7Qu8dHnTZUNhsuk7QoWvpWysK/sbcbtfHM8rlAy+iUaAuj1Qx+18w==
X-Received: by 2002:a17:906:5807:b0:a8a:6bd8:b671 with SMTP id a640c23a62f3a-a8a6bd8b8abmr1353941366b.5.1725887293819;
        Mon, 09 Sep 2024 06:08:13 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2583c1e9sm341152666b.23.2024.09.09.06.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:08:12 -0700 (PDT)
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
Subject: [PATCH net-next v2 04/10] net: netconsole: rename body to msg_body
Date: Mon,  9 Sep 2024 06:07:45 -0700
Message-ID: <20240909130756.2722126-5-leitao@debian.org>
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
 drivers/net/netconsole.c | 48 +++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 8faea9422ea1..c312ad6d5cf8 100644
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
@@ -1133,23 +1133,31 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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
+		if (offset + this_offset >= msgbody_len)
+			/* msgbody was finally written, either in the previous
+			 * messages and/or in the current buf. Time to write
+			 * the userdata.
+			 */
+			msgbody_written = true;
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


