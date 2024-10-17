Return-Path: <netdev+bounces-136500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AFB9A1F02
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E7B1C21632
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E1A1DD0D4;
	Thu, 17 Oct 2024 09:51:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D981DCB06;
	Thu, 17 Oct 2024 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158660; cv=none; b=h+MsRFxcXjU6irpBsVNGymyCkQG49zdnwELNYpVv3oFM1EJNlYqC0Iwq7ofUg5ffg24GsAwDl1vX7qI6BDpj/rAOZJ911SQjBoVN4Iw1cZ9h+z4smcdCj5PrMbZsId60/bJLVCzwITjzpIMTdVBzf14oVm1fKthPuWGH++bhdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158660; c=relaxed/simple;
	bh=zugCEIgehcbeB64o9FtqUvF0JsigTEtwDT0nye+0BQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAEPkWO7bQAq5zzqvaDK02LZdNSyyqp5RifrgNR2M7Jir8MBeMho5enCKDifcMy42u4mZSyRko8ym3zhPWmzKxyyUMggUAmXG/pwk2W8AsSkM9XTBW137tueCkzOArBufK0yAs/1FwouXFXNaO2Ysd8FT+W7ujU2J4wzWpME3uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99f646ff1bso94879966b.2;
        Thu, 17 Oct 2024 02:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158657; x=1729763457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOJFb1agHKAShwLyoNXeyBzPMaJpkLOy9IhEQOkdcyA=;
        b=Tm+Tykl4C+vFChtPqcOkOhnkabUwG9jQlZJnso7sOgellDxPZ9Vq0agdGke6OyTnet
         8JypsgERbPoLyvK3kj4y9mF9vt8zJPgnxSBTIyAHdXQ+JA0zXgH54WBHXAsByS6l8MX2
         hBbKV7fP5FbU88I5eaERKR6yb+irVP+Q+K97VgOvXy3SkJUXelt9Z84NNZ8Jygv/EoPh
         q1XxnnCy4+vwLv8syu9mVcbLJcy4qe9lhNg3H4boI3KtGEhKc7K0pjMebDYyhAQUU0B7
         Ha173Wmt2aIm5k+GsQlgXGvSoIEZ187R7X9aQr3vbBDR1afhD1r1B7Q3QLBlz5/CXVmY
         UZeA==
X-Forwarded-Encrypted: i=1; AJvYcCUYa77rR/+P2oYiaA1NEoUmCP8OsakU9aFuO7FQyHjlLp95++YQy+t6KCtw6fi7lIkMD7bVtDjm@vger.kernel.org, AJvYcCWQFs53/g1cJWmga6QGlzUbXiP/2sHITeE8au6htzWZIiN2QNlQ6KjNKUQqoIwoaUeTSCOcLopxpV3Lh4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjijcDXRmXHCdT8yfxoAAf/FwgvL5FAHCJkT6AqgEMzQlWzzrA
	6OX9gOp2PC0+OG1jp9xQtUY8kZ+mo9Xw2d8EwZxwMRAcWolXKKhw
X-Google-Smtp-Source: AGHT+IFqikUWY8yuC4CPdaIlvvlImf1oB8c/wFj2eJXCHofLSN1rqZFTLGz1eVCxNngG63zrNO5DRQ==
X-Received: by 2002:a17:907:3f8a:b0:a99:f605:7f1b with SMTP id a640c23a62f3a-a99f6058003mr1656132266b.60.1729158656495;
        Thu, 17 Oct 2024 02:50:56 -0700 (PDT)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29717ca8sm276916866b.44.2024.10.17.02.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:50:56 -0700 (PDT)
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
Subject: [PATCH net-next v5 4/9] net: netconsole: rename body to msg_body
Date: Thu, 17 Oct 2024 02:50:19 -0700
Message-ID: <20241017095028.3131508-5-leitao@debian.org>
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
index 6e916131c061..3f59b841d659 100644
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


