Return-Path: <netdev+bounces-130376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CCC98A46E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C0D1C20B84
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC72C191F81;
	Mon, 30 Sep 2024 13:12:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05991191F60;
	Mon, 30 Sep 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701947; cv=none; b=iNed3SRuIlHVkl56Ciddg41tQ0E+QGdJNkhaofWHMrjgGSoL3npo5ZHsuGCQrAVhIabmG9zBl5I7kATCit4MdsN9yu3FN9ketgwrxO9o5SUWhJLLNOJoDkMjRqnqLut56Q2XEkYsH2j/W7I90zZiZ/FGP4GryaBgnRJ/KkiGlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701947; c=relaxed/simple;
	bh=G06VWIjgSkb5T+Rhxs4tVbY5voMH09vj86RMygQPa1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJTz4AJqpxjfWR8MLhYjGoeNaKELrJBVjc3nmy01bv6mYuOm5JBBzc/p+3ZQuuX/c9b4TrpBxep/+oqwT9FbEUXa+dSNSAMds6PJl0jhcHnNUTKSlmMxlJz1wuA0Gaxys4509lyfX/UKnvCavEaJdXRPQ7s98ebVYAfQayUlJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so763439966b.1;
        Mon, 30 Sep 2024 06:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701944; x=1728306744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBhPBaj2saKKoTM2iemIROzb/EIYC5E3NS9/4E4lyRg=;
        b=v+gDye/iSU+aEEryzweOkujM1kxCNLvGXZ/L+N7JzioQAqJG2Pwk5Bo7TcpmFaC98X
         TBzWfmA67hzS1L7i/4EL+2Bk04FIWJ9Q7loa6ndQ5imSILdoC/54rv3Xwq6kTyeTm1w9
         zGiXRgdriF7vKKsP7SKJw+7OoQj9TL+cCbACFB8AXwdc2zLbll1PnMl5OYDjOEuK9x32
         bie6o9qgxMkXhU+wiNwvFltPaHl5phE0OsfZ7Gra7QwFKfET3wcCZoE6qHOJZkKKD27I
         ltdPrZ0w6K0wO+p37cKUBerUu7QQ3/AuwVmox847wF2Chy7tmL7QTCopOu/IbtZV6MON
         o+ew==
X-Forwarded-Encrypted: i=1; AJvYcCWqiUSY0UP+edsRi+lpH2BFTQ+uU0P8sOI0izE2jJJV0dV/Gpdxkjs7jFOYqnkPUwrZyi5sSTPufSrbGXw=@vger.kernel.org, AJvYcCXenjAz+Y9hkgJBkdcp7OWTyGWNoWzLTAjHRfFudnbZn4iIChQD9pEFJWSvUmUh33Qp2uvs1JcZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwvfBIhiVzL87PpWJ8riSQgqyi+y7jLpSCNs3RVycoqQSyIDsQ6
	R8YRSFrDKWYdqJX4/ac8gze51EKIU/BA81xNSBt4KcpwYtnFc3wD
X-Google-Smtp-Source: AGHT+IEeDeqbch11hW5mAXQhW+Ia9+/OiDSMyKiD2uUZdy95sri7bA0yletOYapk5xttQyXPFQD+JA==
X-Received: by 2002:a17:907:3d87:b0:a8d:302e:e1fe with SMTP id a640c23a62f3a-a93c4af052amr1343124266b.63.1727701944152;
        Mon, 30 Sep 2024 06:12:24 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2948034sm525826866b.125.2024.09.30.06.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:12:23 -0700 (PDT)
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
Subject: [PATCH net-next v4 03/10] net: netconsole: separate fragmented message handling in send_ext_msg
Date: Mon, 30 Sep 2024 06:12:02 -0700
Message-ID: <20240930131214.3771313-4-leitao@debian.org>
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
index d31ac47b496a..6cd0a9f25db3 100644
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
@@ -1184,6 +1172,38 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
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


